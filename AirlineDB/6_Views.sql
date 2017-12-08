--Aktarmali ve aktarmasiz tum ucuslarin, ilk aktarmasinin kalkis tarihi ve saati ile son aktarmasinin inis tarihi ve saatinin musterilere gostermek amaciyla view olusturma icin yazilan sql
-- Artik aktarma sayisi ne olursa olsun calisiyor...

USE Airline1
GO
CREATE VIEW VW_firstDeparture_lastArrival_of_connectingFlights
as

WITH first_leg(Flight_no,Departure_date,Scheduled_departure_time)
AS
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
), last_leg(Flight_no,Arrival_date,Scheduled_arrival_time) as
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
), connecting_flight(Flight_no,Departure_date,Scheduled_departure_time,Arrival_date,Scheduled_arrival_time) as

(
SELECT	first_leg.Flight_no,Departure_date,Scheduled_departure_time,Arrival_date,Scheduled_arrival_time
FROM	first_leg,last_leg
where first_leg.Flight_no = last_leg.Flight_no
)



(SELECT LI.Flight_no,Date as Departure_date,F.Scheduled_departure_time,(CAST(LI.Arrival_time as DATE)) as Arrival_date,F.Scheduled_arrival_time
FROM	LEG_INSTANCE as LI,FLIGHT_LEG as F,connecting_flight as CF
WHERE	LI.Flight_no=F.Flight_no
AND		LI.Flight_no != CF.Flight_no)
UNION
(SELECT	*
FROM connecting_flight
)