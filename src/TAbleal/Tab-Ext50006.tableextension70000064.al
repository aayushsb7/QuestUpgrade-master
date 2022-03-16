tableextension 50006 "tableextension70000064" extends "Purch. Rcpt. Line"
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
    }


    //Unsupported feature: Code Modification on "InsertInvLineFromRcptLine(PROCEDURE 2)".

    //procedure InsertInvLineFromRcptLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SETRANGE("Document No.","Document No.");

    TempPurchLine := PurchLine;
    #4..68
      PurchLine."Document No." := TempPurchLine."Document No.";
      PurchLine."Variant Code" := "Variant Code";
      PurchLine."Location Code" := "Location Code";
      PurchLine."Quantity (Base)" := 0;
      PurchLine.Quantity := 0;
      PurchLine."Outstanding Qty. (Base)" := 0;
    #75..148
      IF "Attached to Line No." = 0 THEN
        SETRANGE("Attached to Line No.","Line No.");
    UNTIL (NEXT = 0) OR ("Attached to Line No." = 0);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..71
      PurchLine.PragyapanPatra := PragyapanPatra; //SRT Dec 23rd 2019
    #72..151
    */
    //end;
}

