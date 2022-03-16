report 50046 "Loan Detail"
{
    DefaultLayout = RDLC;
    RDLCLayout = './LoanDetail.rdlc';

    dataset
    {
        dataitem(DataItem1; Table270)
        {
            column(CompanyName; COMPANYPROPERTY.DISPLAYNAME)
            {
            }
            column(ReportName; ReportName)
            {
            }
            column(LoanNo; LoanNo)
            {
            }
            column(IssuingBankName_BankAccount; "Bank Account"."Issuing Bank Name")
            {
            }
            column(LoanType_BankAccount; "Bank Account"."Loan Type")
            {
            }
            column(LoanAmount_BankAccount; "Bank Account"."Loan Amount")
            {
            }
            column(OutstandingPrinciple; OutstandingPrinciple)
            {
            }
            column(StartDate_BankAccount; "Bank Account"."Start Date")
            {
            }
            column(EndDate_BankAccount; "Bank Account"."End Date")
            {
            }
            column(InterestRate_BankAccount; "Bank Account"."Interest Rate")
            {
            }
            column(NoOfInstallament; Countt)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(OutstandingPrinciple);
                LoanNo := Name;
                Countt := 0;

                LoanRepaySchedule.RESET;
                LoanRepaySchedule.SETRANGE("Loan Account No.", "Bank Account"."No.");
                LoanRepaySchedule.SETRANGE("Repayment Posted", TRUE);
                IF LoanRepaySchedule.FINDFIRST THEN BEGIN
                    OutstandingPrinciple := "Bank Account"."Loan Amount";
                    REPEAT
                        OutstandingPrinciple := OutstandingPrinciple - LoanRepaySchedule."Principal Amount";
                    UNTIL LoanRepaySchedule.NEXT = 0;
                END;




                LoanRepaySchedule.RESET;
                LoanRepaySchedule.SETRANGE("Loan Account No.", "Bank Account"."No.");
                LoanRepaySchedule.SETFILTER("Principal Amount", '> 0');

                IF LoanRepaySchedule.FINDFIRST THEN
                    REPEAT

                        Countt += 1;


                    UNTIL LoanRepaySchedule.NEXT = 0;
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

    var
        LoanNo: Text;
        OutstandingPrinciple: Decimal;
        NoOfInstallament: Decimal;
        CompanyInfo: Record "79";
        ReportName: Label 'Loan Detail';
        LoanRepaySchedule: Record "50020";
        Countt: Decimal;
}

