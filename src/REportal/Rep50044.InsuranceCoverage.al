report 50044 "Insurance Coverage"
{
    DefaultLayout = RDLC;
    RDLCLayout = './InsuranceCoverage.rdlc';

    dataset
    {
        dataitem(DataItem1; Table5600)
        {
            column(InsuranceNo_FixedAsset; "Fixed Asset"."Insurance No.")
            {
            }
            column(Description_FixedAsset; "Fixed Asset".Description)
            {
            }
            column(No_FixedAsset; "Fixed Asset"."No.")
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DISPLAYNAME)
            {
            }
            column(Insurance_TABLECAPTION__________InsuranceFilter; TABLECAPTION + ': ' + InsuranceFilter)
            {
            }
            column(InsuranceFilter; InsuranceFilter)
            {
            }
            column(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
            {
            }
            column(Insurance__No__; "No.")
            {
            }
            column(Insurance_Description; Description)
            {
            }
            dataitem(DataItem4; Table5628)
            {
                DataItemLink = No.=FIELD(Insurance No.);
                column(PolicyCoverage_Insurance; Insurance."Policy Coverage")
                {
                }
                column(Posting_Date; FALedgerEntries."Posting Date")
                {
                }
                column(User_id; FALedgerEntries."User ID")
                {
                }
                column(No_Insurance; Insurance."No.")
                {
                }
                column(Amount; BookedAmount)
                {
                }
                column(FAledgerEntries_DocumentNo; FALedgerEntries."Entry No.")
                {
                }
                column(PolicyNo_Insurance; Insurance."Policy No.")
                {
                }
                column(Description_Insurance; Insurance.Description)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                FALedgerEntries.SETRANGE("FA No.", "Fixed Asset"."No.");
                IF FALedgerEntries.FINDFIRST THEN BEGIN
                    BookedAmount := FALedgerEntries.Amount;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        PrintOnlyOnePerPage: Boolean;
        InsuranceFilter: Text;
        FALedgerEntries: Record "5601";
        BookedAmount: Decimal;
        FixedAsset: Record "5600";
}

