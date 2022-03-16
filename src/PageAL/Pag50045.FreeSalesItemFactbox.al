page 50045 "Free Sales Item Factbox"
{
    PageType = ListPart;
    SourceTable = "Sales Line";
    SourceTableView = WHERE("Free Item Line" = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    Editable = false;
                }
                field(Description; Description)
                {
                    Editable = false;
                }
                field("Free Quantity"; Quantity)
                {
                    Caption = 'Free Quantity';
                    Editable = false;
                }
                field("Return Reason Code"; "Return Reason Code")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ItemTrackingLines)
            {
                ApplicationArea = ItemTracking;
                Caption = 'Select Batch';
                Image = ItemTrackingLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ShortCutKey = 'Shift+Ctrl+I';
                ToolTip = 'View or edit serial numbers and lot numbers that are assigned to the item on the document or journal line.';
                Visible = true;

                trigger OnAction()
                begin
                    OpenItemTrackingLines;
                end;
            }
        }
    }
}

