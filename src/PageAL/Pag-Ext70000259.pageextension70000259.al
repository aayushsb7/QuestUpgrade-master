pageextension 70000259 "pageextension70000259" extends "Posted Purchase Invoices"
{

    //Unsupported feature: Property Insertion (InsertAllowed) on ""Posted Purchase Invoices"(Page 146)".


    //Unsupported feature: Property Insertion (DeleteAllowed) on ""Posted Purchase Invoices"(Page 146)".


    //Unsupported feature: Property Insertion (ModifyAllowed) on ""Posted Purchase Invoices"(Page 146)".

    layout
    {

        //Unsupported feature: Property Modification (SourceExpr) on "Control 32".


        //Unsupported feature: Property Deletion (ToolTipML) on "Control 32".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control 32".


        //Unsupported feature: Property Deletion (Visible) on "Control 32".

        addafter("Control 4")
        {
            field("Order No."; "Order No.")
            {
                ApplicationArea = Suite;
                ToolTip = 'Specifies the number of the associated order.';
                Visible = false;
            }
        }
        addafter("Control 32")
        {
            field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code")
            {
            }
            field("Shortcut Dimension 5 Code"; "Shortcut Dimension 5 Code")
            {
            }
        }
        addafter("Control 1102601009")
        {
            field(PragyapanPatra; PragyapanPatra)
            {
            }
        }
        moveafter("Control 4"; "Control 28")
    }
}

