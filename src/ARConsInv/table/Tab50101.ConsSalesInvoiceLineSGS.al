table 50101 "Cons Sales Invoice Line SGS"
{

    fields
    {


        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Cons Sales Invoice Header SGS";

        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }

        field(20; "Child Sales Invoice"; Code[20])
        {
            Caption = 'Child Sales Invoice';
            TableRelation = "Sales Invoice Header";

        }

        field(21; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."Posting Date" where("No." = field("Child Sales Invoice")));
        }

        field(22; "Due Date"; Date)
        {
            Caption = 'Due Date';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."Due Date" where("No." = field("Child Sales Invoice")));
        }

        field(30; "Child Sales Invoice Amount"; Decimal)
        {
            Caption = 'Child Sales Invoice Amount';
            FieldClass = FlowField;
            //AutoFormatType = 1;
            //AutoFormatExpression = '';
            CalcFormula = Sum("Sales Invoice Line"."Amount Including VAT" WHERE("Document No." = field("Child Sales Invoice")));

        }





    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    // var
    //     myInt: Integer;

    // trigger OnInsert()
    // begin

    // end;

    // trigger OnModify()
    // begin

    // end;

    // trigger OnDelete()
    // begin

    // end;

    // trigger OnRename()
    // begin

    // end;

}