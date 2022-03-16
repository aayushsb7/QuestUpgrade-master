tableextension 50030 "tableextension70000117" extends "Item Template"
{
    fields
    {
        field(6500; "Item Tracking Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Tracking Code";
        }
    }


    //Unsupported feature: Code Modification on "CreateFieldRefArray(PROCEDURE 12)".

    //procedure CreateFieldRefArray();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    I := 1;

    AddToArray(FieldRefArray,I,RecRef.FIELD(FIELDNO(Type)));
    #4..16
    AddToArray(FieldRefArray,I,RecRef.FIELD(FIELDNO("Warehouse Class Code")));
    AddToArray(FieldRefArray,I,RecRef.FIELD(FIELDNO("Item Category Code")));
    AddToArray(FieldRefArray,I,RecRef.FIELD(FIELDNO("Service Item Group")));

    OnAfterCreateFieldRefArray(FieldRefArray,RecRef,I);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..19
    AddToArray(FieldRefArray,I,RecRef.FIELD(FIELDNO("Item Tracking Code")));//aakrista 5/23/2021
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateItemFromTemplate(PROCEDURE 8)".

    //procedure UpdateItemFromTemplate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT GUIALLOWED THEN
      EXIT;

    #4..10
      ConfigTemplateManagement.UpdateRecord(ConfigTemplateHeader,ItemRecRef);
      DimensionsTemplate.InsertDimensionsFromTemplates(ConfigTemplateHeader,Item."No.",DATABASE::Item);
      ItemRecRef.SETTABLE(Item);
      Item.FIND;
    END;

    OnAfterUpdateItemFromTemplate(Rec,Item,ConfigTemplateHeader);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..13
        Item.SETRANGE("Item Tracking Code"); //aakrista
    #14..17
    */
    //end;

    //Unsupported feature: Property Modification (Dimensions) on "CreateFieldRefArray(PROCEDURE 12).FieldRefArray(Parameter 1000)".


    //Unsupported feature: Property Modification (Dimensions) on "AddToArray(PROCEDURE 4).FieldRefArray(Parameter 1000)".


    //Unsupported feature: Property Modification (Id) on "CreateConfigTemplateFromExistingItem(PROCEDURE 5).FieldRefArray(Variable 1004)".


    //Unsupported feature: Property Modification (Dimensions) on "CreateConfigTemplateFromExistingItem(PROCEDURE 5).FieldRefArray(Variable 1004)".


    //Unsupported feature: Property Modification (Dimensions) on "InsertConfigurationTemplateHeaderAndLines(PROCEDURE 2).FieldRefArray(Variable 1001)".



    //Unsupported feature: Property Modification (Dimensions) on "OnInsert.FieldRefArray(Variable 1001)".

    //var
    //>>>> ORIGINAL VALUE:
    //OnInsert.FieldRefArray : 17;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OnInsert.FieldRefArray : 18;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Dimensions) on "OnModify.FieldRefArray(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //OnModify.FieldRefArray : 17;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OnModify.FieldRefArray : 18;
    //Variable type has not been exported.
}

