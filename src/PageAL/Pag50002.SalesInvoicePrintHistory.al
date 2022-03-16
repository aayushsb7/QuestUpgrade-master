page 50002 "Sales Invoice Print History"
{
    PageType = List;
    SourceTable = "Sales Invoice Print History";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Type)
                {
                    Editable = false;
                }
                field("Times Printed"; "Times Printed")
                {
                    Editable = false;
                }
                field("Printing Date"; "Printing Date")
                {
                    Editable = false;
                }
                field("Printed Time"; "Printed Time")
                {
                    Editable = false;
                }
                field("Printed By"; "Printed By")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

