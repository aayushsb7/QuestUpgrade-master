table 50016 "User Accountability Centers"
{

    fields
    {
        field(1; "User ID"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(2; "Accountability Center"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Accountability Center";
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

