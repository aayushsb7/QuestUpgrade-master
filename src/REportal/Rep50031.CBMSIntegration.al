report 50031 "CBMS Integration"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Integration; Table2000000026)
        {
            DataItemTableView = SORTING (Number)
                                WHERE (Number = CONST (1));

            trigger OnAfterGetRecord()
            var
                CBMSMgt: Codeunit "50004";
            begin
                InvoiceMaterializeView.RESET;
                InvoiceMaterializeView.LOCKTABLE;
                InvoiceMaterializeView.SETFILTER("Sync Status", '%1|%2', InvoiceMaterializeView."Sync Status"::Pending, InvoiceMaterializeView."Sync Status"::"Sync In Progress");
                IF NOT JobQueueActive THEN
                    ProgressWindow.UPDATE(2, InvoiceMaterializeView.COUNT);
                IF InvoiceMaterializeView.FINDSET THEN
                    REPEAT
                        IF NOT JobQueueActive THEN BEGIN
                            TotalCount += 1;
                            ProgressWindow.UPDATE(1, TotalCount);
                        END;
                        CBMSMgt.StartBatchCBMSIntegration(InvoiceMaterializeView);
                    UNTIL InvoiceMaterializeView.NEXT = 0;
            end;

            trigger OnPreDataItem()
            begin
                IF NOT JobQueueActive THEN
                    ProgressWindow.OPEN(Text001);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        IF NOT JobQueueActive THEN
            ProgressWindow.CLOSE;
    end;

    var
        InvoiceMaterializeView: Record "50001";
        ProgressWindow: Dialog;
        Text001: Label 'Syncing #1############ of #2############';
        TotalCount: Integer;

    [Scope('Internal')]
    procedure JobQueueActive(): Boolean
    begin
        EXIT(NOT GUIALLOWED);
    end;
}

