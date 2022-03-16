report 50058 "Sales Invoice Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SalesInvoiceAnalysis.rdlc';

    dataset
    {
        dataitem(DataItem1; Table18)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Customer Posting Group", "Date Filter";
            column(AllFilters; AllFilters)
            {
            }
            column(ReportName; ReportName)
            {
            }
            column(Name_CompanyInfo; CompanyInfo.Name)
            {
            }
            column(No_Customer; Customer."No.")
            {
            }
            column(Name_Customer; Customer.Name)
            {
            }
            column(CustomerPostingGroup_Customer; Customer."Customer Posting Group")
            {
            }
            dataitem(DataItem2; Table5802)
            {
                DataItemLink = Source No.=FIELD(No.),
                               Posting Date=FIELD(Date Filter);
                DataItemTableView = WHERE(Item Ledger Entry Type=CONST(Sale),
                                          Document Type=CONST(Sales Invoice));
                column(DocumentNo_ValueEntry;"Value Entry"."Document No.")
                {
                }
                column(InventoryPostingGroup_ValueEntry;"Value Entry"."Inventory Posting Group")
                {
                }
                column(ItemNo_ValueEntry;ItemName)
                {
                }
                column(PostingDate_ValueEntry;FORMAT("Value Entry"."Posting Date"))
                {
                }
                column(InvoicedQuantity_ValueEntry;SalesUOMQty)
                {
                }
                column(SalesAmountActual_ValueEntry;"Value Entry"."Sales Amount (Actual)")
                {
                }
                column(BatchNo;BatchNo)
                {
                }
                column(ExpiryDate;IRDMgt.GetExpiryDateInText(ExpiryDate))
                {
                }
                column(SalesUOM;SalesUOM)
                {
                }
                column(ExternalDocNo;ExternalDocNo)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ILE.GET("Value Entry"."Item Ledger Entry No.");
                    ILE.CALCFIELDS("Item Name");
                    ItemName := ILE."Item Name";
                    BatchNo := ILE."Lot No.";
                    ExpiryDate := ILE."Expiration Date";
                    SalesUOM := ILE."Unit of Measure Code";
                    ExternalDocNo := ILE."External Document No.";
                    SalesUOMQty := ABS(ILE."Invoiced Quantity")/ILE."Qty. per Unit of Measure";
                end;
            }
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

    trigger OnPreReport()
    begin
        AllFilters := Customer.GETFILTERS;
        CompanyInfo.GET;
    end;

    var
        AllFilters: Text;
        ReportName: Label 'Sales Invoice Analysis - Customer/Product wise';
        CompanyInfo: Record "79";
        BatchNo: Code[20];
        ExpiryDate: Date;
        ILE: Record "32";
        SalesUOM: Code[10];
        ItemName: Text;
        IRDMgt: Codeunit "50000";
        ExternalDocNo: Code[50];
        SalesUOMQty: Decimal;
}

