tableextension 50054 "Value Entry" extends "Value Entry"
{
    fields
    {

        //Unsupported feature: Property Modification (DecimalPlaces) on ""Valued Quantity"(Field 12)".


        //Unsupported feature: Property Modification (DecimalPlaces) on ""Item Ledger Entry Quantity"(Field 13)".


        //Unsupported feature: Property Modification (DecimalPlaces) on ""Invoiced Quantity"(Field 14)".

        field(50000; "Sys. LC No."; Code[20])
        {
            Caption = 'LC No.';
            DataClassification = ToBeClassified;
            TableRelation = "LC Details"."No." WHERE("Transaction Type" = CONST(Purchase),
                                                    Closed = CONST(false),
                                                    Released = CONST(true));

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
        field(50003; "Purchase Consignment No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'VAT1.00';
            TableRelation = "Purchase Consignment"."No." WHERE(Blocked = CONST(false));
        }
        field(50004; PragyapanPatra; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Sys. LC No." = FILTER(<> '')) PragyapanPatra.Code WHERE("Sys LC No." = FIELD("Sys. LC No."))
            ELSE
            IF ("Sys. LC No." = FILTER('')) PragyapanPatra.Code WHERE("Sys LC No." = FILTER(''));
            ValidateTableRelation = false;
        }
        field(50005; "Item Name"; Text[50])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            Editable = false;
            FieldClass = FlowField;
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

    }
}

