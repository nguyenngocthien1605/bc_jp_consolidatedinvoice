page 50107 "ConsPurchInvoiceDocumentSGS"
{
    Caption = 'Consolidated Purchase Invoice Document';
    PageType = ListPlus;
    RefreshOnActivate = true;
    SourceTable = "Cons Purch Invoice Header SGS";
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

                field("Vendor No."; rec."Vendor No.")
                {
                    ApplicationArea = All;
                }

                field("Consolidate Date"; rec."Consolidate Date")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Terms"; rec."Payment Terms")
                {
                    ApplicationArea = All;
                }
                field("Status"; rec.Status)
                {
                    ApplicationArea = All;
                }

            }


            part("Cons Purch Invoice Line SGS"; "Cons Purch Invoice Line SGS")
            {
                Caption = 'Lines';
                ApplicationArea = All;
                Enabled = rec."Vendor No." <> '';
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
                    ConsPurchInvoiceMgt: Codeunit "Cons Purch Invoices Mgt SGS";
                begin
                    ConsPurchInvoiceMgt.Confirm(Rec);
                end;
            }
            action(UnConfirm)
            {
                Caption = 'Un-Confirm';
                ApplicationArea = All;
                //Enabled = enableUnconfirm;

                trigger OnAction()
                var
                    ConsPurchInvoiceMgt: Codeunit "Cons Purch Invoices Mgt SGS";
                begin
                    ConsPurchInvoiceMgt.UnConfirm(Rec);
                end;
            }

            action(Print)
            {
                Caption = 'Print & Print Preview';
                ApplicationArea = All;
                trigger OnAction()
                var
                    ConsPurchInvoiceHeaderRec: Record "Cons Purch Invoice Header SGS";
                    ToPrintReport: Report "Cons purch invoice report SGS";
                begin

                    ConsPurchInvoiceHeaderRec.SetCurrentKey("No.");
                    ConsPurchInvoiceHeaderRec.SetFilter("No.", Rec."No.");
                    ToPrintReport.SetTableView(ConsPurchInvoiceHeaderRec);
                    ToPrintReport.Run();

                end;

            }
            action(Print2PDF)
            {
                Caption = 'Print to PDF';
                ApplicationArea = All;
                trigger OnAction()
                var
                    ConsPurchInvoiceHeaderRec: Record "Cons Purch Invoice Header SGS";
                begin
                    ConsPurchInvoiceHeaderRec.SetCurrentKey("No.");
                    ConsPurchInvoiceHeaderRec.SetFilter("No.", Rec."No.");
                    Report.RunModal(Report::"Cons purch invoice report SGS", false, false, ConsPurchInvoiceHeaderRec);

                end;
            }
        }
    }
}