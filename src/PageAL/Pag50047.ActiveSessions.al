page 50047 "Active Sessions"
{
    Caption = 'Active Sessions';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Session,SQL Trace,Events';
    RefreshOnActivate = true;
    SourceTable = "Active Session";

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
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;
                    Caption = 'User ID';
                    Editable = false;
                    ToolTip = 'Specifies the user name of the user who is logged on to the active session.';
                }
                field(IsSQLTracing; IsSQLTracing)
                {
                    ApplicationArea = All;
                    Caption = 'SQL Tracing';
                    Editable = IsRowSessionActive;
                    ToolTip = 'Specifies if SQL tracing is enabled.';
                }
                field("Client Type"; ClientTypeText)
                {
                    ApplicationArea = All;
                    Caption = 'Client Type';
                    Editable = false;
                    ToolTip = 'Specifies the client type on which the session event occurred, such as Web Service and Client Service . ';
                }
                field("Login Datetime"; "Login Datetime")
                {
                    ApplicationArea = All;
                    Caption = 'Login Date';
                    Editable = false;
                    ToolTip = 'Specifies the date and time that the session started on the Dynamics NAV Server instance.';
                }
                field("Server Computer Name"; "Server Computer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Server Computer Name';
                    Editable = false;
                    ToolTip = 'Specifies the fully qualified domain name (FQDN) of the computer on which the Dynamics NAV Server instance runs.';
                }
                field("Server Instance Name"; "Server Instance Name")
                {
                    ApplicationArea = All;
                    Caption = 'Server Instance Name';
                    Editable = false;
                    ToolTip = 'Specifies the name of the Dynamics NAV Server instance to which the session is connected. The server instance name comes from the Session Event table.';
                }
                field(IsDebugging; IsDebugging)
                {
                    ApplicationArea = All;
                    Caption = 'Debugging';
                    Editable = false;
                    ToolTip = 'Specifies sessions that are being debugged.';
                }
                field(IsDebugged; IsDebugged)
                {
                    ApplicationArea = All;
                    Caption = 'Debugged';
                    Editable = false;
                    ToolTip = 'Specifies debugged sessions.';
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
                    var
                        ActiveSession: Record "Active Session";
                    begin
                        IF CONFIRM('Do you want to Kill the user session?') THEN BEGIN
                            //STOPSESSION("Session ID");
                            ActiveSession.RESET;
                            ActiveSession.SETRANGE("Session Unique ID", "Session Unique ID");
                            IF ActiveSession.FINDFIRST THEN
                                ActiveSession.DELETE;
                        END;
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
        IF "Session ID" = 0 THEN BEGIN
            SessionIdText := '';
            ClientTypeText := '';
        END ELSE BEGIN
            SessionIdText := FORMAT("Session ID");
            ClientTypeText := FORMAT("Client Type");
        END;
    end;

    var
        DebuggerManagement: Codeunit "DebuggerManagement";
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
}

