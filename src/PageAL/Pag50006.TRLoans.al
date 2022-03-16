page 50006 "TR Loans"
{
    PageType = List;
    SourceTable = "TR Loan";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("TR Code"; "TR Code")
                {
                }
                field("LC No."; "LC No.")
                {
                }
                field(Description; Description)
                {
                }
                field("Expiry Date"; "Expiry Date")
                {
                }
                field(Period; Period)
                {
                }
                field("Interest Rate"; "Interest Rate")
                {
                }
            }
        }
    }

    actions
    {
    }
}

