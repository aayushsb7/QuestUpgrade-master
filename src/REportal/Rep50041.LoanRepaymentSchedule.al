report 50041 "Loan Repayment Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './LoanRepaymentSchedule.rdlc';

    dataset
    {
        dataitem(DataItem1; Table50020)
        {
            RequestFilterFields = "Loan Account No.", "Bank No.";
            column(AllFilters; AllFilters)
            {
            }
            column(ReportName; ReportName)
            {
            }
            column(LoanAccountNo_LoanRepaymentSchedule; "Loan Repayment Schedule"."Loan Account No.")
            {
            }
            column(ActualLoanAccountNo; Loan.Name)
            {
            }
            column(LineNo_LoanRepaymentSchedule; "Loan Repayment Schedule"."Line No.")
            {
            }
            column(BankNo_LoanRepaymentSchedule; "Loan Repayment Schedule"."Bank No.")
            {
            }
            column(BankName_LoanRepaymentSchedule; "Loan Repayment Schedule"."Bank Name")
            {
            }
            column(PrincipalAmount_LoanRepaymentSchedule; "Loan Repayment Schedule"."Principal Amount")
            {
            }
            column(InstallmentAmount_LoanRepaymentSchedule; "Loan Repayment Schedule"."Installment Amount")
            {
            }
            column(InstallmentPaymentDate_LoanRepaymentSchedule; FORMAT("Loan Repayment Schedule"."Installment Payment Date") + '(' + "Loan Repayment Schedule"."Installment Pmt. Nepali Date" + ')')
            {
            }
            column(RepaymentPosted_LoanRepaymentSchedule; "Loan Repayment Schedule"."Repayment Posted")
            {
            }
            column(RepaymentReversed_LoanRepaymentSchedule; "Loan Repayment Schedule"."Repayment Reversed")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Loan.GET("Loan Repayment Schedule"."Loan Account No.") THEN
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
        AllFilters := "Loan Repayment Schedule".GETFILTERS;
    end;

    var
        AllFilters: Text;
        ReportName: Label 'Loan Repayment Schedule';
        Loan: Record "270";
}

