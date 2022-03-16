page 50019 "API Web Service"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Api Web Service";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Object Type"; "Object Type")
                {
                }
                field("Object ID"; "Object ID")
                {
                }
                field("Service Name"; "Service Name")
                {
                }
                field(Published; Published)
                {
                }
                field("API URL"; APIURL)
                {
                    ExtendedDatatype = URL;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        APIURL := 'http://' + ActiveSession."Server Computer Name" +
                  ':' + FORMAT(CompanyInfo."ODATA Port") +
                  '/' + ActiveSession."Server Instance Name" +
                  '/api/beta/' + "Service Name";
    end;

    trigger OnOpenPage()
    begin
        CompanyInfo.GET;
        CompanyInfo.TESTFIELD("ODATA Port");
        ActiveSession.GET(SERVICEINSTANCEID, SESSIONID);
    end;

    var
        APIURL: Text;
        CompanyInfo: Record "Company Information";
        ActiveSession: Record "Active Session";
}

