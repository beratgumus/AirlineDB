USE Airline1
GO

-- 1. Yarım saatten fazla rotar yapan ucusları bulan SQL
SELECT FL.Flight_no, Leg_no, [Date],  Scheduled_departure_time, CAST(LI.Departure_time as TIME(0)) as Departure_time
FROM FLIGHT_LEG as FL
INNER JOIN LEG_INSTANCE as LI
ON FL.Flight_no = LI.Flight_no
AND FL.Leg_number = LI.Leg_no
WHERE ( SELECT DATEDIFF(minute, CAST(LI.Date as DATETIME) + CAST(FL.Scheduled_departure_time as DATETIME), LI.Departure_time ) ) > 30;


-- 2. Adı verilen havaalanına inebilen uçakların listesi
SELECT AIRPLANE.*
FROM AIRPORT, CAN_LAND, AIRPLANE_TYPE, AIRPLANE
WHERE AIRPORT.Name = 'Adnan Menderes Havalimanı'
AND CAN_LAND.Airport_code = AIRPORT.Airport_code 
AND CAN_LAND.Airplane_type_name = AIRPLANE_TYPE.Airplane_type_name
AND AIRPLANE_TYPE.Airplane_type_name = AIRPLANE.Airplane_type;

-- 3. Planlanan yerden farklı yere iniş ya da farkli yerden kalkis yapan uçuşlar

USE Airline1
SELECT	*
FROM FLIGHT_LEG as FL, LEG_INSTANCE as LI
WHERE	(FL.Flight_no=LI.Flight_no AND FL.Leg_number = LI.Leg_no)
		AND ((FL.Arrival_airport_code != LI.Arrival_airport_code )
		OR (FL.Departure_airport_code != LI.Departure_airport_code))
		

-- 6) Tamamlanmış uçuşların boş koltuk sayısı %50den fazla olanları bulan sql
SELECT Flight_no, Leg_no, [Date], Number_of_available_seats, Total_number_of_seats, CAST(Number_of_available_seats * 100 as float) / CAST(Total_number_of_seats as float) as Rate
FROM LEG_INSTANCE as LI, AIRPLANE as A
WHERE LI.Arrival_time IS NOT NULL
AND LI.Airplane_id = A.Airplane_id
AND (CAST(Number_of_available_seats * 100 as float) / CAST(Total_number_of_seats as float) ) > 50


-- 9) verilen bir havaalanında, verilen tarihden sonra, 5'den az uçuş yapmış şirketlerin isimleri
SELECT *
FROM (
		SELECT COUNT(*) AS Flight_count, FLIGHT.Airline 
		FROM AIRPORT, FLIGHT, LEG_INSTANCE
		WHERE AIRPORT.Name = 'Atatürk Havalimanı'
		AND LEG_INSTANCE.Departure_airport_code = AIRPORT.Airport_code
		AND FLIGHT.Flight_number = LEG_INSTANCE.Flight_no
		AND LEG_INSTANCE.Date > CAST('2015.01.01' AS DATE)
		--AND LEG_INSTANCE.Date < CAST(GETDATE() AS DATE) --yapMIŞ dediği için
		GROUP BY FLIGHT.Airline
	) RESULT
WHERE RESULT.Flight_count < 5


-- 17. Uluslar arası uçuş gerçekleştiren havayolları listesi
WITH INTERNATIONAL_FLIGHTS(Flight_no) AS
(
	SELECT fl.Flight_no
	FROM FLIGHT_LEG AS fl, AIRPORT AS a1, AIRPORT AS a2
	WHERE fl.Departure_airport_code = a1.Airport_code
	AND fl.Arrival_airport_code = a2.Airport_code
	AND a1.State != a2.State
)
SELECT DISTINCT Airline
FROM FLIGHT, INTERNATIONAL_FLIGHTS
WHERE Flight_number = INTERNATIONAL_FLIGHTS.Flight_no


-- 18) Aktarmalı uçuşların listesi
SELECT COUNT(*) AS Leg_count, FLIGHT_LEG.Flight_no
FROM FLIGHT, FLIGHT_LEG
WHERE FLIGHT.Flight_number = FLIGHT_LEG.Flight_no
GROUP BY FLIGHT_LEG.Flight_no
HAVING COUNT(*) > 1


-- 19. izmirde 5den fazla uçuş yapmış şirketlerin listesi
SELECT COUNT(*) AS Flight_count, FLIGHT.Airline
FROM AIRPORT, LEG_INSTANCE, FLIGHT
WHERE AIRPORT.City = 'İzmir'
AND AIRPORT.Airport_code = LEG_INSTANCE.Departure_airport_code
AND LEG_INSTANCE.Flight_no = FLIGHT.Flight_number
GROUP BY FLIGHT.Airline
HAVING COUNT(*) > 5