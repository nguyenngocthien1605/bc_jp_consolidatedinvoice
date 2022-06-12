codeunit 50101 "Cons Sales Invoices Mgt SGS"
{
    Subtype = Normal;

    Permissions = TableData "Sales Invoice Header" = imd,
                    tabledata "Cons Sales Invoice Line SGS" = imd;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvHeaderInsert', '', false, false)]
    local procedure UpdateConsSalesInvOnAfterSalesInvHeaderInsert(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; WhseShip: Boolean; WhseReceive: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header"; var TempWhseRcptHeader: Record "Warehouse Receipt Header"; PreviewMode: Boolean);
    begin
        SalesInvHeader."Target of Consolidation" := SalesHeader."Target of Consolidation";
        SalesInvHeader.Modify();
    end;


    procedure CollectChildSalesInvoice(var ConsSalesInvoiceHeader: Record "Cons Sales Invoice Header SGS")
    var
        ConsSalesInvoiceLine: Record "Cons Sales Invoice Line SGS";
        SalesInvoice: Record "Sales Invoice Header";
        line: Integer;
    begin

        ConsSalesInvoiceLine.SetRange("Document No.", ConsSalesInvoiceHeader."No.");
        ConsSalesInvoiceLine.DeleteAll();

        line := 1;
        SalesInvoice.SetRange("Bill-to Customer No.", ConsSalesInvoiceHeader."Customer No.");
        SalesInvoice.SetFilter("Due Date", '%1..%2', ConsSalesInvoiceHeader."From Date", ConsSalesInvoiceHeader."To Date");
        SalesInvoice.SetRange("Target of Consolidation", true);

        if SalesInvoice.FindSet() then
            repeat

                //Message('Line-SalesInvoice.No = %1', SalesInvoice."No.");
                ConsSalesInvoiceLine.Reset();
                ConsSalesInvoiceLine."Document No." := ConsSalesInvoiceHeader."No.";
                ConsSalesInvoiceLine."Line No." := line;
                ConsSalesInvoiceLine."Child Sales Invoice" := SalesInvoice."No.";
                ConsSalesInvoiceLine.Insert();
                line := line + 1;

            until SalesInvoice.Next() = 0;
        Commit();
        Message('Invoice %1 for customer %2 has been consolidated successfully.', ConsSalesInvoiceHeader."No.", ConsSalesInvoiceHeader."Customer No.");
    end;


}