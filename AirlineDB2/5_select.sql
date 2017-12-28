USE Airline2

-- Uyrugu Japonya olan musteriler tarafindan en cok tercih edilen havayolu sirketleri

SELECT	CO.Name,COUNT(*) as Musteri_sayisi
FROM CUSTOMER as C,SEAT_RESERVATION as SR,FLIGHT as F,COMPANY as CO
WHERE	C.Id=SR.Customer_id
AND		SR.Flight_no=f.Flight_number
AND		F.Company_id=CO.Id
AND		C.Country='Japan'
GROUP BY CO.Name
ORDER BY COUNT(*) desc;


--Son 2 ay icerisinde Tokyo`daki havaalanina inis yapan yolcularin uyruklara gore dagilimi --degisimi gormek icin ay farkini 2den 3e cikar

SELECT	C.Country,COUNT(*) as Yolcu_sayisi
FROM AIRPORT as A,LEG_INSTANCE as LI,CUSTOMER as C,SEAT_RESERVATION as SR
WHERE	A.Airport_code=LI.Arrival_airport_code
AND		LI.Flight_no=SR.Flight_no
AND		LI.Leg_no=SR.Leg_no
AND		LI.Date=SR.Date
AND		SR.Customer_id=C.Id
AND		A.City='Tokyo'
AND		Li.Date > DATEADD(m, -2, getdate())
GROUP BY C.Country
ORDER BY COUNT(*) desc;


-- Ucak ureten firmalarin, ucaklarinin yaptigi toplam kaza sayisi

WITH ACCIDENT(Airplane_id) 
AS
(SELECT Airplane_id
FROM	LEG_INSTANCE as LI
WHERE	 NOT EXISTS (SELECT	*
				FROM	FLIGHT_LEG as FL
				WHERE	LI.Flight_no=Flight_no
				AND		LI.Leg_no=FL.Leg_number
				AND		LI.Arrival_airport_code is NOT NULL
				AND		LI.Arrival_time is NOT NULL
				))
SELECT	C.Name,COUNT(*) as Kaza_sayisi
FROM	AIRPLANE as A,AIRPLANE_TYPE as AT,COMPANY as C,ACCIDENT as AC
WHERE	AC.Airplane_id=A.Airplane_id
AND		A.Airplane_type=AT.Airplane_type_name
AND		AT.Company_id=C.Id
GROUP BY C.Name
ORDER BY COUNT(*) desc;