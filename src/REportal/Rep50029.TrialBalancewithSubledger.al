report 50029 "Trial Balance with Subledger"
{
    DefaultLayout = RDLC;
    RDLCLayout = './TrialBalancewithSubledger.rdlc';

    dataset
    {
        dataitem(DataItem1; Table2000000026)
        {
            DataItemTableView = SORTING (Number);
            column(Entry_No_; TempGLEntry."Entry No.")
            {
            }
            column(GL_Account_No_; TempGLEntry."G/L Account No.")
            {
            }
            column(GL_Account_Name; TempGLEntry.Description)
            {
            }
            column(SubLedger; TempGLEntry."Source No.")
            {
            }
            column(SubLedgerName; TempGLEntry.Narration)
            {
            }
            column(NetChange; TempGLEntry."Add.-Currency Debit Amount")
            {
            }
            column(Opening; TempGLEntry."Add.-Currency Credit Amount")
            {
            }
            column(Closing; TempGLEntry.Amount)
            {
            }
            column(StartDateText; StartDateText)
            {
            }
            column(EndDate; FORMAT(EndDate))
            {
            }
            column(StartDate; FORMAT(StartDate))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(ReportHeading; ReportHeading)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Number = 1 THEN
                    TempGLEntry.FINDFIRST
                ELSE
                    TempGLEntry.NEXT;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE(Number, 1, TempGLEntry.COUNT);
            end;
        }
        dataitem(DataItem9; Table15)
        {
            column(TotalDebitOpeningBalance; TotalDebitOpeningBalance)
            {
            }
            column(TotalCreditOpeningBalance; TotalCreditOpeningBalance)
            {
            }
            column(TotalDebitNetChange; TotalDebitNetChange)
            {
            }
            column(TotalCreditNetChange; TotalCreditNetChange)
            {
            }
            column(TotalDebitBalanceatdate; TotalDebitBalanceatdate)
            {
            }
            column(TotalCreditBalanceatdate; TotalCreditBalanceatdate)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CALCFIELDS("Net Change", "Balance at Date");
                //SUB1.00
                OpeningBalance := ("Balance at Date" - "Net Change");
                //SUB1.00
                IF "Account Type" = "Account Type"::Posting THEN BEGIN
                    //Opening Balance
                    IF OpeningBalance >= 0 THEN BEGIN
                        DebitOpeningBalance := OpeningBalance;
                        TotalDebitOpeningBalance += DebitOpeningBalance;
                    END;
                    IF OpeningBalance < 0 THEN BEGIN
                        CreditOpeningBalance := OpeningBalance;
                        TotalCreditOpeningBalance += CreditOpeningBalance;
                    END;
                    //Net Change
                    IF "Net Change" >= 0 THEN BEGIN
                        DebitNetchange := "Net Change";
                        TotalDebitNetChange += DebitNetchange;
                    END;
                    IF "Net Change" < 0 THEN BEGIN
                        CreditNetChange := "Net Change";
                        TotalCreditNetChange += CreditNetChange;
                    END;
                    //Balance at date
                    IF "Balance at Date" >= 0 THEN BEGIN
                        DebitBalanceatdate := "Balance at Date";
                        TotalDebitBalanceatdate += DebitBalanceatdate;
                    END;
                    IF "Balance at Date" < 0 THEN BEGIN
                        CreditBalanceatdate := "Balance at Date";
                        TotalCreditBalanceatdate += CreditBalanceatdate;
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Date Filter", '%1..%2', StartDate, EndDate);
                OpeningBalance := 0;
                DebitOpeningBalance := 0;
                TotalDebitOpeningBalance := 0;
                CreditOpeningBalance := 0;
                TotalCreditOpeningBalance := 0;
                DebitNetchange := 0;
                TotalDebitNetChange := 0;
                CreditNetChange := 0;
                TotalCreditNetChange := 0;
                DebitBalanceatdate := 0;
                TotalDebitBalanceatdate := 0;
                CreditBalanceatdate := 0;
                TotalCreditBalanceatdate := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Option)
                {
                    Caption = 'Option';
                    field("Starting Date"; StartDate)
                    {
                        Caption = 'Starting Date';
                    }
                    field("Ending Date"; EndDate)
                    {
                        Caption = 'Ending Date';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        StartDateText := FORMAT(StartDate - 1);

        GetData;
    end;

    var
        TempGLEntry: Record "17" temporary;
        StartDate: Date;
        EndDate: Date;
        StartDateText: Text;
        OpeningBalance: Decimal;
        DebitOpeningBalance: Decimal;
        TotalDebitOpeningBalance: Decimal;
        CreditOpeningBalance: Decimal;
        TotalCreditOpeningBalance: Decimal;
        DebitNetchange: Decimal;
        TotalDebitNetChange: Decimal;
        CreditNetChange: Decimal;
        TotalCreditNetChange: Decimal;
        DebitBalanceatdate: Decimal;
        TotalDebitBalanceatdate: Decimal;
        CreditBalanceatdate: Decimal;
        TotalCreditBalanceatdate: Decimal;
        ReportHeading: Label 'Trial Balance Showing SubLedger Totals';

    local procedure GetData()
    var
        GLentry: Record "17";
    begin
        GLentry.RESET;
        GLentry.SETFILTER("Entry No.", '>%1', 0);
        GLentry.SETRANGE("Posting Date", 0D, EndDate);
        IF GLentry.FINDSET THEN BEGIN
            REPEAT
                InsertGLRecord(GLentry);
                ModifyOpeningRecord;
                ModifyNetChangeRecord;
            UNTIL GLentry.NEXT = 0;
        END;
    end;

    local procedure InsertGLRecord(GLentry: Record "17")
    var
        SourceName: Text[50];
        BankAccount: Record "270";
        FixedAsset: Record "5600";
        Vendor: Record "23";
        Customer: Record "18";
        LcDetails: Record "50008";
    begin
        TempGLEntry.INIT;
        TempGLEntry."Entry No." := GLentry."Entry No.";
        TempGLEntry."Posting Date" := GLentry."Posting Date";
        TempGLEntry."G/L Account No." := GLentry."G/L Account No.";
        GLentry.CALCFIELDS("G/L Account Name");
        TempGLEntry.Description := GLentry."G/L Account Name";
        TempGLEntry.Amount := GLentry.Amount;

        CASE TRUE OF
            GLentry."Source No." <> '':
                BEGIN
                    CLEAR(SourceName);
                    TempGLEntry."Source No." := GLentry."Source No.";
                    CASE GLentry."Source Type" OF
                        GLentry."Source Type"::"Bank Account":
                            BEGIN
                                BankAccount.RESET;
                                BankAccount.SETRANGE("No.", GLentry."Source No.");
                                IF BankAccount.FINDFIRST THEN BEGIN
                                    SourceName := BankAccount.Name;
                                    TempGLEntry.Narration := SourceName;
                                END;
                            END;
                        GLentry."Source Type"::"Fixed Asset":
                            BEGIN
                                FixedAsset.RESET;
                                FixedAsset.SETRANGE("No.", GLentry."Source No.");
                                IF FixedAsset.FINDFIRST THEN BEGIN
                                    SourceName := FixedAsset.Description;
                                    TempGLEntry.Narration := SourceName;
                                END;
                            END;
                        GLentry."Source Type"::Vendor:
                            BEGIN
                                Vendor.RESET;
                                Vendor.SETRANGE("No.", GLentry."Source No.");
                                IF Vendor.FINDFIRST THEN BEGIN
                                    SourceName := Vendor.Name;
                                    TempGLEntry.Narration := SourceName;
                                END;
                            END;
                        GLentry."Source Type"::Customer:
                            BEGIN
                                Customer.RESET;
                                Customer.SETRANGE("No.", GLentry."Source No.");
                                IF Customer.FINDFIRST THEN BEGIN
                                    SourceName := Customer.Name;
                                    TempGLEntry.Narration := SourceName;
                                END;
                            END;
                    END;
                END;
            ((GLentry."Sys. LC No." <> '') AND (GLentry."TR Loan Code" = '')):
                BEGIN
                    TempGLEntry."Source No." := GLentry."Sys. LC No.";
                    IF LcDetails.GET(GLentry."Sys. LC No.") THEN
                        TempGLEntry.Narration := LcDetails."LC\DO No.";
                END;
            ((GLentry."Sys. LC No." <> '') AND (GLentry."TR Loan Code" <> '')):
                TempGLEntry."Source No." := GLentry."TR Loan Code";
        END;
        TempGLEntry.INSERT;
    end;

    local procedure ModifyOpeningRecord()
    begin
        IF (TempGLEntry."Posting Date" > 0D) AND (TempGLEntry."Posting Date" <= (CALCDATE('<-1D>', StartDate))) THEN BEGIN
            TempGLEntry."Add.-Currency Credit Amount" := TempGLEntry.Amount;
            TempGLEntry.MODIFY;
        END;
    end;

    local procedure ModifyNetChangeRecord()
    begin
        IF (TempGLEntry."Posting Date" >= StartDate) AND (TempGLEntry."Posting Date" <= EndDate) THEN BEGIN
            TempGLEntry."Add.-Currency Debit Amount" := TempGLEntry.Amount;
            TempGLEntry.MODIFY;
        END;
    end;
}

