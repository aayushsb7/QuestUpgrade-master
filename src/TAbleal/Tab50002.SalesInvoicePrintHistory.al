table 50002 "Sales Invoice Print History"
{
    Caption = 'Sales Invoice Print History';

    fields
    {
        field(1; "Table ID"; Integer)
        {
        }
        field(2; "Document Type"; Option)
        {
            OptionCaption = 'Sales Invoice,Sales Credit Memo';
            OptionMembers = "Sales Invoice","Sales Credit Memo";
        }
        field(3; "Document No."; Code[20])
        {
        }
        field(4; "Fiscal Year"; Text[30])
        {
        }
        field(5; "Line No."; Integer)
        {
        }
        field(22; "Printing Date"; Date)
        {
        }
        field(23; "Printed Time"; Time)
        {
        }
        field(24; "Printed By"; Code[50])
        {
            TableRelation = "User Setup";
            ValidateTableRelation = false;
        }
        field(25; "Times Printed"; Integer)
        {
        }
        field(26; Type; Option)
        {
            OptionCaption = 'Tax Invoice,Invoice,Copy of Original';
            OptionMembers = "Tax Invoice",Invoice,"Copy of Original";
        }
    }

    keys
    {
        key(Key1; "Table ID", "Document Type", "Document No.", "Fiscal Year", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

