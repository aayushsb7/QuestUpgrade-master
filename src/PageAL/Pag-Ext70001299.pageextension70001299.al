pageextension 50074 "pageextension70001299" extends "Transfer Orders"
{
    layout
    {
        addlast(content)
        {
            field("Batch No."; "Batch No.")
            {
            }
            field("Posted Assembly Order"; "Posted Assembly Order")
            {
            }
            field("Manufacturing Date"; "Manufacturing Date")
            {
                Visible = false;
            }
            field("Expiy Date"; "Expiy Date")
            {
                Visible = false;
            }
        }
    }
    actions
    {
        addlast(Creation)
        {
            action("Temporary Receive")
            {
                Visible = false;

                trigger OnAction()
                var
                    TempCodeunit: Codeunit "Temporary Codeunit";
                begin
                    TempCodeunit.ReceiveMultiple;
                end;
            }
        }
    }
}

