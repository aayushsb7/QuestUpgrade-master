tableextension 50031 "tableextension70000087" extends "Purch. Cr. Memo Hdr."
{
    fields
    {
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
            TableRelation = "Purchase Consignment"."No.";
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
        field(50006; "Nepali Posting Date"; Code[10])
        {
            DataClassification = ToBeClassified;
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
        }
        field(50501; PragyapanPatra; Code[100])
        {
            DataClassification = ToBeClassified;
            Description = 'NP15.1001';
            TableRelation = PragyapanPatra.Code;
        }
        field(50502; "Posting Time"; Time)
        {
            DataClassification = ToBeClassified;
            Description = 'NP15.1001';
        }
        field(70000; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(70001; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(70002; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
        }
        field(70003; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));
        }
        field(70004; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));
        }
        field(70005; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));
        }
    }

    //Unsupported feature: Variable Insertion (Variable: CompanyInfo) (VariableCollection) on "SetSecurityFilterOnRespCenter(PROCEDURE 4)".


    //Unsupported feature: Variable Insertion (Variable: SysMgt) (VariableCollection) on "SetSecurityFilterOnRespCenter(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "SetSecurityFilterOnRespCenter(PROCEDURE 4)".

    //procedure SetSecurityFilterOnRespCenter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF UserSetupMgt.GetPurchasesFilter <> '' THEN BEGIN
      FILTERGROUP(2);
      SETRANGE("Responsibility Center",UserSetupMgt.GetPurchasesFilter);
      FILTERGROUP(0);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF UserSetupMgt.GetPurchasesFilter <> '' THEN BEGIN
      CompanyInfo.GET;
      FILTERGROUP(2);
      IF NOT CompanyInfo."Activate Local Resp. Center" THEN
        SETRANGE("Responsibility Center",UserSetupMgt.GetPurchasesFilter)
      ELSE
    #3..5
    */
    //end;
}

