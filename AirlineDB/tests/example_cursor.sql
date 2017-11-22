-- cursor kullanımı için bir örnek.
-- bir tablonun her satırı için işlem yapılacağında kullanılıyor. (döngü)
-- Bu kod tüm airport code'larını listeler

USE Airline1
GO

-- airport kodlarını tutacak geçici değişkenimiz
DECLARE @airportcode nchar(3);

-- satırları gezmek için kullanacağımız cursor'umuz
DECLARE airport_cursor CURSOR 
LOCAL STATIC READ_ONLY FORWARD_ONLY
FOR 
SELECT Airport_code FROM AIRPORT; 
-- SELECT kısmı ile cursorun gösterdiği satırın hangi sütunlarını seçeceğimizi belirledik
-- bkz. FETCH NEXT FROM

-- cursoru aktifleştirelim
OPEN airport_cursor;

-- cursorun gösterdiği satırdaki veriyi alalım (ilk satır)
FETCH NEXT FROM airport_cursor INTO @airportcode;

-- döngümüzü başlatalım
WHILE @@FETCH_STATUS = 0
BEGIN
	-- az önce aldığımız veriyi yazdıralım
	PRINT @airportcode;

	-- bir sonraki veriyi alalım
	FETCH NEXT FROM airport_cursor INTO @airportcode;
END

CLOSE airport_cursor;
DEALLOCATE airport_cursor;