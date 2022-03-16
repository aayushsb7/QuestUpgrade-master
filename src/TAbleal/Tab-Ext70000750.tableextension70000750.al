tableextension 50049 "tableextension70000750" extends "Detailed Employee Ledger Entry"
{
    fields
    {
        field(50004; "Employee Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Salary Advance,Expense Advance,Other';
            OptionMembers = " ","Salary Advance","Expense Advance",Other;
        }
    }
}

