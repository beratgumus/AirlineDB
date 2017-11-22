USE Airline1
GO

-- 2. Adı verilen havaalanına inebilen uçakların listesi
SELECT AIRPLANE.*
FROM AIRPORT, CAN_LAND, AIRPLANE, AIRPLANE_TYPE
WHERE AIRPORT.Name = 'Adnan Menderes Havalimanı'
AND CAN_LAND.Airport_code = AIRPORT.Airport_code 
AND CAN_LAND.Airplane_type_name = AIRPLANE_TYPE.Airplane_type_name
AND AIRPLANE_TYPE.Airplane_type_name = AIRPLANE.Airplane_type;

