-- ============================================
-- PRUEBAS DE AUDITORIA Y VISTAS
-- EJECUTAR COMO PROYECTO_SEG
-- ============================================

-- 1. Verificar las personas.

SELECT * FROM persona;


-- 2. Verificar la tabla de auditoria.

SELECT * FROM auditoria_persona
ORDER BY id_auditoria DESC;


-- 3. Verificar las vistas.

SELECT * FROM vista_personas_publicas;

SELECT * FROM vista_personas_activas;


-- 4. Verificar que el trigger este habilitado.

SELECT trigger_name, status
FROM user_triggers
WHERE trigger_name = 'TRG_AUDITORIA_PERSONA';



-- ============================================
-- PRUEBAS DE PERMISOS
-- EJECUTAR COMO CONSULTA_SEG
-- ============================================

-- Esta consulta debe funcionar.

SELECT * FROM PROYECTO_SEG.VISTA_PERSONAS_PUBLICAS;

-- Esta consulta tambien debe funcionar.

SELECT * FROM PROYECTO_SEG.VISTA_PERSONAS_ACTIVAS;

-- Esta consulta debe fallar por falta de permisos.

SELECT * FROM PROYECTO_SEG.PERSONA;
