table 50103 "Cons Purch Invoice Line SGS"
{


    fields
    {


        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Cons Purch Invoice Header SGS";

        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }

        field(20; "Child Purch Invoice"; Code[20])
        {
            Caption = 'Child Purchase Invoice';
            TableRelation = "Purch. Inv. Header";

        }

        field(21; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Inv. Header"."Posting Date" where("No." = field("Child Purch Invoice")));
        }

        field(22; "Due Date"; Date)
        {
            Caption = 'Due Date';
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Inv. Header"."Due Date" where("No." = field("Child Purch Invoice")));
        }

        field(30; "Child Purch Invoice Amount"; Decimal)
        {
            Caption = 'Child Purchase Invoice Amount';
            FieldClass = FlowField;
            CalcFormula = Sum("Purch. Inv. Line"."Amount Including VAT" WHERE("Document No." = field("Child Purch Invoice")));

        }


    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }


}