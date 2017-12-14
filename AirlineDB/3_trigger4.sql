-- LEG_INSTANCE'e veri eklemeden önce 
--		+ seçilen uçağın maksimum koltuk sayısını (uçakda 150 koltuk var, 160 koltuk satışa çıkmasın),
--		+ seçilen uçağın varış havaalanına inip inemeyeceğini
-- kontrol edelim.
-- 

-- NOT: şu anda sadece tek INSERT destekleniyor. 
-- Toplu eklemeleri bu trigger'i oluşturmadan önce yapınız.

USE Airline1
GO

SET NOCOUNT ON
GO

DROP TRIGGER IF EXISTS [dbo].[TRG_validate_insert]
GO

CREATE TRIGGER TRG_validate_insert
        ON LEG_INSTANCE
        INSTEAD OF INSERT
AS
BEGIN

	DECLARE @max int
	SET @max = 
	(
		SELECT A.Total_number_of_seats
		FROM AIRPLANE A, inserted
		WHERE A.Airplane_id = inserted.Airplane_id
	)
	
	
	DECLARE @instance_seats int
	SELECT @instance_seats = Number_of_available_seats FROM inserted

	DECLARE @Airplane_id CHAR(6)
	SELECT @Airplane_id = Airplane_id FROM inserted

	DECLARE @Arr_airport CHAR(3)
	SET @Arr_airport =
	(
		-- Arrival airportu Flight_leg'den alıyoruz çünkü leg_instance eklerken
		-- henüz uçuş gerçekleşmemiş olacağı için Arrival_airport_code null olacaktır.
		SELECT F.Arrival_airport_code
		FROM FLIGHT_LEG F, inserted
		WHERE F.Flight_no = inserted.Flight_no
		AND F.Leg_number = inserted.Leg_no
	)
	
	IF( @max < @instance_seats )
		PRINT 'Available seat number can be maximum ' + CAST(@max as NVARCHAR) 
			+ ' for airplane ' + @Airplane_id + '.'
	ELSE IF ( 
		NOT EXISTS( 
			-- eklenen uçak ve arrival airport ikilisi Can_land'de var mı diye bakalım
			SELECT * 
			FROM AIRPLANE as A, CAN_LAND as CL 
			WHERE A.Airplane_id = @Airplane_id
			AND A.Airplane_type = CL.Airplane_type_name
			AND CL.Airport_code = @Arr_airport
		) 
	) 
		PRINT 'Airplane ' + @Airplane_id + ' can not land arrival airport ' + @Arr_airport + '.'
	ELSE
		INSERT INTO LEG_INSTANCE
		SELECT * FROM inserted
	
END