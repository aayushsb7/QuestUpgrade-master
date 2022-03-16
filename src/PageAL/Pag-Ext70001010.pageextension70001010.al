pageextension 50069 "pageextension70001010" extends "Employee List"
{
    actions
    {
        addafter("Action 43")
        {
            action("Delete All")
            {
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;

                trigger OnAction()
                begin
                    Employee.DELETEALL;
                end;
            }
        }
    }

    var
        Employee: Record "5200";
}

