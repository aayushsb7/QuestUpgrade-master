pageextension 70000824 "pageextension70000824" extends "Sales Invoice Subform"
{

    //Unsupported feature: Property Modification (SourceTableView) on ""Sales Invoice Subform"(Page 47)".

    actions
    {

        //Unsupported feature: Code Modification on "DeferralSchedule(Action 17).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ShowDeferralSchedule;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TotalSalesHeader.GET("Document Type","Document No.");
        ShowDeferrals(TotalSalesHeader."Posting Date",TotalSalesHeader."Currency Code");
        //ShowDeferralSchedule;
        */
        //end;
    }


    //Unsupported feature: Property Modification (Id) on "ApplicationAreaMgmtFacade(Variable 1008)".

    //var
    //>>>> ORIGINAL VALUE:
    //ApplicationAreaMgmtFacade : 1008;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ApplicationAreaMgmtFacade : 1999;
    //Variable type has not been exported.

    var
        ApplicationAreaSetup: Record "9178";


        //Unsupported feature: Code Modification on "OnNewRecord".

        //trigger OnNewRecord(BelowxRec: Boolean)
        //>>>> ORIGINAL CODE:
        //begin
        /*
        InitType;
        SetDefaultType;

        CLEAR(ShortcutDimCode);
        UpdateTypeText;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        InitType;
        SetDefaultType;
        // Default to Item for the first line and to previous line type for the others
        IF ApplicationAreaSetup.IsFoundationEnabled THEN
          IF xRec."Document No." = '' THEN
            Type := Type::Item;
        #3..5
        */
        //end;
}

