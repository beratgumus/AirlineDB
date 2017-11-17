INSERT INTO AIRPORT (Airport_code, Name, City, State) 
VALUES 
(3501, 'Adnan Menderes Havalimanı', 'İzmir', 'Türkiye'),
(3402, 'Atatürk Havalimanı', 'İstanbul', 'Türkiye');


INSERT INTO FLIGHT (Flight_number, Airline, Weekdays) 
VALUES 
(1, 'Türk Hava Yolları', '1,2,3,4,5');


INSERT INTO FLIGHT_LEG (Flight_no, Leg_number, Departure_airport_code, Scheduled_departure_time,
	Arrival_airport_code, Scheduled_arrival_time) 
VALUES 
(1, 1, 3501, '10:00', 3402, '10:45'),
(1, 2, 3402, '12:15', 3501, '13:00');

INSERT INTO FARE (Flight_no, Fare_code, Amount, Restrictions)
VALUES
(1, 1, 75, NULL),
(1, 2, 130, NULL),
(1, 3, 250, NULL);

-- Source: https://tr.wikipedia.org/wiki/T%C3%BCrk_Hava_Yollar%C4%B1
INSERT INTO AIRPLANE_TYPE (Airplane_type_name, Max_seats, Company)
VALUES
('Airbus A320-200', 153, 'Airbus S.A.S'),
('Airbus A321-200', 188, 'Airbus S.A.S'),
('Airbus A330-200', 250, 'Airbus S.A.S'),
('Boeing 737-800', 165, 'Boeing');

INSERT INTO AIRPLANE (Airplane_id, Total_number_of_seats, Airplane_type)
VALUES
(1, 150, 'Airbus A320-200'),
(2, 188, 'Airbus A321-200'),
(3, 179, 'Airbus A321-200'),
(4, 165, 'Boeing 737-800');



