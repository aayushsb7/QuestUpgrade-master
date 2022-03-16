report 50033 "FA Ledger Entry Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './FALedgerEntryReport.rdlc';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(DataItem2285; Table5612)
        {
            DataItemTableView = SORTING (FA No., Depreciation Book Code);
            RequestFilterFields = "FA No.", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Acquisition Date", "Disposal Date";
            column(Filters; Filters)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(FA_Depreciation_Book__FA_No__; "FA No.")
            {
            }
            column(AcquisitionDateFilter; AcquisitionDateFilter)
            {
            }
            column(FA_Depreciation_Book__Acquisition_Cost_; "Acquisition Cost")
            {
            }
            column(FA_Depreciation_Book__FA_Class_Code_; "FA Class Code")
            {
            }
            column(FA_Depreciation_Book__FA_Subclass_Code_; "FA Subclass Code")
            {
            }
            column(FA_Depreciation_Book__Shortcut_Dimension_1_Code_; "Shortcut Dimension 1 Code")
            {
            }
            column(FA_Depreciation_Book__Shortcut_Dimension_2_Code_; "Shortcut Dimension 2 Code")
            {
            }
            column(FA_Depreciation_Book__Shortcut_Dimension_3_Code_; "Shortcut Dimension 3 Code")
            {
            }
            column(Loc; Loc)
            {
            }
            column(FAName; FAName)
            {
            }
            column(FA_Depreciation_Book__Acquisition_Date_; "Acquisition Date")
            {
            }
            column(CustName; CustName)
            {
            }
            column(GRNNo; GRNNo)
            {
            }
            column(TotalAcquisitionCost; TotalAcquisitionCost)
            {
            }
            column(FA_LedgerCaption; FA_LedgerCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Nepal_Red_Cross_Society__NRCS_Caption; Nepal_Red_Cross_Society__NRCS_CaptionLbl)
            {
            }
            column(Assets_Detail_ReportCaption; Assets_Detail_ReportCaptionLbl)
            {
            }
            column(FA_Depreciation_Book__FA_No__Caption; FIELDCAPTION("FA No."))
            {
            }
            column(FA_Depreciation_Book__Acquisition_Cost_Caption; FIELDCAPTION("Acquisition Cost"))
            {
            }
            column(FA_SubClassCaption; FA_SubClassCaptionLbl)
            {
            }
            column(FA_ClassCaption; FA_ClassCaptionLbl)
            {
            }
            column(FA_Depreciation_Book__Shortcut_Dimension_1_Code_Caption; FIELDCAPTION("Shortcut Dimension 1 Code"))
            {
            }
            column(FA_Depreciation_Book__Shortcut_Dimension_2_Code_Caption; FIELDCAPTION("Shortcut Dimension 2 Code"))
            {
            }
            column(FA_Depreciation_Book__Shortcut_Dimension_3_Code_Caption; FIELDCAPTION("Shortcut Dimension 3 Code"))
            {
            }
            column(LocCaption; LocCaptionLbl)
            {
            }
            column(FANameCaption; FANameCaptionLbl)
            {
            }
            column(Aquisition_DateCaption; Aquisition_DateCaptionLbl)
            {
            }
            column(CustNameCaption; CustNameCaptionLbl)
            {
            }
            column(GRN_No_Caption; GRN_No_CaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(FA_Depreciation_Book_Depreciation_Book_Code; "Depreciation Book Code")
            {
            }
            column(GlobalDimension1; FARec."Shortcut Dimension 1 Code")
            {
            }
            column(GlobalDimension2; FARec."Shortcut Dimension 2 Code")
            {
            }
            column(ShortcutDimension3Code_FADepreciationBook; "FA Depreciation Book"."Shortcut Dimension 3 Code")
            {
            }
            column(FALocation; FARec."FA Location Code")
            {
            }

            trigger OnAfterGetRecord()
            var
                OldEntryNo: Integer;
            begin
                //"FA Depreciation Book".CALCFIELDS("Shortcut Dimension 1 Code","Shortcut Dimension 3 Code");
                // Feb 5th 2014 >>
                /*IF Dim3Filter <> '' THEN BEGIN
                  FALedgerEntry.RESET;
                  FALedgerEntry.SETCURRENTKEY("FA No.","Depreciation Book Code","FA Posting Date");
                  FALedgerEntry.SETRANGE("FA No.","FA No.");
                  IF FALedgerEntry.FINDLAST THEN BEGIN
                    OldEntryNo := FALedgerEntry."Entry No.";
                    FALedgerEntry.SETFILTER("New Department Code",Dim3Filter);
                    IF FALedgerEntry.FINDLAST THEN BEGIN
                      IF FALedgerEntry."Entry No." <> OldEntryNo THEN
                        CurrReport.SKIP;
                    END;
                  END;
                END;*/
                // Feb 5th 2014 <<

                IF NoFac THEN
                    "FA Class Code" := '';
                IF NoAcDate THEN
                    "Acquisition Date" := 0D;
                IF NoFaSc THEN
                    "FA Subclass Code" := '';
                IF NoDept THEN
                    "Shortcut Dimension 3 Code" := '';
                IF NoDonor THEN
                    "Shortcut Dimension 2 Code" := '';
                IF NoProject THEN
                    "Shortcut Dimension 1 Code" := '';
                //---------------//
                CLEAR(CustName);
                FACust.RESET;
                FACust.SETCURRENTKEY("FA No.", "Date of Ownership");
                FACust.SETRANGE("FA No.", "FA No.");
                FACust.SETRANGE("Current Owner", TRUE);
                FACust.SETFILTER("Employee No.", CustFilter);
                //  FACust.SETFILTER("Date of Transfer",'=%1',0D);
                IF FACust.FINDLAST THEN BEGIN
                    FACust.CALCFIELDS("Employee Name");
                    CustName := FACust."Employee Name";
                END
                ELSE BEGIN
                    IF CustFilter <> '' THEN
                        CurrReport.SKIP;
                END;

                IF (DisposedOnly = TRUE) AND ("Disposal Date" = 0D) THEN
                    CurrReport.SKIP
                ELSE
                    IF (DisposedOnly = FALSE) AND ("Disposal Date" <> 0D) THEN
                        CurrReport.SKIP;

                FARec.GET("FA No.");
                FARec.CALCFIELDS("Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", Location);

                FAName := FARec.Description;
                IF FARec.Location <> '' THEN
                    Loc := FARec.Location
                ELSE
                    Loc := FARec."FA Location Code";

                //for Custodian Name
                IF NoCustdn THEN
                    CustName := '';


                PurchRcptLine.RESET;
                PurchRcptLine.SETRANGE("No.", "FA No.");
                IF PurchRcptLine.FINDFIRST THEN BEGIN
                    GRNNo := PurchRcptLine."Document No.";
                END;

                TotalAcquisitionCost += "Acquisition Cost";

            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("FA No.");
                Dim3Filter := "FA Depreciation Book".GETFILTER("Shortcut Dimension 3 Code");

                TotalAcquisitionCost := 0;
                AcquisitionDateFilter := "FA Depreciation Book".GETFILTER("Acquisition Date");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(DisposedOnly; DisposedOnly)
                    {
                        Caption = 'Disposed Only';
                    }
                    field(NoFac; NoFac)
                    {
                        Caption = 'No FACLASS';
                    }
                    field(NoFaSc; NoFaSc)
                    {
                        Caption = 'NO FA SUBCLASS';
                    }
                    field(NoAcDate; NoAcDate)
                    {
                        Caption = 'NO AQUISITION DATE';
                    }
                    field(NoLoc; NoLoc)
                    {
                        Caption = 'NO LOCATION';
                    }
                    field(NoDept; NoDept)
                    {
                        Caption = 'NO Dept. Code';
                    }
                    field(NoDonor; NoDonor)
                    {
                        Caption = 'No Donor Code';
                    }
                    field(NoProject; NoProject)
                    {
                        Caption = 'No Project Code';
                    }
                    field(NoCustdn; NoCustdn)
                    {
                        Caption = 'No Custdn Name';
                    }
                    field(CustFilter; CustFilter)
                    {
                        Caption = 'Custodian No.';
                        TableRelation = Customer;
                    }
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

    trigger OnPreReport()
    begin
        Filters := 'Filters: ';
        IF DisposedOnly THEN
            Filters += 'Disposed Only, ';
        IF NoFac THEN
            Filters += 'No FA Class, ';
        IF NoFaSc THEN
            Filters += 'No FA Subclass, ';
        IF NoAcDate THEN
            Filters += 'No Aquisition Date, ';
        IF NoLoc THEN
            Filters += 'No Location, ';
        IF NoDept THEN
            Filters += 'No Dept. Code, ';
        IF NoDonor THEN
            Filters += 'No Donor Code, ';
        IF NoProject THEN
            Filters += 'No Project Code, ';
        IF NoCustdn THEN
            Filters += 'No Custdn Name, ';
        IF CustFilter <> '' THEN
            Filters += 'Custodian No.: ' + CustFilter;

        Filters += ' ' + "FA Depreciation Book".GETFILTERS;
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        FAName: Text[50];
        Dim1: Code[20];
        Dim2: Code[20];
        Dim3: Code[20];
        Dim4: Code[20];
        FARec: Record "5600";
        DisposedOnly: Boolean;
        Loc: Code[20];
        FACust: Record "50018";
        CustName: Text[50];
        CustFilter: Code[100];
        NoFac: Boolean;
        NoFaSc: Boolean;
        NoAcDate: Boolean;
        NoLoc: Boolean;
        NoDept: Boolean;
        NoDonor: Boolean;
        NoProject: Boolean;
        NoCustdn: Boolean;
        PurchRcptLine: Record "121";
        GRNNo: Code[20];
        Dim3Filter: Code[250];
        FALedgerEntry: Record "5601";
        TotalAcquisitionCost: Decimal;
        FA_LedgerCaptionLbl: Label 'FA Ledger';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Nepal_Red_Cross_Society__NRCS_CaptionLbl: Label 'Nepal Red Cross Society (NRCS)';
        Assets_Detail_ReportCaptionLbl: Label 'Assets Detail Report';
        FA_SubClassCaptionLbl: Label 'FA SubClass';
        FA_ClassCaptionLbl: Label 'FA Class';
        LocCaptionLbl: Label 'Location';
        FANameCaptionLbl: Label 'Description';
        Aquisition_DateCaptionLbl: Label 'Aquisition Date';
        CustNameCaptionLbl: Label 'Custodian Name';
        GRN_No_CaptionLbl: Label 'GRN No.';
        TotalCaptionLbl: Label 'Total';
        AcquisitionDateFilter: Text;
        Filters: Text;

    [Scope('Internal')]
    procedure GetDepartmentCode(FACode: Code[20]): Code[20]
    var
        FACustodian: Record "50018";
    begin
        FACustodian.RESET;
        FACustodian.SETRANGE("FA No.", FACode);
        FACustodian.SETRANGE("Current Owner", TRUE);
        IF FACustodian.FINDLAST THEN
            EXIT(FACustodian."New Department Code")
        ELSE
            EXIT('');
    end;
}

