tableextension 50063 "tableextension70001310" extends "Assembly Line"
{
    fields
    {

        //Unsupported feature: Property Modification (DecimalPlaces) on "Quantity(Field 40)".


        //Unsupported feature: Property Modification (DecimalPlaces) on ""Quantity (Base)"(Field 41)".


        //Unsupported feature: Property Modification (DecimalPlaces) on ""Remaining Quantity"(Field 42)".


        //Unsupported feature: Property Modification (DecimalPlaces) on ""Remaining Quantity (Base)"(Field 43)".


        //Unsupported feature: Property Modification (DecimalPlaces) on ""Consumed Quantity"(Field 44)".


        //Unsupported feature: Property Modification (DecimalPlaces) on ""Consumed Quantity (Base)"(Field 45)".


        //Unsupported feature: Property Modification (DecimalPlaces) on ""Quantity to Consume"(Field 46)".


        //Unsupported feature: Property Modification (DecimalPlaces) on ""Quantity to Consume (Base)"(Field 47)".


        //Unsupported feature: Property Modification (DecimalPlaces) on ""Quantity per"(Field 60)".


        //Unsupported feature: Property Modification (DecimalPlaces) on ""Qty. per Unit of Measure"(Field 61)".


        //Unsupported feature: Code Modification on "Type(Field 10).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Consumed Quantity",0);
        VerifyReservationChange(Rec,xRec);
        TestStatusOpen;
        #4..9
        "Inventory Posting Group" := '';
        "Gen. Prod. Posting Group" := '';
        CLEAR("Lead-Time Offset");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..12
        "Document Id" := AssemblyHeader.Id; //SRT July 9th 2019
        */
        //end;


        //Unsupported feature: Code Modification on ""No."(Field 11).OnValidate".

        //trigger "(Field 11)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "Location Code" := '';
        TESTFIELD("Consumed Quantity",0);
        CALCFIELDS("Reserved Quantity");
        WhseValidateSourceLine.AssemblyLineVerifyChange(Rec,xRec);
        IF "No." <> '' THEN
          CheckItemAvailable(FIELDNO("No."));
        #7..23
              CopyFromResource;
          END
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        CheckDuplicateAssemblyItemLine; //SRT Jan 20th 2020
        #4..26
        "Document Id" := AssemblyHeader.Id; //SRT July 9th 2019
        */
        //end;
        field(50000; "Document Id"; Guid)
        {
            DataClassification = ToBeClassified;
        }
    }

    local procedure "--SRT--"()
    begin
    end;

    procedure CheckDuplicateAssemblyItemLine()
    var
        DuplicateAssemblyItemLine: Record "Assembly Line";
        DuplicateErrExistMsg: Label 'Item %1 has been selected already in line no. %2 for Assembly document no. %3.';
        AssemblySetup: Record "Assembly Setup";
    begin
        //SRT Jan 21st 2020 >>
        IF Type <> Type::Item THEN
            EXIT;

        AssemblySetup.GET;
        IF AssemblySetup."Block Same Assembly Item Line" THEN BEGIN
            DuplicateAssemblyItemLine.RESET;
            DuplicateAssemblyItemLine.SETRANGE("Document Type", "Document Type");
            DuplicateAssemblyItemLine.SETRANGE("Document No.", "Document No.");
            DuplicateAssemblyItemLine.SETRANGE("No.", "No.");
            DuplicateAssemblyItemLine.SETFILTER("Line No.", '<>%1', "Line No.");
            IF DuplicateAssemblyItemLine.FINDFIRST THEN
                ERROR(DuplicateErrExistMsg, "No.", DuplicateAssemblyItemLine."Line No.", "Document No.");
        END;
        //SRT Jan 21st 2020 <<
    end;
}

