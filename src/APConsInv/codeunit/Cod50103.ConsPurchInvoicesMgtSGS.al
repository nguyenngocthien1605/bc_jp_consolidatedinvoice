codeunit 50103 "Cons Purch Invoices Mgt SGS"
{
    Subtype = Normal;

    Permissions = TableData "Purch. Inv. Header" = imd,
                    tabledata "Cons Purch Invoice Line SGS" = imd,
                        tabledata "Vendor Ledger Entry" = m;


    //Press Shift + Alt + E to generate snipet
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPurchInvHeaderInsert', '', false, false)]
    local procedure OnAfterPurchInvHeaderInsert(var PurchInvHeader: Record "Purch. Inv. Header"; var PurchHeader: Record "Purchase Header"; PreviewMode: Boolean);
    begin
        PurchInvHeader."Target of Consolidation" := PurchHeader."Target of Consolidation";
        PurchInvHeader.Modify();
    end;


    procedure UnConfirm(var ConsPurchInvoiceHeader: Record "Cons Purch Invoice Header SGS")
    var
        ConsPurchInvoiceLine: Record "Cons Purch Invoice Line SGS";
        PurchInvoice: Record "Purch. Inv. Header";
        VendLedgEntry: Record "Vendor Ledger Entry";
    begin
        if (ConsPurchInvoiceHeader.Status = ConsStatus::"Confirmed") then begin
            // update Due Date back to previous value for child purch invoice
            ConsPurchInvoiceLine.SetRange("Document No.", ConsPurchInvoiceHeader."No.");
            if ConsPurchInvoiceLine.FindSet() then begin

                repeat

                    //Update table "Purch. Inv. Header" => fields: "Due Date"; "Previous Due Date"
                    PurchInvoice.Get(ConsPurchInvoiceLine."Child Purch Invoice");
                    PurchInvoice."Due Date" := PurchInvoice."Previous Due Date";
                    PurchInvoice."Previous Due Date" := 0D;
                    PurchInvoice."Is Consolidated" := false;
                    PurchInvoice.Modify();

                    //Update table "Vendor Ledger Entry" => fields: "Due Date"
                    VendLedgEntry.SetCurrentKey("Entry No.");
                    VendLedgEntry.SetRange("Entry No.", PurchInvoice."Vendor Ledger Entry No.");

                    if (VendLedgEntry.Find('-')) then begin
                        VendLedgEntry."Due Date" := PurchInvoice."Due Date";
                        VendLedgEntry.Modify();
                    end;

                    ConsPurchInvoiceLine.Delete(false);

                until ConsPurchInvoiceLine.Next() = 0;
            end;
            ConsPurchInvoiceHeader."Status" := ConsStatus::"Un-Confirmed";
            ConsPurchInvoiceHeader."Due Date" := 0D;

            ConsPurchInvoiceHeader.Modify();
            Commit();
        end
        else begin
            Message('Invoice %1 for customer %2 is already un-confirmed.', ConsPurchInvoiceHeader."No.", ConsPurchInvoiceHeader."Vendor No.");
        end;



    end;

    procedure Confirm(var ConsPurchInvoiceHeader: Record "Cons Purch Invoice Header SGS")
    var
        ConsPurchInvoiceLine: Record "Cons Purch Invoice Line SGS";
        PurchInvoice: Record "Purch. Inv. Header";
        Vendor: Record Vendor;
        PaymentTerm: Record "Payment Terms";
        line: Integer;
        ConsDueDate: Date;
        VendLedgEntry: Record "Vendor Ledger Entry";
    begin

        if (ConsPurchInvoiceHeader.Status = ConsStatus::Confirmed) then begin
            Error('Invoice %1 for customer %2 is already confirmed.', ConsPurchInvoiceHeader."No.", ConsPurchInvoiceHeader."Vendor No.");
        end;

        Vendor.Get(ConsPurchInvoiceHeader."Vendor No.");
        PaymentTerm.Get(Vendor."Payment Terms Code");
        ConsDueDate := CalcDate(PaymentTerm."Due Date Calculation", ConsPurchInvoiceHeader."Consolidate Date");

        line := 1;
        PurchInvoice.SetRange("Target of Consolidation", true);
        PurchInvoice.SetRange("Is Consolidated", false);
        PurchInvoice.SetRange("Pay-to Vendor No.", ConsPurchInvoiceHeader."Vendor No.");
        PurchInvoice.SetFilter("Posting Date", '..%1', ConsPurchInvoiceHeader."Consolidate Date");

        if PurchInvoice.FindSet() then begin

            ConsPurchInvoiceLine.SetRange("Document No.", ConsPurchInvoiceHeader."No.");
            ConsPurchInvoiceLine.DeleteAll();

            repeat

                //Update table "Cust. Ledger Entry" => fields: "Due Date"
                VendLedgEntry.SetCurrentKey("Entry No.");
                VendLedgEntry.SetRange("Entry No.", PurchInvoice."Vendor Ledger Entry No.");

                if (VendLedgEntry.Find('-')) then begin
                    VendLedgEntry."Due Date" := ConsDueDate;
                    VendLedgEntry.Modify();
                end;

                //Update table "Purch. Inv. Header" => fields: "Due Date"; "Previous Due Date"
                PurchInvoice."Previous Due Date" := PurchInvoice."Due Date";
                PurchInvoice."Due Date" := ConsDueDate;
                PurchInvoice."Is Consolidated" := true;
                PurchInvoice.Modify();

                //Insert table "Cons Purch Invoice Line SGS"
                ConsPurchInvoiceLine.Reset();
                ConsPurchInvoiceLine."Document No." := ConsPurchInvoiceHeader."No.";
                ConsPurchInvoiceLine."Line No." := line;
                ConsPurchInvoiceLine."Child Purch Invoice" := PurchInvoice."No.";
                ConsPurchInvoiceLine.Insert();

                line := line + 1;

            until PurchInvoice.Next() = 0;

            //Update table "Cons Purch Invoice Header SGS"
            ConsPurchInvoiceHeader."Status" := ConsStatus::Confirmed;
            ConsPurchInvoiceHeader."Due Date" := ConsDueDate;
            ConsPurchInvoiceHeader.Modify();



            Commit();

        end;
        Message('Invoice %1 for customer %2 has been consolidated successfully.', ConsPurchInvoiceHeader."No.", ConsPurchInvoiceHeader."Vendor No.");
    end;


}