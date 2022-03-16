pageextension 70002220 "pageextension70002220" extends "Posted Assembly Orders"
{

    //Unsupported feature: Property Insertion (InsertAllowed) on ""Posted Assembly Orders"(Page 922)".


    //Unsupported feature: Property Insertion (DeleteAllowed) on ""Posted Assembly Orders"(Page 922)".


    //Unsupported feature: Property Insertion (ModifyAllowed) on ""Posted Assembly Orders"(Page 922)".

    layout
    {
        addafter("Control 24")
        {
            field("Batch No."; "Batch No.")
            {
            }
        }
    }
    actions
    {
        addafter(Navigate)
        {
            action("Update Document ID")
            {

                trigger OnAction()
                var
                    TempCodeunit: Codeunit "50005";
                begin
                    TempCodeunit.UpdateDocumentIDInPostedAssemblyLine;
                end;
            }
        }
    }
}

