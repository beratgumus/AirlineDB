-- yeni bilet alýndýðýnda satýn alýnabilen koltuk sayýsýný düþürelim
USE Airline1
GO
CREATE TRIGGER TRG_decrease_available_seats
        ON SEAT_RESERVATION
        AFTER INSERT
AS
BEGIN

    UPDATE  LEG_INSTANCE
    SET     Number_of_available_seats = Number_of_available_seats -
	(SELECT COUNT(*)
	FROM inserted,LEG_INSTANCE LI
	WHERE LI.Flight_no = inserted.Flight_no
		and LI.Leg_no = inserted.Leg_no
		and LI.[Date] = inserted.[Date])
	WHERE LEG_INSTANCE.Flight_no IN  
      (SELECT Flight_no FROM inserted)
	  and LEG_INSTANCE.Leg_no IN  
      (SELECT Leg_no FROM inserted)
	  and LEG_INSTANCE.[Date] IN  
      (SELECT [Date] FROM inserted)
END