-- Script para insertar países, cantones, distritos y direcciones (todas en Costa Rica)

-- 1. Insertar país Costa Rica
EXEC FIDE_REGISTRAR_PAIS_SP('Costa Rica');

-- Verificar el ID de país insertado
-- SELECT * FROM FIDE_PAISES_TB;
-- Asumo que el ID es 1

SELECT * FROM FIDE_PAISES_TB;
SELECT * FROM FIDE_CANTONES_TB;
SELECT * FROM FIDE_DISTRITOS_TB;

-- 2. Insertar cantones de Costa Rica (ID_PAIS = 1)
EXEC FIDE_REGISTRAR_CANTON_SP('San José', 1);
EXEC FIDE_REGISTRAR_CANTON_SP('Alajuela', 1);
EXEC FIDE_REGISTRAR_CANTON_SP('Cartago', 1);
EXEC FIDE_REGISTRAR_CANTON_SP('Heredia', 1);
EXEC FIDE_REGISTRAR_CANTON_SP('Guanacaste', 1);
EXEC FIDE_REGISTRAR_CANTON_SP('Puntarenas', 1);
EXEC FIDE_REGISTRAR_CANTON_SP('Limón', 1);

-- Verificar los IDs de cantones insertados
-- SELECT * FROM FIDE_CANTONES_TB;
-- Asumo que los IDs son del 1 al 7 respectivamente

-- 3. Insertar distritos
-- Distritos de San José (ID_CANTON = 1)
EXEC FIDE_REGISTRAR_DISTRITO_SP('Escazú', 100);
EXEC FIDE_REGISTRAR_DISTRITO_SP('Santa Ana', 100);
EXEC FIDE_REGISTRAR_DISTRITO_SP('Desamparados', 100);

-- Distritos de Alajuela (ID_CANTON = 2)
EXEC FIDE_REGISTRAR_DISTRITO_SP('Grecia', 101);
EXEC FIDE_REGISTRAR_DISTRITO_SP('San Ramón', 101);
EXEC FIDE_REGISTRAR_DISTRITO_SP('Atenas', 101);

-- Distritos de Cartago (ID_CANTON = 3)
EXEC FIDE_REGISTRAR_DISTRITO_SP('Tres Ríos', 102);
EXEC FIDE_REGISTRAR_DISTRITO_SP('Turrialba', 102);
EXEC FIDE_REGISTRAR_DISTRITO_SP('El Guarco', 102);

-- Distritos de Heredia (ID_CANTON = 4)
EXEC FIDE_REGISTRAR_DISTRITO_SP('Santo Domingo', 103);
EXEC FIDE_REGISTRAR_DISTRITO_SP('San Rafael', 103);
EXEC FIDE_REGISTRAR_DISTRITO_SP('Belén', 103);

-- Distritos de Guanacaste (ID_CANTON = 5)
EXEC FIDE_REGISTRAR_DISTRITO_SP('Liberia', 104);
EXEC FIDE_REGISTRAR_DISTRITO_SP('Nicoya', 104);

-- Distritos de Puntarenas (ID_CANTON = 6)
EXEC FIDE_REGISTRAR_DISTRITO_SP('Esparza', 105);
EXEC FIDE_REGISTRAR_DISTRITO_SP('Quepos', 105);

-- Distritos de Limón (ID_CANTON = 7)
EXEC FIDE_REGISTRAR_DISTRITO_SP('Siquirres', 106);
EXEC FIDE_REGISTRAR_DISTRITO_SP('Guápiles', 106);

-- Verificar los IDs de distritos insertados
-- SELECT * FROM FIDE_DISTRITOS_TB;
-- Asumo que los IDs son del 1 al 17 respectivamente

-- 4. Insertar 10 direcciones (todas en Costa Rica)
-- Dirección 1: Costa Rica, San José, Escazú
EXEC FIDE_REGISTRAR_DIRECCION_SP(1, 100, 10018);

-- Dirección 2: Costa Rica, San José, Santa Ana
EXEC FIDE_REGISTRAR_DIRECCION_SP(1, 100, 10019);

-- Dirección 3: Costa Rica, San José, Desamparados
EXEC FIDE_REGISTRAR_DIRECCION_SP(1, 100, 10020);

-- Dirección 4: Costa Rica, Alajuela, Grecia
EXEC FIDE_REGISTRAR_DIRECCION_SP(1, 101, 10021);

-- Dirección 5: Costa Rica, Alajuela, San Ramón
EXEC FIDE_REGISTRAR_DIRECCION_SP(1, 101, 10022);

-- Dirección 6: Costa Rica, Cartago, Tres Ríos
EXEC FIDE_REGISTRAR_DIRECCION_SP(1, 102, 10024);

-- Dirección 7: Costa Rica, Heredia, Santo Domingo
EXEC FIDE_REGISTRAR_DIRECCION_SP(1, 103, 10027);

-- Dirección 8: Costa Rica, Guanacaste, Liberia
EXEC FIDE_REGISTRAR_DIRECCION_SP(1, 104, 10030);

-- Dirección 9: Costa Rica, Puntarenas, Esparza
EXEC FIDE_REGISTRAR_DIRECCION_SP(1, 105, 10032);

-- Dirección 10: Costa Rica, Limón, Siquirres
EXEC FIDE_REGISTRAR_DIRECCION_SP(1, 106, 10034);

-- Verificar las direcciones insertadas
 SELECT * FROM FIDE_DIRECCION_TB;