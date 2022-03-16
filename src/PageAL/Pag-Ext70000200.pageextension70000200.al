pageextension 50098 "pageextension70000200" extends "Posted Sales Invoice"
{

    //Unsupported feature: Property Insertion (DeleteAllowed) on ""Posted Sales Invoice"(Page 132)".


    //Unsupported feature: Property Insertion (ModifyAllowed) on ""Posted Sales Invoice"(Page 132)".

    layout
    {

        //Unsupported feature: Property Modification (Level) on "Control 88".


        //Unsupported feature: Property Modification (ControlType) on "Control 88".


        //Unsupported feature: Property Insertion (SourceExpr) on "Control 88".


        //Unsupported feature: Property Modification (Level) on "Control 85".


        //Unsupported feature: Property Modification (ControlType) on "Control 85".


        //Unsupported feature: Property Insertion (Name) on "Control 85".


        //Unsupported feature: Property Insertion (GroupType) on "Control 85".


        //Unsupported feature: Property Modification (Level) on "Control 87".


        //Unsupported feature: Property Modification (SourceExpr) on "Control 87".


        //Unsupported feature: Property Insertion (Name) on "Control 66".


        //Unsupported feature: Property Insertion (Name) on "Control 32".


        //Unsupported feature: Property Deletion (Visible) on "Control 88".


        //Unsupported feature: Property Deletion (GroupType) on "Control 88".


        //Unsupported feature: Property Deletion (CaptionML) on "Control 85".


        //Unsupported feature: Property Deletion (ToolTipML) on "Control 85".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control 85".


        //Unsupported feature: Property Deletion (SourceExpr) on "Control 85".


        //Unsupported feature: Property Deletion (Importance) on "Control 85".


        //Unsupported feature: Property Deletion (Editable) on "Control 85".


        //Unsupported feature: Property Deletion (CaptionML) on "Control 87".


        //Unsupported feature: Property Deletion (ToolTipML) on "Control 87".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control 87".


        //Unsupported feature: Property Deletion (Importance) on "Control 87".


        //Unsupported feature: Property Deletion (Editable) on "Control 87".

        // modify("Control 93")
        // {
        //     Visible = false;
        // }
        // modify("Control 95")
        // {
        //     Visible = false;
        // }
        addlast(content)
        {
            group(General1)
            {
                // Visible = IsSellToCountyVisible;//changed
                // field("Sell-to County"; "Sell-to County")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'County';
                //     Editable = false;
                //     Importance = Additional;
                //     ToolTip = 'Specifies the state, province or county as a part of the address.';
                // }
            }
        }
        addafter("Bill-to Contact")
        {
            // field("Sell-to Country/Region Code"; "Sell-to Country/Region Code")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Country/Region';
            //     Editable = false;
            //     Importance = Additional;
            //     ToolTip = 'Specifies the country or region of the address.';
            // }
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
                field(Cases; Cases)
                {
                }
                field("Doc. Thru."; "Doc. Thru.")
                {
                }
            }
            // field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
            // {
            //     ApplicationArea = Dimensions;
            //     Editable = false;
            //     ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
            // }
            // field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
            // {
            //     ApplicationArea = Dimensions;
            //     Editable = false;
            //     ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
            // }
            field("Shortcut Dimension 5 Code"; "Shortcut Dimension 5 Code")
            {
            }
            field("Shortcut Dimension 6 Code"; "Shortcut Dimension 6 Code")
            {
            }
        }


        // addafter("Control 38")
        // {
        //     group()
        //     {
        //         Visible = IsShipToCountyVisible;
        //     }
        // }
        // addafter("Control 24")
        // {
        //     group()
        //     {
        //         Visible = IsBillToCountyVisible;
        //     }
        // }
        // moveafter("Control 67"; "Control 6")
        // moveafter("Control 6"; "Control 96")
        // moveafter("Control 82"; "Control 85")
        // moveafter(Dimensions; "Control 87")
    }
    actions
    {


        //Unsupported feature: Code Insertion (VariableCollection) on "Print(Action 58).OnAction".

        //trigger (Variable: BillDeliveryDetail)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "Print(Action 58).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SalesInvHeader := Rec;
        CurrPage.SETSELECTIONFILTER(SalesInvHeader);
        SalesInvHeader.PrintRecords(TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SalesInvHeader := Rec;
        CurrPage.SETSELECTIONFILTER(SalesInvHeader);

        //check bill delivery details >> ASPL
        IF SalesInvHeader."No. Printed" = 0 THEN BEGIN
          BillDeliveryDetail.RESET;
          BillDeliveryDetail.SETRANGE("Sales Invoice No.",SalesInvHeader."No.");
          IF NOT BillDeliveryDetail.FINDFIRST THEN BEGIN
            IF CONFIRM('%1 not found for sales bill %2. Do you want to create bill delivery details and fill the delivery details?',FALSE,BillDeliveryDetail.TABLECAPTION,SalesInvHeader."No.") THEN BEGIN
              SysMgt.CreateAndOpenBillDeliveryDetail(SalesInvHeader);
              COMMIT;
            END;
          END;
        END;
        //check bill delivery details << ASPL

        SalesInvHeader.PrintRecords(TRUE);
        */
        //end;
        addfirst(Creation)
        {
            action("Batchwise Invoice")
            {
                Image = Print;

                trigger OnAction()
                var
                    SalesInvHdr: Record "Sales Invoice Header";
                begin
                    SalesInvHdr.RESET;
                    SalesInvHdr.SETRANGE("No.", "No.");
                    IF SalesInvHdr.FINDFIRST THEN
                        REPORT.RUN(50061, TRUE, FALSE, SalesInvHdr);
                end;
            }
        }
        addafter(ChangePaymentService)
        {
            action(DeliveryDetail)
            {
                Caption = 'Delivery Detail';
                Ellipsis = true;
                Image = Delivery;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    SysMgt.CreateAndOpenBillDeliveryDetail(Rec); //ASPL
                end;
            }
        }
    }

    var
        BillDeliveryDetail: Record "Bill Delivery Details";


    //Unsupported feature: Property Modification (Id) on "IsShipToCountyVisible(Variable 1013)".

    //var
    //>>>> ORIGINAL VALUE:
    //IsShipToCountyVisible : 1013;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //IsShipToCountyVisible : 1999;
    //Variable type has not been exported.

    var
        SysMgt: Codeunit "System Mgt. Quest";
}

