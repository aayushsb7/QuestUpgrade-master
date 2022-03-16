report 50038 "Loan Acc. - Trial Bal."
{
    DefaultLayout = RDLC;
    RDLCLayout = './LoanAccTrialBal.rdlc';
    Caption = 'Loan Acc. - Trial Bal.';

    dataset
    {
        dataitem(DataItem4558; Table270)
        {
            DataItemTableView = SORTING (No.)
                                WHERE (Type = CONST (Loan));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Bank Acc. Posting Group", "Date Filter";
            column(FilterPeriod_BankAccLedg; STRSUBSTNO(Text000, DateFilter_BankAccount))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(ExcludeBalanceOnly; ExcludeBalanceOnly)
            {
            }
            column(BankAccFilter; BankAccFilter)
            {
            }
            column(StartBalanceLCY; StartBalanceLCY)
            {
            }
            column(StartBalance; StartBalance)
            {
            }
            column(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
            {
            }
            column(ReportFilter; STRSUBSTNO('%1: %2', TABLECAPTION, BankAccFilter))
            {
            }
            column(No_BankAccount; "No.")
            {
            }
            column(Name_BankAccount; Name)
            {
            }
            column(PhNo_BankAccount; "Phone No.")
            {
                IncludeCaption = true;
            }
            column(CurrencyCode_BankAccount; "Currency Code")
            {
                IncludeCaption = true;
            }
            column(StartBalance2; StartBalance)
            {
                AutoFormatExpression = "Bank Account Ledger Entry"."Currency Code";
                AutoFormatType = 1;
            }
            column(BankAccDetailTrialBalCap; BankAccDetailTrialBalCapLbl)
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(RepInclBankAcchavingBal; RepInclBankAcchavingBalLbl)
            {
            }
            column(BankAccLedgPostingDateCaption; BankAccLedgPostingDateCaptionLbl)
            {
            }
            column(BankAccBalanceCaption; BankAccBalanceCaptionLbl)
            {
            }
            column(OpenFormatCaption; OpenFormatCaptionLbl)
            {
            }
            column(BankAccBalanceLCYCaption; BankAccBalanceLCYCaptionLbl)
            {
            }
            column(TotalOpeningBalLCY; TotalOpeningBalLCY)
            {
            }
            column(TotalOpeningBal; TotalOpeningBal)
            {
            }
            column(IssuingBank_BankAccount; "Bank Account"."Issuing Bank")
            {
            }
            column(IssuingBankName_BankAccount; "Bank Account"."Issuing Bank Name")
            {
            }
            dataitem(DataItem4920; Table271)
            {
                DataItemLink = Bank Account No.=FIELD(No.),
                               Posting Date=FIELD(Date Filter),
                               Global Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                               Global Dimension 1 Code=FIELD(Global Dimension 1 Filter);
                DataItemTableView = SORTING(Bank Account No.,Posting Date);
                column(PostingDate_BankAccLedg;FORMAT("Posting Date"))
                {
                }
                column(DocType_BankAccLedg;"Document Type")
                {
                    IncludeCaption = true;
                }
                column(DocNo_BankAccLedg;"Document No.")
                {
                    IncludeCaption = true;
                }
                column(Desc_BankAccLedg;Description)
                {
                    IncludeCaption = true;
                }
                column(BankAccBalance;BankAccBalance)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(RemaningAmt_BankAccLedg;"Remaining Amount")
                {
                    IncludeCaption = true;
                }
                column(EntryNo_BankAccLedg;"Entry No.")
                {
                    IncludeCaption = true;
                }
                column(OpenFormat;FORMAT(Open))
                {
                    OptionCaption = 'Open';
                }
                column(Amount_BankAccLedg;Amount)
                {
                    IncludeCaption = true;
                }
                column(EntryAmtLcy_BankAccLedg;"Amount (LCY)")
                {
                    IncludeCaption = true;
                }
                column(DebitAmount_BankAccountLedgerEntry;"Bank Account Ledger Entry"."Debit Amount")
                {
                }
                column(CreditAmount_BankAccountLedgerEntry;"Bank Account Ledger Entry"."Credit Amount")
                {
                }
                column(Amount_BankAccountLedgerEntry;"Bank Account Ledger Entry".Amount)
                {
                }
                column(CreditAmountLCY_BankAccountLedgerEntry;"Bank Account Ledger Entry"."Credit Amount (LCY)")
                {
                }
                column(DebitAmountLCY_BankAccountLedgerEntry;"Bank Account Ledger Entry"."Debit Amount (LCY)")
                {
                }
                column(BankAccBalanceLCY;BankAccBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(ContinuedCaption;ContinuedCaptionLbl)
                {
                }
                column(ExternalDocumentNo_BankAccountLedgerEntry;"Bank Account Ledger Entry"."External Document No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF NOT PrintReversedEntries AND Reversed THEN
                      CurrReport.SKIP;
                    BankAccLedgEntryExists := TRUE;
                    BankAccBalance := BankAccBalance + Amount;
                    BankAccBalanceLCY := BankAccBalanceLCY + "Amount (LCY)"
                end;

                trigger OnPreDataItem()
                begin
                    BankAccLedgEntryExists := FALSE;
                    IF LoaTransactionType = LoaTransactionType::"Interest Payment" THEN
                      SETRANGE("Loan Transaction Type","Loan Transaction Type"::"Interest Payment")
                    ELSE
                      SETFILTER("Loan Transaction Type",'<>%1',"Loan Transaction Type"::"Interest Payment");
                    CurrReport.CREATETOTALS(Amount,"Amount (LCY)");
                end;
            }
            dataitem(DataItem5444;Table2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number=CONST(1));

                trigger OnAfterGetRecord()
                begin
                    IF NOT BankAccLedgEntryExists AND ((StartBalance = 0) OR ExcludeBalanceOnly) THEN BEGIN
                      StartBalanceLCY := 0;
                      CurrReport.SKIP;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                StartBalance := 0;
                IF DateFilter_BankAccount <> '' THEN
                  IF GETRANGEMIN("Date Filter") <> 0D THEN BEGIN
                    SETRANGE("Date Filter",0D,GETRANGEMIN("Date Filter") - 1);
                    CALCFIELDS("Net Change","Net Change (LCY)");
                    CALCFIELDS("Interest Amount");
                    CALCFIELDS("Repayment Amount");
                    CALCFIELDS("Disbursement Amount");
                    Value := "Repayment Amount" + "Disbursement Amount";
                    IF LoaTransactionType = LoaTransactionType::"Interest Payment" THEN  BEGIN
                      StartBalance := "Interest Amount";
                      StartBalanceLCY := "Interest Amount";
                    END ELSE BEGIN
                      StartBalance := Value;
                      StartBalanceLCY := Value;
                    END;
                    SETFILTER("Date Filter",DateFilter_BankAccount);
                  END;
                CurrReport.PRINTONLYIFDETAIL := ExcludeBalanceOnly OR (StartBalance = 0);
                BankAccBalance := StartBalance;
                BankAccBalanceLCY := StartBalanceLCY;
                TotalOpeningBal += StartBalance;  //VNC2016CU5
                TotalOpeningBalLCY += StartBalanceLCY; //VNC2016CU5
                IF PrintOnlyOnePerPage THEN
                  PageGroupNo := PageGroupNo + 1;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;
                CurrReport.CREATETOTALS("Bank Account Ledger Entry"."Amount (LCY)",StartBalanceLCY);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PrintOnlyOnePerPage;PrintOnlyOnePerPage)
                    {
                        Caption = 'New Page per Loan';
                    }
                    field(ExcludeBalanceOnly;ExcludeBalanceOnly)
                    {
                        Caption = 'Exclude Loans That Have a Balance Only';
                        MultiLine = true;
                    }
                    field(PrintReversedEntries;PrintReversedEntries)
                    {
                        Caption = 'Include Reversed Entries';
                    }
                    field(LoaTransactionType;LoaTransactionType)
                    {
                        Caption = 'Loan Transaction Type';
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

    trigger OnInitReport()
    begin
        PageGroupNo := 1;
    end;

    trigger OnPreReport()
    begin
        BankAccFilter := "Bank Account".GETFILTERS;
        DateFilter_BankAccount := "Bank Account".GETFILTER("Date Filter");
        TotalOpeningBal := 0;  //VNC2016CU5
        TotalOpeningBalLCY := 0; //VNC2016CU5
    end;

    var
        Text000: Label 'Period: %1';
        PrintOnlyOnePerPage: Boolean;
        ExcludeBalanceOnly: Boolean;
        BankAccFilter: Text;
        DateFilter_BankAccount: Text[30];
        BankAccBalance: Decimal;
        BankAccBalanceLCY: Decimal;
        StartBalance: Decimal;
        StartBalanceLCY: Decimal;
        BankAccLedgEntryExists: Boolean;
        PrintReversedEntries: Boolean;
        PageGroupNo: Integer;
        BankAccDetailTrialBalCapLbl: Label 'Loan Acc. - Trial Bal.';
        CurrReportPageNoCaptionLbl: Label 'Page';
        RepInclBankAcchavingBalLbl: Label 'This report also includes Loans that only have balances.';
        BankAccLedgPostingDateCaptionLbl: Label 'Posting Date';
        BankAccBalanceCaptionLbl: Label 'Balance';
        OpenFormatCaptionLbl: Label 'Open';
        BankAccBalanceLCYCaptionLbl: Label 'Balance (LCY)';
        ContinuedCaptionLbl: Label 'Continued';
        TotalOpeningBal: Decimal;
        TotalOpeningBalLCY: Decimal;
        LoaTransactionType: Option ,Loan,"Interest Payment";
        Value: Decimal;

    [Scope('Internal')]
    procedure InitializeRequest(NewPrintOnlyOnePerPage: Boolean;NewExcludeBalanceOnly: Boolean;NewPrintReversedEntries: Boolean)
    begin
        PrintOnlyOnePerPage := NewPrintOnlyOnePerPage;
        ExcludeBalanceOnly := NewExcludeBalanceOnly;
        PrintReversedEntries := NewPrintReversedEntries;
    end;
}

