/***************************************************************************************************
Procedure:          dbo.usp_ibmi_incr_order_all_silver
Create Date:        2024-10-01
Author:             Jeremy Shahan
Description:        Combine all incremental order data into a single table
Called by:          Fabric
					Pipeline: _ibmi_master_incr_order_all (sub)
Affected table(s):  silver.ibmi_incr_order_all
Usage:              EXEC dbo.usp_ibmi_incr_order_all_silver

****************************************************************************************************
SUMMARY OF CHANGES
#             Date(yyyy-mm-dd)    Author              Comments
------------------- ------------------ ------------------------------------------------------------
1            
***************************************************************************************************/

CREATE PROCEDURE [dbo].[usp_ibmi_incr_order_all_silver]
AS

SET NOCOUNT ON

DELETE FROM silver.ibmi_incr_order_all

INSERT INTO silver.ibmi_incr_order_all

SELECT 
	   [cd_order_origin_area_code]					AS order_origin_area_code
	  ,[cd_order_load_number]						AS order_load_number
      ,[cd_order_status_code]						AS order_status_code
      ,[cd_order_date]								AS order_date
      ,[cd_order_time]								AS order_time
      ,[cd_order_customer_code]						AS order_customer_code
      ,[cd_order_consignee_code]					AS order_consignee_code
      ,[cd_order_billto_code]						AS order_billto_code
      ,[cd_order_loadat_code]						AS order_loadat_code
      ,[cd_order_early_pickup_date]					AS order_early_pickup_date
      ,[cd_order_early_pickup_time]					AS order_early_pickup_time
      ,[is_pickup_required]							AS is_pickup_required
      ,[cd_order_early_delivery_date]				AS order_early_delivery_date
      ,[cd_order_early_delivery_time]				AS order_early_delivery_time
      ,[is_delivery_required]						AS is_delivery_required
      ,[cd_order_commodity_code]					AS order_commodity_code
      ,[cd_order_commodity_description]				AS order_commodity_description
      ,[cd_order_creation_initials]					AS order_creation_initials
      ,[cd_order_customer_phone_area_code]			AS order_customer_phone_area_code
      ,[cd_order_customer_phone_number]				AS order_customer_phone_number
      ,[cd_order_consignee_phone_area_code]			AS order_consignee_phone_area_code
      ,[cd_order_consignee_phone_number]			AS order_consignee_phone_number
      ,[cd_order_load_weight]						AS order_load_weight
      ,[cd_order_pallet_count]						AS order_pallet_count
      ,[cd_order_origin_city_code]					AS order_origin_city_code
      ,[cd_order_origin_state]						AS order_origin_state
      ,[cd_order_origin_bea_code]					AS order_origin_bea_code
      ,[cd_order_origin_gu_code]					AS order_origin_gu_code
      ,[cd_order_origin_city_short_name]			AS order_origin_city_short_name
      ,[cd_order_destination_city_code]				AS order_destination_city_code
      ,[cd_order_destination_state]					AS order_destination_state
      ,[cd_order_destination_bea_code]				AS order_destination_bea_code
      ,[cd_order_destination_gu_code]				AS order_destination_gu_code
      ,[cd_order_destination_city_short_name]		AS order_destination_city_short_name
      ,[cd_order_miles_billable]					AS order_miles_billable
      ,[cd_order_load_type]							AS order_load_type
      ,[cd_order_stop_count]						AS order_stop_count
      ,[cd_order_dispatch_count]					AS order_dispatch_count
      ,[cd_order_preload_trailer]					AS order_preload_trailer
      ,[cd_order_revenue_estimation]				AS order_revenue_estimation
      ,[cd_order_new_origin_area_code]				AS order_new_origin_area_code
      ,[cd_order_destination_area_code]				AS order_destination_area_code
      ,[cd_order_bill_of_lading]					AS order_bill_of_lading
      ,[cd_order_purchase_order]					AS order_purchase_order
      ,[cd_order_pick_up_code]						AS order_pick_up_code
      ,[cd_order_piece_count]						AS order_piece_count
      ,[cd_order_collection_method_code]			AS order_collection_method_code
      ,[cd_order_load_volume]						AS order_load_volume
      ,[cd_order_message]							AS order_message
      ,[cd_order_late_pickup_date]					AS order_late_pickup_date
      ,[cd_order_late_pickup_time]					AS order_late_pickup_time
      ,[cd_order_late_delivery_date]				AS order_late_delivery_date
      ,[cd_order_late_delivery_time]				AS order_late_delivery_time
      ,[cd_order_required_pallet_count]				AS order_required_pallet_count
      ,[cd_order_ship_date]							AS order_ship_date
      ,[order_ship_time]							AS order_ship_time
      ,[cd_order_temp_high]							AS order_temp_high
      ,[cd_order_temp_low]							AS order_temp_low
      ,[cd_order_last_update_date]					AS order_last_update_date
      ,[cd_order_last_update_time]					AS order_last_update_time
      ,[cd_order_last_update_initials]				AS order_last_update_initials
      ,[cd_order_company_code]						AS order_company_code
      ,[cd_order_division_code]						AS order_division_code
      ,[cd_order_lane_code]							AS order_lane_code
      ,[cd_order_seal_code]							AS order_seal_code
      ,[cd_order_service_failure_code]				AS order_service_failure_code
      ,[cd_order_driver_commit_flag]				AS order_driver_commit_flag
      ,[is_edi_load]								AS is_edi_load
      ,[is_edi_stats_complete]						AS is_edi_stats_complete
      ,[is_driver_loaded]							AS is_driver_loaded
      ,[is_driver_unloaded]							AS is_driver_unloaded
      ,[is_delivery_receipt_signed]					AS is_delivery_receipt_signed
      ,[cd_order_delivery_receipt_req]				AS order_delivery_receipt_req
      ,[cd_order_edi_message_billing_flag]			AS order_edi_message_billing_flag
      ,[is_load_just_in_time]						AS is_load_just_in_time
      ,[cd_order_edi_billing_code]					AS order_edi_billing_code
      ,[is_edi_inbound_or_outbound]					AS is_edi_inbound_or_outbound
      ,[cd_order_current_city_code]					AS order_current_city_code
      ,[cd_order_current_state]						AS order_current_state
      ,[cd_order_loaded_call_date]					AS order_loaded_call_date
      ,[cd_order_empty_call_date]					AS order_empty_call_date
      ,[cd_order_trailer_length]					AS order_trailer_length
      ,[cd_order_trailer_height]					AS order_trailer_height
      ,[has_permit]									AS has_permit
      ,[has_permit_complete]						AS has_permit_complete
      ,[cd_order_latitude]							AS order_latitude
      ,[cd_order_longitude]							AS order_longitude
      ,[is_tentitive_load]							AS is_tentitive_load
      ,[cd_order_hours_under_dispatch]				AS order_hours_under_dispatch
      ,[cd_order_origin_zone_code]					AS order_origin_zone_code
      ,[cd_order_origin_region_code]				AS order_origin_region_code
      ,[cd_order_destination_zone_code]				AS order_destination_zone_code
      ,[cd_order_destination_region_code]			AS order_destination_region_code
      ,[is_to_be_rated]								AS is_to_be_rated
      ,[has_new_gu_code]							AS has_new_gu_code
      ,[is_exclude_from_model]						AS is_exclude_from_model
      ,[cd_order_carry_over_flag]					AS order_carry_over_flag
      ,[cd_order_truck_type_requirement_code]		AS order_truck_type_requirement_code
      ,[cd_order_delivery_code]						AS order_delivery_code
FROM [silver].[ibmi_incr_cd_order]  

UNION

SELECT 
	*
FROM [silver].[ibmi_incr_tlb_order] 
WHERE NOT EXISTS
	(
	SELECT DISTINCT cd_order_load_number
	FROM   [silver].[ibmi_incr_cd_order]  
	WHERE cd_order_load_number = tlb_order_load_number
	) 

UNION

SELECT 
	*
FROM   [silver].[ibmi_incr_order]  
WHERE  NOT EXISTS
	(
	SELECT DISTINCT cd_order_load_number
	FROM [silver].[ibmi_incr_cd_order]  
	WHERE cd_order_load_number = order_load_number
	)
	AND NOT EXISTS
	(
	SELECT DISTINCT tlb_order_load_number
	FROM   [silver].[ibmi_incr_tlb_order]  
	WHERE tlb_order_load_number = order_load_number
	)