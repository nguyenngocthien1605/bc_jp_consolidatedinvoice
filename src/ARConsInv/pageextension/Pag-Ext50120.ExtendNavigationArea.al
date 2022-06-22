pageextension 50120 "ExtendNavigationArea" extends "Business Manager Role Center"
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
            group("JP Localization")
            {
                action("Cons Sales Invoice List SGS")
                {
                    ApplicationArea = All;
                    RunObject = page "Cons Sales Invoice List SGS";
                    Caption = 'Consolidated sales invoice list';
                }

                action("Cons Purch Invoice List SGS")
                {
                    ApplicationArea = All;
                    RunObject = page "Cons Purch Invoice List SGS";
                    Caption = 'Consolidated purchase invoice list';
                }

            }

        }
    }
}