page 50058 "API Functions"
{
    EntityName = 'apiFunctionNames';
    EntitySetName = 'apiFunctions';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "API Functions Mgt.";

    layout
    {
        area(content)
        {
            field(primaryKey; "Primary Key")
            {
            }
        }
    }

    actions
    {
    }

    var
        NormalText: Text;

    [ServiceEnabled]
    procedure getpostedbatchquantity(ItemNo: Code[20]; BatchNo: Code[20]): Decimal
    var
        PostedAssemblyHeader: Record "Posted Assembly Header";
    begin
        PostedAssemblyHeader.RESET;
        PostedAssemblyHeader.SETRANGE("Item No.", ItemNo);
        PostedAssemblyHeader.SETRANGE("Batch No.", BatchNo);
        PostedAssemblyHeader.CALCSUMS(Quantity);
        EXIT(PostedAssemblyHeader.Quantity);
    end;

    [ServiceEnabled]
    procedure testmsg(): Text
    begin
        EXIT('{"test":"message","srt" : "srt1"}');
    end;
}

