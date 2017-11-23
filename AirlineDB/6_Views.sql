--Aktarmali ucuslarin, ilk aktarmasinin kalkis tarihi ve saati ile son aktarmasinin inis tarihi ve saatinin musterilere gostermek amaciyla view olusturma icin yazilan sql
-- Artik aktarma sayisi ne olursa olsun calisiyor...

USE Airline1
GO
CREATE VIEW VW_firstDeparture_lastArrival_of_connectingFlights
AS

SELECT	first_leg.Flight_no,first_leg.Departure_date,first_leg.Scheduled_departure_time,last_leg.Arrival_date,last_leg.Scheduled_arrival_time 
FROM
(
	SELECT Start_leg.Flight_no, Start_leg.Date as Departure_date,FLIGHT_LEG.Scheduled_departure_time
	FROM LEG_INSTANCE as Start_leg,FLIGHT_LEG
	WHERE Start_leg.Flight_no = FLIGHT_LEG.Flight_no
	AND Start_leg.Leg_no = FLIGHT_LEG.Leg_number
	AND Start_leg.Flight_no IN(
							SELECT	Flight_no
							FROM	FLIGHT_LEG
							GROUP BY Flight_no
							HAVING COUNT(*) > 1)
	
							AND	 Start_leg.Leg_no = (
							SELECT MIN(Leg_number)
							FROM FLIGHT_LEG
							WHERE FLIGHT_LEG.Flight_no = Start_leg.Flight_no
							)
) as first_leg
,
(
	SELECT End_leg.Flight_no,(CAST(End_leg.Arrival_time as DATE)) as Arrival_date,FLIGHT_LEG.Scheduled_arrival_time
	FROM LEG_INSTANCE as End_leg,FLIGHT_LEG
	WHERE End_leg.Flight_no = FLIGHT_LEG.Flight_no
	AND End_leg.Leg_no = FLIGHT_LEG.Leg_number
	AND End_leg.Flight_no IN(
							SELECT	Flight_no
							FROM	FLIGHT_LEG
							GROUP BY Flight_no
							HAVING COUNT(*) > 1)
	
							AND End_leg.Leg_no = (
							SELECT MAX(Leg_number)
							FROM FLIGHT_LEG
							WHERE FLIGHT_LEG.Flight_no = End_leg.Flight_no
							)
) as last_leg
where first_leg.Flight_no = last_leg.Flight_no