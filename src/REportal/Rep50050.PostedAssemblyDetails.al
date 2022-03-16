report 50050 "Posted Assembly Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PostedAssemblyDetails.rdlc';

    dataset
    {
        dataitem(DataItem1; Table910)
        {
            RequestFilterFields = "Posting Date", "Item No.";
            column(ItemNo_PostedAssemblyHeader; "Posted Assembly Header"."Item No.")
            {
            }
            column(No_PostedAssemblyHeader; "Posted Assembly Header"."No.")
            {
            }
            column(Description_PostedAssemblyHeader; "Posted Assembly Header".Description)
            {
            }
            column(BatchNo_PostedAssemblyHeader; "Posted Assembly Header"."Batch No.")
            {
            }
            column(ManufacturingDate_PostedAssemblyHeader; FORMAT("Posted Assembly Header"."Manufacturing Date"))
            {
            }
            column(ExpiryDate_PostedAssemblyHeader; FORMAT("Posted Assembly Header"."Expiry Date"))
            {
            }
            column(OutputCost; OutputCost)
            {
            }
            column(ConsumptionCost; ConsumptionCost)
            {
            }
            column(ShippedTransferCost; ShippedTransferCost)
            {
            }
            column(ReceivedTransferCost; ReceivedTransferCost)
            {
            }
            column(PostingDate_PostedAssemblyHeader; FORMAT("Posted Assembly Header"."Posting Date"))
            {
            }
            column(AllFilters; AllFilters)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ConsumptionCost := 0;
                OutputCost := 0;
                ShippedTransferCost := 0;
                ReceivedTransferCost := 0;
                ConsumptionValueEntry.RESET;
                ConsumptionValueEntry.SETRANGE("Document No.", "No.");
                ConsumptionValueEntry.SETRANGE("Item Ledger Entry Type", ConsumptionValueEntry."Item Ledger Entry Type"::"Assembly Consumption");
                ConsumptionValueEntry.SETRANGE("Entry Type", ConsumptionValueEntry."Entry Type"::"Direct Cost");
                IF ConsumptionValueEntry.FINDFIRST THEN BEGIN
                    ConsumptionValueEntry.CALCSUMS("Cost Amount (Actual)");
                    ConsumptionCost := ConsumptionValueEntry."Cost Amount (Actual)";
                END;

                OutputValueEntry.RESET;
                OutputValueEntry.SETRANGE("Document No.", "No.");
                OutputValueEntry.SETRANGE("Item Ledger Entry Type", OutputValueEntry."Item Ledger Entry Type"::"Assembly Output");
                OutputValueEntry.SETRANGE("Entry Type", OutputValueEntry."Entry Type"::"Direct Cost");
                IF OutputValueEntry.FINDFIRST THEN
                    OutputCost := OutputValueEntry."Cost Amount (Actual)";

                ShipmentHdr.RESET;
                ShipmentHdr.SETRANGE("Posted Assembly Order", "Posted Assembly Header"."No.");
                IF ShipmentHdr.FINDFIRST THEN
                    REPEAT
                        ValueEntry.RESET;
                        ValueEntry.SETRANGE("Document No.", ShipmentHdr."No.");
                        ValueEntry.SETRANGE("Document Type", ValueEntry."Document Type"::"Transfer Shipment");
                        ValueEntry.SETRANGE("Location Code", ShipmentHdr."Transfer-from Code");
                        IF ValueEntry.FINDFIRST THEN BEGIN
                            ValueEntry.CALCSUMS("Cost Amount (Actual)");
                            ShippedTransferCost := ValueEntry."Cost Amount (Actual)";
                        END;
                    UNTIL ShipmentHdr.NEXT = 0;

                ReceiptHdr.RESET;
                ReceiptHdr.SETRANGE("Posted Assembly Order", "Posted Assembly Header"."No.");
                IF ReceiptHdr.FINDFIRST THEN
                    REPEAT
                        ValueEntry.RESET;
                        ValueEntry.SETRANGE("Document No.", ReceiptHdr."No.");
                        ValueEntry.SETRANGE("Document Type", ValueEntry."Document Type"::"Transfer Receipt");
                        ValueEntry.SETRANGE("Location Code", ReceiptHdr."Transfer-to Code");
                        IF ValueEntry.FINDFIRST THEN BEGIN
                            ValueEntry.CALCSUMS("Cost Amount (Actual)");
                            ReceivedTransferCost := ValueEntry."Cost Amount (Actual)";
                        END;
                    UNTIL ShipmentHdr.NEXT = 0;
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

    trigger OnPreReport()
    begin
        AllFilters := "Posted Assembly Header".GETFILTERS;
    end;

    var
        ConsumptionCost: Decimal;
        OutputCost: Decimal;
        ValueEntry: Record "5802";
        OutputValueEntry: Record "5802";
        PostedAssemblyHeader: Record "910";
        ConsumptionValueEntry: Record "5802";
        AllFilters: Text;
        ShippedTransferCost: Decimal;
        ReceivedTransferCost: Decimal;
        ShipmentHdr: Record "5744";
        ReceiptHdr: Record "5746";
}

