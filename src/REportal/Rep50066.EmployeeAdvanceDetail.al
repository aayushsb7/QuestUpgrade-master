report 50066 "Employee Advance Detail"
{
    DefaultLayout = RDLC;
    RDLCLayout = './EmployeeAdvanceDetail.rdlc';
    Caption = 'Employee Advance Detail';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(DataItem6836; Table5200)
        {
            DataItemTableView = SORTING (No.);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Date Filter", "Employee Transaction Type", "Global Dimension 1 Filter", "Global Dimension 2 Filter";
            column(TodayFormatted; FORMAT(TODAY))
            {
            }
            column(PeriodCustDatetFilter; STRSUBSTNO(Text000, CustDateFilter))
            {
            }
            column(CompanyName; COMPANYPROPERTY.DISPLAYNAME)
            {
            }
            column(PrintAmountsInLCY; PrintAmountsInLCY)
            {
            }
            column(ExcludeBalanceOnly; ExcludeBalanceOnly)
            {
            }
            column(CustFilterCaption; TABLECAPTION + ': ' + CustFilter)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(AmountCaption; AmountCaption)
            {
            }
            column(RemainingAmtCaption; RemainingAmtCaption)
            {
            }
            column(No_Cust; "No.")
            {
            }
            column(Name_Cust; FullName)
            {
            }
            column(PhoneNo_Cust; "Phone No.")
            {
                IncludeCaption = true;
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(StartBalAdjLCY; StartBalAdjLCY)
            {
                AutoFormatType = 1;
            }
            column(CustLedgerEntryAmtLCY; "Employee Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding)
            {
                AutoFormatType = 1;
            }
            column(StartBalanceLCYAdjLCY; StartBalanceLCY + StartBalAdjLCY)
            {
                AutoFormatType = 1;
            }
            column(StrtBalLCYCustLedgEntryAmt; StartBalanceLCY + "Employee Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding)
            {
                AutoFormatType = 1;
            }
            column(CustDetailTrialBalCaption; CustDetailTrialBalCaptionLbl)
            {
            }
            column(PageNoCaption; PageNoCaptionLbl)
            {
            }
            column(AllAmtsLCYCaption; AllAmtsLCYCaptionLbl)
            {
            }
            column(RepInclCustsBalCptn; RepInclCustsBalCptnLbl)
            {
            }
            column(PostingDateCaption; PostingDateCaptionLbl)
            {
            }
            column(DueDateCaption; DueDateCaptionLbl)
            {
            }
            column(BalanceLCYCaption; BalanceLCYCaptionLbl)
            {
            }
            column(AdjOpeningBalCaption; AdjOpeningBalCaptionLbl)
            {
            }
            column(BeforePeriodCaption; BeforePeriodCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(OpeningBalCaption; OpeningBalCaptionLbl)
            {
            }
            column(ExternalDocNoCaption; ExternalDocNoCaptionLbl)
            {
            }
            column(EmployeeOpening; EmployeeOpening)
            {
            }
            column(Summary; Summary)
            {
            }
            column(ReportName; ReportName)
            {
            }
            dataitem(EmployeePostingGroup; Table5221)
            {
                DataItemTableView = SORTING (Code);
                PrintOnlyIfDetail = true;
                column(Code_EmployeePostingGroup; Code)
                {
                }
                column(PayablesAccount_EmployeePostingGroup; "Payables Account")
                {
                }
                column(StartBalanceLCY; StartBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(CustBalanceLCY; CustBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                dataitem(DataItem8503; Table5222)
                {
                    DataItemLink = G/L Account No.=FIELD(Payables Account);
                    DataItemTableView = SORTING (Employee No., Posting Date);
                    column(PostDate_CustLedgEntry; FORMAT("Posting Date"))
                    {
                    }
                    column(DocType_CustLedgEntry; "Document Type")
                    {
                        IncludeCaption = true;
                    }
                    column(DocNo_CustLedgEntry; "Document No.")
                    {
                        IncludeCaption = true;
                    }
                    column(ExtDocNo_CustLedgEntry; '')
                    {
                    }
                    column(Desc_CustLedgEntry; Description)
                    {
                        IncludeCaption = true;
                    }
                    column(CustAmount; CustAmount)
                    {
                        AutoFormatExpression = CustCurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(CustRemainAmount; CustRemainAmount)
                    {
                        AutoFormatExpression = CustCurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(CustEntryDueDate; FORMAT(CustEntryDueDate))
                    {
                    }
                    column(EntryNo_CustLedgEntry; "Entry No.")
                    {
                        IncludeCaption = true;
                    }
                    column(CustCurrencyCode; CustCurrencyCode)
                    {
                    }
                    column(CustBalanceLCY1; CustBalanceLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(DebitAmountLCY_EmployeeLedgerEntry; "Employee Ledger Entry"."Debit Amount (LCY)")
                    {
                    }
                    column(CreditAmountLCY_EmployeeLedgerEntry; "Employee Ledger Entry"."Credit Amount (LCY)")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CALCFIELDS(Amount, "Remaining Amount", "Amount (LCY)", "Remaining Amt. (LCY)");
                        CustLedgEntryExists := TRUE;
                        IF PrintAmountsInLCY THEN BEGIN
                            CustAmount := "Amount (LCY)";
                            CustRemainAmount := "Remaining Amt. (LCY)";
                            CustCurrencyCode := '';
                        END ELSE BEGIN
                            CustAmount := Amount;
                            CustRemainAmount := "Remaining Amount";
                            CustCurrencyCode := "Currency Code";
                        END;
                        CustBalanceLCY := CustBalanceLCY + "Amount (LCY)";
                        RunningBalance += "Amount (LCY)";
                        RunningBalanceTotal += "Amount (LCY)";
                    end;

                    trigger OnPreDataItem()
                    begin
                        CustLedgEntryExists := FALSE;
                        CurrReport.CREATETOTALS(CustAmount, "Amount (LCY)");

                        SETRANGE("Employee No.", Employee."No.");
                        SETFILTER("Posting Date", Employee.GETFILTER("Date Filter"));
                        SETFILTER("Global Dimension 1 Code", Employee.GETFILTER("Global Dimension 1 Filter"));
                        SETFILTER("Global Dimension 2 Code", Employee.GETFILTER("Global Dimension 2 Filter"));
                    end;
                }
                dataitem(DataItem5444; Table2000000026)
                {
                    DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                    column(Name1_Cust; Employee.FullName)
                    {
                    }
                    column(CustBalanceLCY4; RunningBalance)
                    {
                        AutoFormatType = 1;
                    }
                    column(RunningBalanceTotal; RunningBalanceTotal)
                    {
                    }
                    column(StartBalanceLCY2; StartBalanceLCY)
                    {
                    }
                    column(StartBalAdjLCY2; StartBalAdjLCY)
                    {
                    }
                    column(CustBalStBalStBalAdjLCY; CustBalanceLCY - StartBalanceLCY - StartBalAdjLCY)
                    {
                        AutoFormatType = 1;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF NOT CustLedgEntryExists AND ((StartBalanceLCY = 0) OR ExcludeBalanceOnly) THEN BEGIN
                            StartBalanceLCY := 0;
                            CurrReport.SKIP;
                        END;
                    end;
                }

                trigger OnAfterGetRecord()
                begin

                    CalcAmounts2(PeriodStartDate, PeriodEndDate, StartBalanceLCY);
                    EmployeeOpening += StartBalanceLCY;
                    CustBalanceLCY := StartBalanceLCY;
                    RunningBalance += StartBalanceLCY;
                    RunningBalanceTotal += StartBalanceLCY;
                end;

                trigger OnPreDataItem()
                begin
                    IF GLFilter <> '' THEN
                        SETFILTER("Payables Account", GLFilter);

                    SETFILTER(Code, '<>EMPLOYEE');
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF PrintOnlyOnePerPage THEN
                    PageGroupNo := PageGroupNo + 1;

                StartBalanceLCY := 0;
                StartBalAdjLCY := 0;
                CLEAR(EmployeeOpening);
                CLEAR(RunningBalance);

                IF Summary THEN
                    ReportName := 'Employee Advance Summary'
                ELSE
                    ReportName := 'Employee Advance Detail';
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;
                CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;
                CurrReport.CREATETOTALS("Employee Ledger Entry"."Amount (LCY)", StartBalanceLCY, StartBalAdjLCY, Correction, ApplicationRounding);
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
                    field(ShowAmountsInLCY; PrintAmountsInLCY)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Amounts in LCY';
                        ToolTip = 'Specifies if the reported amounts are shown in the local currency.';
                        Visible = false;
                    }
                    field(NewPageperCustomer; PrintOnlyOnePerPage)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Page per Customer';
                        ToolTip = 'Specifies if each customer''s information is printed on a new page if you have chosen two or more customers to be included in the report.';
                        Visible = false;
                    }
                    field(ExcludeCustHaveaBalanceOnly; ExcludeBalanceOnly)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Exclude Customers That Have a Balance Only';
                        MultiLine = true;
                        ToolTip = 'Specifies if you do not want the report to include entries for customers that have a balance but do not have a net change during the selected time period.';
                        Visible = false;
                    }
                    field(Summary; Summary)
                    {
                        Caption = 'Summary';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            PrintAmountsInLCY := TRUE;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        CaptionManagement: Codeunit "42";
    begin
        CustFilter := CaptionManagement.GetRecordFiltersWithCaptions(Employee);
        CustDateFilter := Employee.GETFILTER("Date Filter");
        PeriodEndDate := 01012999D;
        IF CustDateFilter <> '' THEN BEGIN
            PeriodStartDate := Employee.GETRANGEMIN("Date Filter");
            PeriodEndDate := Employee.GETRANGEMAX("Date Filter");
        END;

        IF STRPOS(Employee.GETFILTER("Employee Transaction Type"), 'Salary Advance') > 0 THEN
            GLFilter := '15250001';
        IF STRPOS(Employee.GETFILTER("Employee Transaction Type"), 'Expense Advance') > 0 THEN
            IF GLFilter = '' THEN
                GLFilter := '15250002'
            ELSE
                GLFilter += '|' + '15250002';
        IF STRPOS(Employee.GETFILTER("Employee Transaction Type"), 'Other') > 0 THEN
            IF GLFilter = '' THEN
                GLFilter := '15250003'
            ELSE
                GLFilter += '|' + '15250003';
    end;

    var
        Text000: Label 'Period: %1';
        CustLedgEntry: Record "21";
        PrintAmountsInLCY: Boolean;
        PrintOnlyOnePerPage: Boolean;
        ExcludeBalanceOnly: Boolean;
        CustFilter: Text;
        CustDateFilter: Text;
        AmountCaption: Text[80];
        RemainingAmtCaption: Text[30];
        CustAmount: Decimal;
        CustRemainAmount: Decimal;
        CustBalanceLCY: Decimal;
        CustCurrencyCode: Code[10];
        CustEntryDueDate: Date;
        StartBalanceLCY: Decimal;
        StartBalAdjLCY: Decimal;
        Correction: Decimal;
        ApplicationRounding: Decimal;
        CustLedgEntryExists: Boolean;
        PageGroupNo: Integer;
        CustDetailTrialBalCaptionLbl: Label 'Customer - Detail Trial Bal.';
        PageNoCaptionLbl: Label 'Page';
        AllAmtsLCYCaptionLbl: Label 'All amounts are in LCY';
        RepInclCustsBalCptnLbl: Label 'This report also includes customers that only have balances.';
        PostingDateCaptionLbl: Label 'Posting Date';
        DueDateCaptionLbl: Label 'Due Date';
        BalanceLCYCaptionLbl: Label 'Balance (LCY)';
        AdjOpeningBalCaptionLbl: Label 'Adj. of Opening Balance';
        BeforePeriodCaptionLbl: Label 'Total (LCY) Before Period';
        TotalCaptionLbl: Label 'Total (LCY)';
        OpeningBalCaptionLbl: Label 'Total Adj. of Opening Balance';
        ExternalDocNoCaptionLbl: Label 'External Doc. No.';
        PeriodStartDate: Date;
        PeriodEndDate: Date;
        EmployeeOpening: Decimal;
        RunningBalance: Decimal;
        RunningBalanceTotal: Decimal;
        Summary: Boolean;
        ReportName: Text[50];
        EmpPostingGroup: Record "5221";
        GLFilter: Text;

    [Scope('Internal')]
    procedure InitializeRequest(ShowAmountInLCY: Boolean; SetPrintOnlyOnePerPage: Boolean; SetExcludeBalanceOnly: Boolean)
    begin
        PrintOnlyOnePerPage := SetPrintOnlyOnePerPage;
        PrintAmountsInLCY := ShowAmountInLCY;
        ExcludeBalanceOnly := SetExcludeBalanceOnly;
    end;

    local procedure CalcAmounts2(DateFrom: Date; DateTo: Date; var BeginBalance: Decimal)
    var
        EmpLedgerEntry: Record "5222";
    begin
        BeginBalance := 0;
        IF CustDateFilter = '' THEN
            EXIT;
        EmpLedgerEntry.RESET();
        EmpLedgerEntry.SETRANGE("Employee No.", Employee."No.");
        EmpLedgerEntry.SETRANGE("Posting Date", 0D, DateFrom - 1);
        EmpLedgerEntry.SETRANGE("G/L Account No.", EmployeePostingGroup."Payables Account");
        EmpLedgerEntry.SETFILTER("Global Dimension 1 Code", Employee.GETFILTER("Global Dimension 1 Filter"));
        EmpLedgerEntry.SETFILTER("Global Dimension 2 Code", Employee.GETFILTER("Global Dimension 2 Filter"));
        IF EmpLedgerEntry.FINDSET() THEN
            REPEAT
                EmpLedgerEntry.CALCFIELDS("Amount (LCY)");
                BeginBalance += EmpLedgerEntry."Amount (LCY)";
            UNTIL EmpLedgerEntry.NEXT() = 0;
    end;
}

