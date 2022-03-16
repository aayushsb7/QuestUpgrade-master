report 50019 "Cash Receipt Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CashReceiptVoucher.rdlc';

    dataset
    {
        dataitem(DataItem7024; Table17)
        {
            DataItemTableView = SORTING (Source Code, Source No.)
                                ORDER(Descending)
                                WHERE (Credit Amount=FILTER(<>0));
            RequestFilterFields = "Entry No.","Document Type","Posting Date";
            RequestFilterHeading = 'Receipt Voucher';
            column(FORMAT_TODAY_0_4_;FORMAT(TODAY,0,4))
            {
            }
            column(CompInfo_Name;CompInfo.Name)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PAGENO)
            {
            }
            column(PaymentMethodCode;PaymentMethod)
            {
            }
            column(USERID;USERID)
            {
            }
            column(ContactNo;ContactNo)
            {
            }
            column(CustomerAddress1;CustomerAddress1)
            {
            }
            column(CustomerName;CustomerName)
            {
            }
            column(CustomerVAT;CustomerVAT)
            {
            }
            column(NepaliDate;NepaliDate)
            {
            }
            column(CompInfo_Picture_Control1000000018;CompInfo.Picture)
            {
            }
            column(BranchName;BranchName)
            {
            }
            column(Address;Address)
            {
            }
            column(PhoneNo;PhoneNo)
            {
            }
            column(FaxNo;FaxNo)
            {
            }
            column(Email;Email)
            {
            }
            column(Info1;Info1)
            {
            }
            column(Info2;Info2)
            {
            }
            column(TextVar1;textVar[1])
            {
            }
            column(TextVar2;textVar[2])
            {
            }
            column(CompanyVAT;CompanyVAT)
            {
            }
            column(CustomerAmount;CustomerAmount)
            {
            }
            column(CustomerDescription;CustomerDescription)
            {
            }
            column(GLEntry_Narration;Narration)
            {
            }
            column(GLEntry_Account_Type;"G/L Entry"."Bal. Account Type")
            {
            }
            column(GLEntry_Account_No;AccCode)
            {
            }
            column(GLEntry_Description;Description)
            {
            }
            column(GLEntry_Debit_Amount;"Debit Amount")
            {
            }
            column(GLEntry_Credit_Amount;"Credit Amount")
            {
            }
            column(GLEntry_Document_No__;VoucNo)
            {
            }
            column(CompInfo_Picture;CompInfo.Picture)
            {
            }
            column(AccName;AccName)
            {
            }
            column(PostingDateText;PostDate)
            {
            }
            column(RemarksText;RemarksText)
            {
            }
            column(GLEntry_Cheque_No;"External Document No.")
            {
            }
            column(CustomerAddress;CustomerAddress)
            {
            }
            column(BankAccountNo;BankAccountNo)
            {
            }
            column(GLEntry_Debit_Amount__Control1000000041;"Debit Amount")
            {
            }
            column(GLEntry_Credit_Amount__Control1000000042;"Credit Amount")
            {
            }
            column(GLEntry_LineCaption;Gen__Journal_LineCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(GLEntry_Account_Type_Caption;FIELDCAPTION("Bal. Account Type"))
            {
            }
            column(GLEntry_Account_No__Caption;Gen__Journal_Line__Account_No__CaptionLbl)
            {
            }
            column(GLEntry_DescriptionCaption;FIELDCAPTION(Description))
            {
            }
            column(GLEntry_Debit_Amount_Caption;Gen__Journal_Line__Debit_Amount_CaptionLbl)
            {
            }
            column(GLEntry_Credit_Amount_Caption;Gen__Journal_Line__Credit_Amount_CaptionLbl)
            {
            }
            column(GLEntry_Document_No__Caption;Gen__Journal_Line__Document_No__CaptionLbl)
            {
            }
            column(Acc__NameCaption;Acc__NameCaptionLbl)
            {
            }
            column(Posting_DateCaption;Posting_DateCaptionLbl)
            {
            }
            column(GLEntry_Posting_Date;"Posting Date")
            {
            }
            column(GLEntry_Document_No_;"Document No.")
            {
            }
            column(GLEntry_Global_DimensionCode1;"G/L Entry"."Global Dimension 1 Code")
            {
            }
            column(GLEntry_Global_DimensionCode2;"G/L Entry"."Global Dimension 2 Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                VoucNo := "Document No.";
                PostDate := FORMAT("Posting Date");
                CustomerAddress := GetCustomerAddress("Source No.","Source Type");
                CustomerAddress1 := GetCustomerAddress("Source No.","Source Type");
                BankAccountNo := GetBankAccountNo("Source Type","Source No.");
                ContactNo := GetContactNo("Source No.","Source Type");
                CustomerName := GetCustomerName("Source No.","Source Type");
                CustomerVAT := GetVATNo("Source No.","Source Type");

                CustomerDescription := GetDescription("Source No.","Source Type");
                Narration := "G/L Entry".Narration;

                IF CustomerName = '' THEN BEGIN
                  DimensionValue.RESET;
                  DimensionValue.SETRANGE("Dimension Code",'EMPLOYEE');
                  DimensionValue.SETRANGE(Code,"G/L Entry"."Shortcut Dimension 4 Code");
                  IF DimensionValue.FINDFIRST THEN
                    CustomerName := DimensionValue.Name;
                END;
                AccCode := "G/L Account No.";
                CALCFIELDS("G/L Account Name");
                AccName := "G/L Account Name";

                NepaliDate := STPLMgt.getNepaliDate("Posting Date");
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Document No.");

                AccName := '';

                //to get information from responsibility center
                UserSetup.GET(USERID);

                RespCenter.RESET;
                RespCenter.SETRANGE(Code,UserSetup."Default Accountability Center");
                IF RespCenter.FIND('-') THEN BEGIN
                  BranchName := 'Dhumbarahi, Kathmandu'; //RespCenter.Name;
                  //Address := 'Dhumbarahi, Kathmandu'; //RespCenter.Address;
                  PhoneNo := '+977-1-4008801-5'; //RespCenter."Phone No.";
                  FaxNo := '+977-1-4008813';//RespCenter."Fax No.";
                  Email := 'finance@voith.com.np'; //RespCenter."E-Mail";
                END;

                Info1 := BranchName + ', '+'Tel.:'+PhoneNo;
                Info2 := 'Fax :'+ FaxNo + ', '+'Email : '+ Email;
                CompanyVAT := CompInfo."VAT Registration No.";
                CLEAR(CustomerAmount);

                GLEntry.RESET;
                GLEntry.SETRANGE("Document No.","G/L Entry".GETFILTER("Document No."));
                GLEntry.SETFILTER("Document Type",'%1|%2',GLEntry."Document Type"::" ",GLEntry."Document Type"::Payment);
                GLEntry.SETFILTER("Source Code",'<>%1','INVTPCOST');
                IF GLEntry.FINDSET THEN REPEAT
                  CustomerAmount += GetCustomerAmount(GLEntry."Source No.",GLEntry."Source Type");
                UNTIL GLEntry.NEXT = 0;

                SystemManagement.InitTextVariable;
                SystemManagement.FormatNoText(textVar, CustomerAmount,'');
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
        CustomerName: Text;
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
        textVar: array [2] of Text[100];
        SystemManagement: Codeunit "50000";
        PaymentMethod: Code[20];
        DimensionValue: Record "349";
        GLEntry: Record "17";

    [Scope('Internal')]
    procedure GetCustomerAddress("Account No.": Code[20];"Account Type": Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"): Text[50]
    var
        Cust: Record "18";
        CustomerAddress: Text[50];
    begin
        IF ("Account Type" = "Account Type"::Customer) THEN BEGIN
          Cust.RESET;
          Cust.SETRANGE("No.","Account No.");
          IF Cust.FIND('-') THEN
          CustomerAddress := Cust.Address;
        EXIT(CustomerAddress);
        END
    end;

    [Scope('Internal')]
    procedure GetBankAccountNo("Account Type": Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";"Account No": Code[20]): Text[30]
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
    procedure GetContactNo("Account No": Code[20];"Account Type": Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"): Text[30]
    var
        Cust: Record "18";
        "PhoneNo.": Text[30];
    begin
        IF ("Account Type" = "Account Type"::Customer) THEN BEGIN
          Cust.RESET;
          Cust.SETRANGE("No.","Account No");
          IF Cust.FIND('-') THEN
          "PhoneNo." := Cust."Phone No.";

        EXIT("PhoneNo.");
        END
    end;

    [Scope('Internal')]
    procedure GetCustomerName("Account No": Code[20];"Account Type": Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"): Text
    var
        Cust: Record "18";
        CustomerNameTxt: Text;
    begin
        IF ("Account Type" = "Account Type"::Customer) THEN BEGIN
          Cust.RESET;
          Cust.SETRANGE("No.","Account No");
          IF Cust.FIND('-') THEN
          CustomerNameTxt := Cust.Name + ' ' + Cust."Name 2";
        END;

        EXIT(CustomerNameTxt);
    end;

    [Scope('Internal')]
    procedure GetVATNo("Account No": Code[20];"Account Type": Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"): Text[20]
    var
        Cust: Record "18";
        VatNo: Text[20];
    begin
        IF ("Account Type" = "Account Type"::Customer) THEN BEGIN
          Cust.RESET;
          Cust.SETRANGE("No.","Account No");
          IF Cust.FIND('-') THEN
          VatNo := Cust."VAT Registration No.";

        EXIT(VatNo);
        END
    end;

    [Scope('Internal')]
    procedure GetCustomerAmount("Account No": Code[20];"Account Type": Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"): Decimal
    var
        Amount: Decimal;
    begin
        //IF ("Account Type" = "Account Type"::Customer) THEN BEGIN
        Amount := GLEntry."Credit Amount";
        EXIT(Amount);
        //END;
    end;

    [Scope('Internal')]
    procedure GetDescription("Account No": Code[20];"Account Type": Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"): Text[50]
    var
        Description: Text[50];
    begin
        IF ("Account Type" = "Account Type"::Customer) THEN BEGIN
            Description := "G/L Entry".Description;

        EXIT(Description);
        END;
    end;
}

