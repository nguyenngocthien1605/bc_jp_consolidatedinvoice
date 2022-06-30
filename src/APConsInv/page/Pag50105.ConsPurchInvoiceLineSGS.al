page 50105 "Cons Purch Invoice Line SGS"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    Editable = false;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Cons Purch Invoice Line SGS";
    CardPageId = "Purchase Invoice";
    layout
    {
        area(Content)
        {
            repeater("Details")
            {


                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;

                }

                field("Child Purch Invoice"; rec."Child Purch Invoice")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        DataDrillDown: Codeunit "Child Purch Invoice Drill Down";
                    begin
                        DataDrillDown.PurchInvoiceDrillDown(Rec);
                    end;
                }

                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;

                }
                field("Due Date"; rec."Due Date")
                {
                    ApplicationArea = All;

                }

                field("Child Purch Invoice Amount"; rec."Child Purch Invoice Amount")
                {
                    ApplicationArea = All;

                }


            }
        }
    }

}