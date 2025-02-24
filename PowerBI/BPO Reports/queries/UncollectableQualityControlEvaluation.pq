let
    Source = SharePoint.Tables("https://hunterwar.sharepoint.com/sites/SharedServices/ssqc", [Implementation=null, ApiVersion=15]),
    #"018e2fcb-4985-4db4-9bf8-6d159b1f7bbe" = Source{[Id="018e2fcb-4985-4db4-9bf8-6d159b1f7bbe"]}[Items],
    #"Renamed Columns" = Table.RenameColumns(#"018e2fcb-4985-4db4-9bf8-6d159b1f7bbe",{{"ID", "ID.1"}}),
    #"Added Custom" = Table.AddColumn(#"Renamed Columns", "Auditor", each [Author][Title]),
    #"Replaced Value" = Table.ReplaceValue(#"Added Custom"," | Hunter Warfield","",Replacer.ReplaceText,{"Auditor"}),
    #"Removed Columns" = Table.RemoveColumns(#"Replaced Value",{"FileSystemObjectType", "Id", "ServerRedirectedEmbedUri", "ServerRedirectedEmbedUrl", "ContentTypeId", "OData__ColorTag", "ComplianceAssetId", "OData_DM9Id", "ID.1", "AuthorId", "EditorId", "OData__UIVersionString", "Attachments", "GUID", "FirstUniqueAncestorSecurableObject", "RoleAssignments", "AttachmentFiles", "ContentType", "GetDlpPolicyTip", "FieldValuesAsHtml", "FieldValuesForEdit", "File", "Folder", "LikedByInformation", "ParentList", "Properties", "Versions"}),
    #"Renamed Columns1" = Table.RenameColumns(#"Removed Columns",{{"Title", "account_number"}, {"Department0", "dept"}, {"Audit Type", "audit_type"}, {"Was the Account_x002", "moved_unnecessarily"}, {"Date of Account_x002", "date_of_acc_movement"}, {"Did the Rep se", "secured_correctly"}, {"Source", "source"}, {"Creditor Name", "creditor_name"}, {"Was there a UD", "udp_prior_move"}, {"Where documents alre", "reqtd_docs_already_on_file"}, {"Was the correct_x002", "correct_udp_type"}, {"Can we respond_x0020", "resp_w_docs_on_file"}, {"Is there Standard_x0", "stand_VOD_on_file"}}),
    #"Renamed Columns2" = Table.RenameColumns(#"Renamed Columns1",{{"Active Tradeline", "reporting"}, {"Comments", "comments"}, {"Auditor", "auditor"}}),
    #"Added Custom1" = Table.AddColumn(#"Renamed Columns2", "user", each [FieldValuesAsText][OData__x0044_M9]),
    #"Renamed Columns3" = Table.RenameColumns(#"Added Custom1",{{"Balance of Account", "balance_of_account"}}),
    #"Duplicated Column" = Table.DuplicateColumn(#"Renamed Columns3", "balance_of_account", "balance_of_account - Copy"),
    #"Renamed Columns4" = Table.RenameColumns(#"Duplicated Column",{{"balance_of_account - Copy", "actual_balance_of_account"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns4",{{"actual_balance_of_account", type number}}),
    #"Renamed Columns5" = Table.RenameColumns(#"Changed Type",{{"balance_of_account", "Balance of Account"}, {"Where all the ", "tags_rem"}}),
    #"Replaced Value1" = Table.ReplaceValue(#"Renamed Columns5",null,"N/A",Replacer.ReplaceValue,{"udp_prior_move"}),
    #"Replaced Value2" = Table.ReplaceValue(#"Replaced Value1","N/a","N/A",Replacer.ReplaceText,{"udp_prior_move"}),
    #"Replaced Value3" = Table.ReplaceValue(#"Replaced Value2",null,"N/A",Replacer.ReplaceValue,{"stand_VOD_on_file"}),
    #"Replaced Value4" = Table.ReplaceValue(#"Replaced Value3",null,"N/A",Replacer.ReplaceValue,{"reporting"}),
    #"Replaced Value5" = Table.ReplaceValue(#"Replaced Value4",null,"N/A",Replacer.ReplaceValue,{"comments"})
in
    #"Replaced Value5"