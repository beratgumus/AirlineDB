USE Airline1
GO
-- 1. Yarım saatten fazla rotar yapan ucusların havayolu sirketini ve yolcularını bulan SQL
SELECT FL.Flight_no, LI.Leg_no, LI.[Date],  Scheduled_departure_time, CAST(LI.Departure_time as TIME(0)) as Departure_time,Airline,Customer_name
FROM FLIGHT_LEG as FL, LEG_INSTANCE as LI,FLIGHT,SEAT_RESERVATION as SR
WHERE FL.Flight_no = LI.Flight_no
AND FL.Leg_number = LI.Leg_no
AND FL.Flight_no=FLIGHT.Flight_number
AND	LI.Flight_no=SR.Flight_no
AND	LI.Leg_no=SR.Leg_no
AND	LI.Date=SR.Date
AND ( SELECT DATEDIFF(minute, CAST(LI.Date as DATETIME) + CAST(FL.Scheduled_departure_time as DATETIME), LI.Departure_time ) ) > 30;


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
		OR (FL.Departure_airport_code != LI.Departure_airport_code));
		

-- 6) Tamamlanmış uçuşların boş koltuk sayısı %50den fazla olanları bulan sql
SELECT Flight_no, Leg_no, [Date], Number_of_available_seats, Total_number_of_seats, CAST(Number_of_available_seats * 100 as float) / CAST(Total_number_of_seats as float) as Rate
FROM LEG_INSTANCE as LI, AIRPLANE as A
WHERE LI.Arrival_time IS NOT NULL
AND LI.Airplane_id = A.Airplane_id
AND (CAST(Number_of_available_seats * 100 as float) / CAST(Total_number_of_seats as float) ) > 50;


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
WHERE RESULT.Flight_count < 5;


-- 10) verilen bir havaalanına inebilecek uçakları alabildiği yolcu sayısına göre sıralayan sql
SELECT A.Airplane_id, A.Total_number_of_seats
FROM AIRPORT, CAN_LAND as CL, AIRPLANE A
WHERE AIRPORT.Name = 'Adnan Menderes Havalimanı'
AND AIRPORT.Airport_code = CL.Airport_code
AND A.Airplane_type = CL.Airplane_type_name
ORDER BY A.Total_number_of_seats DESC;


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
WHERE Flight_number = INTERNATIONAL_FLIGHTS.Flight_no;


-- 18) Aktarmalı uçuşların listesi
SELECT COUNT(*) AS Leg_count, FLIGHT_LEG.Flight_no
FROM FLIGHT, FLIGHT_LEG
WHERE FLIGHT.Flight_number = FLIGHT_LEG.Flight_no
GROUP BY FLIGHT_LEG.Flight_no
HAVING COUNT(*) > 1;


-- 19. izmirde 5den fazla uçuş yapmış şirketlerin listesi
SELECT COUNT(*) AS Flight_count, FLIGHT.Airline
FROM AIRPORT, LEG_INSTANCE, FLIGHT
WHERE AIRPORT.City = 'İzmir'
AND AIRPORT.Airport_code = LEG_INSTANCE.Departure_airport_code
AND LEG_INSTANCE.Flight_no = FLIGHT.Flight_number
GROUP BY FLIGHT.Airline
HAVING COUNT(*) > 5;


-- 20. verilen bir havalimanını en çok kullanan şirketlerin listesi
-- Flight_count = iniş havalimanı + kalkış havalimanı 'Adnan Menderes Havalimanı'
-- olan uçuşların sayısı
SELECT F.Airline, COUNT(*) as Flight_count
FROM FLIGHT as F, FLIGHT_LEG as FL
WHERE ( 
	FL.Departure_airport_code IN (
		SELECT Airport_code
		FROM AIRPORT
		WHERE AIRPORT.Name = 'Adnan Menderes Havalimanı' )
	OR FL.Arrival_airport_code IN (
		SELECT Airport_code
		FROM AIRPORT
		WHERE AIRPORT.Name = 'Adnan Menderes Havalimanı' )
)
AND F.Flight_number = FL.Flight_no
GROUP BY F.Airline
ORDER BY COUNT(*) DESC


--21. planlanan iniş havalimanından farklı havalimanına inen fakat inmesi normalde mümkün olmayan uçuşlar
-- (uçuşda kullanılan uçakğın tipi ve indiği havalimanı can_land tablosunda yok fakat inmiş)
SELECT LI.*
FROM FLIGHT_LEG as FL, LEG_INSTANCE as LI
WHERE FL.Flight_no = LI.Flight_no
AND FL.Leg_number = LI.Leg_no
AND FL.Arrival_airport_code != LI.Arrival_airport_code
AND LI.Airplane_id NOT IN ( 
	SELECT A.Airplane_id
	FROM  AIRPLANE as A, CAN_LAND as CL
	WHERE A.Airplane_type = CL.Airplane_type_name
	AND CL.Airport_code = LI.Arrival_airport_code
)


--23. Planlanan havada kalma suresinden daha fazla surede ucusu tamamlayan ucuslar
SELECT	LI.Flight_no,LI.Leg_no,LI.Date,(DATEDIFF(MINUTE,FL.Scheduled_departure_time,FL.Scheduled_arrival_time)) AS Planlanan_Ucus_Suresi,DATEDIFF(MINUTE,LI.Departure_time,LI.Arrival_time) AS Gerceklesen_Ucus_Suresi
FROM	FLIGHT_LEG AS FL,LEG_INSTANCE AS LI
WHERE	FL.Flight_no=LI.Flight_no AND FL.Leg_number=LI.Leg_no
AND  (DATEDIFF(MINUTE,LI.Departure_time,LI.Arrival_time)) - (DATEDIFF(MINUTE,FL.Scheduled_departure_time,FL.Scheduled_arrival_time))  >0;


-- 24.istanbul-japonya arası aktarmasız uçuşlardaki aynı telefon numarasına sahip müşterilerin adı
WITH IJ_FLIGHTS(Flight_no) AS
(
	SELECT fl.Flight_no
	FROM FLIGHT_LEG AS fl, AIRPORT AS a1, AIRPORT AS a2
	WHERE fl.Departure_airport_code = a1.Airport_code
	AND fl.Arrival_airport_code = a2.Airport_code
	AND a1.City = 'İstanbul'
	AND a2.State = 'Japan'
)
SELECT SEAT_RESERVATION.Customer_name, SEAT_RESERVATION.Customer_phone
FROM SEAT_RESERVATION
WHERE SEAT_RESERVATION.Customer_phone IN (

	SELECT SR.Customer_phone
	FROM IJ_FLIGHTS, LEG_INSTANCE as LI, SEAT_RESERVATION as SR
	WHERE LI.Flight_no = IJ_FLIGHTS.Flight_no
	AND SR.Flight_no = LI.Flight_no
	AND SR.Leg_no = LI.Leg_no
	AND SR.Date = LI.Date
	GROUP BY SR.Customer_phone
	HAVING COUNT(*) > 1
);



-- 5.d. Exists -- Max_seats i 200 den buyuk olan ucaklar
SELECT *
FROM	AIRPLANE
WHERE	EXISTS (SELECT	*
				FROM	AIRPLANE_TYPE
				WHERE	AIRPLANE.Airplane_type=AIRPLANE_TYPE.Airplane_type_name
				AND		Max_seats >200
				);

-- 5.d. Not Exists -- Kaza yapmis ucuslarin listesi
SELECT *
FROM	LEG_INSTANCE as LI
WHERE	 NOT EXISTS (SELECT	*
				FROM	FLIGHT_LEG as FL
				WHERE	LI.Flight_no=Flight_no
				AND		LI.Leg_no=FL.Leg_number
				AND		LI.Arrival_airport_code is NOT NULL
				);