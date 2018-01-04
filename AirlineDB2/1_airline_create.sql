IF db_id('Airline2') IS NOT NULL
	USE master;
	GO
	ALTER DATABASE Airline2 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	GO
	DROP DATABASE Airline2
GO

CREATE DATABASE Airline2
GO

USE Airline2

CREATE TABLE AIRPORT (
	[Airport_code] CHAR(3) NOT NULL,
	[Name] NVARCHAR(255) NOT NULL,
	[City] NVARCHAR(255) NOT NULL,
	[State] NVARCHAR(255) NOT NULL,
	CONSTRAINT PK_airport PRIMARY KEY (Airport_code),
	CONSTRAINT CHK_airport_code CHECK(Airport_code LIKE '[A-Z][A-Z][A-Z]')
);

CREATE TABLE COMPANY (
	[Id] INT NOT NULL,
	[Name] NVARCHAR(255) NOT NULL,
	[Company_type] NVARCHAR(255) NOT NULL,
	CONSTRAINT PK_company PRIMARY KEY (Id),
	CONSTRAINT CHK_company_type CHECK(Company_type = 'Airplane' OR Company_type = 'Airline')
);

CREATE TABLE FLIGHT (
	[Flight_number] INT NOT NULL,
	[Company_id] INT NOT NULL,
	[Weekdays] NVARCHAR(255) NOT NULL,
	CONSTRAINT PK_flight PRIMARY KEY (Flight_number),
	CONSTRAINT CHK_weekdays CHECK(Weekdays LIKE '[0-7,]%'),
	CONSTRAINT FK_company FOREIGN KEY (Company_id) REFERENCES COMPANY(Id)
);


CREATE TABLE FLIGHT_LEG (
	[Flight_no] INT NOT NULL,
	[Leg_number] INT NOT NULL,
	[Departure_airport_code] CHAR(3) NOT NULL,
	[Scheduled_departure_time] TIME(0) NOT NULL,
	[Arrival_airport_code] CHAR(3) NOT NULL,
	[Scheduled_arrival_time] TIME(0) NOT NULL,
	[Km] INT NOT NULL,
	CONSTRAINT PK_flight_leg3 PRIMARY KEY (Flight_no,Leg_number),
	CONSTRAINT FK_flight_no3 FOREIGN KEY (Flight_no) REFERENCES FLIGHT(Flight_number),
	CONSTRAINT FK_departure_airport_code3 FOREIGN KEY (Departure_airport_code) REFERENCES AIRPORT(Airport_code),
	CONSTRAINT FK_arrival_airport_code3 FOREIGN KEY (Arrival_airport_code) REFERENCES AIRPORT(Airport_code),
	CONSTRAINT CHK_km CHECK (Km BETWEEN 0 AND 20050) -- distance of two points on earth surface cannot be more than ~20030 km
);

CREATE TABLE AIRPLANE_TYPE (
	[Airplane_type_name] NVARCHAR(255) NOT NULL,
	[Max_seats] INT NOT NULL,
	[Company_id] INT NOT NULL,
	CONSTRAINT PK_airplane_type PRIMARY KEY (Airplane_type_name),
	CONSTRAINT FK_company2 FOREIGN KEY (Company_id) REFERENCES COMPANY(Id)
);

CREATE TABLE AIRPLANE (
	[Airplane_id] NVARCHAR(8) NOT NULL,
	[Total_number_of_seats] INT NOT NULL,
	[Airplane_type] NVARCHAR(255) NOT NULL,
	CONSTRAINT PK_airplane PRIMARY KEY (Airplane_id),
	CONSTRAINT FK_airplane_type6 FOREIGN KEY (Airplane_type) REFERENCES AIRPLANE_TYPE(Airplane_type_name)
);

CREATE TABLE LEG_INSTANCE (
	[Flight_no] INT NOT NULL,
	[Leg_no] INT NOT NULL,
	[Date] DATE NOT NULL,
	[Number_of_available_seats] INT NOT NULL,
	[Airplane_id] NVARCHAR(8) NOT NULL,
	[Departure_airport_code] CHAR(3) NOT NULL,
	[Departure_time] SMALLDATETIME ,
	[Arrival_airport_code] CHAR(3),
	[Arrival_time] SMALLDATETIME ,
	CONSTRAINT PK_leg_instance PRIMARY KEY (Flight_no, Leg_no, [Date]),
	CONSTRAINT FK_flight_leg7 FOREIGN KEY (Flight_no, Leg_no) REFERENCES FLIGHT_LEG(Flight_no, Leg_number),
	CONSTRAINT FK_airplane_id7 FOREIGN KEY (Airplane_id) REFERENCES AIRPLANE(Airplane_id),
	CONSTRAINT FK_departure_airport_code7 FOREIGN KEY (Departure_airport_code) REFERENCES AIRPORT(Airport_code),
	CONSTRAINT FK_arrival_airport_code7 FOREIGN KEY (Arrival_airport_code) REFERENCES AIRPORT(Airport_code)
	--CONSTRAINT CHK_date CHECK(CAST([Date] AS DATE) > GETDATE()) --yeni eklenen kay?t geçmi? günlerden olmas?n
);

CREATE TABLE CAN_LAND (
	[Airplane_type_name] NVARCHAR(255) NOT NULL,
	[Airport_code] CHAR(3) NOT NULL,
	CONSTRAINT PK_can_land PRIMARY KEY (Airplane_type_name, Airport_code),
	CONSTRAINT FK_airplane_type_name8 FOREIGN KEY (Airplane_type_name) REFERENCES AIRPLANE_TYPE(Airplane_type_name),
	CONSTRAINT FK_airport_code8 FOREIGN KEY (Airport_code) REFERENCES AIRPORT(Airport_code)
);

CREATE TABLE CUSTOMER(
	[Id] INT NOT NULL,
	[Name] NVARCHAR(128) NOT NULL,
	[Phone] NVARCHAR(32) NOT NULL,
	[Email] NVARCHAR(255) NOT NULL,
	[Address] NVARCHAR(255) NOT NULL,
	[Country] NVARCHAR(64) NOT NULL,
	[Passport_number] INT NOT NULL,
	CONSTRAINT PK_customer PRIMARY KEY (Id),
	CONSTRAINT UQ_passport UNIQUE (Passport_number),
	CONSTRAINT CHK_passport_number CHECK (Passport_number BETWEEN 10000000 AND 99999999 ) --passport number must be 8 digits
);

CREATE TABLE FARE (
	[Flight_no] INT NOT NULL,
	[Fare_code] INT NOT NULL,
	[Amount] INT NOT NULL,
	[Restrictions] NVARCHAR(255),
	CONSTRAINT PK_fare PRIMARY KEY (Flight_no, Fare_code),
	CONSTRAINT FK_flight_no4 FOREIGN KEY (Flight_no) REFERENCES FLIGHT(Flight_number),
	CONSTRAINT CHK_amount CHECK(Amount > 10)
);

CREATE TABLE SEAT_RESERVATION (
	[Flight_no] INT NOT NULL,
	[Leg_no] INT NOT NULL,
	[Date] DATE NOT NULL,
	[Fare_code] INT NOT NULL,
	[Seat_number] INT NOT NULL,
	[Customer_id] INT NOT NULL,
	CONSTRAINT PK_seat_reservation PRIMARY KEY (Flight_no, Leg_no, [Date], Seat_number),
	CONSTRAINT FK_fno_lno_date9 FOREIGN KEY (Flight_no, Leg_no, [Date]) REFERENCES LEG_INSTANCE(Flight_no, Leg_no, [Date]),
	CONSTRAINT FK_fare FOREIGN KEY (Flight_no, Fare_code) REFERENCES FARE(Flight_no, Fare_code),
	CONSTRAINT FK_customer_id2 FOREIGN KEY (Customer_id) REFERENCES CUSTOMER(Id)
);

CREATE TABLE FFC (
	[Customer_id] INT NOT NULL,
	[Total_km] INT NOT NULL,
	CONSTRAINT PK_ffc PRIMARY KEY (Customer_id),
	CONSTRAINT FK_customer_id3 FOREIGN KEY (Customer_id) REFERENCES CUSTOMER(Id)
);