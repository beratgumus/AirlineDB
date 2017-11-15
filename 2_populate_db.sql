INSERT INTO AIRPORT (Airport_code, Name, City, State) 
VALUES 
(3501, 'Adnan Menderes Havalimanı', 'İzmir', 'Türkiye'),
(3402, 'Atatürk Havalimanı', 'İstanbul', 'Türkiye');


INSERT INTO FLIGHT (Flight_number, Airline, Weekdays) 
VALUES 
(1, 'Türk Hava Yolları', '1-1-1-1-1-0-0');


INSERT INTO FLIGHT_LEG(Flight_no, Leg_number, Departure_airport_code, Scheduled_departure_time,
	Arrival_airport_code, Scheduled_arrival_time) 
VALUES 
(1, 1, 3501, '10:00', 3402, '10:45');
