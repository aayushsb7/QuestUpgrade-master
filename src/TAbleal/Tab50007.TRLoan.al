table 50007 "TR Loan"
{

    fields
    {
        field(1; "TR Code"; Code[30])
        {

            trigger OnValidate()
            begin
                IF "TR Code" = '' THEN
                    ERROR(Error3);
            end;
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "LC No."; Code[20])
        {
            TableRelation = "LC Details";
        }
        field(4; "Expiry Date"; Date)
        {
        }
        field(5; Period; DateFormula)
        {
        }
        field(6; "Interest Rate"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "LC No.", "TR Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF LedgerEntryExists("TR Code") THEN
            ERROR(Error1, PostedDocumentNo);
        IF JournalEntryExists("TR Code") THEN
            ERROR(Error2, DocumentNo, "TR Code");
    end;

    trigger OnInsert()
    begin
        IF "TR Code" = '' THEN
            ERROR(Error3);
    end;

    trigger OnModify()
    begin
        IF LedgerEntryExists("TR Code") THEN
            ERROR(Error1, PostedDocumentNo);
        IF JournalEntryExists("TR Code") THEN
            ERROR(Error2, DocumentNo, "TR Code");
    end;

    trigger OnRename()
    begin
        IF LedgerEntryExists(xRec."TR Code") THEN
            ERROR(Error1, PostedDocumentNo);
        IF JournalEntryExists(xRec."TR Code") THEN
            ERROR(Error2, DocumentNo, xRec."TR Code");
    end;

    var
        Error1: Label 'You cannot modify or Delete or Rename TR Loan Details as it Exists in G/L Entry %1';
        Error2: Label 'You cannot modify or Delete or Rename TR Loan Details as it Exists in Journal %1. Please remove TR Loan %2 from Journal %1 to delete or modify or Rename.';
        Error3: Label 'Please Enter TR Code';
        PostedDocumentNo: Code[20];
        DocumentNo: Code[20];

    local procedure LedgerEntryExists(TRCode: Code[30]): Boolean
    var
        GLEntry: Record "G/L Entry";
    begin
        CLEAR(PostedDocumentNo);
        GLEntry.RESET;
        GLEntry.SETRANGE("TR Loan Code", TRCode);
        IF GLEntry.FINDFIRST THEN BEGIN
            PostedDocumentNo := GLEntry."Document No.";
            EXIT(TRUE);
        END;
    end;

    local procedure JournalEntryExists(TRCode: Code[30]): Boolean
    var
        JournalLine: Record "Gen. Journal Line";
    begin
        CLEAR(DocumentNo);
        JournalLine.RESET;
        JournalLine.SETRANGE("TR Loan Code", TRCode);
        IF JournalLine.FINDFIRST THEN BEGIN
            DocumentNo := JournalLine."Document No.";
            EXIT(TRUE);
        END;
    end;
}

