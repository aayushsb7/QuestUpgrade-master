report 50051 "Employee Detail"
{
    DefaultLayout = RDLC;
    RDLCLayout = './EmployeeDetail.rdlc';

    dataset
    {
        dataitem(DataItem1; Table17)
        {
            DataItemTableView = WHERE (Source Type=CONST(Employee));
            RequestFilterFields = "G/L Account No.", "Source Type", "Source No.", "G/L Account Name", "Employee Transaction Type", "Global Dimension 1 Code", "Global Dimension 2 Code";
            column(DocumentNo_GLEntry; "G/L Entry"."Document No.")
            {
            }
            column(GLAccountNo_GLEntry; "G/L Entry"."G/L Account No.")
            {
            }
            column(GLAccountName_GLEntry; "G/L Entry"."G/L Account Name")
            {
            }
            column(Description_GLEntry; "G/L Entry".Description)
            {
            }
            column(DebitAmount_GLEntry; "G/L Entry"."Debit Amount")
            {
            }
            column(CreditAmount_GLEntry; "G/L Entry"."Credit Amount")
            {
            }
            column(Amount_GLEntry; "G/L Entry".Amount)
            {
            }
            column(Summary; Summary)
            {
            }
            column(ReportName; ReportName)
            {
            }
            column(PostingDate_GLEntry; FORMAT("G/L Entry"."Posting Date"))
            {
            }
            column(GlobalDimension1Code_GLEntry; "G/L Entry"."Global Dimension 1 Code")
            {
            }
            column(ActivityName; ActivityName)
            {
            }
            column(GlobalDimension2Code_GLEntry; "G/L Entry"."Global Dimension 2 Code")
            {
            }

            trigger OnAfterGetRecord()
            begin


                ActivityName := '';
                DimVal.RESET;
                DimVal.SETRANGE("Dimension Code", GLSetup."Global Dimension 2 Code");
                DimVal.SETRANGE(Code, "G/L Entry"."Global Dimension 2 Code");
                IF DimVal.FINDFIRST THEN
                    ActivityName := DimVal.Name;
            end;

            trigger OnPreDataItem()
            begin
                IF Summary THEN
                    ReportName := 'Employee Advance Summary'
                ELSE
                    ReportName := 'Employee Advance Detail';
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Employee Name"; EmployeeName)
                {
                    TableRelation = Employee;
                    Visible = false;
                }
                field(Summary; Summary)
                {
                    Caption = 'Summary';
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
        GLSetup.GET;
        EmployeeName := "G/L Entry".GETFILTER("Source No.");
    end;

    var
        GLEntry: Record "17";
        EmployeeName: Text;
        Summary: Boolean;
        ReportName: Text;
        ActivityName: Text;
        DimVal: Record "349";
        GLSetup: Record "98";
}

