tableextension 70000409 "tableextension70000409" extends "Item Journal Batch"
{
    fields
    {
        field(50000; Id; Guid)
        {
            Caption = 'Id';
            DataClassification = ToBeClassified;
        }
        field(50001; "Last Modified DateTime"; DateTime)
        {
            Caption = 'Last Modified DateTime';
            DataClassification = ToBeClassified;
        }
    }


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    LOCKTABLE;
    ItemJnlTemplate.GET("Journal Template Name");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    LOCKTABLE;
    ItemJnlTemplate.GET("Journal Template Name");
    //SRT July 5th 2019 >>
    Id := CREATEGUID;
    SetLastModifiedDateTime;
    //SRT July 5th 2019 <<
    */
    //end;


    //Unsupported feature: Code Insertion on "OnModify".

    //trigger OnModify()
    //begin
    /*
    SetLastModifiedDateTime; //SRT July 5th 2019
    */
    //end;

    local procedure SetLastModifiedDateTime()
    begin
        "Last Modified DateTime" := CURRENTDATETIME;
    end;
}

