pageextension 50053 "pageextension70001693" extends "Sales Return Order Subform"
{
    layout
    {
        addlast(content)
        {
            field("Line No."; "Line No.")
            {
                Editable = true;
                Visible = false;
            }
            field("Returned Document No."; "Returned Document No.")
            {
                Editable = false;
            }
            field("Returned Document Line No."; "Returned Document Line No.")
            {
                Editable = false;
                Visible = false;
            }
            field("Free Item Line"; "Free Item Line")
            {
                Editable = false;
            }
            field("Sales Line No."; "Sales Line No.")
            {
                Editable = false;
            }
        }



    }
}

