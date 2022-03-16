page 50024 "FA Custodian Card"
{
    PageType = Card;
    SourceTable = "FA Custodian";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("FA No."; "FA No.")
                {
                }
                field("FA Description"; "FA Description")
                {
                }
                field("Employee No."; "Employee No.")
                {
                    Caption = 'Custodian No.';
                }
                field("Employee Name"; "Employee Name")
                {
                    Caption = 'Custodian Name';
                }
                field("Date of Ownership"; "Date of Ownership")
                {
                }
                field(Location; Location)
                {
                }
                field("New Department Code"; "New Department Code")
                {
                }
                field("New Location Code"; "New Location Code")
                {
                }
                field("Current Owner"; "Current Owner")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Date of Ownership" := TODAY;
    end;
}

