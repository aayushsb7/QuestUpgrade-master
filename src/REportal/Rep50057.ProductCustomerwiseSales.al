report 50057 "Product Customer wise Sales"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ProductCustomerwiseSales.rdlc';

    dataset
    {
        dataitem(DataItem1; Table18)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Customer Posting Group", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";
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
            dataitem(DataItem2; Table32)
            {
                CalcFields = Sales Amount (Expected),Sales Amount (Actual);
                DataItemLink = Source No.=FIELD(No.),
                               Posting Date=FIELD(Date Filter),
                               Global Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                               Global Dimension 2 Code=FIELD(Global Dimension 2 Filter);
                DataItemTableView = WHERE(Source Type=CONST(Customer),
                                          Entry Type=CONST(Sale));
                column(ItemNo_ItemLedgerEntry;"Item Ledger Entry"."Item No.")
                {
                }
                column(ItemName_ItemLedgerEntry;"Item Ledger Entry"."Item Name")
                {
                }
                column(PostingDate_ItemLedgerEntry;"Item Ledger Entry"."Posting Date")
                {
                }
                column(InvoicedQuantity_ItemLedgerEntry;"Item Ledger Entry"."Invoiced Quantity")
                {
                }
                column(SalesAmountExpected_ItemLedgerEntry;"Item Ledger Entry"."Sales Amount (Expected)" + "Item Ledger Entry"."Sales Amount (Actual)")
                {
                }
                column(SalesQuantity;SalesQuantity)
                {
                }
                column(SalesReturnQuantity;SalesReturnQuantity)
                {
                }
                column(SalesValue;SalesValue)
                {
                }
                column(SalesReturnValue;SalesReturnValue)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SalesQuantity := 0;
                    SalesValue := 0;
                    SalesReturnValue := 0;
                    SalesReturnQuantity := 0;
                    IF "Item Ledger Entry"."Invoiced Quantity" < 0 THEN BEGIN
                      SalesQuantity := ABS("Item Ledger Entry"."Invoiced Quantity");
                      SalesValue := ABS("Item Ledger Entry"."Sales Amount (Actual)" +"Item Ledger Entry"."Sales Amount (Expected)");
                    END ELSE BEGIN
                      SalesReturnQuantity := "Item Ledger Entry"."Invoiced Quantity";
                      SalesReturnValue := "Item Ledger Entry"."Sales Amount (Actual)" + "Item Ledger Entry"."Sales Amount (Expected)";
                    END;
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
        CompanyInfo: Record "79";
        SalesQuantity: Decimal;
        SalesReturnQuantity: Decimal;
        SalesValue: Decimal;
        SalesReturnValue: Decimal;
        ReportName: Label 'Sales Summary - Product/Document Agent wise in Local Currency Including Sales Return';
}

