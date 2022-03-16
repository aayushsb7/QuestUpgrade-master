tableextension 50020 "tableextension70000518" extends "Tracking Specification"
{
    fields
    {

        //Unsupported feature: Code Modification on ""Serial No."(Field 24).OnValidate".

        //trigger "(Field 24)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Serial No." <> xRec."Serial No." THEN BEGIN
          TESTFIELD("Quantity Handled (Base)",0);
          TESTFIELD("Appl.-from Item Entry",0);
        #4..6
          IF NOT SkipSerialNoQtyValidation THEN
            CheckSerialNoQty;
          InitExpirationDate;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..9
          InitManufacturingDate; //SRT
        END;
        */
        //end;


        //Unsupported feature: Code Modification on ""Lot No."(Field 5400).OnValidate".

        //trigger "(Field 5400)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Lot No." <> xRec."Lot No." THEN BEGIN
          TESTFIELD("Quantity Handled (Base)",0);
          TESTFIELD("Appl.-from Item Entry",0);
          IF IsReclass THEN
            "New Lot No." := "Lot No.";
          WMSManagement.CheckItemTrackingChange(Rec,xRec);
          InitExpirationDate;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..7
          InitManufacturingDate; //SRT
        END;
        */
        //end;
        field(50000; "Manufacturing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "New Manufacturing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    local procedure "--SRT--"()
    begin
    end;

    procedure InitManufacturingDate()
    var
        ItemTrackingMgt: Codeunit "Item Tracing Mgt.";
        ManufacturingDate: Date;
        EntriesExist: Boolean;
    begin
        IF ("Serial No." = xRec."Serial No.") AND ("Lot No." = xRec."Lot No.") THEN
            EXIT;

        "Manufacturing Date" := 0D;

        ManufacturingDate := ItemTrackingMgt.ExistingManufacturingDate("Item No.", "Variant Code", "Lot No.", "Serial No.", FALSE, EntriesExist);
        IF EntriesExist THEN BEGIN
            "Manufacturing Date" := ManufacturingDate;
            //"Buffer Status2" := "Buffer Status2"::"ExpDate blocked";
        END; /*ELSE
          "Buffer Status2" := 0;*/

        IF IsReclass THEN BEGIN
            "New Manufacturing Date" := "Manufacturing Date";
            //"Warranty Date" := ItemTrackingMgt.ExistingWarrantyDate("Item No.","Variant Code","Lot No.","Serial No.",EntriesExist);
        END;

    end;
}

