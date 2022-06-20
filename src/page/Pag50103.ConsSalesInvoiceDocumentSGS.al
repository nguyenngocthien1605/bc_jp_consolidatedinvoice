page 50103 "ConsSalesInvoiceDocumentSGS"
{
    Caption = 'Cons Sales Invoice Document';
    PageType = ListPlus;
    RefreshOnActivate = true;
    SourceTable = "Cons Sales Invoice Header SGS";
    Editable = false;

    layout
    {
        area(Content)
        {
            group(General)
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

                field("Consolidate Date"; rec."Consolidate Date")
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


            part("Cons Sales Invoice Line SGS"; "Cons Sales Invoice Line SGS")
            {
                Caption = 'Lines';
                ApplicationArea = All;
                Enabled = rec."Customer No." <> '';
                SubPageLink = "Document No." = field("No.");

            }

        }
    }

    actions
    {
        area(Processing)
        {
            action(Confirm)
            {
                Caption = 'Confirm';
                ApplicationArea = All;
                //Enabled = enableConfirm;
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
                //Enabled = enableUnconfirm;

                trigger OnAction()
                var
                    ConsSalesInvoiceMgt: Codeunit "Cons Sales Invoices Mgt SGS";
                begin
                    ConsSalesInvoiceMgt.UnConfirm(Rec);
                end;
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