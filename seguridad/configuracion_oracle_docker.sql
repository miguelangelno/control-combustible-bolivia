-- ============================================
-- ORACLE DOCKER
-- Configuracion y verificacion de Oracle
-- ============================================

-- 1. Verificar el usuario conectado.

SHOW USER;

-- 2. Verificar el contenedor actual.

SHOW CON_NAME;

-- 3. Verificar la version de Oracle.

SELECT * FROM V$VERSION;

-- 4. Verificar el servicio y la base de datos.

SELECT
    SYS_CONTEXT('USERENV', 'DB_NAME') AS BASE_DATOS,
    SYS_CONTEXT('USERENV', 'SERVICE_NAME') AS SERVICIO,
    SYS_CONTEXT('USERENV', 'CON_NAME') AS CONTENEDOR
FROM DUAL;
