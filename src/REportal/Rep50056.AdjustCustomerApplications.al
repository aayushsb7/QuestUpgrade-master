report 50056 "Adjust Customer Applications"
{
    Permissions = TableData 21 = rm;
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1; Table18)
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                counttotal += 1;
                ProgressWindow.UPDATE(3, counttotal);
                ProgressWindow.UPDATE(4, Customer."No.");
                IF UnApplyOnly THEN BEGIN
                    StartUnApply(Customer);
                END
                ELSE BEGIN
                    //StartUnApply(Customer);
                    //ReDoApplyPrepayment(Customer);
                    IF ApplyExactAmt THEN
                        ReDoApplyJournalWithExactMatchAmount(Customer);
                    IF ApplyInvoices THEN
                        ReDoApply(Customer);
                    IF ApplyRemaining THEN
                        ReDoApplyRemainingCustomerLedger(Customer);
                END;
                ProgressWindow.UPDATE(2, counttotal);
            end;

            trigger OnPreDataItem()
            begin
                //IF Customer.GETFILTER("No.") = '' THEN
                //ERROR(Text000);
                ProgressWindow.OPEN(Text001);
                ProgressWindow.UPDATE(1, Customer.COUNT);
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
                group(Options)
                {
                    field("Unapply only"; UnApplyOnly)
                    {
                    }
                    field(ApplyExactAmt; ApplyExactAmt)
                    {
                        Caption = 'Apply Exact Amount';
                    }
                    field(ApplyInvoices; ApplyInvoices)
                    {
                        Caption = 'Apply Invoices';
                    }
                    field(ApplyRemaining; ApplyRemaining)
                    {
                        Caption = 'Apply Remaining Amount';
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
        Cust.RESET;
        Cust.SETRANGE("Application Method", Cust."Application Method"::Manual);
        Cust.MODIFYALL("Application Method", Cust."Application Method"::"Apply to Oldest");

        Cust.RESET;
        Cust.SETFILTER(Blocked, '<>%1', Cust.Blocked::" ");
        Cust.MODIFYALL(Blocked, Cust.Blocked::" ");
    end;

    var
        TempDtldCustLedgEntry: Record "379" temporary;
        DtldCustLedgEntry2: Record "379";
        CreateCustLedgEntry: Record "21";
        Cust: Record "18";
        DocNo: Code[20];
        PostingDate: Date;
        CustLedgEntryNo: Integer;
        Text000: Label 'You must select Customer.';
        UnApplyOnly: Boolean;
        ProgressWindow: Dialog;
        counttotal: Integer;
        Text001: Label 'Total Records: #1######\Processing Customer: #4##############\Processed : #2########\Modifying...#3#######################';
        ApplyExactAmt: Boolean;
        ApplyInvoices: Boolean;
        ApplyRemaining: Boolean;

    local procedure "--UnApply"()
    begin
    end;

    local procedure StartUnApply(Customer: Record "18")
    var
        CustLedgerEntry: Record "21";
        DtldCustLedgEntry: Record "379";
        ApplicationEntryNo: Integer;
    begin
        CLEAR(DocNo);
        CLEAR(PostingDate);
        CLEAR(CustLedgEntryNo);
        CLEAR(TempDtldCustLedgEntry);
        CLEAR(DtldCustLedgEntry2);
        CLEAR(CreateCustLedgEntry);
        CLEAR(Cust);
        WITH Customer DO BEGIN
            CustLedgerEntry.RESET;
            CustLedgerEntry.SETCURRENTKEY("Closed by Entry No.");
            //CustLedgerEntry.SETCURRENTKEY(CustLedgerEntry."Closed at Date");
            CustLedgerEntry.SETRANGE("Customer No.", "No.");
            IF CustLedgerEntry.FINDLAST THEN
                REPEAT
                    //IF (NOT CustLedgerEntry.Open) AND (NOT CustLedgerEntry.Reversed) AND (AdjustmentApplicable(CustLedgerEntry)) THEN BEGIN
                    IF (NOT CustLedgerEntry.Reversed) AND (AdjustmentApplicable(CustLedgerEntry)) THEN BEGIN
                        ApplicationEntryNo := FindLastApplEntry(CustLedgerEntry."Entry No.");
                        IF ApplicationEntryNo <> 0 THEN BEGIN
                            CLEAR(DtldCustLedgEntry);
                            CLEAR(DtldCustLedgEntry2);
                            DtldCustLedgEntry.GET(ApplicationEntryNo);
                            UnApplyCustomer(DtldCustLedgEntry);
                        END;
                    END;
                UNTIL CustLedgerEntry.NEXT(-1) = 0;
        END;
    end;

    local procedure FindLastApplEntry(CustLedgEntryNo: Integer): Integer
    var
        DtldCustLedgEntry: Record "379";
        ApplicationEntryNo: Integer;
    begin
        WITH DtldCustLedgEntry DO BEGIN
            SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type");
            SETRANGE("Cust. Ledger Entry No.", CustLedgEntryNo);
            SETRANGE("Entry Type", "Entry Type"::Application);
            SETRANGE(Unapplied, FALSE);
            ApplicationEntryNo := 0;
            IF FIND('-') THEN
                REPEAT
                    IF "Entry No." > ApplicationEntryNo THEN
                        ApplicationEntryNo := "Entry No.";
                UNTIL NEXT = 0;
        END;
        EXIT(ApplicationEntryNo);
    end;

    local procedure UnApplyCustomer(DtldCustLedgEntry: Record "379")
    begin
        WITH DtldCustLedgEntry DO BEGIN
            IF ("Entry Type" = "Entry Type"::Application) AND (Unapplied = FALSE) THEN BEGIN
                SetDtldCustLedgEntry("Entry No.");
                InsertEntries;
                Unapply;
            END;
        END;
    end;

    [Scope('Internal')]
    procedure SetDtldCustLedgEntry(EntryNo: Integer)
    begin
        DtldCustLedgEntry2.GET(EntryNo);
        CustLedgEntryNo := DtldCustLedgEntry2."Cust. Ledger Entry No.";
        PostingDate := DtldCustLedgEntry2."Posting Date";
        DocNo := DtldCustLedgEntry2."Document No.";
        Cust.GET(DtldCustLedgEntry2."Customer No.");
    end;

    local procedure InsertEntries()
    var
        DtldCustLedgEntry: Record "379";
    begin
        IF DtldCustLedgEntry2."Transaction No." = 0 THEN BEGIN
            DtldCustLedgEntry.SETCURRENTKEY("Application No.", "Customer No.", "Entry Type");
            DtldCustLedgEntry.SETRANGE("Application No.", DtldCustLedgEntry2."Application No.");
        END ELSE BEGIN
            DtldCustLedgEntry.SETCURRENTKEY("Transaction No.", "Customer No.", "Entry Type");
            DtldCustLedgEntry.SETRANGE("Transaction No.", DtldCustLedgEntry2."Transaction No.");
        END;
        DtldCustLedgEntry.SETRANGE("Customer No.", DtldCustLedgEntry2."Customer No.");
        TempDtldCustLedgEntry.RESET;
        TempDtldCustLedgEntry.DELETEALL;
        IF DtldCustLedgEntry.FINDSET THEN
            REPEAT
                IF (DtldCustLedgEntry."Entry Type" <> DtldCustLedgEntry."Entry Type"::"Initial Entry") AND
                   NOT DtldCustLedgEntry.Unapplied
                THEN BEGIN
                    TempDtldCustLedgEntry := DtldCustLedgEntry;
                    TempDtldCustLedgEntry.INSERT;
                END;
            UNTIL DtldCustLedgEntry.NEXT = 0;
    end;

    local procedure Unapply()
    var
        CustEntryApplyPostedEntries: Codeunit "226";
    begin
        IF TempDtldCustLedgEntry.ISEMPTY THEN
            EXIT;
        CLEAR(CustEntryApplyPostedEntries);
        CustEntryApplyPostedEntries.PostUnApplyCustomer(DtldCustLedgEntry2, DocNo, PostingDate);
        PostingDate := 0D;
        DocNo := '';
        TempDtldCustLedgEntry.DELETEALL;
    end;

    local procedure AdjustmentApplicable(CustLedgerEntry2: Record "21"): Boolean
    var
        CustLedgerEntry: Record "21";
    begin
        WITH CustLedgerEntry DO BEGIN
            RESET;

            IF CustLedgerEntry2."Entry No." <> 0 THEN BEGIN
                CreateCustLedgEntry := CustLedgerEntry2;

                FindApplnEntriesDtldtLedgEntry(CustLedgerEntry);
                SETCURRENTKEY("Entry No.");
                SETRANGE("Entry No.");

                IF CreateCustLedgEntry."Closed by Entry No." <> 0 THEN BEGIN
                    "Entry No." := CreateCustLedgEntry."Closed by Entry No.";
                    MARK(TRUE);
                END;

                SETCURRENTKEY("Closed by Entry No.");
                SETRANGE("Closed by Entry No.", CreateCustLedgEntry."Entry No.");
                IF FIND('-') THEN
                    REPEAT
                        MARK(TRUE);
                    UNTIL NEXT = 0;

                SETCURRENTKEY("Entry No.");
                SETRANGE("Closed by Entry No.");
            END;

            MARKEDONLY(TRUE);
            /*IF FINDSET THEN REPEAT
              IF (("Document Type" = "Document Type"::"Credit Memo") AND (CustLedgerEntry2."Document Type" = CustLedgerEntry2."Document Type"::Invoice)) OR
                (("Document Type" = "Document Type"::Invoice) AND (CustLedgerEntry2."Document Type" = CustLedgerEntry2."Document Type"::"Credit Memo")) THEN
                EXIT(FALSE);
            UNTIL NEXT = 0;
            */
            EXIT(TRUE);
        END;

    end;

    local procedure FindApplnEntriesDtldtLedgEntry(var CustLedgerEntry: Record "21")
    var
        DtldCustLedgEntry1: Record "379";
        DtldCustLedgEntry2: Record "379";
    begin
        WITH CustLedgerEntry DO BEGIN
            DtldCustLedgEntry1.SETCURRENTKEY("Cust. Ledger Entry No.");
            DtldCustLedgEntry1.SETRANGE("Cust. Ledger Entry No.", CreateCustLedgEntry."Entry No.");
            DtldCustLedgEntry1.SETRANGE(Unapplied, FALSE);
            IF DtldCustLedgEntry1.FIND('-') THEN
                REPEAT
                    IF DtldCustLedgEntry1."Cust. Ledger Entry No." =
                       DtldCustLedgEntry1."Applied Cust. Ledger Entry No."
                    THEN BEGIN
                        DtldCustLedgEntry2.INIT;
                        DtldCustLedgEntry2.SETCURRENTKEY("Applied Cust. Ledger Entry No.", "Entry Type");
                        DtldCustLedgEntry2.SETRANGE(
                          "Applied Cust. Ledger Entry No.", DtldCustLedgEntry1."Applied Cust. Ledger Entry No.");
                        DtldCustLedgEntry2.SETRANGE("Entry Type", DtldCustLedgEntry2."Entry Type"::Application);
                        DtldCustLedgEntry2.SETRANGE(Unapplied, FALSE);
                        IF DtldCustLedgEntry2.FIND('-') THEN
                            REPEAT
                                IF DtldCustLedgEntry2."Cust. Ledger Entry No." <>
                                   DtldCustLedgEntry2."Applied Cust. Ledger Entry No."
                                THEN BEGIN
                                    SETCURRENTKEY("Entry No.");
                                    SETRANGE("Entry No.", DtldCustLedgEntry2."Cust. Ledger Entry No.");
                                    IF FIND('-') THEN
                                        MARK(TRUE);
                                END;
                            UNTIL DtldCustLedgEntry2.NEXT = 0;
                    END ELSE BEGIN
                        SETCURRENTKEY("Entry No.");
                        SETRANGE("Entry No.", DtldCustLedgEntry1."Applied Cust. Ledger Entry No.");
                        IF FIND('-') THEN
                            MARK(TRUE);
                    END;
                UNTIL DtldCustLedgEntry1.NEXT = 0;
        END;
    end;

    local procedure "--Apply"()
    begin
    end;

    local procedure ReDoApplyPrepayment(Customer: Record "18")
    var
        CustLedgerEntry: Record "21";
        CustLedgerEntry2: Record "21";
        DtldCustLedgEntry: Record "379";
        ApplicationEntryNo: Integer;
        AmountToApply: Decimal;
        ApplyingAmount: Decimal;
    begin
        WITH Customer DO BEGIN
            CustLedgerEntry.RESET;
            CustLedgerEntry.SETRANGE("Customer No.", "No.");
            CustLedgerEntry.SETRANGE(Prepayment, TRUE);
            IF CustLedgerEntry.FINDFIRST THEN
                REPEAT
                    CustLedgerEntry.CALCFIELDS("Remaining Amount");
                    AmountToApply := CustLedgerEntry."Remaining Amount";
                    IF (CustLedgerEntry.Open) AND (CustLedgerEntry."Remaining Amount" > 0) THEN BEGIN
                        FindCustomerLedgerEntry(CustLedgerEntry2, CustLedgerEntry);
                        SetApplyCustomerEntry(CustLedgerEntry, CustLedgerEntry."Remaining Amount");
                        REPEAT
                            IF AmountToApply > 0 THEN BEGIN
                                CustLedgerEntry2.CALCFIELDS("Remaining Amount");
                                IF CustLedgerEntry2."Remaining Amount" < 0 THEN BEGIN
                                    CustLedgerEntry2.VALIDATE("Applies-to ID", USERID);
                                    IF AmountToApply >= ABS(CustLedgerEntry2."Remaining Amount") THEN
                                        CustLedgerEntry2.VALIDATE("Amount to Apply", CustLedgerEntry2."Remaining Amount")
                                    ELSE
                                        CustLedgerEntry2.VALIDATE("Amount to Apply", AmountToApply * -1);
                                    CustLedgerEntry2.MODIFY(TRUE);
                                    AmountToApply := AmountToApply - ABS(CustLedgerEntry2."Amount to Apply");
                                END;
                            END;
                        UNTIL CustLedgerEntry2.NEXT = 0;
                        IF AmountToApply <> CustLedgerEntry."Remaining Amount" THEN
                            PostCustLedgerApplication(CustLedgerEntry);
                    END;

                    IF (CustLedgerEntry.Open) AND (CustLedgerEntry."Remaining Amount" < 0) THEN BEGIN
                        FindCustomerLedgerEntry(CustLedgerEntry2, CustLedgerEntry);
                        SetApplyCustomerEntry(CustLedgerEntry, CustLedgerEntry."Remaining Amount");
                        REPEAT
                            IF AmountToApply < 0 THEN BEGIN
                                CustLedgerEntry2.CALCFIELDS("Remaining Amount");
                                IF CustLedgerEntry2."Remaining Amount" > 0 THEN BEGIN
                                    CustLedgerEntry2.VALIDATE("Applies-to ID", USERID);
                                    IF AmountToApply <= ABS(CustLedgerEntry2."Remaining Amount") THEN
                                        CustLedgerEntry2.VALIDATE("Amount to Apply", CustLedgerEntry2."Remaining Amount")
                                    ELSE
                                        CustLedgerEntry2.VALIDATE("Amount to Apply", AmountToApply * -1);
                                    CustLedgerEntry2.MODIFY(TRUE);
                                    AmountToApply := AmountToApply + ABS(CustLedgerEntry2."Amount to Apply");
                                END;
                            END;
                        UNTIL CustLedgerEntry2.NEXT = 0;
                        IF AmountToApply <> CustLedgerEntry."Remaining Amount" THEN
                            PostCustLedgerApplication(CustLedgerEntry);
                    END;
                UNTIL CustLedgerEntry.NEXT = 0;
        END;
    end;

    [Scope('Internal')]
    procedure SetApplyCustomerEntry(var CustLedgerEntry: Record "21"; AmountToApply: Decimal)
    var
        CustLedgerEntry2: Record "21";
        CustLedgerEntry3: Record "21";
    begin
        // Clear any existing applying entries.
        CustLedgerEntry2.SETRANGE("Applying Entry", TRUE);
        CustLedgerEntry2.SETFILTER("Entry No.", '<>%1', CustLedgerEntry."Entry No.");
        IF CustLedgerEntry2.FINDSET THEN
            REPEAT
                CustLedgerEntry3 := CustLedgerEntry2;
                CustLedgerEntry3.VALIDATE("Applying Entry", FALSE);
                CustLedgerEntry3."Amount to Apply" := 0;
                CustLedgerEntry3.MODIFY(TRUE);
            UNTIL CustLedgerEntry2.NEXT = 0;

        // Clear Applies-to IDs
        CustLedgerEntry2.RESET;
        CustLedgerEntry2.SETFILTER("Applies-to ID", '<>%1', '');
        CustLedgerEntry2.SETFILTER("Entry No.", '<>%1', CustLedgerEntry."Entry No.");
        IF CustLedgerEntry2.FINDSET THEN
            REPEAT
                CustLedgerEntry3 := CustLedgerEntry2;
                CustLedgerEntry3.VALIDATE("Applies-to ID", '');
                CustLedgerEntry3."Amount to Apply" := 0;
                CustLedgerEntry3.MODIFY(TRUE);
            UNTIL CustLedgerEntry2.NEXT = 0;

        // Apply Payment Entry on Posted Invoice.
        WITH CustLedgerEntry DO BEGIN
            VALIDATE("Applying Entry", TRUE);
            VALIDATE("Applies-to ID", USERID);
            VALIDATE("Amount to Apply", AmountToApply);
            MODIFY(TRUE);
        END;

        CODEUNIT.RUN(CODEUNIT::"Cust. Entry-Edit", CustLedgerEntry);
        COMMIT;
    end;

    [Scope('Internal')]
    procedure FindCustomerLedgerEntry(var CustLedgerEntry: Record "21"; ApplyingCustLedgerEntry: Record "21")
    var
        SalesCrMemoLine: Record "115";
    begin
        WITH CustLedgerEntry DO BEGIN
            IF ApplyingCustLedgerEntry.Prepayment THEN BEGIN
                RESET;
                SETCURRENTKEY("Posting Date");
                SETRANGE("Document No.", ApplyingCustLedgerEntry."Document No.");
                IF ApplyingCustLedgerEntry."Document Type" = ApplyingCustLedgerEntry."Document Type"::Invoice THEN
                    SETRANGE("Document Type", "Document Type"::Payment)
                ELSE
                    IF ApplyingCustLedgerEntry."Document Type" = ApplyingCustLedgerEntry."Document Type"::"Credit Memo" THEN
                        SETRANGE("Document Type", "Document Type"::Refund);
                SETRANGE("Customer No.", ApplyingCustLedgerEntry."Customer No.");
                SETRANGE("Shortcut Dimension 6 Code", ApplyingCustLedgerEntry."Shortcut Dimension 6 Code");
                SETRANGE(Open, TRUE);
                IF FINDFIRST THEN;
            END ELSE BEGIN
                RESET;
                SETCURRENTKEY("Posting Date");
                IF ApplyingCustLedgerEntry."Document Type" = ApplyingCustLedgerEntry."Document Type"::Invoice THEN
                    SETFILTER("Document Type", '%1|%2', "Document Type"::Payment, "Document Type"::" ")
                ELSE
                    IF ApplyingCustLedgerEntry."Document Type" = ApplyingCustLedgerEntry."Document Type"::"Credit Memo" THEN
                        SETFILTER("Document Type", '%1|%2', "Document Type"::Refund, "Document Type"::" ");
                SETRANGE("Customer No.", ApplyingCustLedgerEntry."Customer No.");
                SETRANGE("Shortcut Dimension 6 Code", ApplyingCustLedgerEntry."Shortcut Dimension 6 Code");
                SETRANGE(Open, TRUE);
                SETRANGE("Document No.", ApplyingCustLedgerEntry."Document No.");
                IF NOT FINDFIRST THEN BEGIN
                    SETRANGE("Document No.");
                    IF ApplyingCustLedgerEntry."Document Type" = ApplyingCustLedgerEntry."Document Type"::"Credit Memo" THEN BEGIN
                        SalesCrMemoLine.RESET;
                        SalesCrMemoLine.SETRANGE("Document No.", ApplyingCustLedgerEntry."Document No.");
                        SalesCrMemoLine.SETFILTER("No.", '<>%1', '');
                        SalesCrMemoLine.SETFILTER("Returned Document No.", '<>%1', '');
                        IF SalesCrMemoLine.FINDFIRST THEN BEGIN
                            SETRANGE("Document No.", SalesCrMemoLine."Returned Document No.");
                        END;
                    END;
                    IF FINDFIRST THEN;
                END;
            END;
        END;
    end;

    [Scope('Internal')]
    procedure FindRandomCustomerLedgerEntry(var CustLedgerEntry: Record "21"; ApplyingCustLedgerEntry: Record "21")
    begin
        WITH CustLedgerEntry DO BEGIN
            RESET;
            SETCURRENTKEY("Posting Date");
            SETFILTER("Remaining Amount", '>%1', 0);
            SETRANGE("Customer No.", ApplyingCustLedgerEntry."Customer No.");
            SETRANGE("Shortcut Dimension 6 Code", ApplyingCustLedgerEntry."Shortcut Dimension 6 Code");
            SETRANGE(Open, TRUE);
            IF FINDFIRST THEN;
        END;
    end;

    [Scope('Internal')]
    procedure FindExactCustomerLedgerEntry(var CustLedgerEntry: Record "21"; ApplyingCustLedgerEntry: Record "21")
    begin
        WITH CustLedgerEntry DO BEGIN
            RESET;
            SETCURRENTKEY("Posting Date");
            //SETRANGE("Document No.",ApplyingCustLedgerEntry."Document No.");
            SETRANGE("Remaining Amount", ApplyingCustLedgerEntry."Remaining Amount" * -1);
            SETRANGE("Customer No.", ApplyingCustLedgerEntry."Customer No.");
            SETRANGE("Shortcut Dimension 6 Code", ApplyingCustLedgerEntry."Shortcut Dimension 6 Code");
            SETRANGE(Open, TRUE);
            SETFILTER("Source Code", '<>SALES&<>SERVICE');
            IF FINDFIRST THEN;
        END;
    end;

    [Scope('Internal')]
    procedure SetAppliestoIdCustomer(var CustLedgerEntry: Record "21")
    begin
        // Set Applies-to ID.
        CustLedgerEntry.LOCKTABLE;
        IF CustLedgerEntry.FINDFIRST THEN
            REPEAT
                IF CustLedgerEntry.Open THEN BEGIN
                    IF CustLedgerEntry."Amount to Apply" = 0 THEN BEGIN
                        CustLedgerEntry.CALCFIELDS("Remaining Amount");
                        IF CustLedgerEntry."Remaining Amount" <> 0 THEN BEGIN
                            CustLedgerEntry.VALIDATE("Applies-to ID", USERID);
                            CustLedgerEntry.VALIDATE("Amount to Apply", CustLedgerEntry."Remaining Amount");
                            CustLedgerEntry.MODIFY(TRUE);
                        END;
                    END;
                END;
            UNTIL CustLedgerEntry.NEXT = 0;
    end;

    [Scope('Internal')]
    procedure PostCustLedgerApplication(var CustLedgerEntry: Record "21")
    begin
        // Post Application Entries.

        CODEUNIT.RUN(CODEUNIT::"CustEntry-Apply Posted Entries", CustLedgerEntry);
        COMMIT;
    end;

    local procedure "--Agile.17.01"()
    begin
    end;

    local procedure GetApplicationDimFilter(JnlDim2Code: Code[20]): Text
    var
        DimensionValue: Record "349";
        GLSetup: Record "98";
        Dim2FilterText: Text;
        DimCategory: Code[20];
    begin
        /*Dim2FilterText := '';
        IF JnlDim2Code = '' THEN
          EXIT;
        GLSetup.GET;
        IF DimensionValue.GET(GLSetup."Global Dimension 2 Code",JnlDim2Code) THEN BEGIN
          DimCategory := DimensionValue."Dimension Category";
          IF DimCategory <> '' THEN BEGIN
            DimensionValue.RESET;
            DimensionValue.SETRANGE("Dimension Code",GLSetup."Global Dimension 2 Code");
            DimensionValue.SETRANGE("Dimension Category",DimCategory);
            IF DimensionValue.FINDFIRST THEN REPEAT
              IF Dim2FilterText = '' THEN
                Dim2FilterText := DimensionValue.Code
              ELSE
                Dim2FilterText += '|' + DimensionValue.Code;
            UNTIL DimensionValue.NEXT = 0;
          END;
        END;
        IF Dim2FilterText = '' THEN
          Dim2FilterText := JnlDim2Code;
        EXIT(Dim2FilterText);*/

    end;

    local procedure ReDoApplyRemainingCustomerLedger(Customer: Record "18")
    var
        CustLedgerEntry: Record "21";
        CustLedgerEntry2: Record "21";
        DtldCustLedgEntry: Record "379";
        ApplicationEntryNo: Integer;
        AmountToApply: Decimal;
        ApplyingAmount: Decimal;
    begin
        WITH Customer DO BEGIN
            CLEAR(CustLedgerEntry);
            CustLedgerEntry.RESET;
            CustLedgerEntry.SETCURRENTKEY("Posting Date");
            CustLedgerEntry.SETRANGE("Customer No.", "No.");
            CustLedgerEntry.SETRANGE(Open, TRUE);
            CustLedgerEntry.SETFILTER("Remaining Amount", '<%1', 0);
            IF CustLedgerEntry.FINDFIRST THEN
                REPEAT
                    CustLedgerEntry.CALCFIELDS("Remaining Amount");
                    AmountToApply := CustLedgerEntry."Remaining Amount";
                    IF (CustLedgerEntry.Open) AND (CustLedgerEntry."Remaining Amount" < 0) THEN BEGIN
                        FindRandomCustomerLedgerEntry(CustLedgerEntry2, CustLedgerEntry);
                        IF CustLedgerEntry2.FINDFIRST THEN BEGIN
                            SetApplyCustomerEntry(CustLedgerEntry, CustLedgerEntry."Remaining Amount");
                            REPEAT
                                //IF CustLedgerEntry2."Entry No." = 439643 THEN
                                //MESSAGE('s');
                                IF AmountToApply < 0 THEN BEGIN
                                    CustLedgerEntry2.CALCFIELDS("Remaining Amount");
                                    IF CustLedgerEntry2."Remaining Amount" > 0 THEN BEGIN
                                        CustLedgerEntry2.VALIDATE("Applies-to ID", USERID);
                                        IF ABS(AmountToApply) <= ABS(CustLedgerEntry2."Remaining Amount") THEN
                                            CustLedgerEntry2.VALIDATE("Amount to Apply", ABS(AmountToApply))
                                        ELSE
                                            CustLedgerEntry2.VALIDATE("Amount to Apply", CustLedgerEntry2."Remaining Amount");
                                        CustLedgerEntry2.MODIFY(TRUE);
                                        AmountToApply := AmountToApply + ABS(CustLedgerEntry2."Amount to Apply");
                                    END;
                                END;
                            UNTIL CustLedgerEntry2.NEXT = 0;
                        END;
                        IF AmountToApply <> CustLedgerEntry."Remaining Amount" THEN
                            PostCustLedgerApplication(CustLedgerEntry);
                    END;
                UNTIL CustLedgerEntry.NEXT = 0;
        END;
    end;

    local procedure ReDoApplyJournalWithExactMatchAmount(Customer: Record "18")
    var
        CustLedgerEntry: Record "21";
        CustLedgerEntry2: Record "21";
        DtldCustLedgEntry: Record "379";
        ApplicationEntryNo: Integer;
        AmountToApply: Decimal;
        ApplyingAmount: Decimal;
    begin
        WITH Customer DO BEGIN
            CLEAR(CustLedgerEntry);
            CustLedgerEntry.RESET;
            CustLedgerEntry.SETCURRENTKEY("Posting Date");
            CustLedgerEntry.SETRANGE("Customer No.", "No.");
            CustLedgerEntry.SETRANGE(Open, TRUE);
            CustLedgerEntry.SETFILTER("Remaining Amount", '<%1', 0);
            CustLedgerEntry.SETFILTER("Source Code", '<>SALES&<>SERVICE');
            IF CustLedgerEntry.FINDFIRST THEN
                REPEAT
                    CustLedgerEntry.CALCFIELDS("Remaining Amount");
                    AmountToApply := CustLedgerEntry."Remaining Amount";
                    IF (CustLedgerEntry.Open) AND (CustLedgerEntry."Remaining Amount" < 0) THEN BEGIN
                        FindExactCustomerLedgerEntry(CustLedgerEntry2, CustLedgerEntry);
                        IF CustLedgerEntry2.FINDFIRST THEN BEGIN
                            SetApplyCustomerEntry(CustLedgerEntry, CustLedgerEntry."Remaining Amount");
                            BEGIN
                                IF AmountToApply < 0 THEN BEGIN
                                    CustLedgerEntry2.CALCFIELDS("Remaining Amount");
                                    IF CustLedgerEntry2."Remaining Amount" > 0 THEN BEGIN
                                        CustLedgerEntry2.VALIDATE("Applies-to ID", USERID);
                                        IF ABS(AmountToApply) <= ABS(CustLedgerEntry2."Remaining Amount") THEN
                                            CustLedgerEntry2.VALIDATE("Amount to Apply", ABS(AmountToApply))
                                        ELSE
                                            CustLedgerEntry2.VALIDATE("Amount to Apply", CustLedgerEntry2."Remaining Amount");
                                        CustLedgerEntry2.MODIFY(TRUE);
                                        AmountToApply := AmountToApply + ABS(CustLedgerEntry2."Amount to Apply");
                                    END;
                                END;
                            END;
                        END;
                        IF AmountToApply <> CustLedgerEntry."Remaining Amount" THEN
                            PostCustLedgerApplication(CustLedgerEntry);
                    END;
                UNTIL CustLedgerEntry.NEXT = 0;
        END;
    end;

    local procedure ReDoApply(Customer: Record "18")
    var
        CustLedgerEntry: Record "21";
        CustLedgerEntry2: Record "21";
        DtldCustLedgEntry: Record "379";
        ApplicationEntryNo: Integer;
        AmountToApply: Decimal;
        ApplyingAmount: Decimal;
    begin
        WITH Customer DO BEGIN
            CustLedgerEntry.RESET;
            CustLedgerEntry.SETRANGE("Customer No.", "No.");
            //CustLedgerEntry.SETFILTER(Amount,'>%1',0);
            CustLedgerEntry.SETFILTER("Document Type", '%1|%2', CustLedgerEntry."Document Type"::Invoice, CustLedgerEntry."Document Type"::"Credit Memo");
            IF CustLedgerEntry.FINDFIRST THEN
                REPEAT
                    CustLedgerEntry.CALCFIELDS("Remaining Amount");
                    AmountToApply := CustLedgerEntry."Remaining Amount";

                    //IF CustLedgerEntry."Entry No." = 96724 THEN
                    // MESSAGE('Entry No. >> %1, ApplyAmount >> %2',CustLedgerEntry."Entry No.",CustLedgerEntry."Remaining Amount");

                    IF (CustLedgerEntry.Open) AND (CustLedgerEntry."Remaining Amount" > 0) THEN BEGIN
                        FindCustomerLedgerEntry(CustLedgerEntry2, CustLedgerEntry);
                        SetApplyCustomerEntry(CustLedgerEntry, CustLedgerEntry."Remaining Amount");
                        REPEAT
                            IF AmountToApply > 0 THEN BEGIN
                                CustLedgerEntry2.CALCFIELDS("Remaining Amount");
                                IF CustLedgerEntry2."Remaining Amount" < 0 THEN BEGIN
                                    CustLedgerEntry2.VALIDATE("Applies-to ID", USERID);
                                    IF AmountToApply >= ABS(CustLedgerEntry2."Remaining Amount") THEN
                                        CustLedgerEntry2.VALIDATE("Amount to Apply", CustLedgerEntry2."Remaining Amount")
                                    ELSE
                                        CustLedgerEntry2.VALIDATE("Amount to Apply", AmountToApply * -1);
                                    CustLedgerEntry2.MODIFY;
                                    AmountToApply := AmountToApply - ABS(CustLedgerEntry2."Amount to Apply");
                                END;
                            END;
                        UNTIL CustLedgerEntry2.NEXT = 0;
                        IF AmountToApply <> CustLedgerEntry."Remaining Amount" THEN
                            PostCustLedgerApplication(CustLedgerEntry);
                    END;

                    IF (CustLedgerEntry.Open) AND (CustLedgerEntry."Remaining Amount" < 0) THEN BEGIN
                        FindCustomerLedgerEntry(CustLedgerEntry2, CustLedgerEntry);
                        SetApplyCustomerEntry(CustLedgerEntry, CustLedgerEntry."Remaining Amount");
                        REPEAT
                            IF AmountToApply < 0 THEN BEGIN
                                CustLedgerEntry2.CALCFIELDS("Remaining Amount");
                                IF CustLedgerEntry2."Remaining Amount" > 0 THEN BEGIN
                                    CustLedgerEntry2.VALIDATE("Applies-to ID", USERID);
                                    IF ABS(AmountToApply) <= ABS(CustLedgerEntry2."Remaining Amount") THEN
                                        CustLedgerEntry2.VALIDATE("Amount to Apply", AmountToApply * -1)
                                    ELSE
                                        CustLedgerEntry2.VALIDATE("Amount to Apply", CustLedgerEntry2."Remaining Amount");
                                    CustLedgerEntry2.MODIFY;
                                    AmountToApply := AmountToApply + ABS(CustLedgerEntry2."Amount to Apply");
                                END;
                            END;
                        UNTIL CustLedgerEntry2.NEXT = 0;
                        IF AmountToApply <> CustLedgerEntry."Remaining Amount" THEN
                            PostCustLedgerApplication(CustLedgerEntry);
                    END;
                UNTIL CustLedgerEntry.NEXT = 0;
        END;
    end;
}

