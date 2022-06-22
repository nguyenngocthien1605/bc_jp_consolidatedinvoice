codeunit 50104 "Child Purch Invoice Drill Down"
{
    trigger OnRun()
    begin

    end;

    procedure PurchInvoiceDrillDown(var consInvoiceLine: Record "Cons Purch Invoice Line SGS")
    var
        purchInvoiceHeader: Record "Purch. Inv. Header";
    begin
        purchInvoiceHeader.Get(consInvoiceLine."Child Purch Invoice");
        Page.RunModal(Page::"Posted Purchase Invoice", purchInvoiceHeader);

    end;
}