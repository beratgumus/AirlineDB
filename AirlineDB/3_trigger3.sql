-- uçak(lar) eklemeden önce uçakdaki koltuk sayısının, uçak modelinin koltuk 
-- sayısından fazla olmadığını kontrol edelim
-- bu trigger bir çoklu eklemeleri destekleyecek şekilde düzenlenmiştir
USE Airline1
GO

CREATE TRIGGER TRG_control_max_seats
        ON AIRPLANE
        INSTEAD OF INSERT
AS
BEGIN
	
	DECLARE @airplane_type_max_seats int;
	DECLARE @airplane_type nvarchar(255);
	DECLARE @airplane_seats int;
	DECLARE @i int;

	DECLARE airplane_cursor CURSOR 
	LOCAL STATIC READ_ONLY FORWARD_ONLY
	FOR 
	SELECT Total_number_of_seats, Airplane_type FROM inserted;

	OPEN airplane_cursor;
	FETCH NEXT FROM airplane_cursor INTO @airplane_seats, @airplane_type;

	SET @i = 1;
	WHILE @@FETCH_STATUS = 0
	BEGIN 
		SET @airplane_type_max_seats = 
		(
			SELECT Max_seats 
			FROM AIRPLANE_TYPE
			WHERE AIRPLANE_TYPE.Airplane_type_name = @airplane_type
		)
		
		--PRINT 'koltuk sayısı: ' + CAST(@airplane_seats AS NVARCHAR) 
		--	+ ', uçak tipi: ' + @airplane_type
		--	+ ', uçak tipinin maksimum koltuk sayısı ' + CAST(@airplane_type_max_seats AS NVARCHAR)

		IF( @airplane_seats > @airplane_type_max_seats )
		BEGIN
			DECLARE @ErrorMessage NVARCHAR(4000);
			SET @ErrorMessage = CAST(@i AS NVARCHAR)
				+ '. uçağın koltuk sayısı uçak modelinin koltuk sayısından büyük olamaz. ('
				+ CAST(@airplane_seats AS NVARCHAR) + ' > ' + CAST(@airplane_type_max_seats AS NVARCHAR) + ')';
			RAISERROR(@ErrorMessage, 18, -1);
			RETURN;
		END
		ELSE
		BEGIN
			FETCH NEXT FROM airplane_cursor INTO @airplane_seats, @airplane_type;
			SET @i = @i + 1;
		END

	END
	CLOSE airplane_cursor;
	DEALLOCATE airplane_cursor;


	INSERT INTO AIRPLANE
	SELECT * FROM inserted;
	
	SET @i = @i - 1;
	PRINT CAST(@i AS VARCHAR) + ' uçak başarılı bir şekilde eklendi!';

END