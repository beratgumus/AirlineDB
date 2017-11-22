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