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


