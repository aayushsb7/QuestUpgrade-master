page 50036 "Item Journal Lines Entity"
{
    Caption = 'itemjournalLines', Locked = true;
    DelayedInsert = true;
    ODataKeyFields = Id;
    PageType = ListPart;
    SourceTable = "Item Journal Line";

    layout
    {
        area(content)
        {
            repeater(ItemJnlLineEntity)
            {
                field(id; Id)
                {
                    ApplicationArea = All;
                    Caption = 'Id', Locked = true;
                    Editable = false;
                }
                field(journalDisplayName; GlobalJournalDisplayNameTxt)
                {
                    ApplicationArea = All;
                    Caption = 'JournalDisplayName', Locked = true;
                    ToolTip = 'Specifies the Journal Batch Name of the Journal Line';

                    trigger OnValidate()
                    begin
                        ERROR(CannotEditBatchNameErr);
                    end;
                }
                field(lineNumber; "Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'LineNumber', Locked = true;
                }
                field(entryType; "Entry Type")
                {
                    Caption = 'entryType';
                }
                field(postingDate; "Posting Date")
                {
                    ApplicationArea = All;
                    Caption = 'PostingDate', Locked = true;
                }
                field(documentNumber; "Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'DocumentNumber', Locked = true;
                }
                field(itemId; "Item Id")
                {
                    ApplicationArea = All;
                    Caption = 'itemId', Locked = true;

                    trigger OnValidate()
                    begin
                        IF "Item Id" = BlankGUID THEN BEGIN
                            "Item No." := '';
                            EXIT;
                        END;

                        Item.SETRANGE(Id, "Item Id");
                        IF NOT Item.FINDFIRST THEN
                            ERROR(AccountIdDoesNotMatchAnAccountErr);

                        "Item No." := Item."No.";
                    end;
                }
                field(itemNumber; "Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'itemNumber', Locked = true;

                    trigger OnValidate()
                    begin
                        IF Item."No." <> '' THEN BEGIN
                            IF Item."No." <> "Item No." THEN
                                ERROR(AccountValuesDontMatchErr);
                            EXIT;
                        END;

                        IF "Item No." = '' THEN BEGIN
                            "Item Id" := BlankGUID;
                            EXIT;
                        END;

                        IF NOT Item.GET("Item No.") THEN
                            ERROR(AccountNumberDoesNotMatchAnAccountErr);

                        "Item Id" := Item.Id;
                    end;
                }
                field(locationCode; "Location Code")
                {
                    Caption = 'locationCode';
                }
                field(quantity; Quantity)
                {
                    Caption = 'quantity';
                }
                field(isSpillage; "Is Spillage")
                {
                    Caption = 'isSpillage';
                }
                field(externalDocumentNumber; "External Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'ExternalDocumentNumber', Locked = true;
                }
                field(description; Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description', Locked = true;
                }
                field(unitAmount; "Unit Amount")
                {
                    ApplicationArea = All;
                    Caption = 'unitAmount', Locked = true;
                }
                field(dimensions; DimensionsJSON)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions', Locked = true;
                    ODataEDMType = 'Collection(DIMENSION)';
                    ToolTip = 'Specifies Journal Line Dimensions.';

                    trigger OnValidate()
                    begin
                        DimensionsSet := PreviousDimensionsJSON <> DimensionsJSON;
                    end;
                }
                field(lastModifiedDateTime; "Last Modified DateTime")
                {
                    ApplicationArea = All;
                    Caption = 'LastModifiedDateTime', Locked = true;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        IF NOT FiltersChecked THEN BEGIN
            CheckFilters;
            FiltersChecked := TRUE;
        END;
    end;

    trigger OnAfterGetRecord()
    begin
        SetCalculatedFields;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        TempGenJournalLine: Record "Item Journal Line" temporary;
    begin
        TempGenJournalLine.RESET;
        TempGenJournalLine.COPY(Rec);

        CLEAR(Rec);
        GraphMgtItemJournalLines.SetJournalLineTemplateAndBatch(
          Rec, LibraryAPIItemJournal.GetBatchNameFromId(TempGenJournalLine.GETFILTER("Item Journal Batch Id")));
        LibraryAPIItemJournal.InitializeLine(
          Rec, TempGenJournalLine."Line No.", TempGenJournalLine."Document No.", TempGenJournalLine."External Document No.");

        GraphMgtItemJournalLines.SetJournalLineValues(Rec, TempGenJournalLine);

        UpdateDimensions(FALSE);
        SetCalculatedFields;
    end;

    trigger OnModifyRecord(): Boolean
    var
        GenJournalLine: Record "Item Journal Line";
    begin
        GenJournalLine.SETRANGE(Id, Id);
        GenJournalLine.FINDFIRST;

        IF "Line No." = GenJournalLine."Line No." THEN
            MODIFY(TRUE)
        ELSE BEGIN
            GenJournalLine.TRANSFERFIELDS(Rec, FALSE);
            GenJournalLine.RENAME("Journal Template Name", "Journal Batch Name", "Line No.");
            TRANSFERFIELDS(GenJournalLine, TRUE);
        END;

        UpdateDimensions(TRUE);
        SetCalculatedFields;

        EXIT(FALSE);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CheckFilters;
        ClearCalculatedFields;
    end;

    trigger OnOpenPage()
    begin
        GraphMgtItemJournalLines.SetJournalLineFilters(Rec);
    end;

    var
        Item: Record Item;
        GraphMgtItemJournalLines: Codeunit "Graph Mgt - Item Journal Lines";
        LibraryAPIItemJournal: Codeunit "Library API - Item Journal";
        FiltersNotSpecifiedErr: Label 'You must specify a item journal batch ID or a item journal ID to get a item journal line.', Locked = true;
        CannotEditBatchNameErr: Label 'The Item Journal Batch Display Name isn''t editable.', Locked = true;
        AccountValuesDontMatchErr: Label 'The item no. values do not match to a specific Item.', Locked = true;
        AccountIdDoesNotMatchAnAccountErr: Label 'The "itemId" does not match to an Account.', Locked = true;
        AccountNumberDoesNotMatchAnAccountErr: Label 'The "itemNumber" does not match to an Item.', Locked = true;
        DimensionsJSON: Text;
        PreviousDimensionsJSON: Text;
        GlobalJournalDisplayNameTxt: Code[10];
        FiltersChecked: Boolean;
        DimensionsSet: Boolean;
        BlankGUID: Guid;

    local procedure SetCalculatedFields()
    var
        GraphMgtComplexTypes: Codeunit  "Graph Mgt - Complex Types";
    begin
        GlobalJournalDisplayNameTxt := "Journal Batch Name";
        DimensionsJSON := GraphMgtComplexTypes.GetDimensionsJSON("Dimension Set ID");
        PreviousDimensionsJSON := DimensionsJSON;
    end;

    local procedure ClearCalculatedFields()
    begin
        CLEAR(GlobalJournalDisplayNameTxt);
        CLEAR(DimensionsJSON);
        CLEAR(PreviousDimensionsJSON);
        CLEAR(DimensionsSet);
    end;

    local procedure CheckFilters()
    begin
        IF (GETFILTER("Item Journal Batch Id") = '') AND
           (GETFILTER(Id) = '')
        THEN
            ERROR(FiltersNotSpecifiedErr);
    end;

    local procedure UpdateDimensions(LineExists: Boolean)
    var
        GraphMgtComplexTypes: Codeunit "Graph Mgt - Complex Types";
        DimensionManagement: Codeunit DimensionManagement;
        NewDimensionSetId: Integer;
    begin
        IF NOT DimensionsSet THEN
            EXIT;

        GraphMgtComplexTypes.GetDimensionSetFromJSON(DimensionsJSON, "Dimension Set ID", NewDimensionSetId);
        IF "Dimension Set ID" <> NewDimensionSetId THEN BEGIN
            "Dimension Set ID" := NewDimensionSetId;
            DimensionManagement.UpdateGlobalDimFromDimSetID(NewDimensionSetId, "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            IF LineExists THEN
                MODIFY;
        END;
    end;
}

