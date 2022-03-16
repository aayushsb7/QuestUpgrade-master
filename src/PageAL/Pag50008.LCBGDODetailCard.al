page 50008 "LC/BG/DO Detail Card"
{
    SourceTable = "LC Details";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Transaction Type"; "Transaction Type")
                {
                }
                field("Document Type"; "Document Type")
                {

                    trigger OnValidate()
                    begin
                        VisibleDocumentType; // << MIN 8/8/2019
                    end;
                }
                field("LC Type"; "LC Type")
                {
                }
                field("No."; "No.")
                {
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit() THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("LC\DO No."; "LC\DO No.")
                {
                    Caption = 'LC\DO\BG No.';
                }
                field("Loan No."; "Loan No.")
                {
                }
                field(Description; Description)
                {
                }
                field("Issued To/Received From"; "Issued To/Received From")
                {
                    Importance = Promoted;

                    trigger OnValidate()
                    var
                        Customer: Record Customer;
                        Vendor: Record Vendor;
                    begin
                        IF "Transaction Type" = "Transaction Type"::Purchase THEN BEGIN
                            Vendor.SETFILTER(Vendor."No.", "Issued To/Received From");
                            IF Vendor.FINDFIRST THEN
                                "Currency Code" := Vendor."Currency Code";
                        END;
                        IF "Transaction Type" = "Transaction Type"::Sale THEN BEGIN
                            Customer.SETFILTER(Customer."No.", "Issued To/Received From");
                            IF Customer.FINDFIRST THEN
                                "Currency Code" := Customer."Currency Code";
                        END;
                    end;
                }
                field("Issued To/Received From Name"; "Issued To/Received From Name")
                {
                }
                field("Issuing Bank"; "Issuing Bank")
                {
                }
                field("Issue Bank Name1"; "Issue Bank Name1")
                {
                }
                group(General1)
                {
                    Visible = BankGuaranteeVisible;
                    field("Tolerance Percentage"; "Tolerance Percentage")
                    {
                    }
                    field("Shipment Date"; "Shipment Date")
                    {
                    }
                    field("Type of LC"; "Type of LC")
                    {
                        Caption = 'Type of LC/BG/DO';

                        trigger OnValidate()
                        begin
                            /*
                            IF "Type of LC" = "Type of LC"::Inland THEN
                              NotEditCurrExch := FALSE
                              ELSE
                              NotEditCurrExch := TRUE;
                            */

                        end;
                    }
                }
                group(General2)
                {
                    Visible = CurrencyCodeVisible;
                    field("Currency Code"; "Currency Code")
                    {
                    }
                    field("Exchange Rate"; "Exchange Rate")
                    {
                    }
                }
                group(General3)
                {
                    Visible = ExpiryDateVisible;
                    field("Expiry Date"; "Expiry Date")
                    {
                    }
                    field("Has Amendment"; "Has Amendment")
                    {
                        Editable = false;
                    }
                    field("BG Type"; "BG Type")
                    {
                        Visible = BankGuaranteeVisible;
                    }
                }
                field(Released; Released)
                {
                }
                field(Closed; Closed)
                {
                }
                field("Date of Issue"; "Date of Issue")
                {
                }
                field("Insured By"; "Insured By")
                {
                }
                field(Incoterms; Incoterms)
                {
                }
                field("LC Open Name"; "LC Open Name")
                {
                }
            }
            group(Invoicing)
            {
                field("LC Value"; "LC Value")
                {
                    Caption = 'LC/BG/DO Value';

                    trigger OnValidate()
                    var
                        Currency: Record Currency;
                    begin
                        //IME.RD
                        // Currency.SETFILTER(Currency."Currency Code","Currency Code");
                        //  IF Currency.FINDFIRST THEN
                        //    "LC Value (LCY)" := ("LC Value" * Currency."Relational Exch. Rate Amount");
                        //IME.RD
                    end;
                }
                field("LC Value (LCY)"; "LC Value (LCY)")
                {
                    Caption = 'LC/BG/DO Value (LCY)';
                }
                field("Purchase LC Utilized Value"; "Purchase LC Utilized Value")
                {
                    Visible = false;
                }
                field("Remaining Value"; "LC Value (LCY)" - "Purchase LC Utilized Value" - "Sales LC Utilized Value")
                {
                    Caption = 'Remaining Value';
                    Visible = false;
                }
            }
            group("LC Values")
            {
                field(Margin; Margin)
                {
                    Visible = PurchaseVisible;
                }
                field(Charge; Charge)
                {
                    Visible = PurchaseVisible;
                }
                field("Document Value"; "Document Value")
                {
                    Visible = PurchaseVisible;
                }
                field("TR Loan"; "TR Loan")
                {
                    Visible = PurchaseVisible;
                }
                field(Commission; Commission)
                {
                    Editable = false;
                }
                field("Sales LC Utilized Value"; "Sales LC Utilized Value")
                {
                    Visible = SalesVisible;
                }
            }
            group(Remark)
            {
                Caption = 'Remarks';
                field(Remarks; Remarks)
                {
                }
                field(Notes; Notes)
                {
                }
            }
            // part(; 50006)
            // {
            //     SubPageLink = "LC No." = FIELD("No.");
            //     Visible = PurchaseVisible;
            // }
        }
        area(factboxes)
        {
            // systempart(; Notes)
            // {
            // }
            // systempart(; MyNotes)
            // {
            // }
            // systempart(; Links)
            // {
            // }
        }
    }

    actions
    {
        area(processing)
        {
            action(Page_Amend)
            {
                Caption = 'A&mendments';
                Image = "Report";
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    LCAmendDetail: Record "LC Amend Detail";
                begin
                    //Opening the LC page.
                    LCAmendDetail.RESET;
                    LCAmendDetail.SETRANGE("No.", "No.");
                    PAGE.RUN(50010, LCAmendDetail);
                end;
            }
            action(Fun_LCRelease)
            {
                Caption = '&Release';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //Calling function in Codeunit 33020011::"Letter of Credit Management" to release the current record
                    IF "Document Type" = "Document Type"::"Letter of Credit" THEN
                        TESTFIELD("Loan No.");
                    TESTFIELD("Issuing Bank");
                    TESTFIELD("LC Value");
                    TESTFIELD("Date of Issue");
                    IF "Document Type" IN ["Document Type"::"Letter of Credit", "Document Type"::"Bank Guarantee"] THEN
                        TESTFIELD("Expiry Date");
                    TESTFIELD("LC\DO No.");
                    ReleaseLC(Rec);
                end;
            }
            action(Fun_LCAmendment)
            {
                Caption = '&Amendemts';
                Image = AdjustEntries;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //Calling function in Codeunit 33020011::"Letter of Credit Management" to amend the current record.
                    AmendLC(Rec);
                end;
            }
            action(Fun_LCClose)
            {
                Caption = '&Close';
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //Calling function in Codeunit 33020011::"Letter of Credit Management" to close the current record.
                    CloseLC(Rec);
                end;
            }
            action(Reopen)
            {

                trigger OnAction()
                begin
                    //Calling function in Codeunit 33020011::"Letter of Credit Management" to reopen the current record.
                    ReopenLC(Rec);
                end;
            }
            action("Create Vendor")
            {
                Image = CreateDocument;
                Promoted = true;
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction()
                begin
                    CreateVendor; //Agile - ZM
                end;
            }
            action(statistics)
            {
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF "Transaction Type" = "Transaction Type"::Sale THEN
            SalesVisible := TRUE;
        IF "Transaction Type" = "Transaction Type"::Purchase THEN
            PurchaseVisible := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Transaction Type" := "Transaction Type"::Purchase;
    end;

    trigger OnOpenPage()
    begin
        IF "Transaction Type" = "Transaction Type"::Sale THEN
            SalesVisible := TRUE;
        IF "Transaction Type" = "Transaction Type"::Purchase THEN
            PurchaseVisible := TRUE;
        VisibleDocumentType; // << MIN 8/8/2019
    end;

    var
        [InDataSet]
        NotEditCurrExch: Boolean;
        SalesVisible: Boolean;
        PurchaseVisible: Boolean;
        BankGuaranteeVisible: Boolean;
        CurrencyCodeVisible: Boolean;
        ExpiryDateVisible: Boolean;

    local procedure VisibleDocumentType()
    begin
        IF "Document Type" = "Document Type"::"  " THEN
            EXIT;
        BankGuaranteeVisible := TRUE;
        CurrencyCodeVisible := TRUE;
        ExpiryDateVisible := TRUE;
        IF ("Document Type" = "Document Type"::"Bank Guarantee") OR ("Document Type" = "Document Type"::DAA) OR ("Document Type" = "Document Type"::DAP) THEN
            BankGuaranteeVisible := FALSE
        ELSE
            BankGuaranteeVisible := TRUE;

        IF ("Document Type" = "Document Type"::"Bank Guarantee") THEN
            CurrencyCodeVisible := FALSE
        ELSE
            CurrencyCodeVisible := TRUE;

        IF ("Document Type" = "Document Type"::DAA) OR ("Document Type" = "Document Type"::DAP) THEN
            ExpiryDateVisible := FALSE
        ELSE
            ExpiryDateVisible := TRUE;
    end;
}

