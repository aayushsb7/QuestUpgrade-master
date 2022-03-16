tableextension 70000615 "tableextension70000615" extends "G/L Register"
{
    fields
    {

        //Unsupported feature: Deletion (FieldCollection) on ""Creation Time"(Field 11)".

        field(50501; "Creation Time"; Time)
        {
            DataClassification = ToBeClassified;
            Description = 'NP15.1001';
        }
        field(59000; "From TDS Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'TDS1.00';
        }
        field(59001; "To TDS Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'TDS1.00';
        }
    }
}

