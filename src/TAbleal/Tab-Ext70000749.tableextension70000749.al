tableextension 50048 "tableextension70000749" extends "Employee Ledger Entry"
{
    fields
    {
        field(50004; "Employee Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Salary Advance,Expense Advance,Other';
            OptionMembers = " ","Salary Advance","Expense Advance",Other;
        }
        field(50005; "G/L Account No."; Code[20])
        {
            CalcFormula = Lookup("G/L Entry"."G/L Account No." WHERE("Entry No." = FIELD("Entry No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }


    //Unsupported feature: Code Modification on "CopyFromGenJnlLine(PROCEDURE 6)".

    //procedure CopyFromGenJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Employee No." := GenJnlLine."Account No.";
    "Posting Date" := GenJnlLine."Posting Date";
    "Document Type" := GenJnlLine."Document Type";
    #4..15
    "Bal. Account Type" := GenJnlLine."Bal. Account Type";
    "Bal. Account No." := GenJnlLine."Bal. Account No.";
    "No. Series" := GenJnlLine."Posting No. Series";
    "Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type";
    "Applies-to Doc. No." := GenJnlLine."Applies-to Doc. No.";
    "Applies-to ID" := GenJnlLine."Applies-to ID";

    OnAfterCopyEmployeeLedgerEntryFromGenJnlLine(Rec,GenJnlLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..18
    "Employee Transaction Type" := GenJnlLine."Employee Transaction Type";//AT
    #19..23
    */
    //end;
}

