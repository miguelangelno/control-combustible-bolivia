# Control de combustible subvencionado en Bolivia

**Grupo 4:** Novillo Becerras Miguel Angel · Felipe Ochoa Esthefani · Vallejos Medrano Thalia
**Materia:** Taller de Base de Datos II (TBD2-2026)

Modelo de base de datos relacional (14 tablas) para controlar quién recibe combustible subvencionado, cuánto y dónde, y detectar fraudes.

## Estructura del repositorio

| Carpeta / archivo | Contenido | Tarea |
|---|---|---|
| [`Informes/`](Informes) | `LG4_Investigacion.pdf`: investigación comparativa de cómo otros países distribuyen y controlan el combustible | LG4 |
| [`Diagramas/`](Diagramas) | `LG5_E-R.pdf`, `.png` y `.jpeg`: modelo entidad-relación de las 14 tablas | LG5 |
| [`Sql/`](Sql) | `modelo_combustible.sql`: creación de tablas y relaciones (PostgreSQL) | LG5 |
| [`Scripts/`](Scripts) | Scripts de apoyo (todavía sin scripts) | |
| `modelo_combustible_bolivia.dbml` | Código del modelo para verlo en [dbdiagram.io](https://dbdiagram.io/d) | LG5 |
| [`docs/`](docs) | Material de apoyo: explicación de las 14 tablas y la hoja manuscrita del primer diagrama | |

## Cómo funciona

- La persona se identifica con su **huella digital**.
- El vehículo se identifica con un **tag RFID**; sus datos (modelo, tanque, propietario) vienen del **RUAT**.
- **YPFB** abastece las gasolineras y la **ANH** controla.
- Cada vehículo subvencionado tiene su propio saldo de litros. Al agotarse, la carga pasa a **precio internacional**.
- Máximo 2 vehículos subvencionados por persona. Las reglas se guardan en una tabla y se pueden cambiar.
- Antifraude por ubicación, frecuencia de cargas y capacidad del tanque.

## Las 14 tablas

`persona`, `huella_digital`, `modelo_vehiculo`, `vehiculo`, `regla_negocio`, `precio_combustible`, `subvencion_vehiculo`, `sucursal`, `surtidor`, `despacho_ypfb`, `inspeccion_anh`, `transaccion_carga`, `carga_bidon`, `alerta_fraude`.

## Pendiente
- Definir la unidad del valor "10" de la subvención (litros, o m³ para el gas).
- Scripts de datos de prueba y consultas.
