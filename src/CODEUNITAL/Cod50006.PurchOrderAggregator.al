codeunit 50006 "Purch. Order Aggregator"
{
    Permissions = TableData 122 = rimd;

    trigger OnRun()
    begin
    end;

    var
        GraphMgtGeneralTools: Codeunit "5465";
        DocumentIDNotSpecifiedErr: Label 'You must specify a document id to get the lines.', Locked = true;
        DocumentDoesNotExistErr: Label 'No document with the specified ID exists.', Locked = true;
        MultipleDocumentsFoundForIdErr: Label 'Multiple documents have been found for the specified criteria.', Locked = true;
        CannotModifyPostedInvioceErr: Label 'The invoice has been posted and can no longer be modified.', Locked = true;
        CannotInsertALineThatAlreadyExistsErr: Label 'You cannot insert a line with a duplicate sequence number.', Locked = true;
        CannotModifyALineThatDoesntExistErr: Label 'You cannot modify a line that does not exist.', Locked = true;
        CannotInsertPostedInvoiceErr: Label 'Invoices created through the API must be in Draft state.', Locked = true;
        CanOnlySetUOMForTypeItemErr: Label 'Unit of Measure can be set only for lines with type Item.', Locked = true;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertPurchaseHeader(var Rec: Record "38"; RunTrigger: Boolean)
    begin
        IF NOT CheckValidRecord(Rec) OR (NOT GraphMgtGeneralTools.IsApiEnabled) THEN
            EXIT;

        InsertOrModifyFromPurchaseHeader(Rec);
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyPurchaseHeader(var Rec: Record "38"; var xRec: Record "38"; RunTrigger: Boolean)
    begin
        IF NOT CheckValidRecord(Rec) OR (NOT GraphMgtGeneralTools.IsApiEnabled) THEN
            EXIT;

        InsertOrModifyFromPurchaseHeader(Rec);
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeletePurchaseHeader(var Rec: Record "38"; RunTrigger: Boolean)
    var
        PurchInvEntityAggregate: Record "5477";
    begin
        IF NOT CheckValidRecord(Rec) OR (NOT GraphMgtGeneralTools.IsApiEnabled) THEN
            EXIT;

        TransferIntegrationRecordID(Rec);

        IF NOT PurchInvEntityAggregate.GET(Rec."No.", FALSE) THEN
            EXIT;
        PurchInvEntityAggregate.DELETE;
    end;

    [EventSubscriber(ObjectType::Codeunit, 66, 'OnAfterResetRecalculateInvoiceDisc', '', false, false)]
    local procedure OnAfterResetRecalculateInvoiceDisc(var PurchaseHeader: Record "38")
    begin
        IF NOT CheckValidRecord(PurchaseHeader) OR (NOT GraphMgtGeneralTools.IsApiEnabled) THEN
            EXIT;

        InsertOrModifyFromPurchaseHeader(PurchaseHeader);
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertPurchaseLine(var Rec: Record "39"; RunTrigger: Boolean)
    begin
        IF NOT CheckValidLineRecord(Rec) THEN
            EXIT;

        ModifyTotalsPurchaseLine(Rec);
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyPurchaseLine(var Rec: Record "39"; var xRec: Record "39"; RunTrigger: Boolean)
    begin
        IF NOT CheckValidLineRecord(Rec) THEN
            EXIT;

        ModifyTotalsPurchaseLine(Rec);
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeletePurchaseLine(var Rec: Record "39"; RunTrigger: Boolean)
    var
        PurchaseLine: Record "39";
    begin
        PurchaseLine.SETRANGE("Document No.", Rec."Document No.");
        PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
        PurchaseLine.SETRANGE("Recalculate Invoice Disc.", TRUE);

        IF PurchaseLine.FINDFIRST THEN BEGIN
            ModifyTotalsPurchaseLine(PurchaseLine);
            EXIT;
        END;

        PurchaseLine.SETRANGE("Recalculate Invoice Disc.");

        IF NOT PurchaseLine.FINDFIRST THEN
            BlankTotals(Rec."Document No.", FALSE);
    end;

    [EventSubscriber(ObjectType::Table, 122, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertPurchaseInvoiceHeader(var Rec: Record "122"; RunTrigger: Boolean)
    begin
        IF Rec.ISTEMPORARY OR (NOT GraphMgtGeneralTools.IsApiEnabled) THEN
            EXIT;

        InsertOrModifyFromPurchaseInvoiceHeader(Rec);
    end;

    [EventSubscriber(ObjectType::Table, 122, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyPurchaseInvoiceHeader(var Rec: Record "122"; var xRec: Record "122"; RunTrigger: Boolean)
    begin
        IF Rec.ISTEMPORARY OR (NOT GraphMgtGeneralTools.IsApiEnabled) THEN
            EXIT;

        InsertOrModifyFromPurchaseInvoiceHeader(Rec);
    end;

    [EventSubscriber(ObjectType::Table, 122, 'OnAfterRenameEvent', '', false, false)]
    local procedure OnAfterRenamePurchaseInvoiceHeader(var Rec: Record "122"; var xRec: Record "122"; RunTrigger: Boolean)
    var
        PurchInvEntityAggregate: Record "5477";
    begin
        IF Rec.ISTEMPORARY OR (NOT GraphMgtGeneralTools.IsApiEnabled) THEN
            EXIT;

        IF NOT PurchInvEntityAggregate.GET(xRec."No.", TRUE) THEN
            EXIT;

        PurchInvEntityAggregate.SetIsRenameAllowed(TRUE);
        PurchInvEntityAggregate.RENAME(Rec."No.", TRUE);
    end;

    [EventSubscriber(ObjectType::Table, 122, 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeletePurchaseInvoiceHeader(var Rec: Record "122"; RunTrigger: Boolean)
    var
        PurchInvEntityAggregate: Record "5477";
    begin
        IF Rec.ISTEMPORARY OR (NOT GraphMgtGeneralTools.IsApiEnabled) THEN
            EXIT;

        IF NOT PurchInvEntityAggregate.GET(Rec."No.", TRUE) THEN
            EXIT;

        PurchInvEntityAggregate.DELETE;
    end;

    [EventSubscriber(ObjectType::Codeunit, 70, 'OnAfterCalcPurchaseDiscount', '', false, false)]
    local procedure OnAfterCalculatePurchaseDiscountOnPurchaseHeader(var PurchaseHeader: Record "38")
    begin
        IF NOT CheckValidRecord(PurchaseHeader) OR (NOT GraphMgtGeneralTools.IsApiEnabled) THEN
            EXIT;

        InsertOrModifyFromPurchaseHeader(PurchaseHeader);
    end;

    [EventSubscriber(ObjectType::Table, 25, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertVendorLedgerEntry(var Rec: Record "25"; RunTrigger: Boolean)
    begin
        IF Rec.ISTEMPORARY OR (NOT GraphMgtGeneralTools.IsApiEnabled) THEN
            EXIT;

        SetStatusOptionFromVendLedgerEntry(Rec);
    end;

    [EventSubscriber(ObjectType::Table, 25, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyVendorLedgerEntry(var Rec: Record "25"; var xRec: Record "25"; RunTrigger: Boolean)
    begin
        IF Rec.ISTEMPORARY OR (NOT GraphMgtGeneralTools.IsApiEnabled) THEN
            EXIT;

        SetStatusOptionFromVendLedgerEntry(Rec);
    end;

    [EventSubscriber(ObjectType::Table, 25, 'OnAfterRenameEvent', '', false, false)]
    local procedure OnAfterRenameVendorLedgerEntry(var Rec: Record "25"; var xRec: Record "25"; RunTrigger: Boolean)
    begin
        IF Rec.ISTEMPORARY OR (NOT GraphMgtGeneralTools.IsApiEnabled) THEN
            EXIT;

        SetStatusOptionFromVendLedgerEntry(Rec);
    end;

    [EventSubscriber(ObjectType::Table, 25, 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeleteVendorLedgerEntry(var Rec: Record "25"; RunTrigger: Boolean)
    begin
        IF Rec.ISTEMPORARY OR (NOT GraphMgtGeneralTools.IsApiEnabled) THEN
            EXIT;

        SetStatusOptionFromVendLedgerEntry(Rec);
    end;

    [EventSubscriber(ObjectType::Table, 1900, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertCancelledDocument(var Rec: Record "1900"; RunTrigger: Boolean)
    begin
        IF Rec.ISTEMPORARY OR (NOT GraphMgtGeneralTools.IsApiEnabled) THEN
            EXIT;

        SetStatusOptionFromCancelledDocument(Rec);
    end;

    [EventSubscriber(ObjectType::Table, 1900, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyCancelledDocument(var Rec: Record "1900"; var xRec: Record "1900"; RunTrigger: Boolean)
    begin
        IF Rec.ISTEMPORARY OR (NOT GraphMgtGeneralTools.IsApiEnabled) THEN
            EXIT;

        SetStatusOptionFromCancelledDocument(Rec);
    end;

    [EventSubscriber(ObjectType::Table, 1900, 'OnAfterRenameEvent', '', false, false)]
    local procedure OnAfterRenameCancelledDocument(var Rec: Record "1900"; var xRec: Record "1900"; RunTrigger: Boolean)
    begin
        IF Rec.ISTEMPORARY OR (NOT GraphMgtGeneralTools.IsApiEnabled) THEN
            EXIT;

        SetStatusOptionFromCancelledDocument(xRec);
        SetStatusOptionFromCancelledDocument(Rec);
    end;

    [EventSubscriber(ObjectType::Table, 1900, 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeleteCancelledDocument(var Rec: Record "1900"; RunTrigger: Boolean)
    begin
        IF Rec.ISTEMPORARY OR (NOT GraphMgtGeneralTools.IsApiEnabled) THEN
            EXIT;

        SetStatusOptionFromCancelledDocument(Rec);
    end;

    [Scope('Internal')]
    procedure PropagateOnInsert(var PurchInvEntityAggregate: Record "5477"; var TempFieldBuffer: Record "8450" temporary)
    var
        PurchaseHeader: Record "38";
        TargetRecordRef: RecordRef;
        DocTypeFieldRef: FieldRef;
        NoFieldRef: FieldRef;
    begin
        IF PurchInvEntityAggregate.ISTEMPORARY OR (NOT GraphMgtGeneralTools.IsApiEnabled) THEN
            EXIT;

        IF PurchInvEntityAggregate.Posted THEN
            ERROR(CannotInsertPostedInvoiceErr);

        TargetRecordRef.OPEN(DATABASE::"Purchase Header");

        DocTypeFieldRef := TargetRecordRef.FIELD(PurchaseHeader.FIELDNO("Document Type"));
        //DocTypeFieldRef.VALUE(PurchaseHeader."Document Type"::Invoice);
        DocTypeFieldRef.VALUE(PurchaseHeader."Document Type"::Order); //SRT July 4th 2019
        NoFieldRef := TargetRecordRef.FIELD(PurchaseHeader.FIELDNO("No."));

        TransferFieldsWithValidate(TempFieldBuffer, PurchInvEntityAggregate, TargetRecordRef);

        TargetRecordRef.INSERT(TRUE);

        PurchInvEntityAggregate."No." := NoFieldRef.VALUE;
        PurchInvEntityAggregate.FIND;
    end;

    [Scope('Internal')]
    procedure PropagateOnModify(var PurchInvEntityAggregate: Record "5477"; var TempFieldBuffer: Record "8450" temporary)
    var
        PurchaseHeader: Record "38";
        TargetRecordRef: RecordRef;
        Exists: Boolean;
    begin
        IF PurchInvEntityAggregate.ISTEMPORARY OR (NOT GraphMgtGeneralTools.IsApiEnabled) THEN
            EXIT;

        IF PurchInvEntityAggregate.Posted THEN
            ERROR(CannotModifyPostedInvioceErr);

        //Exists := PurchaseHeader.GET(PurchaseHeader."Document Type"::Invoice,PurchInvEntityAggregate."No.");
        Exists := PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, PurchInvEntityAggregate."No."); //SRT July 4th 2019
        IF Exists THEN
            TargetRecordRef.GETTABLE(PurchaseHeader)
        ELSE
            TargetRecordRef.OPEN(DATABASE::"Purchase Header");

        TransferFieldsWithValidate(TempFieldBuffer, PurchInvEntityAggregate, TargetRecordRef);

        IF Exists THEN
            TargetRecordRef.MODIFY(TRUE)
        ELSE
            TargetRecordRef.INSERT(TRUE);
    end;

    [Scope('Internal')]
    procedure PropagateOnDelete(var PurchInvEntityAggregate: Record "5477")
    var
        PurchInvHeader: Record "122";
        PurchaseHeader: Record "38";
    begin
        IF PurchInvEntityAggregate.ISTEMPORARY OR (NOT GraphMgtGeneralTools.IsApiEnabled) THEN
            EXIT;

        IF PurchInvEntityAggregate.Posted THEN BEGIN
            PurchInvHeader.GET(PurchInvEntityAggregate."No.");
            IF PurchInvHeader."No. Printed" = 0 THEN
                PurchInvHeader."No. Printed" := 1;
            PurchInvHeader.DELETE(TRUE);
        END ELSE BEGIN
            //PurchaseHeader.GET(PurchaseHeader."Document Type"::Invoice,PurchInvEntityAggregate."No.");
            PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, PurchInvEntityAggregate."No."); //SRT July 4th 2019
            PurchaseHeader.DELETE(TRUE);
        END;
    end;

    [Scope('Internal')]
    procedure UpdateAggregateTableRecords()
    var
        PurchaseHeader: Record "38";
        PurchInvHeader: Record "122";
        PurchInvEntityAggregate: Record "5477";
    begin
        //PurchaseHeader.SETRANGE("Document Type",PurchaseHeader."Document Type"::Invoice);
        PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order); //SRT July 4th 2019
        IF PurchaseHeader.FINDSET THEN
            REPEAT
                InsertOrModifyFromPurchaseHeader(PurchaseHeader);
            UNTIL PurchaseHeader.NEXT = 0;

        IF PurchInvHeader.FINDSET THEN
            REPEAT
                InsertOrModifyFromPurchaseInvoiceHeader(PurchInvHeader);
            UNTIL PurchInvHeader.NEXT = 0;

        PurchInvEntityAggregate.SETRANGE(Posted, FALSE);
        IF PurchInvEntityAggregate.FINDSET(TRUE, FALSE) THEN
            REPEAT
                //IF NOT PurchaseHeader.GET(PurchaseHeader."Document Type"::Invoice,PurchInvEntityAggregate."No.") THEN
                IF NOT PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, PurchInvEntityAggregate."No.") THEN //SRT July 4th 2019
                    PurchInvEntityAggregate.DELETE(TRUE);
            UNTIL PurchInvEntityAggregate.NEXT = 0;

        PurchInvEntityAggregate.SETRANGE(Posted, TRUE);
        IF PurchInvEntityAggregate.FINDSET(TRUE, FALSE) THEN
            REPEAT
                IF NOT PurchInvHeader.GET(PurchInvEntityAggregate."No.") THEN
                    PurchInvEntityAggregate.DELETE(TRUE);
            UNTIL PurchInvEntityAggregate.NEXT = 0;
    end;

    local procedure InsertOrModifyFromPurchaseHeader(var PurchaseHeader: Record "38")
    var
        PurchInvEntityAggregate: Record "5477";
        RecordExists: Boolean;
    begin
        PurchInvEntityAggregate.LOCKTABLE;
        RecordExists := PurchInvEntityAggregate.GET(PurchaseHeader."No.", FALSE);

        PurchInvEntityAggregate.TRANSFERFIELDS(PurchaseHeader, TRUE);
        PurchInvEntityAggregate.Posted := FALSE;
        PurchInvEntityAggregate.Status := PurchInvEntityAggregate.Status::Draft;
        AssignTotalsFromPurchaseHeader(PurchaseHeader, PurchInvEntityAggregate);
        PurchInvEntityAggregate.UpdateReferencedRecordIds;

        IF RecordExists THEN
            PurchInvEntityAggregate.MODIFY(TRUE)
        ELSE
            PurchInvEntityAggregate.INSERT(TRUE);
    end;

    local procedure InsertOrModifyFromPurchaseInvoiceHeader(var PurchInvHeader: Record "122")
    var
        PurchInvEntityAggregate: Record "5477";
        RecordExists: Boolean;
    begin
        PurchInvEntityAggregate.LOCKTABLE;
        RecordExists := PurchInvEntityAggregate.GET(PurchInvHeader."No.", TRUE);
        PurchInvEntityAggregate.TRANSFERFIELDS(PurchInvHeader, TRUE);
        PurchInvEntityAggregate.Posted := TRUE;
        SetStatusOptionFromPurchaseInvoiceHeader(PurchInvHeader, PurchInvEntityAggregate);
        AssignTotalsFromPurchaseInvoiceHeader(PurchInvHeader, PurchInvEntityAggregate);
        PurchInvEntityAggregate.UpdateReferencedRecordIds;

        IF RecordExists THEN
            PurchInvEntityAggregate.MODIFY(TRUE)
        ELSE
            PurchInvEntityAggregate.INSERT(TRUE);
    end;

    local procedure SetStatusOptionFromPurchaseInvoiceHeader(var PurchInvHeader: Record "122"; var PurchInvEntityAggregate: Record "5477")
    begin
        PurchInvHeader.CALCFIELDS(Cancelled, Closed, Corrective);
        IF PurchInvHeader.Cancelled THEN BEGIN
            PurchInvEntityAggregate.Status := PurchInvEntityAggregate.Status::Canceled;
            EXIT;
        END;

        IF PurchInvHeader.Corrective THEN BEGIN
            PurchInvEntityAggregate.Status := PurchInvEntityAggregate.Status::Corrective;
            EXIT;
        END;

        IF PurchInvHeader.Closed THEN BEGIN
            PurchInvEntityAggregate.Status := PurchInvEntityAggregate.Status::Paid;
            EXIT;
        END;

        PurchInvEntityAggregate.Status := PurchInvEntityAggregate.Status::Open;
    end;

    local procedure SetStatusOptionFromVendLedgerEntry(var VendorLedgerEntry: Record "25")
    var
        PurchInvEntityAggregate: Record "5477";
    begin
        IF NOT GraphMgtGeneralTools.IsApiEnabled THEN
            EXIT;

        PurchInvEntityAggregate.SETRANGE("Vendor Ledger Entry No.", VendorLedgerEntry."Entry No.");
        PurchInvEntityAggregate.SETRANGE(Posted, TRUE);

        IF NOT PurchInvEntityAggregate.FINDSET(TRUE) THEN
            EXIT;

        REPEAT
            UpdateStatusIfChanged(PurchInvEntityAggregate);
        UNTIL PurchInvEntityAggregate.NEXT = 0;
    end;

    local procedure SetStatusOptionFromCancelledDocument(var CancelledDocument: Record "1900")
    var
        PurchInvEntityAggregate: Record "5477";
    begin
        IF NOT GraphMgtGeneralTools.IsApiEnabled THEN
            EXIT;

        CASE CancelledDocument."Source ID" OF
            DATABASE::"Purch. Inv. Header":
                IF NOT PurchInvEntityAggregate.GET(CancelledDocument."Cancelled Doc. No.", TRUE) THEN
                    EXIT;
            DATABASE::"Purch. Cr. Memo Hdr.":
                IF NOT PurchInvEntityAggregate.GET(CancelledDocument."Cancelled By Doc. No.", TRUE) THEN
                    EXIT;
            ELSE
                EXIT;
        END;

        UpdateStatusIfChanged(PurchInvEntityAggregate);
    end;

    [Scope('Internal')]
    procedure UpdateUnitOfMeasure(var Item: Record "27"; JSONUnitOfMeasureTxt: Text)
    var
        TempFieldSet: Record "2000000041" temporary;
        GraphCollectionMgtItem: Codeunit "5470";
        ItemModified: Boolean;
    begin
        GraphCollectionMgtItem.UpdateOrCreateItemUnitOfMeasureFromSalesDocument(JSONUnitOfMeasureTxt, Item, TempFieldSet, ItemModified);

        IF ItemModified THEN
            Item.MODIFY(TRUE);
    end;

    local procedure UpdateStatusIfChanged(var PurchInvEntityAggregate: Record "5477")
    var
        PurchInvHeader: Record "122";
        CurrentStatus: Option;
    begin
        PurchInvHeader.GET(PurchInvEntityAggregate."No.");
        CurrentStatus := PurchInvEntityAggregate.Status;

        SetStatusOptionFromPurchaseInvoiceHeader(PurchInvHeader, PurchInvEntityAggregate);
        IF CurrentStatus <> PurchInvEntityAggregate.Status THEN
            PurchInvEntityAggregate.MODIFY(TRUE);
    end;

    local procedure AssignTotalsFromPurchaseHeader(var PurchaseHeader: Record "38"; var PurchInvEntityAggregate: Record "5477")
    var
        PurchaseLine: Record "39";
    begin
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");

        IF NOT PurchaseLine.FINDFIRST THEN BEGIN
            BlankTotals(PurchaseLine."Document No.", FALSE);
            EXIT;
        END;

        AssignTotalsFromPurchaseLine(PurchaseLine, PurchInvEntityAggregate, PurchaseHeader);
    end;

    local procedure AssignTotalsFromPurchaseInvoiceHeader(var PurchInvHeader: Record "122"; var PurchInvEntityAggregate: Record "5477")
    var
        PurchInvLine: Record "123";
    begin
        PurchInvLine.SETRANGE("Document No.", PurchInvHeader."No.");

        IF NOT PurchInvLine.FINDFIRST THEN BEGIN
            BlankTotals(PurchInvLine."Document No.", TRUE);
            EXIT;
        END;

        AssignTotalsFromPurchaseInvoiceLine(PurchInvLine, PurchInvEntityAggregate);
    end;

    local procedure AssignTotalsFromPurchaseLine(var PurchaseLine: Record "39"; var PurchInvEntityAggregate: Record "5477"; var PurchaseHeader: Record "38")
    var
        TotalPurchaseLine: Record "39";
        DocumentTotals: Codeunit "57";
        VATAmount: Decimal;
    begin
        IF PurchaseLine."VAT Calculation Type" = PurchaseLine."VAT Calculation Type"::"Sales Tax" THEN BEGIN
            PurchInvEntityAggregate."Discount Applied Before Tax" := TRUE;
            PurchInvEntityAggregate."Prices Including VAT" := FALSE;
        END ELSE
            PurchInvEntityAggregate."Discount Applied Before Tax" := NOT PurchaseHeader."Prices Including VAT";

        DocumentTotals.CalculatePurchaseTotals(TotalPurchaseLine, VATAmount, PurchaseLine);

        PurchInvEntityAggregate."Invoice Discount Amount" := TotalPurchaseLine."Inv. Discount Amount";
        PurchInvEntityAggregate.Amount := TotalPurchaseLine.Amount;
        PurchInvEntityAggregate."Total Tax Amount" := VATAmount;
        PurchInvEntityAggregate."Amount Including VAT" := TotalPurchaseLine."Amount Including VAT";
    end;

    local procedure AssignTotalsFromPurchaseInvoiceLine(var PurchInvLine: Record "123"; var PurchInvEntityAggregate: Record "5477")
    var
        PurchInvHeader: Record "122";
        TotalPurchInvHeader: Record "122";
        DocumentTotals: Codeunit "57";
        VATAmount: Decimal;
    begin
        IF PurchInvLine."VAT Calculation Type" = PurchInvLine."VAT Calculation Type"::"Sales Tax" THEN
            PurchInvEntityAggregate."Discount Applied Before Tax" := TRUE
        ELSE BEGIN
            PurchInvHeader.GET(PurchInvLine."Document No.");
            PurchInvEntityAggregate."Discount Applied Before Tax" := NOT PurchInvHeader."Prices Including VAT";
        END;

        DocumentTotals.CalculatePostedPurchInvoiceTotals(TotalPurchInvHeader, VATAmount, PurchInvLine);

        PurchInvEntityAggregate."Invoice Discount Amount" := TotalPurchInvHeader."Invoice Discount Amount";
        PurchInvEntityAggregate.Amount := TotalPurchInvHeader.Amount;
        PurchInvEntityAggregate."Total Tax Amount" := VATAmount;
        PurchInvEntityAggregate."Amount Including VAT" := TotalPurchInvHeader."Amount Including VAT";
    end;

    local procedure BlankTotals(DocumentNo: Code[20]; Posted: Boolean)
    var
        PurchInvEntityAggregate: Record "5477";
    begin
        IF NOT PurchInvEntityAggregate.GET(DocumentNo, Posted) THEN
            EXIT;

        PurchInvEntityAggregate."Invoice Discount Amount" := 0;
        PurchInvEntityAggregate."Total Tax Amount" := 0;

        PurchInvEntityAggregate.Amount := 0;
        PurchInvEntityAggregate."Amount Including VAT" := 0;
        PurchInvEntityAggregate.MODIFY;
    end;

    local procedure CheckValidRecord(var PurchaseHeader: Record "38"): Boolean
    begin
        IF PurchaseHeader.ISTEMPORARY THEN
            EXIT(FALSE);

        //IF PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Invoice THEN
        IF PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order THEN //SRT July 4th 2019
            EXIT(FALSE);

        EXIT(TRUE);
    end;

    local procedure ModifyTotalsPurchaseLine(var PurchaseLine: Record "39")
    var
        PurchInvEntityAggregate: Record "5477";
        PurchaseHeader: Record "38";
    begin
        IF PurchaseLine.ISTEMPORARY OR (NOT GraphMgtGeneralTools.IsApiEnabled) THEN
            EXIT;

        //IF PurchaseLine."Document Type" <> PurchaseLine."Document Type"::Invoice THEN
        IF PurchaseLine."Document Type" <> PurchaseLine."Document Type"::Order THEN //SRT July 4th 2019
            EXIT;

        IF NOT PurchInvEntityAggregate.GET(PurchaseLine."Document No.", FALSE) THEN
            EXIT;

        IF NOT PurchaseLine."Recalculate Invoice Disc." THEN
            EXIT;

        IF NOT PurchaseHeader.GET(PurchaseLine."Document Type", PurchaseLine."Document No.") THEN
            EXIT;

        AssignTotalsFromPurchaseLine(PurchaseLine, PurchInvEntityAggregate, PurchaseHeader);
        PurchInvEntityAggregate.MODIFY(TRUE);
    end;

    local procedure TransferPurchaseInvoiceLineAggregateToPurchaseLine(var PurchInvLineAggregate: Record "5478"; var PurchaseLine: Record "39"; var TempFieldBuffer: Record "8450" temporary)
    var
        PurchaseLineRecordRef: RecordRef;
    begin
        //PurchaseLine."Document Type" := PurchaseLine."Document Type"::Invoice;
        PurchaseLine."Document Type" := PurchaseLine."Document Type"::Order; //SRT July 4th 2019
        PurchaseLineRecordRef.GETTABLE(PurchaseLine);

        TransferFieldsWithValidate(TempFieldBuffer, PurchInvLineAggregate, PurchaseLineRecordRef);

        PurchaseLineRecordRef.SETTABLE(PurchaseLine);
    end;

    local procedure TransferIntegrationRecordID(var PurchaseHeader: Record "38")
    var
        PurchInvHeader: Record "122";
        NewIntegrationRecord: Record "5151";
        OldIntegrationRecord: Record "5151";
        IntegrationManagement: Codeunit "5150";
        PurchaseInvoiceHeaderRecordRef: RecordRef;
    begin
        IF ISNULLGUID(PurchaseHeader.Id) THEN
            EXIT;

        PurchInvHeader.SETRANGE("Pre-Assigned No.", PurchaseHeader."No.");
        IF NOT PurchInvHeader.FINDFIRST THEN
            EXIT;

        IF PurchInvHeader.Id = PurchaseHeader.Id THEN
            EXIT;

        IF OldIntegrationRecord.GET(PurchaseHeader.Id) THEN
            OldIntegrationRecord.DELETE;

        IF NewIntegrationRecord.GET(PurchInvHeader.Id) THEN
            NewIntegrationRecord.DELETE;

        PurchInvHeader.Id := PurchaseHeader.Id;
        PurchInvHeader.MODIFY(TRUE);
        PurchaseInvoiceHeaderRecordRef.GETTABLE(PurchInvHeader);

        IntegrationManagement.InsertUpdateIntegrationRecord(PurchaseInvoiceHeaderRecordRef, CURRENTDATETIME);
    end;

    local procedure TransferFieldsWithValidate(var TempFieldBuffer: Record "8450" temporary; RecordVariant: Variant; var TargetTableRecRef: RecordRef)
    var
        DataTypeManagement: Codeunit "701";
        SourceRecRef: RecordRef;
        TargetFieldRef: FieldRef;
        SourceFieldRef: FieldRef;
    begin
        DataTypeManagement.GetRecordRef(RecordVariant, SourceRecRef);

        TempFieldBuffer.RESET;
        IF NOT TempFieldBuffer.FINDFIRST THEN
            EXIT;

        REPEAT
            IF TargetTableRecRef.FIELDEXIST(TempFieldBuffer."Field ID") THEN BEGIN
                SourceFieldRef := SourceRecRef.FIELD(TempFieldBuffer."Field ID");
                TargetFieldRef := TargetTableRecRef.FIELD(TempFieldBuffer."Field ID");
                TargetFieldRef.VALIDATE(SourceFieldRef.VALUE);
            END;
        UNTIL TempFieldBuffer.NEXT = 0;
    end;

    [Scope('Internal')]
    procedure RedistributeInvoiceDiscounts(var PurchInvEntityAggregate: Record "5477")
    var
        PurchaseLine: Record "39";
    begin
        IF PurchInvEntityAggregate.Posted THEN
            EXIT;

        //PurchaseLine.SETRANGE("Document Type",PurchaseLine."Document Type"::Invoice);
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order); //SRT July 4th 2019
        PurchaseLine.SETRANGE("Document No.", PurchInvEntityAggregate."No.");
        PurchaseLine.SETRANGE("Recalculate Invoice Disc.", TRUE);
        IF PurchaseLine.FINDFIRST THEN
            CODEUNIT.RUN(CODEUNIT::"Purch - Calc Disc. By Type", PurchaseLine);

        PurchInvEntityAggregate.FIND;
    end;

    [Scope('Internal')]
    procedure LoadLines(var PurchInvLineAggregate: Record "5478"; DocumentIdFilter: Text)
    var
        PurchInvEntityAggregate: Record "5477";
    begin
        IF DocumentIdFilter = '' THEN
            ERROR(DocumentIDNotSpecifiedErr);

        PurchInvEntityAggregate.SETFILTER(Id, DocumentIdFilter);
        IF NOT PurchInvEntityAggregate.FINDFIRST THEN
            EXIT;

        IF PurchInvEntityAggregate.Posted THEN
            LoadPurchaseInvoiceLines(PurchInvLineAggregate, PurchInvEntityAggregate)
        ELSE
            LoadPurchaseLines(PurchInvLineAggregate, PurchInvEntityAggregate);
    end;

    local procedure LoadPurchaseInvoiceLines(var PurchInvLineAggregate: Record "5478"; var PurchInvEntityAggregate: Record "5477")
    var
        PurchInvLine: Record "123";
    begin
        PurchInvLine.SETRANGE("Document No.", PurchInvEntityAggregate."No.");

        IF PurchInvLine.FINDSET(FALSE, FALSE) THEN
            REPEAT
                CLEAR(PurchInvLineAggregate);
                PurchInvLineAggregate.TRANSFERFIELDS(PurchInvLine, TRUE);
                PurchInvLineAggregate."Document Id" := PurchInvEntityAggregate.Id;
                IF PurchInvLine."VAT Calculation Type" = PurchInvLine."VAT Calculation Type"::"Sales Tax" THEN
                    PurchInvLineAggregate."Tax Code" := PurchInvLine."Tax Group Code"
                ELSE
                    PurchInvLineAggregate."Tax Code" := PurchInvLine."VAT Identifier";

                PurchInvLineAggregate."VAT %" := PurchInvLine."VAT %";
                PurchInvLineAggregate."Tax Amount" := PurchInvLine."Amount Including VAT" - PurchInvLine."VAT Base Amount";
                PurchInvLineAggregate."Currency Code" := PurchInvLine.GetCurrencyCode;
                PurchInvLineAggregate."Prices Including Tax" := PurchInvEntityAggregate."Prices Including VAT";
                PurchInvLineAggregate.UpdateReferencedRecordIds;
                UpdateLineAmountsFromPurchaseInvoiceLine(PurchInvLineAggregate);
                PurchInvLineAggregate.INSERT(TRUE);
            UNTIL PurchInvLine.NEXT = 0;
    end;

    local procedure LoadPurchaseLines(var PurchInvLineAggregate: Record "5478"; var PurchInvEntityAggregate: Record "5477")
    var
        PurchaseLine: Record "39";
    begin
        //PurchaseLine.SETRANGE("Document Type",PurchaseLine."Document Type"::Invoice);
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order); //SRT July 4th 2019
        PurchaseLine.SETRANGE("Document No.", PurchInvEntityAggregate."No.");

        IF PurchaseLine.FINDSET(FALSE, FALSE) THEN
            REPEAT
                TransferFromPurchaseLine(PurchInvLineAggregate, PurchInvEntityAggregate, PurchaseLine);
                PurchInvLineAggregate.INSERT(TRUE);
            UNTIL PurchaseLine.NEXT = 0;
    end;

    local procedure TransferFromPurchaseLine(var PurchInvLineAggregate: Record "5478"; var PurchInvEntityAggregate: Record "5477"; var PurchaseLine: Record "39")
    begin
        CLEAR(PurchInvLineAggregate);
        PurchInvLineAggregate.TRANSFERFIELDS(PurchaseLine, TRUE);
        PurchInvLineAggregate."Document Id" := PurchInvEntityAggregate.Id;
        IF PurchaseLine."VAT Calculation Type" = PurchaseLine."VAT Calculation Type"::"Sales Tax" THEN
            PurchInvLineAggregate."Tax Code" := PurchaseLine."Tax Group Code"
        ELSE
            PurchInvLineAggregate."Tax Code" := PurchaseLine."VAT Identifier";

        PurchInvLineAggregate."VAT %" := PurchaseLine."VAT %";
        PurchInvLineAggregate."Tax Amount" := PurchaseLine."Amount Including VAT" - PurchaseLine."VAT Base Amount";
        PurchInvLineAggregate."Prices Including Tax" := PurchInvEntityAggregate."Prices Including VAT";
        PurchInvLineAggregate.UpdateReferencedRecordIds;
        UpdateLineAmountsFromPurchaseLine(PurchInvLineAggregate);
    end;

    [Scope('Internal')]
    procedure PropagateInsertLine(var PurchInvLineAggregate: Record "5478"; var TempFieldBuffer: Record "8450" temporary)
    var
        PurchInvEntityAggregate: Record "5477";
        PurchaseLine: Record "39";
        LastUsedPurchaseLine: Record "39";
    begin
        VerifyCRUDIsPossibleForLine(PurchInvLineAggregate, PurchInvEntityAggregate);

        PurchaseLine."Document Type" := PurchaseLine."Document Type"::Order; //SRT July 4th 2019
        PurchaseLine."Document No." := PurchInvEntityAggregate."No.";

        IF PurchInvLineAggregate."Line No." = 0 THEN BEGIN
            LastUsedPurchaseLine.SETRANGE("Document No.", PurchInvEntityAggregate."No.");
            LastUsedPurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order); //SRT July 4th 2019
            IF LastUsedPurchaseLine.FINDLAST THEN
                PurchInvLineAggregate."Line No." := LastUsedPurchaseLine."Line No." + 10000
            ELSE
                PurchInvLineAggregate."Line No." := 10000;

            PurchaseLine."Line No." := PurchInvLineAggregate."Line No.";
        END ELSE
            //IF PurchaseLine.GET(PurchaseLine."Document Type"::Invoice,PurchInvEntityAggregate."No.",PurchInvLineAggregate."Line No.") THEN
            IF PurchaseLine.GET(PurchaseLine."Document Type"::Order, PurchInvEntityAggregate."No.", PurchInvLineAggregate."Line No.") THEN //SRT July 4th 2019
                ERROR(CannotInsertALineThatAlreadyExistsErr);

        TransferPurchaseInvoiceLineAggregateToPurchaseLine(PurchInvLineAggregate, PurchaseLine, TempFieldBuffer);
        PurchaseLine.CheckDuplicateItemLine; //SRT Feb 28th 2020
        PurchaseLine.INSERT(TRUE);

        RedistributeInvoiceDiscounts(PurchInvEntityAggregate);

        PurchaseLine.FIND;
        TransferFromPurchaseLine(PurchInvLineAggregate, PurchInvEntityAggregate, PurchaseLine);
    end;

    [Scope('Internal')]
    procedure PropagateModifyLine(var PurchInvLineAggregate: Record "5478"; var TempFieldBuffer: Record "8450" temporary)
    var
        PurchInvEntityAggregate: Record "5477";
        PurchaseLine: Record "39";
    begin
        VerifyCRUDIsPossibleForLine(PurchInvLineAggregate, PurchInvEntityAggregate);

        //IF NOT PurchaseLine.GET(PurchaseLine."Document Type"::Invoice,PurchInvEntityAggregate."No.",PurchInvLineAggregate."Line No.") THEN
        IF NOT PurchaseLine.GET(PurchaseLine."Document Type"::Order, PurchInvEntityAggregate."No.", PurchInvLineAggregate."Line No.") THEN //SRT July 4th 2019
            ERROR(CannotModifyALineThatDoesntExistErr);

        TransferPurchaseInvoiceLineAggregateToPurchaseLine(PurchInvLineAggregate, PurchaseLine, TempFieldBuffer);

        PurchaseLine.MODIFY(TRUE);

        RedistributeInvoiceDiscounts(PurchInvEntityAggregate);

        PurchaseLine.FIND;
        TransferFromPurchaseLine(PurchInvLineAggregate, PurchInvEntityAggregate, PurchaseLine);
    end;

    [Scope('Internal')]
    procedure PropagateDeleteLine(var PurchInvLineAggregate: Record "5478")
    var
        PurchInvEntityAggregate: Record "5477";
        PurchaseLine: Record "39";
    begin
        VerifyCRUDIsPossibleForLine(PurchInvLineAggregate, PurchInvEntityAggregate);

        //IF PurchaseLine.GET(PurchaseLine."Document Type"::Invoice,PurchInvEntityAggregate."No.",PurchInvLineAggregate."Line No.") THEN BEGIN
        IF PurchaseLine.GET(PurchaseLine."Document Type"::Order, PurchInvEntityAggregate."No.", PurchInvLineAggregate."Line No.") THEN BEGIN //SRT July 4th 2019
            PurchaseLine.DELETE(TRUE);
            RedistributeInvoiceDiscounts(PurchInvEntityAggregate);
        END;
    end;

    local procedure VerifyCRUDIsPossibleForLine(var PurchInvLineAggregate: Record "5478"; var PurchInvEntityAggregate: Record "5477")
    var
        SearchPurchInvEntityAggregate: Record "5477";
        DocumentIDFilter: Text;
    begin
        IF ISNULLGUID(PurchInvLineAggregate."Document Id") THEN BEGIN
            DocumentIDFilter := PurchInvLineAggregate.GETFILTER("Document Id");
            IF DocumentIDFilter = '' THEN
                ERROR(DocumentIDNotSpecifiedErr);
            PurchInvEntityAggregate.SETFILTER(Id, DocumentIDFilter);
        END ELSE
            PurchInvEntityAggregate.SETRANGE(Id, PurchInvLineAggregate."Document Id");

        IF NOT PurchInvEntityAggregate.FINDFIRST THEN
            ERROR(DocumentDoesNotExistErr);

        SearchPurchInvEntityAggregate.COPY(PurchInvEntityAggregate);
        IF SearchPurchInvEntityAggregate.NEXT <> 0 THEN
            ERROR(MultipleDocumentsFoundForIdErr);

        IF PurchInvEntityAggregate.Posted THEN
            ERROR(CannotModifyPostedInvioceErr);
    end;

    local procedure UpdateLineAmountsFromPurchaseLine(var PurchInvLineAggregate: Record "5478")
    begin
        PurchInvLineAggregate."Line Tax Amount" :=
          PurchInvLineAggregate."Line Amount Including Tax" - PurchInvLineAggregate."Line Amount Excluding Tax";
        UpdateInvoiceDiscountAmount(PurchInvLineAggregate);
    end;

    local procedure UpdateLineAmountsFromPurchaseInvoiceLine(var PurchInvLineAggregate: Record "5478")
    begin
        PurchInvLineAggregate."Line Tax Amount" :=
          PurchInvLineAggregate."Line Amount Including Tax" - PurchInvLineAggregate."Line Amount Excluding Tax";
        UpdateInvoiceDiscountAmount(PurchInvLineAggregate);
    end;

    local procedure UpdateInvoiceDiscountAmount(var PurchInvLineAggregate: Record "5478")
    begin
        IF PurchInvLineAggregate."Prices Including Tax" THEN
            PurchInvLineAggregate."Inv. Discount Amount Excl. VAT" :=
              PurchInvLineAggregate."Line Amount Excluding Tax" - PurchInvLineAggregate.Amount
        ELSE
            PurchInvLineAggregate."Inv. Discount Amount Excl. VAT" := PurchInvLineAggregate."Inv. Discount Amount";
    end;

    [Scope('Internal')]
    procedure VerifyCanUpdateUOM(var PurchInvLineAggregate: Record "5478")
    begin
        IF PurchInvLineAggregate."API Type" <> PurchInvLineAggregate."API Type"::Item THEN
            ERROR(CanOnlySetUOMForTypeItemErr);
    end;

    local procedure CheckValidLineRecord(var PurchaseLine: Record "39"): Boolean
    begin
        IF PurchaseLine.ISTEMPORARY THEN
            EXIT(FALSE);

        IF NOT GraphMgtGeneralTools.IsApiEnabled THEN
            EXIT(FALSE);

        //IF PurchaseLine."Document Type" <> PurchaseLine."Document Type"::Invoice THEN
        IF PurchaseLine."Document Type" <> PurchaseLine."Document Type"::Order THEN //SRT July 4th 2019
            EXIT(FALSE);

        EXIT(TRUE);
    end;
}

