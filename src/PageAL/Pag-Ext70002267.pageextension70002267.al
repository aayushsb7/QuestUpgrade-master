pageextension 70002267 "pageextension70002267" extends "Sales Return Order List"
{
    actions
    {
        modify(SendApprovalRequest)
        {
            Promoted = true;
            PromotedIsBig = true;
            PromotedCategory = Category4;
            PromotedOnly = true;
        }
        modify(CancelApprovalRequest)
        {
            Promoted = true;
            PromotedIsBig = true;
            PromotedCategory = Category4;
            PromotedOnly = true;
        }
    }
}

