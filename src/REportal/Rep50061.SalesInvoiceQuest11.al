report 50061 "Sales Invoice Quest 1.1."
{
    DefaultLayout = RDLC;
    RDLCLayout = './SalesInvoiceQuest11.rdlc';

    dataset
    {
        dataitem(DataItem5581; Table112)
        {
            DataItemTableView = SORTING (No.);
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';
            column(No_SalesInvHdr; "No.")
            {
            }
            column(Bank_LC_No; "Sales Invoice Header"."Bank LC No.")
            {
            }
            column(PaymentMethod; "Sales Invoice Header"."Payment Method Code")
            {
            }
            column(Sell_To_Customer_Name; "Sales Invoice Header"."Sell-to Customer Name")
            {
            }
            column(Bill_To_Name2; "Sales Invoice Header"."Bill-to Name 2")
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyInfo2Picture; CompanyInfo2.Picture)
            {
            }
            column(CompanyInfo1Picture; CompanyInfo1.Picture)
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo3Picture; CompanyInfo3.Picture)
            {
            }
            column(HomePage; CompanyInfo."Home Page")
            {
            }
            column(EMail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfoVATRegNo; CompanyInfoVATRegNo)
            {
            }
            column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
            {
            }
            column(CompanyInfoBankName; CompanyInfo."Bank Name")
            {
            }
            column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
            {
            }
            column(CompanyInfoFaxNo; CompanyInfo."Fax No.")
            {
            }
            column(VATRegistrationNo_SalesInvoiceHeader; "Sales Invoice Header"."VAT Registration No.")
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
            column(CustomerName; Cust.Name + Cust."Name 2")
            {
            }
            column(CustomerAddress; Cust.Address + Cust."Address 2")
            {
            }
            column(Cust_Phone_No_; Cust."Phone No.")
            {
            }
            column(InvoiceDate; FORMAT("Posting Date") + '  ( ' + SystemManagement.getNepaliDate("Posting Date") + ' )')
            {
            }
            column(DueDate; FORMAT("Due Date") + '  ( ' + SystemManagement.getNepaliDate("Due Date") + ' )')
            {
            }
            column(OrderNo; "External Document No.")
            {
            }
            column(DispatchDate_SalesInvoiceHeader; FORMAT(BillDeliveryDetail."Dispatch Date"))
            {
            }
            column(TransportName_SalesInvoiceHeader; BillDeliveryDetail."Transport Name")
            {
            }
            column(CNNo_SalesInvoiceHeader; BillDeliveryDetail."CN No.")
            {
            }
            column(MR_SalesInvoiceHeader; BillDeliveryDetail."M.R.")
            {
            }
            column(Cases_SalesInvoiceHeader; BillDeliveryDetail.Cases)
            {
            }
            column(DocThru_SalesInvoiceHeader; BillDeliveryDetail."Doc. Thru.")
            {
            }
            column(PrintedDate; FORMAT(TODAY) + ' ( ' + SystemManagement.getNepaliDate(TODAY) + ' )')
            {
            }
            column(PaymentTermsCode_SalesInvoiceHeader; "Sales Invoice Header"."Payment Terms Code")
            {
            }
            column(PreviewMode; CurrReport.PREVIEW)
            {
            }
            column(SpecialDiscount_SalesInvoiceHeader; "Sales Invoice Header"."Special Discount")
            {
            }
            column(InvoiceDiscountAmount_SalesInvoiceHeader; "Sales Invoice Header"."Invoice Discount Amount")
            {
            }
            column(Amount_SalesInvoiceHeader; "Sales Invoice Header".Amount)
            {
            }
            column(AmountIncludingVAT_SalesInvoiceHeader; "Sales Invoice Header"."Amount Including VAT")
            {
            }
            column(TotalAmount; TotalAmount)
            {
            }
            column(TotalAmountVAT; TotalAmountVAT)
            {
            }
            column(TotalInvDiscAmount; TotalInvDiscAmount)
            {
            }
            column(TotalAmountInclVAT; TotalAmountInclVAT)
            {
            }
            column(TextVar1; TextVar[1])
            {
            }
            column(TextVar2; TextVar[2])
            {
            }
            dataitem(DataItem22; Table110)
            {
                DataItemLink = Order No.=FIELD(Order No.);
                dataitem(DataItem24; Table111)
                {
                    DataItemLink = Document No.=FIELD(No.);
                    column(UnitPrice_SalesShipmentLine; "Sales Shipment Line"."Unit Price")
                    {
                    }
                    column(FreeQuantity; FreeQuantity)
                    {
                    }
                    column(MaximumRetailPrice_SalesShipmentLine; "Sales Shipment Line"."Maximum Retail Price")
                    {
                    }
                    dataitem(DataItem1; Table32)
                    {
                        DataItemLink = Document No.=FIELD(Document No.),
                                       Document Line No.=FIELD(Line No.);
                        DataItemTableView = SORTING(Entry No.);
                        column(ExpirationDate_ItemLedgerEntry;FORMAT("Item Ledger Entry"."Expiration Date"))
                        {
                        }
                        column(EntryNo_ItemLedgerEntry;"Item Ledger Entry"."Entry No.")
                        {
                        }
                        column(ItemNo_ItemLedgerEntry;"Item Ledger Entry"."Item No.")
                        {
                        }
                        column(PostingDate_ItemLedgerEntry;FORMAT("Item Ledger Entry"."Posting Date"))
                        {
                        }
                        column(SourceNo_ItemLedgerEntry;"Item Ledger Entry"."Source No.")
                        {
                        }
                        column(DocumentNo_ItemLedgerEntry;"Item Ledger Entry"."Document No.")
                        {
                        }
                        column(Description_ItemLedgerEntry;"Item Ledger Entry".Description)
                        {
                        }
                        column(Quantity_ItemLedgerEntry;"Item Ledger Entry".Quantity)
                        {
                        }
                        column(UnitofMeasureCode_ItemLedgerEntry;"Item Ledger Entry"."Unit of Measure Code")
                        {
                        }
                        column(SalesAmountExpected_ItemLedgerEntry;"Item Ledger Entry"."Sales Amount (Expected)")
                        {
                        }
                        column(SN;SN)
                        {
                        }
                        column(ItemName_ItemLedgerEntry;"Item Ledger Entry"."Item Name")
                        {
                        }
                        column(QuantityReal;QuantityReal)
                        {
                        }
                        column(BatchNo_ItemLedgerEntry;"Item Ledger Entry"."Batch No.")
                        {
                        }
                        column(EntryAmount;EntryAmount)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            SN += 1;
                            QuantityReal := 0;
                            "Item Ledger Entry".CALCFIELDS("Item Name");
                            ItemUnitOfMeasure.GET("Item Ledger Entry"."Item No.","Item Ledger Entry"."Unit of Measure Code");

                            QuantityReal := ABS(ROUND(("Item Ledger Entry".Quantity / ItemUnitOfMeasure."Qty. per Unit of Measure"),0.01,'='));
                            EntryAmount := ABS(ROUND((QuantityReal * "Sales Shipment Line"."Unit Price"),0.01,'='));
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                          //for getting free quantity
                          FreeQuantity := 0;
                          IF Type = Type::Item THEN BEGIN
                            FreeSalesInvLine.RESET;
                            FreeSalesInvLine.SETRANGE("Document No.","Document No.");
                            FreeSalesInvLine.SETRANGE("No.","No.");
                            FreeSalesInvLine.SETRANGE("Sales Line No.","Line No.");
                            IF FreeSalesInvLine.FINDFIRST THEN
                              FreeQuantity := FreeSalesInvLine.Quantity;
                          END;
                    end;
                }
            }

            trigger OnAfterGetRecord()
            begin

                IF COMPANYNAME = 'QUESTPHARRMACEUTICALSLIVE' THEN BEGIN
                  IF (NOT CurrReport.PREVIEW) AND ("Sales Invoice Header"."Posting Date" < 071620D) THEN
                    ERROR('You are not allowed to print invoice of previous FY.');
                END;

                Cust.RESET;
                Cust.SETRANGE("No.","Sales Invoice Header"."Sell-to Customer No.");
                IF Cust.FINDFIRST THEN;

                LC_Detail.RESET;
                LC_Detail.SETRANGE("LC\DO No.","Sales Invoice Header"."Bank LC No.");
                IF LC_Detail.FINDFIRST THEN;


                BillDeliveryDetail.RESET;
                BillDeliveryDetail.SETRANGE("Sales Invoice No.","Sales Invoice Header"."No.");
                IF BillDeliveryDetail.FINDLAST THEN;

                SalesInvLine.RESET;
                SalesInvLine.SETRANGE("Document No.","Sales Invoice Header"."No.");
                SalesInvLine.SETRANGE(Type,SalesInvLine.Type::Item);
                IF SalesInvLine.FINDFIRST THEN
                  REPEAT
                    ProductDiscount += SalesInvLine."Line Discount Amount";
                    TotalAmountVAT += SalesInvLine."Amount Including VAT" - SalesInvLine.Amount;
                    TotalAmountInclVAT += SalesInvLine."Amount Including VAT";

                    UNTIL SalesInvLine.NEXT = 0;

                //TotalAmount := "Sales Invoice Header"."Amount Including VAT" - "Sales Invoice Header"."Invoice Discount Amount";

                 IRDMgt.InitTextVariable;
                 IRDMgt.FormatNoText(TextVar, TotalAmountInclVAT,'');
            end;

            trigger OnPreDataItem()
            begin
                SN := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        GetCompanyOneLineAddress;
    end;

    var
        CompanyInfo: Record "79";
        CompanyInfo1: Record "79";
        CompanyInfo2: Record "79";
        CompanyInfo3: Record "79";
        CompanyOneLineAddress: Text;
        CompanyCommunicationAddress: Text;
        CustomerOneLineAddress: Text;
        Cust: Record "18";
        SystemManagement: Codeunit "50000";
        RespCenter: Record "5714";
        SameCustomer: Boolean;
        LC_Detail: Record "50008";
        BillDeliveryDetail: Record "50027";
        CompanyInfoVATRegNo: Text;
        SN: Integer;
        ItemUnitOfMeasure: Record "5404";
        QuantityReal: Decimal;
        FreeQuantity: Decimal;
        FreeSalesInvLine: Record "113";
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalPaymentDiscOnVAT: Decimal;
        EntryAmount: Decimal;
        SalesInvLine: Record "113";
        IRDMgt: Codeunit "50000";
        ProductDiscount: Decimal;
        TextVar: array [2] of Text;

    local procedure GetCompanyOneLineAddress()
    var
        AccCenter: Record "50015";
        CompanyAddr: array [1] of Text;
    begin
        CompanyAddr[1] := CompanyInfo.Name;
        IF NOT CompanyInfo."Activate Local Resp. Center" THEN BEGIN
          IF CompanyInfo."Phone No." <> '' THEN
            CompanyOneLineAddress := SystemManagement.OneLineAddress(CompanyAddr) + ', ' + CompanyInfo.FIELDCAPTION("Phone No.") + ' : ' + CompanyInfo."Phone No."
          ELSE
            CompanyOneLineAddress := SystemManagement.OneLineAddress(CompanyAddr);

          IF CompanyInfo."Fax No." <> '' THEN
            CompanyCommunicationAddress := CompanyInfo.FIELDCAPTION("Fax No.") + ' : ' + CompanyInfo."Fax No.";
          IF (CompanyCommunicationAddress <> '') AND (CompanyInfo."E-Mail" <> '') THEN
            CompanyCommunicationAddress += ', ' + CompanyInfo.FIELDCAPTION("E-Mail") + ' : ' + CompanyInfo."E-Mail";
          CompanyInfoVATRegNo := 'PAN Number'+ ' : '+CompanyInfo."VAT Registration No.";
        END ELSE BEGIN
          IF AccCenter.GET("Sales Invoice Header"."Accountability Center") THEN BEGIN
            CompanyOneLineAddress := AccCenter.Address;
            CompanyCommunicationAddress := 'Tel No. : ' + AccCenter."Phone No.";
            CompanyInfoVATRegNo := 'E-mail : ' + AccCenter."E-Mail";
          END;
        END;
    end;

    local procedure GetCustomerOneLineAddress()
    begin
        //CustomerOneLineAddress := SystemManagement.OneLineAddress(CustAddr);
    end;
}

