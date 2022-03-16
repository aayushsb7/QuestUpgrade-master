report 50030 "PDC create journal"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1; Table50013)
        {
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("Journal Template"; "Journal Template Name")
                    {
                        ShowMandatory = true;
                        TableRelation = "Gen. Journal Template".Name;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            CLEAR(TemplateSecurityPage);
                            TemplateSecurityRec.RESET;
                            IF UserSetUp.GET(USERID) THEN
                                TemplateSecurityRec.SETRANGE("User ID", USERID);
                            TemplateSecurityRec.SETRANGE("Table Name", TemplateSecurityRec."Table Name"::"General Journal");
                            //IF JournalBatchRec.FINDFIRST THEN
                            TemplateSecurityPage.SETTABLEVIEW(TemplateSecurityRec);
                            TemplateSecurityPage.SETRECORD(TemplateSecurityRec);
                            //journalbatchpage.EDITABLE(TRUE);
                            TemplateSecurityPage.LOOKUPMODE(TRUE);
                            IF TemplateSecurityPage.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                TemplateSecurityPage.GETRECORD(TemplateSecurityRec);
                                //if journalbatchrec.findfirst then
                                //message(journalbatchrec.name);
                                "Journal Template Name" := TemplateSecurityRec."Template Name";
                            END;
                        end;
                    }
                    field("Journal Batch"; "Journal Batch Name")
                    {
                        ShowMandatory = true;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            IF "Journal Template Name" <> '' THEN BEGIN
                                /*
                                CLEAR(JournalBatchPage);
                                JournalBatchRec.RESET;
                                JournalBatchRec.SETRANGE("Journal Template Name", "Journal Template Name");
                                //IF JournalBatchRec.FINDFIRST THEN
                                JournalBatchPage.SETTABLEVIEW(JournalBatchRec);
                                JournalBatchPage.SETRECORD(JournalBatchRec);
                                //journalbatchpage.EDITABLE(TRUE);
                                JournalBatchPage.LOOKUPMODE(TRUE);
                                IF JournalBatchPage.RUNMODAL =ACTION::LookupOK THEN BEGIN
                                  JournalBatchPage.GETRECORD(JournalBatchRec);
                                  //if journalbatchrec.findfirst then
                                  //message(journalbatchrec.name);
                            
                                  "Journal Batch Name" := JournalBatchRec.Name;
                                  END;
                                  */

                                CLEAR(TemplateSecurityPage);
                                TemplateSecurityRec.RESET;
                                IF UserSetUp.GET(USERID) THEN
                                    TemplateSecurityRec.SETRANGE("User ID", USERID);
                                TemplateSecurityRec.SETRANGE("Table Name", TemplateSecurityRec."Table Name"::"General Journal");
                                TemplateSecurityRec.SETRANGE("Template Name", "Journal Template Name");
                                //IF JournalBatchRec.FINDFIRST THEN
                                TemplateSecurityPage.SETTABLEVIEW(TemplateSecurityRec);
                                TemplateSecurityPage.SETRECORD(TemplateSecurityRec);
                                //journalbatchpage.EDITABLE(TRUE);
                                TemplateSecurityPage.LOOKUPMODE(TRUE);
                                IF TemplateSecurityPage.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                    TemplateSecurityPage.GETRECORD(TemplateSecurityRec);
                                    //if journalbatchrec.findfirst then
                                    //message(journalbatchrec.name);
                                    "Journal Batch Name" := TemplateSecurityRec."Batch Name";
                                END;



                            END;

                        end;
                    }
                    field("Bank Account No."; BankAccNo)
                    {
                        ShowMandatory = true;
                        TableRelation = "Bank Account";
                    }
                }
                group(Information)
                {
                    field("Entry No."; PDCRec."Entry No.")
                    {
                        Editable = false;
                    }
                    field("Posting Date"; PDCRec."Posting Date")
                    {
                        Editable = false;
                    }
                    field(Type; PDCRec.Type)
                    {
                        Editable = false;
                    }
                    field("Cheque No."; PDCRec."Cheque No.")
                    {
                        Editable = false;
                    }
                    field("Cheque Date"; PDCRec."Cheque Date")
                    {
                        Editable = false;
                    }
                    field("Drawn Date"; PDCRec."Drawn On")
                    {
                        Editable = false;
                    }
                    field("Bank Name"; PDCRec."Customer Bank Name")
                    {
                        Editable = false;
                    }
                    field("Customer No."; PDCRec."Bill-To/Pay-To No.")
                    {
                        Editable = false;
                    }
                    field("Customer Name"; PDCRec."Bill-To/Pay-To Name")
                    {
                        Editable = false;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            //"Journal Template Name" := 'CASHRCPT';
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        GenJnlTemplateRec: Record "80";
    begin
        IF ("Journal Batch Name" = '') OR ("Journal Template Name" = '') OR (BankAccNo = '') THEN
            ERROR('Insert Mandatory Fields');


        PDCRec.GET(EntryNo1);
        PDCRec.SETRANGE("Entry No.", EntryNo1);

        IF ("Journal Batch Name" = '') THEN
            ERROR('Select Journal Batch.');

        /*
        GenJournalRec2.RESET;
        GenJournalRec2.SETRANGE(GenJournalRec2."Journal Template Name", "Journal Template Name");
        GenJournalRec2.SETRANGE(GenJournalRec2."Journal Batch Name", "Journal Batch Name");
        IF GenJournalRec2.FINDLAST THEN BEGIN
          TempLineNo := GenJournalRec2."Line No." +10000;
          DocumentNo := INCSTR(GenJournalRec2."Document No.");
          END
        ELSE BEGIN
          TempLineNo := 10000;
          DocumentNo := '';
          END;
        */
        //GenJournalRec.RESET;
        GenJournalRec.INIT;
        /*
        GenJournalRec."Line No." := TempLineNo;
        GenJournalRec."Journal Template Name" := "Journal Template Name";
        GenJournalRec."Journal Batch Name" := "Journal Batch Name";
        */
        GenJournalRec."Posting Date" := WORKDATE;
        IF PDCRec.Type = PDCRec.Type::Receipt THEN BEGIN

            GenJournalRec.VALIDATE("Account Type", GenJournalRec."Account Type"::"Bank Account");

            GenJournalRec.VALIDATE("Account No.", BankAccNo);
            GenJournalRec.VALIDATE("Bal. Account Type", GenJournalRec."Bal. Account Type"::Customer);

            GenJournalRec.VALIDATE("Bal. Account No.", PDCRec."Bill-To/Pay-To No.");

        END
        ELSE
            IF PDCRec.Type = PDCRec.Type::Payment THEN BEGIN

                GenJournalRec.VALIDATE("Account Type", GenJournalRec."Account Type"::Vendor);

                GenJournalRec.VALIDATE("Account No.", PDCRec."Bill-To/Pay-To No.");

                GenJournalRec.VALIDATE("Bal. Account Type", GenJournalRec."Bal. Account Type"::"Bank Account");

                GenJournalRec.VALIDATE("Bal. Account No.", BankAccNo);
            END;

        GenJournalRec.VALIDATE("Document Type", GenJournalRec."Document Type"::Payment);
        //genjournalrec.validate

        GenJournalRec.VALIDATE("Sell-to/Buy-from No.", PDCRec."Sell-To/Buy-From No.");
        GenJournalRec.VALIDATE("Bill-to/Pay-to No.", PDCRec."Bill-To/Pay-To No.");
        //GenJournalRec.VALIDATE(Description, PDCRec."Sell-To/Buy-From Name");
        GenJournalRec.VALIDATE(Amount, PDCRec.Amount);
        GenJournalRec.VALIDATE("External Document No.", PDCRec."Cheque No.");
        GenJournalRec.Narration := 'System Created Entry of PDC Entry No. ' + FORMAT(PDCRec."Entry No.");

        //GenJournalRec."Cheque No." := PDCRec."Cheque No.";
        //GenJournalRec."Cheque Date" := PDCRec."Cheque Date";
        //GenJournalRec.Narration := PDCRec.Narration;
        /*
        IF DocumentNo <> '' THEN
          GenJournalRec."Document No." := DocumentNo
        ELSE
          BEGIN
        
            CLEAR(NoSeriesMgt);
            GenJnlBatchRec.RESET;
            GenJnlBatchRec.SETRANGE("Journal Template Name", "Journal Template Name");
            GenJnlBatchRec.SETRANGE(Name, "Journal Batch Name");
            GenJnlBatchRec.SETFILTER("No. Series", '<>%1', '');
            IF GenJnlBatchRec.FINDFIRST THEN
              GenJournalRec."Document No." := NoSeriesMgt.TryGetNextNo(GenJnlBatchRec."No. Series",GenJournalRec."Posting Date");
          END;
        GenJournalRec.INSERT(TRUE);
        */
        CLEAR(NoSeriesMgt);
        GenJnlBatchRec.RESET;
        GenJnlBatchRec.SETRANGE("Journal Template Name", "Journal Template Name");
        GenJnlBatchRec.SETRANGE(Name, "Journal Batch Name");
        GenJnlBatchRec.SETFILTER("Posting No. Series", '<>%1', '');
        IF GenJnlBatchRec.FINDFIRST THEN BEGIN
            GenJournalRec."PDC Entry No." := PDCRec."Entry No.";
            GenJournalRec."Document No." := NoSeriesMgt.GetNextNo(GenJnlBatchRec."Posting No. Series", GenJournalRec."Posting Date", TRUE);
            //GenJournalRec.VALIDATE("Shortcut Dimension 1 Code",GenJnlBatchRec."Global Dimension 1 Code");
            GenJournalRec."Shortcut Dimension 2 Code" := PDCRec."Shortcut Dimension 2 Code";
            GenJournalRec."Shortcut Dimension 3 Code" := PDCRec."Shortcut Dimension 3 Code";
            GenJournalRec."Shortcut Dimension 4 Code" := PDCRec."Shortcut Dimension 4 Code";
            GenJournalRec."Shortcut Dimension 5 Code" := PDCRec."Shortcut Dimension 5 Code";
            GenJournalRec."Shortcut Dimension 6 Code" := PDCRec."Shortcut Dimension 6 Code";
            GenJournalRec."Shortcut Dimension 7 Code" := PDCRec."Shortcut Dimension 7 Code";
            GenJournalRec."Shortcut Dimension 8 Code" := PDCRec."Shortcut Dimension 8 Code";
            GenJournalRec."Dimension Set ID" := PDCRec."Dimension Set ID";
            IF GenJnlTemplateRec.GET(GenJnlBatchRec."Journal Template Name") THEN
                GenJournalRec."Source Code" := GenJnlTemplateRec."Source Code";
        END;
        GenJnlPost.RUN(GenJournalRec); //CP
                                       //COMMIT;

        PDCRec.Remarks := PDCRec.Remarks::Deposit;
        PDCRec.Status := PDCRec.Status::Closed;
        PDCRec."Drawn On" := WORKDATE;
        PDCRec.MODIFY;

        //CLEAR(CRJ);

        //CRJ.SETRECORD(GenJournalRec);
        //CRJ.SETTABLEVIEW(GenJournalRec);
        //CRJ.RUN;
        //MESSAGE('Journal Lines have been Created.');

        MESSAGE('Journal Lines have been Posted.');

    end;

    var
        "Journal Template Name": Code[20];
        "Journal Batch Name": Code[20];
        EntryNo1: Integer;
        PDCRec: Record "50014";
        GenJournalRec: Record "81";
        GenJournalRec2: Record "81";
        TempLineNo: Integer;
        CRJ: Page "255";
        JournalBatchPage: Page "251";
        JournalBatchRec: Record "232";
        BankAccNo: Code[20];
        NoSeriesMgt: Codeunit "396";
        GenJnlBatchRec: Record "232";
        DocumentNo: Code[20];
        GenJnlPost: Codeunit "12";
        TemplateSecurityRec: Record "50003";
        TemplateSecurityPage: Page "50005";
        UserSetUp: Record "91";

    [Scope('Internal')]
    procedure GetPDCRec(EntryNo: Integer)
    begin
        EntryNo1 := EntryNo;

        PDCRec.GET(EntryNo1);

        //PDCrec := PDCRec;
        //.SETRANGE("SNo.", EntryNo1);
    end;
}

