let
    Source = Excel.Workbook(Web.Contents("https://hunterwar.sharepoint.com/sites/SharedServices/ssqc/Reports/CRA%20Report%20-%20Audit.xlsx"), null, false),
    #"Error 2_sheet" = Source{[Item="Error 2",Kind="Sheet"]}[Data],
    FilterNullAndWhitespace = each List.Select(_, each _ <> null and (not (_ is text) or Text.Trim(_) <> "")),
    #"Transposed Table" = Table.Transpose(#"Error 2_sheet"),
    #"Removed Top Rows" = Table.Skip(#"Transposed Table", each try List.IsEmpty(List.Skip(FilterNullAndWhitespace(Record.FieldValues(_)), 1)) otherwise false),
    #"Transposed Table1" = Table.Transpose(#"Removed Top Rows"),
    #"Removed Bottom Rows" = Table.RemoveLastN(#"Transposed Table1", each try List.IsEmpty(List.Skip(FilterNullAndWhitespace(Record.FieldValues(_)), 1)) otherwise false),
    #"Removed Top Rows1" = Table.Skip(#"Removed Bottom Rows", each try List.IsEmpty(List.Skip(FilterNullAndWhitespace(Record.FieldValues(_)), 1)) otherwise false),
    #"Removed Blank Rows" = Table.SelectRows(#"Removed Top Rows1", each not List.IsEmpty(FilterNullAndWhitespace(Record.FieldValues(_)))),
    #"Promoted Headers" = Table.PromoteHeaders(#"Removed Blank Rows", [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Account", Int64.Type}, {"Error", type any}, {"Documents on file", type any}, {"IDIcore", type any}, {"Was the error fixed", type any}, {"How many consumers", type any}, {"Input by", type any}, {"HOLD", type any}, {"Additional Update", type any}, {"Aditional notes", type any}, {"Column11", type any}})
in
    #"Changed Type"