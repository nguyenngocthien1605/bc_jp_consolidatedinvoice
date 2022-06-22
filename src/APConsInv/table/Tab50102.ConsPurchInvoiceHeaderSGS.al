table 50102 "Cons Purch Invoice Header SGS"
{
    Caption = 'Consolidated Purchase Invoice Header';

    DrillDownPageID = "Cons Purch Invoice Card SGS";
    LookupPageID = "Cons Purch Invoice Card SGS";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    PurchSetup.Get();
                    NoSeriesMgt.TestManual(PurchSetup."Consolidated Invoice No.");
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

        field(10; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = "Vendor";
            trigger OnValidate()
            var
                localVendor: Record "Vendor";
                currentWorkDay, currentWorkMonth, currentWorkYear, consDay : Integer;
                strDateExp: Text[30];
            begin



                if ("Consolidate Date" = 0D) AND ("Vendor No." <> '') then begin
                    localVendor.Get(rec."Vendor No.");
                    consDay := localVendor."Consolidate Day";
                    currentWorkDay := System.Date2DMY(WorkDate(), 1);
                    currentWorkMonth := System.Date2DMY(WorkDate(), 2);
                    currentWorkYear := System.Date2DMY(WorkDate(), 3);

                    if consDay = 0 then begin
                        Error('The customer %1 is not enabled for consolidated invoice.', rec."Vendor No.");
                    end;


                    if consDay < currentWorkDay then begin

                        rec."Consolidate Date" := getDate(consDay, currentWorkMonth + 1, currentWorkYear);


                    end else begin

                        rec."Consolidate Date" := getDate(consDay, currentWorkMonth, currentWorkYear);

                    end;
                end;
            end;



        }

        // field(20; "From Date"; Date)
        // {
        //     Caption = 'From Date';
        // }

        field(30; "Consolidate Date"; Date)
        {
            Caption = 'Consolidate Date';
        }

        field(40; "Due Date"; Date)
        {
            Caption = 'Due Date (Cons. Inv)';
        }


        field(90; "Status"; Enum ConsStatus)
        {
            Caption = 'Status';
            InitValue = "Un-Confirmed";
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
            PurchSetup.Get();
            PurchSetup.TestField("Consolidated Invoice No.");
            NoSeriesMgt.InitSeries(PurchSetup."Consolidated Invoice No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
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
