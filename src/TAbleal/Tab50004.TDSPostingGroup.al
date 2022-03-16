table 50004 "TDS Posting Group"
{
    DrillDownPageID = 50003;
    LookupPageID = 50003;

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "TDS%"; Decimal)
        {
        }
        field(3; "GL Account No."; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(4; Type; Option)
        {
            OptionCaption = ' ,Purchase TDS,Sales TDS';
            OptionMembers = " ","Purchase TDS","Sales TDS";
        }
        field(5; "Effective From"; Date)
        {
        }
        field(6; Blocked; Boolean)
        {
        }
        field(7; Description; Text[100])
        {
        }
        field(8; "TDS base excluing VAT"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", "TDS%", "GL Account No.")
        {
        }
    }


    procedure FindTDSGroup(TDSGroup: Code[20]; EffectiveDate: Date): Boolean
    begin
        RESET;
        SETRANGE(Code, TDSGroup);
        SETRANGE(Blocked, FALSE);
        //SETFILTER("Effective From",'<%1',EffectiveDate);
        EXIT(FINDLAST);
    end;
}

