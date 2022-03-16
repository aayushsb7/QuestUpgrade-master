table 50011 "Journal Dimension Bal. Buffer"
{

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(2; "Journal Batch Name"; Code[10])
        {
        }
        field(3; "Dimension No."; Integer)
        {
        }
        field(4; "Dimension Code"; Code[20])
        {
        }
        field(5; "Dimension Value Code"; Code[20])
        {
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; Mandatory; Boolean)
        {
        }
        field(8; "Document No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", "Journal Batch Name", "Document No.", "Dimension Code", "Dimension Value Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

