table 50101 "Cons Sales Invoice Line SGS"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line num"; Integer)
        {
            Caption = 'Line number';


        }

        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Cons Sales Invoice Header SGS";

        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }

        field(20; "Child Sales Invoice"; Code[20])
        {
            Caption = 'Child Sales Invoice';
            TableRelation = "Sales Invoice Header";

        }

        field(30; "Child Sales Invoice Amount"; Decimal)
        {
            Caption = 'Child Sales Invoice Amount';
            AutoFormatType = 1;
            AutoFormatExpression = '';
            FieldClass = FlowField;
            CalcFormula = Max("Sales Invoice Header".Amount WHERE("No." = FIELD("Document No.")));

        }





    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}