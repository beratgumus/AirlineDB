USE Airline2

-- Uyrugu Japonya olan m�steriler tarafindan en �ok tercih edilen havayolu sirketleri

SELECT	CO.Name,COUNT(*) as Musteri_sayisi
FROM CUSTOMER as C,SEAT_RESERVATION as SR,FLIGHT as F,COMPANY as CO
WHERE	C.Id=SR.Customer_id
AND		SR.Flight_no=f.Flight_number
AND		F.Company_id=CO.Id
AND		C.Country='Japan'
GROUP BY CO.Name
ORDER BY COUNT(*) desc;

