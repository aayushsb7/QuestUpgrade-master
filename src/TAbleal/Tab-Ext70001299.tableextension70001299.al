tableextension 50062 "tableextension70001299" extends "Assembly Header"
{
    fields
    {

        //Unsupported feature: Property Modification (Editable) on ""Posting No."(Field 63)".

        field(50000; Id; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Batch No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Value will be passed from another software';

            trigger OnValidate()
            begin
                IF "Batch No." <> '' THEN BEGIN
                    AssemblyHdr.RESET;
                    AssemblyHdr.SETRANGE("Batch No.", "Batch No.");
                    AssemblyHdr.SETFILTER("No.", '<>%1', "No.");
                    IF AssemblyHdr.FINDFIRST THEN
                        ERROR('Batch No. %1 has been already created in Assembly Order No. %2', "Batch No.", AssemblyHdr."No.");
                END;
            end;
        }
        field(50002; "Manufacturing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Last Time Modified"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "External Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'If the data are being sent from third party software then value will be true';
        }
    }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CheckIsNotAsmToOrder;

    AssemblyHeaderReserve.DeleteLine(Rec);
    CALCFIELDS("Reserved Qty. (Base)");
    TESTFIELD("Reserved Qty. (Base)",0);

    DeleteAssemblyLines;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF "Posting No." <> '' THEN
      ERROR(DelErr);

    #1..7
    */
    //end;


    //Unsupported feature: Code Modification on "OnModify".

    //trigger OnModify()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    AssemblyHeaderReserve.VerifyChange(Rec,xRec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    AssemblyHeaderReserve.VerifyChange(Rec,xRec);
    //SRT July 9th 2019 >>
    "Last Date Modified" := TODAY;
    "Assigned User ID" := USERID;
    "Last Time Modified" := TIME;
    //SRT July 9th 2019 <<
    */
    //end;


    //Unsupported feature: Code Modification on "InitRecord(PROCEDURE 15)".

    //procedure InitRecord();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CASE "Document Type" OF
      "Document Type"::Quote,"Document Type"::"Blanket Order":
        NoSeriesMgt.SetDefaultSeries("Posting No. Series",AssemblySetup."Posted Assembly Order Nos.");
      "Document Type"::Order:
        BEGIN
          IF ("No. Series" <> '') AND
             (AssemblySetup."Assembly Order Nos." = AssemblySetup."Posted Assembly Order Nos.")
          THEN
            "Posting No. Series" := "No. Series"
          ELSE
            NoSeriesMgt.SetDefaultSeries("Posting No. Series",AssemblySetup."Posted Assembly Order Nos.");
        END;
    END;

    "Creation Date" := WORKDATE;
    IF "Due Date" = 0D THEN
      "Due Date" := WORKDATE;
    "Posting Date" := WORKDATE;
    IF "Starting Date" = 0D THEN
      "Starting Date" := WORKDATE;
    IF "Ending Date" = 0D THEN
      "Ending Date" := WORKDATE;

    SetDefaultLocation;

    OnAfterInitRecord(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..15
    {IF "Due Date" = 0D THEN
      "Due Date" := WORKDATE;}
    "Posting Date" := WORKDATE;
    IF "Starting Date" = 0D THEN
      //"Starting Date" := WORKDATE;
      "Starting Date" := "Posting Date";
    IF "Ending Date" = 0D THEN
      //"Ending Date" := WORKDATE;
      "Ending Date" := "Posting Date";
    IF "Due Date" = 0D THEN
      "Due Date" := "Posting Date";
    SetDefaultLocation;
    //SRT July 9th 2019 >>
    IF "Batch No." <> '' THEN BEGIN
      AssemblyHdr.RESET;
      AssemblyHdr.SETRANGE("Batch No.","Batch No.");
      AssemblyHdr.SETFILTER("No.",'<>%1',"No.");
      IF AssemblyHdr.FINDFIRST THEN
        ERROR('Batch No. %1 has been already created in Assembly Order No. %2',"Batch No.",AssemblyHdr."No.");
    END;
    Id := CREATEGUID;
    "Last Date Modified" := TODAY;
    "Assigned User ID" := USERID;
    "Last Time Modified" := TIME;
    //SRT July 9th 2019 <<

    OnAfterInitRecord(Rec);
    */
    //end;


    //Unsupported feature: Code Modification on "ValidateDates(PROCEDURE 34)".

    //procedure ValidateDates();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CASE FieldNumToCalculateFrom OF
      FIELDNO("Due Date"):
        BEGIN
    #4..69
                END;
        END;
    END;
    IF "Due Date" < "Ending Date" THEN
      ERROR(Text015,FIELDCAPTION("Due Date"),"Due Date",FIELDCAPTION("Ending Date"),"Ending Date");
    IF "Ending Date" < "Starting Date" THEN
      ERROR(Text015,FIELDCAPTION("Ending Date"),"Ending Date",FIELDCAPTION("Starting Date"),"Starting Date");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..72
    {IF "Due Date" < "Ending Date" THEN
      ERROR(Text015,FIELDCAPTION("Due Date"),"Due Date",FIELDCAPTION("Ending Date"),"Ending Date");
    IF "Ending Date" < "Starting Date" THEN
      ERROR(Text015,FIELDCAPTION("Ending Date"),"Ending Date",FIELDCAPTION("Starting Date"),"Starting Date");}  //test for API SRT
    */
    //end;

    local procedure "--SRT--"()
    begin
    end;

    procedure SendToPosting(PostingCodeunitID: Integer)
    begin
        //SRT July 10th 2019
        CODEUNIT.RUN(PostingCodeunitID, Rec);
    end;

    procedure TransferBatchQuantiyAsPerAssemblySetup(var AssemblyHeader: Record "Assembly Header"; TransferQtyAssemble: Decimal; PostingNo: Code[20])
    var
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        TransferPostShipment: Codeunit "TransferOrder-Post Shipment";
        LineNo: Integer;
        IRDMgt: Codeunit "IRD Mgt.";
    begin
        //SRT August 11th 2019
        WITH AssemblyHeader DO BEGIN
            AssemblySetup.GET;
            AssemblySetup.TESTFIELD("Default Location for Transfer");
            TransferHeader.RESET;
            TransferHeader.SETCURRENTKEY("Batch No.");
            TransferHeader.SETRANGE("Batch No.", "Batch No.");
            TransferHeader.SETRANGE("Posted Assembly Order", PostingNo);
            IF NOT TransferHeader.FINDFIRST THEN BEGIN
                TransferHeader.INIT;
                TransferHeader."No." := '';
                TransferHeader.VALIDATE("Transfer-from Code", AssemblyHeader."Location Code");
                TransferHeader.VALIDATE("Transfer-to Code", AssemblySetup."Default Location for Transfer");
                TransferHeader.INSERT(TRUE);
                TransferHeader."Batch No." := "Batch No.";
                TransferHeader."Manufacturing Date" := "Manufacturing Date";
                TransferHeader."Expiy Date" := "Expiry Date";
                TransferHeader."Assembly Order No." := "No.";
                TransferHeader."Posted Assembly Order" := PostingNo;
                TransferHeader.MODIFY;

                TransferLine.RESET;
                TransferLine.SETRANGE("Document No.", TransferHeader."No.");
                IF TransferLine.FINDLAST THEN
                    LineNo := TransferLine."Line No." + 1000
                ELSE
                    LineNo := 1000;

                TransferLine.INIT;
                TransferLine."Document No." := TransferHeader."No.";
                TransferLine."Line No." := LineNo;
                TransferLine.VALIDATE("Item No.", "Item No.");
                TransferLine.VALIDATE(Quantity, TransferQtyAssemble);
                TransferLine.INSERT(TRUE);
                IRDMgt.AssignLotNoToPerTransferLine(TransferLine, "Batch No.", TransferLine.Quantity);
                TransferLine.MODIFY;
                CLEAR(TransferPostShipment);
                TransferPostShipment.SetCalledFromAssembly(TRUE);
                TransferPostShipment.RUN(TransferHeader);
                MODIFY;
            END;
        END;
    end;

    var
        "-----SRT--": Integer;
        UserSetup: Record "User Setup";
        AssemblyHdr: Record "Assembly Header";
        AssemblySetup: Record "Assembly Setup";
        "--SRT----": Integer;
        DelErr: Label 'Posting no. reserved. You cannot delete the record now. Please transfer the posting no. to some other assembly orders to delete the record.';
}

