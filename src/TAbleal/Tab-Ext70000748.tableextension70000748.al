tableextension 50047 "tableextension70000748" extends "Employee Posting Group"
{
    fields
    {
        field(50000; "Salary Advance Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                CheckGLAcc("Salary Advance Account");  //SRT August 6th 2019
            end;
        }
        field(50001; "Expense Advance Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                CheckGLAcc("Expense Advance Account"); //SRT August 6th 2019
            end;
        }
        field(50003; "Other Advance Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                CheckGLAcc("Other Advance Account"); //SRT August 6th 2019
            end;
        }
    }

    procedure GetSalaryAdvanceAccount(): Code[20]
    begin
        //SRT August 6th 2019 >>
        TESTFIELD("Salary Advance Account");
        EXIT("Salary Advance Account");
    end;

    procedure GetExpenseAdvanceAccount(): Code[20]
    begin
        //SRT August 6th 2019 >>
        TESTFIELD("Expense Advance Account");
        EXIT("Expense Advance Account");
    end;

    procedure GetOtherAdvanceAccount(): Code[20]
    begin
        //SRT August 6th 2019 >>
        TESTFIELD("Other Advance Account");
        EXIT("Other Advance Account");
    end;
}

