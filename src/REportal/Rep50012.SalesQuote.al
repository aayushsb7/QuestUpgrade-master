report 50012 "Sales Quote"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SalesQuote.rdlc';
    Caption = 'Sales Quote';
    PreviewMode = Normal;

    dataset
    {
        dataitem(DataItem6640; Table36)
        {
            DataItemTableView = SORTING (Document Type, No.)
                                WHERE (Document Type=CONST(Quote));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Quote';
            column(DocType_SalesHeader; "Document Type")
            {
            }
            column(No_SalesHeader; "No.")
            {
            }
            column(DocumentProfile; "Document Profile")
            {
            }
            column(SalesLineVATIdentifierCaption; SalesLineVATIdentifierCaptionLbl)
            {
            }
            column(PaymentTermsDescriptionCaption; PaymentTermsDescriptionCaptionLbl)
            {
            }
            column(ShipmentMethodDescriptionCaption; ShipmentMethodDescriptionCaptionLbl)
            {
            }
            column(CompanyInfoHomePageCaption; CompanyInfoHomePageCaptionLbl)
            {
            }
            column(CompanyInfoEmailCaption; CompanyInfoEmailCaptionLbl)
            {
            }
            column(DocumentDateCaption; DocumentDateCaptionLbl)
            {
            }
            column(SalesLineAllowInvoiceDiscCaption; SalesLineAllowInvoiceDiscCaptionLbl)
            {
            }
            column(CompanyInfo2Picture; CompanyInfo2.Picture)
            {
            }
            column(CompanyInfo3Picture; CompanyInfo3.Picture)
            {
            }
            column(CompanyInfo1Picture; CompanyInfo1.Picture)
            {
            }
            column(CompanyInfoHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfoVATRegNo; CompanyInfo.FIELDCAPTION("VAT Registration No.") + ' : ' + CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
            {
            }
            column(CompanyInfoBankName; CompanyInfo."Bank Name")
            {
            }
            column(CompanyInfoBankAccountNo; CompanyInfo."Bank Account No.")
            {
            }
            column(NP151001_1; "--NP15.1001")
            {
            }
            column(CompanyOneLineAddress; CompanyOneLineAddress)
            {
            }
            column(CompanyCommunicationAddress; CompanyCommunicationAddress)
            {
            }
            column(CustomerOneLineAddress; CustomerOneLineAddress)
            {
            }
            column(Cust_Phone_No_; Cust."Phone No.")
            {
            }
            column(InvoiceDate; FORMAT("Document Date") + '  ( ' + SystemManagement.getNepaliDate("Posting Date") + ' )')
            {
            }
            dataitem(CopyLoop; Table2000000026)
            {
                DataItemTableView = SORTING (Number);
                dataitem(PageLoop; Table2000000026)
                {
                    DataItemTableView = SORTING (Number)
                                        WHERE (Number = CONST (1));
                    column(PaymentTermsDescription; PaymentTerms.Description)
                    {
                    }
                    column(ShipmentMethodDescription; ShipmentMethod.Description)
                    {
                    }
                    column(SalesCopyText; STRSUBSTNO(Text004, CopyText))
                    {
                    }
                    column(CustAddr1; CustAddr[1])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(CustAddr2; CustAddr[2])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CustAddr3; CustAddr[3])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CustAddr4; CustAddr[4])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CustAddr5; CustAddr[5])
                    {
                    }
                    column(CompanyInfoEmail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CustAddr6; CustAddr[6])
                    {
                    }
                    column(BilltoCustNo_SalesHeader; "Sales Header"."Bill-to Customer No.")
                    {
                    }
                    column(DocDate_SalesHeader; FORMAT("Sales Header"."Document Date", 0, 4))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_SalesHeader; "Sales Header"."VAT Registration No.")
                    {
                    }
                    column(ShipmentDate_SalesHeader; FORMAT("Sales Header"."Shipment Date"))
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(No1_SalesHeader; "Sales Header"."No.")
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourReference_SalesHeader; "Sales Header"."Your Reference")
                    {
                    }
                    column(CustAddr7; CustAddr[7])
                    {
                    }
                    column(CustAddr8; CustAddr[8])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(PricesIncludingVAT_SalesHdr; "Sales Header"."Prices Including VAT")
                    {
                    }
                    column(PageCaption; STRSUBSTNO(Text005, ''))
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(QuotationCopy; QuotationCopy)
                    {
                    }
                    column(PricesInclVATYesNo_SalesHdr; FORMAT("Sales Header"."Prices Including VAT"))
                    {
                    }
                    column(CompanyInfoPhoneNoCaption; CompanyInfoPhoneNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoVATRegNoCaption; CompanyInfoVATRegNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoGiroNoCaption; CompanyInfoGiroNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankNameCaption; CompanyInfoBankNameCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankAccountNoCaption; CompanyInfoBankAccountNoCaptionLbl)
                    {
                    }
                    column(SalesHeaderShipmentDateCaption; SalesHeaderShipmentDateCaptionLbl)
                    {
                    }
                    column(SalesHeaderNoCaption; SalesHeaderNoCaptionLbl)
                    {
                    }
                    column(BilltoCustNo_SalesHeaderCaption; "Sales Header".FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(PricesIncludingVAT_SalesHdrCaption; "Sales Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    dataitem(DimensionLoop1; Table2000000026)
                    {
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING (Number)
                                            WHERE (Number = FILTER (1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(HeaderDimensionsCaption; HeaderDimensionsCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DimSetEntry1.FINDSET THEN
                                    CurrReport.BREAK;
                            END ELSE
                                IF NOT Continue THEN
                                    CurrReport.BREAK;

                            CLEAR(DimText);
                            Continue := FALSE;
                            REPEAT
                                OldDimText := DimText;
                                IF DimText = '' THEN
                                    DimText := STRSUBSTNO('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3', DimText, DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                END;
                            UNTIL DimSetEntry1.NEXT = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowInternalInfo THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(DataItem2844; Table37)
                    {
                        DataItemLink = Document Type=FIELD(Document Type),
                                       Document No.=FIELD(No.);
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING(Document Type,Document No.,Line No.);

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK;
                        end;
                    }
                    dataitem(RoundLoop;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(LineAmt_SalesLine;SalesLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(LineTotal;LineTotal)
                        {
                        }
                        column(No_SalesLine;"Sales Line"."No.")
                        {
                        }
                        column(Desc_SalesLine;SalesLineDescription)
                        {
                        }
                        column(InvExists;InvExists)
                        {
                        }
                        column(NonStockItemRemarks;NonStockItemRemarks)
                        {
                        }
                        column(InVentoryQty;InventoryQty)
                        {
                        }
                        column(Quantity_SalesLine;"Sales Line".Quantity)
                        {
                        }
                        column(UnitofMeasure_SalesLine;"Sales Line"."Unit of Measure Code")
                        {
                        }
                        column(LineAmt1_SalesLine;"Sales Line"."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(UnitPrice_SalesLine;"Sales Line"."Unit Price")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(LineDiscount_SalesLine;"Sales Line"."Line Discount %")
                        {
                        }
                        column(AllowInvoiceDisc_SalesLine;"Sales Line"."Allow Invoice Disc.")
                        {
                            IncludeCaption = false;
                        }
                        column(VATIdentifier_SalesLine;"Sales Line"."VAT Identifier")
                        {
                        }
                        column(Type_SalesLine;FORMAT("Sales Line".Type))
                        {
                        }
                        column(No1_SalesLine;"Sales Line"."Line No.")
                        {
                        }
                        column(AllowInvoiceDisYesNo;FORMAT("Sales Line"."Allow Invoice Disc."))
                        {
                        }
                        column(InvDiscountAmount_SalesLine;-SalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText;TotalText)
                        {
                        }
                        column(DiscountAmt_SalesLine;SalesLine."Line Amount" - SalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtTxt;VATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalExclVATText;TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText;TotalInclVATText)
                        {
                        }
                        column(VATAmount;VATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATDiscountAmount;-VATDiscountAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT;TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountVAT;TotalAmountVAT)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseAmount;VATBaseAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(UnitPriceCaption;UnitPriceCaptionLbl)
                        {
                        }
                        column(SalesLineLineDiscCaption;SalesLineLineDiscCaptionLbl)
                        {
                        }
                        column(AmountCaption;AmountCaptionLbl)
                        {
                        }
                        column(SalesLineInvDiscAmtCaption;SalesLineInvDiscAmtCaptionLbl)
                        {
                        }
                        column(SubtotalCaption;SubtotalCaptionLbl)
                        {
                        }
                        column(VATDiscountAmountCaption;VATDiscountAmountCaptionLbl)
                        {
                        }
                        column(No_SalesLineCaption;"Sales Line".FIELDCAPTION("No."))
                        {
                        }
                        column(Desc_SalesLineCaption;"Sales Line".FIELDCAPTION(Description))
                        {
                        }
                        column(Quantity_SalesLineCaption;"Sales Line".FIELDCAPTION(Quantity))
                        {
                        }
                        column(UnitofMeasure_SalesLineCaption;"Sales Line".FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(NP151001;"--NP15.1001")
                        {
                        }
                        column(SalesQuoteLineSN;SalesQuoteLineSN)
                        {
                        }
                        column(LineTotalAmount;LineTotalAmount)
                        {
                        }
                        column(TextVar_1;TextVar[1])
                        {
                        }
                        column(TextVar_2;TextVar[2])
                        {
                        }
                        column(TotalSubTotal;TotalSubTotal)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvDiscAmount;TotalInvDiscAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        dataitem(DimensionLoop2;Table2000000026)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number=FILTER(1..));
                            column(DimText_DimnLoop2;DimText)
                            {
                            }
                            column(LineDimensionsCaption;LineDimensionsCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                  IF NOT DimSetEntry2.FINDSET THEN
                                    CurrReport.BREAK;
                                END ELSE
                                  IF NOT Continue THEN
                                    CurrReport.BREAK;

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                  OldDimText := DimText;
                                  IF DimText = '' THEN
                                    DimText := STRSUBSTNO('%1 %2',DimSetEntry2."Dimension Code",DimSetEntry2."Dimension Value Code")
                                  ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3',DimText,
                                        DimSetEntry2."Dimension Code",DimSetEntry2."Dimension Value Code");
                                  IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                  END;
                                UNTIL DimSetEntry2.NEXT = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT ShowInternalInfo THEN
                                  CurrReport.BREAK;

                                DimSetEntry2.SETRANGE("Dimension Set ID","Sales Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                              SalesLine.FIND('-')
                            ELSE
                              SalesLine.NEXT;
                            "Sales Line" := SalesLine;

                            IF NOT "Sales Header"."Prices Including VAT" AND
                               (SalesLine."VAT Calculation Type" = SalesLine."VAT Calculation Type"::"Full VAT")
                            THEN
                              SalesLine."Line Amount" := 0;

                            IF (SalesLine.Type = SalesLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                              "Sales Line"."No." := '';


                            //TotalSubTotal += "Line Amount"; Standard Code Commented GAT.15.07
                            TotalInvDiscAmount -= "Sales Line"."Inv. Discount Amount";
                            TotalAmount += "Sales Line".Amount;
                            TotalAmountVAT += "Sales Line"."Amount Including VAT" - "Sales Line".Amount;
                            TotalAmountInclVAT += "Sales Line"."Amount Including VAT";

                            LineTotal := 0;
                            LineTotal := "Sales Line".Quantity * "Sales Line"."Unit Price";  //Agile ZM

                            //GAT.15.07 >>
                            SalesQuoteLineOnAfterGetRecord("Sales Line");
                            //GAT.15.07 <<
                        end;

                        trigger OnPostDataItem()
                        begin
                            SalesLine.DELETEALL;
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := SalesLine.FIND('+');
                            WHILE MoreLines AND (SalesLine.Description = '') AND (SalesLine."Description 2" = '') AND
                                  (SalesLine."No." = '') AND (SalesLine.Quantity = 0) AND
                                  (SalesLine.Amount = 0)
                            DO
                              MoreLines := SalesLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                              CurrReport.BREAK;
                            SalesLine.SETRANGE("Line No.",0,SalesLine."Line No.");
                            SETRANGE(Number,1,SalesLine.COUNT);
                            CurrReport.CREATETOTALS(SalesLine."Line Amount",SalesLine."Inv. Discount Amount");

                            //GAT.15.07 >>
                            SalesQuoteLineOnPreDataItem;
                            //GAT.15.07 <<
                        end;
                    }
                    dataitem(VATCounter;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATBase_VATAmtLine;VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmt_VATAmtLine;VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(LineAmount_VATAmtLine;VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(InvDiscBaseAmt_VATAmtLine;VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(InvoiceDiscAmt_VATAmtLine;VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VAT_VATAmtLine;VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0:5;
                        }
                        column(VATIdentifier_VATAmtLine;VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLineVATCaption;VATAmountLineVATCaptionLbl)
                        {
                        }
                        column(VATBaseCaption;VATBaseCaptionLbl)
                        {
                        }
                        column(VATAmtCaption;VATAmtCaptionLbl)
                        {
                        }
                        column(VATAmountSpecificationCaption;VATAmountSpecificationCaptionLbl)
                        {
                        }
                        column(LineAmtCaption;LineAmtCaptionLbl)
                        {
                        }
                        column(InvoiceDiscBaseAmtCaption;InvoiceDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(InvoiceDiscAmtCaption;InvoiceDiscAmtCaptionLbl)
                        {
                        }
                        column(TotalCaption;TotalCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF VATAmount = 0 THEN
                              CurrReport.BREAK;
                            SETRANGE(Number,1,VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(
                              VATAmountLine."Line Amount",VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount",VATAmountLine."VAT Base",VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VATCounterLCY;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VALExchRate;VALExchRate)
                        {
                        }
                        column(VALSpecLCYHeader;VALSpecLCYHeader)
                        {
                        }
                        column(VALVATBaseLCY;VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY;VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATCtrl_VATAmtLine;VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0:5;
                        }
                        column(VATIdentifierCtrl_VATAmtLine;VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              VATAmountLine.GetBaseLCY(
                                "Sales Header"."Posting Date","Sales Header"."Currency Code","Sales Header"."Currency Factor");
                            VALVATAmountLCY :=
                              VATAmountLine.GetAmountLCY(
                                "Sales Header"."Posting Date","Sales Header"."Currency Code","Sales Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Sales Header"."Currency Code" = '') OR
                               (VATAmountLine.GetTotalVATAmount = 0)
                            THEN
                              CurrReport.BREAK;

                            SETRANGE(Number,1,VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY,VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                              VALSpecLCYHeader := Text008 + Text009
                            ELSE
                              VALSpecLCYHeader := Text008 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Header"."Order Date","Sales Header"."Currency Code",1);
                            VALExchRate := STRSUBSTNO(Text010,CurrExchRate."Relational Exch. Rate Amount",CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number=CONST(1));
                    }
                    dataitem(Total2;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number=CONST(1));
                        column(SelltoCustNo_SalesHeader;"Sales Header"."Sell-to Customer No.")
                        {
                        }
                        column(ShipToAddr1;ShipToAddr[1])
                        {
                        }
                        column(ShipToAddr2;ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr3;ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr4;ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr5;ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr6;ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr7;ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr8;ShipToAddr[8])
                        {
                        }
                        column(ShiptoAddressCaption;ShiptoAddressCaptionLbl)
                        {
                        }
                        column(SelltoCustNo_SalesHeaderCaption;"Sales Header".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowShippingAddr THEN
                              CurrReport.BREAK;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                var
                    SalesPost: Codeunit "80";
                begin
                    CLEAR(SalesLine);
                    CLEAR(SalesPost);
                    SalesLine.DELETEALL;
                    VATAmountLine.DELETEALL;
                    SalesPost.GetSalesLines("Sales Header",SalesLine,0);
                    SalesLine.CalcVATAmountLines(0,"Sales Header",SalesLine,VATAmountLine);
                    SalesLine.UpdateVATOnLines(0,"Sales Header",SalesLine,VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Sales Header"."Currency Code","Sales Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;

                    IF Number = 2 THEN BEGIN
                      CopyText := '';
                      QuotationCopy := 'WORKSHOP COPY';
                      OutputNo += 1;
                    END;

                    IF Number > 2 THEN BEGIN
                      CopyText := '';
                      QuotationCopy := 'CUSTOMER COPY';
                      OutputNo += 1;
                    END;

                    CurrReport.PAGENO := Number;

                    TotalSubTotal := 0;
                    TotalInvDiscAmount := 0;
                    TotalAmount := 0;
                    TotalAmountVAT := 0;
                    TotalAmountInclVAT := 0;
                    TotalPaymentDiscOnVAT := 0;
                end;

                trigger OnPostDataItem()
                begin
                    IF Print THEN
                      SalesCountPrinted.RUN("Sales Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := 1;
                    CopyText := '';
                    //QuotationCopy := 'OFFICE COPY';
                    SETRANGE(Number,1,NoOfLoops);
                    OutputNo := 1;

                    //GAT.15.07 >>
                    CopyLoopOnPreDataItem;
                    //GAT.15.07 <<
                end;
            }

            trigger OnAfterGetRecord()
            var
                "Sell-to Country": Text[50];
            begin
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                  FormatAddr.RespCenter(CompanyAddr,RespCenter);
                  CompanyInfo."Phone No." := RespCenter."Phone No.";
                  CompanyInfo."Fax No." := RespCenter."Fax No.";
                  CompanyInfo."E-Mail" := RespCenter."E-Mail";
                END ELSE
                  FormatAddr.Company(CompanyAddr,CompanyInfo);

                //GAT.15.07 >>
                GetCompanyOneLineAddress;
                //GAT.15.07 <<

                DimSetEntry1.SETRANGE("Dimension Set ID","Dimension Set ID");

                IF "Salesperson Code" = '' THEN BEGIN
                  SalesPurchPerson.INIT;
                  SalesPersonText := '';
                END ELSE BEGIN
                  SalesPurchPerson.GET("Salesperson Code");
                  SalesPersonText := Text000;
                END;
                IF "Your Reference" = '' THEN
                  ReferenceText := ''
                ELSE
                  ReferenceText := FIELDCAPTION("Your Reference");
                IF "VAT Registration No." = '' THEN
                  VATNoText := ''
                ELSE
                  VATNoText := FIELDCAPTION("VAT Registration No.");
                IF "Currency Code" = '' THEN BEGIN
                  GLSetup.TESTFIELD("LCY Code");
                  TotalText := STRSUBSTNO(Text001,GLSetup."LCY Code");
                  TotalInclVATText := STRSUBSTNO(Text002,GLSetup."LCY Code");
                  TotalExclVATText := STRSUBSTNO(Text006,GLSetup."LCY Code");
                END ELSE BEGIN
                  TotalText := STRSUBSTNO(Text001,"Currency Code");
                  TotalInclVATText := STRSUBSTNO(Text002,"Currency Code");
                  TotalExclVATText := STRSUBSTNO(Text006,"Currency Code");
                END;
                FormatAddr.SalesHeaderBillTo(CustAddr,"Sales Header");

                //GAT.15.07 >>
                GetCustomerOneLineAddress;
                //GAT.15.07 <<

                IF "Payment Terms Code" = '' THEN
                  PaymentTerms.INIT
                ELSE BEGIN
                  PaymentTerms.GET("Payment Terms Code");
                  PaymentTerms.TranslateDescription(PaymentTerms,"Language Code");
                END;
                IF "Shipment Method Code" = '' THEN
                  ShipmentMethod.INIT
                ELSE BEGIN
                  ShipmentMethod.GET("Shipment Method Code");
                  ShipmentMethod.TranslateDescription(ShipmentMethod,"Language Code");
                END;

                IF Country.GET("Sell-to Country/Region Code") THEN
                  "Sell-to Country" := Country.Name;
                FormatAddr.SalesHeaderShipTo(ShipToAddr,CustAddr,"Sales Header");
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                  IF (ShipToAddr[i] <> CustAddr[i]) AND (ShipToAddr[i] <> '') AND (ShipToAddr[i] <> "Sell-to Country") THEN
                    ShowShippingAddr := TRUE;

                IF Print THEN BEGIN
                  IF ArchiveDocument THEN
                    ArchiveManagement.StoreSalesDocument("Sales Header",LogInteraction);

                  IF LogInteraction THEN BEGIN
                    CALCFIELDS("No. of Archived Versions");
                    IF "Bill-to Contact No." <> '' THEN
                      SegManagement.LogDocument(
                        1,"No.","Doc. No. Occurrence",
                        "No. of Archived Versions",DATABASE::Contact,"Bill-to Contact No.",
                        "Salesperson Code","Campaign No.","Posting Description","Opportunity No.")
                    ELSE
                      SegManagement.LogDocument(
                        1,"No.","Doc. No. Occurrence",
                        "No. of Archived Versions",DATABASE::Customer,"Bill-to Customer No.",
                        "Salesperson Code","Campaign No.","Posting Description","Opportunity No.");
                  END;
                END;
                MARK(TRUE);
            end;

            trigger OnPostDataItem()
            var
                ToDo: Record "5080";
                FileManagement: Codeunit "419";
            begin
                MARKEDONLY := TRUE;
                COMMIT;
            end;

            trigger OnPreDataItem()
            begin
                NoOfRecords := COUNT;
                Print := Print; //OR NOT CurrReport.PREVIEW;
                FinalQuotation := '';
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopies;NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                    }
                    field(ShowInternalInfo;ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information';
                    }
                    field(ArchiveDocument;ArchiveDocument)
                    {
                        Caption = 'Archive Document';

                        trigger OnValidate()
                        begin
                            IF NOT ArchiveDocument THEN
                              LogInteraction := FALSE;
                        end;
                    }
                    field(LogInteraction;LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;

                        trigger OnValidate()
                        begin
                            IF LogInteraction THEN
                              ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            ArchiveDocument := SalesSetup."Archive Quotes and Orders";
            LogInteraction := SegManagement.FindInteractTmplCode(1) <> '';

            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET;
        CompanyInfo.GET;
        SalesSetup.GET;
        UserSetup.GET(USERID);
        NonStockItemRemarks := '';

        CASE SalesSetup."Logo Position on Documents" OF
          SalesSetup."Logo Position on Documents"::"No Logo":
            ;
          SalesSetup."Logo Position on Documents"::Left:
            BEGIN
              CompanyInfo3.GET;
              CompanyInfo3.CALCFIELDS(Picture);
            END;
          SalesSetup."Logo Position on Documents"::Center:
            BEGIN
              CompanyInfo1.GET;
              CompanyInfo1.CALCFIELDS(Picture);
            END;
          SalesSetup."Logo Position on Documents"::Right:
            BEGIN
              CompanyInfo2.GET;
              CompanyInfo2.CALCFIELDS(Picture);
            END;
        END;
    end;

    var
        Text000: Label 'Salesperson';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label 'Sales - Quote %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        GLSetup: Record "98";
        ShipmentMethod: Record "10";
        PaymentTerms: Record "3";
        SalesPurchPerson: Record "13";
        CompanyInfo: Record "79";
        CompanyInfo1: Record "79";
        CompanyInfo2: Record "79";
        CompanyInfo3: Record "79";
        SalesSetup: Record "311";
        VATAmountLine: Record "290" temporary;
        SalesLine: Record "37" temporary;
        DimSetEntry1: Record "480";
        DimSetEntry2: Record "480";
        RespCenter: Record "5714";
        Language: Record "8";
        Country: Record "9";
        CurrExchRate: Record "330";
        SalesCountPrinted: Codeunit "313";
        FormatAddr: Codeunit "365";
        SegManagement: Codeunit "5051";
        ArchiveManagement: Codeunit "5063";
        CustAddr: array [8] of Text[50];
        ShipToAddr: array [8] of Text[50];
        CompanyAddr: array [8] of Text[50];
        SalesPersonText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        i: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        Text007: Label 'Do you want to create a follow-up to-do?';
        NoOfRecords: Integer;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        Text008: Label 'VAT Amount Specification in ';
        Text009: Label 'Local Currency';
        Text010: Label 'Exchange rate: %1/%2';
        OutputNo: Integer;
        Print: Boolean;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.';
        CompanyInfoVATRegNoCaptionLbl: Label 'VAT Registration No.';
        CompanyInfoGiroNoCaptionLbl: Label 'Giro No.';
        CompanyInfoBankNameCaptionLbl: Label 'Bank';
        CompanyInfoBankAccountNoCaptionLbl: Label 'Account No.';
        SalesHeaderShipmentDateCaptionLbl: Label 'Shipment Date';
        SalesHeaderNoCaptionLbl: Label 'Quote No.';
        HeaderDimensionsCaptionLbl: Label 'Header Dimensions';
        UnitPriceCaptionLbl: Label 'Unit Price';
        SalesLineLineDiscCaptionLbl: Label 'Discount %';
        AmountCaptionLbl: Label 'Amount';
        SalesLineInvDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
        SubtotalCaptionLbl: Label 'Subtotal';
        VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT';
        LineDimensionsCaptionLbl: Label 'Line Dimensions';
        VATAmountLineVATCaptionLbl: Label 'VAT %';
        VATBaseCaptionLbl: Label 'VAT Base';
        VATAmtCaptionLbl: Label 'VAT Amount';
        VATAmountSpecificationCaptionLbl: Label 'VAT Amount Specification';
        LineAmtCaptionLbl: Label 'Line Amount';
        InvoiceDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        InvoiceDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
        TotalCaptionLbl: Label 'Total';
        ShiptoAddressCaptionLbl: Label 'Ship-to Address';
        SalesLineVATIdentifierCaptionLbl: Label 'VAT Identifier';
        PaymentTermsDescriptionCaptionLbl: Label 'Payment Terms';
        ShipmentMethodDescriptionCaptionLbl: Label 'Shipment Method';
        CompanyInfoHomePageCaptionLbl: Label 'Home Page';
        CompanyInfoEmailCaptionLbl: Label 'E-Mail';
        DocumentDateCaptionLbl: Label 'Document Date';
        SalesLineAllowInvoiceDiscCaptionLbl: Label 'Allow Invoice Discount';
        "--NP15.1001": Integer;
        Cust: Record "18";
        Currency: Record "4";
        SystemManagement: Codeunit "50000";
        SystemMgt: Codeunit "50002";
        SalesQuoteLineSN: Integer;
        CompanyOneLineAddress: Text;
        CompanyCommunicationAddress: Text;
        CustomerOneLineAddress: Text;
        TextVar: array [2] of Text[80];
        LineTotalAmount: Decimal;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalPaymentDiscOnVAT: Decimal;
        SalesLineDescription: Text;
        TermsandCondition: Record "5906";
        LineTotal: Decimal;
        FinalQuotation: Text;
        QuotationCopy: Text[20];
        InvExists: Boolean;
        InventoryQty: Decimal;
        ItemRec: Record "27";
        UserSetup: Record "91";
        NonStockItemRemarks: Text;

    [Scope('Internal')]
    procedure InitializeRequest(NoOfCopiesFrom: Integer;ShowInternalInfoFrom: Boolean;ArchiveDocumentFrom: Boolean;LogInteractionFrom: Boolean;PrintFrom: Boolean)
    begin
        NoOfCopies := NoOfCopiesFrom;
        ShowInternalInfo := ShowInternalInfoFrom;
        ArchiveDocument := ArchiveDocumentFrom;
        LogInteraction := LogInteractionFrom;
        Print := PrintFrom;
    end;

    local procedure "---NP15.1001"()
    begin
    end;

    local procedure GetCompanyOneLineAddress()
    begin
        CompanyAddr[1] := CompanyInfo.Name;
        IF CompanyInfo."Phone No." <> '' THEN
          CompanyOneLineAddress := SystemManagement.OneLineAddress(CompanyAddr) + ', ' + CompanyInfo.FIELDCAPTION("Phone No.") + ' : ' + CompanyInfo."Phone No."
        ELSE
          CompanyOneLineAddress := SystemManagement.OneLineAddress(CompanyAddr);

        IF CompanyInfo."Fax No." <> '' THEN
          CompanyCommunicationAddress := CompanyInfo.FIELDCAPTION("Fax No.") + ' : ' + CompanyInfo."Fax No.";
        IF (CompanyCommunicationAddress <> '') AND (CompanyInfo."E-Mail" <> '') THEN
          CompanyCommunicationAddress += ', ' + CompanyInfo.FIELDCAPTION("E-Mail") + ' : ' + CompanyInfo."E-Mail";
    end;

    local procedure GetCustomerOneLineAddress()
    begin
        CustomerOneLineAddress := SystemManagement.OneLineAddress(CustAddr);
    end;

    local procedure SalesQuoteLineOnPreDataItem()
    begin
        SalesQuoteLineSN := 0;
    end;

    local procedure SalesQuoteLineOnAfterGetRecord(SalesLine: Record "37")
    begin
        WITH SalesLine DO BEGIN
          IF "No." <> '' THEN
            SalesQuoteLineSN  += 1;
          IF "Sales Header"."Currency Code" = '' THEN
            Currency.InitRoundingPrecision
          ELSE BEGIN
            "Sales Header".TESTFIELD("Currency Factor");
            Currency.GET("Sales Header"."Currency Code");
            Currency.TESTFIELD("Amount Rounding Precision");
          END;

          LineTotalAmount := ROUND(Quantity * "Unit Price",Currency."Amount Rounding Precision");
          TotalInvDiscAmount -= "Line Discount Amount";
          TotalSubTotal += LineTotalAmount;

          SystemManagement.InitTextVariable;
          SystemManagement.FormatNoText(TextVar, TotalAmountInclVAT,'');
        END;
    end;

    local procedure CopyLoopOnPreDataItem()
    begin
        //InvoiceCaption := '';
        //CopyOfOriginalInvoiceCaption := '';
        //TimesPrintedCaption := '';
    end;
}

