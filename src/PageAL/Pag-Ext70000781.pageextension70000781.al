pageextension 50084 "pageextension70000781" extends "Sales Invoice"
{
    layout
    {

        //Unsupported feature: Property Modification (Level) on "Control 81".


        //Unsupported feature: Property Modification (SourceExpr) on "Control 81".


        //Unsupported feature: Property Modification (Level) on "Control 73".


        //Unsupported feature: Property Modification (SourceExpr) on "Control 73".


        //Unsupported feature: Property Deletion (CaptionML) on "Control 81".


        //Unsupported feature: Property Deletion (ToolTipML) on "Control 81".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control 81".


        //Unsupported feature: Property Deletion (Importance) on "Control 81".


        //Unsupported feature: Property Deletion (QuickEntry) on "Control 81".

        // modify("Control 73.OnValidate")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (CaptionML) on "Control 73".


        //Unsupported feature: Property Deletion (ToolTipML) on "Control 73".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control 73".


        //Unsupported feature: Property Deletion (Importance) on "Control 73".


        //Unsupported feature: Property Deletion (QuickEntry) on "Control 73".

        addlast(content)
        {
            // field("Sell-to Post Code"; "Sell-to Post Code")//alreadydefined
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Post Code';
            //     Importance = Additional;
            //     QuickEntry = false;
            //     ToolTip = 'Specifies the postal code.';
            // }
            // field("Sell-to Country/Region Code"; "Sell-to Country/Region Code")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Country/Region Code';
            //     Importance = Additional;
            //     QuickEntry = false;
            //     ToolTip = 'Specifies the country or region of the address.';

            //     trigger OnValidate()
            //     begin
            //         IsSellToCountyVisible := FormatAddress.UseCounty("Sell-to Country/Region Code");
            //     end;
            // }
        }
        addafter(SalesLines)
        {
            group("Dispatch Details")
            {
                field("Transport Name"; "Transport Name")
                {
                }
                field("CN No."; "CN No.")
                {
                }
                field("Dispatch Date"; "Dispatch Date")
                {
                }
                field("M.R."; "M.R.")
                {
                }
            }
        }
        // moveafter("Control 70"; "Control 87")
    }

    var
        CompanyInfo: Record "Company Information";


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    JobQueuesUsed := SalesReceivablesSetup.JobQueueActive;
    SetExtDocNoMandatoryCondition;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    JobQueuesUsed := SalesReceivablesSetup.JobQueueActive;
    SetExtDocNoMandatoryCondition;
    CompanyInfo.GET;
    */
    //end;


    //Unsupported feature: Code Modification on "UpdatePaymentService(PROCEDURE 7)".

    //procedure UpdatePaymentService();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PaymentServiceEnabled := PaymentServiceSetup.CanChangePaymentService(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    PaymentServiceVisible := PaymentServiceSetup.IsPaymentServiceVisible;
    PaymentServiceEnabled := PaymentServiceSetup.CanChangePaymentService(Rec);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "OnBeforeStatisticsAction(PROCEDURE 1)".

}

