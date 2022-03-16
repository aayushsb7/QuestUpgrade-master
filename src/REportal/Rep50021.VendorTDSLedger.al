report 50021 "Vendor TDS Ledger"
{
    DefaultLayout = RDLC;
    RDLCLayout = './VendorTDSLedger.rdlc';

    dataset
    {
        dataitem(DataItem1; Table23)
        {
            RequestFilterFields = "Date Filter", "TDS Entry Closed Filter";
            column(Company_Name; CompInfo.Name)
            {
            }
            column(Company_Address; CompInfo.Address)
            {
            }
            column(Company_Phone_No; CompInfo."Phone No.")
            {
            }
            column(No_Vendor; Vendor."No.")
            {
            }
            column(Name_Vendor; Vendor.Name)
            {
            }
            column(Vat_Registration_No; Vendor."VAT Registration No.")
            {
            }
            column(TDSEntryClosedFilter_Vendor; Vendor."TDS Entry Closed Filter")
            {
            }
            column(TDSBalance_Vendor; Vendor."TDS Balance")
            {
            }
            column(DateFilter_Vendor; Vendor."Date Filter")
            {
            }
            column(Opening_Amount; OpeningAmount)
            {
            }
            column(FilterText; FilterText)
            {
            }
            column(ShowDetail; ShowDetail)
            {
            }
            dataitem(DataItem2; Table50006)
            {
                DataItemLink = Bill-to/Pay-to No.=FIELD(No.);
                DataItemTableView = WHERE (TDS Type=CONST(Purchase TDS));
                column(TDSAmount_TDSEntry; "Original TDS Entry"."Original TDS Amount")
                {
                }
                column(Base_TDSEntry; "Original TDS Entry"."Original Base")
                {
                }
                column(TDSPostingGroup_TDSEntry; "Original TDS Entry"."TDS Posting Group")
                {
                }
                column(Description; Description)
                {
                }
                column(Running_Amount; RunningAmount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    TDSPostingGroup.RESET;
                    TDSPostingGroup.SETRANGE(Code, "TDS Posting Group");
                    IF TDSPostingGroup.FINDFIRST THEN
                        Description := TDSPostingGroup.Description;

                    RunningAmount += "Original TDS Entry"."Original TDS Amount";
                end;

                trigger OnPreDataItem()
                begin
                    "Original TDS Entry".SETFILTER("Posting Date", VendDateFilter);

                    FilterText += ', ' + "Original TDS Entry".GETFILTERS;
                    RunningAmount := 0
                end;
            }

            trigger OnAfterGetRecord()
            begin
                OpeningAmount := 0;
                IF VendDateFilter <> '' THEN BEGIN
                    IF GETRANGEMIN("Date Filter") <> 0D THEN BEGIN
                        SETRANGE("Date Filter", 0D, GETRANGEMIN("Date Filter") - 1);
                        CALCFIELDS("TDS Balance");
                        OpeningAmount := "TDS Balance";
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                FilterText := Vendor.GETFILTERS;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Tick for Detail Report")
                {
                    field(ShowDetail; ShowDetail)
                    {
                        Caption = 'Show Detail';
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
        CompInfo.GET;
        VendFilter := Vendor.GETFILTERS;
        VendDateFilter := Vendor.GETFILTER("Date Filter");
    end;

    var
        TDSPostingGroup: Record "50004";
        Description: Text[100];
        CompInfo: Record "79";
        OpeningAmount: Decimal;
        VendFilter: Text;
        VendDateFilter: Text[30];
        FilterText: Text;
        RunningAmount: Decimal;
        ShowDetail: Boolean;
}

