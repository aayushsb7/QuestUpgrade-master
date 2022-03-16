pageextension 70000102 "pageextension70000102" extends "User Setup"
{
    layout
    {
        addafter(Email)
        {
            field("Default Accountability Center"; "Default Accountability Center")
            {
            }
            field("Default Location Code"; "Default Location Code")
            {
            }
            field("Allow TDS A/C Direct Posting"; "Allow TDS A/C Direct Posting")
            {
            }
            field("Blank IRD Voucher No."; "Blank IRD Voucher No.")
            {
            }
            field("Allow All Journal Batch"; "Allow All Journal Batch")
            {
            }
            field("Skip Posting Date Control"; "Skip Posting Date Control")
            {
            }
            field("Approval Administrator"; "Approval Administrator")
            {
            }
            field("Allow Handling MRP"; "Allow Handling MRP")
            {
                ToolTip = 'if the value is true then user will be able to edit and modify MRP';
            }
        }
    }
}

