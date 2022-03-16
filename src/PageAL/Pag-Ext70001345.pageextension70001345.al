pageextension 50057 "pageextension70001345" extends "Value Entries"
{

    //Unsupported feature: Property Insertion (Permissions) on ""Value Entries"(Page 5802)".

    actions
    {
        addlast(Creation)
        {
            group(myAction)
            {
                action("Load PragyapanPatra ")
                {
                    Image = Process;

                    trigger OnAction()
                    begin
                        //GetPragyapanPatraFromPurchase;
                    end;
                }
                action("Update Unit Cost Temp")
                {

                    trigger OnAction()
                    var
                        TempCodeunit: Codeunit "Temporary Codeunit";
                    begin
                        TempCodeunit.UpdateUnitCostForFinishedGoods;
                    end;
                }
            }
        }


    }
}

