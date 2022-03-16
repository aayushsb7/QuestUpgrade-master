report 50025 "Item Stock Movement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ItemStockMovement.rdlc';

    dataset
    {
        dataitem(ReportHeader; Table2000000026)
        {
            DataItemTableView = SORTING (Number)
                                WHERE (Number = CONST (1));
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyAddr1; CompanyAddr[1])
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
            column(PrintedOn; CURRENTDATETIME)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
        }
        dataitem(Item; Table27)
        {
            DataItemTableView = WHERE (Type = CONST (Inventory));
            RequestFilterFields = "No.", "Date Filter", "Location Filter", "Inventory Posting Group";

            trigger OnAfterGetRecord()
            begin
                totalcount += 1;
                ProgressWindow.UPDATE(1, totalcount);

                DateRange := Item.GETRANGEMIN("Date Filter");
                DateRangeMax := Item.GETRANGEMAX("Date Filter");

                GetOpening;

                IF HasTransaction(Item."No.") THEN BEGIN
                    SETFILTER("Date Filter", DateFilter_Item);
                    GetPeriodMovement;
                END;

                GetClosing;
            end;

            trigger OnPreDataItem()
            begin
                ItemStockMovement.RESET;
                ItemStockMovement.DELETEALL;
                InsertOCColumn;
                ProgressWindow.OPEN(Text000);
                ProgressWindow.UPDATE(2, COUNT);
            end;
        }
        dataitem(ReportBody; Table2000000026)
        {
            DataItemTableView = SORTING (Number);
            column(ItemNo; ItemStockMovement."No.")
            {
            }
            column(LocationCode; ItemStockMovement."Location Code")
            {
            }
            column(InventoryPostingGroup; ItemStockMovement."Item Category Code")
            {
            }
            column(GenProdPostingGroup; ItemStockMovement."Gen. Prod. Posting Group")
            {
            }
            column(ItemDescription; ItemStockMovement.Description)
            {
            }
            column(ColumnCaption; ItemStockMovement."Description 2")
            {
            }
            column(CostAmountActual; ItemStockMovement.Amount)
            {
            }
            column(Quantity; ItemStockMovement.Quantity)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Number = 1 THEN
                    ItemStockMovement.FINDFIRST
                ELSE
                    ItemStockMovement.NEXT;
            end;

            trigger OnPostDataItem()
            begin
                ItemStockMovement.RESET;
                ItemStockMovement.DELETEALL;
            end;

            trigger OnPreDataItem()
            begin
                ItemStockMovement.RESET;
                SETRANGE(Number, 1, ItemStockMovement.COUNT);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group()
                {
                    field("Cost Post to GL"; CostPosttoGL)
                    {
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
        ReportCaption = 'Item Stock Movement';
    }

    trigger OnInitReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
        FormatAddr.Company(CompanyAddr, CompanyInfo);
        GetCompanyOneLineAddress;
    end;

    trigger OnPreReport()
    begin
        ItemFilter := Item.GETFILTERS;
        DateFilter_Item := Item.GETFILTER("Date Filter");
        ItemLocationFilter := Item.GETFILTER("Location Filter");
        LocationFilterWithIntransit := ItemLocationFilter + '&<>' + GetIntransitLocation;
        DropShipmentFilter := Item.GETFILTER("Drop Shipment Filter");
        IF DateFilter_Item = '' THEN
            ERROR(ErrSpecifyDateRange);
    end;

    var
        ItemStockMovement: Record "37" temporary;
        CompanyInfo: Record "79";
        IRDMgt: Codeunit "50000";
        FormatAddr: Codeunit "365";
        ItemFilter: Text;
        ItemLocationFilter: Text;
        LocationFilterWithIntransit: Text;
        DateFilter_Item: Text[30];
        DateRange: Date;
        DateRangeMax: Date;
        totalcount: Integer;
        ProgressWindow: Dialog;
        TotalModified: Integer;
        InventoryPostingGroupFilter: Text;
        Text000: Label '#1###### of #2######## Records being Processed.';
        ErrSpecifyDateRange: Label 'Please specify the DateFilter Range.';
        MsgReportExecutionTime: Label 'Item Filter = %1\Start Time = %2\End Time = %3';
        OpeningCaption: Label 'A. Opening';
        PurchaseCaption: Label 'Purchase';
        SalesReturnCaption: Label 'Sales Return';
        TransferRcptCaption: Label 'Transfer Receipt';
        PosAdjCaption: Label 'Positive Adjustment';
        SalesCaption: Label 'Sales';
        PurReturnCaption: Label 'Purchase Return';
        TransShipCaption: Label 'Transfer Shipment';
        NegAdjCaption: Label 'Negative Adjustment';
        IntransitCaption: Label 'Intransit';
        ClosingCaption: Label 'Z. Closing';
        LineNo: Integer;
        CompanyOneLineAddress: Text;
        CompanyCommunicationAddress: Text;
        CompanyAddr: array[8] of Text[50];
        DropShipmentFilter: Text[30];
        CostPosttoGL: Boolean;

    [Scope('Internal')]
    procedure GetOpening()
    var
        LocationFilter: Text[250];
    begin
        IF DateRange <> 0D THEN BEGIN
            BuildMovementData('..' + FORMAT(DateRange - 1), OpeningCaption);
        END;
    end;

    [Scope('Internal')]
    procedure GetPeriodMovement()
    begin
        BuildMovementData(DateFilter_Item, '');
    end;

    [Scope('Internal')]
    procedure GetClosing()
    begin
        IF DateRangeMax <> 0D THEN BEGIN
            BuildMovementData('..' + FORMAT(DateRangeMax), ClosingCaption);
        END;
    end;

    [Scope('Internal')]
    procedure HasTransaction(ItemNo: Code[20]) HasRecords: Boolean
    var
        ILE: Record "32";
    begin
        ILE.RESET;
        ILE.SETCURRENTKEY("Item No.", "Posting Date");
        ILE.SETRANGE("Item No.", ItemNo);
        ILE.SETFILTER("Posting Date", DateFilter_Item);
        EXIT(NOT ILE.ISEMPTY);
    end;

    local procedure GetIntransitLocation(): Text
    var
        Location: Record "14";
        InTransit_Location: Text;
    begin
        Location.RESET;
        Location.SETRANGE("Use As In-Transit", TRUE);
        IF Location.FINDFIRST THEN
            REPEAT
                InTransit_Location += Location.Code + '|';
            UNTIL Location.NEXT = 0;
        EXIT(InTransit_Location);
    end;

    local procedure BuildDocumentTypeCaption(DocumentType: Option " ","Sales Shipment","Sales Invoice","Sales Return Receipt","Sales Credit Memo","Purchase Receipt","Purchase Invoice","Purchase Return Shipment","Purchase Credit Memo","Transfer Shipment","Transfer Receipt","Service Shipment","Service Invoice","Service Credit Memo","Posted Assembly"): Text[250]
    begin
        EXIT(FORMAT(DocumentType));
    end;

    local procedure BuildILETypeCaption(ILEType: Option Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output"): Text[250]
    begin
        EXIT(FORMAT(ILEType));
    end;

    local procedure BuildMovementData(NewDateFilter: Text[50]; ColumnCaption: Text[250])
    var
        ItemLedgerEntry: Record "32";
        NewColumnCaption: Text;
        ValueEntry: Record "5802";
    begin
        NewColumnCaption := ColumnCaption;
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.", "Posting Date");
        ItemLedgerEntry.SETRANGE("Item No.", Item."No.");
        ItemLedgerEntry.SETFILTER("Posting Date", NewDateFilter);
        ItemLedgerEntry.SETFILTER("Location Code", ItemLocationFilter);
        ItemLedgerEntry.SETFILTER("Drop Shipment", DropShipmentFilter);
        ItemLedgerEntry.SETAUTOCALCFIELDS("Cost Amount (Expected)", "Cost Amount (Actual)");
        IF ItemLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                IF ColumnCaption = '' THEN BEGIN
                    NewColumnCaption := BuildDocumentTypeCaption(ItemLedgerEntry."Document Type");
                    IF DELCHR(NewColumnCaption, '=') = '' THEN
                        NewColumnCaption := BuildILETypeCaption(ItemLedgerEntry."Entry Type");
                END;

                ItemStockMovement.RESET;
                ItemStockMovement.SETRANGE("No.", Item."No.");
                ItemStockMovement.SETRANGE("Location Code", ItemLedgerEntry."Location Code");
                ItemStockMovement.SETRANGE("Description 2", NewColumnCaption);
                IF NOT ItemStockMovement.FINDFIRST THEN BEGIN
                    CLEAR(ItemStockMovement);
                    ItemStockMovement.INIT;
                    ItemStockMovement."Line No." := LineNo + 10000;
                    ItemStockMovement."Location Code" := ItemLedgerEntry."Location Code";
                    ItemStockMovement."Item Category Code" := ItemLedgerEntry."Item Category Code";
                    ItemStockMovement."Product Group Code" := ItemLedgerEntry."Product Group Code";
                    ItemStockMovement."No." := Item."No.";
                    ItemStockMovement.Description := Item.Description;
                    ItemStockMovement."Description 2" := NewColumnCaption;
                    //Agile CP 27 March 2017
                    IF CostPosttoGL THEN BEGIN
                        ValueEntry.RESET;
                        ValueEntry.SETFILTER("Posting Date", NewDateFilter);
                        ValueEntry.SETFILTER("Location Code", ItemLocationFilter);
                        ValueEntry.SETFILTER("Drop Shipment", DropShipmentFilter);
                        ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgerEntry."Entry No.");
                        IF ValueEntry.FINDSET THEN
                            REPEAT
                                ItemStockMovement.Amount += ValueEntry."Cost Posted to G/L";
                                ItemStockMovement.Quantity += ValueEntry."Invoiced Quantity";
                            UNTIL ValueEntry.NEXT = 0;
                    END
                    //Agile CP 27 March 2017
                    ELSE BEGIN
                        ItemStockMovement.Amount := ItemLedgerEntry."Cost Amount (Expected)" + ItemLedgerEntry."Cost Amount (Actual)";
                        ItemStockMovement.Quantity := ItemLedgerEntry.Quantity;
                    END;
                    ItemStockMovement.INSERT;
                    LineNo += 10000;
                END
                ELSE BEGIN
                    //Agile CP 27 March 2017
                    IF CostPosttoGL THEN BEGIN
                        ValueEntry.RESET;
                        ValueEntry.SETFILTER("Posting Date", NewDateFilter);
                        ValueEntry.SETFILTER("Location Code", ItemLocationFilter);
                        ValueEntry.SETFILTER("Drop Shipment", DropShipmentFilter);
                        ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgerEntry."Entry No.");
                        IF ValueEntry.FINDSET THEN
                            REPEAT
                                ItemStockMovement.Amount += ValueEntry."Cost Posted to G/L";
                                ItemStockMovement.Quantity += ValueEntry."Invoiced Quantity";
                            UNTIL ValueEntry.NEXT = 0;
                    END
                    //Agile CP 27 March 2017
                    ELSE BEGIN
                        ItemStockMovement.Amount += ItemLedgerEntry."Cost Amount (Expected)" + ItemLedgerEntry."Cost Amount (Actual)";
                        ItemStockMovement.Quantity += ItemLedgerEntry.Quantity;
                    END;
                    ItemStockMovement.MODIFY;
                END;
            UNTIL ItemLedgerEntry.NEXT = 0;
        END;
    end;

    local procedure GetCompanyOneLineAddress()
    begin
        CompanyAddr[1] := CompanyInfo.Name;
        IF CompanyInfo."Phone No." <> '' THEN
            CompanyOneLineAddress := IRDMgt.OneLineAddress(CompanyAddr) + ', ' + CompanyInfo.FIELDCAPTION("Phone No.") + ' : ' + CompanyInfo."Phone No."
        ELSE
            CompanyOneLineAddress := IRDMgt.OneLineAddress(CompanyAddr);

        IF CompanyInfo."Fax No." <> '' THEN
            CompanyCommunicationAddress := CompanyInfo.FIELDCAPTION("Fax No.") + ' : ' + CompanyInfo."Fax No.";
        IF (CompanyCommunicationAddress <> '') AND (CompanyInfo."E-Mail" <> '') THEN
            CompanyCommunicationAddress += ', ' + CompanyInfo.FIELDCAPTION("E-Mail") + ' : ' + CompanyInfo."E-Mail";
    end;

    local procedure InsertOCColumn()
    begin
        CLEAR(ItemStockMovement);
        ItemStockMovement.INIT;
        ItemStockMovement."Line No." := LineNo + 10000;
        ItemStockMovement."Description 2" := OpeningCaption;
        ItemStockMovement.INSERT;
        LineNo += 10000;
        CLEAR(ItemStockMovement);
        ItemStockMovement.INIT;
        ItemStockMovement."Line No." := LineNo + 10000;
        ItemStockMovement."Description 2" := ClosingCaption;
        ItemStockMovement.INSERT;
        LineNo += 10000;
    end;
}

