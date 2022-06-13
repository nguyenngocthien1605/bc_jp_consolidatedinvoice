page 50100 "Cons Sales Invoice List SGS"
{
    Caption = 'Consolidated Sales Invoices';

    PageType = List;
    SourceTable = "Cons Sales Invoice Header SGS";
    CardPageId = "Cons Sales Invoice Card SGS";

    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
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
                    Caption = '1. Consolidate sales invoices';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ConsSalesInvoiceMgt: Codeunit "Cons Sales Invoices Mgt SGS";
                    begin
                        ConsSalesInvoiceMgt.CollectChildSalesInvoice(rec);
                    end;
                }
                action(Show)
                {
                    Caption = '2. Open consolidated sales invoices details';
                    ApplicationArea = All;
                    RunObject = page "Cons Sales Invoice Line SGS";
                    RunPageLink = "Document No." = field("No.");

                }
            }


        }
    }


}