pageextension 50052 "pageextension70001698" extends "Purchase Return Order"
{
    layout
    {

        //Unsupported feature: Property Modification (Level) on "Control 64".


        //Unsupported feature: Property Modification (SourceExpr) on "Control 64".


        //Unsupported feature: Property Deletion (CaptionML) on "Control 64".


        //Unsupported feature: Property Deletion (ToolTipML) on "Control 64".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control 64".


        //Unsupported feature: Property Deletion (Importance) on "Control 64".


        addfirst(General)
        {
            // field("Buy-from County"; "Buy-from County")
            // {
            //     ApplicationArea = PurchReturnOrder;
            //     Caption = 'County';
            //     Importance = Additional;
            //     ToolTip = 'Specifies the county of the address.';
            // }
        }
        // moveafter("Control 69"; "Control 68")
    }

    var
        CompanyInfo: Record "Company Information";


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    JobQueueUsed := PurchasesPayablesSetup.JobQueueActive;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    JobQueueUsed := PurchasesPayablesSetup.JobQueueActive;
    CompanyInfo.GET; //SRT June 24th 2019
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetDocNoVisible;

    IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
      FILTERGROUP(2);
      SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
      FILTERGROUP(0);
    END;
    IF ("No." <> '') AND ("Buy-from Vendor No." = '') THEN
      DocumentIsPosted := (NOT GET("Document Type","No."));

    ActivateFields;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
      IF NOT CompanyInfo."Activate Local Resp. Center" THEN
        SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter)
      ELSE
    #5..11
    */
    //end;
}

