Create Function dbo.fnDateTable
(
  @StartDate datetime,
  @EndDate datetime,
  @DayPart char(5) -- support 'day','month','year','hour', default 'day'
)
Returns @Result Table
(
  [Date] datetime
)
As
Begin
  Declare @CurrentDate datetime
  Set @CurrentDate=@StartDate
  While @CurrentDate<=@EndDate
  Begin
    Insert Into @Result Values (@CurrentDate)
    Select @CurrentDate=
    Case
    When @DayPart='year' Then DateAdd(yy,1,@CurrentDate)
    When @DayPart='month' Then DateAdd(mm,1,@CurrentDate)
    When @DayPart='hour' Then DateAdd(hh,1,@CurrentDate)
    Else
      DateAdd(dd,1,@CurrentDate)
    End
  End
  Return
End


DROP TABLE [Time]
CREATE TABLE [Time]
(PK_Date date PRIMARY KEY,
Date_Name varchar(30),
[Year] int,
Year_Name varchar(30),
Day_Of_Year int,
Day_Of_Year_Name varchar(30)
)

DECLARE @Date date
SET @Date = '19400101'
WHILE @Date < CONVERT(DATE, GETDATE())
BEGIN
INSERT INTO [Time] (PK_Date, Date_Name, [Year], Year_Name, Day_Of_Year, Day_Of_Year_Name)
VALUES (@Date, 'Calendar ' + CONVERT(VARCHAR(20), @Date), DATEPART(YEAR, @Date), 
		'Calendar ' + CAST(DATEPART(YEAR, @Date) AS VARCHAR(10)), DATEPART(DAYOFYEAR, @Date),
		CAST(DATEPART(DAYOFYEAR, @Date) AS VARCHAR(10)) + ' of ' + 'Calendar ' + CAST(DATEPART(YEAR, @Date) AS VARCHAR(10)))
SET @Date = CONVERT(DATE, DATEADD(dd, 1, @Date))
END
