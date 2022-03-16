tableextension 50045 "tableextension70000728" extends Employee
{
    fields
    {
        field(50004; "Employee Transaction Type"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = ' ,Salary Advance,Expense Advance,Other';
            OptionMembers = " ","Salary Advance","Expense Advance",Other;
        }
    }
    keys
    {
        key(Key1; "First Name")
        {
        }
    }
}

