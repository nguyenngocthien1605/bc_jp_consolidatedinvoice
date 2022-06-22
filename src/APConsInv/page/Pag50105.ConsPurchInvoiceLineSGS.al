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

                // field("Document No."; rec."Document No.")
                // {
                //     Caption = 'Document No.';
                //     ApplicationArea = All;

                // }
                field("Line No."; rec."Line No.")
                {
                    Caption = 'Line No.';
                    ApplicationArea = All;

                }

                field("Child Purch Invoice"; rec."Child Purch Invoice")
                {
                    Caption = 'Child Purchase Invoice';
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
                    Caption = 'Posting Date';
                    ApplicationArea = All;

                }
                field("Due Date"; rec."Due Date")
                {
                    Caption = 'Due Date';
                    ApplicationArea = All;

                }

                field("Child Purch Invoice Amount"; rec."Child Purch Invoice Amount")
                {
                    Caption = 'Purchase Invoice Amount';
                    ApplicationArea = All;

                }


            }
        }
    }

}