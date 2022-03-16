codeunit 50005 "Temporary Codeunit"
{
    Permissions = TableData 17 = rm,
                  TableData 21 = rm,
                  TableData 25 = rm,
                  TableData 32 = rm,
                  TableData 110 = rm,
                  TableData 111 = rm,
                  TableData 112 = rm,
                  TableData 113 = rm,
                  TableData 114 = rm,
                  TableData 115 = rm,
                  TableData 120 = rm,
                  TableData 121 = rm,
                  TableData 122 = rm,
                  TableData 123 = rm,
                  TableData 124 = rm,
                  TableData 125 = rm,
                  TableData 254 = rm,
                  TableData 271 = rm,
                  TableData 379 = rm,
                  TableData 380 = rm,
                  TableData 5601 = rm,
                  TableData 5802 = rm;

    trigger OnRun()
    begin
        // UpdateMissingLotFromPositiveAdjmt;
        // AppendZeroInLotNo;
        // CheckIfLotExistSalesBuffer;
        //UpdateLotInBlankPostedAssemblyILEOutput;
        //UpdateDefaultDimItemLedEnt;
        //ClearSetAppliestoID;
        //ChangePragya;
        //DocumentTypeUpdate;
        //UpdateBatchNo;
        //UpdateNepaliDate; //Amisha
        //UpdateFixedAssets;
        //UpdateFixedAssetsDepriciation;
        //UpdateFixedAssetsLedgerEntries;
        // UpdateGLEntries;
        // UpdateGLentry; //Amsa
        DeleteFixedAssets;
    end;

    var
        ProgressWindow: Dialog;
        TotalCount: Integer;
        Text000: Label 'Processed : #1######\Total Records : #2######## \Modified : #3######';
        ModifiedCount: Integer;
        ProcessedRecords: Integer;
        InsertedRecords: Integer;
        NoSeriesLine: Record "309";
        EnglishNepaliDate: Record "50000";
        GLEntry: Record "17";

    [Scope('Internal')]
    procedure UpdateEngNepDate()
    var
        EngNepCal: Record "50000";
    begin
        EngNepCal.RESET;
        IF EngNepCal.FINDFIRST THEN
            REPEAT
                IF STRLEN(EngNepCal."Nepali Date") = 9 THEN BEGIN
                    //EngNepCal."Nepali Date" := ReplaceString(FORMAT(EngNepCal."Nepali Date"),'.','/');
                    EngNepCal."Nepali Date" := IRDNepaliDate(EngNepCal."Nepali Date");
                    EngNepCal.MODIFY;
                END;
            UNTIL EngNepCal.NEXT = 0;
    end;

    [Scope('Internal')]
    procedure IRDNepaliDate(NepaliDate: Code[10]): Code[10]
    var
        Pos: Integer;
        IRDDate: Code[10];
        i: Integer;
    begin
        //YYYY.MM.DD for CBMS
        CLEAR(IRDDate);
        Pos := STRPOS(NepaliDate, '/');
        FOR i := 1 TO STRLEN(NepaliDate) DO BEGIN
            IF NepaliDate[i] = '/' THEN BEGIN
                IF (i = 8) AND (STRLEN(NepaliDate) = 9) THEN
                    IRDDate += '/0'
                ELSE
                    IRDDate += '/';
            END ELSE
                IRDDate += FORMAT(NepaliDate[i]);

        END;
        EXIT(IRDDate);
    end;

    local procedure ReplaceString(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
        EXIT(NewString);
    end;

    local procedure UpdateItemJnlIntegrationRecord()
    var
        IntegrationRec: Record "5151";
        ItemJournalLine: Record "83";
        ItemJnlBatch: Record "233";
        Item: Record "27";
        AssemblyHeader: Record "900";
        AssemblyLine: Record "901";
    begin
        ItemJnlBatch.RESET;
        ItemJnlBatch.SETFILTER(Name, '<>%1', 'SPILLAGE');
        IF ItemJnlBatch.FINDFIRST THEN
            REPEAT
                ItemJnlBatch.Id := CREATEGUID;
                ItemJnlBatch.MODIFY;
                ItemJournalLine.RESET;
                ItemJournalLine.SETRANGE("Journal Template Name", ItemJnlBatch."Journal Template Name");
                ItemJournalLine.SETRANGE("Journal Batch Name", ItemJnlBatch.Name);
                IF ItemJournalLine.FINDFIRST THEN
                    REPEAT
                        ItemJournalLine."Item Journal Batch Id" := ItemJnlBatch.Id;
                        ItemJournalLine.Id := CREATEGUID;
                        ItemJournalLine.MODIFY;
                        IntegrationRec.RESET;
                        IntegrationRec.INIT;
                        IntegrationRec."Table ID" := DATABASE::"Item Journal Line";
                        IntegrationRec."Page ID" := PAGE::"Item Journal";
                        IntegrationRec."Record ID" := ItemJournalLine.RECORDID;
                        IntegrationRec."Integration ID" := ItemJournalLine.Id;
                        IntegrationRec.INSERT;
                    UNTIL ItemJournalLine.NEXT = 0;

            UNTIL ItemJnlBatch.NEXT = 0;


        /*AssemblyHeader.RESET;
        IF AssemblyHeader.FINDFIRST THEN REPEAT
          IF ISNULLGUID(AssemblyHeader.Id) THEN BEGIN
            AssemblyHeader.Id := CREATEGUID;
            AssemblyHeader.MODIFY;
          END;
          AssemblyLine.RESET;
          AssemblyLine.SETRANGE("Document Type",AssemblyHeader."Document Type");
          AssemblyLine.SETRANGE("Document No.",AssemblyHeader."No.");
          IF AssemblyLine.FINDFIRST THEN REPEAT
            AssemblyLine."Document Id" := AssemblyHeader.Id;
            AssemblyLine.MODIFY;
          UNTIL AssemblyLine.NEXT = 0;
        UNTIL AssemblyHeader.NEXT = 0;*/

    end;

    local procedure ItemUpdate()
    var
        Item: Record "27";
    begin
        Item.RESET;
        Item.SETFILTER("VAT Prod. Posting Group", '');
        IF Item.FINDFIRST THEN
            REPEAT
                //Item.VALIDATE("Gen. Prod. Posting Group",Item."Inventory Posting Group");
                Item.VALIDATE("VAT Prod. Posting Group", 'NOVAT');
                Item.MODIFY;
            UNTIL Item.NEXT = 0;
    end;

    local procedure AssignPragyapanPatra()
    var
        PurchInvHeader: Record "122";
        PurchInvLine: Record "123";
        ItemLedgEntry: Record "32";
        ValueEntry: Record "5802";
        CustLedgEntry: Record "21";
        GLEntry: Record "17";
        VATEntry: Record "254";
        VendLedgEntry: Record "25";
        DetailedVendLedgEntry: Record "380";
        PurchRcptHdr: Record "120";
        PurchRcptLine: Record "121";
        totalcount: Integer;
        ProgressWindow: Dialog;
        ModifiedCount: Integer;
        ProcessedRecords: Integer;
        Text000: Label 'Processed : #1######\Total Records : #2######## \Modified : #3######';
    begin
        PurchInvHeader.RESET;
        //PurchInvHeader.SETRANGE("Order No.",'FAC/PO/7677-00057');
        PurchInvHeader.SETFILTER(PragyapanPatra, '<>%1', '');
        IF PurchInvHeader.FINDFIRST THEN
            REPEAT
                PurchInvLine.RESET;
                PurchInvLine.SETRANGE("Document No.", PurchInvHeader."No.");
                IF PurchInvLine.FINDFIRST THEN
                    REPEAT
                        PurchInvLine.PragyapanPatra := PurchInvHeader.PragyapanPatra;
                        PurchInvLine.MODIFY;
                    UNTIL PurchInvLine.NEXT = 0;
                PurchRcptHdr.RESET;
                PurchRcptHdr.SETRANGE("Order No.", PurchInvHeader."Order No.");
                IF PurchRcptHdr.FINDFIRST THEN BEGIN
                    PurchRcptLine.RESET;
                    PurchRcptLine.SETRANGE("Document No.", PurchRcptHdr."No.");
                    IF PurchRcptLine.FINDFIRST THEN
                        REPEAT
                            PurchRcptLine.PragyapanPatra := PurchInvHeader.PragyapanPatra;
                            PurchRcptLine.MODIFY;
                            ItemLedgEntry.RESET;
                            ItemLedgEntry.SETRANGE("Document No.", PurchRcptHdr."No.");
                            IF ItemLedgEntry.FINDFIRST THEN
                                REPEAT
                                    IF ItemLedgEntry.PragyapanPatra = '' THEN BEGIN
                                        ItemLedgEntry."Posting Date" := PurchInvHeader."Posting Date";
                                        ItemLedgEntry.MODIFY;
                                    END;
                                UNTIL ItemLedgEntry.NEXT = 0;
                        UNTIL PurchRcptLine.NEXT = 0;
                END;
                GLEntry.RESET;
                GLEntry.SETRANGE("Document No.", PurchInvHeader."No.");
                GLEntry.SETRANGE("Document Type", GLEntry."Document Type"::Invoice);
                IF GLEntry.FINDFIRST THEN
                    REPEAT
                        GLEntry.PragyapanPatra := PurchInvHeader.PragyapanPatra;
                        GLEntry.MODIFY;
                    UNTIL GLEntry.NEXT = 0;

                /*VendLedgEntry.RESET;
                VendLedgEntry.SETFILTER("Document No.",PurchInvHeader."No.");
                IF VendLedgEntry.FINDFIRST THEN BEGIN
                  VendLedgEntry."Letter of Credit/Telex Trans." := GLEntry."Letter of Credit/Telex Trans.";
                  VendLedgEntry.MODIFY;
                END;*/

                /*DetailedVendLedgEntry.RESET;
                DetailedVendLedgEntry.SETFILTER("Document No.",PurchInvHeader."No.");
                IF DetailedVendLedgEntry.FINDFIRST THEN BEGIN
                  DetailedVendLedgEntry."Letter of Credit/Telex Trans." := PurchInvHeader."Letter of Credit/Telex Trans.";
                 DetailedVendLedgEntry.MODIFY;
                END;*/

                ValueEntry.RESET;
                ValueEntry.SETFILTER("Document No.", PurchInvHeader."No.");
                IF ValueEntry.FINDFIRST THEN
                    REPEAT
                        IF ValueEntry.PragyapanPatra = '' THEN BEGIN
                            ValueEntry.PragyapanPatra := PurchInvHeader.PragyapanPatra;
                            ValueEntry.MODIFY;
                        END;
                    UNTIL ValueEntry.NEXT = 0;

                VATEntry.RESET;
                VATEntry.SETFILTER("Document No.", PurchInvHeader."No.");
                IF VATEntry.FINDFIRST THEN
                    REPEAT
                        VATEntry.PragyapanPatra := PurchInvHeader.PragyapanPatra;
                        VATEntry.MODIFY;
                    UNTIL VATEntry.NEXT = 0;
            UNTIL PurchInvHeader.NEXT = 0;

    end;

    local procedure ExternalEntryTrueAssembly()
    var
        AssemblyHeader: Record "900";
    begin
        ProcessedRecords := 0;
        ModifiedCount := 0;
        AssemblyHeader.RESET;
        AssemblyHeader.SETRANGE("External Entry", FALSE);
        //Processed : #1######\Total Records : #2######## \Modified : #3######
        ProgressWindow.OPEN(Text000);
        ProgressWindow.UPDATE(2, AssemblyHeader.COUNT);
        IF AssemblyHeader.FINDFIRST THEN
            REPEAT
                AssemblyHeader."External Entry" := TRUE;
                AssemblyHeader.MODIFY;
                ModifiedCount += 1;
                ProcessedRecords += 1;
                ProgressWindow.UPDATE(1, ProcessedRecords);
                ProgressWindow.UPDATE(3, ModifiedCount);
            UNTIL AssemblyHeader.NEXT = 0;
    end;

    [Scope('Internal')]
    procedure UpdateLotNoInfo()
    var
        PostedAssemblyOrder: Record "910";
        LotNoInfo: Record "6505";
        ILE: Record "32";
        Modified: Boolean;
    begin
        ProcessedRecords := 0;
        ModifiedCount := 0;
        ProgressWindow.OPEN(Text000);
        LotNoInfo.RESET;
        LotNoInfo.SETRANGE("Manufacturing Date", 0D);
        IF LotNoInfo.FINDFIRST THEN
            REPEAT
                PostedAssemblyOrder.RESET;
                PostedAssemblyOrder.SETRANGE("Item No.", LotNoInfo."Item No.");
                PostedAssemblyOrder.SETRANGE("Batch No.", LotNoInfo."Lot No.");
                IF PostedAssemblyOrder.FINDLAST THEN BEGIN
                    LotNoInfo."Manufacturing Date" := PostedAssemblyOrder."Manufacturing Date";
                    LotNoInfo."Expiry Date" := PostedAssemblyOrder."Expiry Date";
                    LotNoInfo.Description := PostedAssemblyOrder.Description;
                    LotNoInfo.MODIFY;
                    Modified := TRUE;
                END;

                IF LotNoInfo."Manufacturing Date" = 0D THEN BEGIN
                    ILE.RESET;
                    ILE.SETRANGE("Lot No.", LotNoInfo."Lot No.");
                    ILE.SETRANGE("Entry Type", ILE."Entry Type"::"Positive Adjmt.");
                    IF ILE.FINDFIRST THEN BEGIN
                        LotNoInfo."Manufacturing Date" := ILE."Manufacturing Date";
                        LotNoInfo."Expiry Date" := ILE."Expiration Date";
                        LotNoInfo.MODIFY;
                        Modified := TRUE;
                    END;
                END;
                IF Modified THEN
                    ModifiedCount += 1;
                ProcessedRecords += 1;
                ProgressWindow.UPDATE(1, ProcessedRecords);
                ProgressWindow.UPDATE(3, ModifiedCount);
            UNTIL LotNoInfo.NEXT = 0;

        ILE.RESET;
        ILE.SETFILTER("Lot No.", '<>%1', '');
        ILE.SETRANGE("Expiration Date", 0D);
        IF ILE.FINDFIRST THEN
            REPEAT
                LotNoInfo.GET(ILE."Item No.", '', ILE."Lot No.");
                IF ILE."Expiration Date" = 0D THEN BEGIN
                    ILE."Expiration Date" := LotNoInfo."Expiry Date";
                    ILE.MODIFY;
                END;
            UNTIL ILE.NEXT = 0;
    end;

    [Scope('Internal')]
    procedure UpdateLoanTransactionType()
    var
        GLEntry: Record "17";
        BankAccountLedgEntry: Record "271";
        Loan: Record "270";
    begin
        ProcessedRecords := 0;
        ModifiedCount := 0;
        ProgressWindow.OPEN(Text000);
        GLEntry.RESET;
        GLEntry.SETFILTER("Loan Transaction Type", '<>%1', GLEntry."Loan Transaction Type"::" ");
        ProgressWindow.UPDATE(2, GLEntry.COUNT);
        IF GLEntry.FINDFIRST THEN
            REPEAT
                IF BankAccountLedgEntry.GET(GLEntry."Entry No.") THEN BEGIN
                    BankAccountLedgEntry."Loan Repayment Line No." := GLEntry."Loan Repayment Line No.";
                    BankAccountLedgEntry."Loan Transaction Type" := GLEntry."Loan Transaction Type";
                    BankAccountLedgEntry.Narration := GLEntry.Narration;
                    IF Loan.GET(BankAccountLedgEntry."Bank Account No.") THEN BEGIN
                        BankAccountLedgEntry."Loan No." := Loan."Loan No.";
                        BankAccountLedgEntry.Type := Loan.Type;
                    END;
                    BankAccountLedgEntry.MODIFY;
                    ModifiedCount += 1;
                END;
                ProcessedRecords += 1;
                ProgressWindow.UPDATE(1, ProcessedRecords);
                ProgressWindow.UPDATE(3, ModifiedCount);
            UNTIL GLEntry.NEXT = 0;
    end;

    [Scope('Internal')]
    procedure UpdateDocumentIDInPostedAssemblyLine()
    var
        PostedAssemblyHeader: Record "910";
        PostedAssemblyLine: Record "911";
    begin
        ProcessedRecords := 0;
        ModifiedCount := 0;
        ProgressWindow.OPEN(Text000);
        PostedAssemblyHeader.RESET;
        ProgressWindow.UPDATE(2, PostedAssemblyHeader.COUNT);
        IF PostedAssemblyHeader.FINDFIRST THEN
            REPEAT
                PostedAssemblyLine.RESET;
                PostedAssemblyLine.SETRANGE("Document No.", PostedAssemblyHeader."No.");
                IF PostedAssemblyLine.FINDSET THEN
                    PostedAssemblyLine.MODIFYALL("Document Id", PostedAssemblyHeader.Id);
                ModifiedCount += 1;
                ProcessedRecords += 1;
                ProgressWindow.UPDATE(1, ProcessedRecords);
                ProgressWindow.UPDATE(3, ModifiedCount);
            UNTIL PostedAssemblyHeader.NEXT = 0;
    end;

    [Scope('Internal')]
    procedure UpdateUnitCostForFinishedGoods()
    var
        PostedAssemblyHeader: Record "910";
        PostedAssemblyLine: Record "911";
        ValueEntries: Record "5802";
        TransferShptHeader: Record "5744";
        TransferRcptHeader: Record "5746";
        ConsumptionValueEntry: Record "5802";
        OutputValueEntry: Record "5802";
        TransferValueEntry: Record "5802";
        TransferILE: Record "32";
        TransferShipmentLine: Record "5745";
        TransferReceiptLine: Record "5747";
    begin
        ProcessedRecords := 0;
        ModifiedCount := 0;
        ProgressWindow.OPEN(Text000);
        PostedAssemblyHeader.RESET;
        ProgressWindow.UPDATE(2, PostedAssemblyHeader.COUNT);
        IF PostedAssemblyHeader.FINDFIRST THEN
            REPEAT
                ProcessedRecords += 1;
                ConsumptionValueEntry.RESET;
                ConsumptionValueEntry.SETRANGE("Document No.", PostedAssemblyHeader."No.");
                ConsumptionValueEntry.SETRANGE("Item Ledger Entry Type", ConsumptionValueEntry."Item Ledger Entry Type"::"Assembly Consumption");
                ConsumptionValueEntry.SETRANGE("Entry Type", ConsumptionValueEntry."Entry Type"::"Direct Cost");
                IF ConsumptionValueEntry.FINDFIRST THEN
                    ConsumptionValueEntry.CALCSUMS("Cost Amount (Actual)");

                OutputValueEntry.RESET;
                OutputValueEntry.SETRANGE("Document No.", PostedAssemblyHeader."No.");
                OutputValueEntry.SETRANGE("Item Ledger Entry Type", OutputValueEntry."Item Ledger Entry Type"::"Assembly Output");
                OutputValueEntry.SETRANGE("Entry Type", OutputValueEntry."Entry Type"::"Direct Cost");
                IF OutputValueEntry.FINDFIRST THEN BEGIN
                    //IF OutputValueEntry."Cost Amount (Actual)" <> ConsumptionValueEntry."Cost Amount (Actual)" THEN BEGIN
                    OutputValueEntry."Cost Amount (Actual)" := -ConsumptionValueEntry."Cost Amount (Actual)";
                    OutputValueEntry."Cost per Unit" := -(ConsumptionValueEntry."Cost Amount (Actual)" / OutputValueEntry."Invoiced Quantity");
                    OutputValueEntry.MODIFY;
                    ModifiedCount += 1;
                    TransferILE.RESET;
                    TransferILE.SETRANGE("Entry Type", TransferILE."Entry Type"::Transfer);
                    TransferILE.SETRANGE("Batch No.", PostedAssemblyHeader."Batch No.");
                    IF TransferILE.FINDFIRST THEN
                        REPEAT
                            TransferValueEntry.RESET;
                            TransferValueEntry.SETRANGE("Item Ledger Entry No.", TransferILE."Entry No.");
                            TransferValueEntry.SETRANGE("Entry Type", TransferValueEntry."Entry Type"::"Direct Cost");
                            IF TransferValueEntry.FINDFIRST THEN
                                REPEAT
                                    IF TransferILE."Document Type" = TransferILE."Document Type"::"Transfer Shipment" THEN BEGIN
                                        IF TransferILE."Location Code" = 'INTRANSIT' THEN BEGIN
                                            TransferValueEntry."Cost Amount (Actual)" := ConsumptionValueEntry."Cost Amount (Actual)";
                                            TransferValueEntry."Cost per Unit" := (TransferValueEntry."Cost Amount (Actual)" / TransferValueEntry."Invoiced Quantity");
                                            TransferValueEntry.MODIFY;
                                        END ELSE BEGIN
                                            TransferValueEntry."Cost Amount (Actual)" := -ConsumptionValueEntry."Cost Amount (Actual)";
                                            TransferValueEntry."Cost per Unit" := -(TransferValueEntry."Cost Amount (Actual)" / TransferValueEntry."Invoiced Quantity");
                                            TransferValueEntry.MODIFY;
                                        END;
                                    END ELSE
                                        IF TransferILE."Document Type" = TransferILE."Document Type"::"Transfer Receipt" THEN BEGIN
                                            IF TransferILE."Location Code" = 'INTRANSIT' THEN BEGIN
                                                TransferValueEntry."Cost Amount (Actual)" := -ConsumptionValueEntry."Cost Amount (Actual)";
                                                TransferValueEntry."Cost per Unit" := -(TransferValueEntry."Cost Amount (Actual)" / TransferValueEntry."Invoiced Quantity");
                                                TransferValueEntry.MODIFY;
                                            END ELSE BEGIN
                                                TransferValueEntry."Cost Amount (Actual)" := ConsumptionValueEntry."Cost Amount (Actual)";
                                                TransferValueEntry."Cost per Unit" := (TransferValueEntry."Cost Amount (Actual)" / TransferValueEntry."Invoiced Quantity");
                                                TransferValueEntry.MODIFY;
                                            END;
                                        END;
                                UNTIL TransferValueEntry.NEXT = 0;
                        UNTIL TransferILE.NEXT = 0;
                    //END;
                END;
                ProgressWindow.UPDATE(1, ProcessedRecords);
                ProgressWindow.UPDATE(3, ModifiedCount);
            UNTIL PostedAssemblyHeader.NEXT = 0;
    end;

    [Scope('Internal')]
    procedure UpdateFreeSalesLine()
    var
        SalesLine: Record "37";
        IRDMgt: Codeunit "50002";
        SalesHeader: Record "36";
    begin
        ProcessedRecords := 0;
        ModifiedCount := 0;
        ProgressWindow.OPEN(Text000);
        SalesHeader.RESET;
        ProgressWindow.UPDATE(2, SalesHeader.COUNT);
        IF SalesHeader.FINDFIRST THEN
            REPEAT
                ProcessedRecords += 1;
                SalesLine.RESET;
                SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                SalesLine.SETRANGE("Free Item Line", FALSE);
                IF SalesLine.FINDFIRST THEN
                    REPEAT
                        IRDMgt.InsertFreeItemSalesLine(SalesLine);
                        ModifiedCount += 1;
                    UNTIL SalesLine.NEXT = 0;
                ProgressWindow.UPDATE(1, ProcessedRecords);
                ProgressWindow.UPDATE(3, ProcessedRecords);
            UNTIL SalesHeader.NEXT = 0;
    end;

    [Scope('Internal')]
    procedure ReceiveMultiple()
    var
        TOReceive: Codeunit "5705";
        TransferHeader: Record "5740";
    begin
        ProcessedRecords := 0;
        ModifiedCount := 0;
        ProgressWindow.OPEN(Text000);
        TransferHeader.RESET;
        TransferHeader.SETRANGE(Status, TransferHeader.Status::Released);
        ProgressWindow.UPDATE(2, TransferHeader.COUNT);
        IF TransferHeader.FINDFIRST THEN
            REPEAT
                ProcessedRecords += 1;
                CLEAR(TOReceive);
                TOReceive.SetSkipLocationCheck(TRUE);
                TOReceive.SetHideValidationDialog(TRUE);
                TOReceive.RUN(TransferHeader);
                ModifiedCount += 1;
                COMMIT;
                ProgressWindow.UPDATE(1, ProcessedRecords);
                ProgressWindow.UPDATE(3, ModifiedCount);
            UNTIL TransferHeader.NEXT = 0;
    end;

    [Scope('Internal')]
    procedure CreateSalesOrder()
    var
        HeaderSalesBuffer: Record "50026";
        LineSalesBuffer: Record "50026";
        SalesHeader: Record "36";
        SalesLine: Record "37";
        Text000: Label 'Processed : #1######\Total Records : #2######## \Inserted : #3########## \Modified : #4######';
        IRDMgt: Codeunit "50000";
        LotNoInfo: Record "6505";
        FreeSalesLine: Record "37";
        SysMgt: Codeunit "50002";
    begin
        ProcessedRecords := 0;
        ModifiedCount := 0;
        ProgressWindow.OPEN(Text000);
        HeaderSalesBuffer.RESET;
        HeaderSalesBuffer.SETRANGE(Posted, FALSE);
        HeaderSalesBuffer.SETRANGE("Row Type", HeaderSalesBuffer."Row Type"::"Document Header");
        HeaderSalesBuffer.SETRANGE("Document Type", HeaderSalesBuffer."Document Type"::Order);
        ProgressWindow.UPDATE(2, HeaderSalesBuffer.COUNT);
        IF HeaderSalesBuffer.FINDFIRST THEN
            REPEAT
                ProcessedRecords += 1;
                IF NOT SalesHeader.GET(HeaderSalesBuffer."Document Type", HeaderSalesBuffer."Document No.") THEN BEGIN
                    SalesHeader.INIT;
                    SalesHeader.SetHideValidationDialog(TRUE);
                    SalesHeader."Document Type" := HeaderSalesBuffer."Document Type";
                    SalesHeader."No." := HeaderSalesBuffer."Document No.";
                    SalesHeader.VALIDATE("Accountability Center", 'CORPORATE');
                    SalesHeader.VALIDATE("Location Code", 'CORPORATE');
                    SalesHeader.INSERT(TRUE);
                    SalesHeader.VALIDATE("Sell-to Customer No.", HeaderSalesBuffer."Sell-to Customer No.");
                    SalesHeader.VALIDATE("Document Date", HeaderSalesBuffer."Document Date");
                    SalesHeader.VALIDATE("Order Date", SalesHeader."Document Date");
                    SalesHeader.VALIDATE("Posting Date", SalesHeader."Document Date");
                    SalesHeader.VALIDATE("Expected Delivery Date", SalesHeader."Expected Delivery Date");
                    SalesHeader.VALIDATE("Due Date", SalesHeader."Document Date");
                    SalesHeader.VALIDATE("Transport Name", HeaderSalesBuffer."Transport Name");
                    SalesHeader.VALIDATE("M.R.", HeaderSalesBuffer."M.R.");
                    SalesHeader.VALIDATE("CN No.", HeaderSalesBuffer."CN No.");
                    SalesHeader.VALIDATE("Doc. Thru.", HeaderSalesBuffer."Doc. Thru.");
                    SalesHeader.VALIDATE("Shortcut Dimension 1 Code", 'CORPORATE');
                    SalesHeader.VALIDATE("External Document No.", HeaderSalesBuffer."External Document No.");
                    SalesHeader.VALIDATE("Dispatch Date", HeaderSalesBuffer."Dispatch Date");
                    SalesHeader.VALIDATE("Shipment Date", HeaderSalesBuffer."Dispatch Date");
                    SalesHeader.MODIFY(TRUE);
                    InsertedRecords += 1;
                END ELSE BEGIN
                    SalesHeader.SetHideValidationDialog(TRUE);
                    SalesHeader.VALIDATE("External Document No.", HeaderSalesBuffer."External Document No.");
                    SalesHeader.VALIDATE("Dispatch Date", HeaderSalesBuffer."Dispatch Date");
                    SalesHeader.VALIDATE("Shipment Date", HeaderSalesBuffer."Dispatch Date");
                    SalesHeader.MODIFY(TRUE);
                END;

                LineSalesBuffer.RESET;
                LineSalesBuffer.SETRANGE("Row Type", LineSalesBuffer."Row Type"::"Document Line");
                LineSalesBuffer.SETRANGE("Document Type", HeaderSalesBuffer."Document Type");
                LineSalesBuffer.SETRANGE("Document No.", HeaderSalesBuffer."Document No.");
                IF LineSalesBuffer.FINDFIRST THEN
                    REPEAT
                        SalesLine.RESET;
                        SalesLine.SETRANGE("Document Type", HeaderSalesBuffer."Document Type");
                        SalesLine.SETRANGE("Document No.", HeaderSalesBuffer."Document No.");
                        SalesLine.SETRANGE("Line No.", LineSalesBuffer."Line No.");
                        IF NOT SalesLine.FINDFIRST THEN BEGIN
                            SalesLine.INIT;
                            SalesLine.VALIDATE("Document Type", LineSalesBuffer."Document Type");
                            SalesLine.VALIDATE("Document No.", LineSalesBuffer."Document No.");
                            SalesLine.VALIDATE("Line No.", LineSalesBuffer."Line No.");
                            SalesLine.VALIDATE(Type, LineSalesBuffer.Type);
                            SalesLine.VALIDATE("No.", LineSalesBuffer."No.");
                            SalesLine.INSERT(TRUE);
                            SalesLine.VALIDATE("Unit of Measure Code", LineSalesBuffer."Unit of Measure");
                            SalesLine.VALIDATE(Quantity, LineSalesBuffer.Quantity);
                            SalesLine.VALIDATE("Unit Price", LineSalesBuffer."Unit Price Excl VAT");
                            SalesLine.VALIDATE("Batch No.", LineSalesBuffer."Batch No.");
                            IF LotNoInfo.GET(SalesLine."No.", '', SalesLine."Batch No.") THEN
                                SalesLine.VALIDATE("Manufacturing Date", LotNoInfo."Manufacturing Date")
                            ELSE
                                LineSalesBuffer."Lot No. Not Found" := TRUE;
                            SalesLine.VALIDATE("Expiry Date", LineSalesBuffer."Expiry Date");
                            SalesLine.MODIFY(TRUE);
                            IRDMgt.AssignLotNoToPerSalesLine(SalesLine, SalesLine."Batch No.", SalesLine.Quantity * SalesLine."Qty. per Unit of Measure");
                            SysMgt.InsertFreeItemSalesLine(SalesLine);
                            FreeSalesLine.RESET;
                            FreeSalesLine.SETRANGE("Document Type", SalesLine."Document Type");
                            FreeSalesLine.SETRANGE("Document No.", SalesLine."Document No.");
                            FreeSalesLine.SETRANGE("Sales Line No.", SalesLine."Line No.");
                            FreeSalesLine.SETRANGE("Free Item Line", TRUE);
                            IF FreeSalesLine.FINDFIRST THEN BEGIN
                                CLEAR(IRDMgt);
                                IRDMgt.AssignLotNoToPerSalesLine(FreeSalesLine, SalesLine."Batch No.", FreeSalesLine.Quantity * FreeSalesLine."Qty. per Unit of Measure");
                            END;
                            ModifiedCount += 1;
                        END ELSE BEGIN
                            SalesLine.VALIDATE("Unit of Measure Code", LineSalesBuffer."Unit of Measure");
                            SalesLine.VALIDATE(Quantity, LineSalesBuffer.Quantity);
                            SalesLine.VALIDATE("Unit Price", LineSalesBuffer."Unit Price Excl VAT");
                            SalesLine.VALIDATE("Batch No.", LineSalesBuffer."Batch No.");
                            IF LotNoInfo.GET(SalesLine."No.", '', SalesLine."Batch No.") THEN
                                SalesLine.VALIDATE("Manufacturing Date", LotNoInfo."Manufacturing Date")
                            ELSE
                                LineSalesBuffer."Lot No. Not Found" := TRUE;
                            SalesLine.VALIDATE("Expiry Date", LineSalesBuffer."Expiry Date");
                            SalesLine.MODIFY(TRUE);
                            IRDMgt.AssignLotNoToPerSalesLine(SalesLine, SalesLine."Batch No.", SalesLine.Quantity * SalesLine."Qty. per Unit of Measure");
                            SysMgt.InsertFreeItemSalesLine(SalesLine);
                            FreeSalesLine.RESET;
                            FreeSalesLine.SETRANGE("Document Type", SalesLine."Document Type");
                            FreeSalesLine.SETRANGE("Document No.", SalesLine."Document No.");
                            FreeSalesLine.SETRANGE("Sales Line No.", SalesLine."Line No.");
                            FreeSalesLine.SETRANGE("Free Item Line", TRUE);
                            IF FreeSalesLine.FINDFIRST THEN BEGIN
                                CLEAR(IRDMgt);
                                IRDMgt.AssignLotNoToPerSalesLine(FreeSalesLine, SalesLine."Batch No.", FreeSalesLine.Quantity * FreeSalesLine."Qty. per Unit of Measure");
                            END;
                        END;
                        LineSalesBuffer.Processed := TRUE;
                        LineSalesBuffer.MODIFY;
                    UNTIL LineSalesBuffer.NEXT = 0;
                HeaderSalesBuffer.Processed := TRUE;
                COMMIT;
                HeaderSalesBuffer.MODIFY;
                ProgressWindow.UPDATE(1, ProcessedRecords);
                ProgressWindow.UPDATE(3, InsertedRecords);
                ProgressWindow.UPDATE(4, ModifiedCount);
            UNTIL HeaderSalesBuffer.NEXT = 0;
    end;

    [Scope('Internal')]
    procedure PostSalesOrder()
    var
        HeaderSalesBuffer: Record "50026";
        Text000: Label 'Processed : #1######\Total Records : #2######## \Inserted : #3########## \Modified : #4######';
        SalesHeader: Record "36";
        SalesPost: Codeunit "80";
    begin
        ProcessedRecords := 0;
        ModifiedCount := 0;
        ProgressWindow.OPEN(Text000);
        HeaderSalesBuffer.RESET;
        ProgressWindow.UPDATE(2, HeaderSalesBuffer.COUNT);
        HeaderSalesBuffer.SETRANGE("Row Type", HeaderSalesBuffer."Row Type"::"Document Header");
        HeaderSalesBuffer.SETRANGE("Document Type", HeaderSalesBuffer."Document Type"::Order);
        IF HeaderSalesBuffer.FINDFIRST THEN
            REPEAT
                ProcessedRecords += 1;
                IF SalesHeader.GET(HeaderSalesBuffer."Document Type", HeaderSalesBuffer."Document No.") THEN BEGIN
                    SalesHeader.Ship := TRUE;
                    SalesHeader.Invoice := TRUE;
                    CLEAR(SalesPost);
                    SalesPost.RUN(SalesHeader);
                    HeaderSalesBuffer.Posted := TRUE;
                    HeaderSalesBuffer.MODIFY;
                    ModifiedCount += 1;
                    InsertedRecords += 1;
                END;
                ProgressWindow.UPDATE(1, ProcessedRecords);
                ProgressWindow.UPDATE(3, InsertedRecords);
                ProgressWindow.UPDATE(4, ModifiedCount);
            UNTIL HeaderSalesBuffer.NEXT = 0;
    end;

    [Scope('Internal')]
    procedure PostSalesReturnOrder()
    var
        HeaderSalesBuffer: Record "50026";
        Text000: Label 'Processed : #1######\Total Records : #2######## \Inserted : #3########## \Modified : #4######';
        SalesHeader: Record "36";
        SalesPost: Codeunit "80";
    begin
        ProcessedRecords := 0;
        ModifiedCount := 0;
        ProgressWindow.OPEN(Text000);
        HeaderSalesBuffer.RESET;
        HeaderSalesBuffer.SETRANGE("Row Type", HeaderSalesBuffer."Row Type"::"Document Header");
        HeaderSalesBuffer.SETRANGE("Document Type", HeaderSalesBuffer."Document Type"::"Return Order");
        HeaderSalesBuffer.SETRANGE(Posted, FALSE);
        ProgressWindow.UPDATE(2, HeaderSalesBuffer.COUNT);
        IF HeaderSalesBuffer.FINDFIRST THEN
            REPEAT
                ProcessedRecords += 1;
                IF SalesHeader.GET(HeaderSalesBuffer."Document Type", HeaderSalesBuffer."Document No.") THEN BEGIN
                    SalesHeader.Receive := TRUE;
                    SalesHeader.Invoice := TRUE;
                    CLEAR(SalesPost);
                    SalesPost.RUN(SalesHeader);
                    HeaderSalesBuffer.Posted := TRUE;
                    HeaderSalesBuffer.MODIFY;
                    ModifiedCount += 1;
                    InsertedRecords += 1;
                END;
                ProgressWindow.UPDATE(1, ProcessedRecords);
                ProgressWindow.UPDATE(3, InsertedRecords);
                ProgressWindow.UPDATE(4, ModifiedCount);
            UNTIL HeaderSalesBuffer.NEXT = 0;
    end;

    [Scope('Internal')]
    procedure UpdateMissingLotFromAssembly()
    var
        LotInfo: Record "6505";
        PostedAssemblyHeader: Record "910";
        Text000: Label 'Processed : #1######\Total Records : #2######## \Inserted : #3########## \Modified : #4######';
    begin
        ProcessedRecords := 0;
        ModifiedCount := 0;
        ProgressWindow.OPEN(Text000);
        PostedAssemblyHeader.RESET;
        ProgressWindow.UPDATE(2, PostedAssemblyHeader.COUNT);
        IF PostedAssemblyHeader.FINDFIRST THEN
            REPEAT
                ProcessedRecords += 1;
                IF NOT LotInfo.GET(PostedAssemblyHeader."Item No.", PostedAssemblyHeader."Variant Code", PostedAssemblyHeader."Batch No.") THEN BEGIN
                    LotInfo.INIT;
                    LotInfo."Lot No." := PostedAssemblyHeader."Batch No.";
                    LotInfo.Description := PostedAssemblyHeader.Description;
                    LotInfo."Item No." := PostedAssemblyHeader."Item No.";
                    LotInfo."Variant Code" := PostedAssemblyHeader."Variant Code";
                    LotInfo."Manufacturing Date" := PostedAssemblyHeader."Manufacturing Date";
                    LotInfo."Expiry Date" := PostedAssemblyHeader."Expiry Date";
                    LotInfo.INSERT;
                    InsertedRecords += 1;
                END ELSE BEGIN
                    LotInfo.Description := PostedAssemblyHeader.Description;
                    LotInfo."Manufacturing Date" := PostedAssemblyHeader."Manufacturing Date";
                    LotInfo."Expiry Date" := PostedAssemblyHeader."Expiry Date";
                    LotInfo.MODIFY;
                    ModifiedCount += 1;
                END;
                ProgressWindow.UPDATE(1, ProcessedRecords);
                ProgressWindow.UPDATE(3, InsertedRecords);
                ProgressWindow.UPDATE(4, ModifiedCount);
            UNTIL PostedAssemblyHeader.NEXT = 0;
    end;

    [Scope('Internal')]
    procedure UpdateMissingLotFromPositiveAdjmt()
    var
        LotInfo: Record "6505";
        ItemLedgEntry: Record "32";
        Text000: Label 'Processed : #1######\Total Records : #2######## \Inserted : #3########## \Modified : #4######';
    begin
        ProcessedRecords := 0;
        ModifiedCount := 0;
        ProgressWindow.OPEN(Text000);
        ItemLedgEntry.RESET;
        ItemLedgEntry.SETRANGE("Entry Type", ItemLedgEntry."Entry Type"::"Positive Adjmt.");
        ItemLedgEntry.SETFILTER("Lot No.", '<>%1', '');
        ProgressWindow.UPDATE(2, ItemLedgEntry.COUNT);
        IF ItemLedgEntry.FINDFIRST THEN
            REPEAT
                ProcessedRecords += 1;
                ItemLedgEntry.CALCFIELDS("Item Name");
                IF NOT LotInfo.GET(ItemLedgEntry."Item No.", ItemLedgEntry."Variant Code", ItemLedgEntry."Lot No.") THEN BEGIN
                    LotInfo.INIT;
                    LotInfo."Lot No." := ItemLedgEntry."Batch No.";
                    LotInfo.Description := ItemLedgEntry."Item Name";
                    LotInfo."Item No." := ItemLedgEntry."Item No.";
                    LotInfo."Variant Code" := ItemLedgEntry."Variant Code";
                    LotInfo."Manufacturing Date" := ItemLedgEntry."Manufacturing Date";
                    LotInfo."Expiry Date" := ItemLedgEntry."Expiration Date";
                    LotInfo.INSERT;
                    InsertedRecords += 1;
                END ELSE BEGIN
                    LotInfo.Description := ItemLedgEntry."Item Name";
                    LotInfo."Manufacturing Date" := ItemLedgEntry."Manufacturing Date";
                    LotInfo."Expiry Date" := ItemLedgEntry."Expiration Date";
                    LotInfo.MODIFY;
                    ModifiedCount += 1;
                END;
                ProgressWindow.UPDATE(1, ProcessedRecords);
                ProgressWindow.UPDATE(3, InsertedRecords);
                ProgressWindow.UPDATE(4, ModifiedCount);
            UNTIL ItemLedgEntry.NEXT = 0;
    end;

    [Scope('Internal')]
    procedure AppendZeroInLotNo()
    var
        LotNoInfo: Record "6505";
        ILE: Record "32";
        NewLotNo: Code[20];
        OldLotNo: Code[20];
    begin
        LotNoInfo.RESET;
        ProcessedRecords := 0;
        ModifiedCount := 0;
        ProgressWindow.OPEN(Text000);
        //Processed : #1######\Total Records : #2######## \Modified : #3######
        ProgressWindow.UPDATE(2, LotNoInfo.COUNT);
        IF LotNoInfo.FINDFIRST THEN
            REPEAT
                OldLotNo := '';
                NewLotNo := '';
                ProcessedRecords += 1;
                IF STRLEN(LotNoInfo."Lot No.") = 5 THEN BEGIN
                    OldLotNo := LotNoInfo."Lot No.";
                    NewLotNo := '0' + LotNoInfo."Lot No.";
                    LotNoInfo.RENAME(LotNoInfo."Item No.", LotNoInfo."Variant Code", NewLotNo);
                    ILE.RESET;
                    ILE.SETRANGE("Item No.", LotNoInfo."Item No.");
                    ILE.SETRANGE("Variant Code", LotNoInfo."Variant Code");
                    ILE.SETRANGE("Lot No.", OldLotNo);
                    IF ILE.FINDFIRST THEN
                        ILE.MODIFYALL("Lot No.", NewLotNo);
                    ModifiedCount += 1;
                END;
                ProgressWindow.UPDATE(1, ProcessedRecords);
                ProgressWindow.UPDATE(3, ModifiedCount);
            UNTIL LotNoInfo.NEXT = 0;
    end;

    [Scope('Internal')]
    procedure CheckIfLotExistSalesBuffer()
    var
        SalesBuffer: Record "50026";
        LotNoInfo: Record "6505";
    begin
        SalesBuffer.RESET;
        ProcessedRecords := 0;
        ModifiedCount := 0;
        ProgressWindow.OPEN(Text000);
        SalesBuffer.SETRANGE("Row Type", SalesBuffer."Row Type"::"Document Line");
        IF SalesBuffer.FINDFIRST THEN
            REPEAT
                ProcessedRecords += 1;
                IF LotNoInfo.GET(SalesBuffer."No.", '', SalesBuffer."Batch No.") THEN
                    SalesBuffer."Lot No. Not Found" := FALSE
                ELSE
                    SalesBuffer."Lot No. Not Found" := TRUE;
                SalesBuffer.MODIFY;
                ModifiedCount += 1;
                ProgressWindow.UPDATE(1, ProcessedRecords);
                ProgressWindow.UPDATE(3, ModifiedCount);
            UNTIL SalesBuffer.NEXT = 0;
    end;

    local procedure UpdateLotInBlankPostedAssemblyILEOutput()
    var
        PostedAssemblyHeader: Record "910";
        ILE: Record "32";
    begin
        ILE.RESET;
        ILE.SETRANGE("Entry Type", ILE."Entry Type"::"Assembly Output");
        ILE.SETFILTER("Lot No.", '');
        IF ILE.FINDFIRST THEN
            REPEAT
                PostedAssemblyHeader.GET(ILE."Document No.");
                ILE."Lot No." := PostedAssemblyHeader."Batch No.";
                ILE."Expiration Date" := PostedAssemblyHeader."Expiry Date";
                ILE."Expiy Date" := ILE."Expiration Date";
                ILE."Batch No." := PostedAssemblyHeader."Batch No.";
                ILE."Manufacturing Date" := PostedAssemblyHeader."Manufacturing Date";
                ILE.MODIFY;
            UNTIL ILE.NEXT = 0;
    end;

    local procedure ClearSetAppliestoID()
    var
        VendorLedgEntry: Record "25";
    begin
        VendorLedgEntry.RESET;
        VendorLedgEntry.SETFILTER("Applies-to ID", '<>%1', '');
        VendorLedgEntry.MODIFYALL("Applies-to ID", '');
        // VendorLedgEntry.GET(50550);
        // VendorLedgEntry."Applies-to ID" := '';
        // VendorLedgEntry.MODIFY;
    end;

    [Scope('Internal')]
    procedure UpdateDefaultDimItemLedEnt()
    var
        ItemLedEnt: Record "32";
        DefaultDimension: Record "352";
        Item: Record "27";
        GeneralLedgerSetup: Record "98";
        DimMgt: Codeunit "408";
    begin
        Item.RESET;
        Item.SETRANGE("No.", '090');
        GeneralLedgerSetup.GET;
        IF Item.FIND('-') THEN
            REPEAT
                DefaultDimension.RESET;
                DefaultDimension.SETRANGE("Table ID", 27);
                DefaultDimension.SETRANGE("No.", Item."No.");
                DefaultDimension.SETRANGE("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 4 Code");
                IF DefaultDimension.FINDFIRST THEN BEGIN
                    ItemLedEnt.RESET;
                    ItemLedEnt.SETRANGE("Item No.", Item."No.");
                    IF ItemLedEnt.FINDSET(TRUE, FALSE) THEN
                        REPEAT
                            ItemLedEnt.VALIDATE("Shortcut Dimension 4 Code", DefaultDimension."Dimension Value Code");
                            DimMgt.ValidateShortcutDimValues(4, ItemLedEnt."Shortcut Dimension 4 Code", ItemLedEnt."Dimension Set ID");
                            ItemLedEnt.MODIFY;
                        UNTIL ItemLedEnt.NEXT = 0;
                END;
            UNTIL Item.NEXT = 0;
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit "408";
    begin
        /*DimMgt.ValidateDimValueCode(FieldNumber,ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::Item,"No.",FieldNumber,ShortcutDimCode);
        */

    end;

    local procedure ChangePragya()
    var
        PurchInvHeader: Record "122";
        GLEntry: Record "17";
        VATEntry: Record "254";
        ValueEntry: Record "5802";
    begin
        PurchInvHeader.RESET;
        PurchInvHeader.SETRANGE("No.", 'FAC/PPI/7677-00538');
        IF PurchInvHeader.FINDFIRST THEN BEGIN
            PurchInvHeader.PragyapanPatra := 'M 58932';
            PurchInvHeader.MODIFY;
        END;
        GLEntry.RESET;
        GLEntry.SETRANGE("Document No.", 'FAC/PPI/7677-00538');
        GLEntry.SETRANGE("Gen. Posting Type", GLEntry."Gen. Posting Type"::Purchase);
        IF GLEntry.FINDSET THEN
            REPEAT
                GLEntry.PragyapanPatra := 'M 58932';
                GLEntry.MODIFY;
            UNTIL GLEntry.NEXT = 0;

        VATEntry.RESET;
        VATEntry.SETRANGE("Document No.", 'FAC/PPI/7677-00538');
        IF VATEntry.FINDFIRST THEN BEGIN
            VATEntry.PragyapanPatra := 'M 58932';
            VATEntry.MODIFY;
        END;

        ValueEntry.RESET;
        ValueEntry.SETRANGE("Document No.", 'FAC/PPI/7677-00538');
        IF ValueEntry.FINDFIRST THEN BEGIN
            ValueEntry.PragyapanPatra := 'M 58932';
            ValueEntry.MODIFY;
        END;
    end;

    local procedure DocumentTypeUpdate()
    var
        EmpLedgEntries: Record "5222";
        DetailedEmpLedgerEntries: Record "5223";
        GLEntry: Record "17";
        BankAccLedgEntry: Record "271";
    begin
        GLEntry.GET(149);
        GLEntry."Transaction No." := 68;
        GLEntry.MODIFY;

        GLEntry.RESET;
        GLEntry.SETRANGE("Document No.", 'COR/PV/7677-00056');
        IF GLEntry.FINDFIRST THEN BEGIN
            GLEntry."Document Type" := GLEntry."Document Type"::Payment;
            GLEntry.MODIFY;
            EmpLedgEntries.RESET;
            EmpLedgEntries.SETRANGE("Document No.", GLEntry."Document No.");
            IF EmpLedgEntries.FINDFIRST THEN BEGIN
                EmpLedgEntries."Document Type" := GLEntry."Document Type";
                EmpLedgEntries.MODIFY;
            END;

            DetailedEmpLedgerEntries.RESET;
            DetailedEmpLedgerEntries.SETRANGE("Document No.", GLEntry."Document No.");
            IF DetailedEmpLedgerEntries.FINDFIRST THEN BEGIN
                DetailedEmpLedgerEntries."Document Type" := GLEntry."Document Type";
                DetailedEmpLedgerEntries.MODIFY;
            END;
            BankAccLedgEntry.RESET;
            BankAccLedgEntry.SETRANGE("Document No.", GLEntry."Document No.");
            IF BankAccLedgEntry.FINDFIRST THEN BEGIN
                BankAccLedgEntry."Transaction No." := 68;
                BankAccLedgEntry.MODIFY;
                MESSAGE('modified');
            END;
        END;
    end;

    local procedure UpdateBatchNo()
    var
        itemLedgerEntry: Record "32";
        PostedAssemblyHdr: Record "910";
    begin
        itemLedgerEntry.RESET;
        itemLedgerEntry.SETRANGE("Entry Type", itemLedgerEntry."Entry Type"::"Assembly Consumption");
        itemLedgerEntry.SETFILTER("Batch No.", '');
        IF itemLedgerEntry.FINDFIRST THEN
            REPEAT
                PostedAssemblyHdr.RESET;
                PostedAssemblyHdr.SETRANGE("No.", itemLedgerEntry."Document No.");
                IF PostedAssemblyHdr.FINDFIRST THEN BEGIN
                    itemLedgerEntry."Batch No." := PostedAssemblyHdr."Batch No.";
                    itemLedgerEntry.MODIFY;
                END;
            UNTIL itemLedgerEntry.NEXT = 0;
    end;

    [Scope('Internal')]
    procedure UpdateNepaliDate()
    var
        ProgresWindow: Dialog;
        ProcessingCount: Integer;
        ModifyingCount: Integer;
        Text000: Label 'Total Records #1#########\Processing #2###########\Modifying #3############';
    begin
        //Amisha 4/9/2021
        GLEntry.RESET;
        //Total Records #1#########\Processing #2###########\Modifying #3############
        ProgressWindow.OPEN(Text000);
        ProgressWindow.UPDATE(1, GLEntry.COUNT);
        IF GLEntry.FINDFIRST THEN
            REPEAT
                ProcessingCount += 1;
                ProgressWindow.UPDATE(2, ProcessingCount);
                EnglishNepaliDate.RESET;
                EnglishNepaliDate.SETRANGE("English Date", GLEntry."Document Date");
                IF EnglishNepaliDate.FINDFIRST THEN BEGIN
                    GLEntry."Nepali Document Date" := EnglishNepaliDate."Nepali Date";
                    GLEntry.MODIFY;
                    ModifyingCount += 1;
                    ProgressWindow.UPDATE(3, ModifyingCount);
                END;
            UNTIL GLEntry.NEXT = 0;
    end;

    local procedure UpdateReservationExpiryDate()
    var
        ReservationEntry: Record "337";
    begin
        ReservationEntry.RESET;
        ReservationEntry.SETRANGE("Entry No.", 124745);
        IF ReservationEntry.FINDFIRST THEN BEGIN
            ReservationEntry."Expiration Date" := 120122D;
            ReservationEntry."Manufacturing Date" := 010121D;
            ReservationEntry.MODIFY;
        END;
    end;

    local procedure UpdateFixedAssets()
    var
        FixedAssets: Record "5600";
    begin
        FixedAssets.SETFILTER("No.", '%1..%2', 'FA-OP0300', 'FA-OP0430');
        FixedAssets.MODIFYALL("FA Class Code", 'P & M');
        FixedAssets.MODIFYALL("FA Subclass Code", '007');
        FixedAssets.MODIFYALL("No. Series", 'FA');
        FixedAssets.MODIFYALL("FA Posting Group", 'P & M');
        MESSAGE('Updated');
    end;

    local procedure UpdateFixedAssetsDepriciation()
    var
        FADepBook: Record "5612";
    begin
        FADepBook.SETFILTER("FA No.", '%1..%2', 'FA-OP0300', 'FA-OP0430');
        FADepBook.MODIFYALL("FA Posting Group", 'P & M');
        MESSAGE('Updated');
    end;

    local procedure UpdateFixedAssetsLedgerEntries()
    var
        FALedgEntry: Record "5601";
    begin
        FALedgEntry.RESET;
        FALedgEntry.SETFILTER("FA No.", '%1..%2', 'FA-OP0300', 'FA-OP0430');
        IF FALedgEntry.FINDSET THEN
            REPEAT
                FALedgEntry."FA Posting Group" := 'P & M';
                FALedgEntry."FA Subclass Code" := '007';
                FALedgEntry.MODIFY;
            UNTIL FALedgEntry.NEXT = 0;
        MESSAGE('Updated');
    end;

    local procedure UpdateGLEntries()
    var
        GLEntry: Record "17";
    begin
        GLEntry.RESET;
        GLEntry.SETFILTER("Source No.", '%1..%2', 'FA-OP0300', 'FA-OP0430');
        IF GLEntry.FINDSET THEN
            REPEAT
                GLEntry."G/L Account No." := '11000006';
                GLEntry.MODIFY;
            UNTIL GLEntry.NEXT = 0;
        MESSAGE('Updated');
    end;

    local procedure UpdateGLentry()
    var
        GLEntry: Record "17";
    begin
        GLEntry.RESET;
        GLEntry.SETRANGE("Document No.", 'Cor/pv/7677-02915');
        GLEntry.SETFILTER("Entry No.", '25261');
        GLEntry.SETRANGE("G/L Account No.", '15250001');
        IF GLEntry.FINDFIRST THEN BEGIN
            GLEntry."G/L Account No." := '15150002';
            GLEntry.MODIFY;
            //  MESSAGE(FORMAT(GLEntry."Document No."));
            //  MESSAGE(FORMAT(GLEntry."Entry No."));
            //  MESSAGE(FORMAT(GLEntry."G/L Account No."));
            MESSAGE('Done');
        END;
    end;

    local procedure DeleteFixedAssets()
    var
        FixedAsset: Record "5600";
    begin
        FixedAsset.SETFILTER("No.", '%1..%2', 'TFA-OP0300', 'TFA-OP0430');
        IF FixedAsset.FINDFIRST THEN
            REPEAT
                FixedAsset.DELETE;
            UNTIL FixedAsset.NEXT = 0;
        MESSAGE('Done')
    end;
}

