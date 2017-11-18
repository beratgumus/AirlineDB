-- yeni bilet alýndýðýnda satýn alýnabilen koltuk sayýsýný düþürelim
CREATE TRIGGER TRG_decrease_available_seats
        ON SEAT_RESERVATION
        AFTER INSERT
AS
BEGIN

    UPDATE  LEG_INSTANCE
    SET     Number_of_available_seats = Number_of_available_seats - 1
    WHERE   Flight_no = (SELECT Flight_no FROM inserted)
	AND		Leg_no = (SELECT Leg_no FROM inserted)
	AND		[Date] = (SELECT [Date] FROM inserted) 

END