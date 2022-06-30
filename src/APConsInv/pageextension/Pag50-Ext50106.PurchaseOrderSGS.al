pageextension 50106 "Purchase Order SGS" extends "Purchase Order"//50 "Purchase Order"
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

    // var
    //     enableTargetConsolidation: Boolean;

    local procedure setTargetConsolidation(): Boolean
    var
        vendor: Record Vendor;
        retVal: Boolean;
    begin
        vendor.get(rec."Buy-from Vendor No.");


        if vendor."Consolidate Day" <> 0 then begin

            retVal := true;

        end

        else begin

            retVal := false;

        end;

        exit(retVal);

    end;

}