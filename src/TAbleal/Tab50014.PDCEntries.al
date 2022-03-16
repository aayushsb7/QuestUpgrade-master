table 50014 "PDC Entries"
{
    DrillDownPageID = 50023;
    LookupPageID = 50023;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Editable = false;
        }
        field(2; "Posting Date"; Date)
        {
        }
        field(3; Type; Option)
        {
            OptionMembers = Receipt,Payment;

            trigger OnValidate()
            begin
                "Bill-To/Pay-To No." := '';
                "Bill-To/Pay-To Name" := '';
                "Sell-To/Buy-From No." := '';
                "Sell-To/Buy-From Name" := '';

                IF Type = Type::Receipt THEN BEGIN
                    "Bill-To/Pay-To Type" := "Bill-To/Pay-To Type"::Customer;
                    "Sell-To/Buy-From Type" := "Sell-To/Buy-From Type"::Customer;
                END

                ELSE
                    IF Type = Type::Payment THEN BEGIN
                        "Bill-To/Pay-To Type" := "Bill-To/Pay-To Type"::Vendor;
                        "Sell-To/Buy-From Type" := "Sell-To/Buy-From Type"::Vendor;
                    END;
            end;
        }
        field(4; "Cheque No."; Text[50])
        {
        }
        field(5; "Cheque Date"; Date)
        {
        }
        field(6; "Drawn On"; Date)
        {
            Description = 'delete';
        }
        field(7; "Customer Bank Account"; Code[10])
        {
            TableRelation = "Customer Bank Account".Code WHERE("Customer No." = FIELD("Bill-To/Pay-To No."));
        }
        field(8; "Customer Bank Name"; Text[100])
        {
        }
        field(9; "Bill-To/Pay-To No."; Code[20])
        {
            TableRelation = IF ("Bill-To/Pay-To Type" = CONST(Customer)) Customer."No."
            ELSE
            IF ("Bill-To/Pay-To Type" = CONST(Vendor)) Vendor."No.";

            trigger OnValidate()
            begin
                IF ("Bill-To/Pay-To No." <> '') THEN BEGIN
                    IF ("Bill-To/Pay-To Type" = "Bill-To/Pay-To Type"::Customer) THEN BEGIN
                        CustomerRec.GET("Bill-To/Pay-To No.");
                        "Bill-To/Pay-To Name" := CustomerRec.Name;
                    END
                    ELSE
                        IF ("Bill-To/Pay-To Type" = "Bill-To/Pay-To Type"::Vendor) THEN BEGIN
                            VendorRec.GET("Bill-To/Pay-To No.");
                            "Bill-To/Pay-To Name" := VendorRec.Name;
                        END;
                END
                ELSE
                    "Bill-To/Pay-To Name" := '';
            end;
        }
        field(10; "Bill-To/Pay-To Name"; Text[100])
        {
        }
        field(11; Amount; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(12; Remarks; Option)
        {
            OptionMembers = Due,Deposit,Cancel;
        }
        field(13; Narration; Text[250])
        {
        }
        field(14; "User Id"; Code[50])
        {
            Editable = false;
        }
        field(15; "Bill-To/Pay-To Type"; Option)
        {
            Editable = false;
            OptionMembers = Customer,Vendor;
        }
        field(16; "Sell-To/Buy-From Type"; Option)
        {
            Editable = false;
            OptionMembers = Customer,Vendor;
        }
        field(17; "Sell-To/Buy-From No."; Code[20])
        {
            TableRelation = IF ("Sell-To/Buy-From Type" = CONST(Customer)) Customer."No."
            ELSE
            IF ("Sell-To/Buy-From Type" = CONST(Vendor)) Vendor."No.";

            trigger OnValidate()
            begin
                IF ("Sell-To/Buy-From No." <> '') THEN BEGIN
                    IF ("Sell-To/Buy-From Type" = "Sell-To/Buy-From Type"::Customer) THEN BEGIN
                        CustomerRec.GET("Sell-To/Buy-From No.");
                        "Sell-To/Buy-From Name" := CustomerRec.Name;
                        "Bill-To/Pay-To No." := CustomerRec."Bill-to Customer No.";
                        IF "Bill-To/Pay-To No." <> '' THEN BEGIN
                            CustomerRec2.GET("Bill-To/Pay-To No.");
                            "Bill-To/Pay-To Name" := CustomerRec2.Name;
                        END;
                    END
                    ELSE
                        IF ("Sell-To/Buy-From Type" = "Sell-To/Buy-From Type"::Vendor) THEN BEGIN
                            VendorRec.GET("Sell-To/Buy-From No.");
                            "Sell-To/Buy-From Name" := VendorRec.Name;
                            "Bill-To/Pay-To No." := VendorRec."Pay-to Vendor No.";
                            IF "Bill-To/Pay-To No." <> '' THEN BEGIN
                                VendorRec2.GET("Bill-To/Pay-To No.");
                                "Bill-To/Pay-To Name" := VendorRec2.Name;
                            END;
                        END;
                END
                ELSE
                    "Sell-To/Buy-From Name" := '';
            end;
        }
        field(18; "Sell-To/Buy-From Name"; Text[100])
        {
        }
        field(19; "Date Filter"; Date)
        {
        }
        field(20; Status; Option)
        {
            OptionMembers = Open,Closed;
        }
        field(21; "Incorrect Entry"; Boolean)
        {
        }
        field(24; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(25; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(26; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(27; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(28; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
        }
        field(29; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));
        }
        field(30; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));
        }
        field(31; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));
        }
        field(480; "Dimension Set ID"; Integer)
        {
        }
        field(481; Reversed; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "User Id" := USERID;
    end;

    var
        BankRec: Record "Bank Account";

        CustomerRec: Record Customer;
        VendorRec: Record Vendor;
        CustomerRec2: Record Customer;
        VendorRec2: Record Vendor;
        CustomerBankRec: Record "Customer Bank Account";
        BankAccNo: Code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        "Journal Template Name": Code[20];
        "Journal Batch Name": Code[20];
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        Text5000: Label 'System Created Entry of PDC Entry No.';
        Text5001: Label 'Journal Lines have been Reversed.';
        GLrec: Record "G/L Entry";
        PDCAlreadyReversed: Label 'The selected PDC entry has already been reversed.';
        PaymentNotDone: Label 'The cheque has not been deposited yet. You can only reverse the entries which have been processed.';
        IncorrectEntryErr: Label 'You cannot reverse the PDC entries which has already been marked incorrect.';
        ReversePost: Label 'Do you want to reverse the selected PDC entry?';


    procedure ReversePDC(PDCRec: Record "PDC Entries")
    var
        GenJournalRec: Record "Gen. Journal Line";
        GenJnlBatchRec: Record "Gen. Journal Batch";
        GenJnlTemplateRec: Record "Gen. Journal Template";
    begin
        IF NOT CONFIRM(ReversePost) THEN
            EXIT;

        WITH PDCRec DO BEGIN
            IF Reversed THEN
                ERROR(PDCAlreadyReversed);

            IF Status <> Status::Closed THEN
                ERROR(PaymentNotDone);

            IF "Incorrect Entry" THEN
                ERROR(IncorrectEntryErr);

            GLrec.RESET;
            GLrec.SETRANGE("PDC Entry No.", PDCRec."Entry No.");
            GLrec.SETFILTER("Source No.", '<>%1', '');
            GLrec.FINDFIRST;

            GenJournalRec.INIT;
            GenJournalRec."Posting Date" := WORKDATE;
            IF PDCRec.Type = PDCRec.Type::Receipt THEN BEGIN
                GenJournalRec.VALIDATE("Account Type", GenJournalRec."Account Type"::Customer);
                GenJournalRec.VALIDATE("Account No.", PDCRec."Bill-To/Pay-To No.");
                GenJournalRec.VALIDATE("Bal. Account Type", GenJournalRec."Bal. Account Type"::"Bank Account");
                GenJournalRec.VALIDATE("Bal. Account No.", GLrec."Source No.");
            END
            ELSE
                IF PDCRec.Type = PDCRec.Type::Payment THEN BEGIN
                    GenJournalRec.VALIDATE("Account Type", GenJournalRec."Account Type"::Vendor);
                    GenJournalRec.VALIDATE("Account No.", PDCRec."Bill-To/Pay-To No.");
                    GenJournalRec.VALIDATE("Bal. Account Type", GenJournalRec."Bal. Account Type"::"Bank Account");
                    GenJournalRec.VALIDATE("Bal. Account No.", BankAccNo);
                END;

            GenJournalRec.VALIDATE("Document Type", GenJournalRec."Document Type"::Refund);
            GenJournalRec.VALIDATE("Sell-to/Buy-from No.", PDCRec."Sell-To/Buy-From No.");
            GenJournalRec.VALIDATE("Bill-to/Pay-to No.", PDCRec."Bill-To/Pay-To No.");
            //GenJournalRec.VALIDATE(Description, PDCRec."Sell-To/Buy-From Name");
            GenJournalRec.VALIDATE(Amount, PDCRec.Amount);
            GenJournalRec.VALIDATE("External Document No.", PDCRec."Cheque No.");
            GenJournalRec.Narration := Text5000 + FORMAT(PDCRec."Entry No.");


            CLEAR(NoSeriesMgt);
            GenJnlBatchRec.RESET;

            GenJournalRec."PDC Entry No." := PDCRec."Entry No.";
            GenJournalRec."Document No." := GLrec."Document No.";
            // GenJournalRec.VALIDATE("Shortcut Dimension 1 Code",GenJnlBatchRec."Global Dimension 1 Code");
            GenJournalRec."Shortcut Dimension 2 Code" := PDCRec."Shortcut Dimension 2 Code";
            GenJournalRec."Shortcut Dimension 3 Code" := PDCRec."Shortcut Dimension 3 Code";
            GenJournalRec."Shortcut Dimension 4 Code" := PDCRec."Shortcut Dimension 4 Code";
            GenJournalRec."Shortcut Dimension 5 Code" := PDCRec."Shortcut Dimension 5 Code";
            GenJournalRec."Shortcut Dimension 6 Code" := PDCRec."Shortcut Dimension 6 Code";
            GenJournalRec."Shortcut Dimension 7 Code" := PDCRec."Shortcut Dimension 7 Code";
            GenJournalRec."Shortcut Dimension 8 Code" := PDCRec."Shortcut Dimension 8 Code";
            GenJournalRec."Dimension Set ID" := PDCRec."Dimension Set ID";
            IF GenJnlTemplateRec.GET(GenJnlBatchRec."Journal Template Name") THEN
                GenJournalRec."Source Code" := GenJnlTemplateRec."Source Code";
        END;
        GenJnlPost.RUN(GenJournalRec);


        PDCRec.Remarks := PDCRec.Remarks::Deposit;
        PDCRec.Status := PDCRec.Status::Closed;
        PDCRec.Reversed := TRUE;
        PDCRec.MODIFY;

        MESSAGE(Text5001);
    end;
}

