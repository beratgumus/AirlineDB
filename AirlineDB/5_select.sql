USE Airline1
GO

-- 2. Adı verilen havaalanına inebilen uçakların listesi
SELECT AIRPLANE.*
FROM AIRPORT, CAN_LAND, AIRPLANE_TYPE, AIRPLANE
WHERE AIRPORT.Name = 'Adnan Menderes Havalimanı'
AND CAN_LAND.Airport_code = AIRPORT.Airport_code 
AND CAN_LAND.Airplane_type_name = AIRPLANE_TYPE.Airplane_type_name
AND AIRPLANE_TYPE.Airplane_type_name = AIRPLANE.Airplane_type;


-- 17. Uluslar arası uçuş gerçekleştiren havayolları listesi
SELECT DISTINCT Airline
FROM FLIGHT
WHERE Flight_number IN (
	SELECT fl.Flight_no
	FROM FLIGHT_LEG AS fl
	INNER JOIN AIRPORT AS a1
	ON fl.Departure_airport_code = a1.Airport_code
	INNER JOIN AIRPORT AS a2
	ON fl.Arrival_airport_code = a2.Airport_code
	WHERE a1.State != a2.State
)


-- 18) Aktarmalı uçuşların listesi
SELECT DISTINCT FLIGHT_LEG.Flight_no
FROM FLIGHT_LEG , 
	(
		SELECT COUNT(*) AS Flight_count, FLIGHT_LEG.Flight_no
		FROM FLIGHT, FLIGHT_LEG
		WHERE FLIGHT.Flight_number = FLIGHT_LEG.Flight_no
		GROUP BY FLIGHT_LEG.Flight_no
	) RESULT
WHERE RESULT.Flight_count > 1
AND RESULT.Flight_no = FLIGHT_LEG.Flight_no;


-- 19. izmirde 5den fazla uçuş yapmış şirketlerin listesi
SELECT RESULT.Airline
FROM (
	SELECT COUNT(*) AS Flight_count, FLIGHT.Airline
	FROM AIRPORT, LEG_INSTANCE, FLIGHT
	WHERE AIRPORT.City = 'İzmir'
	AND AIRPORT.Airport_code = LEG_INSTANCE.Departure_airport_code
	AND LEG_INSTANCE.Flight_no = FLIGHT.Flight_number
	GROUP BY FLIGHT.Airline
) RESULT
WHERE RESULT.Flight_count > 5