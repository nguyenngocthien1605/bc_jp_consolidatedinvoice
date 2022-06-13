page 50101 "Cons Sales Invoice Line SGS"
{
    Caption = 'Consolidated sales invoice details';
    PageType = List;
    Editable = false;
    SourceTable = "Cons Sales Invoice Line SGS";

    layout
    {
        area(Content)
        {
            repeater("Details")
            {

                field("Document No."; rec."Document No.")
                {
                    Caption = 'Document No.';
                    ApplicationArea = All;

                }
                field("Line No."; rec."Line No.")
                {
                    Caption = 'Line No.';
                    ApplicationArea = All;

                }

                field("Child Sales Invoice"; rec."Child Sales Invoice")
                {
                    Caption = 'Sales Invoice';
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