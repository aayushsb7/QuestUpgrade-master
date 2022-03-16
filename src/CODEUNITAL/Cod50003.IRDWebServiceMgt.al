codeunit 50003 "IRD Web Service Mgt."
{
    //  data += '&seller_pan=' + '302956542';
    //  data += '&buyer_pan=' + '123456789';
    //  data += '&buyer_name=' + 'testsoft';
    //  data += '&fiscal_year=' + '2074.075';
    //  data += '&invoice_number=' + InvoiceNumber;
    //  data += '&invoice_date=' + '2074.06.29';
    //  data += '&total_sales=' + '1000';
    //  data += '&taxable_sales_vat=' + '1000';
    //  data += '&vat=' + '130';
    //  data += '&excisable_amount=' + '0';
    //  data += '&excise=' + '0';
    //  data += '&taxable_sales_hst=' + '0';
    //  data += '&hst=' + '0';
    //  data += '&amount_for_esf=' + '0';
    //  data += '&esf=' + '0';
    //  data += '&export_sales=' + '0';
    //  data += '&tax_exempted_sales=' + '0';
    //  data += '&isrealtime=' + 'true';


    trigger OnRun()
    begin
    end;

    var
        Text000: Label 'Sending Data...';
        Text001: Label 'Sending Data failed!\Statuscode: %1\Description: %2';
        Error100: Label 'API credential does not match.';
        Error101: Label 'Bill Already Exists.';
        Error102: Label 'Exception while saving bill details.';
        Error103: Label 'Unknown exceptions.';
        Error104: Label 'Invalid Bill Model.';
        Error105: Label 'Bill Not Found.';
        CError100: Label 'API credential does not match.';
        CError101: Label 'Bill does not exists.';
        CError102: Label 'Exception while saving credit note details.';
        CError103: Label 'Unknown exceptions.';
        CError104: Label 'Invalid Bill Model.';
        CError105: Label 'Bill does not exists (for Sales Return)';
        CompanyInfo: Record "79";

    [Scope('Internal')]
    procedure PushBill(SellerPan: Text; BuyerPan: Text; BuyerName: Text; FiscalYear: Text; InvoiceNumber: Text; InvoiceDate: Text; TotalSales: Decimal; TaxableSalesVAT: Decimal; VAT: Decimal; ExcisableAmount: Decimal; Excise: Decimal; TaxableSalesHST: Decimal; HST: Decimal; AmountForESF: Decimal; ESF: Decimal; ExportSales: Decimal; TaxExemptedSales: Decimal; IsRealTime: Boolean; PostingDatetime: DateTime) ReturnValue: Boolean
    var
        stringContent: DotNet StringContent;
        httpUtility: DotNet HttpUtility;
        encoding: DotNet Encoding;
        result: DotNet String;
        resultParts: DotNet Array;
        separator: DotNet String;
        HttpResponseMessage: DotNet HttpResponseMessage;
        null: DotNet Object;
        Window: Dialog;
        data: Text;
        statusCode: Text;
        statusText: Text;
        ResponseCode: Code[10];
        PhoneNo: Text;
        MessageText: Text;
        Success: Boolean;
        ErrorMessage: Text;
    begin
        CompanyInfo.GET;
        data := 'username=' + CompanyInfo."CBMS Username";
        data += '&password=' + CompanyInfo."CBMS Password";
        data += '&seller_pan=' + SellerPan;
        data += '&buyer_pan=' + BuyerPan;
        data += '&buyer_name=' + BuyerName;
        data += '&fiscal_year=' + FiscalYear;
        data += '&invoice_number=' + InvoiceNumber;
        data += '&invoice_date=' + InvoiceDate;
        data += '&total_sales=' + FORMAT(TotalSales, 0, 2);
        data += '&taxable_sales_vat=' + FORMAT(TaxableSalesVAT, 0, 2);
        data += '&vat=' + FORMAT(VAT, 0, 2);
        data += '&excisable_amount=' + FORMAT(ExcisableAmount, 0, 2);
        data += '&excise=' + FORMAT(Excise, 0, 2);
        data += '&taxable_sales_hst=' + FORMAT(TaxableSalesHST, 0, 2);
        data += '&hst=' + FORMAT(HST, 0, 2);
        data += '&amount_for_esf=' + FORMAT(AmountForESF, 0, 2);
        data += '&esf=' + FORMAT(ESF, 0, 2);
        data += '&export_sales=' + FORMAT(ExportSales, 0, 2);
        data += '&tax_exempted_sales=' + FORMAT(TaxExemptedSales, 0, 2);
        IF IsRealTime THEN
            data += '&isrealtime=' + 'true'
        ELSE
            data += '&isrealtime=' + 'false';
        data += '&datetimeClient=' + FORMAT(PostingDatetime);
        stringContent := stringContent.StringContent(data, encoding.UTF8, 'application/x-www-form-urlencoded');

        ReturnValue := CallRESTBillWebService(CompanyInfo."CBMS Base URL",
                                                           'POST',
                                                           'POST',
                                                           stringContent,
                                                           HttpResponseMessage);

        IF NOT ReturnValue THEN
            EXIT(FALSE);

        result := HttpResponseMessage.Content.ReadAsStringAsync.Result;
        CLEAR(ErrorMessage);
        Success := IsSuccess(result.ToString, ErrorMessage);
        IF Success THEN
            EXIT(TRUE)
        ELSE
            MESSAGE(ErrorMessage);
        EXIT(FALSE);
    end;

    [TryFunction]
    [Scope('Internal')]
    procedure CallRESTBillWebService(BaseUrl: Text; Method: Text; RestMethod: Text; var HttpContent: DotNet HttpContent; var HttpResponseMessage: DotNet HttpResponseMessage)
    var
        HttpClient: DotNet HttpClient;
        Uri: DotNet Uri;
    begin
        HttpClient := HttpClient.HttpClient();
        HttpClient.BaseAddress := Uri.Uri(BaseUrl);

        CASE RestMethod OF
            'GET':
                HttpResponseMessage := HttpClient.GetAsync(Method).Result;
            'POST':
                HttpResponseMessage := HttpClient.PostAsync('api/bill', HttpContent).Result;
            'PUT':
                HttpResponseMessage := HttpClient.PutAsync(Method, HttpContent).Result;
            'DELETE':
                HttpResponseMessage := HttpClient.DeleteAsync(Method).Result;
        END;

        HttpResponseMessage.EnsureSuccessStatusCode();
    end;

    local procedure IsSuccess(ResponseCode: Text; var ErrorMessage: Text): Boolean
    begin
        CASE ResponseCode OF
            '100':
                ErrorMessage := Error100;
            '101':
                ErrorMessage := Error101;
            '102':
                ErrorMessage := Error102;
            '103':
                ErrorMessage := Error103;
            '104':
                ErrorMessage := Error104;
            '105':
                ErrorMessage := Error105;
            '200':
                EXIT(TRUE);
            ELSE
                ErrorMessage := ResponseCode;
        END;
    end;

    [Scope('Internal')]
    procedure PushCreditBill(SellerPan: Text; BuyerPan: Text; BuyerName: Text; FiscalYear: Text; Ref_InvoiceNumber: Text; ReturnDate: Text; ReturnDocumentNo: Text; TotalSales: Decimal; TaxableSalesVAT: Decimal; VAT: Decimal; ExcisableAmount: Decimal; Excise: Decimal; TaxableSalesHST: Decimal; HST: Decimal; AmountForESF: Decimal; ESF: Decimal; ExportSales: Decimal; TaxExemptedSales: Decimal; IsRealTime: Boolean; PostingDatetime: DateTime; ReasonForReturn: Text) ReturnValue: Boolean
    var
        stringContent: DotNet StringContent;
        httpUtility: DotNet HttpUtility;
        encoding: DotNet Encoding;
        result: DotNet String;
        resultParts: DotNet Array;
        separator: DotNet String;
        HttpResponseMessage: DotNet HttpResponseMessage;
        null: DotNet Object;
        Window: Dialog;
        data: Text;
        statusCode: Text;
        statusText: Text;
        ResponseCode: Code[10];
        PhoneNo: Text;
        MessageText: Text;
        Success: Boolean;
        ErrorMessage: Text;
    begin
        CompanyInfo.GET;
        data := 'username=' + CompanyInfo."CBMS Username";
        data += '&password=' + CompanyInfo."CBMS Password";
        data += '&seller_pan=' + SellerPan;
        data += '&buyer_pan=' + BuyerPan;
        data += '&fiscal_year=' + FiscalYear;
        data += '&buyer_name=' + BuyerName;
        data += '&ref_invoice_number=' + Ref_InvoiceNumber;
        data += '&credit_note_number=' + ReturnDocumentNo;
        data += '&credit_note_date=' + ReturnDate;
        data += '&reason_for_return=' + ReasonForReturn;
        data += '&total_sales=' + FORMAT(TotalSales, 0, 2);
        data += '&taxable_sales_vat=' + FORMAT(TaxableSalesVAT, 0, 2);
        data += '&vat=' + FORMAT(VAT, 0, 2);
        data += '&excisable_amount=' + FORMAT(ExcisableAmount, 0, 2);
        data += '&excise=' + FORMAT(Excise, 0, 2);
        data += '&taxable_sales_hst=' + FORMAT(TaxableSalesHST, 0, 2);
        data += '&hst=' + FORMAT(HST, 0, 2);
        data += '&amount_for_esf=' + FORMAT(AmountForESF, 0, 2);
        data += '&esf=' + FORMAT(ESF, 0, 2);
        data += '&export_sales=' + FORMAT(ExportSales, 0, 2);
        data += '&tax_exempted_sales=' + FORMAT(TaxExemptedSales, 0, 2);
        IF IsRealTime THEN
            data += '&isrealtime=' + 'true'
        ELSE
            data += '&isrealtime=' + 'false';
        data += '&datetimeClient=' + FORMAT(PostingDatetime);
        stringContent := stringContent.StringContent(data, encoding.UTF8, 'application/x-www-form-urlencoded');


        ReturnValue := CallRESTCreditBillWebService(CompanyInfo."CBMS Base URL",
                                                           'POST',
                                                           'POST',
                                                           stringContent,
                                                           HttpResponseMessage);

        IF NOT ReturnValue THEN
            EXIT(FALSE);

        result := HttpResponseMessage.Content.ReadAsStringAsync.Result;
        CLEAR(ErrorMessage);
        Success := IsSuccessCredit(result.ToString, ErrorMessage);
        IF Success THEN
            EXIT(TRUE)
        ELSE
            MESSAGE(ErrorMessage);
        EXIT(FALSE);
    end;

    [TryFunction]
    [Scope('Internal')]
    procedure CallRESTCreditBillWebService(BaseUrl: Text; Method: Text; RestMethod: Text; var HttpContent: DotNet HttpContent; var HttpResponseMessage: DotNet HttpResponseMessage)
    var
        HttpClient: DotNet HttpClient;
        Uri: DotNet Uri;
    begin
        HttpClient := HttpClient.HttpClient();
        HttpClient.BaseAddress := Uri.Uri(BaseUrl);

        CASE RestMethod OF
            'GET':
                HttpResponseMessage := HttpClient.GetAsync(Method).Result;
            'POST':
                HttpResponseMessage := HttpClient.PostAsync('api/billreturn', HttpContent).Result;
            'PUT':
                HttpResponseMessage := HttpClient.PutAsync(Method, HttpContent).Result;
            'DELETE':
                HttpResponseMessage := HttpClient.DeleteAsync(Method).Result;
        END;

        HttpResponseMessage.EnsureSuccessStatusCode();
    end;

    local procedure IsSuccessCredit(ResponseCode: Text; var ErrorMessage: Text): Boolean
    begin
        CASE ResponseCode OF
            '100':
                ErrorMessage := CError100;
            '101':
                ErrorMessage := CError101;
            '102':
                ErrorMessage := CError102;
            '103':
                ErrorMessage := CError103;
            '104':
                ErrorMessage := CError104;
            '105':
                ErrorMessage := CError105;
            '200':
                EXIT(TRUE);
            ELSE
                ErrorMessage := ResponseCode;
        END;
    end;

    [Scope('Internal')]
    procedure GetSetup(): Boolean
    begin
        CompanyInfo.GET;
        EXIT((CompanyInfo."CBMS Base URL" <> '') AND
             (CompanyInfo."CBMS Username" <> '') AND
             (CompanyInfo."CBMS Password" <> ''))
    end;
}

