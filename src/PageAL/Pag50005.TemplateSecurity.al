page 50005 "Template Security"
{
    PageType = List;
    SourceTable = "Template Security";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table Name"; "Table Name")
                {
                }
                field("Template Name"; "Template Name")
                {

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Batch Name"; "Batch Name")
                {
                }
                field("User ID"; "User ID")
                {
                }
                field("Branch Code"; "Branch Code")
                {
                }
                field(Posting; Posting)
                {
                }
                field("Authorised Limit"; "Authorised Limit")
                {
                }
                field("Template Type"; "Template Type")
                {
                }
            }
        }
    }

    actions
    {
    }
}

