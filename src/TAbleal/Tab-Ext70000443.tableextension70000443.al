tableextension 50015 "tableextension70000443" extends Item
{
    fields
    {

        //Unsupported feature: Code Insertion (VariableCollection) on "Type(Field 10).OnValidate".

        //trigger (Variable: ItemLedgEntry)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "Type(Field 10).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ExistsItemLedgerEntry THEN
          ERROR(CannotChangeFieldErr,FIELDCAPTION(Type),TABLECAPTION,"No.",ItemLedgEntryTableCaptionTxt);
        CheckJournalsAndWorksheets(FIELDNO(Type));
        #4..21
          VALIDATE("Overhead Rate",0);
          VALIDATE("Indirect Cost %",0);
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ItemLedgEntry.RESET;
        ItemLedgEntry.SETCURRENTKEY("Item No.");
        ItemLedgEntry.SETRANGE("Item No.","No.");
        //IF NOT ItemLedgEntry.ISEMPTY THEN
          //ERROR(CannotChangeFieldErr,FIELDCAPTION(Type),TABLECAPTION,"No.",ItemLedgEntry.TABLECAPTION);
        #1..24
        */
        //end;
        field(50000; "Sales Order Threshold Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Free Sales Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Item Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Active,Excipient';
            OptionMembers = " ",Active,Excipient;
        }
        field(50003; "External Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'To know whether item entry is from Amnil Technologies or not';
        }
        field(50004; "Remaining Box"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    //Unsupported feature: Property Modification (Fields) on "DropDown(FieldGroup 1)".


    //Unsupported feature: Property Modification (Fields) on "Brick(FieldGroup 2)".


    var
        ItemLedgEntry: Record "Item Ledger Entry";

    var
        SelectOrCreateItemErr: Label 'You must select an existing item or create a new.';

    var
        Item: Record Item;
        temp: Integer;
}

