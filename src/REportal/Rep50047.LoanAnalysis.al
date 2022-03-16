report 50047 "Loan Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './LoanAnalysis.rdlc';

    dataset
    {
        dataitem(DataItem1; Table270)
        {
            DataItemTableView = WHERE (Type = CONST (Loan));
            RequestFilterFields = "No.", "Bank Acc. Posting Group";
            column(AllFilters; AllFilters)
            {
            }
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
            column(OverDuePrincipal; OverDuePrincipal)
            {
            }
            column(OverDueInterest; OverDueIntrest)
            {
            }
            column(ExcessInterestPaid; ExcessIntrestPaid)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(OverDuePrincipal);
                CLEAR(OverDueIntrest);
                CLEAR(ExcessIntrestPaid);
                Interest := 0;

                LoanNo := "Bank Account".Name;

                LoanRepaySchedule.RESET;
                LoanRepaySchedule.SETRANGE("Loan Account No.", "Bank Account"."No.");
                LoanRepaySchedule.SETFILTER("Installment Payment Date", '< TODAY');
                IF LoanRepaySchedule.FINDSET THEN
                    REPEAT
                        IF NOT LoanRepaySchedule."Repayment Posted" THEN
                            OverDuePrincipal += LoanRepaySchedule."Principal Amount";
                        IF NOT LoanRepaySchedule."Interest Posted" THEN
                            OverDueIntrest += LoanRepaySchedule."Interest Amount";
                    UNTIL LoanRepaySchedule.NEXT = 0;

                LoanRepaySchedule.RESET;
                LoanRepaySchedule.SETRANGE("Loan Account No.", "Bank Account"."No.");
                LoanRepaySchedule.SETRANGE("Interest Posted", TRUE);
                IF LoanRepaySchedule.FINDFIRST THEN BEGIN
                    ExcessIntrestPaid := Interest;
                    REPEAT

                        Interest := LoanRepaySchedule."Remaining Interest Amount" - LoanRepaySchedule."Interest Amount";
                        ExcessIntrestPaid += Interest;

                    UNTIL LoanRepaySchedule.NEXT = 0;
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

    trigger OnPreReport()
    begin
        AllFilters := "Bank Account".GETFILTERS;
    end;

    var
        LoanNo: Text;
        OverDuePrincipal: Decimal;
        OverDueIntrest: Decimal;
        ExcessIntrestPaid: Decimal;
        ReportName: Label 'Loan Analysis';
        LoanRepaySchedule: Record "50020";
        Interest: Decimal;
        AllFilters: Text;
}

