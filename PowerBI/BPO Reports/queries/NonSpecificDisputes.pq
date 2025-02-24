let
    Source = Excel.Workbook(Web.Contents("https://hunterwar.sharepoint.com/sites/SharedServices/ssqc/Reports/NSDisp%20Reclassification.xlsx"), null, true),
    Query1_Sheet = Source{[Item="Query1",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Query1_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"cnsmr_id", Int64.Type}, {"Account_Number", Int64.Type}, {"Consumer_Number", Int64.Type}, {"Result_Code", type text}, {"Workgroup", type text}, {"Dispute_Dt", type datetime}, {"Dispute_Usr", type text}, {"Action_Dt", type datetime}, {"Action_Usr", type text}, {"Action_Code", type text}, {"Action_Result_Code", type text}, {"Classification", type text}, {"Agent who reclassified", type any}, {"Properly Classified?", type any}, {"Risk?", type any}, {"Type Of Risk", type any}, {"Docs on file?", type any}, {"Case needed?", type any}, {"Was there a previous dispute/vod request?", type any}, {"Agent who classified 1st dispute", type any}, {"Previous dispute properly addressed?", type any}, {"Additional Notes", type any}}),
    #"Duplicated Column" = Table.DuplicateColumn(#"Changed Type", "Dispute_Dt", "Dispute_Dt - Copy"),
    #"Duplicated Column1" = Table.DuplicateColumn(#"Duplicated Column", "Action_Dt", "Action_Dt - Copy"),
    #"Renamed Columns" = Table.RenameColumns(#"Duplicated Column1",{{"Action_Dt - Copy", "Class_Dt"}}),
    #"Duplicated Column2" = Table.DuplicateColumn(#"Renamed Columns", "Account_Number", "Account_Number - Copy"),
    #"Changed Type1" = Table.TransformColumnTypes(#"Duplicated Column2",{{"Account_Number - Copy", type text}}),
    #"Renamed Columns1" = Table.RenameColumns(#"Changed Type1",{{"Account_Number - Copy", "Acc_Num_Text"}}),
    #"Filtered Rows" = Table.SelectRows(#"Renamed Columns1", each ([Classification] = "Re-classification - NSDisp")),
    #"Sorted Rows" = Table.Sort(#"Filtered Rows",{{"Class_Dt", Order.Descending}}),
    #"Lowercased Text" = Table.TransformColumns(#"Sorted Rows",{{"Agent who reclassified", Text.Lower, type text}}),
    #"Renamed Columns2" = Table.RenameColumns(#"Lowercased Text",{{"Agent who reclassified", "User"}})
in
    #"Renamed Columns2"