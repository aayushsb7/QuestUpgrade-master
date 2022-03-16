codeunit 50001 "IRD Engine"
{
    Permissions = TableData 112 = m,
                  TableData 5992 = m;

    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', false, false)]
    local procedure InsertSalesMaterializedView(var SalesHeader: Record "36"; var GenJnlPostLine: Codeunit "12"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20])
    var
        SysMgt: Codeunit "50000";
    begin
        /*
        WITH SalesHeader DO BEGIN
          IF Invoice THEN BEGIN
            IF "Document Type" IN ["Document Type"::Order,"Document Type"::Invoice] THEN BEGIN
              CLEAR(SysMgt);
              SysMgt.InsertRegisterInvoice(DATABASE::"Sales Invoice Header",SalesInvHdrNo);
            END
            ELSE BEGIN
              CLEAR(SysMgt);
              SysMgt.InsertRegisterInvoice(DATABASE::"Sales Cr.Memo Header",SalesCrMemoHdrNo);
            END;
          END;
        END;
        */

    end;

    [EventSubscriber(ObjectType::Codeunit, 5980, 'OnAfterPostServiceDoc', '', false, false)]
    local procedure InsertServiceMaterializedView(var ServiceHeader: Record "5900"; ServiceShptHdrNo: Code[20]; ServiceInvHdrNo: Code[20]; ServiceCrMemoHdrNo: Code[20]; Ship: Boolean; Consume: Boolean; Invoice: Boolean; WhseShip: Boolean)
    var
        SysMgt: Codeunit "50000";
    begin
        /*WITH ServiceHeader DO BEGIN
          IF Invoice THEN BEGIN
            IF "Document Type" IN ["Document Type"::Order,"Document Type"::Invoice] THEN BEGIN
              CLEAR(SysMgt);
              SysMgt.InsertRegisterInvoice(DATABASE::"Service Invoice Header",ServiceInvHdrNo);
            END
            ELSE BEGIN
              CLEAR(SysMgt);
              SysMgt.InsertRegisterInvoice(DATABASE::"Service Cr.Memo Header",ServiceCrMemoHdrNo);
            END;
          END;
        END;
        */

    end;

    [EventSubscriber(ObjectType::Codeunit, 2, 'OnAfterInitializeCompany', '', false, false)]
    local procedure InitializeCompany()
    var
        ReportSelections: Record "77";
        SysMgt: Codeunit "50000";
    begin
        SysMgt.InitReportSelection;
        SysMgt.EnableChangeLog;
    end;

    [EventSubscriber(ObjectType::Codeunit, 11, 'OnAfterCheckGenJnlLine', '', false, false)]
    local procedure CheckGenJnlLine(var GenJournalLine: Record "81")
    var
        GLAccount: Record "15";
        PurchSetup: Record "312";
        SalesSetup: Record "311";
    begin
        /*WITH GenJournalLine DO BEGIN
          IF ("Gen. Posting Type" =  "Gen. Posting Type"::Purchase) THEN BEGIN
            PurchSetup.GET;
            IF PurchSetup."Ext. Doc. No. Mandatory" THEN
              TESTFIELD("External Document No.");
            TESTFIELD("Localized VAT Identifier");
          END;
        
          IF ("Gen. Posting Type" =  "Gen. Posting Type"::Sale)  THEN BEGIN
            SalesSetup.GET;
            IF SalesSetup."Ext. Doc. No. Mandatory" THEN
              TESTFIELD("External Document No.");
            TESTFIELD("Localized VAT Identifier");
          END;
        
          IF "VAT %"  > 0 THEN
            TESTFIELD("VAT Registration No.");
        END;
        */

    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterInitGLRegister', '', false, false)]
    local procedure CopyOnGLRegister(var GLRegister: Record "45"; var GenJournalLine: Record "81")
    begin
        //GLRegister."Creation Time" := TIME;
    end;

    [EventSubscriber(ObjectType::Table, 17, 'OnAfterCopyGLEntryFromGenJnlLine', '', false, false)]
    local procedure CopyGLEntryFromGenJnlLine(var GLEntry: Record "17"; var GenJournalLine: Record "81")
    begin
        /*
        GLEntry.Narration := GenJournalLine.Narration;
        GLEntry."Localized VAT Identifier" := GenJournalLine."Localized VAT Identifier";
        GLEntry.PragyapanPatra := GenJournalLine.PragyapanPatra;
        */

    end;

    [EventSubscriber(ObjectType::Table, 254, 'OnAfterCopyVATEntryFromGenJnlLine', '', false, false)]
    local procedure CopyVATEntryFromGenJnlLine(var Sender: Record "254"; GenJournalLine: Record "81")
    begin
        /*
        Sender.PragyapanPatra := GenJournalLine.PragyapanPatra;
        Sender."Localized VAT Identifier" := GenJournalLine."Localized VAT Identifier";
        Sender."Shortcut Dimension 1 Code" := GenJournalLine."Shortcut Dimension 1 Code";
        */

    end;

    [EventSubscriber(ObjectType::Codeunit, 22, 'OnAfterInsertItemLedgEntry', '', false, false)]
    local procedure CopyItemLedgEntryFromItemJnlLine(var ItemLedgerEntry: Record "32"; var ItemJournalLine: Record "83")
    begin
        /*
        ItemLedgerEntry.PragyapanPatra := ItemJournalLine.PragyapanPatra;
        ItemLedgerEntry.MODIFY;
        */

    end;

    [EventSubscriber(ObjectType::Codeunit, 6620, 'OnCopySalesInvLinesToDoc', '', false, false)]
    local procedure CopySalesInvHeaderToSalesLine(var FromSalesLine: Record "37"; SalesInvHeaderNo: Code[20])
    begin
        //FromSalesLine."Returned Document No." := SalesInvHeaderNo;
    end;

    [EventSubscriber(ObjectType::Codeunit, 6620, 'OnCopySalesShptLinesToDoc', '', false, false)]
    local procedure CopySalesShptHeaderToSalesLine(var FromSalesLine: Record "37"; SalesShptHeaderNo: Code[20])
    begin
        //FromSalesLine."Returned Document No." := SalesShptHeaderNo;
    end;

    [EventSubscriber(ObjectType::Codeunit, 6620, 'OnCopySalesReturnRcptToDocs', '', false, false)]
    local procedure CopySalesReturnRcptHeaderToSalesLine(var FromSalesLine: Record "37"; ReturnRcptHeaderNo: Code[20])
    begin
        //FromSalesLine."Returned Document No." := ReturnRcptHeaderNo;
    end;

    [EventSubscriber(ObjectType::Codeunit, 6620, 'OnCopySalesCrMemoLinesToDoc', '', false, false)]
    local procedure CopySalesCrMemoHeaderToSalesLine(var FromSalesLine: Record "37"; SalesCrMemoHeaderNo: Code[20])
    begin
        //FromSalesLine."Returned Document No." := SalesCrMemoHeaderNo;
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterCopyInvPostingBuffer', '', false, false)]
    local procedure CopyGenJnlLineFromInvPostBufferSales(var GenJournalLine: Record "81"; var InvoicePostBuffer: array[2] of Record "49")
    begin
        /*
        GenJournalLine.PragyapanPatra := InvoicePostBuffer[1].PragyapanPatra;
        GenJournalLine."Localized VAT Identifier" := InvoicePostBuffer[1]."Localized VAT Identifier";
        */

    end;

    [EventSubscriber(ObjectType::Codeunit, 442, 'OnAfterCopyInvPostingBuffer', '', false, false)]
    local procedure CopyGenJnlLineFromPrepInvPostBufferSales(var GenJournalLine: Record "81"; PrepaymentInvLineBuffer: Record "461")
    begin
        //GenJournalLine."Localized VAT Identifier" := PrepaymentInvLineBuffer."Localized VAT Identifier" :: Prepayments; //IME
    end;

    [EventSubscriber(ObjectType::Codeunit, 5987, 'OnAfterCopyInvPostingBuffer', '', false, false)]
    local procedure CopyGenJnlLineFromInvPostBufferService(var GenJournalLine: Record "81"; var InvoicePostBuffer: array[2] of Record "49")
    begin
        /*
        GenJournalLine.PragyapanPatra := InvoicePostBuffer[1].PragyapanPatra;
        GenJournalLine."Localized VAT Identifier" := InvoicePostBuffer[1]."Localized VAT Identifier";
        */

    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnAfterCopyInvPostingBuffer', '', false, false)]
    local procedure CopyGenJnlLineFromInvPostBufferPurchase(var GenJournalLine: Record "81"; var InvoicePostBuffer: array[2] of Record "49")
    begin
        /*
        GenJournalLine.PragyapanPatra := InvoicePostBuffer[1].PragyapanPatra;
        GenJournalLine."Localized VAT Identifier" := InvoicePostBuffer[1]."Localized VAT Identifier";
        */

    end;

    [EventSubscriber(ObjectType::Codeunit, 442, 'OnBeforeInsertSalesInvLine', '', false, false)]
    local procedure CopySalesInvLineFromPrepInvPostBuffer(var SalesInvoiceLine: Record "113"; var PrepaymentInvLineBuffer: Record "461")
    begin
        //SalesInvoiceLine."Localized VAT Identifier" := PrepaymentInvLineBuffer."Localized VAT Identifier" :: Prepayments; //IME
    end;

    [EventSubscriber(ObjectType::Codeunit, 442, 'OnBeforeInsertSalesCrMemoLine', '', false, false)]
    local procedure CopySalesCrMemoLineFromPrepInvPostBuffer(var SalesCrMemoLine: Record "115"; var PrepaymentInvLineBuffer: Record "461")
    begin
        //SalesCrMemoLine."Localized VAT Identifier" := PrepaymentInvLineBuffer."Localized VAT Identifier" :: Prepayments; //IME
    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnAfterValidateEvent', 'VAT Prod. Posting Group', false, false)]
    local procedure GetCustomVATPostingSetupOnJournalLine(var Rec: Record "81"; var xRec: Record "81"; CurrFieldNo: Integer)
    var
        VATPostingSetup: Record "325";
    begin
        /*
        IF VATPostingSetup.GET(Rec."VAT Bus. Posting Group",Rec."VAT Prod. Posting Group") THEN
          Rec."Localized VAT Identifier" := VATPostingSetup."Localized VAT Identifier";
        */

    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnAfterValidateEvent', 'VAT Prod. Posting Group', false, false)]
    local procedure GetCustomVATPostingSetupOnSalesLine(var Rec: Record "37"; var xRec: Record "37"; CurrFieldNo: Integer)
    var
        VATPostingSetup: Record "325";
    begin
        /*
        IF VATPostingSetup.GET(Rec."VAT Bus. Posting Group",Rec."VAT Prod. Posting Group") THEN
          Rec."Localized VAT Identifier" := VATPostingSetup."Localized VAT Identifier";
        */

    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'VAT Prod. Posting Group', false, false)]
    local procedure GetCustomVATPostingSetupOnPurchLine(var Rec: Record "39"; var xRec: Record "39"; CurrFieldNo: Integer)
    var
        VATPostingSetup: Record "325";
    begin
        /*
        IF VATPostingSetup.GET(Rec."VAT Bus. Posting Group",Rec."VAT Prod. Posting Group") THEN
          Rec."Localized VAT Identifier" := VATPostingSetup."Localized VAT Identifier";
        */

    end;

    [EventSubscriber(ObjectType::Table, 5902, 'OnAfterModifyEvent', '', false, false)]
    local procedure GetCustomVATPostingSetupOnServiceLine(var Rec: Record "5902"; var xRec: Record "5902"; RunTrigger: Boolean)
    var
        VATPostingSetup: Record "325";
    begin
        /*
        IF VATPostingSetup.GET(Rec."VAT Bus. Posting Group",Rec."VAT Prod. Posting Group") THEN
          Rec."Localized VAT Identifier" := VATPostingSetup."Localized VAT Identifier";
        */

    end;

    [EventSubscriber(ObjectType::Table, 5902, 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure GetCustomVATPostingSetupOnF6ServiceLine(var Rec: Record "5902"; var xRec: Record "5902"; CurrFieldNo: Integer)
    var
        VATPostingSetup: Record "325";
    begin
        /*
        IF VATPostingSetup.GET(Rec."VAT Bus. Posting Group",Rec."VAT Prod. Posting Group") THEN
          Rec."Localized VAT Identifier" := VATPostingSetup."Localized VAT Identifier";
        */

    end;

    [EventSubscriber(ObjectType::Codeunit, 315, 'OnNoPrintedModify', '', false, false)]
    local procedure ModifySalesInvPrintInformation(var SalesInvoiceHeader: Record "112")
    var
        RegisterofInvoiceNoSeries: Record "50001";
        AccountingPeriod: Record "50";
        SysMgt: Codeunit "50000";
        PrintingDate: Date;
        PrintingTime: Time;
    begin
        /*
        WITH SalesInvoiceHeader DO BEGIN
          PrintingDate := TODAY;
          PrintingTime := TIME;
          IF "No. Printed" = 1 THEN BEGIN
              "Tax Invoice Printed By" := USERID;
              RegisterofInvoiceNoSeries.RESET;
              RegisterofInvoiceNoSeries.SETRANGE("Table ID",DATABASE::"Sales Invoice Header");
              RegisterofInvoiceNoSeries.SETRANGE("Document Type",RegisterofInvoiceNoSeries."Document Type"::"Sales Invoice");
              RegisterofInvoiceNoSeries.SETRANGE("Document No.","No.");
              RegisterofInvoiceNoSeries.SETRANGE("Fiscal Year",SysMgt.GetNepaliFiscalYear("Posting Date"));
              IF RegisterofInvoiceNoSeries.FINDFIRST THEN BEGIN
                RegisterofInvoiceNoSeries.Printed := TRUE;
                RegisterofInvoiceNoSeries."Printed By" := USERID;
                RegisterofInvoiceNoSeries."Is Printed" := "No. Printed";
                RegisterofInvoiceNoSeries."Printed Time" := PrintingTime;
                RegisterofInvoiceNoSeries.MODIFY;
              END;
          END;
          SysMgt.InsertSalesDocPrintHistory(DATABASE::"Sales Invoice Header","No.",PrintingDate,PrintingTime);
        END;
        */

    end;

    [EventSubscriber(ObjectType::Codeunit, 316, 'OnNoPrintedModify', '', false, false)]
    local procedure ModifySalesCrInvPrintInformation(var SalesCrMemoHeader: Record "114")
    var
        RegisterofInvoiceNoSeries: Record "50001";
        AccountingPeriod: Record "50";
        SysMgt: Codeunit "50000";
        PrintingDate: Date;
        PrintingTime: Time;
    begin
        /*
        WITH SalesCrMemoHeader DO BEGIN
          PrintingDate := TODAY;
          PrintingTime := TIME;
          IF "No. Printed" = 1 THEN BEGIN
            "Printed By" := USERID;
            RegisterofInvoiceNoSeries.RESET;
            RegisterofInvoiceNoSeries.SETRANGE("Table ID",DATABASE::"Sales Invoice Header");
            RegisterofInvoiceNoSeries.SETRANGE("Document Type",RegisterofInvoiceNoSeries."Document Type"::"Sales Invoice");
            RegisterofInvoiceNoSeries.SETRANGE("Document No.","No.");
            RegisterofInvoiceNoSeries.SETRANGE("Fiscal Year",SysMgt.GetNepaliFiscalYear("Posting Date"));
            IF RegisterofInvoiceNoSeries.FINDFIRST THEN BEGIN
              RegisterofInvoiceNoSeries.Printed := TRUE;
              RegisterofInvoiceNoSeries."Printed By" := USERID;
              RegisterofInvoiceNoSeries."Is Printed" := "No. Printed";
              RegisterofInvoiceNoSeries."Printed Time" := PrintingTime;
              RegisterofInvoiceNoSeries.MODIFY;
            END;
          END;
          SysMgt.InsertSalesDocPrintHistory(DATABASE::"Sales Cr.Memo Header","No.",PrintingDate,PrintingTime);
        END;
        */

    end;

    [EventSubscriber(ObjectType::Codeunit, 5902, 'OnNoPrintedModify', '', false, false)]
    local procedure ModifyServiceInvPrintInformation(var ServiceInvoiceHeader: Record "5992")
    var
        RegisterofInvoiceNoSeries: Record "50001";
        AccountingPeriod: Record "50";
        SysMgt: Codeunit "50000";
        PrintingDate: Date;
        PrintingTime: Time;
    begin
        /*
        WITH ServiceInvoiceHeader DO BEGIN
          PrintingDate := TODAY;
          PrintingTime := TIME;
          IF "No. Printed" = 1 THEN BEGIN
              "Tax Invoice Printed By" := USERID;
              RegisterofInvoiceNoSeries.RESET;
              RegisterofInvoiceNoSeries.SETRANGE("Table ID",DATABASE::"Service Invoice Header");
              RegisterofInvoiceNoSeries.SETRANGE("Document Type",RegisterofInvoiceNoSeries."Document Type"::"Sales Invoice");
              RegisterofInvoiceNoSeries.SETRANGE("Document No.","No.");
              RegisterofInvoiceNoSeries.SETRANGE("Fiscal Year",SysMgt.GetNepaliFiscalYear("Posting Date"));
              IF RegisterofInvoiceNoSeries.FINDFIRST THEN BEGIN
                RegisterofInvoiceNoSeries.Printed := TRUE;
                RegisterofInvoiceNoSeries."Printed By" := USERID;
                RegisterofInvoiceNoSeries."Is Printed" := "No. Printed";
                RegisterofInvoiceNoSeries."Printed Time" := PrintingTime;
                RegisterofInvoiceNoSeries.MODIFY;
              END;
          END;
          SysMgt.InsertSalesDocPrintHistory(DATABASE::"Service Invoice Header","No.",PrintingDate,PrintingTime);
        END;
        */

    end;

    [EventSubscriber(ObjectType::Codeunit, 5904, 'OnNoPrintedModify', '', false, false)]
    local procedure ModifyServiceCrInvPrintInformation(var ServiceCrMemoHeader: Record "5994")
    var
        RegisterofInvoiceNoSeries: Record "50001";
        AccountingPeriod: Record "50";
        SysMgt: Codeunit "50000";
        PrintingDate: Date;
        PrintingTime: Time;
    begin
        /*
        WITH ServiceCrMemoHeader DO BEGIN
          PrintingDate := TODAY;
          PrintingTime := TIME;
          IF "No. Printed" = 1 THEN BEGIN
            "Printed By" := USERID;
            RegisterofInvoiceNoSeries.RESET;
            RegisterofInvoiceNoSeries.SETRANGE("Table ID",DATABASE::"Service Cr.Memo Header");
            RegisterofInvoiceNoSeries.SETRANGE("Document Type",RegisterofInvoiceNoSeries."Document Type"::"Sales Invoice");
            RegisterofInvoiceNoSeries.SETRANGE("Document No.","No.");
            RegisterofInvoiceNoSeries.SETRANGE("Fiscal Year",SysMgt.GetNepaliFiscalYear("Posting Date"));
            IF RegisterofInvoiceNoSeries.FINDFIRST THEN BEGIN
              RegisterofInvoiceNoSeries.Printed := TRUE;
              RegisterofInvoiceNoSeries."Printed By" := USERID;
              RegisterofInvoiceNoSeries."Is Printed" := "No. Printed";
              RegisterofInvoiceNoSeries."Printed Time" := PrintingTime;
              RegisterofInvoiceNoSeries.MODIFY;
            END;
          END;
          SysMgt.InsertSalesDocPrintHistory(DATABASE::"Service Cr.Memo Header","No.",PrintingDate,PrintingTime);
        END;
        */

    end;

    [EventSubscriber(ObjectType::Codeunit, 6620, 'OnAfterCopyToSalesLine', '', false, false)]
    local procedure OnAfterCopyToSalesLineFromDocuments(var ToSalesLine: Record "37"; FromSalesLine: Record "37")
    begin
        //ToSalesLine."Returned Document No." := FromSalesLine."Returned Document No.";
    end;

    [EventSubscriber(ObjectType::Table, 112, 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertSalesInvHeader(var Rec: Record "112"; RunTrigger: Boolean)
    begin
        /*
        WITH Rec DO BEGIN
          "Posting Time" := TIME;
        END;
        */

    end;

    [EventSubscriber(ObjectType::Table, 114, 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertSalesCrMemoHeader(var Rec: Record "114"; RunTrigger: Boolean)
    begin
        /*
        WITH Rec DO BEGIN
          "Posting Time" := TIME;
        END;
        */

    end;

    [EventSubscriber(ObjectType::Table, 5992, 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertServiceInvHeader(var Rec: Record "5992"; RunTrigger: Boolean)
    begin
        /*
        WITH Rec DO BEGIN
          "Posting Time" := TIME;
        END;
        */

    end;

    [EventSubscriber(ObjectType::Table, 5994, 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertServiceCrMemoHeader(var Rec: Record "5994"; RunTrigger: Boolean)
    begin
        /*
        WITH Rec DO BEGIN
          "Posting Time" := TIME;
        END;
        */

    end;

    [EventSubscriber(ObjectType::Table, 122, 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertPurchInvHeader(var Rec: Record "122"; RunTrigger: Boolean)
    begin
        /*
        WITH Rec DO BEGIN
          "Posting Time" := TIME;
        END;
        */

    end;

    [EventSubscriber(ObjectType::Table, 124, 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertPurchCrMemoHeader(var Rec: Record "124"; RunTrigger: Boolean)
    begin
        /*
        WITH Rec DO BEGIN
          "Posting Time" := TIME;
        END;
        */

    end;

    [EventSubscriber(ObjectType::Codeunit, 442, 'OnBeforeInsertSalesCrMemoLine', '', false, false)]
    local procedure OnBeforeInsertSalesCrMemoLineOnPrepPosting(var SalesCrMemoLine: Record "115"; var PrepaymentInvLineBuffer: Record "461")
    begin
        /*
        WITH SalesCrMemoLine DO BEGIN
          "Localized VAT Identifier" := PrepaymentInvLineBuffer."Localized VAT Identifier" :: Prepayments; //IME
        END;
        */

    end;

    [EventSubscriber(ObjectType::Codeunit, 442, 'OnBeforeInsertSalesInvLine', '', false, false)]
    local procedure OnBeforeInsertSalesInvLineOnPrepPosting(var SalesInvoiceLine: Record "113"; var PrepaymentInvLineBuffer: Record "461")
    begin
        /*
        WITH SalesInvoiceLine DO BEGIN
          "Localized VAT Identifier" := PrepaymentInvLineBuffer."Localized VAT Identifier" :: Prepayments; //IME
        END;
        */

    end;

    [EventSubscriber(ObjectType::Table, 49, 'OnAfterPrepareSales', '', false, false)]
    local procedure PrepareSalesFieldsOnInvPostBuffer(var Sender: Record "49"; SalesLine: Record "37")
    begin
        //Sender."Localized VAT Identifier" := SalesLine."Localized VAT Identifier";
    end;

    [EventSubscriber(ObjectType::Table, 49, 'OnAfterPrepareService', '', false, false)]
    local procedure PrepareServiceFieldsOnInvPostBuffer(var Sender: Record "49"; ServiceLine: Record "5902")
    begin
        //Sender."Localized VAT Identifier" := ServiceLine."Localized VAT Identifier";
    end;

    [EventSubscriber(ObjectType::Table, 49, 'OnAfterPreparePurchase', '', false, false)]
    local procedure PreparePurchaseFieldsOnInvPostBuffer(var Sender: Record "49"; PurchaseLine: Record "39")
    begin
        /*
        Sender."Localized VAT Identifier" := PurchaseLine."Localized VAT Identifier";
        Sender.PragyapanPatra := PurchaseLine.PragyapanPatra;
        */

    end;

    [EventSubscriber(ObjectType::Table, 461, 'OnAfterPrepareSalesPrepmt', '', false, false)]
    local procedure PrepareSalesFieldsOnPrepInvPostBuffer(var Sender: Record "461"; SalesLine: Record "37")
    begin
        //Sender."Localized VAT Identifier" := SalesLine."Localized VAT Identifier" :: Prepayments; //IME
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnCheckPurchasePostRestrictions', '', false, false)]
    local procedure PurchPostRestriction(var Sender: Record "38")
    var
        Vendor: Record "23";
        PurchLine: Record "39";
    begin
        /*
        WITH Sender DO BEGIN
          { //the code has been already written on code unit 90
          Vendor.GET("Pay-to Vendor No.");
          IF Vendor."Pragyapan Patra Mandatory" THEN
            TESTFIELD(PragyapanPatra)
          ELSE BEGIN
        
          //Agile CP 03Aug2016
            IF NOT ItemChargePPMandatory("Document Type","No.") THEN
              TESTFIELD(PragyapanPatra,'');
          //END;
          }
        
          PurchLine.RESET;
          PurchLine.SETRANGE("Document Type","Document Type");
          PurchLine.SETRANGE("Document No.","No.");
          PurchLine.SETFILTER(Quantity,'<>0');
          IF PurchLine.FINDSET THEN REPEAT
            IF PurchLine."Document Type" IN [PurchLine."Document Type"::"Return Order",PurchLine."Document Type"::"Credit Memo"] THEN
              PurchLine.TESTFIELD("Return Reason Code");
          UNTIL PurchLine.NEXT = 0;
          END;
        */

    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnCheckSalesPostRestrictions', '', false, false)]
    local procedure SalesPostRestriction(var Sender: Record "36")
    var
        SalesSetup: Record "311";
        SalesLine: Record "37";
        IRDMgt: Codeunit "50000";
    begin
        /*
        WITH Sender DO BEGIN
          SalesSetup.GET;
          IF NOT Sender."Tax Invoice Donot Exist in Nav" THEN // Agile CP 13 Sep 2016
            SalesSetup.TESTFIELD("Exact Cost Reversing Mandatory");
          IRDMgt.VerifyAndSetNepaliFiscalYear("Posting Date");
          SalesLine.RESET;
          SalesLine.SETRANGE("Document Type","Document Type");
          SalesLine.SETRANGE("Document No.","No.");
          SalesLine.SETFILTER(Quantity,'<>0');
          IF SalesLine.FINDSET THEN REPEAT
            IF SalesLine."Document Type" IN [SalesLine."Document Type"::"Return Order",SalesLine."Document Type"::"Credit Memo"] THEN BEGIN
              SalesLine.TESTFIELD("Return Reason Code");
              IF NOT Sender."Tax Invoice Donot Exist in Nav" THEN // Agile CP 13 Sep 2016
                SalesLine.TESTFIELD("Returned Document No.");
            END;
          UNTIL SalesLine.NEXT = 0;
        END;
        */

    end;

    [EventSubscriber(ObjectType::Table, 5900, 'OnCheckPostRestrictions', '', false, false)]
    local procedure ServicePostRestriction(var Sender: Record "5900")
    var
        SalesSetup: Record "311";
        ServiceLine: Record "5902";
        IRDMgt: Codeunit "50000";
    begin
        /*
        WITH Sender DO BEGIN
          SalesSetup.GET;
          SalesSetup.TESTFIELD("Exact Cost Reversing Mandatory");
          IRDMgt.VerifyAndSetNepaliFiscalYear("Posting Date");
          ServiceLine.RESET;
          ServiceLine.SETRANGE("Document Type","Document Type");
          ServiceLine.SETRANGE("Document No.","No.");
          ServiceLine.SETFILTER(Quantity,'<>0');
          IF ServiceLine.FINDSET THEN REPEAT
            IF ServiceLine."Document Type" = ServiceLine."Document Type"::"Credit Memo" THEN BEGIN
              ServiceLine.TESTFIELD("Return Reason Code");
              ServiceLine.TESTFIELD("Returned Document No.");
            END;
          UNTIL ServiceLine.NEXT = 0;
        END;
        */

    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterUpdatePurchaseLine', '', false, false)]
    local procedure UpdatePurchLinesFCallFromPurchHeader(var Sender: Record "38"; ChangedFieldName: Text[100]; var PurchaseLine: Record "39")
    begin
        /*
        CASE ChangedFieldName OF
          Sender.FIELDCAPTION(PragyapanPatra):
            IF PurchaseLine."No." <> '' THEN
              PurchaseLine.VALIDATE(PragyapanPatra,Sender.PragyapanPatra);
        END;
        */

    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure UpdatePurchLineOnField6Validation(var Rec: Record "39"; var xRec: Record "39"; CurrFieldNo: Integer)
    var
        PurchaseHeader: Record "38";
    begin
        /*
        WITH Rec DO BEGIN
          IF PurchaseHeader.GET("Document Type","Document No.") THEN BEGIN
            PragyapanPatra := PurchaseHeader.PragyapanPatra;
          END;
        END;
        */

    end;

    [EventSubscriber(ObjectType::Table, 5900, 'OnAfterUpdateServLines', '', false, false)]
    local procedure UpdateServLinesFCallFromServHeader(var Sender: Record "5900"; ChangedFieldName: Text[100]; var ServiceLine: Record "5902")
    begin
        /*
        CASE ChangedFieldName OF
          Sender.FIELDCAPTION("Applies-to Doc. No."):
            IF ServiceLine."No." <> '' THEN BEGIN
              ServiceLine.VALIDATE("Returned Document No.",Sender."Applies-to Doc. No.");
              ServiceLine.MODIFY(TRUE);
            END;
        END;
        */

    end;

    [EventSubscriber(ObjectType::Table, 5902, 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure UpdateServLineOnField6Validation(var Rec: Record "5902"; var xRec: Record "5902"; CurrFieldNo: Integer)
    var
        ServiceHeader: Record "5900";
    begin
        /*
        WITH Rec DO BEGIN
          IF ServiceHeader.GET("Document Type","Document No.") THEN BEGIN
            "Returned Document No." := ServiceHeader."Applies-to Doc. No.";
          END;
        END;
        */

    end;

    [Scope('Internal')]
    procedure ResetNoOfPrint(DocumentNo: Code[20])
    var
        SalesInvoiceHeader: Record "112";
        ServiceInvoiceHeader: Record "5992";
        InvoiceMaterializeView: Record "50001";
        SalesInvoicePrintHistory: Record "50002";
    begin
        SalesInvoiceHeader.RESET;
        SalesInvoiceHeader.SETRANGE("No.", DocumentNo);
        IF SalesInvoiceHeader.FINDSET THEN
            REPEAT
                SalesInvoiceHeader."No. Printed" := 0;
                SalesInvoiceHeader."Tax Invoice Printed By" := '';
                SalesInvoiceHeader.MODIFY;
            UNTIL SalesInvoiceHeader.NEXT = 0;


        InvoiceMaterializeView.RESET;
        InvoiceMaterializeView.SETRANGE("Bill No", DocumentNo);
        IF InvoiceMaterializeView.FINDSET THEN
            REPEAT
                InvoiceMaterializeView."Is Bill Printed" := FALSE;
                InvoiceMaterializeView."Printed By" := '';
                InvoiceMaterializeView."Printed Time" := 0T;
                InvoiceMaterializeView."Is Printed" := 0;
                InvoiceMaterializeView.MODIFY;
            UNTIL InvoiceMaterializeView.NEXT = 0;

        SalesInvoicePrintHistory.RESET;
        SalesInvoicePrintHistory.SETRANGE("Document No.", DocumentNo);
        IF SalesInvoicePrintHistory.FINDSET THEN
            REPEAT
                SalesInvoicePrintHistory.DELETE;
            UNTIL SalesInvoicePrintHistory.NEXT = 0;

        MESSAGE('Done!');
    end;

    [Scope('Internal')]
    procedure Binding()
    begin
    end;

    [EventSubscriber(ObjectType::Table, 271, 'OnAfterCopyFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyGenJnlLineInBankAccLedg(var BankAccountLedgerEntry: Record "271"; GenJournalLine: Record "81")
    var
        Loan: Record "270";
    begin
        BankAccountLedgerEntry."Loan Transaction Type" := GenJournalLine."Loan Transaction Type";
        BankAccountLedgerEntry."Loan Repayment Line No." := GenJournalLine."Loan Repayment Line No.";
        IF Loan.GET(GenJournalLine."Account No.") THEN BEGIN
            BankAccountLedgerEntry."Loan No." := Loan."Loan No.";
            BankAccountLedgerEntry.Type := Loan.Type;
        END;
    end;
}

