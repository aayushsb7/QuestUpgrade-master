tableextension 50064 "tableextension70001313" extends "Assembly Setup"
{
    fields
    {
        field(50000; "Default Location for Transfer"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'if the value is not blank then when Assembly is posted from API Transfer order will be shipped from factory to Default Location for Transfer';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(50001; "Block Same Assembly Item Line"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'if the value is true then duplicate item no. cannot be inserted in assembly line';
        }
    }
}

