﻿USE Airline1
INSERT INTO AIRPORT (Airport_code, Name, Country, City, State) 
VALUES 
('ADB', 'Adnan Menderes Havalimanı','Türkiye', 'İzmir', NULL),
('IST', 'Atatürk Havalimanı', 'Türkiye','İstanbul', NULL),
('ESB', 'Esenboğa Havalimanı','Türkiye' ,'Ankara', NULL),
('NRT', 'Narita International Airport','Japan', 'Tokyo', NULL),
('YXU', 'London International Airport','Canada', 'London','Ontario');


INSERT INTO FLIGHT (Flight_number, Airline, Weekdays) 
VALUES 
(1, 'Türk Hava Yolları', '1,2,3,4,5'), -- izmir -> istanbul | aktarmasız | akşam
(2, 'Türk Hava Yolları', '1,2,3,4,5,6,7'), -- izmir -> istanbul | aktarmasız | sabah
(3, 'Türk Hava Yolları', '1,2,3,4,5'), -- istanbul -> izmir | aktarmasız | öğlen
(4, 'Türk Hava Yolları', '1,5'), -- istanbul -> tokyo | aktarmasız | gece
(5, 'Türk Hava Yolları', '5'), -- izmir -> tokyo | aktarmalı | sabah + 1 gün
(6, 'Alamet Havayolları', '1'), -- istanbul -> ankara
(7, 'Alamet Havayolları', '2'), -- izmir -> istanbul
(8, 'Türk Hava Yolları', '1,2,3,4,5,6,7'), -- izmir -> ankara
(9, 'Unified Airlines', '1,5'), -- japonya -> londra
(10, 'Türk Hava Yolları', '7'),
(11, 'Türk Hava Yolları', '6');-- ankara -> izmir -> istanbul ->tokyo


INSERT INTO FLIGHT_LEG (Flight_no, Leg_number, Departure_airport_code, Scheduled_departure_time,
	Arrival_airport_code, Scheduled_arrival_time) 
VALUES 
(1, 1, 'ADB', '21:50', 'IST', '23:05'),
(2, 1, 'ADB', '10:50', 'IST', '12:10'),
(3, 1, 'IST', '12:15', 'ADB', '13:00'),
(4, 1, 'IST', '02:10', 'NRT', '19:50'),
(5, 1, 'ADB', '21:50', 'IST', '23:05'), -- izmir -> tokyo part1
(5, 2, 'IST', '02:10', 'NRT', '19:50'), -- izmir -> tokyo part2
(6, 1, 'IST', '13:15', 'ESB', '14:10'),
(7, 1, 'ADB', '07:10', 'IST', '08:00'),
(8, 1, 'ADB', '16:25', 'ESB', '17:25'),
(9, 1, 'NRT', '05:00', 'YXU', '01:00'),
(10, 1, 'ADB', '01:00', 'NRT', '20:00'),
(11, 1, 'ESB', '19:00', 'ADB', '20:15'),
(11, 2, 'ADB', '07:00', 'IST', '08:15'),
(11, 3, 'IST', '02:10', 'NRT', '19:50');

INSERT INTO FARE (Flight_no, Fare_code, Amount, Restrictions)
VALUES
(1, 1, 75, NULL),
(1, 2, 150, NULL),
(2, 1, 120, NULL),
(2, 2, 230, NULL),
(3, 1, 80, NULL),
(3, 2, 210, NULL),
(4, 1, 2100, NULL),
(4, 2, 2700, NULL),
(5, 1, 2300, NULL),
(5, 2, 3000, NULL),
(6, 1, 35, NULL),
(7, 1, 35, NULL),
(8, 1, 80, NULL),
(8, 2, 170, NULL),
(9, 1, 5590, NULL),
(9, 2, 6250, NULL);



-- Source: https://tr.wikipedia.org/wiki/T%C3%BCrk_Hava_Yollar%C4%B1
INSERT INTO AIRPLANE_TYPE (Airplane_type_name, Max_seats, Company)
VALUES
('Airbus A320-200', 153, 'Airbus S.A.S'),
('Airbus A321-200', 188, 'Airbus S.A.S'),
('Airbus A330-200', 250, 'Airbus S.A.S'),
('Airbus A380', 850, 'Airbus S.A.S'),
('Boeing 737-800', 165, 'Boeing'),
('Boeing 737-900ER', 151, 'Boeing'),
('Bombardier CRJ700', 70, 'Bombardier');

INSERT INTO AIRPLANE (Airplane_id, Total_number_of_seats, Airplane_type)
VALUES
('THY111', 150, 'Airbus A320-200'),
('THY222', 188, 'Airbus A321-200'),
('THY333', 179, 'Airbus A321-200'),
('THY444', 165, 'Boeing 737-800'),
('THY555', 245, 'Airbus A330-200'),
('XXX666', 165, 'Boeing 737-800'),
('XXX777', 151, 'Boeing 737-900ER'),
('XXX888', 149, 'Boeing 737-900ER'),
('ALA999', 153, 'Airbus A320-200'),
('XXX101', 250, 'Airbus A330-200'),
('UNAFFF', 70, 'Bombardier CRJ700');


INSERT INTO CAN_LAND (Airplane_type_name, Airport_code)
VALUES
('Airbus A320-200', 'ADB'), -- Airbus A320-200 | yurt içi
('Airbus A320-200', 'IST'),
('Airbus A320-200', 'ESB'),
('Airbus A321-200', 'ADB'), -- Airbus A321-200 | tüm havaalanları
('Airbus A321-200', 'IST'),
('Airbus A321-200', 'ESB'),
('Airbus A321-200', 'NRT'),
('Airbus A321-200', 'YXU'),
('Airbus A330-200', 'ADB'), -- Airbus A330-200 | ESB inemiyor
('Airbus A330-200', 'IST'),
('Airbus A330-200', 'NRT'),
('Airbus A330-200', 'YXU'),
('Boeing 737-800', 'ADB'), -- Boeing 737-800 | tüm havaalanları
('Boeing 737-800', 'IST'),
('Boeing 737-800', 'ESB'),
('Boeing 737-800', 'NRT'),
('Boeing 737-800', 'YXU'),
('Boeing 737-900ER', 'IST'), -- Boeing 737-900ER
('Boeing 737-900ER', 'ESB'),
('Boeing 737-900ER', 'NRT'),
('Boeing 737-900ER', 'YXU'),
('Bombardier CRJ700', 'ADB'), -- Bombardier CRJ700 | tüm havaalanları
('Bombardier CRJ700', 'IST'),
('Bombardier CRJ700', 'ESB'),
('Bombardier CRJ700', 'NRT'),
('Bombardier CRJ700', 'YXU'),
('Airbus A380', 'NRT'), -- Airbus A380 | sadece yurt dışı
('Airbus A380', 'YXU');

INSERT INTO LEG_INSTANCE(Flight_no,Leg_no,Date,Number_of_available_seats,Airplane_id,Departure_airport_code,
	Departure_time,Arrival_airport_code,Arrival_time)
VALUES
(1,1,'2017-11-13',15,	'THY111','ADB','2017-11-13 21:53','IST','2017-11-13 23:04'), -- Planlanan havada kalma suresinden daha az surede ucusu tamamladi, -4 dk
(1,1,'2017-11-14',17,	'THY111','ADB','2017-11-14 21:50','IST','2017-11-14 23:05'), -- Rotarsiz, tam zamanlama
(1,1,'2017-11-15',22,	'THY444','ADB','2017-11-15 22:22','IST','2017-11-15 23:34'), -- 32 dk Rotarli
(2,1,'2017-11-13',14,	'THY111','ADB','2017-11-13 10:51','IST','2017-11-13 12:20'), -- Planlanan havada kalma suresinden daha fazla surede ucusu tamamladi, +9 dk
(2,1,'2017-11-15',100,	'THY444','ADB','2017-11-15 10:50','IST','2017-11-15 12:10'),  -- Doluluk orani %50 den az
(3,1,'2017-11-14',6,	'THY333','IST','2017-11-14 12:15','ADB','2017-11-14 13:00'),
(3,1,'2017-11-15',7,	'THY444','IST','2017-11-15 12:18','ADB','2017-11-15 13:07'),
(4,1,'2017-11-13',11,	'THY555','IST','2017-11-13 02:28','NRT','2017-11-13 20:10'), -- Uluslar arasi ucus
(4,1,'2017-10-22',1,	'THY111','IST','2017-10-22 03:34','NRT','2017-10-22 23:58'),
(4,1,'2017-11-17',6,	'THY555','IST','2017-11-17 02:17','NRT','2017-11-17 19:58'),
(5,1,'2017-11-17',6,	'THY555','ADB','2017-11-17 21:50','IST','2017-11-17 23:05'),  -- izmir -> tokyo part1
(5,2,'2017-11-18',13,	'THY555','IST','2017-11-18 02:19','NRT','2017-11-18 19:59'), -- izmir -> tokyo part2, +1
(6,1,'2023-11-18',153,	'ALA999','IST', null, null, null), -- alamet havayolları
(7,1,'2017-12-28',153,	'ALA999','ADB', '2017-12-28 17:12', null, null),			 --Havada olan,henuz inis yapmamis ucus
(2,1,'2017-11-14',17,	'THY111','ADB','2017-11-14 10:51','ESB','2017-11-14 12:40'), -- Planlanan yerden farkli havaalanina inen ucus -- IST yerine ESB ye iniyor
(2,1,'2017-11-21',0,	'THY555','ADB','2017-11-21 10:50','ESB','2017-11-21 13:13'), -- Planlanan yerden farkli havaalanina inen fakat normalde inememesi gereken uçuş
(9,1,'2017-11-22',6,	'UNAFFF','NRT','2017-11-22 05:02','YXU','2017-11-23 00:12'),
(1,1,'2018-1-22',135,	'THY111','ADB', null, null, null), -- gerçekleşmemiş uçuş
(1,1,'2018-1-25',150,	'THY111','ADB', null, null, null), -- hiç bilet satılmamış uçuş
(3,1,'2018-1-25',188,	'THY222','ADB', null, null, null),
(9,1,'2018-12-29',70,	'UNAFFF','NRT', null, null, null);

INSERT INTO SEAT_RESERVATION (Flight_no, Leg_no, Date, Seat_number, Customer_name, Customer_phone)
VALUES
(1, 1, '2017-11-13', 1, 'Mehmet Okumuş',	'+905551112222'),
(1, 1, '2017-11-13', 2, 'Melis Okumuş',		'+905001002000'),
(1, 1, '2017-11-13', 3, 'Sema Okumamış ',	'+905001502002'),
(1, 1, '2017-11-13', 4, 'Tarkan Altınbaş',	'+905531119090'),
(1, 1, '2017-11-13', 5, 'Tuncay Şanlı',		'+905119897777'),
(1, 1, '2017-11-15', 1, 'Merve Konuk',		'+905108889999'),
(1, 1, '2017-11-15', 2, 'Burcu Gün',		'+905001002001'),
(3, 1, '2017-11-14', 1, 'Mehmet Okumuş',	'+905551112222'),
(3, 1, '2017-11-14', 2, 'Melis Okumuş',		'+905001002000'),
(3, 1, '2017-11-14', 3, 'Tarkan Altınbaş',	'+905536669090'),
(4, 1, '2017-10-22', 1, 'Melis Elibol',		'+812083438802'),
(4, 1, '2017-10-22', 2, 'Hiroto Miyamoto',	'+812083438662'),
(4, 1, '2017-11-13', 1, 'Canberk Kara',		'+9055612345678'),
(4, 1, '2017-11-13', 2, 'Hosuzu Miyamoto',	'+812055558801'),
(4, 1, '2017-11-13', 3, 'Asuka Miyamoto',	'+812055558801'),
(4, 1, '2017-11-13', 4, 'Mert Akıncılar',	'+905519890012'),
(4, 1, '2017-11-13', 5, 'Rana Altıparmak',	'+905519890012'),
(5, 2, '2017-11-18', 14, 'Selim Gezgin',	'+905532221144'),
(9, 1, '2017-11-22', 1, 'Tetsushou Fukui',	'+15415454908'),
(9, 1, '2017-11-22', 2, 'Hiroto Miyamoto',	'+812083438662'),
(9, 1, '2017-11-22', 3, 'Lisa L. Smith',	'+16415524531');
