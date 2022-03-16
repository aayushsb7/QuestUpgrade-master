report 50037 "Cash Book"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CashBook.rdlc';
    Caption = 'Cash Book';

    dataset
    {
        dataitem(DataItem6710; Table15)
        {
            DataItemTableView = WHERE (Account Type=CONST(Posting));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Income/Balance", "Debit/Credit", "Date Filter";
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(PeriodGLDtFilter; STRSUBSTNO(Text000, GLDateFilter))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(ExcludeBalanceOnly; ExcludeBalanceOnly)
            {
            }
            column(PrintReversedEntries; PrintReversedEntries)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(PrintClosingEntries; PrintClosingEntries)
            {
            }
            column(PrintOnlyCorrections; PrintOnlyCorrections)
            {
            }
            column(GLAccTableCaption; TABLECAPTION + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(EmptyString; '')
            {
            }
            column(No_GLAcc; "No.")
            {
            }
            column(DetailTrialBalCaption; DetailTrialBalCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(PeriodCaption; PeriodCaptionLbl)
            {
            }
            column(OnlyCorrectionsCaption; OnlyCorrectionsCaptionLbl)
            {
            }
            column(NetChangeCaption; NetChangeCaptionLbl)
            {
            }
            column(GLEntryDebitAmtCaption; GLEntryDebitAmtCaptionLbl)
            {
            }
            column(GLEntryCreditAmtCaption; GLEntryCreditAmtCaptionLbl)
            {
            }
            column(GLBalCaption; GLBalCaptionLbl)
            {
            }
            column(StartingNepaliDate; StartDateNep)
            {
            }
            column(EndingNepaliDate; EndDateNep)
            {
            }
            dataitem(PageCounter; Table2000000026)
            {
                DataItemTableView = SORTING (Number)
                                    WHERE (Number = CONST (1));
                column(Name_GLAcc; "G/L Account".Name)
                {
                }
                column(StartBalance; StartBalance)
                {
                    AutoFormatType = 1;
                }
                dataitem(DataItem7069; Table17)
                {
                    DataItemLink = G/L Account No.=FIELD(No.),
                                   Posting Date=FIELD(Date Filter),
                                   Global Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                   Global Dimension 2 Code=FIELD(Global Dimension 2 Filter),
                                   Business Unit Code=FIELD(Business Unit Filter);
                    DataItemLinkReference = "G/L Account";
                    DataItemTableView = SORTING(G/L Account No.,Posting Date);
                    column(VATAmount_GLEntry;"VAT Amount")
                    {
                        IncludeCaption = true;
                    }
                    column(DebitAmount_GLEntry;"Debit Amount")
                    {
                    }
                    column(CreditAmount_GLEntry;"Credit Amount")
                    {
                    }
                    column(PostingDate_GLEntry;"Posting Date")
                    {
                    }
                    column(DocumentNo_GLEntry;"Document No.")
                    {
                    }
                    column(Description_GLEntry;Description)
                    {
                    }
                    column(GLBalance;GLBalance)
                    {
                        AutoFormatType = 1;
                    }
                    column(EntryNo_GLEntry;"Entry No.")
                    {
                    }
                    column(ClosingEntry;ClosingEntry)
                    {
                    }
                    column(Reversed_GLEntry;Reversed)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF PrintOnlyCorrections THEN
                          IF NOT (("Debit Amount" < 0) OR ("Credit Amount" < 0)) THEN
                            CurrReport.SKIP;
                        IF NOT PrintReversedEntries AND Reversed THEN
                          CurrReport.SKIP;

                        GLBalance := GLBalance + Amount;
                        IF ("Posting Date" = CLOSINGDATE("Posting Date")) AND
                           NOT PrintClosingEntries
                        THEN BEGIN
                          "Debit Amount" := 0;
                          "Credit Amount" := 0;
                        END;

                        IF "Posting Date" = CLOSINGDATE("Posting Date") THEN
                          ClosingEntry := TRUE
                        ELSE
                          ClosingEntry := FALSE;
                    end;

                    trigger OnPreDataItem()
                    begin
                        GLBalance := StartBalance;
                        CurrReport.CREATETOTALS(Amount,"Debit Amount","Credit Amount","VAT Amount");
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CurrReport.PRINTONLYIFDETAIL := ExcludeBalanceOnly OR (StartBalance = 0);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                StartBalance := 0;
                IF GLDateFilter <> '' THEN
                  IF GETRANGEMIN("Date Filter") <> 0D THEN BEGIN
                    SETRANGE("Date Filter",0D,CLOSINGDATE(GETRANGEMIN("Date Filter") - 1));
                    CALCFIELDS("Net Change");
                    StartBalance := "Net Change";
                    SETFILTER("Date Filter",GLDateFilter);
                  END;

                IF PrintOnlyOnePerPage THEN BEGIN
                  GLEntryPage.RESET;
                  GLEntryPage.SETRANGE("G/L Account No.","No.");
                  IF CurrReport.PRINTONLYIFDETAIL AND GLEntryPage.FINDFIRST THEN
                    PageGroupNo := PageGroupNo + 1;
                END;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                PageGroupNo := 1;

                CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;
                //KMT2016CU5 >>
                IF GLFilter <> '' THEN
                "G/L Account".SETFILTER("No.",GLFilter);
                //KMT2016CU5 <<
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
                    Visible = false;
                    field(NewPageperGLAcc;PrintOnlyOnePerPage)
                    {
                        Caption = 'New Page per G/L Acc.';
                    }
                    field(ExcludeGLAccsHaveBalanceOnly;ExcludeBalanceOnly)
                    {
                        Caption = 'Exclude G/L Accs. That Have a Balance Only';
                        MultiLine = true;
                    }
                    field(InclClosingEntriesWithinPeriod;PrintClosingEntries)
                    {
                        Caption = 'Include Closing Entries Within the Period';
                        MultiLine = true;
                    }
                    field(IncludeReversedEntries;PrintReversedEntries)
                    {
                        Caption = 'Include Reversed Entries';
                    }
                    field(PrintCorrectionsOnly;PrintOnlyCorrections)
                    {
                        Caption = 'Print Corrections Only';
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
        PostingDateCaption = 'Posting Date';
        DocNoCaption = 'Document No.';
        DescCaption = 'Description';
        VATAmtCaption = 'VAT Amount';
        EntryNoCaption = 'Entry No.';
    }

    trigger OnPreReport()
    begin
        GLDateFilter := "G/L Account".GETFILTER("Date Filter");
        GLSetup.GET;
        GLSetup.TESTFIELD("Cash Book GL Filter");
        GLFilter := GLSetup."Cash Book GL Filter";
        //KMT2016CU5 >>
        IF GLDateFilter <> '' THEN BEGIN
          StartDateNep := '';
          EndDateNep := '';
          StartEngDate := 0D;
          EndEngDate := 0D;
          StartEngDate := "G/L Account".GETRANGEMIN("Date Filter");
          EndEngDate := "G/L Account".GETRANGEMAX("Date Filter");
          NepaliCal.RESET;
          NepaliCal.SETRANGE("English Date",StartEngDate);
          IF NepaliCal.FINDFIRST THEN
              StartDateNep := NepaliCal."Nepali Date";

          NepaliCal.RESET;
          NepaliCal.SETRANGE("English Date",EndEngDate);
          IF NepaliCal.FINDFIRST THEN
            EndDateNep := NepaliCal."Nepali Date";
        END;
        //KMT2016CU5 <<
    end;

    var
        Text000: Label 'Period: %1';
        GLDateFilter: Text[30];
        GLFilter: Text;
        GLBalance: Decimal;
        StartBalance: Decimal;
        PrintOnlyOnePerPage: Boolean;
        ExcludeBalanceOnly: Boolean;
        PrintClosingEntries: Boolean;
        PrintOnlyCorrections: Boolean;
        PrintReversedEntries: Boolean;
        PageGroupNo: Integer;
        GLEntryPage: Record "17";
        ClosingEntry: Boolean;
        DetailTrialBalCaptionLbl: Label 'Detail Trial Balance';
        PageCaptionLbl: Label 'Page';
        BalanceCaptionLbl: Label 'This also includes general ledger accounts that only have a balance.';
        PeriodCaptionLbl: Label 'This report also includes closing entries within the period.';
        OnlyCorrectionsCaptionLbl: Label 'Only corrections are included.';
        NetChangeCaptionLbl: Label 'Net Change';
        GLEntryDebitAmtCaptionLbl: Label 'Debit';
        GLEntryCreditAmtCaptionLbl: Label 'Credit';
        GLBalCaptionLbl: Label 'Balance';
        CompanyInfo: Record "79";
        StartDateNep: Code[10];
        EndDateNep: Code[10];
        NepaliCal: Record "50000";
        StartEngDate: Date;
        EndEngDate: Date;
        GLSetup: Record "98";

    [Scope('Internal')]
    procedure InitializeRequest(NewPrintOnlyOnePerPage: Boolean;NewExcludeBalanceOnly: Boolean;NewPrintClosingEntries: Boolean;NewPrintReversedEntries: Boolean;NewPrintOnlyCorrections: Boolean)
    begin
        PrintOnlyOnePerPage := NewPrintOnlyOnePerPage;
        ExcludeBalanceOnly := NewExcludeBalanceOnly;
        PrintClosingEntries := NewPrintClosingEntries;
        PrintReversedEntries := NewPrintReversedEntries;
        PrintOnlyCorrections := NewPrintOnlyCorrections;
    end;
}

