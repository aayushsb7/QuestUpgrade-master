page 50003 "TDS Posting Group"
{
    PageType = List;
    SourceTable = "TDS Posting Group";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                }
                field(Description; Description)
                {
                }
                field("TDS%"; "TDS%")
                {
                }
                field("GL Account No."; "GL Account No.")
                {
                }
                field(Type; Type)
                {
                }
                field("Effective From"; "Effective From")
                {
                }
                field(Blocked; Blocked)
                {
                }
                field("TDS base excluing VAT"; "TDS base excluing VAT")
                {
                }
            }
        }
    }

    actions
    {
    }
}

