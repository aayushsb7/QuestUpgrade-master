page 50022 "Nepali Calendar"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "English-Nepali Date";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("English Year"; "English Year")
                {
                }
                field("English Month"; "English Month")
                {
                }
                field("English Day"; "English Day")
                {
                }
                field(Week; Week)
                {
                }
                field("English Date"; "English Date")
                {
                }
                field("Week Integer"; "Week Integer")
                {
                }
                field("Day Off"; "Day Off")
                {
                }
                field("Nepali Date"; "Nepali Date")
                {
                }
                field("Nepali Year"; "Nepali Year")
                {
                }
                field("Nepali Month"; "Nepali Month")
                {
                }
                field("Nepali Day"; "Nepali Day")
                {
                }
                field("Fiscal Year"; "Fiscal Year")
                {
                }
                field("Floating Holiday"; "Floating Holiday")
                {
                }
                field(Description; Description)
                {
                }
                field("Open Date for Appraisal"; "Open Date for Appraisal")
                {
                }
                field("Close Date for Appraisal"; "Close Date for Appraisal")
                {
                }
                field("Opening Fiscal Year"; "Opening Fiscal Year")
                {
                }
                field("Closing Fiscal Year"; "Closing Fiscal Year")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Updatedate)//
            {
                action(Update)
                {

                    trigger OnAction()
                    begin
                        TempCodeunit.UpdateEngNepDate;
                    end;
                }
            }
        }
    }

    var
        TempCodeunit: Codeunit "Temporary Codeunit";
}

