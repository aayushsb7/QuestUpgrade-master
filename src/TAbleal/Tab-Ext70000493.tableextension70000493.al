tableextension 70000493 "tableextension70000493" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50000; "Purchase Consignment Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50001; "Vendor Template Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'use while creating vendor form LC details';
            TableRelation = "Config. Template Header".Code;
        }
        field(50002; "Block Same Purchase Item Line"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'if the value is true then duplicate item no. cannot be inserted in purchase line';
        }
        field(50011; "Apply Vendor Entry Dim 1 Wise"; Boolean)
        {
            CaptionClass = '1,2,1';
            DataClassification = ToBeClassified;
        }
        field(50012; "Apply Vendor Entry Dim 2 Wise"; Boolean)
        {
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
        }
        field(50013; "Apply Vendor Entry Dim 3 Wise"; Boolean)
        {
            CaptionClass = '1,2,3';
            DataClassification = ToBeClassified;
        }
        field(50014; "Apply Vendor Entry Dim 4 Wise"; Boolean)
        {
            CaptionClass = '1,2,4';
            DataClassification = ToBeClassified;
        }
        field(50015; "Apply Vendor Entry Dim 5 Wise"; Boolean)
        {
            CaptionClass = '1,2,5';
            DataClassification = ToBeClassified;
        }
        field(50016; "Apply Vendor Entry Dim 6 Wise"; Boolean)
        {
            CaptionClass = '1,2,6';
            DataClassification = ToBeClassified;
        }
        field(50017; "Apply Vendor Entry Dim 7 Wise"; Boolean)
        {
            CaptionClass = '1,2,7';
            DataClassification = ToBeClassified;
        }
        field(50018; "Apply Vendor Entry Dim 8 Wise"; Boolean)
        {
            CaptionClass = '1,2,8';
            DataClassification = ToBeClassified;
        }
        field(55000; "ILE Application Diff"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'COGS1.00';

            trigger OnValidate()
            begin
                /*//COGS1.00 Agile CP 21 Feb 2018
                IF ABS("ILE Application Diff") > 0.99 THEN
                  ERROR('The value cannot be less than -0.99 and greater than 0.99');
                //COGS1.00 Agile CP 21 Feb 2018*/

            end;
        }
    }
}

