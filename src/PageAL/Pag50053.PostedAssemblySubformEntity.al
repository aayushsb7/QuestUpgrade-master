page 50053 "Posted Assembly Subform Entity"
{
    AutoSplitKey = false;
    Caption = 'Posted Assembly Subform Entity';
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    //The property 'EntityName' can only be set if the property 'PageType' is set to 'API'
    //EntityName = 'assemblyOrderLines';
    //The property 'EntitySetName' can only be set if the property 'PageType' is set to 'API'
    //EntitySetName = 'assemblyOrderLines';
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    PopulateAllFields = true;
    SourceTable = "Posted Assembly Line";
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
                }
                field(unitofMeasureCode; "Unit of Measure Code")
                {
                    ApplicationArea = Assembly;
                    Caption = 'unitofMeasureCode', Locked = true;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                }
                field(quantityPer; "Quantity per")
                {
                    ApplicationArea = Assembly;
                    Caption = 'quantityPer', Locked = true;
                    ToolTip = 'Specifies how many units of the assembly component are required to assemble one assembly item.';
                }
                field(quantity; Quantity)
                {
                    ApplicationArea = Assembly;
                    Caption = 'quantity', Locked = true;
                    ToolTip = 'Specifies how many units of the assembly component are expected to be consumed.';
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

    trigger OnDeleteRecord(): Boolean
    var
        AssemblyLineReserve: Codeunit "Assembly Line-Reserve";
    begin
    end;
}

