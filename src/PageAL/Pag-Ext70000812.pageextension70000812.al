pageextension 50081 "pageextension70000812" extends "Sales & Receivables Setup"
{
    layout
    {
        addlast(content)
        {
            field("Re-Order Reserved Invoice No."; "Re-Order Reserved Invoice No.")
            {
            }
        }
        addlast(content)
        {
            group("ASPL Setup")
            {
                group("Dimension Wise Apply Entry Setup")
                {
                    field("Apply Cust. Entry Dim 1 Wise"; "Apply Cust. Entry Dim 1 Wise")
                    {
                    }
                    field("Apply Cust. Entry Dim 2 Wise"; "Apply Cust. Entry Dim 2 Wise")
                    {
                    }
                    field("Apply Cust. Entry Dim 3 Wise"; "Apply Cust. Entry Dim 3 Wise")
                    {
                    }
                    field("Apply Cust. Entry Dim 4 Wise"; "Apply Cust. Entry Dim 4 Wise")
                    {
                    }
                    field("Apply Cust. Entry Dim 5 Wise"; "Apply Cust. Entry Dim 5 Wise")
                    {
                    }
                    field("Apply Cust. Entry Dim 6 Wise"; "Apply Cust. Entry Dim 6 Wise")
                    {
                    }
                    field("Apply Cust. Entry Dim 7 Wise"; "Apply Cust. Entry Dim 7 Wise")
                    {
                    }
                    field("Apply Cust. Entry Dim 8 Wise"; "Apply Cust. Entry Dim 8 Wise")
                    {
                    }
                }
                field("Maximum Sales Line Per Doc."; "Maximum Sales Line Per Doc.")
                {
                    ToolTip = 'to allow no. of sales line as per the number provided';
                }
            }
        }
    }
}

