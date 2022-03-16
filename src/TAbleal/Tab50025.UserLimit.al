table 50025 "User Limit"
{
    DataPerCompany = false;

    fields
    {
        field(1; "Instance ID"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnLookup()
            var
                ServerInstanceList: Page "Server Instance List";
                ServerInstance: Record "Server Instance";
            begin
                ServerInstanceList.SETRECORD(ServerInstance);
                ServerInstance.RESET;
                ServerInstanceList.LOOKUPMODE := TRUE;
                IF ServerInstanceList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    ServerInstanceList.GETRECORD(ServerInstance);
                    "Instance ID" := ServerInstance."Server Instance ID";
                    "Instance Name" := ServerInstance."Server Instance Name";
                END;
            end;
        }
        field(2; "Instance Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "User Limit"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Instance ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

