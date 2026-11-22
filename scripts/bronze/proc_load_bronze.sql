/*creating an procedure for easy and daily use */

create or alter procedure bronze.load_bronze as
begin
	declare @start_time datetime,@end_time datetime,@batch_start_time datetime,@batch_end_time datetime;
begin try	

	set @batch_start_time=getdate();
	print '===========================================';
	print 'Loading bronze layer';
	print '===========================================';


	print '--------------------------------------------';
	print 'LOADING CRM TABLES';
	print '--------------------------------------------';

	set @start_time =GETDATE();
	print 'truncating table bronze.crm_cust_info';
	/* we are using truncate and then bulk insert cause we went with the truncate & insert method while designing the architecture */
	truncate table bronze.crm_cust_info;

	print 'inserting data into : bronze.crm_cust_info';
	bulk insert bronze.crm_cust_info
	from 'D:\SQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
	with(
	firstrow=2,  --tells the sql to start the bulk insert from row 2
	fieldterminator=',',  --basically the delimiter used in the file so the sql knows how to take in the data
	tablock
	);
	set @end_time=GETDATE();
	print '>>load duration : '+ cast(datediff(second,@start_time,@end_time) as nvarchar) +' seconds';
	print '>>-------';


	--2
	set @start_time =GETDATE();
		print 'truncating table bronze.crm_sales_details';
	truncate table bronze.crm_sales_details;
	print 'inserting data into : bronze.crm_sales_details';
	bulk insert bronze.crm_sales_details
	from 'D:\SQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
	with(
	firstrow=2,  --tells the sql to start the bulk insert from row 2
	fieldterminator=',',  --basically the delimiter used in the file so the sql knows how to take in the data
	tablock
	);
	set @end_time=GETDATE();
	print '>>load duration : '+ cast(datediff(second,@start_time,@end_time) as nvarchar) +' seconds';
	print '>>-------';


	--select * from bronze.crm_prd_info;

	--3
	set @start_time =GETDATE();
		print 'truncating table bronze.crm_prd_info';
	truncate table bronze.crm_prd_info;
		print 'inserting data into : bronze.crm_prd_info';
	bulk insert bronze.crm_prd_info
	from 'D:\SQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
	with(
	firstrow=2,  --tells the sql to start the bulk insert from row 2
	fieldterminator=',',  --basically the delimiter used in the file so the sql knows how to take in the data
	tablock
	);
	set @end_time=GETDATE();
	print '>>load duration : '+ cast(datediff(second,@start_time,@end_time) as nvarchar) +' seconds';
	print '>>-------';


	print '--------------------------------------------';
	print 'LOADING ERP TABLES';
	print '--------------------------------------------';
	/*ERP DATASETS*/

	--4
	set @start_time =GETDATE();
		print 'truncating table bronze.erp_cust_az12';
	truncate table bronze.erp_cust_az12;
		print 'inserting data into : bronze.erp_cust_az12';
	bulk insert bronze.erp_cust_az12
	from 'D:\SQL\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
	with(
	firstrow=2,  --tells the sql to start the bulk insert from row 2
	fieldterminator=',',  --basically the delimiter used in the file so the sql knows how to take in the data
	tablock
	);
	set @end_time=GETDATE();
	print '>>load duration : '+ cast(datediff(second,@start_time,@end_time) as nvarchar) +' seconds';
	print '>>-------';


	--5
	set @start_time =GETDATE();
		print 'truncating table bronze.erp_loc_a101';
	truncate table bronze.erp_loc_a101;
		print 'inserting data into : bronze.erp_loc_a101';
	bulk insert bronze.erp_loc_a101
	from 'D:\SQL\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
	with(
	firstrow=2,  --tells the sql to start the bulk insert from row 2
	fieldterminator=',',  --basically the delimiter used in the file so the sql knows how to take in the data
	tablock
	);
	set @end_time=GETDATE();
	print '>>load duration : '+ cast(datediff(second,@start_time,@end_time) as nvarchar) +' seconds';
	print '>>-------';


	--6
	set @start_time =GETDATE();
		print 'truncating table bronze.erp_px_cat_g1v2';
	truncate table bronze.erp_px_cat_g1v2;
		print 'inserting data into : bronze.erp_px_cat_g1v2';
	bulk insert bronze.erp_px_cat_g1v2
	from 'D:\SQL\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
	with(
	firstrow=2,  --tells the sql to start the bulk insert from row 2
	fieldterminator=',',  --basically the delimiter used in the file so the sql knows how to take in the data
	tablock
	);
	set @end_time=GETDATE();
	print '>>load duration : '+ cast(datediff(second,@start_time,@end_time) as nvarchar) +' seconds';
	print '>>-------';

	set @batch_end_time=getdate();
	print '===========================================';
	print 'loading bronze layer is completed';
	print '>> total load duration : '+ cast(datediff(second,@batch_start_time,@batch_end_time) as nvarchar) +' seconds';
	print '===========================================';


end try
begin catch
	print '===========================================';
	print 'ERROR OCCURED DURING LAODING BRONZE LAYER';
	PRINT 'Error Message'+ ERROR_MESSAGE();
	PRINT 'Error Message'+ CAST(ERROR_NUMBER() AS NVARCHAR);
	PRINT 'Error Message'+ CAST(ERROR_STATE() AS NVARCHAR);
	print '===========================================';
end catch

end

