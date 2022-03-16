report 50040 "LC Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './LCReport.rdlc';
    Caption = 'LC Report';

    dataset
    {
        dataitem(DataItem1; Table50008)
        {
            DataItemTableView = WHERE (Transaction Type=CONST(Purchase));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Date Filter", "Issued To/Received From";
            column(ShowSummary; ShowSummary)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaption)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyPhNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyFaxNo; CompanyInfo."Fax No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyVATNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(DocClassNo_DocumentClassMaster; "LC Details"."No.")
            {
            }
            column(StartingNepaliDate; StartDateNep)
            {
            }
            column(EndingNepaliDate; EndDateNep)
            {
            }
            column(Balance; StartBalance)
            {
            }
            column(OpeningBal; OpeningBalance)
            {
            }
            column(OpeningBalDrCr; OpeningBalDrCr)
            {
            }
            column(AllFilters; AllFilters)
            {
            }
            column(ReportHeading; ReportHeading)
            {
            }
            column(LCDONo_LCDetails; "LC Details"."LC\DO No.")
            {
            }
            column(IssuedToReceivedFrom_LCDetails; "LC Details"."Issued To/Received From")
            {
            }
            column(IssuedToReceivedFromName_LCDetails; "LC Details"."Issued To/Received From Name")
            {
            }
            dataitem(DataItem2; Table17)
            {
                DataItemLink = Sys. LC No.=FIELD(No.),
                               Posting Date=FIELD(Date Filter);
                column(PostingDate_GLEntry;FORMAT("G/L Entry"."Posting Date"))
                {
                }
                column(ExternalDocumentNo_GLEntry;"G/L Entry"."External Document No.")
                {
                }
                column(DocumentNo_GLEntry;"G/L Entry"."Document No.")
                {
                }
                column(GLAccountNo_GLEntry;"G/L Entry"."G/L Account No.")
                {
                }
                column(Description_GLEntry;"G/L Entry".Description)
                {
                }
                column(DebitAmount_GLEntry;"G/L Entry"."Debit Amount")
                {
                }
                column(CreditAmount_GLEntry;"G/L Entry"."Credit Amount")
                {
                }
                column(RunningBalance;RunningBalance)
                {
                }
                column(Narration_GLEntry;"G/L Entry".Narration)
                {
                }
                column(SourceName;"G/L Entry"."Source Name")
                {
                }
                column(DrCrIndication;DrCrIndication)
                {
                }
                column(GLAccountName_GLEntry;"G/L Entry"."G/L Account Name")
                {
                }
                column(DocumentType_GLEntry;"G/L Entry"."Document Type")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    RunningBalance := RunningBalance + Amount;
                    IF RunningBalance > 0 THEN
                      DrCrIndication := 'Dr.'
                    ELSE
                      DrCrIndication := 'Cr.';
                end;

                trigger OnPreDataItem()
                begin
                    IF GLAccFilter <> '' THEN
                      SETFILTER("G/L Account No.",GLAccFilter);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                RunningBalance := 0;
                StartBalance := 0;
                OpeningBalance := 0;
                GLEntry.RESET;
                GLEntry.SETFILTER("Global Dimension 1 Code","LC Details"."No.");
                GLEntry.SETFILTER("Posting Date",'<%1',StartEngDate);
                IF GLAccFilter <> '' THEN
                  GLEntry.SETFILTER("G/L Account No.",GLAccFilter);
                IF GLEntry.FINDSET THEN REPEAT
                  StartBalance += GLEntry.Amount;
                UNTIL GLEntry.NEXT = 0;

                OpeningBalance := StartBalance;
                RunningBalance := StartBalance;
                IF OpeningBalance < 0 THEN
                  OpeningBalDrCr := 'Cr.';
                IF OpeningBalance > 0 THEN
                  OpeningBalDrCr := 'Dr.';
                IF OpeningBalance = 0 THEN
                  OpeningBalDrCr := '';
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("LC Code Filter")
                {
                    field("Show Summary";ShowSummary)
                    {
                    }
                    field("GL Account Filter";GLAccFilter)
                    {

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            GLAcc.RESET;
                            IF PAGE.RUNMODAL(0,GLAcc) = ACTION::LookupOK THEN
                              IF STRPOS(GLAccFilter, GLAcc."No.") = 0 THEN
                                IF GLAccFilter <> '' THEN
                                  GLAccFilter += '|' + GLAcc."No."
                                ELSE
                                  GLAccFilter := GLAcc."No.";
                        end;
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
        AllFilters := "LC Details".GETFILTERS;
        DateFilter := "LC Details".GETFILTER("Date Filter");
        IF GLAccFilter <> '' THEN
          AllFilters += ',' + GLAccFilter;
        CompanyInfo.GET;
        IF DateFilter <> '' THEN BEGIN
          StartDateNep := '';
          EndDateNep := '';
          StartEngDate := 0D;
          EndEngDate := 0D;

          StartEngDate := "LC Details".GETRANGEMIN("Date Filter");
          EndEngDate := "LC Details".GETRANGEMAX("Date Filter");
          NepaliCal.RESET;
          NepaliCal.SETRANGE("English Date",StartEngDate);
          IF NepaliCal.FINDFIRST THEN
              StartDateNep := NepaliCal."Nepali Date";

          NepaliCal.RESET;
          NepaliCal.SETRANGE("English Date",EndEngDate);
          IF NepaliCal.FINDFIRST THEN
            EndDateNep := NepaliCal."Nepali Date";

          AllFilters += ',' + StartDateNep + '..' + EndDateNep;
        END;
        GLSetup.GET;
    end;

    var
        LCBoolean: Boolean;
        TRBoolean: Boolean;
        GLEntry: Record "17";
        OpeningBalance: Decimal;
        StartDateNep: Code[10];
        EndDateNep: Code[10];
        NepaliCal: Record "50000";
        StartEngDate: Date;
        EndEngDate: Date;
        CompanyInfo: Record "79";
        DateFilter: Text;
        AllFilters: Text;
        StartBalance: Decimal;
        ReportHeading: Label 'LC Detail Trial Bal.';
        ReportTitle: Text;
        CurrReport_PAGENOCaption: Label 'Page';
        SourceName: Text;
        Vendor: Record "23";
        RunningBalance: Decimal;
        DrCrIndication: Text;
        OpeningBalDrCr: Text;
        GLAccFilter: Code[20];
        GLSetup: Record "98";
        LCNoFilter: Code[20];
        ShowSummary: Boolean;
        GLAcc: Record "15";
}

