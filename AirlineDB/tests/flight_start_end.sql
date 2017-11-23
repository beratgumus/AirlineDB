USE Airline1
GO

-- Bir uçuşun başlangıç ve bitiş havaalanı kodlarını (kaç aktarma olursa olsun) bulan sql
SELECT F.Flight_number,
(
	SELECT Start_leg.Departure_airport_code 
	FROM FLIGHT_LEG as Start_leg 
	WHERE Start_leg .Flight_no = F.Flight_number
	AND Start_leg.Leg_number = (
		SELECT MIN(Leg_number)
		FROM FLIGHT_LEG
		WHERE FLIGHT_LEG.Flight_no = Start_leg.Flight_no
	)
) as Departure_airport_code
,
(
	SELECT End_leg.Arrival_airport_code
	FROM FLIGHT_LEG as End_leg
	WHERE End_leg .Flight_no = F.Flight_number
	AND End_leg.Leg_number = (
		SELECT MAX(Leg_number)
		FROM FLIGHT_LEG
		WHERE FLIGHT_LEG.Flight_no = End_leg.Flight_no
	)
) as Arrival_airport_code
FROM FLIGHT as F
