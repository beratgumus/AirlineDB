USE Airline2

INSERT INTO AIRPORT (Airport_code, Name, City, State) 
VALUES 
('ADB', 'Adnan Menderes Havalimanı', 'İzmir', 'Türkiye'),
('IST', 'Atatürk Havalimanı', 'İstanbul', 'Türkiye'),
('ESB', 'Esenboğa Havalimanı', 'Ankara', 'Türkiye'),
('NRT', 'Narita International Airport', 'Tokyo', 'Japan'),
('YXU', 'London International Airport', 'Ontario', 'London');

INSERT INTO COMPANY (Id, Name, Company_type)
VALUES
(1, 'Türk Hava Yolları', 'Airline'),
(2, 'Alamet Hava Yolları', 'Airline'),
(3, 'Unified Airlines', 'Airline'),
(7, 'Airbus S.A.S', 'Airplane' ),
(8, 'Boeing', 'Airplane' ),
(9, 'Bombardier', 'Airplane' )

INSERT INTO FLIGHT (Flight_number, Company_id, Weekdays) 
VALUES 
(1, 1, '1,2,3,4,5'), -- izmir -> istanbul | aktarmasız | akşam
(2, 1, '1,2,3,4,5,6,7'), -- izmir -> istanbul | aktarmasız | sabah
(3, 1, '1,2,3,4,5'), -- istanbul -> izmir | aktarmasız | öğlen
(4, 1, '1,5'), -- istanbul -> tokyo | aktarmasız | gece
(5, 1, '5'), -- izmir -> tokyo | aktarmalı | sabah + 1 gün
(6, 2, '1'), -- istanbul -> ankara
(7, 2, '2'), -- izmir -> istanbul
(8, 1, '1,2,3,4,5,6,7'), -- izmir -> ankara
(9, 3, '1,5'); -- japonya -> londra


INSERT INTO FLIGHT_LEG (Flight_no, Leg_number, Departure_airport_code, Scheduled_departure_time,
	Arrival_airport_code, Scheduled_arrival_time, Km) 
VALUES 
(1, 1, 'ADB', '21:50', 'IST', '23:05', 350),
(2, 1, 'ADB', '10:50', 'IST', '12:10', 350),
(3, 1, 'IST', '12:15', 'ADB', '13:00', 350),
(4, 1, 'IST', '02:10', 'NRT', '19:50', 8900),
(5, 1, 'ADB', '21:50', 'IST', '23:05', 350), -- izmir -> tokyo part1
(5, 2, 'IST', '02:10', 'NRT', '19:50', 8900), -- izmir -> tokyo part2
(6, 1, 'IST', '13:15', 'ESB', '14:10', 365),
(7, 1, 'ADB', '07:10', 'IST', '08:00', 350),
(8, 1, 'ADB', '16:25', 'ESB', '17:25', 550),
(9, 1, 'NRT', '05:00', 'YXU', '01:00', 10300);

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
INSERT INTO AIRPLANE_TYPE (Airplane_type_name, Max_seats, Company_id)
VALUES
('Airbus A320-200', 153, 7),
('Airbus A321-200', 188, 7),
('Airbus A330-200', 250, 7),
('Airbus A380', 850, 7),
('Boeing 737-800', 165, 8),
('Boeing 737-900ER', 151, 8),
('Bombardier CRJ700', 70, 9);

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

INSERT INTO CUSTOMER(Id, Name, Phone, Email, Address, Country, Passport_number)
VALUES

(1, 'Mehmet Okumuş',	'+905551112222', 'mehmet@m.com', '53/33 sk no:5 İstanbul', 'Türkiye', 99102345),
(2, 'Melis Okumuş',		'+905001002000', 'melis@y.com',	'Lale sokak no:22 İzmir', 'Türkiye', 11683945),
(3, 'Sema Okumamış ',	'+905001502002', 'sema_1@m.com', '63/55 sk no:62 Adana', 'Türkiye',82658364),
(4, 'Tarkan Altınbaş',	'+905531119090', 'sema_3@m.com', '12/34 sk no:34 İstanbul','Türkiye', 11634486),
(5, 'Tuncay Şanlı',		'+905119897777', 'tsan@m.com', '53/33 sk no:3 İzmir', 'Türkiye',16164745),
(6, 'Merve Konuk',		'+905108889999', 'merve4@m.com', 'Esnaflar mah. 55sk no:5 İzmir', 'Türkiye',16006934),
(7, 'Burcu Gün',		'+905001002001', 'burcuG@g.com', '51/36 sk no:84 Adana','Türkiye', 16234409),
(8, 'Melis Elibol',		'+812083438802', 'melisse@a.co', '22/13 sk no:54 Mardin', 'Türkiye',13484674),
(9, 'Hiroto Miyamoto',	'+812083438662', 'hirot8@z.cn','Bunkyō-ku, Tōkyō-to 113-0033', 'Japan',13415334),
(10, 'Canberk Kara',	'+905561234567', 'canbrk@b.com', '13/13 sk no:15 İzmir','Türkiye', 11163432),
(11, 'Hosuzu Miyamoto',	'+812055558801', 'hosuz_44@a.jp', 'Bunkyō-ku, Tōkyō-to 113-0033','Japan', 98106723),
(12, 'Asuka Miyamoto',	'+812055558801', 'asuka@a.jp', 'Bunkyō-ku, Tōkyō-to 113-0033','Japan', 41334255),
(13, 'Mert Akıncılar',	'+905519890012', 'mert@b.co', '11/5 sk no:11 İstanbul','Türkiye', 56347389),
(14, 'Rana Altıparmak',	'+905519890012', 'rana663@sv.com', 'Lale sk no:64 İstanbul','Türkiye', 51390288),
(15, 'Selim Gezgin',	'+905532221144', 'selo@mm.com', '53/33 sk no:56 İzmir', 'Türkiye',11069384),
(16, 'Tetsushou Fukui',	'+15415454908', 'tetsu5@ymh.com', 'Taitō-ku, Tōkyō-to 111-0032', 'Japan',56134533),
(17, 'Lisa L. Smith',	'+16415524531', 'lisasmth@a.com', '11 Wilton Pl Belgravia', 'England', 51009633),
(18, 'Alec Silva',		'+11174257502',  'Suspen@a.co','〒162-0807 Tōkyō-to, Shinjuku-ku','Japan',34248085),
(19, 'Guine White',		'+11947029437',	'gui@egestas.net','P.O. Box 802, 6387 Sed St.','Panama',20434226),
(20, 'Kato Logan',		'+18032920211',	'Donec@primis.org','P.O. Box 400, 5460 Suspendisse St.','Argentina',79809146),
(21, 'Evan Barnett',	'+12216571686',	'nibh@Nulla.org','Ap #930-1583 Dui, Ave','Gabon',77508114),
(22, 'Chase Ratliff',	'+15532472921',	'susc66@Nun.co','P.O. Box 190, 6188 Proin Ave','Indonesia',75211956),
(23, 'Xavier Cantu',	'+13827606327',	'Ves.ante@um.ca','P.O. Box 853, 2608 Nisi. St.','Bolivia',39360081),
(24, 'Alex Mercer',		'+13082426688',	'In.gue@Cras.edu','P.O. Box 721, 8260 Nulla. Ave','Japan',24581066),
(25, 'Salvador Levine',	'+16666802564',	'viamus@ateget.edu','254-2236 Amet Street','Bhutan',84344346),
(26, 'Zephania Peters',	'+19115827032',	'uit.in@at.ca','P.O. Box 452, 8267 Imperdiet Road','Guinea-Bissau',16837283),
(27, 'Emi Ball',		'+19145922922',	'aug.ut@estas.net','Ap #549-5514 Faucibus. Road','Tuvalu',80937458),
(28, 'Bianca Chris',	'+18318631380',	'ori.lus@itamet.co','Ap #843-8343 Eget, Rd.','Belgium',46704263),
(29, 'Thadd Marrowgar',	'+17263989143',	'e77n@liquam.edu','143-7096 Gravida. Rd.','Kazakhstan',24133493),
(30, 'Kai Weiss',		'+18649782718',	'ad.lito8@odim.org','P.O. Box 569, 917 Mauris St.','Kuwait',15936462);

INSERT INTO SEAT_RESERVATION (Flight_no, Leg_no, Date, Seat_number, Customer_id)
VALUES
(1, 1, '2017-11-13', 1, 1),
(1, 1, '2017-11-13', 2, 2),
(1, 1, '2017-11-13', 3, 3),
(1, 1, '2017-11-13', 4, 4),
(1, 1, '2017-11-13', 5, 5),
(1, 1, '2017-11-15', 1, 6),
(1, 1, '2017-11-15', 2, 7),
(3, 1, '2017-11-14', 1, 1),
(3, 1, '2017-11-14', 2, 2),
(3, 1, '2017-11-14', 3, 4),
(4, 1, '2017-10-22', 1, 8),
(4, 1, '2017-10-22', 2, 9),
(4, 1, '2017-11-13', 1, 10),
(4, 1, '2017-11-13', 2, 11),
(4, 1, '2017-11-13', 3, 12),
(4, 1, '2017-11-13', 4, 13),
(4, 1, '2017-11-13', 5, 14),
(5, 2, '2017-11-18', 14, 15),
(5, 2, '2017-11-18', 12, 28),
(5, 2, '2017-11-18', 18, 29),
(5, 2, '2017-11-18', 24, 30),
(9, 1, '2017-11-22', 1, 16),
(9, 1, '2017-11-22', 2, 9),
(9, 1, '2017-11-22', 3, 17);
