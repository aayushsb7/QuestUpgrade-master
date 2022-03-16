tableextension 50061 "tableextension70001247" extends "Item Journal Line"
{
    fields
    {

        //Unsupported feature: Code Modification on ""Item No."(Field 3).OnValidate".

        //trigger "(Field 3)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Item No." <> xRec."Item No." THEN BEGIN
          "Variant Code" := '';
          "Bin Code" := '';
        #4..136

        OnBeforeVerifyReservedQty(Rec,xRec,FIELDNO("Item No."));
        ReserveItemJnlLine.VerifyChange(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..139
        UpdateItemID; //SRT July 5th 2019
        */
        //end;


        //Unsupported feature: Code Insertion on ""Journal Batch Name"(Field 41)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        UpdateItemJournalBatchID; //SRT July 5th 2019
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
        }
        field(50004; "Batch No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Value will be passed from another software';
        }
        field(50005; "Manufacturing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Expiy Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50050; Id; Guid)
        {
            Caption = 'Id';
            DataClassification = ToBeClassified;
        }
        field(50051; "Item Id"; Guid)
        {
            Caption = 'Item Id';
            DataClassification = ToBeClassified;
            TableRelation = Item.Id;

            trigger OnValidate()
            begin
                UpdateItemNo; //SRT July 5th 2019
            end;
        }
        field(50052; "Item Journal Batch Id"; Guid)
        {
            Caption = 'Journal Batch Id';
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Batch".Id;

            trigger OnValidate()
            begin
                UpdateItemJournalBatchName; //SRT July 5th 2019
            end;
        }
        field(50053; "Last Modified DateTime"; DateTime)
        {
            Caption = 'Last Modified DateTime';
            DataClassification = ToBeClassified;
        }
        field(50054; "External Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'to recognize entry from third party software';
        }
        field(50055; "Is Spillage"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'value will be passed from third party software(Amnil) and the ajmt. inventory account will be redirected to spillage g/l';
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
        }
        field(50502; "Localized VAT Identifier"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'NP15.1001';
            Editable = false;
            OptionCaption = ' ,Taxable Import Purchase,Exempt Purchase,Taxable Local Purchase,Taxable Capex Purchase,Taxable Sales,Non Taxable Sales,Exempt Sales,Prepayments,Purchase Without VAT Invoice,Sales without VAT Invoice,Direct Sales';
            OptionMembers = " ","Taxable Import Purchase","Exempt Purchase","Taxable Local Purchase","Taxable Capex Purchase","Taxable Sales","Non Taxable Sales","Exempt Sales",Prepayments,"Purchase Without VAT Invoice","Sales without VAT Invoice","Direct Sales";
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


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    LOCKTABLE;
    ItemJnlTemplate.GET("Journal Template Name");
    ItemJnlBatch.GET("Journal Template Name","Journal Batch Name");
    #4..7
    ValidateNewShortcutDimCode(2,"New Shortcut Dimension 2 Code");

    CheckPlanningAssignment;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..10
    SetLastModifiedDateTime; //SRT July 5th 2019
    */
    //end;


    //Unsupported feature: Code Modification on "OnModify".

    //trigger OnModify()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeVerifyReservedQty(Rec,xRec,0);
    ReserveItemJnlLine.VerifyChange(Rec,xRec);
    CheckPlanningAssignment;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    SetLastModifiedDateTime; //SRT July 5th 2019
    */
    //end;


    //Unsupported feature: Code Modification on "SetUpNewLine(PROCEDURE 8)".

    //procedure SetUpNewLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    MfgSetup.GET;
    ItemJnlTemplate.GET("Journal Template Name");
    ItemJnlBatch.GET("Journal Template Name","Journal Batch Name");
    #4..50
    IF Location.GET("Location Code") THEN
      IF  Location."Directed Put-away and Pick" THEN
        "Location Code" := '';

    OnAfterSetupNewLine(Rec,LastItemJnlLine,ItemJnlTemplate);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..53
    UpdateItemJournalBatchID;  //SRT july 5th 2019
    Id := CREATEGUID; //SRT july 5th 2019
    OnAfterSetupNewLine(Rec,LastItemJnlLine,ItemJnlTemplate);
    */
    //end;


    //Unsupported feature: Code Modification on "CopyFromSalesHeader(PROCEDURE 58)".

    //procedure CopyFromSalesHeader();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Posting Date" := SalesHeader."Posting Date";
    "Document Date" := SalesHeader."Document Date";
    "Order Date" := SalesHeader."Order Date";
    "Source Posting Group" := SalesHeader."Customer Posting Group";
    "Salespers./Purch. Code" := SalesHeader."Salesperson Code";
    "Reason Code" := SalesHeader."Reason Code";
    "Source Currency Code" := SalesHeader."Currency Code";
    "Shpt. Method Code" := SalesHeader."Shipment Method Code";

    OnAfterCopyItemJnlLineFromSalesHeader(Rec,SalesHeader);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    //Agile ZM >>
    "Sys. LC No." := SalesHeader."Sys. LC No.";
    "Bank LC No." := SalesHeader."Bank LC No.";
    "LC Amend No." := SalesHeader."LC Amend No.";
    //Agile ZM <<
    #8..10
    */
    //end;


    //Unsupported feature: Code Modification on "CopyFromSalesLine(PROCEDURE 12)".

    //procedure CopyFromSalesLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Item No." := SalesLine."No.";
    Description := SalesLine.Description;
    "Shortcut Dimension 1 Code" := SalesLine."Shortcut Dimension 1 Code";
    #4..34
    "Source Type" := "Source Type"::Customer;
    "Source No." := SalesLine."Sell-to Customer No.";
    "Invoice-to Source No." := SalesLine."Bill-to Customer No.";

    OnAfterCopyItemJnlLineFromSalesLine(Rec,SalesLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..37
    PragyapanPatra := SalesLine.PragyapanPatra;
    "Purchase Consignment No." := SalesLine."Purchase Consignment No.";
    OnAfterCopyItemJnlLineFromSalesLine(Rec,SalesLine);
    */
    //end;


    //Unsupported feature: Code Modification on "CopyFromPurchHeader(PROCEDURE 57)".

    //procedure CopyFromPurchHeader();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Posting Date" := PurchHeader."Posting Date";
    "Document Date" := PurchHeader."Document Date";
    "Source Posting Group" := PurchHeader."Vendor Posting Group";
    "Salespers./Purch. Code" := PurchHeader."Purchaser Code";
    "Country/Region Code" := PurchHeader."Buy-from Country/Region Code";
    "Reason Code" := PurchHeader."Reason Code";
    "Source Currency Code" := PurchHeader."Currency Code";
    "Shpt. Method Code" := PurchHeader."Shipment Method Code";

    OnAfterCopyItemJnlLineFromPurchHeader(Rec,PurchHeader);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    //IME19.00 Begin
    "Sys. LC No." := PurchHeader."Sys. LC No.";
    "Bank LC No." := PurchHeader."Bank LC No.";
    "LC Amend No." := PurchHeader."LC Amend No.";
    "Purchase Consignment No." := PurchHeader."Purchase Consignment No.";
    //Agile RD NOV 30 2016
    //Agile ZM
    PragyapanPatra := PurchHeader.PragyapanPatra;
    //Agile ZM
    //IME19.00 End
    #8..10
    */
    //end;


    //Unsupported feature: Code Modification on "CopyFromPurchLine(PROCEDURE 160)".

    //procedure CopyFromPurchLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Item No." := PurchLine."No.";
    Description := PurchLine.Description;
    "Shortcut Dimension 1 Code" := PurchLine."Shortcut Dimension 1 Code";
    #4..40
    "Indirect Cost %" := PurchLine."Indirect Cost %";
    "Overhead Rate" := PurchLine."Overhead Rate";
    "Return Reason Code" := PurchLine."Return Reason Code";

    OnAfterCopyItemJnlLineFromPurchLine(Rec,PurchLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..43
    IF PurchLine.PragyapanPatra <> '' THEN
      PragyapanPatra := PurchLine.PragyapanPatra; //ratan

    OnAfterCopyItemJnlLineFromPurchLine(Rec,PurchLine);
    */
    //end;

    local procedure "--SRT--"()
    begin
    end;

    procedure GetNewLineNo(TemplateName: Code[10]; BatchName: Code[10]): Integer
    var
        ItemJournalLine: Record "Item Journal Line";
    begin
        //SRT July 5th 2019 >>
        ItemJournalLine.VALIDATE("Journal Template Name", TemplateName);
        ItemJournalLine.VALIDATE("Journal Batch Name", BatchName);
        ItemJournalLine.SETRANGE("Journal Template Name", TemplateName);
        ItemJournalLine.SETRANGE("Journal Batch Name", BatchName);
        IF ItemJournalLine.FINDLAST THEN
            EXIT(ItemJournalLine."Line No." + 1000);
        EXIT(1000);
        //SRT July 5th 2019 <<
    end;

    procedure UpdateItemID()
    var
        Item: Record Item;
    begin
        //SRT July 5th 2019 >>
        IF "Item No." = '' THEN BEGIN
            CLEAR("Item Id");
            EXIT;
        END;

        IF NOT Item.GET("Item No.") THEN
            EXIT;

        "Item Id" := Item.Id;
        //SRT July 5th 2019 <<
    end;

    local procedure UpdateItemNo()
    var
        Item: Record Item;
    begin
        //SRT July 5th 2019 >>
        IF ISNULLGUID("Item Id") THEN
            EXIT;

        Item.SETRANGE(Id, "Item Id");
        IF NOT Item.FINDFIRST THEN
            EXIT;

        "Item No." := Item."No.";
        //SRT July 5th 2019 <<
    end;

    procedure UpdateItemJournalBatchID()
    var
        ItemJnlBatch: Record "Item Journal Batch";
    begin
        //SRT July 5th 2019 <<
        IF NOT ItemJnlBatch.GET("Journal Template Name", "Journal Batch Name") THEN
            EXIT;

        "Item Journal Batch Id" := ItemJnlBatch.Id;
        //SRT July 5th 2019 <<
    end;

    local procedure UpdateItemJournalBatchName()
    var
        ItemJnlBatch: Record "Item Journal Batch";
    begin
        //SRT July 5th 2019 >>
        ItemJnlBatch.SETRANGE(Id, "Item Journal Batch Id");
        IF NOT ItemJnlBatch.FINDFIRST THEN
            EXIT;

        "Journal Batch Name" := ItemJnlBatch.Name;
        //SRT July 5th 2019 <<
    end;

    local procedure SetLastModifiedDateTime()
    var
        DateFilterCalc: Codeunit "DateFilter-Calc";
    begin
        "Last Modified DateTime" := DateFilterCalc.ConvertToUtcDateTime(CURRENTDATETIME);
    end;

    procedure SendToPosting(PostingCodeunitID: Integer)
    begin
        CODEUNIT.RUN(PostingCodeunitID, Rec);
    end;
}

