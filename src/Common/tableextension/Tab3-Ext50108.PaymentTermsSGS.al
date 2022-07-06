tableextension 50108 "Payment Terms SGS" extends "Payment Terms" //3
{
    fields
    {
        //CutOffDay
        field(50101; "CutOff Day"; Integer)
        {
            Caption = 'CutOff Day';
            trigger OnValidate()
            begin
                if (rec."CutOff Day" < 0) or (rec."CutOff Day" > 31) then begin
                    Error('CutOff day is invalid! Please enter from 0 to 31.');
                end;
            end;
        }
        field(50111; "Payment Day"; Integer)
        {
            Caption = 'Payment Day';
            trigger OnValidate()
            begin
                if (rec."Payment Day" < 0) or (rec."Payment Day" > 31) then begin
                    Error('Payment day is invalid! Please enter from 0 to 31.');
                end;
            end;
        }

        field(50121; "Cons. Due Date Calculate"; Enum "Cons. Due Date Calculate")
        {
            DataClassification = ToBeClassified;
            InitValue = "Previous Working Day";

        }
        // field(50102; "Num Of Days"; Integer)
        // {
        //     Caption = 'Number of days';
        //     trigger OnValidate()
        //     begin
        //         if (rec."Num Of Days" < 0) then begin
        //             Error('Number of days is invalid! Please enter value >= 0');
        //         end;
        //     end;
        // }
        // field(50103; "Num Of Months"; Integer)
        // {
        //     Caption = 'Number of months';
        //     trigger OnValidate()
        //     begin
        //         if (rec."Num Of Months" < 0) then begin
        //             Error('Number of months is invalid! Please enter value >= 0');
        //         end;
        //     end;
        // }
    }



}