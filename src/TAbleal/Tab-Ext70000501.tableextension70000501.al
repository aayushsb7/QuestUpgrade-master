tableextension 50018 "tableextension70000501" extends "Item Ledger Entry"
{
    fields
    {

        //Unsupported feature: Property Modification (DecimalPlaces) on "Quantity(Field 12)".


        //Unsupported feature: Property Modification (DecimalPlaces) on ""Remaining Quantity"(Field 13)".


        //Unsupported feature: Property Modification (DecimalPlaces) on ""Invoiced Quantity"(Field 14)".


        //Unsupported feature: Property Modification (DecimalPlaces) on ""Shipped Qty. Not Returned"(Field 5818)".

        field(50000; "Item Name"; Text[50])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));

        }
        field(50001; "Base Unit of Measure"; Code[10])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup(Item."Base Unit of Measure" WHERE("No." = FIELD("Item No.")));

        }
        field(50003; "Purchase Consignment No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'VAT1.00';
            TableRelation = "Purchase Consignment"."No." WHERE(Blocked = CONST(false));
        }
        field(50004; "Batch No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Value will be passed from another software';
        }
        field(50005; "Manufacturing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Expiy Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Sys. LC No."; Code[20])
        {
            Caption = 'LC No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                LCDetail: Record "LC Details";
                LCAmendDetail: Record "LC Amend Detail";
                Text33020011: Label 'LC has amendments and amendment is not released.';
                Text33020012: Label 'LC has amendments and  amendment is closed.';
                Text33020013: Label 'LC Details is not released.';
                Text33020014: Label 'LC Details is closed.';
            begin
            end;
        }
        field(50018; "Bank LC No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "LC Amend No."; Code[20])
        {
            Caption = 'Amendment No.';
            DataClassification = ToBeClassified;
            TableRelation = "LC Amend Detail"."Version No." WHERE("No." = FIELD("Sys. LC No."));
        }
        field(50054; "External Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'to recognize entry from third party software';
        }
        field(50055; "Is Spillage"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50401; "Document Profile"; Option)
        {
            Caption = 'Document Profile';
            DataClassification = ToBeClassified;
            Description = 'NP15.1001';
            OptionCaption = ' ,Spare Parts Trade,Vehicles Trade,Service';
            OptionMembers = " ","Spare Parts Trade","Vehicles Trade",Service;
        }
        field(50501; PragyapanPatra; Code[100])
        {
            DataClassification = ToBeClassified;
            Description = 'NP15.1001';
            TableRelation = PragyapanPatra.Code;
        }

    }
}

