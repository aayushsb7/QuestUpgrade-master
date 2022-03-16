pageextension 50087 "pageextension70000754" extends "Item Journal"
{
    layout
    {
        addlast(content)
        {
            field("Line No."; "Line No.")
            {
                Editable = false;
            }
            field("Batch No."; "Batch No.")
            {
                Visible = false;
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

