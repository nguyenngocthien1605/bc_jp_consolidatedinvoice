codeunit 50105 "Date Function Mgt"
{
    Subtype = Normal;


    procedure getLastBusinessDate(Day: Integer; Month: Integer; Year: Integer): Date
    var
        lastDate, checkDate : Date;
        CalendarMgmt: Codeunit "Calendar Management";
        CompanyInformation: Record "Company Information";
        CustomCalendarChange: Record "Customized Calendar Change";
        IsNonworkingDay: Boolean;
    begin
        lastDate := CalcDate('<CM>', DMY2Date(1, Month, Year));
        if (Date2DWY(lastDate, 1) = 6) then begin
            lastDate := CalcDate('<+2D>', lastDate);
        end;
        if (Date2DWY(lastDate, 1) = 7) then begin
            lastDate := CalcDate('<+1D>', lastDate);
        end;

        CompanyInformation.Get();
        CompanyInformation.TESTFIELD("Base Calendar Code");


        // CustomCalendarChange.Find('-');
        CalendarMgmt.SetSource(CompanyInformation, CustomCalendarChange);
        checkDate := lastDate;

        repeat begin
            IsNonworkingDay := CalendarMgmt.IsNonworkingDay(checkDate, CustomCalendarChange);
            if (IsNonworkingDay = true) then begin
                checkDate := CalcDate('<+1D>', checkDate); // increase 1 day
            end;

        end until (IsNonworkingDay = false); // exit when checkDate is working day

        exit(checkDate);

    end;

}
