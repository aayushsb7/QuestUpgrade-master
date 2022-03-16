tableextension 50028 "tableextension70000230" extends "G/L Entry"
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
        }
        field(50005; "Source Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Loan Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Loan Disbursement,Loan Repayment,Interest Payment,Additional Interest Payment,Booking Margin,Booking Commission,Release Margin,Document Value';
            OptionMembers = " ","Loan Disbursement","Loan Repayment","Interest Payment","Additional Interest Payment","Booking Margin","Booking Commission","Release Margin","Document Value";
        }
        field(50007; "Loan Repayment Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "FA Item Charge"; Code[20])
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
            OptionCaption = ' ,Taxable Import Purchase,Exempt Purchase,Taxable Local Purchase,Taxable Capex Purchase,Taxable Sales,Non Taxable Sales,Exempt Sales,Prepayments,Purchase Without VAT Invoice,Sales without VAT Invoice,Direct Sales';
            OptionMembers = " ","Taxable Import Purchase","Exempt Purchase","Taxable Local Purchase","Taxable Capex Purchase","Taxable Sales","Non Taxable Sales","Exempt Sales",Prepayments,"Purchase Without VAT Invoice","Sales without VAT Invoice","Direct Sales";
        }
        field(59000; "TDS Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'TDS1.00';
            TableRelation = "TDS Posting Group".Code;
        }
        field(59001; "TDS%"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'TDS1.00';
        }
        field(59002; "TDS Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'TDS1.00';
            OptionCaption = ' ,Purchase TDS,Sales TDS';
            OptionMembers = " ","Purchase TDS","Sales TDS";
        }
        field(59003; "TDS Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'TDS1.00';
        }
        field(59004; "TDS Base Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'TDS1.00';
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
            TableRelation = "TR Loan"."TR Code" WHERE("LC No." = FIELD("TR Loan Code"));
        }

        field(70006; "Shortcut Dimension 3 Name"; Text[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Shortcut Dimension 3 Code")));
            CaptionClass = '1,2,3, Name ';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70007; "Shortcut Dimension 4 Name"; Text[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Shortcut Dimension 4 Code")));
            CaptionClass = '1,2,4, Name ';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70008; "Shortcut Dimension 5 Name"; Text[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Shortcut Dimension 5 Code")));
            CaptionClass = '1,2,5, Name ';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70009; "Shortcut Dimension 6 Name"; Text[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Shortcut Dimension 6 Code")));
            CaptionClass = '1,2,6, Name ';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70010; "Shortcut Dimension 7 Name"; Text[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Shortcut Dimension 7 Code")));
            CaptionClass = '1,2,7, Name ';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70011; "Shortcut Dimension 8 Name"; Text[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Shortcut Dimension 8 Code")));
            CaptionClass = '1,2,8, Name ';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70012; "Global Dimension 1 Name"; Text[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Global Dimension 1 Code")));
            CaptionClass = '1,1,1, Name ';
            Caption = 'Global Dimension 1 Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70013; "Global Dimension 2 Name"; Text[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Global Dimension 2 Code")));
            CaptionClass = '1,1,2, Name ';
            Caption = 'Global Dimension 2 Name';
            Editable = false;
            FieldClass = FlowField;
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
        }
        field(90003; "Amount (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(90004; Comment; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(90005; "Sys. Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(90006; "Nepali Document Date"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }


    //Unsupported feature: Code Modification on "CopyFromGenJnlLine(PROCEDURE 4)".

    //procedure CopyFromGenJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Posting Date" := GenJnlLine."Posting Date";
    "Document Date" := GenJnlLine."Document Date";
    "Document Type" := GenJnlLine."Document Type";
    "Document No." := GenJnlLine."Document No.";
    "External Document No." := GenJnlLine."External Document No.";
    #6..33
    "No. Series" := GenJnlLine."Posting No. Series";
    "IC Partner Code" := GenJnlLine."IC Partner Code";
    "Prod. Order No." := GenJnlLine."Prod. Order No.";

    OnAfterCopyGLEntryFromGenJnlLine(Rec,GenJnlLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Posting Date" := GenJnlLine."Posting Date";
    "Nepali Posting Date" := GenJnlLine."Nepal Posting Date";
    "Document Date" := GenJnlLine."Document Date";
    "Nepali Document Date" := GenJnlLine."Nepali Document Date"; //Ami 4/6/2021
    #3..36
    "Amount (LCY)" := GenJnlLine."Amount (LCY)"; // MIN 9/9/2019
    Comment := GenJnlLine.Comment; //Sameer Dec 12 2020
    "Sys. Loan No." := GenJnlLine."Sys. Loan No."; //Sameer Dec 12 2020
    IRDMgt.CopyGLEntryFromGenJnlLine(Rec,GenJnlLine);  //all added fields keep here

    OnAfterCopyGLEntryFromGenJnlLine(Rec,GenJnlLine);
    */
    //end;

    var
        IRDMgt: Codeunit "50000";
}

