page 50013 "PDC Journal"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "PDC Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                }
                field("Posting Date"; "Posting Date")
                {
                }
                field(Type; Type)
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
                field("Customer Bank Account"; "Customer Bank Account")
                {
                }
                field("Customer Bank Name"; "Customer Bank Name")
                {
                }
                field("Cheque No."; "Cheque No.")
                {
                }
                field("Cheque Date"; "Cheque Date")
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
                    Visible = false;
                }
                field(Narration; Narration)
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
        area(navigation)
        {
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        //ReportPrint.PrintGenJnlLine(Rec);
                    end;
                }
                action(Post)
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        IF NOT DIALOG.CONFIRM('Do you want to post the PDC lines?', FALSE) THEN
                            EXIT;



                        IF (Rec.FINDFIRST) THEN BEGIN
                            PDCEntryRec.LOCKTABLE;
                            IF (PDCEntryRec.FINDLAST) THEN
                                //PDCEntryRec.NEXT := PDCEntryRec."Entry No." + 1
                                EntryNo := PDCEntryRec."Entry No." + 1
                            ELSE
                                //PDCEntryRec.NEXT := 1;
                                EntryNo := 1;

                            REPEAT

                                Rec.TESTFIELD("Posting Date");
                                Rec.TESTFIELD("Cheque No.");
                                Rec.TESTFIELD("Cheque Date");
                                Rec.TESTFIELD("Customer Bank Account");
                                Rec.TESTFIELD("Bill-To/Pay-To No.");
                                Rec.TESTFIELD(Amount);
                                Rec.TESTFIELD("Shortcut Dimension 1 Code");

                                PDCEntryRec.INIT;
                                PDCEntryRec."Entry No." := EntryNo;
                                EntryNo += 1;

                                // pdcentryrec.
                                PDCEntryRec."Posting Date" := Rec."Posting Date";
                                PDCEntryRec.Type := Rec.Type;
                                PDCEntryRec."Cheque No." := Rec."Cheque No.";
                                PDCEntryRec."Cheque Date" := Rec."Cheque Date";

                                PDCEntryRec."Customer Bank Name" := Rec."Customer Bank Name";
                                PDCEntryRec."Customer Bank Account" := Rec."Customer Bank Account";
                                PDCEntryRec."Drawn On" := Rec."Drawn On";
                                PDCEntryRec."Bill-To/Pay-To Type" := Rec."Bill-To/Pay-To Type";
                                PDCEntryRec."Bill-To/Pay-To No." := Rec."Bill-To/Pay-To No.";
                                PDCEntryRec."Bill-To/Pay-To Name" := Rec."Bill-To/Pay-To Name";

                                PDCEntryRec."Sell-To/Buy-From Type" := Rec."Sell-To/Buy-From Type";
                                PDCEntryRec."Sell-To/Buy-From No." := Rec."Sell-To/Buy-From No.";
                                PDCEntryRec."Sell-To/Buy-From Name" := Rec."Sell-To/Buy-From Name";


                                PDCEntryRec.Amount := Rec.Amount;
                                PDCEntryRec.Remarks := Rec.Remarks;
                                PDCEntryRec.Narration := Rec.Narration;

                                PDCEntryRec."User Id" := Rec."User Id";
                                PDCEntryRec."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
                                PDCEntryRec."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                                PDCEntryRec."Shortcut Dimension 3 Code" := Rec."Shortcut Dimension 3 Code";
                                PDCEntryRec."Shortcut Dimension 4 Code" := Rec."Shortcut Dimension 4 Code";
                                PDCEntryRec."Shortcut Dimension 5 Code" := Rec."Shortcut Dimension 5 Code";
                                PDCEntryRec."Shortcut Dimension 6 Code" := Rec."Shortcut Dimension 6 Code";
                                PDCEntryRec."Shortcut Dimension 7 Code" := Rec."Shortcut Dimension 7 Code";
                                PDCEntryRec."Shortcut Dimension 8 Code" := Rec."Shortcut Dimension 8 Code";
                                PDCEntryRec."Dimension Set ID" := Rec."Dimension Set ID";

                                PDCEntryRec.INSERT;

                                Rec.DELETE;
                            UNTIL (Rec.NEXT = 0)
                        END;
                        COMMIT;
                        MESSAGE('The journal lines were successfully posted.');
                        //CurrPage.UPDATE(FALSE);

                        /*CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",Rec);
                        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                         */

                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post+Print",Rec);
                        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                        */

                    end;
                }
            }
        }
    }

    var
        PDCEntryRec: Record "PDC Entries";
        PDCEntryRec2: Record "PDC Entries";
        EntryNo: Integer;
        MyDialog: Dialog;
}

