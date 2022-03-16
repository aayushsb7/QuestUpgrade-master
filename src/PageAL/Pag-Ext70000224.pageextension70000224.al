pageextension 50100 "pageextension70000224" extends "Posted Purchase Rcpt. Subform"
{

    //Unsupported feature: Property Insertion (InsertAllowed) on ""Posted Purchase Rcpt. Subform"(Page 137)".


    //Unsupported feature: Property Insertion (DeleteAllowed) on ""Posted Purchase Rcpt. Subform"(Page 137)".


    //Unsupported feature: Property Insertion (ModifyAllowed) on ""Posted Purchase Rcpt. Subform"(Page 137)".

    layout
    {

        //Unsupported feature: Property Modification (SourceExpr) on "Control 5".


        //Unsupported feature: Property Deletion (ToolTipML) on "Control 5".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control 5".


        //Unsupported feature: Property Deletion (Visible) on "Control 5".

        addlast(content)
        {
            field("FA Item Charge"; "FA Item Charge")
            {
            }
            // field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
            // {
            //     ApplicationArea = Dimensions;
            //     ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
            //     Visible = DimVisible2;
            // }
        }

        //moveafter("Control 7"; "Control 19")
    }
}

