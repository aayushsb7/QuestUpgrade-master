report 50005 "Purchase VAT Book"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PurchaseVATBook.rdlc';

    dataset
    {
        dataitem(DataItem1; Table254)
        {
            DataItemTableView = WHERE (Type = CONST (Purchase));
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
            column(NepaliDate_VATEntry; NepaliDate)
            {
            }
            column(LocalizedVATIdentifier_VATEntry; "VAT Entry"."Localized VAT Identifier")
            {
            }
            column(DocNo; DocNo)
            {
            }
            column(SupplierName; SupplierName)
            {
            }
            column(ImportPurchAmount; ImportPurchAmount)
            {
            }
            column(ImportPurchVATAmount; ImportPurchVATAmount)
            {
            }
            column(CAPEXPurchAmount; CAPEXPurchAmount)
            {
            }
            column(CAPEXPurchVATAmount; CAPEXPurchVATAmount)
            {
            }
            column(LocalPurchAmount; LocalPurchAmount)
            {
            }
            column(LocalPurchVATAmount; LocalPurchVATAmount)
            {
            }
            column(ExemptPurchAmount; ExemptPurchAmount)
            {
            }
            column(ExemptPurchVATAmount; ExemptPurchVATAmount)
            {
            }
            column(CompanyInfo_VAT_Registration_No; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(PostingDate; PostingDate)
            {
            }
            column(TotalPurchaseAmount; TotalPurchaseAmount)
            {
            }
            column(ResponsibilityCenterName; ResponsibilityCenterName)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF "Localized VAT Identifier" = "Localized VAT Identifier"::"Purchase Without VAT Invoice" THEN
                    CurrReport.SKIP; //Agile CP 14 Sep 2016

                CLEAR(DocNo);
                IF (PragyapanPatra <> '') THEN
                    DocNo := PragyapanPatra
                ELSE
                    DocNo := "VAT Entry"."External Document No.";

                Vendor.RESET;
                Vendor.SETRANGE("No.", "Bill-to/Pay-to No.");
                IF Vendor.FINDFIRST THEN
                    SupplierName := Vendor.Name;

                CLEAR(ImportPurchAmount);
                CLEAR(ImportPurchVATAmount);
                CLEAR(ExemptPurchAmount);
                CLEAR(ExemptPurchVATAmount);
                CLEAR(CAPEXPurchAmount);
                CLEAR(CAPEXPurchVATAmount);
                CLEAR(LocalPurchAmount);
                CLEAR(LocalPurchVATAmount);

                IF "Localized VAT Identifier" = "Localized VAT Identifier"::"Taxable Import Purchase" THEN BEGIN
                    IF ImportPurchaseVATBase THEN BEGIN
                        ImportPurchAmount := "VAT Entry".Amount * 100 / 13;
                        ImportPurchVATAmount := "VAT Entry".Amount;
                    END ELSE BEGIN
                        ImportPurchAmount := "VAT Entry".Base;
                        ImportPurchVATAmount := "VAT Entry".Amount;
                    END;
                END ELSE
                    IF "Localized VAT Identifier" = "Localized VAT Identifier"::"Exempt Purchase" THEN BEGIN
                        ExemptPurchAmount := "VAT Entry".Base;
                        ExemptPurchVATAmount := "VAT Entry".Amount;
                    END ELSE
                        IF "Localized VAT Identifier" = "Localized VAT Identifier"::"Taxable Local Purchase" THEN BEGIN
                            LocalPurchAmount := "VAT Entry".Base;
                            LocalPurchVATAmount := "VAT Entry".Amount;
                        END ELSE
                            IF "Localized VAT Identifier" = "Localized VAT Identifier"::"Taxable Capex Purchase" THEN BEGIN
                                CAPEXPurchAmount := "VAT Entry".Base;
                                CAPEXPurchVATAmount := "VAT Entry".Amount;
                            END;
                TotalPurchaseAmount := ImportPurchAmount + CAPEXPurchAmount + LocalPurchAmount + ExemptPurchAmount;

                NepaliDate := SystemManagement.getNepaliDate("Posting Date");

                ResponsibilityCenterName := "Shortcut Dimension 1 Code";
                /*
                ResponsibilityCenter.RESET;
                ResponsibilityCenter.SETRANGE("Purch. Posted Invoice Nos.","No. Series");
                IF ResponsibilityCenter.FINDFIRST THEN BEGIN
                  ResponsibilityCenterName := ResponsibilityCenter.Name;
                END ELSE BEGIN
                  ResponsibilityCenter.RESET;
                  ResponsibilityCenter.SETRANGE("Purch. Credit Memo Nos.","No. Series");
                  IF ResponsibilityCenter.FINDFIRST THEN BEGIN
                    ResponsibilityCenterName := ResponsibilityCenter.Name;
                  END;
                END;
                */

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Option)
                {
                    field("Import Purchase VAT Base"; ImportPurchaseVATBase)
                    {
                        Caption = 'Import Purchase VAT Base (13%)';
                    }
                }
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
    begin
        CompanyInfo.GET;
        CLEAR(PostingDate);
        PostingDate := "VAT Entry".GETFILTER("Posting Date");
    end;

    var
        DocNo: Code[100];
        Vendor: Record "23";
        SupplierName: Text[100];
        ImportPurchAmount: Decimal;
        ImportPurchVATAmount: Decimal;
        CAPEXPurchAmount: Decimal;
        CAPEXPurchVATAmount: Decimal;
        LocalPurchAmount: Decimal;
        LocalPurchVATAmount: Decimal;
        ExemptPurchAmount: Decimal;
        ExemptPurchVATAmount: Decimal;
        CompanyInfo: Record "79";
        PostingDate: Text[100];
        ImportPurchaseVATBase: Boolean;
        TotalPurchaseAmount: Decimal;
        NepaliDate: Text;
        SystemManagement: Codeunit "50000";
        ResponsibilityCenter: Record "5714";
        ResponsibilityCenterName: Text[50];
}

