tableextension 50017 "tableextension70000451" extends "Bank Account Posting Group"
{
    fields
    {
        field(50000; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Bank Account,Loan Account';
            OptionMembers = "Bank Account","Loan Account";
        }
        field(50001; "Interest G/L Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                CheckGLAcc("Interest G/L Account No."); //SRT Dec 7th 2019
            end;
        }
    }

    procedure GetLoanInterestAdvanceAccount(): Code[20]
    begin
        //SRT Dec 7th 2019 >>
        TESTFIELD("Interest G/L Account No.");
        EXIT("Interest G/L Account No.");
    end;

    //Unsupported feature: Property Modification (Fields) on "DropDown(FieldGroup 1)".

}

