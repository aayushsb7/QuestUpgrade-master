tableextension 50065 "tableextension70001388" extends "General Ledger Setup"
{
    fields
    {
        field(50000; "LC Details Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50001; "Block Negative B/C on Bank"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Dimension Fields Editable"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "BG Detail Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50004; "DO Detail Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50005; "DAP Detail Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50006; "DAA Detail Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50007; "Loan Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50008; "Cash Book GL Filter"; Text[30])
        {
            DataClassification = ToBeClassified;

            trigger OnLookup()
            var
                GLAcc: Record "G/L Account";
            begin
                //SRT August 1st 2019 >>
                GLAcc.RESET;
                IF PAGE.RUNMODAL(0, GLAcc) = ACTION::LookupOK THEN
                    IF STRPOS("Cash Book GL Filter", GLAcc."No.") = 0 THEN
                        IF "Cash Book GL Filter" <> '' THEN
                            "Cash Book GL Filter" += '|' + GLAcc."No."
                        ELSE
                            "Cash Book GL Filter" := GLAcc."No.";
                //SRT August 1st 2019 <<
            end;
        }
        field(50009; "TDS Payment Jnl Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(50010; "TDS Payment Jnl Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("TDS Payment Jnl Template"));
        }
        field(56001; "Employee Dimension"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dimension.Code;
        }
        field(56055; "TDS Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST(BRANCH));
        }
        field(80004; "Exact Invoice Amount Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(80005; "Return Tolerance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(80006; "Enable Budget Control"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(90000; "User Accountability Center"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}

