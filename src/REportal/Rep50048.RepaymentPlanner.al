report 50048 "Repayment Planner"
{
    DefaultLayout = RDLC;
    RDLCLayout = './RepaymentPlanner.rdlc';

    dataset
    {
        dataitem(DataItem1; Table270)
        {
            DataItemTableView = WHERE (Type = CONST (Loan));
            column(AllFilters; AllFilters)
            {
            }
            column(CompanyName; COMPANYPROPERTY.DISPLAYNAME)
            {
            }
            column(ReportName; ReportName)
            {
            }
            column(AmountIn7days; AmountIn7days)
            {
            }
            column(AmountIn15days; AmountIn15days)
            {
            }
            column(AmountIn30days; AmountIn30days)
            {
            }
            column(AmountIn90days; AmountIn90days)
            {
            }
            column(BankNo; "Issuing Bank")
            {
            }
            column(BankName; "Issuing Bank Name")
            {
            }

            trigger OnAfterGetRecord()
            begin
                CALCFIELDS("Issuing Bank Name");
                AmountIn7days := 0;
                AmountIn15days := 0;
                AmountIn30days := 0;
                AmountIn90days := 0;
                AmountIn7days := AmountForVaroiusDays(StartingDate, StartingDate + 7);
                AmountIn15days := AmountForVaroiusDays(StartingDate + 8, StartingDate + 15);
                AmountIn30days := AmountForVaroiusDays(StartingDate + 16, StartingDate + 30);
                AmountIn90days := AmountForVaroiusDays(StartingDate + 31, StartingDate + 90);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Starting Date"; StartingDate)
                {
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
        AllFilters := "Bank Account".GETFILTERS;
    end;

    var
        LoanRepaySchedule: Record "50020";
        AmountIn7days: Decimal;
        ReportName: Label 'Repayment Planner';
        AmountIn15days: Decimal;
        AmountIn30days: Decimal;
        AmountIn90days: Decimal;
        StartingDate: Date;
        AllFilters: Text;

    local procedure AmountForVaroiusDays(Starting: Date; Ending: Date): Decimal
    var
        amt: Decimal;
    begin
        amt := 0;
        LoanRepaySchedule.RESET;
        LoanRepaySchedule.SETRANGE("Loan Account No.", "Bank Account"."No.");
        LoanRepaySchedule.SETRANGE("Bank No.", "Bank Account"."Issuing Bank");
        LoanRepaySchedule.SETRANGE("Installment Payment Date", Starting, Ending);
        IF LoanRepaySchedule.FINDFIRST THEN
            REPEAT
                amt += LoanRepaySchedule."Principal Amount" + LoanRepaySchedule."Installment Amount";
            UNTIL LoanRepaySchedule.NEXT = 0;

        EXIT(amt);
    end;
}

