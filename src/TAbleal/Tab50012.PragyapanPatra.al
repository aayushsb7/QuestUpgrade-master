table 50012 "PragyapanPatra"
{
    DrillDownPageID = 50007;
    LookupPageID = 50007;

    fields
    {
        field(1; "Code"; Code[100])
        {

            trigger OnValidate()
            begin
                IF Code = '' THEN
                    ERROR(Error3)
            end;
        }
        field(2; Name; Text[250])
        {
        }
        field(50000; "Purchase Consignment No."; Code[20])
        {
            Caption = 'Purchase Consignment No.';
            TableRelation = "Purchase Consignment"."No." WHERE("Sys LC No." = FIELD("Sys LC No."));
        }
        field(50001; "Sys LC No."; Code[20])
        {
            TableRelation = "LC Details";
        }
        field(50002; "Date of Custom Clearance"; Date)
        {
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
        fieldgroup(DrillDown; "Code", Name, "Purchase Consignment No.", "Sys LC No.")
        {
        }
    }

    trigger OnDelete()
    begin
        IF ExistsInPostedPurchaseDocument(Code) THEN
            ERROR(Error1, PostedPurchaseDocumentNo);
        IF ExistsInPurchaseDocument(Code) THEN
            ERROR(Error2, PurchaseDocumentNo, Code);
    end;

    trigger OnInsert()
    begin
        IF Code = '' THEN
            ERROR(Error3)
    end;

    trigger OnModify()
    begin
        /*IF ExistsInPostedPurchaseDocument(Code) THEN
          ERROR(Error1,PostedPurchaseDocumentNo);
        IF ExistsInPurchaseDocument(Code) THEN
          ERROR(Error2,PurchaseDocumentNo,Code);*/

    end;

    trigger OnRename()
    begin
        IF ExistsInPostedPurchaseDocument(xRec.Code) THEN
            ERROR(Error1, PostedPurchaseDocumentNo);
        IF ExistsInPurchaseDocument(xRec.Code) THEN
            ERROR(Error2, PurchaseDocumentNo, xRec.Code);
    end;

    var
        Error1: Label 'You cannot modify or Delete or Rename PragaypanPatra Details as it Exists in Posted Purchase Invoice %1';
        Error2: Label 'You cannot modify or Delete or Rename PragaypanPatra Details as it Exists in Purchase Document %1. Please remove PPNo %2 from Purchase Document %1 to delete or modify or Rename.';
        PostedPurchaseDocumentNo: Code[20];
        PurchaseDocumentNo: Code[20];
        Error3: Label 'Please Enter Code';

    local procedure ExistsInPostedPurchaseDocument(PPNo: Code[100]): Boolean
    var
        PostedPurchaseInvoice: Record "Purch. Inv. Header";
    begin
        CLEAR(PostedPurchaseDocumentNo);
        PostedPurchaseInvoice.RESET;
        PostedPurchaseInvoice.SETRANGE(PragyapanPatra, PPNo);
        IF PostedPurchaseInvoice.FINDFIRST THEN BEGIN
            PostedPurchaseDocumentNo := PostedPurchaseInvoice."No.";
            EXIT(TRUE);
        END;
    end;

    local procedure ExistsInPurchaseDocument(PPNo: Code[100]): Boolean
    var
        PurchaseLine: Record "Purchase Line";
        PurchaseHeader: Record "Purchase Header";
    begin
        CLEAR(PurchaseDocumentNo);
        PurchaseHeader.RESET;
        PurchaseHeader.SETRANGE(PragyapanPatra, PPNo);
        IF PurchaseHeader.FINDFIRST THEN BEGIN
            PurchaseDocumentNo := PurchaseHeader."No.";
            EXIT(TRUE);
        END;

        CLEAR(PurchaseDocumentNo);
        PurchaseLine.RESET;
        PurchaseLine.SETRANGE(PragyapanPatra, PPNo);
        IF PurchaseLine.FINDFIRST THEN BEGIN
            PurchaseDocumentNo := PurchaseLine."Document No.";
            EXIT(TRUE);
        END;
    end;
}

