page 50049 "TDS Ledger Entries"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "TDS Ledger Entries";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("TDS Entry No."; "TDS Entry No.")
                {
                }
                field("Entry No."; "Entry No.")
                {
                }
                field("Posting Date"; "Posting Date")
                {
                }
                field("Document No."; "Document No.")
                {
                }
                field("Main G/L Account"; "Main G/L Account")
                {
                }
                field("Main G/L Account Name"; "Main G/L Account Name")
                {
                }
                field("Source Type"; "Source Type")
                {
                }
                field("Bill-to/Pay-to No."; "Bill-to/Pay-to No.")
                {
                }
                field("TDS Posting Group"; "TDS Posting Group")
                {
                }
                field("GL Account"; "GL Account")
                {
                }
                field("GL Account Name"; "GL Account Name")
                {
                    Visible = true;
                }
                field("TDS%"; "TDS%")
                {
                }
                field(Narration; Narration)
                {
                }
                field(Base; Base)
                {
                }
                field("TDS Amount"; "TDS Amount")
                {
                }
                field("User ID"; "User ID")
                {
                }
                field("Source Code"; "Source Code")
                {
                }
                field("Transaction No."; "Transaction No.")
                {
                }
                field("External Document No."; "External Document No.")
                {
                }
                field("Document Date"; "Document Date")
                {
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                }
                field("TDS Type"; "TDS Type")
                {
                }
                field(Closed; Closed)
                {
                }
                field("IRD Voucher No."; "IRD Voucher No.")
                {
                }
                field("IRD Voucher Date"; "IRD Voucher Date")
                {
                }
                field("Fiscal Year"; "Fiscal Year")
                {
                }
                field("Reversed Entry No."; "Reversed Entry No.")
                {
                }
                field(Reversed; Reversed)
                {
                }
                field("Reversed by Entry No."; "Reversed by Entry No.")
                {
                }
                field("Vendor Name"; "Vendor Name")
                {
                    Visible = false;
                }
                field("Bank Account No."; "Bank Account No.")
                {
                }
                field("Payment Done"; "Payment Done")
                {
                }
                field("G/L Entry No."; "G/L Entry No.")
                {
                }
                field("Payment Transaction No."; "Payment Transaction No.")
                {
                }
            }
            group(General1)
            {
                fixed(General2)
                {
                    group(Balance)
                    {
                        Caption = 'Balance';
                        field(TDS; TDSBalance + "TDS Amount" - xRec."TDS Amount")
                        {
                            AutoFormatType = 1;
                            Caption = 'TDS';
                            Editable = false;
                            Visible = TDSBalanceVisible;
                        }
                        field("TDS Base"; BaseBalance + Base - xRec.Base)
                        {
                            Caption = 'TDS Base';
                        }
                    }
                    group("Total Balance")
                    {
                        Caption = 'Total Balance';
                        field("Total TDS"; TotalTDSBalance + "TDS Amount" - xRec."TDS Amount")
                        {
                            AutoFormatType = 1;
                            Caption = 'Total TDS';
                            Editable = false;
                            Visible = TotalTDSBalanceVisible;
                        }
                        field("Total TDS Base"; TotalBaseBalance + Base - xRec.Base)
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
            action("Reverse Transaction")
            {
                Image = ReverseLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction()
                var
                    GenJnlLine: Record "Gen. Journal Line";
                    DocNo: Code[20];
                    GLEntry: Record "G/L Entry";
                    LineNo: Integer;
                    TDSLedgEntry: Record "TDS Ledger Entries";
                begin
                    IF NOT CONFIRM('Do you want to reverse the transaction?', FALSE) THEN
                        EXIT;
                    IF Reversed THEN
                        ERROR('The document has already been reversed');

                    TotalBankAmt := 0;
                    TDSLedgEntry.RESET;
                    CurrPage.SETSELECTIONFILTER(TDSLedgEntry);
                    IF TDSLedgEntry.FINDFIRST THEN BEGIN
                        GLEntry.RESET;
                        GLEntry.SETRANGE("Transaction No.", TDSLedgEntry."Payment Transaction No.");
                        IF GLEntry.FINDFIRST THEN
                            DocNo := GLEntry."Document No.";
                        GenJnlLine.INIT;
                        GenJnlLine."Document No." := DocNo;
                        GenJnlLine."Posting No. Series" := GLEntry."No. Series";
                        IF "Source Type" = "Source Type"::Vendor THEN BEGIN
                            GenJnlLine."Document Class" := GenJnlLine."Document Class"::Vendor;
                            GenJnlLine."Document Subclass" := TDSLedgEntry."Bill-to/Pay-to No.";
                        END;
                        REPEAT
                            TotalBankAmt += TDSLedgEntry."TDS Amount";
                            IF (TDSLedgEntry."Payment Done") OR (NOT TDSLedgEntry.Reversed) THEN BEGIN
                                CreatePaymentJournals(GenJnlLine, TDSLedgEntry, TRUE, TDSLedgEntry."Bank Account No.", '', GLEntry."Journal Batch Name", LineNo);
                                LineNo += 10000;
                            END ELSE
                                ERROR(ReverseHasAlreadyDone, TDSLedgEntry."Document No.");
                        UNTIL TDSLedgEntry.NEXT = 0;
                        CreateBalanceJournal(GenJnlLine, TRUE, TDSLedgEntry."Bank Account No.", TotalBankAmt, LineNo, '', GLEntry."Journal Batch Name");
                        CreateReversalTDSEntry(TDSLedgEntry); //Sameer Bhujel Jan 15
                        MESSAGE(TDSReversed);
                    END;
                    //ReverseTDSPaymentEntry(TDSentry);
                end;

            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateBalance;
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

    local procedure CreateReversalTDSEntry(TDSEntry: Record "TDS Ledger Entries")
    var
        TDSLedgerEntry: Record "TDS Ledger Entries";
        EntryNo: Integer;
    begin
        TDSLedgerEntry.RESET;
        IF TDSLedgerEntry.FINDLAST THEN
            EntryNo := TDSLedgerEntry."Entry No." + 1
        ELSE
            EntryNo := 1;
        TDSLedgerEntry.INIT;
        TDSLedgerEntry.TRANSFERFIELDS(TDSEntry);
        TDSLedgerEntry."Entry No." := EntryNo;
        TDSLedgerEntry."TDS Amount" := -TDSEntry."TDS Amount";
        TDSLedgerEntry.Base := -TDSEntry.Base;
        TDSLedgerEntry."Posting Date" := TODAY;
        TDSLedgerEntry.Reversed := TRUE;
        TDSLedgerEntry."Reversed by Entry No." := TDSEntry."Entry No.";
        TDSLedgerEntry."Reversed Entry No." := TDSLedgerEntry."Entry No.";
        TDSLedgerEntry.INSERT(TRUE);
    end;

    local procedure UpdateBalance()
    begin
        /*GenJnlManagement.CalcTDSEntryTDSBalance(Rec,xRec,TDSBalance,TotalTDSBalance,ShowTDSBalance,ShowTotalTDSBalance); //TDS1.00
        TDSBalanceVisible := ShowTDSBalance;  //TDS1.00
        TotalTDSBalanceVisible := ShowTotalTDSBalance; //TDS1.00
        GenJnlManagement.CalcTDSEntryBaseBalance(Rec,xRec,BaseBalance,TotalBaseBalance,ShowBaseBalance,ShowTotalBaseBalance); //TDS1.00
        BaseBalanceVisible := ShowBaseBalance;  //TDS1.00
        TotalBaseBalanceVisible := ShowTotalBaseBalance; //TDS1.00*/

    end;

    var
        Filters: Text[100];
        TDSentry: Record "TDS Ledger Entries";
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

}





