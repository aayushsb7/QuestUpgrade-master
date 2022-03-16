pageextension 50108 "pageextension70000543" extends "Apply Customer Entries"
{
    layout
    {

        //Unsupported feature: Property Modification (SourceExpr) on "ApplyingCustomerName(Control 27)".


        //Unsupported feature: Property Modification (SourceExpr) on "Control 25".


        //Unsupported feature: Property Deletion (Name) on "ApplyingCustomerName(Control 27)".


        //Unsupported feature: Property Deletion (CaptionML) on "ApplyingCustomerName(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ApplyingCustomerName(Control 27)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "ApplyingCustomerName(Control 27)".


        //Unsupported feature: Property Deletion (Visible) on "ApplyingCustomerName(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Control 25".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control 25".


        //Unsupported feature: Property Deletion (Visible) on "Control 25".


        //Unsupported feature: Property Deletion (Editable) on "Control 25".

        addafter(ApplyingCustomerNo)
        {
            // field(ApplyingCustomerName; ApplyingCustLedgEntry."Customer Name")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Customer Name';
            //     ToolTip = 'Specifies the customer name of the entry to be applied.';
            //     // Visible = CustNameVisible;
            // }
            // field("Customer Name"; "Customer Name")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Editable = false;
            //     ToolTip = 'Specifies the customer name that the entry is linked to.';
            //     //Visible = CustNameVisible;
            // }
            field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code")
            {
            }
            field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code")
            {
            }
        }

        // moveafter(ApplyingCustomerNo; ApplyingDescription)
        // moveafter("Control 8"; "Control 10")
        // moveafter("Control 56"; "Control 25")
    }
}

