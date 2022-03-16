tableextension 50044 "tableextension70000723" extends "Integration Record"
{
    fields
    {
        field(50000; "Table Name"; Text[50])
        {
            CalcFormula = Lookup(Object.Name WHERE(ID = FIELD("Table ID"),
                                                    Type = CONST(Table)));
            Editable = false;
            FieldClass = FlowField;
        }
    }
}

