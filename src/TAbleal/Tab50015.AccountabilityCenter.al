table 50015 "Accountability Center"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3; Address; Text[50])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
        }
        field(4; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = ToBeClassified;
        }
        field(5; City; Text[30])
        {
            Caption = 'City';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code".City
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                PostCode.LookupPostCode(City, "Post Code", County, "Country/Region Code");
            end;

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(6; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code"
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                PostCode.LookupPostCode(City, "Post Code", County, "Country/Region Code");
            end;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(7; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                PostCode.CheckClearPostCodeCityCounty(City, "Post Code", County, "Country/Region Code", xRec."Country/Region Code");
            end;
        }
        field(8; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(9; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
            DataClassification = ToBeClassified;
        }
        field(10; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
            DataClassification = ToBeClassified;
        }
        field(11; Contact; Text[50])
        {
            Caption = 'Contact';
            DataClassification = ToBeClassified;
        }
        field(12; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(13; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(14; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(15; County; Text[30])
        {
            Caption = 'County';
            DataClassification = ToBeClassified;
        }
        field(102; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("E-Mail");
            end;
        }
        field(103; "Home Page"; Text[90])
        {
            Caption = 'Home Page';
            DataClassification = ToBeClassified;
            ExtendedDatatype = URL;
        }
        field(5900; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(5901; "Contract Gain/Loss Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Contract Gain/Loss Amount';
            Editable = false;

            CalcFormula = Sum("Contract Gain/Loss Entry".Amount WHERE("Responsibility Center" = FIELD(Code),
                                                                       "Change Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(50000; "Sales Quote Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50001; "Sales Blanket Order Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50002; "Sales Order Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50003; "Sales Return Order Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50004; "Sales Invoice Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50005; "Sales Posted Invoice Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50006; "Sales Credit Memo Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50007; "Sales Posted Credit Memo Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50008; "Sales Posted Shipment Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50009; "Purch. Quote Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50010; "Purch. Blanket Order Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50011; "Purch. Order Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50012; "Purch. Return Order Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50013; "Purch. Invoice Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50014; "Purch. Posted Invoice Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50015; "Purch. Credit Memo Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50016; "Purch. Posted Credit Memo Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50017; "Purch. Posted Receipt Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50018; "Delivery Detail Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50023; "Trans. Order Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50024; "Posted Transfer Shpt. Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50025; "Posted Transfer Rcpt. Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50026; "Purch. Posted Prept. Inv. Nos."; Code[20])
        {
            Caption = 'Purch. Posted Prepmt. Inv. Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50027; "Purch. Ptd. Prept. Cr. M. Nos."; Code[20])
        {
            Caption = 'Purch. Posted Prepmt. Cr. Memo Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50028; "Purch. Ptd. Return Shpt. Nos."; Code[20])
        {
            Caption = 'Purch. Posted Return Shpt. Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50029; "Sales Posted Prepmt. Inv. Nos."; Code[20])
        {
            Caption = 'Sales Posted Prepmt. Inv. Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50030; "Sales Ptd. Prept. Cr. M. Nos."; Code[20])
        {
            Caption = 'Sales Posted Prepmt. Cr. Memo Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50031; "Sales Ptd. Return Receipt Nos."; Code[20])
        {
            Caption = 'Sales Posted Return Receipt Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50037; "Service Invoice Nos."; Code[20])
        {
            Caption = 'Service Invoice Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50038; "Service Order Nos."; Code[20])
        {
            Caption = 'Service Order Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50039; "Service Quote Nos."; Code[20])
        {
            Caption = 'Service Quote Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50040; "Posted Service Invoice Nos."; Code[20])
        {
            Caption = 'Posted Service Invoice Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50041; "Posted Serv. Credit Memo Nos."; Code[20])
        {
            Caption = 'Posted Serv. Credit Memo Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50042; "Posted Service Shipment Nos."; Code[20])
        {
            Caption = 'Posted Service Shipment Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50043; "Service Credit Memo Nos."; Code[20])
        {
            Caption = 'Service Credit Memo Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PostCode: Record "Post Code";
        DimMgt: Codeunit DimensionManagement;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::"Responsibility Center", Code, FieldNumber, ShortcutDimCode);
        MODIFY;
    end;
}

