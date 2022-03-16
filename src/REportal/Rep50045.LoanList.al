report 50045 "Loan List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './LoanList.rdlc';

    dataset
    {
        dataitem(DataItem1; Table270)
        {
            column(ReportName; ReportName)
            {
            }
            column(Allfilters; Allfilters)
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DISPLAYNAME)
            {
            }
            column(LoanNo; LoanNo)
            {
            }
            column(IssuingBankName; "Bank Account"."Issuing Bank Name")
            {
            }
            column(LoanType; "Bank Account"."Loan Type")
            {
            }
            column(LoanAmount; "Bank Account"."Loan Amount")
            {
            }

            trigger OnAfterGetRecord()
            begin

                LoanNo := Name;
            end;

            trigger OnPreDataItem()
            begin

                SETFILTER(Type, '%1', "Bank Account".Type::Loan);
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

    trigger OnPreReport()
    begin
        Allfilters := "Bank Account".GETFILTERS;
    end;

    var
        ReportName: Label 'Loan List';
        Allfilters: Text;
        LoanNo: Text;
}

