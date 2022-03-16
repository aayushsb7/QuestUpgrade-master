page 50026 "Loan Account Card"
{
    Caption = 'Loan Account Card';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Bank Statement Service,Bank Account';
    SourceTable = "Bank Account";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the number of the bank account.';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Loan No."; Name)
                {
                    Caption = 'Loan No.';
                }
                field("Issuing Bank"; "Issuing Bank")
                {

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Issuing Bank Name"; "Issuing Bank Name")
                {
                }
                field("Bank Acc. Posting Group"; "Bank Acc. Posting Group")
                {
                    Caption = 'Loan Account Posting Group';
                }
                field("Loan Type"; "Loan Type")
                {
                    OptionCaption = ' ,Short Term Loan,Hire Purchase Loan,Long Term Loan,Equipment Loan,>';
                }
                field("Start Date"; "Start Date")
                {
                }
                field("End Date"; "End Date")
                {
                }
                field("Time in Years"; "Time in Years")
                {
                    Visible = false;
                }
                field("Search Name"; "Search Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a search name for the bank account.';
                    Visible = false;
                }
                field("Loan Amount"; "Loan Amount")
                {
                }
                field("Interest Rate"; "Interest Rate")
                {
                }
                field("Interest Charge"; "Interest Charge")
                {
                    Visible = false;
                }
                field(Released; Released)
                {
                    Editable = false;
                }
                field(Blocked; Blocked)
                {
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the date when the Bank Account card was last modified.';
                }
            }
            group("Loan Amount Information")
            {
                field("Repayment Amount"; "Repayment Amount")
                {
                }
                field("Disbursement Amount"; "Disbursement Amount")
                {
                }
                field("Interest Amount"; "Interest Amount")
                {
                    Enabled = false;
                }
                field(LCPayment; LCPayment)
                {
                    Caption = 'LC Payment';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        BankAccLedgerEntry.RESET;
                        BankAccLedgerEntry.SETRANGE("Sys. Loan No.", "No.");
                        PAGE.RUN(372, BankAccLedgerEntry);
                    end;
                }
            }
            part("Repayment Schedule"; "Bank Repayment Schedule")
            {
                SubPageLink = "Loan Account No." = FIELD("No.");
            }
        }
        area(factboxes)
        {
            // systempart(; Links)
            // {
            //     Visible = false;
            // }
            // systempart(; Notes)
            // {
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
                    RunObject = Page 375;
                    RunPageLink = "No." = FIELD("No."),
                                 "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                    Visible = false;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Bank Account"),
                                  "No." = FIELD("No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = Suite;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedOnly = true;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(270),
                                 "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                }
                action(Balance)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Balance';
                    Image = Balance;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedOnly = true;
                    RunObject = Page "Bank Account Balance";
                    RunPageLink = "No." = FIELD("No."),
                                 "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                 "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ToolTip = 'View a summary of the bank account balance at different periods.';
                }
                action(Statements)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'St&atements';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Bank Account Statement List";
                    RunPageLink = "Bank Account No." = FIELD("No.");
                    ToolTip = 'View posted bank statements and reconciliations.';
                }
                action("Ledger E&ntries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ledger E&ntries';
                    Image = BankAccountLedger;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Bank Account Ledger Entries";
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
                    ApplicationArea = All;
                    Caption = 'C&ontact';
                    Image = ContactPerson;
                    ToolTip = 'Open the list of business contacts.';
                    Visible = false;

                    trigger OnAction()
                    begin
                        ShowContact;
                    end;
                }
                // separator()
                // {
                // }
                action("Online Map")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Online Map';
                    Image = Map;
                    ToolTip = 'View the address on an online map.';
                    Visible = false;

                    trigger OnAction()
                    begin
                        DisplayMap;
                    end;
                }
                action(PagePositivePayEntries)
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
            action(BankAccountReconciliations)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Payment Reconciliation Journals';
                Image = BankAccountRec;
                RunObject = Page "Pmt. Reconciliation Journals";
                RunPageLink = "Bank Account No." = FIELD("No.");
                RunPageView = SORTING("Bank Account No.");
                ToolTip = 'Reconcile your bank account by importing transactions and applying them, automatically or manually, to open customer ledger entries, open vendor ledger entries, or open bank account ledger entries.';
                Visible = false;
            }
            action("Receivables-Payables Lines")
            {
                Caption = 'Receivables-Payables';
                Image = ReceivablesPayables;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Receivables-Payables Lines";
                ToolTip = 'View a summary of receivables for customers and payables for vendors.';
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
                    UnlinkStatementProvider;
                    CurrPage.UPDATE(TRUE);
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
        }
        area(processing)
        {
            action("Cash Receipt Journals")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cash Receipt Journals';
                Image = Journals;
                RunObject = Page "Cash Receipt Journal";
                ToolTip = 'Create a cash receipt journal line for the bank account, for example, to post a payment receipt.';
                Visible = false;
            }
            action("Payment Journals")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Payment Journals';
                Image = Journals;
                RunObject = Page "Payment Journal";
                ToolTip = 'Create a payment journal line for the bank account, for example, to post a payment.';
                Visible = false;
            }
            action(PagePosPayExport)
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
        }
        area(reporting)
        {
            action(List)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;
                RunObject = Report "Bank Account - List";
                ToolTip = 'View a list of general information about bank accounts, such as posting group, currency code, minimum balance, and balance.';
            }
            action("Detail Trial Balance")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Detail Trial Balance';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;
                RunObject = Report "Loan Acc. - Detail Trial Bal.";
                ToolTip = 'View a detailed trial balance for selected checks.';
            }
            action("Receivables-Payables")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Receivables-Payables';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Receivables-Payables";
                ToolTip = 'View a summary of receivables for customers and payables for vendors.';
            }
            action("Check Details")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Check Details';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;
                RunObject = Report "Bank Account - Check Details";
                ToolTip = 'View a detailed trial balance for selected checks.';
            }
            action(Release)
            {
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    LoanReleased;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        GetOnlineFeedStatementStatus(OnlineFeedStatementStatus, Linked);
        ShowBankLinkingActions := StatementProvidersExist;
    end;

    trigger OnAfterGetRecord()
    begin
        GetOnlineFeedStatementStatus(OnlineFeedStatementStatus, Linked);
        CALCFIELDS("Check Report Name");


        GLEntry.RESET;
        GLEntry.SETRANGE("Sys. Loan No.", "No.");
        //GLEntry.SETRANGE("Loan Transaction Type",GLEntry."Loan Transaction Type"::"Loan Disbursement");
        GLEntry.SETFILTER("Sys. LC No.", '<>%1', '');
        GLEntry.CALCSUMS("Amount (LCY)");
        LCPayment := -(GLEntry."Amount (LCY)");
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Type := Type::Loan;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := Type::Loan;
    end;

    trigger OnOpenPage()
    var
        Contact: Record Contact;
    begin
        ContactActionVisible := Contact.READPERMISSION;
    end;

    var
        Text001: Label 'There may be a statement using the %1.\\Do you want to change Balance Last Statement?';
        Text002: Label 'Canceled.';
        [InDataSet]
        ContactActionVisible: Boolean;
        Linked: Boolean;
        OnlineBankAccountLinkingErr: Label 'You must link the bank account to an online bank account.\\Choose the Link to Online Bank Account action.';
        ShowBankLinkingActions: Boolean;
        OnlineFeedStatementStatus: Option "Not Linked",Linked,"Linked and Auto. Bank Statement Enabled";
        LCPayment: Decimal;
        GLEntry: Record "G/L Entry";
        BankAccLedgerEntry: Record "Bank Account Ledger Entry";
}

