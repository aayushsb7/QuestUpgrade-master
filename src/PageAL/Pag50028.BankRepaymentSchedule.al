page 50028 "Bank Repayment Schedule"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Loan Repayment Schedule";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bank No."; "Bank No.")
                {
                }
                field("Bank Name"; "Bank Name")
                {
                }
                field("Principal Amount"; "Principal Amount")
                {
                }
                field("Installment Amount"; "Installment Amount")
                {
                }
                field("Installment Payment Date"; "Installment Payment Date")
                {
                }
                field("Installment Pmt. Nepali Date"; "Installment Pmt. Nepali Date")
                {
                }
                field("Interest Rate"; "Interest Rate")
                {
                }
                field("Interest Amount"; "Interest Amount")
                {
                }
                field("Remaining Interest Amount"; "Remaining Interest Amount")
                {
                    Editable = false;
                }
                field("Remaining Amount"; "Remaining Amount")
                {
                    Editable = false;
                }
                field("Repayment Posted"; "Repayment Posted")
                {
                    Editable = false;
                }
                field("Interest Posted"; "Interest Posted")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

