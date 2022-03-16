report 50006 "Sales VAT Book"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SalesVATBook.rdlc';

    dataset
    {
        dataitem(DataItem1; Table254)
        {
            DataItemTableView = WHERE (Type = CONST (Sale));
            RequestFilterFields = "Posting Date";
            column(EntryNo_VATEntry; "VAT Entry"."Entry No.")
            {
            }
            column(GenBusPostingGroup_VATEntry; "VAT Entry"."Gen. Bus. Posting Group")
            {
            }
            column(GenProdPostingGroup_VATEntry; "VAT Entry"."Gen. Prod. Posting Group")
            {
            }
            column(PostingDate_VATEntry; "VAT Entry"."Posting Date")
            {
            }
            column(DocumentNo_VATEntry; "VAT Entry"."Document No.")
            {
            }
            column(DocumentType_VATEntry; "VAT Entry"."Document Type")
            {
            }
            column(Type_VATEntry; "VAT Entry".Type)
            {
            }
            column(Base_VATEntry; "VAT Entry".Base)
            {
            }
            column(Amount_VATEntry; "VAT Entry".Amount)
            {
            }
            column(VATCalculationType_VATEntry; "VAT Entry"."VAT Calculation Type")
            {
            }
            column(BilltoPaytoNo_VATEntry; "VAT Entry"."Bill-to/Pay-to No.")
            {
            }
            column(EU3PartyTrade_VATEntry; "VAT Entry"."EU 3-Party Trade")
            {
            }
            column(UserID_VATEntry; "VAT Entry"."User ID")
            {
            }
            column(SourceCode_VATEntry; "VAT Entry"."Source Code")
            {
            }
            column(ReasonCode_VATEntry; "VAT Entry"."Reason Code")
            {
            }
            column(ClosedbyEntryNo_VATEntry; "VAT Entry"."Closed by Entry No.")
            {
            }
            column(Closed_VATEntry; "VAT Entry".Closed)
            {
            }
            column(CountryRegionCode_VATEntry; "VAT Entry"."Country/Region Code")
            {
            }
            column(InternalRefNo_VATEntry; "VAT Entry"."Internal Ref. No.")
            {
            }
            column(TransactionNo_VATEntry; "VAT Entry"."Transaction No.")
            {
            }
            column(UnrealizedAmount_VATEntry; "VAT Entry"."Unrealized Amount")
            {
            }
            column(UnrealizedBase_VATEntry; "VAT Entry"."Unrealized Base")
            {
            }
            column(RemainingUnrealizedAmount_VATEntry; "VAT Entry"."Remaining Unrealized Amount")
            {
            }
            column(RemainingUnrealizedBase_VATEntry; "VAT Entry"."Remaining Unrealized Base")
            {
            }
            column(ExternalDocumentNo_VATEntry; "VAT Entry"."External Document No.")
            {
            }
            column(NoSeries_VATEntry; "VAT Entry"."No. Series")
            {
            }
            column(TaxAreaCode_VATEntry; "VAT Entry"."Tax Area Code")
            {
            }
            column(TaxLiable_VATEntry; "VAT Entry"."Tax Liable")
            {
            }
            column(TaxGroupCode_VATEntry; "VAT Entry"."Tax Group Code")
            {
            }
            column(UseTax_VATEntry; "VAT Entry"."Use Tax")
            {
            }
            column(TaxJurisdictionCode_VATEntry; "VAT Entry"."Tax Jurisdiction Code")
            {
            }
            column(TaxGroupUsed_VATEntry; "VAT Entry"."Tax Group Used")
            {
            }
            column(TaxType_VATEntry; "VAT Entry"."Tax Type")
            {
            }
            column(TaxonTax_VATEntry; "VAT Entry"."Tax on Tax")
            {
            }
            column(SalesTaxConnectionNo_VATEntry; "VAT Entry"."Sales Tax Connection No.")
            {
            }
            column(UnrealizedVATEntryNo_VATEntry; "VAT Entry"."Unrealized VAT Entry No.")
            {
            }
            column(VATBusPostingGroup_VATEntry; "VAT Entry"."VAT Bus. Posting Group")
            {
            }
            column(VATProdPostingGroup_VATEntry; "VAT Entry"."VAT Prod. Posting Group")
            {
            }
            column(AdditionalCurrencyAmount_VATEntry; "VAT Entry"."Additional-Currency Amount")
            {
            }
            column(AdditionalCurrencyBase_VATEntry; "VAT Entry"."Additional-Currency Base")
            {
            }
            column(AddCurrencyUnrealizedAmt_VATEntry; "VAT Entry"."Add.-Currency Unrealized Amt.")
            {
            }
            column(AddCurrencyUnrealizedBase_VATEntry; "VAT Entry"."Add.-Currency Unrealized Base")
            {
            }
            column(VATBaseDiscount_VATEntry; "VAT Entry"."VAT Base Discount %")
            {
            }
            column(AddCurrRemUnrealAmount_VATEntry; "VAT Entry"."Add.-Curr. Rem. Unreal. Amount")
            {
            }
            column(AddCurrRemUnrealBase_VATEntry; "VAT Entry"."Add.-Curr. Rem. Unreal. Base")
            {
            }
            column(VATDifference_VATEntry; "VAT Entry"."VAT Difference")
            {
            }
            column(AddCurrVATDifference_VATEntry; "VAT Entry"."Add.-Curr. VAT Difference")
            {
            }
            column(ShiptoOrderAddressCode_VATEntry; "VAT Entry"."Ship-to/Order Address Code")
            {
            }
            column(DocumentDate_VATEntry; "VAT Entry"."Document Date")
            {
            }
            column(VATRegistrationNo_VATEntry; "VAT Entry"."VAT Registration No.")
            {
            }
            column(Reversed_VATEntry; "VAT Entry".Reversed)
            {
            }
            column(ReversedbyEntryNo_VATEntry; "VAT Entry"."Reversed by Entry No.")
            {
            }
            column(ReversedEntryNo_VATEntry; "VAT Entry"."Reversed Entry No.")
            {
            }
            column(EUService_VATEntry; "VAT Entry"."EU Service")
            {
            }
            column(PragyapanPatra_VATEntry; "VAT Entry".PragyapanPatra)
            {
            }
            column(ShortcutDimension1Code_VATEntry; "VAT Entry"."Shortcut Dimension 1 Code")
            {
            }
            column(NepaliDate_VATEntry; NepaliDate)
            {
            }
            column(LocalizedVATIdentifier_VATEntry; "VAT Entry"."Localized VAT Identifier")
            {
            }
            column(CustomerName; CustomerName)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_VAT_Registration_No; CompanyInfo."VAT Registration No.")
            {
            }
            column(PostingDateFilter; PostingDateFilter)
            {
            }
            column(TotalSale; TotalSale * -1)
            {
            }
            column(NonTaxSale; NonTaxSale * -1)
            {
            }
            column(ZeroTaxSaleExp; ZeroTaxSaleExp * -1)
            {
            }
            column(TaxableAmount; TaxableAmount * -1)
            {
            }
            column(VATAmount; VATAmount * -1)
            {
            }
            column(TotalAmount; TotalAmount * -1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CustomerName := '';
                TotalSale := 0;
                NonTaxSale := 0;
                ZeroTaxSaleExp := 0;
                TaxableAmount := 0;
                VATAmount := 0;
                TotalAmount := 0;

                IF "Localized VAT Identifier" = "Localized VAT Identifier"::Prepayments THEN
                    CurrReport.SKIP; //IME.SRT

                IF Customer.GET("VAT Entry"."Bill-to/Pay-to No.") THEN
                    CustomerName := Customer.Name;

                NepaliDate := SystemManagement.getNepaliDate("Posting Date");

                IF "Localized VAT Identifier" = "Localized VAT Identifier"::"Taxable Sales" THEN
                    TaxableAmount := Base
                ELSE
                    IF "Localized VAT Identifier" = "Localized VAT Identifier"::"Non Taxable Sales" THEN
                        NonTaxSale := Base
                    ELSE
                        IF "Localized VAT Identifier" = "Localized VAT Identifier"::"Exempt Sales" THEN
                            ZeroTaxSaleExp := Base;

                TotalSale := Base;
                VATAmount := Amount;
                TotalAmount := Base + Amount;
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
        CLEAR(PostingDateFilter);
        PostingDateFilter := "VAT Entry".GETFILTER("Posting Date");
    end;

    var
        Customer: Record "18";
        CompanyInfo: Record "79";
        SystemManagement: Codeunit "50000";
        CustomerName: Text[100];
        PostingDateFilter: Text[100];
        NepaliDate: Text;
        TotalSale: Decimal;
        NonTaxSale: Decimal;
        ZeroTaxSaleExp: Decimal;
        TaxableAmount: Decimal;
        VATAmount: Decimal;
        TotalAmount: Decimal;
}

