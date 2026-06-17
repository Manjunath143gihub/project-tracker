BEGIN
    FOR c IN (
        SELECT page_id, region_id, report_id
        FROM apex_application_page_ir_rpt
        WHERE application_id = 100
    ) LOOP
        BEGIN
            apex_ir.delete_report(
                p_application_id => 100,
                p_page_id        => c.page_id,
                p_region_id      => c.region_id,
                p_report_id      => c.report_id
            );
        EXCEPTION WHEN OTHERS THEN NULL;
        END;
    END LOOP;
    COMMIT;
END;
/
apex import -input .
exit
