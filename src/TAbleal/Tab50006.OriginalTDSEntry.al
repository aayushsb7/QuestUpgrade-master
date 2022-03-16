table 50006 "Original TDS Entry"
{
    Caption = 'Original TDS Entry';
    DrillDownPageID = 50004;
    LookupPageID = 50004;

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Posting Date"; Date)
        {
        }
        field(3; "Document No."; Code[20])
        {
        }
        field(4; "Source Type"; Option)
        {
            OptionCaption = ' ,Customer,Vendor';
            OptionMembers = " ",Customer,Vendor;
        }
        field(5; "Bill-to/Pay-to No."; Code[20])
        {
        }
        field(6; "TDS Posting Group"; Code[20])
        {
            TableRelation = "TDS Posting Group".Code;
        }
        field(7; "TDS%"; Decimal)
        {
        }
        field(8; "Original Base"; Decimal)
        {
        }
        field(9; "Original TDS Amount"; Decimal)
        {
        }
        field(10; "User ID"; Code[50])
        {
        }
        field(11; "Source Code"; Code[10])
        {
        }
        field(12; "Transaction No."; Integer)
        {
        }
        field(13; "External Document No."; Code[20])
        {
        }
        field(14; "No. Series"; Code[10])
        {
        }
        field(15; "Document Date"; Date)
        {
        }
        field(16; "Shortcut Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value";
        }
        field(17; "Shortcut Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(18; "TDS Type"; Option)
        {
            OptionCaption = ' ,Purchase TDS,Sales TDS';
            OptionMembers = " ","Purchase TDS","Sales TDS";
        }
        field(20; "Reversed Entry No."; Integer)
        {
        }
        field(21; Reversed; Boolean)
        {
        }
        field(22; "Reversed by Entry No."; Integer)
        {
        }
        field(24; Closed; Boolean)
        {
        }
        field(25; "IRD Voucher No."; Code[50])
        {
        }
        field(50; "TDS Base Payment Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'TDS Partial Payment Case';
        }
        field(51; "TDS Amount Payment"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'TDS Partial Payment Case';

            trigger OnValidate()
            begin
                IF "TDS Amount Payment" > "Original TDS Amount" THEN
                    ERROR(TDSPmtAmtControl, FIELDCAPTION("TDS Amount Payment"), FIELDCAPTION("Original TDS Amount"), "Original TDS Amount");

                CalculateTDSBaseAmount;
            end;
        }
        field(52; "Paid TDS Base Amount"; Decimal)
        {
            CalcFormula = Sum("TDS Ledger Entries".Base WHERE("TDS Entry No." = FIELD("Entry No.")));
            Description = 'TDS Partial Payment Case';
            Editable = false;
            FieldClass = FlowField;
        }
        field(53; "Paid TDS Amount"; Decimal)
        {
            CalcFormula = Sum("TDS Ledger Entries"."TDS Amount" WHERE("TDS Entry No." = FIELD("Entry No.")));
            Description = 'TDS Partial Payment Case';
            Editable = false;
            FieldClass = FlowField;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Editable = false;
        }
        field(50000; "GL Account"; Code[20])
        {
            CalcFormula = Lookup("TDS Posting Group"."GL Account No." WHERE(Code = FIELD("TDS Posting Group")));
            FieldClass = FlowField;
        }
        field(50001; "IRD Voucher Date"; Date)
        {
        }
        field(50002; "Fiscal Year"; Code[10])
        {
        }
        field(54000; "Vendor Name"; Text[50])
        {
            Caption = 'Vendor Name';
        }
        field(54001; "GL Account Name"; Text[50])
        {
            Caption = 'GL Account Name';
        }
        field(54002; "Main G/L Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(54003; "Main G/L Account Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(60000; "Payment Done"; Boolean)
        {
        }
        field(60001; "Bank Account No."; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(60002; "G/L Entry No."; Integer)
        {
        }
        field(60003; "Payment Transaction No."; Integer)
        {
        }
        field(60004; Narration; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Transaction No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";
        TDS_Payment_Narration: Label 'System Created TDS Payment Entry for Doc. No. ';
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        GLSetup: Record "General Ledger Setup";
        Currency: Record Currency;
        TDSPmtAmtControl: Label '%1 must be less than or equal to %2 %3.';
        PostingDate: Date;
        ExtDocNo: Code[20];
        NarrationText: Text;


    procedure Navigate()
    var
        NavigateForm: Page Navigate;
    begin
        NavigateForm.SetDoc("Posting Date", "Document No.");
        NavigateForm.RUN;
    end;

    procedure CreatePaymentJournals(var GenJnlLine: Record "Gen. Journal Line"; var TDS_Entry: Record "Original TDS Entry"; Reverse: Boolean; BankAccNo: Code[20]; GenJnlTemplateName: Code[10]; GenJnlBatchName: Code[10]; LineNo: Integer)
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenJnlBatchRec: Record "Gen. Journal Batch";
        GenJnlTemplateRec: Record "Gen. Journal Template";
    begin
        WITH TDS_Entry DO BEGIN
            CALCFIELDS("GL Account");
            GenJnlLine.VALIDATE("Posting Date", PostingDate);
            GenJnlLine.VALIDATE("Line Type", GenJnlLine."Line Type"::"G/L Account");
            GenJnlLine."Line No." := LineNo;
            GenJnlLine.VALIDATE("Account No.", TDS_Entry."GL Account");
            IF NOT Reverse THEN BEGIN
                //GenJnlLine.VALIDATE(Amount,TDS_Entry."Original TDS Amount");
                GenJnlLine.VALIDATE(Amount, TDS_Entry."TDS Amount Payment");
                GenJnlLine.VALIDATE("Document Type", GenJnlLine."Document Type"::Payment);
            END ELSE BEGIN
                //GenJnlLine.VALIDATE(Amount,-TDS_Entry."Original TDS Amount");
                GenJnlLine.VALIDATE(Amount, -TDS_Entry."TDS Amount Payment");
                GenJnlLine.VALIDATE("Document Type", GenJnlLine."Document Type"::Refund);
            END;
            IF "Source Type" = "Source Type"::Vendor THEN
                GenJnlLine."Document Class" := GenJnlLine."Document Class"::Vendor
            ELSE
                IF "Source Type" = "Source Type"::Customer THEN
                    GenJnlLine."Document Class" := GenJnlLine."Document Class"::Customer;
            GenJnlLine."Document Subclass" := "Bill-to/Pay-to No.";
            //GenJnlLine."External Document No." := TDS_Entry."Document No." +'('+FORMAT(TDS_Entry."Entry No.")+')';
            GenJnlLine."External Document No." := ExtDocNo;
            //GenJnlLine.Narration := TDS_Payment_Narration + TDS_Entry."Document No.";
            GenJnlLine.Narration := NarrationText;
            GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", TDS_Entry."Shortcut Dimension 1 Code");
            GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", TDS_Entry."Shortcut Dimension 2 Code");
            GenJnlLine."Dimension Set ID" := TDS_Entry."Dimension Set ID";
            GenJnlLine."TDS Entry No." := TDS_Entry."Entry No.";
            GenJnlLine."System-Created Entry" := TRUE;
            GenJnlLine.INSERT(TRUE);
            //GenJnlPost.RUN(GenJnlLine);

            /*IF NOT Reverse THEN BEGIN
              TDS_Entry."Payment Done" := TRUE;
              TDS_Entry.Reversed := FALSE;
            END ELSE BEGIN
              TDS_Entry."Payment Done" := FALSE;
              TDS_Entry.Reversed := TRUE;
            END;
            TDS_Entry."Payment Transaction No." := GetGLEntryTransactionNo(TDS_Entry."Entry No.");
            TDS_Entry."Bank Account No." := BankAccNo;
            TDS_Entry.MODIFY;*/
        END;

    end;


    procedure GetGLEntryTransactionNo(TDS_Entry_No: Integer): Integer
    var
        GLEntry: Record "G/L Entry";
    begin
        WITH GLEntry DO BEGIN
            SETRANGE("TDS Entry No.", TDS_Entry_No);
            FINDLAST;
            EXIT("Transaction No.");
        END;
    end;


    procedure ReverseTDSPaymentEntry(var TDSEntry: Record "TDS Ledger Entries")
    var
        Text001: Label 'Do you really want to reverse the selected TDS Payment Entries?';
        GLEntry: Record "G/L Entry";
        ReversalEntry: Record "Reversal Entry";
        Text003: Label 'The selected tds entries are reversed successfully.';
    begin
        IF TDSEntry.FINDFIRST THEN BEGIN
            IF NOT CONFIRM(Text001, FALSE) THEN
                EXIT;
            REPEAT
                TDSEntry.TESTFIELD(Reversed, FALSE);

                GLEntry.RESET;
                GLEntry.SETRANGE("Transaction No.", TDSEntry."Payment Transaction No.");
                IF GLEntry.FINDFIRST THEN BEGIN
                    CLEAR(ReversalEntry);
                    IF GLEntry.Reversed THEN
                        ReversalEntry.AlreadyReversedEntry(TABLECAPTION, GLEntry."Entry No.");
                    GLEntry.TESTFIELD("Transaction No.");
                    ReversalEntry.SetHideDialog(TRUE);
                    ReversalEntry.SetTDSEntry(TRUE);
                    ReversalEntry.ReverseTransaction(GLEntry."Transaction No.")
                END;

                IF GLEntry.Reversed THEN BEGIN
                    TDSEntry.Reversed := TRUE;
                    TDSEntry."Payment Done" := FALSE;
                END;
            UNTIL TDSEntry.NEXT = 0;
            MESSAGE(Text003);
        END;
    end;


    procedure GetJournalTemplate(BatchName: Code[10]): Code[10]
    var
        JournalBatch: Record "Gen. Journal Batch";
    begin
        JournalBatch.RESET;
        JournalBatch.SETRANGE(Name, BatchName);
        IF JournalBatch.FINDSET THEN
            EXIT(JournalBatch."Journal Template Name");
    end;


    procedure CreateBalanceJournal(var GenJnlLine: Record "Gen. Journal Line"; Reverse: Boolean; BankAccNo: Code[20]; Amount: Decimal; LineNo: Integer; GenJnlTemplateName: Code[10]; GenJnlBatchName: Code[10])
    begin
        GLSetup.GET;
        GenJnlLine.VALIDATE("Posting Date", PostingDate);
        GenJnlLine.VALIDATE("Line Type", GenJnlLine."Line Type"::"Bank Account");
        GenJnlLine.VALIDATE("Account No.", BankAccNo);
        GenJnlLine."Line No." := LineNo;
        IF NOT Reverse THEN BEGIN
            GenJnlLine.VALIDATE(Amount, -Amount);
            GenJnlLine.VALIDATE("Document Type", GenJnlLine."Document Type"::Payment);
        END ELSE BEGIN
            GenJnlLine.VALIDATE(Amount, Amount);
            GenJnlLine.VALIDATE("Document Type", GenJnlLine."Document Type"::Refund);
        END;
        GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
        GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
        GenJnlLine.VALIDATE("Dimension Set ID", "Dimension Set ID");
        GenJnlLine."System-Created Entry" := TRUE;
        GenJnlLine."External Document No." := ExtDocNo;
        GenJnlLine.Narration := NarrationText;
        GenJnlLine.INSERT(TRUE);
        //GenJnlPost.RUN(GenJnlLine);
    end;

    local procedure CalculateTDSBaseAmount()
    var
        AmountNegativeOrZero: Label 'Amount is Negative or Zero. Do you want to Reverse Purchase TDS Entries?';
        TDSTypeBlank: Label 'TDS Type of %1 cannot be Blank in TDS Posting Group.';
        AmountPositiveOrZero: Label 'Amount is Positive or Zero. Do you want to Reverse Sale TDS Entries?';
    begin
        //TDS1.00
        IF "TDS Posting Group" <> '' THEN BEGIN
            IF (FindTDSType = 1) AND ("Original Base" >= 0) THEN
                CalculateTDSBaseAmount2
            ELSE
                IF (FindTDSType = 1) AND ("Original Base" < 0) THEN //amount less than zero in case of manual reverse
                BEGIN
                    IF NOT CONFIRM(AmountNegativeOrZero, FALSE) THEN
                        EXIT;
                    CalculateTDSBaseAmount2;
                END;

            //for blank
            IF (FindTDSType = 0) THEN
                ERROR(TDSTypeBlank, "TDS Posting Group");

            //for Sales TDS
            IF (FindTDSType = 2) AND ("Original Base" <= 0) THEN
                CalculateTDSBaseAmount2
            ELSE
                IF (FindTDSType = 2) AND ("Original Base" > 0) THEN //amount greater than zero in case of manual reverse
                BEGIN
                    IF NOT CONFIRM(AmountPositiveOrZero, FALSE) THEN
                        EXIT;
                    CalculateTDSBaseAmount2;
                END;
        END;
        //TDS1.00
    end;


    local procedure CalculateTDSBaseAmount2()
    var
        AmountNegativeOrZero: Label 'Amount in Negative or Zero. Do you want to Reverse TDS Entries?';
        TDSSetup2: Record "TDS Posting Group";
        TDSAmt: Decimal;
        Amt: Decimal;
    begin
        Currency.InitRoundingPrecision;
        TDSAmt := ROUND("TDS Amount Payment", Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
        "TDS Base Payment Amount" := ROUND((100 * TDSAmt) / "TDS%", Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
        IF ("TDS Base Payment Amount" - "Original Base") >= 0.02 THEN
            "TDS Base Payment Amount" := "Original Base";
    end;

    local procedure FindTDSType(): Integer
    var
        TDSSetup2: Record "TDS Posting Group";
    begin
        TDSSetup2.RESET;
        TDSSetup2.SETRANGE(Code, "TDS Posting Group");
        IF TDSSetup2.FINDFIRST THEN
            EXIT(TDSSetup2.Type);
    end;


    procedure SetValues(NewPostingDate: Date; NewExtDocNo: Code[20]; NewNarration: Text)
    begin
        PostingDate := NewPostingDate;
        ExtDocNo := NewExtDocNo;
        NarrationText := NewNarration;
    end;
}

