pageextension 50072 "pageextension70001310" extends "Posted Transfer Shipments"
{

    //Unsupported feature: Property Insertion (InsertAllowed) on ""Posted Transfer Shipments"(Page 5752)".


    //Unsupported feature: Property Insertion (DeleteAllowed) on ""Posted Transfer Shipments"(Page 5752)".


    //Unsupported feature: Property Insertion (ModifyAllowed) on ""Posted Transfer Shipments"(Page 5752)".

    layout
    {
        addlast(content)
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

