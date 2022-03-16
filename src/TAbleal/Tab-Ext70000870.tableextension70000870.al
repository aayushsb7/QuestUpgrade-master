tableextension 50050 "tableextension70000870" extends "Fixed Asset"
{
    fields
    {
        field(50001; Location; Code[20])
        {
            CalcFormula = Lookup("FA Custodian".Location WHERE("FA No." = FIELD("No."),
                                                                "Current Owner" = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; "User Responsibility Center"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Shortcut Dimension 3 Code"; Code[20])
        {
            CalcFormula = Lookup("FA Ledger Entry".Field23020456 WHERE("FA No." = FIELD("No.")));
            CaptionClass = '1,2,3';
            FieldClass = FlowField;
        }
        field(50005; "Shortcut Dimension 4 Code"; Code[20])
        {
            CalcFormula = Lookup("FA Ledger Entry".Field23020456 WHERE("FA No." = FIELD("No.")));
            CaptionClass = '1,2,4';
            FieldClass = FlowField;
        }
        field(50006; "Shortcut Dimension 5 Code"; Code[20])
        {
            CalcFormula = Lookup("FA Ledger Entry".Field23020456 WHERE("FA No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50011; "Shortcut Dimension 6 Code"; Code[20])
        {
            CalcFormula = Lookup("FA Ledger Entry".Field23020456 WHERE("FA No." = FIELD("No.")));
            CaptionClass = '1,2,6';
            FieldClass = FlowField;
        }
        field(50012; "Shortcut Dimension 1 Code"; Code[20])
        {
            CalcFormula = Lookup("FA Ledger Entry"."Global Dimension 1 Code" WHERE("FA No." = FIELD("No.")));
            CaptionClass = '1,2,1';
            FieldClass = FlowField;
        }
        field(50013; "Shortcut Dimension 2 Code"; Code[20])
        {
            CalcFormula = Lookup("FA Ledger Entry"."Global Dimension 2 Code" WHERE("FA No." = FIELD("No.")));
            CaptionClass = '1,2,2';
            FieldClass = FlowField;
        }
        field(50199; "New Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(50200; "New Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));
        }
        field(50201; "Insurance No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Insurance;
        }
    }
}

