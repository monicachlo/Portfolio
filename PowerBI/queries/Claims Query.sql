SELECT  
    d.Cnsmr_Accnt_Idntfr_Agncy_ID AS 'Accnt#',
    Desk,
    cat2.tag_shrt_nm AS 'I-tag',
    d.State AS 'State',               
    d.Status_Code AS 'Status Code',   
    d.Last_Status_Date AS 'Date Desk Assigned',  
    cat2.cnsmr_accnt_tag_assgn_dt AS 'tag_date',  
    CASE 
        WHEN csreview.tag_shrt_nm IS NULL THEN 0 
        ELSE 1 
    END AS 'CSReview',  -- Added CSReview column with condition
    csreview.cnsmr_accnt_tag_assgn_dt AS 'CSReview_tag_date',  -- Added CSReview tag date
    CASE 
        WHEN ramailhd.tag_shrt_nm IS NULL THEN 0 
        ELSE 1 
    END AS 'RAMailHd',  -- Added RAMailHd column with condition
    ramailhd.cnsmr_accnt_tag_assgn_dt AS 'RAMailHd_Date_Assigned',  -- Added RAMailHd Date Assigned column
    CASE
        WHEN raholdtag.tag_shrt_nm IS NULL THEN 0 
        ELSE 1 
    END AS 'RAHold_Tag',  -- Added RA-HOLD column with condition
    c.SSN AS 'SSN'  -- Added SSN column from Consumer table
FROM  
    [CRS_Interface].[dbo].[Cnsmr_Accnt_Service] cas (NOLOCK)
    --join CRS_Interface.dbo.vw_cnsmr c (NOLOCK) on c.Cnsmr_Accnt_ID = cas.Cnsmr_Accnt_ID
    JOIN CRS_Interface.dbo.vw_debtor d (NOLOCK) on d.Cnsmr_Accnt_ID = cas.Cnsmr_Accnt_ID
    JOIN CRS_Interface.dbo.vw_Client cl (NOLOCK) on cl.Client_Number = d.Client_Number
    OUTER APPLY (
        SELECT TOP 1 
            cat2.cnsmr_accnt_id,
            t.tag_shrt_nm,
            cat2.cnsmr_accnt_tag_assgn_dt  
        FROM 
            crs5_oltp_replicated.dbo.cnsmr_Accnt_Tag cat2 (NOLOCK)
        JOIN 
            crs_interface.dbo.vw_tags t (NOLOCK) on t.tag_id = cat2.tag_id 
        WHERE 
            cat2.cnsmr_accnt_id = d.Cnsmr_Accnt_ID
            AND t.tag_shrt_nm LIKE 'I-%'
        --and cat2.tag_id in (1636,1638,1637,1639,1640,1641) 
        --and cat2.cnsmr_accnt_sft_delete_flg = 'N'
    ) Cat2
 
    OUTER APPLY (
        SELECT TOP 1 
            tag.tag_shrt_nm, 
            cat3.cnsmr_accnt_tag_assgn_dt
        FROM 
            crs5_oltp_replicated.dbo.cnsmr_Accnt_Tag cat3 (NOLOCK)
        JOIN 
            crs5_oltp_replicated.dbo.tag tag (NOLOCK) on tag.tag_id = cat3.tag_id
        WHERE 
            cat3.cnsmr_accnt_id = d.Cnsmr_Accnt_ID
            AND tag.tag_shrt_nm = 'CSReview'  -- Filtering for CSReview tag
    ) csreview  -- Added CSReview lookup
 
    OUTER APPLY (
        SELECT TOP 1 
            tag.tag_shrt_nm,
            cat4.cnsmr_accnt_tag_assgn_dt
        FROM 
            crs5_oltp_replicated.dbo.cnsmr_Accnt_Tag cat4 (NOLOCK)
        JOIN 
            crs5_oltp_replicated.dbo.tag tag (NOLOCK) on tag.tag_id = cat4.tag_id
        WHERE 
            cat4.cnsmr_accnt_id = d.Cnsmr_Accnt_ID
            AND tag.tag_shrt_nm = 'RAMailHd'  -- Filtering for RAMailHd tag
    ) ramailhd  -- Added RAMailHd lookup
 
    OUTER APPLY (
        SELECT TOP 1 
            tag.tag_shrt_nm,
            cat5.cnsmr_accnt_tag_assgn_dt
        FROM 
            crs5_oltp_replicated.dbo.cnsmr_Accnt_Tag cat5 (NOLOCK)
        JOIN 
            crs5_oltp_replicated.dbo.tag tag (NOLOCK) on tag.tag_id = cat5.tag_id
        WHERE 
            cat5.cnsmr_accnt_id = d.Cnsmr_Accnt_ID
            AND tag.tag_shrt_nm = 'RA-HOLD'  -- Filtering for RA-HOLD tag
    ) raholdtag -- Added RA-HOLD lookup
 
    LEFT JOIN CRS_Interface.dbo.Consumer c (NOLOCK) ON c.Cnsmr_Accnt_ID = d.Cnsmr_Accnt_ID  -- Join for SSN column

Where 
    --Desk like 'RA%'
    Desk in ('RACease','ResAdvct','RASpec','RAShrdSv','RAHS1','RAHS2','RAHS3','RAHS4','RAHS5','RAFL1','RAFL2','RAFL3','RAFL4','RAFL5','RAFL6','RAFL7');
