table 50010 "Purchase Consignment"
{
    DrillDownPageID = 50012;
    LookupPageID = 50012;

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    PurchasesAndPaybleSetup.GET;
                    NoSeriesMgt.TestManual(PurchasesAndPaybleSetup."Purchase Consignment Nos.");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; "Commercial Invoice No."; Text[50])
        {
            Caption = 'Commercial Invoice No.';

            trigger OnValidate()
            begin
                //Agile RD June 24 2016
                IF "No." = '' THEN BEGIN
                    PurchasesAndPaybleSetup.GET;
                    PurchasesAndPaybleSetup.TESTFIELD("Purchase Consignment Nos.");
                    NoSeriesMgt.InitSeries(PurchasesAndPaybleSetup."Purchase Consignment Nos.", xRec."No. Series", 0D, "No.", "No. Series");
                END;
                //Agile RD June 24 2016
            end;
        }
        field(3; Blocked; Boolean)
        {
        }
        field(10; "Vendor Code"; Code[10])
        {
            Caption = 'Vendor Code';
            TableRelation = Vendor."No.";
        }
        field(11; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(5005; "Posted Purchase Invoices"; Integer)
        {
        }
        field(5006; "Posted Purch. Credit Memos"; Integer)
        {
        }
        field(50401; "Document Profile"; Option)
        {
            Caption = 'Document Profile';
            Description = 'NP15.1001';
            OptionCaption = ' ,Spare Parts Trade,Vehicles Trade,Service';
            OptionMembers = " ","Spare Parts Trade","Vehicles Trade",Service;
        }
        field(50402; "Sys LC No."; Code[20])
        {
            TableRelation = "LC Details";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Commercial Invoice No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Commercial Invoice No.")
        {
        }
    }

    trigger OnDelete()
    begin
        ERROR(Text1001);
    end;

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            PurchasesAndPaybleSetup.GET;
            PurchasesAndPaybleSetup.TESTFIELD("Purchase Consignment Nos.");
            NoSeriesMgt.InitSeries(PurchasesAndPaybleSetup."Purchase Consignment Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        END;
    end;

    trigger OnRename()
    begin
        ERROR(Text1002);
    end;

    var
        PurchasesAndPaybleSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PurchaseConsignment: Record "Purchase Consignment";
        Text1001: Label 'You are not allowed to Delete!';
        Text1002: Label 'You are not allowed to Rename!';

    procedure AssistEdit(): Boolean
    begin
        WITH PurchaseConsignment DO BEGIN
            PurchaseConsignment := Rec;
            PurchasesAndPaybleSetup.GET;
            PurchasesAndPaybleSetup.TESTFIELD("Purchase Consignment Nos.");
            IF NoSeriesMgt.SelectSeries(PurchasesAndPaybleSetup."Purchase Consignment Nos.", xRec."No. Series", "No. Series") THEN BEGIN
                PurchasesAndPaybleSetup.GET;
                PurchasesAndPaybleSetup.TESTFIELD("Purchase Consignment Nos.");
                NoSeriesMgt.SetSeries("No.");
                Rec := PurchaseConsignment;
                EXIT(TRUE);
            END;
        END;
    end;
}

