pageextension 50120 "ExtendNavigationArea" extends "Business Manager Role Center"
{

    actions
    {
        addfirst(Sections)
        {


            //Creates a sub-menu
            group("JP Localization")
            {
                action("Cons Sales Invoice List SGS")
                {
                    ApplicationArea = All;
                    RunObject = page "Cons Sales Invoice List SGS";
                    Caption = 'Cons. sales invoice list';
                }

                action("Cons Purch Invoice List SGS")
                {
                    ApplicationArea = All;
                    RunObject = page "Cons Purch Invoice List SGS";
                    Caption = 'Cons. purchase invoice list';
                }

            }

        }
    }
}