tableextension 50100 "Sales & Receivables Setup SGS" extends "Sales & Receivables Setup" //311
{
    fields
    {

        // Add changes to table fields here
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
