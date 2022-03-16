tableextension 50036 "tableextension70000093" extends "Purch. Cr. Memo Line"
{
    fields
    {
        field(50000; "FA Item Charge"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Charge";
        }
        field(50003; "Purchase Consignment No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'VAT1.00';
            TableRelation = "Purchase Consignment"."No." WHERE(Blocked = CONST(false));
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
        field(59000; "TDS Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'TDS1.00';
            TableRelation = "TDS Posting Group".Code;
        }
        field(59001; "TDS%"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'TDS1.00';
        }
        field(59002; "TDS Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'TDS1.00';
            OptionCaption = ' ,Purchase TDS,Sales TDS';
            OptionMembers = " ","Purchase TDS","Sales TDS";
        }
        field(59003; "TDS Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'TDS1.00';
        }
        field(59004; "TDS Base Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'TDS1.00';
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
    }
}

