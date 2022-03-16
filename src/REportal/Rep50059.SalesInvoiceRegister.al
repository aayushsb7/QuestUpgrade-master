report 50059 "Sales Invoice Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SalesInvoiceRegister.rdlc';

    dataset
    {
        dataitem(DataItem1; Table50001)
        {
            DataItemTableView = WHERE (Document Type=CONST(Sales Invoice));
            RequestFilterFields = "Bill Date";
            column(CompanyName; CompayInfo.Name)
            {
            }
            column(CompanyPicture; CompayInfo.Picture)
            {
            }
            column(OneLineAddress; OneLineAddress)
            {
            }
            column(OneLineCommunAddress; OneLineCommunAddress)
            {
            }
            column(BillNo_InvoiceMaterializeView; "Invoice Materialize View"."Bill No")
            {
            }
            column(VATRegistrationNo_InvoiceMaterializeView; "Invoice Materialize View"."VAT Registration No.")
            {
            }
            column(Amount_InvoiceMaterializeView; "Invoice Materialize View".Amount)
            {
            }
            column(Discount_InvoiceMaterializeView; "Invoice Materialize View".Discount)
            {
            }
            column(TotalAmount_InvoiceMaterializeView; "Invoice Materialize View"."Total Amount")
            {
            }
            column(CustomerCode_InvoiceMaterializeView; "Invoice Materialize View"."Customer Code")
            {
            }
            column(CustomerName_InvoiceMaterializeView; "Invoice Materialize View"."Customer Name")
            {
            }
            column(TotalQuantity; TotalQuantity)
            {
            }
            column(ProductDiscount; ProductDiscount)
            {
            }
            column(Discount; Discount)
            {
            }
            column(Vat; Vat)
            {
            }
            column(OtherDisc; OtherDisc)
            {
            }
            column(FinencialYear; FinencialYear)
            {
            }
            column(NetAmount; NetAmount)
            {
            }
            column(PeriodFilter; PeriodFilter)
            {
            }
            column(PeriodFilterNepali; PeriodFilterNepali)
            {
            }

            trigger OnAfterGetRecord()
            begin
                TotalQuantity := 0;
                Discount := 0;
                Vat := 0;
                ProductDiscount := 0;
                NetAmount := 0;
                SalesInvLine.RESET;
                SalesInvLine.SETRANGE("Document No.", "Invoice Materialize View"."Bill No");
                IF SalesInvLine.FINDFIRST THEN
                    REPEAT
                        TotalQuantity += SalesInvLine.Quantity;
                        ProductDiscount += SalesInvLine."Line Discount Amount";
                    UNTIL SalesInvLine.NEXT = 0;

                Vat := "Invoice Materialize View"."TAX Amount";
                Discount := "Invoice Materialize View".Discount;
                NetAmount := "Invoice Materialize View".Amount + Discount + Vat + ProductDiscount + OtherDisc;
            end;

            trigger OnPreDataItem()
            begin
                /*IF PeriodFilter = '' THEN BEGIN
                  "Invoice Materialize View".SETRANGE("Fiscal Year",FiscalYear);
                  GlSetup.GET;
                  PeriodFilter := FORMAT(GlSetup."Allow Posting From") + ' to ' + FORMAT(TODAY);
                  END;*/

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        FiscalYearStart: Date;
    begin
        CompayInfo.GET;
        CompayInfo.CALCFIELDS(Picture);
        OneLineAddress := GetOneLineAddr(CompayInfo);
        OneLineCommunAddress := GetOnlineCommnAddr(CompayInfo);
        PeriodFilter := "Invoice Materialize View".GETFILTER("Bill Date");

        DateFrom := "Invoice Materialize View".GETRANGEMIN("Bill Date");
        DateTo := "Invoice Materialize View".GETRANGEMAX("Bill Date");

        IF (DateFrom = DateTo) OR (DateFrom = 0D) OR (DateTo = 0D) THEN
            ERROR('Enter the valide Bill Date');

        EnglishToNepaliDate.RESET;
        EnglishToNepaliDate.SETRANGE("English Date", DateFrom);
        IF EnglishToNepaliDate.FINDFIRST THEN
            PeriodFilterNepali := FORMAT(EnglishToNepaliDate."Nepali Date") + ' to ';

        CLEAR(EnglishToNepaliDate);
        EnglishToNepaliDate.RESET;
        EnglishToNepaliDate.SETRANGE("English Date", DateTo);
        IF EnglishToNepaliDate.FINDFIRST THEN
            PeriodFilterNepali += FORMAT(EnglishToNepaliDate."Nepali Date");


        GlSetup.GET;
        CLEAR(EnglishToNepaliDate);
        EnglishToNepaliDate.RESET;
        EnglishToNepaliDate.SETRANGE("English Date", DateFrom);
        IF EnglishToNepaliDate.FINDFIRST THEN
            FiscalYear := EnglishToNepaliDate."Fiscal Year";

        CLEAR(EnglishToNepaliDate);
        EnglishToNepaliDate.RESET;
        EnglishToNepaliDate.SETRANGE("Fiscal Year", FiscalYear);
        EnglishToNepaliDate.SETRANGE("Opening Fiscal Year", TRUE);
        IF EnglishToNepaliDate.FINDFIRST THEN BEGIN
            FinencialYear := FORMAT(EnglishToNepaliDate."Nepali Date") + ' to ';
            FiscalYearStart := EnglishToNepaliDate."English Date";
        END;

        CLEAR(EnglishToNepaliDate);
        EnglishToNepaliDate.RESET;
        EnglishToNepaliDate.SETRANGE("Closing Fiscal Year", TRUE);
        EnglishToNepaliDate.SETRANGE("Fiscal Year", FiscalYear);
        IF EnglishToNepaliDate.FINDFIRST THEN
            FinencialYear += FORMAT(EnglishToNepaliDate."Nepali Date");
        /*FOR i:= 1 TO 2 DO BEGIN
          CASE i OF
            1:
              BEGIN
              EnglishToNepaliDate.SETRANGE("Opening Fiscal Year",TRUE);
              IF EnglishToNepaliDate.FINDFIRST THEN BEGIN
                FinencialYear += FORMAT(EnglishToNepaliDate."Nepali Date") + ' to ';
                FiscalYearStart := EnglishToNepaliDate."English Date";
                END;
                END;
             2:
              BEGIN
              EnglishToNepaliDate.SETRANGE("Closing Fiscal Year",TRUE);
              IF EnglishToNepaliDate.FINDFIRST THEN
                FinencialYear += FORMAT(EnglishToNepaliDate."Nepali Date");
              END;
            END;
        END;*/

    end;

    var
        CompayInfo: Record "79";
        OneLineAddress: Text;
        OneLineCommunAddress: Text;
        TotalQuantity: Decimal;
        ProductDiscount: Decimal;
        Discount: Decimal;
        Vat: Decimal;
        OtherDisc: Decimal;
        SalesInvLine: Record "113";
        FinencialYear: Text;
        NetAmount: Decimal;
        PeriodFilterNepali: Text;
        EnglishToNepaliDate: Record "50000";
        FiscalYear: Code[10];
        GlSetup: Record "98";
        i: Integer;
        DateFrom: Date;
        DateTo: Date;
        PeriodFilter: Text;

    local procedure GetOneLineAddr(Company: Record "79"): Text
    var
        Address: Text;
    begin
        Company.GET;
        IF Company.Address <> '' THEN
            Address := Company.Address + Company."Address 2";

        EXIT(Address);
    end;

    local procedure GetOnlineCommnAddr(Company: Record "79"): Text
    var
        AddrCommunication: Text;
    begin
        Company.GET;
        IF Company."Phone No." <> '' THEN
            AddrCommunication := 'Phone no : ' + Company."Phone No.";
        IF Company."E-Mail" <> '' THEN
            IF AddrCommunication = '' THEN
                AddrCommunication := 'E-Mail' + Company."E-Mail"
            ELSE
                AddrCommunication += 'E-Mail' + Company."E-Mail";

        EXIT(AddrCommunication);
    end;
}

