pageextension 70002270 "pageextension70002270" extends "Purchase Order List"
{
    layout
    {
        addafter("Amount Received Not Invoiced excl. VAT (LCY)")
        {
            field("Vendor Invoice No."; "Vendor Invoice No.")
            {
            }
        }
    }
}

