page 50014 "PDC Entries"
{
    Editable = false;
    PageType = List;
    SourceTable = "PDC Entries";

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
                field(Type; Type)
                {
                }
                field("Cheque No."; "Cheque No.")
                {
                }
                field("Cheque Date"; "Cheque Date")
                {
                }
                field("Drawn On"; "Drawn On")
                {
                }
                field("Customer Bank Account"; "Customer Bank Account")
                {
                }
                field("Customer Bank Name"; "Customer Bank Name")
                {
                }
                field("Sell-To/Buy-From Type"; "Sell-To/Buy-From Type")
                {
                }
                field("Sell-To/Buy-From No."; "Sell-To/Buy-From No.")
                {
                }
                field("Sell-To/Buy-From Name"; "Sell-To/Buy-From Name")
                {
                }
                field("Bill-To/Pay-To Type"; "Bill-To/Pay-To Type")
                {
                }
                field("Bill-To/Pay-To No."; "Bill-To/Pay-To No.")
                {
                }
                field("Bill-To/Pay-To Name"; "Bill-To/Pay-To Name")
                {
                }
                field(Amount; Amount)
                {
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                }
                field(Remarks; Remarks)
                {
                }
                field(Narration; Narration)
                {
                }
                field(Status; Status)
                {
                }
                field("Incorrect Entry"; "Incorrect Entry")
                {
                }
                field("User Id"; "User Id")
                {
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                }
                field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code")
                {
                }
                field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code")
                {
                }
                field("Shortcut Dimension 5 Code"; "Shortcut Dimension 5 Code")
                {
                }
                field("Shortcut Dimension 6 Code"; "Shortcut Dimension 6 Code")
                {
                }
                field("Shortcut Dimension 7 Code"; "Shortcut Dimension 7 Code")
                {
                }
                field("Shortcut Dimension 8 Code"; "Shortcut Dimension 8 Code")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(Process)
                {
                    Image = CopyFromTask;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ReversalEntry: Record "Reversal Entry";
                    begin
                        IF Status = Status::Closed THEN
                            ERROR('This document is closed.');

                        OptionNumber := DIALOG.STRMENU('Deposit Cheque,Cancel Cheque', 0, 'Select action');
                        IF OptionNumber = 1 THEN BEGIN
                            "PDC Create Journal Report".GetPDCRec("Entry No.");

                            "PDC Create Journal Report".RUN;
                            CLEAR("PDC Create Journal Report");
                        END
                        ELSE
                            IF OptionNumber = 2 THEN BEGIN
                                Remarks := Remarks::Cancel;
                                Status := Status::Closed;
                                MODIFY;


                            END;

                        //REPORT.RUN(50005, TRUE, TRUE, Rec);
                    end;
                }
                action("Incorrect Entry")
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        IF "Entry No." = 0 THEN
                            ERROR('Record not selected');

                        IF Status = Status::Closed THEN
                            ERROR('This document is closed.');

                        IF "Incorrect Entry" THEN
                            ERROR('This document is already marked as incorrect entry.');



                        IF NOT DIALOG.CONFIRM('Do you want to mark Entry No. %1 as incorrect entry?', FALSE, "Entry No.") THEN
                            EXIT;

                        Rec."Incorrect Entry" := TRUE;
                        Rec.Status := Status::Closed;
                        Rec.MODIFY;

                        MESSAGE('Entry No. %1 has been marked as incorrect entry.', "Entry No.");
                    end;
                }
                action(Reverse)
                {
                    Image = ReverseLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        "Journal Template Name": Code[20];
                        "Journal Batch Name": Code[20];
                        PDCRec: Record "PDC Entries";
                        GenJournalRec: Record "Gen. Journal Line";
                    begin
                        ReversePDC(Rec);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        SETRANGE("Date Filter", 0D, WORKDATE);
        //setrange("cheque date", 0d, workdate);
    end;

    var
        "PDC Create Journal Report": Report "PDC create journal";
        PDCReport: Report "PDC create journal";
        OptionNumber: Integer;
        ReverseConfirm: Boolean;
        PDCEntryRec: Record "PDC Entries";
        GLEntryRec: Record "G/L Entry";
        GlEntry: Record "G/L Entry";
}

