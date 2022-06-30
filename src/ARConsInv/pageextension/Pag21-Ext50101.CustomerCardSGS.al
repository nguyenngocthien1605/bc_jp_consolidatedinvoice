pageextension 50101 "Customer Card SGS" extends "Customer Card"//21
{
    layout
    {
        // The "addlast" construct adds the field control as the last control in the General 
        // group.
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
        SalesReceivablesSetup: Record "Sales & Receivables Setup";

    begin
        SalesReceivablesSetup.FindFirst();

        if SalesReceivablesSetup."Consolidated Invoice" = true then begin
            // Message('Show Consolidate Day');
            showConsDay := true;

        end
        else begin
            showConsDay := false;
        end;
    end;

}