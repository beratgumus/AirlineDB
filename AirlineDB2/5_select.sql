USE Airline2

-- Uyrugu Japonya olan musteriler tarafindan en cok tercih edilen havayolu sirketleri
SELECT	CO.Name, COUNT(*) as Musteri_sayisi
FROM CUSTOMER as C, SEAT_RESERVATION as SR, FLIGHT as F, COMPANY as CO
WHERE	C.Id = SR.Customer_id
AND		SR.Flight_no = f.Flight_number
AND		F.Company_id = CO.Id
AND		C.Country = 'Japan'
GROUP BY CO.Name
ORDER BY COUNT(*) desc;


--Son 2 ay icerisinde Tokyo`daki havaalanina inis yapan yolcularin uyruklara gore dagilimi --degisimi gormek icin ay farkini 2den 3e cikar
SELECT	C.Country,COUNT(*) as Yolcu_sayisi
FROM AIRPORT as A, LEG_INSTANCE as LI, CUSTOMER as C, SEAT_RESERVATION as SR
WHERE	A.Airport_code=LI.Arrival_airport_code
AND		LI.Flight_no = SR.Flight_no
AND		LI.Leg_no = SR.Leg_no
AND		LI.Date = SR.Date
AND		SR.Customer_id = C.Id
AND		A.City = 'Tokyo'
AND		LI.Date > DATEADD(m, -2, getdate())
GROUP BY C.Country
ORDER BY COUNT(*) desc;


-- Ucak ureten firmalarin, ucaklarinin yaptigi toplam kaza sayisi

WITH ACCIDENT(Airplane_id) 
AS
(SELECT Airplane_id
FROM	LEG_INSTANCE as LI
WHERE	 NOT EXISTS (SELECT	*
				FROM	FLIGHT_LEG as FL
				WHERE	LI.Flight_no = Flight_no
				AND		LI.Leg_no = FL.Leg_number
				AND		LI.Arrival_airport_code is NOT NULL
				AND		LI.Arrival_time is NOT NULL
				)
)
SELECT	C.Name, COUNT(*) as Kaza_sayisi
FROM	AIRPLANE as A, AIRPLANE_TYPE as AT, COMPANY as C, ACCIDENT as AC
WHERE	AC.Airplane_id = A.Airplane_id
AND		A.Airplane_type = AT.Airplane_type_name
AND		AT.Company_id = C.Id
GROUP BY C.Name
ORDER BY COUNT(*) desc;


-- 1. Verilen bir haavayolu şirketinde, yarım saatten fazla rotar yapan 
-- uçuslarında uçan yolcularının listesi
SELECT COMPANY.Name as Airline, FL.Flight_no, LI.Leg_no, LI.[Date], 
	Scheduled_departure_time,CAST(LI.Departure_time as TIME(0)) as Departure_time, 
	CUSTOMER.Name as Customer
FROM FLIGHT_LEG as FL, LEG_INSTANCE as LI, FLIGHT, SEAT_RESERVATION as SR, CUSTOMER, COMPANY
WHERE COMPANY.Name = 'Türk Hava Yolları'
AND FL.Flight_no = LI.Flight_no
AND FL.Leg_number = LI.Leg_no
AND FL.Flight_no = FLIGHT.Flight_number
AND FLIGHT.Company_id = COMPANY.Id
AND	LI.Flight_no = SR.Flight_no
AND	LI.Leg_no = SR.Leg_no
AND	LI.Date = SR.Date
AND SR.Customer_id = CUSTOMER.Id
AND ( DATEDIFF(minute, CAST(LI.Date as DATETIME) + 
	CAST(FL.Scheduled_departure_time as DATETIME), LI.Departure_time ) 
	) > 30;


-- Verilen bir havayolu şirketinin 5000 (aktarmasız) kilometreden uzun 
-- uçuşlarında seyehat eden yolcuların listesi
SELECT CUSTOMER.*, Flight_number, Km
FROM COMPANY , FLIGHT, FLIGHT_LEG as FL, SEAT_RESERVATION as SR, CUSTOMER
WHERE COMPANY.Name = 'Türk Hava Yolları'
AND FL.Km > 5000
AND FLIGHT.Company_id = COMPANY.Id
AND FL.Flight_no = FLIGHT.Flight_number
AND SR.Flight_no = FL.Flight_no
AND SR.Leg_no = FL.Leg_number
AND SR.Customer_id = CUSTOMER.Id;


-- 17. Uluslar arası uçuş gerçekleştiren havayolları şirketlerinin listesi
WITH INTERNATIONAL_FLIGHTS(Flight_no) AS
(
	SELECT fl.Flight_no
	FROM FLIGHT_LEG AS fl, AIRPORT AS a1, AIRPORT AS a2
	WHERE fl.Departure_airport_code = a1.Airport_code
	AND fl.Arrival_airport_code = a2.Airport_code
	AND a1.State != a2.State
)
SELECT DISTINCT COMPANY.Name
FROM FLIGHT, INTERNATIONAL_FLIGHTS, COMPANY
WHERE Flight_number = INTERNATIONAL_FLIGHTS.Flight_no
AND COMPANY.Id = FLIGHT.Company_id;


-- 19. izmirden en az 1 kere uçuş yapmış şirketlerin listesi
SELECT COMPANY.Name
FROM AIRPORT, FLIGHT, LEG_INSTANCE, COMPANY
WHERE AIRPORT.City = 'İzmir'
AND LEG_INSTANCE.Departure_airport_code = AIRPORT.Airport_code
AND LEG_INSTANCE.Flight_no = FLIGHT.Flight_number
AND FLIGHT.Company_id = COMPANY.Id
GROUP BY COMPANY.Name

-- Kalkış ve iniş havaalanı verilen, henüz gerçekleşmemiş uçuşların
-- tarihi, kalkış saati, iniş saati ve boş koltuk sayıları
SELECT LEG_INSTANCE.Date, Scheduled_departure_time, Number_of_available_seats, 
	Scheduled_arrival_time
FROM AIRPORT as DEP, AIRPORT as ARR, FLIGHT_LEG, LEG_INSTANCE
WHERE DEP.City = 'İzmir'
AND ARR.City = 'İstanbul'
AND FLIGHT_LEG.Departure_airport_code = DEP.Airport_code
AND FLIGHT_LEG.Arrival_airport_code = ARR.Airport_code
AND LEG_INSTANCE.Flight_no = FLIGHT_LEG.Flight_no
AND LEG_INSTANCE.Leg_no = FLIGHT_LEG.Leg_number
AND DATE > CAST(GETDATE() as DATE)


-- Yılın ilk uçuşunu gerçekleştiren havaalanı şirketi ve uçuş bilgileri
	SELECT TOP 1 C.Name as Airline, LI.Flight_no, LI.Leg_no, LI.Date
	FROM LEG_INSTANCE as LI, FLIGHT as F, COMPANY as C
	WHERE DATEPART(YY, LI.Date) = DATEPART(YY, GETDATE())
	AND F.Flight_number = LI.Flight_no
	AND C.Id = F.Company_id
	ORDER BY LI.Date ASC

	
-- Yılın ilk ve son uçuşlarını gerçekleştiren havayolu şirketleri ve uçuş bilgileri
WITH FIRST_FLIGHT(Type, Airline, Flight_no, Leg_no, Date) as (
	
	SELECT TOP 1 'First flight', C.Name as Airline, LI.Flight_no, LI.Leg_no, LI.Date
	FROM LEG_INSTANCE as LI, FLIGHT as F, COMPANY as C
	WHERE DATEPART(YY, LI.Date) = DATEPART(YY, GETDATE())
	AND F.Flight_number = LI.Flight_no
	AND C.Id = F.Company_id
	ORDER BY LI.Date ASC

), LAST_FLIGHT(Type, Airline, Flight_no, Leg_no, Date) as (

	SELECT TOP 1  'Last flight', C.Name as Airline, LI.Flight_no, LI.Leg_no, LI.Date
	FROM LEG_INSTANCE as LI, FLIGHT as F, COMPANY as C
	WHERE DATEPART(YY, LI.Date) = DATEPART(YY, GETDATE())
	AND F.Flight_number = LI.Flight_no
	AND C.Id = F.Company_id
	ORDER BY LI.Date DESC
)
SELECT * FROM FIRST_FLIGHT
UNION
SELECT * FROM LAST_FLIGHT;


-- 20. verilen bir havalimanını en çok kullanan şirketlerin listesi
-- Flight_count = iniş havalimanı + kalkış havalimanı 'Adnan Menderes Havalimanı'
-- olan uçuşların sayısı
WITH SELECTED_AIRPORT(Code) as (
	SELECT Airport_code	
	FROM AIRPORT
	WHERE AIRPORT.Name = 'Adnan Menderes Havalimanı'
)
SELECT C.Name, COUNT(*) as Flight_count
FROM FLIGHT as F, LEG_INSTANCE as LI, COMPANY as C, SELECTED_AIRPORT
WHERE (	LI.Departure_airport_code = SELECTED_AIRPORT.Code
		OR LI.Arrival_airport_code = SELECTED_AIRPORT.Code )
AND F.Flight_number = LI.Flight_no
AND F.Company_id = C.Id
GROUP BY C.Name
ORDER BY COUNT(*) DESC