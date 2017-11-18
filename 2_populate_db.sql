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
(5, 'Türk Hava Yolları', '5'); -- izmir -> tokyo | aktarmalı | sabah + 1 gün


INSERT INTO FLIGHT_LEG (Flight_no, Leg_number, Departure_airport_code, Scheduled_departure_time,
	Arrival_airport_code, Scheduled_arrival_time) 
VALUES 
(1, 1, 'ADB', '21:50', 'IST', '23:05'),
(2, 1, 'ADB', '10:50', 'IST', '12:10'),
(3, 1, 'IST', '12:15', 'ADB', '13:00'),
(4, 1, 'IST', '02:10', 'NRT', '19:50'),
(5, 1, 'ADB', '21:50', 'IST', '23:05'), -- izmir -> tokyo part1
(5, 2, 'IST', '02:10', 'NRT', '19:50'); -- izmir -> tokyo part2


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
(5, 2, 3000, NULL);

-- Source: https://tr.wikipedia.org/wiki/T%C3%BCrk_Hava_Yollar%C4%B1
INSERT INTO AIRPLANE_TYPE (Airplane_type_name, Max_seats, Company)
VALUES
('Airbus A320-200', 153, 'Airbus S.A.S'),
('Airbus A321-200', 188, 'Airbus S.A.S'),
('Airbus A330-200', 250, 'Airbus S.A.S'),
('Boeing 737-800', 165, 'Boeing'),
('Boeing 737-900ER', 151, 'Boeing');

INSERT INTO AIRPLANE (Airplane_id, Total_number_of_seats, Airplane_type)
VALUES
(1, 150, 'Airbus A320-200'),
(2, 188, 'Airbus A321-200'),
(3, 179, 'Airbus A321-200'),
(4, 165, 'Boeing 737-800');

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
('Boeing 737-900ER', 'YXU');