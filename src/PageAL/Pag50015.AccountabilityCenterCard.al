page 50015 "Accountability Center Card"
{
    Caption = 'Accountability Center Card';
    PageType = Card;
    SourceTable = "Accountability Center";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Code; Code)
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the responsibility center code.';
                }
                field(Name; Name)
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the name.';
                }
                field(Address; Address)
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the address associated with the responsibility center.';
                }
                field("Address 2"; "Address 2")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies additional address information.';
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the postal code.';
                }
                field(City; City)
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the city where the responsibility center is located.';
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the country/region of the address.';
                }
                field(Contact; Contact)
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the name of the person you regularly contact. ';
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the location of the responsibility center.';
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the responsibility center''s phone number.';
                }
                field("Fax No."; "Fax No.")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the fax number of the responsibility center.';
                }
                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = Advanced;
                    ExtendedDatatype = EMail;
                    ToolTip = 'Specifies the email address of the responsibility center.';
                }
                field("Home Page"; "Home Page")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the responsibility center''s web site.';
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering';
                group(Sales)
                {
                    Caption = 'Sales';
                    field("Sales Quote Nos."; "Sales Quote Nos.")
                    {
                    }
                    field("Sales Blanket Order Nos."; "Sales Blanket Order Nos.")
                    {
                    }
                    field("Sales Order Nos."; "Sales Order Nos.")
                    {
                    }
                    field("Sales Return Order Nos."; "Sales Return Order Nos.")
                    {
                    }
                    field("Sales Invoice Nos."; "Sales Invoice Nos.")
                    {
                    }
                    field("Sales Posted Invoice Nos."; "Sales Posted Invoice Nos.")
                    {
                    }
                    field("Sales Credit Memo Nos."; "Sales Credit Memo Nos.")
                    {
                    }
                    field("Sales Posted Credit Memo Nos."; "Sales Posted Credit Memo Nos.")
                    {
                    }
                    field("Sales Posted Shipment Nos."; "Sales Posted Shipment Nos.")
                    {
                    }
                    field("Sales Posted Prepmt. Inv. Nos."; "Sales Posted Prepmt. Inv. Nos.")
                    {
                    }
                    field("Sales Ptd. Prept. Cr. M. Nos."; "Sales Ptd. Prept. Cr. M. Nos.")
                    {
                    }
                    field("Sales Ptd. Return Receipt Nos."; "Sales Ptd. Return Receipt Nos.")
                    {
                    }
                    field("Delivery Detail Nos."; "Delivery Detail Nos.")
                    {
                    }
                }
                group(Purchase)
                {
                    Caption = 'Purchase';
                    field("Purch. Quote Nos."; "Purch. Quote Nos.")
                    {
                    }
                    field("Purch. Blanket Order Nos."; "Purch. Blanket Order Nos.")
                    {
                    }
                    field("Purch. Order Nos."; "Purch. Order Nos.")
                    {
                    }
                    field("Purch. Return Order Nos."; "Purch. Return Order Nos.")
                    {
                    }
                    field("Purch. Invoice Nos."; "Purch. Invoice Nos.")
                    {
                    }
                    field("Purch. Posted Invoice Nos."; "Purch. Posted Invoice Nos.")
                    {
                    }
                    field("Purch. Credit Memo Nos."; "Purch. Credit Memo Nos.")
                    {
                    }
                    field("Purch. Posted Credit Memo Nos."; "Purch. Posted Credit Memo Nos.")
                    {
                    }
                    field("Purch. Posted Receipt Nos."; "Purch. Posted Receipt Nos.")
                    {
                    }
                    field("Purch. Posted Prept. Inv. Nos."; "Purch. Posted Prept. Inv. Nos.")
                    {
                    }
                    field("Purch. Ptd. Prept. Cr. M. Nos."; "Purch. Ptd. Prept. Cr. M. Nos.")
                    {
                    }
                    field("Purch. Ptd. Return Shpt. Nos."; "Purch. Ptd. Return Shpt. Nos.")
                    {
                    }
                }
                group(Warehouse)
                {
                    Caption = 'Warehouse';
                    field("Trans. Order Nos."; "Trans. Order Nos.")
                    {
                    }
                    field("Posted Transfer Shpt. Nos."; "Posted Transfer Shpt. Nos.")
                    {
                    }
                    field("Posted Transfer Rcpt. Nos."; "Posted Transfer Rcpt. Nos.")
                    {
                    }
                }
            }
        }
        area(factboxes)
        {
            // systempart(; Links)
            // {
            //     Visible = false;
            // }
            // systempart(; Notes)
            // {
            //     Visible = false;
            // }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Resp. Ctr.")
            {
                Caption = '&Resp. Ctr.';
                Image = Dimensions;
                action(Dimensions)
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(5714),
                                  "No." = FIELD(Code);
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                }
            }
        }
    }
}

