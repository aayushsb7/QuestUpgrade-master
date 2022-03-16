page 50039 "Purch. Change Log API"
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
                field(purchaseDocumentID; "Purchase Document ID")
                {
                    Caption = 'purchaseDocumentID';
                    Visible = false;
                }
                field(modifiedDate; "Modified Date")
                {
                    Caption = 'Modified Date';
                }
                field(remarks; Remarks)
                {
                    Caption = 'Remarks';
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

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "External Entry" := TRUE;
    end;
}

