table 50000 "English-Nepali Date"
{
    Caption = 'English-Nepali Date';

    fields
    {
        field(1; "English Year"; Integer)
        {
        }
        field(2; "English Month"; Option)
        {
            OptionCaption = ' ,January,February,March,April,May,June,July,August,September,October,November,December';
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
        }
        field(3; "English Day"; Integer)
        {
        }
        field(4; Week; Option)
        {
            OptionMembers = " ",Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday;
        }
        field(5; "English Date"; Date)
        {
        }
        field(6; "Week Integer"; Integer)
        {
        }
        field(7; "Day Off"; Boolean)
        {
        }
        field(8; "Nepali Date"; Code[10])
        {
        }
        field(9; "Nepali Year"; Integer)
        {
        }
        field(10; "Nepali Month"; Option)
        {
            OptionCaption = ' ,Baisakh,Jestha,Asar,Shrawan,Bhadra,Ashoj,Kartik,Mangsir,Poush,Margh,Falgun,Chaitra';
            OptionMembers = " ",Baisakh,Jestha,Asar,Shrawan,Bhadra,Ashoj,Kartik,Mangsir,Poush,Margh,Falgun,Chaitra;
        }
        field(11; "Nepali Day"; Integer)
        {
        }
        field(12; "Fiscal Year"; Code[10])
        {
        }
        field(13; "Floating Holiday"; Boolean)
        {
        }
        field(14; Description; Text[30])
        {
        }
        field(15; "Open Date for Appraisal"; Boolean)
        {
        }
        field(16; "Close Date for Appraisal"; Boolean)
        {
        }
        field(17; "Opening Fiscal Year"; Boolean)
        {
        }
        field(18; "Closing Fiscal Year"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Nepali Year", "English Year", "English Month", "English Day")
        {
            Clustered = true;
        }
        key(Key2; "Fiscal Year")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Fiscal Year")
        {
        }
    }


    procedure getNepaliDate(EngDate: Date): Code[10]
    var
        EnglishNepaliDate: Record "English-Nepali Date";
        Text0000: Label 'Cannot find the equivalant Nepali Date! Please contact your system administrator.';
    begin
        EnglishNepaliDate.RESET;
        EnglishNepaliDate.SETRANGE("English Date", EngDate);
        IF EnglishNepaliDate.FIND('-') THEN
            EXIT(EnglishNepaliDate."Nepali Date");
    end;


    procedure getNepaliMonth(EngDate: Date): Text[100]
    var
        EnglishNepaliDate: Record "English-Nepali Date";
        Text0000: Label 'Cannot find the equivalant Nepali Date! Please contact your system administrator.';
    begin
        EnglishNepaliDate.RESET;
        EnglishNepaliDate.SETRANGE("English Date", EngDate);
        IF EnglishNepaliDate.FIND('-') THEN
            EXIT(FORMAT(EnglishNepaliDate."Nepali Month"));
    end;

    procedure getNepaliYear(EngDate: Date): Integer
    var
        Text0000: Label 'Cannot find the equivalant Nepali Date! Please contact your system administrator.';
        EnglishNepaliDate: Record "English-Nepali Date";
    begin
        EnglishNepaliDate.RESET;
        EnglishNepaliDate.SETRANGE("English Date", EngDate);
        IF EnglishNepaliDate.FIND('-') THEN
            EXIT(EnglishNepaliDate."Nepali Year");
    end;


    procedure getEngDate(NepDate: Code[20]): Date
    var
        Text001: Label 'Cannot find equivalant English Date! Please contact your system administrator.';
        EnglishNepaliDate: Record "English-Nepali Date";
    begin
        EnglishNepaliDate.RESET;
        EnglishNepaliDate.SETRANGE("Nepali Date", NepDate);
        IF EnglishNepaliDate.FIND('-') THEN
            EXIT(EnglishNepaliDate."English Date");
    end;
}

