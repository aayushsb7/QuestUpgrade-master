codeunit 50000 "IRD Mgt."
{
    Permissions = TableData 50000 = r,
                  TableData 50001 = rim,
                  TableData 50002 = rim;

    trigger OnRun()
    begin
    end;

    var
        Text026: Label 'ZERO';
        Text027: Label 'HUNDRED';
        Text028: Label 'AND';
        Text029: Label '%1 results in a written number that is too long.';
        Text032: Label 'ONE';
        Text033: Label 'TWO';
        Text034: Label 'THREE';
        Text035: Label 'FOUR';
        Text036: Label 'FIVE';
        Text037: Label 'SIX';
        Text038: Label 'SEVEN';
        Text039: Label 'EIGHT';
        Text040: Label 'NINE';
        Text041: Label 'TEN';
        Text042: Label 'ELEVEN';
        Text043: Label 'TWELVE';
        Text044: Label 'THIRTEEN';
        Text045: Label 'FOURTEEN';
        Text046: Label 'FIFTEEN';
        Text047: Label 'SIXTEEN';
        Text048: Label 'SEVENTEEN';
        Text049: Label 'EIGHTEEN';
        Text050: Label 'NINETEEN';
        Text051: Label 'TWENTY';
        Text052: Label 'THIRTY';
        Text053: Label 'FORTY';
        Text054: Label 'FIFTY';
        Text055: Label 'SIXTY';
        Text056: Label 'SEVENTY';
        Text057: Label 'EIGHTY';
        Text058: Label 'NINETY';
        Text1280000: Label 'LAKH';
        Text1280001: Label 'CRORE';
        Text059: Label 'THOUSAND';
        Text060: Label 'MILLION';
        Text061: Label 'BILLION';
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        GeneralLedgSetup: Record "98";
        IRDMgt: Codeunit "50000";
        intNewEntryNo: Integer;

    [Scope('Internal')]
    procedure getNepaliDate(EngDate: Date): Code[10]
    var
        EnglishNepaliDate: Record "50000";
        Text0000: Label 'Cannot find the equivalant Nepali Date! Please contact your system administrator.';
    begin
        EnglishNepaliDate.RESET;
        EnglishNepaliDate.SETRANGE("English Date", EngDate);
        IF EnglishNepaliDate.FIND('-') THEN
            EXIT(EnglishNepaliDate."Nepali Date");
    end;

    [Scope('Internal')]
    procedure getEngDate(NepDate: Code[20]): Date
    var
        EnglishNepaliDate: Record "50000";
        Text001: Label 'Cannot find equivalant English Date! Please contact your system administrator.';
    begin
        EnglishNepaliDate.RESET;
        EnglishNepaliDate.SETRANGE("Nepali Date", NepDate);
        IF EnglishNepaliDate.FIND('-') THEN
            EXIT(EnglishNepaliDate."English Date");
    end;

    [Scope('Internal')]
    procedure getNepaliYearMonth(EngDate: Date; var NepaliYear: Integer; var NepaliMonth: Option " ",Baisakh,Jestha,Asar,Shrawn,Bhadra,Ashoj,Kartik,Mangsir,Poush,Margh,Falgun,Chaitra)
    var
        EnglishNepaliDate: Record "50000";
    begin
        EnglishNepaliDate.RESET;
        EnglishNepaliDate.SETRANGE("English Date", EngDate);
        IF EnglishNepaliDate.FINDFIRST THEN BEGIN
            NepaliYear := EnglishNepaliDate."Nepali Year";
            NepaliMonth := EnglishNepaliDate."Nepali Month";
        END;
    end;

    [Scope('Internal')]
    procedure getEnglishMonth(EngDate: Date): Integer
    var
        EnglishNepaliDate: Record "50000";
    begin
        EnglishNepaliDate.RESET;
        EnglishNepaliDate.SETRANGE("English Date", EngDate);
        IF EnglishNepaliDate.FINDFIRST THEN
            EXIT(EnglishNepaliDate."English Month");

        EXIT(0);
    end;

    [Scope('Internal')]
    procedure getEnglishYear(EngDate: Date): Integer
    var
        EnglishNepaliDate: Record "50000";
    begin
        EnglishNepaliDate.RESET;
        EnglishNepaliDate.SETRANGE("English Date", EngDate);
        IF EnglishNepaliDate.FINDFIRST THEN
            EXIT(EnglishNepaliDate."English Year");

        EXIT(0);
    end;

    [Scope('Internal')]
    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        Currency: Record "4";
        TensDec: Integer;
        OnesDec: Integer;
    begin
        CLEAR(NoText);
        NoTextIndex := 1;
        NoText[1] := '';

        IF No < 1 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text026)
        ELSE BEGIN
            FOR Exponent := 4 DOWNTO 1 DO BEGIN
                PrintExponent := FALSE;
                IF No > 99999 THEN BEGIN
                    Ones := No DIV (POWER(100, Exponent - 1) * 10);
                    Hundreds := 0;
                END ELSE BEGIN
                    Ones := No DIV POWER(1000, Exponent - 1);
                    Hundreds := Ones DIV 100;
                END;
                Tens := (Ones MOD 100) DIV 10;
                Ones := Ones MOD 10;
                IF Hundreds > 0 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text027);
                END;
                IF Tens >= 2 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    IF Ones > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                END ELSE
                    IF (Tens * 10 + Ones) > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                IF PrintExponent AND (Exponent > 1) THEN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                IF No > 99999 THEN
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(100, Exponent - 1) * 10
                ELSE
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
            END;
        END;

        IF CurrencyCode <> '' THEN BEGIN
            Currency.GET(CurrencyCode);
            AddToNoText(NoText, NoTextIndex, PrintExponent, '');
        END ELSE
            AddToNoText(NoText, NoTextIndex, PrintExponent, 'RUPEES');

        AddToNoText(NoText, NoTextIndex, PrintExponent, Text028);
        // AddToNoText(NoText,NoTextIndex,PrintExponent,FORMAT(No * 100) + '/100');

        TensDec := ((No * 100) MOD 100) DIV 10;
        OnesDec := (No * 100) MOD 10;
        IF TensDec >= 2 THEN BEGIN
            AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[TensDec]);
            IF OnesDec > 0 THEN
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[OnesDec]);
        END ELSE
            IF (TensDec * 10 + OnesDec) > 0 THEN
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[TensDec * 10 + OnesDec])
            ELSE
                AddToNoText(NoText, NoTextIndex, PrintExponent, Text026);
        IF (CurrencyCode <> '') THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, '')
        ELSE
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' PAISA ONLY');
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent := TRUE;

        WHILE STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) DO BEGIN
            NoTextIndex := NoTextIndex + 1;
            IF NoTextIndex > ARRAYLEN(NoText) THEN
                ERROR(Text029, AddText);
        END;

        NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    [Scope('Internal')]
    procedure InitTextVariable()
    begin
        OnesText[1] := Text032;
        OnesText[2] := Text033;
        OnesText[3] := Text034;
        OnesText[4] := Text035;
        OnesText[5] := Text036;
        OnesText[6] := Text037;
        OnesText[7] := Text038;
        OnesText[8] := Text039;
        OnesText[9] := Text040;
        OnesText[10] := Text041;
        OnesText[11] := Text042;
        OnesText[12] := Text043;
        OnesText[13] := Text044;
        OnesText[14] := Text045;
        OnesText[15] := Text046;
        OnesText[16] := Text047;
        OnesText[17] := Text048;
        OnesText[18] := Text049;
        OnesText[19] := Text050;

        TensText[1] := '';
        TensText[2] := Text051;
        TensText[3] := Text052;
        TensText[4] := Text053;
        TensText[5] := Text054;
        TensText[6] := Text055;
        TensText[7] := Text056;
        TensText[8] := Text057;
        TensText[9] := Text058;

        ExponentText[1] := '';
        ExponentText[2] := Text059;
        ExponentText[3] := Text1280000;
        ExponentText[4] := Text1280001;
    end;

    [Scope('Internal')]
    procedure InsertRepSelection(ReportUsage: Integer; Sequence: Code[10]; ReportID: Integer)
    var
        ReportSelections: Record "77";
    begin
        ReportSelections.RESET;
        ReportSelections.SETRANGE(Usage, ReportUsage);
        ReportSelections.SETRANGE(Sequence, Sequence);
        ReportSelections.DELETEALL;

        CLEAR(ReportSelections);
        ReportSelections.INIT;
        ReportSelections.Usage := ReportUsage;
        ReportSelections.Sequence := Sequence;
        ReportSelections."Report ID" := ReportID;
        ReportSelections.INSERT;
    end;

    [Scope('Internal')]
    procedure InsertRegisterInvoice(TableID: Integer; DocumentNo: Code[20])
    var
        AccountingPeriod: Record "50";
        RegisterofInvoiceNoSeries: Record "50001";
        SalesInvHeader: Record "112";
        SalesCrMemoHeader: Record "114";
        ServiceInvoiceHeader: Record "5992";
        ServiceCrMemoHeader: Record "5994";
    begin
        CASE TableID OF
            DATABASE::"Sales Invoice Header":
                BEGIN
                    IF NOT SalesInvHeader.GET(DocumentNo) THEN
                        EXIT;
                    CLEAR(RegisterofInvoiceNoSeries);
                    RegisterofInvoiceNoSeries.INIT;
                    RegisterofInvoiceNoSeries."Table ID" := DATABASE::"Sales Invoice Header";
                    RegisterofInvoiceNoSeries."Document Type" := RegisterofInvoiceNoSeries."Document Type"::"Sales Invoice";
                    RegisterofInvoiceNoSeries."Bill No" := SalesInvHeader."No.";
                    RegisterofInvoiceNoSeries."Fiscal Year" := GetNepaliFiscalYear(SalesInvHeader."Posting Date");
                    RegisterofInvoiceNoSeries."Bill Date" := SalesInvHeader."Posting Date";
                    RegisterofInvoiceNoSeries."Posting Time" := SalesInvHeader."Posting Time";
                    RegisterofInvoiceNoSeries."Source Type" := RegisterofInvoiceNoSeries."Source Type"::Customer;
                    RegisterofInvoiceNoSeries."Customer Code" := SalesInvHeader."Bill-to Customer No.";
                    RegisterofInvoiceNoSeries."Source Code" := SalesInvHeader."Source Code";
                    RegisterofInvoiceNoSeries."Customer Name" := SalesInvHeader."Bill-to Name";
                    RegisterofInvoiceNoSeries."VAT Registration No." := SalesInvHeader."VAT Registration No.";
                    RegisterofInvoiceNoSeries."Responsibility Center" := SalesInvHeader."Responsibility Center"; //ZM Agile
                    RegisterofInvoiceNoSeries."Responsibility Center" := SalesInvHeader."Accountability Center";
                    SetSyncStatus(RegisterofInvoiceNoSeries);
                    CalculateInvoiceTotals(DATABASE::"Sales Invoice Header", SalesInvHeader."No.",
                          RegisterofInvoiceNoSeries.Amount, RegisterofInvoiceNoSeries.Discount, RegisterofInvoiceNoSeries."Taxable Amount",
                          RegisterofInvoiceNoSeries."TAX Amount", RegisterofInvoiceNoSeries."Total Amount");

                    RegisterofInvoiceNoSeries."Entered By" := SalesInvHeader."User ID";
                    RegisterofInvoiceNoSeries."Is Bill Printed" := SalesInvHeader."No. Printed" > 0;
                    RegisterofInvoiceNoSeries."Is Bill Active" := TRUE;
                    RegisterofInvoiceNoSeries."Printed By" := SalesInvHeader."Tax Invoice Printed By";
                    RegisterofInvoiceNoSeries.INSERT;
                END;
            DATABASE::"Sales Cr.Memo Header":
                BEGIN
                    IF NOT SalesCrMemoHeader.GET(DocumentNo) THEN
                        EXIT;
                    CLEAR(RegisterofInvoiceNoSeries);
                    RegisterofInvoiceNoSeries.INIT;
                    RegisterofInvoiceNoSeries."Table ID" := DATABASE::"Sales Cr.Memo Header";
                    RegisterofInvoiceNoSeries."Document Type" := RegisterofInvoiceNoSeries."Document Type"::"Sales Credit Memo";
                    RegisterofInvoiceNoSeries."Bill No" := SalesCrMemoHeader."No.";
                    RegisterofInvoiceNoSeries."Fiscal Year" := GetNepaliFiscalYear(SalesCrMemoHeader."Posting Date");
                    RegisterofInvoiceNoSeries."Bill Date" := SalesCrMemoHeader."Posting Date";
                    RegisterofInvoiceNoSeries."Posting Time" := SalesCrMemoHeader."Posting Time";
                    RegisterofInvoiceNoSeries."Source Type" := RegisterofInvoiceNoSeries."Source Type"::Customer;
                    RegisterofInvoiceNoSeries."Customer Code" := SalesCrMemoHeader."Bill-to Customer No.";
                    RegisterofInvoiceNoSeries."Source Code" := SalesCrMemoHeader."Source Code";
                    RegisterofInvoiceNoSeries."Customer Name" := SalesCrMemoHeader."Bill-to Name";
                    RegisterofInvoiceNoSeries."VAT Registration No." := SalesCrMemoHeader."VAT Registration No.";
                    RegisterofInvoiceNoSeries."Responsibility Center" := SalesCrMemoHeader."Responsibility Center"; //ZM Agile
                    RegisterofInvoiceNoSeries."Responsibility Center" := SalesInvHeader."Accountability Center";
                    SetSyncStatus(RegisterofInvoiceNoSeries);
                    CalculateInvoiceTotals(DATABASE::"Sales Cr.Memo Header", SalesCrMemoHeader."No.",
                          RegisterofInvoiceNoSeries.Amount, RegisterofInvoiceNoSeries.Discount, RegisterofInvoiceNoSeries."Taxable Amount",
                          RegisterofInvoiceNoSeries."TAX Amount", RegisterofInvoiceNoSeries."Total Amount");

                    RegisterofInvoiceNoSeries."Entered By" := SalesCrMemoHeader."User ID";
                    RegisterofInvoiceNoSeries."Is Bill Printed" := SalesCrMemoHeader."No. Printed" > 0;
                    RegisterofInvoiceNoSeries."Is Bill Active" := TRUE;
                    RegisterofInvoiceNoSeries."Printed By" := SalesCrMemoHeader."Printed By";
                    RegisterofInvoiceNoSeries.INSERT;
                    SetInActiveInvoices(DATABASE::"Sales Cr.Memo Header", DocumentNo);
                END;
        END;
    end;

    [Scope('Internal')]
    procedure InsertSalesDocPrintHistory(TableNo: Integer; DocumentNo: Code[20]; PrintingDate: Date; PrintingTime: Time)
    var
        SalesInvoicePrintHistory: Record "50002";
        RegisterofInvoiceNoSeries: Record "50001";
        SalesInvHeader: Record "112";
        SalesCrMemoHeader: Record "114";
        ServiceInvoiceHeader: Record "5992";
        ServiceCrMemoHeader: Record "5994";
        PostingDate: Date;
        LastNoOfPrint: Integer;
        LastLineNo: Integer;
        DocumentType: Option "Sales Invoice","Sales Credit Memo";
        FiscalYear: Text[30];
    begin
        SalesInvoicePrintHistory.RESET;
        SalesInvoicePrintHistory.SETRANGE("Table ID", TableNo);
        CASE TableNo OF
            DATABASE::"Sales Invoice Header":
                BEGIN
                    SalesInvoicePrintHistory.SETRANGE("Document Type", SalesInvoicePrintHistory."Document Type"::"Sales Invoice");
                    SalesInvHeader.GET(DocumentNo);
                    LastNoOfPrint := SalesInvHeader."No. Printed";
                    PostingDate := SalesInvHeader."Posting Date";
                    DocumentType := DocumentType::"Sales Invoice";
                    FiscalYear := GetNepaliFiscalYear(PostingDate);
                END;
            DATABASE::"Service Invoice Header":
                BEGIN
                    SalesInvoicePrintHistory.SETRANGE("Document Type", SalesInvoicePrintHistory."Document Type"::"Sales Invoice");
                    ServiceInvoiceHeader.GET(DocumentNo);
                    LastNoOfPrint := ServiceInvoiceHeader."No. Printed";
                    PostingDate := ServiceInvoiceHeader."Posting Date";
                    DocumentType := DocumentType::"Sales Invoice";
                    FiscalYear := GetNepaliFiscalYear(PostingDate);
                END;
            DATABASE::"Sales Cr.Memo Header":
                BEGIN
                    SalesInvoicePrintHistory.SETRANGE("Document Type", SalesInvoicePrintHistory."Document Type"::"Sales Credit Memo");
                    SalesCrMemoHeader.GET(DocumentNo);
                    LastNoOfPrint := SalesCrMemoHeader."No. Printed";
                    PostingDate := SalesCrMemoHeader."Posting Date";
                    DocumentType := DocumentType::"Sales Credit Memo";
                    FiscalYear := GetNepaliFiscalYear(PostingDate);
                END;
            DATABASE::"Service Cr.Memo Header":
                BEGIN
                    SalesInvoicePrintHistory.SETRANGE("Document Type", SalesInvoicePrintHistory."Document Type"::"Sales Credit Memo");
                    ServiceCrMemoHeader.GET(DocumentNo);
                    LastNoOfPrint := ServiceCrMemoHeader."No. Printed";
                    PostingDate := ServiceCrMemoHeader."Posting Date";
                    DocumentType := DocumentType::"Sales Credit Memo";
                    FiscalYear := GetNepaliFiscalYear(PostingDate);
                END;
        END;
        SalesInvoicePrintHistory.SETRANGE("Document No.", DocumentNo);
        SalesInvoicePrintHistory.SETRANGE("Fiscal Year", FiscalYear);
        IF SalesInvoicePrintHistory.FINDLAST THEN
            LastLineNo := SalesInvoicePrintHistory."Line No.";

        SalesInvoicePrintHistory.INIT;
        SalesInvoicePrintHistory."Table ID" := TableNo;
        SalesInvoicePrintHistory."Document Type" := DocumentType;
        SalesInvoicePrintHistory."Document No." := DocumentNo;
        SalesInvoicePrintHistory."Fiscal Year" := GetNepaliFiscalYear(PostingDate);
        SalesInvoicePrintHistory."Line No." := LastLineNo + 10000;
        SalesInvoicePrintHistory."Printing Date" := PrintingDate;
        SalesInvoicePrintHistory."Printed Time" := PrintingTime;
        SalesInvoicePrintHistory."Printed By" := USERID;
        IF LastNoOfPrint = 0 THEN BEGIN
            SalesInvoicePrintHistory.Type := SalesInvoicePrintHistory.Type::"Tax Invoice";
            SalesInvoicePrintHistory."Times Printed" := 1
        END
        ELSE
            IF LastNoOfPrint = 1 THEN BEGIN
                SalesInvoicePrintHistory.Type := SalesInvoicePrintHistory.Type::Invoice;
                SalesInvoicePrintHistory."Times Printed" := 1
            END
            ELSE BEGIN
                SalesInvoicePrintHistory.Type := SalesInvoicePrintHistory.Type::"Copy of Original";
                SalesInvoicePrintHistory."Times Printed" := LastNoOfPrint - 1;
            END;

        SalesInvoicePrintHistory.INSERT;
    end;

    local procedure SetInActiveInvoices(TableID: Integer; DocumentNo: Code[20])
    var
        SalesInvHeader: Record "112";
        SalesCrMemoLine: Record "115";
        ServiceInvoiceHeader: Record "5992";
        ServiceCrMemoLine: Record "5995";
        ValueEntry: Record "5802";
        RegisterofInvoiceNoSeries: Record "50001";
    begin
        CASE TableID OF
            DATABASE::"Sales Cr.Memo Header":
                BEGIN
                    SalesCrMemoLine.RESET;
                    SalesCrMemoLine.SETRANGE("Document No.", DocumentNo);
                    SalesCrMemoLine.SETFILTER(Quantity, '<>0');
                    IF SalesCrMemoLine.FINDSET THEN
                        REPEAT
                            IF SalesInvHeader.GET(SalesCrMemoLine."Returned Document No.") THEN BEGIN
                                RegisterofInvoiceNoSeries.RESET;
                                RegisterofInvoiceNoSeries.SETRANGE("Table ID", DATABASE::"Sales Invoice Header");
                                RegisterofInvoiceNoSeries.SETRANGE("Document Type", RegisterofInvoiceNoSeries."Document Type"::"Sales Invoice");
                                RegisterofInvoiceNoSeries.SETRANGE("Bill No", SalesCrMemoLine."Returned Document No.");
                                RegisterofInvoiceNoSeries.SETRANGE("Fiscal Year", GetNepaliFiscalYear(SalesInvHeader."Posting Date"));
                                IF RegisterofInvoiceNoSeries.FINDFIRST THEN BEGIN
                                    RegisterofInvoiceNoSeries."Is Bill Active" := FALSE;
                                    RegisterofInvoiceNoSeries.MODIFY;
                                END;
                            END;
                        UNTIL SalesCrMemoLine.NEXT = 0;
                END;
        END;
    end;

    [Scope('Internal')]
    procedure SetSyncStatus(var InvoiceMaterializeView: Record "50001")
    var
        CBMSMgt: Codeunit "50004";
        ReturnedDocNo: Code[20];
    begin
        IF CBMSMgt.Enabled THEN BEGIN
            IF InvoiceMaterializeView."Document Type" = InvoiceMaterializeView."Document Type"::"Sales Credit Memo" THEN BEGIN
                IF CBMSMgt.RealTimeEnabled THEN
                    InvoiceMaterializeView."Sync Status" := InvoiceMaterializeView."Sync Status"::"Sync In Progress"
                ELSE
                    InvoiceMaterializeView."Sync Status" := InvoiceMaterializeView."Sync Status"::Pending;
            END
            ELSE
                IF InvoiceMaterializeView."Document Type" = InvoiceMaterializeView."Document Type"::"Sales Invoice" THEN BEGIN
                    IF CBMSMgt.RealTimeEnabled THEN
                        InvoiceMaterializeView."Sync Status" := InvoiceMaterializeView."Sync Status"::"Sync In Progress"
                    ELSE
                        InvoiceMaterializeView."Sync Status" := InvoiceMaterializeView."Sync Status"::Pending;
                END;
        END
        ELSE BEGIN
            InvoiceMaterializeView."Sync Status" := InvoiceMaterializeView."Sync Status"::"Not Valid";
        END;
    end;

    [Scope('Internal')]
    procedure GetNepaliFiscalYear(PostingDate: Date): Text[30]
    var
        AccountingPeriod: Record "50";
    begin
        WITH AccountingPeriod DO BEGIN
            SETRANGE("New Fiscal Year", TRUE);
            SETRANGE("Starting Date", 0D, PostingDate);
            IF FINDLAST THEN BEGIN
                VerifyAndSetNepaliFiscalYear(PostingDate);
                EXIT("Nepali Fiscal Year");
            END;
        END;
    end;

    [Scope('Internal')]
    procedure CalculateInvoiceTotals(TableNo: Integer; DocumentNo: Code[20]; var TotalSubTotal: Decimal; var TotalInvDiscAmount: Decimal; var TotalTaxableAmount: Decimal; var TotalAmountVAT: Decimal; var TotalAmountInclVAT: Decimal)
    var
        Currency: Record "4";
        SalesInvHeader: Record "112";
        SalesInvLine: Record "113";
        SalesCrMemoHeader: Record "114";
        SalesCrMemoLine: Record "115";
        ServiceInvoiceHeader: Record "5992";
        ServiceInvoiceLine: Record "5993";
        ServiceCrMemoHeader: Record "5994";
        ServiceCrMemoLine: Record "5995";
    begin
        TotalSubTotal := 0;
        TotalInvDiscAmount := 0;
        TotalTaxableAmount := 0;
        TotalAmountVAT := 0;
        TotalAmountInclVAT := 0;
        CASE TableNo OF
            DATABASE::"Sales Invoice Header":
                BEGIN
                    IF NOT SalesInvHeader.GET(DocumentNo) THEN
                        EXIT;
                    SalesInvLine.RESET;
                    SalesInvLine.SETRANGE("Document No.", SalesInvHeader."No.");
                    IF SalesInvLine.FINDSET THEN
                        REPEAT
                            IF NOT SalesInvLine."Prepayment Line" THEN BEGIN
                                IF SalesInvHeader."Currency Code" = '' THEN
                                    Currency.InitRoundingPrecision
                                ELSE BEGIN
                                    SalesInvHeader.TESTFIELD("Currency Factor");
                                    Currency.GET(SalesInvHeader."Currency Code");
                                    Currency.TESTFIELD("Amount Rounding Precision");
                                END;
                                TotalSubTotal += ROUND(SalesInvLine.Quantity * SalesInvLine."Unit Price", Currency."Amount Rounding Precision");
                                TotalInvDiscAmount += SalesInvLine."Line Discount Amount";
                                TotalInvDiscAmount += SalesInvLine."Inv. Discount Amount";
                                IF SalesInvLine."VAT %" > 0 THEN
                                    TotalTaxableAmount += SalesInvLine.Amount;
                                TotalAmountVAT += SalesInvLine."Amount Including VAT" - SalesInvLine.Amount;
                                TotalAmountInclVAT += SalesInvLine."Amount Including VAT";
                            END;
                        UNTIL SalesInvLine.NEXT = 0;
                END;

            DATABASE::"Service Invoice Header":
                BEGIN
                    IF NOT ServiceInvoiceHeader.GET(DocumentNo) THEN
                        EXIT;
                    ServiceInvoiceLine.RESET;
                    ServiceInvoiceLine.SETRANGE("Document No.", ServiceInvoiceHeader."No.");
                    IF ServiceInvoiceLine.FINDSET THEN
                        REPEAT
                            IF ServiceInvoiceHeader."Currency Code" = '' THEN
                                Currency.InitRoundingPrecision
                            ELSE BEGIN
                                ServiceInvoiceHeader.TESTFIELD("Currency Factor");
                                Currency.GET(ServiceInvoiceHeader."Currency Code");
                                Currency.TESTFIELD("Amount Rounding Precision");
                            END;
                            TotalSubTotal += ROUND(ServiceInvoiceLine.Quantity * ServiceInvoiceLine."Unit Price", Currency."Amount Rounding Precision");
                            TotalInvDiscAmount += ServiceInvoiceLine."Line Discount Amount";
                            TotalInvDiscAmount += ServiceInvoiceLine."Inv. Discount Amount";
                            IF ServiceInvoiceLine."VAT %" > 0 THEN
                                TotalTaxableAmount += ServiceInvoiceLine.Amount;
                            TotalAmountVAT += ServiceInvoiceLine."Amount Including VAT" - ServiceInvoiceLine.Amount;
                            TotalAmountInclVAT += ServiceInvoiceLine."Amount Including VAT";
                        UNTIL ServiceInvoiceLine.NEXT = 0;
                END;

            DATABASE::"Sales Cr.Memo Header":
                BEGIN
                    IF NOT SalesCrMemoHeader.GET(DocumentNo) THEN
                        EXIT;
                    SalesCrMemoLine.RESET;
                    SalesCrMemoLine.SETRANGE("Document No.", SalesCrMemoHeader."No.");
                    IF SalesCrMemoLine.FINDSET THEN
                        REPEAT
                            IF NOT SalesCrMemoLine."Prepayment Line" THEN BEGIN
                                IF SalesCrMemoHeader."Currency Code" = '' THEN
                                    Currency.InitRoundingPrecision
                                ELSE BEGIN
                                    SalesCrMemoHeader.TESTFIELD("Currency Factor");
                                    Currency.GET(SalesCrMemoHeader."Currency Code");
                                    Currency.TESTFIELD("Amount Rounding Precision");
                                END;
                                TotalSubTotal += ROUND(SalesCrMemoLine.Quantity * SalesCrMemoLine."Unit Price", Currency."Amount Rounding Precision");
                                TotalInvDiscAmount += SalesCrMemoLine."Line Discount Amount";
                                TotalInvDiscAmount += SalesCrMemoLine."Inv. Discount Amount";
                                IF SalesCrMemoLine."VAT %" > 0 THEN
                                    TotalTaxableAmount += SalesCrMemoLine.Amount;
                                TotalAmountVAT += SalesCrMemoLine."Amount Including VAT" - SalesCrMemoLine.Amount;
                                TotalAmountInclVAT += SalesCrMemoLine."Amount Including VAT";
                            END;
                        UNTIL SalesCrMemoLine.NEXT = 0;
                END;

            DATABASE::"Service Cr.Memo Header":
                BEGIN
                    IF NOT ServiceCrMemoHeader.GET(DocumentNo) THEN
                        EXIT;
                    ServiceCrMemoLine.RESET;
                    ServiceCrMemoLine.SETRANGE("Document No.", ServiceCrMemoHeader."No.");
                    IF ServiceCrMemoLine.FINDSET THEN
                        REPEAT
                            IF ServiceCrMemoHeader."Currency Code" = '' THEN
                                Currency.InitRoundingPrecision
                            ELSE BEGIN
                                ServiceCrMemoHeader.TESTFIELD("Currency Factor");
                                Currency.GET(ServiceCrMemoHeader."Currency Code");
                                Currency.TESTFIELD("Amount Rounding Precision");
                            END;
                            TotalSubTotal += ROUND(ServiceCrMemoLine.Quantity * ServiceCrMemoLine."Unit Price", Currency."Amount Rounding Precision");
                            TotalInvDiscAmount += ServiceCrMemoLine."Line Discount Amount";
                            TotalInvDiscAmount += ServiceCrMemoLine."Inv. Discount Amount";
                            IF ServiceCrMemoLine."VAT %" > 0 THEN
                                TotalTaxableAmount += ServiceCrMemoLine.Amount;
                            TotalAmountVAT += ServiceCrMemoLine."Amount Including VAT" - ServiceCrMemoLine.Amount;
                            TotalAmountInclVAT += ServiceCrMemoLine."Amount Including VAT";
                        UNTIL ServiceCrMemoLine.NEXT = 0;
                END;

        END;
    end;

    [Scope('Internal')]
    procedure VerifyAndSetNepaliFiscalYear(PostingDate: Date)
    var
        AccountingPeriodPage: Page "100";
        AccountingPeriod: Record "50";
        NoNepaliFiscalYearInfoQst: Label 'No Nepali Fiscal Year is provided in %1. Do you want to update it now?', Comment = '%1 = Company Information';
        NoNepaliFiscalYearInfoMsg: Label 'No Nepali Fiscal Year information is provided in %1. Review the report.';
        UpdateNepaliFiscalYearError: Label 'Please update Nepali Fiscal Year in %1. ';
    begin
        WITH AccountingPeriod DO BEGIN
            SETRANGE("New Fiscal Year", TRUE);
            SETRANGE("Starting Date", 0D, PostingDate);
            IF (FINDLAST) AND ("Nepali Fiscal Year" <> '') THEN
                EXIT;
            ERROR(UpdateNepaliFiscalYearError, TABLECAPTION);
            IF NOT (FINDLAST) AND ("Nepali Fiscal Year" <> '') THEN
                MESSAGE(NoNepaliFiscalYearInfoMsg, TABLECAPTION);
        END;
    end;

    [Scope('Internal')]
    procedure OneLineAddress(var AddrArray: array[8] of Text[50]) OneLineAddress: Text
    var
        i: Integer;
    begin
        //COMPRESSARRAY(AddrArray);  //ZM Agile
        FOR i := 2 TO ARRAYLEN(AddrArray) DO BEGIN
            IF AddrArray[i] <> '' THEN
                IF OneLineAddress = '' THEN
                    OneLineAddress += AddrArray[i]
                ELSE
                    OneLineAddress += ', ' + AddrArray[i];
        END;
        EXIT(OneLineAddress);
    end;

    [Scope('Internal')]
    procedure EnableChangeLog()
    var
        ChangeLogSetup: Record "402";
    begin
        WITH ChangeLogSetup DO BEGIN
            IF NOT GET THEN BEGIN
                INIT;
                "Change Log Activated" := TRUE;
                INSERT;
            END
            ELSE BEGIN
                "Change Log Activated" := TRUE;
                MODIFY;
            END;
        END;
        InsertTableChangeLog(3);
        InsertTableChangeLog(4);
        InsertTableChangeLog(5);
        InsertTableChangeLog(9);
        InsertTableChangeLog(10);
        InsertTableChangeLog(13);
        InsertTableChangeLog(14);
        InsertTableChangeLog(15);
        InsertTableChangeLog(18);
        InsertTableChangeLog(23);
        InsertTableChangeLog(27);
        InsertTableChangeLog(50);
        InsertTableChangeLog(77);
        InsertTableChangeLog(78);
        InsertTableChangeLog(79);
        InsertTableChangeLog(80);
        InsertTableChangeLog(82);
        InsertTableChangeLog(84);
        InsertTableChangeLog(85);
        InsertTableChangeLog(91);
        InsertTableChangeLog(92);
        InsertTableChangeLog(93);
        InsertTableChangeLog(94);
        InsertTableChangeLog(95);
        InsertTableChangeLog(98);
        InsertTableChangeLog(112);
        InsertTableChangeLog(113);
        InsertTableChangeLog(114);
        InsertTableChangeLog(115);
        InsertTableChangeLog(131);
        InsertTableChangeLog(135);
        InsertTableChangeLog(152);
        InsertTableChangeLog(156);
        InsertTableChangeLog(200);
        InsertTableChangeLog(201);
        InsertTableChangeLog(202);
        InsertTableChangeLog(204);
        InsertTableChangeLog(205);
        InsertTableChangeLog(206);
        InsertTableChangeLog(208);
        InsertTableChangeLog(209);
        InsertTableChangeLog(220);
        InsertTableChangeLog(230);
        InsertTableChangeLog(231);
        InsertTableChangeLog(232);
        InsertTableChangeLog(233);
        InsertTableChangeLog(236);
        InsertTableChangeLog(237);
        InsertTableChangeLog(242);
        InsertTableChangeLog(244);
        InsertTableChangeLog(245);
        InsertTableChangeLog(250);
        InsertTableChangeLog(251);
        InsertTableChangeLog(252);
        InsertTableChangeLog(254);
        InsertTableChangeLog(270);
        InsertTableChangeLog(289);
        InsertTableChangeLog(308);
        InsertTableChangeLog(309);
        InsertTableChangeLog(310);
        InsertTableChangeLog(311);
        InsertTableChangeLog(312);
        InsertTableChangeLog(313);
        InsertTableChangeLog(314);
        InsertTableChangeLog(315);
        InsertTableChangeLog(323);
        InsertTableChangeLog(324);
        InsertTableChangeLog(325);
        InsertTableChangeLog(333);
        InsertTableChangeLog(334);
        InsertTableChangeLog(348);
        InsertTableChangeLog(349);
        InsertTableChangeLog(350);
        InsertTableChangeLog(351);
        InsertTableChangeLog(352);
        InsertTableChangeLog(363);
        InsertTableChangeLog(409);
        InsertTableChangeLog(470);
        InsertTableChangeLog(471);
        InsertTableChangeLog(472);
        InsertTableChangeLog(487);
        InsertTableChangeLog(550);
        InsertTableChangeLog(750);
        InsertTableChangeLog(762);
        InsertTableChangeLog(770);
        InsertTableChangeLog(843);
        InsertTableChangeLog(869);
        InsertTableChangeLog(980);
        InsertTableChangeLog(1108);
        InsertTableChangeLog(1112);
        InsertTableChangeLog(1200);
        InsertTableChangeLog(1213);
        InsertTableChangeLog(1261);
        InsertTableChangeLog(1270);
        InsertTableChangeLog(1275);
        InsertTableChangeLog(1501);
        InsertTableChangeLog(1508);
        InsertTableChangeLog(1510);
        InsertTableChangeLog(1512);
        InsertTableChangeLog(5050);
        InsertTableChangeLog(5063);
        InsertTableChangeLog(5064);
        InsertTableChangeLog(5068);
        InsertTableChangeLog(5069);
        InsertTableChangeLog(5070);
        InsertTableChangeLog(5071);
        InsertTableChangeLog(5073);
        InsertTableChangeLog(5079);
        InsertTableChangeLog(5083);
        InsertTableChangeLog(5084);
        InsertTableChangeLog(5105);
        InsertTableChangeLog(5122);
        InsertTableChangeLog(5200);
        InsertTableChangeLog(5202);
        InsertTableChangeLog(5203);
        InsertTableChangeLog(5204);
        InsertTableChangeLog(5205);
        InsertTableChangeLog(5206);
        InsertTableChangeLog(5209);
        InsertTableChangeLog(5210);
        InsertTableChangeLog(5211);
        InsertTableChangeLog(5215);
        InsertTableChangeLog(5216);
        InsertTableChangeLog(5218);
        InsertTableChangeLog(5404);
        InsertTableChangeLog(5600);
        InsertTableChangeLog(5603);
        InsertTableChangeLog(5604);
        InsertTableChangeLog(5605);
        InsertTableChangeLog(5606);
        InsertTableChangeLog(5607);
        InsertTableChangeLog(5608);
        InsertTableChangeLog(5609);
        InsertTableChangeLog(5611);
        InsertTableChangeLog(5612);
        InsertTableChangeLog(5619);
        InsertTableChangeLog(5620);
        InsertTableChangeLog(5622);
        InsertTableChangeLog(5623);
        InsertTableChangeLog(5626);
        InsertTableChangeLog(5628);
        InsertTableChangeLog(5630);
        InsertTableChangeLog(5633);
        InsertTableChangeLog(5634);
        InsertTableChangeLog(5700);
        InsertTableChangeLog(5714);
        InsertTableChangeLog(5715);
        InsertTableChangeLog(5718);
        InsertTableChangeLog(5719);
        InsertTableChangeLog(5722);
        InsertTableChangeLog(5723);
        InsertTableChangeLog(5769);
        InsertTableChangeLog(5813);
        InsertTableChangeLog(5814);
        InsertTableChangeLog(5911);
        InsertTableChangeLog(5915);
        InsertTableChangeLog(5916);
        InsertTableChangeLog(5917);
        InsertTableChangeLog(5918);
        InsertTableChangeLog(5919);
        InsertTableChangeLog(5920);
        InsertTableChangeLog(5921);
        InsertTableChangeLog(5927);
        InsertTableChangeLog(5928);
        InsertTableChangeLog(5929);
        InsertTableChangeLog(5940);
        InsertTableChangeLog(5941);
        InsertTableChangeLog(5945);
        InsertTableChangeLog(5954);
        InsertTableChangeLog(5955);
        InsertTableChangeLog(5956);
        InsertTableChangeLog(5957);
        InsertTableChangeLog(5958);
        InsertTableChangeLog(5966);
        InsertTableChangeLog(5968);
        InsertTableChangeLog(5996);
        InsertTableChangeLog(6080);
        InsertTableChangeLog(6081);
        InsertTableChangeLog(6082);
        InsertTableChangeLog(6502);
        InsertTableChangeLog(6504);
        InsertTableChangeLog(6505);
        InsertTableChangeLog(6635);
        InsertTableChangeLog(7002);
        InsertTableChangeLog(7004);
        InsertTableChangeLog(7012);
        InsertTableChangeLog(7014);
        InsertTableChangeLog(7111);
        InsertTableChangeLog(7112);
        InsertTableChangeLog(7113);
        InsertTableChangeLog(7116);
        InsertTableChangeLog(7152);
        InsertTableChangeLog(7300);
        InsertTableChangeLog(7301);
        InsertTableChangeLog(7302);
        InsertTableChangeLog(7303);
        InsertTableChangeLog(7304);
        InsertTableChangeLog(7305);
        InsertTableChangeLog(7309);
        InsertTableChangeLog(7310);
        InsertTableChangeLog(7326);
        InsertTableChangeLog(7327);
        InsertTableChangeLog(7328);
        InsertTableChangeLog(7335);
        InsertTableChangeLog(7336);
        InsertTableChangeLog(7337);
        InsertTableChangeLog(7338);
        InsertTableChangeLog(7354);
        InsertTableChangeLog(7600);
        InsertTableChangeLog(9000);
        InsertTableChangeLog(9001);
        InsertTableChangeLog(9002);
        InsertTableChangeLog(9003);
        InsertTableChangeLog(9651);
        InsertTableChangeLog(9657);
        InsertTableChangeLog(50000);
        InsertTableChangeLog(50001);
        InsertTableChangeLog(50002);
    end;

    local procedure InsertTableChangeLog(TableID: Integer)
    var
        ChangeLogSetupTable: Record "403";
    begin
        WITH ChangeLogSetupTable DO BEGIN
            IF NOT GET(TableID) THEN BEGIN
                INIT;
                "Table No." := TableID;
                "Log Insertion" := "Log Insertion"::"All Fields";
                "Log Modification" := "Log Modification"::"All Fields";
                "Log Deletion" := "Log Deletion"::"All Fields";
                INSERT;
            END
            ELSE BEGIN
                "Log Insertion" := "Log Insertion"::"All Fields";
                "Log Modification" := "Log Modification"::"All Fields";
                "Log Deletion" := "Log Deletion"::"All Fields";
                MODIFY;
            END;
        END;
    end;

    [Scope('Internal')]
    procedure InitReportSelection()
    var
        ReportSelections: Record "77";
    begin
        WITH ReportSelections DO BEGIN
            InsertRepSelection(Usage::"S.Quote", '1', REPORT::"Sales Quote");
            InsertRepSelection(Usage::"S.Order", '1', REPORT::"Sales Order");
            InsertRepSelection(Usage::"S.Invoice", '1', REPORT::"Sales Invoice");
            InsertRepSelection(Usage::"S.Return", '1', REPORT::"Return Order Confirmation");
            InsertRepSelection(Usage::"S.Cr.Memo", '1', REPORT::"Sales Credit Memo");
            InsertRepSelection(Usage::"S.Shipment", '1', REPORT::"Sales Shipment");
            InsertRepSelection(Usage::"S.Ret.Rcpt.", '1', REPORT::"Sales - Return Receipt");
            InsertRepSelection(Usage::"P.Quote", '1', REPORT::"Purchase - Quote");
            InsertRepSelection(Usage::"P.Order", '1', REPORT::"Purchase Order");
            InsertRepSelection(Usage::"P.Invoice", '1', REPORT::"Purchase Invoice");
            InsertRepSelection(Usage::"P.Return", '1', REPORT::"Return Order");
            InsertRepSelection(Usage::"P.Cr.Memo", '1', REPORT::"Purchase Debit Memo");
            InsertRepSelection(Usage::"P.Receipt", '1', REPORT::"Purchase Receipt");
            InsertRepSelection(Usage::"P.Ret.Shpt.", '1', REPORT::"Purchase - Return Shipment");
            InsertRepSelection(Usage::Inv2, '1', REPORT::"Transfer Shipments");
            InsertRepSelection(Usage::Inv3, '1', REPORT::"Transfer Receipts");
        END;
    end;

    [Scope('Internal')]
    procedure Binding()
    begin
    end;

    local procedure "--Migrated"()
    begin
    end;

    [Scope('Internal')]
    procedure InsertSalesMaterializedView(var SalesHeader: Record "36"; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20])
    var
        SysMgt: Codeunit "50000";
    begin
        WITH SalesHeader DO BEGIN
            IF Invoice THEN BEGIN
                IF "Document Type" IN ["Document Type"::Order, "Document Type"::Invoice] THEN BEGIN
                    CLEAR(SysMgt);
                    SysMgt.InsertRegisterInvoice(DATABASE::"Sales Invoice Header", SalesInvHdrNo);
                END
                ELSE BEGIN
                    CLEAR(SysMgt);
                    SysMgt.InsertRegisterInvoice(DATABASE::"Sales Cr.Memo Header", SalesCrMemoHdrNo);
                END;
            END;
        END;
    end;

    [Scope('Internal')]
    procedure InsertServiceMaterializedView(var ServiceHeader: Record "5900"; ServiceShptHdrNo: Code[20]; ServiceInvHdrNo: Code[20]; ServiceCrMemoHdrNo: Code[20]; Ship: Boolean; Consume: Boolean; Invoice: Boolean; WhseShip: Boolean)
    var
        SysMgt: Codeunit "50000";
    begin
        WITH ServiceHeader DO BEGIN
            IF Invoice THEN BEGIN
                IF "Document Type" IN ["Document Type"::Order, "Document Type"::Invoice] THEN BEGIN
                    CLEAR(SysMgt);
                    SysMgt.InsertRegisterInvoice(DATABASE::"Service Invoice Header", ServiceInvHdrNo);
                END
                ELSE BEGIN
                    CLEAR(SysMgt);
                    SysMgt.InsertRegisterInvoice(DATABASE::"Service Cr.Memo Header", ServiceCrMemoHdrNo);
                END;
            END;
        END;
    end;

    [Scope('Internal')]
    procedure CheckGenJnlLine(var GenJournalLine: Record "81")
    var
        GLAccount: Record "15";
        PurchSetup: Record "312";
        SalesSetup: Record "311";
        CustPostingGrp: Record "92";
        VendPostinggr: Record "93";
        TDSGroup: Record "50004";
    begin
        WITH GenJournalLine DO BEGIN
            IF ("Gen. Posting Type" = "Gen. Posting Type"::Purchase) THEN BEGIN
                PurchSetup.GET;
                IF PurchSetup."Ext. Doc. No. Mandatory" THEN
                    TESTFIELD("External Document No.");
                IF ("Posting Group" <> '') AND VendPostinggr.GET("Posting Group") AND
                   (NOT VendPostinggr."Skip VAT Registration No.") AND ("VAT %" > 0) THEN
                    TESTFIELD("VAT Registration No.");

                TESTFIELD("Localized VAT Identifier");
            END;

            IF ("Line Type" = "Line Type"::Loan) OR ("Bal. Line Type" = "Bal. Line Type"::Loan) THEN
                TESTFIELD("Loan Transaction Type");

            IF "Loan Transaction Type" = "Loan Transaction Type"::"Loan Repayment" THEN
                TESTFIELD("Loan Repayment Line No.");

            IF "Account Type" = "Account Type"::Employee THEN
                TESTFIELD("Employee Transaction Type");

            IF ("Gen. Posting Type" = "Gen. Posting Type"::Sale) THEN BEGIN
                SalesSetup.GET;
                IF SalesSetup."Ext. Doc. No. Mandatory" THEN
                    TESTFIELD("External Document No.");
                TESTFIELD("Localized VAT Identifier");
                IF ("Posting Group" <> '') AND CustPostingGrp.GET("Posting Group") AND
                   (CustPostingGrp."Check VAT Reg. No.") AND ("VAT %" > 0) THEN
                    TESTFIELD("VAT Registration No.");
            END;

            IF ("TDS Group" <> '') AND TDSGroup.GET("TDS Group") AND
               GLAccount.GET(TDSGroup."GL Account No.") AND GLAccount."Document Class Mandatory" THEN BEGIN
                TESTFIELD("Document Class");
                TESTFIELD("Document Subclass");
            END;
        END;
    end;

    [Scope('Internal')]
    procedure CopyOnGLRegister(var GLRegister: Record "45"; var GenJournalLine: Record "81")
    begin
        GLRegister."Creation Time" := TIME;
    end;

    [Scope('Internal')]
    procedure CopyGLEntryFromGenJnlLine(var GLEntry: Record "17"; var GenJnlLine: Record "81")
    var
        ShortcutDimCode: array[8] of Code[20];
        TDSEntry: Record "50006";
    begin
        GLEntry.Narration := GenJnlLine.Narration;
        GLEntry."Localized VAT Identifier" := GenJnlLine."Localized VAT Identifier";
        GLEntry.PragyapanPatra := GenJnlLine.PragyapanPatra;
        GLEntry."Source Name" := GetSourceName(GenJnlLine."Source Type", GenJnlLine."Source No.");
        GLEntry."Loan Transaction Type" := GenJnlLine."Loan Transaction Type";
        GLEntry."Loan Repayment Line No." := GenJnlLine."Loan Repayment Line No.";
        GLEntry."FA Item Charge" := GenJnlLine."FA Item Charge";
        //IME>RD
        GetShortcutDimensionsInfo(GenJnlLine."Dimension Set ID", ShortcutDimCode);
        GLEntry."Shortcut Dimension 3 Code" := ShortcutDimCode[3];//GenJnlLine."Shortcut Dimension 3 Code";
        GLEntry."Shortcut Dimension 4 Code" := ShortcutDimCode[4];//GenJnlLine."Shortcut Dimension 4 Code";
        GLEntry."Shortcut Dimension 5 Code" := ShortcutDimCode[5];//GenJnlLine."Shortcut Dimension 5 Code";
        GLEntry."Shortcut Dimension 6 Code" := ShortcutDimCode[6];//GenJnlLine."Shortcut Dimension 6 Code";
        GLEntry."Shortcut Dimension 7 Code" := ShortcutDimCode[7];//GenJnlLine."Shortcut Dimension 7 Code";
        GLEntry."Shortcut Dimension 8 Code" := ShortcutDimCode[8];//GenJnlLine."Shortcut Dimension 8 Code";
        //IME>RD
        //Agile RD June 24 2016
        GLEntry."TR Loan Code" := GenJnlLine."TR Loan Code";
        //Agile RD June 24 2016
        //SM 16 Jan 2016
        GLEntry."LC Entry Type" := GenJnlLine."LC Entry Type";
        GLEntry."TDS Entry No." := GenJnlLine."TDS Entry No.";
        GLEntry."PDC Entry No." := GenJnlLine."PDC Entry No.";
        //SM 16 Jan 2016
        //TDS1.00
        GLEntry."TDS Group" := GenJnlLine."TDS Group";
        GLEntry."TDS%" := GenJnlLine."TDS%";
        GLEntry."TDS Type" := GenJnlLine."TDS Type";
        GLEntry."TDS Amount" := GenJnlLine."TDS Amount";
        GLEntry."TDS Base Amount" := GenJnlLine."TDS Base Amount";
        GLEntry."Document Class" := GenJnlLine."Document Class";
        GLEntry."Document Subclass" := GenJnlLine."Document Subclass";
        //TDS1.00
        GLEntry."Employee Transaction Type" := GenJnlLine."Employee Transaction Type";
        //IME19.00 Begin
        GLEntry."Sys. LC No." := GenJnlLine."Sys. LC No.";
        GLEntry."Bank LC No." := GenJnlLine."Bank LC No.";
        GLEntry."LC Amend No." := GenJnlLine."LC Amend No.";
        GLEntry."Purchase Consignment No." := GenJnlLine."Purchase Consignment No.";
        //IME19.00 End
    end;

    [Scope('Internal')]
    procedure CopyVATEntryFromGenJnlLine(var Sender: Record "254"; GenJournalLine: Record "81")
    begin
        Sender.PragyapanPatra := GenJournalLine.PragyapanPatra;
        Sender."Localized VAT Identifier" := GenJournalLine."Localized VAT Identifier";
        Sender."Shortcut Dimension 1 Code" := GenJournalLine."Shortcut Dimension 1 Code";
    end;

    [Scope('Internal')]
    procedure CopyItemLedgEntryFromItemJnlLine(var ItemLedgerEntry: Record "32"; var ItemJournalLine: Record "83")
    begin
        ItemLedgerEntry.PragyapanPatra := ItemJournalLine.PragyapanPatra;
        ItemLedgerEntry.MODIFY;
    end;

    [Scope('Internal')]
    procedure CopySalesInvHeaderToSalesLine(var FromSalesLine: Record "37"; SalesInvHeaderNo: Code[20]; SalesInvLineNo: Integer)
    begin
        FromSalesLine."Returned Document No." := SalesInvHeaderNo;
        FromSalesLine."Returned Document Line No." := SalesInvLineNo;
    end;

    [Scope('Internal')]
    procedure CopyGenJnlLineFromInvPostBufferSales(var GenJournalLine: Record "81"; var InvoicePostBuffer: Record "49")
    begin
        GenJournalLine.PragyapanPatra := InvoicePostBuffer.PragyapanPatra;
        GenJournalLine."Localized VAT Identifier" := InvoicePostBuffer."Localized VAT Identifier";
    end;

    [Scope('Internal')]
    procedure CopyGenJnlLineFromInvPostBufferPurchase(var GenJournalLine: Record "81"; var InvoicePostBuffer: Record "49")
    begin
        GenJournalLine.PragyapanPatra := InvoicePostBuffer.PragyapanPatra;
        GenJournalLine."Localized VAT Identifier" := InvoicePostBuffer."Localized VAT Identifier";
        GenJournalLine."FA Item Charge" := InvoicePostBuffer."FA Item Charge";
        //TDS1.00
        GenJournalLine."TDS Group" := InvoicePostBuffer."TDS Group";
        GenJournalLine."TDS%" := InvoicePostBuffer."TDS%";
        GenJournalLine."TDS Type" := InvoicePostBuffer."TDS Type";
        GenJournalLine."TDS Amount" := InvoicePostBuffer."TDS Amount";
        GenJournalLine."TDS Base Amount" := InvoicePostBuffer."TDS Base Amount";
        GenJournalLine."Shortcut Dimension 3 Code" := InvoicePostBuffer."Shortcut Dimension 3 Code";
        GenJournalLine."Shortcut Dimension 4 Code" := InvoicePostBuffer."Shortcut Dimension 4 Code";
        GenJournalLine."Shortcut Dimension 5 Code" := InvoicePostBuffer."Shortcut Dimension 5 Code";
        GenJournalLine."Shortcut Dimension 6 Code" := InvoicePostBuffer."Shortcut Dimension 6 Code";
        GenJournalLine."Shortcut Dimension 7 Code" := InvoicePostBuffer."Shortcut Dimension 7 Code";
        GenJournalLine."Shortcut Dimension 8 Code" := InvoicePostBuffer."Shortcut Dimension 8 Code";
        //TDS1.00
    end;

    [Scope('Internal')]
    procedure CopyInvPostingBufferFromPurchaseHeader(var InvoicePostBuffer: Record "49"; var PurchaseHeader: Record "38")
    begin
        InvoicePostBuffer.PragyapanPatra := PurchaseHeader.PragyapanPatra;
    end;

    [Scope('Internal')]
    procedure CopyInvPostingBufferFromPurchaseLine(var PurchLine: Record "39"; var InvoicePostBuffer: Record "49")
    var
        PurchHdr: Record "38";
    begin
        InvoicePostBuffer."Localized VAT Identifier" := PurchLine."Localized VAT Identifier";
        InvoicePostBuffer."Shortcut Dimension 3 Code" := PurchLine."Shortcut Dimension 3 Code";
        InvoicePostBuffer."Shortcut Dimension 4 Code" := PurchLine."Shortcut Dimension 4 Code";
        InvoicePostBuffer."Shortcut Dimension 5 Code" := PurchLine."Shortcut Dimension 5 Code";
        InvoicePostBuffer."Shortcut Dimension 6 Code" := PurchLine."Shortcut Dimension 6 Code";
        InvoicePostBuffer."Shortcut Dimension 7 Code" := PurchLine."Shortcut Dimension 7 Code";
        InvoicePostBuffer."Shortcut Dimension 8 Code" := PurchLine."Shortcut Dimension 8 Code";
        InvoicePostBuffer."FA Item Charge" := PurchLine."FA Item Charge";
        InvoicePostBuffer.PragyapanPatra := PurchLine.PragyapanPatra;
        IF PurchLine.PragyapanPatra = '' THEN BEGIN
            IF PurchHdr.GET(PurchLine."Document Type", PurchLine."Document No.") THEN
                IF PurchHdr.PragyapanPatra <> '' THEN
                    InvoicePostBuffer.PragyapanPatra := PurchHdr.PragyapanPatra;
        END;
    end;

    [Scope('Internal')]
    procedure CopyInvPostingBufferFromSalesHeader(var InvoicePostBuffer: Record "49"; var SalesHeader: Record "36")
    begin
    end;

    [Scope('Internal')]
    procedure CopyInvPostingBufferFromSalesLine(var SalesLine: Record "37"; var InvoicePostBuffer: Record "49")
    begin
        InvoicePostBuffer."Localized VAT Identifier" := SalesLine."Localized VAT Identifier";
    end;

    [Scope('Internal')]
    procedure GetCustomVATPostingSetupOnJournalLine(var Rec: Record "81"; var xRec: Record "81"; CurrFieldNo: Integer)
    var
        VATPostingSetup: Record "325";
    begin
        IF VATPostingSetup.GET(Rec."VAT Bus. Posting Group", Rec."VAT Prod. Posting Group") THEN
            Rec."Localized VAT Identifier" := VATPostingSetup."Localized VAT Identifier"
        ELSE BEGIN
            Rec."Localized VAT Identifier" := Rec."Localized VAT Identifier"::" ";
            //Rec.MODIFY;
        END;
    end;

    [Scope('Internal')]
    procedure GetCustomVATPostingSetupOnSalesLine(var Rec: Record "37"; var xRec: Record "37"; CurrFieldNo: Integer)
    var
        VATPostingSetup: Record "325";
    begin
        IF VATPostingSetup.GET(Rec."VAT Bus. Posting Group", Rec."VAT Prod. Posting Group") THEN
            Rec."Localized VAT Identifier" := VATPostingSetup."Localized VAT Identifier";
    end;

    [Scope('Internal')]
    procedure GetCustomVATPostingSetupOnPurchLine(var Rec: Record "39"; var xRec: Record "39"; CurrFieldNo: Integer)
    var
        VATPostingSetup: Record "325";
    begin
        IF VATPostingSetup.GET(Rec."VAT Bus. Posting Group", Rec."VAT Prod. Posting Group") THEN
            Rec."Localized VAT Identifier" := VATPostingSetup."Localized VAT Identifier";
    end;

    [Scope('Internal')]
    procedure ModifySalesInvPrintInformation(var SalesInvoiceHeader: Record "112")
    var
        RegisterofInvoiceNoSeries: Record "50001";
        AccountingPeriod: Record "50";
        SysMgt: Codeunit "50000";
        PrintingDate: Date;
        PrintingTime: Time;
    begin
        WITH SalesInvoiceHeader DO BEGIN
            PrintingDate := TODAY;
            PrintingTime := TIME;
            IF "No. Printed" = 1 THEN BEGIN
                "Tax Invoice Printed By" := USERID;
                RegisterofInvoiceNoSeries.RESET;
                RegisterofInvoiceNoSeries.SETRANGE("Table ID", DATABASE::"Sales Invoice Header");
                RegisterofInvoiceNoSeries.SETRANGE("Document Type", RegisterofInvoiceNoSeries."Document Type"::"Sales Invoice");
                RegisterofInvoiceNoSeries.SETRANGE("Bill No", "No.");
                RegisterofInvoiceNoSeries.SETRANGE("Fiscal Year", SysMgt.GetNepaliFiscalYear("Posting Date"));
                IF RegisterofInvoiceNoSeries.FINDFIRST THEN BEGIN
                    RegisterofInvoiceNoSeries."Is Bill Printed" := TRUE;
                    RegisterofInvoiceNoSeries."Printed By" := USERID;
                    RegisterofInvoiceNoSeries."Is Printed" := "No. Printed";
                    RegisterofInvoiceNoSeries."Printed Time" := PrintingTime;
                    RegisterofInvoiceNoSeries.MODIFY;
                END;
            END;
            SysMgt.InsertSalesDocPrintHistory(DATABASE::"Sales Invoice Header", "No.", PrintingDate, PrintingTime);
        END;
    end;

    [Scope('Internal')]
    procedure ModifySalesCrInvPrintInformation(var SalesCrMemoHeader: Record "114")
    var
        RegisterofInvoiceNoSeries: Record "50001";
        AccountingPeriod: Record "50";
        SysMgt: Codeunit "50000";
        PrintingDate: Date;
        PrintingTime: Time;
    begin
        WITH SalesCrMemoHeader DO BEGIN
            PrintingDate := TODAY;
            PrintingTime := TIME;
            IF "No. Printed" = 1 THEN BEGIN
                "Printed By" := USERID;
                RegisterofInvoiceNoSeries.RESET;
                RegisterofInvoiceNoSeries.SETRANGE("Table ID", DATABASE::"Sales Invoice Header");
                RegisterofInvoiceNoSeries.SETRANGE("Document Type", RegisterofInvoiceNoSeries."Document Type"::"Sales Invoice");
                RegisterofInvoiceNoSeries.SETRANGE("Bill No", "No.");
                RegisterofInvoiceNoSeries.SETRANGE("Fiscal Year", SysMgt.GetNepaliFiscalYear("Posting Date"));
                IF RegisterofInvoiceNoSeries.FINDFIRST THEN BEGIN
                    RegisterofInvoiceNoSeries."Is Bill Printed" := TRUE;
                    RegisterofInvoiceNoSeries."Printed By" := USERID;
                    RegisterofInvoiceNoSeries."Is Printed" := "No. Printed";
                    RegisterofInvoiceNoSeries."Printed Time" := PrintingTime;
                    RegisterofInvoiceNoSeries.MODIFY;
                END;
            END;
            SysMgt.InsertSalesDocPrintHistory(DATABASE::"Sales Cr.Memo Header", "No.", PrintingDate, PrintingTime);
        END;
    end;

    [Scope('Internal')]
    procedure OnAfterCopyToSalesLineFromDocuments(var ToSalesLine: Record "37"; FromSalesLine: Record "37")
    begin
        ToSalesLine."Returned Document No." := FromSalesLine."Returned Document No.";
        ToSalesLine."Returned Document Line No." := FromSalesLine."Returned Document Line No.";
    end;

    [Scope('Internal')]
    procedure OnBeforeInsertSalesInvHeader(var Rec: Record "112"; RunTrigger: Boolean)
    begin
        WITH Rec DO BEGIN
            "Posting Time" := TIME;
        END;
    end;

    [Scope('Internal')]
    procedure OnBeforeInsertSalesCrMemoHeader(var Rec: Record "114"; RunTrigger: Boolean)
    begin
        WITH Rec DO BEGIN
            "Posting Time" := TIME;
        END;
    end;

    [Scope('Internal')]
    procedure OnBeforeInsertPurchInvHeader(var Rec: Record "122"; RunTrigger: Boolean)
    begin
        WITH Rec DO BEGIN
            "Posting Time" := TIME;
        END;
    end;

    [Scope('Internal')]
    procedure OnBeforeInsertPurchCrMemoHeader(var Rec: Record "124"; RunTrigger: Boolean)
    begin
        WITH Rec DO BEGIN
            "Posting Time" := TIME;
        END;
    end;

    [Scope('Internal')]
    procedure PrepareSalesFieldsOnInvPostBuffer(var Sender: Record "49"; SalesLine: Record "37")
    begin
        Sender."Localized VAT Identifier" := SalesLine."Localized VAT Identifier";
    end;

    [Scope('Internal')]
    procedure PreparePurchaseFieldsOnInvPostBuffer(var Sender: Record "49"; PurchaseLine: Record "39")
    begin
        Sender."Localized VAT Identifier" := PurchaseLine."Localized VAT Identifier";
        Sender.PragyapanPatra := PurchaseLine.PragyapanPatra;
    end;

    [Scope('Internal')]
    procedure PurchPostRestriction(var Sender: Record "38")
    var
        Vendor: Record "23";
        PurchLine: Record "39";
    begin
        WITH Sender DO BEGIN
            TESTFIELD("Location Code");
            TESTFIELD("Accountability Center");
            IF "Document Type" IN ["Document Type"::"Credit Memo", "Document Type"::"Return Order"] THEN
                IRDMgt.CheckReturnAmtWithInvoiceDocument(DATABASE::"Purchase Header", "No.");

            PurchLine.RESET;
            PurchLine.SETRANGE("Document Type", "Document Type");
            PurchLine.SETRANGE("Document No.", "No.");
            PurchLine.SETFILTER(Quantity, '<>0');
            IF PurchLine.FINDSET THEN
                REPEAT
                    IF PurchLine."Document Type" IN [PurchLine."Document Type"::"Return Order", PurchLine."Document Type"::"Credit Memo"] THEN
                        PurchLine.TESTFIELD("Return Reason Code");
                    PurchLine.TESTFIELD("Localized VAT Identifier");
                    PurchLine.TESTFIELD("Location Code");
                    PurchLine.TESTFIELD("Accountability Center");
                UNTIL PurchLine.NEXT = 0;

        END;
    end;

    [Scope('Internal')]
    procedure SalesPostRestriction(var Sender: Record "36")
    var
        SalesSetup: Record "311";
        SalesLine: Record "37";
        IRDMgt: Codeunit "50000";
        Customer: Record "18";
    begin
        WITH Sender DO BEGIN
            TESTFIELD("Location Code");
            TESTFIELD("Accountability Center");
            TESTFIELD("Shortcut Dimension 1 Code");
            SalesSetup.GET;
            SalesSetup.TESTFIELD("Exact Cost Reversing Mandatory");
            IRDMgt.VerifyAndSetNepaliFiscalYear("Posting Date");

            //check credit limit >>
            Customer.GET("Bill-to Customer No.");
            IF Customer."Credit Limit (LCY)" <> 0 THEN BEGIN
                CALCFIELDS("Amount Including VAT");
                Customer.CALCFIELDS(Balance);
                IF "Amount Including VAT" > (Customer.Balance + Customer."Credit Limit (LCY)") THEN
                    ERROR('Credit Limit Exceeded by %1', ("Amount Including VAT" - (Customer.Balance + Customer."Credit Limit (LCY)")));
            END;
            //check credit limit <<

            SalesLine.RESET;
            SalesLine.SETRANGE("Document Type", "Document Type");
            SalesLine.SETRANGE("Document No.", "No.");
            SalesLine.SETFILTER("No.", '<>%1', '');
            IF SalesLine.FINDSET THEN
                REPEAT
                    IF SalesLine."Document Type" IN [SalesLine."Document Type"::"Return Order", SalesLine."Document Type"::"Credit Memo"] THEN BEGIN
                        SalesLine.TESTFIELD("Return Reason Code");
                        SalesLine.TESTFIELD("Returned Document No.");
                        //SalesLine.TESTFIELD("Returned Document Line No.");
                    END ELSE BEGIN
                        IF SalesLine."Free Item Line" AND (SalesLine."Sales Line No." = 0) THEN
                            ERROR('Free Item %1 is not linked with original sales line %2', SalesLine."No.", SalesLine."No.");
                    END;
                    SalesLine.TESTFIELD("Localized VAT Identifier");
                    SalesLine.TESTFIELD("Location Code");
                    SalesLine.TESTFIELD("Accountability Center");
                    /*IF NOT SalesLine."Free Item Line" THEN
                      SalesLine.TESTFIELD("Line Amount");*/
                    SalesLine.TESTFIELD(Quantity);


                UNTIL SalesLine.NEXT = 0;
        END;

    end;

    [Scope('Internal')]
    procedure UpdatePurchLinesFCallFromPurchHeader(var Sender: Record "38"; ChangedFieldName: Text[100]; var PurchaseLine: Record "39")
    begin
        CASE ChangedFieldName OF
            Sender.FIELDCAPTION(PragyapanPatra):
                IF (PurchaseLine."No." <> '') AND (PurchaseLine."Qty. to Invoice" > 0) THEN
                    PurchaseLine.VALIDATE(PragyapanPatra, Sender.PragyapanPatra);
        END;
    end;

    [Scope('Internal')]
    procedure UpdatePurchLineOnField6Validation(var Rec: Record "39"; var xRec: Record "39"; CurrFieldNo: Integer)
    var
        PurchaseHeader: Record "38";
    begin
        WITH Rec DO BEGIN
            IF PurchaseHeader.GET("Document Type", "Document No.") THEN BEGIN
                PragyapanPatra := PurchaseHeader.PragyapanPatra;
            END;
        END;
    end;

    [Scope('Internal')]
    procedure CopyPurchInvHeaderToPurchLine(var FromPurchLine: Record "39"; PurchInvHeaderNo: Code[20]; PuchInvLineNo: Integer)
    begin
        FromPurchLine."Returned Document No." := PurchInvHeaderNo;
        FromPurchLine."Returned Document Line No." := PuchInvLineNo;
    end;

    [Scope('Internal')]
    procedure OnAfterCopyToPurchaseLineFromDocuments(var ToPurchLine: Record "39"; FromPurchLine: Record "39")
    begin
        ToPurchLine."Returned Document No." := FromPurchLine."Returned Document No.";
        ToPurchLine."Returned Document Line No." := FromPurchLine."Returned Document Line No.";
    end;

    [Scope('Internal')]
    procedure CheckReturnAmtQtyEditable(): Boolean
    begin
        GeneralLedgSetup.GET;
        EXIT(NOT GeneralLedgSetup."Exact Invoice Amount Mandatory");
    end;

    [Scope('Internal')]
    procedure CheckReturnAmtWithInvoiceDocument(TableID: Integer; DocumentNo: Code[20])
    var
        PurchHdr: Record "38";
        PurchLine: Record "39";
        PurchInvHdr: Record "122";
        SalesHdr: Record "36";
        SalesLine: Record "37";
        SalesInvHdr: Record "112";
        Text001: Label 'Total Amount of this doucment must be same as of the Invoice Document %1';
        ServiceHdr: Record "5900";
        ServiceLine: Record "5902";
        ServiceInvHdr: Record "5992";
        ServIncAmt: Decimal;
    begin
        GeneralLedgSetup.GET;
        IF NOT GeneralLedgSetup."Exact Invoice Amount Mandatory" THEN
            EXIT;
        CASE TableID OF
            DATABASE::"Purchase Header":
                BEGIN
                    PurchHdr.RESET;
                    PurchHdr.SETRANGE("No.", DocumentNo);
                    IF PurchHdr.FINDFIRST THEN BEGIN
                        PurchLine.RESET;
                        PurchLine.SETRANGE("Document No.", PurchHdr."No.");
                        PurchLine.SETFILTER("Returned Document No.", '<>%1', '');
                        IF PurchLine.FINDFIRST THEN BEGIN
                            PurchInvHdr.RESET;
                            PurchInvHdr.SETRANGE("No.", PurchLine."Returned Document No.");
                            IF PurchInvHdr.FINDFIRST THEN BEGIN
                                PurchInvHdr.CALCFIELDS(Amount);
                                PurchInvHdr.CALCFIELDS("Amount Including VAT");
                                PurchHdr.CALCFIELDS(Amount);
                                PurchHdr.CALCFIELDS("Amount Including VAT");
                                IF (ABS(PurchInvHdr.Amount - PurchHdr.Amount) > GeneralLedgSetup."Return Tolerance")
                                      OR (ABS(PurchInvHdr."Amount Including VAT" - PurchHdr."Amount Including VAT") > GeneralLedgSetup."Return Tolerance") THEN
                                    ERROR(Text001, PurchLine."Returned Document No.");
                            END;
                        END;
                    END;
                END;

            DATABASE::"Sales Header":
                BEGIN
                    SalesHdr.RESET;
                    SalesHdr.SETRANGE("No.", DocumentNo);
                    IF SalesHdr.FINDFIRST THEN BEGIN
                        SalesLine.RESET;
                        SalesLine.SETRANGE("Document No.", SalesHdr."No.");
                        SalesLine.SETFILTER("Returned Document No.", '<>%1', '');
                        IF SalesLine.FINDFIRST THEN BEGIN
                            SalesInvHdr.RESET;
                            SalesInvHdr.SETRANGE("No.", SalesLine."Returned Document No.");
                            IF SalesInvHdr.FINDFIRST THEN BEGIN
                                SalesInvHdr.CALCFIELDS(Amount);
                                SalesInvHdr.CALCFIELDS("Amount Including VAT");
                                SalesHdr.CALCFIELDS(Amount);
                                SalesHdr.CALCFIELDS("Amount Including VAT");
                                IF (ABS(SalesInvHdr.Amount - SalesHdr.Amount) > GeneralLedgSetup."Return Tolerance")
                                    OR (ABS(SalesInvHdr."Amount Including VAT" - SalesHdr."Amount Including VAT") > GeneralLedgSetup."Return Tolerance") THEN
                                    ERROR(Text001, SalesLine."Returned Document No.");
                            END;
                        END;
                    END;
                END;
        END;
    end;

    [Scope('Internal')]
    procedure GetShortcutDimensionsInfo(DimSetID: Integer; var ShortcutDimCode: array[8] of Code[20])
    var
        DimMgt: Codeunit "408";
        GLSetup: Record "98";
        i: Integer;
        GLSetupShortcutDimCode: array[8] of Code[20];
        DimSetEntry: Record "480";
    begin
        GLSetup.GET;
        GLSetupShortcutDimCode[1] := GLSetup."Shortcut Dimension 1 Code";
        GLSetupShortcutDimCode[2] := GLSetup."Shortcut Dimension 2 Code";
        GLSetupShortcutDimCode[3] := GLSetup."Shortcut Dimension 3 Code";
        GLSetupShortcutDimCode[4] := GLSetup."Shortcut Dimension 4 Code";
        GLSetupShortcutDimCode[5] := GLSetup."Shortcut Dimension 5 Code";
        GLSetupShortcutDimCode[6] := GLSetup."Shortcut Dimension 6 Code";
        GLSetupShortcutDimCode[7] := GLSetup."Shortcut Dimension 7 Code";
        GLSetupShortcutDimCode[8] := GLSetup."Shortcut Dimension 8 Code";

        CLEAR(ShortcutDimCode);
        FOR i := 1 TO 8 DO BEGIN
            ShortcutDimCode[i] := '';
            IF GLSetupShortcutDimCode[i] <> '' THEN BEGIN
                IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[i]) THEN BEGIN
                    ShortcutDimCode[i] := DimSetEntry."Dimension Value Code";
                END;
            END;
        END;
    end;

    [Scope('Internal')]
    procedure GetSourceName(SourceType: Option " ",Customer,Vendor,"Bank Account","Fixed Asset",Employee; SourceNo: Text): Text[50]
    var
        Customer: Record "18";
        Vendor: Record "23";
        BankAccount: Record "270";
        FixedAsset: Record "5600";
        Employee: Record "5200";
    begin
        //SRT August 13th 2019
        IF SourceType = SourceType::Customer THEN BEGIN
            IF Customer.GET(SourceNo) THEN
                EXIT(Customer.Name);
        END ELSE
            IF SourceType = SourceType::Vendor THEN BEGIN
                IF Vendor.GET(SourceNo) THEN
                    EXIT(Vendor.Name);
            END ELSE
                IF SourceType = SourceType::"Bank Account" THEN BEGIN
                    IF BankAccount.GET(SourceNo) THEN
                        EXIT(BankAccount.Name);
                END ELSE
                    IF SourceType = SourceType::"Fixed Asset" THEN BEGIN
                        IF FixedAsset.GET(SourceNo) THEN
                            EXIT(FixedAsset.Description);
                    END ELSE
                        IF SourceType = SourceType::Employee THEN BEGIN
                            IF Employee.GET(SourceNo) THEN
                                EXIT(Employee.FullName);
                        END;
    end;

    [Scope('Internal')]
    procedure AssignLotNoToPerAssemblyHeaderQtyToAssemble(AssemblyHeader: Record "900"; LotNo: Code[20]; AvailableQty: Decimal)
    var
        CreateReservEntry: Codeunit "99000830";
        ReservationEntry: Record "337";
        ReservationMgt: Codeunit "99000845";
        QtyAlreadyAssigned: Decimal;
        recReservEntry: Record "337";
        Item: Record "27";
    begin
        WITH AssemblyHeader DO BEGIN
            LotNo := "Batch No.";
            TESTFIELD("Item No.");
            TESTFIELD("Manufacturing Date");
            TESTFIELD("Expiry Date");
            TESTFIELD("Batch No.");
            Item.GET("Item No.");
            IF (LotNo <> '') AND (Item."Item Tracking Code" <> '') THEN BEGIN
                recReservEntry.RESET;
                recReservEntry.LOCKTABLE;
                recReservEntry.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name",
                 "Source Prod. Order Line", "Reservation Status");

                recReservEntry.SETRANGE("Source ID", "No.");
                recReservEntry.SETRANGE("Source Ref. No.", 0);
                recReservEntry.SETRANGE("Source Type", DATABASE::"Assembly Header");
                recReservEntry.SETRANGE("Source Subtype", "Document Type");
                recReservEntry.SETRANGE("Source Batch Name", '');
                recReservEntry.SETRANGE("Source Prod. Order Line", 0);
                recReservEntry.SETRANGE("Reservation Status", recReservEntry."Reservation Status"::Surplus);
                recReservEntry.DELETEALL;

                //create lot
                CreateReservEntry.SetManufacturingDate("Manufacturing Date");
                CreateReservEntry.SetDates(0D, "Expiry Date");
                CreateReservEntry.CreateReservEntryFor(DATABASE::"Assembly Header", "Document Type", "No.", '', 0, 0,
                "Qty. per Unit of Measure",
                Quantity, "Quantity to Assemble", '', LotNo);

                CreateReservEntry.CreateEntry("Item No.", "Variant Code", "Location Code", '', 0D, "Posting Date", 0, 2);
            END;
        END;
    end;

    [Scope('Internal')]
    procedure AssignLotNoToPerTransferLine(TransferLine: Record "5741"; LotNo: Code[20]; AvailableQty: Decimal)
    var
        CreateReservEntry: Codeunit "99000830";
        ReservationEntry: Record "337";
        ReservationMgt: Codeunit "99000845";
        TransferHeader: Record "5740";
    begin
        WITH TransferLine DO BEGIN
            IF LotNo <> '' THEN BEGIN
                TransferHeader.GET("Document No.");
                CreateReservEntry.SetManufacturingDate(TransferHeader."Manufacturing Date");
                CreateReservEntry.SetDates(0D, TransferHeader."Expiy Date");
                CreateReservEntry.CreateReservEntryFor(DATABASE::"Transfer Line", 0, "Document No.", '', 0, "Line No.", "Qty. per Unit of Measure",
                AvailableQty, AvailableQty, '', LotNo);
                CreateReservEntry.CreateEntry("Item No.", "Variant Code", "Transfer-from Code", '', 0D, "Shipment Date", 0, 2);

                CreateReservEntry.CreateReservEntryFor(DATABASE::"Transfer Line", 1, "Document No.", '', 0, "Line No.", "Qty. per Unit of Measure",
                AvailableQty, AvailableQty, '', LotNo);
                CreateReservEntry.CreateEntry("Item No.", "Variant Code", "Transfer-to Code", '', "Receipt Date", 0D, 0, 2);
            END;
        END;
    end;

    [Scope('Internal')]
    procedure AssignLotNoToPerSalesLine(SalesLine: Record "37"; LotNo: Code[20]; AvailableQty: Decimal)
    var
        CreateReservEntry: Codeunit "99000830";
        ReservationEntry: Record "337";
        ReservationMgt: Codeunit "99000845";
        SalesHeader: Record "37";
        recReservEntry: Record "337";
        Item: Record "27";
        LotInfo: Record "6505";
    begin
        WITH SalesLine DO BEGIN
            IF Type <> Type::Item THEN
                EXIT;
            Item.GET("No.");

            IF LotNo = '' THEN
                EXIT;
            IF SalesLine."Document Type" = SalesLine."Document Type"::Order THEN
                IF NOT LotInfo.GET(SalesLine."No.", SalesLine."Variant Code", SalesLine."Batch No.") THEN
                    EXIT;

            IF (LotNo <> '') AND (Item."Item Tracking Code" <> '') THEN BEGIN
                TESTFIELD("Document No.");
                TESTFIELD("Line No.");
                //TESTFIELD("Batch No.");

                recReservEntry.RESET;
                recReservEntry.LOCKTABLE;
                recReservEntry.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name",
                 "Source Prod. Order Line", "Reservation Status");

                recReservEntry.SETRANGE("Source ID", "Document No.");
                recReservEntry.SETRANGE("Source Ref. No.", "Line No.");
                recReservEntry.SETRANGE("Source Type", DATABASE::"Sales Line");
                recReservEntry.SETRANGE("Source Subtype", "Document Type");
                recReservEntry.SETRANGE("Source Batch Name", '');
                recReservEntry.SETRANGE("Source Prod. Order Line", 0);
                recReservEntry.SETRANGE("Reservation Status", recReservEntry."Reservation Status"::Surplus);
                recReservEntry.DELETEALL;

                //create lot no for batch
                CreateReservEntry.SetManufacturingDate(SalesLine."Manufacturing Date");
                CreateReservEntry.SetDates(0D, SalesLine."Expiry Date");
                CreateReservEntry.CreateReservEntryFor(DATABASE::"Sales Line", "Document Type", "Document No.", '', 0, "Line No.", "Qty. per Unit of Measure",
                AvailableQty, AvailableQty, '', LotNo);
                CreateReservEntry.CreateEntry("No.", "Variant Code", "Location Code", '', 0D, "Shipment Date", 0, 2);
            END;
        END;
    end;

    [Scope('Internal')]
    procedure AssignLotNoToPerItemJnlLine(ItemJnlLine: Record "83"; LotNo: Code[20]; AvailableQty: Decimal)
    var
        CreateReservEntry: Codeunit "99000830";
        ReservationEntry: Record "337";
        ReservationMgt: Codeunit "99000845";
        recReservEntry: Record "337";
        Item: Record "27";
        tcDMS001: Label 'Lot Generated Entry for Batch';
    begin
        WITH ItemJnlLine DO BEGIN
            Item.GET("Item No.");
            IF (LotNo <> '') AND (Item."Item Tracking Code" <> '') THEN BEGIN
                ItemJnlLine.TESTFIELD("Document No.");
                ItemJnlLine.TESTFIELD("Line No.");
                ItemJnlLine.TESTFIELD("Item No.");
                ItemJnlLine.TESTFIELD("Batch No.");
                ItemJnlLine.TESTFIELD("Expiy Date");
                //ItemJnlLine.TESTFIELD("Manufacturing Date");

                recReservEntry.RESET;
                recReservEntry.LOCKTABLE;
                recReservEntry.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name",
                  "Source Prod. Order Line", "Reservation Status");

                recReservEntry.SETRANGE("Source ID", ItemJnlLine."Journal Template Name");
                recReservEntry.SETRANGE("Source Ref. No.", ItemJnlLine."Line No.");
                recReservEntry.SETRANGE("Source Type", DATABASE::"Item Journal Line");
                recReservEntry.SETRANGE("Source Subtype", 2);//!!
                recReservEntry.SETRANGE("Source Batch Name", ItemJnlLine."Journal Batch Name");
                recReservEntry.SETRANGE("Source Prod. Order Line", 0);
                recReservEntry.SETRANGE("Reservation Status", recReservEntry."Reservation Status"::Prospect);
                recReservEntry.DELETEALL;

                recReservEntry.RESET;
                recReservEntry.LOCKTABLE;
                intNewEntryNo := fGetLastEntryNo(recReservEntry) + 1;
                recReservEntry.INIT;
                recReservEntry."Entry No." := intNewEntryNo;
                recReservEntry.Positive := TRUE;
                recReservEntry."Item No." := ItemJnlLine."Item No.";
                recReservEntry."Location Code" := ItemJnlLine."Location Code";

                IF (ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Sale)
                  OR (ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::"Negative Adjmt.") THEN BEGIN
                    recReservEntry."Quantity (Base)" := -AvailableQty;
                    recReservEntry.Quantity := -AvailableQty;
                    recReservEntry."Qty. to Handle (Base)" := -AvailableQty;
                    recReservEntry."Qty. to Invoice (Base)" := -AvailableQty;
                    recReservEntry.Positive := FALSE;
                END
                ELSE //positive adjustment, purchase
                 BEGIN
                    recReservEntry."Quantity (Base)" := AvailableQty;
                    recReservEntry.Quantity := AvailableQty;
                    recReservEntry."Qty. to Handle (Base)" := AvailableQty;
                    recReservEntry."Qty. to Invoice (Base)" := AvailableQty;
                    recReservEntry."Quantity Invoiced (Base)" := AvailableQty;
                END;

                recReservEntry."Reservation Status" := recReservEntry."Reservation Status"::Prospect;
                recReservEntry.Description := tcDMS001;
                recReservEntry."Creation Date" := WORKDATE;
                recReservEntry."Transferred from Entry No." := 0;
                recReservEntry."Source Type" := DATABASE::"Item Journal Line";
                IF ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::"Positive Adjmt." THEN
                    recReservEntry."Source Subtype" := 2  //!!!
                ELSE
                    IF ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::"Negative Adjmt." THEN
                        recReservEntry."Source Subtype" := 3;

                recReservEntry."Source ID" := ItemJnlLine."Journal Template Name";
                recReservEntry."Source Batch Name" := ItemJnlLine."Journal Batch Name";
                recReservEntry."Source Prod. Order Line" := 0;
                recReservEntry."Source Ref. No." := ItemJnlLine."Line No.";
                recReservEntry."Appl.-to Item Entry" := 0;
                recReservEntry."Expected Receipt Date" := WORKDATE;
                recReservEntry."Shipment Date" := 0D;
                //recReservEntry."Serial No." := ItemJnlLine."Service Item No.";
                recReservEntry."Serial No." := '';
                recReservEntry."Created By" := USERID;
                recReservEntry."Changed By" := '';
                recReservEntry."Qty. per Unit of Measure" := ItemJnlLine."Qty. per Unit of Measure";
                recReservEntry.Binding := 0;
                recReservEntry."Suppressed Action Msg." := FALSE;
                recReservEntry."Planning Flexibility" := recReservEntry."Planning Flexibility"::Unlimited;
                recReservEntry."Warranty Date" := 0D;
                recReservEntry."Expiration Date" := "Expiy Date";
                recReservEntry."Manufacturing Date" := "Manufacturing Date";
                //recReservEntry."Reserved Pick & Ship Qty." := 0;
                recReservEntry."New Serial No." := '';
                recReservEntry."New Lot No." := '';
                //recReservEntry."Lot No." := '';
                recReservEntry."Lot No." := "Batch No.";
                recReservEntry."Variant Code" := ItemJnlLine."Variant Code";
                recReservEntry.Correction := FALSE;
                recReservEntry."Action Message Adjustment" := 0;
                recReservEntry."Shipment Date" := ItemJnlLine."Posting Date";
                recReservEntry.INSERT;
            END;
        END;
    end;

    [Scope('Internal')]
    procedure fGetLastEntryNo(var recReservEntry: Record "337"): Integer
    begin
        //VSN1.00
        recReservEntry.RESET;
        IF recReservEntry.FINDLAST THEN
            EXIT(recReservEntry."Entry No.")
        //VSN1.00
    end;

    [Scope('Internal')]
    procedure GetExpiryDateInText(EngDate: Date): Text
    begin
        IF EngDate = 0D THEN
            EXIT('');

        IF STRLEN(FORMAT(getEnglishMonth(EngDate))) = 1 THEN
            EXIT('0' + FORMAT(getEnglishMonth(EngDate)) + '/' + FORMAT(getEnglishYear(EngDate)))
        ELSE
            EXIT(FORMAT(getEnglishMonth(EngDate)) + '/' + FORMAT(getEnglishYear(EngDate)));
    end;
}

