table 50019 "Purchase Change Log"
{

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(3; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Purchase Document ID"; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Inserted Datetime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Modified Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'to be sent from Amnil';
        }
        field(8; "External Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Purchase Document ID", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        PurchChangeLog: Record "Purchase Change Log";
    begin
        PurchChangeLog.RESET;
        PurchChangeLog.SETRANGE("Purchase Document ID", "Purchase Document ID");
        IF PurchChangeLog.FINDLAST THEN
            "Line No." := PurchChangeLog."Line No." + 1000
        ELSE
            "Line No." := 1000;

        PurchHeader.RESET;
        PurchHeader.SETRANGE(Id, "Purchase Document ID");
        IF PurchHeader.FINDFIRST THEN BEGIN
            "Document Type" := PurchHeader."Document Type";
            "Document No." := PurchHeader."No.";
        END;


        "Inserted Datetime" := CURRENTDATETIME;
        IF NOT "External Entry" THEN
            "Modified Date" := TODAY;
    end;

    var
        PurchHeader: Record "Purchase Header";
}

