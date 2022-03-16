pageextension 50070 "pageextension70002062" extends "Job List"
{
    actions
    {
        addlast(Creation)
        {
            action("Upate Nepali Document Date")
            {

                trigger OnAction()
                begin
                    IF NOT CONFIRM('Do you want to continue?', FALSE) THEN
                        EXIT;
                    CLEAR(TempCodeunit);
                    TempCodeunit.UpdateNepaliDate;
                end;
            }
        }
    }

    var
        TempCodeunit: Codeunit "Temporary Codeunit";
}

