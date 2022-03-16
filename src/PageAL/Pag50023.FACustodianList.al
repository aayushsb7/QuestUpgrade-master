page 50023 "FA Custodian List"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "FA Custodian";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;
                field("FA No."; "FA No.")
                {
                }
                field("Employee No."; "Employee No.")
                {
                }
                field("FA Description"; "FA Description")
                {
                }
                field("Employee Name"; "Employee Name")
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
                field("Date of Ownership"; "Date of Ownership")
                {
                }
                field("Date of Transfer"; "Date of Transfer")
                {
                }
                field("Current Owner"; "Current Owner")
                {
                }
            }
        }
    }

    actions
    {
    }
}

