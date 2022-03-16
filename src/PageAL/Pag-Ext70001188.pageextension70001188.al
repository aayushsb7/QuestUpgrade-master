pageextension 50066 "pageextension70001188" extends "Purchase Invoice Entity"
{
    layout
    {
        modify(pdfDocument)
        {

            //Unsupported feature: Property Modification (ControlType) on "pdfDocument(Control 9)".


            //Unsupported feature: Property Modification (Name) on "pdfDocument(Control 9)".

            Caption = 'paymentTerms', Locked = true;

            //Unsupported feature: Property Insertion (SourceExpr) on "pdfDocument(Control 9)".

        }

        //Unsupported feature: Property Deletion (Editable) on "id(Control 3)".


        //Unsupported feature: Code Insertion on "paymentTerms(Control 9)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        RegisterFieldSet(FIELDNO("Payment Terms Code"));
        */
        //end;

        //Unsupported feature: Property Deletion (SubPageLink) on "pdfDocument(Control 9)".


        //Unsupported feature: Property Deletion (PagePartID) on "pdfDocument(Control 9)".


        //Unsupported feature: Property Deletion (EntitySetName) on "pdfDocument(Control 9)".


        //Unsupported feature: Property Deletion (EntityName) on "pdfDocument(Control 9)".


        //Unsupported feature: Property Deletion (PartType) on "pdfDocument(Control 9)".



        //Unsupported feature: Code Modification on "discountAmount(Control 12).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        RegisterFieldSet(FIELDNO("Invoice Discount Amount"));
        InvoiceDiscountAmount := "Invoice Discount Amount";
        DiscountAmountSet := TRUE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        RegisterFieldSet(FIELDNO("Invoice Discount Amount"));
        */
        //end;
        addafter(pdfDocument)
        {
            field(shipmentMethod; "Shipment Method Code")
            {
                ApplicationArea = All;
                Caption = 'shipmentMethod', Locked = true;

                trigger OnValidate()
                begin
                    RegisterFieldSet(FIELDNO("Shipment Method Code"));
                end;
            }
        }
        moveafter(currencyCode; pdfDocument)
    }


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetCalculatedFields;
    IF HasWritePermission THEN
      PurchInvAggregator.RedistributeInvoiceDiscounts(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetCalculatedFields;
    PurchInvAggregator.RedistributeInvoiceDiscounts(Rec);
    */
    //end;


    //Unsupported feature: Code Modification on "OnInsertRecord".

    //trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CheckVendor;
    ProcessBillingPostalAddress;

    PurchInvAggregator.PropagateOnInsert(Rec,TempFieldBuffer);
    UpdateDiscount;

    SetCalculatedFields;

    PurchInvAggregator.RedistributeInvoiceDiscounts(Rec);

    EXIT(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    #7..11
    */
    //end;


    //Unsupported feature: Code Modification on "OnModifyRecord".

    //trigger OnModifyRecord(): Boolean
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF xRec.Id <> Id THEN
      ERROR(CannotChangeIDErr);

    ProcessBillingPostalAddress;

    PurchInvAggregator.PropagateOnModify(Rec,TempFieldBuffer);
    UpdateDiscount;

    SetCalculatedFields;

    PurchInvAggregator.RedistributeInvoiceDiscounts(Rec);

    EXIT(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    #8..13
    */
    //end;


    //Unsupported feature: Code Modification on "ClearCalculatedFields(PROCEDURE 10)".

    //procedure ClearCalculatedFields();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CLEAR(BillingPostalAddressJSONText);
    CLEAR(InvoiceDiscountAmount);
    CLEAR(DiscountAmountSet);
    TempFieldBuffer.DELETEALL;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CLEAR(BillingPostalAddressJSONText);
    TempFieldBuffer.DELETEALL;
    */
    //end;

    //Unsupported feature: Property Deletion (ChangeTrackingAllowed).

}

