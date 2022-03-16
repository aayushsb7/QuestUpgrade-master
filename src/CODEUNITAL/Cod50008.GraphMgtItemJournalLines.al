codeunit 50008 "Graph Mgt - Item Journal Lines"
{

    trigger OnRun()
    begin
    end;

    var
        GraphMgtJournal: Codeunit "Graph Mgt - Item Journals";

    [Scope('OnPrem')]
    procedure SetJournalLineTemplateAndBatch(var GenJournalLine: Record "Item Journal Line"; JournalLineBatchName: Code[10])
    begin
        GenJournalLine.VALIDATE("Journal Template Name", GraphMgtJournal.GetDefaultJournalLinesTemplateName);
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");

        GenJournalLine.VALIDATE("Journal Batch Name", JournalLineBatchName);
        GenJournalLine.SETRANGE("Journal Batch Name", JournalLineBatchName);
    end;

    [Scope('OnPrem')]
    procedure SetJournalLineFilters(var GenJournalLine: Record "Item Journal Line")
    begin
        GenJournalLine.SETRANGE("Journal Template Name", GraphMgtJournal.GetDefaultJournalLinesTemplateName);
    end;

    [Scope('OnPrem')]
    procedure SetJournalLineValues(var GenJournalLine: Record "Item Journal Line"; TempGenJournalLine: Record "83" temporary)
    var
        DummyDate: Date;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ItemJnlBatch: Record "Item Journal Batch";
        SourceCodeSetup: Record "Source Code Setup";
        UserSetup: Record "User Setup";
    begin
        IF TempGenJournalLine."Posting Date" <> DummyDate THEN
            GenJournalLine.VALIDATE("Posting Date", TempGenJournalLine."Posting Date");
        GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::" ");
        GenJournalLine.VALIDATE("Entry Type", TempGenJournalLine."Entry Type");
        GenJournalLine.VALIDATE("Item No.", TempGenJournalLine."Item No.");
        GenJournalLine.VALIDATE("External Document No.", TempGenJournalLine."External Document No.");
        GenJournalLine.VALIDATE("Location Code", TempGenJournalLine."Location Code");
        GenJournalLine.VALIDATE(Quantity, TempGenJournalLine.Quantity);
        GenJournalLine.VALIDATE("Unit Amount", TempGenJournalLine."Unit Amount");
        GenJournalLine.VALIDATE("Is Spillage", TempGenJournalLine."Is Spillage");
        IF TempGenJournalLine.Description <> '' THEN
            GenJournalLine.VALIDATE(Description, TempGenJournalLine.Description);
        GenJournalLine."External Entry" := TRUE;
        IF TempGenJournalLine."Shortcut Dimension 1 Code" <> '' THEN
            GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", TempGenJournalLine."Shortcut Dimension 1 Code");
        IF TempGenJournalLine."Shortcut Dimension 2 Code" <> '' THEN
            GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", TempGenJournalLine."Shortcut Dimension 2 Code");
        IF TempGenJournalLine."Shortcut Dimension 3 Code" <> '' THEN
            GenJournalLine.VALIDATE("Shortcut Dimension 3 Code", TempGenJournalLine."Shortcut Dimension 3 Code");
        IF TempGenJournalLine."Shortcut Dimension 4 Code" <> '' THEN
            GenJournalLine.VALIDATE("Shortcut Dimension 4 Code", TempGenJournalLine."Shortcut Dimension 4 Code");
        IF TempGenJournalLine."Shortcut Dimension 5 Code" <> '' THEN
            GenJournalLine.VALIDATE("Shortcut Dimension 5 Code", TempGenJournalLine."Shortcut Dimension 5 Code");
        IF TempGenJournalLine."Shortcut Dimension 6 Code" <> '' THEN
            GenJournalLine.VALIDATE("Shortcut Dimension 6 Code", TempGenJournalLine."Shortcut Dimension 6 Code");
        IF TempGenJournalLine."Shortcut Dimension 7 Code" <> '' THEN
            GenJournalLine.VALIDATE("Shortcut Dimension 7 Code", TempGenJournalLine."Shortcut Dimension 7 Code");
        IF TempGenJournalLine."Shortcut Dimension 8 Code" <> '' THEN
            GenJournalLine.VALIDATE("Shortcut Dimension 8 Code", TempGenJournalLine."Shortcut Dimension 8 Code");

        ItemJnlBatch.GET(GenJournalLine."Journal Template Name", GenJournalLine."Journal Batch Name");
        IF ItemJnlBatch."No. Series" <> '' THEN BEGIN
            CLEAR(NoSeriesMgt);
            GenJournalLine.VALIDATE("Document No.", NoSeriesMgt.GetNextNo(ItemJnlBatch."No. Series", TempGenJournalLine."Posting Date", FALSE))
        END ELSE
            GenJournalLine.VALIDATE("Document No.", TempGenJournalLine."Document No.");
        IF ItemJnlBatch."Posting No. Series" <> '' THEN BEGIN
            GenJournalLine."Posting No. Series" := ItemJnlBatch."Posting No. Series";
        END;
        SourceCodeSetup.GET;
        GenJournalLine."Source Code" := SourceCodeSetup."Item Journal";
        IF TempGenJournalLine."Location Code" = '' THEN BEGIN
            UserSetup.GET(USERID);
            GenJournalLine.VALIDATE("Location Code", UserSetup."Default Location Code");
        END
    end;

    local procedure EnableAccountODataWebService()
    begin
        UpdateIntegrationRecords(FALSE);
    end;

    [Scope('Internal')]
    procedure UpdateIntegrationRecords(OnlyItemsWithoutId: Boolean)
    var
        GenJnlLine: Record "83";
        GraphMgtGeneralTools: Codeunit "5465";
        GenJnlLineRecordRef: RecordRef;
    begin
        GenJnlLineRecordRef.OPEN(DATABASE::"Item Journal Line");
        GraphMgtGeneralTools.UpdateIntegrationRecords(GenJnlLineRecordRef, GenJnlLine.FIELDNO(Id), OnlyItemsWithoutId);
    end;

    [EventSubscriber(ObjectType::Codeunit, 5150, 'OnUpdateReferencedIdField', '', false, false)]
    local procedure HandleUpdateReferencedIdFieldOnJournalLines(var RecRef: RecordRef; NewId: Guid; var Handled: Boolean)
    var
        DummyGenJnlLine: Record "83";
        GraphMgtGeneralTools: Codeunit "5465";
    begin
        GraphMgtGeneralTools.HandleUpdateReferencedIdFieldOnItem(
          RecRef, NewId, Handled, DATABASE::"Item Journal Line", DummyGenJnlLine.FIELDNO(Id));
    end;

    [EventSubscriber(ObjectType::Codeunit, 5150, 'OnGetPredefinedIdValue', '', false, false)]
    local procedure HandleGetPredefinedIdValue(var Id: Guid; var RecRef: RecordRef; var Handled: Boolean)
    var
        DummyGenJnlLine: Record "83";
        GraphMgtGeneralTools: Codeunit "5465";
    begin
        GraphMgtGeneralTools.HandleGetPredefinedIdValue(
          Id, RecRef, Handled, DATABASE::"Item Journal Line", DummyGenJnlLine.FIELDNO(Id));
    end;

    [EventSubscriber(ObjectType::Codeunit, 5465, 'ApiSetup', '', false, false)]
    local procedure HandleApiSetup()
    begin
        EnableAccountODataWebService;
        UpdateIds;
    end;

    [Scope('Internal')]
    procedure UpdateIds()
    var
        GenJournalLine: Record "83";
    begin
        WITH GenJournalLine DO BEGIN
            //SETRANGE("Account Type","Account Type"::"G/L Account");

            IF FINDSET THEN
                REPEAT
                    UpdateItemID;
                    UpdateItemJournalBatchID;
                    MODIFY(FALSE);
                UNTIL NEXT = 0;
        END;
    end;
}

