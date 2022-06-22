page 50104 "Cons Purch Invoice List SGS"
{
    Caption = 'Consolidated Purchase Invoices List';

    PageType = List;
    SourceTable = "Cons Purch Invoice Header SGS";
    CardPageId = "ConsPurchInvoiceDocumentSGS";

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

                field("Vendor No."; rec."Vendor No.")
                {
                    ApplicationArea = All;

                }

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
                        ConsPurchInvoiceMgt: Codeunit "Cons Purch Invoices Mgt SGS";
                    begin
                        ConsPurchInvoiceMgt.Confirm(Rec);
                    end;
                }

                action(UnConfirm)
                {
                    Caption = 'Un-Confirm';
                    ApplicationArea = All;
                    Enabled = enableUnconfirm;

                    trigger OnAction()
                    var
                        ConsPurchInvoiceMgt: Codeunit "Cons Purch Invoices Mgt SGS";
                    begin
                        ConsPurchInvoiceMgt.UnConfirm(Rec);
                    end;
                }

                action(Show)
                {
                    Caption = 'Show details';
                    ApplicationArea = All;
                    RunObject = page "ConsPurchInvoiceDocumentSGS";
                    RunPageLink = "No." = field("No.");

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