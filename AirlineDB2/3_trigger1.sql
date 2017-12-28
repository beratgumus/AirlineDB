USE Airline2
GO

DROP TRIGGER IF EXISTS [dbo].[TRG_control_company]
GO

CREATE TRIGGER TRG_control_company
        ON FLIGHT
        INSTEAD OF INSERT
AS
BEGIN

	DECLARE @company_id int;
	SELECT @company_id = Company_id FROM inserted;
	
	DECLARE @company_type nvarchar(10);

	SELECT @company_type = C.Company_type
		FROM COMPANY as C
		WHERE C.Id = @company_id;

	IF( @company_type = 'Airline' )
		INSERT INTO FLIGHT
		SELECT * FROM inserted;
	ELSE
		RAISERROR('You cant select an airplane company for flights. Select an airline company instead.', 16, 1)
		--PRINT 'You cant select an airplane company for flights. Select an airline company instead.';

END