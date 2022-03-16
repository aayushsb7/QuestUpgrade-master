pageextension 70001311 "pageextension70001311" extends "Posted Transfer Receipts"
{

    //Unsupported feature: Property Insertion (InsertAllowed) on ""Posted Transfer Receipts"(Page 5753)".


    //Unsupported feature: Property Insertion (DeleteAllowed) on ""Posted Transfer Receipts"(Page 5753)".


    //Unsupported feature: Property Insertion (ModifyAllowed) on ""Posted Transfer Receipts"(Page 5753)".

    layout
    {
        addafter("Control 1102601007")
        {
            field("Batch No."; "Batch No.")
            {
            }
            field("Posted Assembly Order"; "Posted Assembly Order")
            {
            }
            field("Manufacturing Date"; "Manufacturing Date")
            {
                Visible = false;
            }
            field("Expiy Date"; "Expiy Date")
            {
                Visible = false;
            }
        }
    }
}

