report 50023 "Trial Balance With Opening"
{
    DefaultLayout = RDLC;
    RDLCLayout = './TrialBalanceWithOpening.rdlc';
    Caption = 'Trial Balance With Opening';

    dataset
    {
        dataitem(DataItem6710; Table15)
        {
            DataItemTableView = SORTING (No.);
            RequestFilterFields = "No.", "Account Type", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";
            column(STRSUBSTNO_Text000_PeriodText_; STRSUBSTNO(Text000, PeriodText))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(PeriodText; PeriodText)
            {
            }
            column(G_L_Account__TABLECAPTION__________GLFilter; TABLECAPTION + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(G_L_Account_No_; "No.")
            {
            }
            column(Trial_BalanceCaption; Trial_BalanceCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Net_ChangeCaption; Net_ChangeCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(OpeningBalanceCaption; OpeningBalanceCaptionLbl)
            {
            }
            column(G_L_Account___No__Caption; FIELDCAPTION("No."))
            {
            }
            column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaption; PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl)
            {
            }
            column(G_L_Account___Net_Change_Caption; G_L_Account___Net_Change_CaptionLbl)
            {
            }
            column(G_L_Account___Net_Change__Control22Caption; G_L_Account___Net_Change__Control22CaptionLbl)
            {
            }
            column(G_L_Account___Balance_at_Date_Caption; G_L_Account___Balance_at_Date_CaptionLbl)
            {
            }
            column(G_L_Account___Balance_at_Date__Control24Caption; G_L_Account___Balance_at_Date__Control24CaptionLbl)
            {
            }
            column(G_L_Account___OpeningBalance_Caption; G_L_Account___OpeningBalance_CaptionLbl)
            {
            }
            column(G_L_Account___OpeningBalance__Control26Caption; G_L_Account___OpeningBalance__Control26CaptionLbl)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            dataitem(DataItem5444; Table2000000026)
            {
                DataItemTableView = SORTING (Number)
                                    WHERE (Number = CONST (1));
                column(G_L_Account___No__; "G/L Account"."No.")
                {
                }
                column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__Name; PADSTR('', "G/L Account".Indentation * 2) + "G/L Account".Name)
                {
                }
                column(OpeningBalance; OpeningBalance)
                {
                }
                column(OpeningBalance_Control26; -OpeningBalance)
                {
                }
                column(G_L_Account___Net_Change_; "G/L Account"."Net Change")
                {
                }
                column(G_L_Account___Net_Change__Control22; -"G/L Account"."Net Change")
                {
                    AutoFormatType = 1;
                }
                column(G_L_Account___Balance_at_Date_; "G/L Account"."Balance at Date")
                {
                }
                column(G_L_Account___Balance_at_Date__Control24; -"G/L Account"."Balance at Date")
                {
                    AutoFormatType = 1;
                }
                column(G_L_Account___Account_Type_; FORMAT("G/L Account"."Account Type", 0, 2))
                {
                }
                column(No__of_Blank_Lines; "G/L Account"."No. of Blank Lines")
                {
                }
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
                dataitem(BlankLineRepeater; Table2000000026)
                {
                    column(BlankLineNo; BlankLineNo)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF BlankLineNo = 0 THEN
                            CurrReport.BREAK;

                        BlankLineNo -= 1;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    BlankLineNo := "G/L Account"."No. of Blank Lines" + 1;
                end;
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

                IF PrintToExcel THEN
                    MakeExcelDataBody;

                IF ChangeGroupNo THEN BEGIN
                    PageGroupNo += 1;
                    ChangeGroupNo := FALSE;
                END;

                ChangeGroupNo := "New Page";
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 0;
                ChangeGroupNo := FALSE;
                //SUB1.00
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
                //SUB1.00
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PrintToExcel; PrintToExcel)
                    {
                        Caption = 'Print to Excel';
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

    trigger OnPostReport()
    begin
        IF PrintToExcel THEN
            CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        GLFilter := "G/L Account".GETFILTERS;
        PeriodText := "G/L Account".GETFILTER("Date Filter");
        IF PrintToExcel THEN
            MakeExcelInfo;
    end;

    var
        Text000: Label 'Period: %1';
        ExcelBuf: Record "370" temporary;
        GLFilter: Text;
        PeriodText: Text[30];
        PrintToExcel: Boolean;
        Text012: Label 'Trial Balance NAV';
        Text001: Label 'Trial Balance Plus';
        Text002: Label 'Data';
        Text003: Label 'Debit';
        Text004: Label 'Credit';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Date';
        Text010: Label 'G/L Filter';
        Text011: Label 'Period Filter';
        Trial_BalanceCaptionLbl: Label 'Trial Balance Plus';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Net_ChangeCaptionLbl: Label 'Net Change';
        BalanceCaptionLbl: Label 'Balance';
        PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl: Label 'Name';
        G_L_Account___Net_Change_CaptionLbl: Label 'Debit';
        G_L_Account___Net_Change__Control22CaptionLbl: Label 'Credit';
        G_L_Account___Balance_at_Date_CaptionLbl: Label 'Debit';
        G_L_Account___Balance_at_Date__Control24CaptionLbl: Label 'Credit';
        PageGroupNo: Integer;
        ChangeGroupNo: Boolean;
        BlankLineNo: Integer;
        OpeningBalance: Decimal;
        OpeningBalanceCaptionLbl: Label 'Opening Balance';
        G_L_Account___OpeningBalance_CaptionLbl: Label 'Debit';
        G_L_Account___OpeningBalance__Control26CaptionLbl: Label 'Credit';
        DebitOpeningBalance: Decimal;
        TotalDebitOpeningBalance: Decimal;
        TotalDebitOpeningBalance1: Decimal;
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

    [Scope('Internal')]
    procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text005), FALSE, FALSE, TRUE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text007), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(Text001), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text006), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::"Trial Balance", FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text008), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text009), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text010), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn("G/L Account".GETFILTER("No."), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text011), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn("G/L Account".GETFILTER("Date Filter"), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.AddColumn("G/L Account".FIELDCAPTION("No."), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("G/L Account".FIELDCAPTION(Name), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          FORMAT("G/L Account".FIELDCAPTION("Net Change") + ' - ' + Text003), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          FORMAT("G/L Account".FIELDCAPTION("Net Change") + ' - ' + Text004), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          FORMAT("G/L Account".FIELDCAPTION("Balance at Date") + ' - ' + Text003), FALSE, '', TRUE, FALSE, TRUE, '',
          ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          FORMAT("G/L Account".FIELDCAPTION("Balance at Date") + ' - ' + Text004), FALSE, '', TRUE, FALSE, TRUE, '',
          ExcelBuf."Cell Type"::Text);
    end;

    [Scope('Internal')]
    procedure MakeExcelDataBody()
    var
        BlankFiller: Text[250];
    begin
        BlankFiller := PADSTR(' ', MAXSTRLEN(BlankFiller), ' ');
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(
          "G/L Account"."No.", FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
          ExcelBuf."Cell Type"::Text);
        IF "G/L Account".Indentation = 0 THEN
            ExcelBuf.AddColumn(
              "G/L Account".Name, FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
              ExcelBuf."Cell Type"::Text)
        ELSE
            ExcelBuf.AddColumn(
              COPYSTR(BlankFiller, 1, 2 * "G/L Account".Indentation) + "G/L Account".Name,
              FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        CASE TRUE OF
            "G/L Account"."Net Change" = 0:
                BEGIN
                    ExcelBuf.AddColumn(
                      '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
                      ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(
                      '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
                      ExcelBuf."Cell Type"::Number);
                END;
            "G/L Account"."Net Change" > 0:
                BEGIN
                    ExcelBuf.AddColumn(
                      "G/L Account"."Net Change", FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
                      FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(
                      '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
                      ExcelBuf."Cell Type"::Number);
                END;
            "G/L Account"."Net Change" < 0:
                BEGIN
                    ExcelBuf.AddColumn(
                      '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
                      ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(
                      -"G/L Account"."Net Change", FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
                      FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                END;
        END;

        CASE TRUE OF
            "G/L Account"."Balance at Date" = 0:
                BEGIN
                    ExcelBuf.AddColumn(
                      '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
                      ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(
                      '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
                      ExcelBuf."Cell Type"::Number);
                END;
            "G/L Account"."Balance at Date" > 0:
                BEGIN
                    ExcelBuf.AddColumn(
                      "G/L Account"."Balance at Date", FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
                      FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(
                      '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
                      ExcelBuf."Cell Type"::Number);
                END;
            "G/L Account"."Balance at Date" < 0:
                BEGIN
                    ExcelBuf.AddColumn(
                      '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
                      ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(
                      -"G/L Account"."Balance at Date", FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
                      FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                END;
        END;
    end;

    [Scope('Internal')]
    procedure CreateExcelbook()
    begin
        ExcelBuf.CreateBookAndOpenExcel(Text012, Text002, Text001, COMPANYNAME, USERID);
        ERROR('');
    end;
}

