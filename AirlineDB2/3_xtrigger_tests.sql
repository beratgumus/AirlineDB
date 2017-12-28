-- trigger'ların doğru çalışıp çalışmadığını test etmek için yazılmış olan query'ler

USE Airline2
GO

BEGIN TRANSACTION

--==♦ TRG_control_company (3_trigger1.sql) hata testi ♦==--
INSERT INTO FLIGHT (Flight_number, Company_id, Weekdays) 
VALUES 
(998, 1, '1,2,3,4,5,6,7'); -- company = Türk Hava Yolları, hata olmamalı

INSERT INTO FLIGHT (Flight_number, Company_id, Weekdays) 
VALUES 
(999, 7, '1,2,3,4,5,6,7'); -- company = Airbus S.A.S, triggerdan hata gelmeli



--==♦ TRG_update_ffc (3_trigger2.sql) testi ♦==--
DECLARE @test_customer int = 30;
DECLARE @total_km int;
SELECT @total_km = Total_km FROM FFC WHERE Customer_id = @test_customer;
PRINT 'Customer '+ CAST(@test_customer as VARCHAR) + 
	' Total_km = ' + CAST(@Total_km as VARCHAR);

INSERT INTO SEAT_RESERVATION (Flight_no, Leg_no, Date, Seat_number, Customer_id)
VALUES
(1, 1, '2017-11-13', 999, @test_customer); -- uçuş uzunluğu 350 km

SELECT @total_km = Total_km FROM FFC WHERE Customer_id = @test_customer;
PRINT 'Customer '+ CAST(@test_customer as VARCHAR) + 
	' Total_km = ' + CAST(@Total_km as VARCHAR);

ROLLBACK TRANSACTION -- yapılan değişiklikleri geri al