tableextension 50038 "tableextension70000563" extends "Purchase Line"
{
    fields
    {

        //Unsupported feature: Code Modification on "Type(Field 5).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchHeader;
        TestStatusOpen;

        #4..54

        Type := TempPurchLine.Type;
        "System-Created Entry" := TempPurchLine."System-Created Entry";
        OnValidateTypeOnCopyFromTempPurchLine(Rec,TempPurchLine);
        VALIDATE("FA Posting Type");

        IF Type = Type::Item THEN
          "Allow Item Charge Assignment" := TRUE
        ELSE
          "Allow Item Charge Assignment" := FALSE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..57
        "External Entry" := TempPurchLine."External Entry"; //SRT July 4th 2019
        #58..64
        */
        //end;


        //Unsupported feature: Code Modification on ""No."(Field 6).OnValidate".

        //trigger "(Field 6)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchSetup;

        "No." := FindOrCreateRecordByNo("No.");

        TestStatusOpen;
        TESTFIELD("Qty. Rcd. Not Invoiced",0);
        #7..59
        END;

        "System-Created Entry" := TempPurchLine."System-Created Entry";
        GetPurchHeader;
        InitHeaderDefaults(PurchHeader);
        UpdateLeadTimeFields;
        #66..132
          UpdateJobPrices;
          UpdateDimensionsFromJobTask;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        CheckDuplicateItemLine; //SRT Jan 21st 2020
        #4..62
        "External Entry" := TempPurchLine."External Entry"; //SRT July 4th 2019
        #63..135
        */
        //end;


        //Unsupported feature: Code Modification on "Quantity(Field 15).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        IsHandled := FALSE;
        OnValidateQuantityOnBeforeDropShptCheck(Rec,xRec,CurrFieldNo,IsHandled);
        IF NOT IsHandled THEN
        #5..85
        END;

        CheckWMS;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        CheckDuplicateItemLine; //SRT Jan 21st 2020
        SingleQtyRestriction; //KMT2016CU5
        #2..88
        */
        //end;


        //Unsupported feature: Code Modification on ""Direct Unit Cost"(Field 22).OnValidate".

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
        #4..30
              "Direct Unit Cost" * (100 + "VAT %") / (100 + xRec."VAT %"),
              Currency."Unit-Amount Rounding Precision"));
        UpdateAmounts;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..33
        IRDMgt.GetCustomVATPostingSetupOnPurchLine(Rec,xRec,FIELDNO("VAT Prod. Posting Group"));
        */
        //end;
        field(50000; "FA Item Charge"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Charge";

            trigger OnValidate()
            begin
                SingleQtyRestriction; //KMT2016CU5
            end;
        }
        field(50004; "Accountability Center"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Accountability Center";
        }
        field(50005; "External Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'To know whether entry is from Amnil Technologies or not';
        }
        field(50019; "Purchase Consignment No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'VAT1.00';

            trigger OnValidate()
            begin
                TESTFIELD("Quantity Received", 0); //Agile ZM
                TESTFIELD("Quantity Invoiced", 0); //Agile ZM
            end;
        }
        field(50401; "Document Profile"; Option)
        {
            Caption = 'Document Profile';
            DataClassification = ToBeClassified;
            Description = 'NP15.1001';
            OptionCaption = ' ,Spare Parts Trade,Vehicles Trade,Service';
            OptionMembers = " ","Spare Parts Trade","Vehicles Trade",Service;
        }
        field(50501; PragyapanPatra; Code[100])
        {
            DataClassification = ToBeClassified;
            Description = 'NP15.1001';
            TableRelation = PragyapanPatra.Code;

            trigger OnValidate()
            begin
                //TESTFIELD("Quantity Invoiced",0); //Agile ZM
            end;
        }
        field(50502; "Localized VAT Identifier"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'NP15.1001';
            OptionCaption = ' ,Taxable Import Purchase,Exempt Purchase,Taxable Local Purchase,Taxable Capex Purchase,Taxable Sales,Non Taxable Sales,Exempt Sales,Prepayments,Purchase Without VAT Invoice,Sales without VAT Invoice,Direct Sales';
            OptionMembers = " ","Taxable Import Purchase","Exempt Purchase","Taxable Local Purchase","Taxable Capex Purchase","Taxable Sales","Non Taxable Sales","Exempt Sales",Prepayments,"Purchase Without VAT Invoice","Sales without VAT Invoice","Direct Sales";
        }
        field(50504; "Returned Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50505; "Returned Document Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(55011; "Amount to Assign"; Decimal)
        {
            CalcFormula = Sum("Item Charge Assignment (Purch)"."Amount to Assign" WHERE("Document Type" = FIELD("Document Type"),
                                                                                         "Document No." = FIELD("Document No."),
                                                                                         "Document Line No." = FIELD("Line No.")));
            Caption = 'Amount to Assign';
            DecimalPlaces = 0 : 5;
            Description = 'COGS1.0';
            Editable = false;
            FieldClass = FlowField;
        }
        field(59000; "TDS Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'TDS1.00';
            TableRelation = "TDS Posting Group".Code WHERE(Type = FILTER("Purchase TDS"),
                                                            Blocked = CONST(false));

            trigger OnValidate()
            begin
                // TDS1.00 >>
                ClearTDSFields;

                TDSPostingGroup.RESET;
                TDSPostingGroup.SETRANGE(Code, "TDS Group");
                IF TDSPostingGroup.FINDFIRST THEN BEGIN
                    TDSPostingGroup.TESTFIELD("TDS%");
                    TDSPostingGroup.TESTFIELD("GL Account No.");
                    "TDS Type" := "TDS Type"::"Purchase TDS";
                    "TDS%" := TDSPostingGroup."TDS%";
                END;
                // TDS1.00 <<
            end;
        }
        field(59001; "TDS%"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'TDS1.00';
            Editable = false;
        }
        field(59002; "TDS Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'TDS1.00';
            Editable = false;
            OptionCaption = ' ,Purchase TDS,Sales TDS';
            OptionMembers = " ","Purchase TDS","Sales TDS";
        }
        field(59003; "TDS Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'TDS1.00';
            Editable = false;
        }
        field(59004; "TDS Base Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'TDS1.00';
            Editable = false;
        }
        field(59005; "Document Class"; Option)
        {
            Caption = 'Document Class';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Customer,Vendor,Bank Account,Fixed Assets';
            OptionMembers = " ",Customer,Vendor,"Bank Account","Fixed Assets";
        }
        field(59006; "Document Subclass"; Code[20])
        {
            Caption = 'Document Subclass';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Document Class" = CONST(Customer)) Customer
            ELSE
            IF ("Document Class" = CONST(Vendor)) Vendor
            ELSE
            IF ("Document Class" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Document Class" = CONST("Fixed Assets")) "Fixed Asset";
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

    //Unsupported feature: Variable Insertion (Variable: CompanyInfo) (VariableCollection) on "InitHeaderDefaults(PROCEDURE 97)".



    //Unsupported feature: Code Modification on "InitHeaderDefaults(PROCEDURE 97)".

    //procedure InitHeaderDefaults();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PurchHeader.TESTFIELD("Buy-from Vendor No.");

    "Buy-from Vendor No." := PurchHeader."Buy-from Vendor No.";
    "Currency Code" := PurchHeader."Currency Code";
    "Expected Receipt Date" := PurchHeader."Expected Receipt Date";
    "Shortcut Dimension 1 Code" := PurchHeader."Shortcut Dimension 1 Code";
    "Shortcut Dimension 2 Code" := PurchHeader."Shortcut Dimension 2 Code";
    IF NOT IsNonInventoriableItem THEN
      "Location Code" := PurchHeader."Location Code";
    "Transaction Type" := PurchHeader."Transaction Type";
    #11..22
      "Prepayment %" := PurchHeader."Prepayment %";
    "Prepayment Tax Area Code" := PurchHeader."Tax Area Code";
    "Prepayment Tax Liable" := PurchHeader."Tax Liable";
    "Responsibility Center" := PurchHeader."Responsibility Center";
    "Requested Receipt Date" := PurchHeader."Requested Receipt Date";
    "Promised Receipt Date" := PurchHeader."Promised Receipt Date";
    "Inbound Whse. Handling Time" := PurchHeader."Inbound Whse. Handling Time";
    "Order Date" := PurchHeader."Order Date";

    OnAfterInitHeaderDefaults(Rec,PurchHeader);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    //SRT Jan 27th 2020 >>
    "Shortcut Dimension 3 Code" := PurchHeader."Shortcut Dimension 3 Code";
    "Shortcut Dimension 4 Code" := PurchHeader."Shortcut Dimension 4 Code";
    "Shortcut Dimension 5 Code" := PurchHeader."Shortcut Dimension 5 Code";
    "Shortcut Dimension 6 Code" := PurchHeader."Shortcut Dimension 6 Code";
    "Shortcut Dimension 7 Code" := PurchHeader."Shortcut Dimension 7 Code";
    "Shortcut Dimension 8 Code" := PurchHeader."Shortcut Dimension 8 Code";
    //SRT Jan 27th 2020 <<
    #8..25
    CompanyInfo.GET;
    IF NOT CompanyInfo."Activate Local Resp. Center" THEN
      "Responsibility Center" := PurchHeader."Responsibility Center"
    ELSE
      "Accountability Center" := PurchHeader."Accountability Center";

    #27..30
    PragyapanPatra := PurchHeader.PragyapanPatra; //SRT Dec 16th 2019

    OnAfterInitHeaderDefaults(Rec,PurchHeader);
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
    IsChanged := OldDimSetID <> "Dimension Set ID";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
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

    local procedure ClearTDSFields()
    begin
        //TDS1.00
        "TDS%" := 0;
        "TDS Type" := "TDS Type"::" ";
        "TDS Amount" := 0;
        "TDS Base Amount" := 0;
        //TDS1.00
    end;

    local procedure "--SRT--"()
    begin
    end;

    local procedure SingleQtyRestriction()
    begin
        IF Type = Type::"Fixed Asset" THEN BEGIN
            IF (Quantity > 1) AND ("FA Item Charge" <> '') THEN
                ERROR(Text055, "Line No.");
        END;
    end;

    procedure CheckDuplicateItemLine()
    var
        DuplicatePurchaseItemLine: Record "Purchase Line";
        DuplicateErrExistMsg: Label 'Item %1 has been selected already in line no. %2 for Purchase document no. %3.';
    begin
        //SRT Jan 21st 2020 >>
        IF Type <> Type::Item THEN
            EXIT;

        PurchSetup.GET;
        IF PurchSetup."Block Same Purchase Item Line" THEN BEGIN
            DuplicatePurchaseItemLine.RESET;
            DuplicatePurchaseItemLine.SETRANGE("Document Type", "Document Type");
            DuplicatePurchaseItemLine.SETRANGE("Document No.", "Document No.");
            DuplicatePurchaseItemLine.SETRANGE("No.", "No.");
            DuplicatePurchaseItemLine.SETFILTER("Line No.", '<>%1', "Line No.");
            IF DuplicatePurchaseItemLine.FINDFIRST THEN
                ERROR(DuplicateErrExistMsg, "No.", DuplicatePurchaseItemLine."Line No.", "Document No.");
        END;
        //SRT Jan 21st 2020 <<
    end;

    //Unsupported feature: Property Modification (Id) on "ShowDimensions(PROCEDURE 25).OldDimSetID(Variable 1000)".


    var
        FindRecordMgt: Codeunit "Find Record Management";
        // "--SRT--": Integer;//change/3.14.2022
        DuplicatePurchaseItemLine: Record "Purchase Line";

    var
        TDSPostingGroup: Record "TDS Posting Group";
        "--Customizations--": Integer;
        IRDMgt: Codeunit "IRD Mgt.";
        PurchSetup: Record "Purchases & Payables Setup";
        Text055: Label 'Quantity must be 1 in Line No. %1 if the FA Item Charge is not blank.';
}

