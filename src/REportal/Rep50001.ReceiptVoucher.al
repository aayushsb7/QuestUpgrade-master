report 50001 "Receipt Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReceiptVoucher.rdlc';

    dataset
    {
        dataitem(DataItem7024; Table81)
        {
            DataItemTableView = SORTING (Journal Template Name, Journal Batch Name, Posting Date, Document No.);
            RequestFilterFields = "Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.";
            RequestFilterHeading = 'Receipt Voucher';
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(ContactNo; ContactNo)
            {
            }
            column(CustomerAddress1; CustomerAddress1)
            {
            }
            column(CustomerName; CustomerName)
            {
            }
            column(CustomerVAT; CustomerVAT)
            {
            }
            column(NepaliDate; NepaliDate)
            {
            }
            column(CompInfo_Picture_Control1000000018; CompInfo.Picture)
            {
            }
            column(BranchName; BranchName)
            {
            }
            column(Address; Address)
            {
            }
            column(PhoneNo; PhoneNo)
            {
            }
            column(FaxNo; FaxNo)
            {
            }
            column(Email; Email)
            {
            }
            column(Info1; Info1)
            {
            }
            column(Info2; Info2)
            {
            }
            column(CompanyVAT; CompanyVAT)
            {
            }
            column(CustomerAmount; CustomerAmount)
            {
            }
            column(CustomerDescription; CustomerDescription)
            {
            }
            column(Gen__Journal_Line_Narration; Narration)
            {
            }
            column(Gen__Journal_Line__Account_Type_; "Account Type")
            {
            }
            column(Gen__Journal_Line__Account_No__; AccCode)
            {
            }
            column(Gen__Journal_Line_Description; Description)
            {
            }
            column(Gen__Journal_Line__Debit_Amount_; "Debit Amount")
            {
            }
            column(Gen__Journal_Line__Credit_Amount_; "Credit Amount")
            {
            }
            column(Gen__Journal_Line__Shortcut_Dimension_1_Code_; "Shortcut Dimension 1 Code")
            {
            }
            column(Gen__Journal_Line__Shortcut_Dimension_2_Code_; "Shortcut Dimension 2 Code")
            {
            }
            column(Gen__Journal_Line__Document_No__; VoucNo)
            {
            }
            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(AccName; AccName)
            {
            }
            column(PostingDateText; PostDate)
            {
            }
            column(RemarksText; RemarksText)
            {
            }
            column(Gen__Journal_Line__Cheque_No__; "External Document No.")
            {
            }
            column(CustomerAddress; CustomerAddress)
            {
            }
            column(BankAccountNo; BankAccountNo)
            {
            }
            column(Gen__Journal_Line__Debit_Amount__Control1000000041; "Debit Amount")
            {
            }
            column(Gen__Journal_Line__Credit_Amount__Control1000000042; "Credit Amount")
            {
            }
            column(Gen__Journal_LineCaption; Gen__Journal_LineCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Gen__Journal_Line__Account_Type_Caption; FIELDCAPTION("Account Type"))
            {
            }
            column(Gen__Journal_Line__Account_No__Caption; Gen__Journal_Line__Account_No__CaptionLbl)
            {
            }
            column(Gen__Journal_Line_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Gen__Journal_Line__Debit_Amount_Caption; Gen__Journal_Line__Debit_Amount_CaptionLbl)
            {
            }
            column(Gen__Journal_Line__Credit_Amount_Caption; Gen__Journal_Line__Credit_Amount_CaptionLbl)
            {
            }
            column(Gen__Journal_Line__Shortcut_Dimension_1_Code_Caption; FIELDCAPTION("Shortcut Dimension 1 Code"))
            {
            }
            column(Gen__Journal_Line__Shortcut_Dimension_2_Code_Caption; FIELDCAPTION("Shortcut Dimension 2 Code"))
            {
            }
            column(Gen__Journal_Line__Document_No__Caption; Gen__Journal_Line__Document_No__CaptionLbl)
            {
            }
            column(Acc__NameCaption; Acc__NameCaptionLbl)
            {
            }
            column(Posting_DateCaption; Posting_DateCaptionLbl)
            {
            }
            column(Gen__Journal_Line_Journal_Template_Name; "Journal Template Name")
            {
            }
            column(Gen__Journal_Line_Journal_Batch_Name; "Journal Batch Name")
            {
            }
            column(Gen__Journal_Line_Line_No_; "Line No.")
            {
            }
            column(Gen__Journal_Line_Posting_Date; "Posting Date")
            {
            }
            column(Gen__Journal_Line_Document_No_; "Document No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                VoucNo := "Document No.";
                PostDate := FORMAT("Posting Date");
                CustomerAddress := GetCustomerAddress("Account No.", "Account Type");
                CustomerAddress1 := GetCustomerAddress("Account No.", "Account Type");
                BankAccountNo := GetBankAccountNo("Account Type", "Account No.");
                ContactNo := GetContactNo("Account No.", "Account Type");
                CustomerName := GetCustomerName("Account No.", "Account Type");
                CustomerVAT := GetVATNo("Account No.", "Account Type");
                CustomerAmount := GetCustomerAmount("Account No.", "Account Type");
                CustomerDescription := GetDescription("Account No.", "Account Type");
                Narration := "Gen. Journal Line".Narration;

                IF ("Account Type" = "Account Type"::"G/L Account") THEN BEGIN
                    GLAccount.RESET;
                    GLAccount.SETRANGE("No.", "Account No.");
                    IF GLAccount.FIND('-') THEN
                        AccName := GLAccount.Name;
                END ELSE
                    IF ("Account Type" = "Account Type"::"Bank Account") THEN BEGIN
                        BankAcc.RESET;
                        BankAcc.SETRANGE("No.", "Account No.");
                        IF BankAcc.FIND('-') THEN BEGIN
                            BankAccPostGrp.RESET;
                            BankAccPostGrp.SETRANGE(Code, BankAcc."Bank Acc. Posting Group");
                            IF BankAccPostGrp.FIND('-') THEN BEGIN
                                AccCode := BankAccPostGrp."G/L Bank Account No.";
                                GLAccount.GET(AccCode);
                                AccName := GLAccount.Name;
                            END;
                        END;
                    END ELSE
                        IF ("Account Type" = "Account Type"::Customer) THEN BEGIN
                            Cust.RESET;
                            Cust.SETRANGE("No.", "Account No.");
                            IF Cust.FIND('-') THEN BEGIN
                                CustomerAddress := Cust.Address;
                                CustPostGrp.RESET;
                                CustPostGrp.SETRANGE(Code, Cust."Customer Posting Group");
                                IF CustPostGrp.FIND('-') THEN BEGIN
                                    AccCode := CustPostGrp."Receivables Account";
                                    GLAccount.GET(AccCode);
                                    AccName := GLAccount.Name;
                                END;
                            END;
                        END ELSE
                            IF ("Account Type" = "Account Type"::Vendor) THEN BEGIN
                                Vend.RESET;
                                Vend.SETRANGE("No.", "Account No.");
                                IF Vend.FIND('-') THEN BEGIN
                                    VendPostGrp.RESET;
                                    VendPostGrp.SETRANGE(Code, Vend."Vendor Posting Group");
                                    IF VendPostGrp.FIND('-') THEN BEGIN
                                        AccCode := VendPostGrp."Payables Account";
                                        GLAccount.GET(AccCode);
                                        AccName := GLAccount.Name;

                                    END;
                                END;
                            END ELSE
                                IF ("Account Type" = "Account Type"::"Fixed Asset") THEN BEGIN
                                    FixAst.RESET;
                                    FixAst.SETRANGE("No.", "Account No.");
                                    IF FixAst.FIND('-') THEN BEGIN
                                        FAPostGrp.RESET;
                                        FAPostGrp.SETRANGE(Code, FixAst."FA Posting Group");
                                        IF FAPostGrp.FIND('-') THEN BEGIN
                                            AccCode := FAPostGrp."Acquisition Cost Account";
                                            GLAccount.GET(AccCode);
                                            AccName := GLAccount.Name;
                                        END;
                                    END;
                                END;
                NepaliDate := STPLMgt.getNepaliDate("Posting Date");
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Document No.");

                AccName := '';

                //to get information from responsibility center
                UserSetup.GET(USERID);

                RespCenter.RESET;
                RespCenter.SETRANGE(Code, UserSetup."Default Accountability Center");
                IF RespCenter.FIND('-') THEN BEGIN
                    BranchName := RespCenter.Name;
                    Address := RespCenter.Address;
                    PhoneNo := RespCenter."Phone No.";
                    FaxNo := RespCenter."Fax No.";
                    Email := RespCenter."E-Mail";
                END;

                Info1 := BranchName + ',' + Address + ',' + 'Ph. No.:' + PhoneNo;
                Info2 := 'Fax :' + FaxNo + ',' + 'Email :' + Email;
                CompanyVAT := CompInfo."VAT Registration No.";
                CLEAR(CustomerAmount);
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
        CompInfo.GET;
        CompInfo.CALCFIELDS(Picture);
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total for ';
        CompInfo: Record "79";
        GLAccount: Record "15";
        Cust: Record "18";
        Vend: Record "23";
        BankAcc: Record "270";
        FixAst: Record "5600";
        AccName: Text[50];
        PostingDateText: Text[60];
        RemarksText: Text[250];
        CustPostGrp: Record "92";
        VendPostGrp: Record "93";
        BankAccPostGrp: Record "277";
        FAPostGrp: Record "5606";
        AccCode: Code[20];
        VoucNo: Code[20];
        PostDate: Text[20];
        CustomerAddress: Text[50];
        BankAccountNo: Text[30];
        ContactNo: Text[30];
        CustomerAddress1: Text[50];
        CustomerName: Text[50];
        CustomerVAT: Text[20];
        NepaliDate: Code[10];
        STPLMgt: Codeunit "50000";
        UserSetup: Record "91";
        RespCenter: Record "5714";
        BranchName: Text[50];
        Address: Text[50];
        PhoneNo: Text[30];
        FaxNo: Text[30];
        Email: Text[80];
        Info1: Text[200];
        Info2: Text[200];
        CompanyVAT: Text[20];
        CustomerAmount: Decimal;
        CustomerDescription: Text[50];
        Narration: Text[250];
        Gen__Journal_LineCaptionLbl: Label 'Gen. Journal Line';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Gen__Journal_Line__Account_No__CaptionLbl: Label 'Account No.';
        Gen__Journal_Line__Debit_Amount_CaptionLbl: Label 'Debit Amount (NPR)';
        Gen__Journal_Line__Credit_Amount_CaptionLbl: Label 'Credit Amount (NPR)';
        Gen__Journal_Line__Document_No__CaptionLbl: Label 'Voucher No.';
        Acc__NameCaptionLbl: Label 'Account Name';
        Posting_DateCaptionLbl: Label 'Posting Date';

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
    procedure GetBankAccountNo("Account Type": Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"; "Account No": Code[20]): Text[30]
    var
        AccNo: Text[30];
        BankLedgerEntry: Record "271";
        Bank: Record "270";
    begin

        IF "Account Type" = "Account Type"::"Bank Account" THEN
            //IF BankLedgerEntry.GET("Entry No.") THEN BEGIN
            Bank.GET("Account No");
        //AccName := Bank.Name;
        AccNo := Bank."Bank Account No.";
        EXIT(AccNo);
    end;

    [Scope('Internal')]
    procedure GetContactNo("Account No": Code[20]; "Account Type": Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"): Text[30]
    var
        Cust: Record "18";
        "PhoneNo.": Text[30];
    begin
        IF ("Account Type" = "Account Type"::Customer) THEN BEGIN
            Cust.RESET;
            Cust.SETRANGE("No.", "Account No");
            IF Cust.FIND('-') THEN
                "PhoneNo." := Cust."Phone No.";

            EXIT("PhoneNo.");
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
            Amount := "Gen. Journal Line"."Credit Amount";

            EXIT(Amount);
        END;
    end;

    [Scope('Internal')]
    procedure GetDescription("Account No": Code[20]; "Account Type": Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"): Text[50]
    var
        Description: Text[50];
    begin
        IF ("Account Type" = "Account Type"::Customer) THEN BEGIN
            Description := "Gen. Journal Line".Description;

            EXIT(Description);
        END;
    end;
}

