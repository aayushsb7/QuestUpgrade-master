report 50064 "Employee Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './EmployeeDetails.rdlc';

    dataset
    {
        dataitem(DataItem15; Table5200)
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.", "Date Filter", "Employee Transaction Type";
            column(No_Employee; Employee."No.")
            {
            }
            column(DateFilter_Employee; Employee."Date Filter")
            {
            }
            column(FirstName_Employee; Employee."First Name")
            {
            }
            column(OpeningBal; OpeningBal)
            {
            }
            column(DateFilters; DateFilters)
            {
            }
            column(DebitAmount; DebitAmount)
            {
            }
            column(CreditAmount; CreditAmount)
            {
            }
            column(Summary; Summary)
            {
            }
            dataitem(EmployeeTransactionType; Table17)
            {
                DataItemLink = Source No.=FIELD(No.),
                               Employee Transaction Type=FIELD(Employee Transaction Type);
                PrintOnlyIfDetail = false;
                UseTemporary = true;
                column(EmployeeTransactionType_EmployeeTransactionType;EmployeeTransactionType."Employee Transaction Type")
                {
                }
                column(EmployeeTransactionTypeOpening;EmployeeTransactionTypeOpening)
                {
                }
                dataitem(EmployeeTransactionTypeWiseGL;Table17)
                {
                    DataItemLink = Source No.=FIELD(Source No.),
                                   Employee Transaction Type=FIELD(Employee Transaction Type);
                    PrintOnlyIfDetail = false;
                    UseTemporary = true;
                    column(GLAccountNo_EmployeeTransactionTypeWiseGL;EmployeeTransactionTypeWiseGL."G/L Account No.")
                    {
                    }
                    column(GLAccountName_EmployeeTransactionTypeWiseGL;EmployeeTransactionTypeWiseGL."G/L Account Name")
                    {
                    }
                    column(EmployeeTransactionTypeWiseGLOpening;EmployeeTransactionTypeWiseGLOpening)
                    {
                    }
                    dataitem(EmployeeTransactionGLDetails;Table17)
                    {
                        DataItemLink = Source No.=FIELD(Source No.),
                                       Employee Transaction Type=FIELD(Employee Transaction Type),
                                       G/L Account No.=FIELD(G/L Account No.);
                        DataItemTableView = WHERE(Source Type=CONST(Employee));
                        PrintOnlyIfDetail = false;
                        column(DocumentNo_GLEntry;"Document No.")
                        {
                        }
                        column(GLAccountNo_GLEntry;"G/L Account No.")
                        {
                        }
                        column(GLAccountName_GLEntry;"G/L Account Name")
                        {
                        }
                        column(Description_GLEntry;Description)
                        {
                        }
                        column(DebitAmount_GLEntry;"Debit Amount")
                        {
                        }
                        column(CreditAmount_GLEntry;"Credit Amount")
                        {
                        }
                        column(Amount_GLEntry;Amount)
                        {
                        }
                        column(ReportName;ReportName)
                        {
                        }
                        column(PostingDate_GLEntry;FORMAT("Posting Date" ))
                        {
                        }
                        column(GlobalDimension1Code_GLEntry;"Global Dimension 1 Code")
                        {
                        }
                        column(ActivityName;ActivityName)
                        {
                        }
                        column(GlobalDimension2Code_GLEntry;"Global Dimension 2 Code")
                        {
                        }
                        column(ClosingBal;ClosingBal)
                        {
                        }
                        column(SourceName_GLEntry;"Source Name")
                        {
                        }
                        column(EmployeeTransactionTypeRunningBalance;EmployeeTransactionTypeRunningBalance)
                        {
                        }
                        column(EmployeeTransactionTypeWiseGLRunningBalance;EmployeeTransactionTypeWiseGLRunningBalance)
                        {
                        }
                        column(EmployeeTransactionType_GLEntry;EmployeeTransactionGLDetails."Employee Transaction Type")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            ActivityName := '';
                            IF DimVal.GET(GLSetup."Global Dimension 2 Code",EmployeeTransactionGLDetails."Global Dimension 2 Code") THEN
                              ActivityName := DimVal.Name
                            ELSE
                              ActivityName := '';


                            EmployeeTransactionTypeRunningBalance += EmployeeTransactionGLDetails.Amount;
                            EmployeeTransactionTypeWiseGLRunningBalance += EmployeeTransactionGLDetails.Amount;

                            DebitAmount += EmployeeTransactionGLDetails."Debit Amount";
                            CreditAmount += EmployeeTransactionGLDetails."Credit Amount";
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF Summary THEN
                              ReportName := 'Employee Advance Summary'
                            ELSE
                              ReportName := 'Employee Advance Detail';

                            EmployeeTransactionGLDetails.SETRANGE("Source No.",Employee."No.");
                            EmployeeTransactionGLDetails.SETRANGE("Employee Transaction Type",EmployeeTransactionTypeWiseGL."Employee Transaction Type");
                            EmployeeTransactionGLDetails.SETRANGE("G/L Account No.",EmployeeTransactionTypeWiseGL."G/L Account No.");
                            //EmployeeTransactionGLDetails.SETRANGE("Posting Date",Employee."Date Filter");
                            EmployeeTransactionGLDetails.SETFILTER("Posting Date",DateFilters);
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        GLEntry.RESET;
                        GLEntry.SETRANGE("Source Type",GLEntry."Source Type"::Employee);
                        GLEntry.SETRANGE("Source No.",Employee."No.");
                        GLEntry.SETRANGE("Employee Transaction Type",EmployeeTransactionType."Employee Transaction Type");
                        GLEntry.SETRANGE("G/L Account No.",EmployeeTransactionTypeWiseGL."G/L Account No.");
                        IF NOT GLEntry.FINDFIRST THEN
                          CurrReport.SKIP;

                        GLEntry.RESET;
                        GLEntry.SETRANGE("Source Type",GLEntry."Source Type"::Employee);
                        GLEntry.SETRANGE("Source No.",Employee."No.");
                        GLEntry.SETRANGE("Employee Transaction Type",EmployeeTransactionType."Employee Transaction Type");
                        GLEntry.SETRANGE("G/L Account No.",EmployeeTransactionTypeWiseGL."G/L Account No.");
                        GLEntry.SETRANGE("Posting Date",0D,Employee.GETRANGEMIN("Date Filter") - 1);
                        GLEntry.CALCSUMS(Amount);
                        EmployeeTransactionTypeWiseGLOpening := GLEntry.Amount;
                        EmployeeTransactionTypeWiseGLRunningBalance := EmployeeTransactionTypeWiseGLOpening;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    GLEntry.RESET;
                    GLEntry.SETRANGE("Source Type",GLEntry."Source Type"::Employee);
                    GLEntry.SETRANGE("Source No.",Employee."No.");
                    GLEntry.SETRANGE("Employee Transaction Type",EmployeeTransactionType."Employee Transaction Type");
                    IF NOT GLEntry.FINDFIRST THEN
                      CurrReport.SKIP;

                    IF EmployeePostingGroup.GET(Employee."Employee Posting Group") THEN;
                    GLAccount.RESET;
                    GLAccount.SETFILTER("No.",'%1|%2|%3',
                                        EmployeePostingGroup."Salary Advance Account",
                                        EmployeePostingGroup."Expense Advance Account",
                                        EmployeePostingGroup."Other Advance Account");
                    IF GLAccount.FINDFIRST THEN REPEAT
                      EmployeeTransactionTypeWiseGL.INIT;
                      EmployeeTransactionTypeWiseGL."G/L Account No." := GLAccount."No.";
                      EmployeeTransactionTypeWiseGL."Employee Transaction Type" := EmployeeTransactionType."Employee Transaction Type";
                      EmployeeTransactionTypeWiseGL."Source Type" := EmployeeTransactionTypeWiseGL."Source Type"::Employee;
                      EmployeeTransactionTypeWiseGL."Source No." := EmployeeTransactionType."Source No.";
                      EmployeeTransactionTypeWiseGL."Entry No." := Entryno1;
                      EmployeeTransactionTypeWiseGL.INSERT;
                      Entryno1 += 1;
                    UNTIL GLAccount.NEXT = 0;


                    //EmployeeTransactionTypeOpening Calculation
                    GLEntry.RESET;
                    GLEntry.SETRANGE("Source Type",GLEntry."Source Type"::Employee);
                    GLEntry.SETRANGE("Source No.",Employee."No.");
                    GLEntry.SETRANGE("Employee Transaction Type",EmployeeTransactionType."Employee Transaction Type");
                    GLEntry.SETRANGE("Posting Date",0D,Employee.GETRANGEMIN("Date Filter") - 1);
                    GLEntry.CALCSUMS(Amount);
                    EmployeeTransactionTypeOpening := GLEntry.Amount;
                    EmployeeTransactionTypeRunningBalance := EmployeeTransactionTypeOpening;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                OpeningBal := 0;
                IF DateFilters <> '' THEN BEGIN
                  GLEntry.RESET;
                  GLEntry.SETRANGE("Source Type",GLEntry."Source Type"::Employee);
                  GLEntry.SETRANGE("Source No.",Employee."No.");
                  GLEntry.SETRANGE("Posting Date",0D,Employee.GETRANGEMIN("Date Filter") - 1);
                  GLEntry.CALCSUMS(Amount);
                  OpeningBal := GLEntry.Amount;
                END;
                EmployeeTransactionType.RESET;
                EmployeeTransactionType.SETRANGE("Source No.",Employee."No.");
                IF NOT EmployeeTransactionType.FINDFIRST THEN BEGIN
                  EmployeeTransactionType.INIT;
                  EmployeeTransactionType."Employee Transaction Type" := EmployeeTransactionType."Employee Transaction Type"::"Expense Advance";
                  EmployeeTransactionType."Source Type" := EmployeeTransactionType."Source Type"::Employee;
                  EmployeeTransactionType."Source No." := Employee."No.";
                  EmployeeTransactionType."Entry No." := Entryno;
                  EmployeeTransactionType.INSERT;
                  Entryno += 1;

                  EmployeeTransactionType.INIT;
                  EmployeeTransactionType."Employee Transaction Type" := EmployeeTransactionType."Employee Transaction Type"::"Salary Advance";
                  EmployeeTransactionType."Source Type" := EmployeeTransactionType."Source Type"::Employee;
                  EmployeeTransactionType."Source No." := Employee."No.";
                  EmployeeTransactionType."Entry No." := Entryno;
                  EmployeeTransactionType.INSERT;
                  Entryno += 1;

                  EmployeeTransactionType.INIT;
                  EmployeeTransactionType."Employee Transaction Type" := EmployeeTransactionType."Employee Transaction Type"::Other;
                  EmployeeTransactionType."Source Type" := EmployeeTransactionType."Source Type"::Employee;
                  EmployeeTransactionType."Source No." := Employee."No.";
                  EmployeeTransactionType."Entry No." := Entryno;
                  EmployeeTransactionType.INSERT;
                  Entryno += 1;
                END;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field("Employee Name";EmployeeName)
                {
                    TableRelation = Employee;
                    Visible = false;
                }
                field(Summary;Summary)
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
        DateFilters := Employee.GETFILTER("Date Filter");

        EmployeeTransactionType.RESET;
        IF EmployeeTransactionType.FINDLAST THEN
          Entryno := EmployeeTransactionType."Entry No." + 1
        ELSE
          Entryno := 1;


        EmployeeTransactionTypeWiseGL.RESET;
        IF EmployeeTransactionTypeWiseGL.FINDLAST THEN
          Entryno1 := EmployeeTransactionTypeWiseGL."Entry No." + 1
        ELSE
          Entryno1 := 1;
    end;

    var
        GLEntry: Record "17";
        EmployeeName: Text;
        Summary: Boolean;
        ReportName: Text;
        ActivityName: Text;
        DimVal: Record "349";
        GLSetup: Record "98";
        OpeningBal: Decimal;
        EmployeeLedgerEntry: Record "5222";
        ClosingBal: Decimal;
        TotalDebitAmt: Decimal;
        TotalCreditAmt: Decimal;
        DateFilters: Text;
        Entryno: Integer;
        GLAccount: Record "15";
        EmployeeTransactionTypeOpening: Decimal;
        EmployeeTransactionTypeRunningBalance: Decimal;
        EmployeeTransactionTypeWiseGLRunningBalance: Decimal;
        EmployeeTransactionTypeWiseGLOpening: Decimal;
        Entryno1: Integer;
        EmployeePostingGroup: Record "5221";
        DebitAmount: Decimal;
        CreditAmount: Decimal;
}

