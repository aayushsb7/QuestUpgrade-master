tableextension 50008 "tableextension70000027" extends "Sales Shipment Header"
{
    fields
    {
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
        field(50003; "Accountability Center"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Accountability Center";
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

    //Unsupported feature: Variable Insertion (Variable: CompanyInfo) (VariableCollection) on "SetSecurityFilterOnRespCenter(PROCEDURE 6)".


    //Unsupported feature: Variable Insertion (Variable: SysMgt) (VariableCollection) on "SetSecurityFilterOnRespCenter(PROCEDURE 6)".



    //Unsupported feature: Code Modification on "SetSecurityFilterOnRespCenter(PROCEDURE 6)".

    //procedure SetSecurityFilterOnRespCenter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF UserSetupMgt.GetSalesFilter <> '' THEN BEGIN
      FILTERGROUP(2);
      SETRANGE("Responsibility Center",UserSetupMgt.GetSalesFilter);
      FILTERGROUP(0);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF UserSetupMgt.GetSalesFilter <> '' THEN BEGIN
      CompanyInfo.GET;
      FILTERGROUP(2);
      IF NOT CompanyInfo."Activate Local Resp. Center" THEN
        SETRANGE("Responsibility Center",UserSetupMgt.GetSalesFilter)
      ELSE
    #3..5
    */
    //end;
}

