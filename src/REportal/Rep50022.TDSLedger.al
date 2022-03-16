report 50022 "TDS Ledger"
{
    DefaultLayout = RDLC;
    RDLCLayout = './TDSLedger.rdlc';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(DataItem1; Table50006)
        {
            RequestFilterFields = "Posting Date";
            column(TDS_Posting_Group; "Original TDS Entry"."TDS Posting Group")
            {
            }
            column(TDS_Base; "Original TDS Entry"."Original Base")
            {
            }
            column(TDS_Amount; "Original TDS Entry"."Original TDS Amount")
            {
            }
            column(TDS_Vendor_No; "Original TDS Entry"."Bill-to/Pay-to No.")
            {
            }
            column(VendorName; VendorName)
            {
            }
            column(TDSPostingGroupName; TDSPostingGroupName)
            {
            }
            column(Comapnay_Name; CompanyInfo.Name)
            {
            }
            column(Report_Title; Report_Title)
            {
            }
            column("Filter"; Filter)
            {
            }
            column(Narration; Narration)
            {
            }
            column(ShowNarration; ShowNarration)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(VendorName);
                CLEAR(Narration);
                Vendor.RESET;
                Vendor.SETRANGE("No.", "Original TDS Entry"."Bill-to/Pay-to No.");
                IF Vendor.FINDFIRST THEN
                    VendorName := Vendor.Name;

                CLEAR(TDSPostingGroupName);
                TDSPostingGroup.RESET;
                TDSPostingGroup.SETRANGE(TDSPostingGroup.Code, "Original TDS Entry"."TDS Posting Group");
                IF TDSPostingGroup.FINDFIRST THEN
                    TDSPostingGroupName := TDSPostingGroup.Description;

                //since all glentry of a single transaction will have same narration
                GlEntry.RESET;
                GlEntry.SETRANGE("Document No.", "Original TDS Entry"."Document No.");
                GlEntry.SETFILTER(Narration, '<>%1', '');
                IF GlEntry.FINDFIRST THEN
                    Narration := GlEntry.Narration;
            end;

            trigger OnPreDataItem()
            begin
                Filter := "Original TDS Entry".GETFILTERS;
                //MESSAGE(Filter);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(ShowNarration; ShowNarration)
                {
                    Caption = 'Show Narration';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInfo.GET;
    end;

    var
        Vendor: Record "23";
        VendorName: Text[50];
        TDSPostingGroup: Record "50004";
        TDSPostingGroupName: Text[100];
        CompanyInfo: Record "79";
        Report_Title: Label 'TDS Ledger';
        "Filter": Text[100];
        Narration: Text;
        GlEntry: Record "17";
        ShowNarration: Boolean;
        NArr: Label 'Narr: ';
}

