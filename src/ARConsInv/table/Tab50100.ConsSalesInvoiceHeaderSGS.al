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

                if ("Consolidate Date" = 0D) AND ("Customer No." <> '') then begin
                    localCustomer.Get(rec."Customer No.");
                    consDay := localCustomer."Consolidate Day";
                    // currentWorkDay := System.Date2DMY(WorkDate(), 1);
                    // currentWorkMonth := System.Date2DMY(WorkDate(), 2);
                    // currentWorkYear := System.Date2DMY(WorkDate(), 3);

                    rec."Payment Terms" := localCustomer."Payment Terms Code";
                    if consDay = 0 then begin
                        Error('The customer %1 is not enabled for consolidated invoice.', rec."Customer No.");
                    end;


                end;
            end;



        }



        field(30; "Consolidate Date"; Date)
        {
            Caption = 'Consolidate Date';
            trigger OnValidate()
            var
                confirmReConsolidate: Boolean;
                Text000: Label 'Do you want to re-consolidate this invoice %1 with new consolidated date %2?';
                invoiceCodeUnitMgt: Codeunit "Cons Sales Invoices Mgt SGS";
            begin
                if ((rec.Status = ConsStatus::Confirmed) and (rec."Consolidate Date" <> xRec."Consolidate Date")) then begin
                    confirmReConsolidate := Dialog.Confirm(Text000, true, rec."No.", rec."Consolidate Date");
                    if (confirmReConsolidate = true) then begin
                        invoiceCodeUnitMgt.UnConfirm(rec);
                        invoiceCodeUnitMgt.Confirm(rec);
                    end;

                end;


            end;
        }

        field(40; "Due Date"; Date)
        {
            Caption = 'Due Date (Cons. Inv)';
        }


        field(50; "Payment Terms"; Code[10])
        {
            Caption = 'Payment Terms';
            TableRelation = "Payment Terms";
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
            SalesSetup.Get();
            SalesSetup.TestField("Consolidated Invoice No.");
            NoSeriesMgt.InitSeries(SalesSetup."Consolidated Invoice No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;



}
