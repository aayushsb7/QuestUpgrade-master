tableextension 50027 "Purchase Header" extends "Purchase Header"
{
    fields
    {

        //Unsupported feature: Property Modification (Editable) on ""Vendor Posting Group"(Field 31)".


        //Unsupported feature: Code Modification on ""Buy-from Vendor No."(Field 2).OnValidate".

        //trigger "(Field 2)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "No." = '' THEN
          InitRecord;
        TestStatusOpen;
        IF ("Buy-from Vendor No." <> xRec."Buy-from Vendor No.") AND
           (xRec."Buy-from Vendor No." <> '')
        #6..91

        IF (xRec."Buy-from Vendor No." <> '') AND (xRec."Buy-from Vendor No." <> "Buy-from Vendor No.") THEN
          RecallModifyAddressNotification(GetModifyVendorAddressNotificationId);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF "No." = '' THEN BEGIN
          CompanyInfo.GET;
          IF NOT CompanyInfo."Activate Local Resp. Center" THEN
            InitRecord
          ELSE
            InitRecordUsingRespCenter;
        END;

        TESTFIELD(Status,Status::Open);
        #3..94
        */
        //end;


        //Unsupported feature: Code Modification on ""Pay-to Vendor No."(Field 4).OnValidate".

        //trigger "(Field 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        IF (xRec."Pay-to Vendor No." <> "Pay-to Vendor No.") AND
           (xRec."Pay-to Vendor No." <> '')
        #4..64
            TESTFIELD("Currency Code",xRec."Currency Code");
        END;

        CreateDim(
          DATABASE::Vendor,"Pay-to Vendor No.",
          DATABASE::"Salesperson/Purchaser","Purchaser Code",
          DATABASE::Campaign,"Campaign No.",
          DATABASE::"Responsibility Center","Responsibility Center");

        OnValidatePaytoVendorNoBeforeRecreateLines(Rec,CurrFieldNo);

        #76..84

        IF (xRec."Pay-to Vendor No." <> '') AND (xRec."Pay-to Vendor No." <> "Pay-to Vendor No.") THEN
          RecallModifyAddressNotification(GetModifyPayToVendorAddressNotificationId);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..67
        CompanyInfo.GET;
        IF NOT CompanyInfo."Activate Local Resp. Center" THEN
        #68..71
          DATABASE::"Responsibility Center","Responsibility Center")
        ELSE
          CreateDim(
            DATABASE::Vendor,"Pay-to Vendor No.",
            DATABASE::"Salesperson/Purchaser","Purchaser Code",
            DATABASE::Campaign,"Campaign No.",
            DATABASE::"Accountability Center","Accountability Center");
        #73..87
        */
        //end;


        //Unsupported feature: Code Modification on ""Purchaser Code"(Field 43).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidatePurchaserOnPurchHeader(Rec,FALSE,FALSE);

        ApprovalEntry.SETRANGE("Table ID",DATABASE::"Purchase Header");
        #4..6
        IF NOT ApprovalEntry.ISEMPTY THEN
          ERROR(Text042,FIELDCAPTION("Purchaser Code"));

        CreateDim(
          DATABASE::"Salesperson/Purchaser","Purchaser Code",
          DATABASE::Vendor,"Pay-to Vendor No.",
          DATABASE::Campaign,"Campaign No.",
          DATABASE::"Responsibility Center","Responsibility Center");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..9
        CompanyInfo.GET;
        IF NOT CompanyInfo."Activate Local Resp. Center" THEN
        #10..13
          DATABASE::"Responsibility Center","Responsibility Center")
        ELSE
          CreateDim(
          DATABASE::"Salesperson/Purchaser","Purchaser Code",
          DATABASE::Vendor,"Pay-to Vendor No.",
          DATABASE::Campaign,"Campaign No.",
          DATABASE::"Accountability Center","Accountability Center");
        */
        //end;


        //Unsupported feature: Code Modification on ""Sell-to Customer No."(Field 72).OnValidate".

        //trigger "(Field 72)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Document Type" = "Document Type"::Order) AND
           (xRec."Sell-to Customer No." <> "Sell-to Customer No.")
        THEN BEGIN
        #4..15
              YouCannotChangeFieldErr,
              FIELDCAPTION("Sell-to Customer No."));
        END;

        IF "Sell-to Customer No." = '' THEN
          UpdateLocationCode('')
        ELSE
          VALIDATE("Ship-to Code",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..18
        CompanyInfo.GET;
        IF "Sell-to Customer No." = '' THEN BEGIN
          IF NOT CompanyInfo."Activate Local Resp. Center" THEN
            VALIDATE("Location Code",UserSetupMgt.GetLocation(1,'',"Responsibility Center"))
        ELSE
            VALIDATE("Location Code",UserSetupMgt.GetLocation2);
        END ELSE
          VALIDATE("Ship-to Code",'');
        */
        //end;


        //Unsupported feature: Code Modification on ""Document Date"(Field 99).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF xRec."Document Date" <> "Document Date" THEN
          UpdateDocumentDate := TRUE;
        VALIDATE("Payment Terms Code");
        VALIDATE("Prepmt. Payment Terms Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
        //>> MIN 8/17/2019
        "Nepali Document Date" := IRDMgt.getNepaliDate("Document Date");
        */
        //end;


        //Unsupported feature: Code Modification on ""Dimension Set ID"(Field 480).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        //SRT July 11th 2019 >>
        GetShortcutDimensionsInfo("Dimension Set ID",ShortcutDimCode);
        "Shortcut Dimension 3 Code" := ShortcutDimCode[3];
        "Shortcut Dimension 4 Code" := ShortcutDimCode[4];
        "Shortcut Dimension 5 Code" := ShortcutDimCode[5];
        "Shortcut Dimension 6 Code" := ShortcutDimCode[6];
        "Shortcut Dimension 7 Code" := ShortcutDimCode[7];
        "Shortcut Dimension 8 Code" := ShortcutDimCode[8];
        //SRT July 11th 2019 <<
        */
        //end;


        //Unsupported feature: Code Modification on ""Campaign No."(Field 5050).OnValidate".

        //trigger "(Field 5050)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CreateDim(
          DATABASE::Campaign,"Campaign No.",
          DATABASE::Vendor,"Pay-to Vendor No.",
          DATABASE::"Salesperson/Purchaser","Purchaser Code",
          DATABASE::"Responsibility Center","Responsibility Center");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CompanyInfo.GET;
        IF NOT CompanyInfo."Activate Local Resp. Center" THEN
        #1..4
          DATABASE::"Responsibility Center","Responsibility Center")
        ELSE
          CreateDim(
            DATABASE::Campaign,"Campaign No.",
            DATABASE::Vendor,"Pay-to Vendor No.",
            DATABASE::"Salesperson/Purchaser","Purchaser Code",
            DATABASE::"Accountability Center","Accountability Center")
        */
        //end;


        //Unsupported feature: Code Modification on ""Assigned User ID"(Field 9000).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT UserSetupMgt.CheckRespCenter2(1,"Responsibility Center","Assigned User ID") THEN
          ERROR(
            Text049,"Assigned User ID",
            RespCenter.TABLECAPTION,UserSetupMgt.GetPurchasesFilter2("Assigned User ID"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CompanyInfo.GET;
        IF NOT CompanyInfo."Activate Local Resp. Center" THEN BEGIN
        #1..4
        END ELSE BEGIN
          IF NOT UserSetupMgt.CheckRespCenter2(1,"Accountability Center","Assigned User ID") THEN
            ERROR(
              Text049,"Assigned User ID",
              AccCenter.TABLECAPTION,UserSetupMgt.GetPurchasesFilter2("Assigned User ID"));
        END
        */
        //end;
        field(50000; "Sys. LC No."; Code[20])
        {
            Caption = 'LC No.';
            DataClassification = ToBeClassified;
            TableRelation = "LC Details"."No." WHERE("Transaction Type" = CONST(Purchase),
                                                    Closed = CONST(false),
                                                    Released = CONST(true));

            trigger OnValidate()
            var
                LCDetail: Record "LC Details";
                LCAmendDetail: Record "LC Amend Detail";
                Text33020011: Label 'LC has amendments and amendment is not released.';
                Text33020012: Label 'LC has amendments and  amendment is closed.';
                Text33020013: Label 'LC Details is not released.';
                Text33020014: Label 'LC Details is closed.';
            begin
                //IME19.00 Begin
                //Code to check for LC Amendment and insert Bank LC No. and LC Amend No. (LC Version No.) if LC is amended atleast once.
                LCAmendDetail.RESET;
                LCAmendDetail.SETRANGE("No.", "Sys. LC No.");
                IF LCAmendDetail.FIND('+') THEN BEGIN
                    IF NOT LCAmendDetail.Closed THEN BEGIN
                        IF LCAmendDetail.Released THEN BEGIN
                            "Bank LC No." := LCAmendDetail."Bank Amended No.";
                            "LC Amend No." := LCAmendDetail."Version No.";
                            //MODIFY;   //Agile july 11, 2016
                        END ELSE
                            ERROR(Text33020011);
                    END ELSE
                        ERROR(Text33020012);
                END ELSE BEGIN
                    LCDetail.RESET;
                    LCDetail.SETRANGE("No.", "Sys. LC No.");
                    IF LCDetail.FIND('-') THEN BEGIN
                        IF NOT LCDetail.Closed THEN BEGIN
                            IF LCDetail.Released THEN BEGIN
                                "Bank LC No." := LCDetail."LC\DO No.";
                                //MODIFY;   //Agile july 11, 2016
                            END ELSE
                                ERROR(Text33020013);
                        END ELSE
                            ERROR(Text33020014);
                    END;
                END;
                //IME19.00 End

                /*
                //Pranisha UTS Begin
                IF "Document Profile" = "Document Profile"::"Vehicles Trade" THEN BEGIN
                  LCDetail.RESET;
                  LCDetail.SETRANGE("No.","Sys. LC No.");
                  IF LCDetail.FINDFIRST THEN BEGIN
                      IF LCDetail."Utilized Unit" = LCDetail.Units THEN
                        ERROR('All units of this LC is utilized.');
                  END;
                END;
                //Pranisha UTS End
                */

            end;
        }
        field(50001; "Bank LC No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "LC Amend No."; Code[20])
        {
            Caption = 'Amendment No.';
            DataClassification = ToBeClassified;
            TableRelation = "LC Amend Detail"."Version No." WHERE("No." = FIELD("Sys. LC No."));
        }
        field(50003; "Purchase Consignment No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'VAT1.00';
            TableRelation = "Purchase Consignment"."No." WHERE(Blocked = CONST(false));

            trigger OnValidate()
            begin
                UpdatePurchLines(FIELDCAPTION("Purchase Consignment No."), FALSE);
            end;
        }
        field(50004; "Accountability Center"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Accountability Center";

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::Open);
                IF NOT UserSetupMgt.CheckRespCenter(1, "Accountability Center") THEN
                    ERROR(
                      Text028,
                      AccCenter.TABLECAPTION, UserSetupMgt.GetPurchasesFilter);

                //"Location Code" := UserSetupMgt.GetLocation(1,'',"Accountability Center");
                "Location Code" := UserSetupMgt.GetLocation2;
                IF "Location Code" = '' THEN BEGIN
                    IF InvtSetup.GET THEN
                        "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
                END ELSE BEGIN
                    IF Location.GET("Location Code") THEN;
                    "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
                END;

                UpdateShipToAddress;

                IF xRec."Accountability Center" <> "Accountability Center" THEN BEGIN
                    RecreatePurchLines(FIELDCAPTION("Accountability Center"));
                    "Assigned User ID" := '';
                END;
            end;
        }
        field(50005; "External Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'To know whether item entry is from Amnil Technologies or not';
        }
        field(50006; "Nepali Document Date"; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //>> MIN 8/17/2019
                "Posting Date" := IRDMgt.getEngDate("Nepali Document Date");
            end;
        }
        field(50007; "Pharma PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PO No. from Pharma/Amnil Software will be copied over API in this field';
        }
        field(50401; "Document Profile"; Option)
        {
            Caption = 'Document Profile';
            DataClassification = ToBeClassified;
            Description = 'NP15.1001';
            OptionCaption = ' ,Spare Parts Trade,Vehicles Trade,Service';
            OptionMembers = " ","Spare Parts Trade","Vehicles Trade",Service;

            trigger OnValidate()
            begin
                UpdatePurchLines(FIELDCAPTION("Document Profile"), CurrFieldNo <> 0);
            end;
        }
        field(50501; PragyapanPatra; Code[100])
        {
            DataClassification = ToBeClassified;
            Description = 'NP15.1001';
            TableRelation = PragyapanPatra.Code;

            trigger OnValidate()
            begin
                UpdatePurchLines(FIELDCAPTION(PragyapanPatra), FALSE);
            end;
        }
        field(70000; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(70001; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(70002; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");
            end;
        }
        field(70003; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(6, "Shortcut Dimension 6 Code");
            end;
        }
        field(70004; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(7, "Shortcut Dimension 7 Code");
            end;
        }
        field(70005; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(8, "Shortcut Dimension 8 Code");
            end;
        }
    }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT UserSetupMgt.CheckRespCenter(1,"Responsibility Center") THEN
      ERROR(
        Text023,
        RespCenter.TABLECAPTION,UserSetupMgt.GetPurchasesFilter);

    ArchiveManagement.AutoArchivePurchDocument(Rec);
    PostPurchDelete.DeleteHeader(
    #8..36
       (PurchCrMemoHeaderPrepmt."No." <> '')
    THEN
      MESSAGE(PostedDocsToPrintCreatedMsg);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CompanyInfo.GET;
    IF NOT CompanyInfo."Activate Local Resp. Center" THEN BEGIN
      IF NOT UserSetupMgt.CheckRespCenter(1,"Responsibility Center") THEN
        ERROR(
          Text023,
          RespCenter.TABLECAPTION,UserSetupMgt.GetPurchasesFilter);
    END ELSE
      IF NOT UserSetupMgt.CheckRespCenter(1,"Accountability Center") THEN
        ERROR(
          Text023,
          AccCenter.TABLECAPTION,UserSetupMgt.GetPurchasesFilter);
    #5..39
    */
    //end;


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InitInsert;

    IF GETFILTER("Buy-from Vendor No.") <> '' THEN
      IF GETRANGEMIN("Buy-from Vendor No.") = GETRANGEMAX("Buy-from Vendor No.") THEN
    #5..8

    IF "Buy-from Vendor No." <> '' THEN
      StandardCodesMgt.CheckShowPurchRecurringLinesNotification(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF SysMgt.GetNoSeriesFromRespCenter THEN
        InitInsertUsingRespCenter
      ELSE
        InitInsert;

    SystemMgt.InitCustomFieldsOnPurchaseHeaderInsert_DMS_Fxn(Rec);
    #2..11

    IF "External Entry" THEN
      "Pharma PO No." := "Vendor Invoice No.";
    */
    //end;


    //Unsupported feature: Code Insertion on "OnModify".

    //trigger OnModify()
    //begin
    /*
    IF "External Entry" THEN
      "Pharma PO No." := "Vendor Invoice No.";
    */
    //end;


    //Unsupported feature: Code Modification on "UpdatePurchLinesByFieldNo(PROCEDURE 99)".

    //procedure UpdatePurchLinesByFieldNo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := FALSE;
    OnBeforeUpdatePurchLinesByFieldNo(Rec,ChangedFieldNo,AskQuestion,IsHandled);
    IF IsHandled THEN
    #4..72
          ELSE
            OnUpdatePurchLinesByChangedFieldName(Rec,PurchLine,Field.FieldName,ChangedFieldNo);
        END;
        PurchLine.MODIFY(TRUE);
        PurchLineReserve.VerifyChange(PurchLine,xPurchLine);
      UNTIL PurchLine.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..75
        IRDMgt.UpdatePurchLinesFCallFromPurchHeader(Rec,ChangedFieldName,PurchLine);
    #76..78
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: DimSetEntry) (VariableCollection) on "ShowDocDim(PROCEDURE 32)".



    //Unsupported feature: Code Modification on "ShowDocDim(PROCEDURE 32)".

    //procedure ShowDocDim();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OldDimSetID := "Dimension Set ID";
    "Dimension Set ID" :=
      DimMgt.EditDimensionSet2(
        "Dimension Set ID",STRSUBSTNO('%1 %2',"Document Type","No."),
        "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");

    IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
      MODIFY;
      IF PurchLinesExist THEN
        UpdateAllLineDim("Dimension Set ID",OldDimSetID);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
      //SRT Jan 27th 2020 >>
      "Shortcut Dimension 3 Code" := '';
      "Shortcut Dimension 4 Code" := '';
      "Shortcut Dimension 5 Code" := '';
      "Shortcut Dimension 6 Code" := '';
      "Shortcut Dimension 7 Code" := '';
      "Shortcut Dimension 8 Code" := '';
      GLSetup.GET;
      DimSetEntry.RESET;
      DimSetEntry.SETRANGE("Dimension Set ID","Dimension Set ID");
      IF DimSetEntry.FINDFIRST THEN REPEAT
        IF DimSetEntry."Dimension Code" = GLSetup."Shortcut Dimension 3 Code" THEN
          "Shortcut Dimension 3 Code" := DimSetEntry."Dimension Value Code"
        ELSE IF DimSetEntry."Dimension Code" = GLSetup."Shortcut Dimension 4 Code" THEN
          "Shortcut Dimension 4 Code" := DimSetEntry."Dimension Value Code"
        ELSE IF DimSetEntry."Dimension Code" = GLSetup."Shortcut Dimension 5 Code" THEN
          "Shortcut Dimension 5 Code" := DimSetEntry."Dimension Value Code"
        ELSE IF DimSetEntry."Dimension Code" = GLSetup."Shortcut Dimension 6 Code" THEN
          "Shortcut Dimension 6 Code" := DimSetEntry."Dimension Value Code"
        ELSE IF DimSetEntry."Dimension Code" = GLSetup."Shortcut Dimension 7 Code" THEN
          "Shortcut Dimension 7 Code" := DimSetEntry."Dimension Value Code"
        ELSE IF DimSetEntry."Dimension Code" = GLSetup."Shortcut Dimension 8 Code" THEN
          "Shortcut Dimension 8 Code" := DimSetEntry."Dimension Value Code"
      UNTIL DimSetEntry.NEXT = 0;
      //SRT Jan 27th 2020

    #8..10

    END;
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: DimSetEntry) (VariableCollection) on "UpdateAllLineDim(PROCEDURE 34)".



    //Unsupported feature: Code Modification on "UpdateAllLineDim(PROCEDURE 34)".

    //procedure UpdateAllLineDim();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := FALSE;
    OnBeforeUpdateAllLineDim(Rec,NewParentDimSetID,OldParentDimSetID,IsHandled);
    IF IsHandled THEN
    #4..23
          DimMgt.UpdateGlobalDimFromDimSetID(
            PurchLine."Dimension Set ID",PurchLine."Shortcut Dimension 1 Code",PurchLine."Shortcut Dimension 2 Code");

          OnUpdateAllLineDimOnBeforePurchLineModify(PurchLine);
          PurchLine.MODIFY;
        END;
      UNTIL PurchLine.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..26
          //SRT Jan 27th 2020 >>
          PurchLine."Shortcut Dimension 3 Code" := '';
          PurchLine."Shortcut Dimension 4 Code" := '';
          PurchLine."Shortcut Dimension 5 Code" := '';
          PurchLine."Shortcut Dimension 6 Code" := '';
          PurchLine."Shortcut Dimension 7 Code" := '';
          PurchLine."Shortcut Dimension 8 Code" := '';
          GLSetup.GET;
          DimSetEntry.RESET;
          DimSetEntry.SETRANGE("Dimension Set ID",PurchLine."Dimension Set ID");
          IF DimSetEntry.FINDFIRST THEN REPEAT
            IF DimSetEntry."Dimension Code" = GLSetup."Shortcut Dimension 3 Code" THEN
              PurchLine."Shortcut Dimension 3 Code" := DimSetEntry."Dimension Value Code"
            ELSE IF DimSetEntry."Dimension Code" = GLSetup."Shortcut Dimension 4 Code" THEN
              PurchLine."Shortcut Dimension 4 Code" := DimSetEntry."Dimension Value Code"
            ELSE IF DimSetEntry."Dimension Code" = GLSetup."Shortcut Dimension 5 Code" THEN
              PurchLine."Shortcut Dimension 5 Code" := DimSetEntry."Dimension Value Code"
            ELSE IF DimSetEntry."Dimension Code" = GLSetup."Shortcut Dimension 6 Code" THEN
              PurchLine."Shortcut Dimension 6 Code" := DimSetEntry."Dimension Value Code"
            ELSE IF DimSetEntry."Dimension Code" = GLSetup."Shortcut Dimension 7 Code" THEN
              "Shortcut Dimension 7 Code" := DimSetEntry."Dimension Value Code"
            ELSE IF DimSetEntry."Dimension Code" = GLSetup."Shortcut Dimension 8 Code" THEN
              PurchLine."Shortcut Dimension 8 Code" := DimSetEntry."Dimension Value Code"
          UNTIL DimSetEntry.NEXT = 0;
          //SRT Jan 27th 2020

    #27..30
    */
    //end;


    //Unsupported feature: Code Modification on "SetSecurityFilterOnRespCenter(PROCEDURE 43)".

    //procedure SetSecurityFilterOnRespCenter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := FALSE;
    OnBeforeSetSecurityFilterOnRespCenter(Rec,IsHandled);
    IF (NOT IsHandled) AND (UserSetupMgt.GetPurchasesFilter <> '') THEN BEGIN
      FILTERGROUP(2);
      SETRANGE("Responsibility Center",UserSetupMgt.GetPurchasesFilter);
      FILTERGROUP(0);
    END;

    SETRANGE("Date Filter",0D,WORKDATE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    IF UserSetupMgt.GetPurchasesFilter <> '' THEN BEGIN
      CompanyInfo.GET;
      FILTERGROUP(2);
      IF NOT CompanyInfo."Activate Local Resp. Center" THEN
        SETRANGE("Responsibility Center",UserSetupMgt.GetPurchasesFilter)
      ELSE
        SETFILTER("Accountability Center",SystemMgt.GetUserRespCenterFilter);
      FILTERGROUP(0);
    END;

    SETRANGE("Date Filter",0D,WORKDATE);
    */
    //end;


    //Unsupported feature: Code Modification on "CreateDimSetForPrepmtAccDefaultDim(PROCEDURE 44)".

    //procedure CreateDimSetForPrepmtAccDefaultDim();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PurchaseLine.SETRANGE("Document Type","Document Type");
    PurchaseLine.SETRANGE("Document No.","No.");
    PurchaseLine.SETFILTER("Prepmt. Amt. Inv.",'<>%1',0);
    IF PurchaseLine.FINDSET THEN
      REPEAT
        CollectParamsInBufferForCreateDimSet(TempPurchaseLine,PurchaseLine);
      UNTIL PurchaseLine.NEXT = 0;
    TempPurchaseLine.RESET;
    TempPurchaseLine.MARKEDONLY(FALSE);
    IF TempPurchaseLine.FINDSET THEN
      REPEAT
        PurchaseLine.CreateDim(DATABASE::"G/L Account",TempPurchaseLine."No.",
          DATABASE::Job,TempPurchaseLine."Job No.",
          DATABASE::"Responsibility Center",TempPurchaseLine."Responsibility Center",
          DATABASE::"Work Center",TempPurchaseLine."Work Center No.");
      UNTIL TempPurchaseLine.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    CompanyInfo.GET;
    #8..11
        IF NOT CompanyInfo."Activate Local Resp. Center" THEN
    #12..14
            DATABASE::"Work Center",TempPurchaseLine."Work Center No.")
        ELSE
          PurchaseLine.CreateDim(DATABASE::"G/L Account",TempPurchaseLine."No.",
          DATABASE::Job,TempPurchaseLine."Job No.",
          DATABASE::"Accountability Center",TempPurchaseLine."Accountability Center",
          DATABASE::"Work Center",TempPurchaseLine."Work Center No.");
      UNTIL TempPurchaseLine.NEXT = 0;
    */
    //end;


    //Unsupported feature: Code Modification on "CollectParamsInBufferForCreateDimSet(PROCEDURE 49)".

    //procedure CollectParamsInBufferForCreateDimSet();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TempPurchaseLine.SETRANGE("Gen. Bus. Posting Group",PurchaseLine."Gen. Bus. Posting Group");
    TempPurchaseLine.SETRANGE("Gen. Prod. Posting Group",PurchaseLine."Gen. Prod. Posting Group");
    IF NOT TempPurchaseLine.FINDFIRST THEN BEGIN
    #4..9
    END ELSE
      IF NOT TempPurchaseLine.MARK THEN BEGIN
        TempPurchaseLine.SETRANGE("Job No.",PurchaseLine."Job No.");
        TempPurchaseLine.SETRANGE("Responsibility Center",PurchaseLine."Responsibility Center");
        TempPurchaseLine.SETRANGE("Work Center No.",PurchaseLine."Work Center No.");
        OnCollectParamsInBufferForCreateDimSetOnAfterSetTempPurchLineFilters(TempPurchaseLine,PurchaseLine);
        IF TempPurchaseLine.ISEMPTY THEN
          InsertTempPurchaseLineInBuffer(TempPurchaseLine,PurchaseLine,TempPurchaseLine."No.",FALSE)
      END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CompanyInfo.GET;
    #1..12
        IF NOT CompanyInfo."Activate Local Resp. Center" THEN
          TempPurchaseLine.SETRANGE("Responsibility Center",PurchaseLine."Responsibility Center")
        ELSE
          TempPurchaseLine.SETRANGE("Accountability Center",PurchaseLine."Accountability Center");
    #14..18
    */
    //end;


    //Unsupported feature: Code Modification on "InsertTempPurchaseLineInBuffer(PROCEDURE 35)".

    //procedure InsertTempPurchaseLineInBuffer();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TempPurchaseLine.INIT;
    TempPurchaseLine."Line No." := PurchaseLine."Line No.";
    TempPurchaseLine."No." := AccountNo;
    TempPurchaseLine."Job No." := PurchaseLine."Job No.";
    TempPurchaseLine."Responsibility Center" := PurchaseLine."Responsibility Center";
    TempPurchaseLine."Work Center No." := PurchaseLine."Work Center No.";
    TempPurchaseLine."Gen. Bus. Posting Group" := PurchaseLine."Gen. Bus. Posting Group";
    TempPurchaseLine."Gen. Prod. Posting Group" := PurchaseLine."Gen. Prod. Posting Group";
    TempPurchaseLine.MARK := DefaultDimenstionsNotExist;
    OnInsertTempPurchLineInBufferOnBeforeTempPurchLineInsert(TempPurchaseLine,PurchaseLine);
    TempPurchaseLine.INSERT;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CompanyInfo.GET;
    #1..4
    IF NOT CompanyInfo."Activate Local Resp. Center" THEN
      TempPurchaseLine."Responsibility Center" := PurchaseLine."Responsibility Center"
    ELSE
      TempPurchaseLine."Accountability Center" := PurchaseLine."Accountability Center";
    #6..11
    */
    //end;


    //Unsupported feature: Code Modification on "InitFromVendor(PROCEDURE 68)".

    //procedure InitFromVendor();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PurchLine.SETRANGE("Document Type","Document Type");
    PurchLine.SETRANGE("Document No.","No.");
    IF VendorNo = '' THEN BEGIN
    #4..6
      GetPurchSetup;
      "No. Series" := xRec."No. Series";
      OnInitFromVendorOnBeforeInitRecord(Rec,xRec);
      InitRecord;
      InitNoSeries;
      EXIT(TRUE);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CompanyInfo.GET;
    #1..9
      IF NOT CompanyInfo."Activate Local Resp. Center" THEN
        InitRecord
      ELSE
        InitRecordUsingRespCenter;
    #11..13
    */
    //end;


    //Unsupported feature: Code Modification on "InitFromContact(PROCEDURE 69)".

    //procedure InitFromContact();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PurchLine.SETRANGE("Document Type","Document Type");
    PurchLine.SETRANGE("Document No.","No.");
    IF (ContactNo = '') AND (VendorNo = '') THEN BEGIN
    #4..6
      GetPurchSetup;
      "No. Series" := xRec."No. Series";
      OnInitFromContactOnBeforeInitRecord(Rec,xRec);
      InitRecord;
      InitNoSeries;
      EXIT(TRUE);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CompanyInfo.GET;
    #1..9
      IF NOT CompanyInfo."Activate Local Resp. Center" THEN
        InitRecord
      ELSE
        InitRecordUsingRespCenter;
    #11..13
    */
    //end;


    //Unsupported feature: Code Modification on "ValidateEmptySellToCustomerAndLocation(PROCEDURE 42)".

    //procedure ValidateEmptySellToCustomerAndLocation();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := FALSE;
    OnBeforeValidateEmptySellToCustomerAndLocation(Rec,Vend,IsHandled);
    IF IsHandled THEN
      EXIT;

    VALIDATE("Sell-to Customer No.",'');
    IF "Buy-from Vendor No." <> '' THEN
      GetVend("Buy-from Vendor No.");
    UpdateLocationCode(Vend."Location Code");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    //VALIDATE("Location Code",UserSetupMgt.GetLocation(1,Vend."Location Code","Responsibility Center"));

    CompanyInfo.GET;
    IF NOT CompanyInfo."Activate Local Resp. Center" THEN
      VALIDATE("Location Code",UserSetupMgt.GetLocation(1,Vend."Location Code","Responsibility Center"))
    ELSE
      VALIDATE("Location Code",UserSetupMgt.GetLocation2);
    #7..9
    */
    //end;

    procedure InitInsertUsingRespCenter()
    begin
        IF "No." = '' THEN BEGIN
            NoSeriesRespCenter := SysMgt.GetUserRespCenter;
            TestNoSeriesUsingRespCenter;
            NoSeriesMgt.InitSeries(GetNoSeriesCodeUsingRespCenter, xRec."No. Series", "Posting Date", "No.", "No. Series");
        END;

        InitRecordUsingRespCenter;

        CompanyInfo.GET;
        IF NOT CompanyInfo."Activate Local Resp. Center" THEN
            VALIDATE("Responsibility Center", NoSeriesRespCenter)
        ELSE
            VALIDATE("Accountability Center", NoSeriesRespCenter);
        VALIDATE("Assigned User ID", USERID);
    end;

    local procedure TestNoSeriesUsingRespCenter(): Boolean
    begin
        PurchSetup.GET;
        CASE "Document Type" OF
            "Document Type"::Quote:
                SysMgt.TestNoSeriesFromRespCenter(DocumentProfile::Purchase, DocumentType::Quote);
            "Document Type"::Order:
                SysMgt.TestNoSeriesFromRespCenter(DocumentProfile::Purchase, DocumentType::Order);
            "Document Type"::Invoice:
                BEGIN
                    SysMgt.TestNoSeriesFromRespCenter(DocumentProfile::Purchase, DocumentType::Invoice);
                    SysMgt.TestNoSeriesFromRespCenter(DocumentProfile::Purchase, DocumentType::"Posted Invoice");
                END;
            "Document Type"::"Return Order":
                SysMgt.TestNoSeriesFromRespCenter(DocumentProfile::Purchase, DocumentType::"Return Order");
            "Document Type"::"Credit Memo":
                BEGIN
                    SysMgt.TestNoSeriesFromRespCenter(DocumentProfile::Purchase, DocumentType::"Credit Memo");
                    SysMgt.TestNoSeriesFromRespCenter(DocumentProfile::Purchase, DocumentType::"Posted Credit Memo");
                END;
            "Document Type"::"Blanket Order":
                SysMgt.TestNoSeriesFromRespCenter(DocumentProfile::Purchase, DocumentType::"Blanket Order");
        END;
    end;

    local procedure GetNoSeriesCodeUsingRespCenter(): Code[10]
    begin
        CASE "Document Type" OF
            "Document Type"::Quote:
                EXIT(SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Purchase, DocumentType::Quote));
            "Document Type"::Order:
                EXIT(SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Purchase, DocumentType::Order));
            "Document Type"::Invoice:
                EXIT(SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Purchase, DocumentType::Invoice));
            "Document Type"::"Return Order":
                EXIT(SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Purchase, DocumentType::"Return Order"));
            "Document Type"::"Credit Memo":
                EXIT(SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Purchase, DocumentType::"Credit Memo"));
            "Document Type"::"Blanket Order":
                EXIT(SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Purchase, DocumentType::"Blanket Order"));
        END;
    end;

    procedure InitRecordUsingRespCenter()
    var
    begin
        PurchSetup.GET;

        CASE "Document Type" OF
            "Document Type"::Quote, "Document Type"::Order:
                BEGIN
                    NoSeriesMgt.SetDefaultSeries("Posting No. Series",
                                                  SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Purchase, DocumentType::"Posted Invoice"));
                    NoSeriesMgt.SetDefaultSeries("Receiving No. Series",
                    SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Purchase, DocumentType::"Posted Receipt"));

                    IF "Document Type" = "Document Type"::Order THEN BEGIN
                        NoSeriesMgt.SetDefaultSeries("Prepayment No. Series",
                                                      SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Purchase,
                                                      DocumentType::"Posted Prepmt. Inv."));
                        NoSeriesMgt.SetDefaultSeries("Prepmt. Cr. Memo No. Series",
                                                      SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Purchase,
                                                      DocumentType::"Posted Prepmt. Cr. Memo"));
                    END;

                END;
            "Document Type"::Invoice:
                BEGIN
                    IF ("No. Series" <> '') AND
                       (SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Purchase, DocumentType::Invoice) =
                       SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Purchase, DocumentType::"Posted Invoice"))
                    THEN
                        "Posting No. Series" := "No. Series"
                    ELSE
                        NoSeriesMgt.SetDefaultSeries("Posting No. Series",
                                                      SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Purchase, DocumentType::"Posted Invoice")
                );
                    IF PurchSetup."Receipt on Invoice" THEN
                        NoSeriesMgt.SetDefaultSeries("Receiving No. Series",
                                                      SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Purchase, DocumentType::"Posted Receipt"));
                END;
            "Document Type"::"Return Order":
                BEGIN
                    NoSeriesMgt.SetDefaultSeries("Posting No. Series",
                                                SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Purchase, DocumentType::"Posted Credit Memo")
              );
                    NoSeriesMgt.SetDefaultSeries("Return Shipment No. Series",
                                                SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Purchase,
                                                DocumentType::"Posted Return Shipment"));
                END;
            "Document Type"::"Credit Memo":
                BEGIN
                    IF ("No. Series" <> '') AND
                       (SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Purchase, DocumentType::"Credit Memo") =
                       SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Purchase, DocumentType::"Posted Credit Memo"))
                    THEN
                        "Posting No. Series" := "No. Series"
                    ELSE
                        NoSeriesMgt.SetDefaultSeries("Posting No. Series",
                                                      SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Purchase,
                                                      DocumentType::"Posted Credit Memo"));
                    IF PurchSetup."Return Shipment on Credit Memo" THEN
                        NoSeriesMgt.SetDefaultSeries("Return Shipment No. Series",
                                                      SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Purchase,
                                                      DocumentType::"Posted Return Shipment"));
                END;
            "Document Type"::"Blanket Order":
                BEGIN
                    IF "Document Type" = "Document Type"::"Blanket Order" THEN BEGIN
                        NoSeriesMgt.SetDefaultSeries("Prepayment No. Series",
                                                      SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Purchase,
                                                      DocumentType::"Blanket Order"));
                        NoSeriesMgt.SetDefaultSeries("Prepmt. Cr. Memo No. Series",
                                                      SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Purchase,
                                                      DocumentType::"Blanket Order"));
                    END;
                END;
        END;


        IF "Document Type" IN ["Document Type"::Order, "Document Type"::Invoice, "Document Type"::"Return Order"] THEN
            "Order Date" := WORKDATE;

        IF "Document Type" = "Document Type"::Invoice THEN
            "Expected Receipt Date" := WORKDATE;

        IF NOT ("Document Type" IN ["Document Type"::"Blanket Order", "Document Type"::Quote]) AND
           ("Posting Date" = 0D)
        THEN BEGIN
            "Posting Date" := WORKDATE;
        END;

        IF PurchSetup."Default Posting Date" = PurchSetup."Default Posting Date"::"No Date" THEN
            "Posting Date" := 0D;

        "Document Date" := WORKDATE;
        "Nepali Document Date" := IRDMgt.getNepaliDate("Document Date"); //SRT Jan 29th 2020
        VALIDATE("Sell-to Customer No.", '');

        IF "Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"] THEN BEGIN
            GLSetup.GET;
            Correction := GLSetup."Mark Cr. Memos as Corrections";
        END;

        "Posting Description" := FORMAT("Document Type") + ' ' + "No.";

        IF InvtSetup.GET THEN
            "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
        CompanyInfo.GET;
        IF NOT CompanyInfo."Activate Local Resp. Center" THEN
            "Responsibility Center" := UserSetupMgt.GetRespCenter(1, "Responsibility Center")
        ELSE
            "Accountability Center" := UserSetupMgt.GetRespCenter(1, "Accountability Center");
        VALIDATE("Assigned User ID", USERID);
        VALIDATE("Location Code", UserSetupMgt.GetLocation2);
    end;

    local procedure GetPostingNoSeriesCodeUsingRespCenter(): Code[10]
    begin
        CASE "Document Type" OF
            "Document Type"::"Return Order",
          "Document Type"::"Credit Memo":
                EXIT(SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Purchase, DocumentType::"Posted Credit Memo"));
            ELSE
                EXIT(SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Purchase, DocumentType::"Posted Invoice"));
        END;
    end;

    local procedure GetPostingPrepaymentNoSeriesCodeUsingRespCenter(): Code[10]
    begin
        CASE "Document Type" OF
            "Document Type"::"Return Order",
          "Document Type"::"Credit Memo":
                EXIT(SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Purchase, DocumentType::"Posted Prepmt. Cr. Memo"));
            ELSE
                EXIT(SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Purchase, DocumentType::"Posted Prepmt. Inv."));
        END;
    end;

    procedure CalculateTDS()
    var
        TDSPostingGroup: Record "TDS Posting Group";
        PurchaseLine: Record "Purchase Line";
        Currency: Record Currency;
    begin
        // TDS1.00 >>
        Currency.InitRoundingPrecision;

        PurchaseLine.RESET;
        PurchaseLine.SETRANGE("Document Type", "Document Type");
        PurchaseLine.SETRANGE("Document No.", "No.");
        PurchaseLine.SETFILTER("TDS Group", '<>%1', '');
        IF PurchaseLine.FINDFIRST THEN BEGIN
            REPEAT
                IF "Prices Including VAT" THEN
                    PurchaseLine."TDS Base Amount" := (PurchaseLine."Direct Unit Cost" - (PurchaseLine."Direct Unit Cost" * PurchaseLine."VAT %" / 100)) * PurchaseLine."Qty. to Invoice"
                ELSE
                    PurchaseLine."TDS Base Amount" := PurchaseLine."Direct Unit Cost" * PurchaseLine."Qty. to Invoice";

                PurchaseLine."TDS Amount" := ROUND(PurchaseLine."TDS Base Amount" * PurchaseLine."TDS%" / 100, Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
                PurchaseLine."TDS Type" := PurchaseLine."TDS Type"::"Purchase TDS";
                PurchaseLine.MODIFY;
            UNTIL PurchaseLine.NEXT = 0;
        END;
        // TDS1.00 <<
    end;

    local procedure "--SRT--"()
    begin
    end;

    local procedure GetShortcutDimensionsInfo(DimSetID: Integer; var ShortcutDimCode: array[8] of Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
        GLSetup: Record "General Ledger Setup";
        i: Integer;
        GLSetupShortcutDimCode: array[8] of Code[20];
        DimSetEntry: Record "Dimension Set Entry";
    begin
        GLSetup.GET;
        GLSetupShortcutDimCode[1] := GLSetup."Shortcut Dimension 1 Code";
        GLSetupShortcutDimCode[2] := GLSetup."Shortcut Dimension 2 Code";
        GLSetupShortcutDimCode[3] := GLSetup."Shortcut Dimension 3 Code";
        GLSetupShortcutDimCode[4] := GLSetup."Shortcut Dimension 4 Code";
        GLSetupShortcutDimCode[5] := GLSetup."Shortcut Dimension 5 Code";
        GLSetupShortcutDimCode[6] := GLSetup."Shortcut Dimension 6 Code";
        GLSetupShortcutDimCode[7] := GLSetup."Shortcut Dimension 7 Code";
        GLSetupShortcutDimCode[8] := GLSetup."Shortcut Dimension 8 Code";

        CLEAR(ShortcutDimCode);
        FOR i := 1 TO 8 DO BEGIN
            ShortcutDimCode[i] := '';
            IF GLSetupShortcutDimCode[i] <> '' THEN BEGIN
                IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[i]) THEN BEGIN
                    ShortcutDimCode[i] := DimSetEntry."Dimension Value Code";
                END;
            END;
        END;
    end;

    //Unsupported feature: Property Modification (Id) on "UpdateAllLineDim(PROCEDURE 34).ConfirmManagement(Variable 1004)".


    var
        "--Customization--": Integer;
        SysMgt: Codeunit "System Mgt. Quest";
        DocumentProfile: Option Purchase,Sales,Transfer,Service;
        DocumentType: Option Quote,"Blanket Order","Order","Return Order",Invoice,"Posted Invoice","Credit Memo","Posted Credit Memo","Posted Shipment","Posted Receipt","Posted Prepmt. Inv.","Posted Prepmt. Cr. Memo","Posted Return Receipt","Posted Return Shipment",Booking,"Posted Order","Posted Debit Note",Requisition,Services,"Posted Credit Note";
        NoSeriesRespCenter: Code[10];
        ResponsibilityCenter: Record "Responsibility Center";
        IRDMgt: Codeunit "IRD Mgt.";
        SystemMgt: Codeunit "System Mgt. Quest";
        AccCenter: Record "Accountability Center";
        AccCenter2: Record "Accountability Center";
        "--SRT-": Integer;
        ShortcutDimCode: array[8] of Code[20];
        ChangedFieldName: Text;
        PurchSetup: Record "Purchases & Payables Setup";
        InvtSetup: Record "Inventory Setup";
        CompanyInfo: Record "Company Information";
        UserSetupMgt: Codeunit "User Setup Management";
        GLSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Location: record Location;


}

