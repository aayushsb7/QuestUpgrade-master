tableextension 50066 "tableextension70001090" extends "Return Receipt Line"
{
    fields
    {
        field(50004; "Free Line"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'To recognize whether it is free quantity line or not';
        }
        field(50005; "Sales Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'To link sales line no. with free item line';
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
        }
        field(50502; "Returned Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
}

