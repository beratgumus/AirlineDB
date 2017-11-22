USE Airline1
INSERT INTO AIRPORT (Airport_code, Name, City, State) 
VALUES 
('ADB', 'Adnan Menderes Havalimanı', 'İzmir', 'Türkiye'),
('IST', 'Atatürk Havalimanı', 'İstanbul', 'Türkiye'),
('ESB', 'Esenboğa Havalimanı', 'Ankara', 'Türkiye'),
('NRT', 'Narita International Airport', 'Tokyo', 'Japan'),
('YXU', 'London International Airport', 'Ontario', 'London');


INSERT INTO FLIGHT (Flight_number, Airline, Weekdays) 
VALUES 
(1, 'Türk Hava Yolları', '1,2,3,4,5'), -- izmir -> istanbul | aktarmasız | akşam
(2, 'Türk Hava Yolları', '1,2,3,4,5,6,7'), -- izmir -> istanbul | aktarmasız | sabah
(3, 'Türk Hava Yolları', '1,2,3,4,5'), -- istanbul -> izmir | aktarmasız | öğlen
(4, 'Türk Hava Yolları', '1,5'), -- istanbul -> tokyo | aktarmasız | gece
(5, 'Türk Hava Yolları', '5'), -- izmir -> tokyo | aktarmalı | sabah + 1 gün
(6, 'Alamet Havayolları', '1'),
(7, 'Alamet Havayolları', '2');


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
(7, 1, 'ADB', '07:10', 'IST', '08:00');

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
(7, 1, 35, NULL);

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
(1, 150, 'Airbus A320-200'),
(2, 188, 'Airbus A321-200'),
(3, 179, 'Airbus A321-200'),
(4, 165, 'Boeing 737-800'),
(5, 245, 'Airbus A330-200'),
(6, 165, 'Boeing 737-800'),
(7, 151, 'Boeing 737-900ER'),
(8, 149, 'Boeing 737-900ER'),
(9, 153, 'Airbus A320-200'),
(10, 250, 'Airbus A330-200');


INSERT INTO CAN_LAND (Airplane_type_name, Airport_code)
VALUES
('Airbus A320-200', 'ADB'), -- Airbus A320-200
('Airbus A320-200', 'IST'),
('Airbus A320-200', 'ESB'),
('Airbus A321-200', 'ADB'), -- Airbus A321-200 | tüm havaalanları
('Airbus A321-200', 'IST'),
('Airbus A321-200', 'ESB'),
('Airbus A321-200', 'NRT'),
('Airbus A321-200', 'YXU'),
('Airbus A330-200', 'ADB'), -- Airbus A330-200
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
(1,1,'2017-11-13',15,1,'ADB','2017-11-13 21:53','IST','2017-11-13 23:04'), -- Planlanan havada kalma suresinden daha az surede ucusu tamamladi, -4 dk
(1,1,'2017-11-14',17,1,'ADB','2017-11-14 21:50','IST','2017-11-14 23:05'), -- Rotarsiz, tam zamanlama
(1,1,'2017-11-15',22,4,'ADB','2017-11-15 22:22','IST','2017-11-15 23:34'), -- 32 dk Rotarli
(2,1,'2017-11-13',14,1,'ADB','2017-11-13 10:51','IST','2017-11-13 12:20'), -- Planlanan havada kalma suresinden daha fazla surede ucusu tamamladi, +9 dk
(2,1,'2017-11-15',100,4,'ADB','2017-11-15 10:50','IST','2017-11-15 12:10'),  -- Doluluk orani %50 den az
(3,1,'2017-11-14',6,3,'IST','2017-11-14 12:15','ADB','2017-11-14 13:00'),
(3,1,'2017-11-15',7,4,'IST','2017-11-15 12:18','ADB','2017-11-15 13:07'),
(4,1,'2017-11-13',11,5,'IST','2017-11-13 02:28','NRT','2017-11-13 20:10'), -- Uluslar arasi ucus
(4,1,'2017-11-17',6,5,'IST','2017-11-17 02:17','NRT','2017-11-17 19:58'),
(5,1,'2017-11-17',6,5,'ADB','2017-11-17 21:50','IST','2017-11-17 23:05'),  -- izmir -> tokyo part1
(5,2,'2017-11-18',13,5,'IST','2017-11-18 02:19','NRT','2017-11-18 19:59'), -- izmir -> tokyo part2, +1
(6,1,'2023-11-18',153,9,'IST',null, null, null), -- alamet havayolları
(7,1,'2023-11-18',153,9,'ADB', null, null, null);


INSERT INTO SEAT_RESERVATION (Flight_no, Leg_no, Date, Seat_number, Customer_name, Customer_phone)
VALUES
(1, 1, '2017-11-13', 1, 'Mehmet Okumuş', '+905551112222'),
(1, 1, '2017-11-13', 2, 'Melis Okumuş', '+905001002000'),
(1, 1, '2017-11-13', 3, 'Merve Konuk', '+905108889999'),
(1, 1, '2017-11-13', 4, 'Burcu Gün', '+905001002001'),
(1, 1, '2017-11-13', 5, 'Sema Okumamış ', '+905001502002'),
(1, 1, '2017-11-13', 6, 'Tarkan Altınbaş', '+905531119090'),
(1, 1, '2017-11-13', 7, 'Tuncay Şanlı', '+905119897777'),
(3, 1, '2017-11-14', 1, 'Mehmet Okumuş', '+905551112222'),
(3, 1, '2017-11-14', 2, 'Melis Okumuş', '+905001002000'),
(3, 1, '2017-11-14', 3, 'Tarkan Altınbaş', '+905536669090'),
(4, 1, '2017-11-13', 1, 'Canberk Kara', '+9055612345678'),
(4, 1, '2017-11-13', 2, 'Melis Elibol', '+812083438802'),
(4, 1, '2017-11-13', 3, 'Hiroto Miyamoto', '+812083438662'),
(4, 1, '2017-11-13', 4, 'Hosuzu Miyamoto', '+812055558801'),
(4, 1, '2017-11-13', 5, 'Asuka Miyamoto', '+812055558801'),
(4, 1, '2017-11-13', 6, 'Mert Akıncılar', '+905519890012'),
(4, 1, '2017-11-13', 7, 'Rana Altıparmak', '+905519890012'),
(5, 2, '2017-11-18', 14, 'Selim Gezgin', '+905532221144');