table 50020 "Loan Repayment Schedule"
{

    fields
    {
        field(1; "Loan Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account" WHERE(Type = CONST(Loan));
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Bank No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account" WHERE(Type = CONST(Bank));

            trigger OnValidate()
            begin
                IF Loan.GET("Loan Account No.") THEN BEGIN
                    TESTFIELD("Bank No.", Loan."Issuing Bank");
                END;
            end;
        }
        field(4; "Bank Name"; Text[50])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Bank Account".Name WHERE("No." = FIELD("Bank No.")));

        }
        field(5; "Principal Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Installment Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Installment Payment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Installment Pmt. Nepali Date"; Text[30])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("English-Nepali Date"."Nepali Date" WHERE("English Date" = FIELD("Installment Payment Date")));

        }
        field(9; "Interest Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Interest Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Remaining Interest Amount"; Decimal)
        {
        }
        field(12; "Remaining Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Repayment Posted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Repayment Reversed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Interest Posted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan Account No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Loan Account No.", "Line No.", "Principal Amount", "Remaining Amount", "Interest Amount", "Remaining Interest Amount")
        {
        }
    }

    trigger OnInsert()
    begin
        Loan.GET("Loan Account No.");
        "Bank No." := Loan."Issuing Bank";
    end;

    trigger OnModify()
    begin
        /*IF "Repayment Posted" THEN
          ERROR('Cannot Modified Posted Repayment Schedule');*/

    end;

    var
        Loan: Record "Bank Account";
}

