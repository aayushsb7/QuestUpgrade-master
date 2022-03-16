tableextension 70001333 "tableextension70001333" extends "User Setup"
{
    fields
    {
        field(50000; "Allow Handling MRP"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'if the value is true then user will be able to edit and modify MRP';
        }
        field(50001; "Default Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(50501; "Default Accountability Center"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'NP15.1001';
            TableRelation = "Accountability Center";
        }
        field(59001; "Allow TDS A/C Direct Posting"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'TDS1.00';
        }
        field(59002; "Blank IRD Voucher No."; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(59003; "Allow All Journal Batch"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(59005; "Skip Posting Date Control"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}

