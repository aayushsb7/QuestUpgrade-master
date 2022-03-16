table 50018 "FA Custodian"
{
    DrillDownPageID = 50023;
    LookupPageID = 50023;
    Permissions = TableData 5601 = rm;

    fields
    {
        field(1; "FA No."; Code[20])
        {
            TableRelation = "Fixed Asset";

            trigger OnValidate()
            begin
                CALCFIELDS("FA Description");
            end;
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = Customer;

            trigger OnValidate()
            begin
                CALCFIELDS("Employee Name");
            end;
        }
        field(3; "FA Description"; Text[50])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Fixed Asset".Description WHERE("No." = FIELD("FA No.")));

        }
        field(4; "Employee Name"; Text[50])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Employee No.")));

        }
        field(5; "Date of Ownership"; Date)
        {
        }
        field(6; "Current Owner"; Boolean)
        {
        }
        field(50001; Location; Code[20])
        {
            TableRelation = Location;
        }
        field(50002; "Date of Transfer"; Date)
        {
            Editable = false;
        }
        field(50003; "New Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                IF "Current Owner" THEN
                    ChangeDepartmentCode;
            end;
        }
        field(50004; "New Location Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));

            trigger OnValidate()
            begin
                IF "Current Owner" THEN
                    ChangeDepartmentCode;
            end;
        }
    }

    keys
    {
        key(Key1; "FA No.", "Employee No.", "Date of Ownership")
        {
            Clustered = true;
        }
        key(Key2; "FA No.", "Date of Ownership")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        FACustodianRec.RESET;
        FACustodianRec.SETRANGE("FA No.", "FA No.");
        FACustodianRec.SETRANGE("Current Owner", TRUE);
        IF FACustodianRec.FINDFIRST THEN BEGIN
            IF FACustodianRec."Employee No." <> "Employee No." THEN BEGIN
                FACustodianRec."Current Owner" := FALSE;
                FACustodianRec."Date of Transfer" := "Date of Ownership";
                FACustodianRec.MODIFY;
            END;
        END;
        "Current Owner" := TRUE;
    end;

    trigger OnRename()
    begin
        FACustodianRec."Date of Transfer" := "Date of Ownership";
    end;

    var
        FACustodianRec: Record "FA Custodian";


    procedure ChangeDepartmentCode()
    var
        FALedgerEntry: Record "FA Ledger Entry";
    begin
        /*IF ("New Department Code" <> '') OR ("New Location Code" <> '') THEN BEGIN
          FALedgerEntry.RESET;
          FALedgerEntry.SETCURRENTKEY("FA No.","Depreciation Book Code","FA Posting Date");
          FALedgerEntry.SETRANGE("FA No.","FA No.");
          IF FALedgerEntry.FINDLAST THEN BEGIN
            IF "New Department Code" <> '' THEN BEGIN
              FALedgerEntry."New Department Code" := "New Department Code";
              FALedgerEntry."Shortcut Dimension 3 Code" := "New Department Code";
            END;
            IF "New Location Code" <> '' THEN
              FALedgerEntry."New Location Code" := "New Location Code";
            FALedgerEntry.MODIFY;
          END;
        END;*/

    end;
}

