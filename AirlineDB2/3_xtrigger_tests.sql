-- trigger'ların doğru çalışıp çalışmadığını test etmek için yazılmış olan query'ler

USE Airline2
GO

--==♦ FLIGHT tablosundaki TRG_control_company hata testi ♦==--
INSERT INTO FLIGHT (Flight_number, Company_id, Weekdays) 
VALUES 
(998, 1, '1,2,3,4,5,6,7'); -- company = Türk Hava Yolları, hata olmamalı

DELETE FROM FLIGHT
WHERE Flight_number = 998;

INSERT INTO FLIGHT (Flight_number, Company_id, Weekdays) 
VALUES 
(999, 7, '1,2,3,4,5,6,7'); -- company = Airbus S.A.S, triggerdan hata gelmeli
