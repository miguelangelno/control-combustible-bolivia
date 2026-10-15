# Control de combustible subvencionado en Bolivia

Modelo de base de datos (modelo relacional, diagrama entidad-relación) para controlar quién recibe combustible subvencionado, cuánto y dónde, y detectar fraudes.

## Cómo funciona

- La persona se identifica con su **huella digital**.
- El vehículo se identifica con un **tag RFID**; sus datos (modelo, tanque, propietario) vienen del **RUAT**.
- **YPFB** abastece las gasolineras y la **ANH** controla.
- Cada vehículo subvencionado tiene su propio saldo de litros. Al agotarse, la carga pasa a **precio internacional**.

## Reglas de negocio

- Máximo **2 vehículos subvencionados** por persona.
- El subsidio se aplica solo si quien pone la huella es el **titular**, el vehículo está subvencionado a su nombre y le queda saldo. Si falta una, se cobra precio internacional.
- Una carga puede partirse entre litros subvencionados e internacionales.
- Las cargas en **bidones** también se registran.
- Las reglas son **dinámicas**: viven en la tabla `regla_negocio`, con fechas de vigencia.
- Antifraude: mismo auto en dos ciudades lejanas en poco tiempo, cargas muy frecuentes y litros mayores a la capacidad del tanque.

## Las 14 tablas

| Grupo | Tablas |
|---|---|
| Personas | `persona`, `huella_digital` |
| Vehículos | `modelo_vehiculo`, `vehiculo` |
| Reglas y precios | `regla_negocio`, `precio_combustible` |
| Subsidio | `subvencion_vehiculo` |
| Gasolineras | `sucursal`, `surtidor` |
| YPFB y ANH | `despacho_ypfb`, `inspeccion_anh` |
| Cargas | `transaccion_carga`, `carga_bidon` |
| Control | `alerta_fraude` |

`transaccion_carga` es el centro del modelo: casi todas las demás tablas se conectan con ella. Todas las relaciones son de uno a muchos.

## Cómo ver el diagrama

1. Abre [dbdiagram.io/d](https://dbdiagram.io/d).
2. Borra el ejemplo que trae.
3. Pega el contenido de `modelo_combustible_bolivia.dbml`.

## Archivos

- `modelo_combustible_bolivia.dbml`: el modelo completo en DBML.
- `docs/tablas_modelo_combustible.pdf`: qué hace cada tabla y con cuáles se relaciona.

## Pendientes

- Definir la unidad del "10" de subvención (litros, o m³ para el gas).
- Definir de cuál vehículo se descuenta el saldo en una carga en bidón.
- Las reglas (máximo de 2 vehículos, saldo, antifraude) las aplica el sistema; la base solo guarda los datos.
