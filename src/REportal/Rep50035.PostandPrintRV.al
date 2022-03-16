report 50035 "Post and Print RV"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PostandPrintRV.rdlc';
    Caption = 'Post and Print RV';

    dataset
    {
        dataitem("G/L Entry"; Table17)
        {
            DataItemTableView = SORTING (Entry No.);
            RequestFilterFields = "Document No.", "Posting Date";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyInfo.Name)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfoPicture2; CompanyInfo."Picture 2")
            {
            }
            column(CompanyInfoPicture3; CompanyInfo."Picture 3")
            {
            }
            column(Info1; Info1)
            {
            }
            column(Info2; Info2)
            {
            }
            column(CompanyVAT; CompanyInfo."VAT Registration No.")
            {
            }
            column(EmpName; EmpName)
            {
            }
            column(BranchName; Dim1ValueName)
            {
            }
            column(CostRevName; Dim2ValueName)
            {
            }
            column(DocumentNo; DocumentNo)
            {
            }
            column(PostingDate; PostingDate)
            {
            }
            column(NepaliDate; NepaliDate)
            {
            }
            column(SourceDesc____Voucher_; SourceDesc)
            {
            }
            column(G_L_Entry__Amount; "G/L Entry".Amount)
            {
            }
            column(G_L_RegisterCaption; G_L_RegisterCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(G_L_Entry__Posting_Date_Caption; G_L_Entry__Posting_Date_CaptionLbl)
            {
            }
            column(G_L_Entry__Document_Type_Caption; G_L_Entry__Document_Type_CaptionLbl)
            {
            }
            column(G_L_Entry__Document_No__Caption; "G/L Entry".FIELDCAPTION("Document No."))
            {
            }
            column(G_L_Entry__G_L_Account_No__Caption; "G/L Entry".FIELDCAPTION("G/L Account No."))
            {
            }
            column(GLAcc_NameCaption; GLAcc_NameCaptionLbl)
            {
            }
            column(G_L_Entry_DescriptionCaption; "G/L Entry".FIELDCAPTION(Description))
            {
            }
            column(G_L_Entry__VAT_Amount_Caption; "G/L Entry".FIELDCAPTION("VAT Amount"))
            {
            }
            column(G_L_Entry__Gen__Posting_Type_Caption; G_L_Entry__Gen__Posting_Type_CaptionLbl)
            {
            }
            column(G_L_Entry__Gen__Bus__Posting_Group_Caption; G_L_Entry__Gen__Bus__Posting_Group_CaptionLbl)
            {
            }
            column(G_L_Entry__Gen__Prod__Posting_Group_Caption; G_L_Entry__Gen__Prod__Posting_Group_CaptionLbl)
            {
            }
            column(G_L_Entry_AmountCaption; "G/L Entry".FIELDCAPTION(Amount))
            {
            }
            column(G_L_Entry__Entry_No__Caption; "G/L Entry".FIELDCAPTION("Entry No."))
            {
            }
            column(G_L_Register__No__Caption; G_L_Register__No__CaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(CrText; CrText)
            {
            }
            column(GLAccName; GLAccName)
            {
            }
            column(DrText; DrText)
            {
            }
            column(G_L_Entry__Debit_Amount_; "Debit Amount")
            {
            }
            column(G_L_Entry__Credit_Amount_; "Credit Amount")
            {
            }
            column(DebitAmountTotal; DebitAmountTotal)
            {
            }
            column(CreditAmountTotal; CreditAmountTotal)
            {
            }
            column(Description1; Description1)
            {
            }
            column(Cheque_No______ChequeNo______Dated______FORMAT_ChequeDate_; GLEntry."External Document No.")
            {
            }
            column(LCNo__; "LCNo.")
            {
            }
            column(Bank_LCNo__; "Bank LCNo.")
            {
            }
            column(G_L_Entry__G_L_Entry___Transaction_No__; "G/L Entry"."Transaction No.")
            {
            }
            column(ChequeDate; ChequeDate)
            {
            }
            column(Narration1; Narration1)
            {
            }
            column(G_L_Entry__Posting_Date_; FORMAT("Posting Date"))
            {
            }
            column(G_L_Entry__Document_Type_; "Document Type")
            {
            }
            column(G_L_Entry__Document_No__; "Document No.")
            {
            }
            column(G_L_Entry__G_L_Account_No__; "G/L Account No.")
            {
            }
            column(GLAcc_Name; GLAcc.Name)
            {
            }
            column(G_L_Entry_Description; Description)
            {
            }
            column(G_L_Entry__VAT_Amount_; "VAT Amount")
            {
            }
            column(G_L_Entry__Gen__Posting_Type_; "Gen. Posting Type")
            {
            }
            column(G_L_Entry__Gen__Bus__Posting_Group_; "Gen. Bus. Posting Group")
            {
            }
            column(G_L_Entry__Gen__Prod__Posting_Group_; "Gen. Prod. Posting Group")
            {
            }
            column(G_L_Entry_Amount; Amount)
            {
            }
            column(G_L_Entry__Entry_No__; "Entry No.")
            {
            }
            column(CustomerAddress; CustomerAddress)
            {
            }
            column(CustomerNumber; CustomerNumber)
            {
            }
            column(CreditAmount; CreditAmount)
            {
            }
            column(CustomerVAT; CustomerVAT)
            {
            }
            column(Narration; Narration)
            {
            }
            column(ChequeNo; ChequeNo)
            {
            }
            column(CustomerName; CustomerName)
            {
            }
            column(GLEntry__Source_Type_; GLEntry."Source Type")
            {
            }
            column(TextVar_1______TextVar_2_; TextVar[1] + ' ' + TextVar[2])
            {
                AutoFormatType = 1;
            }
            column(TextVar1_1______TextVar1_2_; TextVar1[1] + ' ' + TextVar1[2])
            {
                AutoFormatType = 1;
            }
            column(G_L_Entry_Amount_Control41; Amount)
            {
            }
            column(Narration_Caption; Narration_CaptionLbl)
            {
            }
            column(G_L_Entry_Amount_Control41Caption; G_L_Entry_Amount_Control41CaptionLbl)
            {
            }
            column(Dim1Name; Dim1Name)
            {
            }
            column(Dim2Name; Dim2Name)
            {
            }
            column(ShowDimension; ShowDimension)
            {
            }
            column(DimensionText1; DimensionText[1])
            {
            }
            column(DimensionText2; DimensionText[2])
            {
            }
            column(DimensionText3; DimensionText[3])
            {
            }
            column(DimensionText4; DimensionText[4])
            {
            }
            column(DimensionText5; DimensionText[5])
            {
            }
            column(DimensionText6; DimensionText[6])
            {
            }
            column(DimensionText7; DimensionText[7])
            {
            }
            column(DimensionText8; DimensionText[8])
            {
            }
            column(ShowReceivedBy; ShowReceivedBy)
            {
            }
            column(BankName; BankName)
            {
            }
            column(CashReceiptType_GLEntry; BankName)
            {
            }

            trigger OnAfterGetRecord()
            var
                ClosingDate: Date;
            begin
                IF SourceCodeSetup."Inventory Post Cost" = "Source Code" THEN
                    CurrReport.SKIP;
                IF Amount = 0 THEN
                    CurrReport.SKIP;
                PostingDate := "Posting Date";
                NepaliDate := STPLmgt.getNepaliDate(PostingDate);

                IF GLAcc.GET("G/L Account No.") THEN;

                IF "Source Code" IN [SourceCodeSetup."Payment Journal", SourceCodeSetup."Cash Receipt Journal"] THEN
                    ShowReceivedBy := TRUE;
                IF "Source Type" = "Source Type"::Customer THEN BEGIN
                    CreditAmount := "G/L Entry"."Credit Amount";
                    DocumentNo := "G/L Entry"."Document No.";
                    Narration := "G/L Entry".Narration;
                    Narration1 := "G/L Entry".Narration;
                    Customer.SETRANGE("No.", "Source No.");
                    IF Customer.FIND('-') THEN BEGIN
                        IF Customer."Customer Posting Group" = 'ADVCUST' THEN BEGIN
                            CustDocSubClass.RESET;
                            CustDocSubClass.SETRANGE("No.", "G/L Entry"."Document Subclass");
                            IF CustDocSubClass.FINDFIRST THEN BEGIN
                                CustomerName := CustDocSubClass.Name + ' ' + CustDocSubClass."Name 2";
                                CustomerAddress := CustDocSubClass.Address;
                                CustomerNumber := CustDocSubClass."Phone No.";
                                CustomerVAT := CustDocSubClass."VAT Registration No.";
                            END;
                        END ELSE BEGIN
                            CustomerName := Customer.Name + ' ' + Customer."Name 2";
                            CustomerAddress := Customer.Address;
                            CustomerNumber := Customer."Phone No.";
                            CustomerVAT := Customer."VAT Registration No.";
                        END;
                    END;
                END ELSE BEGIN
                    CreditAmount := 0;
                    DocumentNo := '';
                    ChequeNo := '';
                    //CustomerName := '';
                    //CustomerAddress := '';
                    //CustomerNumber := '';
                    //CustomerVAT := '';
                END;
                GLAccName := FindGLAccName("Source Type", "Entry No.", "Source No.", "G/L Account No.");
                BankAccountNo := FindGLAccNo("Source Type", "Entry No.", "Source No.", "G/L Account No.");
                IF BankAccountNo <> '' THEN
                    GLAccName += ', ' + BankAccountNo;
                //EmpName := FindEmpName("Dimension Set ID");
                Dim1ValueName := FindDim1("Dimension Set ID");
                Dim2ValueName := FindDim2("Dimension Set ID");
                NarrationText := GetNarration("Entry No.");
                Description1 := GetDescription("Source Type", "Entry No.", "Source No.", "G/L Account No.");
                IF Amount < 0 THEN BEGIN
                    CrText := 'To';
                    DrText := '';
                END ELSE BEGIN
                    CrText := '';
                    DrText := 'Dr';
                END;
                GetPaymentInfo;
                SourceDesc := '';
                IF "Source Code" <> '' THEN BEGIN
                    SourceCode.GET("Source Code");
                    SourceDesc := SourceCode.Description;
                END;

                PageLoop := PageLoop - 1;
                LinesPrinted := LinesPrinted + 1;

                ChequeNo := '';
                ChequeDate := 0D;

                IF (ChequeNo <> '') AND (ChequeDate <> 0D) THEN BEGIN
                    PageLoop := PageLoop - 1;
                    LinesPrinted := LinesPrinted + 1;
                END;
                IF PostingDate <> "Posting Date" THEN BEGIN
                    PostingDate := "Posting Date";
                    TotalDebitAmt := 0;
                END;
                IF DocumentNo <> "Document No." THEN BEGIN
                    DocumentNo := "Document No.";
                    TotalDebitAmt := 0;
                END;

                IF PostingDate = "Posting Date" THEN BEGIN
                    TotalDebitAmt += "Debit Amount";
                    PageLoop := NUMLines;
                    LinesPrinted := 0;
                END;
                IF ISSERVICETIER THEN BEGIN
                    IF (PrePostingDate <> "Posting Date") OR (PreDocumentNo <> "Document No.") THEN BEGIN
                        DebitAmountTotal := 0;
                        CreditAmountTotal := 0;
                        PrePostingDate := "Posting Date";
                        PreDocumentNo := "Document No.";
                    END;

                    DebitAmountTotal := DebitAmountTotal + "Debit Amount";
                    CreditAmountTotal := CreditAmountTotal + "Credit Amount";
                END;

                IF DebitAmountTotal <> 0 THEN BEGIN
                    NumberToText.InitTextVariable;
                    NumberToText.FormatNoText(TextVar1, DebitAmountTotal, '');

                END ELSE BEGIN
                    NumberToText.InitTextVariable;
                    NumberToText.FormatNoText(TextVar1, CreditAmountTotal, '');

                END;

                IF ShowDimension THEN
                    GetDimensions("Dimension Set ID");
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CREATETOTALS(Amount);

                NUMLines := 13;
                PageLoop := NUMLines;
                LinesPrinted := 0;
                DebitAmountTotal := 0;
                CreditAmountTotal := 0;
                //TestField := 0;
                SETFILTER("Source Code", '<>%1&<>%2&<>%3&<>%4', SourceCodeSetup."Sales Entry Application",
                                                    SourceCodeSetup."Purchase Entry Application",
                                                    SourceCodeSetup."Unapplied Sales Entry Appln.",
                                                    SourceCodeSetup."Unapplied Purch. Entry Appln.");
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
        CompanyInfo.CALCFIELDS("Picture 2");
        CompanyInfo.CALCFIELDS("Picture 3");
        Info1 := CompanyInfo.Address + ', Phone No. : ' + CompanyInfo."Phone No." + ', Fax No. : ' + CompanyInfo."Fax No.";
        Info2 := 'E-mail : ' + CompanyInfo."E-Mail";
    end;

    var
        GLSetup: Record "98";
        HRSetup: Record "5218";
        GLAcc: Record "15";
        Customer: Record "18";
        CustomerName: Text[250];
        CustomerAddress: Text[50];
        CustomerNumber: Text[30];
        CustomerVAT: Text[20];
        CompanyInfo: Record "79";
        CreditAmount: Decimal;
        UserSetup: Record "91";
        RespCenter: Record "5714";
        Dim1ValueName: Text[50];
        Address: Text[50];
        PhoneNo: Text[30];
        FaxNo: Text[30];
        Email: Text[80];
        Info1: Text[200];
        Info2: Text[200];
        CompanyVAT: Text[20];
        DocumentNo: Code[20];
        PostingDate: Date;
        NepaliDate: Text[20];
        STPLmgt: Codeunit "50000";
        Narration: Text[250];
        SourceCode: Record "230";
        GLEntry: Record "17";
        BankAccLedgEntry: Record "271";
        GLAccName: Text;
        SourceDesc: Text[50];
        CrText: Text[2];
        DrText: Text[2];
        NumberText: Text[80];
        PageLoop: Integer;
        LinesPrinted: Integer;
        NUMLines: Integer;
        ChequeNo: Code[50];
        ChequeDate: Date;
        OnesText: Text[30];
        TensText: Text[30];
        ExponentText: Text[30];
        PrintLineNarration: Boolean;
        TotalDebitAmt: Decimal;
        DebitAmountTotal: Decimal;
        CreditAmountTotal: Decimal;
        PrePostingDate: Date;
        PreDocumentNo: Code[20];
        "BankNo.": Record "270";
        BankAccountNo: Text[30];
        EmpName: Text[50];
        Dim2ValueName: Text[50];
        City: Text[50];
        NarrationText: Text[250];
        "LCNo.": Code[20];
        "Bank LCNo.": Code[20];
        Narration1: Text[250];
        CheckNo: Code[50];
        TestField: Integer;
        NumberToText: Codeunit "50000";
        TextVar: array[2] of Text[80];
        TextVar1: array[2] of Text[80];
        TestText: Text[250];
        Amount: Decimal;
        Description1: Text[50];
        Dim1Name: Text[50];
        Dim2Name: Text[50];
        Dimension: Record "348";
        DimensionText: array[8] of Text[100];
        ShowDimension: Boolean;
        ShowReceivedBy: Boolean;
        SourceCodeSetup: Record "242";
        Text16526: Label 'ZERO';
        Text16527: Label 'HUNDRED';
        Text16528: Label 'AND';
        Text16529: Label '%1 results in a written number that is too long.';
        Text16532: Label 'ONE';
        Text16533: Label 'TWO';
        Text16534: Label 'THREE';
        Text16535: Label 'FOUR';
        Text16536: Label 'FIVE';
        Text16537: Label 'SIX';
        Text16538: Label 'SEVEN';
        Text16539: Label 'EIGHT';
        Text16540: Label 'NINE';
        Text16541: Label 'TEN';
        Text16542: Label 'ELEVEN';
        Text16543: Label 'TWELVE';
        Text16544: Label 'THIRTEEN';
        Text16545: Label 'FOURTEEN';
        Text16546: Label 'FIFTEEN';
        Text16547: Label 'SIXTEEN';
        Text16548: Label 'SEVENTEEN';
        Text16549: Label 'EIGHTEEN';
        Text16550: Label 'NINETEEN';
        Text16551: Label 'TWENTY';
        Text16552: Label 'THIRTY';
        Text16553: Label 'FORTY';
        Text16554: Label 'FIFTY';
        Text16555: Label 'SIXTY';
        Text16556: Label 'SEVENTY';
        Text16557: Label 'EIGHTY';
        Text16558: Label 'NINETY';
        Text16559: Label 'THOUSAND';
        Text16560: Label 'MILLION';
        Text16561: Label 'BILLION';
        Text16562: Label 'LAKH';
        Text16563: Label 'CRORE';
        G_L_RegisterCaptionLbl: Label 'G/L Register';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        G_L_Entry__Posting_Date_CaptionLbl: Label 'Posting Date';
        G_L_Entry__Document_Type_CaptionLbl: Label 'Document Type';
        GLAcc_NameCaptionLbl: Label 'Name';
        G_L_Entry__Gen__Posting_Type_CaptionLbl: Label 'Gen. Posting Type';
        G_L_Entry__Gen__Bus__Posting_Group_CaptionLbl: Label 'Gen. Bus. Posting Group';
        G_L_Entry__Gen__Prod__Posting_Group_CaptionLbl: Label 'Gen. Prod. Posting Group';
        G_L_Register__No__CaptionLbl: Label 'Register No.';
        TotalCaptionLbl: Label 'Total';
        Narration_CaptionLbl: Label 'Narration:';
        G_L_Entry_Amount_Control41CaptionLbl: Label 'Total';
        BankName: Text;
        CustDocSubClass: Record "18";

    [Scope('Internal')]
    procedure FindGLAccName("Source Type": Option " ",Customer,Vendor,"Bank Account","Fixed Asset"; "Entry No.": Integer; "Source No.": Code[20]; "G/L Account No.": Code[20]): Text[100]
    var
        AccName: Text[100];
        VendLedgerEntry: Record "25";
        Vend: Record "23";
        CustLedgerEntry: Record "21";
        Cust: Record "18";
        BankLedgerEntry: Record "271";
        Bank: Record "270";
        FALedgerEntry: Record "5601";
        FA: Record "5600";
        GLAccount: Record "15";
        "BankAccNo.": Text[30];
    begin
        IF "Source Type" = "Source Type"::Vendor THEN
            IF VendLedgerEntry.GET("Entry No.") THEN BEGIN
                Vend.GET("Source No.");
                AccName := Vend.Name;
            END ELSE BEGIN
                GLAccount.GET("G/L Account No.");
                AccName := GLAccount.Name;
            END
        ELSE
            IF "Source Type" = "Source Type"::Customer THEN
                IF CustLedgerEntry.GET("Entry No.") THEN BEGIN
                    Cust.GET("Source No.");
                    AccName := Cust.Name + ' ' + Cust."Name 2";
                END ELSE BEGIN
                    GLAccount.GET("G/L Account No.");
                    AccName := GLAccount.Name;
                END
            ELSE
                IF "Source Type" = "Source Type"::"Bank Account" THEN
                    IF BankLedgerEntry.GET("Entry No.") THEN BEGIN
                        Bank.GET("Source No.");
                        AccName := Bank.Name;

                    END ELSE BEGIN
                        GLAccount.GET("G/L Account No.");
                        AccName := GLAccount.Name;
                    END
                ELSE
                    IF "Source Type" = "Source Type"::"Fixed Asset" THEN BEGIN
                        FALedgerEntry.RESET;
                        FALedgerEntry.SETCURRENTKEY("G/L Entry No.");
                        FALedgerEntry.SETRANGE("G/L Entry No.", "Entry No.");
                        IF FALedgerEntry.FINDFIRST THEN BEGIN
                            FA.GET("Source No.");
                            AccName := FA.Description;
                        END ELSE BEGIN
                            GLAccount.GET("G/L Account No.");
                            AccName := GLAccount.Name;
                        END;
                    END ELSE BEGIN
                        GLAccount.GET("G/L Account No.");
                        AccName := GLAccount.Name;
                    END;

        IF "Source Type" = "Source Type"::" " THEN BEGIN
            GLAccount.GET("G/L Account No.");
            AccName := GLAccount.Name;
        END;

        EXIT(AccName);
    end;

    [Scope('Internal')]
    procedure FindGLAccNo("Source Type": Option " ",Customer,Vendor,"Bank Account","Fixed Asset"; "Entry No.": Integer; "Source No.": Code[20]; "G/L Account No.": Code[20]): Text[30]
    var
        AccNo: Text[30];
        BankLedgerEntry: Record "271";
        Bank: Record "270";
    begin
        IF "Source Type" = "Source Type"::"Bank Account" THEN
            IF BankLedgerEntry.GET("Entry No.") THEN BEGIN
                Bank.GET("Source No.");
                AccNo := Bank."Bank Account No.";
            END ELSE BEGIN
            END;
        EXIT(AccNo);
    end;

    [Scope('Internal')]
    procedure FindEmpName(DimensionSetID: Integer): Text[50]
    var
        EmployeeName: Text[50];
        DimensionCode: Code[20];
        DimensionValueCode: Code[20];
        DimSetEntry: Record "480";
        DimensionValue: Record "349";
    begin
        DimSetEntry.SETRANGE("Dimension Set ID", DimensionSetID);
        //DimSetEntry.SETRANGE("Dimension Code",HRSetup."Employee Dimension");
        IF DimSetEntry.FINDFIRST THEN BEGIN
            DimensionCode := DimSetEntry."Dimension Code";
            DimensionValueCode := DimSetEntry."Dimension Value Code";
            DimensionValue.RESET;
            DimensionValue.SETRANGE(DimensionValue.Code, DimensionValueCode);
            IF DimensionValue.FINDFIRST THEN
                EmployeeName := DimensionValue.Name;
        END;
        EXIT(EmployeeName);
    end;

    [Scope('Internal')]
    procedure FindDim1(DimensionSetID: Integer): Text[50]
    var
        Dim1Name: Text[50];
        DimensionCode: Code[20];
        DimensionValueCode: Code[20];
        DimSetEntry: Record "480";
        DimensionValue: Record "349";
    begin
        DimSetEntry.SETRANGE("Dimension Set ID", DimensionSetID);
        DimSetEntry.SETRANGE("Dimension Code", GLSetup."Global Dimension 1 Code");
        IF DimSetEntry.FINDFIRST THEN BEGIN
            DimensionCode := DimSetEntry."Dimension Code";
            DimensionValueCode := DimSetEntry."Dimension Value Code";
            DimensionValue.RESET;
            DimensionValue.SETRANGE(DimensionValue.Code, DimensionValueCode);
            IF DimensionValue.FINDFIRST THEN
                Dim1Name := DimensionValue.Name;
        END;
        EXIT(Dim1Name);
    end;

    [Scope('Internal')]
    procedure FindDim2(DimensionSetID: Integer): Text[50]
    var
        Dim2Name: Text[50];
        DimensionCode: Code[20];
        DimensionValueCode: Code[20];
        DimSetEntry: Record "480";
        DimensionValue: Record "349";
    begin
        DimSetEntry.SETRANGE("Dimension Set ID", DimensionSetID);
        DimSetEntry.SETRANGE("Dimension Code", GLSetup."Global Dimension 2 Code");
        IF DimSetEntry.FINDFIRST THEN BEGIN
            DimensionCode := DimSetEntry."Dimension Code";
            DimensionValueCode := DimSetEntry."Dimension Value Code";
            DimensionValue.RESET;
            DimensionValue.SETRANGE(DimensionValue.Code, DimensionValueCode);
            IF DimensionValue.FINDFIRST THEN
                Dim2Name := DimensionValue.Name;
        END;
        EXIT(Dim2Name);
    end;

    [Scope('Internal')]
    procedure GetNarration("Entry No.": Integer): Text[250]
    var
        Narration: Text[250];
        GLEntry1: Record "17";
    begin
        GLEntry1.SETRANGE(GLEntry1."Entry No.", "Entry No.");
        IF GLEntry1.FINDFIRST THEN
            Narration := GLEntry1.Narration;

        EXIT(Narration);
    end;

    [Scope('Internal')]
    procedure FindCustomerName("Source Type": Option " ",Customer,Vendor,"Bank Account","Fixed Asset"; "Entry No.": Integer; "Source No.": Code[20]): Text[50]
    var
        CustName: Text[50];
        Customer: Record "18";
        CustomerLedgerEntry: Record "21";
    begin
        IF "Source Type" = "Source Type"::Customer THEN
            IF CustomerLedgerEntry.GET("Entry No.") THEN BEGIN
                Customer.GET("Source No.");
                //AccName := Bank.Name;
                CustName := Customer.Name;
            END;
        EXIT(CustName);
    end;

    local procedure GetDimensions(DimSetID: Integer)
    var
        DimensionSetEntry: Record "480";
        i: Integer;
    begin
        CLEAR(DimensionText);
        DimensionSetEntry.RESET;
        DimensionSetEntry.SETRANGE("Dimension Set ID", DimSetID);
        IF DimensionSetEntry.FINDSET THEN
            REPEAT
                DimensionSetEntry.CALCFIELDS("Dimension Value Name");
                i += 1;
                DimensionText[i] := DimensionSetEntry."Dimension Code" + ' : ' + DimensionSetEntry."Dimension Value Name";
            UNTIL DimensionSetEntry.NEXT = 0;
    end;

    [Scope('Internal')]
    procedure GetCustomerAddress("Account No.": Code[20]; "Account Type": Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"): Text[50]
    var
        Cust: Record "18";
        CustomerAddress: Text[50];
    begin
        IF ("Account Type" = "Account Type"::Customer) THEN BEGIN
            Cust.RESET;
            Cust.SETRANGE("No.", "Account No.");
            IF Cust.FIND('-') THEN
                CustomerAddress := Cust.Address;

            EXIT(CustomerAddress);
        END
    end;

    [Scope('Internal')]
    procedure GetCustomerName("Account No": Code[20]; "Account Type": Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"): Text[50]
    var
        Cust: Record "18";
        CustomerName: Text[50];
    begin
        IF ("Account Type" = "Account Type"::Customer) THEN BEGIN
            Cust.RESET;
            Cust.SETRANGE("No.", "Account No");
            IF Cust.FIND('-') THEN
                CustomerName := Cust.Name;

            EXIT(CustomerName);
        END
    end;

    [Scope('Internal')]
    procedure GetVATNo("Account No": Code[20]; "Account Type": Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"): Text[20]
    var
        Cust: Record "18";
        VatNo: Text[20];
    begin
        IF ("Account Type" = "Account Type"::Customer) THEN BEGIN
            Cust.RESET;
            Cust.SETRANGE("No.", "Account No");
            IF Cust.FIND('-') THEN
                VatNo := Cust."VAT Registration No.";

            EXIT(VatNo);
        END
    end;

    [Scope('Internal')]
    procedure GetCustomerAmount("Account No": Code[20]; "Account Type": Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"): Decimal
    var
        Amount: Decimal;
    begin
        IF ("Account Type" = "Account Type"::Customer) THEN BEGIN
            Amount := "G/L Entry".Amount;

            EXIT(Amount);
        END;
    end;

    [Scope('Internal')]
    procedure GetDescription("Source Type": Option " ",Customer,Vendor,"Bank Account","Fixed Asset"; "Entry No.": Integer; "Source No.": Code[20]; "G/L Account No.": Code[20]): Text[50]
    var
        Description: Text[50];
    begin
        IF "Source Type" = "Source Type"::Vendor THEN BEGIN
            IF GLEntry.GET("Entry No.") THEN
                Description := GLEntry.Description
        END ELSE
            IF "Source Type" = "Source Type"::Customer THEN BEGIN
                IF GLEntry.GET("Entry No.") THEN
                    Description := GLEntry.Description;
            END ELSE
                IF "Source Type" = "Source Type"::"Bank Account" THEN BEGIN
                    IF GLEntry.GET("Entry No.") THEN
                        Description := GLEntry.Description;
                END ELSE
                    IF "Source Type" = "Source Type"::"Fixed Asset" THEN BEGIN
                        IF GLEntry.GET("Entry No.") THEN
                            Description := GLEntry.Description
                    END ELSE
                        Description := GLEntry.Description;

        IF "Source Type" = "Source Type"::" " THEN BEGIN
            IF GLEntry.GET("Entry No.") THEN
                Description := GLEntry.Description;
        END;
        EXIT(Description);
    end;

    local procedure GetPaymentInfo()
    var
        GLEntry: Record "17";
        Customer: Record "18";
        BankAccount: Record "270";
    begin
        GLEntry.RESET;
        GLEntry.SETRANGE("Document No.", "G/L Entry"."Document No.");
        GLEntry.SETRANGE("Posting Date", "G/L Entry"."Posting Date");
        GLEntry.SETRANGE("Source Type", GLEntry."Source Type"::"Bank Account");
        IF GLEntry.FINDLAST THEN BEGIN
            IF BankAccount.GET(GLEntry."Source No.") THEN BEGIN
                BankName := BankAccount.Name;
            END;
        END ELSE
            BankName := 'CASH';
    end;
}

