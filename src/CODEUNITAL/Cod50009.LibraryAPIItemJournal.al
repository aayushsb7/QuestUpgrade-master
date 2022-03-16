codeunit 50009 "Library API - Item Journal"
{

    trigger OnRun()
    begin
    end;

    var
        GenJnlManagement: Codeunit GenJnlManagement;
        NoSeriesMgt: Codeunit NoSeriesManagement;

    [Scope('Internal')]
    procedure InitializeLine(var GenJournalLine: Record "Item Journal Line"; LineNo: Integer; DocumentNo: Code[20]; ExternalDocumentNo: Code[35])
    var
        GenJournalBatch: Record "Gen. Journal Batch";
        CopyValuesFromGenJnlLine: Record "Item Journal Line";
        CopyValuesFromGenJnlLineSpecified: Boolean;
        BottomLine: Boolean;
    begin
        GenJournalBatch.GET(GenJournalLine."Journal Template Name", GenJournalLine."Journal Batch Name");

        GenJournalLine."Line No." := LineNo;
        GetCopyValuesFromLine(GenJournalLine, CopyValuesFromGenJnlLine, CopyValuesFromGenJnlLineSpecified, BottomLine);

        IF BottomLine AND
           (LineNo <> 0)
        THEN BEGIN
            GenJournalLine."Line No." := 0;
            SetUpNewLine(GenJournalLine, CopyValuesFromGenJnlLine, CopyValuesFromGenJnlLineSpecified, BottomLine);
            GenJournalLine."Line No." := LineNo;
        END ELSE
            SetUpNewLine(GenJournalLine, CopyValuesFromGenJnlLine, CopyValuesFromGenJnlLineSpecified, BottomLine);

        GenJournalLine."External Document No." := ExternalDocumentNo;
        IF DocumentNo <> '' THEN
            GenJournalLine."Document No." := DocumentNo
        ELSE
            AlterDocNoBasedOnExternalDocNo(GenJournalLine, CopyValuesFromGenJnlLine, GenJournalBatch, CopyValuesFromGenJnlLineSpecified);
    end;

    [Scope('Internal')]
    procedure EnsureGenJnlBatchExists(TemplateNameTxt: Text[10]; BatchNameTxt: Text[10])
    var
        GenJournalBatch: Record "233";
    begin
        IF NOT GenJournalBatch.GET(TemplateNameTxt, BatchNameTxt) THEN BEGIN
            GenJournalBatch.VALIDATE("Journal Template Name", TemplateNameTxt);
            GenJournalBatch.SetupNewBatch;
            GenJournalBatch.VALIDATE(Name, BatchNameTxt);
            GenJournalBatch.VALIDATE(Description, GenJournalBatch.Name);
            GenJournalBatch.INSERT(TRUE);
            COMMIT;
        END;
    end;

    local procedure GetCopyValuesFromLine(var GenJournalLine: Record "83"; var CopyValuesFromGenJnlLine: Record "83"; var CopyValuesFromGenJnlLineSpecified: Boolean; var BottomLine: Boolean)
    begin
        // This function is replicating the behavior of the page
        // If line is at the bottom, we will copy values from previous line
        // If line is in the middle, we will copy values from next line
        BottomLine := TRUE;
        CopyValuesFromGenJnlLineSpecified := FALSE;

        IF GenJournalLine."Line No." <> 0 THEN BEGIN
            CopyValuesFromGenJnlLine.RESET;
            CopyValuesFromGenJnlLine.COPYFILTERS(GenJournalLine);
            CopyValuesFromGenJnlLine.SETFILTER("Line No.", '>%1', GenJournalLine."Line No.");
            IF CopyValuesFromGenJnlLine.FINDFIRST THEN BEGIN
                CopyValuesFromGenJnlLineSpecified := TRUE;
                BottomLine := FALSE;
                EXIT;
            END;
        END;

        IF NOT CopyValuesFromGenJnlLineSpecified THEN BEGIN
            CopyValuesFromGenJnlLine.RESET;
            CopyValuesFromGenJnlLine.COPYFILTERS(GenJournalLine);
            IF CopyValuesFromGenJnlLine.FINDLAST THEN
                CopyValuesFromGenJnlLineSpecified := TRUE;
        END;
    end;

    local procedure SetUpNewLine(var GenJournalLine: Record "83"; CopyValuesFromGenJnlLine: Record "83"; CopyValuesFromGenJnlLineSpecified: Boolean; BottomLine: Boolean)
    var
        Balance: Decimal;
        TotalBalance: Decimal;
        ShowBalance: Boolean;
        ShowTotalBalance: Boolean;
    begin
        IF CopyValuesFromGenJnlLineSpecified THEN
            //GenJnlManagement.CalcBalance(
            //GenJournalLine,CopyValuesFromGenJnlLine,Balance,TotalBalance,ShowBalance,ShowTotalBalance);

            GenJournalLine.SetUpNewLine(CopyValuesFromGenJnlLine);

        IF GenJournalLine."Line No." = 0 THEN
            GenJournalLine.VALIDATE(
              "Line No.", GenJournalLine.GetNewLineNo(GenJournalLine."Journal Template Name", GenJournalLine."Journal Batch Name"));
    end;

    local procedure AlterDocNoBasedOnExternalDocNo(var GenJournalLine: Record "83"; CopyValuesFromGenJnlLine: Record "83"; GenJnlBatch: Record "233"; CopyValuesFromGenJnlLineSpecified: Boolean)
    var
        NoSeriesLine: Record "309";
    begin
        IF CopyValuesFromGenJnlLineSpecified AND
           (CopyValuesFromGenJnlLine."Document No." = GenJournalLine."Document No.") AND
           (CopyValuesFromGenJnlLine."External Document No." <> GenJournalLine."External Document No.")
        THEN BEGIN
            IF GenJnlBatch."No. Series" <> '' THEN BEGIN
                NoSeriesMgt.SetNoSeriesLineFilter(NoSeriesLine, GenJnlBatch."No. Series", GenJournalLine."Posting Date");
                IF NoSeriesLine."Increment-by No." > 1 THEN
                    NoSeriesMgt.IncrementNoText(GenJournalLine."Document No.", NoSeriesLine."Increment-by No.")
                ELSE
                    GenJournalLine."Document No." := INCSTR(GenJournalLine."Document No.");
            END ELSE
                GenJournalLine."Document No." := INCSTR(GenJournalLine."Document No.");
        END;
    end;

    [Scope('Internal')]
    procedure GetBatchNameFromId(JournalBatchId: Guid): Code[10]
    var
        GenJournalBatch: Record "233";
    begin
        GenJournalBatch.SETRANGE(Id, JournalBatchId);
        GenJournalBatch.FINDFIRST;

        EXIT(GenJournalBatch.Name);
    end;
}

