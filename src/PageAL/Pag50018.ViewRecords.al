page 50018 "View Records"
{
    Editable = false;
    PageType = List;
    SourceTable = Object;
    SourceTableView = WHERE(Type = CONST(Table));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Type)
                {
                }
                field(ID; ID)
                {
                }
                field(Name; Name)
                {
                }
                field(Modified; Modified)
                {
                }
                field(Compiled; Compiled)
                {
                }
                field(Date; Date)
                {
                }
                field(Time; Time)
                {
                }
                field("Version List"; "Version List")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Run")
            {
                Image = "Table";
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    HYPERLINK(GETURL(CLIENTTYPE::Current, COMPANYNAME, OBJECTTYPE::Table, ID));
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        User.RESET;
        User.SETRANGE("User Name", USERID);
        User.FINDFIRST;
        IF NOT AccessControl.GET(User."User Security ID", 'SUPER') THEN
            IF NOT AccessControl.GET(User."User Security ID", 'VIEWRECORDS') THEN     //ZM June 13, 2017
                ERROR('');
    end;

    var
        AccessControl: Record "Access Control";
        User: Record User;
}

