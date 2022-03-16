codeunit 50050 "ApplicationManagement"
{

    trigger OnRun()
    begin
    end;

    var
        DebuggerManagement: Codeunit "Debugger Management";
        LogInManagement: Codeunit LogInManagement;
        TextManagement: Codeunit TextManagement;
        CaptionManagement: Codeunit CaptionManagement;
        LanguageManagement: Codeunit "43";
        AutoFormatManagement: Codeunit "45";
        purch: Codeunit purchp
        NotSupportedErr: Label 'The value is not supported.';

    procedure CompanyOpen()
    var
        LogonManagement: Codeunit "9802";
    begin
        LogonManagement.SetLogonInProgress(TRUE);

        // This needs to be the very first thing to run before company open
        CODEUNIT.RUN(CODEUNIT::"Azure AD User Management");

        OnBeforeCompanyOpen;
        LogInManagement.CompanyOpen;
        OnAfterCompanyOpen;
        LogonManagement.SetLogonInProgress(FALSE);
        LimitUserSession; //SRT
    end;

    procedure GetSystemIndicator(var Text: Text[250]; var Style: Option Standard,Accent1,Accent2,Accent3,Accent4,Accent5,Accent6,Accent7,Accent8,Accent9)
    var
        CompanyInformation: Record "79";
    begin
        IF CompanyInformation.GET THEN
            CompanyInformation.GetSystemIndicator(Text, Style);
        OnAfterGetSystemIndicator(Text, Style);
    end;

    procedure CompanyClose()
    begin
        OnBeforeCompanyClose;
        LogInManagement.CompanyClose;
        OnAfterCompanyClose;
    end;

    procedure FindPrinter(ReportID: Integer): Text[250]
    var
        PrinterSelection: Record "78";
        PrinterName: Text[250];
    begin
        CLEAR(PrinterSelection);

        IF PrinterSelection.READPERMISSION THEN
            IF NOT PrinterSelection.GET(USERID, ReportID) THEN
                IF NOT PrinterSelection.GET('', ReportID) THEN
                    IF NOT PrinterSelection.GET(USERID, 0) THEN
                        IF PrinterSelection.GET('', 0) THEN;
        PrinterName := PrinterSelection."Printer Name";
        OnAfterFindPrinter(ReportID, PrinterName);
        EXIT(PrinterName);
    end;

    procedure ApplicationVersion(): Text[248]
    var
        AppVersion: Text[248];
    begin
        AppVersion := CustomApplicationVersion('W1 11.0');
        OnAfterGetApplicationVersion(AppVersion);
        EXIT(AppVersion);
    end;

    local procedure CustomApplicationVersion(BaseBuildVersion: Text[80]): Text[80]
    begin
        EXIT(BaseBuildVersion);
    end;

    procedure ApplicationBuild(): Text[80]
    begin
        // Must ever only be the build number of the server building the app.
        EXIT(CustomApplicationBuild('29745'));
    end;

    local procedure CustomApplicationBuild(BaseBuildNumber: Text[80]): Text[80]
    begin
        EXIT(BaseBuildNumber);
    end;

    procedure ApplicationLanguage(): Integer
    begin
        EXIT(1033);
    end;

    [Scope('Internal')]
    procedure DefaultRoleCenter(): Integer
    var
        ConfPersMgt: Codeunit "9170";
        AzureADUserManagement: Codeunit "9010";
        PermissionManager: Codeunit "9002";
        DefaultRoleCenterID: Integer;
    begin
        IF PermissionManager.SoftwareAsAService THEN
            IF AzureADUserManagement.TryGetAzureUserPlanRoleCenterId(DefaultRoleCenterID, USERSECURITYID) THEN;

        IF DefaultRoleCenterID = 0 THEN
            DefaultRoleCenterID := ConfPersMgt.DefaultRoleCenterID;

        OnAfterGetDefaultRoleCenter(DefaultRoleCenterID);
        EXIT(DefaultRoleCenterID);
    end;

    procedure MakeDateTimeText(var DateTimeText: Text[250]): Integer
    begin
        EXIT(TextManagement.MakeDateTimeText(DateTimeText));
    end;

    procedure GetSeparateDateTime(DateTimeText: Text[250]; var Date: Date; var Time: Time): Boolean
    begin
        EXIT(TextManagement.GetSeparateDateTime(DateTimeText, Date, Time));
    end;

    procedure MakeDateText(var DateText: Text[250]): Integer
    var
        Position: Integer;
    begin
        Position := TextManagement.MakeDateText(DateText);
        OnAfterMakeDateText(Position, DateText);
        EXIT(Position);
    end;

    procedure MakeTimeText(var TimeText: Text[250]): Integer
    var
        Position: Integer;
    begin
        Position := TextManagement.MakeTimeText(TimeText);
        OnAfterMakeTimeText(Position, TimeText);
        EXIT(Position);
    end;

    procedure MakeText(var Text: Text[250]): Integer
    var
        Position: Integer;
    begin
        Position := TextManagement.MakeText(Text);
        OnAfterMakeText(Position, Text);
        EXIT(Position);
    end;

    procedure MakeDateTimeFilter(var DateTimeFilterText: Text[250]): Integer
    var
        Position: Integer;
    begin
        Position := TextManagement.MakeDateTimeFilter(DateTimeFilterText);
        OnAfterMakeDateTimeFilter(Position, DateTimeFilterText);
        EXIT(Position);
    end;

    procedure MakeDateFilter(var DateFilterText: Text): Integer
    var
        Position: Integer;
    begin
        Position := TextManagement.MakeDateFilter(DateFilterText);
        OnAfterMakeDateFilter(Position, DateFilterText);
        EXIT(Position);
    end;

    [Scope('Internal')]
    procedure MakeTextFilter(var TextFilterText: Text): Integer
    var
        Position: Integer;
    begin
        Position := TextManagement.MakeTextFilter(TextFilterText);
        OnAfterMakeTextFilter(Position, TextFilterText);
        EXIT(Position);
    end;

    [Scope('Internal')]
    procedure MakeCodeFilter(var TextFilterText: Text): Integer
    var
        Position: Integer;
    begin
        Position := TextManagement.MakeTextFilter(TextFilterText);
        OnAfterMakeCodeFilter(Position, TextFilterText);
        EXIT(Position);
    end;

    procedure MakeTimeFilter(var TimeFilterText: Text[250]): Integer
    var
        Position: Integer;
    begin
        Position := TextManagement.MakeTimeFilter(TimeFilterText);
        OnAfterMakeTimeFilter(Position, TimeFilterText);
        EXIT(Position);
    end;

    procedure AutoFormatTranslate(AutoFormatType: Integer; AutoFormatExpr: Text[80]): Text[80]
    var
        AutoFormatTranslation: Text[80];
    begin
        AutoFormatTranslation := AutoFormatManagement.AutoFormatTranslate(AutoFormatType, AutoFormatExpr);
        OnAfterAutoFormatTranslate(AutoFormatType, AutoFormatExpr, AutoFormatTranslation);
        EXIT(AutoFormatTranslation);
    end;

    procedure ReadRounding(): Decimal
    begin
        EXIT(AutoFormatManagement.ReadRounding);
    end;

    procedure CaptionClassTranslate(Language: Integer; CaptionExpr: Text[1024]): Text[1024]
    var
        Caption: Text[1024];
    begin
        //Caption := CaptionManagement.CaptionClassTranslate(Language,CaptionExpr);
        OnAfterCaptionClassTranslate(Language, CaptionExpr, Caption);
        EXIT(Caption);
    end;

    procedure GetCueStyle(TableId: Integer; FieldNo: Integer; CueValue: Decimal): Text
    var
        CueSetup: Codeunit "9701";
    begin
        EXIT(CueSetup.GetCustomizedCueStyle(TableId, FieldNo, CueValue));
    end;

    [Scope('Internal')]
    procedure SetGlobalLanguage()
    begin
        LanguageManagement.SetGlobalLanguage;
    end;

    [Scope('Internal')]
    procedure ValidateApplicationlLanguage(LanguageID: Integer)
    begin
        LanguageManagement.ValidateApplicationLanguage(LanguageID);
    end;

    [Scope('Internal')]
    procedure LookupApplicationlLanguage(var LanguageID: Integer)
    begin
        LanguageManagement.LookupApplicationLanguage(LanguageID);
    end;

    procedure GetGlobalTableTriggerMask(TableID: Integer): Integer
    var
        TableTriggerMask: Integer;
    begin
        // Replaced by GetDatabaseTableTriggerSetup
        OnAfterGetGlobalTableTriggerMask(TableID, TableTriggerMask);
        EXIT(TableTriggerMask);
    end;

    procedure OnGlobalInsert(RecRef: RecordRef)
    begin
        // Replaced by OnDataBaseInsert. This trigger is only called from pages.
        OnAfterOnGlobalInsert(RecRef);
    end;

    procedure OnGlobalModify(RecRef: RecordRef; xRecRef: RecordRef)
    begin
        // Replaced by OnDataBaseModify. This trigger is only called from pages.
        OnAfterOnGlobalModify(RecRef, xRecRef);
    end;

    procedure OnGlobalDelete(RecRef: RecordRef)
    begin
        // Replaced by OnDataBaseDelete. This trigger is only called from pages.
        OnAfterOnGlobalDelete(RecRef);
    end;

    procedure OnGlobalRename(RecRef: RecordRef; xRecRef: RecordRef)
    begin
        // Replaced by OnDataBaseRename. This trigger is only called from pages.
        OnAfterOnGlobalRename(RecRef, xRecRef);
    end;

    [Scope('Internal')]
    procedure GetDatabaseTableTriggerSetup(TableId: Integer; var OnDatabaseInsert: Boolean; var OnDatabaseModify: Boolean; var OnDatabaseDelete: Boolean; var OnDatabaseRename: Boolean)
    var
        IntegrationManagement: Codeunit "5150";
        ChangeLogMgt: Codeunit "423";
    begin
        ChangeLogMgt.GetDatabaseTableTriggerSetup(TableId, OnDatabaseInsert, OnDatabaseModify, OnDatabaseDelete, OnDatabaseRename);
        IntegrationManagement.GetDatabaseTableTriggerSetup(TableId, OnDatabaseInsert, OnDatabaseModify, OnDatabaseDelete, OnDatabaseRename);
        OnAfterGetDatabaseTableTriggerSetup(TableId, OnDatabaseInsert, OnDatabaseModify, OnDatabaseDelete, OnDatabaseRename);
    end;

    [Scope('Internal')]
    procedure OnDatabaseInsert(RecRef: RecordRef)
    var
        IntegrationManagement: Codeunit "5150";
        ChangeLogMgt: Codeunit "423";
    begin
        OnBeforeOnDatabaseInsert(RecRef);
        ChangeLogMgt.LogInsertion(RecRef);
        IntegrationManagement.OnDatabaseInsert(RecRef);
        OnAfterOnDatabaseInsert(RecRef);
    end;

    [Scope('Internal')]
    procedure OnDatabaseModify(RecRef: RecordRef)
    var
        IntegrationManagement: Codeunit "5150";
        ChangeLogMgt: Codeunit "423";
    begin
        OnBeforeOnDatabaseModify(RecRef);
        ChangeLogMgt.LogModification(RecRef);
        IntegrationManagement.OnDatabaseModify(RecRef);
        OnAfterOnDatabaseModify(RecRef);
    end;

    [Scope('Internal')]
    procedure OnDatabaseDelete(RecRef: RecordRef)
    var
        IntegrationManagement: Codeunit "5150";
        ChangeLogMgt: Codeunit "423";
    begin
        OnBeforeOnDatabaseDelete(RecRef);
        ChangeLogMgt.LogDeletion(RecRef);
        IntegrationManagement.OnDatabaseDelete(RecRef);
        OnAfterOnDatabaseDelete(RecRef);
    end;

    [Scope('Internal')]
    procedure OnDatabaseRename(RecRef: RecordRef; xRecRef: RecordRef)
    var
        IntegrationManagement: Codeunit "5150";
        ChangeLogMgt: Codeunit "423";
    begin
        OnBeforeOnDatabaseRename(RecRef, xRecRef);
        ChangeLogMgt.LogRename(RecRef, xRecRef);
        IntegrationManagement.OnDatabaseRename(RecRef, xRecRef);
        OnAfterOnDatabaseRename(RecRef, xRecRef);
    end;

    [Scope('Internal')]
    procedure OnDebuggerBreak(ErrorMessage: Text)
    begin
        //DebuggerManagement.ProcessDebuggerBreak(ErrorMessage);
    end;

    procedure LaunchDebugger()
    begin
        PAGE.RUN(PAGE::"Session List");
    end;

    procedure OpenSettings()
    begin
        PAGE.RUN(PAGE::"My Settings");
    end;

    procedure OpenContactMSSales()
    begin
        PAGE.RUN(PAGE::"Contact MS Sales");
    end;

    procedure InvokeExtensionInstallation(AppId: Text; ResponseUrl: Text)
    var
        ExtensionMarketplaceMgmt: Codeunit "2501";
    begin
        IF NOT ExtensionMarketplaceMgmt.InstallExtension(AppId, ResponseUrl) THEN
            MESSAGE(GETLASTERRORTEXT);
    end;

    [Scope('Internal')]
    procedure CustomizeChart(var TempChart: Record "2000000078" temporary): Boolean
    var
        GenericChartMgt: Codeunit "9180";
    begin
        EXIT(GenericChartMgt.ChartCustomization(TempChart));
    end;

    procedure HasCustomLayout(ObjectType: Option "Report","Page"; ObjectID: Integer): Integer
    var
        ReportLayoutSelection: Record "9651";
    begin
        // Return value:
        // 0: No custom layout
        // 1: RDLC layout
        // 2: Word layout
        IF ObjectType <> ObjectType::Report THEN
            ERROR(NotSupportedErr);

        EXIT(ReportLayoutSelection.HasCustomLayout(ObjectID));
    end;

    [Scope('Internal')]
    procedure MergeDocument(ObjectType: Option "Report","Page"; ObjectID: Integer; ReportAction: Option SaveAsPdf,SaveAsWord,SaveAsExcel,Preview,Print,SaveAsHtml; XmlData: InStream; FileName: Text)
    var
        DocumentReportMgt: Codeunit "9651";
    begin
        IF ObjectType <> ObjectType::Report THEN
            ERROR(NotSupportedErr);

        DocumentReportMgt.MergeWordLayout(ObjectID, ReportAction, XmlData, FileName);
    end;

    [Scope('Internal')]
    procedure ReportGetCustomRdlc(ReportId: Integer): Text
    var
        CustomReportLayout: Record "9650";
    begin
        EXIT(CustomReportLayout.GetCustomRdlc(ReportId));
    end;

    procedure ReportScheduler(ReportId: Integer; RequestPageXml: Text): Boolean
    var
        ScheduleAReport: Page "682";
    begin
        EXIT(ScheduleAReport.ScheduleAReport(ReportId, RequestPageXml));
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetApplicationVersion(var AppVersion: Text[248])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCompanyOpen()
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCompanyOpen()
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCompanyClose()
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCompanyClose()
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetSystemIndicator(var Text: Text[250]; var Style: Option Standard,Accent1,Accent2,Accent3,Accent4,Accent5,Accent6,Accent7,Accent8,Accent9)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFindPrinter(ReportID: Integer; var PrinterName: Text[250])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetDefaultRoleCenter(var DefaultRoleCenterID: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterMakeDateText(var Position: Integer; var DateText: Text[250])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterMakeTimeText(var Position: Integer; var TimeText: Text[250])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterMakeText(var Position: Integer; var Text: Text[250])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterMakeDateTimeFilter(var Position: Integer; var DateTimeFilterText: Text[250])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterMakeDateFilter(var Position: Integer; var DateFilterText: Text)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterMakeTextFilter(var Position: Integer; var TextFilterText: Text)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterMakeCodeFilter(var Position: Integer; var TextFilterText: Text)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterMakeTimeFilter(var Position: Integer; var TimeFilterText: Text[250])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterAutoFormatTranslate(AutoFormatType: Integer; AutoFormatExpression: Text[80]; var AutoFormatTranslation: Text[80])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCaptionClassTranslate(Language: Integer; CaptionExpression: Text[1024]; var Caption: Text[1024])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetGlobalTableTriggerMask(TableID: Integer; var TableTriggerMask: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnGlobalInsert(RecRef: RecordRef)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnGlobalModify(RecRef: RecordRef; xRecRef: RecordRef)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnGlobalDelete(RecRef: RecordRef)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnGlobalRename(RecRef: RecordRef; xRecRef: RecordRef)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetDatabaseTableTriggerSetup(TableId: Integer; var OnDatabaseInsert: Boolean; var OnDatabaseModify: Boolean; var OnDatabaseDelete: Boolean; var OnDatabaseRename: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnDatabaseInsert(RecRef: RecordRef)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnDatabaseModify(RecRef: RecordRef)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnDatabaseDelete(RecRef: RecordRef)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnDatabaseRename(RecRef: RecordRef; xRecRef: RecordRef)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnDatabaseInsert(RecRef: RecordRef)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnDatabaseModify(RecRef: RecordRef)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnDatabaseDelete(RecRef: RecordRef)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnDatabaseRename(RecRef: RecordRef; xRecRef: RecordRef)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnEditInExcel(ServiceName: Text[240]; ODataFilter: Text)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnInstallAppPerDatabase()
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnInstallAppPerCompany()
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCheckPreconditionsPerDatabase()
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCheckPreconditionsPerCompany()
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnUpgradePerDatabase()
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnUpgradePerCompany()
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnValidateUpgradePerDatabase()
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnValidateUpgradePerCompany()
    begin
    end;

    local procedure BindCustomization()
    var
        IRDMgt: Codeunit "50000";
        IRDEngine: Codeunit "50001";
    begin
        IRDMgt.Binding;
        IRDEngine.Binding;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1, 'OnAfterGetDatabaseTableTriggerSetup', '', false, false)]
    local procedure BindOnAfterGetDatabaseTableTriggerSetup(TableId: Integer; var OnDatabaseInsert: Boolean; var OnDatabaseModify: Boolean; var OnDatabaseDelete: Boolean; var OnDatabaseRename: Boolean)
    begin
        BindCustomization;
    end;

    local procedure "--SRT--"()
    begin
    end;

    local procedure LimitUserSession()
    var
        ActiveSession: Record "2000000110";
        TotalSession: Integer;
        LastUser: Text;
        UserLimit: Record "50025";
        ActiveSession2: Record "2000000110";
        UserSetup: Record "91";
        UserRec: Record "2000000120";
    begin
        ActiveSession2.RESET;
        ActiveSession2.SETRANGE("Session ID", SESSIONID);
        ActiveSession2.SETRANGE("Server Instance ID", SERVICEINSTANCEID);
        IF ActiveSession2.FINDFIRST THEN;

        IF IsUserLimited(USERID) THEN BEGIN
            EXIT;
        END;


        /*IF UserSetup.GET(USERID) THEN
          IF UserSetup."Instance Name" <> '' THEN
            IF STRPOS(UserSetup."Instance Name" ,  ActiveSession2."Server Instance Name") = 0 THEN
              ERROR('Invalid instance login. Please contact administrator.');*/

        UserLimit.RESET;
        UserLimit.SETRANGE("Instance Name", ActiveSession2."Server Instance Name");
        IF UserLimit.FINDFIRST THEN BEGIN
            ActiveSession.RESET;
            ActiveSession.SETCURRENTKEY("User ID");
            ActiveSession.SETFILTER("Client Type", '%1|%2|%3|%4', ActiveSession."Client Type"::Desktop, ActiveSession."Client Type"::"Windows Client",
                                ActiveSession."Client Type"::Phone, ActiveSession."Client Type"::Tablet);

            ActiveSession.SETRANGE("Server Instance Name", ActiveSession2."Server Instance Name");
            ActiveSession.SETFILTER("Session ID", '<>%1', SESSIONID);
            LastUser := '';
            TotalSession := 1;
            IF ActiveSession.FINDFIRST THEN
                REPEAT

                    IF NOT IsUserLimited(ActiveSession."User ID") THEN BEGIN
                        IF LastUser <> ActiveSession."User ID" THEN BEGIN
                            LastUser := ActiveSession."User ID";
                            TotalSession += 1;
                            IF ActiveSession."User ID" = USERID THEN
                                EXIT;
                        END;
                    END;
                UNTIL ActiveSession.NEXT = 0;
            /* MESSAGE('User id = %1\server instace = %2 - %3\ Total session = %4',
                      USERID, SERVICEINSTANCEID, ActiveSession."Server Instance Name", TotalSession);
           */
            //MESSAGE('Total %1 , Limited = %2', TotalSession , UserLimit."User Limit");

            IF TotalSession > UserLimit."User Limit" THEN
                ERROR('License limit reached.');
        END;
        //ERROR('limit full.');
        //STOPSESSION(SESSIONID);

    end;

    local procedure IsUserLimited(_UserId: Code[50]): Boolean
    var
        UserRec: Record "2000000120";
    begin
        UserRec.RESET;
        UserRec.SETRANGE("User Name", _UserId);
        UserRec.SETFILTER("License Type", '%1|%2', UserRec."License Type"::"Limited User", UserRec."License Type"::"External User");
        IF UserRec.FINDFIRST THEN
            EXIT(TRUE);
        EXIT(FALSE);
    end;
}

