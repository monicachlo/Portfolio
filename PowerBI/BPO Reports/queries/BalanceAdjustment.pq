let
    Source = Excel.Workbook(Web.Contents("https://hunterwar.sharepoint.com/sites/SharedServices/ssqc/Reports/balance%20adjustment%20audit.xlsx"), null, true),
    Sheet1_Sheet = Source{[Item="Sheet1",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Sheet1_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Account #", Int64.Type}, {"Creditor", type text}, {"Client", type text}, {"Creditor Reference", type text}, {"PND1/RAEODL", Int64.Type}, {"PND1/Wrong Balance", Int64.Type}, {"PND1 / RAEODL Status", type text}, {"PND1 other consumers", type any}, {"communication after the adjustment", Int64.Type}, {"SSN/DOB ", Int64.Type}, {"Method", type text}, {"Agent ", type text}, {"Human Error ", Int64.Type}, {"Reason of Human Error", type text}, {"Adjustment", type text}, {"Interest", Int64.Type}, {"Interest Removed", Int64.Type}, {"Interest Amount Waived", type any}, {"Documents Available", Int64.Type}, {"Reason", type text}, {"Adj Amount", type number}, {"Original Balance", type number}, {"FCRA violation", Int64.Type}, {"State Violation", Int64.Type}, {"AUD Submitted", Int64.Type}, {"BOC sent", Int64.Type}, {"CBRINTR Added", Int64.Type}, {"Account Escalated to Accounting", type any}, {"Additional Notes", type text}}),
    #"Filtered Rows" = Table.SelectRows(#"Changed Type", each ([BOC sent] <> null)),
    #"Renamed Columns" = Table.RenameColumns(#"Filtered Rows",{{"Account #", "Accnt_Nmbr"}, {"communication after the adjustment", "commu_after_adjustment"}, {"BOC sent", "BOC_sent"}}),
    #"Added Custom" = Table.AddColumn(#"Renamed Columns", "Flag_For_Removal", each if [BOC_sent] = 1 or [commu_after_adjustment] = 1 then 1 else 0),
    #"Duplicated Column" = Table.DuplicateColumn(#"Added Custom", "Placement Date", "Placement Date - Copy"),
    #"Renamed Columns1" = Table.RenameColumns(#"Duplicated Column",{{"Placement Date - Copy", "Pl_Date"}}),
    #"Changed Type1" = Table.TransformColumnTypes(#"Renamed Columns1",{{"Pl_Date", type date}}),
    #"Duplicated Column1" = Table.DuplicateColumn(#"Changed Type1", "Adjustment Date", "Adjustment Date - Copy"),
    #"Renamed Columns2" = Table.RenameColumns(#"Duplicated Column1",{{"Adjustment Date - Copy", "Adj_Date"}}),
    #"Changed Type2" = Table.TransformColumnTypes(#"Renamed Columns2",{{"Adj_Date", type date}})
in
    #"Changed Type2"