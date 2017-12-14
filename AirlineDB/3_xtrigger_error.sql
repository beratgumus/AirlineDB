-- == HATA TESTLERİ ==
-- Buradaki queryler triggerlar/check constraintleri test etmek için yazılmıştır.
-- Genelinde hatalı bir durum söz konusudur


-- Trigger4
INSERT INTO LEG_INSTANCE(Flight_no,Leg_no,Date,Number_of_available_seats,Airplane_id,Departure_airport_code,
	Departure_time,Arrival_airport_code,Arrival_time)
VALUES
(4,1,'2018-01-01',150,'THY111', 'IST' ,null, null, null); 
-- istanbul -> tokyo uçuşu fakat THY111 tokyoya inemiyor. trigger4 çalışıp hata vermeli

INSERT INTO LEG_INSTANCE(Flight_no,Leg_no,Date,Number_of_available_seats,Airplane_id,Departure_airport_code,
	Departure_time,Arrival_airport_code,Arrival_time)
VALUES
(4,1,'2018-01-02',344,'THY222', 'IST' ,null, null, null);
-- THY222 max_available_seats 188den fazla olmamalı. hata vermeli