-- Script para insertar pa�ses, cantones, distritos y direcciones (todas en Costa Rica)

-- 1. Insertar pa�s Costa Rica
EXEC FIDE_REGISTRAR_PAIS_SP('Costa Rica');

-- Verificar el ID de pa�s insertado
-- SELECT * FROM FIDE_PAISES_TB;
-- Asumo que el ID es 1

SELECT * FROM FIDE_PAISES_TB;
SELECT * FROM FIDE_CANTONES_TB;
SELECT * FROM FIDE_DISTRITOS_TB;

-- 2. Insertar cantones de Costa Rica (ID_PAIS = 1)
EXEC FIDE_REGISTRAR_CANTON_SP('San Jos�', 1);
EXEC FIDE_REGISTRAR_CANTON_SP('Alajuela', 1);
EXEC FIDE_REGISTRAR_CANTON_SP('Cartago', 1);
EXEC FIDE_REGISTRAR_CANTON_SP('Heredia', 1);
EXEC FIDE_REGISTRAR_CANTON_SP('Guanacaste', 1);
EXEC FIDE_REGISTRAR_CANTON_SP('Puntarenas', 1);
EXEC FIDE_REGISTRAR_CANTON_SP('Lim�n', 1);

-- Verificar los IDs de cantones insertados
-- SELECT * FROM FIDE_CANTONES_TB;
-- Asumo que los IDs son del 1 al 7 respectivamente

-- 3. Insertar distritos
-- Distritos de San Jos� (ID_CANTON = 1)
EXEC FIDE_REGISTRAR_DISTRITO_SP('Escaz�', 100);
EXEC FIDE_REGISTRAR_DISTRITO_SP('Santa Ana', 100);
EXEC FIDE_REGISTRAR_DISTRITO_SP('Desamparados', 100);

-- Distritos de Alajuela (ID_CANTON = 2)
EXEC FIDE_REGISTRAR_DISTRITO_SP('Grecia', 101);
EXEC FIDE_REGISTRAR_DISTRITO_SP('San Ram�n', 101);
EXEC FIDE_REGISTRAR_DISTRITO_SP('Atenas', 101);

-- Distritos de Cartago (ID_CANTON = 3)
EXEC FIDE_REGISTRAR_DISTRITO_SP('Tres R�os', 102);
EXEC FIDE_REGISTRAR_DISTRITO_SP('Turrialba', 102);
EXEC FIDE_REGISTRAR_DISTRITO_SP('El Guarco', 102);

-- Distritos de Heredia (ID_CANTON = 4)
EXEC FIDE_REGISTRAR_DISTRITO_SP('Santo Domingo', 103);
EXEC FIDE_REGISTRAR_DISTRITO_SP('San Rafael', 103);
EXEC FIDE_REGISTRAR_DISTRITO_SP('Bel�n', 103);

-- Distritos de Guanacaste (ID_CANTON = 5)
EXEC FIDE_REGISTRAR_DISTRITO_SP('Liberia', 104);
EXEC FIDE_REGISTRAR_DISTRITO_SP('Nicoya', 104);

-- Distritos de Puntarenas (ID_CANTON = 6)
EXEC FIDE_REGISTRAR_DISTRITO_SP('Esparza', 105);
EXEC FIDE_REGISTRAR_DISTRITO_SP('Quepos', 105);

-- Distritos de Lim�n (ID_CANTON = 7)
EXEC FIDE_REGISTRAR_DISTRITO_SP('Siquirres', 106);
EXEC FIDE_REGISTRAR_DISTRITO_SP('Gu�piles', 106);

-- Verificar los IDs de distritos insertados
-- SELECT * FROM FIDE_DISTRITOS_TB;
-- Asumo que los IDs son del 1 al 17 respectivamente

-- 4. Insertar 10 direcciones (todas en Costa Rica)
-- Direcci�n 1: Costa Rica, San Jos�, Escaz�
EXEC FIDE_REGISTRAR_DIRECCION_SP(1, 100, 10000);

-- Direcci�n 2: Costa Rica, San Jos�, Santa Ana
EXEC FIDE_REGISTRAR_DIRECCION_SP(1, 100, 10001);

-- Direcci�n 3: Costa Rica, San Jos�, Desamparados
EXEC FIDE_REGISTRAR_DIRECCION_SP(1, 100, 10002);

-- Direcci�n 4: Costa Rica, Alajuela, Grecia
EXEC FIDE_REGISTRAR_DIRECCION_SP(1, 101, 10003);

-- Direcci�n 5: Costa Rica, Alajuela, San Ram�n
EXEC FIDE_REGISTRAR_DIRECCION_SP(1, 101, 10004);

-- Direcci�n 6: Costa Rica, Cartago, Tres R�os
EXEC FIDE_REGISTRAR_DIRECCION_SP(1, 102, 10006);

-- Direcci�n 7: Costa Rica, Heredia, Santo Domingo
EXEC FIDE_REGISTRAR_DIRECCION_SP(1, 103, 10009);

-- Direcci�n 8: Costa Rica, Guanacaste, Liberia
EXEC FIDE_REGISTRAR_DIRECCION_SP(1, 104, 10012);

-- Direcci�n 9: Costa Rica, Puntarenas, Esparza
EXEC FIDE_REGISTRAR_DIRECCION_SP(1, 105, 10014);

-- Direcci�n 10: Costa Rica, Lim�n, Siquirres
EXEC FIDE_REGISTRAR_DIRECCION_SP(1, 106, 10016);

-- Verificar las direcciones insertadas
 SELECT * FROM FIDE_DIRECCION_TB;