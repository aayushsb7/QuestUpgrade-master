table 50013 "PDC Line"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            Editable = false;
        }
        field(2; "Posting Date"; Date)
        {

            trigger OnValidate()
            begin
                IF "Posting Date" <> 0D THEN
                    IF ("Cheque Date" < "Posting Date") AND ("Cheque Date" <> 0D) THEN
                        ERROR('Cheque Date must be greater then Posting Date');
            end;
        }
        field(3; Type; Option)
        {
            Editable = false;
            OptionMembers = Receipt,Payment;

            trigger OnValidate()
            begin
                "Bill-To/Pay-To No." := '';
                "Bill-To/Pay-To Name" := '';
                "Sell-To/Buy-From No." := '';
                "Sell-To/Buy-From Name" := '';

                IF Type = Type::Receipt THEN BEGIN
                    "Bill-To/Pay-To Type" := "Bill-To/Pay-To Type"::Customer;
                    "Sell-To/Buy-From Type" := "Sell-To/Buy-From Type"::Customer;
                END

                ELSE
                    IF Type = Type::Payment THEN BEGIN
                        "Bill-To/Pay-To Type" := "Bill-To/Pay-To Type"::Vendor;
                        "Sell-To/Buy-From Type" := "Sell-To/Buy-From Type"::Vendor;
                    END;
            end;
        }
        field(4; "Cheque No."; Text[50])
        {
        }
        field(5; "Cheque Date"; Date)
        {

            trigger OnValidate()
            begin
                IF "Cheque Date" <> 0D THEN
                    IF "Cheque Date" < "Posting Date" THEN
                        ERROR('Cheque Date must be greater then Posting Date');
            end;
        }
        field(6; "Drawn On"; Date)
        {
            Description = 'delete';
        }
        field(7; "Customer Bank Account"; Code[10])
        {
            TableRelation = "Customer Bank Account".Code WHERE("Customer No." = FIELD("Bill-To/Pay-To No."));

            trigger OnValidate()
            begin
                CustomerBankRec.RESET;
                CustomerBankRec.SETRANGE(Code, "Customer Bank Account");
                IF CustomerBankRec.FINDFIRST THEN
                    "Customer Bank Name" := CustomerBankRec.Name
                ELSE
                    "Customer Bank Name" := '';
            end;
        }
        field(8; "Customer Bank Name"; Text[100])
        {
        }
        field(9; "Bill-To/Pay-To No."; Code[20])
        {
            TableRelation = IF ("Bill-To/Pay-To Type" = CONST(Customer)) Customer."No."
            ELSE
            IF ("Bill-To/Pay-To Type" = CONST(Vendor)) Vendor."No.";

            trigger OnValidate()
            begin
                IF ("Bill-To/Pay-To No." <> '') THEN BEGIN
                    IF ("Bill-To/Pay-To Type" = "Bill-To/Pay-To Type"::Customer) THEN BEGIN
                        CustomerRec.GET("Bill-To/Pay-To No.");
                        "Bill-To/Pay-To Name" := CustomerRec.Name;
                    END
                    ELSE
                        IF ("Bill-To/Pay-To Type" = "Bill-To/Pay-To Type"::Vendor) THEN BEGIN
                            VendorRec.GET("Bill-To/Pay-To No.");
                            "Bill-To/Pay-To Name" := VendorRec.Name;
                        END;
                END
                ELSE
                    "Bill-To/Pay-To Name" := '';

                "Customer Bank Account" := '';
            end;
        }
        field(10; "Bill-To/Pay-To Name"; Text[100])
        {
        }
        field(11; Amount; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(12; Remarks; Option)
        {
            OptionMembers = Due,Deposit,Cancel;
        }
        field(13; Narration; Text[250])
        {
        }
        field(14; "User Id"; Code[50])
        {
            Editable = false;
        }
        field(15; "Bill-To/Pay-To Type"; Option)
        {
            Editable = false;
            OptionMembers = Customer,Vendor;
        }
        field(16; "Sell-To/Buy-From Type"; Option)
        {
            Editable = false;
            OptionMembers = Customer,Vendor;
        }
        field(17; "Sell-To/Buy-From No."; Code[20])
        {
            TableRelation = IF ("Sell-To/Buy-From Type" = CONST(Customer)) Customer."No."
            ELSE
            IF ("Sell-To/Buy-From Type" = CONST(Vendor)) Vendor."No.";

            trigger OnValidate()
            begin
                IF ("Sell-To/Buy-From No." <> '') THEN BEGIN
                    IF ("Sell-To/Buy-From Type" = "Sell-To/Buy-From Type"::Customer) THEN BEGIN
                        CustomerRec.GET("Sell-To/Buy-From No.");
                        "Sell-To/Buy-From Name" := CustomerRec.Name;
                        "Bill-To/Pay-To No." := CustomerRec."Bill-to Customer No.";
                        IF "Bill-To/Pay-To No." <> '' THEN BEGIN
                            CustomerRec2.GET("Bill-To/Pay-To No.");
                            "Bill-To/Pay-To Name" := CustomerRec2.Name;
                        END
                        ELSE BEGIN
                            VALIDATE("Bill-To/Pay-To No.", "Sell-To/Buy-From No.");

                        END;
                    END
                    ELSE
                        IF ("Sell-To/Buy-From Type" = "Sell-To/Buy-From Type"::Vendor) THEN BEGIN
                            VendorRec.GET("Sell-To/Buy-From No.");
                            "Sell-To/Buy-From Name" := VendorRec.Name;
                            "Bill-To/Pay-To No." := VendorRec."Pay-to Vendor No.";
                            IF "Bill-To/Pay-To No." <> '' THEN BEGIN
                                VendorRec2.GET("Bill-To/Pay-To No.");
                                "Bill-To/Pay-To Name" := VendorRec2.Name;
                            END;
                        END;
                END
                ELSE
                    "Sell-To/Buy-From Name" := '';

                "Customer Bank Account" := '';
            end;
        }
        field(18; "Sell-To/Buy-From Name"; Text[100])
        {
        }
        field(24; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(25; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(26; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(27; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(28; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."= CONST(5));
           trigger OnValidate()
            begin
                ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");
            end;
        }
        field(29; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));

            trigger OnValidate()
            begin  
                ValidateShortcutDimCode(6, "Shortcut Dimension 6 Code");
            end;
        }
        field(30; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));

            trigger OnValidate()
            begin  
                ValidateShortcutDimCode(7, "Shortcut Dimension 7 Code");
            end;
        }
        field(31; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));

            trigger OnValidate()
            begin  
                ValidateShortcutDimCode(8, "Shortcut Dimension 8 Code");
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "User Id" := USERID;
    end;

    var
        BankRec: Record "Bank Account";
        CustomerRec: Record Customer;
        VendorRec: Record Vendor;
        CustomerRec2: Record Customer;
        VendorRec2: Record Vendor;
        CustomerBankRec: Record "Customer Bank Account";
        DimMgt: Codeunit DimensionManagement;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}

