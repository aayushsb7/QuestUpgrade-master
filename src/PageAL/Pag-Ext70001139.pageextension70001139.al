pageextension 50065 "pageextension70001139" extends "Vendor Entity"
{
    layout
    {
        addafter(displayName)
        {
            field(vendorGroup; "Vendor Posting Group")
            {
                Caption = 'vendorGroup';

                trigger OnValidate()
                begin
                    RegisterFieldSet(FIELDNO("Vendor Posting Group")); //SRT July 10th 2019
                end;
            }
        }
    }
}

