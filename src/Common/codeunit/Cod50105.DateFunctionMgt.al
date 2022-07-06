codeunit 50105 "Date Function Mgt"
{
    Subtype = Normal;

    procedure getDueDateByPaymentDayandCutoffDay(PaymentTerm: Record "Payment Terms"; consDate: Date): Date
    var
        consDate_Day, consDate_Month, dueDate_Month : Integer;
        paymentDay, cutoffDay : Integer;
        dueDate: Date;
        isNextWorkingDay: Boolean;
    begin
        consDate_Day := Date2DMY(consDate, 1);
        consDate_Month := Date2DMY(consDate, 2);

        cutoffDay := PaymentTerm."CutOff Day";
        paymentDay := PaymentTerm."Payment Day";

        if ((cutoffDay > 0) and (paymentDay > 0)) then begin
            if (consDate_Day <= cutoffDay) then begin
                dueDate_Month := consDate_Month + 1;
            end
            else begin
                dueDate_Month := consDate_Month + 2;
            end;

            if (PaymentTerm."Cons. Due Date Calculate" = "Cons. Due Date Calculate"::"Next Working Day") then begin
                isNextWorkingDay := true;
            end
            else begin
                isNextWorkingDay := false;
            end;

            dueDate := getBusinessDate(DMY2Date(paymentDay, dueDate_Month, Date2DMY(consDate, 3)), isNextWorkingDay);

            exit(dueDate);
        end
        else begin

            exit(consDate); // return consDate if not using paymentDay and cutoff day 

        end;
        ;





    end;



    procedure getBusinessDate(checkDate: Date; isNextWorkingDate: boolean): Date
    var
        businessDate: Date;
        CalendarMgmt: Codeunit "Calendar Management";
        CompanyInformation: Record "Company Information";
        CustomCalendarChange: Record "Customized Calendar Change";
        IsNonworkingDay: Boolean;
    begin
        CompanyInformation.Get();
        CompanyInformation.TESTFIELD("Base Calendar Code");

        // CustomCalendarChange.Find('-');
        CalendarMgmt.SetSource(CompanyInformation, CustomCalendarChange);
        businessDate := checkDate;

        repeat begin
            IsNonworkingDay := CalendarMgmt.IsNonworkingDay(businessDate, CustomCalendarChange);
            if (IsNonworkingDay = true) then begin
                if (isNextWorkingDate = true) then begin
                    businessDate := CalcDate('<+1D>', businessDate); // next day
                end
                else begin
                    businessDate := CalcDate('<-1D>', businessDate); // previous day
                end;
                ;
            end;

        end until (IsNonworkingDay = false); // exit when businessDate is working day

        exit(businessDate);
    end;

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
