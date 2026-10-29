-- =====================================================================
-- Auditoria de Oracle (Unified Auditing) - Proyecto Control de Combustible
-- Ejecutar conectado como SYS (SYSDBA) a la base FREEPDB1.
-- Ejemplo:
--   docker exec -it oracle-combustible sqlplus sys/<clave>@//localhost/FREEPDB1 as sysdba
-- Ejecutar sentencia por sentencia (o como script con @archivo).
-- =====================================================================

-- 1. Politica que vigila las tablas sensibles (dinero y litros)
CREATE AUDIT POLICY pol_aud_transacciones
  ACTIONS INSERT ON combustible.transaccion_carga,
          UPDATE ON combustible.transaccion_carga,
          DELETE ON combustible.transaccion_carga,
          UPDATE ON combustible.subvencion_vehiculo,
          DELETE ON combustible.subvencion_vehiculo;

-- 2. Activar la politica (desde aqui Oracle empieza a registrar)
AUDIT POLICY pol_aud_transacciones;

-- 3. Politica que registra los intentos de conexion fallidos
CREATE AUDIT POLICY pol_aud_logon ACTIONS LOGON;

-- 4. Activarla solo para conexiones NO exitosas
AUDIT POLICY pol_aud_logon WHENEVER NOT SUCCESSFUL;

-- 5. Verificar que ambas politicas estan activas
SELECT policy_name FROM audit_unified_enabled_policies;

-- =====================================================================
-- PRUEBAS
-- Conectarse como el usuario del proyecto (combustible) y ejecutar
-- acciones sobre las tablas vigiladas, por ejemplo:
--   UPDATE subvencion_vehiculo SET litros_consumidos = 20 WHERE id_subvencion = 1;
--   DELETE FROM transaccion_carga WHERE id_transaccion = 1;
--   COMMIT;
-- Y una conexion con clave incorrecta para generar un LOGON fallido.
-- =====================================================================

-- =====================================================================
-- CONSULTA DE LOS REGISTROS (como SYS)
-- =====================================================================
SET LINESIZE 200
COL dbusername FORMAT A12
COL action_name FORMAT A10
COL object_name FORMAT A22

-- Acciones sobre las tablas del proyecto
SELECT event_timestamp, dbusername, action_name, object_name FROM unified_audit_trail WHERE object_schema = 'COMBUSTIBLE' ORDER BY event_timestamp DESC FETCH FIRST 10 ROWS ONLY;

-- Intentos de conexion fallidos
SELECT event_timestamp, dbusername, action_name, return_code FROM unified_audit_trail WHERE action_name = 'LOGON' AND return_code != 0 ORDER BY event_timestamp DESC FETCH FIRST 5 ROWS ONLY;

-- =====================================================================
-- PARA QUITAR LAS POLITICAS (opcional)
-- NOAUDIT POLICY pol_aud_transacciones;
-- DROP AUDIT POLICY pol_aud_transacciones;
-- NOAUDIT POLICY pol_aud_logon;
-- DROP AUDIT POLICY pol_aud_logon;
-- =====================================================================
