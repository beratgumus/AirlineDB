use Airline1
GO
-- Flight no 1 olan ucuslardaki bileet fiyatlarini %20 arttir
Update FARE
SET	Amount=Amount*1.20
WHERE	Flight_no=1

-- Flight no 6 olan ucusun gununu pazartesiden carsambaya cek
Update FLIGHT
SET		Weekdays=3
WHERE	Flight_number=6

-- Flight no 2, leg no 1 olan ucusun planlann kalkis ve inis saatlerini 1 saat ileri alan update
Update FLIGHT_LEG
SET		Scheduled_departure_time=DATEADD(MINUTE,60,Scheduled_departure_time)
		, Scheduled_arrival_time=DATEADD(MINUTE,60,Scheduled_arrival_time)
WHERE	Flight_no=2 AND Leg_number=1