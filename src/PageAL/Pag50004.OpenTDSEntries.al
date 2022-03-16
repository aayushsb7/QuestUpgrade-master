page 50004 "Open TDS Entries"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Original TDS Entry";
    SourceTableView = WHERE(Closed = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                    Editable = false;
                }
                field("Posting Date"; "Posting Date")
                {
                    Editable = false;
                }
                field("Document No."; "Document No.")
                {
                    Editable = false;
                }
                field("Main G/L Account"; "Main G/L Account")
                {
                    Editable = false;
                }
                field("Main G/L Account Name"; "Main G/L Account Name")
                {
                    Editable = false;
                }
                field("Source Type"; "Source Type")
                {
                    Editable = false;
                }
                field("Bill-to/Pay-to No."; "Bill-to/Pay-to No.")
                {
                    Editable = false;
                }
                field("TDS Posting Group"; "TDS Posting Group")
                {
                    Editable = false;
                }
                field("GL Account"; "GL Account")
                {
                    Editable = false;
                }
                field("GL Account Name"; "GL Account Name")
                {
                    Editable = false;
                    Visible = true;
                }
                field("TDS%"; "TDS%")
                {
                    Editable = false;
                }
                field(Narration; Narration)
                {
                    Editable = false;
                }
                field("Original Base"; "Original Base")
                {
                    Editable = false;
                }
                field("Original TDS Amount"; "Original TDS Amount")
                {
                    Editable = false;
                }
                field("Remaining TDS Base"; RemainingTDSBaseAmount)
                {
                    Editable = false;
                    Visible = true;
                }
                field("Remaining TDS Amount"; RemainingTDSAmount)
                {
                    Editable = false;
                }
                field("Paid TDS Amount"; "Paid TDS Amount")
                {
                }
                field("TDS Base Payment Amount"; "TDS Base Payment Amount")
                {
                    Editable = false;
                    Visible = true;
                }
                field("TDS Payment Amt"; "TDS Amount Payment")
                {
                    Caption = 'TDS Payment Amt';
                }
                field("Paid TDS Base Amount"; "Paid TDS Base Amount")
                {
                }
                field("User ID"; "User ID")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Source Code"; "Source Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Transaction No."; "Transaction No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("External Document No."; "External Document No.")
                {
                }
                field("Document Date"; "Document Date")
                {
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("TDS Type"; "TDS Type")
                {
                    Editable = true;
                    Visible = true;
                }
                field(Closed; Closed)
                {
                    Editable = false;
                    Visible = false;
                }
                field("IRD Voucher No."; "IRD Voucher No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("IRD Voucher Date"; "IRD Voucher Date")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Fiscal Year"; "Fiscal Year")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Reversed Entry No."; "Reversed Entry No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Reversed; Reversed)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Reversed by Entry No."; "Reversed by Entry No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Vendor Name"; "Vendor Name")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Bank Account No."; "Bank Account No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Payment Done"; "Payment Done")
                {
                    Editable = false;
                    Visible = false;
                }
                field("G/L Entry No."; "G/L Entry No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Payment Transaction No."; "Payment Transaction No.")
                {
                    Editable = false;
                    Visible = false;
                }
            }
            group(General1)
            {
                fixed(General2)
                {
                    group(Balance)
                    {
                        Caption = 'Balance';
                        field(TDS; TDSBalance + "Original TDS Amount" - xRec."Original TDS Amount")
                        {
                            AutoFormatType = 1;
                            Caption = 'TDS';
                            Editable = false;
                            Visible = TDSBalanceVisible;
                        }
                        field("TDS Base"; BaseBalance + "Original Base" - xRec."Original Base")
                        {
                            Caption = 'TDS Base';
                        }
                    }
                    group("Total Balance")
                    {
                        Caption = 'Total Balance';
                        field("Total TDS"; TotalTDSBalance + "Original TDS Amount" - xRec."Original TDS Amount")
                        {
                            AutoFormatType = 1;
                            Caption = 'Total TDS';
                            Editable = false;
                            Visible = TotalTDSBalanceVisible;
                        }
                        field("Total TDS Base"; TotalBaseBalance + "Original Base" - xRec."Original Base")
                        {
                            Caption = 'Total TDS Base';
                        }
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
            }
            action("&Navigate")
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Navigate;
                end;
            }
            action("Close TDS Entries")
            {
                Caption = 'Close TDS Entries';
                Image = ClearLog;
                Visible = false;

                trigger OnAction()
                begin
                    //Filters := getfilters;
                    TDSentry.RESET;
                    CurrPage.SETSELECTIONFILTER(TDSentry);
                    IF TDSentry.FINDFIRST THEN BEGIN
                        TDSentry.MARK;
                        REPORT.RUNMODAL(50020, TRUE, FALSE, TDSentry);
                    END;
                end;
            }
            action("Payment Entries")
            {
                Image = LedgerEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "TDS Ledger Entries";
                RunPageLink = "TDS Entry No." = FIELD("Entry No.");
            }
            group(Reports)
            {
                Caption = 'Reports';
            }
            action("TDS Entry")
            {
                Caption = 'TDS Entry';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "TDS Ledger";

                trigger OnAction()
                begin
                    //Filters := getfilters;
                    TDSentry.RESET;
                    TDSentry.COPYFILTERS(Rec);
                    REPORT.RUNMODAL(50001, TRUE, FALSE, TDSentry);
                end;
            }
            action("Vendor TDS Entry")
            {
                Caption = 'Vendor TDS Entry';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report 50021;

                trigger OnAction()
                begin
                    //Filters := getfilters;
                    TDSentry.RESET;
                    TDSentry.COPYFILTERS(Rec);
                    REPORT.RUNMODAL(50001, TRUE, FALSE, TDSentry);
                end;
            }
            action("TDS Payment_Not Used")
            {
                Image = Payment;
                Visible = false;

                trigger OnAction()
                var
                    BankAccNo: Code[20];
                    BankAccountTxt: Label 'Bank Account';
                    BankAccPage: Page "Bank Account List";
                    JournalBatchTxt: Label 'Enter Template and Batch before posting.';
                    GenJnlTemplateName: Code[10];
                    GenJnlBatchName: Code[10];
                    SelectionErr: Label 'Please enter Bank No., Journal Template Name and Journal Batch Name before posting.';
                    GenJnlLine: Record "Gen. Journal Line";
                    GenJnlBatchRec: Record "Gen. Journal Batch";
                    GenJnlTemplateRec: Record "Gen. Journal Template";
                    DocNo: Code[20];
                    LineNo: Integer;
                begin
                    GLSetup.GET;
                    GLSetup.TESTFIELD("TDS Branch Code");

                    TotalBankAmt := 0;
                    LineNo := 10000;
                    BankPageBuilder.ADDRECORD(BankAccountTxt, BankAccount);
                    BankPageBuilder.ADDFIELD(BankAccountTxt, BankAccount."No.");
                    BankPageBuilder.ADDRECORD(JournalBatchTxt, TemplateSecurity);
                    BankPageBuilder.ADDFIELD(JournalBatchTxt, TemplateSecurity."Template Name");
                    BankPageBuilder.ADDFIELD(JournalBatchTxt, TemplateSecurity."Batch Name");
                    BankPageBuilder.RUNMODAL;
                    BankAccount.SETVIEW(BankPageBuilder.GETVIEW(BankAccountTxt));
                    TemplateSecurity.SETVIEW(BankPageBuilder.GETVIEW(JournalBatchTxt));
                    BankAccNo := BankAccount.GETFILTER("No.");
                    GenJnlTemplateName := TemplateSecurity.GETFILTER("Template Name");
                    GenJnlBatchName := TemplateSecurity.GETFILTER("Batch Name");
                    IF (BankAccNo <> '') AND (GenJnlTemplateName <> '') AND (GenJnlBatchName <> '') THEN BEGIN
                        TDSentry.RESET;
                        CurrPage.SETSELECTIONFILTER(TDSentry);
                        IF TDSentry.FINDFIRST THEN BEGIN
                            GenJnlBatchRec.RESET;
                            GenJnlBatchRec.SETRANGE("Journal Template Name", GenJnlTemplateName);
                            GenJnlBatchRec.SETRANGE(Name, GenJnlBatchName);
                            GenJnlBatchRec.SETFILTER("Posting No. Series", '<>%1', '');
                            IF GenJnlBatchRec.FINDFIRST THEN BEGIN
                                DocNo := NoSeriesMgt.GetNextNo(GenJnlBatchRec."No. Series", TODAY, TRUE);
                                IF GenJnlTemplateRec.GET(GenJnlBatchRec."Journal Template Name") THEN
                                    GenJnlLine."Source Code" := GenJnlTemplateRec."Source Code";
                            END;
                            REPEAT
                                IF NOT TDSentry."Payment Done" THEN
                                    TotalBankAmt += TDSentry."Original TDS Amount";
                                IF NOT TDSentry."Payment Done" THEN BEGIN
                                    GenJnlLine.INIT;
                                    GenJnlLine."Document No." := DocNo;
                                    GenJnlLine."Posting No. Series" := GenJnlBatchRec."Posting No. Series";
                                    CreatePaymentJournals(GenJnlLine, TDSentry, FALSE, BankAccNo, GenJnlTemplateName, GenJnlBatchName, LineNo);
                                    LineNo += 10000;
                                END ELSE
                                    ERROR(PaymentAlreadyDone, TDSentry."Document No.", TDSentry."Entry No.");
                            UNTIL TDSentry.NEXT = 0;
                            GenJnlLine.INIT;
                            GenJnlLine."Document No." := DocNo;
                            GenJnlLine."Source Code" := GenJnlTemplateRec."Source Code";
                            CreateBalanceJournal(GenJnlLine, FALSE, BankAccNo, TotalBankAmt, LineNo, GenJnlTemplateName, GenJnlBatchName);
                        END;
                        MESSAGE(TDSPaymentDone);
                    END ELSE
                        ERROR(SelectionErr);
                end;
            }
            action("Post TDS Payment")
            {
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    BankAccountTxt: Label 'Bank Account';
                    JournalBatchTxt: Label 'Enter Template and Batch before posting.';
                    GenJnlTemplateName: Code[10];
                    GenJnlBatchName: Code[10];
                    SelectionErr: Label 'Please enter Bank No. and payment information.';
                    GenJnlLine: Record "Gen. Journal Line";
                    GenJnlBatchRec: Record "Gen. Journal Batch";
                    GenJnlTemplateRec: Record "Gen. Journal Template";
                    DocNo: Code[20];
                    LineNo: Integer;
                    CurrGLAcc: Code[20];
                    PrevGLAcc: Code[20];
                    SourceCode: Code[20];
                    PaymentInfoTxt: Label 'Fill Payment Information';
                    PaymentJnl: Record "Gen. Journal Line";
                    PostingDate: Date;
                    ExtDocNo: Code[20];
                    NarrationText: Text;
                    GenJnlBatch: Codeunit "Gen. Jnl.-Post Batch";
                    TDSBasePmtErr: Label 'TDS Base Payment Amount must be less than or equal to Original Base Amount.';
                    TDSPmtErr: Label 'TDS Amount Payment must be less than or equal to Original TDS Amount.';
                    SameGLErr: Label 'You must select entries with same g/l account code.';
                    TDSAmtExceedErr: Label 'Sum of %1 and %2 exceeds %3.';
                begin
                    TDSentry.RESET;
                    CurrPage.SETSELECTIONFILTER(TDSentry);
                    IF TDSentry.FINDFIRST THEN
                        REPEAT
                            TDSentry.TESTFIELD("TDS Base Payment Amount");
                            TDSentry.TESTFIELD("TDS Amount Payment");
                            TDSentry.TESTFIELD(Closed, FALSE);
                            TDSentry.TESTFIELD("Payment Done", FALSE);
                            TDSentry.CALCFIELDS("Paid TDS Base Amount");
                            TDSentry.CALCFIELDS("Paid TDS Amount");
                            IF TDSentry."TDS Base Payment Amount" > TDSentry."Original Base" THEN
                                ERROR(TDSBasePmtErr);
                            IF TDSentry."TDS Amount Payment" > TDSentry."Original TDS Amount" THEN
                                ERROR(TDSPmtErr);

                            TDSentry.CALCFIELDS("GL Account");
                            CurrGLAcc := TDSentry."GL Account";
                            IF (CurrGLAcc <> PrevGLAcc) AND (PrevGLAcc <> '') THEN
                                ERROR(SameGLErr); //restrict selecting entries with different g/l code.
                            IF (TDSentry."Paid TDS Amount" + TDSentry."TDS Amount Payment") > TDSentry."Original TDS Amount" THEN
                                ERROR(TDSAmtExceedErr, TDSentry.FIELDCAPTION("Paid TDS Amount"), TDSentry.FIELDCAPTION("TDS Amount Payment"), TDSentry.FIELDCAPTION("Original TDS Amount"));
                            PrevGLAcc := CurrGLAcc;
                        UNTIL TDSentry.NEXT = 0;

                    TotalBankAmt := 0;
                    LineNo := 10000;
                    BankPageBuilder.ADDRECORD(BankAccountTxt, BankAccount);
                    BankPageBuilder.ADDFIELD(BankAccountTxt, BankAccount."No.");
                    BankPageBuilder.ADDRECORD(PaymentInfoTxt, GenJnlLine);
                    BankPageBuilder.ADDFIELD(PaymentInfoTxt, PaymentJnl."Posting Date");
                    BankPageBuilder.ADDFIELD(PaymentInfoTxt, PaymentJnl."External Document No.");
                    BankPageBuilder.ADDFIELD(PaymentInfoTxt, PaymentJnl.Narration);
                    BankPageBuilder.RUNMODAL;
                    BankAccount.SETVIEW(BankPageBuilder.GETVIEW(BankAccountTxt));
                    PaymentJnl.SETVIEW(BankPageBuilder.GETVIEW(PaymentInfoTxt));
                    BEGIN
                        GLSetup.GET;
                        GLSetup.TESTFIELD("TDS Payment Jnl Template");
                        GLSetup.TESTFIELD("TDS Payment Jnl Batch");

                        GenJnlLine.SETRANGE("Journal Template Name", GLSetup."TDS Payment Jnl Template");
                        GenJnlLine.SETRANGE("Journal Batch Name", GLSetup."TDS Payment Jnl Batch");
                        GenJnlLine.DELETEALL;

                        BankAccNo := BankAccount.GETFILTER("No.");
                        EVALUATE(PostingDate, PaymentJnl.GETFILTER("Posting Date"));
                        ExtDocNo := PaymentJnl.GETFILTER("External Document No.");
                        NarrationText := PaymentJnl.GETFILTER(Narration);
                        GenJnlTemplateName := GLSetup."TDS Payment Jnl Template";
                        GenJnlBatchName := GLSetup."TDS Payment Jnl Batch";

                        IF (BankAccNo <> '') AND (PostingDate <> 0D) AND (ExtDocNo <> '') AND (NarrationText <> '') THEN BEGIN
                            TDSentry.RESET;
                            CurrPage.SETSELECTIONFILTER(TDSentry);
                            IF TDSentry.FINDFIRST THEN BEGIN
                                IF (BankAccNo <> '') AND (GenJnlTemplateName <> '') AND (GenJnlBatchName <> '') THEN BEGIN
                                    GenJnlBatchRec.RESET;
                                    GenJnlBatchRec.SETRANGE("Journal Template Name", GenJnlTemplateName);
                                    GenJnlBatchRec.SETRANGE(Name, GenJnlBatchName);
                                    GenJnlBatchRec.SETFILTER("Posting No. Series", '<>%1', '');
                                    IF GenJnlBatchRec.FINDFIRST THEN BEGIN
                                        //DocNo := NoSeriesMgt.GetNextNo(GenJnlBatchRec."No. Series",TODAY,TRUE);
                                        COMMIT;
                                        DocNo := NoSeriesMgt.TryGetNextNo(GenJnlBatchRec."No. Series", PostingDate);
                                        IF GenJnlTemplateRec.GET(GenJnlBatchRec."Journal Template Name") THEN
                                            SourceCode := GenJnlTemplateRec."Source Code";
                                    END;
                                END;
                                GenJnlLine.RESET;
                                GenJnlLine.SETRANGE("Journal Template Name", GenJnlTemplateRec.Name);
                                GenJnlLine.SETRANGE("Journal Batch Name", GenJnlBatchRec.Name);
                                IF GenJnlLine.FINDLAST THEN
                                    LineNo := GenJnlLine."Line No." + 10000
                                ELSE
                                    LineNo := 10000;

                                REPEAT
                                    IF NOT TDSentry."Payment Done" THEN BEGIN
                                        TotalBankAmt += TDSentry."TDS Amount Payment";
                                        GenJnlLine.INIT;
                                        GenJnlLine."Journal Template Name" := GenJnlTemplateRec.Name;
                                        GenJnlLine."Journal Batch Name" := GenJnlBatchRec.Name;
                                        GenJnlLine."Document No." := DocNo;
                                        GenJnlLine."Line No." := LineNo;
                                        GenJnlLine."Posting No. Series" := GenJnlBatchRec."Posting No. Series";
                                        GenJnlLine."Source Code" := SourceCode;
                                        TDSentry.SetValues(PostingDate, ExtDocNo, NarrationText);
                                        TDSentry.CreatePaymentJournals(GenJnlLine, TDSentry, FALSE, BankAccNo, GenJnlTemplateName, GenJnlBatchName, LineNo);
                                        LineNo += 10000;
                                    END ELSE
                                        ERROR(PaymentAlreadyDone, "Document No.", "Entry No.");
                                UNTIL TDSentry.NEXT = 0;
                                GenJnlLine.INIT;
                                GenJnlLine."Journal Template Name" := GenJnlTemplateRec.Name;
                                GenJnlLine."Journal Batch Name" := GenJnlBatchRec.Name;
                                GenJnlLine."Line No." := LineNo;
                                GenJnlLine."Document No." := DocNo;
                                GenJnlLine."Source Code" := SourceCode;
                                GenJnlLine."Posting No. Series" := GenJnlBatchRec."Posting No. Series";
                                SetValues(PostingDate, ExtDocNo, NarrationText);
                                CreateBalanceJournal(GenJnlLine, FALSE, BankAccNo, TotalBankAmt, LineNo, GenJnlTemplateName, GenJnlBatchName);
                                COMMIT;
                                IF GenJnlBatch.RUN(GenJnlLine) THEN BEGIN
                                    TDSentry.RESET;
                                    CurrPage.SETSELECTIONFILTER(TDSentry);
                                    IF TDSentry.FINDFIRST THEN
                                        REPEAT
                                            PostTDSEntry(TDSentry);
                                            TDSentry.CALCFIELDS("Paid TDS Base Amount");
                                            TDSentry.CALCFIELDS("Paid TDS Amount");
                                            IF TDSentry."Original TDS Amount" = TDSentry."Paid TDS Amount" THEN BEGIN
                                                TDSentry.Closed := TRUE;
                                                TDSentry."Payment Done" := TRUE;
                                            END;
                                            RemainingTDSBaseAmount := TDSentry."Original Base" - TDSentry."Paid TDS Base Amount";
                                            RemainingTDSAmount := TDSentry."Original TDS Amount" - TDSentry."Paid TDS Amount";
                                            TDSentry.VALIDATE("TDS Amount Payment", 0);
                                            TDSentry."Payment Transaction No." := TDSentry.GetGLEntryTransactionNo(TDSentry."Entry No.");
                                            TDSentry.MODIFY;
                                        UNTIL TDSentry.NEXT = 0;
                                END;
                                MESSAGE(TDSPaymentDone);
                                CurrPage.UPDATE;
                            END ELSE
                                ERROR(SelectionErr);
                        END;
                    END;
                end;
            }
            action("Reverse Transaction")
            {
                Image = ReverseLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    GenJnlLine: Record "Gen. Journal Line";
                    DocNo: Code[20];
                    GLEntry: Record "G/L Entry";
                    LineNo: Integer;
                begin
                    TotalBankAmt := 0;
                    TDSentry.RESET;
                    CurrPage.SETSELECTIONFILTER(TDSentry);
                    IF TDSentry.FINDFIRST THEN BEGIN
                        GLEntry.RESET;
                        GLEntry.SETRANGE("Transaction No.", TDSentry."Payment Transaction No.");
                        IF GLEntry.FINDFIRST THEN
                            DocNo := GLEntry."Document No.";
                        GenJnlLine.INIT;
                        GenJnlLine."Document No." := DocNo;
                        GenJnlLine."Posting No. Series" := GLEntry."No. Series";
                        IF "Source Type" = "Source Type"::Vendor THEN BEGIN
                            GenJnlLine."Document Class" := GenJnlLine."Document Class"::Vendor;
                            GenJnlLine."Document Subclass" := TDSentry."Bill-to/Pay-to No.";
                        END;
                        REPEAT
                            TotalBankAmt += TDSentry."Original TDS Amount";
                            IF (TDSentry."Payment Done") OR (NOT TDSentry.Reversed) THEN BEGIN
                                CreatePaymentJournals(GenJnlLine, TDSentry, TRUE, TDSentry."Bank Account No.", '', GLEntry."Journal Batch Name", LineNo);
                                LineNo += 10000;
                            END ELSE
                                ERROR(ReverseHasAlreadyDone, TDSentry."Document No.");
                        UNTIL TDSentry.NEXT = 0;
                        CreateBalanceJournal(GenJnlLine, TRUE, TDSentry."Bank Account No.", TotalBankAmt, LineNo, '', GLEntry."Journal Batch Name");
                        MESSAGE(TDSReversed);
                    END;
                    //ReverseTDSPaymentEntry(TDSentry);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CalcAmount;
        UpdateBalance;
    end;

    trigger OnAfterGetRecord()
    begin
        CalcAmount;
    end;

    trigger OnInit()
    begin
        TotalTDSBalanceVisible := TRUE; //TDS1.00
        TDSBalanceVisible := TRUE; //TDS1.00
        TotalBaseBalanceVisible := TRUE; //TDS1.00
        BaseBalanceVisible := TRUE; //TDS1.00
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UpdateBalance;
    end;

    var
        Filters: Text[100];
        TDSentry: Record "Original TDS Entry";
        TDSBalance: Decimal;
        TotalTDSBalance: Decimal;
        ShowTDSBalance: Boolean;
        ShowTotalTDSBalance: Boolean;
        [InDataSet]
        TDSBalanceVisible: Boolean;
        [InDataSet]
        TotalTDSBalanceVisible: Boolean;
        GenJnlManagement: Codeunit GenJnlManagement;
        BaseBalance: Decimal;
        TotalBaseBalance: Decimal;
        ShowBaseBalance: Boolean;
        ShowTotalBaseBalance: Boolean;
        [InDataSet]
        BaseBalanceVisible: Boolean;
        [InDataSet]
        TotalBaseBalanceVisible: Boolean;
        BankPageBuilder: FilterPageBuilder;
        BankAccount: Record "Bank Account";
        PaymentAlreadyDone: Label 'Payment has already been done for Document No. %1 Entry No. %2.';
        ReverseHasAlreadyDone: Label 'Document No. %1 has already been reversed.';
        TDSPaymentDone: Label 'The payment for selected TDS Entries has been posted.';
        TDSReversed: Label 'The reversal of payment for selected TDS Entries has been posted.';
        TemplateSecurity: Record "Template Security";
        TotalBankAmt: Decimal;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        GLSetup: Record "General Ledger Setup";
        RemainingTDSBaseAmount: Decimal;
        RemainingTDSAmount: Decimal;
        BankAccNo: Code[20];

    local procedure UpdateBalance()
    begin
        GenJnlManagement.CalcTDSEntryTDSBalance(Rec, xRec, TDSBalance, TotalTDSBalance, ShowTDSBalance, ShowTotalTDSBalance); //TDS1.00
        TDSBalanceVisible := ShowTDSBalance;  //TDS1.00
        TotalTDSBalanceVisible := ShowTotalTDSBalance; //TDS1.00
        GenJnlManagement.CalcTDSEntryBaseBalance(Rec, xRec, BaseBalance, TotalBaseBalance, ShowBaseBalance, ShowTotalBaseBalance); //TDS1.00
        BaseBalanceVisible := ShowBaseBalance;  //TDS1.00
        TotalBaseBalanceVisible := ShowTotalBaseBalance; //TDS1.00
    end;

    procedure PostTDSEntry(OpenTDSEntry: Record "Original TDS Entry")
    var
        TDSLedgEntries: Record "TDS Ledger Entries";
        LastEntryNo: Integer;
    begin
        TDSLedgEntries.RESET;
        IF NOT TDSLedgEntries.FINDLAST THEN
            LastEntryNo := 1
        ELSE
            LastEntryNo := TDSLedgEntries."Entry No." + 1;

        TDSLedgEntries.INIT;
        TDSLedgEntries.TRANSFERFIELDS(OpenTDSEntry);
        TDSLedgEntries."Entry No." := LastEntryNo;
        TDSLedgEntries."TDS Entry No." := OpenTDSEntry."Entry No.";
        TDSLedgEntries."Bank Account No." := BankAccNo;
        TDSLedgEntries.Closed := TRUE;
        TDSLedgEntries."Payment Done" := TRUE;
        TDSLedgEntries.Base := OpenTDSEntry."TDS Base Payment Amount";
        TDSLedgEntries."TDS Amount" := OpenTDSEntry."TDS Amount Payment";
        TDSLedgEntries."Payment Transaction No." := TDSentry.GetGLEntryTransactionNo(OpenTDSEntry."Entry No.");
        TDSLedgEntries."User ID" := USERID;
        TDSLedgEntries.INSERT;
    end;

    local procedure CalcAmount()
    var
        Currency: Record Currency;
    begin
        CALCFIELDS("Paid TDS Base Amount");
        CALCFIELDS("Paid TDS Amount");
        Currency.InitRoundingPrecision;
        RemainingTDSBaseAmount := ROUND(("Original Base" - "Paid TDS Base Amount"), Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
        RemainingTDSAmount := ROUND(("Original TDS Amount" - "Paid TDS Amount"), Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
        //"TDS Base Payment Amount" := ROUND((100*"TDS Amount Payment")/"TDS%",Currency."Amount Rounding Precision",Currency.VATRoundingDirection);
    end;
}

