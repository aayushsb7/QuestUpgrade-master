pageextension 50092 "pageextension70000693" extends Navigate
{
    var
        TDSEntry: Record "Original TDS Entry";
        Text030: Label 'TDS Entry';
        InvoiceMateiralizedView: Record "Invoice Materialize View";
        Text031: Label 'Invoice Materialize View';
        SalesInvMaterialize: Page "Sales Invoice Materialize View";
        SalesCrMemoMaterialize: Page "Sales Cr.Memo Materialize View";


    //Unsupported feature: Code Modification on "FindRecords(PROCEDURE 2)".

    //procedure FindRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeFindRecords(HideDialog);
    IF NOT HideDialog THEN
      Window.OPEN(Text002);
    RESET;
    DELETEALL;
    "Entry No." := 0;

    FindPostedDocuments;
    FindLedgerEntries;

    #11..45

    IF NOT HideDialog THEN
      Window.CLOSE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    FindIncomingDocumentRecords;
    //TDS1.00 >>
    IF TDSEntry.READPERMISSION THEN BEGIN
      TDSEntry.RESET;
      TDSEntry.SETFILTER("Document No.",DocNoFilter);
      TDSEntry.SETFILTER("Posting Date",PostingDateFilter);
      {InsertIntoDocEntry(
        DATABASE::"Original TDS Entry",50006,Text030,TDSEntry.COUNT);}
    END;
    //TDS1.00 <<

    //IRD20.00 >>
    IF InvoiceMateiralizedView.READPERMISSION THEN BEGIN
      InvoiceMateiralizedView.RESET;
      InvoiceMateiralizedView.SETFILTER("Bill No",DocNoFilter);
      InvoiceMateiralizedView.SETFILTER("Bill Date",PostingDateFilter);
      {InsertIntoDocEntry(
        DATABASE::"Invoice Materialize View",0,Text031,InvoiceMateiralizedView.COUNT);}
    END;
    //IRD20.00 <<
    FindEmployeeRecords;
    FindSalesShipmentHeader;
    IF SalesInvHeader.READPERMISSION THEN BEGIN
      SalesInvHeader.RESET;
      SalesInvHeader.SETFILTER("No.",DocNoFilter);
      SalesInvHeader.SETFILTER("Posting Date",PostingDateFilter);
      {InsertIntoDocEntry(
        DATABASE::"Sales Invoice Header",0,Text003,SalesInvHeader.COUNT);}
    END;
    IF ReturnRcptHeader.READPERMISSION THEN BEGIN
      ReturnRcptHeader.RESET;
      ReturnRcptHeader.SETFILTER("No.",DocNoFilter);
      ReturnRcptHeader.SETFILTER("Posting Date",PostingDateFilter);
      {InsertIntoDocEntry(
        DATABASE::"Return Receipt Header",0,Text017,ReturnRcptHeader.COUNT);}
    END;
    IF SalesCrMemoHeader.READPERMISSION THEN BEGIN
      SalesCrMemoHeader.RESET;
      SalesCrMemoHeader.SETFILTER("No.",DocNoFilter);
      SalesCrMemoHeader.SETFILTER("Posting Date",PostingDateFilter);
      {InsertIntoDocEntry(
        DATABASE::"Sales Cr.Memo Header",0,Text004,SalesCrMemoHeader.COUNT);}
    END;
    IF ServShptHeader.READPERMISSION THEN BEGIN
      ServShptHeader.RESET;
      ServShptHeader.SETFILTER("No.",DocNoFilter);
      ServShptHeader.SETFILTER("Posting Date",PostingDateFilter);
      {InsertIntoDocEntry(
        DATABASE::"Service Shipment Header",0,Text005,ServShptHeader.COUNT);}
    END;
    IF ServInvHeader.READPERMISSION THEN BEGIN
      ServInvHeader.RESET;
      ServInvHeader.SETFILTER("No.",DocNoFilter);
      ServInvHeader.SETFILTER("Posting Date",PostingDateFilter);
      {InsertIntoDocEntry(
        DATABASE::"Service Invoice Header",0,sText003,ServInvHeader.COUNT);}
    END;
    IF ServCrMemoHeader.READPERMISSION THEN BEGIN
      ServCrMemoHeader.RESET;
      ServCrMemoHeader.SETFILTER("No.",DocNoFilter);
      ServCrMemoHeader.SETFILTER("Posting Date",PostingDateFilter);
      {InsertIntoDocEntry(
        DATABASE::"Service Cr.Memo Header",0,Text004,ServCrMemoHeader.COUNT);}
    END;
    IF IssuedReminderHeader.READPERMISSION THEN BEGIN
      IssuedReminderHeader.RESET;
      IssuedReminderHeader.SETFILTER("No.",DocNoFilter);
      IssuedReminderHeader.SETFILTER("Posting Date",PostingDateFilter);
      {InsertIntoDocEntry(
        DATABASE::"Issued Reminder Header",0,Text006,IssuedReminderHeader.COUNT);}
    END;
    IF IssuedFinChrgMemoHeader.READPERMISSION THEN BEGIN
      IssuedFinChrgMemoHeader.RESET;
      IssuedFinChrgMemoHeader.SETFILTER("No.",DocNoFilter);
      IssuedFinChrgMemoHeader.SETFILTER("Posting Date",PostingDateFilter);
      {InsertIntoDocEntry(
        DATABASE::"Issued Fin. Charge Memo Header",0,Text007,
        IssuedFinChrgMemoHeader.COUNT);}
    END;
    IF PurchRcptHeader.READPERMISSION THEN BEGIN
      PurchRcptHeader.RESET;
      PurchRcptHeader.SETFILTER("No.",DocNoFilter);
      PurchRcptHeader.SETFILTER("Posting Date",PostingDateFilter);
      {InsertIntoDocEntry(
        DATABASE::"Purch. Rcpt. Header",0,Text010,PurchRcptHeader.COUNT);}
    END;
    IF PurchInvHeader.READPERMISSION THEN BEGIN
      PurchInvHeader.RESET;
      PurchInvHeader.SETFILTER("No.",DocNoFilter);
      PurchInvHeader.SETFILTER("Posting Date",PostingDateFilter);
      {InsertIntoDocEntry(
        DATABASE::"Purch. Inv. Header",0,Text008,PurchInvHeader.COUNT);}
    END;
    IF ReturnShptHeader.READPERMISSION THEN BEGIN
      ReturnShptHeader.RESET;
      ReturnShptHeader.SETFILTER("No.",DocNoFilter);
      ReturnShptHeader.SETFILTER("Posting Date",PostingDateFilter);
      {InsertIntoDocEntry(
        DATABASE::"Return Shipment Header",0,Text018,ReturnShptHeader.COUNT);}
    END;
    IF PurchCrMemoHeader.READPERMISSION THEN BEGIN
      PurchCrMemoHeader.RESET;
      PurchCrMemoHeader.SETFILTER("No.",DocNoFilter);
      PurchCrMemoHeader.SETFILTER("Posting Date",PostingDateFilter);
      {InsertIntoDocEntry(
        DATABASE::"Purch. Cr. Memo Hdr.",0,Text009,PurchCrMemoHeader.COUNT);}
    END;
    IF ProductionOrderHeader.READPERMISSION THEN BEGIN
      ProductionOrderHeader.RESET;
      ProductionOrderHeader.SETRANGE(
        Status,
        ProductionOrderHeader.Status::Released,
        ProductionOrderHeader.Status::Finished);
      ProductionOrderHeader.SETFILTER("No.",DocNoFilter);
      {InsertIntoDocEntry(
        DATABASE::"Production Order",0,Text99000000,ProductionOrderHeader.COUNT);}
    END;
    IF PostedAssemblyHeader.READPERMISSION THEN BEGIN
      PostedAssemblyHeader.RESET;
      PostedAssemblyHeader.SETFILTER("No.",DocNoFilter);
     {InsertIntoDocEntry(
        DATABASE::"Posted Assembly Header",0,Text025,PostedAssemblyHeader.COUNT);}
    END;
    IF TransShptHeader.READPERMISSION THEN BEGIN
      TransShptHeader.RESET;
      TransShptHeader.SETFILTER("No.",DocNoFilter);
      TransShptHeader.SETFILTER("Posting Date",PostingDateFilter);
      {InsertIntoDocEntry(
        DATABASE::"Transfer Shipment Header",0,Text019,TransShptHeader.COUNT);}
    END;
    IF TransRcptHeader.READPERMISSION THEN BEGIN
      TransRcptHeader.RESET;
      TransRcptHeader.SETFILTER("No.",DocNoFilter);
      TransRcptHeader.SETFILTER("Posting Date",PostingDateFilter);
      {InsertIntoDocEntry(
        DATABASE::"Transfer Receipt Header",0,Text020,TransRcptHeader.COUNT);}
    END;
    IF PostedWhseShptLine.READPERMISSION THEN BEGIN
      PostedWhseShptLine.RESET;
      PostedWhseShptLine.SETCURRENTKEY("Posted Source No.","Posting Date");
      PostedWhseShptLine.SETFILTER("Posted Source No.",DocNoFilter);
      PostedWhseShptLine.SETFILTER("Posting Date",PostingDateFilter);
      {InsertIntoDocEntry(
        DATABASE::"Posted Whse. Shipment Line",0,
        PostedWhseShptLine.TABLECAPTION,PostedWhseShptLine.COUNT);}
    END;
    IF PostedWhseRcptLine.READPERMISSION THEN BEGIN
      PostedWhseRcptLine.RESET;
      PostedWhseRcptLine.SETCURRENTKEY("Posted Source No.","Posting Date");
      PostedWhseRcptLine.SETFILTER("Posted Source No.",DocNoFilter);
      PostedWhseRcptLine.SETFILTER("Posting Date",PostingDateFilter);
      {InsertIntoDocEntry(
        DATABASE::"Posted Whse. Receipt Line",0,
        PostedWhseRcptLine.TABLECAPTION,PostedWhseRcptLine.COUNT);}
    END;
    IF GLEntry.READPERMISSION THEN BEGIN
      GLEntry.RESET;
      GLEntry.SETCURRENTKEY("Document No.","Posting Date");
      GLEntry.SETFILTER("Document No.",DocNoFilter);
      GLEntry.SETFILTER("Posting Date",PostingDateFilter);
      {InsertIntoDocEntry(
        DATABASE::"G/L Entry",0,GLEntry.TABLECAPTION,GLEntry.COUNT);}
    END;
    IF VATEntry.READPERMISSION THEN BEGIN
      VATEntry.RESET;
      VATEntry.SETCURRENTKEY("Document No.","Posting Date");
      VATEntry.SETFILTER("Document No.",DocNoFilter);
      VATEntry.SETFILTER("Posting Date",PostingDateFilter);
      {InsertIntoDocEntry(
        DATABASE::"VAT Entry",0,VATEntry.TABLECAPTION,VATEntry.COUNT);}
    END;
    #8..48
    */
    //end;


    //Unsupported feature: Code Modification on "ShowRecords(PROCEDURE 6)".

    //procedure ShowRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := FALSE;
    OnBeforeNavigateShowRecords(
      "Table ID",DocNoFilter,PostingDateFilter,ItemTrackingSearch,Rec,IsHandled,
    #4..152
          PAGE.RUN(0,WarrantyLedgerEntry);
        DATABASE::"Cost Entry":
          PAGE.RUN(0,CostEntry);
        DATABASE::"Pstd. Phys. Invt. Order Hdr":
          PAGE.RUN(0,PstdPhysInvtOrderHdr);
      END;

    OnAfterNavigateShowRecords(
      "Table ID",DocNoFilter,PostingDateFilter,ItemTrackingSearch,Rec,
      SalesInvHeader,SalesCrMemoHeader,PurchInvHeader,PurchCrMemoHeader,ServInvHeader,ServCrMemoHeader);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..155
        //TDS1.00 >>
        DATABASE::"Original TDS Entry":
          PAGE.RUN(0,TDSEntry);
        //TDS1.00 <<
        //IRD20.00 >>
        DATABASE::"Invoice Materialize View":
          PAGE.RUN(0,InvoiceMateiralizedView);
        //IRD20.00 <<
    #156..162
    */
    //end;
}

