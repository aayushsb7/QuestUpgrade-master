pageextension 50096 "pageextension70000099" extends "General Ledger Setup"
{
    layout
    {

        //Unsupported feature: Property Modification (SourceExpr) on "Control 74".


        //Unsupported feature: Property Deletion (ToolTipML) on "Control 74".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control 74".

        addlast(content)
        {
            // field("Tax Invoice Renaming Threshold"; "Tax Invoice Renaming Threshold")//alreadydefined
            // {
            //     ApplicationArea = Basic, Suite;
            //     ToolTip = 'Specifies that if the amount on a sales invoice or a service invoice exceeds the threshold, then the name of the document is changed to include the words "Tax Invoice", as required by the tax authorities.';
            // }
            field("Block Negative B/C on Bank"; "Block Negative B/C on Bank")
            {
            }
            field("Dimension Fields Editable"; "Dimension Fields Editable")
            {
            }
            field("Employee Dimension"; "Employee Dimension")
            {
            }
            field("Return Tolerance"; "Return Tolerance")
            {
            }
            field("Enable Budget Control"; "Enable Budget Control")
            {
            }
            group("Agile Localization")
            {
                field("LC Details Nos."; "LC Details Nos.")
                {
                }
                field("BG Detail Nos."; "BG Detail Nos.")
                {
                }
                field("DO Detail Nos."; "DO Detail Nos.")
                {
                }
                field("DAP Detail Nos."; "DAP Detail Nos.")
                {
                }
                field("DAA Detail Nos."; "DAA Detail Nos.")
                {
                }
            }
            field("Cash Book GL Filter"; "Cash Book GL Filter")
            {
            }
            field("User Accountability Center"; "User Accountability Center")
            {
            }
            field("TDS Payment Jnl Template"; "TDS Payment Jnl Template")
            {
            }
            field("TDS Payment Jnl Batch"; "TDS Payment Jnl Batch")
            {
            }
        }



        // moveafter("Control 5"; "Control 3")
    }
}

