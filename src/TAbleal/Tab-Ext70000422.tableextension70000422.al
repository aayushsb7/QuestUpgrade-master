tableextension 50013 "tableextension70000422" extends "Vendor Ledger Entry"
{
    fields
    {
        field(50001; "Sys. LC No."; Code[20])
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
        field(50002; "Bank LC No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "LC Amend No."; Code[20])
        {
            Caption = 'Amendment No.';
            DataClassification = ToBeClassified;
            TableRelation = "LC Amend Detail"."Version No." WHERE("No." = FIELD("Sys. LC No."));
        }
        field(50004; "Purchase Consignment No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'VAT1.00';
            TableRelation = "Purchase Consignment"."No." WHERE(Blocked = CONST(false));
        }
        field(50501; Narration; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'NP15.1001';
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
            OptionCaption = ' ,Margin,Charge,Document Value,TR Loan';
            OptionMembers = " ",Margin,Charge,"Document Value","TR Loan";
        }
    }


    //Unsupported feature: Code Modification on "CopyFromGenJnlLine(PROCEDURE 6)".

    //procedure CopyFromGenJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Vendor No." := GenJnlLine."Account No.";
    "Posting Date" := GenJnlLine."Posting Date";
    "Document Date" := GenJnlLine."Document Date";
    #4..35
    "Payment Reference" := GenJnlLine."Payment Reference";
    "Payment Method Code" := GenJnlLine."Payment Method Code";
    "Exported to Payment File" := GenJnlLine."Exported to Payment File";

    OnAfterCopyVendLedgerEntryFromGenJnlLine(Rec,GenJnlLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..38
    //UTS1.00 SM 12 Apr 2017
    IRDMgt.GetShortcutDimensionsInfo(GenJnlLine."Dimension Set ID",ShortcutDimCode);
    "Shortcut Dimension 3 Code" := ShortcutDimCode[3];//GenJnlLine."Shortcut Dimension 3 Code";
    "Shortcut Dimension 4 Code" := ShortcutDimCode[4];//GenJnlLine."Shortcut Dimension 4 Code";
    "Shortcut Dimension 5 Code" := ShortcutDimCode[5];//GenJnlLine."Shortcut Dimension 5 Code";
    "Shortcut Dimension 6 Code" := ShortcutDimCode[6];//GenJnlLine."Shortcut Dimension 6 Code";
    "Shortcut Dimension 7 Code" := ShortcutDimCode[7];//GenJnlLine."Shortcut Dimension 7 Code";
    "Shortcut Dimension 8 Code" := ShortcutDimCode[8];//GenJnlLine."Shortcut Dimension 8 Code";

    //UTS1.00 SM 12 Apr 2017
    //IME19.00 Begin
    "Sys. LC No." := GenJnlLine."Sys. LC No.";
    "Bank LC No." := GenJnlLine."Bank LC No.";
    "LC Amend No." := GenJnlLine."LC Amend No.";
    "Purchase Consignment No." := GenJnlLine."Purchase Consignment No.";
    //IME 19.00 End
    "LC Entry Type" := GenJnlLine."LC Entry Type"; //SM 16 Jan 2016
    OnAfterCopyVendLedgerEntryFromGenJnlLine(Rec,GenJnlLine);
    */
    //end;

    var
        IRDMgt: Codeunit "IRD Mgt.";
        ShortcutDimCode: array[8] of Code[20];
}

