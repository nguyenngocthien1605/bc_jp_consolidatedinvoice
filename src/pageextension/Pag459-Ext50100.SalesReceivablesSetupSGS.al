pageextension 50100 "Sales & Receivables Setup SGS" extends "Sales & Receivables Setup" //459
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("Consolidated Invoice"; Rec."Consolidated Invoice")
            {
                Caption = 'Consolidated Invoice (Syscom)';
                ToolTip = 'Enable consolidated invoice function.';
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    if Rec."Consolidated Invoice" then
                        ConsolidateInvoice_SGS := true
                    else
                        ConsolidateInvoice_SGS := false;

                end;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        ConsolidateInvoice_SGS: Boolean;

}