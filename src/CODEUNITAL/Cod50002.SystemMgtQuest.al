codeunit 50002 "System Mgt. Quest"
{

    trigger OnRun()
    begin
    end;

    var
        ResponsibilityCenter: Record "Responsibility Center";
        Text000: Label 'You are not authorised to transfer from %1.';
        Text007: Label 'You cannot change %1 because there are one or more %2 for this %3.';
        Text008: Label 'You cannot receive the Serial No. %1 because sales/transfer/adjustment entries are done.';
        Text009: Label 'You cannot receive the Serial No. %1 because there are outstanding service orders/quotes attached to it.';
        Text010: Label 'You cannot receive the Serial No. %1 because Service ledger entries exists.';
        Text011: Label 'You are not allowed to post Sales %1 if total price including VAT is %2.';
        Text012: Label '%1 must be equal to %2 in Line no %3.';
        UserSetup: Record "User Setup";
        CompanyInfo: Record "79";
        AccountabilityCenter: Record "50015";


    procedure GetRespCenterWiseNoSeries("Document Profile": Option Purchase,Sales,Transfer,Service; "Document Type": Option Quote,"Blanket Order","Order","Return Order",Invoice,"Posted Invoice","Credit Memo","Posted Credit Memo","Posted Shipment","Posted Receipt","Posted Prepmt. Inv.","Posted Prepmt. Cr. Memo","Posted Return Receipt","Posted Return Shipment",Booking,"Posted Order","Posted Debit Note",Requisition,Services,"Posted Credit Note"): Code[10]
    var
        RespCenter: Record "Responsibility Center";
    begin
        UserSetup.GET(USERID);
        CompanyInfo.GET;
        IF NOT CompanyInfo."Activate Local Resp. Center" THEN BEGIN
            IF RespCenter.GET(UserSetup."Default Accountability Center") THEN BEGIN
                CASE "Document Profile" OF
                    "Document Profile"::Purchase:
                        BEGIN
                            CASE "Document Type" OF
                                "Document Type"::Quote:
                                    EXIT(RespCenter."Purch. Quote Nos.");
                                "Document Type"::"Blanket Order":
                                    EXIT(RespCenter."Purch. Blanket Order Nos.");
                                "Document Type"::Order:
                                    EXIT(RespCenter."Purch. Order Nos.");
                                "Document Type"::"Return Order":
                                    EXIT(RespCenter."Purch. Return Order Nos.");
                                "Document Type"::Invoice:
                                    EXIT(RespCenter."Purch. Invoice Nos.");
                                "Document Type"::"Posted Invoice":
                                    EXIT(RespCenter."Purch. Posted Invoice Nos.");
                                "Document Type"::"Credit Memo":
                                    EXIT(RespCenter."Purch. Credit Memo Nos.");
                                "Document Type"::"Posted Credit Memo":
                                    EXIT(RespCenter."Purch. Posted Credit Memo Nos.");
                                "Document Type"::"Posted Receipt":
                                    EXIT(RespCenter."Purch. Posted Receipt Nos.");
                                "Document Type"::"Posted Return Shipment":
                                    EXIT(RespCenter."Purch. Ptd. Return Shpt. Nos.");
                                "Document Type"::"Posted Prepmt. Inv.":
                                    EXIT(RespCenter."Purch. Posted Prept. Inv. Nos.");
                                "Document Type"::"Posted Prepmt. Cr. Memo":
                                    EXIT(RespCenter."Purch. Ptd. Prept. Cr. M. Nos.");
                            END;
                        END;
                    "Document Profile"::Sales:
                        BEGIN
                            CASE "Document Type" OF
                                "Document Type"::Quote:
                                    EXIT(RespCenter."Sales Quote Nos.");
                                "Document Type"::"Blanket Order":
                                    EXIT(RespCenter."Sales Blanket Order Nos.");
                                "Document Type"::Order:
                                    EXIT(RespCenter."Sales Order Nos.");
                                "Document Type"::"Return Order":
                                    EXIT(RespCenter."Sales Return Order Nos.");
                                "Document Type"::Invoice:
                                    EXIT(RespCenter."Sales Invoice Nos.");
                                "Document Type"::"Posted Invoice":
                                    EXIT(RespCenter."Sales Posted Invoice Nos.");
                                "Document Type"::"Credit Memo":
                                    EXIT(RespCenter."Sales Credit Memo Nos.");
                                "Document Type"::"Posted Credit Memo":
                                    EXIT(RespCenter."Sales Posted Credit Memo Nos.");
                                "Document Type"::"Posted Shipment":
                                    EXIT(RespCenter."Sales Posted Shipment Nos.");
                                "Document Type"::"Posted Return Receipt":
                                    EXIT(RespCenter."Sales Ptd. Return Receipt Nos.");
                                "Document Type"::"Posted Prepmt. Inv.":
                                    EXIT(RespCenter."Sales Posted Prepmt. Inv. Nos.");
                                "Document Type"::"Posted Prepmt. Cr. Memo":
                                    EXIT(RespCenter."Sales Ptd. Prept. Cr. M. Nos.");
                            END;

                        END;
                    "Document Profile"::Service:
                        BEGIN
                            CASE "Document Type" OF
                                "Document Type"::Quote:
                                    EXIT(RespCenter."Service Quote Nos.");
                                "Document Type"::Order:
                                    EXIT(RespCenter."Service Order Nos.");
                                "Document Type"::Invoice:
                                    EXIT(RespCenter."Service Invoice Nos.");
                                "Document Type"::"Posted Invoice":
                                    EXIT(RespCenter."Posted Service Invoice Nos.");
                                "Document Type"::"Credit Memo":
                                    EXIT(RespCenter."Service Credit Memo Nos.");
                                "Document Type"::"Posted Credit Memo":
                                    EXIT(RespCenter."Posted Serv. Credit Memo Nos.");
                                "Document Type"::"Posted Shipment":
                                    EXIT(RespCenter."Posted Service Shipment Nos.");
                            END;
                        END;
                    "Document Profile"::Transfer:
                        BEGIN
                            CASE "Document Type" OF
                                "Document Type"::Order:
                                    EXIT(RespCenter."Trans. Order Nos.");
                                "Document Type"::"Posted Receipt":
                                    EXIT(RespCenter."Posted Transfer Rcpt. Nos.");
                                "Document Type"::"Posted Shipment":
                                    EXIT(RespCenter."Posted Transfer Shpt. Nos.");
                            END;
                        END;
                END;
            END;
        END ELSE BEGIN
            IF AccountabilityCenter.GET(UserSetup."Default Accountability Center") THEN BEGIN
                CASE "Document Profile" OF
                    "Document Profile"::Purchase:
                        BEGIN
                            CASE "Document Type" OF
                                "Document Type"::Quote:
                                    EXIT(AccountabilityCenter."Purch. Quote Nos.");
                                "Document Type"::"Blanket Order":
                                    EXIT(AccountabilityCenter."Purch. Blanket Order Nos.");
                                "Document Type"::Order:
                                    EXIT(AccountabilityCenter."Purch. Order Nos.");
                                "Document Type"::"Return Order":
                                    EXIT(AccountabilityCenter."Purch. Return Order Nos.");
                                "Document Type"::Invoice:
                                    EXIT(AccountabilityCenter."Purch. Invoice Nos.");
                                "Document Type"::"Posted Invoice":
                                    EXIT(AccountabilityCenter."Purch. Posted Invoice Nos.");
                                "Document Type"::"Credit Memo":
                                    EXIT(AccountabilityCenter."Purch. Credit Memo Nos.");
                                "Document Type"::"Posted Credit Memo":
                                    EXIT(AccountabilityCenter."Purch. Posted Credit Memo Nos.");
                                "Document Type"::"Posted Receipt":
                                    EXIT(AccountabilityCenter."Purch. Posted Receipt Nos.");
                                "Document Type"::"Posted Return Shipment":
                                    EXIT(AccountabilityCenter."Purch. Ptd. Return Shpt. Nos.");
                                "Document Type"::"Posted Prepmt. Inv.":
                                    EXIT(AccountabilityCenter."Purch. Posted Prept. Inv. Nos.");
                                "Document Type"::"Posted Prepmt. Cr. Memo":
                                    EXIT(AccountabilityCenter."Purch. Ptd. Prept. Cr. M. Nos.");

                            END;
                        END;
                    "Document Profile"::Sales:
                        BEGIN
                            CASE "Document Type" OF
                                "Document Type"::Quote:
                                    EXIT(AccountabilityCenter."Sales Quote Nos.");
                                "Document Type"::"Blanket Order":
                                    EXIT(AccountabilityCenter."Sales Blanket Order Nos.");
                                "Document Type"::Order:
                                    EXIT(AccountabilityCenter."Sales Order Nos.");
                                "Document Type"::"Return Order":
                                    EXIT(AccountabilityCenter."Sales Return Order Nos.");
                                "Document Type"::Invoice:
                                    EXIT(AccountabilityCenter."Sales Invoice Nos.");
                                "Document Type"::"Posted Invoice":
                                    EXIT(AccountabilityCenter."Sales Posted Invoice Nos.");
                                "Document Type"::"Credit Memo":
                                    EXIT(AccountabilityCenter."Sales Credit Memo Nos.");
                                "Document Type"::"Posted Credit Memo":
                                    EXIT(AccountabilityCenter."Sales Posted Credit Memo Nos.");
                                "Document Type"::"Posted Shipment":
                                    EXIT(AccountabilityCenter."Sales Posted Shipment Nos.");
                                "Document Type"::"Posted Return Receipt":
                                    EXIT(AccountabilityCenter."Sales Ptd. Return Receipt Nos.");
                                "Document Type"::"Posted Prepmt. Inv.":
                                    EXIT(AccountabilityCenter."Sales Posted Prepmt. Inv. Nos.");
                                "Document Type"::"Posted Prepmt. Cr. Memo":
                                    EXIT(AccountabilityCenter."Sales Ptd. Prept. Cr. M. Nos.");
                            END;

                        END;
                    "Document Profile"::Service:
                        BEGIN
                            CASE "Document Type" OF
                                "Document Type"::Order:
                                    EXIT(AccountabilityCenter."Service Order Nos.");
                                "Document Type"::Invoice:
                                    EXIT(AccountabilityCenter."Service Invoice Nos.");
                                "Document Type"::"Posted Invoice":
                                    EXIT(AccountabilityCenter."Posted Service Invoice Nos.");
                                "Document Type"::"Credit Memo":
                                    EXIT(AccountabilityCenter."Service Credit Memo Nos.");
                                "Document Type"::"Posted Credit Memo":
                                    EXIT(AccountabilityCenter."Posted Serv. Credit Memo Nos.");
                                "Document Type"::Quote:
                                    EXIT(AccountabilityCenter."Service Quote Nos.");

                            END;
                        END;
                    "Document Profile"::Transfer:
                        BEGIN
                            CASE "Document Type" OF
                                "Document Type"::Order:
                                    EXIT(AccountabilityCenter."Trans. Order Nos.");
                                "Document Type"::"Posted Receipt":
                                    EXIT(AccountabilityCenter."Posted Transfer Rcpt. Nos.");
                                "Document Type"::"Posted Shipment":
                                    EXIT(AccountabilityCenter."Posted Transfer Shpt. Nos.");
                            END;
                        END;
                END;
            END;
        END
    end;

    [Scope('Internal')]
    procedure GetNoSeriesFromRespCenter(): Boolean
    var
        CompanyInfo: Record "79";
    begin
        CompanyInfo.GET;
        EXIT(CompanyInfo."Activate Local Resp. Center");
    end;

    [Scope('Internal')]
    procedure InitCustomFieldsOnTransferHeader(var Rec: Record "5740"; var xRec: Record "5740"; CurrFieldNo: Integer)
    var
        UserSetup: Record "91";
        Location: Record "14";
    begin
        Rec.TransferLoctionFilter := Rec."Transfer-from Code" + ',' + Rec."Transfer-to Code";
    end;

    [Scope('Internal')]
    procedure TestNoSeriesFromRespCenter("Document Profile": Option Purchase,Sales,Transfer,Service; "Document Type": Option Quote,"Blanket Order","Order","Return Order",Invoice,"Posted Invoice","Credit Memo","Posted Credit Memo","Posted Shipment","Posted Receipt","Posted Prepmt. Inv.","Posted Prepmt. Cr. Memo","Posted Return Receipt","Posted Return Shipment",Booking,"Posted Order","Posted Debit Note",Requisition,Services,"Posted Credit Note")
    var
        RespCenter: Record "50015";
    begin
        UserSetup.GET(USERID);
        CompanyInfo.GET;
        IF NOT CompanyInfo."Activate Local Resp. Center" THEN BEGIN
            IF RespCenter.GET(UserSetup."Default Accountability Center") THEN BEGIN
                CASE "Document Profile" OF
                    "Document Profile"::Purchase:
                        BEGIN
                            CASE "Document Type" OF
                                "Document Type"::Quote:
                                    RespCenter.TESTFIELD("Purch. Quote Nos.");
                                "Document Type"::"Blanket Order":
                                    RespCenter.TESTFIELD("Purch. Blanket Order Nos.");
                                "Document Type"::Order:
                                    RespCenter.TESTFIELD("Purch. Order Nos.");
                                "Document Type"::"Return Order":
                                    RespCenter.TESTFIELD("Purch. Return Order Nos.");
                                "Document Type"::Invoice:
                                    RespCenter.TESTFIELD("Purch. Invoice Nos.");
                                "Document Type"::"Posted Invoice":
                                    RespCenter.TESTFIELD("Purch. Posted Invoice Nos.");
                                "Document Type"::"Credit Memo":
                                    RespCenter.TESTFIELD("Purch. Credit Memo Nos.");
                                "Document Type"::"Posted Credit Memo":
                                    RespCenter.TESTFIELD("Purch. Posted Credit Memo Nos.");
                                "Document Type"::"Posted Receipt":
                                    RespCenter.TESTFIELD("Purch. Posted Receipt Nos.");
                                "Document Type"::"Posted Return Shipment":
                                    RespCenter.TESTFIELD("Purch. Ptd. Return Shpt. Nos.");
                                "Document Type"::"Posted Prepmt. Inv.":
                                    RespCenter.TESTFIELD("Purch. Posted Prept. Inv. Nos.");
                                "Document Type"::"Posted Prepmt. Cr. Memo":
                                    RespCenter.TESTFIELD("Purch. Ptd. Prept. Cr. M. Nos.");
                            END;
                        END;
                    "Document Profile"::Sales:
                        BEGIN
                            CASE "Document Type" OF
                                "Document Type"::Quote:
                                    RespCenter.TESTFIELD("Sales Quote Nos.");
                                "Document Type"::"Blanket Order":
                                    RespCenter.TESTFIELD("Sales Blanket Order Nos.");
                                "Document Type"::Order:
                                    RespCenter.TESTFIELD("Sales Order Nos.");
                                "Document Type"::"Return Order":
                                    RespCenter.TESTFIELD("Sales Return Order Nos.");
                                "Document Type"::Invoice:
                                    RespCenter.TESTFIELD("Sales Invoice Nos.");
                                "Document Type"::"Posted Invoice":
                                    RespCenter.TESTFIELD("Sales Posted Invoice Nos.");
                                "Document Type"::"Credit Memo":
                                    RespCenter.TESTFIELD("Sales Credit Memo Nos.");
                                "Document Type"::"Posted Credit Memo":
                                    RespCenter.TESTFIELD("Sales Posted Credit Memo Nos.");
                                "Document Type"::"Posted Shipment":
                                    RespCenter.TESTFIELD("Sales Posted Shipment Nos.");
                                "Document Type"::"Posted Return Receipt":
                                    RespCenter.TESTFIELD("Sales Ptd. Return Receipt Nos.");
                                "Document Type"::"Posted Prepmt. Inv.":
                                    RespCenter.TESTFIELD("Sales Posted Prepmt. Inv. Nos.");
                                "Document Type"::"Posted Prepmt. Cr. Memo":
                                    RespCenter.TESTFIELD("Sales Ptd. Prept. Cr. M. Nos.");
                            END;
                        END;
                    "Document Profile"::Service:
                        BEGIN
                            CASE "Document Type" OF
                                "Document Type"::Quote:
                                    RespCenter.TESTFIELD("Service Quote Nos.");
                                "Document Type"::Order:
                                    RespCenter.TESTFIELD("Service Order Nos.");
                                "Document Type"::Invoice:
                                    RespCenter.TESTFIELD("Service Invoice Nos.");
                                "Document Type"::"Posted Invoice":
                                    RespCenter.TESTFIELD("Posted Service Invoice Nos.");
                                "Document Type"::"Credit Memo":
                                    RespCenter.TESTFIELD("Service Credit Memo Nos.");
                                "Document Type"::"Posted Credit Memo":
                                    RespCenter.TESTFIELD("Posted Serv. Credit Memo Nos.");
                                "Document Type"::"Posted Shipment":
                                    RespCenter.TESTFIELD("Posted Service Shipment Nos.");
                            END;
                        END;
                    "Document Profile"::Transfer:
                        BEGIN
                            CASE "Document Type" OF
                                "Document Type"::Order:
                                    RespCenter.TESTFIELD("Trans. Order Nos.");
                                "Document Type"::"Posted Receipt":
                                    RespCenter.TESTFIELD("Posted Transfer Rcpt. Nos.");
                                "Document Type"::"Posted Shipment":
                                    RespCenter.TESTFIELD("Posted Transfer Shpt. Nos.");
                            END;
                        END;
                END;
            END;
        END ELSE BEGIN
            //to code later
        END;
    end;

    [Scope('Internal')]
    procedure GetUserRespCenter(): Code[10]
    var
        UserSetup: Record "91";
    begin
        UserSetup.GET(USERID);
        UserSetup.TESTFIELD("Default Accountability Center");
        EXIT(UserSetup."Default Accountability Center");
    end;

    [Scope('Internal')]
    procedure GetUserRespCenterFilter() RespCenterFilter: Text
    var
        UserSetup: Record "91";
        UserRespCenter: Record "50016";
    begin
        UserSetup.GET(USERID);
        IF UserSetup."Default Accountability Center" <> '' THEN
            RespCenterFilter := UserSetup."Default Accountability Center";
        UserRespCenter.RESET;
        UserRespCenter.SETRANGE("User ID", USERID);
        IF UserRespCenter.FINDSET THEN
            REPEAT
                IF UserRespCenter."Accountability Center" <> '' THEN BEGIN
                    IF RespCenterFilter <> '' THEN BEGIN
                        RespCenterFilter += '|' + UserRespCenter."Accountability Center"
                    END
                    ELSE
                        RespCenterFilter += UserRespCenter."Accountability Center"
                END;
            UNTIL UserRespCenter.NEXT = 0;
        EXIT(RespCenterFilter);
    end;

    [Scope('Internal')]
    procedure Compare(Number: Text[30]; Digit: Integer; StartDigit: Text[1]): Boolean
    var
        i: Integer;
        Cf: Text[1];
        Ce: Text[1];
        Check: Boolean;
    begin
        Check := TRUE;
        IF (STRLEN(Number) = Digit) OR (STRLEN(Number) = 0) THEN
            FOR i := 1 TO STRLEN(Number) DO BEGIN
                Ce := COPYSTR(Number, i, 1);
                IF (i = 1) AND (Ce <> StartDigit) THEN
                    Check := FALSE;
                IF NOT ((Ce >= '0') AND (Ce <= '9')) THEN
                    Check := FALSE;
            END
        ELSE
            Check := FALSE;
        EXIT(Check);
    end;

    [Scope('OnPrem')]
    procedure CreatePurchaseOrder(PurchConsignment: Record "Purchase Consignment"): Boolean
    var
        PurchaseHeader: Record "Purchase Header";
        Text101: Label 'Purchase Order %1 has been created.';
        Text102: Label 'Purchase Orders exist for Purchase Consignment No. %1. Do you to create new Purchase Order?';
    begin
        PurchaseHeader.RESET;
        PurchaseHeader.INIT;
        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Order;
        PurchaseHeader.INSERT(TRUE);
        PurchaseHeader."Purchase Consignment No." := PurchConsignment."No.";
        PurchaseHeader.MODIFY(TRUE);
        MESSAGE(Text101, PurchaseHeader."No.");
    end;

    [Scope('OnPrem')]
    procedure CreatePurchaseInvoice(PurchConsignment: Record "Purchase Consignment"): Boolean
    var
        PurchaseHeader: Record "Purchase Header";
        Text101: Label 'Purchase Invoice %1 has been created.';
    begin
        PurchaseHeader.RESET;
        PurchaseHeader.INIT;
        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Invoice;
        PurchaseHeader.INSERT(TRUE);
        PurchaseHeader."Purchase Consignment No." := PurchConsignment."No.";
        PurchaseHeader.MODIFY(TRUE);
        MESSAGE(Text101, PurchaseHeader."No.");
    end;

    [Scope('OnPrem')]
    procedure CreatePurchaseCreditMemo(PurchConsignment: Record "Purchase Consignment"): Boolean
    var
        PurchaseHeader: Record "Purchase Header";
        Text101: Label 'Purchase Credit Memo %1 has been created.';
        Text102: Label 'Purchase Credit Memo exist for Purchase Consignment No. %1. Do you want to create new Purchase Credit Memo?';
    begin
        PurchaseHeader.RESET;
        PurchaseHeader.INIT;
        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::"Credit Memo";
        PurchaseHeader.INSERT(TRUE);
        PurchaseHeader."Purchase Consignment No." := PurchConsignment."No.";
        PurchaseHeader.MODIFY(TRUE);
        MESSAGE(Text101, PurchaseHeader."No.");
    end;

    [Scope('OnPrem')]
    procedure CreatePurchaseReturnOrder(PurchConsignment: Record "Purchase Consignment"): Boolean
    var
        PurchaseHeader: Record "Purchase Header";
        Text101: Label 'Purchase Credit Memo %1 has been created.';
        Text102: Label 'Purchase Credit Memo exist for Purchase Consignment No. %1. Do you want to create new Purchase Credit Memo?';
    begin
        PurchaseHeader.RESET;
        PurchaseHeader.INIT;
        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::"Return Order";
        PurchaseHeader.INSERT(TRUE);
        PurchaseHeader."Purchase Consignment No." := PurchConsignment."No.";
        PurchaseHeader.MODIFY(TRUE);
        MESSAGE(Text101, PurchaseHeader."No.");
    end;

    [Scope('OnPrem')]
    procedure InitCustomFieldsOnSalesHeaderInsert_DMS_Fxn(var Rec: Record "36")
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.GET(USERID);
        UserSetup.TESTFIELD("Default Location Code");
        Rec.VALIDATE("Location Code", UserSetup."Default Location Code");
        //Rec.MODIFY;
    end;

    [Scope('OnPrem')]
    procedure InitCustomFieldsOnPurchaseHeaderInsert_DMS_Fxn(var Rec: Record "38")
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.GET(USERID);
        UserSetup.TESTFIELD("Default Location Code");
        Rec.VALIDATE("Location Code", UserSetup."Default Location Code");
        //Rec.MODIFY;
    end;

    [EventSubscriber(ObjectType::Table, 83, 'OnAfterCopyItemJnlLineFromPurchLine', '', false, false)]
    local procedure OnAfterCopyItemJnlLineFromPurchase(var ItemJnlLine: Record "83"; PurchLine: Record "39")
    begin
        ItemJnlLine."Shortcut Dimension 3 Code" := PurchLine."Shortcut Dimension 3 Code";
        ItemJnlLine."Shortcut Dimension 4 Code" := PurchLine."Shortcut Dimension 4 Code";
        ItemJnlLine."Shortcut Dimension 5 Code" := PurchLine."Shortcut Dimension 5 Code";
        ItemJnlLine."Shortcut Dimension 6 Code" := PurchLine."Shortcut Dimension 6 Code";
        ItemJnlLine."Shortcut Dimension 7 Code" := PurchLine."Shortcut Dimension 7 Code";
        ItemJnlLine."Shortcut Dimension 8 Code" := PurchLine."Shortcut Dimension 8 Code";
    end;

    [EventSubscriber(ObjectType::Table, 83, 'OnAfterCopyItemJnlLineFromSalesLine', '', false, false)]
    local procedure OnAfterCopyItemJnlLineFromSales(var ItemJnlLine: Record "83"; SalesLine: Record "37")
    begin
        ItemJnlLine."Shortcut Dimension 3 Code" := SalesLine."Shortcut Dimension 3 Code";
        ItemJnlLine."Shortcut Dimension 4 Code" := SalesLine."Shortcut Dimension 4 Code";
        ItemJnlLine."Shortcut Dimension 5 Code" := SalesLine."Shortcut Dimension 5 Code";
        ItemJnlLine."Shortcut Dimension 6 Code" := SalesLine."Shortcut Dimension 6 Code";
        ItemJnlLine."Shortcut Dimension 7 Code" := SalesLine."Shortcut Dimension 7 Code";
        ItemJnlLine."Shortcut Dimension 8 Code" := SalesLine."Shortcut Dimension 8 Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, 22, 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "32"; ItemJournalLine: Record "83")
    begin
        NewItemLedgEntry."Shortcut Dimension 3 Code" := ItemJournalLine."Shortcut Dimension 3 Code";
        NewItemLedgEntry."Shortcut Dimension 4 Code" := ItemJournalLine."Shortcut Dimension 4 Code";
        NewItemLedgEntry."Shortcut Dimension 5 Code" := ItemJournalLine."Shortcut Dimension 5 Code";
        NewItemLedgEntry."Shortcut Dimension 6 Code" := ItemJournalLine."Shortcut Dimension 6 Code";
        NewItemLedgEntry."Shortcut Dimension 7 Code" := ItemJournalLine."Shortcut Dimension 7 Code";
        NewItemLedgEntry."Shortcut Dimension 8 Code" := ItemJournalLine."Shortcut Dimension 8 Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, 22, 'OnAfterInitValueEntry', '', false, false)]
    local procedure OnAfterInitValueEntry(var ValueEntry: Record "5802"; ItemJournalLine: Record "83")
    begin
        ValueEntry."Shortcut Dimension 3 Code" := ItemJournalLine."Shortcut Dimension 3 Code";
        ValueEntry."Shortcut Dimension 4 Code" := ItemJournalLine."Shortcut Dimension 4 Code";
        ValueEntry."Shortcut Dimension 5 Code" := ItemJournalLine."Shortcut Dimension 5 Code";
        ValueEntry."Shortcut Dimension 6 Code" := ItemJournalLine."Shortcut Dimension 6 Code";
        ValueEntry."Shortcut Dimension 7 Code" := ItemJournalLine."Shortcut Dimension 7 Code";
        ValueEntry."Shortcut Dimension 8 Code" := ItemJournalLine."Shortcut Dimension 8 Code";
    end;

    [Scope('Internal')]
    procedure InsertFreeItemSalesLine(var SalesLine: Record "37")
    var
        SalesHeader: Record "36";
        CustPostingGr: Record "92";
        Item: Record "27";
        FreeItemSalesLine: Record "37";
        LastLineNo: Integer;
        BaseQuantity: Decimal;
    begin
        WITH SalesLine DO BEGIN
            IF ("Document Type" IN ["Document Type"::"Credit Memo", "Document Type"::"Return Order", "Document Type"::"Blanket Order",
                                   "Document Type"::"Blanket Order", "Document Type"::Quote]) OR (Type <> Type::Item) OR "Free Item Line" THEN
                EXIT;
            IF (Type <> Type::Item) OR "Free Item Line" THEN
                EXIT;


            SalesHeader.GET("Document Type", "Document No.");
            CustPostingGr.GET(SalesHeader."Customer Posting Group");
            IF NOT CustPostingGr."Free Deal Applicable" THEN
                EXIT;

            FreeItemSalesLine.RESET;
            FreeItemSalesLine.SETRANGE("Document Type", SalesLine."Document Type");
            FreeItemSalesLine.SETRANGE("Document No.", SalesLine."Document No.");
            IF FreeItemSalesLine.FINDLAST THEN
                LastLineNo := FreeItemSalesLine."Line No." + 1000
            ELSE
                LastLineNo := 1000;

            FreeItemSalesLine.RESET;
            FreeItemSalesLine.SETRANGE("Document Type", SalesLine."Document Type");
            FreeItemSalesLine.SETRANGE("Document No.", SalesLine."Document No.");
            FreeItemSalesLine.SETRANGE("Free Item Line", TRUE);
            FreeItemSalesLine.SETRANGE("Sales Line No.", SalesLine."Line No.");
            IF FreeItemSalesLine.FINDFIRST THEN
                FreeItemSalesLine.DELETEALL;

            Item.GET(SalesLine."No.");
            IF Item."Sales Order Threshold Qty." <> 0 THEN BEGIN
                IF SalesLine."Document Type" IN [SalesLine."Document Type"::"Return Order", SalesLine."Document Type"::"Credit Memo"] THEN
                    BaseQuantity := SalesLine."Return Qty. to Receive"
                ELSE
                    BaseQuantity := SalesLine.Quantity;

                IF BaseQuantity >= Item."Sales Order Threshold Qty." THEN BEGIN
                    FreeItemSalesLine.RESET;
                    FreeItemSalesLine.SETRANGE("Document Type", SalesLine."Document Type");
                    FreeItemSalesLine.SETRANGE("Document No.", SalesLine."Document No.");
                    FreeItemSalesLine.SETRANGE("Sales Line No.", SalesLine."Line No.");
                    IF NOT FreeItemSalesLine.FINDFIRST THEN BEGIN

                        FreeItemSalesLine.INIT;
                        FreeItemSalesLine.SetHideValidationDialog(TRUE);
                        FreeItemSalesLine."Document Type" := SalesLine."Document Type";
                        FreeItemSalesLine."Document No." := SalesLine."Document No.";
                        FreeItemSalesLine."Line No." := LastLineNo;
                        FreeItemSalesLine.VALIDATE(Type, FreeItemSalesLine.Type::Item);
                        FreeItemSalesLine.VALIDATE("No.", Item."No.");
                        FreeItemSalesLine."Free Item Line" := TRUE;
                        FreeItemSalesLine."Sales Line No." := SalesLine."Line No.";
                        FreeItemSalesLine."Batch No." := SalesLine."Batch No.";
                        FreeItemSalesLine."Manufacturing Date" := SalesLine."Manufacturing Date";
                        FreeItemSalesLine."Expiry Date" := SalesLine."Expiry Date";
                        FreeItemSalesLine."Returned Document No." := SalesLine."Returned Document No.";
                        FreeItemSalesLine."Returned Document Line No." := SalesLine."Returned Document Line No.";
                        FreeItemSalesLine.VALIDATE("Shortcut Dimension 1 Code", SalesLine."Shortcut Dimension 1 Code");
                        FreeItemSalesLine.VALIDATE("Shortcut Dimension 2 Code", SalesLine."Shortcut Dimension 2 Code");
                        FreeItemSalesLine.VALIDATE("Shortcut Dimension 3 Code", SalesLine."Shortcut Dimension 3 Code");
                        FreeItemSalesLine.VALIDATE("Shortcut Dimension 4 Code", SalesLine."Shortcut Dimension 4 Code");
                        FreeItemSalesLine.VALIDATE("Shortcut Dimension 5 Code", SalesLine."Shortcut Dimension 5 Code");
                        FreeItemSalesLine.VALIDATE("Shortcut Dimension 6 Code", SalesLine."Shortcut Dimension 6 Code");
                        FreeItemSalesLine.VALIDATE("Shortcut Dimension 7 Code", SalesLine."Shortcut Dimension 7 Code");
                        FreeItemSalesLine.VALIDATE("Shortcut Dimension 8 Code", SalesLine."Shortcut Dimension 8 Code");
                        FreeItemSalesLine.INSERT(TRUE);
                        IF ((BaseQuantity MOD Item."Sales Order Threshold Qty.") = 0) THEN
                            FreeItemSalesLine.VALIDATE(Quantity, (BaseQuantity DIV Item."Sales Order Threshold Qty.") * Item."Free Sales Quantity") //free quantity
                        ELSE
                            FreeItemSalesLine.VALIDATE(Quantity, Item."Free Sales Quantity");
                        FreeItemSalesLine.VALIDATE("Unit Price", 0);
                        FreeItemSalesLine.VALIDATE("Line Discount %", 0);
                        FreeItemSalesLine.MODIFY(TRUE);
                    END ELSE BEGIN
                        FreeItemSalesLine."Batch No." := SalesLine."Batch No.";
                        FreeItemSalesLine."Manufacturing Date" := SalesLine."Manufacturing Date";
                        FreeItemSalesLine."Expiry Date" := SalesLine."Expiry Date";
                        FreeItemSalesLine."Sales Line No." := SalesLine."Line No.";
                        FreeItemSalesLine."Returned Document No." := SalesLine."Returned Document No.";
                        FreeItemSalesLine."Returned Document Line No." := SalesLine."Returned Document Line No.";
                        FreeItemSalesLine.VALIDATE("Shortcut Dimension 1 Code", SalesLine."Shortcut Dimension 1 Code");
                        FreeItemSalesLine.VALIDATE("Shortcut Dimension 2 Code", SalesLine."Shortcut Dimension 2 Code");
                        FreeItemSalesLine.VALIDATE("Shortcut Dimension 3 Code", SalesLine."Shortcut Dimension 3 Code");
                        FreeItemSalesLine.VALIDATE("Shortcut Dimension 4 Code", SalesLine."Shortcut Dimension 4 Code");
                        FreeItemSalesLine.VALIDATE("Shortcut Dimension 5 Code", SalesLine."Shortcut Dimension 5 Code");
                        FreeItemSalesLine.VALIDATE("Shortcut Dimension 6 Code", SalesLine."Shortcut Dimension 6 Code");
                        FreeItemSalesLine.VALIDATE("Shortcut Dimension 7 Code", SalesLine."Shortcut Dimension 7 Code");
                        FreeItemSalesLine.VALIDATE("Shortcut Dimension 8 Code", SalesLine."Shortcut Dimension 8 Code");
                        FreeItemSalesLine.MODIFY(TRUE);
                    END;
                END;
            END;
        END;
    end;

    [Scope('Internal')]
    procedure ManageFreeItemSalesReturnLine(var SalesLine: Record "37")
    var
        recReservEntry: Record "337";
        FreeSalesReturnLine: Record "37";
        BatchNo: Code[20];
        LotNoInfo: Record "6505";
        CreateReservEntry: Codeunit "99000830";
        BaseQty: Decimal;
        FreeRetQty: Decimal;
        Item: Record "27";
    begin
        IF SalesLine."Document Type" IN [SalesLine."Document Type"::"Return Order", SalesLine."Document Type"::"Credit Memo"] THEN BEGIN
            IF SalesLine.Type <> SalesLine.Type::Item THEN
                EXIT;
            BaseQty := SalesLine."Return Qty. to Receive";


            Item.GET(SalesLine."No.");
            IF Item."Sales Order Threshold Qty." = 0 THEN
                EXIT;
            IF ((BaseQty MOD Item."Sales Order Threshold Qty.") = 0) THEN
                FreeRetQty := (BaseQty DIV Item."Sales Order Threshold Qty.") * Item."Free Sales Quantity"
            //FreeItemSalesLine.VALIDATE(Quantity,(BaseQuantity DIV Item."Sales Order Threshold Qty.")*Item."Free Sales Quantity") //free quantity
            ELSE
                FreeRetQty := Item."Free Sales Quantity";
            //FreeItemSalesLine.VALIDATE(Quantity,Item."Free Sales Quantity");

            FreeSalesReturnLine.RESET;
            FreeSalesReturnLine.SETRANGE("Document No.", SalesLine."Document No.");
            FreeSalesReturnLine.SETRANGE("Returned Document No.", SalesLine."Returned Document No.");
            FreeSalesReturnLine.SETRANGE("Sales Line No.", SalesLine."Returned Document Line No.");
            IF FreeSalesReturnLine.FINDFIRST THEN BEGIN

                recReservEntry.RESET;
                recReservEntry.LOCKTABLE;
                recReservEntry.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name",
                 "Source Prod. Order Line", "Reservation Status");

                //find the existing batch details
                recReservEntry.SETRANGE("Source ID", FreeSalesReturnLine."Document No.");
                recReservEntry.SETRANGE("Source Ref. No.", FreeSalesReturnLine."Line No.");
                recReservEntry.SETRANGE("Source Type", DATABASE::"Sales Line");
                recReservEntry.SETRANGE("Source Subtype", FreeSalesReturnLine."Document Type");
                recReservEntry.SETRANGE("Source Batch Name", '');
                recReservEntry.SETRANGE("Source Prod. Order Line", 0);
                recReservEntry.SETRANGE("Reservation Status", recReservEntry."Reservation Status"::Surplus);
                IF recReservEntry.FINDFIRST THEN BEGIN
                    LotNoInfo.GET(FreeSalesReturnLine."No.", recReservEntry."Variant Code", recReservEntry."Lot No.");
                END;

                //delete reservation line
                recReservEntry.SETRANGE("Source ID", FreeSalesReturnLine."Document No.");
                recReservEntry.SETRANGE("Source Ref. No.", FreeSalesReturnLine."Line No.");
                recReservEntry.SETRANGE("Source Type", DATABASE::"Sales Line");
                recReservEntry.SETRANGE("Source Subtype", FreeSalesReturnLine."Document Type");
                recReservEntry.SETRANGE("Source Batch Name", '');
                recReservEntry.SETRANGE("Source Prod. Order Line", 0);
                recReservEntry.SETRANGE("Reservation Status", recReservEntry."Reservation Status"::Surplus);
                recReservEntry.DELETEALL;

                //modify existing free quantity
                FreeSalesReturnLine.VALIDATE(Quantity, FreeRetQty);
                FreeSalesReturnLine.VALIDATE("Unit Price", 0);
                FreeSalesReturnLine.MODIFY;

                //recreate reservation based on new return qty. to receive
                CreateReservEntry.SetManufacturingDate(LotNoInfo."Manufacturing Date");
                CreateReservEntry.SetDates(0D, LotNoInfo."Expiry Date");
                CreateReservEntry.CreateReservEntryFor(DATABASE::"Sales Line", FreeSalesReturnLine."Document Type",
                FreeSalesReturnLine."Document No.", '', 0, FreeSalesReturnLine."Line No.", FreeSalesReturnLine."Qty. per Unit of Measure",
                FreeRetQty, FreeRetQty, '', LotNoInfo."Lot No.");
                CreateReservEntry.CreateEntry(FreeSalesReturnLine."No.", FreeSalesReturnLine."Variant Code", FreeSalesReturnLine."Location Code",
                '', 0D, FreeSalesReturnLine."Shipment Date", 0, 2);

            END;
        END;
    end;

    [Scope('Internal')]
    procedure SendSalesExpectedDeliveryDateCrossedEmail(SalesHdr: Record "36")
    var
        CompanyInfo: Record "79";
        SalesSetup: Record "311";
        SMTPMailSetup: Record "409";
        SMTPMail: Codeunit "400";
    begin
        WITH SalesHdr DO BEGIN

        END;
    end;

    [Scope('Internal')]
    procedure JobQueueActive(): Boolean
    begin
        EXIT(NOT GUIALLOWED);
    end;

    [Scope('Internal')]
    procedure CreateLotInformation(TempTrackingSpecification: Record "336")
    var
        LotInfo: Record "6505";
        Item: Record "27";
    begin
        Item.GET(TempTrackingSpecification."Item No.");
        LotInfo.RESET;
        LotInfo.SETRANGE("Item No.", TempTrackingSpecification."Item No.");
        LotInfo.SETRANGE("Variant Code", TempTrackingSpecification."Variant Code");
        LotInfo.SETRANGE("Lot No.", TempTrackingSpecification."Lot No.");
        IF NOT LotInfo.FINDFIRST THEN BEGIN
            //TempTrackingSpecification.TESTFIELD("Manufacturing Date");
            TempTrackingSpecification.TESTFIELD("Expiration Date");
            LotInfo.INIT;
            LotInfo."Lot No." := TempTrackingSpecification."Lot No.";
            LotInfo.Description := Item.Description;
            LotInfo."Item No." := TempTrackingSpecification."Item No.";
            LotInfo."Variant Code" := TempTrackingSpecification."Variant Code";
            LotInfo."Manufacturing Date" := TempTrackingSpecification."Manufacturing Date";
            LotInfo."Expiry Date" := TempTrackingSpecification."Expiration Date";
            LotInfo.INSERT;
        END ELSE BEGIN
            //TempTrackingSpecification.TESTFIELD("Manufacturing Date");
            TempTrackingSpecification.TESTFIELD("Expiration Date");
            LotInfo.Description := Item.Description;
            LotInfo."Manufacturing Date" := TempTrackingSpecification."Manufacturing Date";
            LotInfo."Expiry Date" := TempTrackingSpecification."Expiration Date";
            LotInfo.MODIFY;
        END;
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnAfterInsertEvent', '', false, false)]
    local procedure CheckSalesLineValidity(var Rec: Record "37"; RunTrigger: Boolean)
    var
        AlreadyInsertedSalesLine: Record "37";
        SalesSetup: Record "311";
        SalesHeader: Record "36";
    begin
        SalesSetup.GET;
        AlreadyInsertedSalesLine.RESET;
        AlreadyInsertedSalesLine.SETRANGE("Document Type", Rec."Document Type");
        AlreadyInsertedSalesLine.SETRANGE("Document No.", Rec."Document No.");
        AlreadyInsertedSalesLine.SETRANGE("Free Item Line", FALSE);
        AlreadyInsertedSalesLine.SETFILTER("No.", '<>%1', '');
        IF (AlreadyInsertedSalesLine.COUNT > SalesSetup."Maximum Sales Line Per Doc.") AND (SalesSetup."Maximum Sales Line Per Doc." > 0) THEN
            ERROR('%1 is %2.More lines cannot be inserted for sales document %3.', SalesSetup.FIELDCAPTION("Maximum Sales Line Per Doc."), SalesSetup."Maximum Sales Line Per Doc.", AlreadyInsertedSalesLine."Document No.");
    end;

    [Scope('Internal')]
    procedure AutoCreateBillDeliveryDetail(SalesInvHeader: Record "112")
    var
        BillDeliveryDetails: Record "50027";
    begin
        BillDeliveryDetails.RESET;
        BillDeliveryDetails.SETRANGE("Sales Invoice No.", SalesInvHeader."No.");
        IF NOT BillDeliveryDetails.FINDFIRST THEN BEGIN
            BillDeliveryDetails.INIT;
            BillDeliveryDetails."Accountability Center" := SalesInvHeader."Accountability Center";
            BillDeliveryDetails."Location Code" := SalesInvHeader."Location Code";
            BillDeliveryDetails."Posting Date" := SalesInvHeader."Posting Date";
            BillDeliveryDetails."M.R." := SalesInvHeader."M.R.";
            BillDeliveryDetails."Doc. Thru." := SalesInvHeader."Doc. Thru.";
            BillDeliveryDetails.Cases := SalesInvHeader.Cases;
            BillDeliveryDetails."Dispatch Date" := SalesInvHeader."Dispatch Date";
            BillDeliveryDetails."Transport Name" := SalesInvHeader."Transport Name";
            BillDeliveryDetails."CN No." := SalesInvHeader."CN No.";
            BillDeliveryDetails."Sales Invoice No." := SalesInvHeader."No.";
            BillDeliveryDetails."Sales Order No." := SalesInvHeader."Order No.";
            BillDeliveryDetails.INSERT(TRUE);
        END;
    end;

    [Scope('OnPrem')]
    procedure CreateAndOpenBillDeliveryDetail(SalesInvHeader: Record "Sales Invoice Header")
    var
        BillDeliveryDetails: Record "Bill Delivery Details";
        BillDeliveryDetail: Page "Bill Delivery Detail";
    begin
        AutoCreateBillDeliveryDetail(SalesInvHeader);
        BillDeliveryDetails.RESET;
        BillDeliveryDetails.SETRANGE("Sales Invoice No.", SalesInvHeader."No.");
        BillDeliveryDetail.SETTABLEVIEW(BillDeliveryDetails);
        BillDeliveryDetail.SETRECORD(BillDeliveryDetails);
        BillDeliveryDetail.RUN;
    end;
}

