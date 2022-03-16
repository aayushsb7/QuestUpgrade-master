pageextension 50062 "pageextension70001203" extends "Fixed Asset Card"
{
    layout
    {
        // modify(DepreciationTableCode)//change
        // {
        //     Visible = false;
        // }
        addlast(General)
        {
            field("Insurance No."; "Insurance No.")
            {
            }
        }
        addafter(BookValue)
        {
            field(DepreciationTableCode; FADepreciationBook."Depreciation Table Code")
            {
                ApplicationArea = FixedAssets;
                Caption = 'Depreciation Table Code';
                Importance = Additional;
                TableRelation = "Depreciation Table Header";
                ToolTip = 'Specifies the code of the depreciation table to use if you have selected the User-Defined option in the Depreciation Method field.';

                trigger OnValidate()
                begin
                    LoadDepreciationBooks;
                    FADepreciationBook.VALIDATE("Depreciation Table Code");
                    SaveSimpleDepriciationBook(xRec."No.");
                end;
            }
        }
    }
    actions
    {
        addlast(Creation)
        {
            action("Custo&dian")
            {
                Caption = 'Custo&dian';
                Image = NewCustomer;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page 50024;
                RunPageLink = "FA No." = FIELD("No.");
            }
        }
    }

    //Unsupported feature: Variable Insertion (Variable: FADepreciationBookLcl) (VariableCollection) on "SetDefaultPostingGroup(PROCEDURE 22)".

}

