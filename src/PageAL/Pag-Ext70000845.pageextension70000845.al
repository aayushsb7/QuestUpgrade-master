pageextension 50077 "pageextension70000845" extends "Purchase Quote"
{

    //Unsupported feature: Property Modification (Id) on "IsBuyFromCountyVisible(Variable 1017)".

    //var
    //>>>> ORIGINAL VALUE:
    //IsBuyFromCountyVisible : 1017;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //IsBuyFromCountyVisible : 1999;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "IsPayToCountyVisible(Variable 1018)".

    //var
    //>>>> ORIGINAL VALUE:
    //IsPayToCountyVisible : 1018;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //IsPayToCountyVisible : 1998;
    //Variable type has not been exported.

    var
        "--Customization": Integer;
        CompanyInfo: Record "Company Information";


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
      FILTERGROUP(2);
      SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
      FILTERGROUP(0);
    END;

    SETRANGE("Date Filter",0D,WORKDATE);

    ActivateFields;

    SetDocNoVisible;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
      FILTERGROUP(2);
      IF NOT CompanyInfo."Activate Local Resp. Center" THEN
        SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter)
      ELSE
        SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
    #4..11
    */
    //end;
}

