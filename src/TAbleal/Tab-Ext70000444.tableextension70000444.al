tableextension 50016 "tableextension70000444" extends "Bank Account"
{
    fields
    {
        field(50000; "Capping Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Bank,Loan';
            OptionMembers = Bank,Loan;
        }
        field(50002; "Loan Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Short Term Loan,Hire Purchase Loan,Long Term Loan,Equipment Loan';
            OptionMembers = " ","Short Term Loan","Hire Purchase Loan","Long Term Loan","Equipment Loan";
        }
        field(50003; "Issuing Bank"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account" WHERE(Type = CONST(Bank));

            trigger OnValidate()
            var
                BankAcount: Record "Bank Account";
            begin
                /*IF BankAcount.GET("Issuing Bank") THEN
                  VALIDATE("Bank Acc. Posting Group",BankAcount."Bank Acc. Posting Group")
                ELSE
                  VALIDATE("Bank Acc. Posting Group",'');
                 */

            end;
        }
        field(50004; "Issuing Bank Name"; Text[50])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Bank Account".Name WHERE("No." = FIELD("Issuing Bank")));

        }
        field(50005; "Documentary Credit No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalculateTimeInYears;
            end;
        }
        field(50007; "End Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalculateTimeInYears;
            end;
        }
        field(50008; "Time in Years"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Loan Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Interest Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Interest Charge"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Loan No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; Released; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50014; "Bank Categories"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Commercial Bank,Development Bank,Sahakari,Investment Company';
            OptionMembers = " ","Commercial Bank","Development Bank",Sahakari,"Investment Company";
        }
        field(50015; "Repayment Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FIELD("No."),
                                                                        "Posting Date" = FIELD("Date Filter"),
                                                                        "Loan Transaction Type" = CONST("Loan Repayment")));

        }
        field(50016; "Disbursement Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Posting Date" = FIELD("Date Filter"),
                                                                        "Bank Account No." = FIELD("No."),
                                                                        "Loan Transaction Type" = CONST("Loan Disbursement")));

        }
        field(50017; "Interest Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FIELD("No."),
                                                                       "Posting Date" = FIELD("Date Filter"),
                                                                        "Loan Transaction Type" = CONST("Interest Payment")));

        }
    }
    keys
    {

    }


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "No." = '' THEN BEGIN
      GLSetup.GET;
      GLSetup.TESTFIELD("Bank Account Nos.");
      NoSeriesMgt.InitSeries(GLSetup."Bank Account Nos.",xRec."No. Series",0D,"No.","No. Series");
    END;

    IF NOT InsertFromContact THEN
      UpdateContFromBank.OnInsert(Rec);

    DimMgt.UpdateDefaultDim(
      DATABASE::"Bank Account","No.",
      "Global Dimension 1 Code","Global Dimension 2 Code");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF "No." = '' THEN BEGIN
      GLSetup.GET;
      IF Type = Type::Bank THEN BEGIN
      GLSetup.TESTFIELD("Bank Account Nos.");
      NoSeriesMgt.InitSeries(GLSetup."Bank Account Nos.",xRec."No. Series",0D,"No.","No. Series");
      END ELSE IF Type = Type::Loan THEN BEGIN //SRT August 10th 2019
        GLSetup.TESTFIELD("Loan Nos.");
        NoSeriesMgt.InitSeries(GLSetup."Loan Nos.",xRec."No. Series",0D,"No.","No. Series");
      END;
    END;

    IF Type = Type::Bank THEN  //SRT August 10th 2019
    #7..12
    */
    //end;


    //Unsupported feature: Code Modification on "OnModify".

    //trigger OnModify()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Last Date Modified" := TODAY;

    IF IsContactUpdateNeeded THEN BEGIN
    #4..7
        IF FIND THEN;
      END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //SRT August 10th 2019 >>
    IF Type = Type::Loan THEN BEGIN
      IF Blocked = xRec.Blocked THEN
        TESTFIELD(Released, FALSE);
    END;
    //SRT August 10th 2019 <<
    #1..10
    */
    //end;

    local procedure "-----Agile-----"()
    begin
    end;

    local procedure CalculateTimeInYears()
    begin
        "Time in Years" := 0;
        IF ("Start Date" <> 0D) AND ("End Date" <> 0D) THEN
            "Time in Years" := ("End Date" - "Start Date") / 365;
    end;

    procedure LoanReleased()
    begin
        IF Released THEN
            ERROR('Loan account already released.');
        TESTFIELD(Name);
        TESTFIELD("Issuing Bank");
        TESTFIELD("Bank Acc. Posting Group");
        TESTFIELD("Loan Type");
        //TESTFIELD("Start Date");
        //TESTFIELD("End Date");
        //TESTFIELD("Loan Amount");
        //TESTFIELD("Interest Rate");

        Released := TRUE;
        MODIFY;
        MESSAGE('Loan Account Released.');
    end;
}

