pageextension 50089 "pageextension70000724" extends "Bank Account Posting Groups"
{
    layout
    {
        addlast(content)
        {
            field("Interest G/L Account No."; "Interest G/L Account No.")
            {

                trigger OnValidate()
                begin
                    TESTFIELD(Type, Type::"Loan Account");  //SRT Dec 5th 2019
                end;
            }
            field(Type; Type)
            {
            }
        }
    }
}

