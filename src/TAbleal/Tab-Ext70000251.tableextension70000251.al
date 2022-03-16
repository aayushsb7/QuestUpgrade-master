tableextension 70000251 "tableextension70000251" extends Customer
{
    fields
    {

        //Unsupported feature: Code Modification on ""VAT Bus. Posting Group"(Field 110).OnValidate".

        //trigger  Posting Group"(Field 110)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UpdateTaxAreaId;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        UpdateTaxAreaId;
        TESTFIELD("VAT Registration No."); //SRT June 5th 2019
        */
        //end;
        field(50000; "Expected Delivery Days"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Contact Person"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "No." = '' THEN BEGIN
      SalesSetup.GET;
      SalesSetup.TESTFIELD("Customer Nos.");
    #4..18

    UpdateReferencedIds;
    SetLastModifiedDateTime;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..21
    "Application Method" := "Application Method"::"Apply to Oldest";  //SRT June 5th 2019
    */
    //end;
}

