page 50020 "License Range"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Permission Range";
    SourceTableView = WHERE(From = FILTER(>= 50000));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Object Type"; "Object Type")
                {
                }
                field(Index; Index)
                {
                }
                field(From; From)
                {
                }
                field("To"; "To")
                {
                }
                field("Read Permission"; "Read Permission")
                {
                }
                field("Insert Permission"; "Insert Permission")
                {
                }
                field("Modify Permission"; "Modify Permission")
                {
                }
                field("Delete Permission"; "Delete Permission")
                {
                }
                field("Execute Permission"; "Execute Permission")
                {
                }
                field("Limited Usage Permission"; "Limited Usage Permission")
                {
                }
            }
        }
    }

    actions
    {
    }
}

