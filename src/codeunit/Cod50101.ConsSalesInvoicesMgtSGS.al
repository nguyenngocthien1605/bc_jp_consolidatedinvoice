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

    procedure UnConfirm(var ConsSalesInvoiceHeader: Record "Cons Sales Invoice Header SGS")
    var
        ConsSalesInvoiceLine: Record "Cons Sales Invoice Line SGS";
        SalesInvoice: Record "Sales Invoice Header";

    begin
        if (ConsSalesInvoiceHeader.Status = ConsStatus::"Confirmed") then begin
            // update Due Date back to previous value for child sales invoice
            ConsSalesInvoiceLine.SetRange("Document No.", ConsSalesInvoiceHeader."No.");
            if ConsSalesInvoiceLine.FindSet() then begin
                repeat
                    SalesInvoice.Get(ConsSalesInvoiceLine."Child Sales Invoice");
                    SalesInvoice."Due Date" := SalesInvoice."Previous Due Date";
                    SalesInvoice."Previous Due Date" := 0D;
                    SalesInvoice."Is Consolidated" := false;
                    SalesInvoice.Modify(false);
                    ConsSalesInvoiceLine.Delete(false);
                until ConsSalesInvoiceLine.Next() = 0;
            end;
            ConsSalesInvoiceHeader."Status" := ConsStatus::"Un-Confirmed";
            ConsSalesInvoiceHeader."Due Date" := 0D;

            ConsSalesInvoiceHeader.Modify();
            Commit();
        end
        else begin
            Message('Invoice %1 for customer %2 is already un-confirmed.', ConsSalesInvoiceHeader."No.", ConsSalesInvoiceHeader."Customer No.");
        end;



    end;

    procedure Confirm(var ConsSalesInvoiceHeader: Record "Cons Sales Invoice Header SGS")
    var
        ConsSalesInvoiceLine: Record "Cons Sales Invoice Line SGS";
        SalesInvoice: Record "Sales Invoice Header";
        Customer: Record Customer;
        PaymentTerm: Record "Payment Terms";
        line: Integer;
        ConsDueDate: Date;
    begin

        if (ConsSalesInvoiceHeader.Status = ConsStatus::Confirmed) then begin
            Error('Invoice %1 for customer %2 is already confirmed.', ConsSalesInvoiceHeader."No.", ConsSalesInvoiceHeader."Customer No.");
        end;

        Customer.Get(ConsSalesInvoiceHeader."Customer No.");
        PaymentTerm.Get(Customer."Payment Terms Code");
        ConsDueDate := CalcDate(PaymentTerm."Due Date Calculation", ConsSalesInvoiceHeader."Consolidate Date");

        line := 1;
        SalesInvoice.SetRange("Target of Consolidation", true);
        SalesInvoice.SetRange("Is Consolidated", false);
        SalesInvoice.SetRange("Bill-to Customer No.", ConsSalesInvoiceHeader."Customer No.");
        SalesInvoice.SetFilter("Posting Date", '..%1', ConsSalesInvoiceHeader."Consolidate Date");

        if SalesInvoice.FindSet() then begin

            ConsSalesInvoiceLine.SetRange("Document No.", ConsSalesInvoiceHeader."No.");
            ConsSalesInvoiceLine.DeleteAll();
            repeat

                SalesInvoice."Previous Due Date" := SalesInvoice."Due Date";
                SalesInvoice."Due Date" := ConsDueDate;
                SalesInvoice."Is Consolidated" := true;
                SalesInvoice.Modify();

                ConsSalesInvoiceLine.Reset();
                ConsSalesInvoiceLine."Document No." := ConsSalesInvoiceHeader."No.";
                ConsSalesInvoiceLine."Line No." := line;
                ConsSalesInvoiceLine."Child Sales Invoice" := SalesInvoice."No.";
                ConsSalesInvoiceLine.Insert();
                line := line + 1;

            until SalesInvoice.Next() = 0;

            ConsSalesInvoiceHeader."Status" := ConsStatus::Confirmed;
            ConsSalesInvoiceHeader."Due Date" := ConsDueDate;
            ConsSalesInvoiceHeader.Modify();
            Commit();

        end;
        Message('Invoice %1 for customer %2 has been consolidated successfully.', ConsSalesInvoiceHeader."No.", ConsSalesInvoiceHeader."Customer No.");
    end;


}