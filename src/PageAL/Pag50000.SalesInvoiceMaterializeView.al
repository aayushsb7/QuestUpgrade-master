page 50000 "Sales Invoice Materialize View"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Invoice Materialize View";
    SourceTableView = WHERE("Table ID" = CONST(112),
                           "Document Type" = CONST("Sales Invoice"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sync Status"; "Sync Status")
                {
                }
                field("Synced Date"; "Synced Date")
                {
                }
                field("Sync with IRD"; "Sync with IRD")
                {
                }
                field("Is Realtime"; "Is Realtime")
                {
                }
                field("Bill No"; "Bill No")
                {
                }
                field("Fiscal Year"; "Fiscal Year")
                {
                }
                field("Bill Date"; "Bill Date")
                {
                }
                field("Posting Time"; "Posting Time")
                {
                }
                field("Customer Code"; "Customer Code")
                {
                }
                field("Source Code"; "Source Code")
                {
                }
                field("Customer Name"; "Customer Name")
                {
                }
                field("VAT Registration No."; "VAT Registration No.")
                {
                }
                field(Amount; Amount)
                {
                }
                field(Discount; Discount)
                {
                }
                field("Taxable Amount"; "Taxable Amount")
                {
                }
                field("TAX Amount"; "TAX Amount")
                {
                }
                field("Total Amount"; "Total Amount")
                {
                }
                field("Entered By"; "Entered By")
                {
                }
                field("Is Bill Printed"; "Is Bill Printed")
                {
                }
                field("Is Bill Active"; "Is Bill Active")
                {
                }
                field("Printed By"; "Printed By")
                {
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("<Action1000000023>")
            {
                Caption = '&Print';
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    InvoiceMat.COPYFILTERS(Rec);
                    REPORT.RUNMODAL(50010, TRUE, FALSE, InvoiceMat);
                end;
            }
            action("Sync. Selected Data to IRD")
            {
                Image = Save;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    InvoiceMaterializedView: Record "Invoice Materialize View";
                    PushInvoices: Codeunit "IRD CBMS Mgt.";
                begin
                    IF NOT CONFIRM('Do you want to send selected records to IRD?', FALSE) THEN
                        EXIT;
                    InvoiceMaterializedView.COPY(Rec);
                    CurrPage.SETSELECTIONFILTER(InvoiceMaterializedView);
                    CLEAR(PushInvoices);
                    PushInvoices.PushBatchBill(InvoiceMaterializedView);
                end;
            }
            action("Update Missing Sales Data")
            {
                Image = SettleOpenTransactions;
                Promoted = false;

                trigger OnAction()
                begin
                    UpdateMissingSalesDataInInvMatView;
                end;
            }
        }
        area(navigation)
        {
            action("<Action59>")
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    SalesInvHeader.GET("Bill No");
                    SalesInvHeader.Navigate;
                end;
            }
            action("<Action1000000028>")
            {
                Caption = 'Print &History';
                Image = History;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Page 50045;
            }
        }
    }

    var
        InvoiceMat: Record "Invoice Materialize View";

    local procedure UpdateMissingSalesDataInInvMatView()
    var
        IRDMgt: Codeunit "IRD Mgt.";
        SalesInvHdr: Record "Sales Invoice Header";
        SalesCrMemoHdr: Record "Sales Cr.Memo Header";
        InvMatView: Record "Invoice Materialize View";
    begin
        SalesInvHdr.RESET();
        IF SalesInvHdr.FINDFIRST() THEN
            REPEAT
                InvMatView.RESET();
                InvMatView.SETRANGE("Bill No", SalesInvHdr."No.");
                IF NOT InvMatView.FINDFIRST() THEN
                    IRDMgt.InsertRegisterInvoice(DATABASE::"Sales Invoice Header", SalesInvHdr."No.");
            UNTIL SalesInvHdr.NEXT() = 0;
        SalesCrMemoHdr.RESET();
        IF SalesCrMemoHdr.FINDFIRST() THEN
            REPEAT
                InvMatView.RESET();
                InvMatView.SETRANGE("Bill No", SalesCrMemoHdr."No.");
                IF NOT InvMatView.FINDFIRST() THEN
                    IRDMgt.InsertRegisterInvoice(DATABASE::"Sales Cr.Memo Header", SalesCrMemoHdr."No.");
            UNTIL SalesCrMemoHdr.NEXT() = 0;
    end;
}

