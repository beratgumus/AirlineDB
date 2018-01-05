-- müşterilerin ülkelere göre dağılışları raporlaması
USE Airline2
GO

DROP VIEW IF EXISTS [dbo].[VW_Customer_distribution]
GO

CREATE VIEW VW_Customer_distribution
AS

WITH DIST(Country, Airline, Customer_count) as  (
	-- Bu geçici tablo ülkeler, havayolu şirketleri ve şirketlerin
	-- kaç yolcusu olduğunu tutar

	SELECT CU.Country, CO.Name, COUNT(*) as Customer_count
	FROM SEAT_RESERVATION as SR, CUSTOMER as CU, FLIGHT as F, COMPANY as CO		
	WHERE SR.Customer_id = CU.Id
	AND SR.Flight_no = F.Flight_number
	AND F.Company_id = CO.Id
	GROUP BY CO.Name, CU.Country	
	
), MAX_USED_AIRLINES(Country, Max_used_airline) as  (
	-- Bu geçici tablo yukarıdaki DIST tablosundan her bir ülke için
	-- yolcu sayısı en fazla olan havayolu şirketini içerir

	SELECT d1.Country, d1.Airline
	FROM DIST as d1
	INNER JOIN (
		SELECT Country, MAX(Customer_count) as Max_customer_count
		FROM DIST
		GROUP BY Country
	) d2 ON d1.Country = d2.Country AND d1.Customer_count = d2.Max_customer_count 

), DIST_BY_COUNTRY(Country, Avg_fare_ammount, Avg_flight_distance, Customer_count) as (
	-- Bu geçici tablo ülkelere göre yolcu sayısını, ortalama bilet fiyatını,
	-- ortalama uçuş uzunluğunu tutar
	
	SELECT CU.Country, AVG(FARE.Amount) as Avg_fare_ammount,
		AVG(FL.Km) Avg_flight_distance, COUNT(*) as Customer_count
	FROM SEAT_RESERVATION as SR, CUSTOMER as CU, FARE, 
		FLIGHT_LEG as FL, FLIGHT as F, COMPANY as CO
	WHERE CU.Id = SR.Customer_id 
	AND SR.Fare_code = FARE.Fare_code
	AND SR.Flight_no = FARE.Flight_no
	AND SR.Leg_no = FL.Leg_number
	AND FARE.Flight_no = FL.Flight_no
	AND F.Flight_number = FL.Flight_no
	AND F.Company_id = CO.Id
	GROUP BY CU.Country
)
SELECT DBC.*, MUA.Max_used_airline
FROM DIST_BY_COUNTRY as DBC, MAX_USED_AIRLINES as MUA
WHERE MUA.Country = DBC.Country

