-- seat reservation tablosuna yeni müşteri eklendiğinde FFC tablosundaki 
-- o muşteriye ilişkin kaydı oluşturan/güncelleyen trigger

USE Airline2
GO

DROP TRIGGER IF EXISTS [dbo].[TRG_update_ffc]
GO

CREATE TRIGGER TRG_update_ffc
	ON SEAT_RESERVATION
	AFTER INSERT
AS
BEGIN

	DECLARE @customer_id int;
	SELECT @customer_id = Customer_id FROM inserted;

	DECLARE @flight_no int;
	SELECT @flight_no = Flight_no FROM inserted;

	DECLARE @km int;
	SELECT @km = Km FROM FLIGHT_LEG WHERE Flight_no = @flight_no;

	IF EXISTS(SELECT * FROM FFC where Customer_id = @customer_id)
		UPDATE FFC
		SET Total_km = Total_km + @km
		WHERE Customer_id = @customer_id;
	ELSE
		INSERT INTO FFC(Customer_id, Total_km)
		VALUES
		(@customer_id, @km);

END