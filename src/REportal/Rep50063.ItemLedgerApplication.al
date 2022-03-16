report 50063 "Item Ledger Application"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ItemLedgerApplication.rdlc';

    dataset
    {
        dataitem(DataItem1; Table32)
        {
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
        ShowAppliedEntries: Codeunit "5801";
}

