tableextension 50106 "Purchase Header SGS" extends "Purchase Header"//38
{
    fields
    {
        // Add changes to table fields here
        field(50101; "Target of Consolidation"; Boolean)
        {
            Caption = 'Target of Consolidation';

        }

        modify("Buy-from Vendor No.")
        {
            trigger OnAfterValidate()
            begin
                rec."Target of Consolidation" := setTargetConsolidation;
            end;
        }
    }

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


