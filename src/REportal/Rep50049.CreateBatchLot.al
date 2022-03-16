report 50049 "Create Batch Lot"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1; Table2000000026)
        {
            DataItemTableView = WHERE (Number = CONST (1));

            trigger OnAfterGetRecord()
            begin
                IF CreateLotSales THEN BEGIN
                    SalesLine.RESET;
                    SalesLine.SETFILTER("Batch No.", '<>%1', '');
                    IF FreeSalesLine THEN
                        SalesLine.SETRANGE("Free Item Line", FreeSalesLine);
                    IF SalesDocumentNo <> '' THEN
                        SalesLine.SETFILTER("Document No.", SalesDocumentNo);
                    ProgressWindow.OPEN(Text001);
                    ProgressWindow.UPDATE(1, SalesLine.COUNT);
                    IF SalesLine.FINDFIRST THEN
                        REPEAT
                            IF SalesLine."Document Type" IN [SalesLine."Document Type"::Order, SalesLine."Document Type"::Invoice] THEN
                                IRDMgt.AssignLotNoToPerSalesLine(SalesLine, SalesLine."Batch No.", SalesLine."Qty. to Ship" * SalesLine."Qty. per Unit of Measure")
                            ELSE
                                IF SalesLine."Document Type" IN [SalesLine."Document Type"::"Return Order", SalesLine."Document Type"::"Credit Memo"] THEN
                                    IRDMgt.AssignLotNoToPerSalesLine(SalesLine, SalesLine."Batch No.", -(SalesLine."Qty. to Invoice" * SalesLine."Qty. per Unit of Measure"));
                            totalcount += 1;
                            COMMIT;
                            ProgressWindow.UPDATE(2, totalcount);
                        UNTIL SalesLine.NEXT = 0;
                END;

                IF CreateLotItemJnl THEN BEGIN
                    ItemJournalLine.RESET;
                    ItemJournalLine.SETFILTER("Batch No.", '<>%1', '');
                    IF ItemJnlDocumentNo <> '' THEN
                        ItemJournalLine.SETFILTER("Document No.", ItemJnlDocumentNo);
                    ProgressWindow.OPEN(Text001);
                    ProgressWindow.UPDATE(1, SalesLine.COUNT);
                    IF ItemJournalLine.FINDFIRST THEN
                        REPEAT
                            IRDMgt.AssignLotNoToPerItemJnlLine(ItemJournalLine, ItemJournalLine."Batch No.", ItemJournalLine.Quantity * ItemJournalLine."Qty. per Unit of Measure");
                            totalcount += 1;
                            ProgressWindow.UPDATE(2, totalcount);
                        UNTIL ItemJournalLine.NEXT = 0;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group()
                {
                    field("Sales Order No."; SalesDocumentNo)
                    {
                    }
                    field("Item Jnl Doc. No."; ItemJnlDocumentNo)
                    {
                        Caption = 'Item Jnl. Document No.';
                    }
                    field("Create Sales Lot"; CreateLotSales)
                    {
                    }
                    field("Create Free Sales Lot"; FreeSalesLine)
                    {
                    }
                    field("Create Item jnl Lot"; CreateLotItemJnl)
                    {
                        Caption = 'Create Item Journal Lot';
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
        ProgressWindow: Dialog;
        totalcount: Integer;
        SalesLine: Record "37";
        ItemJournalLine: Record "83";
        Text001: Label 'Total Count #1############ \Creating Lot #2############';
        CreateLotSales: Boolean;
        CreateLotItemJnl: Boolean;
        IRDMgt: Codeunit "50000";
        SalesHeader: Record "36";
        SalesDocumentNo: Code[20];
        ItemJnlDocumentNo: Code[20];
        FreeSalesLine: Boolean;
}

