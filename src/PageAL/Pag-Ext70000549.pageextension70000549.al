pageextension 50109 "pageextension70000549" extends "Apply Vendor Entries"
{
    layout
    {

        //Unsupported feature: Property Modification (SourceExpr) on "ApplyingVendorName(Control 28)".


        //Unsupported feature: Property Modification (SourceExpr) on "Control 27".


        //Unsupported feature: Property Deletion (Name) on "ApplyingVendorName(Control 28)".


        //Unsupported feature: Property Deletion (CaptionML) on "ApplyingVendorName(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ApplyingVendorName(Control 28)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "ApplyingVendorName(Control 28)".


        //Unsupported feature: Property Deletion (Visible) on "ApplyingVendorName(Control 28)".


        //Unsupported feature: Property Deletion (Editable) on "ApplyingVendorName(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Control 27".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control 27".


        //Unsupported feature: Property Deletion (Visible) on "Control 27".


        //Unsupported feature: Property Deletion (Editable) on "Control 27".

        addafter(ApplyingVendorNo)
        {
            // field(ApplyingVendorName; ApplyingVendLedgEntry."Vendor Name")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Vendor Name';
            //     Editable = false;
            //     ToolTip = 'Specifies the vendor name of the entry to be applied.';
            //     Visible = VendNameVisible;
            // }
            // field("Vendor Name"; "Vendor Name")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Editable = false;
            //     ToolTip = 'Specifies the name of the vendor account that the entry is linked to.';
            //     //Visible = VendNameVisible;
            // }
            field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code")
            {
            }
            field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code")
            {
            }
        }

        // moveafter(ApplyingVendorNo; ApplyingDescription)
        // moveafter("Control 8"; "Control 10")
        // moveafter("Control 59"; "Control 27")
    }
}

