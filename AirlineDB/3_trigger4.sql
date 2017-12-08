-- LEG_INSTANCE'e veri eklemeden önce atanan uçağın maksimum koltuk sayısını kontrol edelim.
-- (uçakda 150 koltuk var, 160 koltuk satışa çıkmasın)

-- NOT: şu anda sadece tek INSERT destekleniyor. 
-- Toplu eklemeleri bu trigger'i oluşturmadan önce yapınız.

USE Airline1
GO
CREATE TRIGGER TRG_control_total_seats
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
	SET @instance_seats = 
	(
		SELECT inserted.Number_of_available_seats
		FROM inserted
	)

	IF( @max > @instance_seats )
		INSERT INTO LEG_INSTANCE
		SELECT * FROM inserted
	ELSE
		PRINT 'This airplane doesnt have. Available seat number can be maximum ' + @max

END