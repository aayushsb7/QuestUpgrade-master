tableextension 70001334 "tableextension70001334" extends "Posted Assembly Header"
{
    fields
    {
        field(50000; Id; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Batch No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Value will be passed from another software';
        }
        field(50002; "Manufacturing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
}

