let
    Source = Excel.Workbook(Web.Contents("https://hunterwar.sharepoint.com/sites/SharedServices/ssqc/Reports/CRA%20Report%20-%20Audit.xlsx"), null, false),
    #"Error 3_sheet" = Source{[Item="Error 3",Kind="Sheet"]}[Data],
    FilterNullAndWhitespace = each List.Select(_, each _ <> null and (not (_ is text) or Text.Trim(_) <> "")),
    #"Removed Top Rows" = Table.Skip(#"Error 3_sheet", each try List.IsEmpty(List.Skip(FilterNullAndWhitespace(Record.FieldValues(_)), 1)) otherwise false),
    #"Removed Blank Rows" = Table.SelectRows(#"Removed Top Rows", each not List.IsEmpty(FilterNullAndWhitespace(Record.FieldValues(_)))),
    #"Promoted Headers" = Table.PromoteHeaders(#"Removed Blank Rows", [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Account Number", Int64.Type}, {"Reason", type text}, {"Was updated?", Int64.Type}, {"How many consumers?", Int64.Type}, {"Input by", type text}, {"HOLD", Int64.Type}, {"Was the address changed by an agent?", Int64.Type}, {"Additional update?", type text}, {"Additional notes", type text}})
in
    #"Changed Type"