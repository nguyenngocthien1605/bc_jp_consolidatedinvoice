page 50106 "Cons Purch Invoice Card SGS"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Cons Purch Invoice Header SGS";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; rec."No.")
                {
                    ApplicationArea = All;

                }

                field("Vendor No."; rec."Vendor No.")
                {
                    ApplicationArea = All;

                }

                field("Consolidate Date"; rec."Consolidate Date")
                {
                    ApplicationArea = All;

                }

                field("Due Date"; rec."Due Date")
                {
                    ApplicationArea = All;
                }

                field("Payment Terms"; rec."Payment Terms")
                {
                    ApplicationArea = All;
                }

                field("Status"; rec.Status)
                {
                    ApplicationArea = All;
                }

            }


        }
    }


}