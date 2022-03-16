page 50056 "Bill Delivery Details"
{
    CardPageID = "Bill Delivery Detail";
    PageType = List;
    SourceTable = "Bill Delivery Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; "Document No.")
                {
                }
                field("Sales Invoice No."; "Sales Invoice No.")
                {
                }
                field("Posting Date"; "Posting Date")
                {
                }
                field("Transport Name"; "Transport Name")
                {
                }
                field("CN No."; "CN No.")
                {
                }
                field("Dispatch Date"; "Dispatch Date")
                {
                }
                field("M.R."; "M.R.")
                {
                }
                field(Cases; Cases)
                {
                }
                field("Doc. Thru."; "Doc. Thru.")
                {
                }
                field("Accountability Center"; "Accountability Center")
                {
                }
                field("Sales Order No."; "Sales Order No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

