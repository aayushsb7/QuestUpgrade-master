page 50038 "Assembly Order Subform Entity"
{
    AutoSplitKey = false;
    Caption = 'Assembly Order Subform Entity';
    DelayedInsert = true;
    //The property 'EntityName' can only be set if the property 'PageType' is set to 'API'
    //EntityName = 'assemblyOrderLines';
    //The property 'EntitySetName' can only be set if the property 'PageType' is set to 'API'
    //EntitySetName = 'assemblyOrderLines';
    PageType = ListPart;
    PopulateAllFields = true;
    SourceTable = "Assembly Line";
    SourceTableTemporary = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(navdocumentID; "Document Id")
                {
                    Caption = 'navdocumentID', Locked = true;
                }
                field(navDocumentNo; "Document No.")
                {
                    Caption = 'navdocumentNo', Locked = true;
                }
                field(lineNo; "Line No.")
                {
                    Caption = 'lineNo', Locked = true;
                }
                field(type; Type)
                {
                    ApplicationArea = Assembly;
                    Caption = 'type', Locked = true;
                    ToolTip = 'Specifies if the assembly order line is of type Item or Resource.';

                    trigger OnValidate()
                    begin
                        Type := Type::Item;
                    end;
                }
                field(itemNo; "No.")
                {
                    ApplicationArea = Assembly;
                    Caption = 'itemNo', Locked = true;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';

                    trigger OnValidate()
                    begin
                        ReserveItem;
                    end;
                }
                field(itemName; Description)
                {
                    ApplicationArea = Assembly;
                    Caption = 'itemName', Locked = true;
                    ToolTip = 'Specifies the description of the assembly component.';
                }
                field(locationCode; "Location Code")
                {
                    ApplicationArea = Location;
                    Caption = 'locationCode', Locked = true;
                    ToolTip = 'Specifies the location from which you want to post consumption of the assembly component.';

                    trigger OnValidate()
                    begin
                        ReserveItem;
                    end;
                }
                field(unitofMeasureCode; "Unit of Measure Code")
                {
                    ApplicationArea = Assembly;
                    Caption = 'unitofMeasureCode', Locked = true;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';

                    trigger OnValidate()
                    begin
                        ReserveItem;
                    end;
                }
                field(quantityPer; "Quantity per")
                {
                    ApplicationArea = Assembly;
                    Caption = 'quantityPer', Locked = true;
                    ToolTip = 'Specifies how many units of the assembly component are required to assemble one assembly item.';

                    trigger OnValidate()
                    begin
                        ReserveItem;
                    end;
                }
                field(quantity; Quantity)
                {
                    ApplicationArea = Assembly;
                    Caption = 'quantity', Locked = true;
                    ToolTip = 'Specifies how many units of the assembly component are expected to be consumed.';

                    trigger OnValidate()
                    begin
                        ReserveItem;
                    end;
                }
                field(quantitytoConsume; "Quantity to Consume")
                {
                    ApplicationArea = Assembly;
                    Caption = 'quantitytoConsume', Locked = true;
                    ToolTip = 'Specifies how many units of the assembly component you want to post as consumed when you post the assembly order.';
                }
                field(consumedQuantity; "Consumed Quantity")
                {
                    ApplicationArea = Assembly;
                    Caption = 'consumedQuantity', Locked = true;
                    ToolTip = 'Specifies how many units of the assembly component have been posted as consumed during the assembly.';
                }
                field(remainingQuantity; "Remaining Quantity")
                {
                    ApplicationArea = Assembly;
                    Caption = 'remainingQuantity', Locked = true;
                    ToolTip = 'Specifies how many units of the assembly component remain to be consumed during assembly.';
                }
                field(qtyperunitofMeasure; "Qty. per Unit of Measure")
                {
                    ApplicationArea = Assembly;
                    Caption = 'qtyperunitofMeasure', Locked = true;
                    ToolTip = 'Specifies the quantity per unit of measure of the component item on the assembly order line.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        ReservationStatusField := ReservationStatus;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        AssemblyLineReserve: Codeunit "Assembly Line-Reserve";
    begin
        IF (Quantity <> 0) AND ItemExists("No.") THEN BEGIN
            COMMIT;
            IF NOT AssemblyLineReserve.DeleteLineConfirm(Rec) THEN
                EXIT(FALSE);
            AssemblyLineReserve.DeleteLine(Rec);
        END;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Document Type" := "Document Type"::Order;
        AssemblyHeader.RESET;
        AssemblyHeader.SETRANGE(Id, xRec."Document Id");
        IF AssemblyHeader.FINDFIRST THEN
            "Document No." := AssemblyHeader."No.";
        "Document Id" := xRec."Document Id";
        "Location Code" := 'FACTORY';
        CheckDuplicateAssemblyItemLine; //SRT Feb 28th 2020
        VALIDATE(Quantity, "Quantity per"); //SRT August 11th 2019
    end;

    var
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        ReservationStatusField: Option " ",Partial,Full;
        AssemblyHeader: Record "Assembly Header";

    local procedure ReserveItem()
    begin
        IF Type <> Type::Item THEN
            EXIT;

        IF ("Remaining Quantity (Base)" <> xRec."Remaining Quantity (Base)") OR
           ("No." <> xRec."No.") OR
           ("Location Code" <> xRec."Location Code") OR
           ("Variant Code" <> xRec."Variant Code") OR
           ("Due Date" <> xRec."Due Date") OR
           ((Reserve <> xRec.Reserve) AND ("Remaining Quantity (Base)" <> 0))
        THEN
            IF Reserve = Reserve::Always THEN BEGIN
                CurrPage.SAVERECORD;
                AutoReserve;
                CurrPage.UPDATE(FALSE);
            END;

        ReservationStatusField := ReservationStatus;
    end;
}

