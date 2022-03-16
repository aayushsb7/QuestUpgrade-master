tableextension 50019 "tableextension70000507" extends "VAT Posting Setup"
{
    fields
    {
        field(40; "Used in Ledger Entries"; Integer)
        {
            Caption = 'Used in Ledger Entries';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Count("G/L Entry" WHERE("VAT Bus. Posting Group" = FIELD("VAT Bus. Posting Group"),
                                                   "VAT Prod. Posting Group" = FIELD("VAT Prod. Posting Group")));

        }
        field(50501; "Localized VAT Identifier"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'NP15.1001';
            OptionCaption = ' ,Taxable Import Purchase,Exempt Purchase,Taxable Local Purchase,Taxable Capex Purchase,Taxable Sales,Non Taxable Sales,Exempt Sales,Prepayments,Purchase Without VAT Invoice';
            OptionMembers = " ","Taxable Import Purchase","Exempt Purchase","Taxable Local Purchase","Taxable Capex Purchase","Taxable Sales","Non Taxable Sales","Exempt Sales",Prepayments,"Purchase Without VAT Invoice";
        }
    }
}

