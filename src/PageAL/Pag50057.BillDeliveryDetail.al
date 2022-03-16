page 50057 "Bill Delivery Detail"
{
    PageType = Card;
    SourceTable = "Bill Delivery Details";

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Sales Invoice No."; "Sales Invoice No.")
                {
                    Editable = false;
                    Visible = true;
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
                    Editable = false;
                }
                field("Sales Order No."; "Sales Order No.")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.GET(USERID);
        UserSetup.TESTFIELD("Default Accountability Center");
        UserSetup.TESTFIELD("Default Location Code");

        "Accountability Center" := UserSetup."Default Accountability Center";
        "Location Code" := UserSetup."Default Location Code";
    end;

    var
        UserSetup: Record "User Setup";
}

