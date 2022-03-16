page 50051 "User Limit Setup"
{
    PageType = List;
    SourceTable = "User Limit";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Instance ID"; "Instance ID")
                {
                }
                field("Instance Name"; "Instance Name")
                {
                }
                field("User Limit"; "User Limit")
                {
                }
            }
        }
    }

    actions
    {
    }
}

