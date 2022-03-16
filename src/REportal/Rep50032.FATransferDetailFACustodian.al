report 50032 "FA Transfer Detail-FACustodian"
{
    DefaultLayout = RDLC;
    RDLCLayout = './FATransferDetailFACustodian.rdlc';

    dataset
    {
        dataitem(DataItem8608; Table50018)
        {
            DataItemTableView = SORTING (FA No., Date of Ownership)
                                ORDER(Descending);
            RequestFilterFields = "FA No.";
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
            column(FA_Custodian__FA_No__; "FA No.")
            {
            }
            column(FA_Custodian__FA_Description_; "FA Description")
            {
            }
            column(FA_Custodian__Employee_No__; "Employee No.")
            {
            }
            column(FA_Custodian__Employee_Name_; "Employee Name")
            {
            }
            column(FA_Custodian__Date_of_Ownership_; "Date of Ownership")
            {
            }
            column(FA_Custodian_Location; Location)
            {
            }
            column(DateOfTransfer; DateOfTransfer)
            {
            }
            column(FA_CustodianCaption; FA_CustodianCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Ownership_StatusCaption; Ownership_StatusCaptionLbl)
            {
            }
            column(FA_Custodian__Employee_No__Caption; FA_Custodian__Employee_No__CaptionLbl)
            {
            }
            column(FA_Custodian_LocationCaption; FIELDCAPTION(Location))
            {
            }
            column(FA_Custodian__Employee_Name_Caption; FA_Custodian__Employee_Name_CaptionLbl)
            {
            }
            column(FA_Custodian__Date_of_Ownership_Caption; FIELDCAPTION("Date of Ownership"))
            {
            }
            column(FA_No_Caption; FA_No_CaptionLbl)
            {
            }
            column(FA_DescriptionCaption; FA_DescriptionCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF "Date of Transfer" = 0D THEN
                    DateOfTransfer := 'Current Owner'
                ELSE
                    DateOfTransfer := 'Previous Owner'
                /*RecentFA := "FA No.";
                IF RecentFA = PreviousFA THEN BEGIN
                  IF FirstRun = 0 THEN BEGIN
                    FirstRun := 1;
                    TransferDate := 0D;
                  END
                  ELSE BEGIN
                    NEXT(-1);
                    TransferDate := "Date of Ownership";
                    NEXT(1);
                  END;
                END
                ELSE BEGIN
                  PreviousFA := RecentFA;
                  FirstRun :=0;
                
                END;
                IF FirstRun = 0 THEN BEGIN
                  FirstRun := 1;
                  TransferDate := "Date of Ownership";
                END
                */

            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("FA No.");
                FirstRun := 0;
                PreviousFA := '';
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TransferDate: Date;
        FirstRun: Integer;
        PreviousFA: Code[20];
        RecentFA: Code[20];
        DateOfTransfer: Text[30];
        FA_CustodianCaptionLbl: Label 'FA Custodian';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Ownership_StatusCaptionLbl: Label 'Ownership Status';
        FA_Custodian__Employee_No__CaptionLbl: Label 'Custodian No.';
        FA_Custodian__Employee_Name_CaptionLbl: Label 'Custodian Name';
        FA_No_CaptionLbl: Label 'FA No.';
        FA_DescriptionCaptionLbl: Label 'FA Description';
}

