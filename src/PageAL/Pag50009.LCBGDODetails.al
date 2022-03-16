page 50009 "LC/BG/DO Details"
{
    CardPageID = "LC/BG/DO Detail Card";
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Details';
    SourceTable = "LC Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field("LC\DO No."; "LC\DO No.")
                {
                    Caption = 'LC\DO\BG';
                }
                field("Issued To/Received From"; "Issued To/Received From")
                {
                }
                field("Issued To/Received From Name"; "Issued To/Received From Name")
                {
                }
                field(Units; Units)
                {
                }
                field("Utilized Unit"; "Utilized Unit")
                {
                }
                field("LC Value"; "LC Value")
                {
                    Caption = 'LC\DO\BG Value';
                }
                field("Date of Issue"; "Date of Issue")
                {
                }
                field("Transaction Type"; "Transaction Type")
                {
                }
                field("Type of LC"; "Type of LC")
                {
                    Caption = 'Type of LC\DO\BG';
                }
                field("Expiry Date"; "Expiry Date")
                {
                }
                field(Closed; Closed)
                {
                }
                field(Released; Released)
                {
                }
                field("Document Type"; "Document Type")
                {
                }
                field("LC Value (LCY)"; "LC Value (LCY)")
                {
                }
                field("Sales LC Utilized Value"; "Sales LC Utilized Value")
                {
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            // systempart(; Notes)
            // {
            // }
            // systempart(; MyNotes)
            // {
            // }
            // systempart(; Links)
            // {
            // }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }
}

