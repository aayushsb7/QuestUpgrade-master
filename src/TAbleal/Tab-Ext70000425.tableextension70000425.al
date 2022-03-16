tableextension 70000425 "tableextension70000425" extends "General Posting Setup"
{
    fields
    {
        field(50000; "Spillage G/L Account"; Code[20])
        {
            Caption = 'Spillage G/L Account';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50001; "Used in Ledger Entries"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}

