tableextension 70000492 "tableextension70000492" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50001; "Apply Cust. Entry Dim 1 Wise"; Boolean)
        {
            CaptionClass = '1,2,1';
            DataClassification = ToBeClassified;
        }
        field(50002; "Apply Cust. Entry Dim 2 Wise"; Boolean)
        {
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
        }
        field(50003; "Apply Cust. Entry Dim 3 Wise"; Boolean)
        {
            CaptionClass = '1,2,3';
            DataClassification = ToBeClassified;
        }
        field(50004; "Apply Cust. Entry Dim 4 Wise"; Boolean)
        {
            CaptionClass = '1,2,4';
            DataClassification = ToBeClassified;
        }
        field(50005; "Apply Cust. Entry Dim 5 Wise"; Boolean)
        {
            CaptionClass = '1,2,5';
            DataClassification = ToBeClassified;
        }
        field(50006; "Apply Cust. Entry Dim 6 Wise"; Boolean)
        {
            CaptionClass = '1,2,6';
            DataClassification = ToBeClassified;
        }
        field(50007; "Apply Cust. Entry Dim 7 Wise"; Boolean)
        {
            CaptionClass = '1,2,7';
            DataClassification = ToBeClassified;
        }
        field(50008; "Apply Cust. Entry Dim 8 Wise"; Boolean)
        {
            CaptionClass = '1,2,8';
            DataClassification = ToBeClassified;
        }
        field(55004; "Re-Order Reserved Invoice No."; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(55005; "Maximum Sales Line Per Doc."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'to allow no. of sales line as per the number provided';
        }
    }
}

