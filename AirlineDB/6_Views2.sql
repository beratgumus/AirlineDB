--Tamamlanmis uçuslarin bos koltuk sayisi %50den fazla olanlari bulan view
use Airline1
GO

CREATE VIEW VW_LegInstance_with_emptySeatsMoreThan_50percent
AS
SELECT Flight_no, Leg_no, [Date], Number_of_available_seats, Total_number_of_seats, CAST(Number_of_available_seats * 100 as float) / CAST(Total_number_of_seats as float) as Rate
FROM LEG_INSTANCE as LI, AIRPLANE as A
WHERE LI.Arrival_time IS NOT NULL
AND LI.Airplane_id = A.Airplane_id
AND (CAST(Number_of_available_seats * 100 as float) / CAST(Total_number_of_seats as float) ) > 50;