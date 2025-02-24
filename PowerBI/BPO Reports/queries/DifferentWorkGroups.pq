let
    Source = Excel.Workbook(Web.Contents("https://hunterwar.sharepoint.com/sites/SharedServices/ssqc/Reports/Accounts%20in%20Diff%20WG%20-%20RA.xlsx"), null, true),
    Query1_Table = Source{[Item="Query1",Kind="Table"]}[Data],
    #"Changed Type" = Table.TransformColumnTypes(Query1_Table,{{"Cnsmr_Accnt_ID", Int64.Type}, {"Cnsmr_Accnt_Idntfr_Agncy_ID", Int64.Type}, {"consumer_type", type text}, {"Cnsmr_Idntfr_Agncy_ID", Int64.Type}, {"wrkgrp_shrt_nm", type text}, {"StatusCode", type text}, {"Changed Workgroup To", type text}, {"New Tag", type text}, {"Belongs to", type text}})
in
    #"Changed Type"