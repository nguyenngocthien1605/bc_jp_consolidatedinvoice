pageextension 50103 "Sales Invoice SGS" extends "Sales Invoice"//43
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {

            field("Target of Consolidation "; Rec."Target of Consolidation")
            {
                ToolTip = 'Enable for consolidating invoice.';
                ApplicationArea = All;


            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec."Target of Consolidation" := setTargetConsolidation;
    end;

    var
        enableTargetConsolidation: Boolean;

    local procedure setTargetConsolidation(): Boolean
    var
        customer: Record Customer;
        retVal: Boolean;
    begin
        customer.get(rec."Sell-to Customer No.");


        if customer."Consolidate Day" <> 0 then begin

            retVal := true;

        end

        else begin

            retVal := false;

        end;

        exit(retVal);

    end;


}