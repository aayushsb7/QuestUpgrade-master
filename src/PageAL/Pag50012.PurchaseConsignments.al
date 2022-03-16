page 50012 "Purchase Consignments"
{
    PageType = ListPart;
    SourceTable = "Purchase Consignment";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field("Commercial Invoice No."; "Commercial Invoice No.")
                {
                }
                field("Vendor Code"; "Vendor Code")
                {
                }
                field(Blocked; Blocked)
                {
                }
                field("Sys LC No."; "Sys LC No.")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Posted Document List")
            {
                Caption = 'Posted Document List';
                action("Posted Purchase Invoices List")
                {
                    Image = Invoice;

                    trigger OnAction()
                    begin
                        PurchaseInvoices.RESET;
                        PurchaseInvoices.SETRANGE("Purchase Consignment No.", "No.");
                        IF PurchaseInvoices.FINDFIRST THEN BEGIN
                            PostedPurchaseInvoice.SETTABLEVIEW(PurchaseInvoices);
                            PostedPurchaseInvoice.RUN;
                        END;
                    end;
                }
                action("Posted Purchase Credit Memos List")
                {
                    Image = Invoice;

                    trigger OnAction()
                    begin
                        PurchaseCreditmemos.RESET;
                        PurchaseCreditmemos.SETRANGE("Purchase Consignment No.", "No.");
                        IF PurchaseCreditmemos.FINDFIRST THEN BEGIN
                            PostedPurchaseCreditmemo.SETTABLEVIEW(PurchaseCreditmemos);
                            PostedPurchaseCreditmemo.RUN;
                        END;
                    end;
                }
            }
            group(Create)
            {
                Caption = 'Create';
                Visible = false;
                action("Create Purchase Order")
                {
                    Image = Ledger;

                    trigger OnAction()
                    var
                        Text102: Label 'Purchase Order exist for Purchase Consignment No. %1. Do you want to create new Purchase Order?';
                    begin
                        IF NOT Blocked THEN BEGIN
                            PurchaseHeader.RESET;
                            PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
                            PurchaseHeader.SETRANGE("Purchase Consignment No.", "No.");
                            IF PurchaseHeader.FINDFIRST THEN BEGIN
                                IF NOT CONFIRM(Text102, FALSE, "No.") THEN
                                    EXIT;
                                PurchMgt.CreatePurchaseOrder(Rec);
                            END
                            ELSE BEGIN
                                PurchMgt.CreatePurchaseOrder(Rec);
                            END;
                            PurchaseHeader2.RESET;
                            PurchaseHeader2.SETRANGE("Document Type", PurchaseHeader2."Document Type"::Order);
                            PurchaseHeader2.SETRANGE("Purchase Consignment No.", "No.");
                            IF PurchaseHeader2.FINDLAST THEN BEGIN
                                PurchaseOrder.SETRECORD(PurchaseHeader2);
                                PurchaseOrder.RUN;
                            END;
                        END
                    end;
                }
                action("Create Purchase Invoice")
                {
                    Image = Ledger;

                    trigger OnAction()
                    var
                        Text102: Label 'Purchase Invoice exist for Purchase Consignment No. %1. Do you want to create new Purchase Invoice?';
                    begin
                        IF NOT Blocked THEN BEGIN
                            PurchaseHeader.RESET;
                            PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Invoice);
                            PurchaseHeader.SETRANGE("Purchase Consignment No.", "No.");
                            IF PurchaseHeader.FINDFIRST THEN BEGIN
                                IF NOT CONFIRM(Text102, FALSE, "No.") THEN
                                    EXIT;
                                PurchMgt.CreatePurchaseInvoice(Rec);
                            END
                            ELSE BEGIN
                                PurchMgt.CreatePurchaseInvoice(Rec);
                            END;
                            PurchaseHeader2.RESET;
                            PurchaseHeader2.SETRANGE("Document Type", PurchaseHeader2."Document Type"::Invoice);
                            PurchaseHeader2.SETRANGE("Purchase Consignment No.", "No.");
                            IF PurchaseHeader2.FINDLAST THEN BEGIN
                                PurchaseInvoice.SETRECORD(PurchaseHeader2);
                                PurchaseInvoice.RUN;
                            END;
                        END
                    end;
                }
                action("Create Purchase Credit Memo")
                {
                    Image = Ledger;

                    trigger OnAction()
                    var
                        Text102: Label 'Purchase Credit Memo exist for Purchase Consignment No. %1. Do you want to create new Purchase Credit Memo?';
                    begin
                        IF NOT Blocked THEN BEGIN
                            PurchaseHeader.RESET;
                            PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::"Credit Memo");
                            PurchaseHeader.SETRANGE("Purchase Consignment No.", "No.");
                            IF PurchaseHeader.FINDFIRST THEN BEGIN
                                IF NOT CONFIRM(Text102, FALSE, "No.") THEN
                                    EXIT;
                                PurchMgt.CreatePurchaseCreditMemo(Rec);
                            END
                            ELSE BEGIN
                                PurchMgt.CreatePurchaseCreditMemo(Rec);
                            END;
                            PurchaseHeader2.RESET;
                            PurchaseHeader2.SETRANGE("Document Type", PurchaseHeader2."Document Type"::"Credit Memo");
                            PurchaseHeader2.SETRANGE("Purchase Consignment No.", "No.");
                            IF PurchaseHeader2.FINDLAST THEN BEGIN
                                PurchaseCreditMemo.SETRECORD(PurchaseHeader2);
                                PurchaseCreditMemo.RUN;
                            END;
                        END
                    end;
                }
                action("Create Purchase Return Order")
                {

                    trigger OnAction()
                    var
                        Text102: Label 'Purchase Return Order exist for Purchase Consignment No. %1. Do you want to create new Purchase Return Order?';
                    begin
                        IF NOT Blocked THEN BEGIN
                            PurchaseHeader.RESET;
                            PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::"Return Order");
                            PurchaseHeader.SETRANGE("Purchase Consignment No.", "No.");
                            IF PurchaseHeader.FINDFIRST THEN BEGIN
                                IF NOT CONFIRM(Text102, FALSE, "No.") THEN
                                    EXIT;
                                PurchMgt.CreatePurchaseReturnOrder(Rec);
                            END
                            ELSE BEGIN
                                PurchMgt.CreatePurchaseReturnOrder(Rec);
                            END;
                            PurchaseHeader2.RESET;
                            PurchaseHeader2.SETRANGE("Document Type", PurchaseHeader2."Document Type"::"Return Order");
                            PurchaseHeader2.SETRANGE("Purchase Consignment No.", "No.");
                            IF PurchaseHeader2.FINDLAST THEN BEGIN
                                PurchaseReturnOrder.SETRECORD(PurchaseHeader2);
                                PurchaseReturnOrder.RUN;
                            END;
                        END
                    end;
                }
                action("Create PragyapanPatra")
                {
                    Image = Ledger;

                    trigger OnAction()
                    var
                        PragyapanPatra: Record PragyapanPatra;
                        PragyapanPatraList: Page PragyapanPatra;
                    begin
                        IF NOT Blocked THEN BEGIN
                            PragyapanPatra.RESET;
                            PragyapanPatraList.SETTABLEVIEW(PragyapanPatra);
                            PragyapanPatraList.RUN;
                        END
                    end;
                }
            }
            group("Document List")
            {
                Caption = 'Document List';
                action("Purchase Order List")
                {
                    Image = Invoice;

                    trigger OnAction()
                    begin
                        PurchaseHeader.RESET;
                        PurchaseHeader.SETRANGE("Purchase Consignment No.", "No.");
                        //PurchaseHeader.SETRANGE(Status,PurchaseHeader.Status::Released);
                        IF PurchaseHeader.FINDFIRST THEN BEGIN
                            PurchaseOrderList.SETTABLEVIEW(PurchaseHeader);
                            PurchaseOrderList.RUN;
                        END;
                    end;
                }
                action("Purchase Invoice List")
                {
                    Image = Invoice;

                    trigger OnAction()
                    begin
                        PurchaseHeader.RESET;
                        PurchaseHeader.SETRANGE("Purchase Consignment No.", "No.");
                        IF PurchaseHeader.FINDFIRST THEN BEGIN
                            PurchaseInvoiceList.SETTABLEVIEW(PurchaseHeader);
                            PurchaseInvoiceList.RUN;
                        END;
                    end;
                }
                action("Purchase Credit Memos List")
                {
                    Image = Invoice;

                    trigger OnAction()
                    begin
                        PurchaseHeader.RESET;
                        PurchaseHeader.SETRANGE("Purchase Consignment No.", "No.");
                        IF PurchaseHeader.FINDFIRST THEN BEGIN
                            PurchaseCreditMemoList.SETTABLEVIEW(PurchaseHeader);
                            PurchaseCreditMemoList.RUN;
                        END;
                    end;
                }
                action("Purchase Return Order List")
                {
                    Image = Invoice;

                    trigger OnAction()
                    begin
                        PurchaseHeader.RESET;
                        PurchaseHeader.SETRANGE("Purchase Consignment No.", "No.");
                        IF PurchaseHeader.FINDFIRST THEN BEGIN
                            PurchaseReturnOrderList.SETTABLEVIEW(PurchaseHeader);
                            PurchaseReturnOrderList.RUN;
                        END;
                    end;
                }
            }
        }
    }

    var
        PurchaseInvoices: Record "Purch. Inv. Header";
        PostedPurchaseInvoice: Page "Posted Purchase Invoices";
        PurchaseCreditmemos: Record "Purch. Cr. Memo Hdr.";
        PostedPurchaseCreditmemo: Page "Posted Purchase Credit Memos";
        PurchMgt: Codeunit "System Mgt. Quest";
        PurchaseHeader: Record "Purchase Header";
        PurchaseOrder: Page "Purchase Order";
        PurchaseInvoice: Page "Purchase Invoices";
        PurchaseCreditMemo: Page "Purchase Credit Memo";
        PurchaseReturnOrder: Page "Purchase Return Order";
        PurchaseOrderList: Page "Purchase Order List";
        PurchaseInvoiceList: Page "Purchase Invoices";
        PurchaseCreditMemoList: Page "Purchase Credit Memos";
        PurchaseReturnOrderList: Page "Purchase Return Order List";
        DocClassMaster: Record "English-Nepali Date";
        DocClassMasterlist: Page "Sales Invoice Materialize View";
        PurchaseHeader2: Record "Purchase Header";
}

