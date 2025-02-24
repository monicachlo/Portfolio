let
    Source = Excel.Workbook(Web.Contents("https://hunterwar.sharepoint.com/sites/SharedServices/ssqc/Reports/CRA%20Report%20-%20Audit.xlsx"), null, false),
    #"Error 1_sheet" = Source{[Item="Error 1",Kind="Sheet"]}[Data],
    FilterNullAndWhitespace = each List.Select(_, each _ <> null and (not (_ is text) or Text.Trim(_) <> "")),
    #"Transposed Table" = Table.Transpose(#"Error 1_sheet"),
    #"Removed Top Rows" = Table.Skip(#"Transposed Table", each try List.IsEmpty(List.Skip(FilterNullAndWhitespace(Record.FieldValues(_)), 1)) otherwise false),
    #"Transposed Table1" = Table.Transpose(#"Removed Top Rows"),
    #"Removed Bottom Rows" = Table.RemoveLastN(#"Transposed Table1", each try List.IsEmpty(List.Skip(FilterNullAndWhitespace(Record.FieldValues(_)), 1)) otherwise false),
    #"Removed Top Rows1" = Table.Skip(#"Removed Bottom Rows", each try List.IsEmpty(List.Skip(FilterNullAndWhitespace(Record.FieldValues(_)), 1)) otherwise false),
    #"Promoted Headers" = Table.PromoteHeaders(#"Removed Top Rows1", [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Account", Int64.Type}, {"Error 1", type text}, {"Error 2", type text}, {"Error 3", type text}, {"Error 4", type any}, {"How many consumers", Int64.Type}, {"Documents on file", Int64.Type}, {"IDIcore", type any}, {"Was the error fixed", Int64.Type}, {"Input by", type text}, {"HOLD", Int64.Type}, {"Detach", Int64.Type}, {"Occuppant", type any}, {"Aditional notes", type text}, {"Column15", type any}}),
    #"Replaced Value" = Table.ReplaceValue(#"Changed Type","PREOTOCOL","PRETOCOL",Replacer.ReplaceText,{"Input by"}),
    #"Duplicated Column" = Table.DuplicateColumn(#"Replaced Value", "Account", "Account - Copy"),
    #"Renamed Columns" = Table.RenameColumns(#"Duplicated Column",{{"Account - Copy", "Account_Num_Text"}}),
    #"Changed Type1" = Table.TransformColumnTypes(#"Renamed Columns",{{"Account_Num_Text", type text}})
in
    #"Changed Type1"