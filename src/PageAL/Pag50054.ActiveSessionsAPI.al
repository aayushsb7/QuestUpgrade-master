page 50054 "Active Sessions API"
{
    Caption = 'Active Sessions API';
    DeleteAllowed = true;
    Editable = true;
    EntityName = 'activeSession';
    EntitySetName = 'activeSessions';
    InsertAllowed = true;
    LinksAllowed = false;
    ModifyAllowed = true;
    ODataKeyFields = "Session Unique ID";
    PageType = API;
    DelayedInsert = true;
    PromotedActionCategories = 'New,Process,Report,Session,SQL Trace,Events';
    RefreshOnActivate = true;
    SourceTable = "Active Session";
    SourceTableView = WHERE("Client Type" = CONST("Windows Client"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(SessionIdText; SessionIdText)
                {
                    ApplicationArea = All;
                    Caption = 'Session ID';
                    Editable = false;
                    ToolTip = 'Specifies the session in the list.';
                }
                field(sessionID; "Session ID")
                {
                    Caption = 'sessionID';
                }
                field(userID; "User ID")
                {
                    ApplicationArea = All;
                    Caption = 'User ID';
                    Editable = false;
                    ToolTip = 'Specifies the user name of the user who is logged on to the active session.';
                }
                field(clientType; ClientTypeText)
                {
                    ApplicationArea = All;
                    Caption = 'Client Type';
                    Editable = false;
                    ToolTip = 'Specifies the client type on which the session event occurred, such as Web Service and Client Service . ';
                }
                field(loginDateTime; "Login Datetime")
                {
                    ApplicationArea = All;
                    Caption = 'Login Date';
                    Editable = false;
                    ToolTip = 'Specifies the date and time that the session started on the Dynamics NAV Server instance.';
                }
                field(serverComputeName; "Server Computer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Server Computer Name';
                    Editable = false;
                    ToolTip = 'Specifies the fully qualified domain name (FQDN) of the computer on which the Dynamics NAV Server instance runs.';
                }
                field(serverInstanceName; "Server Instance Name")
                {
                    ApplicationArea = All;
                    Caption = 'Server Instance Name';
                    Editable = false;
                    ToolTip = 'Specifies the name of the Dynamics NAV Server instance to which the session is connected. The server instance name comes from the Session Event table.';
                }
                field(sessionuniqueId; "Session Unique ID")
                {
                    Caption = 'sessionuniqueId';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            // separator()
            // {
            // }
            group(Session)
            {
                Caption = 'Session';
                action("Debug Selected Session")
                {
                    ApplicationArea = All;
                    Caption = 'Debug';
                    Enabled = CanDebugSelectedSession;
                    Image = Debug;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+Ctrl+S';
                    ToolTip = 'Debug the selected session';

                    trigger OnAction()
                    begin
                        DebuggerManagement.SetDebuggedSession(Rec);
                        DebuggerManagement.OpenDebuggerTaskPage;
                    end;
                }
                action("Debug Next Session")
                {
                    ApplicationArea = All;
                    Caption = 'Debug Next';
                    Enabled = CanDebugNextSession;
                    Image = DebugNext;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+Ctrl+N';
                    ToolTip = 'Debug the next session that breaks code execution.';

                    trigger OnAction()
                    var
                        DebuggedSessionTemp: Record "Active Session";
                    begin
                        DebuggedSessionTemp."Session ID" := 0;
                        DebuggerManagement.SetDebuggedSession(DebuggedSessionTemp);
                        DebuggerManagement.OpenDebuggerTaskPage;
                    end;
                }
                action("Kill Session")
                {
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        STOPSESSION("Session ID");
                    end;
                }
            }
            group("SQL Trace")
            {
                Caption = 'SQL Trace';
                action("Start Full SQL Tracing")
                {
                    ApplicationArea = All;
                    Caption = 'Start Full SQL Tracing';
                    Enabled = NOT FullSQLTracingStarted;
                    Image = Continue;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTip = 'Start SQL tracing.';

                    trigger OnAction()
                    begin
                        DEBUGGER.ENABLESQLTRACE(0, TRUE);
                        FullSQLTracingStarted := TRUE;
                    end;
                }
                action("Stop Full SQL Tracing")
                {
                    ApplicationArea = All;
                    Caption = 'Stop Full SQL Tracing';
                    Enabled = FullSQLTracingStarted;
                    Image = Stop;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTip = 'Stop the current SQL tracing.';

                    trigger OnAction()
                    begin
                        DEBUGGER.ENABLESQLTRACE(0, FALSE);
                        FullSQLTracingStarted := FALSE;
                    end;
                }
            }
            group("Event")
            {
                Caption = 'Event';
                action(Subscriptions)
                {
                    ApplicationArea = All;
                    Caption = 'Subscriptions';
                    Image = "Event";
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page 9510;
                    ToolTip = 'Show event subscriptions.';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        /*IsDebugging := DEBUGGER.ISACTIVE AND ("Session ID" = DEBUGGER.DEBUGGINGSESSIONID);
        IsDebugged := DEBUGGER.ISATTACHED AND ("Session ID" = DEBUGGER.DEBUGGEDSESSIONID);
        IsSQLTracing := DEBUGGER.ENABLESQLTRACE("Session ID");
        IsRowSessionActive := ISSESSIONACTIVE("Session ID");*/

        // If this is the empty row, clear the Session ID and Client Type
        IF "Session ID" = 0 THEN BEGIN
            SessionIdText := '';
            ClientTypeText := '';
        END ELSE BEGIN
            SessionIdText := FORMAT("Session ID");
            ClientTypeText := FORMAT("Client Type");
        END;

    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        /*CanDebugNextSession := NOT DEBUGGER.ISACTIVE;
        CanDebugSelectedSession := NOT DEBUGGER.ISATTACHED AND NOT ISEMPTY;*/

        // If the session list is empty, insert an empty row to carry the button state to the client
        IF NOT FIND(Which) THEN BEGIN
            INIT;
            "Session ID" := 0;
        END;

        EXIT(TRUE);

    end;

    trigger OnOpenPage()
    begin
        /*FILTERGROUP(2);
        SETFILTER("Server Instance ID",'=%1',SERVICEINSTANCEID);
        SETFILTER("Session ID",'<>%1',SESSIONID);
        FILTERGROUP(0);
        
        FullSQLTracingStarted := DEBUGGER.ENABLESQLTRACE(0);*/

    end;

    var
        DebuggerManagement: Codeunit "Debugger Management";
        [InDataSet]
        CanDebugNextSession: Boolean;
        [InDataSet]
        CanDebugSelectedSession: Boolean;
        [InDataSet]
        FullSQLTracingStarted: Boolean;
        IsDebugging: Boolean;
        IsDebugged: Boolean;
        IsSQLTracing: Boolean;
        IsRowSessionActive: Boolean;
        SessionIdText: Text;
        ClientTypeText: Text;

    [TryFunction]
    [ServiceEnabled]
    procedure KillSession(SessionID: Code[250])
    var
        ActiveSession: Record "Active Session";
    begin
        ActiveSession.RESET;
        ActiveSession.SETRANGE("Session Unique ID", SessionID);
        IF ActiveSession.FINDFIRST THEN
            //STOPSESSION(SessionEvent."Session ID");
            ActiveSession.DELETE(TRUE);
    end;
}

