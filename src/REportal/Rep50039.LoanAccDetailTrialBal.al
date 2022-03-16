report 50039 "Loan Acc. - Detail Trial Bal."
{
    DefaultLayout = RDLC;
    RDLCLayout = './LoanAccDetailTrialBal.rdlc';
    Caption = 'Loan Acc. - Detail Trial Bal.';

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
            column(CompanyName; COMPANYPROPERTY.DISPLAYNAME)
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
                column(ExtDocNo_BankAccLedg;"External Document No.")
                {
                    IncludeCaption = true;
                }
                column(Desc_BankAccLedg;Description)
                {
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
                column(BankAccBalanceLCY;BankAccBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(ContinuedCaption;ContinuedCaptionLbl)
                {
                }
                column(DebitAmount_BankAccountLedgerEntry;"Bank Account Ledger Entry"."Debit Amount")
                {
                }
                column(CreditAmount_BankAccountLedgerEntry;"Bank Account Ledger Entry"."Credit Amount")
                {
                }
                column(DebitAmount;"Debit Amount")
                {
                }
                column(CreditAmount;"Credit Amount")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF NOT PrintReversedEntries AND Reversed THEN
                      CurrReport.SKIP;
                    BankAccLedgEntryExists := TRUE;
                    BankAccBalance := BankAccBalance + Amount;
                    BankAccBalanceLCY := BankAccBalanceLCY + "Amount (LCY)";
                    //SRT July 11th 2019 >>
                    DescriptionText := '';
                    IF "Bank Account Ledger Entry".Narration = '' THEN
                      DescriptionText := "Bank Account Ledger Entry".Description
                    ELSE
                      DescriptionText := "Bank Account Ledger Entry".Description+ '<br>' + 'Narration:' + "Bank Account Ledger Entry".Narration;
                    //SRT July 11th 2019 <<
                end;

                trigger OnPreDataItem()
                begin
                    BankAccLedgEntryExists := FALSE;
                    IF LoaTransactionType = LoaTransactionType::"Interest Payment" THEN //aakrista 12/16/2021
                      SETRANGE("Loan Transaction Type","Loan Transaction Type"::"Interest Payment");
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
                CALCFIELDS("Interest Amount");
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
                        ApplicationArea = Basic,Suite;
                        Caption = 'New Page per Loan';
                        ToolTip = 'Specifies if you want to print each bank account on a separate page.';
                    }
                    field(ExcludeBalanceOnly;ExcludeBalanceOnly)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Exclude Loans That Have a Balance Only';
                        MultiLine = true;
                        ToolTip = 'Specifies if you do not want the report to include entries for bank accounts that have a balance but do not have a net change during the selected time period.';
                    }
                    field(PrintReversedEntries;PrintReversedEntries)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Include Reversed Entries';
                        ToolTip = 'Specifies if you want to include reversed entries in the report.';
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
    end;

    var
        Text000: Label 'Period: %1';
        PrintOnlyOnePerPage: Boolean;
        ExcludeBalanceOnly: Boolean;
        BankAccFilter: Text;
        DateFilter_BankAccount: Text;
        BankAccBalance: Decimal;
        BankAccBalanceLCY: Decimal;
        StartBalance: Decimal;
        StartBalanceLCY: Decimal;
        BankAccLedgEntryExists: Boolean;
        PrintReversedEntries: Boolean;
        PageGroupNo: Integer;
        BankAccDetailTrialBalCapLbl: Label 'Loan Acc. - Detail Trial Bal.';
        CurrReportPageNoCaptionLbl: Label 'Page';
        RepInclBankAcchavingBalLbl: Label 'This report also includes bank accounts that only have balances.';
        BankAccLedgPostingDateCaptionLbl: Label 'Posting Date';
        BankAccBalanceCaptionLbl: Label 'Balance';
        OpenFormatCaptionLbl: Label 'Open';
        BankAccBalanceLCYCaptionLbl: Label 'Balance (LCY)';
        ContinuedCaptionLbl: Label 'Continued';
        DescriptionText: Text;
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

