table 50017 "FA Transfer Ledger"
{
    LookupPageID = 50012;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "FA Code"; Code[20])
        {
            TableRelation = "Fixed Asset"."No.";
        }
        field(3;Description;Text[50])
        {
        }
        field(4;"Description 2";Text[250])
        {
        }
        field(5;"Serial No.";Text[30])
        {
        }
        field(6;Quantity;Decimal)
        {
        }
        field(7;"FA Class Code";Code[20])
        {
        }
        field(8;"FA Subclass Code";Code[20])
        {
        }
        field(9;"FA Location";Code[20])
        {
        }
        field(10;Location;Code[20])
        {
            TableRelation = Location;
        }
        field(11;"Book Value";Decimal)
        {
        }
        field(12;"Transfer Date";Date)
        {
        }
        field(13;"From FA Location Code";Code[20])
        {
        }
        field(14;"From Location";Code[20])
        {
        }
        field(15;Remarks;Text[250])
        {
        }
        field(500001;"From  Person";Code[20])
        {
        }
        field(500002;Person;Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"Entry No.")
        {
            Clustered = true;
        }
        key(Key2;"FA Code")
        {
        }
    }

    fieldgroups
    {
    }
}

