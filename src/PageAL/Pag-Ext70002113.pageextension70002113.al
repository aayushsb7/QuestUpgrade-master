pageextension 50041 "pageextension70002113" extends "Assembly Setup"
{
    layout
    {
        addafter("Control 11")
        {
            field("Default Location for Transfer"; "Default Location for Transfer")
            {
                ToolTip = 'if the value is not blank then when Assembly is posted from API Transfer order will be shipped from factory to Default Location for Transfer';
            }
        }
        addafter("Control 12")
        {
            field("Block Same Assembly Item Line"; "Block Same Assembly Item Line")
            {
                ToolTip = 'if the value is true then duplicate item no. cannot be inserted in assembly line';
            }
        }
    }
}

