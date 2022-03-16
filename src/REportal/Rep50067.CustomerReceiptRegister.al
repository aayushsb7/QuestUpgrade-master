report 50067 "Customer Receipt Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CustomerReceiptRegister.rdlc';
    Caption = 'Customer Receipt Register';

    dataset
    {
        dataitem(DataItem6836; Table18)
        {
            DataItemTableView = SORTING (No.);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Customer Posting Group", "Date Filter";
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
            column(Name_Cust; Name)
            {
            }
            column(PhoneNo_Cust; "Phone No.")
            {
                IncludeCaption = true;
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(StartBalanceLCY; StartBalanceLCY)
            {
                AutoFormatType = 1;
            }
            column(StartBalAdjLCY; StartBalAdjLCY)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceLCY; CustBalanceLCY)
            {
                AutoFormatType = 1;
            }
            column(CustLedgerEntryAmtLCY; "Cust. Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding)
            {
                AutoFormatType = 1;
            }
            column(StartBalanceLCYAdjLCY; StartBalanceLCY + StartBalAdjLCY)
            {
                AutoFormatType = 1;
            }
            column(StrtBalLCYCustLedgEntryAmt; StartBalanceLCY + "Cust. Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding)
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
            column(CustDateFilter; CustDateFilter)
            {
            }
            column(CompanyInfoAddress; CompanyInformation.Address)
            {
            }
            column(CompanyInfoAddress2; CompanyInformation."Address 2")
            {
            }
            column(CompanyInfoCity; CompanyInformation.City)
            {
            }
            dataitem(DataItem8503; Table21)
            {
                DataItemLink = Customer No.=FIELD(No.), Posting Date=FIELD(Date Filter), Global Dimension 2 Code=FIELD(Global Dimension 2 Filter), Global Dimension 1 Code=FIELD(Global Dimension 1 Filter), Date Filter=FIELD(Date Filter);
                DataItemTableView = SORTING(Customer No.,Posting Date) WHERE(Document Type=FILTER(' '));
                column(PostDate_CustLedgEntry;FORMAT("Posting Date"))
                {
                }
                column(DocType_CustLedgEntry;"Document Type")
                {
                    IncludeCaption = true;
                }
                column(DocNo_CustLedgEntry;"Document No.")
                {
                    IncludeCaption = true;
                }
                column(ExtDocNo_CustLedgEntry;"External Document No.")
                {
                }
                column(Desc_CustLedgEntry;Description)
                {
                }
                column(CustAmount;CustAmount)
                {
                    AutoFormatExpression = CustCurrencyCode;
                    AutoFormatType = 1;
                }
                column(CustRemainAmount;CustRemainAmount)
                {
                    AutoFormatExpression = CustCurrencyCode;
                    AutoFormatType = 1;
                }
                column(CustEntryDueDate;FORMAT(CustEntryDueDate))
                {
                }
                column(EntryNo_CustLedgEntry;"Entry No.")
                {
                    IncludeCaption = true;
                }
                column(CustCurrencyCode;CustCurrencyCode)
                {
                }
                column(CustBalanceLCY1;CustBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(DebitAmount_CustLedgerEntry;"Debit Amount")
                {
                }
                column(CreditAmount_CustLedgerEntry;"Credit Amount")
                {
                }
                column(GLAccName;GLAccName)
                {
                }
                column(BankAccountNo;BankAccountNo)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CALCFIELDS(Amount,"Remaining Amount","Amount (LCY)","Remaining Amt. (LCY)");

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
                    IF ("Document Type" = "Document Type"::Payment) OR ("Document Type" = "Document Type"::Refund) THEN
                      CustEntryDueDate := 0D
                    ELSE
                      CustEntryDueDate := "Due Date";
                    //SRT July 11th 2019 >>
                    DescriptionText := '';
                    IF "Cust. Ledger Entry".Narration = '' THEN
                      DescriptionText := "Cust. Ledger Entry".Description
                    ELSE
                      DescriptionText := "Cust. Ledger Entry".Description + '<br>' + 'Narration: ' + "Cust. Ledger Entry".Narration;
                    //SRT July 11th 2019 <<

                    GLEntry.RESET;
                    GLEntry.SETRANGE("Document No.", "Document No.");
                    IF GLEntry.FINDFIRST THEN BEGIN
                        GLAccName := FindGLAccName(GLEntry."Source Type",GLEntry."Entry No.",GLEntry."Source No.",GLEntry."G/L Account No.");
                        BankAccountNo := FindGLAccNo(GLEntry."Source Type",GLEntry."Entry No.",GLEntry."Source No.",GLEntry."G/L Account No.");
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    CustLedgEntryExists := FALSE;
                    CurrReport.CREATETOTALS(CustAmount,"Amount (LCY)");

                    "Cust. Ledger Entry".SETFILTER("Document No.", 'COR/RV*');
                end;
            }
            dataitem(DataItem5444;Table2000000026)
            {
                DataItemTableView = SORTING(Number) WHERE(Number=CONST(1));
                column(Name1_Cust;Customer.Name)
                {
                }
                column(CustBalanceLCY4;CustBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(StartBalanceLCY2;StartBalanceLCY)
                {
                }
                column(StartBalAdjLCY2;StartBalAdjLCY)
                {
                }
                column(CustBalStBalStBalAdjLCY;CustBalanceLCY - StartBalanceLCY - StartBalAdjLCY)
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
                IF PrintOnlyOnePerPage THEN
                  PageGroupNo := PageGroupNo + 1;

                StartBalanceLCY := 0;
                StartBalAdjLCY := 0;
                IF CustDateFilter <> '' THEN BEGIN
                  IF GETRANGEMIN("Date Filter") <> 0D THEN BEGIN
                    SETRANGE("Date Filter",0D,GETRANGEMIN("Date Filter") - 1);
                    CALCFIELDS("Net Change (LCY)");
                    StartBalanceLCY := "Net Change (LCY)";
                  END;
                  SETFILTER("Date Filter",CustDateFilter);
                  CALCFIELDS("Net Change (LCY)");
                  StartBalAdjLCY := "Net Change (LCY)";
                  CustLedgEntry.SETCURRENTKEY("Customer No.","Posting Date");
                  CustLedgEntry.SETRANGE("Customer No.","No.");
                  CustLedgEntry.SETFILTER("Posting Date",CustDateFilter);
                  IF CustLedgEntry.FIND('-') THEN
                    REPEAT
                      CustLedgEntry.SETFILTER("Date Filter",CustDateFilter);
                      CustLedgEntry.CALCFIELDS("Amount (LCY)");
                      StartBalAdjLCY := StartBalAdjLCY - CustLedgEntry."Amount (LCY)";
                    UNTIL CustLedgEntry.NEXT = 0;
                END;
                CurrReport.PRINTONLYIFDETAIL := ExcludeBalanceOnly OR (StartBalanceLCY = 0);
                CustBalanceLCY := StartBalanceLCY + StartBalAdjLCY
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;
                CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;
                CurrReport.CREATETOTALS("Cust. Ledger Entry"."Amount (LCY)",StartBalanceLCY,StartBalAdjLCY,Correction,ApplicationRounding);
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
                    field(ShowAmountsInLCY;PrintAmountsInLCY)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Show Amounts in LCY';
                        ToolTip = 'Specifies if the reported amounts are shown in the local currency.';
                    }
                    field(NewPageperCustomer;PrintOnlyOnePerPage)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'New Page per Customer';
                        ToolTip = 'Specifies if each customer''s information is printed on a new page if you have chosen two or more customers to be included in the report.';
                    }
                    field(ExcludeCustHaveaBalanceOnly;ExcludeBalanceOnly)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Exclude Customers That Have a Balance Only';
                        MultiLine = true;
                        ToolTip = 'Specifies if you do not want the report to include entries for customers that have a balance but do not have a net change during the selected time period.';
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
    var
        CaptionManagement: Codeunit "42";
    begin
        CustFilter := CaptionManagement.GetRecordFiltersWithCaptions(Customer);
        CustDateFilter := Customer.GETFILTER("Date Filter");
        WITH "Cust. Ledger Entry" DO
          IF PrintAmountsInLCY THEN BEGIN
            AmountCaption := FIELDCAPTION("Amount (LCY)");
            RemainingAmtCaption := FIELDCAPTION("Remaining Amt. (LCY)");
          END ELSE BEGIN
            AmountCaption := FIELDCAPTION(Amount);
            RemainingAmtCaption := FIELDCAPTION("Remaining Amount");
          END;

        CompanyInformation.GET;
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
        DescriptionText: Text;
        GLAccName: Text;
        BankAccountNo: Text[30];
        CompanyInformation: Record "79";
        GLEntry: Record "17";

    [Scope('Internal')]
    procedure InitializeRequest(ShowAmountInLCY: Boolean;SetPrintOnlyOnePerPage: Boolean;SetExcludeBalanceOnly: Boolean)
    begin
        PrintOnlyOnePerPage := SetPrintOnlyOnePerPage;
        PrintAmountsInLCY := ShowAmountInLCY;
        ExcludeBalanceOnly := SetExcludeBalanceOnly;
    end;

    [Scope('Internal')]
    procedure FindGLAccName("Source Type": Option " ",Customer,Vendor,"Bank Account","Fixed Asset";"Entry No.": Integer;"Source No.": Code[20];"G/L Account No.": Code[20]): Text[100]
    var
        AccName: Text[100];
        VendLedgerEntry: Record "25";
        Vend: Record "23";
        CustLedgerEntry: Record "21";
        Cust: Record "18";
        BankLedgerEntry: Record "271";
        Bank: Record "270";
        FALedgerEntry: Record "5601";
        FA: Record "5600";
        GLAccount: Record "15";
        "BankAccNo.": Text[30];
    begin
        IF "Source Type" = "Source Type"::Vendor THEN
          IF VendLedgerEntry.GET("Entry No.") THEN BEGIN
            Vend.GET("Source No.");
            AccName := Vend.Name;
          END ELSE BEGIN
            GLAccount.GET("G/L Account No.");
            AccName := GLAccount.Name;
          END
        ELSE IF "Source Type" = "Source Type"::Customer THEN
          IF CustLedgerEntry.GET("Entry No.") THEN BEGIN
            Cust.GET("Source No.");
            AccName := Cust.Name + ' '+Cust."Name 2";
          END ELSE BEGIN
            GLAccount.GET("G/L Account No.");
            AccName := GLAccount.Name;
          END
        ELSE IF "Source Type" = "Source Type"::"Bank Account" THEN
          IF BankLedgerEntry.GET("Entry No.") THEN BEGIN
            Bank.GET("Source No.");
            AccName := Bank.Name;

          END ELSE BEGIN
            GLAccount.GET("G/L Account No.");
            AccName := GLAccount.Name;
          END
        ELSE IF "Source Type" = "Source Type"::"Fixed Asset" THEN BEGIN
          FALedgerEntry.RESET;
          FALedgerEntry.SETCURRENTKEY("G/L Entry No.");
          FALedgerEntry.SETRANGE("G/L Entry No.","Entry No.");
          IF FALedgerEntry.FINDFIRST THEN BEGIN
            FA.GET("Source No.");
            AccName := FA.Description;
          END ELSE BEGIN
            GLAccount.GET("G/L Account No.");
            AccName := GLAccount.Name;
          END;
        END ELSE BEGIN
          GLAccount.GET("G/L Account No.");
          AccName := GLAccount.Name;
        END;

        IF "Source Type" = "Source Type"::" " THEN BEGIN
          GLAccount.GET("G/L Account No.");
          AccName := GLAccount.Name;
        END;

        EXIT(AccName);
    end;

    [Scope('Internal')]
    procedure FindGLAccNo("Source Type": Option " ",Customer,Vendor,"Bank Account","Fixed Asset";"Entry No.": Integer;"Source No.": Code[20];"G/L Account No.": Code[20]): Text[30]
    var
        AccNo: Text[30];
        BankLedgerEntry: Record "271";
        Bank: Record "270";
    begin
        IF "Source Type" = "Source Type"::"Bank Account" THEN
          IF BankLedgerEntry.GET("Entry No.") THEN BEGIN
            Bank.GET("Source No.");
            AccNo := Bank."Bank Account No.";
          END ELSE BEGIN
          END;
        EXIT(AccNo);
    end;
}

