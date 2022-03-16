pageextension 70000802 "pageextension70000802" extends "Sales List"
{

    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CopySellToCustomerFilter;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CopySellToCustomerFilter;
    SetSecurityFilterOnRespCenter;  //SRT May 15th 2019
    */
    //end;
}

