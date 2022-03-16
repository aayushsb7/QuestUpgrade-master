report 50054 "Generate No. Series Line"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; Table309)
        {

            trigger OnAfterGetRecord()
            begin
                totalcount += 1;
                ProgressWindow.UPDATE(2, "No. Series Line".COUNT);
                ProgressWindow.UPDATE(1, totalcount);
                PreviousStartingNo := "Starting No.";

                IF NOT NoSeries.GET("Series Code") THEN
                    CurrReport.SKIP;

                IF NoSeries.GET("Series Code") THEN
                    IF NoSeries."New Series Line Created" THEN
                        CurrReport.SKIP;

                NoSeriesLine.RESET;
                NoSeriesLine.SETCURRENTKEY(NoSeriesLine."Line No.");
                NoSeriesLine.SETRANGE("Series Code", "No. Series Line"."Series Code");
                IF NoSeriesLine.FINDLAST THEN
                    LastLineNo := NoSeriesLine."Line No." + 10000
                ELSE
                    LastLineNo := 10000;

                IF (StartingDate <> 0D) AND (SearchString <> '') AND (ReplaceWith <> '') THEN BEGIN //for format like ABC78/77-0001
                    Position := STRPOS(PreviousStartingNo, SearchString);
                    IF Position <> 0 THEN BEGIN
                        NewStartingNo := ReplaceString(PreviousStartingNo, SearchString, ReplaceWith);
                        NoSeriesLine.RESET;
                        NoSeriesLine.SETRANGE("Series Code", "No. Series Line"."Series Code");
                        NoSeriesLine.SETRANGE(NoSeriesLine."Starting No.", NewStartingNo);
                        IF NOT NoSeriesLine.FINDFIRST THEN BEGIN
                            NoSeriesLine.INIT;
                            NoSeriesLine."Series Code" := "Series Code";
                            NoSeriesLine."Line No." := LastLineNo;
                            NoSeriesLine."Starting Date" := StartingDate;
                            NoSeriesLine."Starting No." := NewStartingNo;
                            NoSeriesLine."Increment-by No." := 1;
                            NoSeriesLine.Open := FALSE;
                            NoSeriesLine.New := TRUE;
                            NoSeriesLine.INSERT;

                            NoSeries.GET("No. Series Line"."Series Code");
                            NoSeries."New Series Line Created" := TRUE;
                            NoSeries.MODIFY;
                        END;
                        ProgressWindow.UPDATE(3, totalcount);
                    END;
                END;
                /*IF (Year <> 0) AND (StartingDate <> 0D) THEN BEGIN  //format like ABC76-0001
                  Position := STRPOS(PreviousStartingNo,FORMAT(Year-1) + '-');
                  IF Position <> 0 THEN BEGIN
                    NewStartingNo := COPYSTR(PreviousStartingNo,1,Position-1) + FORMAT(Year) + '-'
                                          + COPYSTR(PreviousStartingNo,Position+3,STRLEN(PreviousStartingNo)) ;
                
                    NoSeriesLine.RESET;
                    NoSeriesLine.SETRANGE(NoSeriesLine."Series Code","No. Series Line"."Series Code");
                    NoSeriesLine.SETRANGE(NoSeriesLine."Starting No.",NewStartingNo);
                    IF NOT NoSeriesLine.FINDFIRST THEN BEGIN
                      NoSeriesLine.INIT;
                      NoSeriesLine."Series Code" := "Series Code";
                      NoSeriesLine."Line No." := LastLineNo;
                      NoSeriesLine."Starting Date" := StartingDate;
                      NoSeriesLine."Starting No." := NewStartingNo;
                      NoSeriesLine."Increment-by No." := 1;
                      NoSeriesLine.Open := FALSE;
                      NoSeriesLine.New := TRUE;
                      NoSeriesLine.INSERT;
                      NoSeries.GET("Series Code");
                      NoSeries."New Series Line Created" := TRUE;
                      NoSeries.MODIFY;
                    END;
                  END;
                END;*/
                ProgressWindow.UPDATE(3, totalcount);

            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('Updated Successfully!');
            end;

            trigger OnPreDataItem()
            begin
                ProgressWindow.OPEN(Text000);
                totalcount := 0;
                /*IF (Year <> 0) AND (StartingDate <> 0D) THEN
                  NoFilter := '*' + FORMAT(Year-1) + '-*'
                ELSE
                  */
                NoFilter := '*' + SearchString + '*';

                "No. Series Line".SETFILTER("Starting No.", NoFilter);
                IF StartingDate = 0D THEN
                    ERROR('please select staring date!');

                /*IF Year = 0 THEN
                  ERROR('please select Year!');*/

                MESSAGE('%1', "No. Series Line".GETFILTERS);

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
                group("Format Like ABC76-00001")
                {
                    Caption = 'Format Like ABC76-00001';
                    Visible = false;
                    field("Nepali Year (Last 2 digits only)"; Year)
                    {
                    }
                }
                group("Format Like ABC76/77-00001")
                {
                    Caption = 'Format Like ABC76/77-00001';
                    field("FY Search String"; SearchString)
                    {
                    }
                    field("New FY Code"; ReplaceWith)
                    {
                        Caption = 'New FY Code';
                    }
                }
                group("English Date")
                {
                    Caption = 'English Date';
                    field("Starting Date (Eng)"; StartingDate)
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
    }

    var
        Year: Integer;
        StartingDate: Date;
        NoFilter: Code[20];
        PreviousStartingNo: Code[20];
        NewStartingNo: Code[20];
        Position: Integer;
        NoSeriesLine: Record "309";
        totalcount: Integer;
        ProgressWindow: Dialog;
        Text000: Label 'Processed : #1######\Total Records : #2######## \Modified : #3######';
        LastLineNo: Integer;
        SearchString: Text;
        NewString: Text;
        ReplaceWith: Text;
        NoSeries: Record "308";

    local procedure ReplaceString(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
        EXIT(NewString);
    end;
}

