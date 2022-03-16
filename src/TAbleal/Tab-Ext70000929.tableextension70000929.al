tableextension 70000929 "tableextension70000929" extends "Transfer Shipment Line"
{
    fields
    {
        field(50001; "Batch No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Value will be passed from another software';
        }
    }


    //Unsupported feature: Code Modification on "CopyFromTransferLine(PROCEDURE 1)".

    //procedure CopyFromTransferLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Line No." := TransLine."Line No.";
    "Item No." := TransLine."Item No.";
    Description := TransLine.Description;
    #4..26
    "Transfer-from Bin Code" := TransLine."Transfer-from Bin Code";
    "Shipping Time" := TransLine."Shipping Time";
    "Item Category Code" := TransLine."Item Category Code";

    OnAfterCopyFromTransferLine(Rec,TransLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..29
    "Product Group Code" := TransLine."Product Group Code";
    "Batch No." :=TransLine."Batch No."; //SRT Dec 23rd 2019
    OnAfterCopyFromTransferLine(Rec,TransLine);
    */
    //end;
}

