page 50034 "Purchase Order Line Entity"
{
    Caption = 'Purchase Order Line Entity';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Purch. Inv. Line Aggregate";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(sequence; "Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'sequence', Locked = true;

                    trigger OnValidate()
                    begin
                        IF (xRec."Line No." <> "Line No.") AND (xRec."Line No." <> 0) THEN
                            ERROR(CannotChangeLineNoErr);

                        RegisterFieldSet(FIELDNO("Line No."));
                    end;
                }
                field(lineType; "API Type")
                {
                    ApplicationArea = All;
                    Caption = 'lineType', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(FIELDNO(Type));
                    end;
                }
                field(itemId; "Item Id")
                {
                    ApplicationArea = All;
                    Caption = 'itemId', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(FIELDNO(Type));
                        RegisterFieldSet(FIELDNO("No."));
                        RegisterFieldSet(FIELDNO("Item Id"));

                        Item.SETRANGE(Id, "Item Id");

                        IF NOT Item.FINDFIRST THEN BEGIN
                            InsertItem := TRUE;
                            CheckIntegrationIdInUse;

                            Item.Id := "Item Id";
                            RegisterFieldSet(Item.FIELDNO(Id));
                            EXIT;
                        END;

                        "No." := Item."No.";
                    end;
                }
                field(lineDetails; LineObjectDetailsJSON)
                {
                    ApplicationArea = All;
                    Caption = 'lineDetails', Locked = true;
                    ODataEDMType = 'DOCUMENTLINEOBJECTDETAILS';
                    ToolTip = 'Specifies details about the line.';

                    trigger OnValidate()
                    var
                        GraphMgtComplexTypes: Codeunit "Graph Mgt - Complex Types";
                    begin
                        IF NOT InsertItem THEN
                            EXIT;

                        GraphMgtComplexTypes.ParseDocumentLineObjectDetailsFromJSON(
                          LineObjectDetailsJSON, Item."No.", Item.Description, Item."Description 2");

                        IF Item."No." <> '' THEN
                            RegisterItemFieldSet(Item.FIELDNO("No."));

                        RegisterFieldSet(FIELDNO("No."));

                        IF Item.Description <> '' THEN
                            RegisterItemFieldSet(Item.FIELDNO(Description));

                        IF Description = '' THEN BEGIN
                            Description := Item.Description;
                            RegisterFieldSet(FIELDNO(Description));
                        END;

                        IF Item."Description 2" <> '' THEN BEGIN
                            "Description 2" := Item."Description 2";
                            RegisterItemFieldSet(Item.FIELDNO("Description 2"));
                            RegisterFieldSet(FIELDNO("Description 2"));
                        END;
                    end;
                }
                field(description; Description)
                {
                    ApplicationArea = All;
                    Caption = 'description';
                    ToolTip = 'Specifies the description of the purchase invoice line.';

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(FIELDNO(Description));
                    end;
                }
                field(unitOfMeasure; UnitOfMeasureJSON)
                {
                    ApplicationArea = All;
                    Caption = 'unitOfMeasure', Locked = true;
                    ODataEDMType = 'ITEM-UOM';
                    ToolTip = 'Specifies Unit of Measure.';

                    trigger OnValidate()
                    var
                        TempUnitOfMeasure: Record "Unit of Measure" temporary;
                        PurchInvAggregator: Codeunit "Purch. Inv. Aggregator";
                        GraphCollectionMgtItem: Codeunit "Graph Collection Mgt - Item";
                    begin
                        PurchInvAggregator.VerifyCanUpdateUOM(Rec);
                        GraphCollectionMgtItem.ParseJSONToUnitOfMeasure(UnitOfMeasureJSON, TempUnitOfMeasure);
                        "Unit of Measure Code" := TempUnitOfMeasure.Code;
                        RegisterFieldSet(FIELDNO("Unit of Measure Code"));

                        IF InsertItem THEN
                            EXIT;

                        PurchInvAggregator.UpdateUnitOfMeasure(Item, UnitOfMeasureJSON);
                    end;
                }
                field(quantity; Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'quantity', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(FIELDNO(Quantity));
                    end;
                }
                field(unitCost; "Direct Unit Cost")
                {
                    ApplicationArea = All;
                    Caption = 'directUnitCost', Locked = true;

                    trigger OnValidate()
                    begin
                        IF InsertItem THEN BEGIN
                            Item."Unit Cost" := "Direct Unit Cost";
                            RegisterFieldSet(Item.FIELDNO("Unit Cost"));
                        END;

                        RegisterFieldSet(FIELDNO("Direct Unit Cost"));
                    end;
                }
                field(discountAmount; "Line Discount Amount")
                {
                    ApplicationArea = All;
                    Caption = 'discountAmount', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(FIELDNO("Line Discount Amount"));
                    end;
                }
                field(discountPercent; "Line Discount %")
                {
                    ApplicationArea = All;
                    Caption = 'discountPercent', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(FIELDNO("Line Discount %"));
                    end;
                }
                field(discountAppliedBeforeTax; "Discount Applied Before Tax")
                {
                    ApplicationArea = All;
                    Caption = 'discountAppliedBeforeTax';
                }
                field(amountExcludingTax; "Line Amount Excluding Tax")
                {
                    ApplicationArea = All;
                    Caption = 'amountExcludingTax', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(FIELDNO(Amount));
                    end;
                }
                field(totalTaxAmount; "Line Tax Amount")
                {
                    ApplicationArea = All;
                    Caption = 'totalTaxAmount', Locked = true;
                }
                field(amountIncludingTax; "Line Amount Including Tax")
                {
                    ApplicationArea = All;
                    Caption = 'amountIncludingTax', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(FIELDNO("Amount Including VAT"));
                    end;
                }
                field(invoiceDiscountAllocation; "Inv. Discount Amount Excl. VAT")
                {
                    ApplicationArea = All;
                    Caption = 'invoiceDiscountAllocation', Locked = true;
                }
                field(netAmount; Amount)
                {
                    ApplicationArea = All;
                    Caption = 'netAmount', Locked = true;
                }
                field(netTaxAmount; "Tax Amount")
                {
                    ApplicationArea = All;
                    Caption = 'netTaxAmount', Locked = true;
                }
                field(netAmountIncludingTax; "Amount Including VAT")
                {
                    ApplicationArea = All;
                    Caption = 'netAmountIncludingTax', Locked = true;
                }
                field(expectedReceiptDate; "Expected Receipt Date")
                {
                    ApplicationArea = All;
                    Caption = 'expectedReceiptDate', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(FIELDNO("Expected Receipt Date"));
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        SetCalculatedFields;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        PurchInvAggregator: Codeunit "Purch. Inv. Aggregator";
    begin
        PurchInvAggregator.PropagateDeleteLine(Rec);
    end;

    trigger OnFindRecord(Which: Text): Boolean
    var
        PurchInvAggregator: Codeunit "Purch. Inv. Aggregator";
        DocumentIdFilter: Text;
        FilterView: Text;
    begin
        IF NOT LinesLoaded THEN BEGIN
            FilterView := GETVIEW;
            DocumentIdFilter := GETFILTER("Document Id");
            PurchInvAggregator.LoadLines(Rec, DocumentIdFilter);
            SETVIEW(FilterView);
            IF NOT FINDFIRST THEN
                EXIT(FALSE);
            LinesLoaded := TRUE;
        END;

        EXIT(TRUE);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        PurchInvAggregator: Codeunit "Purch. Inv. Aggregator";
    begin
        IF InsertItem THEN
            InsertItemOnTheFly;
        PurchInvAggregator.PropagateInsertLine(Rec, TempFieldBuffer);
    end;

    trigger OnModifyRecord(): Boolean
    var
        PurchInvAggregator: Codeunit "Purch. Inv. Aggregator";
    begin
        IF InsertItem THEN
            InsertItemOnTheFly;
        PurchInvAggregator.PropagateModifyLine(Rec, TempFieldBuffer);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ClearCalculatedFields;
        VALIDATE(Type, Type::Item);
        RegisterFieldSet(FIELDNO(Type));
    end;

    var
        TempFieldBuffer: Record "Field Buffer" temporary;
        TempItemFieldSet: Record "2000000041" temporary;//no record found in quest
        Item: Record Item;
        UnitOfMeasureJSON: Text;
        LineObjectDetailsJSON: Text;
        LinesLoaded: Boolean;
        InsertItem: Boolean;
        CannotChangeLineNoErr: Label 'The value for sequence cannot be modified. Delete and insert the line again.', Locked = true;
        ItemWasDeletedErr: Label 'The item was deleted.', Locked = true;
        IdIsAlreadyUsedErr: Label 'The id is already in use used.', Locked = true;
        BothItemIdAndAccountIdAreSpecifiedErr: Label 'Both itemId and accountId are specified. Specify only one of them.';

    local procedure RegisterFieldSet(FieldNo: Integer)
    var
        LastOrderNo: Integer;
    begin
        LastOrderNo := 1;
        IF TempFieldBuffer.FINDLAST THEN
            LastOrderNo := TempFieldBuffer.Order + 1;

        CLEAR(TempFieldBuffer);
        TempFieldBuffer.Order := LastOrderNo;
        TempFieldBuffer."Table ID" := DATABASE::"Purch. Inv. Line Aggregate";
        TempFieldBuffer."Field ID" := FieldNo;
        TempFieldBuffer.INSERT;
    end;

    local procedure ClearCalculatedFields()
    begin
        TempFieldBuffer.RESET;
        TempFieldBuffer.DELETEALL;
        TempItemFieldSet.RESET;
        TempItemFieldSet.DELETEALL;

        CLEAR(Item);
        CLEAR(UnitOfMeasureJSON);
        CLEAR(InsertItem);
        CLEAR(LineObjectDetailsJSON);
    end;

    local procedure SetCalculatedFields()
    var
        GraphMgtPurchInvLines: Codeunit "Graph Mgt - Purch. Inv. Lines";
        GraphMgtComplexTypes: Codeunit "Graph Mgt - Complex Types";
    begin
        LineObjectDetailsJSON := GraphMgtComplexTypes.GetPurchaseLineDescriptionComplexType(Rec);
        UnitOfMeasureJSON := GraphMgtPurchInvLines.GetUnitOfMeasureJSON(Rec);
    end;

    local procedure RegisterItemFieldSet(FieldNo: Integer)
    begin
        IF TempItemFieldSet.GET(DATABASE::Item, FieldNo) THEN
            EXIT;

        TempItemFieldSet.INIT;
        TempItemFieldSet.TableNo := DATABASE::Item;
        TempItemFieldSet.VALIDATE("No.", FieldNo);
        TempItemFieldSet.INSERT(TRUE);
    end;

    local procedure CheckIntegrationIdInUse()
    var
        IntegrationRecord: Record "Integration Record";
    begin
        IF NOT IntegrationRecord.GET("Item Id") THEN
            EXIT;

        IF IntegrationRecord."Table ID" = DATABASE::Item THEN
            ERROR(ItemWasDeletedErr);

        ERROR(IdIsAlreadyUsedErr);
    end;

    local procedure InsertItemOnTheFly()
    var
        GraphCollectionMgtItem: Codeunit "Graph Collection Mgt - Item";
    begin
        GraphCollectionMgtItem.InsertItemFromSalesDocument(Item, TempItemFieldSet, UnitOfMeasureJSON);
        VALIDATE("No.", Item."No.");

        IF Description = '' THEN
            Description := Item.Description;
    end;
}

