report 50100 "Cons invoice report SGS"
{

    Caption = 'Consolidated invoice report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    DefaultRenderingLayout = WordLayout;
    dataset
    {
        dataitem(ConsSalesInvHeader; "Cons Sales Invoice Header SGS")
        {

            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";

            column(No_ConsSalesInvHeader; "No.")
            {
                IncludeCaption = true;

            }
            column(CustNo_ConsSalesInvHeader; "Customer No.")
            {
                IncludeCaption = true;
            }
            // column(FromDate_ConsSalesInvHeader; "From Date")
            // {
            //     IncludeCaption = true;
            // }
            column(ConsDate_ConsSalesInvHeader; "Consolidate Date")
            {
                IncludeCaption = true;
            }
            column(DueDate_ConsSalesInvHeader; "Due Date")
            {
                IncludeCaption = true;
            }

            column(Status_ConsSalesInvHeader; Status)
            {
                IncludeCaption = true;
            }

            dataitem(ConsSalesInvoiceLine; "Cons Sales Invoice Line SGS")
            {
                DataItemTableView = sorting("Document No.", "Line No.");
                DataItemLink = "Document No." = field("No.");
                column(DocumentNo_ConsSalesInvoiceLine; ConsSalesInvoiceLine."Document No.")
                {
                    IncludeCaption = true;
                }
                column(LineNo_ConsSalesInvoiceLine; ConsSalesInvoiceLine."Line No.")
                {
                    IncludeCaption = true;
                }

                column(ChildInvoice_ConsSalesInvoiceLine; ConsSalesInvoiceLine."Child Sales Invoice")
                {
                    IncludeCaption = true;
                }

                column(PostingDate_ConsSalesInvoiceLine; ConsSalesInvoiceLine."Posting Date")
                {
                    IncludeCaption = true;
                }
                column(DueDate_ConsSalesInvoiceLine; ConsSalesInvoiceLine."Due Date")
                {
                    IncludeCaption = true;
                }

                column(InvoiceAmount_ConsSalesInvoiceLine; ConsSalesInvoiceLine."Child Sales Invoice Amount")
                {
                    IncludeCaption = true;
                }

                trigger OnAfterGetRecord()
                var
                begin
                    CalcFields("Child Sales Invoice Amount");
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
        // layout(RDLCLayout)
        // {
        //     Type = RDLC;
        //     LayoutFile = 'Layout\ConsInvoiceSGSListRDLC.rdl';
        // }
        layout(WordLayout)
        {
            Type = Word;
            LayoutFile = 'Layout\ConsInvoiceSGSListWord.docx';
        }

    }
    trigger OnPreReport()
    var

    begin

    end;


}