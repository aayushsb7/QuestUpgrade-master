pageextension 50101 "pageextension70000226" extends "Posted Purch. Invoice Subform"
{
    layout
    {

        //Unsupported feature: Property Modification (SourceExpr) on "Control 15".


        //Unsupported feature: Property Deletion (ToolTipML) on "Control 15".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control 15".


        //Unsupported feature: Property Deletion (Visible) on "Control 15".

        addafter(FilteredTypeField)
        {
            field("FA Item Charge"; "FA Item Charge")
            {
            }
            // field("Job Task No."; "Job Task No.")
            // {
            //     ApplicationArea = Jobs;
            //     ToolTip = 'Specifies the number of the related job task.';
            //     Visible = false;
            // }
            field("TDS Group"; "TDS Group")
            {
            }
            field("TDS%"; "TDS%")
            {
            }
            field("TDS Type"; "TDS Type")
            {
            }
            field("TDS Amount"; "TDS Amount")
            {
            }
            field("TDS Base Amount"; "TDS Base Amount")
            {
            }
            field("Document Subclass"; "Document Subclass")
            {
            }
            field(PragyapanPatra; PragyapanPatra)
            {
            }
        }
        // moveafter("Control 34"; "Control 20")
    }
}

