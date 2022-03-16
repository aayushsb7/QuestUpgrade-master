tableextension 50057 "tableextension70001076" extends "Lot No. Information"
{
    fields
    {
        field(50000; "Manufacturing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ItemTrackingComment.SETRANGE(Type,ItemTrackingComment.Type::"Lot No.");
    ItemTrackingComment.SETRANGE("Item No.","Item No.");
    ItemTrackingComment.SETRANGE("Variant Code","Variant Code");
    ItemTrackingComment.SETRANGE("Serial/Lot No.","Lot No.");
    ItemTrackingComment.DELETEALL;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5

    IF LedgerEntryExist THEN
      ERROR('Item Ledger Entry exists for batch no. %1. Unable to delete.',"Lot No.");
    */
    //end;

    local procedure LedgerEntryExist(): Boolean
    var
        ILE: Record "Item Ledger Entry";
    begin
        ILE.RESET;
        ILE.SETRANGE("Lot No.", "Lot No.");
        IF ILE.FINDFIRST THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;
}

