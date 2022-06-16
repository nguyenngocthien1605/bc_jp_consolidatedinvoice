page 50101 "Cons Sales Invoice Line SGS"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    Editable = false;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Cons Sales Invoice Line SGS";
    CardPageId = "Sales Invoice";
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

                field("Child Sales Invoice"; rec."Child Sales Invoice")
                {
                    Caption = 'Sales Invoice';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        DataDrillDown: Codeunit "Child Sales Invoice Drill Down";
                    begin
                        DataDrillDown.SalesInvoiceDrillDown(Rec);
                    end;
                }

                field("Due Date"; rec."Due Date")
                {
                    Caption = 'Due Date';
                    ApplicationArea = All;

                }

                field("Child Sales Invoice Amount"; rec."Child Sales Invoice Amount")
                {
                    Caption = 'Sales Invoice Amount';
                    ApplicationArea = All;

                }


            }
        }
    }

}