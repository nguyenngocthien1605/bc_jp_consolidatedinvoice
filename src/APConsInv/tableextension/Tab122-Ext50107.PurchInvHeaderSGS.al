tableextension 50107 "Purch. Inv. Header SGS" extends "Purch. Inv. Header"//122
{
    fields
    {
        // Add changes to table fields here
        field(50101; "Target of Consolidation"; Boolean)
        {
            Caption = 'Target of Consolidation';

        }

        field(50102; "Previous Due Date"; Date)
        {
            Caption = 'Previous Due Date';

        }

        field(50103; "Is Consolidated"; Boolean)
        {
            Caption = 'Is Consolidated';

        }

    }
}