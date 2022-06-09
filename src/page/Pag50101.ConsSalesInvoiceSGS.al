page 50101 "Cons Sales Invoice SGS"
{
    Caption = 'Consolidated Sales Invoice SGS';
    PageType = Document;
    PromotedActionCategories = 'Process';
    SourceTable = "Cons Sales Invoice Line SGS";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Line num"; rec."Line num")
                {
                    Caption = 'Line No.';
                    ApplicationArea = All;

                }
                field("Document No."; rec."Document No.")
                {
                    Caption = 'Document No.';
                    ApplicationArea = All;

                }

                field("Child Sales Invoice"; rec."Child Sales Invoice")
                {
                    Caption = 'Child Sales Invoice';
                    ApplicationArea = All;

                }

                field("Child Sales Invoice Amount"; rec."Child Sales Invoice Amount")
                {
                    Caption = 'Child Sales Invoice Amount';
                    ApplicationArea = All;

                }


            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}