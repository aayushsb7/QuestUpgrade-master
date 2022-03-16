report 50065 "Posted Transfer Item Receipt"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PostedTransferItemReceipt.rdlc';

    dataset
    {
        dataitem(DataItem6; Table5746)
        {
            RequestFilterFields = "Posting Date", "No.";
            column(No_TransferReceiptHeader; "Transfer Receipt Header"."No.")
            {
            }
            dataitem(DataItem1; Table5747)
            {
                DataItemLink = Document No.=FIELD(No.);
                column(ItemNo_TransferReceiptLine; "Transfer Receipt Line"."Item No.")
                {
                }
                column(Description_TransferReceiptLine; "Transfer Receipt Line".Description)
                {
                }
                column(Quantity_TransferReceiptLine; "Transfer Receipt Line".Quantity)
                {
                }
                column(UnitofMeasureCode_TransferReceiptLine; "Transfer Receipt Line"."Unit of Measure Code")
                {
                }
                column(BatchNo_TransferReceiptLine; "Transfer Receipt Line"."Batch No.")
                {
                }
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
}

