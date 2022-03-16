pageextension 50046 "pageextension70002064" extends "Assembly Order"
{
    layout
    {
        addlast(content)
        {
            field("Batch No."; "Batch No.")
            {
                Editable = true;
            }
            field("Manufacturing Date"; "Manufacturing Date")
            {
                Editable = false;
            }
            field("Expiry Date"; "Expiry Date")
            {
                Editable = false;
            }
        }
    }
    actions
    {
        addlast(Creation)
        {
            action("Transfer Orders")
            {
                ApplicationArea = Assembly;
                Caption = 'Transfer Orders';
                Image = PostedOrder;
                RunObject = Page 5742;
                RunPageLink = "Assembly Order No." = FIELD("No.");
                ToolTip = 'View completed assembly orders.';
            }
            // action("Posted Assembly Orders")//alreadyexist//change
            // {
            //     ApplicationArea = Assembly;
            //     Caption = 'Posted Assembly Orders';
            //     Image = PostedOrder;
            //     RunObject = Page "Posted Assembly Order";
            //     RunPageLink = "Order No." = FIELD("No.");
            //     RunPageView = SORTING("Order No.");
            //     ToolTip = 'View completed assembly orders.';
            // }
        }
    }
}

