tableextension 50055 "tableextension70001089" extends "Return Receipt Header"
{
    fields
    {
        field(50000; "Sys. LC No."; Code[20])
        {
            Caption = 'LC No.';
            DataClassification = ToBeClassified;
            TableRelation = "LC Details"."No." WHERE("Transaction Type" = CONST(Sale),
                                                    "Issued To/Received From" = FIELD("Sell-to Customer No."),
                                                    Released = CONST(true),
                                                    Closed = CONST(false));

            trigger OnValidate()
            var
                Text33020011: Label 'LC has amendments and amendment is not released.';
                Text33020012: Label 'LC has amendments and  amendment is closed.';
                Text33020013: Label 'LC Details is not released.';
                Text33020014: Label 'LC Details is closed.';
            begin
            end;
        }
        field(50001; "Bank LC No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "LC Amend No."; Code[20])
        {
            Caption = 'Amendment No.';
            DataClassification = ToBeClassified;
            TableRelation = "LC Amend Detail"."Version No." WHERE("No." = FIELD("Sys. LC No."));
        }
        field(50401; "Document Profile"; Option)
        {
            Caption = 'Document Profile';
            DataClassification = ToBeClassified;
            Description = 'NP15.1001';
            OptionCaption = ' ,Spare Parts Trade,Vehicles Trade,Service';
            OptionMembers = " ","Spare Parts Trade","Vehicles Trade",Service;
        }
    }
}

