tableextension 50058 "tableextension70001201" extends "Standard General Journal Line"
{
    fields
    {
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
        field(50004; "Employee Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Salary Advance,Expense Advance,Other';
            OptionMembers = " ","Salary Advance","Expense Advance",Other;

            trigger OnValidate()
            begin
                IF "Account Type" <> "Account Type"::Employee THEN
                    ERROR('Advance Type must be specified only for Account Type ::Employee');
            end;
        }
        field(50005; "Loan Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Loan Disbursement,Loan Repayment,Interest Payment,Additional Interest Payment,Booking Margin,Booking Commission,Release Margin,Document Value';
            OptionMembers = " ","Loan Disbursement","Loan Repayment","Interest Payment","Additional Interest Payment","Booking Margin","Booking Commission","Release Margin","Document Value";
        }
        field(50006; "Loan Repayment Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Loan Transaction Type" = CONST("Interest Payment")) "Loan Repayment Schedule"."Line No." WHERE("Loan Account No." = FIELD("Account No."),
                                                                                                                          "Interest Posted" = CONST(false))
            ELSE
            IF ("Loan Transaction Type" = CONST("Loan Repayment")) "Loan Repayment Schedule"."Line No." WHERE("Loan Account No." = FIELD("Account No."),
                                                                                                                    "Repayment Posted" = CONST(false));

            trigger OnValidate()
            var
                LoanAccount: Record "Bank Account";
                LoanPaymentSchedule: Record "Loan Repayment Schedule";
            begin
            end;
        }
        field(50007; "FA Item Charge"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Charge";
        }
        field(50501; Narration; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'NP15.1001';
        }
        field(50502; PragyapanPatra; Code[100])
        {
            DataClassification = ToBeClassified;
            Description = 'NP15.1001';
        }
        field(50503; "Localized VAT Identifier"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'NP15.1001';
            Editable = false;
            OptionCaption = ' ,Taxable Import Purchase,Exempt Purchase,Taxable Local Purchase,Taxable Capex Purchase,Taxable Sales,Non Taxable Sales,Exempt Sales,Prepayments,Purchase Without VAT Invoice,Sales without VAT Invoice,Direct Sales';
            OptionMembers = " ","Taxable Import Purchase","Exempt Purchase","Taxable Local Purchase","Taxable Capex Purchase","Taxable Sales","Non Taxable Sales","Exempt Sales",Prepayments,"Purchase Without VAT Invoice","Sales without VAT Invoice","Direct Sales";
        }
        field(50509; "Line Type"; Option)
        {
            Caption = 'Line Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee,Loan';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Loan;
        }
        field(50510; "Bal. Line Type"; Option)
        {
            Caption = 'Bal. Line Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee,Loan';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Loan;
        }
        field(59000; "TDS Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'TDS1.00';
            TableRelation = "TDS Posting Group".Code WHERE(Blocked = CONST(false));
        }
        field(59001; "TDS%"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'TDS1.00';
            Editable = false;
        }
        field(59002; "TDS Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'TDS1.00';
            Editable = false;
            OptionCaption = ' ,Purchase TDS,Sales TDS';
            OptionMembers = " ","Purchase TDS","Sales TDS";
        }
        field(59003; "TDS Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'TDS1.00';
            Editable = false;
        }
        field(59004; "TDS Base Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'TDS1.00';
            Editable = false;
        }
        field(59005; "Document Class"; Option)
        {
            Caption = 'Document Class';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Customer,Vendor,Bank Account,Fixed Assets';
            OptionMembers = " ",Customer,Vendor,"Bank Account","Fixed Assets";
        }
        field(59006; "Document Subclass"; Code[20])
        {
            Caption = 'Document Subclass';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Document Class" = CONST(Customer)) Customer
            ELSE
            IF ("Document Class" = CONST(Vendor)) Vendor
            ELSE
            IF ("Document Class" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Document Class" = CONST("Fixed Assets")) "Fixed Asset";
        }
        field(59007; "TR Loan Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "TR Loan";
        }
        field(59008; "Main G/L Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'TDS1.00';
        }
        field(59009; "Main G/L Account Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'TDS1.00';
        }
        field(70000; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(70001; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(70002; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");
            end;
        }
        field(70003; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(6, "Shortcut Dimension 6 Code");
            end;
        }
        field(70004; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(7, "Shortcut Dimension 7 Code");
            end;
        }
        field(70005; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(8, "Shortcut Dimension 8 Code");
            end;
        }
        field(80000; "LC Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Margin,Charge,Document Value,TR Loan,Commission';
            OptionMembers = " ",Margin,Charge,"Document Value","TR Loan",Commission;
        }
        field(90000; "TDS Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(90001; "PDC Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(90002; "Nepali Posting Date"; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF ("Nepali Posting Date" = 'T') OR ("Nepali Posting Date" = 't') THEN
                    "Nepali Posting Date" := IRDMgt.getNepaliDate(TODAY);
            end;
        }
    }

    var
        IRDMgt: Codeunit "IRD Mgt.";
}

