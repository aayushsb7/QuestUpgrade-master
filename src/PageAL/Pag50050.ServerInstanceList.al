page 50050 "Server Instance List"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Server Instance";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Server Instance ID"; "Server Instance ID")
                {
                }
                field("Service Name"; "Service Name")
                {
                }
                field("Server Computer Name"; "Server Computer Name")
                {
                }
                field("Last Active"; "Last Active")
                {
                    Visible = false;
                }
                field("Server Instance Name"; "Server Instance Name")
                {
                }
                field("Server Port"; "Server Port")
                {
                }
                field("Management Port"; "Management Port")
                {
                }
                field(Status; Status)
                {
                }
                field("Last Tenant Config Version"; "Last Tenant Config Version")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

