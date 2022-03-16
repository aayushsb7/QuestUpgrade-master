pageextension 50050 "pageextension70000652" extends "Vendor Ledger Entries"
{

    //Unsupported feature: Property Insertion (ModifyAllowed) on ""Vendor Ledger Entries"(Page 29)".

    layout
    {

        //Unsupported feature: Property Modification (SourceExpr) on "Control 32".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control 32".


        //Unsupported feature: Property Deletion (Visible) on "Control 32".


        //Unsupported feature: Property Deletion (Editable) on "Control 32".
        addlast(content)
        {
            field("Vendor Name"; "Vendor Name")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
                //Visible = VendNameVisible;
            }
            field("Global Dimension 1 Name"; "Global Dimension 1 Name")
            {
            }
            field("Global Dimension 2 Name"; "Global Dimension 2 Name")
            {
            }
            field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code")
            {
            }
            field("Shortcut Dimension 3 Name"; "Shortcut Dimension 3 Name")
            {
            }
            // field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code")
            // {
            // }
            field("Shortcut Dimension 4 Name"; "Shortcut Dimension 4 Name")
            {
            }
            // field("Shortcut Dimension 5 Code"; "Shortcut Dimension 5 Code")
            // {
            // }
            field("Shortcut Dimension 5 Name"; "Shortcut Dimension 5 Name")
            {
            }

            field("Shortcut Dimension 6 Name"; "Shortcut Dimension 6 Name")
            {
            }

            field("Shortcut Dimension 8 Name"; "Shortcut Dimension 8 Name")
            {
            }
            field("Document Date"; "Document Date")
            {
            }
            field(Narration; Narration)
            {
            }
        }

        //  moveafter("Control 8"; "Control 5")
    }
}

