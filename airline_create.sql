CREATE TABLE AIRPORT (
	Airport_code INT NOT NULL,
	Name VARCHAR(255) NOT NULL,
	City VARCHAR(255) NOT NULL,
	State VARCHAR(255) NOT NULL,
	CONSTRAINT PK_airport PRIMARY KEY (Airport_code)
);

CREATE TABLE FLIGHT (
	Flight_number INT NOT NULL,
	Airline VARCHAR(255) NOT NULL,
	Weekdays VARCHAR(255) NOT NULL,
	CONSTRAINT PK_flight PRIMARY KEY (Flight_number)
);

CREATE TABLE FLIGHT_LEG (
	Flight_no INT NOT NULL,
	Leg_number INT NOT NULL,
	Departure_airport_code INT NOT NULL,
	Scheduled_departure_time DATETIME NOT NULL,
	Arrival_airport_code INT NOT NULL,
	Scheduled_arrival_time DATETIME NOT NULL,
	CONSTRAINT PK_flight_leg PRIMARY KEY (Flight_no,Leg_number),
	CONSTRAINT FK_flight_no FOREIGN KEY (Flight_no) REFERENCES FLIGHT(Flight_number),
	CONSTRAINT FK_departure_airport_code FOREIGN KEY (Departure_airport_code) REFERENCES AIRPORT(Airport_code),
	CONSTRAINT FK_arrival_airport_code FOREIGN KEY (Arrival_airport_code) REFERENCES AIRPORT(Airport_code)
);

CREATE TABLE FARE (
	Flight_no INT NOT NULL,
	Fare_code INT NOT NULL,
	Amount INT NOT NULL,
	Restrictions VARCHAR(255),
	CONSTRAINT PK_fare PRIMARY KEY (Flight_no, Fare_code),
	CONSTRAINT FK_flight_no FOREIGN KEY (Flight_no) REFERENCES FLIGHT(Flight_number)
);

CREATE TABLE AIRPLANE_TYPE (
	Airplane_type_name VARCHAR(255) NOT NULL,
	Max_seats INT NOT NULL,
	Company VARCHAR(255) NOT NULL,
	CONSTRAINT PK_airplane_type PRIMARY KEY (Airplane_type_name)
);

CREATE TABLE AIRPLANE (
	Airplane_id  INT NOT NULL,
	Total_number_of_seats INT NOT NULL,
	Airplane_type VARCHAR(255) NOT NULL,
	CONSTRAINT PK_airplane PRIMARY KEY (Airplane_id),
	CONSTRAINT FK_airplane_type FOREIGN KEY (Airplane_type) REFERENCES AIRPLANE_TYPE(Airplane_type_name)
);

CREATE TABLE LEG_INSTANCE (
	Flight_no INT NOT NULL,
	Leg_no INT NOT NULL,
	[Date] DATE NOT NULL,
	Number_of_available_seats INT NOT NULL,
	Airplane_id INT NOT NULL,
	Departure_airport_code INT NOT NULL,
	Departure_time DATETIME NOT NULL,
	Arrival_airport_code INT NOT NULL,
	Arrival_time DATETIME NOT NULL,
	CONSTRAINT PK_leg_instance PRIMARY KEY (Flight_no, Leg_no, [Date]),
	CONSTRAINT FK_flight_leg FOREIGN KEY (Flight_no, Leg_no) REFERENCES FLIGHT_LEG(Flight_number, Leg_number),
	CONSTRAINT FK_airplane_id FOREIGN KEY (Airplane_id) REFERENCES AIRPLANE(Airplane_id),
	CONSTRAINT FK_departure_airport_code FOREIGN KEY (Departure_airport_code) REFERENCES AIRPORT(Airport_code),
	CONSTRAINT FK_arrival_airport_code FOREIGN KEY (Arrival_airport_code) REFERENCES AIRPORT(Airport_code)
);

CREATE TABLE CAN_LAND (
	Airplane_type_name VARCHAR(255) NOT NULL,
	Airport_code INT NOT NULL,
	CONSTRAINT PK_can_land PRIMARY KEY (Airplane_type_name, Airport_code),
	CONSTRAINT FK_airplane_type_name FOREIGN KEY (Airplane_type_name) REFERENCES AIRPLANE_TYPE(Airplane_type_name),
	CONSTRAINT FK_airport_code FOREIGN KEY (Airport_code) REFERENCES AIRPORT(Airport_code)
)

CREATE TABLE SEAT_RESERVATION (
	Flight_no INT NOT NULL,
	Leg_no INT NOT NULL,
	[Date] DATE NOT NULL,
	Seat_number INT NOT NULL,
	Customer_name VARCHAR(255) NOT NULL,
	Customer_phone VARCHAR(255) NOT NULL,
	CONSTRAINT PK_seat_reservation PRIMARY KEY (Flight_no, Leg_no, [Date], Seat_number),
	CONSTRAINT FK_fno_lno_date FOREIGN KEY (Flight_no, Leg_no, [Date]) REFERENCES LEG_INSTANCE(Flight_no, Leg_no, [Date])
);