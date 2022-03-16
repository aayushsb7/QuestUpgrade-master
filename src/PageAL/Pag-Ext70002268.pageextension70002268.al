pageextension 70002268 "pageextension70002268" extends "Sales Order List"
{
    actions
    {
        modify(Approvals)
        {
            PromotedOnly = true;
        }
        modify(CancelApprovalRequest)
        {
            Promoted = true;
            PromotedIsBig = true;
            PromotedCategory = Category4;
            PromotedOnly = true;
        }

        //Unsupported feature: Code Modification on "ReportFactBoxVisibility(Action 38).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        // save visibility value into the table
        CurrPage."Power BI Report FactBox".PAGE.SetFactBoxVisibility(PowerBIVisible);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF PowerBIVisible THEN
          PowerBIVisible := FALSE
        ELSE
          PowerBIVisible := TRUE;
        // save visibility value into the table
        CurrPage."Power BI Report FactBox".PAGE.SetFactBoxVisibility(PowerBIVisible);
        */
        //end;
    }


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF UserMgt.GetSalesFilter <> '' THEN BEGIN
      FILTERGROUP(2);
      SETRANGE("Responsibility Center",UserMgt.GetSalesFilter);
    #4..10
    IsOfficeAddin := OfficeMgt.IsAvailable;

    CopySellToCustomerFilter;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..13

    // Contextual Power BI FactBox: filtering available reports, setting context, loading Power BI related user settings
    CurrPage."Power BI Report FactBox".PAGE.SetNameFilter(CurrPage.CAPTION);
    CurrPage."Power BI Report FactBox".PAGE.SetContext(CurrPage.OBJECTID(FALSE));
    //PowerBIVisible := SetPowerBIUserConfig.SetUserConfig(PowerBIUserConfiguration,CurrPage.OBJECTID(FALSE));
    */
    //end;
}

