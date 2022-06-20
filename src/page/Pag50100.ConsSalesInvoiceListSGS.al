page 50100 "Cons Sales Invoice List SGS"
{
    Caption = 'Consolidated Sales Invoices List';

    PageType = List;
    SourceTable = "Cons Sales Invoice Header SGS";
    CardPageId = "ConsSalesInvoiceDocumentSGS";

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

                // field("From Date"; rec."From Date")
                // {
                //     ApplicationArea = All;

                // }

                field("Cons. Date"; rec."Consolidate Date")
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

    actions
    {
        area(navigation)
        {
            group("Process")
            {
                Caption = 'Process';
                action(Confirm)
                {
                    Caption = 'Confirm';
                    ApplicationArea = All;
                    Enabled = enableConfirm;
                    trigger OnAction()
                    var
                        ConsSalesInvoiceMgt: Codeunit "Cons Sales Invoices Mgt SGS";
                    begin
                        ConsSalesInvoiceMgt.Confirm(Rec);
                    end;
                }

                action(UnConfirm)
                {
                    Caption = 'Un-Confirm';
                    ApplicationArea = All;
                    Enabled = enableUnconfirm;

                    trigger OnAction()
                    var
                        ConsSalesInvoiceMgt: Codeunit "Cons Sales Invoices Mgt SGS";
                    begin
                        ConsSalesInvoiceMgt.UnConfirm(Rec);
                    end;
                }

                action(Show)
                {
                    Caption = 'Show details';
                    ApplicationArea = All;
                    RunObject = page "ConsSalesInvoiceDocumentSGS";
                    RunPageLink = "No." = field("No.");

                }
                action(Print)
                {
                    Caption = 'Print & Print Preview';
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        ConsSalesInvoiceHeaderRec: Record "Cons Sales Invoice Header SGS";
                        ToPrintReport: Report "Cons invoice report SGS";
                    begin

                        ConsSalesInvoiceHeaderRec.SetCurrentKey("No.");
                        ConsSalesInvoiceHeaderRec.SetFilter("No.", Rec."No.");
                        ToPrintReport.SetTableView(ConsSalesInvoiceHeaderRec);
                        ToPrintReport.Run();

                    end;
                }
                action(Print2PDF)
                {
                    Caption = 'Print to PDF';
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        ConsSalesInvoiceHeaderRec: Record "Cons Sales Invoice Header SGS";
                    begin
                        ConsSalesInvoiceHeaderRec.SetCurrentKey("No.");
                        ConsSalesInvoiceHeaderRec.SetFilter("No.", Rec."No.");
                        Report.RunModal(Report::"Cons invoice report SGS", false, false, ConsSalesInvoiceHeaderRec);

                    end;
                }
            }


        }
    }

    trigger OnAfterGetCurrRecord()

    begin
        if (Rec.Status = ConsStatus::Confirmed) then begin
            enableConfirm := false;
            enableUnconfirm := true;
        end
        else begin
            enableConfirm := true;
            enableUnconfirm := false;
        end;

    end;

    var
        enableConfirm, enableUnconfirm : boolean;

}