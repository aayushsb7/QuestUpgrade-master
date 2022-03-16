report 50026 "TDS Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './TDSReport.rdlc';

    dataset
    {
        dataitem(DataItem1; Table17)
        {
            column(BalAccountNo_GLEntry; "G/L Entry"."Bal. Account No.")
            {
            }
            column(GLAccountName_GLEntry; "G/L Entry"."G/L Account Name")
            {
            }
            column(GLAccountNo_GLEntry; "G/L Entry"."G/L Account No.")
            {
            }
            column(TDSGroup_GLEntry; "G/L Entry"."TDS Group")
            {
            }
            column(TDS_GLEntry; "G/L Entry"."TDS%")
            {
            }
            column(TDSType_GLEntry; "G/L Entry"."TDS Type")
            {
            }
            column(TDSAmount_GLEntry; "G/L Entry"."TDS Amount")
            {
            }
            column(TDSBaseAmount_GLEntry; "G/L Entry"."TDS Base Amount")
            {
            }
            column(DocumentNo_GLEntry; "G/L Entry"."Document No.")
            {
            }
            column(VendorNo; VendorNo)
            {
            }
            column(VendorName; VendorName)
            {
            }
            column(IRDDate; IRDDate)
            {
            }
            column(IRDNo; IRDNo)
            {
            }

            trigger OnAfterGetRecord()
            begin
                VendorRec.RESET;
                VendorRec.SETRANGE("No.", "Bal. Account No.");
                IF VendorRec.FINDFIRST THEN BEGIN
                    VendorNo := "Bal. Account No.";
                    VendorName := VendorRec.Name;
                END;

                TDSRec.RESET;
                TDSRec.SETRANGE("Transaction No.", "Transaction No.");
                IF TDSRec.FINDFIRST THEN BEGIN
                    IRDNo := TDSRec."IRD Voucher No.";
                    IRDDate := TDSRec."IRD Voucher Date";
                END;
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("TDS Amount", '>%1', 0);
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

    var
        VendorNo: Code[20];
        VendorName: Text[50];
        IRDNo: Code[50];
        IRDDate: Date;
        VendorRec: Record "23";
        TDSRec: Record "50006";
}

