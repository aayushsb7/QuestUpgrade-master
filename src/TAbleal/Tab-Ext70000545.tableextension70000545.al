tableextension 50025 "Sales Line" extends "Sales Line"
{
    fields
    {
        modify("No.")
        {
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            ELSE
            IF (Type = CONST("G/L Account"),
                "System-Created Entry" = CONST(false)) "G/L Account" WHERE("Direct Posting" = CONST(true),
                "Account Type" = CONST(Posting),
                Blocked = CONST(false))
            ELSE
            IF (Type = CONST("G/L Account"),
                  "System-Created Entry" = CONST(true)) "G/L Account"
            ELSE
            IF (Type = CONST(Resource)) Resource
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF (Type = CONST("Charge (Item)")) "Item Charge"
            ELSE
            IF (Type = CONST(Item), "Document Type" = FILTER(<> "Credit Memo" & <> "Return Order")) Item WHERE("Inventory Posting Group" = CONST(FG),
                   Blocked = CONST(No),
                  "Sales Blocked" = CONST(No))
            ELSE
            IF (Type = CONST(Item),
                                  " Document Type" = FILTER("Credit Memo" | "Return Order")) Item WHERE(Blocked = CONST(No));
        }

        //Unsupported feature: Code Modification on ""Shipment Date"(Field 10).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
        IF CurrFieldNo <> 0 THEN
        #4..15

          IF ("Shipment Date" < WORKDATE) AND HasTypeToFillMandatoryFields THEN
            IF NOT (GetHideValidationDialog OR HasBeenShown) AND GUIALLOWED THEN BEGIN
              MESSAGE(
                Text014,
                FIELDCAPTION("Shipment Date"),"Shipment Date",WORKDATE);
              HasBeenShown := TRUE;
            END;
        END;
        #25..33
          "Planned Shipment Date" := CalcPlannedShptDate(FIELDNO("Shipment Date"));
        IF NOT PlannedDeliveryDateCalculated THEN
          "Planned Delivery Date" := CalcPlannedDeliveryDate(FIELDNO("Shipment Date"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..18
              {MESSAGE(
                Text014,
                FIELDCAPTION("Shipment Date"),"Shipment Date",WORKDATE);}
        #22..36
        */
        //end;


        //Unsupported feature: Code Modification on ""Unit Price"(Field 22).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        VALIDATE("Line Discount %");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        VALIDATE("Line Discount %");

        //ASPL >>
        IF "Unit Price" = 0 THEN
          CLEAR("Maximum Retail Price");
        //ASPL <<
        */
        //end;


        //Unsupported feature: Code Modification on ""VAT Prod. Posting Group"(Field 90).OnValidate".

        //trigger  Posting Group"(Field 90)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        IF "Prepmt. Amt. Inv." <> 0 THEN
          ERROR(CannotChangeVATGroupWithPrepmInvErr);
        #4..31
              "Unit Price" * (100 + "VAT %") / (100 + xRec."VAT %"),
              Currency."Unit-Amount Rounding Precision"));
        UpdateAmounts;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..34
        IRDMgt.GetCustomVATPostingSetupOnSalesLine(Rec,xRec,FIELDNO("VAT Prod. Posting Group"));
        */
        //end;


        //Unsupported feature: Code Modification on ""Return Qty. to Receive"(Field 5803).OnValidate".

        //trigger  to Receive"(Field 5803)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (CurrFieldNo <> 0) AND
           (Type = Type::Item) AND
           ("Return Qty. to Receive" <> 0) AND
        #4..30

        IF (CurrFieldNo <> 0) AND (Type = Type::Item) AND ("Return Qty. to Receive" > 0) THEN
          CheckApplFromItemLedgEntry(ItemLedgEntry);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..33
        //ASPL >>
        IF "Return Qty. to Receive" <> xRec."Return Qty. to Receive" THEN
          SysMgt.ManageFreeItemSalesReturnLine(Rec);
        //ASPL <<
        */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Return Reason Code"(Field 6608).OnValidate".

        //trigger (Variable: FreeSalesLine)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""Return Reason Code"(Field 6608).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateReturnReasonCode(FIELDNO("Return Reason Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ValidateReturnReasonCode(FIELDNO("Return Reason Code"));
        IF "Line No." <> 0 THEN BEGIN
          FreeSalesLine.RESET;
          FreeSalesLine.SETRANGE("Document Type","Document Type");
          FreeSalesLine.SETRANGE("Document No.","Document No.");
          FreeSalesLine.SETRANGE("Sales Line No.","Returned Document Line No.");
          IF FreeSalesLine.FINDFIRST THEN REPEAT
            FreeSalesLine."Return Reason Code" := "Return Reason Code";
            FreeSalesLine.MODIFY(TRUE);
          UNTIL FreeSalesLine.NEXT = 0;
        END;
        */
        //end;
        field(50000; "Maximum Retail Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Accountability Center"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Accountability Center";
        }
        field(50004; "Free Item Line"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'To recognize whether it is free quantity line or not';
        }
        field(50005; "Sales Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'To link sales line no. with free item line';
        }
        field(50006; "Batch No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Value will be passed from another software';
        }
        field(50007; "Manufacturing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Purchase Consignment No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'VAT1.00';
        }
        field(50021; PragyapanPatra; Code[100])
        {
            DataClassification = ToBeClassified;
            Description = 'NP15.1001';
        }
        field(50401; "Document Profile"; Option)
        {
            Caption = 'Document Profile';
            DataClassification = ToBeClassified;
            Description = 'NP15.1001';
            OptionCaption = ' ,Spare Parts Trade,Vehicles Trade,Service';
            OptionMembers = " ","Spare Parts Trade","Vehicles Trade",Service;
        }
        field(50501; "Localized VAT Identifier"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'NP15.1001';
            OptionCaption = ' ,Taxable Import Purchase,Exempt Purchase,Taxable Local Purchase,Taxable Capex Purchase,Taxable Sales,Non Taxable Sales,Exempt Sales,Prepayments,Purchase Without VAT Invoice,Sales without VAT Invoice,Direct Sales';
            OptionMembers = " ","Taxable Import Purchase","Exempt Purchase","Taxable Local Purchase","Taxable Capex Purchase","Taxable Sales","Non Taxable Sales","Exempt Sales",Prepayments,"Purchase Without VAT Invoice","Sales without VAT Invoice","Direct Sales";

            trigger OnValidate()
            begin
                TestStatusOpen;
            end;
        }
        field(50502; "Returned Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50503; "Returned Document Line No."; Integer)
        {
            DataClassification = ToBeClassified;
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


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

    //trigger (Variable: --SRT)()
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TestStatusOpen;

    IF (Quantity <> 0) AND ItemExists("No.") THEN BEGIN
    #4..43
      SalesLine2.SETRANGE("Attached to Line No.","Line No.");
      SalesLine2.SETFILTER("Line No.",'<>%1',"Line No.");
      SalesLine2.DELETEALL(TRUE);
    END;

    IF "Job Contract Entry No." <> 0 THEN
    #50..70
      DeferralUtilities.DeferralCodeOnDelete(
        DeferralUtilities.GetSalesDeferralDocType,'','',
        "Document Type","Document No.","Line No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..46

      //delete free item line if exists
      FreeItemSalesLine.RESET;
      FreeItemSalesLine.SETRANGE("Document Type","Document Type");
      FreeItemSalesLine.SETRANGE("Document No.","Document No.");
      FreeItemSalesLine.SETRANGE("Free Item Line",TRUE);
      IF "Document Type" IN ["Document Type"::"Credit Memo","Document Type"::"Return Order"] THEN
        FreeItemSalesLine.SETRANGE("Sales Line No.","Returned Document Line No.")
      ELSE
        FreeItemSalesLine.SETRANGE("Sales Line No.","Line No.");
      FreeItemSalesLine.DELETEALL;
    #47..73
    */
    //end;


    //Unsupported feature: Code Modification on "InitQtyToShip(PROCEDURE 15)".

    //procedure InitQtyToShip();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetSalesSetup;
    IF (SalesSetup."Default Quantity to Ship" = SalesSetup."Default Quantity to Ship"::Remainder) OR
       ("Document Type" = "Document Type"::Invoice)
    #4..12
    OnAfterInitQtyToShip(Rec,CurrFieldNo);

    InitQtyToInvoice;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..15
    SysMgt.InsertFreeItemSalesLine(Rec); //SRT
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: DimSetEntry) (VariableCollection) on "ShowDimensions(PROCEDURE 25)".


    //Unsupported feature: Variable Insertion (Variable: GLSetup) (VariableCollection) on "ShowDimensions(PROCEDURE 25)".



    //Unsupported feature: Code Modification on "ShowDimensions(PROCEDURE 25)".

    //procedure ShowDimensions();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OldDimSetID := "Dimension Set ID";
    "Dimension Set ID" :=
      DimMgt.EditDimensionSet("Dimension Set ID",STRSUBSTNO('%1 %2 %3',"Document Type","Document No.","Line No."));
    VerifyItemLineDim;
    DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
    ATOLink.UpdateAsmDimFromSalesLine(Rec);
    IsChanged := OldDimSetID <> "Dimension Set ID";
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
    //SRT Jan 27th 2020 <<
    IsChanged := OldDimSetID <> "Dimension Set ID";
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: GLSetup) (VariableCollection) on "CreateDim(PROCEDURE 26)".


    //Unsupported feature: Variable Insertion (Variable: DimSetEntry) (VariableCollection) on "CreateDim(PROCEDURE 26)".



    //Unsupported feature: Code Modification on "CreateDim(PROCEDURE 26)".

    //procedure CreateDim();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SourceCodeSetup.GET;
    TableID[1] := Type1;
    No[1] := No1;
    #4..15
        "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code",SalesHeader."Dimension Set ID",DATABASE::Customer);
    DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
    ATOLink.UpdateAsmDimFromSalesLine(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..18

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
    */
    //end;


    //Unsupported feature: Code Modification on "ValidateShortcutDimCode(PROCEDURE 29)".

    //procedure ValidateShortcutDimCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DimMgt.ValidateShortcutDimValues(FieldNumber,ShortcutDimCode,"Dimension Set ID");
    VerifyItemLineDim;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    DimMgt.ValidateShortcutDimValues(FieldNumber,ShortcutDimCode,"Dimension Set ID");
    VerifyItemLineDim;
    //SRT Jan 27th 2020 >>
    CASE FieldNumber OF
      3:"Shortcut Dimension 3 Code" := ShortcutDimCode;
      4:"Shortcut Dimension 4 Code" := ShortcutDimCode;
      5:"Shortcut Dimension 5 Code" := ShortcutDimCode;
      6:"Shortcut Dimension 6 Code" := ShortcutDimCode;
      7:"Shortcut Dimension 7 Code" := ShortcutDimCode;
      8:"Shortcut Dimension 8 Code" := ShortcutDimCode;
    END;
    //SRT Jan 27th 2020 <<
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: CompanyInfo) (VariableCollection) on "InitHeaderDefaults(PROCEDURE 107)".



    //Unsupported feature: Code Modification on "InitHeaderDefaults(PROCEDURE 107)".

    //procedure InitHeaderDefaults();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF SalesHeader."Document Type" = SalesHeader."Document Type"::Quote THEN BEGIN
      IF (SalesHeader."Sell-to Customer No." = '') AND
         (SalesHeader."Sell-to Customer Template Code" = '')
    #4..38
      "Prepayment %" := SalesHeader."Prepayment %";
    "Prepayment Tax Area Code" := SalesHeader."Tax Area Code";
    "Prepayment Tax Liable" := SalesHeader."Tax Liable";
    "Responsibility Center" := SalesHeader."Responsibility Center";

    "Shipping Agent Code" := SalesHeader."Shipping Agent Code";
    "Shipping Agent Service Code" := SalesHeader."Shipping Agent Service Code";
    "Outbound Whse. Handling Time" := SalesHeader."Outbound Whse. Handling Time";
    "Shipping Time" := SalesHeader."Shipping Time";

    OnAfterInitHeaderDefaults(Rec,SalesHeader);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..41
    CompanyInfo.GET;
    IF NOT CompanyInfo."Activate Local Resp. Center" THEN
      "Responsibility Center" := SalesHeader."Responsibility Center"
    ELSE
      "Accountability Center" := SalesHeader."Accountability Center";
    #43..49
    */
    //end;

    //Unsupported feature: Property Modification (Id) on "ShowDimensions(PROCEDURE 25).OldDimSetID(Variable 1000)".


    var
        FreeSalesLine: Record "Sales Line";

    var
        "--SRT": Integer;
        FreeItemSalesLine: Record "Sales Line";

    var
        "--Customizations--": Integer;
        IRDMgt: Codeunit "IRD Mgt.";
        SysMgt: Codeunit "System Mgt. Quest";
}

