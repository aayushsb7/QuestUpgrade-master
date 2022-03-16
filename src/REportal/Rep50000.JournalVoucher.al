report 50000 "Journal Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = './JournalVoucher.rdlc';

    dataset
    {
        dataitem(DataItem7024; Table81)
        {
            DataItemTableView = SORTING (Journal Template Name, Journal Batch Name, Posting Date, Document No.);
            RequestFilterFields = "Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.";
            RequestFilterHeading = 'Journal Voucher';
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

                IF "Gen. Journal Line".Narration <> '' THEN
                    RemarksText := 'Narration: ' + "Gen. Journal Line".Narration;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Document No.");
                AccName := '';
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Option)
                {
                    Visible = false;
                    field(Narration; RemarksText)
                    {
                    }
                }
            }
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
        Gen__Journal_LineCaptionLbl: Label 'Gen. Journal Line';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Gen__Journal_Line__Account_No__CaptionLbl: Label 'Account No.';
        Gen__Journal_Line__Debit_Amount_CaptionLbl: Label 'Debit Amount (NPR)';
        Gen__Journal_Line__Credit_Amount_CaptionLbl: Label 'Credit Amount (NPR)';
        Gen__Journal_Line__Document_No__CaptionLbl: Label 'Voucher No.';
        Acc__NameCaptionLbl: Label 'Account Name';
        Posting_DateCaptionLbl: Label 'Posting Date';
}

