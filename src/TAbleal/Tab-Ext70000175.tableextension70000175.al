tableextension 50009 "tableextension70000175" extends "G/L Account"
{
    fields
    {
        field(59000; "TDS Account"; Boolean)
        {
            Description = 'TDS1.00';
            FieldClass = FlowField;
            CalcFormula = Exist("TDS Posting Group" WHERE("GL Account No." = FIELD("No.")));

        }
        field(59001; "Net Change - TDS Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Net Change - TDS Amount';
            Description = 'TDS1.00';
            Editable = false;
            FieldClass = FlowField;

            CalcFormula = Sum("G/L Entry"."TDS Amount" WHERE("G/L Account No." = FIELD("No."),
                                                              "G/L Account No." = FIELD(FILTER(Totaling)),
                                                              "Business Unit Code" = FIELD("Business Unit Filter"),
                                                              "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                             " Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                             " Shortcut Dimension 3 Code" = FIELD("Shortcut Dimension 3 Filter"),
                                                             " Posting Date" = FIELD("Date Filter")));

        }
        field(59002; "TR Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(59003; "LC Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(59005; "Document Class Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70000; "Shortcut Dimension 3 Filter"; Code[20])
        {
            CaptionClass = '1,4,3';
            Caption = 'Shortcut Dimension 3 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(80000; "LC Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Margin,Charge,Document Value,TR Loan';
            OptionMembers = " ",Margin,Charge,"Document Value","TR Loan";
        }
    }
}

