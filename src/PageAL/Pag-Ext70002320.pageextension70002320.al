pageextension 50040 "pageextension70002320" extends "Session List"
{
    actions
    {
        addafter("Debug Next Session")
        {
            action("Kill Session")
            {
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    IF CONFIRM('Do you want to Kill the user session?') THEN
                        STOPSESSION("Session ID");
                end;
            }
        }
    }
}

