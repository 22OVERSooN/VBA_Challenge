Sub stock()

For Each ws In Worksheets

'Set Ticker name as string to fill in the small table
Dim Ticker_name As String

'Set total stock as double to fill in the small table
Dim Total_Stock As Double
Total_Stock = 0
'use this to fill in the small table in order
Dim Summary_Table_Row As Double
Summary_Table_Row = 2
'figure out the lastrow and make i equals to it, need to change each every worksheet

Dim open_num As Double
open_num = 2

Dim i As Double
LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
For i = 2 To LastRow

'name the column of small table
ws.Cells(1, 9).Value = "Ticker"
ws.Cells(1, 10).Value = "Yearly Change"
ws.Cells(1, 11).Value = "Percent Change"
ws.Cells(1, 12).Value = "Total Stock Volume"

'start to setup the if formula
If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
  Ticker_name = ws.Cells(i, 1).Value
  Total_Stock = Total_Stock + ws.Cells(i, 7).Value

   'when the ticker name change, put ticker name on column I
   ws.Range("I" & Summary_Table_Row).Value = Ticker_name
   'when the ticker name change,put the total volume on column L
   ws.Range("L" & Summary_Table_Row).Value = Total_Stock

ws.Range("J" & Summary_Table_Row).Value = ws.Cells(i, 6).Value - ws.Cells(open_num, 3).Value

If ws.Range("J" & Summary_Table_Row).Value > 0 Then
    ws.Cells(Summary_Table_Row, 10).Interior.ColorIndex = 4
Else: ws.Cells(Summary_Table_Row, 10).Interior.ColorIndex = 3
    End If

If ws.Cells(i, 6).Value = 0 And ws.Cells(open_num, 3) = 0 Then
  ws.Range("K" & Summary_Table_Row).Value = 0
ElseIf ws.Cells(open_num, 3) = 0 Then
   ws.Range("K" & Summary_Table_Row).Value = "N/A"
Else
   ws.Range("K" & Summary_Table_Row).Value = ws.Cells(Summary_Table_Row, 10).Value / ws.Cells(open_num, 3).Value
   End If

   
   Summary_Table_Row = Summary_Table_Row + 1

   Total_Stock = 0
   
   open_num = i + 1

ElseIf ws.Cells(i + 1, 1).Value = ws.Cells(i, 1).Value Then
   Total_Stock = Total_Stock + ws.Cells(i, 7).Value
    
End If

Next i
ws.Columns("K").NumberFormat = "0.00%"

'name the column and row name
ws.Cells(1, 16).Value = "Ticker"
ws.Cells(1, 17).Value = "Value"
ws.Cells(2, 15).Value = "Greatest % Increase"
ws.Cells(3, 15).Value = "Greatest % Decrease"
ws.Cells(4, 15).Value = "Greatest Total Volume"

'find the max number
Dim max_num As Double
max_num = ws.Application.WorksheetFunction.Max(Columns("K"))
ws.Cells(2, 17).Value = max_num

'find the min number
Dim min_num As Double
min_num = ws.Application.WorksheetFunction.Min(Columns("K"))
ws.Cells(3, 17).Value = min_num

'find the max number of volume
Dim max_vol As Double
max_vol = ws.Application.WorksheetFunction.Max(Columns("L"))
ws.Cells(4, 17).Value = max_vol

'count the new table's row
Dim Last_Row As Double
Last_Row = ws.Cells(Rows.Count, "I").End(xlUp).Row
For i = 2 To Last_Row

'put the number in the small table
If ws.Cells(i, 11).Value = max_num Then
ws.Cells(2, 16).Value = ws.Cells(i, 9).Value

ElseIf ws.Cells(i, 11).Value = min_num Then
ws.Cells(3, 16).Value = ws.Cells(i, 9).Value

ElseIf ws.Cells(i, 12).Value = max_vol Then
ws.Cells(4, 16).Value = ws.Cells(i, 9).Value

End If
Next i

ws.Range("Q2:Q3").NumberFormat = "0.00%"

Next ws

End Sub
