page 50052 "Posted Assembly Order Entity"
{
    Caption = 'postedassemblyOrders', Locked = true;
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    EntityName = 'postedassemblyOrder';
    EntitySetName = 'postedassemblyOrders';
    InsertAllowed = false;
    ModifyAllowed = false;
    ODataKeyFields = Id;
    PageType = API;
    SourceTable = "Posted Assembly Header";

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
                field(navPostedDocumentNo; "No.")
                {
                    Caption = 'navPostedDocumentNo';
                    Editable = false;
                }
                field(navDocumentNo; "Order No.")
                {
                    Caption = 'navDocumentNo';
                }
                field(batchNo; "Batch No.")
                {
                    ApplicationArea = Assembly;
                    AssistEdit = true;
                    Caption = 'batchNo', Locked = true;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(itemNo; "Item No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'itemNo', Locked = true;
                    Editable = IsAsmToOrderEditable;
                    Importance = Promoted;
                    TableRelation = Item."No." WHERE("Assembly BOM" = CONST(true));
                    ToolTip = 'Specifies the number of the item that is being assembled with the assembly order.';
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
                field(unitofMeasure; "Unit of Measure Code")
                {
                    ApplicationArea = Assembly;
                    Caption = 'unitofMeasure', Locked = true;
                    Editable = true;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
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
                part(postedassemblyOrderLines; 50053)
                {
                    ApplicationArea = All;
                    Caption = 'postedassemblyOrderLines', Locked = true;
                    EntityName = 'postedassemblyOrderLine';
                    EntitySetName = 'postedassemblyOrderLines';
                    SubPageLink = "Document Id" = FIELD(Id);
                }
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    var
        AssemblyHeaderReserve: Codeunit "Assembly Header-Reserve";
    begin
    end;

    var
        [InDataSet]
        IsUnitCostEditable: Boolean;
        [InDataSet]
        IsAsmToOrderEditable: Boolean;
        DraftOrderActionErr: Label 'The action can be applied to a draft order only.', Locked = true;
        CannotFindAssemblyOrderErr: Label 'The assembly order cannot be found.', Locked = true;

    [ServiceEnabled]
    procedure getpostedbatchquantity(ItemNo: Code[20]; BatchNo: Code[20]): Text
    var
        PostedAssemblyHeader: Record "Posted Assembly Header";
    begin
        PostedAssemblyHeader.RESET;
        PostedAssemblyHeader.SETRANGE("Item No.", ItemNo);
        PostedAssemblyHeader.SETRANGE("Batch No.", BatchNo);
        PostedAssemblyHeader.CALCSUMS(Quantity);
        EXIT('{"batch:"' + '"' + FORMAT(PostedAssemblyHeader.Quantity) + '"}');
    end;

    [ServiceEnabled]
    procedure testmsg(): Text
    begin
        EXIT('AF');
    end;
}

