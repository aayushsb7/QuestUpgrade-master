codeunit 50007 "Graph Mgt - Item Journal"
{

    trigger OnRun()
    begin
    end;

    [Scope('Internal')]
    procedure GetDefaultJournalLinesTemplateName(): Text[10]
    var
        GenJnlTemplate: Record "82";
    begin
        GenJnlTemplate.RESET;
        GenJnlTemplate.SETRANGE("Page ID", PAGE::"Item Journal");
        GenJnlTemplate.SETRANGE(Recurring, FALSE);
        GenJnlTemplate.SETRANGE(Type, 0);
        GenJnlTemplate.FINDFIRST;
        EXIT(GenJnlTemplate.Name);
    end;

    [Scope('Internal')]
    procedure GetDefaultCustomerPaymentsTemplateName(): Text[10]
    var
        GenJnlTemplate: Record "82";
    begin
        GenJnlTemplate.RESET;
        GenJnlTemplate.SETRANGE("Page ID", PAGE::"Item Journal");
        GenJnlTemplate.SETRANGE(Recurring, FALSE);
        GenJnlTemplate.SETRANGE(Type, 3);
        GenJnlTemplate.FINDFIRST;
        EXIT(GenJnlTemplate.Name);
    end;

    [Scope('Internal')]
    procedure UpdateIntegrationRecords(OnlyItemsWithoutId: Boolean)
    var
        GenJournalBatch: Record "233";
        GraphMgtGeneralTools: Codeunit "5465";
        GenJournalBatchRecordRef: RecordRef;
    begin
        GenJournalBatchRecordRef.OPEN(DATABASE::"Item Journal Batch");
        GraphMgtGeneralTools.UpdateIntegrationRecords(GenJournalBatchRecordRef, GenJournalBatch.FIELDNO(Id), OnlyItemsWithoutId);
    end;

    [EventSubscriber(ObjectType::Codeunit, 5150, 'OnUpdateReferencedIdField', '', false, false)]
    local procedure HandleUpdateReferencedIdFieldOnTaxGroup(var RecRef: RecordRef; NewId: Guid; var Handled: Boolean)
    var
        DummyGenJournalBatch: Record "233";
        GraphMgtGeneralTools: Codeunit "5465";
    begin
        GraphMgtGeneralTools.HandleUpdateReferencedIdFieldOnItem(
          RecRef, NewId, Handled, DATABASE::"Item Journal Batch", DummyGenJournalBatch.FIELDNO(Id));
    end;

    [EventSubscriber(ObjectType::Codeunit, 5150, 'OnGetPredefinedIdValue', '', false, false)]
    local procedure HandleGetPredefinedIdValue(var Id: Guid; var RecRef: RecordRef; var Handled: Boolean)
    var
        DummyGenJournalBatch: Record "233";
        GraphMgtGeneralTools: Codeunit "5465";
    begin
        GraphMgtGeneralTools.HandleGetPredefinedIdValue(
          Id, RecRef, Handled, DATABASE::"Item Journal Batch", DummyGenJournalBatch.FIELDNO(Id));
    end;

    [EventSubscriber(ObjectType::Codeunit, 5465, 'ApiSetup', '', false, false)]
    local procedure HandleApiSetup()
    begin
        UpdateIntegrationRecords(FALSE);
    end;
}

