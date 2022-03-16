pageextension 50083 "pageextension70000809" extends "No. Series"
{
    actions
    {
        addlast(Creation)
        {
            action(UnCheckAll)
            {
                Caption = 'Uncheck All';
                Image = Undo;
                ToolTip = 'To uncheck all the new no series created  to false';

                trigger OnAction()
                var
                    NoSeries: Record "No. Series";
                begin
                    IF NOT CONFIRM('Do you want to un-check all the new series line create tick?', FALSE) THEN
                        EXIT;

                    NoSeries.RESET;
                    NoSeries.SETRANGE("New Series Line Created", TRUE);
                    NoSeries.MODIFYALL("New Series Line Created", FALSE);
                end;
            }
        }
    }
}

