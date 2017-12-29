-- Havalanlarının kullanım miktarlarını gösteren view
--		- Havaalanı kodu
--		- Havaalanından yapılan kalkış sayısı
--		- Havaalanına yapılan iniş sayısı
--		- İniş + kalkış sayısı
--		- Havaalanından en fazla uçuş yapan şirket
USE Airline1
GO

DROP VIEW IF EXISTS [dbo].[VW_Airport_Usage]
GO

CREATE VIEW VW_Airport_Usage
AS

WITH DEP_COUNTS(Airport_code, Departure_count) AS -- havaalanından kalkan uçuşları tutan tablo
(
	SELECT A.Airport_code, COUNT(LI.Flight_no) as Departure_count
	FROM AIRPORT as A
	LEFT JOIN LEG_INSTANCE as LI
	ON A.Airport_code = LI.Departure_airport_code
	GROUP BY A.Airport_code

), ARR_COUNTS(Airport_code, Arrival_count) AS -- havaalanına inen uçuşları tutan tablo
(
	SELECT A.Airport_code, COUNT(LI.Flight_no) as Departure_count
	FROM AIRPORT as A
	LEFT JOIN LEG_INSTANCE as LI
	ON A.Airport_code = LI.Arrival_airport_code
	GROUP BY A.Airport_code

), MAX_USED_BY(Airline, Airport_code, Departure_count) AS -- havaalanını en çok kullanan havayolları
(
	SELECT MAX(T.Airline), T.Airport_code, MAX(Departure_count) as Departure_count
	FROM (

		SELECT A.Airport_code, FL.Airline, COUNT(LI.Flight_no) as Departure_count
		FROM AIRPORT as A
		LEFT JOIN LEG_INSTANCE as LI
		ON A.Airport_code = LI.Departure_airport_code
		LEFT JOIN FLIGHT as FL
		ON LI.Flight_no = FL.Flight_number
		GROUP BY A.Airport_code, FL.Airline
		  
	) as T
	GROUP BY T.Airport_code
)

SELECT IsNull(DC.Airport_code, AC.Airport_code) as Airport_code,
	IsNull(DC.Departure_count, 0) as Departure_count,
	IsNull(AC.Arrival_count, 0) as Arrival_count,
	IsNull(AC.Arrival_count, 0) + IsNull(DC.Departure_count,0) as Total_usage,
	MUB.Airline as Max_departure_airline, MUB.Departure_count as Airline_departure_count
FROM DEP_COUNTS as DC, ARR_COUNTS as AC, MAX_USED_BY as MUB
WHERE AC.Airport_code = DC.Airport_code
AND AC.Airport_code = MUB.Airport_code