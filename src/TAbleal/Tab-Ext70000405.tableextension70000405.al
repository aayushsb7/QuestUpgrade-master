tableextension 50012 "tableextension70000405" extends Vendor
{
    fields
    {
        field(50501; "Pragyapan Patra Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'NP15.1001';
        }
        field(50502; "Consigment No. Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(55000; "TDS Balance"; Decimal)
        {
            Description = '//for Vendor TDS Entry Report';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Original TDS Entry"."Original TDS Amount" WHERE("Source Type" = CONST(Vendor),
                                                                                "Bill-to/Pay-to No." = FIELD("No."),
                                                                                "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                Closed = FIELD("TDS Entry Closed Filter"),
                                                                                "TDS Type" = CONST("Purchase TDS"),
                                                                                "Posting Date" = FIELD("Date Filter")));

        }
        field(55001; "TDS Entry Closed Filter"; Boolean)
        {
            FieldClass = FlowFilter;
        }
        field(55002; "TDS Balance (Open)"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Original TDS Entry"."Original TDS Amount" WHERE("Source Type" = CONST(Vendor),
                                                                                "Bill-to/Pay-to No." = FIELD("No."),
                                                                               "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                Closed = CONST(false),
                                                                                "TDS Type" = CONST("Purchase TDS"),
                                                                                "Posting Date" = FIELD("Date Filter"),
                                                                                Reversed = CONST(false)));

        }
        field(55003; "LC No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "LC Details"."No.";
        }
        field(55004; "LC No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(55005; "External Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'To know whether vendor entry is from Amnil Technologies or not';
        }
    }
}

