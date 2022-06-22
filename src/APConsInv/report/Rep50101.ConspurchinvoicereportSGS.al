report 50101 "Cons purch invoice report SGS"
{

    Caption = 'Consolidated purchase invoice report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    DefaultRenderingLayout = WordLayout;
    dataset
    {
        dataitem(ConsPurchInvHeader; "Cons Purch Invoice Header SGS")
        {

            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";

            column(No_ConsPurchInvHeader; "No.")
            {
                IncludeCaption = true;

            }
            column(VendNo_ConsPurchInvHeader; "Vendor No.")
            {
                IncludeCaption = true;
            }

            column(ConsDate_ConsPurchInvHeader; Format("Consolidate Date", 0, '<Month,2>/<Day,2>/<Year>'))
            {
            }

            column(DueDate_ConsPurchInvHeader; Format("Due Date", 0, '<Month,2>/<Day,2>/<Year>'))
            {
            }


            column(Status_ConsPurchInvHeader; Status)
            {
                IncludeCaption = true;
            }

            dataitem(ConsPurchInvoiceLine; "Cons Purch Invoice Line SGS")
            {
                DataItemTableView = sorting("Document No.", "Line No.");
                DataItemLink = "Document No." = field("No.");
                column(DocumentNo_ConsPurchInvoiceLine; ConsPurchInvoiceLine."Document No.")
                {
                    IncludeCaption = true;
                }
                column(LineNo_ConsPurchInvoiceLine; ConsPurchInvoiceLine."Line No.")
                {
                    IncludeCaption = true;
                }

                column(ChildInvoice_ConsPurchInvoiceLine; ConsPurchInvoiceLine."Child Purch Invoice")
                {
                    IncludeCaption = true;
                }

                column(PostingDate_ConsPurchInvoiceLine; Format(ConsPurchInvoiceLine."Posting Date", 0, '<Month,2>/<Day,2>/<Year>'))
                {
                }
                column(DueDate_ConsPurchInvoiceLine; Format(ConsPurchInvoiceLine."Due Date", 0, '<Month,2>/<Day,2>/<Year>'))
                {
                }


                column(InvoiceAmount_ConsPurchInvoiceLine; ConsPurchInvoiceLine."Child Purch Invoice Amount")
                {
                    IncludeCaption = true;
                }

                trigger OnAfterGetRecord()
                var
                begin
                    CalcFields("Child Purch Invoice Amount");
                    CalcFields("Due Date");
                    CalcFields("Posting Date");
                end;
            }
        }

    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    rendering
    {

        layout(WordLayout)
        {
            Type = Word;
            LayoutFile = 'Layout\ConsPurchInvoiceSGSListWord.docx';
        }

    }
    trigger OnPreReport()
    var

    begin

    end;


}