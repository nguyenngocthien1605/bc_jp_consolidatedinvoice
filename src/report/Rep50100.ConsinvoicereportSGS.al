report 50100 "Cons invoice report SGS"
{

    Caption = 'Consolidated invoice report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    DefaultRenderingLayout = WordLayout;
    dataset
    {
        dataitem(ConsSalesInvoiceLine; "Cons Sales Invoice Line SGS")
        {
            column(ConsSalesInvoiceLine_DocNo; ConsSalesInvoiceLine."Document No.")
            {
                IncludeCaption = true;
            }
            column(ConsSalesInvoiceLine_LineNo; ConsSalesInvoiceLine."Line No.")
            {
                IncludeCaption = true;
            }

            column(ConsSalesInvoiceLine_SalesInvoice; ConsSalesInvoiceLine."Child Sales Invoice")
            {
                IncludeCaption = true;
            }

            column(ConsSalesInvoiceLine_SalesInvoiceAmount; ConsSalesInvoiceLine."Child Sales Invoice Amount")
            {
                IncludeCaption = true;
            }

            trigger OnAfterGetRecord()
            var
            begin
                CalcFields("Child Sales Invoice Amount");
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
        }

        actions
        {
        }
    }

    rendering
    {
        layout(RDLCLayout)
        {
            Type = RDLC;
            LayoutFile = 'Layout\ConsInvoiceSGSListRDLC.rdl';

        }
        layout(WordLayout)
        {
            Type = Word;
            LayoutFile = 'Layout\ConsInvoiceSGSListWord.docx';

        }

    }
    trigger OnPreReport()
    var
    //FormatDocument: Codeunit "Format Document";
    begin
        //CustFilter := FormatDocument.GetRecordFiltersWithCaptions(Customer);
    end;


}