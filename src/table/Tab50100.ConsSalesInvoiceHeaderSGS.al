table 50100 "Cons Sales Invoice Header SGS"
{
    Caption = 'Consolidated Sales Invoice Header';

    DrillDownPageID = "Cons Sales Invoice Card SGS";
    LookupPageID = "Cons Sales Invoice Card SGS";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get();
                    NoSeriesMgt.TestManual(SalesSetup."Consolidated Invoice No.");
                    "No. Series" := '';

                end;
            end;
        }

        field(2; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }

        field(10; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = "Customer";
            trigger OnValidate()
            var
                localCustomer: Record "Customer";
                currentWorkDay, currentWorkMonth, currentWorkYear, consDay : Integer;
                strDateExp: Text[30];
            begin



                if ("From Date" = 0D) and ("To Date" = 0D) AND ("Customer No." <> '') then begin
                    localCustomer.Get(rec."Customer No.");
                    consDay := localCustomer."Consolidate Day";
                    currentWorkDay := System.Date2DMY(WorkDate(), 1);
                    currentWorkMonth := System.Date2DMY(WorkDate(), 2);
                    currentWorkYear := System.Date2DMY(WorkDate(), 3);




                    if consDay = 0 then begin
                        Error('The customer %1 is not enabled for consolidated invoice.', rec."Customer No.");
                    end;


                    if consDay < currentWorkDay then begin
                        // strDateExp := '<-CM+' + Format(consDay) + 'D>';
                        // rec."From Date" := CalcDate(strDateExp, WorkDate());
                        // strDateExp := '<-CM+1M+' + Format(consDay) + 'D>';
                        // rec."To Date" := CalcDate(strDateExp, WorkDate());

                        rec."From Date" := getDate(consDay, currentWorkMonth, currentWorkYear);
                        rec."To Date" := getDate(consDay, currentWorkMonth + 1, currentWorkYear);


                    end else begin
                        // strDateExp := '<-CM-1M+' + Format(consDay) + 'D>';
                        // rec."From Date" := CalcDate(strDateExp, WorkDate());
                        // strDateExp := '<-CM+' + Format(consDay) + 'D>';
                        // rec."To Date" := CalcDate(strDateExp, WorkDate());
                        rec."From Date" := getDate(consDay, currentWorkMonth - 1, currentWorkYear);
                        rec."To Date" := getDate(consDay, currentWorkMonth, currentWorkYear);

                    end;
                end;
            end;



        }

        field(20; "From Date"; Date)
        {
            Caption = 'From Date';
        }

        field(30; "To Date"; Date)
        {
            Caption = 'To Date';
        }


    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()

    begin
        if "No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField("Consolidated Invoice No.");
            NoSeriesMgt.InitSeries(SalesSetup."Consolidated Invoice No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    local procedure getDate(Day: Integer; Month: Integer; Year: Integer): Date
    var

    begin
        if (Day in [30, 31]) and (Month = 2) then begin
            exit(CalcDate('<CM>', DMY2Date(1, Month, Year)));

        end;

        if (Day = 31) and (Month in [4, 6, 9, 11]) then begin
            exit(DMY2Date(30, Month, Year));
        end;

        exit(DMY2Date(Day, Month, Year));
    end;

}