report 50028 "SubLedger Vs GL Account"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SubLedgerVsGLAccount.rdlc';
    Caption = 'SubLedger Vs GL Account';

    dataset
    {
        dataitem(DataItem1; Table17)
        {
            RequestFilterFields = "G/L Account No.", "Posting Date", "Global Dimension 1 Code", "Global Dimension 2 Code", "Shortcut Dimension 3 Code", "Shortcut Dimension 4 Code", "Sys. LC No.", "TR Loan Code";
            column(Posting_Date; "Posting Date")
            {
            }
            column(Entry_No_; "Entry No.")
            {
            }
            column(Document_No_; "Document No.")
            {
            }
            column(Debit_Amount; "Debit Amount")
            {
            }
            column(Credit_Amount; "Credit Amount")
            {
            }
            column(GL_Account_No_; "G/L Account No.")
            {
            }
            column(GL_Account_Name; "G/L Account Name")
            {
            }
            column(Amount; Amount)
            {
            }
            column(Employee; "Shortcut Dimension 3 Code")
            {
            }
            column(SalesPerson; "Shortcut Dimension 4 Code")
            {
            }
            column(Branch; "Global Dimension 1 Code")
            {
            }
            column(ProductSegment; "Global Dimension 2 Code")
            {
            }
            column(TRLoan; "TR Loan Code")
            {
            }
            column(LC; "Bank LC No.")
            {
            }
            column(SysLCNo; "Sys. LC No.")
            {
            }
            column(Narration; Narration)
            {
            }
            column(SubLedger; SubLedger)
            {
            }
            column(SubLedgerName; SubLedgerName)
            {
            }
            column(SubLedgerCaption; SubLedgerCaption)
            {
            }
            column(DocumentTotal; DocumentTotal)
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(ReportFilter; STRSUBSTNO('%1: %2', TABLECAPTION, GLEntryFilter))
            {
            }
            column(GLEntryFilter; GLEntryFilter)
            {
            }
            column(Group1Caption; Group1Caption)
            {
            }
            column(Group1Value; Group1Value)
            {
            }
            column(Group1ValueName; Group1ValueName)
            {
            }
            column(Group2Caption; Group2Caption)
            {
            }
            column(Group2Value; Group2Value)
            {
            }
            column(Group2ValueName; Group2ValueName)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Branch THEN BEGIN
                    IF "Global Dimension 1 Code" = '' THEN
                        CurrReport.SKIP;
                    SubLedger := "Global Dimension 1 Code";
                END;

                IF ProductSegment THEN BEGIN
                    IF "Global Dimension 2 Code" = '' THEN
                        CurrReport.SKIP;
                    SubLedger := "Global Dimension 2 Code";
                END;

                IF Employee THEN BEGIN
                    IF "Shortcut Dimension 3 Code" = '' THEN
                        CurrReport.SKIP;
                    SubLedger := "Shortcut Dimension 3 Code";
                    DimensionValue.RESET;
                    GenLedSetup.GET;
                    DimensionValue.SETRANGE("Dimension Code", GenLedSetup."Shortcut Dimension 3 Code");
                    DimensionValue.SETRANGE(Code, SubLedger);
                    IF DimensionValue.FINDFIRST THEN
                        SubLedgerName := '(' + DimensionValue.Name + ')';
                END;

                IF SalesPerson THEN BEGIN
                    IF "Shortcut Dimension 4 Code" = '' THEN
                        CurrReport.SKIP;
                    SubLedger := "Shortcut Dimension 4 Code";
                    DimensionValue.RESET;
                    GenLedSetup.GET;
                    DimensionValue.SETRANGE("Dimension Code", GenLedSetup."Shortcut Dimension 4 Code");
                    DimensionValue.SETRANGE(Code, SubLedger);
                    IF DimensionValue.FINDFIRST THEN
                        SubLedgerName := '(' + DimensionValue.Name + ')';
                END;

                IF LC THEN BEGIN
                    IF "Sys. LC No." = '' THEN
                        CurrReport.SKIP;
                    SubLedger := "Sys. LC No.";
                    IF LCDetails.GET(SubLedger) THEN
                        SubLedgerName := '(' + LCDetails."LC\DO No." + ')';
                END;

                IF TRLoan THEN BEGIN
                    IF "TR Loan Code" = '' THEN
                        CurrReport.SKIP;
                    SubLedger := "TR Loan Code";
                END;

                IF FirstGLSecondSubLedger THEN BEGIN
                    Group1Value := "G/L Account No.";
                    Group1ValueName := "G/L Account Name";
                    Group2Value := SubLedger;
                    Group2ValueName := SubLedgerName;
                END;

                IF FirstSubLedgerSecondGL THEN BEGIN
                    Group1Value := SubLedger;
                    Group1ValueName := SubLedgerName;
                    Group2Value := "G/L Account No.";
                    Group2ValueName := "G/L Account Name";
                END
            end;

            trigger OnPreDataItem()
            begin
                IF (NOT FirstGLSecondSubLedger) AND (NOT FirstSubLedgerSecondGL) THEN
                    ERROR(Text1008);

                IF (NOT Branch) AND (NOT ProductSegment) AND (NOT Employee) AND (NOT SalesPerson) AND (NOT LC)
                AND (NOT TRLoan) THEN
                    ERROR(Text1001);

                IF Branch THEN
                    SubLedgerCaption := Text1002;

                IF ProductSegment THEN
                    SubLedgerCaption := Text1003;

                IF Employee THEN
                    SubLedgerCaption := Text1004;

                IF SalesPerson THEN
                    SubLedgerCaption := Text1005;

                IF LC THEN
                    SubLedgerCaption := Text1006;

                IF TRLoan THEN
                    SubLedgerCaption := Text1007;

                IF FirstGLSecondSubLedger THEN BEGIN
                    Group1Caption := GLCode;
                    Group2Caption := SubLedgerCaption;
                END;

                IF FirstSubLedgerSecondGL THEN BEGIN
                    Group1Caption := SubLedgerCaption;
                    Group2Caption := GLCode;
                END
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Grouping Type")
                {
                    Caption = 'Grouping Type';
                    field("First GL Second SubLedger"; FirstGLSecondSubLedger)
                    {
                        Caption = 'First GL Second SubLedger';

                        trigger OnValidate()
                        begin
                            FirstSubLedgerSecondGL := FALSE;
                        end;
                    }
                    field("First SubLedger Second GL"; FirstSubLedgerSecondGL)
                    {
                        Caption = 'First SubLedger Second GL';

                        trigger OnValidate()
                        begin
                            FirstGLSecondSubLedger := FALSE;
                        end;
                    }
                }
                group("Sub Ledger Selection")
                {
                    Caption = 'Sub Ledger Selection';
                    field(Branch; Branch)
                    {
                        Caption = 'Branch';

                        trigger OnValidate()
                        begin
                            ProductSegment := FALSE;
                            Employee := FALSE;
                            SalesPerson := FALSE;
                            LC := FALSE;
                            TRLoan := FALSE;
                        end;
                    }
                    field(ProductSegment; ProductSegment)
                    {
                        Caption = 'ProductSegment';

                        trigger OnValidate()
                        begin
                            Branch := FALSE;
                            Employee := FALSE;
                            SalesPerson := FALSE;
                            LC := FALSE;
                            TRLoan := FALSE;
                        end;
                    }
                    field(Employee; Employee)
                    {
                        Caption = 'Employee';

                        trigger OnValidate()
                        begin
                            Branch := FALSE;
                            ProductSegment := FALSE;
                            SalesPerson := FALSE;
                            LC := FALSE;
                            TRLoan := FALSE;
                        end;
                    }
                    field(SalesPerson; SalesPerson)
                    {
                        Caption = 'SalesPerson';

                        trigger OnValidate()
                        begin
                            Branch := FALSE;
                            ProductSegment := FALSE;
                            Employee := FALSE;
                            LC := FALSE;
                            TRLoan := FALSE;
                        end;
                    }
                    field(LC; LC)
                    {
                        Caption = 'LC';

                        trigger OnValidate()
                        begin
                            Branch := FALSE;
                            ProductSegment := FALSE;
                            Employee := FALSE;
                            SalesPerson := FALSE;
                            TRLoan := FALSE;
                        end;
                    }
                    field(TRLoan; TRLoan)
                    {
                        Caption = 'TRLoan';

                        trigger OnValidate()
                        begin
                            Branch := FALSE;
                            ProductSegment := FALSE;
                            Employee := FALSE;
                            SalesPerson := FALSE;
                            LC := FALSE;
                        end;
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
        GLEntryFilter := "G/L Entry".GETFILTERS;
    end;

    var
        SubLedger: Code[100];
        SubLedgerName: Text[250];
        FirstGLSecondSubLedger: Boolean;
        FirstSubLedgerSecondGL: Boolean;
        Branch: Boolean;
        ProductSegment: Boolean;
        Employee: Boolean;
        SalesPerson: Boolean;
        LC: Boolean;
        TRLoan: Boolean;
        Text1001: Label 'You have to select at least one Sub Ledger to run this report!!!';
        Text1002: Label 'Branch';
        Text1003: Label 'Product Segment';
        Text1004: Label 'Employee';
        Text1005: Label 'SalesPerson';
        Text1006: Label 'LC';
        Text1007: Label 'TR Loan';
        SubLedgerCaption: Text[250];
        DocumentTotal: Text[250];
        GLEntryFilter: Text;
        Text1008: Label 'You have to select at least one Grouping Type to run this report!!!';
        GLCode: Label 'GL Account';
        Group1Caption: Text[250];
        Group1Value: Code[100];
        Group1ValueName: Text[100];
        Group2Caption: Text[250];
        Group2Value: Code[100];
        Group2ValueName: Text[100];
        DimensionValue: Record "349";
        LCDetails: Record "50008";
        GenLedSetup: Record "98";
}

