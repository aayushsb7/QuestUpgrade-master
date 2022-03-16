page 50025 "Loan Account List"
{
    CardPageID = "Loan Account Card";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Bank Statement Service';
    SourceTable = "Bank Account";
    SourceTableView = WHERE(Type = CONST(Loan));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the bank account.';
                }
                field(Name; Name)
                {
                    Caption = 'Loan No.';
                }
                field("Loan Type"; "Loan Type")
                {
                }
                field("Issuing Bank"; "Issuing Bank")
                {
                }
                field("Issuing Bank Name"; "Issuing Bank Name")
                {
                }
                field("Start Date"; "Start Date")
                {
                }
                field("End Date"; "End Date")
                {
                }
                field("Time in Years"; "Time in Years")
                {
                }
                field("Loan Amount"; "Loan Amount")
                {
                }
                field("Interest Rate"; "Interest Rate")
                {
                }
                field(Blocked; Blocked)
                {
                }
                field(OnlineFeedStatementStatus; OnlineFeedStatementStatus)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Account Linking Status';
                    Editable = false;
                    ToolTip = 'Specifies if the bank account is linked to an online bank account through the bank statement service.';
                    Visible = ShowBankLinkingActions;
                }
                field("Total Installment Line"; TotalInstallentLines)
                {
                }
            }
        }
        area(factboxes)
        {
            // part(; 9083)
            // {
            //     SubPageLink = "Table ID"=CONST(270),
            //                  " No."=FIELD("No.");
            //                           Visible = false;
            // }
            // systempart(; Links)
            // {
            //     Visible = false;
            // }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Bank Acc.")
            {
                Caption = '&Bank Acc.';
                Image = Bank;
                action(Statistics)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Bank Account Statistics";
                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Bank Account"),
                                  "No." = FIELD("No.");
                    ToolTip = 'Create a comment attached to the selected bank account.';
                }
                action(PositivePayExport)
                {
                    ApplicationArea = Suite;
                    Caption = 'Positive Pay Export';
                    Image = Export;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Positive Pay Export";
                    RunPageLink = "No." = FIELD("No.");
                    ToolTip = 'Export a Positive Pay file with relevant payment information that you then send to the bank for reference when you process payments to make sure that your bank only clears validated checks and amounts.';
                    Visible = false;
                }
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    action("Dimensions-Single")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Dimensions-Single';
                        Image = Dimensions;
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID" = CONST(270),
                                     "No." = FIELD("No.");
                        ShortCutKey = 'Shift+Ctrl+D';
                        ToolTip = 'View or edit the single set of dimensions that are set up for the selected record.';
                    }
                    action("Dimensions-&Multiple")
                    {
                        AccessByPermission = TableData 348 = R;
                        ApplicationArea = Suite;
                        Caption = 'Dimensions-&Multiple';
                        Image = DimensionSets;
                        ToolTip = 'View or edit dimensions for a group of records. You can assign dimension codes to transactions to distribute costs and analyze historical information.';

                        trigger OnAction()
                        var
                            BankAcc: Record "Bank Account";
                            DefaultDimMultiple: Page "Default Dimensions-Multiple";
                        begin
                            CurrPage.SETSELECTIONFILTER(BankAcc);
                            //DefaultDimMultiple.SetMultiBankAcc(BankAcc);
                            DefaultDimMultiple.RUNMODAL;
                        end;
                    }
                }
                action(Balance)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Balance';
                    Image = Balance;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Bank Account Balance";
                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ToolTip = 'View a summary of the bank account balance at different periods.';
                }
                action(Statements)
                {
                    Caption = 'St&atements';
                    Image = List;
                    RunObject = Page "Bank Account Statement List";
                    RunPageLink = "Bank Account No." = FIELD("No.");
                    ToolTip = 'View posted bank statements and reconciliations.';
                }
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    Image = BankAccountLedger;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Electronic Document Format";
                    RunPageLink = "Bank Account No." = FIELD("No.");
                    RunPageView = SORTING("Bank Account No.")
                                  ORDER(Descending);
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View the history of transactions that have been posted for the selected record.';
                }
                action("Chec&k Ledger Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Chec&k Ledger Entries';
                    Image = CheckLedger;
                    RunObject = Page "Check Ledger Entries";
                    RunPageLink = "Bank Account No." = FIELD("No.");
                    RunPageView = SORTING("Bank Account No.")
                                  ORDER(Descending);
                    ToolTip = 'View check ledger entries that result from posting transactions in a payment journal for the relevant bank account.';
                    Visible = false;
                }
                action("C&ontact")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'C&ontact';
                    Image = ContactPerson;
                    ToolTip = 'View or edit detailed information about the contact person at the customer.';
                    Visible = false;

                    trigger OnAction()
                    begin
                        ShowContact;
                    end;
                }
                action(CreateNewLinkedBankAccount)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create New Linked Bank Account';
                    Image = NewBank;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Create a new online bank account to link to the selected bank account.';
                    Visible = ShowBankLinkingActions;

                    trigger OnAction()
                    var
                        BankAccount: Record "Bank Account";
                    begin
                        BankAccount.INIT;
                        BankAccount.LinkStatementProvider(BankAccount);
                    end;
                }
                action(LinkToOnlineBankAccount)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Link to Online Bank Account';
                    Enabled = NOT Linked;
                    Image = LinkAccount;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Create a link to an online bank account from the selected bank account.';
                    Visible = ShowBankLinkingActions;

                    trigger OnAction()
                    begin
                        VerifySingleSelection;
                        LinkStatementProvider(Rec);
                    end;
                }
                action(UnlinkOnlineBankAccount)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Unlink Online Bank Account';
                    Enabled = Linked;
                    Image = UnLinkAccount;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Remove a link to an online bank account from the selected bank account.';
                    Visible = ShowBankLinkingActions;

                    trigger OnAction()
                    begin
                        VerifySingleSelection;
                        UnlinkStatementProvider;
                        CurrPage.UPDATE(TRUE);
                    end;
                }
                action(UpdateBankAccountLinking)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Update Bank Account Linking';
                    Image = MapAccounts;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Link any non-linked bank accounts to their related bank accounts.';
                    Visible = ShowBankLinkingActions;

                    trigger OnAction()
                    begin
                        UpdateBankAccountLinking;
                    end;
                }
                action(AutomaticBankStatementImportSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Automatic Bank Statement Import Setup';
                    Enabled = Linked;
                    Image = ElectronicBanking;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Auto. Bank Stmt. Import Setup";
                    RunPageOnRec = true;
                    ToolTip = 'Set up the information for importing bank statement files.';
                    Visible = ShowBankLinkingActions;
                }
                action(PagePosPayEntries)
                {
                    ApplicationArea = Suite;
                    Caption = 'Positive Pay Entries';
                    Image = CheckLedger;
                    RunObject = Page "Positive Pay Entries";
                    RunPageLink = "Bank Account No." = FIELD("No.");
                    RunPageView = SORTING("Bank Account No.", "Upload Date-Time")
                                  ORDER(Descending);
                    ToolTip = 'View the bank ledger entries that are related to Positive Pay transactions.';
                    Visible = false;
                }
            }
        }
        area(reporting)
        {
            action("Detail Trial Balance")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Detail Trial Balance';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;
                ToolTip = 'View a detailed trial balance for selected checks.';

                trigger OnAction()
                begin
                    BankAcc.RESET;
                    BankAcc.SETRANGE("No.", "No.");
                    REPORT.RUNMODAL(50039, TRUE, FALSE, BankAcc);
                end;
            }
            action("Check Details")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Check Details';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Bank Account - Check Details";
                ToolTip = 'View a detailed trial balance for selected checks.';
            }
            action("Trial Balance by Period")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Trial Balance by Period';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;
                RunObject = Report "Trial Balance by Period";
                ToolTip = 'View a detailed trial balance for selected checks within a selected period.';
            }
            action("Trial Balance")
            {
                ApplicationArea = Suite;
                Caption = 'Trial Balance';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Trial Balance";
                ToolTip = 'View a detailed trial balance for the selected bank account.';
            }
            action("Bank Account Statements")
            {
                ApplicationArea = Suite;
                Caption = 'Bank Account Statements';
                Image = "Report";
                RunObject = Report "Bank Account Statement";
                ToolTip = 'View statements for selected bank accounts. For each bank transaction, the report shows a description, an applied amount, a statement amount, and other information.';
                Visible = false;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        GetOnlineFeedStatementStatus(OnlineFeedStatementStatus, Linked);
        ShowBankLinkingActions := StatementProvidersExist;
        //SRT Dec 7th 2019 >>
        LoanRepaymentSchedule.RESET;
        LoanRepaymentSchedule.SETRANGE("Loan Account No.", "No.");
        IF LoanRepaymentSchedule.FINDFIRST THEN
            TotalInstallentLines := LoanRepaymentSchedule.COUNT
        ELSE
            TotalInstallentLines := 0;
        //SRT Dec 7th 2019 <<
    end;

    trigger OnAfterGetRecord()
    begin
        CALCFIELDS("Check Report Name");
        GetOnlineFeedStatementStatus(OnlineFeedStatementStatus, Linked);
        //SRT Dec 7th 2019 >>
        LoanRepaymentSchedule.RESET;
        LoanRepaymentSchedule.SETRANGE("Loan Account No.", "No.");
        IF LoanRepaymentSchedule.FINDFIRST THEN
            TotalInstallentLines := LoanRepaymentSchedule.COUNT
        ELSE
            TotalInstallentLines := 0;
        //SRT Dec 7th 2019 <<
    end;

    trigger OnOpenPage()
    begin
        ShowBankLinkingActions := StatementProvidersExist;
    end;

    var
        MultiselectNotSupportedErr: Label 'You can only link to one online bank account at a time.';
        Linked: Boolean;
        ShowBankLinkingActions: Boolean;
        OnlineFeedStatementStatus: Option "Not Linked",Linked,"Linked and Auto. Bank Statement Enabled";
        BankAcc: Record "Bank Account";
        TotalInstallentLines: Integer;
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";

    local procedure VerifySingleSelection()
    var
        BankAccount: Record "Bank Account";
    begin
        CurrPage.SETSELECTIONFILTER(BankAccount);

        IF BankAccount.COUNT > 1 THEN
            ERROR(MultiselectNotSupportedErr);
    end;
}

