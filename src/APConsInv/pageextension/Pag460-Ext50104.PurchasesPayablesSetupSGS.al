pageextension 50104 "Purchases & Payables Setup SGS" extends "Purchases & Payables Setup" //460
{
    layout
    {
        // Add changes to page layout here
        addafter("Document Default Line Type")
        {
            field("Consolidated Invoice"; Rec."Consolidated Invoice")
            {
                Caption = 'Consolidated Invoice (Syscom)';
                ToolTip = 'Enable consolidated invoice function.';
                ApplicationArea = All;
            }
        }
        addafter("Number Series")
        {
            field("Consolidated Invoice No."; rec."Consolidated Invoice No.")
            {
                Caption = 'Consolidated Invoice No.';
                ApplicationArea = All;
            }
        }
    }


}