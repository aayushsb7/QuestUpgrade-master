tableextension 50014 "tableextension70000427" extends "VAT Entry"
{
    fields
    {
        field(50203; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
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
    }


    //Unsupported feature: Code Modification on "CopyFromGenJnlLine(PROCEDURE 5)".

    //procedure CopyFromGenJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CopyPostingGroupsFromGenJnlLine(GenJnlLine);
    "Posting Date" := GenJnlLine."Posting Date";
    "Document Date" := GenJnlLine."Document Date";
    #4..15
    "Bill-to/Pay-to No." := GenJnlLine."Bill-to/Pay-to No.";
    "Country/Region Code" := GenJnlLine."Country/Region Code";
    "VAT Registration No." := GenJnlLine."VAT Registration No.";

    OnAfterCopyFromGenJnlLine(Rec,GenJnlLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..18
    IRDMgt.CopyVATEntryFromGenJnlLine(Rec,GenJnlLine);
    OnAfterCopyFromGenJnlLine(Rec,GenJnlLine);
    */
    //end;


    //Unsupported feature: Property Modification (Id) on "ConfirmAdjustQst(Variable 1005)".

    //var
    //>>>> ORIGINAL VALUE:
    //ConfirmAdjustQst : 1005;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ConfirmAdjustQst : 1999;
    //Variable type has not been exported.

    var
        IRDMgt: Codeunit "IRD Mgt.";
}

