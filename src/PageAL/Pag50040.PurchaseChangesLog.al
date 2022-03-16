page 50040 "Purchase Changes Log"
{
    Editable = true;
    PageType = ListPart;
    SourceTable = "Purchase Change Log";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Modified Date"; "Modified Date")
                {
                    Caption = 'Modified Date';
                    Editable = IsEditable;
                }
                field(Remarks; Remarks)
                {
                    Caption = 'Remarks';
                    Editable = IsEditable;
                    ExtendedDatatype = URL;
                    Importance = Promoted;
                    ShowMandatory = true;
                    Style = AttentionAccent;
                    StyleExpr = TRUE;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        IF "External Entry" THEN
            IsEditable := FALSE
        ELSE
            IsEditable := TRUE;
    end;

    trigger OnAfterGetRecord()
    begin
        IF "External Entry" THEN
            IsEditable := FALSE
        ELSE
            IsEditable := TRUE;
    end;

    var
        IsEditable: Boolean;
}

