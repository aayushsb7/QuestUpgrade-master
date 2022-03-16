table 50027 "Bill Delivery Details"
{
    Caption = 'Bill Delivery Details';
    DrillDownPageID = 50056;
    LookupPageID = 50056;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Document No." <> xRec."Document No." THEN BEGIN
                    AccountabilityCenter.GET("Accountability Center");
                    NoSeriesMngt.TestManual(AccountabilityCenter."Delivery Detail Nos.");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; "Sales Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Invoice Header";
        }
        field(3; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Transport Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "CN No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Dispatch Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "M.R."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Cases; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Doc. Thru."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(12; "Accountability Center"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Accountability Center";
        }
        field(13; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
    }

    keys
    {
        key(Key1; "Document No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Document No." = '' THEN BEGIN
            AccountabilityCenter.GET("Accountability Center");
            AccountabilityCenter.TESTFIELD("Delivery Detail Nos.");
            NoSeriesMngt.InitSeries(AccountabilityCenter."Delivery Detail Nos.", xRec."No. Series", "Posting Date", "Document No.", "No. Series");
        END;
    end;

    var
        NoSeriesMngt: Codeunit NoSeriesManagement;
        AccountabilityCenter: Record "Accountability Center";
        DeliveryDetail: Record "Bill Delivery Details";
        UserSetup: Record "User Setup";


    procedure AssistEdit(): Boolean
    begin
        WITH DeliveryDetail DO BEGIN
            DeliveryDetail := Rec;
            AccountabilityCenter.GET;
            AccountabilityCenter.TESTFIELD("Delivery Detail Nos.");
            IF NoSeriesMngt.SelectSeries(AccountabilityCenter."Delivery Detail Nos.", xRec."No. Series", "No. Series") THEN BEGIN
                NoSeriesMngt.SetSeries("Document No.");
                Rec := DeliveryDetail;
                EXIT(TRUE);
            END;
        END;
    end;
}

