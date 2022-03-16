table 50008 "LC Details"
{
    DrillDownPageID = "LC/BG/DO Details";
    LookupPageID = "LC/BG/DO Details";

    fields
    {
        field(1; "No."; Code[20])
        {
            Description = 'Automatic generated No.';

            trigger OnValidate()
            var
                GenSetup: Record "General Ledger Setup";
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    GenSetup.GET;

                    // IF "Document Type" = "Document Type"::"Letter of Credit" THEN
                    //     NoSeriesMngt.TestManual(GenSetup."LC Details Nos.")
                    // ELSE
                    //     IF "Document Type" = "Document Type"::"Bank Guarantee" THEN
                    //         NoSeriesMngt.TestManual(GenSetup."BG Detail Nos.")
                    //     ELSE
                    //         IF "Document Type" = "Document Type"::DAA THEN
                    //             NoSeriesMngt.TestManual(GenSetup."DAA Detail Nos.")
                    //         ELSE
                    //             IF "Document Type" = "Document Type"::DAP THEN
                    //                 NoSeriesMngt.TestManual(GenSetup."DAP Detail Nos.")
                    //             ELSE
                    //                 IF "Document Type" = "Document Type"::"Delivery Order" THEN
                    //                     NoSeriesMngt.TestManual(GenSetup."DO Detail Nos.");


                    // "No. Series" := '';
                END;
            end;
        }
        field(2; "LC\DO No."; Code[20])
        {
            Description = 'LC No. from bank.';
        }
        field(3; Description; Text[50])
        {
        }
        field(4; "Transaction Type"; Option)
        {
            Description = 'LC purpose - sales LC or Purchase LC.';
            OptionCaption = 'Purchase,Sale';
            OptionMembers = Purchase,Sale;
        }
        field(5; "Issued To/Received From"; Code[20])
        {
            Description = 'Link to Customer/Vendor - if Sale then customer else vendor.';
            TableRelation = IF ("Transaction Type" = CONST(Sale)) Customer."No."
            ELSE
            IF ("Transaction Type" = CONST(Purchase)) Vendor."No.";

            trigger OnValidate()
            var
                GblVendor: Record "Vendor";
            begin
                IF ("Transaction Type" = "Transaction Type"::Purchase) THEN BEGIN
                    GblVendor.RESET;
                    GblVendor.SETRANGE("No.", "Issued To/Received From");
                    IF GblVendor.FIND('-') THEN BEGIN
                        // "Issued To/Received From Name" := GblVendor.Name;//change
                        // VALIDATE("Currency Code", GblVendor."Currency Code");
                        // MODIFY;
                    END;
                END ELSE
                    IF ("Transaction Type" = "Transaction Type"::Sale) THEN BEGIN
                        // GblCustomer.RESET;//change
                        // GblCustomer.SETRANGE("No.", "Issued To/Received From");
                        // IF GblCustomer.FIND('-') THEN BEGIN
                        //     // "Issued To/Received From Name" := GblCustomer.Name;
                        //     // VALIDATE("Currency Code", GblCustomer."Currency Code");
                        //     MODIFY;
                        // END;
                    END;
            end;
        }
        field(6; "Issuing Bank"; Code[20])
        {
            Description = 'LC Issuing bank no., Linked to Customer/Vendor Bank account, condition applied, see table relation for details.';
            TableRelation = IF ("Transaction Type" = CONST(Sale)) "Customer Bank Account".Code WHERE("Customer No." = FIELD("Issued To/Received From"))
            ELSE
            IF ("Transaction Type" = CONST(Purchase)) "Bank Account"."No.";

            trigger OnValidate()
            var
                GblBankAcc: Record "Bank Account";
                GblCustBankAcc: Record "Customer Bank Account";
            begin
                IF ("Transaction Type" = "Transaction Type"::Purchase) THEN BEGIN
                    GblBankAcc.RESET;
                    GblBankAcc.SETRANGE("No.", "Issuing Bank");
                    IF GblBankAcc.FIND('-') THEN BEGIN
                        // "Issue Bank Name1" := GblBankAcc.Name;//changes
                        MODIFY;
                    END;
                END ELSE
                    IF ("Transaction Type" = "Transaction Type"::Sale) THEN BEGIN
                        GblCustBankAcc.RESET;
                        GblCustBankAcc.SETRANGE("Customer No.", "Issued To/Received From");
                        GblCustBankAcc.SETRANGE(Code, "Issuing Bank");
                        IF GblCustBankAcc.FIND('-') THEN BEGIN
                            //"Issue Bank Name1" := GblCustBankAcc.Name;//change
                            // "Issue Bank Name2" := GblCustBankAcc."Name 2";
                            MODIFY;
                        END;
                    END;
            end;
        }
        field(7; "Date of Issue"; Date)
        {
        }
        field(8; "Receiving Bank"; Code[20])
        {
            Caption = 'Negotiating Bank';
            Description = 'link to Customer or Vendor bank.';
            TableRelation = IF ("Transaction Type" = CONST(Purchase)) "Vendor Bank Account".Code WHERE("Vendor No." = FIELD("Issued To/Received From"))
            ELSE
            IF ("Transaction Type" = CONST(Sale)) "Bank Account"."No." WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                GblVenBankAcc: Record "Vendor Bank Account";
            begin
                IF ("Transaction Type" = "Transaction Type"::Purchase) THEN BEGIN
                    GblVenBankAcc.RESET;
                    GblVenBankAcc.SETRANGE(Code, "Receiving Bank");
                    IF GblVenBankAcc.FIND('-') THEN BEGIN
                        // "Receiving Bank Name" := GblVenBankAcc.Name;//change
                        MODIFY;
                    END;
                END ELSE
                    IF ("Transaction Type" = "Transaction Type"::Sale) THEN BEGIN
                        GblBankAcc.RESET;
                        GblBankAcc.SETRANGE("No.", "Receiving Bank");
                        IF GblBankAcc.FIND('-') THEN BEGIN
                            "Receiving Bank Name" := GblBankAcc.Name;
                            MODIFY;
                        END;
                    END;
            end;
        }
        field(9; "Expiry Date"; Date)
        {
            Description = 'LC expiry date';
        }
        field(10; "Type of LC"; Option)
        {
            OptionCaption = 'Foreign,Inland';
            OptionMembers = Foreign,Inland;
        }
        field(11; "Type of Credit Limit"; Option)
        {
            OptionCaption = 'Fixed,Revolving';
            OptionMembers = "Fixed",Revolving;
        }
        field(12; "Currency Code"; Code[10])
        {
            Description = 'For multiple currency transaction. Link to currency table.';
            TableRelation = IF ("Type of LC" = CONST(Foreign)) Currency.Code;

            trigger OnValidate()
            begin
                IF "Currency Code" <> '' THEN BEGIN
                    CurrExchRate.SETRANGE("Currency Code", "Currency Code");
                    CurrExchRate.SETRANGE("Starting Date", 0D, "Date of Issue");
                    CurrExchRate.FIND('+');
                    VALIDATE("Exchange Rate", CurrExchRate."Relational Exch. Rate Amount" / CurrExchRate."Exchange Rate Amount");
                END;
            end;
        }
        field(13; "Exchange Rate"; Decimal)
        {
            DecimalPlaces = 0 : 4;

            trigger OnValidate()
            begin
                VALIDATE("LC Value");
            end;
        }
        field(14; "LC Value"; Decimal)
        {

            trigger OnValidate()
            var
                TotalAmount: Decimal;
                Currency: Record Currency;
            begin
                IF "Currency Code" <> '' THEN BEGIN
                    Currency.GET("Currency Code");
                    "LC Value (LCY)" := ROUND("LC Value" * "Exchange Rate", Currency."Amount Rounding Precision");
                END ELSE
                    "LC Value (LCY)" := "LC Value";
            end;
        }
        field(15; "LC Value (LCY)"; Decimal)
        {
            Editable = false;
        }
        field(16; "Purchase LC Utilized Value"; Decimal)
        {
            Caption = 'Purchase Utilized Value';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Value Entry"."Purchase Amount (Actual)" WHERE("Sys. LC No." = FIELD("No."),
                                                                              "Item Charge No." = FILTER(''),
                                                                             "Item Ledger Entry Type" = FIELD("Transaction Type")));

        }
        field(17; "Sales LC Utilized Value"; Decimal)
        {
            Caption = 'Sales LC Utilized Value';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry".Amount WHERE("LC Entry Type" = CONST("Document Value"),
                                                        "Sys. LC No." = FIELD("No."),
                                                       "Gen. Posting Type" = CONST(Sale)));

        }
        field(18; "Revolving Cr. Limit Type"; Option)
        {
            OptionCaption = ' ,Automatic,Manual';
            OptionMembers = " ",Automatic,Manual;
        }
        field(19; "Latest Amended Value"; Decimal)
        {
            Description = 'Link to Amendment details, link with Version No. and No.';
            Editable = false;
        }
        field(20; "Renewed Value"; Decimal)
        {
            Editable = false;
        }
        field(21; Closed; Boolean)
        {
            Editable = false;
        }
        field(22; Released; Boolean)
        {
            Editable = false;
        }
        field(23; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(24; "Vehicle Category"; Code[20])
        {
            Description = 'Link to Dimension';
        }
        field(25; Remarks; Text[250])
        {
        }
        field(26; "Has Amendment"; Boolean)
        {
        }
        field(27; "Tolerance Percentage"; Decimal)
        {
        }
        field(28; "Last Used Amendment No."; Code[20])
        {
        }
        field(29; "Issued To/Received From Name"; Text[50])
        {
        }
        field(30; "Issue Bank Name1"; Text[50])
        {
        }
        field(31; "Receiving Bank Name"; Text[50])
        {
        }
        field(32; "Vehicle Division"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(33; "Shipment Date"; Date)
        {
        }
        field(34; "BG Type"; Option)
        {
            OptionCaption = ' ,Bid Bond,Performance Bond';
            OptionMembers = " ","Bid Bond","Performance Bond";
        }
        field(35; Units; Integer)
        {
        }
        field(38; "Allotment Type"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = 'Insurance,Letter of Credit';
            OptionMembers = Insurance,"Letter of Credit";
        }
        field(39; Location; Code[10])
        {
            TableRelation = Location;
        }
        field(40; "Insured By"; Code[20])
        {
            TableRelation = Vendor;
        }
        field(41; Incoterms; Option)
        {
            OptionCaption = ' ,C&F,CIF,CIP,FOB,CFR,C&I,CNI,EXW,FCA,DAP,DDP,DAU';
            OptionMembers = " ","C&F",CIF,CIP,FOB,CFR,"C&I",CNI,EXW,FCA,DAP,DDP,DAU;
        }
        field(42; Notes; Text[250])
        {
        }
        field(45; "Issue Bank Name2"; Text[50])
        {
            Description = '**SM 08/08/2013 to bring name2 of lc issuing bank';
        }
        field(46; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(100; "LC Open Name"; Text[50])
        {
        }
        field(50000; "Document Type"; Option)
        {
            OptionCaption = '  ,Letter of Credit,Bank Guarantee,Delivery Order,DAP,DAA';
            OptionMembers = "  ","Letter of Credit","Bank Guarantee","Delivery Order",DAP,DAA;
        }
        field(50001; "Responsible F & R Person"; Code[20])
        {
            TableRelation = Employee."No.";
        }
        field(50002; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(80000; Margin; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry".Amount WHERE("LC Entry Type" = CONST(Margin),
                                                        "Sys. LC No." = FIELD("No."),
                                                       "Posting Date" = FIELD("Date Filter")));

        }
        field(80001; Charge; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry".Amount WHERE("LC Entry Type" = CONST(Charge),
                                                       "Sys. LC No." = FIELD("No."),
                                                        "Posting Date" = FIELD("Date Filter")));

        }
        field(80002; "Document Value"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry".Amount WHERE("LC Entry Type" = CONST("Document Value"),
                                                        "Sys. LC No." = FIELD("No."),
                                                       "Posting Date" = FIELD("Date Filter")));

        }
        field(80003; "TR Loan"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry".Amount WHERE("LC Entry Type" = CONST("TR Loan"),
                                                        "Sys. LC No." = FIELD("No."),
                                                       "Posting Date" = FIELD("Date Filter")));

        }
        field(80004; "LC Type"; Option)
        {
            Description = 'Added for Toyota';
            OptionCaption = ' ,Sight LC,Usuance LC,Mixed Payment';
            OptionMembers = " ","Sight LC","Usuance LC","Mixed Payment";
        }
        field(80005; "Utilized Unit"; Decimal)
        {
            Description = 'Added for Toyota';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Value Entry"."Invoiced Quantity" WHERE("Document Type" = CONST("Purchase Invoice"),
                                                                      "Sys. LC No." = FIELD("No.")));

        }
        field(80006; Commission; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry".Amount WHERE("LC Entry Type" = CONST(Commission),
                                                       "Sys. LC No." = FIELD("No.")));

        }
        field(80007; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account" WHERE(Type = CONST(Loan));
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "LC\DO No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "LC\DO No.", Description)
        {
        }
    }

    trigger OnDelete()
    begin
        IF Closed OR Released THEN
            ERROR(Text33020016);
    end;

    trigger OnInsert()
    begin
        TESTFIELD("Document Type");
        IF "No." = '' THEN BEGIN
            GenSetup.GET;
            IF "Document Type" = "Document Type"::"Letter of Credit" THEN BEGIN
                GenSetup.TESTFIELD("LC Details Nos.");
                NoSeriesMngt.InitSeries(GenSetup."LC Details Nos.", xRec."No. Series", 0D, "No.", "No. Series");
            END ELSE
                IF "Document Type" = "Document Type"::"Bank Guarantee" THEN BEGIN
                    GenSetup.TESTFIELD("BG Detail Nos.");
                    NoSeriesMngt.InitSeries(GenSetup."BG Detail Nos.", xRec."No. Series", 0D, "No.", "No. Series");
                END ELSE
                    IF "Document Type" = "Document Type"::DAA THEN BEGIN
                        GenSetup.TESTFIELD("DAA Detail Nos.");
                        NoSeriesMngt.InitSeries(GenSetup."DAA Detail Nos.", xRec."No. Series", 0D, "No.", "No. Series");
                    END ELSE
                        IF "Document Type" = "Document Type"::DAP THEN BEGIN
                            GenSetup.TESTFIELD("DAP Detail Nos.");
                            NoSeriesMngt.InitSeries(GenSetup."DAP Detail Nos.", xRec."No. Series", 0D, "No.", "No. Series");
                        END ELSE
                            IF "Document Type" = "Document Type"::"Delivery Order" THEN BEGIN
                                GenSetup.TESTFIELD("DO Detail Nos.");
                                NoSeriesMngt.InitSeries(GenSetup."DO Detail Nos.", xRec."No. Series", 0D, "No.", "No. Series");
                            END;
        END;

        "Date of Issue" := WORKDATE;
        "Created By" := USERID;
    end;

    trigger OnModify()
    begin
        IF Closed THEN
            ERROR(Text33020015);
    end;




    procedure AssistEdit(): Boolean
    begin
        WITH LcDetails DO BEGIN
            LcDetails := Rec;
            GenSetup.GET;
            IF "Document Type" = "Document Type"::"Letter of Credit" THEN BEGIN
                GenSetup.TESTFIELD("LC Details Nos.");
                IF NoSeriesMngt.SelectSeries(GenSetup."LC Details Nos.", xRec."No. Series", "No. Series") THEN BEGIN
                    NoSeriesMngt.SetSeries("No.");
                    Rec := LcDetails;
                    EXIT(TRUE);
                END;
            END ELSE
                IF "Document Type" = "Document Type"::"Delivery Order" THEN BEGIN
                    GenSetup.TESTFIELD("DO Detail Nos.");
                    IF NoSeriesMngt.SelectSeries(GenSetup."DO Detail Nos.", xRec."No. Series", "No. Series") THEN BEGIN
                        NoSeriesMngt.SetSeries("No.");
                        Rec := LcDetails;
                        EXIT(TRUE);
                    END;
                END ELSE
                    IF "Document Type" = "Document Type"::"Bank Guarantee" THEN BEGIN
                        GenSetup.TESTFIELD("BG Detail Nos.");
                        IF NoSeriesMngt.SelectSeries(GenSetup."BG Detail Nos.", xRec."No. Series", "No. Series") THEN BEGIN
                            NoSeriesMngt.SetSeries("No.");
                            Rec := LcDetails;
                            EXIT(TRUE);
                        END;
                    END ELSE
                        IF "Document Type" = "Document Type"::DAA THEN BEGIN
                            GenSetup.TESTFIELD("DAA Detail Nos.");
                            IF NoSeriesMngt.SelectSeries(GenSetup."DAA Detail Nos.", xRec."No. Series", "No. Series") THEN BEGIN
                                NoSeriesMngt.SetSeries("No.");
                                Rec := LcDetails;
                                EXIT(TRUE);
                            END;
                        END ELSE
                            IF "Document Type" = "Document Type"::DAP THEN BEGIN
                                GenSetup.TESTFIELD("DAP Detail Nos.");
                                IF NoSeriesMngt.SelectSeries(GenSetup."DAP Detail Nos.", xRec."No. Series", "No. Series") THEN BEGIN
                                    NoSeriesMngt.SetSeries("No.");
                                    Rec := LcDetails;
                                    EXIT(TRUE);
                                END;
                            END;
        END;
    end;


    procedure ReleaseLC(ParmLCDetail: Record "LC Details")
    begin
        WITH ParmLCDetail DO BEGIN
            IF CONFIRM(Text33020011) THEN
                IF NOT Released THEN BEGIN
                    Released := TRUE;
                    MODIFY;
                    MESSAGE(Text33020012);
                END ELSE
                    MESSAGE(Text33020012)
            ELSE
                EXIT;
        END;
    end;


    procedure AmendLC(ParmLCDetail: Record "LC Details")
    var
        GlobalLCAmmendments: Page "LC Amend Details";
    begin
        WITH ParmLCDetail DO BEGIN
            IF Released THEN BEGIN
                CLEAR(GlobalLCAmmendments);
                IF Closed THEN
                    ERROR(Text33020017, "LC\DO No.");
                IF CONFIRM(Text33020014) THEN BEGIN
                    GlobalLCADetails.SETRANGE("No.", "No.");
                    IF NOT GlobalLCADetails.FIND('-') THEN BEGIN    //If amendment is not found for this LC.
                        GlobalLCADetails1.INIT;
                        GlobalLCADetails1."Version No." := getLCAVersionNo(ParmLCDetail."No.");
                        GlobalLCADetails1."No." := "No.";
                        //GlobalLCADetails1.INSERT(TRUE);
                        GlobalLCADetails1."LC No." := "LC\DO No.";
                        GlobalLCADetails1.Description := Description;
                        GlobalLCADetails1."Transaction Type" := "Transaction Type";
                        GlobalLCADetails1."Issued To/Received From" := "Issued To/Received From";
                        GlobalLCADetails1."Issuing Bank" := "Issuing Bank";
                        GlobalLCADetails1."Date of Issue" := "Date of Issue";
                        GlobalLCADetails1."Type of LC" := "Type of LC";
                        GlobalLCADetails1."Type of Credit Limit" := "Type of Credit Limit";
                        GlobalLCADetails1."Revolving Cr. Limit Type" := "Revolving Cr. Limit Type";
                        GlobalLCADetails1."Currency Code" := "Currency Code";
                        GlobalLCADetails1."Previous LC Value" := "LC Value";
                        GlobalLCADetails1."Exchange Rate" := "Exchange Rate";
                        GlobalLCADetails1."Receiving Bank" := "Receiving Bank";
                        GlobalLCADetails1."Amended Date" := TODAY;
                        GlobalLCADetails1."Vehicle Category" := "Vehicle Category";
                        GlobalLCADetails1."Vehicle Division" := "Vehicle Division";
                        GlobalLCADetails1."Tolerance Percentage" := "Tolerance Percentage";
                        GlobalLCADetails1."Issued To/Received From Name" := "Issued To/Received From Name";
                        GlobalLCADetails1."Issue Bank Name1" := "Issue Bank Name1";
                        GlobalLCADetails1."Issue Bank Name2" := "Issue Bank Name2"; //**SM 08/08/2013 to bring name2 of lc issuing bank
                        GlobalLCADetails1."Receiving Bank Name" := "Receiving Bank Name";
                        GlobalLCADetails1.INSERT(TRUE);
                        //GlobalLCADetails1.MODIFY;
                        updateLastLCAmdNo(ParmLCDetail."No.", GlobalLCADetails1."Version No.");
                        COMMIT;
                    END ELSE BEGIN              //If amendment is found for this LC.
                        GlobalLCADetails.FIND('+');
                        IF NOT GlobalLCADetails.Released THEN
                            ERROR(Text33020026);
                        GlobalLCADetails1.INIT;
                        GlobalLCADetails1."Version No." := getLCAVersionNo(ParmLCDetail."No.");
                        GlobalLCADetails1."No." := "No.";
                        //GlobalLCADetails1.INSERT(TRUE);
                        GlobalLCADetails1."LC No." := GlobalLCADetails."LC No.";
                        GlobalLCADetails1.Description := GlobalLCADetails.Description;
                        GlobalLCADetails1."Transaction Type" := GlobalLCADetails."Transaction Type";
                        GlobalLCADetails1."Issued To/Received From" := GlobalLCADetails."Issued To/Received From";
                        GlobalLCADetails1."Issuing Bank" := GlobalLCADetails."Issuing Bank";
                        GlobalLCADetails1."Date of Issue" := GlobalLCADetails."Date of Issue";
                        GlobalLCADetails1."Type of Credit Limit" := GlobalLCADetails."Type of Credit Limit";
                        GlobalLCADetails1."Type of LC" := GlobalLCADetails."Type of LC";
                        GlobalLCADetails1."Currency Code" := GlobalLCADetails."Currency Code";
                        GlobalLCADetails1."Previous LC Value" := GlobalLCADetails."LC Value";
                        GlobalLCADetails1."Exchange Rate" := GlobalLCADetails."Exchange Rate";
                        GlobalLCADetails1."Receiving Bank" := GlobalLCADetails."Receiving Bank";
                        GlobalLCADetails1."Tolerance Percentage" := GlobalLCADetails."Tolerance Percentage";
                        GlobalLCADetails1."Issued To/Received From Name" := ParmLCDetail."Issued To/Received From Name";
                        GlobalLCADetails1."Issue Bank Name1" := ParmLCDetail."Issue Bank Name1";
                        GlobalLCADetails1."Receiving Bank Name" := ParmLCDetail."Receiving Bank Name";
                        GlobalLCADetails1."Vehicle Division" := ParmLCDetail."Vehicle Division";
                        GlobalLCADetails1."Vehicle Category" := "Vehicle Category";
                        GlobalLCADetails1."Amended Date" := TODAY;
                        GlobalLCADetails1.INSERT(TRUE);
                        //GlobalLCADetails1.MODIFY;
                        updateLastLCAmdNo(ParmLCDetail."No.", GlobalLCADetails1."Version No.");
                        COMMIT;
                    END;
                    GlobalLCAmmendments.SETTABLEVIEW(GlobalLCADetails1);
                    GlobalLCAmmendments.SETRECORD(GlobalLCADetails1);
                    GlobalLCAmmendments.LOOKUPMODE(TRUE);
                    IF GlobalLCAmmendments.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        GlobalLCAmmendments.GETRECORD(GlobalLCADetails1);
                        CLEAR(GlobalLCAmmendments);
                    END;
                END ELSE
                    EXIT;
            END ELSE
                MESSAGE(Text33020027);
        END;
    end;


    procedure CloseLC(ParmLCDetail: Record "LC Details")
    begin
        //Code to Close LC Details.
        WITH ParmLCDetail DO BEGIN
            IF CONFIRM(Text33020020) THEN
                IF NOT Closed THEN BEGIN
                    TESTFIELD(Released);
                    Closed := TRUE;
                    MODIFY;
                    GlobalLCADetails.RESET;
                    GlobalLCADetails.SETRANGE("No.", ParmLCDetail."No.");
                    IF GlobalLCADetails.FIND('-') THEN
                        REPEAT
                            GlobalLCADetails.Closed := TRUE;
                            GlobalLCADetails.MODIFY;
                        UNTIL GlobalLCADetails.NEXT = 0;
                    MESSAGE(Text33020018);
                END ELSE
                    MESSAGE(Text33020019)
            ELSE
                EXIT;
        END;
    end;


    procedure ReopenLC(ParmLCDetail: Record "LC Details")
    begin
        //Code to Reopen LC Details.
        WITH ParmLCDetail DO BEGIN
            IF CONFIRM(Text33020025) THEN
                IF Closed THEN BEGIN
                    Closed := FALSE;
                    MODIFY;
                    GlobalLCADetails.RESET;
                    GlobalLCADetails.SETRANGE("No.", ParmLCDetail."No.");
                    IF GlobalLCADetails.FIND('-') THEN
                        REPEAT
                            GlobalLCADetails.Closed := FALSE;
                            GlobalLCADetails.MODIFY;
                        UNTIL GlobalLCADetails.NEXT = 0;
                    MESSAGE('The LC has been reopened.');
                END ELSE
                    MESSAGE('This LC is already open.')
            ELSE
                EXIT;
        END;
    end;


    procedure getLCAVersionNo(PrmLCNo: Code[20]): Code[10]
    var
        LclLCDetail: Record "LC Details";
    begin
        //Returning LC Amend No.
        LclLCDetail.RESET;
        LclLCDetail.SETRANGE("No.", PrmLCNo);
        IF LclLCDetail.FIND('-') THEN BEGIN
            IF (LclLCDetail."Last Used Amendment No." <> '') THEN
                GblLCANo := INCSTR(LclLCDetail."Last Used Amendment No.")
            ELSE
                GblLCANo := '00001';
        END;

        EXIT(GblLCANo);
    end;


    procedure updateLastLCAmdNo(PrmLCNo: Code[20]; PrmNewLCAmdNo: Code[20]): Code[10]
    var
        LclLCDetail: Record "LC Details";
    begin
        //Updating LC Details - Last Amendment No.
        LclLCDetail.RESET;
        LclLCDetail.SETRANGE("No.", PrmLCNo);
        IF LclLCDetail.FIND('-') THEN BEGIN
            LclLCDetail."Last Used Amendment No." := PrmNewLCAmdNo;
            LclLCDetail.MODIFY;
        END;
    end;


    procedure CreateVendor()
    var
        Vendor: Record Vendor;
        ConfigTemplateHdr: Record "Config. Template Header";
        ConfigTemplateLine: Record "Config. Template Line";
        PurchaseAndPayable: Record "Purchases & Payables Setup";
        //ConfigTempateMgt: Codeunit "Config. Template Management";
        RecRef: RecordRef;
        VendorAlreadyExist: Label 'Vendor No. %1 has already been created for LC No. %2.';
    begin
        IF NOT CONFIRM('Do you want to create new vendor?') THEN
            ERROR('Aborted by user!');
        TESTFIELD("Transaction Type", "Transaction Type"::Purchase);
        TESTFIELD(Closed, FALSE);
        TESTFIELD(Released, TRUE);
        //****Commented at UTS
        //TESTFIELD(Released,TRUE);

        //PurchaseAndPayable.GET;
        //PurchaseAndPayable.TESTFIELD("Vendor Template Code");

        //ConfigTemplateHdr.RESET;
        //ConfigTemplateHdr.SETRANGE(Code,PurchaseAndPayable."Vendor Template Code");
        //ConfigTemplateHdr.FINDFIRST;

        //ConfigTemplateLine.RESET;
        //ConfigTemplateLine.SETRANGE("Data Template Code",ConfigTemplateHdr.Code);
        //IF ConfigTemplateLine.FINDFIRST THEN BEGIN
        //****Commented at UTS
        Vendor.RESET;
        Vendor.SETRANGE("LC No.", "No.");
        IF NOT Vendor.FINDSET THEN BEGIN
            Vendor.INIT;
            Vendor.Name := "LC\DO No.";
            Vendor."LC No." := "No.";
            Vendor.INSERT(TRUE);
            COMMIT;
            RecRef.GETTABLE(Vendor);
            ConfigTempateMgt.UpdateFromTemplateSelection(RecRef);
            //ConfigTemplateHdr.SETRANGE("Table ID",RecRef.NUMBER);
            //IF ConfigTemplateHdr.FINDFIRST THEN
        END ELSE
            ERROR(VendorAlreadyExist, Vendor."No.", "LC\DO No.");
        //END; //****Commented at UTS

        MESSAGE('Vendor %1 created!', Vendor."No.");
        //  PAGE.RUN(PAGE::"Vendor Card", Vendor);//change
    end;

    var
        GlobalLCADetails: Record "LC Amend Detail";
        GlobalLCADetails1: Record "LC Amend Detail";
        GblLCANo: Code[20];
        GenSetup: Record "General Ledger Setup";
        NoSeriesMngt: Codeunit NoSeriesManagement;
        GblBankAcc: Record "Bank Account";
        ConfigTempateMgt: Codeunit "Config. Template Management";

        PurchaseHeaderRec: Record "Purchase Header";
        PurchaseLineRec: Record "Purchase Line";
        // NoSeriesMngt: Codeunit NoSeriesManagement ;
        GblCustomer: Record "Customer";
        CurrExchRate: Record "Currency Exchange Rate";
        LcDetails: Record "LC Details";

        Text33020015: Label 'You cannot modify Closed LC.';
        Text33020016: Label 'You cannot delete closed or released LC.';
        Text33020011: Label 'Do you want to Release?';
        Text33020012: Label 'The LC has been Released.';
        Text33020013: Label 'The LC is already Released.';
        Text33020014: Label 'Do you want to Amend this Document ?';
        Text33020026: Label 'Without releasing the previous amendment you cannot Amend again.';
        Text33020027: Label 'You cannot Amended without releasing the document.';
        Text33020017: Label 'Cannot Amend LC %1. Status is closed.';
        Text33020018: Label 'The LC has been closed.';
        Text33020019: Label 'The LC is already closed.';
        Text33020020: Label 'Do you want to close LC ?';
        Text33020021: Label 'The LC Amendment has been Released.';
        Text33020022: Label 'The LC Amendment is already Released.';
        Text33020023: Label 'Do you want to Release Amendment?';
        Text33020024: Label 'Do you want to close LC Amendment ?';
        Text33020025: Label 'Do you want to reopen LC ?';


}


