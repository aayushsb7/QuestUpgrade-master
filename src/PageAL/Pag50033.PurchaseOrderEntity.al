page 50033 "Purchase Order Entity"
{
    Caption = 'purchaseOrders', Locked = true;
    DelayedInsert = true;
    EntityName = 'purchaseOrder';
    EntitySetName = 'purchaseOrders';
    ODataKeyFields = Id;
    PageType = API;
    SourceTable = "Purch. Inv. Entity Aggregate";
    SourceTableView = WHERE("Document Type" = CONST(Order),
                            Posted = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; Id)
                {
                    ApplicationArea = All;
                    Caption = 'id', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(FIELDNO(Id));
                    end;
                }
                field(number; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Number', Locked = true;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(FIELDNO("No."));
                    end;
                }
                field(invoiceDate; "Document Date")
                {
                    ApplicationArea = All;
                    Caption = 'invoiceDate', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(FIELDNO("Document Date"));
                        WORKDATE("Document Date"); // TODO: replicate page logic and set other dates appropriately
                    end;
                }
                field(dueDate; "Due Date")
                {
                    ApplicationArea = All;
                    Caption = 'dueDate', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(FIELDNO("Due Date"));
                    end;
                }
                field(vendorInvoiceNumber; "Vendor Invoice No.")
                {
                    ApplicationArea = All;
                    Caption = 'vendorInvoiceNumber', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(FIELDNO("Vendor Invoice No."));
                    end;
                }
                field(vendorId; "Vendor Id")
                {
                    ApplicationArea = All;
                    Caption = 'vendorId', Locked = true;

                    trigger OnValidate()
                    begin
                        Vendor.SETRANGE(Id, "Vendor Id");
                        IF NOT Vendor.FINDFIRST THEN
                            ERROR(CouldNotFindVendorErr);

                        "Buy-from Vendor No." := Vendor."No.";
                        RegisterFieldSet(FIELDNO("Vendor Id"));
                        RegisterFieldSet(FIELDNO("Buy-from Vendor No."));
                    end;
                }
                field(vendorNumber; "Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                    Caption = 'vendorNumber', Locked = true;

                    trigger OnValidate()
                    begin
                        IF Vendor."No." <> '' THEN
                            EXIT;

                        IF NOT Vendor.GET("Buy-from Vendor No.") THEN
                            ERROR(CouldNotFindVendorErr);

                        "Vendor Id" := Vendor.Id;
                        RegisterFieldSet(FIELDNO("Vendor Id"));
                        RegisterFieldSet(FIELDNO("Buy-from Vendor No."));
                    end;
                }
                field(vendorName; "Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                    Caption = 'vendorName', Locked = true;
                }
                field(buyFromAddress; BillingPostalAddressJSONText)
                {
                    ApplicationArea = All;
                    Caption = 'buyFromAddress', Locked = true;
                    ODataEDMType = 'POSTALADDRESS';
                    ToolTip = 'Specifies the billing address of the Purchase Invoice.';

                    trigger OnValidate()
                    begin
                        BillingPostalAddressSet := TRUE;
                    end;
                }
                field(currencyCode; CurrencyCodeTxt)
                {
                    ApplicationArea = All;
                    Caption = 'currencyCode', Locked = true;

                    trigger OnValidate()
                    begin
                        "Currency Code" :=
                          GraphMgtGeneralTools.TranslateCurrencyCodeToNAVCurrencyCode(
                            LCYCurrencyCode, COPYSTR(CurrencyCodeTxt, 1, MAXSTRLEN(LCYCurrencyCode)));
                        RegisterFieldSet(FIELDNO("Currency Code"));
                    end;
                }
                field(paymentTerms; "Payment Terms Code")
                {
                    ApplicationArea = All;
                    Caption = 'paymentTerms', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(FIELDNO("Payment Terms Code"));
                    end;
                }
                field(shipmentMethod; "Shipment Method Code")
                {
                    ApplicationArea = All;
                    Caption = 'shipmentMethod', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(FIELDNO("Shipment Method Code"));
                    end;
                }
                field(pricesIncludeTax; "Prices Including VAT")
                {
                    ApplicationArea = All;
                    Caption = 'pricesIncludeTax', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(FIELDNO("Prices Including VAT"));
                    end;
                }
                part(purchaseOrderLines; 50034)
                {
                    ApplicationArea = All;
                    Caption = 'purchaseOrderLines', Locked = true;
                    EntityName = 'purchaseOrderLine';
                    EntitySetName = 'purchaseOrderLines';
                    SubPageLink = "Document Id" = FIELD(Id);
                }
                field(discountAmount; "Invoice Discount Amount")
                {
                    ApplicationArea = All;
                    Caption = 'discountAmount', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(FIELDNO("Invoice Discount Amount"));
                    end;
                }
                field(discountAppliedBeforeTax; "Discount Applied Before Tax")
                {
                    ApplicationArea = All;
                    Caption = 'discountAppliedBeforeTax', Locked = true;
                }
                field(totalAmountExcludingTax; Amount)
                {
                    ApplicationArea = All;
                    Caption = 'totalAmountExcludingTax', Locked = true;
                    Editable = false;
                }
                field(totalTaxAmount; "Total Tax Amount")
                {
                    ApplicationArea = All;
                    Caption = 'totalTaxAmount', Locked = true;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(FIELDNO("Total Tax Amount"));
                    end;
                }
                field(totalAmountIncludingTax; "Amount Including VAT")
                {
                    ApplicationArea = All;
                    Caption = 'totalAmountIncludingTax', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(FIELDNO("Amount Including VAT"));
                    end;
                }
                field(status; Status)
                {
                    ApplicationArea = All;
                    Caption = 'status', Locked = true;
                    Editable = false;
                }
                field(lastModifiedDateTime; "Last Modified Date Time")
                {
                    ApplicationArea = All;
                    Caption = 'lastModifiedDateTime', Locked = true;
                }
                part(purchaseChangeLogs; 50039)
                {
                    ApplicationArea = All;
                    Caption = 'purchaseChangeLogs', Locked = true;
                    EntityName = 'purchaseChangeLog';
                    EntitySetName = 'purchaseChangeLogs';
                    SubPageLink = "Purchase Document ID" = FIELD(Id);
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        PurchInvAggregator: Codeunit "Purch. Inv. Aggregator";
    begin
        SetCalculatedFields;
        PurchInvAggregator.RedistributeInvoiceDiscounts(Rec);
    end;

    trigger OnDeleteRecord(): Boolean
    var
        PurchInvAggregator: Codeunit "Purch. Inv. Aggregator";
    begin
        PurchInvAggregator.PropagateOnDelete(Rec);

        EXIT(FALSE);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        PurchInvAggregator: Codeunit "Purch. Inv. Aggregator";
    begin
        CheckVendor;
        ProcessBillingPostalAddress;

        PurchInvAggregator.PropagateOnInsert(Rec, TempFieldBuffer);
        SetCalculatedFields;

        PurchInvAggregator.RedistributeInvoiceDiscounts(Rec);

        EXIT(FALSE);
    end;

    trigger OnModifyRecord(): Boolean
    var
        PurchInvAggregator: Codeunit "Purch. Inv. Aggregator";
    begin
        IF xRec.Id <> Id THEN
            ERROR(CannotChangeIDErr);

        ProcessBillingPostalAddress;

        PurchInvAggregator.PropagateOnModify(Rec, TempFieldBuffer);

        SetCalculatedFields;

        PurchInvAggregator.RedistributeInvoiceDiscounts(Rec);

        EXIT(FALSE);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ClearCalculatedFields;
    end;

    var
        TempFieldBuffer: Record "Field Buffer" temporary;
        Vendor: Record Vendor;
        GraphMgtGeneralTools: Codeunit "Graph Mgt - General Tools";
        LCYCurrencyCode: Code[10];
        CurrencyCodeTxt: Text;
        BillingPostalAddressJSONText: Text;
        BillingPostalAddressSet: Boolean;
        CannotChangeIDErr: Label 'The id cannot be changed.', Locked = true;
        VendorNotProvidedErr: Label 'A vendorNumber or a vendorID must be provided.', Locked = true;
        CouldNotFindVendorErr: Label 'The vendor cannot be found.', Locked = true;
        "----SRT--": Integer;
        CustomerNotProvidedErr: Label 'A customerNumber or a customerId must be provided.', Locked = true;
        CustomerValuesDontMatchErr: Label 'The customer values do not match to a specific Customer.', Locked = true;
        CouldNotFindCustomerErr: Label 'The customer cannot be found.', Locked = true;
        ContactIdHasToHaveValueErr: Label 'Contact Id must have a value set.', Locked = true;
        CurrencyValuesDontMatchErr: Label 'The currency values do not match to a specific Currency.', Locked = true;
        CurrencyIdDoesNotMatchACurrencyErr: Label 'The "currencyId" does not match to a Currency.', Locked = true;
        CurrencyCodeDoesNotMatchACurrencyErr: Label 'The "currencyCode" does not match to a Currency.', Locked = true;
        PaymentTermsValuesDontMatchErr: Label 'The payment terms values do not match to a specific Payment Terms.', Locked = true;
        PaymentTermsIdDoesNotMatchAPaymentTermsErr: Label 'The "paymentTermsId" does not match to a Payment Terms.', Locked = true;
        PaymentTermsCodeDoesNotMatchAPaymentTermsErr: Label 'The "paymentTermsCode" does not match to a Payment Terms.', Locked = true;
        ShipmentMethodValuesDontMatchErr: Label 'The shipment method values do not match to a specific Shipment Method.', Locked = true;
        ShipmentMethodIdDoesNotMatchAShipmentMethodErr: Label 'The "shipmentMethodId" does not match to a Shipment Method.', Locked = true;
        ShipmentMethodCodeDoesNotMatchAShipmentMethodErr: Label 'The "shipmentMethodCode" does not match to a Shipment Method.', Locked = true;
        PostedInvoiceActionErr: Label 'The action can be applied to a posted invoice only.', Locked = true;
        DraftInvoiceActionErr: Label 'The action can be applied to a draft invoice only.', Locked = true;
        CannotFindInvoiceErr: Label 'The invoice cannot be found.', Locked = true;
        CancelingInvoiceFailedCreditMemoCreatedAndPostedErr: Label 'Canceling the invoice failed because of the following error: \\%1\\A credit memo is posted.', Locked = true;
        CancelingInvoiceFailedCreditMemoCreatedButNotPostedErr: Label 'Canceling the invoice failed because of the following error: \\%1\\A credit memo is created but not posted.', Locked = true;
        CancelingInvoiceFailedNothingCreatedErr: Label 'Canceling the invoice failed because of the following error: \\%1.', Locked = true;
        EmptyEmailErr: Label 'The send-to email is empty. Specify email either for the customer or for the invoice in email preview.', Locked = true;
        AlreadyCanceledErr: Label 'The invoice cannot be canceled because it has already been canceled.', Locked = true;
        MailNotConfiguredErr: Label 'An email account must be configured to send emails.', Locked = true;
        "----SRT-----": Integer;
        CorrectPostedpurchaseinvoice: Codeunit "Correct Posted Purch. Invoice";

    local procedure SetCalculatedFields()
    var
        GraphMgtPurchaseInvoice: Codeunit "Graph Mgt - Purchase Invoice";
    begin
        BillingPostalAddressJSONText := GraphMgtPurchaseInvoice.PayToVendorAddressToJSON(Rec);
        CurrencyCodeTxt := GraphMgtGeneralTools.TranslateNAVCurrencyCodeToCurrencyCode(LCYCurrencyCode, "Currency Code");
    end;

    local procedure ClearCalculatedFields()
    begin
        CLEAR(BillingPostalAddressJSONText);
        TempFieldBuffer.DELETEALL;
    end;

    local procedure RegisterFieldSet(FieldNo: Integer)
    var
        LastOrderNo: Integer;
    begin
        LastOrderNo := 1;
        IF TempFieldBuffer.FINDLAST THEN
            LastOrderNo := TempFieldBuffer.Order + 1;

        CLEAR(TempFieldBuffer);
        TempFieldBuffer.Order := LastOrderNo;
        TempFieldBuffer."Table ID" := DATABASE::"Purch. Inv. Entity Aggregate";
        TempFieldBuffer."Field ID" := FieldNo;
        TempFieldBuffer.INSERT;
    end;

    local procedure CheckVendor()
    var
        BlankGUID: Guid;
    begin
        IF ("Buy-from Vendor No." = '') AND
           ("Vendor Id" = BlankGUID)
        THEN
            ERROR(VendorNotProvidedErr);
    end;

    local procedure ProcessBillingPostalAddress()
    var
        GraphMgtPurchaseInvoice: Codeunit "Graph Mgt - Purchase Invoice";
    begin
        IF NOT BillingPostalAddressSet THEN
            EXIT;

        GraphMgtPurchaseInvoice.ProcessComplexTypes(Rec, BillingPostalAddressJSONText);

        IF xRec."Buy-from Address" <> "Buy-from Address" THEN
            RegisterFieldSet(FIELDNO("Buy-from Address"));

        IF xRec."Buy-from Address 2" <> "Buy-from Address 2" THEN
            RegisterFieldSet(FIELDNO("Buy-from Address 2"));

        IF xRec."Buy-from City" <> "Buy-from City" THEN
            RegisterFieldSet(FIELDNO("Buy-from City"));

        IF xRec."Buy-from Country/Region Code" <> "Buy-from Country/Region Code" THEN
            RegisterFieldSet(FIELDNO("Buy-from Country/Region Code"));

        IF xRec."Buy-from Post Code" <> "Buy-from Post Code" THEN
            RegisterFieldSet(FIELDNO("Buy-from Post Code"));

        IF xRec."Buy-from County" <> "Buy-from County" THEN
            RegisterFieldSet(FIELDNO("Buy-from County"));
    end;

    local procedure "-------SRT--"()
    begin
    end;

    local procedure GetPostedInvoice(var PurchaseInvoiceHeader: Record "Purch. Inv. Header")
    begin
        IF NOT Posted THEN
            ERROR(PostedInvoiceActionErr);

        PurchaseInvoiceHeader.SETRANGE(Id, Id);
        IF NOT PurchaseInvoiceHeader.FINDFIRST THEN
            ERROR(CannotFindInvoiceErr);
    end;

    local procedure GetDraftInvoice(var PurchaseHeader: Record "Purchase Header")
    begin
        IF Posted THEN
            ERROR(DraftInvoiceActionErr);

        PurchaseHeader.SETRANGE(Id, Id);
        IF NOT PurchaseHeader.FINDFIRST THEN
            ERROR(CannotFindInvoiceErr);
    end;

    local procedure CheckSmtpMailSetup()
    var
        O365SetupEmail: Codeunit "O365 Setup Email";
    begin
        IF NOT O365SetupEmail.SMTPEmailIsSetUp THEN
            ERROR(MailNotConfiguredErr);
    end;

    local procedure CheckSendToEmailAddress(DocumentNo: Code[20])
    begin
        IF GetSendToEmailAddress(DocumentNo) = '' THEN
            ERROR(EmptyEmailErr);
    end;

    local procedure GetSendToEmailAddress(DocumentNo: Code[20]): Text[250]
    var
        EmailAddress: Text[250];
    begin
        EmailAddress := GetDocumentEmailAddress(DocumentNo);
        IF EmailAddress <> '' THEN
            EXIT(EmailAddress);
        EmailAddress := GetCustomerEmailAddress;
        EXIT(EmailAddress);
    end;

    local procedure GetCustomerEmailAddress(): Text[250]
    begin
        IF NOT Vendor.GET("Buy-from Vendor No.") THEN
            EXIT('');
        EXIT(Vendor."E-Mail");
    end;

    local procedure GetDocumentEmailAddress(DocumentNo: Code[20]): Text[250]
    var
        EmailParameter: Record "Email Parameter";
    begin
        IF NOT EmailParameter.GET(DocumentNo, "Document Type", EmailParameter."Parameter Type"::Address) THEN
            EXIT('');
        EXIT(EmailParameter."Parameter Value");
    end;

    local procedure CheckInvoiceCanBeCanceled(var PurchaseInvoiceHeader: Record "Purch. Inv. Header")
    var
        CorrectPostedSalesInvoice: Codeunit "Correct Posted Sales Invoice";
    begin
        IF IsInvoiceCanceled THEN
            ERROR(AlreadyCanceledErr);
        CorrectPostedpurchaseinvoice.TestCorrectInvoiceIsAllowed(PurchaseInvoiceHeader, TRUE);
    end;

    local procedure IsInvoiceCanceled(): Boolean
    begin
        EXIT(Status = Status::Canceled);
    end;

    local procedure PostInvoice(var PurchaseHeader: Record "Purchase Header"; var PurchaseInvoiceHeader: Record "Purch. Inv. Header")
    var
        DummyO365SalesDocument: Record "O365 Sales Document";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        O365SendResendInvoice: Codeunit "O365 Send + Resend Invoice";
        PreAssignedNo: Code[20];
    begin
        //O365SendResendInvoice.CheckDocumentIfNoItemsExists(PurchaseHeader,FALSE,DummyO365SalesDocument);
        LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(PurchaseHeader);
        PreAssignedNo := PurchaseHeader."No.";
        PurchaseHeader.SendToPosting(CODEUNIT::"Purch.-Post");
        PurchaseInvoiceHeader.SETCURRENTKEY("Pre-Assigned No.");
        PurchaseInvoiceHeader.SETRANGE("Pre-Assigned No.", PreAssignedNo);
        PurchaseInvoiceHeader.FINDFIRST;
    end;

    local procedure SendPostedInvoice(var PurchaseInvoiceHeader: Record "Purch. Inv. Header")
    var
        GraphIntBusinessProfile: Codeunit "Graph Int - Business Profile";
    begin
        CheckSmtpMailSetup;
        CheckSendToEmailAddress(PurchaseInvoiceHeader."No.");
        GraphIntBusinessProfile.SyncFromGraphSynchronously;

        PurchaseInvoiceHeader.SETRECFILTER;
        //PurchaseInvoiceHeader.EmailRecords(FALSE);
    end;

    local procedure SendDraftInvoice(var PurchaseHeader: Record "Purchase Header")
    var
        DummyO365SalesDocument: Record "O365 Sales Document";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        O365SendResendInvoice: Codeunit "O365 Send + Resend Invoice";
        GraphIntBusinessProfile: Codeunit "Graph Int - Business Profile";
    begin
        //O365SendResendInvoice.CheckDocumentIfNoItemsExists(PurchaseHeader,FALSE,DummyO365SalesDocument);
        LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(PurchaseHeader);
        CheckSmtpMailSetup;
        CheckSendToEmailAddress(PurchaseHeader."No.");

        GraphIntBusinessProfile.SyncFromGraphSynchronously;
        PurchaseHeader.SETRECFILTER;
        //PurchaseHeader.EmailRecords(FALSE);
    end;

    local procedure SendCanceledInvoice(var PurchaseInvoiceHeader: Record "Purch. Inv. Header")
    var
        JobQueueEntry: Record "Job Queue Entry";
        GraphIntBusinessProfile: Codeunit "Graph Int - Business Profile";
    begin
        CheckSmtpMailSetup;
        CheckSendToEmailAddress(PurchaseInvoiceHeader."No.");
        GraphIntBusinessProfile.SyncFromGraphSynchronously;

        JobQueueEntry.INIT;
        JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
        //JobQueueEntry."Object ID to Run" := CODEUNIT::"O365 Purchase Cancel Invoice";
        JobQueueEntry."Maximum No. of Attempts to Run" := 3;
        JobQueueEntry."Record ID to Process" := PurchaseInvoiceHeader.RECORDID;
        CODEUNIT.RUN(CODEUNIT::"Job Queue - Enqueue", JobQueueEntry);
    end;

    local procedure CancelInvoice(var PurchaseInvoiceHeader: Record "Purch. Inv. Header")
    var
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        PurchaseHeader: Record "Purchase Header";
    begin
        GetPostedInvoice(PurchaseInvoiceHeader);
        CheckInvoiceCanBeCanceled(PurchaseInvoiceHeader);
        IF NOT CODEUNIT.RUN(CODEUNIT::"Correct Posted Sales Invoice", PurchaseInvoiceHeader) THEN BEGIN
            PurchCrMemoHeader.SETRANGE("Applies-to Doc. No.", PurchaseInvoiceHeader."No.");
            IF PurchCrMemoHeader.FINDFIRST THEN
                ERROR(CancelingInvoiceFailedCreditMemoCreatedAndPostedErr, GETLASTERRORTEXT);
            PurchaseHeader.SETRANGE("Applies-to Doc. No.", PurchaseInvoiceHeader."No.");
            IF PurchaseHeader.FINDFIRST THEN
                ERROR(CancelingInvoiceFailedCreditMemoCreatedButNotPostedErr, GETLASTERRORTEXT);
            ERROR(CancelingInvoiceFailedNothingCreatedErr, GETLASTERRORTEXT);
        END;
    end;

    local procedure SetActionResponse(var ActionContext: DotNet WebServiceActionContext; InvoiceId: Guid)
    var
        ODataActionManagement: Codeunit "OData Action Management";
    begin
        ODataActionManagement.AddKey(FIELDNO(Id), InvoiceId);
        ODataActionManagement.SetDeleteResponseLocation(ActionContext, PAGE::"Purchase Order Entity");
    end;

    [ServiceEnabled]
    procedure Post(var ActionContext: DotNet WebServiceActionContext)
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseInvoiceHeader: Record "Purch. Inv. Header";
    begin
        GetDraftInvoice(PurchaseHeader);
        PostInvoice(PurchaseHeader, PurchaseInvoiceHeader);
        SetActionResponse(ActionContext, PurchaseInvoiceHeader.Id);
    end;

    [ServiceEnabled]
    procedure PostAndSend(var ActionContext: DotNet WebServiceActionContext)
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseInvoiceHeader: Record "Purch. Inv. Header";
    begin
        GetDraftInvoice(PurchaseHeader);
        PostInvoice(PurchaseHeader, PurchaseInvoiceHeader);
        COMMIT;
        SendPostedInvoice(PurchaseInvoiceHeader);
        SetActionResponse(ActionContext, PurchaseInvoiceHeader.Id);
    end;

    [ServiceEnabled]
    procedure Send(var ActionContext: DotNet WebServiceActionContext)
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseInvoiceHeader: Record "Purch. Inv. Header";
    begin
        IF Posted THEN BEGIN
            GetPostedInvoice(PurchaseInvoiceHeader);
            IF IsInvoiceCanceled THEN
                SendCanceledInvoice(PurchaseInvoiceHeader)
            ELSE
                SendPostedInvoice(PurchaseInvoiceHeader);
            SetActionResponse(ActionContext, PurchaseInvoiceHeader.Id);
            EXIT;
        END;
        GetDraftInvoice(PurchaseHeader);
        SendDraftInvoice(PurchaseHeader);
        SetActionResponse(ActionContext, PurchaseHeader.Id);
    end;

    [ServiceEnabled]
    procedure Cancel(var ActionContext: DotNet WebServiceActionContext)
    var
        PurchaseInvoiceHeader: Record "Purch. Inv. Header";
    begin
        GetPostedInvoice(PurchaseInvoiceHeader);
        CancelInvoice(PurchaseInvoiceHeader);
        SetActionResponse(ActionContext, PurchaseInvoiceHeader.Id);
    end;

    [ServiceEnabled]
    procedure CancelAndSend(var ActionContext: DotNet WebServiceActionContext)
    var
        PurchaseInvoiceHeader: Record "Purch. Inv. Header";
    begin
        GetPostedInvoice(PurchaseInvoiceHeader);
        CancelInvoice(PurchaseInvoiceHeader);
        SendCanceledInvoice(PurchaseInvoiceHeader);
        SetActionResponse(ActionContext, PurchaseInvoiceHeader.Id);
    end;
}

