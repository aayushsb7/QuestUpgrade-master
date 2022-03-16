tableextension 50041 "tableextension70000711" extends "Sales Line Archive"
{
    fields
    {
        field(50003; "Accountability Center"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Accountability Center";
        }
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
        field(50006; "Batch No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Value will be passed from another software';
        }
        field(50007; "Manufacturing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Expiy Date"; Date)
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
        field(50501; "Localized VAT Identifier"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'NP15.1001';
            OptionCaption = ' ,Taxable Import Purchase,Exempt Purchase,Taxable Local Purchase,Taxable Capex Purchase,Taxable Sales,Non Taxable Sales,Exempt Sales,Prepayments,Purchase Without VAT Invoice,Sales without VAT Invoice,Direct Sales';
            OptionMembers = " ","Taxable Import Purchase","Exempt Purchase","Taxable Local Purchase","Taxable Capex Purchase","Taxable Sales","Non Taxable Sales","Exempt Sales",Prepayments,"Purchase Without VAT Invoice","Sales without VAT Invoice","Direct Sales";
        }
    }
}

