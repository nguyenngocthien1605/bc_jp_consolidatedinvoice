codeunit 50102 "Child Sales Invoice Drill Down"
{
    trigger OnRun()
    begin

    end;

    procedure SalesInvoiceDrillDown(var consSlesInvoiceLine: Record "Cons Sales Invoice Line SGS")
    var
        salesInvoiceHeader: Record "Sales Invoice Header";
    begin
        salesInvoiceHeader.Get(consSlesInvoiceLine."Child Sales Invoice");
        Page.RunModal(Page::"Posted Sales Invoice", salesInvoiceHeader);

    end;
}