tableextension 50039 "tableextension70000650" extends "Invoice Post. Buffer"
{
    fields
    {
        field(50000; "Sys. LC No."; Code[20])
        {
            Caption = 'LC No.';
            DataClassification = ToBeClassified;
            TableRelation = "LC Details"."No." WHERE("Transaction Type" = CONST(Purchase),
                                                    Closed = CONST(false),
                                                    Released = CONST(true));

            trigger OnValidate()
            var
                LCDetail: Record "LC Details";
                LCAmendDetail: Record "LC Amend Detail";
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
        field(50003; "Purchase Consignment No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'VAT1.00';
            TableRelation = "Purchase Consignment"."No." WHERE(Blocked = CONST(false));
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
        }
        field(50502; "Localized VAT Identifier"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'NP15.1001';
            OptionCaption = ' ,Taxable Import Purchase,Exempt Purchase,Taxable Local Purchase,Taxable Capex Purchase,Taxable Sales,Non Taxable Sales,Exempt Sales,Prepayments,Purchase Without VAT Invoice,Sales without VAT Invoice,Direct Sales';
            OptionMembers = " ","Taxable Import Purchase","Exempt Purchase","Taxable Local Purchase","Taxable Capex Purchase","Taxable Sales","Non Taxable Sales","Exempt Sales",Prepayments,"Purchase Without VAT Invoice","Sales without VAT Invoice","Direct Sales";
        }
        field(50605; "FA Item Charge"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Charge";
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


    //Unsupported feature: Code Modification on "PrepareSales(PROCEDURE 1)".

    //procedure PrepareSales();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CLEAR(Rec);
    Type := SalesLine.Type;
    "System-Created Entry" := TRUE;
    #4..30
      "VAT Amount" := 0;
      "VAT Amount (ACY)" := 0;
    END;

    OnAfterInvPostBufferPrepareSales(SalesLine,Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..33
    IRDMgt.CopyInvPostingBufferFromSalesLine(SalesLine,Rec); //IRD19.00
    OnAfterInvPostBufferPrepareSales(SalesLine,Rec);
    */
    //end;


    //Unsupported feature: Code Modification on "PreparePurchase(PROCEDURE 6)".

    //procedure PreparePurchase();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CLEAR(Rec);
    Type := PurchLine.Type;
    "System-Created Entry" := TRUE;
    #4..37
      "VAT Amount" := 0;
      "VAT Amount (ACY)" := 0;
    END;

    OnAfterInvPostBufferPreparePurchase(PurchLine,Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..40
    IRDMgt.CopyInvPostingBufferFromPurchaseLine(PurchLine,Rec);  //IRD19.00
    OnAfterInvPostBufferPreparePurchase(PurchLine,Rec);
    */
    //end;


    //Unsupported feature: Code Modification on "Update(PROCEDURE 12)".

    //procedure Update();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeInvPostBufferUpdate(Rec,InvoicePostBuffer);

    Rec := InvoicePostBuffer;
    #4..9
      "VAT Difference" += InvoicePostBuffer."VAT Difference";
      "VAT Base Amount (ACY)" += InvoicePostBuffer."VAT Base Amount (ACY)";
      Quantity += InvoicePostBuffer.Quantity;
      "VAT Base Before Pmt. Disc." += InvoicePostBuffer."VAT Base Before Pmt. Disc.";
      IF NOT InvoicePostBuffer."System-Created Entry" THEN
        "System-Created Entry" := FALSE;
    #16..28
    END;

    OnAfterInvPostBufferUpdate(Rec,InvoicePostBuffer);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..12
      // TDS1.00
      "TDS Amount" +=
        InvoicePostBuffer."TDS Amount";
      "TDS Base Amount" +=
        InvoicePostBuffer."TDS Base Amount";
      // TDS1.00
    #13..31
    */
    //end;

    procedure SetTDSAccount(var PurchLine: Record "Purchase Line")
    begin
        //TDS1.00
        IF PurchLine."TDS Group" <> '' THEN
            "TDS Group" := PurchLine."TDS Group";
        IF PurchLine."TDS%" <> 0 THEN
            "TDS%" := PurchLine."TDS%";
        IF PurchLine."TDS Type" <> PurchLine."TDS Type"::" " THEN
            "TDS Type" := PurchLine."TDS Type";
        //TDS1.00
    end;

    procedure SetTDSAmounts(TotalTDSAmount: Decimal; TotalTDSBaseAmount: Decimal)
    begin
        //TDS1.00
        "TDS Amount" := TotalTDSAmount;
        "TDS Base Amount" := TotalTDSBaseAmount;
        //TDS1.00
    end;

    procedure ReverseTDSAmounts()
    begin
        //TDS1.00
        "TDS Amount" := -"TDS Amount";
        "TDS Base Amount" := -"TDS Base Amount";
        //TDS1.00
    end;

    procedure UpdateTDSFields(var PurchLine: Record "Purchase Line")
    begin
        //TDS1.00
        IF PurchLine."TDS Group" <> '' THEN
            "TDS Group" := PurchLine."TDS Group";
        IF PurchLine."TDS%" <> 0 THEN
            "TDS%" := PurchLine."TDS%";
        IF PurchLine."TDS Type" <> PurchLine."TDS Type"::" " THEN
            "TDS Type" := PurchLine."TDS Type";
        //TDS1.00
    end;

    var
        "--Customization--": Integer;
        IRDMgt: Codeunit "50000";
}

