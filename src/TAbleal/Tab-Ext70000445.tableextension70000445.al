tableextension 70000445 "tableextension70000445" extends "Bank Account Ledger Entry"
{
    LookupPageID = 50021;
    DrillDownPageID = 50021;
    fields
    {
        field(50001; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Bank,Loan';
            OptionMembers = Bank,Loan;
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
        field(50012; "Loan No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50501; Narration; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'NP15.1001';
        }
        field(50502; "Sys. Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }


    //Unsupported feature: Code Modification on "CopyFromGenJnlLine(PROCEDURE 3)".

    //procedure CopyFromGenJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Bank Account No." := GenJnlLine."Account No.";
    "Posting Date" := GenJnlLine."Posting Date";
    "Document Date" := GenJnlLine."Document Date";
    #4..15
    "User ID" := USERID;
    "Bal. Account Type" := GenJnlLine."Bal. Account Type";
    "Bal. Account No." := GenJnlLine."Bal. Account No.";

    OnAfterCopyFromGenJnlLine(Rec,GenJnlLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..18
    Narration := GenJnlLine.Narration;
    "Sys. Loan No." := GenJnlLine."Sys. Loan No.";
    OnAfterCopyFromGenJnlLine(Rec,GenJnlLine);
    */
    //end;
}

