table 50003 "Template Security"
{
    DrillDownPageID = 50005;
    LookupPageID = 50005;

    fields
    {
        field(1; "Table Name"; Option)
        {
            OptionCaption = 'General Journal,FA Journal,FA Reclass Journal,Insurance Journal,Item Journal,Recurring General Journal,Recurring FA Journal';
            OptionMembers = "General Journal","FA Journal","FA Reclass Journal","Insurance Journal","Item Journal","Recurring General Journal","Recurring FA Journal";
        }
        field(2; "Template Name"; Code[20])
        {
            TableRelation = IF ("Table Name" = CONST("General Journal")) "Gen. Journal Template"
            ELSE
            IF ("Table Name" = CONST("FA Journal")) "FA Journal Template"
            ELSE
            IF ("Table Name" = CONST("FA Reclass Journal")) "FA Reclass. Journal Template"
            ELSE
            IF ("Table Name" = CONST("Insurance Journal")) "Insurance Journal Template"
            ELSE
            IF ("Table Name" = CONST("Item Journal")) "Item Journal Template"
            ELSE
            IF ("Table Name" = CONST("Recurring General Journal")) "Gen. Journal Template" WHERE(Recurring = CONST(true))
            ELSE
            IF ("Table Name" = CONST("Recurring FA Journal")) "FA Journal Template" WHERE(Recurring = CONST(true));
        }
        field(3; "Batch Name"; Code[20])
        {
            TableRelation = IF ("Table Name" = CONST("General Journal")) "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Template Name"))
            ELSE
            IF ("Table Name" = CONST("FA Journal")) "FA Journal Batch".Name WHERE("Journal Template Name" = FIELD("Template Name"))
            ELSE
            IF ("Table Name" = CONST("FA Reclass Journal")) "FA Reclass. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Template Name"))
            ELSE
            IF ("Table Name" = CONST("Insurance Journal")) "Insurance Journal Batch".Name WHERE("Journal Template Name" = FIELD("Template Name"))
            ELSE
            IF ("Table Name" = CONST("Item Journal")) "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Template Name"))
            ELSE
            IF ("Table Name" = CONST("Recurring General Journal")) "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Template Name"))
            ELSE
            IF ("Table Name" = CONST("Recurring FA Journal")) "FA Journal Batch".Name WHERE("Journal Template Name" = FIELD("Template Name"));
        }
        field(4; "User ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(5; "Branch Code"; Code[10])
        {
        }
        field(6; Posting; Boolean)
        {
        }
        field(7; "Authorised Limit"; Decimal)
        {
        }
        field(8; "Template Type"; Option)
        {
            CalcFormula = Lookup("Gen. Journal Template".Type WHERE(Name = FIELD("Template Name")));
            Caption = 'Template Type';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'General,Sales,Purchases,Cash Receipts,Payments,Assets,Intercompany,Jobs';
            OptionMembers = General,Sales,Purchases,"Cash Receipts",Payments,Assets,Intercompany,Jobs;
        }
    }

    keys
    {
        key(Key1; "Table Name", "Template Name", "Batch Name", "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

