USE schoolDW
GO

Declare @StartDate date;
Declare @EndDate date;

--SELECT @StartDate = '1980-01-01', @EndDate = '2016-12-31';
SELECT @StartDate = '1960-12-01', @EndDate = '2025-01-30';

Declare @CurrentDate Date = @StartDate


While @CurrentDate <= @EndDate
	Begin

	    Declare @LastDayOfMonth date;
        Declare @LastWorkingDayOfMonth date;

        -- Find the last day of the month
        SET @LastDayOfMonth = EOMONTH(@CurrentDate);

        -- Find the last working day of the month
        SET @LastWorkingDayOfMonth = @LastDayOfMonth;
        WHILE DATEPART(dw, @LastWorkingDayOfMonth) IN (1,7)
            SET @LastWorkingDayOfMonth = DATEADD(d, -1, @LastWorkingDayOfMonth);

		INSERT INTO DimDate
		(
			[Date],
			[Year],
			[Month],
			MonthNumber,

			DayNumber,
			[DayOfWeek],
			DayOfWeekNumber,
			WorkingDay,

			ExamDay
		)
		Values
		(
			@CurrentDate,
			Cast( Year(@CurrentDate) as varchar(4)),
			Cast( DATENAME(month, @CurrentDate) as varchar(10)),
			Cast( Month(@CurrentDate) as int),

			Cast( DATEPART(day,@CurrentDate) as int),
			Cast( DATENAME(dw, @CurrentDate) as varchar(15)),
			Cast( DATEPART(dw, @CurrentDate) as int),
			CASE
				WHEN DATEPART(dw, @CurrentDate) IN (1,7) THEN 'day off'
				ELSE 'working day'
			END,
			CASE
                WHEN @CurrentDate = @LastWorkingDayOfMonth THEN 'Yes'
                ELSE 'No'
            END

		)
		Set @CurrentDate = DateAdd(d, 1, @CurrentDate);
	End


SELECT * FROM DimDate
