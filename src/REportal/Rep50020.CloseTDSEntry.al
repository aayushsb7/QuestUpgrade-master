report 50020 "Close TDS Entry"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1; Table50006)
        {
            RequestFilterFields = "Posting Date", "TDS Posting Group", "Document No.";

            trigger OnAfterGetRecord()
            begin
                UserSetUp.GET(USERID);

                IF NOT Reverse THEN
                    CloseTDSEntry("IRDVoucherNo.", "Original TDS Entry", IRDVoucherNoDate, FiscalYear)
                ELSE
                    IF UserSetUp."Blank IRD Voucher No." THEN
                        ReverseCloseTDSEntry("Original TDS Entry")
                    ELSE
                        ERROR(Text0001);
            end;

            trigger OnPostDataItem()
            begin
                IF NOT Reverse THEN
                    MESSAGE(Text0003)
                ELSE
                    MESSAGE(Text0004);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Option)
                {
                    field("IRDVoucherNo."; "IRDVoucherNo.")
                    {
                        Caption = 'IRD Voucher No.';

                        trigger OnValidate()
                        begin
                            IF Reverse THEN BEGIN
                                "IRDVoucherNo." := '';
                                IRDVoucherNoDate := 0D;
                                FiscalYear := '';
                            END
                        end;
                    }
                    field(IRDVoucherNoDate; IRDVoucherNoDate)
                    {
                        Caption = 'IRD Voucher Date';
                    }
                    field(FiscalYear; FiscalYear)
                    {
                        Caption = 'Fiscal Year';
                    }
                    field(Reverse; Reverse)
                    {
                        Caption = 'Blank IRD Voucher No.';

                        trigger OnValidate()
                        begin
                            IF ("IRDVoucherNo." <> '') OR (IRDVoucherNoDate <> 0D) OR (FiscalYear <> '') THEN
                                ERROR(Text0002);
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

    var
        "IRDVoucherNo.": Code[20];
        Reverse: Boolean;
        UserSetUp: Record "91";
        Text0001: Label 'You are not authorised to blank IRD Voucher No.';
        Text0002: Label 'IRD Voucher No., IRD Voucher Date, and Fiscal Year should be blank';
        Text0003: Label 'IRD Voucher No., IRD Voucher Date, and Fiscal Year has been updated in selected lines';
        Text0004: Label 'IRD Voucher No., IRD Voucher Date, and Fiscal Year has been updated blank in selected lines';
        IRDVoucherNoDate: Date;
        FiscalYear: Code[10];

    local procedure CloseTDSEntry("IRDVouNo.": Code[20]; TDSEntry: Record "50006"; IRDVouNoDate: Date; FiscalYear: Code[10])
    begin
        IF ("IRDVoucherNo." <> '') AND (IRDVoucherNoDate <> 0D) AND (FiscalYear <> '') THEN BEGIN
            IF NOT TDSEntry.Reversed THEN BEGIN
                TDSEntry."IRD Voucher No." := "IRDVouNo.";
                TDSEntry."IRD Voucher Date" := IRDVouNoDate;
                TDSEntry."Fiscal Year" := FiscalYear;
                TDSEntry.Closed := TRUE;
                TDSEntry.MODIFY;
            END;
        END
    end;

    local procedure ReverseCloseTDSEntry(TDSEntry: Record "50006")
    begin
        TDSEntry."IRD Voucher No." := '';
        TDSEntry."IRD Voucher Date" := 0D;
        TDSEntry."Fiscal Year" := '';
        TDSEntry.Closed := FALSE;
        TDSEntry.MODIFY;
    end;
}

