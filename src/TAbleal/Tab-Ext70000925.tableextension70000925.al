tableextension 50053 "tableextension70000925" extends "Transfer Header"
{
    fields
    {

        //Unsupported feature: Code Modification on ""Transfer-from Code"(Field 2).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;

        IsHandled := FALSE;
        #4..58
          END ELSE
            "Transfer-from Code" := xRec."Transfer-from Code";
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..61

        UpdateTransferFilter;  //Agile ZM
        */
        //end;


        //Unsupported feature: Code Modification on ""Transfer-to Code"(Field 11).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;

        IsHandled := FALSE;
        #4..56
          END ELSE
            "Transfer-to Code" := xRec."Transfer-to Code";
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..59


        UpdateTransferFilter;  //Agile ZM
        */
        //end;
        field(50001; "Batch No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Value will be passed from another software';
        }
        field(50002; "Posted Assembly Order"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; TransferLoctionFilter; Code[30])
        {
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


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetInventorySetup;
    IF "No." = '' THEN BEGIN
      TestNoSeries;
      NoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. Series","Posting Date","No.","No. Series");
    END;
    InitRecord;
    VALIDATE("Shipment Date",WORKDATE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    GetInventorySetup;
    IF "No." = '' THEN BEGIN
      //TestNoSeries;
      //NoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. Series","Posting Date","No.","No. Series");
      //IME19.00 >>
      IF SysMgt.GetNoSeriesFromRespCenter THEN BEGIN
        TestNoSeriesUsingRespCenter;
        NoSeriesMgt.InitSeries(GetNoSeriesCodeUsingRespCenter,xRec."No. Series","Posting Date","No.","No. Series");
      END
      ELSE BEGIN
    #3..5
      //IME19.00 <<
    END;
    InitRecord;
    VALIDATE("Shipment Date",WORKDATE);
    "Assigned User ID" := USERID; //SRT August 17th 2019
    "Last Date Time Modified" := CURRENTDATETIME; //SRT August 17th 2019
    UpdateTransferFilter; //ZM Agile
    */
    //end;


    //Unsupported feature: Code Insertion on "OnModify".

    //trigger OnModify()
    //begin
    /*
    "Last Date Time Modified" := CURRENTDATETIME; //SRT August 17th 2019
    */
    //end;

    local procedure TestNoSeriesUsingRespCenter(): Boolean
    begin
        SysMgt.TestNoSeriesFromRespCenter(DocumentProfile::Transfer, DocumentType::Order)
    end;

    local procedure GetNoSeriesCodeUsingRespCenter(): Code[10]
    begin
        EXIT(SysMgt.GetRespCenterWiseNoSeries(DocumentProfile::Transfer, DocumentType::Order));
    end;

    local procedure UpdateTransferFilter()
    begin
        TransferLoctionFilter := "Transfer-from Code" + '|' + "Transfer-to Code";
    end;

    var
        SysMgt: Codeunit "50002";
        DocumentProfile: Option Purchase,Sales,Transfer,Service;
        DocumentType: Option Quote,"Blanket Order","Order","Return Order",Invoice,"Posted Invoice","Credit Memo","Posted Credit Memo","Posted Shipment","Posted Receipt","Posted Prepmt. Inv.","Posted Prepmt. Cr. Memo","Posted Return Receipt","Posted Return Shipment",Booking,"Posted Order","Posted Debit Note",Requisition,Services,"Posted Credit Note";
        NoSeriesRespCenter: Code[10];
}

