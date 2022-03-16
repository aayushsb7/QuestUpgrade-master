tableextension 50032 "tableextension70001244" extends "Gen. Journal Line"
{
    fields
    {
        modify("Account Type")
        {
            Caption = 'Default Account Type';
        }
        modify("Account No.")
        {
            TableRelation = IF ("Line Type" = CONST(Loan)) "Bank Account" WHERE(Type = CONST(Loan),
                                                                             Released = CONST(true),
                                                                             Blocked = CONST(false))
            ELSE
            IF ("Line Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                                                                                                         Blocked = CONST(false))
            ELSE
            IF ("Line Type" = CONST(Customer)) Customer
            ELSE
            IF ("Line Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Line Type" = CONST("Bank Account")) "Bank Account" WHERE(Type = CONST(Bank))
            ELSE
            IF ("Line Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Line Type" = CONST("IC Partner")) "IC Partner"
            ELSE
            IF ("Line Type" = CONST(Employee)) Employee;
        }
        modify("Bal. Account No.")
        {
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                                                           Blocked = CONST(false))
            ELSE
            IF ("Bal. Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Bal. Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account" WHERE(Type = CONST(Bank))
            ELSE
            IF ("Bal. Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Bal. Account Type" = CONST("IC Partner")) "IC Partner"
            ELSE
            IF ("Bal. Account Type" = CONST(Employee)) Employee;
        }

        //Unsupported feature: Code Modification on ""Account Type"(Field 3).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Fixed Asset",
                               "Account Type"::"IC Partner","Account Type"::Employee]) AND
           ("Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Fixed Asset",
        #4..44
            IF GenJnlTemplate.Type <> GenJnlTemplate.Type::Intercompany THEN
              FIELDERROR("Account Type");
          END;

        VALIDATE("Deferral Code",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..47
        IF "Account Type" <> "Account Type"::Customer THEN
          VALIDATE("Credit Card No.",'');

        VALIDATE("Deferral Code",'');
        */
        //end;


        //Unsupported feature: Code Modification on ""Account No."(Field 4).OnValidate".

        //trigger "(Field 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Account No." <> xRec."Account No." THEN BEGIN
          ClearAppliedAutomatically;
          VALIDATE("Job No.",'');
        #4..51
          "Account Type"::Customer:
            UpdateCustomerID;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..54


        IF xRec."Line Type" IN ["Line Type"::Customer,"Line Type"::Vendor,"Line Type"::"IC Partner"] THEN//bikalpa
          "IC Partner Code" := '';

        IF "Account No." = '' THEN BEGIN
          CleanLine;
          EXIT;
        END;

        CASE "Line Type" OF
          "Line Type"::"G/L Account":
            GetGLAccount;
          "Line Type"::Customer:
            GetCustomerAccount;
          "Line Type"::Vendor:
            GetVendorAccount;
          "Line Type"::Employee:
            GetEmployeeAccount;
          "Line Type"::"Bank Account":
            GetBankAccount;
          "Line Type"::"Fixed Asset":
            GetFAAccount;
          "Line Type"::"IC Partner":
            GetICPartnerAccount;
        END;

        VALIDATE("Currency Code");
        VALIDATE("VAT Prod. Posting Group");
        UpdateLineBalance;
        UpdateSource;
        CreateDim(
          DimMgt.TypeToTableID1("Account Type"),"Account No.",
          DimMgt.TypeToTableID1("Bal. Account Type"),"Bal. Account No.",
          DATABASE::Job,"Job No.",
          DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
          DATABASE::Campaign,"Campaign No.");

        VALIDATE("IC Partner G/L Acc. No.",GetDefaultICPartnerGLAccNo);
        ValidateApplyRequirements(Rec);

        CASE "Line Type" OF
          "Line Type"::"G/L Account":
            UpdateAccountID;
          "Line Type"::Customer:
            UpdateCustomerID;
        END;
        */
        //end;


        //Unsupported feature: Code Modification on ""Posting Date"(Field 5).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Posting Date");
        VALIDATE("Document Date","Posting Date");
        VALIDATE("Currency Code");
        #4..13

        IF "Deferral Code" <> '' THEN
          VALIDATE("Deferral Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //VALIDATE("Document Date","Posting Date"); // comment *** MIN 8/30/2019
        "Nepal Posting Date" := IRDMgt.getNepaliDate("Posting Date");
        #1..16
        */
        //end;


        //Unsupported feature: Code Modification on "Amount(Field 13).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateAmount;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ValidateAmount();
        CalculateTDSAmount; //TDS1.00
        */
        //end;


        //Unsupported feature: Code Insertion on ""Shortcut Dimension 2 Code"(Field 25)".

        //trigger OnLookup(var Text: Text): Boolean
        //var
        //DimValue: Record "349";
        //GenLedgSetup: Record "98";
        //DimValuePage: Page "537";
        //begin
        /*
        //SRT June 6th 2019 >>
        GenLedgSetup.GET;
        CLEAR(DimValuePage);
        DimValue.RESET;
        FILTERGROUP(0);
        DimValue.SETRANGE("Dimension Code",GenLedgSetup."Shortcut Dimension 2 Code");
        IF ("Account Type" = "Account Type"::"G/L Account") AND ("Bal. Account Type" = "Bal. Account Type"::"G/L Account") THEN
          DimValue.SETRANGE("G/L Account No.","Account No.");
        FILTERGROUP(2);
        IF DimValue.FINDFIRST THEN BEGIN
          DimValuePage.SETTABLEVIEW(DimValue);
          DimValuePage.SETRECORD(DimValue);
          DimValuePage.LOOKUPMODE(TRUE);
          DimValuePage.EDITABLE(FALSE);
          IF DimValuePage.RUNMODAL = ACTION::LookupOK THEN BEGIN
            DimValuePage.GETRECORD(DimValue);
            VALIDATE("Shortcut Dimension 2 Code",DimValue.Code);
          END;
        END ELSE BEGIN
          DimValue.RESET;
          DimValue.SETRANGE("Dimension Code",GenLedgSetup."Shortcut Dimension 2 Code");
          DimValuePage.SETTABLEVIEW(DimValue);
          DimValuePage.SETRECORD(DimValue);
          DimValuePage.LOOKUPMODE(TRUE);
          DimValuePage.EDITABLE(FALSE);
          IF DimValuePage.RUNMODAL = ACTION::LookupOK THEN BEGIN
            DimValuePage.GETRECORD(DimValue);
            VALIDATE("Shortcut Dimension 2 Code",DimValue.Code);
          END;
        END;
        //SRT June 6th 2019 <<
        */
        //end;


        //Unsupported feature: Code Modification on ""VAT Amount"(Field 44).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GenJnlBatch.GET("Journal Template Name","Journal Batch Name");
        GenJnlBatch.TESTFIELD("Allow VAT Difference",TRUE);
        IF NOT ("VAT Calculation Type" IN
        #4..41

        IF "Deferral Code" <> '' THEN
          VALIDATE("Deferral Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..44

        CalculateTDSAmount; //TDS1.00
        */
        //end;


        //Unsupported feature: Code Modification on ""Gen. Posting Type"(Field 57).OnValidate".

        //trigger  Posting Type"(Field 57)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckIfFieldIsEmpty := "Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Bank Account"];
        OnBeforeValidateGenPostingType(Rec,CheckIfFieldIsEmpty);
        IF CheckIfFieldIsEmpty THEN
        #4..7
        IF "Gen. Posting Type" > 0 THEN
          VALIDATE("VAT Prod. Posting Group");
        IF "Gen. Posting Type" <> "Gen. Posting Type"::Purchase THEN
          VALIDATE("Use Tax",FALSE)
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..10
          VALIDATE("Use Tax",FALSE);

        CalculateTDSAmount; //TDS1.00
        */
        //end;


        //Unsupported feature: Code Modification on ""Bal. Gen. Posting Type"(Field 64).OnValidate".

        //trigger  Gen()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckIfFieldIsEmpty :=
          "Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Bank Account"];
        OnBeforeValidateBalGenPostingType(Rec,CheckIfFieldIsEmpty);
        #4..15
        END;
        IF "Bal. Gen. Posting Type" <> "Bal. Gen. Posting Type"::Purchase THEN
          VALIDATE("Bal. Use Tax",FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..18

        CalculateTDSAmount; //TDS1.00
        */
        //end;


        //Unsupported feature: Code Modification on ""Document Date"(Field 76).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        VALIDATE("Payment Terms Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        VALIDATE("Payment Terms Code");
        //"Nepal Posting Date" := IRDMgt.getNepaliDate("Document Date");  //MIN 8/30/2019
        "Nepali Document Date" := IRDMgt.getNepaliDate("Document Date"); //Amisha 4/19/2021
        */
        //end;


        //Unsupported feature: Code Modification on ""VAT Prod. Posting Group"(Field 91).OnValidate".

        //trigger  Posting Group"(Field 91)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Bank Account"] THEN
          TESTFIELD("VAT Prod. Posting Group",'');

        #4..27
        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine;
          UpdatePricesFromJobJnlLine;
        END
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..30
        END;

        CalculateTDSAmount; //TDS1.00
        IRDMgt.GetCustomVATPostingSetupOnJournalLine(Rec,xRec,FIELDNO("VAT Registration No."));
        */
        //end;


        //Unsupported feature: Code Modification on ""Bal. VAT Prod. Posting Group"(Field 93).OnValidate".

        //trigger  VAT Prod()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Bal. Account Type" IN
           ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Bank Account"]
        THEN
        #4..20
          END;
        END;
        VALIDATE("Bal. VAT %");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..23

        CalculateTDSAmount; //TDS1.00
        */
        //end;
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
                //Sameer - Flow Loan No
                IF LCDetail.GET("Sys. LC No.") AND (LCDetail."Document Type" = LCDetail."Document Type"::"Letter of Credit") THEN
                    LCDetail.TESTFIELD("Loan No.");

                "Sys. Loan No." := LCDetail."Loan No.";
                //
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
                TESTFIELD("Loan Transaction Type");
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

            trigger OnValidate()
            begin
                IF "Line Type" = "Line Type"::Loan THEN
                    VALIDATE("Account Type", "Account Type"::"Bank Account")
                ELSE
                    VALIDATE("Account Type", "Line Type");
            end;
        }
        field(50510; "Bal. Line Type"; Option)
        {
            Caption = 'Bal. Line Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee,Loan';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Loan;

            trigger OnValidate()
            begin
                IF "Bal. Line Type" = "Bal. Line Type"::Loan THEN
                    VALIDATE("Bal. Account Type", "Bal. Account Type"::"Bank Account")
                ELSE
                    VALIDATE("Bal. Account Type", "Bal. Line Type");
            end;
        }
        field(59000; "TDS Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'TDS1.00';
            TableRelation = "TDS Posting Group".Code WHERE(Blocked = CONST(false));

            trigger OnValidate()
            begin
                CalculateTDSAmount; //TDS1.00
            end;
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
        field(90002; "Nepal Posting Date"; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF ("Nepal Posting Date" = 'T') OR ("Nepal Posting Date" = 't') THEN BEGIN
                    "Nepal Posting Date" := IRDMgt.getNepaliDate(TODAY);
                    "Posting Date" := EnglishNepaliDate.getEngDate("Nepal Posting Date");

                END;

                "Posting Date" := EnglishNepaliDate.getEngDate("Nepal Posting Date");
            end;
        }
        field(90003; "Sys. Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(90004; "Nepali Document Date"; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Ami 4/6/2021
                IF ("Nepali Document Date" = 'T') OR ("Nepali Document Date" = 't') THEN BEGIN
                    "Nepali Document Date" := IRDMgt.getNepaliDate(TODAY);
                    "Document Date" := EnglishNepaliDate.getEngDate("Nepali Document Date");
                END;

                "Document Date" := EnglishNepaliDate.getEngDate("Nepali Document Date");
            end;
        }
    }


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GenJnlAlloc.LOCKTABLE;
    LOCKTABLE;

    #4..10

    ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
    ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..13
    //IME>RD
    ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
    ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
    ValidateShortcutDimCode(5,"Shortcut Dimension 5 Code");
    ValidateShortcutDimCode(6,"Shortcut Dimension 6 Code");
    ValidateShortcutDimCode(7,"Shortcut Dimension 7 Code");
    ValidateShortcutDimCode(8,"Shortcut Dimension 8 Code");
    //IME>RD
    */
    //end;


    //Unsupported feature: Code Modification on "SetUpNewLine(PROCEDURE 9)".

    //procedure SetUpNewLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GenJnlTemplate.GET("Journal Template Name");
    GenJnlBatch.GET("Journal Template Name","Journal Batch Name");
    GenJnlLine.SETRANGE("Journal Template Name","Journal Template Name");
    #4..6
      "Document Date" := LastGenJnlLine."Posting Date";
      "Document No." := LastGenJnlLine."Document No.";
      OnSetUpNewLineOnBeforeIncrDocNo(GenJnlLine,LastGenJnlLine);
      IF BottomLine AND
         (Balance - LastGenJnlLine."Balance (LCY)" = 0) AND
         NOT LastGenJnlLine.EmptyLine
    #13..24
    CASE GenJnlTemplate.Type OF
      GenJnlTemplate.Type::Payments:
        BEGIN
          "Account Type" := "Account Type"::Vendor;
          "Document Type" := "Document Type"::Payment;
        END;
      ELSE BEGIN
        "Account Type" := LastGenJnlLine."Account Type";
        "Document Type" := LastGenJnlLine."Document Type";
      END;
    END;
    #36..38
    "Bal. Account Type" := GenJnlBatch."Bal. Account Type";
    IF ("Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Fixed Asset"]) AND
       ("Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Fixed Asset"])
    THEN
      "Account Type" := "Account Type"::"G/L Account";
    VALIDATE("Bal. Account No.",GenJnlBatch."Bal. Account No.");
    Description := '';
    IF GenJnlBatch."Suggest Balancing Amount" THEN
      SuggestBalancingAmount(LastGenJnlLine,BottomLine);

    UpdateJournalBatchID;

    OnAfterSetupNewLine(Rec,GenJnlTemplate,GenJnlBatch,LastGenJnlLine,Balance,BottomLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..9
      VALIDATE("Nepal Posting Date" ,LastGenJnlLine."Nepal Posting Date"); //SRT August 18th 2019
    #10..27
          "Account Type" := "Account Type"::Vendor;//bikalpa
          "Line Type" := "Line Type"::Vendor;  //SRT Mar 5th 2020
    #29..32
        "Line Type" := LastGenJnlLine."Line Type"; //SRT Mar 5th 2020
    #33..41
    THEN BEGIN
      "Account Type" := "Account Type"::"G/L Account";
      "Line Type" := "Line Type"::"G/L Account"; //SRT Mar 20th 2020
    END;
    #44..51
    */
    //end;


    //Unsupported feature: Code Modification on "CreateDim(PROCEDURE 13)".

    //procedure CreateDim();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TableID[1] := Type1;
    No[1] := No1;
    TableID[2] := Type2;
    #4..11

    "Shortcut Dimension 1 Code" := '';
    "Shortcut Dimension 2 Code" := '';
    "Dimension Set ID" :=
      DimMgt.GetRecDefaultDimID(
        Rec,CurrFieldNo,TableID,No,"Source Code","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code",0,0);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..14
    //IME>RD
    "Shortcut Dimension 3 Code" := '';
    "Shortcut Dimension 4 Code" := '';
    "Shortcut Dimension 5 Code" := '';
    "Shortcut Dimension 6 Code" := '';
    "Shortcut Dimension 7 Code" := '';
    "Shortcut Dimension 8 Code" := '';
    //IME>RD
    #15..17
    //IME>RD
    {"Dimension Set ID" :=
      DimMgt.GetDefaultDimID2(TableID,No,"Source Code","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code",
        "Shortcut Dimension 3 Code","Shortcut Dimension 4 Code","Shortcut Dimension 5 Code",
        "Shortcut Dimension 6 Code","Shortcut Dimension 7 Code","Shortcut Dimension 8 Code",0,0);}
    //IME>RD
    */
    //end;


    //Unsupported feature: Code Modification on "CopyFromInvoicePostBuffer(PROCEDURE 112)".

    //procedure CopyFromInvoicePostBuffer();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Account No." := InvoicePostBuffer."G/L Account";
    "System-Created Entry" := InvoicePostBuffer."System-Created Entry";
    "Gen. Bus. Posting Group" := InvoicePostBuffer."Gen. Bus. Posting Group";
    #4..22
    "Source Curr. VAT Amount" := InvoicePostBuffer."VAT Amount (ACY)";
    "VAT Difference" := InvoicePostBuffer."VAT Difference";
    "VAT Base Before Pmt. Disc." := InvoicePostBuffer."VAT Base Before Pmt. Disc.";

    OnAfterCopyGenJnlLineFromInvPostBuffer(InvoicePostBuffer,Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..25
    IRDMgt.CopyGenJnlLineFromInvPostBufferPurchase(Rec,InvoicePostBuffer); //IRD19.00

    OnAfterCopyGenJnlLineFromInvPostBuffer(InvoicePostBuffer,Rec);
    */
    //end;


    //Unsupported feature: Code Modification on "CopyFromPurchHeader(PROCEDURE 109)".

    //procedure CopyFromPurchHeader();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Source Currency Code" := PurchHeader."Currency Code";
    "Currency Factor" := PurchHeader."Currency Factor";
    Correction := PurchHeader.Correction;
    #4..14
    "On Hold" := PurchHeader."On Hold";
    IF "Account Type" = "Account Type"::Vendor THEN
      "Posting Group" := PurchHeader."Vendor Posting Group";

    OnAfterCopyGenJnlLineFromPurchHeader(PurchHeader,Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..17
    //IME19.00 Begin
    "Sys. LC No." := PurchHeader."Sys. LC No.";
    "Bank LC No." := PurchHeader."Bank LC No.";
    "LC Amend No." := PurchHeader."LC Amend No.";
    "Purchase Consignment No." := PurchHeader."Purchase Consignment No.";
    //IME19.00 End

    //SM 16 Jan 2017
    IF "Sys. LC No." <> '' THEN
      "LC Entry Type" := "LC Entry Type"::"Document Value";
    //SM 16 Jan 2017
    OnAfterCopyGenJnlLineFromPurchHeader(PurchHeader,Rec);
    */
    //end;


    //Unsupported feature: Code Modification on "CopyFromSalesHeader(PROCEDURE 103)".

    //procedure CopyFromSalesHeader();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Source Currency Code" := SalesHeader."Currency Code";
    "Currency Factor" := SalesHeader."Currency Factor";
    "VAT Base Discount %" := SalesHeader."VAT Base Discount %";
    #4..15
    "On Hold" := SalesHeader."On Hold";
    IF "Account Type" = "Account Type"::Customer THEN
      "Posting Group" := SalesHeader."Customer Posting Group";

    OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader,Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..18
    //IME19.00 Begin
    "Sys. LC No." := SalesHeader."Sys. LC No.";
    "Bank LC No." := SalesHeader."Bank LC No.";
    "LC Amend No." := SalesHeader."LC Amend No.";
    "Payment Method Code" := SalesHeader."Payment Method Code";
    //IME19.00 End
    //SM 16 Jan 2017 to pass LC entry type as Document value
    IF "Sys. LC No." <> '' THEN
      "LC Entry Type" := "LC Entry Type"::"Document Value";
    //SM 16 Jan 2017 to pass LC entry type as Document value
    OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader,Rec);
    */
    //end;


    //Unsupported feature: Code Modification on "GetGLAccount(PROCEDURE 146)".

    //procedure GetGLAccount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GLAcc.GET("Account No.");
    CheckGLAcc(GLAcc);
    IF ReplaceDescription AND (NOT GLAcc."Omit Default Descr. in Jnl.") THEN
    #4..27
    IF "Posting Date" <> 0D THEN
      IF "Posting Date" = CLOSINGDATE("Posting Date") THEN
        ClearPostingGroups;
    VALIDATE("Deferral Code",GLAcc."Default Deferral Template Code");

    OnAfterAccountNoOnValidateGetGLAccount(Rec,GLAcc);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..30
      //SRT June 5th 2019 >>
      "Main G/L Account" := "Account No.";
      "Main G/L Account Name" := GLAcc.Name;
      //SRT June 5th 2019 <<
    #31..33
    */
    //end;


    //Unsupported feature: Code Modification on "GetCustomerAccount(PROCEDURE 47)".

    //procedure GetCustomerAccount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Cust.GET("Account No.");
    Cust.CheckBlockedCustOnJnls(Cust,"Document Type",FALSE);
    CheckICPartner(Cust."IC Partner Code","Account Type","Account No.");
    #4..22
        ERROR('');
    VALIDATE("Payment Terms Code");
    CheckPaymentTolerance;

    OnAfterAccountNoOnValidateGetCustomerAccount(Rec,Cust,CurrFieldNo);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..25
    "LC Entry Type" := GetLC_Entry_Type_Customer(Cust); //SM 16 Jan 2017 to get LC Entry Type from G/L Account used in Customer Posting Group
    OnAfterAccountNoOnValidateGetCustomerAccount(Rec,Cust,CurrFieldNo);
    */
    //end;


    //Unsupported feature: Code Modification on "GetVendorAccount(PROCEDURE 115)".

    //procedure GetVendorAccount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Vend.GET("Account No.");
    Vend.CheckBlockedVendOnJnls(Vend,"Document Type",FALSE);
    CheckICPartner(Vend."IC Partner Code","Account Type","Account No.");
    #4..26
        ERROR('');
    VALIDATE("Payment Terms Code");
    CheckPaymentTolerance;

    OnAfterAccountNoOnValidateGetVendorAccount(Rec,Vend,CurrFieldNo);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..29
    "LC Entry Type" := GetLC_Entry_Type_Vendor(Vend); //SM 16 Jan 2017 to get LC Entry Type from G/L Account used in Vendor Posting Group

    OnAfterAccountNoOnValidateGetVendorAccount(Rec,Vend,CurrFieldNo);
    */
    //end;

    local procedure CalculateTDSAmount()
    var
        AmountNegativeOrZero: Label 'Amount is Negative or Zero. Do you want to Reverse Purchase TDS Entries?';
        TDSTypeBlank: Label 'TDS Type of %1 cannot be Blank in TDS Posting Group.';
        AmountPositiveOrZero: Label 'Amount is Positive or Zero. Do you want to Reverse Sale TDS Entries?';
    begin
        //TDS1.00
        //for Purchase TDS
        //MESSAGE('findtdstype-->'+FORMAT(FindTDSType));
        IF "TDS Group" <> '' THEN BEGIN
            IF (FindTDSType = 1) AND (Amount >= 0) THEN
                CalculateTDSAmount2
            ELSE
                IF (FindTDSType = 1) AND (Amount < 0) THEN //amount less than zero in case of manual reverse
                BEGIN
                    IF NOT CONFIRM(AmountNegativeOrZero, FALSE) THEN
                        EXIT;
                    CalculateTDSAmount2;
                END;

            //for blank
            IF (FindTDSType = 0) THEN
                ERROR(TDSTypeBlank, "TDS Group");

            //for Sales TDS
            IF (FindTDSType = 2) AND (Amount <= 0) THEN
                CalculateTDSAmount2
            ELSE
                IF (FindTDSType = 2) AND (Amount > 0) THEN //amount greater than zero in case of manual reverse
                BEGIN
                    IF NOT CONFIRM(AmountPositiveOrZero, FALSE) THEN
                        EXIT;
                    CalculateTDSAmount2;
                END;
        END
        ELSE
            ClearTDSFields;
        //TDS1.00
    end;

    local procedure CalculateTDSAmount2()
    var
        AmountNegativeOrZero: Label 'Amount in Negative or Zero. Do you want to Reverse TDS Entries?';
        TDSSetup2: Record "TDS Posting Group";
    begin
        //TDS1.00
        GetCurrency;

        ClearTDSFields;
        TDSSetup2.RESET;
        TDSSetup2.SETRANGE(Code, "TDS Group");
        IF TDSSetup2.FINDFIRST THEN BEGIN
            "TDS%" := TDSSetup2."TDS%";
            "TDS Type" := TDSSetup2.Type;
            IF TDSSetup2."TDS base excluing VAT" THEN
                "TDS Base Amount" := "VAT Base Amount" / 1.13
            ELSE
                "TDS Base Amount" := "VAT Base Amount";

            "TDS Amount" := ROUND("TDS Base Amount" * "TDS%" / 100, Currency."Amount Rounding Precision", Currency.VATRoundingDirection);
        END;
        //TDS1.00
        //MESSAGE('tds amount-->'+FORMAT("TDS Amount"));
    end;

    local procedure ClearTDSFields()
    begin
        "TDS%" := 0;
        "TDS Type" := "TDS Type"::" ";
        "TDS Amount" := 0;
        "TDS Base Amount" := 0;
    end;

    local procedure FindTDSType(): Integer
    var
        TDSSetup2: Record "TDS Posting Group";
    begin
        TDSSetup2.RESET;
        TDSSetup2.SETRANGE(Code, "TDS Group");
        IF TDSSetup2.FINDFIRST THEN
            EXIT(TDSSetup2.Type);
    end;

    procedure NotAllowTDSAccountSelectInJournalLines()
    var
        TDSPostingGroup: Record "TDS Posting Group";
        UserSetup: Record "User Setup";
    begin
        //TDS1.00 <<
        UserSetup.GET(USERID);
        IF ("Account Type" = "Account Type"::"G/L Account") AND (NOT UserSetup."Allow TDS A/C Direct Posting") THEN BEGIN
            TDSPostingGroup.RESET;
            TDSPostingGroup.SETRANGE("GL Account No.", "Account No.");
            IF TDSPostingGroup.FINDFIRST THEN
                ERROR('You cannot select TDS Account No. %1 in journal lines', "Account No.");
        END;
        //TDS1.00 <<
    end;

    local procedure GetLC_Entry_Type_Vendor(VendorRec: Record Vendor): Integer
    var
        VendorPostingGroup: Record "Vendor Posting Group";
        GL_Acc: Record "G/L Account";
    begin
        VendorPostingGroup.GET(VendorRec."Vendor Posting Group");
        GL_Acc.GET(VendorPostingGroup."Payables Account");
        EXIT(GL_Acc."LC Entry Type");
    end;

    local procedure GetLC_Entry_Type_Customer(CustomerRec: Record Customer): Integer
    var
        CustPostingGroup: Record "Customer Posting Group";
        GL_Acc: Record "G/L Account";
    begin
        CustPostingGroup.GET(CustomerRec."Customer Posting Group");
        GL_Acc.GET(CustPostingGroup."Receivables Account");
        EXIT(GL_Acc."LC Entry Type");
    end;

    var
        IRDMgt: Codeunit "IRD Mgt.";
        EnglishNepaliDate: Record "English-Nepali Date";
}

