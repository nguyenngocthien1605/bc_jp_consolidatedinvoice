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

                field("From Date"; rec."From Date")
                {
                    ApplicationArea = All;

                }

                field("To Date"; rec."To Date")
                {
                    ApplicationArea = All;

                }

                field("Due Date"; rec."Due Date")
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

    // actions
    // {
    //     area(Processing)
    //     {

    //         action(Generate)
    //         {
    //             Caption = '1. Confirm';
    //             ApplicationArea = All;

    //             trigger OnAction()
    //             var
    //                 ConsSalesInvoiceMgt: Codeunit "Cons Sales Invoices Mgt SGS";
    //             begin
    //                 ConsSalesInvoiceMgt.Confirm(Rec);
    //             end;
    //         }
    //         action(Show)
    //         {
    //             Caption = '2. Open consolidated sales invoices details';
    //             ApplicationArea = All;
    //             RunObject = page "Cons Sales Invoice Line SGS";
    //             RunPageLink = "Document No." = field("No.");

    //         }
    //     }
    // }

}