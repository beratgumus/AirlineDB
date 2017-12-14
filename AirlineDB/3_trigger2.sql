-- yeni bilet alınmadan önce boş koltuk var mı kontrol edelim

-- NOT: şu anda sadece tek INSERT destekleniyor (Aynı anda 2 bilet alınmayacağından makul gibi). 
-- Toplu eklemeleri bu trigger'i oluşturmadan önce yapınız.
USE Airline1
GO

DROP TRIGGER IF EXISTS [dbo].[TRG_control_availability]
GO

CREATE TRIGGER TRG_control_availability
        ON SEAT_RESERVATION
        INSTEAD OF INSERT
AS
BEGIN
	
	DECLARE @available int
	SET @available = 
	(
		SELECT Number_of_available_seats 
		FROM LEG_INSTANCE AS LI, inserted
		WHERE LI.Flight_no = inserted.Flight_no
		AND LI.Leg_no = inserted.Leg_no
		AND LI.[Date] = inserted.[Date]
	)

	IF( @available > 0 )
		INSERT INTO SEAT_RESERVATION
		SELECT * FROM inserted
	ELSE
		PRINT 'There is no available seats for that leg instance'

END