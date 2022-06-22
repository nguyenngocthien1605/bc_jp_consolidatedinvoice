tableextension 50102 "Sales Header SGS" extends "Sales Header"
{
    fields
    {
        // Add changes to table fields here
        field(50101; "Target of Consolidation"; Boolean)
        {
            Caption = 'Target of Consolidation';

        }

        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            begin
                //Message('New Sell-to Customer Name is ' + "Sell-to Customer Name");
                rec."Target of Consolidation" := setTargetConsolidation;
            end;
        }
    }

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

    // var
    //     enableTargetConsolidation: Boolean;

}


