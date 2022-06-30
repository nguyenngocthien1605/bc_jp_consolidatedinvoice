tableextension 50104 "Purchases & Payables Setup SGS" extends "Purchases & Payables Setup" //312
{
    fields
    {

        field(50100; "Consolidated Invoice"; Boolean)
        {
            Caption = 'Consolidated Invoice (Syscom)';
            InitValue = false;
        }


        field(50200; "Consolidated Invoice No."; Code[20])
        {
            Caption = 'Consolidated Invoice No.';
            TableRelation = "No. Series";
        }

    }



}
