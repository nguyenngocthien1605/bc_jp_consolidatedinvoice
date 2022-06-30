pageextension 50100 "Sales & Receivables Setup SGS" extends "Sales & Receivables Setup" //459
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
        addafter("Customer Nos.")
        {
            field("Consolidated Invoice No."; rec."Consolidated Invoice No.")
            {

                ApplicationArea = All;
            }
        }
    }

    // var
    //     ConsolidateInvoice_SGS: Boolean;

}