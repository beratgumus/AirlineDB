-- yeni bilet alındığında satın alınabilen koltuk sayısını düşürelim
USE Airline1
GO

DROP TRIGGER IF EXISTS [dbo].[TRG_decrease_available_seats]
GO

CREATE TRIGGER TRG_decrease_available_seats
        ON SEAT_RESERVATION
        AFTER INSERT
AS
BEGIN

    UPDATE  LEG_INSTANCE
    SET     Number_of_available_seats = Number_of_available_seats -
	(
		SELECT COUNT(*)
		FROM inserted
		WHERE LEG_INSTANCE.Flight_no = inserted.Flight_no
		AND LEG_INSTANCE.Leg_no = inserted.Leg_no
		AND LEG_INSTANCE.[Date] = inserted.[Date]
	)
	WHERE LEG_INSTANCE.Flight_no IN  
      (SELECT Flight_no FROM inserted)
	AND LEG_INSTANCE.Leg_no IN  
      (SELECT Leg_no FROM inserted)
	AND LEG_INSTANCE.[Date] IN  
      (SELECT [Date] FROM inserted)
END