let
    Source = Excel.Workbook(Web.Contents("https://hunterwar-my.sharepoint.com/personal/mochinchilla_hunterwarfield_com/Documents/Roster.xlsx"), null, true),
    Table2_Table = Source{[Item="Table2",Kind="Table"]}[Data],
    #"Changed Type" = Table.TransformColumnTypes(Table2_Table,{{"Name", type text}, {"User", type text}, {"Manager", type text}, {"Department", type text}})
in
    #"Changed Type"