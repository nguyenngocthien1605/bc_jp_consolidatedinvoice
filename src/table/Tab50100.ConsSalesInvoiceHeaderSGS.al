table 50100 "Cons Sales Invoice Header SGS"
{
    Caption = 'Consolidated Sales Invoice Header';

    DrillDownPageID = "Cons Sales Invoice SGS";
    LookupPageID = "Cons Sales Invoice SGS";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }

        field(2; "From Date"; Date)
        {
            Caption = 'From Date';
        }

        field(3; "To Date"; Date)
        {
            Caption = 'To Date';
        }



        field(100; "Cons Invoice Total Amount"; Decimal)
        {
            Caption = 'Cons Invoice Total Amount';
            TableRelation = "Cons Sales Invoice Line SGS";
            AutoFormatType = 1;
            AutoFormatExpression = '';
            CalcFormula = Sum("Cons Sales Invoice Line SGS"."Child Sales Invoice Amount" WHERE("Document No." = field("No.")));
            FieldClass = FlowField;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }






}