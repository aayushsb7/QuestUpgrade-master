tableextension 70000930 "tableextension70000930" extends "Transfer Receipt Header"
{
    fields
    {
        field(50001; "Batch No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Value will be passed from another software';
        }
        field(50002; "Posted Assembly Order"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Assembly Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Last Date Time Modified"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Manufacturing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Expiy Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }


    //Unsupported feature: Code Modification on "CopyFromTransferHeader(PROCEDURE 4)".

    //procedure CopyFromTransferHeader();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Transfer-from Code" := TransHeader."Transfer-from Code";
    "Transfer-from Name" := TransHeader."Transfer-from Name";
    "Transfer-from Name 2" := TransHeader."Transfer-from Name 2";
    #4..36
    Area := TransHeader.Area;
    "Transaction Specification" := TransHeader."Transaction Specification";
    "Direct Transfer" := TransHeader."Direct Transfer";

    OnAfterCopyFromTransferHeader(Rec,TransHeader);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..39
    //SRT August 17th 2019 >>
    "Assembly Order No." := TransHeader."Assembly Order No."; //SRT August 17th 2019
    "Batch No." := TransHeader."Batch No."; //SRT August 11th 2019
    "Posted Assembly Order" := TransHeader."Posted Assembly Order"; //SRT August 15th 2019
    "Last Date Time Modified" := TransHeader."Last Date Time Modified";
    "Manufacturing Date" := TransHeader."Manufacturing Date";
    "Expiy Date" := TransHeader."Expiy Date";
    //SRT August 17th 2019 <<
    OnAfterCopyFromTransferHeader(Rec,TransHeader);
    */
    //end;
}

