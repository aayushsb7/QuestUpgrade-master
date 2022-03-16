tableextension 70000652 "tableextension70000652" extends "Accounting Period"
{
    fields
    {
        field(50000; "Depreciation Group"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,1,2,3';
            OptionMembers = " ","1","2","3";
        }
        field(50501; "Nepali Fiscal Year"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'NP15.1001';
        }
    }
}

