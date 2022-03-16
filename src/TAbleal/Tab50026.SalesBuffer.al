table 50026 "Sales Buffer"
{

    fields
    {
        field(1; "Row Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Document Header,Document Line';
            OptionMembers = " ","Document Header","Document Line";
        }
        field(2; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(3; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Sell-to Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(6; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(7; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";

            trigger OnValidate()
            var
                TempSalesLine: Record "Sales Line" temporary;
            begin
            end;
        }
        field(8; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            ELSE
            IF (Type = CONST("G/L Account")) "G/L Account" WHERE("Direct Posting" = CONST(true),
                                                                                   "Account Type" = CONST(Posting),
                                                                                   Blocked = CONST(false))
            ELSE
            IF (Type = CONST(Resource)) Resource
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF (Type = CONST("Charge (Item)")) "Item Charge"
            ELSE
            IF (Type = CONST(Item)) Item;
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                TempSalesLine: Record "Sales Line" temporary;
                FindRecordMgt: Codeunit "Record Set Management";
            begin
            end;
        }
        field(9; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(10; "Unit of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Unit Price Excl VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Batch No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Manufacturing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "External Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Transport Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Expected Delivery Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "CN No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Dispatch Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "M.R."; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Manual Field';
        }
        field(22; Cases; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'Manual Field';
        }
        field(23; "Doc. Thru."; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Manual Field';
        }
        field(24; Processed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Lot No. Not Found"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Row Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

