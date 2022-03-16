report 50017 "Transfer Shipments"
{
    DefaultLayout = RDLC;
    RDLCLayout = './TransferShipments.rdlc';
    Caption = 'Transfer Shipment';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(DataItem6030; Table5744)
        {
            DataItemTableView = SORTING (No.);
            RequestFilterFields = "No.", "Transfer-from Code", "Transfer-to Code";
            RequestFilterHeading = 'Posted Transfer Shipment';
            column(TransferOrderNo; "Transfer Shipment Header"."Transfer Order No.")
            {
            }
            column(No_TransShptHeader; "No.")
            {
            }
            column(NP151001_1; "--NP15.1001")
            {
            }
            column(CompanyInfo1Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyOneLineAddress; CompanyOneLineAddress)
            {
            }
            column(CompanyCommunicationAddress; CompanyCommunicationAddress)
            {
            }
            column(CompanyInfoVATRegNo; CompanyInfo.FIELDCAPTION("VAT Registration No.") + ' : ' + CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyAddr1; CompanyInfo.Name)
            {
            }
            dataitem(CopyLoop; Table2000000026)
            {
                DataItemTableView = SORTING (Number);
                dataitem(PageLoop; Table2000000026)
                {
                    DataItemTableView = SORTING (Number)
                                        WHERE (Number = CONST (1));
                    column(CopyTextCaption; STRSUBSTNO(Text001, CopyText))
                    {
                    }
                    column(TransferToAddr1; TransferToAddr[1])
                    {
                    }
                    column(TransferFromAddr1; TransferFromAddr[1])
                    {
                    }
                    column(TransferToAddr2; TransferToAddr[2])
                    {
                    }
                    column(TransferFromAddr2; TransferFromAddr[2])
                    {
                    }
                    column(TransferToAddr3; TransferToAddr[3])
                    {
                    }
                    column(TransferFromAddr3; TransferFromAddr[3])
                    {
                    }
                    column(TransferToAddr4; TransferToAddr[4])
                    {
                    }
                    column(TransferFromAddr4; TransferFromAddr[4])
                    {
                    }
                    column(TransferToAddr5; TransferToAddr[5])
                    {
                    }
                    column(TransferToAddr6; TransferToAddr[6])
                    {
                    }
                    column(InTransit_TransShptHeader; "Transfer Shipment Header"."In-Transit Code")
                    {
                        IncludeCaption = true;
                    }
                    column(PostDate_TransShptHeader; FORMAT("Transfer Shipment Header"."Posting Date", 0, 4))
                    {
                    }
                    column(No2_TransShptHeader; "Transfer Shipment Header"."No.")
                    {
                    }
                    column(TransferToAddr7; TransferToAddr[7])
                    {
                    }
                    column(TransferToAddr8; TransferToAddr[8])
                    {
                    }
                    column(TransferFromAddr5; TransferFromAddr[5])
                    {
                    }
                    column(TransferFromAddr6; TransferFromAddr[6])
                    {
                    }
                    column(ShiptDate_TransShptHeader; FORMAT("Transfer Shipment Header"."Shipment Date"))
                    {
                    }
                    column(TransferFromAddr7; TransferFromAddr[7])
                    {
                    }
                    column(TransferFromAddr8; TransferFromAddr[8])
                    {
                    }
                    column(PageCaption; STRSUBSTNO(Text002, ''))
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(Desc_ShptMethod; ShipmentMethod.Description)
                    {
                    }
                    column(TransShptHdrNoCaption; TransShptHdrNoCaptionLbl)
                    {
                    }
                    column(TransShptShptDateCaption; TransShptShptDateCaptionLbl)
                    {
                    }
                    dataitem(DimensionLoop1; Table2000000026)
                    {
                        DataItemLinkReference = "Transfer Shipment Header";
                        DataItemTableView = SORTING (Number)
                                            WHERE (Number = FILTER (1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(Number_DimensionLoop1; Number)
                        {
                        }
                        column(HdrDimCaption; HdrDimCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DimSetEntry1.FINDSET THEN
                                    CurrReport.BREAK;
                            END ELSE
                                IF NOT Continue THEN
                                    CurrReport.BREAK;

                            CLEAR(DimText);
                            Continue := FALSE;
                            REPEAT
                                OldDimText := DimText;
                                IF DimText = '' THEN
                                    DimText := STRSUBSTNO('%1 - %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1; %2 - %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                END;
                            UNTIL DimSetEntry1.NEXT = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowInternalInfo THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(DataItem3226; Table5745)
                    {
                        DataItemLink = Document No.=FIELD(No.);
                        DataItemLinkReference = "Transfer Shipment Header";
                        DataItemTableView = SORTING (Document No., Line No.);
                        column(ShowInternalInfo; ShowInternalInfo)
                        {
                        }
                        column(NoOfCopies; NoOfCopies)
                        {
                        }
                        column(ItemNo_TransShptLine; "Item No.")
                        {
                            IncludeCaption = true;
                        }
                        column(Desc_TransShptLine; Description)
                        {
                            IncludeCaption = true;
                        }
                        column(Qty_TransShptLine; Quantity)
                        {
                            IncludeCaption = true;
                        }
                        column(UOM_TransShptLine; "Unit of Measure Code")
                        {
                            IncludeCaption = true;
                        }
                        column(LineNo_TransShptLine; "Line No.")
                        {
                        }
                        column(DocNo_TransShptLine; "Document No.")
                        {
                        }
                        column(NP151001_2; "--NP15.1001")
                        {
                        }
                        column(SN; SN)
                        {
                        }
                        dataitem(DimensionLoop2; Table2000000026)
                        {
                            DataItemTableView = SORTING (Number)
                                                WHERE (Number = FILTER (1 ..));
                            column(DimText4; DimText)
                            {
                            }
                            column(Number_DimensionLoop2; Number)
                            {
                            }
                            column(LineDimCaption; LineDimCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT DimSetEntry2.FINDSET THEN
                                        CurrReport.BREAK;
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK;

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText := STRSUBSTNO('%1 - %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1; %2 - %3', DimText,
                                            DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL DimSetEntry2.NEXT = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT ShowInternalInfo THEN
                                    CurrReport.BREAK;
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            ItemLedgerEntry: Record "32";
                        begin
                            DimSetEntry2.SETRANGE("Dimension Set ID", "Dimension Set ID");

                            //NP15.1001 >>
                            IF "Item No." <> '' THEN
                                SN += 1;
                            //NP15.1001 <<
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("Item No." = '') AND (Quantity = 0) DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            SETRANGE("Line No.", 0, "Line No.");
                            SN := 0;//ZM Agile
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN BEGIN
                        CopyText := Text000;
                        OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := 1 + ABS(NoOfCopies);
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                FormatAddr.TransferShptTransferFrom(TransferFromAddr, "Transfer Shipment Header");
                FormatAddr.TransferShptTransferTo(TransferToAddr, "Transfer Shipment Header");

                IF NOT ShipmentMethod.GET("Shipment Method Code") THEN
                    ShipmentMethod.INIT;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information';
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
        PostingDateCaption = 'Posting Date :';
        ShptMethodCaption = 'Shipment Method :';
    }

    trigger OnInitReport()
    begin
        //NP15.1001 >>
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
        FormatAddr.Company(CompanyAddr, CompanyInfo);
        GetCompanyOneLineAddress;
        //NP15.1001 <<
    end;

    var
        Text000: Label 'COPY';
        Text001: Label 'Transfer Shipment %1';
        Text002: Label 'Page %1';
        ShipmentMethod: Record "10";
        DimSetEntry1: Record "480";
        DimSetEntry2: Record "480";
        FormatAddr: Codeunit "365";
        TransferFromAddr: array[8] of Text[50];
        TransferToAddr: array[8] of Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        OutputNo: Integer;
        TransShptHdrNoCaptionLbl: Label 'Shipment No. :';
        TransShptShptDateCaptionLbl: Label 'Shipment Date :';
        HdrDimCaptionLbl: Label 'Header Dimensions';
        LineDimCaptionLbl: Label 'Line Dimensions';
        "--NP15.1001": Integer;
        CompanyOneLineAddress: Text;
        CompanyCommunicationAddress: Text;
        CompanyInfo: Record "79";
        CompanyAddr: array[8] of Text[50];
        Currency: Record "4";
        SystemManagement: Codeunit "50000";
        SN: Integer;
        VIN: Code[20];

    local procedure "---NP15.1001"()
    begin
    end;

    local procedure GetCompanyOneLineAddress()
    begin
        CompanyAddr[1] := CompanyInfo.Name;
        IF CompanyInfo."Phone No." <> '' THEN
            CompanyOneLineAddress := SystemManagement.OneLineAddress(CompanyAddr) + ', ' + CompanyInfo.FIELDCAPTION("Phone No.") + ' : ' + CompanyInfo."Phone No."
        ELSE
            CompanyOneLineAddress := SystemManagement.OneLineAddress(CompanyAddr);

        IF CompanyInfo."Fax No." <> '' THEN
            CompanyCommunicationAddress := CompanyInfo.FIELDCAPTION("Fax No.") + ' : ' + CompanyInfo."Fax No.";
        IF (CompanyCommunicationAddress <> '') AND (CompanyInfo."E-Mail" <> '') THEN
            CompanyCommunicationAddress += ', ' + CompanyInfo.FIELDCAPTION("E-Mail") + ' : ' + CompanyInfo."E-Mail";
    end;
}

