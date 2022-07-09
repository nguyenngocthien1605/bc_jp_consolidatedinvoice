page 50102 "Cons Sales Invoice Card SGS"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Cons Sales Invoice Header SGS";

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

                field("Customer No."; rec."Customer No.")
                {
                    ApplicationArea = All;

                }

                // field("From Date"; rec."From Date")
                // {
                //     ApplicationArea = All;

                // }

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