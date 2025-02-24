let
    Source = Excel.Workbook(Web.Contents("https://hunterwar.sharepoint.com/sites/SharedServices/ssqc/Reports/Missing%20Address%20Task%20-%20TRACKER%20(M).xlsx"), null, true),
    #"Missing Address Accounts_Sheet" = Source{[Item="Missing Address Accounts",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(#"Missing Address Accounts_Sheet", [PromoteAllScalars=true]),
    #"Added Custom" = Table.AddColumn(#"Promoted Headers", "ConvertedDate", each if [Month] = null or [Year] = null then null
else #date([Year], List.PositionOf({"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"}, [Month]) + 1, 1)),
    #"Changed Type" = Table.TransformColumnTypes(#"Added Custom",{{"ConvertedDate", type date}}),
    #"Replaced Value" = Table.ReplaceValue(#"Changed Type","Added from Idicore","Idicore",Replacer.ReplaceValue,{"Source"}),
    #"Replaced Value1" = Table.ReplaceValue(#"Replaced Value","Added from idicore","Idicore",Replacer.ReplaceValue,{"Source"}),
    #"Filtered Rows" = Table.SelectRows(#"Replaced Value1", each ([Cnsmr_Accnt_Idntfr_Agncy_ID] <> null))
in
    #"Filtered Rows"