page 50016 "Accountability Centers"
{
    Caption = 'Accountability Centers';
    CardPageID = "Accountability Center Card";
    Editable = false;
    PageType = List;
    SourceTable = "Accountability Center";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the responsibility center list code.';
                }
                field(Name; Name)
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the name.';
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the location of the responsibility center.';
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
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    action("Dimensions-Single")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Dimensions-Single';
                        Image = Dimensions;
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID" = CONST(5714),
                                      "No." = FIELD(Code);
                        ShortCutKey = 'Shift+Ctrl+D';
                        ToolTip = 'View or edit the single set of dimensions that are set up for the selected record.';
                    }
                    action("Dimensions-&Multiple")
                    {
                        AccessByPermission = TableData 348 = R;
                        ApplicationArea = Dimensions;
                        Caption = 'Dimensions-&Multiple';
                        Image = DimensionSets;
                        ToolTip = 'View or edit dimensions for a group of records. You can assign dimension codes to transactions to distribute costs and analyze historical information.';

                        trigger OnAction()
                        var
                            RespCenter: Record "Responsibility Center";
                            DefaultDimMultiple: Page "Default Dimensions-Multiple";
                        begin
                            CurrPage.SETSELECTIONFILTER(RespCenter);
                            //DefaultDimMultiple.SetMultiRespCenter(RespCenter);
                            DefaultDimMultiple.RUNMODAL;
                        end;
                    }
                }
            }
        }
    }
}

