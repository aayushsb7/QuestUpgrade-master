page 50037 "Assembly Order Entity"
{
    Caption = 'assemblyOrders', Locked = true;
    DelayedInsert = true;
    EntityName = 'assemblyOrder';
    EntitySetName = 'assemblyOrders';
    ODataKeyFields = Id;
    PageType = API;
    SourceTable = "Assembly Header";
    SourceTableView = WHERE("Document Type" = CONST(Order));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field(Id; Id)
                {
                }
                field(documentType; "Document Type")
                {
                    Caption = 'documentType';
                }
                field(navDocumentNo; "No.")
                {
                    Caption = 'navDocumentNo';
                    Editable = false;
                }
                field(batchNo; "Batch No.")
                {
                    ApplicationArea = Assembly;
                    AssistEdit = true;
                    Caption = 'batchNo', Locked = true;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(itemNo; "Item No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'itemNo', Locked = true;
                    Editable = IsAsmToOrderEditable;
                    Importance = Promoted;
                    TableRelation = Item."No." WHERE("Assembly BOM" = CONST(true));
                    ToolTip = 'Specifies the number of the item that is being assembled with the assembly order.';

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field(manufacturingDate; "Manufacturing Date")
                {
                    Caption = 'manufacturingDate', Locked = true;
                }
                field(expiryDate; "Expiry Date")
                {
                    Caption = 'expiryDate', Locked = true;
                }
                field(locationCode; "Location Code")
                {
                    ApplicationArea = Location;
                    Caption = 'locationCode', Locked = true;
                    Importance = Promoted;
                    ToolTip = 'Specifies the location to which you want to post output of the assembly item.';
                }
                field(itemName; Description)
                {
                    ApplicationArea = Assembly;
                    Caption = 'itemName', Locked = true;
                    ToolTip = 'Specifies the description of the assembly item.';
                }
                field(quantity; Quantity)
                {
                    ApplicationArea = Assembly;
                    Caption = 'quantity', Locked = true;
                    Editable = true;
                    Importance = Promoted;
                    ToolTip = 'Specifies how many units of the assembly item that you expect to assemble with the assembly order.';
                }
                field(quantitytoAssemble; "Quantity to Assemble")
                {
                    ApplicationArea = Assembly;
                    Caption = 'quantitytoAssemble', Locked = true;
                    Importance = Promoted;
                    ToolTip = 'Specifies how many of the assembly item units you want to partially post. To post the full quantity on the assembly order, leave the field unchanged.';
                }
                field(unitofMeasure; "Unit of Measure Code")
                {
                    ApplicationArea = Assembly;
                    Caption = 'unitofMeasure', Locked = true;
                    Editable = true;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                }
                field(startingDate; "Starting Date")
                {
                    Caption = 'startingDate';
                }
                field(endingDate; "Ending Date")
                {
                    Caption = 'endingDate';
                }
                field(postingDate; "Posting Date")
                {
                    ApplicationArea = Assembly;
                    Caption = 'postingDate', Locked = true;
                    Importance = Promoted;
                    ToolTip = 'Specifies the date on which the assembly order is posted.';
                }
                field(dueDate; "Due Date")
                {
                    Caption = 'dueDate';
                }
                field(status; Status)
                {
                    ApplicationArea = Assembly;
                    Caption = 'status', Locked = true;
                    ToolTip = 'Specifies if the document is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.';
                }
                part(assemblyOrderLines; 50038)
                {
                    ApplicationArea = All;
                    Caption = 'assemblyOrderLines', Locked = true;
                    EntityName = 'assemblyOrderLine';
                    EntitySetName = 'assemblyOrderLines';
                    SubPageLink = "Document Id" = FIELD(Id);
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        IsUnitCostEditable := NOT IsStandardCostItem;
        IsAsmToOrderEditable := NOT IsAsmToOrder;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        AssemblyHeaderReserve: Codeunit "Assembly Header-Reserve";
    begin
        TESTFIELD("Assemble to Order", FALSE);
        IF (Quantity <> 0) AND ItemExists("Item No.") THEN BEGIN
            COMMIT;
            IF NOT AssemblyHeaderReserve.DeleteLineConfirm(Rec) THEN
                EXIT(FALSE);
            AssemblyHeaderReserve.DeleteLine(Rec);
        END;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Document Type" := "Document Type"::Order;
        "Assigned User ID" := USERID;
        "External Entry" := TRUE;
        "Last Date Modified" := TODAY;
        "Last Time Modified" := TIME;
        TESTFIELD("Batch No.");

        AssemblyHdr.RESET;
        AssemblyHdr.SETRANGE("Batch No.", "Batch No.");
        AssemblyHdr.SETFILTER("No.", '<>%1', "No.");
        IF AssemblyHdr.FINDFIRST THEN
            ERROR('Batch No. %1 has been already created in Assembly Order No. %2', "Batch No.", AssemblyHdr."No.");
    end;

    trigger OnModifyRecord(): Boolean
    begin
        IF "Quantity to Assemble" <> xRec."Quantity to Assemble" THEN
            VALIDATE("Quantity to Assemble");
    end;

    trigger OnOpenPage()
    begin
        IsUnitCostEditable := TRUE;
        IsAsmToOrderEditable := TRUE;

        UpdateWarningOnLines;
    end;

    var
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        [InDataSet]
        IsUnitCostEditable: Boolean;
        [InDataSet]
        IsAsmToOrderEditable: Boolean;
        DraftOrderActionErr: Label 'The action can be applied to a draft order only.', Locked = true;
        CannotFindAssemblyOrderErr: Label 'The assembly order cannot be found.', Locked = true;
        AssemblyHdr: Record "Assembly Header";

    local procedure PostInvoice(var AssemblyHeader: Record "Assembly Header"; var PostedAssemblyHeader: Record "Posted Assembly Header")
    var
        DummyO365SalesDocument: Record "O365 Sales Document";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        O365SendResendInvoice: Codeunit "O365 Send + Resend Invoice";
        PreAssignedNo: Code[20];
    begin
        //O365SendResendInvoice.CheckDocumentIfNoItemsExists(PurchaseHeader,FALSE,DummyO365SalesDocument);
        LinesInstructionMgt.AssemblyCheckAllLinesHaveQuantityPerAssigned(AssemblyHeader);
        PreAssignedNo := AssemblyHeader."No.";
        AssemblyHeader.SendToPosting(CODEUNIT::"Assembly-Post");
        PostedAssemblyHeader.SETCURRENTKEY("Order No.");
        PostedAssemblyHeader.SETRANGE("Order No.", PreAssignedNo);
        PostedAssemblyHeader.FINDFIRST;
    end;

    local procedure SetActionResponse(var ActionContext: DotNet WebServiceActionContext; OrderId: Guid)
    var
        ODataActionManagement: Codeunit "OData Action Management";
    begin
        ODataActionManagement.AddKey(FIELDNO(Id), OrderId);
        ODataActionManagement.SetDeleteResponseLocation(ActionContext, PAGE::"Assembly Order Entity");
    end;

    [ServiceEnabled]
    procedure Post(var ActionContext: DotNet WebServiceActionContext)
    var
        AssemblyHeader: Record "Assembly Header";
        PostedAssemblyHeader: Record "Posted Assembly Header";
    begin
        GetDraftInvoice(AssemblyHeader);
        PostInvoice(AssemblyHeader, PostedAssemblyHeader);
        SetActionResponse(ActionContext, PostedAssemblyHeader.Id);
    end;

    local procedure GetDraftInvoice(var AssemblyHeader: Record "Assembly Header")
    begin
        AssemblyHeader.SETRANGE(Id, Id);
        IF NOT AssemblyHeader.FINDFIRST THEN
            ERROR(CannotFindAssemblyOrderErr);
    end;
}

