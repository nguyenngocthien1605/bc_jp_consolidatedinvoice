pageextension 50105 "Vendor Card SGS" extends "Vendor Card" //26 "Vendor Card"
{
    layout
    {
        addlast(General)
        {
            field("Consolidate Day"; Rec."Consolidate Day")
            {
                ToolTip = 'Specifies the value of the Consolidate Day field.';
                ApplicationArea = All;
                Visible = showConsDay;
            }
        }
    }

    trigger OnOpenPage()
    begin
        setVisibleForConsDay();
    end;

    var
        [InDataSet]
        showConsDay: Boolean;

    local procedure setVisibleForConsDay()
    var
        PurchasePayableSetup: Record "Purchases & Payables Setup";

    begin
        PurchasePayableSetup.FindFirst();

        if PurchasePayableSetup."Consolidated Invoice" = true then begin
            // Message('Show Consolidate Day');
            showConsDay := true;
        end
        else begin
            showConsDay := false;
        end;
    end;
}