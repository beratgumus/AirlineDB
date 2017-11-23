-- Aktarmali ucuslarin, ilk aktarmasinin kalkis tarihi ve saati ile son aktarmasinin inis tarihi ve saatinin musterilere gostermek amaciyla view olusturma amaciyla yazilan sql
-- Sorgu 3 aktarmali ucus testinde cakildi, yazarken de hissetmistim...
-- Generic yapilmali !!!
SELECT	FL1.Flight_no,LI1.Date as Departure_Date,FL1.Scheduled_departure_time,(CAST(LI2.Arrival_time as DATE)) AS Arrival_date,FL2.Scheduled_arrival_time
FROM	(FLIGHT_LEG AS FL1 
INNER JOIN FLIGHT_LEG AS FL2 
ON FL1.Flight_no= FL2.Flight_no 
AND FL1.Arrival_airport_code = FL2.Departure_airport_code)
INNER JOIN 
(LEG_INSTANCE AS LI1
INNER JOIN LEG_INSTANCE AS LI2
ON LI1.Flight_no=LI2.Flight_no
AND LI1.Arrival_airport_code = LI2.Departure_airport_code)
ON FL1.Flight_no = LI1.Flight_no
WHERE    FL1.Flight_no= FL2.Flight_no
		AND FL1.Flight_no IN(
							SELECT	Flight_no
							FROM	FLIGHT_LEG
							GROUP BY Flight_no
							HAVING COUNT(*) > 1)