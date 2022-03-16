tableextension 70000926 "tableextension70000926" extends "Transfer Line"
{
    fields
    {
        field(50001; "Batch No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Value will be passed from another software';
        }
    }


    //Unsupported feature: Code Modification on "GetTransHeader(PROCEDURE 1)".

    //procedure GetTransHeader();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetTransferHeaderNoVerification;

    TransHeader.TESTFIELD("Shipment Date");
    #4..10
    "Transfer-to Code" := TransHeader."Transfer-to Code";
    "Shipment Date" := TransHeader."Shipment Date";
    "Receipt Date" := TransHeader."Receipt Date";
    "Shipping Agent Code" := TransHeader."Shipping Agent Code";
    "Shipping Agent Service Code" := TransHeader."Shipping Agent Service Code";
    "Shipping Time" := TransHeader."Shipping Time";
    #17..19
    "Direct Transfer" := TransHeader."Direct Transfer";

    OnAfterGetTransHeader(Rec,TransHeader);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..13
    "Batch No." := TransHeader."Batch No."; //SRT Dec 23rd 2019
    #14..22
    */
    //end;
}

