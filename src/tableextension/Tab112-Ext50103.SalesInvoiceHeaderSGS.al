tableextension 50103 "Sales Invoice Header SGS" extends "Sales Invoice Header"//112
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
    }
}