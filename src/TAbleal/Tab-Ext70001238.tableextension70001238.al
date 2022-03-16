tableextension 50060 "tableextension70001238" extends "Company Information"
{
    fields
    {
        field(50000; "Activate Local Resp. Center"; Boolean)
        {
            Caption = 'Activate Local Responsibility Center';
            DataClassification = ToBeClassified;
            Description = 'NP15.1001';
        }
        field(50001; "Enable Workdate for Sales"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "ODATA Port"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Master Setup Comany"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'to avoid any transaction in master setup company';
        }
        field(50004; "Picture 2"; BLOB)
        {
            Caption = 'Picture 2';
            DataClassification = ToBeClassified;
            SubType = Bitmap;

            trigger OnValidate()
            begin
                PictureUpdated := TRUE;
            end;
        }
        field(50005; "Picture 3"; BLOB)
        {
            Caption = 'Picture 3';
            DataClassification = ToBeClassified;
            SubType = Bitmap;

            trigger OnValidate()
            begin
                PictureUpdated := TRUE;
            end;
        }
        field(50500; "CBMS Username"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50501; "CBMS Password"; Text[30])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = Masked;
        }
        field(50502; "CBMS Base URL"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50503; "Enable CBMS Realtime Sync"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50504; "IRD Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}

