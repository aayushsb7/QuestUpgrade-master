page 50048 "Closed TDS Entries"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Original TDS Entry";
    SourceTableView = WHERE(Closed = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                }
                field("Posting Date"; "Posting Date")
                {
                }
                field("Document No."; "Document No.")
                {
                }
                field("Main G/L Account"; "Main G/L Account")
                {
                }
                field("Main G/L Account Name"; "Main G/L Account Name")
                {
                }
                field("Source Type"; "Source Type")
                {
                }
                field("Bill-to/Pay-to No."; "Bill-to/Pay-to No.")
                {
                }
                field("TDS Posting Group"; "TDS Posting Group")
                {
                }
                field("GL Account"; "GL Account")
                {
                }
                field("GL Account Name"; "GL Account Name")
                {
                    Visible = true;
                }
                field("TDS%"; "TDS%")
                {
                }
                field(Narration; Narration)
                {
                }
                field("Original Base"; "Original Base")
                {
                }
                field("Original TDS Amount"; "Original TDS Amount")
                {
                }
                field("User ID"; "User ID")
                {
                    Visible = false;
                }
                field("Source Code"; "Source Code")
                {
                    Visible = false;
                }
                field("Transaction No."; "Transaction No.")
                {
                    Visible = false;
                }
                field("External Document No."; "External Document No.")
                {
                }
                field("Document Date"; "Document Date")
                {
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                }
                field("TDS Type"; "TDS Type")
                {
                }
                field(Closed; Closed)
                {
                }
                field("IRD Voucher No."; "IRD Voucher No.")
                {
                    Visible = false;
                }
                field("IRD Voucher Date"; "IRD Voucher Date")
                {
                    Visible = false;
                }
                field("Fiscal Year"; "Fiscal Year")
                {
                    Visible = false;
                }
                field("Reversed Entry No."; "Reversed Entry No.")
                {
                    Visible = false;
                }
                field(Reversed; Reversed)
                {
                    Visible = false;
                }
                field("Reversed by Entry No."; "Reversed by Entry No.")
                {
                    Visible = false;
                }
                field("Vendor Name"; "Vendor Name")
                {
                    Visible = false;
                }
                field("Bank Account No."; "Bank Account No.")
                {
                    Visible = false;
                }
                field("Payment Done"; "Payment Done")
                {
                    Visible = false;
                }
                field("G/L Entry No."; "G/L Entry No.")
                {
                    Visible = false;
                }
                field("Payment Transaction No."; "Payment Transaction No.")
                {
                    Visible = false;
                }
            }
            group(General1)
            {
                fixed(Geeral2)
                {
                    group(Balance)
                    {
                        Caption = 'Balance';
                        field(TDS; TDSBalance + "Original TDS Amount" - xRec."Original TDS Amount")
                        {
                            AutoFormatType = 1;
                            Caption = 'TDS';
                            Editable = false;
                            Visible = TDSBalanceVisible;
                        }
                        field("TDS Base"; BaseBalance + "Original Base" - xRec."Original Base")
                        {
                            Caption = 'TDS Base';
                        }
                    }
                    group("Total Balance")
                    {
                        Caption = 'Total Balance';
                        field("Total TDS"; TotalTDSBalance + "Original TDS Amount" - xRec."Original TDS Amount")
                        {
                            AutoFormatType = 1;
                            Caption = 'Total TDS';
                            Editable = false;
                            Visible = TotalTDSBalanceVisible;
                        }
                        field("Total TDS Base"; TotalBaseBalance + "Original Base" - xRec."Original Base")
                        {
                            Caption = 'Total TDS Base';
                        }
                    }
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(General3)
            {
                action("Payment Entries")
                {
                    Image = LedgerEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "TDS Ledger Entries";
                    RunPageLink = "TDS Entry No." = FIELD("Entry No.");
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateBalance;
    end;

    trigger OnInit()
    begin
        TotalTDSBalanceVisible := TRUE; //TDS1.00
        TDSBalanceVisible := TRUE; //TDS1.00
        TotalBaseBalanceVisible := TRUE; //TDS1.00
        BaseBalanceVisible := TRUE; //TDS1.00
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UpdateBalance;
    end;

    var
        Filters: Text[100];
        TDSentry: Record "Original TDS Entry";
        TDSBalance: Decimal;
        TotalTDSBalance: Decimal;
        ShowTDSBalance: Boolean;
        ShowTotalTDSBalance: Boolean;
        [InDataSet]
        TDSBalanceVisible: Boolean;
        [InDataSet]
        TotalTDSBalanceVisible: Boolean;
        GenJnlManagement: Codeunit GenJnlManagement;
        BaseBalance: Decimal;
        TotalBaseBalance: Decimal;
        ShowBaseBalance: Boolean;
        ShowTotalBaseBalance: Boolean;
        [InDataSet]
        BaseBalanceVisible: Boolean;
        [InDataSet]
        TotalBaseBalanceVisible: Boolean;
        BankPageBuilder: FilterPageBuilder;
        BankAccount: Record "Bank Account";
        PaymentAlreadyDone: Label 'Payment has already been done for Document No. %1 Entry No. %2.';
        ReverseHasAlreadyDone: Label 'Document No. %1 has already been reversed.';
        TDSPaymentDone: Label 'The payment for selected TDS Entries has been posted.';
        TDSReversed: Label 'The reversal of payment for selected TDS Entries has been posted.';
        TemplateSecurity: Record "Template Security";
        TotalBankAmt: Decimal;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        GLSetup: Record "General Ledger Setup";

    local procedure UpdateBalance()
    begin
        GenJnlManagement.CalcTDSEntryTDSBalance(Rec, xRec, TDSBalance, TotalTDSBalance, ShowTDSBalance, ShowTotalTDSBalance); //TDS1.00
        TDSBalanceVisible := ShowTDSBalance;  //TDS1.00
        TotalTDSBalanceVisible := ShowTotalTDSBalance; //TDS1.00
        GenJnlManagement.CalcTDSEntryBaseBalance(Rec, xRec, BaseBalance, TotalBaseBalance, ShowBaseBalance, ShowTotalBaseBalance); //TDS1.00
        BaseBalanceVisible := ShowBaseBalance;  //TDS1.00
        TotalBaseBalanceVisible := ShowTotalBaseBalance; //TDS1.00
    end;
}

