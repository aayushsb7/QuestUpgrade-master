page 50035 "Item Journal Entity"
{
    Caption = 'itemjournals', Locked = true;
    DelayedInsert = true;
    EntityName = 'itemjournal';
    EntitySetName = 'itemjournals';
    ODataKeyFields = Id;
    PageType = API;
    SourceTable = "Item Journal Batch";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Id; Id)
                {
                }
                field("code"; Name)
                {
                    ApplicationArea = All;
                    Caption = 'code', Locked = true;
                }
                field(displayName; Description)
                {
                    ApplicationArea = All;
                    Caption = 'DisplayName', Locked = true;
                }
                field("Last Modified DateTime"; "Last Modified DateTime")
                {
                    Editable = false;
                }
            }
            part(itemjournalLines; 50036)
            {
                ApplicationArea = All;
                Caption = 'ItemJournalLines', Locked = true;
                EntityName = 'itemjournalLine';
                EntitySetName = 'itemjournalLines';
                SubPageLink ="Item Journal Batch Id"=FIELD(Id);
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Journal Template Name" := GraphMgtJournal.GetDefaultJournalLinesTemplateName;
    end;

    trigger OnOpenPage()
    begin
        SETRANGE("Journal Template Name", GraphMgtJournal.GetDefaultJournalLinesTemplateName);
    end;

    var
        GraphMgtJournal: Codeunit "Graph Mgt - Journal";
        CannotFindItemJnlLineErr: Label 'The item journal line cannot be found.';

    local procedure GetDraftItemJournalLines(var ItemJournalLine: Record "Item Journal Line")
    begin
        ItemJournalLine.SETRANGE("Item Journal Batch Id", Id);
        IF NOT ItemJournalLine.FINDFIRST THEN
            ERROR(CannotFindItemJnlLineErr);
    end;

    local procedure PostItemJournal(var ItemJournalLine: Record "Item Journal Line")
    var
        DummyO365SalesDocument: Record "O365 Sales Document";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        O365SendResendInvoice: Codeunit "O365 Send + Resend Invoice";
        PreAssignedNo: Code[20];
    begin
        LinesInstructionMgt.ItemJournalCheckAllLinesHaveQuantityPerAssigned(ItemJournalLine);
        ItemJournalLine.SendToPosting(CODEUNIT::"Item Jnl.-Post Batch");
    end;

    [ServiceEnabled]
    procedure Post(var ActionContext: DotNet WebServiceActionContext)
    var
        ItemJournalLine: Record "Item Journal Line";
    begin
        GetDraftItemJournalLines(ItemJournalLine);
        PostItemJournal(ItemJournalLine);
        SetActionResponse(ActionContext, ItemJournalLine.Id);
    end;

    local procedure SetActionResponse(var ActionContext: DotNet WebServiceActionContext; InvoiceId: Guid)
    var
        ODataActionManagement: Codeunit "OData Action Management";
        ItemJournalLine: Record "Item Journal Line";
    begin
        /*ODataActionManagement.AddKey(FIELDNO(Id),InvoiceId);
        ODataActionManagement.SetDeleteResponseLocation(ActionContext,PAGE::"Item Journal Lines Entity");*/
        //SRT July 28th 2019 >>
        ItemJournalLine.RESET;
        ItemJournalLine.SETRANGE(Id, InvoiceId);
        IF ItemJournalLine.FINDFIRST THEN
            ItemJournalLine.DELETE(TRUE);
        //SRT July 28th 2019 <<

    end;
}

