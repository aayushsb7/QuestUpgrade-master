pageextension 70000759 "pageextension70000759" extends "Purchase Order Statistics"
{
    layout
    {
        addafter("Total_General")
        {
            field("TDS Amount"; TotalPurchLine[1]."TDS Amount")
            {
                Caption = 'TDS Amount';
                Editable = false;
            }
        }
    }
}

