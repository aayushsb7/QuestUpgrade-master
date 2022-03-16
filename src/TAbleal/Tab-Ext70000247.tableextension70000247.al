tableextension 50010 "tableextension70000247" extends "Reversal Entry"
{
    fields
    {
        modify("Entry Type")
        {
            OptionCaption = ' ,G/L Account,Customer,Vendor,Bank Account,Fixed Asset,Maintenance,VAT,Employee,,,,,,TDS';

            //Unsupported feature: Property Modification (OptionString) on ""Entry Type"(Field 2)".

        }
    }

    //Unsupported feature: Code Modification on "CheckEntries(PROCEDURE 14)".

    //procedure CheckEntries();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DtldCustLedgEntry.LOCKTABLE;
    DtldVendLedgEntry.LOCKTABLE;
    DetailedEmployeeLedgerEntry.LOCKTABLE;
    #4..8
    FALedgEntry.LOCKTABLE;
    MaintenanceLedgEntry.LOCKTABLE;
    VATEntry.LOCKTABLE;
    GLReg.LOCKTABLE;
    FAReg.LOCKTABLE;
    GLSetup.GET;
    #15..23
          TestFieldError;
        REPEAT
          CheckGLAcc(GLEntry,BalanceCheckAmount,BalanceCheckAddCurrAmount);
        UNTIL GLEntry.NEXT = 0;
      END;
      IF (BalanceCheckAmount <> 0) OR (BalanceCheckAddCurrAmount <> 0) THEN
    #30..90
        REPEAT
          CheckVAT(VATEntry);
        UNTIL VATEntry.NEXT = 0;
    END;

    OnAfterCheckEntries;

    DateComprReg.CheckMaxDateCompressed(MaxPostingDate,1);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..11
    TDSEntry.LOCKTABLE; //TDS1.00
    #12..26
        CheckTDS_PDC_Entries(GLEntry); //UTS SM 18 Apr 2017
    #27..93
      //TDS1.00 >>
      IF TDSEntry.FIND('-') THEN
        REPEAT
          CheckTDS(TDSEntry);
        UNTIL TDSEntry.NEXT = 0;
      //TDS1.00 <<
    #94..98
    */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: TDSEntry2) (ParameterCollection) on "CopyReverseFilters(PROCEDURE 15)".



    //Unsupported feature: Code Modification on "CopyReverseFilters(PROCEDURE 15)".

    //procedure CopyReverseFilters();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GLEntry2.COPY(GLEntry);
    CustLedgEntry2.COPY(CustLedgEntry);
    VendLedgEntry2.COPY(VendLedgEntry);
    EmployeeLedgerEntry2.COPY(EmployeeLedgerEntry);
    BankAccLedgEntry2.COPY(BankAccLedgEntry);
    VATEntry2.COPY(VATEntry);
    FALedgEntry2.COPY(FALedgEntry);
    MaintenanceLedgEntry2.COPY(MaintenanceLedgEntry);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
    TDSEntry2.COPY(TDSEntry); //TDS1.00
    */
    //end;


    //Unsupported feature: Code Modification on "Caption(PROCEDURE 3)".

    //procedure Caption();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CASE "Entry Type" OF
      "Entry Type"::"G/L Account":
        BEGIN
    #4..42
        END;
      "Entry Type"::VAT:
        EXIT(STRSUBSTNO('%1',VATEntry.TABLECAPTION));
      ELSE BEGIN
        OnAfterCaption(Rec,NewCaption);
        EXIT(NewCaption);
      END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..45
    END;
    //TDS1.00 <<
    IF "Entry Type" = "Entry Type"::TDS THEN
      EXIT(STRSUBSTNO('%1',TDSEntry.TABLECAPTION))
    //TDS1.00 >>
    ELSE BEGIN
       OnAfterCaption(Rec,NewCaption);
       EXIT(NewCaption);
    END;
    */
    //end;

    local procedure CheckTDS(TDSEntry: Record "Original TDS Entry")
    begin
        /*//TDS1.00
        CheckPostingDate(
          TDSEntry."Posting Date",TDSEntry.TABLECAPTION,
          TDSEntry."Entry No.");
        IF TDSEntry.Closed THEN
          ERROR(
            Text006,TDSEntry.TABLECAPTION,TDSEntry."Entry No.");
        IF TDSEntry.Reversed THEN
          AlreadyReversedEntry(TDSEntry.TABLECAPTION,TDSEntry."Entry No.");
        //TDS1.00*/

    end;

    procedure ShowTDSEntries()
    begin
        PAGE.RUN(0, TDSEntry);  //TDS1.00
    end;

    local procedure InsertFromTDSEntry(var TempRevertTransactionNo: Record "2000000026" temporary; Number: Integer; RevType: Option Transaction,Register; var NextLineNo: Integer)
    begin
        // TDS1.00
        TempRevertTransactionNo.FINDSET;
        REPEAT
            IF RevType = RevType::Transaction THEN
                TDSEntry.SETRANGE("Transaction No.", TempRevertTransactionNo.Number);
            IF TDSEntry.FINDSET THEN
                REPEAT
                    CLEAR(TempReversalEntry);
                    IF RevType = RevType::Register THEN
                        TempReversalEntry."G/L Register No." := Number;
                    TempReversalEntry."Reversal Type" := RevType;
                    TempReversalEntry."Entry Type" := TempReversalEntry."Entry Type"::TDS;
                    TempReversalEntry."Entry No." := TDSEntry."Entry No.";
                    TempReversalEntry."Posting Date" := TDSEntry."Posting Date";
                    TempReversalEntry."Source Code" := TDSEntry."Source Code";
                    TempReversalEntry."Transaction No." := TDSEntry."Transaction No.";
                    TempReversalEntry.Amount := TDSEntry."Original TDS Amount";
                    TempReversalEntry."Amount (LCY)" := TDSEntry."Original TDS Amount";
                    //ReversalEntry."Document Type" := TDSEntry."Document Type";
                    TempReversalEntry."Document No." := TDSEntry."Document No.";
                    TempReversalEntry."Line No." := NextLineNo;
                    NextLineNo := NextLineNo + 1;
                    TempReversalEntry.INSERT;
                UNTIL TDSEntry.NEXT = 0;
        UNTIL TempRevertTransactionNo.NEXT = 0;
        // TDS1.00
    end;

    local procedure CheckTDS_PDC_Entries(GL_Entry: Record "G/L Entry")
    begin
        //UTS SM 18 Apr 2017
        WITH GL_Entry DO BEGIN
            IF ("TDS Entry No." <> 0) THEN
                ERROR(TDSEntryNotBlankErr, "Document No.");

            IF "PDC Entry No." <> 0 THEN
                ERROR(PDCEntryNotBlankErr, "Document No.");
        END;
        //UTS SM 18 Apr 2017
    end;

    procedure SetTDSEntry(NewIsTDSEntry: Boolean)
    begin
        IsTDSEntry := NewIsTDSEntry;
    end;

    var
        TDSEntry: Record "Original TDS Entry";
        IsTDSEntry: Boolean;
        TempReversalEntry: Record "Reversal Entry";
        TDSEntryNotBlankErr: Label 'You cannot reverse the TDS Payment (Doc. No. %1) from this functionality. Please reverse it from TDS Entries Page.';
        PDCEntryNotBlankErr: Label 'You cannot reverse the PDC Payment (Doc. No. %1) from this functionality. Please reverse it from PDC Entries Page.';
}

