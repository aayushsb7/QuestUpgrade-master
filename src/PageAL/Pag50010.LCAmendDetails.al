page 50010 "LC Amend Details"
{
    CardPageID = "LC/BG/DO Amend Detail Card";
    Editable = false;
    PageType = List;
    SourceTable = "LC Amend Detail";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Version No."; "Version No.")
                {
                }
                field("No."; "No.")
                {
                }
                field("LC No."; "LC No.")
                {
                }
                field(Description; Description)
                {
                }
                field("Transaction Type"; "Transaction Type")
                {
                }
                field("Issued To/Received From"; "Issued To/Received From")
                {
                }
                field("Issuing Bank"; "Issuing Bank")
                {
                }
                field("Date of Issue"; "Date of Issue")
                {
                }
            }
        }
    }

    actions
    {
    }
}

