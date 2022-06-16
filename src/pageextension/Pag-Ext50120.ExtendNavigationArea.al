pageextension 50120 "ExtendNavigationArea" extends "Order Processor Role Center"
{

    actions
    {
        addfirst(Sections)
        {

            // action("JP Localization")
            // {
            //     RunObject = page "Cons Sales Invoice List SGS";
            //     Caption = 'JP Localization';
            //     ApplicationArea = All;
            // }


            //Creates a sub-menu
            group("Consolidated sales invoice")
            {
                action("Sales Document Entity")
                {
                    ApplicationArea = All;
                    RunObject = page "Cons Sales Invoice List SGS";
                    Caption = 'Consolidated sales invoice';
                }

            }

        }
    }
}