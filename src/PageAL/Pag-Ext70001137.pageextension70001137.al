pageextension 50068 "pageextension70001137" extends "Item Entity"
{
    layout
    {
        addafter(displayName)
        {
            field(displayName2; "Description 2")
            {
                Caption = 'DisplayName2';

                trigger OnValidate()
                begin
                    RegisterFieldSet(FIELDNO("Description 2")); //SRT July 28th 2019
                end;
            }
        }
        addafter(type)
        {
            field(itemGroup; "Inventory Posting Group")
            {
                Caption = 'itemGroup';

                trigger OnValidate()
                begin
                    RegisterFieldSet(FIELDNO("Inventory Posting Group")); //SRT July 10th 2019
                end;
            }
        }
        addafter(lastModifiedDateTime)
        {
            field(itemType; "Item Type")
            {
                ApplicationArea = All;
                Caption = 'ItemType', Locked = true;

                trigger OnValidate()
                begin
                    RegisterFieldSet(FIELDNO("Item Type"));  //SRT June 6th 2019
                end;
            }
        }
    }


    //Unsupported feature: Code Modification on "SetCalculatedFields(PROCEDURE 6)".

    //procedure SetCalculatedFields();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    // UOM
    BaseUnitOfMeasureJSONText := GraphCollectionMgtItem.ItemUnitOfMeasureToJSON(Rec,"Base Unit of Measure");
    BaseUnitOfMeasureCode := "Base Unit of Measure";
    #4..6
      BaseUnitOfMeasureId := BlankGUID;

    // Inventory
    CALCFIELDS(Inventory);
    InventoryValue := Inventory;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..9
    SETFILTER("Location Filter",'FACTORY'); //SRT Dec 7th 2019
    CALCFIELDS(Inventory);
    InventoryValue := Inventory;
    */
    //end;
}

