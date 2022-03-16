tableextension 50023 "tableextension70000535" extends "Sales Header"
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Ship-to Contact"(Field 18)".


        //Unsupported feature: Code Modification on ""Sell-to Customer No."(Field 2).OnValidate".

        //trigger "(Field 2)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckCreditLimitIfLineNotInsertedYet;
        IF "No." = '' THEN
          InitRecord;
        TestStatusOpen;
        #5..27
              OnValidateSellToCustomerNoAfterInit(Rec,xRec);
              GetSalesSetup;
              "No. Series" := xRec."No. Series";
              InitRecord;
              InitNoSeries;
              EXIT;
            END;
        #35..60
        Cust.CheckBlockedCustOnDocs(Cust,"Document Type",FALSE,FALSE);
        Cust.TESTFIELD("Gen. Bus. Posting Group");
        OnAfterCheckSellToCust(Rec,xRec,Cust);

        CopySellToCustomerAddressFieldsFromCustomer(Cust);

        #67..99

        IF (xRec."Sell-to Customer No." <> '') AND (xRec."Sell-to Customer No." <> "Sell-to Customer No.") THEN
          RecallModifyAddressNotification(GetModifyCustomerAddressNotificationId);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckCreditLimitIfLineNotInsertedYet;
        CompanyInfo.GET;
        IF "No." = '' THEN BEGIN
          CompanyInfo.GET;
          IF NOT CompanyInfo."Activate Local Resp. Center" THEN
            InitRecord
          ELSE
            InitRecord2;
        END;
        TESTFIELD(Status,Status::Open);
        #2..30
              IF NOT CompanyInfo."Activate Local Resp. Center" THEN
                InitRecord
              ELSE
                InitRecord2;

        #32..63
        IF NOT SkipSellToContact THEN
          "Sell-to Contact" := Cust.Contact;
        "Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
        "VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
        "Tax Area Code" := Cust."Tax Area Code";
        "Tax Liable" := Cust."Tax Liable";
        "VAT Registration No." := Cust."VAT Registration No.";
        "VAT Country/Region Code" := Cust."Country/Region Code";
        "Shipping Advice" := Cust."Shipping Advice";
        IF NOT CompanyInfo."Activate Local Resp. Center" THEN BEGIN
          "Responsibility Center" := UserSetupMgt.GetRespCenter(0,Cust."Responsibility Center");
          VALIDATE("Location Code",UserSetupMgt.GetLocation(0,Cust."Location Code","Responsibility Center"));
        END ELSE BEGIN
          "Accountability Center" := SysMgt.GetUserRespCenter;
          VALIDATE("Location Code",UserSetupMgt.GetLocation2);
        END;
        #64..102
        */
        //end;


        //Unsupported feature: Code Modification on ""No."(Field 3).OnValidate".

        //trigger "(Field 3)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "No." <> xRec."No." THEN BEGIN
          GetSalesSetup;
          NoSeriesMgt.TestManual(GetNoSeriesCode);
          "No. Series" := '';
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF "No." <> xRec."No." THEN BEGIN
          GetSalesSetup;
          IF NOT CompanyInfo."Activate Local Resp. Center" THEN
            NoSeriesMgt.TestManual(GetNoSeriesCode)
          ELSE
            NoSeriesMgt.TestManual(GetNoSeriesCode2);
        #3..5
        */
        //end;


        //Unsupported feature: Code Modification on ""Bill-to Customer No."(Field 4).OnValidate".

        //trigger "(Field 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        BilltoCustomerNoChanged := xRec."Bill-to Customer No." <> "Bill-to Customer No.";
        IF BilltoCustomerNoChanged THEN
          IF xRec."Bill-to Customer No." = '' THEN
            InitRecord
          ELSE BEGIN
            IF GetHideValidationDialog OR NOT GUIALLOWED THEN
              Confirmed := TRUE
            ELSE
        #10..35
            TESTFIELD("Currency Code",xRec."Currency Code");
          END;

        CreateDim(
          DATABASE::Customer,"Bill-to Customer No.",
          DATABASE::"Salesperson/Purchaser","Salesperson Code",
          DATABASE::Campaign,"Campaign No.",
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::"Customer Template","Bill-to Customer Template Code");

        VALIDATE("Payment Terms Code");
        VALIDATE("Prepmt. Payment Terms Code");
        VALIDATE("Payment Method Code");
        #49..62

        IF (xRec."Bill-to Customer No." <> '') AND (xRec."Bill-to Customer No." <> "Bill-to Customer No.") THEN
          RecallModifyAddressNotification(GetModifyBillToCustomerAddressNotificationId);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        CompanyInfo.GET;
        #1..3
          IF xRec."Bill-to Customer No." = '' THEN BEGIN
            IF NOT CompanyInfo."Activate Local Resp. Center" THEN
            InitRecord
            ELSE
              InitRecord2;
           END ELSE BEGIN
        #7..38
        CompanyInfo.GET;
        IF NOT CompanyInfo."Activate Local Resp. Center" THEN BEGIN
        #39..44
        END ELSE BEGIN
          CreateDim(
            DATABASE::Customer,"Bill-to Customer No.",
            DATABASE::"Salesperson/Purchaser","Salesperson Code",
            DATABASE::Campaign,"Campaign No.",
            DATABASE::"Accountability Center","Accountability Center",
            DATABASE::"Customer Template","Bill-to Customer Template Code");
        END;
        #46..65
        */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Order Date"(Field 19).OnValidate".

        //trigger (Variable: Customer)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""Order Date"(Field 19).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Document Type" IN ["Document Type"::Quote,"Document Type"::Order]) AND
           NOT ("Order Date" = xRec."Order Date")
        THEN
          PriceMessageIfSalesLinesExist(FIELDCAPTION("Order Date"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
        //SRT June 5th 2019 >>
        IF "Document Type" IN ["Document Type"::Order,"Document Type"::Invoice] THEN BEGIN
          IF "Order Date" <> 0D THEN BEGIN
            Customer.GET("Sell-to Customer No.");
            "Expected Delivery Date" := CALCDATE(Customer."Expected Delivery Days","Order Date");
          END;
        END;
        //SRT June 5th 2019 <<
        */
        //end;


        //Unsupported feature: Code Modification on ""Salesperson Code"(Field 43).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateSalesPersonOnSalesHeader(Rec,FALSE,FALSE);

        ApprovalEntry.SETRANGE("Table ID",DATABASE::"Sales Header");
        #4..6
        IF NOT ApprovalEntry.ISEMPTY THEN
          ERROR(Text053,FIELDCAPTION("Salesperson Code"));

        CreateDim(
          DATABASE::"Salesperson/Purchaser","Salesperson Code",
          DATABASE::Customer,"Bill-to Customer No.",
          DATABASE::Campaign,"Campaign No.",
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::"Customer Template","Bill-to Customer Template Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..9
        CompanyInfo.GET;
        IF NOT CompanyInfo."Activate Local Resp. Center" THEN BEGIN
        #10..15
        END ELSE BEGIN
          CreateDim(
            DATABASE::"Salesperson/Purchaser","Salesperson Code",
            DATABASE::Customer,"Bill-to Customer No.",
            DATABASE::Campaign,"Campaign No.",
            DATABASE::"Accountability Center","Accountability Center",
            DATABASE::"Customer Template","Bill-to Customer Template Code");
        END;
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
          DATABASE::Customer,"Bill-to Customer No.",
          DATABASE::"Salesperson/Purchaser","Salesperson Code",
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::"Customer Template","Bill-to Customer Template Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CompanyInfo.GET;
        IF NOT CompanyInfo."Activate Local Resp. Center" THEN BEGIN
        #1..6
        END ELSE BEGIN
          CreateDim(
            DATABASE::Campaign,"Campaign No.",
            DATABASE::Customer,"Bill-to Customer No.",
            DATABASE::"Salesperson/Purchaser","Salesperson Code",
            DATABASE::"Accountability Center","Accountability Center",
            DATABASE::"Customer Template","Bill-to Customer Template Code");
        END;
        */
        //end;


        //Unsupported feature: Code Modification on ""Bill-to Customer Template Code"(Field 5054).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Document Type","Document Type"::Quote);
        TestStatusOpen;

        #4..31
          "Shipment Method Code" := BillToCustTemplate."Shipment Method Code";
        END;

        CreateDim(
          DATABASE::"Customer Template","Bill-to Customer Template Code",
          DATABASE::"Salesperson/Purchaser","Salesperson Code",
          DATABASE::Customer,"Bill-to Customer No.",
          DATABASE::Campaign,"Campaign No.",
          DATABASE::"Responsibility Center","Responsibility Center");

        OnValidateBilltoCustomerTemplateCodeBeforeRecreateSalesLines(Rec,CurrFieldNo);

        IF NOT InsertMode AND
           (xRec."Sell-to Customer Template Code" = "Sell-to Customer Template Code") AND
           (xRec."Bill-to Customer Template Code" <> "Bill-to Customer Template Code")
        THEN
          RecreateSalesLines(FIELDCAPTION("Bill-to Customer Template Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..34
        CompanyInfo.GET;
        IF NOT CompanyInfo."Activate Local Resp. Center" THEN BEGIN
        #35..40
        END ELSE BEGIN
          CreateDim(
            DATABASE::"Customer Template","Bill-to Customer Template Code",
            DATABASE::"Salesperson/Purchaser","Salesperson Code",
            DATABASE::Customer,"Bill-to Customer No.",
            DATABASE::Campaign,"Campaign No.",
            DATABASE::"Accountability Center","Accountability Center");
        END;
        #41..48
        */
        //end;


        //Unsupported feature: Code Modification on ""Assigned User ID"(Field 9000).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT UserSetupMgt.CheckRespCenter2(0,"Responsibility Center","Assigned User ID") THEN
          ERROR(
            Text061,"Assigned User ID",
            RespCenter.TABLECAPTION,UserSetupMgt.GetSalesFilter2("Assigned User ID"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CompanyInfo.GET;
        IF NOT CompanyInfo."Activate Local Resp. Center" THEN BEGIN
        #1..4
        END ELSE BEGIN
          IF NOT UserSetupMgt.CheckRespCenter2(0,"Accountability Center","Assigned User ID") THEN
            ERROR(
              Text061,"Assigned User ID",
              AccCenter.TABLECAPTION,UserSetupMgt.GetSalesFilter2("Assigned User ID"));
        END;
        */
        //end;
        field(50000; "Sys. LC No."; Code[20])
        {
            Caption = 'LC No.';
            DataClassification = ToBeClassified;
            TableRelation = "LC Details"."No." WHERE("Transaction Type" = CONST(Sale),
                                                    "Issued To/Received From" = FIELD("Sell-to Customer No."),
                                                    Released = CONST(true),
                                                    Closed = CONST(false));

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
                            MODIFY;
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
                                MODIFY;
                            END ELSE
                                ERROR(Text33020013);
                        END ELSE
                            ERROR(Text33020014);
                    END;
                END;
                //IME19.00 End

                //agile
                IF "Sys. LC No." <> '' THEN BEGIN
                    VALIDATE("Payment Method Code", '');
                END;
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
        field(50003; "Accountability Center"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Accountability Center";

            trigger OnValidate()
            var
                UserSetupMgt: Codeunit "User Setup Management";
                Text027: Label 'Your identification is set up to process from %1 %2 only.';
                Location: Record Location;
                InvtSetup: Record "Inventory Setup";

            begin
                TESTFIELD(Status, Status::Open);
                IF NOT UserSetupMgt.CheckRespCenter(0, "Accountability Center") THEN
                    ERROR(
                      Text027,
                      AccCenter.TABLECAPTION, UserSetupMgt.GetSalesFilter);

                "Location Code" := UserSetupMgt.GetLocation(0, '', "Accountability Center");
                IF "Location Code" <> '' THEN BEGIN
                    IF Location.GET("Location Code") THEN
                        "Outbound Whse. Handling Time" := Location."Outbound Whse. Handling Time";
                END ELSE BEGIN
                    IF InvtSetup.GET THEN
                        "Outbound Whse. Handling Time" := InvtSetup."Outbound Whse. Handling Time";
                END;

                UpdateShipToAddress;

                IF xRec."Accountability Center" <> "Accountability Center" THEN BEGIN
                    RecreateSalesLines(FIELDCAPTION("Accountability Center"));
                    "Assigned User ID" := '';
                END;
            end;
        }
        field(50004; "Expected Delivery Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Transport Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "CN No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Dispatch Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "M.R."; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Manual Field';
        }
        field(50009; Cases; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'Manual Field';
        }
        field(50010; "Doc. Thru."; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Manual Field';
        }
        field(50011; "Special Discount"; Decimal)
        {
            DataClassification = ToBeClassified;
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
                UpdateSalesLines(FIELDCAPTION("Document Profile"), CurrFieldNo <> 0);
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
    IF NOT UserSetupMgt.CheckRespCenter(0,"Responsibility Center") THEN
      ERROR(
        Text022,
        RespCenter.TABLECAPTION,UserSetupMgt.GetSalesFilter);

    ArchiveManagement.AutoArchiveSalesDocument(Rec);
    PostSalesDelete.DeleteHeader(
      Rec,SalesShptHeader,SalesInvHeader,SalesCrMemoHeader,ReturnRcptHeader,
    #9..44

    IF IdentityManagement.IsInvAppId AND CustInvoiceDisc.GET(SalesHeader."Invoice Disc. Code") THEN
      CustInvoiceDisc.DELETE; // Cleanup of autogenerated cust. invoice discounts
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CompanyInfo.GET;
    IF NOT CompanyInfo."Activate Local Resp. Center" THEN BEGIN
    #1..4
    END ELSE BEGIN
      IF NOT UserSetupMgt.CheckRespCenter(0,"Accountability Center") THEN
        ERROR(
          Text022,
          AccCenter.TABLECAPTION,UserSetupMgt.GetSalesFilter);
    END;
    #6..47
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: NoSeries) (VariableCollection) on "InitInsert(PROCEDURE 61)".



    //Unsupported feature: Code Modification on "InitInsert(PROCEDURE 61)".

    //procedure InitInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := FALSE;
    OnBeforeInitInsert(Rec,xRec,IsHandled);
    IF NOT IsHandled THEN
      IF "No." = '' THEN BEGIN
        TestNoSeries;
        NoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. Series","Posting Date","No.","No. Series");
      END;

    OnInitInsertOnBeforeInitRecord(Rec,xRec);
    InitRecord;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
        NoSeries.GET(GetNoSeriesCode2);
      IF (NOT NoSeries."Default Nos.") AND SelectNoSeriesAllowed AND NoSeriesMgt.IsSeriesSelected THEN
        "No." := NoSeriesMgt.GetNextNo(NoSeries.Code,"Posting Date",TRUE)
      ELSE
    #6..10
    "Assigned User ID" := USERID;
    */
    //end;


    //Unsupported feature: Code Modification on "InitRecord(PROCEDURE 10)".

    //procedure InitRecord();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetSalesSetup;
    IsHandled := FALSE;
    OnBeforeInitRecord(Rec,IsHandled);
    #4..41
      END;

    IF "Document Type" IN ["Document Type"::Order,"Document Type"::Invoice,"Document Type"::Quote] THEN
      "Shipment Date" := WORKDATE;

    IF NOT ("Document Type" IN ["Document Type"::"Blanket Order","Document Type"::Quote]) AND
       ("Posting Date" = 0D)
    #49..71
    "Doc. No. Occurrence" := ArchiveManagement.GetNextOccurrenceNo(DATABASE::"Sales Header","Document Type","No.");

    OnAfterInitRecord(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..44
      BEGIN
      "Shipment Date" := WORKDATE;
      //"Order Date" := WORKDATE; will be filled manually
    END;
    IF "Document Type" = "Document Type"::"Return Order" THEN
      "Order Date" := WORKDATE;
    #46..74
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
      IF SalesLinesExist THEN
        UpdateAllLineDim("Dimension Set ID",OldDimSetID);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
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

    #7..10
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
            SalesLine."Dimension Set ID",SalesLine."Shortcut Dimension 1 Code",SalesLine."Shortcut Dimension 2 Code");

          OnUpdateAllLineDimOnBeforeSalesLineModify(SalesLine);
          SalesLine.MODIFY;
          ATOLink.UpdateAsmDimFromSalesLine(SalesLine);
        END;
      UNTIL SalesLine.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..26
          //SRT Jan 27th 2020 >>
          SalesLine."Shortcut Dimension 3 Code" := '';
          SalesLine."Shortcut Dimension 4 Code" := '';
          SalesLine."Shortcut Dimension 5 Code" := '';
          SalesLine."Shortcut Dimension 6 Code" := '';
          SalesLine."Shortcut Dimension 7 Code" := '';
          SalesLine."Shortcut Dimension 8 Code" := '';
          GLSetup.GET;
          DimSetEntry.RESET;
          DimSetEntry.SETRANGE("Dimension Set ID",SalesLine."Dimension Set ID");
          IF DimSetEntry.FINDFIRST THEN REPEAT
            IF DimSetEntry."Dimension Code" = GLSetup."Shortcut Dimension 3 Code" THEN
              SalesLine."Shortcut Dimension 3 Code" := DimSetEntry."Dimension Value Code"
            ELSE IF DimSetEntry."Dimension Code" = GLSetup."Shortcut Dimension 4 Code" THEN
              SalesLine."Shortcut Dimension 4 Code" := DimSetEntry."Dimension Value Code"
            ELSE IF DimSetEntry."Dimension Code" = GLSetup."Shortcut Dimension 5 Code" THEN
              SalesLine."Shortcut Dimension 5 Code" := DimSetEntry."Dimension Value Code"
            ELSE IF DimSetEntry."Dimension Code" = GLSetup."Shortcut Dimension 6 Code" THEN
              SalesLine."Shortcut Dimension 6 Code" := DimSetEntry."Dimension Value Code"
            ELSE IF DimSetEntry."Dimension Code" = GLSetup."Shortcut Dimension 7 Code" THEN
              SalesLine."Shortcut Dimension 7 Code" := DimSetEntry."Dimension Value Code"
            ELSE IF DimSetEntry."Dimension Code" = GLSetup."Shortcut Dimension 8 Code" THEN
              SalesLine."Shortcut Dimension 8 Code" := DimSetEntry."Dimension Value Code"
          UNTIL DimSetEntry.NEXT = 0;
          //SRT Jan 27th 2020
    #27..32
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: SysMgt) (VariableCollection) on "SetSecurityFilterOnRespCenter(PROCEDURE 43)".



    //Unsupported feature: Code Modification on "SetSecurityFilterOnRespCenter(PROCEDURE 43)".

    //procedure SetSecurityFilterOnRespCenter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := FALSE;
    OnBeforeSetSecurityFilterOnRespCenter(Rec,IsHandled);
    IF (NOT IsHandled) AND (UserSetupMgt.GetSalesFilter <> '') THEN BEGIN
      FILTERGROUP(2);
      SETRANGE("Responsibility Center",UserSetupMgt.GetSalesFilter);
      FILTERGROUP(0);
    END;

    SETRANGE("Date Filter",0D,WORKDATE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    IF UserSetupMgt.GetSalesFilter <> '' THEN BEGIN
      CompanyInfo.GET;
      FILTERGROUP(2);
      IF NOT CompanyInfo."Activate Local Resp. Center" THEN
        SETRANGE("Responsibility Center",UserSetupMgt.GetSalesFilter)
      ELSE
        SETFILTER("Accountability Center",SysMgt.GetUserRespCenterFilter);
      FILTERGROUP(0);
    END;

    SETRANGE("Date Filter",0D,WORKDATE);
    */
    //end;


    //Unsupported feature: Code Modification on "CreateDimSetForPrepmtAccDefaultDim(PROCEDURE 73)".

    //procedure CreateDimSetForPrepmtAccDefaultDim();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesLine.SETRANGE("Document Type","Document Type");
    SalesLine.SETRANGE("Document No.","No.");
    SalesLine.SETFILTER("Prepmt. Amt. Inv.",'<>%1',0);
    #4..8
    TempSalesLine.MARKEDONLY(FALSE);
    IF TempSalesLine.FINDSET THEN
      REPEAT
        SalesLine.CreateDim(DATABASE::"G/L Account",TempSalesLine."No.",
          DATABASE::Job,TempSalesLine."Job No.",
          DATABASE::"Responsibility Center",TempSalesLine."Responsibility Center");
      UNTIL TempSalesLine.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CompanyInfo.GET;
    #1..11
        IF NOT CompanyInfo."Activate Local Resp. Center" THEN
        SalesLine.CreateDim(DATABASE::"G/L Account",TempSalesLine."No.",
          DATABASE::Job,TempSalesLine."Job No.",
          DATABASE::"Responsibility Center",TempSalesLine."Responsibility Center")
        ELSE
          SalesLine.CreateDim(DATABASE::"G/L Account",TempSalesLine."No.",
            DATABASE::Job,TempSalesLine."Job No.",
            DATABASE::"Accountability Center",TempSalesLine."Accountability Center")
      UNTIL TempSalesLine.NEXT = 0;
    */
    //end;


    //Unsupported feature: Code Modification on "CollectParamsInBufferForCreateDimSet(PROCEDURE 72)".

    //procedure CollectParamsInBufferForCreateDimSet();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TempSalesLine.SETRANGE("Gen. Bus. Posting Group",SalesLine."Gen. Bus. Posting Group");
    TempSalesLine.SETRANGE("Gen. Prod. Posting Group",SalesLine."Gen. Prod. Posting Group");
    IF NOT TempSalesLine.FINDFIRST THEN BEGIN
    #4..8
      IF NOT TempSalesLine.MARK THEN BEGIN
        TempSalesLine.SETRANGE("Job No.",SalesLine."Job No.");
        TempSalesLine.SETRANGE("Responsibility Center",SalesLine."Responsibility Center");
        OnCollectParamsInBufferForCreateDimSetOnAfterSetTempSalesLineFilters(TempSalesLine,SalesLine);
        IF TempSalesLine.ISEMPTY THEN
          InsertTempSalesLineInBuffer(TempSalesLine,SalesLine,TempSalesLine."No.",FALSE);
      END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CompanyInfo.GET;
    #1..11
        IF NOT CompanyInfo."Activate Local Resp. Center" THEN
          TempSalesLine.SETRANGE("Responsibility Center",SalesLine."Responsibility Center")
        ELSE
          TempSalesLine.SETRANGE("Accountability Center",SalesLine."Accountability Center");
    #12..15
    */
    //end;


    //Unsupported feature: Code Modification on "InsertTempSalesLineInBuffer(PROCEDURE 71)".

    //procedure InsertTempSalesLineInBuffer();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TempSalesLine.INIT;
    TempSalesLine."Line No." := SalesLine."Line No.";
    TempSalesLine."No." := AccountNo;
    TempSalesLine."Job No." := SalesLine."Job No.";
    TempSalesLine."Responsibility Center" := SalesLine."Responsibility Center";
    TempSalesLine."Gen. Bus. Posting Group" := SalesLine."Gen. Bus. Posting Group";
    TempSalesLine."Gen. Prod. Posting Group" := SalesLine."Gen. Prod. Posting Group";
    TempSalesLine.MARK := DefaultDimensionsNotExist;
    OnInsertTempSalesLineInBufferOnBeforeTempSalesLineInsert(TempSalesLine,SalesLine);
    TempSalesLine.INSERT;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    IF NOT CompanyInfo."Activate Local Resp. Center" THEN
      TempSalesLine."Responsibility Center" := SalesLine."Responsibility Center"
    ELSE
      TempSalesLine."Accountability Center" := SalesLine."Accountability Center";

    #6..10
    */
    //end;


    //Unsupported feature: Code Modification on "InitFromContact(PROCEDURE 126)".

    //procedure InitFromContact();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesLine.RESET;
    SalesLine.SETRANGE("Document Type","Document Type");
    SalesLine.SETRANGE("Document No.","No.");
    #4..7
      GetSalesSetup;
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
    #1..10
      IF NOT CompanyInfo."Activate Local Resp. Center" THEN
        InitRecord
      ELSE
        InitRecord;
    #12..14
    */
    //end;


    //Unsupported feature: Code Modification on "InitFromTemplate(PROCEDURE 118)".

    //procedure InitFromTemplate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesLine.RESET;
    SalesLine.SETRANGE("Document Type","Document Type");
    SalesLine.SETRANGE("Document No.","No.");
    #4..7
      GetSalesSetup;
      "No. Series" := xRec."No. Series";
      OnInitFromTemplateOnBeforeInitRecord(Rec,xRec);
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
    #1..10
      IF NOT CompanyInfo."Activate Local Resp. Center" THEN
        InitRecord
      ELSE
        InitRecord;
    #12..14
    */
    //end;

    local procedure "--Customizations--"()
    begin
    end;

    local procedure GetNoSeriesCode2(): Code[10]
    begin
        CASE "Document Type" OF
            "Document Type"::Quote:
                EXIT(SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Sales, DocumentType::Quote));
            "Document Type"::Order:
                EXIT(SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Sales, DocumentType::Order));
            "Document Type"::Invoice:
                BEGIN
                    CASE "Document Profile" OF
                        "Document Profile"::Service:
                            EXIT(SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Service, DocumentType::Invoice));
                        ELSE
                            EXIT(SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Sales, DocumentType::Invoice));
                    END;
                END;
            "Document Type"::"Return Order":
                EXIT(SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Sales, DocumentType::"Return Order"));
            "Document Type"::"Credit Memo":
                BEGIN
                    CASE "Document Profile" OF
                        "Document Profile"::Service:
                            EXIT(SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Service, DocumentType::"Credit Memo"));
                        ELSE
                            EXIT(SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Sales, DocumentType::"Credit Memo"));
                    END;
                END;
            "Document Type"::"Blanket Order":
                EXIT(SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Sales, DocumentType::"Blanket Order"));
        END;
    end;

    procedure InitRecord2()
    begin
        SalesSetup.GET;
        CASE "Document Type" OF
            "Document Type"::Quote, "Document Type"::Order:
                BEGIN
                    NoSeriesMgt.SetDefaultSeries("Posting No. Series",
                                                  SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Sales, DocumentType::"Posted Invoice"));
                    NoSeriesMgt.SetDefaultSeries("Shipping No. Series",
                                                  SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Sales, DocumentType::"Posted Shipment"));

                    IF "Document Type" = "Document Type"::Order THEN BEGIN
                        NoSeriesMgt.SetDefaultSeries("Prepayment No. Series",
                                                    SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Sales, DocumentType::"Posted Prepmt. Inv.")
                );
                        NoSeriesMgt.SetDefaultSeries("Prepmt. Cr. Memo No. Series",
                                                    SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Sales,
                                                    DocumentType::"Posted Prepmt. Cr. Memo"));
                    END;

                END;
            "Document Type"::Invoice:
                BEGIN
                    IF ("No. Series" <> '') AND
                       (SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Sales, DocumentType::Invoice) =
                       SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Sales, DocumentType::"Posted Invoice"))
                    THEN
                        "Posting No. Series" := "No. Series"
                    ELSE
                        NoSeriesMgt.SetDefaultSeries("Posting No. Series",
                                                      SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Sales, DocumentType::"Posted Invoice"));
                    IF SalesSetup."Shipment on Invoice" THEN
                        NoSeriesMgt.SetDefaultSeries("Shipping No. Series",
                                                      SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Sales, DocumentType::"Posted Shipment"));
                END;
            "Document Type"::"Return Order":
                BEGIN
                    NoSeriesMgt.SetDefaultSeries("Posting No. Series",
                                                  SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Sales, DocumentType::"Posted Credit Memo"))
              ;
                    NoSeriesMgt.SetDefaultSeries("Return Receipt No. Series",
                                                  SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Sales,
                                                  DocumentType::"Posted Return Receipt"));
                END;
            "Document Type"::"Credit Memo":
                BEGIN
                    IF ("No. Series" <> '') AND
                       (SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Sales, DocumentType::"Credit Memo") =
                        SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Sales, DocumentType::"Posted Credit Memo"))
                    THEN
                        "Posting No. Series" := "No. Series"
                    ELSE
                        NoSeriesMgt.SetDefaultSeries("Posting No. Series",
                                                     SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Sales, DocumentType::"Posted Credit Memo")
                );
                    IF SalesSetup."Return Receipt on Credit Memo" THEN
                        NoSeriesMgt.SetDefaultSeries("Return Receipt No. Series",
                                                      SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Sales,
                                                      DocumentType::"Posted Return Receipt"));
                END;
        END;

        IF "Document Type" IN ["Document Type"::Order, "Document Type"::Invoice, "Document Type"::Quote] THEN BEGIN
            "Shipment Date" := WORKDATE;
            //"Order Date" := WORKDATE; will be filled manually
        END;
        IF "Document Type" = "Document Type"::"Return Order" THEN
            "Order Date" := WORKDATE;

        IF NOT ("Document Type" IN ["Document Type"::"Blanket Order", "Document Type"::Quote]) AND
           ("Posting Date" = 0D)
        THEN
            "Posting Date" := WORKDATE;

        IF SalesSetup."Default Posting Date" = SalesSetup."Default Posting Date"::"No Date" THEN
            "Posting Date" := 0D;

        "Document Date" := WORKDATE;
        // Below Code is commented to get default location from user setup table
        //VALIDATE("Location Code",UserSetupMgt.GetLocation(0,Cust."Location Code","Responsibility Center")); Standard
        // Sipradi-YS GEN6.1.0 * Code to get default location
        // Sipradi-YS END
        IF "Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"] THEN BEGIN
            GLSetup.GET;
            Correction := GLSetup."Mark Cr. Memos as Corrections";
        END;

        "Posting Description" := FORMAT("Document Type") + ' ' + "No.";

        Reserve := Reserve::Optional;

        IF InvtSetup.GET THEN
            VALIDATE("Outbound Whse. Handling Time", InvtSetup."Outbound Whse. Handling Time");
        CompanyInfo.GET;
        IF NOT CompanyInfo."Activate Local Resp. Center" THEN
            "Responsibility Center" := UserSetupMgt.GetRespCenter(0, "Responsibility Center")
        ELSE
            "Accountability Center" := UserSetupMgt.GetRespCenter(0, "Accountability Center");
        VALIDATE("Location Code", UserSetupMgt.GetLocation2);
    end;

    local procedure "--SRT--"()
    begin
    end;

    local procedure GetShortcutDimensionsInfo(DimSetID: Integer; var ShortcutDimCode: array[8] of Code[20])
    var
        DimMgt: Codeunit DimensionManagement;

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

    //Unsupported feature: Property Modification (Id) on "InitInsert(PROCEDURE 61).IsHandled(Variable 1000)".


    //Unsupported feature: Property Modification (Id) on "UpdateAllLineDim(PROCEDURE 34).IsHandled(Variable 1005)".


    //Unsupported feature: Property Modification (Id) on "SetSecurityFilterOnRespCenter(PROCEDURE 43).IsHandled(Variable 1000)".


    var
        Customer: Record Customer;
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        UserSetupMgt: Codeunit "User Setup Management";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        InvtSetup: Record "Inventory Setup";
        SalesSetup: Record "Sales & Receivables Setup";//3.11.2022



    var
        "--AccCenter--": Integer;
        AccCenter: Record "Accountability Center";
        AccCenter2: Record "Accountability Center";
        SysMgt: Codeunit "System Mgt. Quest";
        DocumentProfile: Option Purchase,Sales,Service,Transfer;
        DocumentType: Option Quote,"Blanket Order","Order","Return Order",Invoice,"Posted Invoice","Credit Memo","Posted Credit Memo","Posted Shipment","Posted Receipt","Posted Prepmt. Inv.","Posted Prepmt. Cr. Memo","Posted Return Receipt","Posted Return Shipment",Booking,"Posted Order","Posted Debit Note";
        ShortcutDimCode: array[8] of Code[20];
}

