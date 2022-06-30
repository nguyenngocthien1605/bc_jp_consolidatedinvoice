tableextension 50101 "Customer SGS" extends Customer//18
{
    fields
    {

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