let
    Source = Excel.Workbook(Web.Contents("https://hunterwar.sharepoint.com/sites/SharedServices/ssqc/Reports/CRA%20Report%20RD.xlsx"), null, true),
    Table1_Table = Source{[Item="Table1",Kind="Table"]}[Data],
    #"Changed Type" = Table.TransformColumnTypes(Table1_Table,{{"Account Number", Int64.Type}, {"Issue Reported", type text}, {"Month", type text}, {"Period", type text}, {"Start Date", type date}, {"End Date", type date}, {"uniqueid", type text}, {"DuplicateCount", Int64.Type}}),
    #"Removed Duplicates" = Table.Distinct(#"Changed Type", {"Account Number", "Issue Reported"}),
    #"Duplicated Column" = Table.DuplicateColumn(#"Removed Duplicates", "Account Number", "Account Number - Copy"),
    #"Renamed Columns" = Table.RenameColumns(#"Duplicated Column",{{"Account Number - Copy", "acc_num_copy2"}}),
    #"Changed Type1" = Table.TransformColumnTypes(#"Renamed Columns",{{"acc_num_copy2", type text}})
in
    #"Changed Type1"