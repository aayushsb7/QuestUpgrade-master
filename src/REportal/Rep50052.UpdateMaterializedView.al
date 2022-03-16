report 50052 "Update Materialized View"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1; Table2000000026)
        {
            DataItemTableView = WHERE (Number = CONST (1));

            trigger OnAfterGetRecord()
            begin
                ProcessedRecords := 0;
                ModifiedCount := 0;
                CreateMaterializeView;
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

    var
        User: Record "2000000120";
        StartDate: Date;
        EndDate: Date;
        DateFilter: Text;
        ProgressWindow: Dialog;
        TotalCount: Integer;
        ModifiedCount: Integer;
        ProcessedRecords: Integer;
        SalesInvProcessText: Label 'Processed : #1######\Total Records : #2######## \Bill Inserted : #3######';
        SalesCrMemoProcessText: Label 'Processed : #1######\Total Records : #2######## \Credit Memo Inserted : #3######';

    local procedure CreateMaterializeView()
    var
        IRDMgt: Codeunit "50000";
        SalesInvHdr: Record "112";
        InvMatView: Record "50001";
        SalesCrMemoHdr: Record "114";
    begin
        SalesInvHdr.RESET;
        //Processed : #1######\Total Records : #2######## \Bill Inserted : #3######
        IF NOT JobQueueActive THEN BEGIN
            ProgressWindow.OPEN(SalesInvProcessText);
            ProgressWindow.UPDATE(2, SalesInvHdr.COUNT);
        END;
        IF DateFilter <> '' THEN
            SalesInvHdr.SETFILTER("Posting Date", DateFilter);
        IF SalesInvHdr.FINDFIRST THEN
            REPEAT
                ProcessedRecords += 1;
                InvMatView.RESET;
                InvMatView.SETRANGE("Table ID", 112);
                InvMatView.SETRANGE("Bill No", SalesInvHdr."No.");
                IF NOT InvMatView.FINDFIRST THEN BEGIN
                    IRDMgt.InsertRegisterInvoice(112, SalesInvHdr."No.");
                    ModifiedCount += 1;
                END;
                IF NOT JobQueueActive THEN BEGIN
                    ProgressWindow.UPDATE(1, ProcessedRecords);
                    ProgressWindow.UPDATE(3, ModifiedCount);
                END;
            UNTIL SalesInvHdr.NEXT = 0;


        ProcessedRecords := 0;
        ModifiedCount := 0;

        SalesCrMemoHdr.RESET;
        IF NOT JobQueueActive THEN BEGIN
            ProgressWindow.OPEN(SalesCrMemoProcessText);
            ProgressWindow.UPDATE(2, SalesCrMemoHdr.COUNT);
        END;
        IF DateFilter <> '' THEN
            SalesCrMemoHdr.SETFILTER("Posting Date", DateFilter);
        IF SalesCrMemoHdr.FINDFIRST THEN
            REPEAT
                ProcessedRecords += 1;
                InvMatView.RESET;
                InvMatView.SETRANGE("Table ID", 114);
                InvMatView.SETRANGE("Bill No", SalesCrMemoHdr."No.");
                IF NOT InvMatView.FINDFIRST THEN BEGIN
                    IRDMgt.InsertRegisterInvoice(114, SalesCrMemoHdr."No.");
                    ModifiedCount += 1;
                END;
                IF NOT JobQueueActive THEN BEGIN
                    ProgressWindow.UPDATE(1, ProcessedRecords);
                    ProgressWindow.UPDATE(3, ModifiedCount);
                END;
            UNTIL SalesCrMemoHdr.NEXT = 0;
    end;

    local procedure JobQueueActive(): Boolean
    begin
        EXIT(NOT GUIALLOWED);
    end;
}

