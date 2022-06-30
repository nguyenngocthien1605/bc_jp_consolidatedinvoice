tableextension 50105 "Vendor SGS" extends Vendor//23
{
    fields
    {
        // Add changes to table fields here
        field(50101; "Consolidate Day"; Integer)
        {
            Caption = 'Consolidate Day';
            trigger OnValidate()
            begin
                if (rec."Consolidate Day" < 0) or (rec."Consolidate Day" > 31) then begin
                    Error('Consolidation day is invalid! Please enter from 0 to 31.');
                end;
            end;
        }
    }
}