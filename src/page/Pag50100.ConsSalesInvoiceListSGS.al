page 50100 "Cons Sales Invoice List SGS"
{
    Caption = 'Consolidated Sales Invoices';

    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Cons Sales Invoice Header SGS";

    layout
    {
        area(Content)
        {
            group("Group 1")
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;

                }

                field("From Date"; rec."From Date")
                {
                    ApplicationArea = All;

                }

                field("To Date"; rec."To Date")
                {
                    ApplicationArea = All;

                }

            }


        }
    }

    actions
    {
        area(navigation)
        {
            group("Process")
            {
                Caption = 'Process';
                action(Generate)
                {
                    Caption = 'Generate consolidated invoice';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Message('Generate consolidated invoice (to be implemented');
                    end;
                }
            }

        }
    }


}