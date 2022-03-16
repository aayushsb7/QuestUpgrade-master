page 50011 "LC/BG/DO Amend Detail Card"
{
    SourceTable = "LC Amend Detail";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Version No."; "Version No.")
                {
                }
                field("No."; "No.")
                {
                }
                field("LC No."; "LC No.")
                {
                }
                field(Description; Description)
                {
                }
                field("Transaction Type"; "Transaction Type")
                {
                }
                field("Issued To/Received From"; "Issued To/Received From")
                {
                }
                field("Issued To/Received From Name"; "Issued To/Received From Name")
                {
                }
                field("Issuing Bank"; "Issuing Bank")
                {
                }
                field("Issue Bank Name1"; "Issue Bank Name1")
                {
                }
                field("Issue Bank Name2"; "Issue Bank Name2")
                {
                }
                field("Receiving Bank"; "Receiving Bank")
                {
                }
                field("Receiving Bank Name"; "Receiving Bank Name")
                {
                }
                field("Tolerance Percentage"; "Tolerance Percentage")
                {
                }
                field(Released; Released)
                {
                }
                field(Closed; Closed)
                {
                }
                field("Date of Issue"; "Date of Issue")
                {
                }
                field("Expiry Date"; "Expiry Date")
                {
                }
                field("Shipment Date"; "Shipment Date")
                {
                }
                field("Starting Date"; "Starting Date")
                {
                }
                field("<Bank Amend No.>"; "Bank Amended No.")
                {
                    Caption = 'Bank Amend No.';
                }
                field("Type of LC"; "Type of LC")
                {
                }
                field("Currency Code"; "Currency Code")
                {
                }
                field("Exchange Rate"; "Exchange Rate")
                {
                }
                field("Document Type"; "Document Type")
                {
                }
                field("Responsible F & R Person"; "Responsible F & R Person")
                {
                }
            }
            group(Invoicing)
            {
                field("LC Value"; "LC Value")
                {
                }
                field("LC Value (LCY)"; "LC Value (LCY)")
                {
                }
                field("Amended Value"; "Amended Value")
                {
                }
                field("Previous LC Value"; "Previous LC Value")
                {
                }
                field("Purchase LC Utilized Value"; "Purchase LC Utilized Value")
                {
                }
                field("Sales LC Utilized Value"; "Sales LC Utilized Value")
                {
                }
                field("Remaining Value"; "LC Value (LCY)" - "Purchase LC Utilized Value" - "Sales LC Utilized Value")
                {
                    Caption = 'Remaining Value';
                }
            }
            group(Remark)
            {
                Caption = 'Remarks';
                field(Remarks; Remarks)
                {
                }
            }
        }
        area(factboxes)
        {
            // systempart(; Notes)
            // {
            // }
            // systempart(; MyNotes)
            // {
            // }
            // systempart(; Links)
            // {
            // }
        }
    }

    actions
    {
        area(creation)
        {
            action(Release)
            {
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF Released = FALSE THEN BEGIN
                        IF CONFIRM('Do you want to release the Document?') THEN BEGIN
                            Released := TRUE;
                            MODIFY;
                        END;
                    END ELSE
                        MESSAGE('Document already released!');
                end;
            }
        }
    }
}

