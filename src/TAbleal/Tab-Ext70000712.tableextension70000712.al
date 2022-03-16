tableextension 50042 "tableextension70000712" extends "Purchase Header Archive"
{
    fields
    {
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

    //Unsupported feature: Variable Insertion (Variable: CompanyInfo) (VariableCollection) on "SetSecurityFilterOnRespCenter(PROCEDURE 5)".


    //Unsupported feature: Variable Insertion (Variable: SysMgt) (VariableCollection) on "SetSecurityFilterOnRespCenter(PROCEDURE 5)".



    //Unsupported feature: Code Modification on "SetSecurityFilterOnRespCenter(PROCEDURE 5)".

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

