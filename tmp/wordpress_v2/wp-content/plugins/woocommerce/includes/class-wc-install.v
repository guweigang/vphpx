import rt

pub fn Class_WC_Install.newly_installed_option() string {
	return 'woocommerce_newly_installed'
}
pub fn Class_WC_Install.initial_installed_version() string {
	return 'woocommerce_initial_installed_version'
}
pub fn Class_WC_Install.store_id_option() string {
	return 'woocommerce_store_id'
}
struct Class_WC_Install {
	rt.PhpObjectBase
}

fn init_static_wc_install() {
		rt.init_static_prop('WC_Install', 'db_updates', rt.create_array([rt.ArrayItem{ key: '2.0.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_200_file_paths' }, rt.ArrayItem{ key: none, val: 'wc_update_200_permalinks' }, rt.ArrayItem{ key: none, val: 'wc_update_200_subcat_display' }, rt.ArrayItem{ key: none, val: 'wc_update_200_taxrates' }, rt.ArrayItem{ key: none, val: 'wc_update_200_line_items' }, rt.ArrayItem{ key: none, val: 'wc_update_200_images' }, rt.ArrayItem{ key: none, val: 'wc_update_200_db_version' }]) }, rt.ArrayItem{ key: '2.0.9', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_209_brazillian_state' }, rt.ArrayItem{ key: none, val: 'wc_update_209_db_version' }]) }, rt.ArrayItem{ key: '2.1.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_210_remove_pages' }, rt.ArrayItem{ key: none, val: 'wc_update_210_file_paths' }, rt.ArrayItem{ key: none, val: 'wc_update_210_db_version' }]) }, rt.ArrayItem{ key: '2.2.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_220_shipping' }, rt.ArrayItem{ key: none, val: 'wc_update_220_order_status' }, rt.ArrayItem{ key: none, val: 'wc_update_220_variations' }, rt.ArrayItem{ key: none, val: 'wc_update_220_attributes' }, rt.ArrayItem{ key: none, val: 'wc_update_220_db_version' }]) }, rt.ArrayItem{ key: '2.3.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_230_options' }, rt.ArrayItem{ key: none, val: 'wc_update_230_db_version' }]) }, rt.ArrayItem{ key: '2.4.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_240_options' }, rt.ArrayItem{ key: none, val: 'wc_update_240_shipping_methods' }, rt.ArrayItem{ key: none, val: 'wc_update_240_api_keys' }, rt.ArrayItem{ key: none, val: 'wc_update_240_refunds' }, rt.ArrayItem{ key: none, val: 'wc_update_240_db_version' }]) }, rt.ArrayItem{ key: '2.4.1', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_241_variations' }, rt.ArrayItem{ key: none, val: 'wc_update_241_db_version' }]) }, rt.ArrayItem{ key: '2.5.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_250_currency' }, rt.ArrayItem{ key: none, val: 'wc_update_250_db_version' }]) }, rt.ArrayItem{ key: '2.6.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_260_options' }, rt.ArrayItem{ key: none, val: 'wc_update_260_termmeta' }, rt.ArrayItem{ key: none, val: 'wc_update_260_zones' }, rt.ArrayItem{ key: none, val: 'wc_update_260_zone_methods' }, rt.ArrayItem{ key: none, val: 'wc_update_260_refunds' }, rt.ArrayItem{ key: none, val: 'wc_update_260_db_version' }]) }, rt.ArrayItem{ key: '3.0.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_300_grouped_products' }, rt.ArrayItem{ key: none, val: 'wc_update_300_settings' }, rt.ArrayItem{ key: none, val: 'wc_update_300_product_visibility' }, rt.ArrayItem{ key: none, val: 'wc_update_300_db_version' }]) }, rt.ArrayItem{ key: '3.1.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_310_downloadable_products' }, rt.ArrayItem{ key: none, val: 'wc_update_310_old_comments' }, rt.ArrayItem{ key: none, val: 'wc_update_310_db_version' }]) }, rt.ArrayItem{ key: '3.1.2', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_312_shop_manager_capabilities' }, rt.ArrayItem{ key: none, val: 'wc_update_312_db_version' }]) }, rt.ArrayItem{ key: '3.2.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_320_mexican_states' }, rt.ArrayItem{ key: none, val: 'wc_update_320_db_version' }]) }, rt.ArrayItem{ key: '3.3.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_330_image_options' }, rt.ArrayItem{ key: none, val: 'wc_update_330_webhooks' }, rt.ArrayItem{ key: none, val: 'wc_update_330_product_stock_status' }, rt.ArrayItem{ key: none, val: 'wc_update_330_set_default_product_cat' }, rt.ArrayItem{ key: none, val: 'wc_update_330_clear_transients' }, rt.ArrayItem{ key: none, val: 'wc_update_330_set_paypal_sandbox_credentials' }, rt.ArrayItem{ key: none, val: 'wc_update_330_db_version' }]) }, rt.ArrayItem{ key: '3.4.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_340_states' }, rt.ArrayItem{ key: none, val: 'wc_update_340_state' }, rt.ArrayItem{ key: none, val: 'wc_update_340_last_active' }, rt.ArrayItem{ key: none, val: 'wc_update_340_db_version' }]) }, rt.ArrayItem{ key: '3.4.3', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_343_cleanup_foreign_keys' }, rt.ArrayItem{ key: none, val: 'wc_update_343_db_version' }]) }, rt.ArrayItem{ key: '3.4.4', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_344_recreate_roles' }, rt.ArrayItem{ key: none, val: 'wc_update_344_db_version' }]) }, rt.ArrayItem{ key: '3.5.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_350_reviews_comment_type' }, rt.ArrayItem{ key: none, val: 'wc_update_350_db_version' }]) }, rt.ArrayItem{ key: '3.5.2', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_352_drop_download_log_fk' }]) }, rt.ArrayItem{ key: '3.5.4', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_354_modify_shop_manager_caps' }, rt.ArrayItem{ key: none, val: 'wc_update_354_db_version' }]) }, rt.ArrayItem{ key: '3.6.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_360_product_lookup_tables' }, rt.ArrayItem{ key: none, val: 'wc_update_360_term_meta' }, rt.ArrayItem{ key: none, val: 'wc_update_360_downloadable_product_permissions_index' }, rt.ArrayItem{ key: none, val: 'wc_update_360_db_version' }]) }, rt.ArrayItem{ key: '3.7.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_370_tax_rate_classes' }, rt.ArrayItem{ key: none, val: 'wc_update_370_mro_std_currency' }, rt.ArrayItem{ key: none, val: 'wc_update_370_db_version' }]) }, rt.ArrayItem{ key: '3.9.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_390_move_maxmind_database' }, rt.ArrayItem{ key: none, val: 'wc_update_390_change_geolocation_database_update_cron' }, rt.ArrayItem{ key: none, val: 'wc_update_390_db_version' }]) }, rt.ArrayItem{ key: '4.0.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_product_lookup_tables' }, rt.ArrayItem{ key: none, val: 'wc_update_400_increase_size_of_column' }, rt.ArrayItem{ key: none, val: 'wc_update_400_reset_action_scheduler_migration_status' }, rt.ArrayItem{ key: none, val: 'wc_admin_update_0201_order_status_index' }, rt.ArrayItem{ key: none, val: 'wc_admin_update_0230_rename_gross_total' }, rt.ArrayItem{ key: none, val: 'wc_admin_update_0251_remove_unsnooze_action' }, rt.ArrayItem{ key: none, val: 'wc_update_400_db_version' }]) }, rt.ArrayItem{ key: '4.4.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_440_insert_attribute_terms_for_variable_products' }, rt.ArrayItem{ key: none, val: 'wc_admin_update_110_remove_facebook_note' }, rt.ArrayItem{ key: none, val: 'wc_admin_update_130_remove_dismiss_action_from_tracking_opt_in_note' }, rt.ArrayItem{ key: none, val: 'wc_update_440_db_version' }]) }, rt.ArrayItem{ key: '4.5.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_450_sanitize_coupons_code' }, rt.ArrayItem{ key: none, val: 'wc_update_450_db_version' }]) }, rt.ArrayItem{ key: '5.0.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_500_fix_product_review_count' }, rt.ArrayItem{ key: none, val: 'wc_admin_update_160_remove_facebook_note' }, rt.ArrayItem{ key: none, val: 'wc_admin_update_170_homescreen_layout' }, rt.ArrayItem{ key: none, val: 'wc_update_500_db_version' }]) }, rt.ArrayItem{ key: '5.6.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_560_create_refund_returns_page' }, rt.ArrayItem{ key: none, val: 'wc_update_560_db_version' }]) }, rt.ArrayItem{ key: '6.0.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_600_migrate_rate_limit_options' }, rt.ArrayItem{ key: none, val: 'wc_admin_update_270_delete_report_downloads' }, rt.ArrayItem{ key: none, val: 'wc_admin_update_271_update_task_list_options' }, rt.ArrayItem{ key: none, val: 'wc_admin_update_280_order_status' }, rt.ArrayItem{ key: none, val: 'wc_admin_update_290_update_apperance_task_option' }, rt.ArrayItem{ key: none, val: 'wc_admin_update_290_delete_default_homepage_layout_option' }, rt.ArrayItem{ key: none, val: 'wc_update_600_db_version' }]) }, rt.ArrayItem{ key: '6.3.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_630_create_product_attributes_lookup_table' }, rt.ArrayItem{ key: none, val: 'wc_admin_update_300_update_is_read_from_last_read' }, rt.ArrayItem{ key: none, val: 'wc_update_630_db_version' }]) }, rt.ArrayItem{ key: '6.4.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_640_add_primary_key_to_product_attributes_lookup_table' }, rt.ArrayItem{ key: none, val: 'wc_admin_update_340_remove_is_primary_from_note_action' }, rt.ArrayItem{ key: none, val: 'wc_update_640_db_version' }]) }, rt.ArrayItem{ key: '6.5.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_650_approved_download_directories' }]) }, rt.ArrayItem{ key: '6.5.1', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_651_approved_download_directories' }]) }, rt.ArrayItem{ key: '6.7.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_670_purge_comments_count_cache' }, rt.ArrayItem{ key: none, val: 'wc_update_670_delete_deprecated_remote_inbox_notifications_option' }]) }, rt.ArrayItem{ key: '7.0.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_700_remove_download_log_fk' }, rt.ArrayItem{ key: none, val: 'wc_update_700_remove_recommended_marketing_plugins_transient' }]) }, rt.ArrayItem{ key: '7.2.1', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_721_adjust_new_zealand_states' }, rt.ArrayItem{ key: none, val: 'wc_update_721_adjust_ukraine_states' }]) }, rt.ArrayItem{ key: '7.2.2', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_722_adjust_new_zealand_states' }, rt.ArrayItem{ key: none, val: 'wc_update_722_adjust_ukraine_states' }]) }, rt.ArrayItem{ key: '7.5.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_750_add_columns_to_order_stats_table' }, rt.ArrayItem{ key: none, val: 'wc_update_750_disable_new_product_management_experience' }]) }, rt.ArrayItem{ key: '7.7.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_770_remove_multichannel_marketing_feature_options' }]) }, rt.ArrayItem{ key: '7.9.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_790_blockified_product_grid_block' }]) }, rt.ArrayItem{ key: '8.1.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_810_migrate_transactional_metadata_for_hpos' }]) }, rt.ArrayItem{ key: '8.3.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_830_rename_checkout_template' }, rt.ArrayItem{ key: none, val: 'wc_update_830_rename_cart_template' }]) }, rt.ArrayItem{ key: '8.6.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_860_remove_recommended_marketing_plugins_transient' }]) }, rt.ArrayItem{ key: '8.7.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_870_prevent_listing_of_transient_files_directory' }]) }, rt.ArrayItem{ key: '8.9.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_890_update_connect_to_woocommerce_note' }, rt.ArrayItem{ key: none, val: 'wc_update_890_update_paypal_standard_load_eligibility' }]) }, rt.ArrayItem{ key: '8.9.1', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_891_create_plugin_autoinstall_history_option' }]) }, rt.ArrayItem{ key: '9.1.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_910_add_launch_your_store_tour_option' }, rt.ArrayItem{ key: none, val: 'wc_update_910_remove_obsolete_user_meta' }]) }, rt.ArrayItem{ key: '9.2.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_920_add_wc_hooked_blocks_version_option' }]) }, rt.ArrayItem{ key: '9.3.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_930_add_woocommerce_coming_soon_option' }, rt.ArrayItem{ key: none, val: 'wc_update_930_migrate_user_meta_for_launch_your_store_tour' }]) }, rt.ArrayItem{ key: '9.4.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_940_add_phone_to_order_address_fts_index' }, rt.ArrayItem{ key: none, val: 'wc_update_940_remove_help_panel_highlight_shown' }]) }, rt.ArrayItem{ key: '9.5.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_950_tracking_option_autoload' }]) }, rt.ArrayItem{ key: '9.6.1', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_961_migrate_default_email_base_color' }]) }, rt.ArrayItem{ key: '9.8.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_980_remove_order_attribution_install_banner_dismissed_option' }]) }, rt.ArrayItem{ key: '9.8.5', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_985_enable_new_payments_settings_page_feature' }]) }, rt.ArrayItem{ key: '9.9.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_990_remove_wc_count_comments_transient' }, rt.ArrayItem{ key: none, val: 'wc_update_990_remove_email_notes' }]) }, rt.ArrayItem{ key: '10.0.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_1000_multisite_visibility_setting' }, rt.ArrayItem{ key: none, val: 'wc_update_1000_remove_patterns_toolkit_transient' }]) }, rt.ArrayItem{ key: '10.2.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_1020_add_old_refunded_order_items_to_product_lookup_table' }]) }, rt.ArrayItem{ key: '10.3.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_1030_add_comments_date_type_index' }]) }, rt.ArrayItem{ key: '10.4.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_1040_add_idx_date_paid_status_parent' }, rt.ArrayItem{ key: none, val: 'wc_update_1040_cleanup_legacy_ptk_patterns_fetching' }]) }, rt.ArrayItem{ key: '10.5.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_1050_migrate_brand_permalink_setting' }, rt.ArrayItem{ key: none, val: 'wc_update_1050_enable_autoload_options' }, rt.ArrayItem{ key: none, val: 'wc_update_1050_add_idx_user_email' }, rt.ArrayItem{ key: none, val: 'wc_update_1050_remove_deprecated_marketplace_option' }]) }, rt.ArrayItem{ key: '10.6.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_1060_add_woo_idx_comment_approved_type_index' }]) }, rt.ArrayItem{ key: '10.7.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_1070_disable_hpos_sync_on_read' }]) }, rt.ArrayItem{ key: '10.8.0', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_1080_migrate_analytics_import_option' }, rt.ArrayItem{ key: none, val: 'wc_update_1080_backfill_email_template_sync_meta' }]) }, rt.ArrayItem{ key: '10.8.0-2', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc_update_10802_restore_orders_meta_key_value_index' }]) }]))
}

fn Class_WC_Install.init() {
	mut var_GLOBALS := rt.new_null()
	if !(!rt.is_true(var_GLOBALS.array_get(rt.new_string('wc_uninstalling_plugin')))) {
		return
	}
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'check_version' }]), rt.new_int(5)])
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'manual_database_update' }]), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('woocommerce_newly_installed'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'maybe_enable_hpos' }]), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('woocommerce_newly_installed'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_coming_soon_option' }]), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('woocommerce_newly_installed'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'enable_email_improvements_for_newly_installed' }]), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('woocommerce_newly_installed'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'enable_customer_stock_notifications_signups' }]), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('woocommerce_newly_installed'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'enable_analytics_scheduled_import' }]), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('woocommerce_updated'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'enable_email_improvements_for_existing_merchants' }]), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('woocommerce_run_update_callback'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'run_update_callback' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_update_db_to_current_version'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'update_db_version' }])])
	rt.call_function('add_action', [rt.new_string('admin_init'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'install_actions' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_page_created'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'page_created' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('plugin_action_links_' + (rt.get_constant('WC_PLUGIN_BASENAME')).str()), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'plugin_action_links' }])])
	rt.call_function('add_filter', [rt.new_string('plugin_row_meta'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'plugin_row_meta' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('wpmu_drop_tables'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'wpmu_drop_tables' }])])
	rt.call_function('add_filter', [rt.new_string('cron_schedules'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'cron_schedules' }])])
	rt.call_function('add_action', [rt.new_string('admin_init'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'newly_installed' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_activate_legacy_rest_api_plugin'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'maybe_install_legacy_api_plugin' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_get_note_from_db'), rt.create_array([rt.ArrayItem{ key: none, val: Class_WC_Notes_Run_Db_Update.class() }, rt.ArrayItem{ key: none, val: 'maybe_update_notice' }]), rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('woocommerce_hide_update_notice'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'remove_update_db_notice' }])])
}

fn Class_WC_Install.newly_installed() {
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string(Class_WC_Install.newly_installed_option()), rt.new_bool(false)]))) {
		rt.call_function('do_action', [rt.new_string('woocommerce_newly_installed')])
		rt.call_function('do_action_deprecated', [rt.new_string('woocommerce_admin_newly_installed'), rt.new_array(), rt.new_string('6.5.0'), rt.new_string('woocommerce_newly_installed')])
		rt.call_function('update_option', [rt.new_string(Class_WC_Install.newly_installed_option()), rt.new_string('no')])
		rt.call_function('add_option', [rt.new_string(Class_WC_Install.initial_installed_version()), rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version'), rt.new_string(''), rt.new_bool(false)])
	}
}

fn Class_WC_Install.check_version() {
	mut var_wc_version := rt.call_function('get_option', [rt.new_string('woocommerce_version')])
	mut var_wc_code_version := rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version')
	mut var_requires_update := rt.call_function('version_compare', [var_wc_version.clone(), var_wc_code_version.clone(), rt.new_string('<')])
	mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_0 := iife_temp_0.is_defined(rt.new_string('IFRAME_REQUEST'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) && rt.is_true(var_requires_update) {
		Class_WC_Install.install()
		rt.call_function('do_action', [rt.new_string('woocommerce_updated')])
		rt.call_function('do_action_deprecated', [rt.new_string('woocommerce_admin_updated'), rt.new_array(), var_wc_code_version.clone(), rt.new_string('woocommerce_updated')])
	}
}

fn Class_WC_Install.manual_database_update() {
	mut var_blog_id := rt.call_function('get_current_blog_id', []rt.PhpVal{})
	rt.call_function('add_action', [rt.new_string('wp_' + (var_blog_id).str() + '_wc_updater_cron'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'run_manual_database_update' }])])
}

fn Class_WC_Install.wc_admin_db_update_notice() {
	if rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_wc_admin_active', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('get_option', [rt.new_string('woocommerce_admin_install_timestamp')]))))) {
		create_wc_notes_run_db_update()
	}
}

fn Class_WC_Install.add_update_db_notice() {
	mut iife_temp_1 := Class_WC_Admin_Notices{}
	mut iife_result_1 := iife_temp_1.has_notice(rt.new_string('update'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_1)))) {
	mut iife_temp_2 := Class_WC_Admin_Notices{}
	mut iife_result_2 := iife_temp_2.add_notice(rt.new_string('update'), rt.new_bool(true))
	}
	if rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_wc_admin_active', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('get_option', [rt.new_string('woocommerce_admin_install_timestamp')]))))) {
		mut iife_temp_3 := Class_WC_Notes_Run_Db_Update{}
		mut iife_result_3 := iife_temp_3.add_notice()
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.new_string('Error adding db update note: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-updater' }])])
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
}

fn Class_WC_Install.remove_update_db_notice() {
	mut iife_temp_4 := Class_WC_Admin_Notices{}
	mut iife_result_4 := iife_temp_4.has_notice(rt.new_string('update'))
	if rt.is_true(iife_result_4) {
	mut iife_temp_5 := Class_WC_Admin_Notices{}
	mut iife_result_5 := iife_temp_5.remove_notice(rt.new_string('update'), rt.new_bool(true))
	}
	if rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_wc_admin_active', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('get_option', [rt.new_string('woocommerce_admin_install_timestamp')]))))) {
		mut iife_temp_6 := Class_WC_Notes_Run_Db_Update{}
		mut iife_result_6 := iife_temp_6.set_notice_actioned()
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.clone()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.new_string('Error removing db update note: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-updater' }])])
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
}

fn Class_WC_Install.run_manual_database_update() {
	Class_WC_Install.update()
}

fn Class_WC_Install.run_update_callback(var_update_callback rt.PhpVal) {
	rt.include_file(@DIR + '/wc-update-functions.php', '2')
	if rt.is_true(rt.call_function('is_callable', [var_update_callback.clone()])) {
		Class_WC_Install.run_update_callback_start(var_update_callback.clone())
		mut var_result := rt.new_bool((rt.call_function('call_user_func', [var_update_callback.clone()])).to_bool())
		Class_WC_Install.run_update_callback_end(var_update_callback.clone(), var_result.clone())
	}
}

fn Class_WC_Install.run_update_callback_start(var_callback rt.PhpVal) {
	mut var_callback_mutated := var_callback
	rt.call_function('wc_maybe_define_constant', [rt.new_string('WC_UPDATING'), rt.new_bool(true)])
}

fn Class_WC_Install.run_update_callback_end(var_callback rt.PhpVal, var_result rt.PhpVal) {
	mut var_callback_mutated := var_callback
	mut var_result_mutated := var_result
	if rt.is_true(var_result_mutated) {
		rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{}), 'add', [rt.new_string('woocommerce_run_update_callback'), rt.create_array([rt.ArrayItem{ key: 'update_callback', val: var_callback_mutated }]), rt.new_string('woocommerce-db-updates')])
	}
}

fn Class_WC_Install.install_actions() {
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('do_update_woocommerce')))) {
		rt.call_function('check_admin_referer', [rt.new_string('wc_db_update'), rt.new_string('wc_db_update_nonce')])
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'info', [rt.new_string('Manual database update triggered.'), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-updater' }])])
		Class_WC_Install.update()
		Class_WC_Install.add_update_db_notice()
		mut var_return_url := if !(rt.get_superglobal('_GET').array_get(rt.new_string('return_url'))).is_null() { rt.get_superglobal('_GET').array_get(rt.new_string('return_url')) } else { rt.new_string('') }
		if !(!rt.is_true(var_return_url)) {
			if rt.is_true(rt.identical(rt.new_string('wc-admin-referer'), var_return_url)) {
				var_return_url = rt.call_function('preg_replace', [rt.new_string('/^' + (rt.call_function('preg_quote', [rt.call_function('untrailingslashit', [rt.call_function('admin_url', []rt.PhpVal{})]), rt.new_string('/')])).str() + '\\/?/i'), rt.new_string(''), if rt.is_true(rt.call_function('wp_get_referer', []rt.PhpVal{})) { rt.call_function('wp_get_referer', []rt.PhpVal{}) } else { rt.new_string('') }])
				if rt.is_true(var_return_url) && rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_return_url.clone(), rt.new_string('do_update_woocommerce')]))) {
				var_return_url = rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: '_wpnonce' }, rt.ArrayItem{ key: none, val: '_wc_notice_nonce' }, rt.ArrayItem{ key: none, val: 'wc_db_update' }, rt.ArrayItem{ key: none, val: 'wc_db_update_nonce' }, rt.ArrayItem{ key: none, val: 'wc-hide-notice' }]), rt.call_function('admin_url', [var_return_url.clone()])])
				} else {
				var_return_url = rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings')])
				}
			}
			var_return_url = rt.call_function('esc_url_raw', [rt.call_function('wp_unslash', [var_return_url.clone()])])
			rt.call_function('wp_safe_redirect', [var_return_url.clone()])
			exit(0)
		}
	}
}

fn Class_WC_Install.install() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_blog_installed', []rt.PhpVal{}))))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Install.create_lock())))) {
		return
	}
	rt.call_function('wc_maybe_define_constant', [rt.new_string('WC_INSTALLING'), rt.new_bool(true)])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	Class_WC_Install.install_core()
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto finally_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()

finally_label_3:
	Class_WC_Install.release_lock()
	if rt.has_exception() { return }

end_label_3:
	rt.call_function('add_option', [rt.new_string('woocommerce_admin_install_timestamp'), rt.call_function('time', []rt.PhpVal{})])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_action', [rt.new_string('woocommerce_flush_rewrite_rules')]))))) {
		rt.call_function('flush_rewrite_rules', []rt.PhpVal{})
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_flush_rewrite_rules')])
	rt.call_function('do_action', [rt.new_string('woocommerce_installed')])
	rt.call_function('do_action', [rt.new_string('woocommerce_admin_installed')])
}

fn Class_WC_Install.install_core() {
	if rt.is_true(Class_WC_Install.is_new_install()) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [rt.new_string(Class_WC_Install.newly_installed_option()), rt.new_bool(false)]))))) {
		rt.call_function('update_option', [rt.new_string(Class_WC_Install.newly_installed_option()), rt.new_string('yes')])
	}
	rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'wpdb_table_fix', []rt.PhpVal{})
	Class_WC_Install.remove_admin_notices()
	Class_WC_Install.create_tables()
	Class_WC_Install.verify_base_tables()
	Class_WC_Install.create_options()
	Class_WC_Install.migrate_options()
	Class_WC_Install.create_roles()
	Class_WC_Install.setup_environment()
	Class_WC_Install.create_terms()
	Class_WC_Install.clear_cron_jobs()
	Class_WC_Install.delete_obsolete_notes()
	Class_WC_Install.create_files()
	Class_WC_Install.maybe_create_pages()
	Class_WC_Install.maybe_set_activation_transients()
	Class_WC_Install.set_paypal_standard_load_eligibility()
	Class_WC_Install.update_wc_version()
	Class_WC_Install.maybe_update_db_version()
	Class_WC_Install.maybe_set_store_id()
	Class_WC_Install.maybe_install_legacy_api_plugin()
	Class_WC_Install.maybe_activate_legacy_api_enabled_option()
}

fn Class_WC_Install.create_lock() bool {
	mut var_wpdb := rt.new_null()
	mut var_created_lock := rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('INSERT INTO '), rt.get_property(var_wpdb, 'options')), rt.new_string(' (option_name, option_value, autoload) VALUES (\'wc_installing\', %d, \'no\')')), rt.call_function('time', []rt.PhpVal{})])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_created_lock)))) {
	var_created_lock = rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'options')), rt.new_string(' SET option_value = %d WHERE option_name = \'wc_installing\' AND option_value < %d')), rt.call_function('time', []rt.PhpVal{}), rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.get_constant('MINUTE_IN_SECONDS'), rt.new_int(10)))])])
	}
	if rt.is_true(var_created_lock) {
		rt.call_function('set_transient', [rt.new_string('wc_installing'), rt.new_string('yes'), rt.mul(rt.get_constant('MINUTE_IN_SECONDS'), rt.new_int(10))])
		return true
	}
	return false
}

fn Class_WC_Install.release_lock() {
	mut var_wpdb := rt.new_null()
	rt.call_function('delete_transient', [rt.new_string('wc_installing')])
	rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'options')), rt.new_string(' WHERE option_name = \'wc_installing\''))])
}

fn Class_WC_Install.verify_base_tables(modify_notice bool, execute bool) rt.PhpVal {
	if var_execute {
		Class_WC_Install.create_tables()
	}
	mut var_schema := Class_WC_Install.get_schema()
	mut var_hpos_settings := rt.call_function('filter_var_array', [rt.create_array([rt.ArrayItem{ key: 'cot', val: rt.call_function('get_option', [Class_CustomOrdersTableController.custom_orders_table_usage_enabled_option()]) }, rt.ArrayItem{ key: 'data_sync', val: rt.call_function('get_option', [Class_DataSynchronizer.orders_data_sync_enabled_option()]) }]), rt.create_array([rt.ArrayItem{ key: 'cot', val: rt.get_constant('FILTER_VALIDATE_BOOLEAN') }, rt.ArrayItem{ key: 'data_sync', val: rt.get_constant('FILTER_VALIDATE_BOOLEAN') }])])
	if rt.is_true(rt.call_function('in_array', [rt.new_bool(true), var_hpos_settings.clone(), rt.new_bool(true)])) {
		var_schema = rt.concat(var_schema, rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_OrdersTableDataStore.class()]), 'get_database_schema', []rt.PhpVal{}))
	}
	mut var_missing_tables := rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil.class()]), 'get_missing_tables', [var_schema.clone()])
	if 0 < var_missing_tables.clone().array_count() {
		if var_modify_notice {
		mut iife_temp_7 := Class_WC_Admin_Notices{}
		mut iife_result_7 := iife_temp_7.add_notice(rt.new_string('base_tables_missing'))
		}
		rt.call_function('update_option', [rt.new_string('woocommerce_schema_missing_tables'), var_missing_tables.clone()])
	} else {
		if var_modify_notice {
		mut iife_temp_8 := Class_WC_Admin_Notices{}
		mut iife_result_8 := iife_temp_8.remove_notice(rt.new_string('base_tables_missing'))
		}
		rt.call_function('update_option', [rt.new_string('woocommerce_schema_version'), rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'db_version')])
		rt.call_function('delete_option', [rt.new_string('woocommerce_schema_missing_tables')])
	}
	return var_missing_tables.clone()
}

fn Class_WC_Install.remove_admin_notices() {
	rt.include_file(@DIR + '/admin/class-wc-admin-notices.php', '2')
	mut iife_temp_9 := Class_WC_Admin_Notices{}
	mut iife_result_9 := iife_temp_9.remove_all_notices()
	Class_WC_Install.remove_update_db_notice()
}

fn Class_WC_Install.setup_environment() {
	mut iife_temp_10 := Class_WC_Post_types{}
	mut iife_result_10 := iife_temp_10.register_post_types()
	mut iife_temp_11 := Class_WC_Post_types{}
	mut iife_result_11 := iife_temp_11.register_taxonomies()
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'), 'init_query_vars', []rt.PhpVal{})
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'), 'add_endpoints', []rt.PhpVal{})
mut iife_temp_12 := Class_WC_Auth{}
mut iife_result_12 := iife_temp_12.add_endpoint()
mut iife_temp_13 := Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine{}
mut iife_result_13 := iife_temp_13.add_endpoint()
}

fn Class_WC_Install.is_new_install() bool {
	return rt.call_function('get_option', [rt.new_string('woocommerce_version'), rt.new_null()]).is_null() || rt.is_true(rt.identical(-1, rt.call_function('wc_get_page_id', [rt.new_string('shop')]))) && rt.is_true(rt.identical(rt.new_int(0), rt.call_function('array_sum', [rt.cast_array(rt.call_function('wp_count_posts', [rt.new_string('product')]))])))
}

fn Class_WC_Install.needs_db_update() bool {
	mut var_current_db_version := rt.call_function('get_option', [rt.new_string('woocommerce_db_version'), rt.new_null()])
	return !(var_current_db_version.clone().is_null()) && rt.is_true(rt.call_function('version_compare', [var_current_db_version.clone(), rt.call_function('array_key_last', [rt.get_static_prop('WC_Install', 'db_updates')]), rt.new_string('<')]))
}

fn Class_WC_Install.is_db_auto_update_enabled() bool {
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_enable_auto_update_db'), rt.new_bool(true)])).to_bool()
}

fn Class_WC_Install.maybe_set_activation_transients() {
	if rt.is_true(Class_WC_Install.is_new_install()) {
		rt.call_function('set_transient', [rt.new_string('_wc_activation_redirect'), rt.new_int(1), rt.new_int(30)])
	}
}

fn Class_WC_Install.maybe_update_db_version() {
	if rt.is_true(Class_WC_Install.needs_db_update()) {
		if rt.is_true(Class_WC_Install.is_db_auto_update_enabled()) {
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'info', [rt.new_string('Automatic database update triggered.'), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-updater' }])])
			Class_WC_Install.update()
		} else {
			Class_WC_Install.add_update_db_notice()
		}
	} else {
		Class_WC_Install.update_db_version()
	}
}

fn Class_WC_Install.maybe_set_store_id() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [rt.new_string(Class_WC_Install.store_id_option()), rt.new_bool(false)]))))) {
		rt.call_function('add_option', [rt.new_string(Class_WC_Install.store_id_option()), rt.call_function('wp_generate_uuid4', []rt.PhpVal{})])
	}
}

fn Class_WC_Install.update_wc_version() {
	rt.call_function('update_option', [rt.new_string('woocommerce_version'), rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version')])
}

fn Class_WC_Install.get_db_update_callbacks() rt.PhpVal {
	return rt.get_static_prop('WC_Install', 'db_updates')
}

fn Class_WC_Install.update() {
	mut var_current_db_version := rt.call_function('get_option', [rt.new_string('woocommerce_db_version')])
	mut var_updates := Class_WC_Install.get_db_update_callbacks()
	mut var_scheduled_time := rt.call_function('time', []rt.PhpVal{})
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'info', [rt.call_function('sprintf', [rt.new_string('Scheduling database updates (from %s)...'), var_current_db_version.clone()]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-updater' }])])
	if rt.is_true(Class_WC_Install.is_db_auto_update_enabled()) {
		mut var_scheduled_time_delay := rt.call_function('absint', [rt.call_function('apply_filters', [rt.new_string('woocommerce_db_update_schedule_delay'), rt.new_int(0)])])
		if rt.is_true(rt.greater(var_scheduled_time_delay, rt.new_int(0))) {
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'info', [rt.call_function('sprintf', [rt.new_string('  Updates will begin running in approximately %s.'), rt.call_function('human_time_diff', [rt.new_int(0), var_scheduled_time_delay.clone()])]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-updater' }])])
			var_scheduled_time = rt.add(var_scheduled_time, var_scheduled_time_delay)
		}
	}
	mut var_loop := rt.new_int(0)
	mut iter_1 := var_updates.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_update_callbacks := item_1.val
		mut var_version := item_1.key
		if rt.is_true(rt.call_function('version_compare', [var_current_db_version.clone(), var_version.clone(), rt.new_string('>=')])) {
			continue
		}
		mut iter_2 := var_update_callbacks.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_update_callback := item_2.val
			rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{}), 'schedule_single', [rt.add(var_scheduled_time, var_loop), rt.new_string('woocommerce_run_update_callback'), rt.create_array([rt.ArrayItem{ key: 'update_callback', val: var_update_callback }]), rt.new_string('woocommerce-db-updates')])
			rt.pre_inc(var_loop)
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'info', [rt.call_function('sprintf', [rt.new_string('  [%s] Scheduled \'%s\'.'), var_version.clone(), var_update_callback.clone()]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-updater' }])])
		}
	}
	mut var_wc_db_version := rt.call_function('array_key_last', [var_updates.clone()])
	var_wc_db_version = if rt.is_true(rt.call_function('version_compare', [rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version'), var_wc_db_version.clone(), rt.new_string('>')])) { rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version') } else { var_wc_db_version }
	mut var_success := rt.new_bool(true)
	if rt.is_true(rt.call_function('version_compare', [var_current_db_version.clone(), var_wc_db_version.clone(), rt.new_string('<')])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{}), 'get_next', [rt.new_string('woocommerce_update_db_to_current_version')]))))) {
	var_success = rt.greater(rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{}), 'schedule_single', [rt.add(var_scheduled_time, var_loop), rt.new_string('woocommerce_update_db_to_current_version'), rt.create_array([rt.ArrayItem{ key: 'version', val: var_wc_db_version }]), rt.new_string('woocommerce-db-updates')]), rt.new_int(0))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_success)))) {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.new_string('There was an error scheduling database updates.'), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-updater' }])])
		if rt.is_true(Class_WC_Install.is_db_auto_update_enabled()) {
			Class_WC_Install.add_update_db_notice()
		}
		return
	}
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'info', [rt.new_string('Database updates scheduled.'), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-updater' }])])
}

fn Class_WC_Install.update_db_version(var_version rt.PhpVal) {
	mut var_version_mutated := var_version
	if rt.is_true(rt.new_bool(var_version_mutated.clone().is_null())) {
	mut var_last_db_version := rt.call_function('array_key_last', [rt.get_static_prop('WC_Install', 'db_updates')])
	var_version_mutated = if rt.is_true(rt.call_function('version_compare', [rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version'), var_last_db_version.clone(), rt.new_string('>')])) { rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version') } else { var_last_db_version }
	}
	rt.call_function('update_option', [rt.new_string('woocommerce_db_version'), var_version_mutated.clone()])
}

fn Class_WC_Install.cron_schedules(var_schedules rt.PhpVal) rt.PhpVal {
	mut var_schedules_mutated := var_schedules
	var_schedules_mutated.array_set('monthly', rt.create_array([rt.ArrayItem{ key: 'interval', val: rt.get_constant('MONTH_IN_SECONDS') }, rt.ArrayItem{ key: 'display', val: rt.call_function('__', [rt.new_string('Monthly'), rt.new_string('woocommerce')]) }]))
	var_schedules_mutated.array_set('fifteendays', rt.create_array([rt.ArrayItem{ key: 'interval', val: rt.mul(rt.new_int(15), rt.get_constant('DAY_IN_SECONDS')) }, rt.ArrayItem{ key: 'display', val: rt.call_function('__', [rt.new_string('Every 15 Days'), rt.new_string('woocommerce')]) }]))
	return var_schedules_mutated.clone()
}

fn Class_WC_Install.clear_cron_jobs() {
	rt.call_function('wp_clear_scheduled_hook', [rt.new_string('woocommerce_scheduled_sales')])
	rt.call_function('wp_clear_scheduled_hook', [rt.new_string('woocommerce_cancel_unpaid_orders')])
	rt.call_function('wp_clear_scheduled_hook', [rt.new_string('woocommerce_cleanup_sessions')])
	rt.call_function('wp_clear_scheduled_hook', [rt.new_string('woocommerce_cleanup_personal_data')])
	rt.call_function('wp_clear_scheduled_hook', [rt.new_string('woocommerce_cleanup_logs')])
	rt.call_function('wp_clear_scheduled_hook', [rt.new_string('woocommerce_geoip_updater')])
	rt.call_function('wp_clear_scheduled_hook', [rt.new_string('woocommerce_tracker_send_event')])
	rt.call_function('wp_clear_scheduled_hook', [rt.new_string('woocommerce_cleanup_rate_limits')])
}

fn Class_WC_Install.maybe_create_pages() {
	if !rt.is_true(rt.call_function('get_option', [rt.new_string('woocommerce_db_version')])) {
		Class_WC_Install.create_pages()
	}
}

fn Class_WC_Install.create_pages() {
	rt.call_function('remove_action', [rt.new_string('publish_page'), rt.new_string('_delete_option_fresh_site'), rt.new_int(0)])
	rt.call_function('wc_switch_to_site_locale', []rt.PhpVal{})
	rt.include_file(@DIR + '/admin/wc-admin-functions.php', '2')
	mut var_cart_shortcode := rt.call_function('apply_filters_deprecated', [rt.new_string('woocommerce_cart_shortcode_tag'), rt.create_array([rt.ArrayItem{ key: none, val: '' }]), rt.new_string('8.3.0'), rt.new_string('woocommerce_create_pages')])
	mut var_cart_page_content := if !rt.is_true(var_cart_shortcode) { Class_WC_Install.get_cart_block_content() } else { '<!-- wp:shortcode -->[' + (var_cart_shortcode).str() + ']<!-- /wp:shortcode -->' }
	mut var_checkout_shortcode := rt.call_function('apply_filters_deprecated', [rt.new_string('woocommerce_checkout_shortcode_tag'), rt.create_array([rt.ArrayItem{ key: none, val: '' }]), rt.new_string('8.3.0'), rt.new_string('woocommerce_create_pages')])
	mut var_checkout_page_content := if !rt.is_true(var_checkout_shortcode) { Class_WC_Install.get_checkout_block_content() } else { '<!-- wp:shortcode -->[' + (var_checkout_shortcode).str() + ']<!-- /wp:shortcode -->' }
	mut var_my_account_shortcode := rt.call_function('apply_filters', [rt.new_string('woocommerce_my_account_shortcode_tag'), rt.new_string('woocommerce_my_account')])
	mut var_pages := rt.call_function('apply_filters', [rt.new_string('woocommerce_create_pages'), rt.create_array([rt.ArrayItem{ key: 'shop', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('_x', [rt.new_string('shop'), rt.new_string('Page slug'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [rt.new_string('Shop'), rt.new_string('Page title'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'content', val: '' }]) }, rt.ArrayItem{ key: 'cart', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('_x', [rt.new_string('cart'), rt.new_string('Page slug'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [rt.new_string('Cart'), rt.new_string('Page title'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'content', val: var_cart_page_content }]) }, rt.ArrayItem{ key: 'checkout', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('_x', [rt.new_string('checkout'), rt.new_string('Page slug'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [rt.new_string('Checkout'), rt.new_string('Page title'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'content', val: var_checkout_page_content }]) }, rt.ArrayItem{ key: 'myaccount', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('_x', [rt.new_string('my-account'), rt.new_string('Page slug'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [rt.new_string('My account'), rt.new_string('Page title'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'content', val: '<!-- wp:shortcode -->[' + (var_my_account_shortcode).str() + ']<!-- /wp:shortcode -->' }]) }, rt.ArrayItem{ key: 'refund_returns', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('_x', [rt.new_string('refund_returns'), rt.new_string('Page slug'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [rt.new_string('Refund and Returns Policy'), rt.new_string('Page title'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'content', val: Class_WC_Install.get_refunds_return_policy_page_content() }, rt.ArrayItem{ key: 'post_status', val: 'draft' }]) }])])
	mut iter_3 := var_pages.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_page := item_3.val
		mut var_key := item_3.key
		rt.call_function('wc_create_page', [rt.call_function('esc_sql', [var_page.array_get(rt.new_string('name'))]), rt.new_string('woocommerce_' + (var_key).str() + '_page_id'), var_page.array_get(rt.new_string('title')), var_page.array_get(rt.new_string('content')), if !(!rt.is_true(var_page.array_get(rt.new_string('parent')))) { rt.call_function('wc_get_page_id', [var_page.array_get(rt.new_string('parent'))]) } else { rt.new_string('') }, if !(!rt.is_true(var_page.array_get(rt.new_string('post_status')))) { var_page.array_get(rt.new_string('post_status')) } else { rt.new_string('publish') }])
	}
	rt.call_function('wc_restore_locale', []rt.PhpVal{})
}

fn Class_WC_Install.create_options() {
	rt.include_file(@DIR + '/admin/class-wc-admin-settings.php', '2')
	mut iife_temp_14 := Class_WC_Admin_Settings{}
	mut iife_result_14 := iife_temp_14.get_settings_pages()
	mut var_settings := iife_result_14
	mut iter_4 := var_settings.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_section := item_4.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_section.clone(), rt.new_string('WC_Settings_Page')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('method_exists', [var_section.clone(), rt.new_string('get_settings')]))))) {
			continue
		}
		mut var_subsections := rt.call_function('array_unique', [rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: '' }]), rt.func_array_keys(rt.call_method(var_section, 'get_sections', []rt.PhpVal{}))])])
		mut iter_5 := var_subsections.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_subsection := item_5.val
			mut iter_6 := rt.call_method(var_section, 'get_settings', [var_subsection.clone()]).iterator()
			for {
				item_6 := iter_6.next() or { break }
				mut var_value := item_6.val
				if var_value.array_isset(rt.new_string('default')) && var_value.array_isset(rt.new_string('id')) {
					mut var_autoload := rt.new_bool(if var_value.array_isset(rt.new_string('autoload')) { (var_value.array_get(rt.new_string('autoload'))).to_bool() } else { true })
					mut var_skip_initial_save := rt.new_bool(if var_value.array_isset(rt.new_string('skip_initial_save')) { (var_value.array_get(rt.new_string('skip_initial_save'))).to_bool() } else { false })
					if rt.is_true(rt.new_bool(!(rt.is_true(var_skip_initial_save)))) {
						rt.call_function('add_option', [var_value.array_get(rt.new_string('id')), var_value.array_get(rt.new_string('default')), rt.new_string(''), rt.new_string((if rt.is_true(var_autoload) { 'yes' } else { 'no' }).str())])
					}
				}
			}
		}
	}
	rt.call_function('add_option', [rt.new_string('woocommerce_single_image_width'), rt.new_string('600'), rt.new_string(''), rt.new_string('yes')])
	rt.call_function('add_option', [rt.new_string('woocommerce_thumbnail_image_width'), rt.new_string('300'), rt.new_string(''), rt.new_string('yes')])
	rt.call_function('add_option', [rt.new_string('woocommerce_checkout_highlight_required_fields'), rt.new_string('yes'), rt.new_string(''), rt.new_string('yes')])
	rt.call_function('add_option', [rt.new_string('woocommerce_demo_store'), rt.new_string('no'), rt.new_string(''), rt.new_string('no')])
	if rt.is_true(Class_WC_Install.is_new_install()) {
		mut iife_temp_15 := Class_WC_Tax{}
		mut iife_result_15 := iife_temp_15.create_tax_class(rt.call_function('__', [rt.new_string('Reduced rate'), rt.new_string('woocommerce')]))
		mut iife_temp_16 := Class_WC_Tax{}
		mut iife_result_16 := iife_temp_16.create_tax_class(rt.call_function('__', [rt.new_string('Zero rate'), rt.new_string('woocommerce')]))
		rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.class()]), 'init_feature', [rt.new_bool(false), rt.new_bool(true)])
	}
}

fn Class_WC_Install.maybe_enable_hpos() {
	if rt.is_true(Class_WC_Install.should_enable_hpos_for_new_shop()) {
		mut var_feature_controller := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class()])
		rt.call_method(var_feature_controller, 'change_feature_enable', [rt.new_string('custom_order_tables'), rt.new_bool(true)])
	}
}

fn Class_WC_Install.add_coming_soon_option() {
	rt.call_function('add_option', [rt.new_string('woocommerce_coming_soon'), rt.new_string('yes')])
	rt.call_function('add_option', [rt.new_string('woocommerce_store_pages_only'), rt.new_string('yes')])
}

fn Class_WC_Install.enable_email_improvements_for_newly_installed() {
	mut var_feature_controller := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class()])
	rt.call_method(var_feature_controller, 'change_feature_enable', [rt.new_string('email_improvements'), rt.new_bool(true)])
	rt.call_function('update_option', [rt.new_string('woocommerce_email_improvements_default_enabled'), rt.new_string('yes')])
	rt.call_function('update_option', [rt.new_string('woocommerce_email_auto_sync_with_theme'), rt.new_string('yes')])
	rt.call_function('update_option', [rt.new_string('woocommerce_email_improvements_first_enabled_at'), rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s')])])
	rt.call_function('update_option', [rt.new_string('woocommerce_email_improvements_last_enabled_at'), rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s')])])
	rt.call_function('update_option', [rt.new_string('woocommerce_email_improvements_enabled_count'), rt.new_int(1)])
}

fn Class_WC_Install.enable_customer_stock_notifications_signups() {
	rt.call_function('update_option', [rt.new_string('woocommerce_back_in_stock_allow_signups'), rt.new_string('yes')])
}

fn Class_WC_Install.enable_analytics_scheduled_import() {
	rt.call_function('add_option', [rt.new_string('woocommerce_analytics_scheduled_import'), rt.new_string('yes')])
}

fn Class_WC_Install.enable_email_improvements_for_existing_merchants() {
	mut iife_temp_17 := Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements{}
	mut iife_result_17 := iife_temp_17.should_enable_email_improvements_for_existing_stores()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_17)))) {
		return
	}
	mut var_feature_controller := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class()])
	rt.call_method(var_feature_controller, 'change_feature_enable', [rt.new_string('email_improvements'), rt.new_bool(true)])
	rt.call_function('update_option', [rt.new_string('woocommerce_email_improvements_existing_store_enabled'), rt.new_string('yes')])
	mut var_first_enabled_at := rt.call_function('get_option', [rt.new_string('woocommerce_email_improvements_first_enabled_at')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_first_enabled_at)))) {
		rt.call_function('update_option', [rt.new_string('woocommerce_email_improvements_first_enabled_at'), rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s')])])
	}
	mut var_last_enabled_at := rt.call_function('get_option', [rt.new_string('woocommerce_email_improvements_last_enabled_at')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_last_enabled_at)))) {
		rt.call_function('update_option', [rt.new_string('woocommerce_email_improvements_last_enabled_at'), rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s')])])
	}
	mut var_enabled_count := rt.call_function('get_option', [rt.new_string('woocommerce_email_improvements_enabled_count')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_enabled_count)))) {
		rt.call_function('update_option', [rt.new_string('woocommerce_email_improvements_enabled_count'), rt.new_int(1)])
	} else {
		rt.call_function('update_option', [rt.new_string('woocommerce_email_improvements_enabled_count'), rt.new_int((var_enabled_count).to_i64()) + 1])
	}
}

fn Class_WC_Install.should_enable_hpos_for_new_shop() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_init')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('doing_action', [rt.new_string('woocommerce_init')]))))) {
		return false
	}
	mut var_feature_controller := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class()])
	mut iife_temp_18 := Class_OrderUtil{}
	mut iife_result_18 := iife_temp_18.custom_orders_table_usage_is_enabled()
	if rt.is_true(iife_result_18) {
		return true
	}
	if !(!rt.is_true(rt.call_function('wc_get_orders', [rt.create_array([rt.ArrayItem{ key: 'limit', val: 1 }])]))) {
		return false
	}
	mut var_plugin_compat_info := rt.call_method(var_feature_controller, 'get_compatible_plugins_for_feature', [rt.new_string('custom_order_tables'), rt.new_bool(true)])
	if !(!rt.is_true(var_plugin_compat_info.array_get(rt.new_string('incompatible')))) || !(!rt.is_true(var_plugin_compat_info.array_get(rt.new_string('uncertain')))) {
		return false
	}
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_enable_hpos_by_default_for_new_shops'), rt.new_bool(true)])).to_bool()
}

fn Class_WC_Install.get_order_stats_table_schema(var_collate rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	mut var_collate_mutated := var_collate
	mut iife_temp_19 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_19 := iife_temp_19.feature_is_enabled(rt.new_string('fulfillments'))
	mut var_should_have_fulfillment_column := rt.new_bool(rt.is_true(Class_WC_Install.is_new_install()) && rt.is_true(iife_result_19))
	if rt.is_true(rt.identical(rt.new_bool(false), var_should_have_fulfillment_column)) {
	mut iife_temp_20 := Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{}
	mut iife_result_20 := iife_temp_20.has_fulfillment_status_column()
	var_should_have_fulfillment_column = iife_result_20
	}
	return rt.concat(rt.concat(rt.new_string('CREATE TABLE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_stats (\n\torder_id bigint(20) unsigned NOT NULL,\n\tparent_id bigint(20) unsigned DEFAULT 0 NOT NULL,\n\tdate_created datetime DEFAULT \'0000-00-00 00:00:00\' NOT NULL,\n\tdate_created_gmt datetime DEFAULT \'0000-00-00 00:00:00\' NOT NULL,\n\tdate_paid datetime DEFAULT \'0000-00-00 00:00:00\',\n\tdate_completed datetime DEFAULT \'0000-00-00 00:00:00\',\n\tnum_items_sold int(11) DEFAULT 0 NOT NULL,\n\ttotal_sales double DEFAULT 0 NOT NULL,\n\ttax_total double DEFAULT 0 NOT NULL,\n\tshipping_total double DEFAULT 0 NOT NULL,\n\tnet_total double DEFAULT 0 NOT NULL,\n\treturning_customer tinyint(1) DEFAULT NULL,\n\tstatus varchar(20) NOT NULL,\n\tcustomer_id bigint(20) unsigned NOT NULL')) + if rt.is_true(var_should_have_fulfillment_column) { ',\n\tfulfillment_status varchar(50) DEFAULT NULL' } else { '' } + ',\n\tPRIMARY KEY (order_id),\n\tKEY date_created (date_created),\n\tKEY customer_id (customer_id),\n\tKEY status (status)' + if rt.is_true(var_should_have_fulfillment_column) { ',\n\tKEY fulfillment_status (fulfillment_status)' } else { '' } + ",\n\tKEY idx_date_paid_status_parent (date_paid, status, parent_id)\n) ${var_collate.to_string()};"
}

fn Class_WC_Install.delete_obsolete_notes() {
	mut var_wpdb := rt.new_null()
	mut var_obsolete_notes_names := rt.create_array([rt.ArrayItem{ key: none, val: 'wc-admin-welcome-note' }, rt.ArrayItem{ key: none, val: 'wc-admin-insight-first-product-and-payment' }, rt.ArrayItem{ key: none, val: 'wc-admin-store-notice-setting-moved' }, rt.ArrayItem{ key: none, val: 'wc-admin-store-notice-giving-feedback' }, rt.ArrayItem{ key: none, val: 'wc-admin-first-downloadable-product' }, rt.ArrayItem{ key: none, val: 'wc-admin-learn-more-about-product-settings' }, rt.ArrayItem{ key: none, val: 'wc-admin-adding-and-managing-products' }, rt.ArrayItem{ key: none, val: 'wc-admin-onboarding-profiler-reminder' }, rt.ArrayItem{ key: none, val: 'wc-admin-historical-data' }, rt.ArrayItem{ key: none, val: 'wc-admin-manage-store-activity-from-home-screen' }, rt.ArrayItem{ key: none, val: 'wc-admin-review-shipping-settings' }, rt.ArrayItem{ key: none, val: 'wc-admin-home-screen-feedback' }, rt.ArrayItem{ key: none, val: 'wc-admin-update-store-details' }, rt.ArrayItem{ key: none, val: 'wc-admin-effortless-payments-by-mollie' }, rt.ArrayItem{ key: none, val: 'wc-admin-google-ads-and-marketing' }, rt.ArrayItem{ key: none, val: 'wc-admin-insight-first-sale' }, rt.ArrayItem{ key: none, val: 'wc-admin-marketing-intro' }, rt.ArrayItem{ key: none, val: 'wc-admin-draw-attention' }, rt.ArrayItem{ key: none, val: 'wc-admin-welcome-to-woocommerce-for-store-users' }, rt.ArrayItem{ key: none, val: 'wc-admin-need-some-inspiration' }, rt.ArrayItem{ key: none, val: 'wc-admin-choose-niche' }, rt.ArrayItem{ key: none, val: 'wc-admin-start-dropshipping-business' }, rt.ArrayItem{ key: none, val: 'wc-admin-filter-by-product-variations-in-reports' }, rt.ArrayItem{ key: none, val: 'wc-admin-learn-more-about-variable-products' }, rt.ArrayItem{ key: none, val: 'wc-admin-getting-started-ecommerce-webinar' }, rt.ArrayItem{ key: none, val: 'wc-admin-navigation-feedback' }, rt.ArrayItem{ key: none, val: 'wc-admin-navigation-feedback-follow-up' }, rt.ArrayItem{ key: none, val: 'wc-admin-set-up-additional-payment-types' }, rt.ArrayItem{ key: none, val: 'wc-admin-deactivate-plugin' }, rt.ArrayItem{ key: none, val: 'wc-admin-complete-store-details' }, rt.ArrayItem{ key: none, val: 'wc-admin-choosing-a-theme' }])
	mut var_additional_obsolete_notes_names := rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_obsolete_notes_names'), rt.new_array()])
	if rt.is_true(rt.new_bool(var_additional_obsolete_notes_names.clone().is_array())) {
	var_obsolete_notes_names = rt.call_function('array_merge', [var_obsolete_notes_names.clone(), var_additional_obsolete_notes_names.clone()])
	}
	mut var_note_names_placeholder := rt.call_function('substr', [rt.call_function('str_repeat', [rt.new_string(',%s'), rt.new_int(var_obsolete_notes_names.clone().array_count())]), rt.new_int(1)])
	mut var_note_ids := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT note_id FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_admin_notes WHERE name IN ( ')), var_note_names_placeholder), rt.new_string(' )')), var_obsolete_notes_names.clone()]), rt.get_constant('ARRAY_N')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_note_ids)))) {
		return
	}
	var_note_ids = rt.call_function('array_column', [var_note_ids.clone(), rt.new_int(0)])
	mut var_note_ids_placeholder := rt.call_function('substr', [rt.call_function('str_repeat', [rt.new_string(',%d'), rt.new_int(var_note_ids.clone().array_count())]), rt.new_int(1)])
	rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_admin_notes WHERE note_id IN ( ')), var_note_ids_placeholder), rt.new_string(' )')), var_note_ids.clone()])])
	rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_admin_note_actions WHERE note_id IN ( ')), var_note_ids_placeholder), rt.new_string(' )')), var_note_ids.clone()])])
}

fn Class_WC_Install.migrate_options() {
	mut var_migrated_options := { 'woocommerce_onboarding_profile': 'wc_onboarding_profile', 'woocommerce_admin_install_timestamp': 'wc_admin_install_timestamp', 'woocommerce_onboarding_opt_in': 'wc_onboarding_opt_in', 'woocommerce_admin_import_stats': 'wc_admin_import_stats', 'woocommerce_admin_version': 'wc_admin_version', 'woocommerce_admin_last_orders_milestone': 'wc_admin_last_orders_milestone', 'woocommerce_admin-wc-helper-last-refresh': 'wc-admin-wc-helper-last-refresh', 'woocommerce_admin_report_export_status': 'wc_admin_report_export_status', 'woocommerce_task_list_complete': 'woocommerce_task_list_complete', 'woocommerce_task_list_hidden': 'woocommerce_task_list_hidden', 'woocommerce_extended_task_list_complete': 'woocommerce_extended_task_list_complete', 'woocommerce_extended_task_list_hidden': 'woocommerce_extended_task_list_hidden' }
	rt.call_function('wc_maybe_define_constant', [rt.new_string('WC_ADMIN_MIGRATING_OPTIONS'), rt.new_bool(true)])
	for var_new_option, var_old_option in var_migrated_options {
		mut var_old_option_value := rt.call_function('get_option', [rt.new_string(old_option), rt.new_bool(false)])
		if rt.is_true(rt.identical(rt.new_bool(false), var_old_option_value)) {
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('1'), var_old_option_value)) {
		var_old_option_value = rt.new_string('yes')
		} else if rt.is_true(rt.identical(rt.new_string('0'), var_old_option_value)) {
		var_old_option_value = rt.new_string('no')
		}
		rt.call_function('update_option', [rt.new_string(new_option), var_old_option_value.clone()])
		if rt.is_true(rt.new_bool(new_option != old_option)) {
			rt.call_function('delete_option', [rt.new_string(old_option)])
		}
	}
}

fn Class_WC_Install.create_terms() {
	mut var_taxonomies := { 'product_type': map[string]rt.PhpVal{}, 'product_visibility': map[string]rt.PhpVal{} }
	for var_taxonomy, var_terms in var_taxonomies {
		mut iter_7 := var_terms.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_term := item_7.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_term_by', [rt.new_string('name'), var_term.clone(), rt.new_string(taxonomy)]))))) {
				rt.call_function('wp_insert_term', [var_term.clone(), rt.new_string(taxonomy)])
			}
		}
	}
	mut var_woocommerce_default_category := rt.new_int((rt.call_function('get_option', [rt.new_string('default_product_cat'), rt.new_int(0)])).to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_woocommerce_default_category)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('term_exists', [var_woocommerce_default_category.clone(), rt.new_string('product_cat')]))))) {
		mut var_default_product_cat_id := rt.new_int(0)
		mut var_default_product_cat_slug := rt.call_function('sanitize_title', [rt.call_function('_x', [rt.new_string('Uncategorized'), rt.new_string('Default category slug'), rt.new_string('woocommerce')])])
		mut var_default_product_cat := rt.call_function('get_term_by', [rt.new_string('slug'), var_default_product_cat_slug.clone(), rt.new_string('product_cat')])
		if rt.is_true(var_default_product_cat) {
		var_default_product_cat_id = rt.call_function('absint', [rt.get_property(var_default_product_cat, 'term_taxonomy_id')])
		} else {
			mut var_result := rt.call_function('wp_insert_term', [rt.call_function('_x', [rt.new_string('Uncategorized'), rt.new_string('Default category slug'), rt.new_string('woocommerce')]), rt.new_string('product_cat'), rt.create_array([rt.ArrayItem{ key: 'slug', val: var_default_product_cat_slug }])])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_result.clone()]))))) && !(!rt.is_true(var_result.array_get(rt.new_string('term_taxonomy_id')))) {
			var_default_product_cat_id = rt.call_function('absint', [var_result.array_get(rt.new_string('term_taxonomy_id'))])
			}
		}
		if rt.is_true(var_default_product_cat_id) {
			rt.call_function('update_option', [rt.new_string('default_product_cat'), var_default_product_cat_id.clone()])
		}
	}
}

fn Class_WC_Install.maybe_install_legacy_api_plugin() {
	if rt.is_true(Class_WC_Install.is_new_install()) {
		return
	}
	mut var_legacy_api_plugin := rt.new_string('woocommerce-legacy-rest-api/woocommerce-legacy-rest-api.php')
	mut var_autoinstalled_plugins := rt.cast_array(rt.call_function('get_site_option', [rt.new_string('woocommerce_history_of_autoinstalled_plugins'), rt.new_array()]))
	mut var_previously_installed_by_us := rt.new_bool(var_autoinstalled_plugins.array_isset(var_legacy_api_plugin))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_previously_installed_by_us)))) {
	var_autoinstalled_plugins = rt.cast_array(rt.call_function('get_site_option', [rt.new_string('woocommerce_autoinstalled_plugins'), rt.new_array()]))
	var_previously_installed_by_us = rt.new_bool(var_autoinstalled_plugins.array_isset(var_legacy_api_plugin))
	}
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_skip_legacy_rest_api_plugin_auto_install'), var_previously_installed_by_us.clone()])) {
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_api_enabled')]))))) && rt.is_true(rt.identical(rt.new_int(0), rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_WebhookUtil.class()]), 'get_legacy_webhooks_count', [rt.new_bool(true)]))) {
		return
	}
	rt.call_function('wp_clean_plugins_cache', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('get_plugins')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	}
	if rt.call_function('get_plugins', []rt.PhpVal{}).array_isset(var_legacy_api_plugin) {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_previously_installed_by_us)))) {
			return
		}
		mut var_active_valid_plugins := rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_PluginUtil.class()]), 'get_all_active_valid_plugins', []rt.PhpVal{})
		if rt.is_true(rt.call_function('in_array', [var_legacy_api_plugin.clone(), var_active_valid_plugins.clone(), rt.new_bool(true)])) {
			return
		}
	mut var_install_ok := rt.new_bool(true)
	} else {
		mut var_install_result := rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_PluginInstaller.class()]), 'install_plugin', [rt.new_string('https://downloads.wordpress.org/plugin/woocommerce-legacy-rest-api.latest-stable.zip'), rt.create_array([rt.ArrayItem{ key: 'info_link', val: 'https://developer.woocommerce.com/2023/10/03/the-legacy-rest-api-will-move-to-a-dedicated-extension-in-woocommerce-9-0/' }])])
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		if rt.is_true(if !(var_install_result.array_get(rt.new_string('already_installing'))).is_null() { var_install_result.array_get(rt.new_string('already_installing')) } else { rt.new_null() }) {
			rt.call_function('as_schedule_single_action', [rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(10)), rt.new_string('woocommerce_activate_legacy_rest_api_plugin')])
			if rt.has_exception() { unsafe { goto catch_label_4 } }
			return
		}
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		var_install_ok = var_install_result.array_get(rt.new_string('install_ok'))
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		unsafe { goto end_label_4 }

catch_label_4:
		mut var_e_4 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_4, 'Exception') {
			mut var_ex := var_e_4.clone()
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.new_string('The autoinstall of the WooCommerce Legacy REST API plugin failed: ' + (rt.call_method(var_ex, 'getMessage', []rt.PhpVal{})).str()), rt.create_array([rt.ArrayItem{ key: 'source', val: 'plugin_auto_installs' }, rt.ArrayItem{ key: 'exception', val: var_ex }])])
			var_install_ok = rt.new_bool(false)
			unsafe { goto end_label_4 }
		}
		else {
			rt.throw_exception(var_e_4)
			unsafe { goto end_label_4 }
		}

end_label_4:
	}
	mut var_plugin_page_url := rt.new_string('https://wordpress.org/plugins/woocommerce-legacy-rest-api/')
	mut var_blog_post_url := rt.new_string('https://developer.woocommerce.com/2023/10/03/the-legacy-rest-api-will-move-to-a-dedicated-extension-in-woocommerce-9-0/')
	mut var_site_legacy_api_settings_url := rt.call_function('get_admin_url', [rt.new_null(), rt.new_string('/admin.php?page=wc-settings&tab=advanced&section=legacy_api')])
	mut var_site_webhooks_settings_url := rt.call_function('get_admin_url', [rt.new_null(), rt.new_string('/admin.php?page=wc-settings&tab=advanced&section=webhooks')])
	mut var_site_logs_url := rt.call_function('get_admin_url', [rt.new_null(), rt.new_string('/admin.php?page=wc-status&tab=logs')])
	if rt.is_true(var_install_ok) {
		mut var_activation_result := rt.call_function('activate_plugin', [var_legacy_api_plugin.clone()])
		if rt.is_true(rt.new_bool(rt.instance_of(var_activation_result, 'WP_Error'))) {
			mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('⚠️ WooCommerce installed <a href="%1$s">the Legacy REST API plugin</a> because this site has <a href="%2$s">the Legacy REST API enabled</a> or has <a href="%3$s">legacy webhooks defined</a>, but it failed to activate it (see error details in <a href="%4$s">the WooCommerce logs</a>). Please go to <a href="%5$s">the plugins page</a> and activate it manually. <a href="%6$s">More information</a>'), rt.new_string('woocommerce')]), var_plugin_page_url.clone(), var_site_legacy_api_settings_url.clone(), var_site_webhooks_settings_url.clone(), var_site_logs_url.clone(), rt.call_function('get_admin_url', [rt.new_null(), rt.new_string('/plugins.php')]), var_blog_post_url.clone()])
			mut var_notice_name := rt.new_string('woocommerce_legacy_rest_api_plugin_activation_failed')
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.call_function('__', [rt.new_string('WooCommerce installed the Legacy REST API plugin but failed to activate it, see context for more details.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'plugin_auto_installs' }, rt.ArrayItem{ key: 'error', val: var_activation_result }])])
		} else {
			var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('ℹ️ WooCommerce installed and activated <a href="%1$s">the Legacy REST API plugin</a> because this site has <a href="%2$s">the Legacy REST API enabled</a> or has <a href="%3$s">legacy webhooks defined</a>. <a href="%4$s">More information</a>'), rt.new_string('woocommerce')]), var_plugin_page_url.clone(), var_site_legacy_api_settings_url.clone(), var_site_webhooks_settings_url.clone(), var_blog_post_url.clone()])
			var_notice_name = rt.new_string('woocommerce_legacy_rest_api_plugin_activated')
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'info', [rt.new_string('WooCommerce activated the Legacy REST API plugin in this site.'), rt.create_array([rt.ArrayItem{ key: 'source', val: 'plugin_auto_installs' }])])
		}
	mut iife_temp_21 := Class_WC_Admin_Notices{}
	mut iife_result_21 := iife_temp_21.add_custom_notice(var_notice_name.clone(), var_message.clone())
	} else {
	var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('⚠️ WooCommerce attempted to install <a href="%1$s">the Legacy REST API plugin</a> because this site has <a href="%2$s">the Legacy REST API enabled</a> or has <a href="%3$s">legacy webhooks defined</a>, but the installation failed (see error details in <a href="%4$s">the WooCommerce logs</a>). Please install and activate the plugin manually. <a href="%5$s">More information</a>'), rt.new_string('woocommerce')]), var_plugin_page_url.clone(), var_site_legacy_api_settings_url.clone(), var_site_webhooks_settings_url.clone(), var_site_logs_url.clone(), var_blog_post_url.clone()])
	mut iife_temp_22 := Class_WC_Admin_Notices{}
	mut iife_result_22 := iife_temp_22.add_custom_notice(rt.new_string('woocommerce_legacy_rest_api_plugin_install_failed'), var_message.clone())
	}
mut iife_temp_23 := Class_WC_Admin_Notices{}
mut iife_result_23 := iife_temp_23.store_notices()
}

fn Class_WC_Install.maybe_activate_legacy_api_enabled_option() {
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Install.is_new_install())))) && rt.is_true(rt.call_function('is_plugin_active', [rt.new_string('woocommerce-legacy-rest-api/woocommerce-legacy-rest-api.php')])) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_api_enabled')]))))) {
		rt.call_function('update_option', [rt.new_string('woocommerce_api_enabled'), rt.new_string('yes')])
	}
}

fn Class_WC_Install.create_tables() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_wpdb, 'hide_errors', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/upgrade.php', '4')
	if rt.is_true(rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.new_string('SHOW TABLES LIKE \''), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_downloadable_product_permissions\';'))])) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.new_string('SHOW COLUMNS FROM `'), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_downloadable_product_permissions` LIKE \'permission_id\';'))]))))) {
			rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_downloadable_product_permissions DROP PRIMARY KEY, ADD `permission_id` bigint(20) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT;'))])
		}
	}
	if rt.is_true(rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.new_string('SHOW TABLES LIKE \''), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_product_lookup\';'))])) {
		if rt.is_true(rt.greater(rt.new_int(2), rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = \''), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_product_lookup\' AND INDEX_NAME = \'PRIMARY\''))]))) {
			rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_product_lookup DROP PRIMARY KEY, ADD PRIMARY KEY (order_item_id, order_id)'))])
		}
	}
	if rt.is_true(rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.new_string('SHOW TABLES LIKE \''), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_sessions\''))])) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.new_string('SHOW KEYS FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_sessions WHERE Key_name = \'PRIMARY\' AND Column_name = \'session_id\''))]))))) {
			rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('ALTER TABLE `'), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_sessions` DROP PRIMARY KEY, DROP KEY `session_id`, ADD PRIMARY KEY(`session_id`), ADD UNIQUE KEY(`session_key`)'))])
		}
	}
	mut var_suppress_errors := rt.call_method(var_wpdb, 'suppress_errors', [rt.new_bool(true)])
	mut var_db_delta_result := rt.call_function('dbDelta', [Class_WC_Install.get_schema()])
	rt.call_method(var_wpdb, 'suppress_errors', [var_suppress_errors.clone()])
	mut var_comment_type_index_exists := rt.call_method(var_wpdb, 'get_row', [rt.concat(rt.concat(rt.new_string('SHOW INDEX FROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' WHERE key_name = \'woo_idx_comment_type\''))])
	if rt.is_true(rt.identical(rt.new_null(), var_comment_type_index_exists)) {
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' ADD INDEX woo_idx_comment_type (comment_type)'))])
	}
	mut var_date_type_index_exists := rt.call_method(var_wpdb, 'get_row', [rt.concat(rt.concat(rt.new_string('SHOW INDEX FROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' WHERE key_name = \'woo_idx_comment_date_type\''))])
	if rt.is_true(rt.identical(rt.new_null(), var_date_type_index_exists)) {
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' ADD INDEX woo_idx_comment_date_type (comment_date_gmt, comment_type, comment_approved, comment_post_ID)'))])
	}
	mut var_comment_approved_type_index_exists := rt.call_method(var_wpdb, 'get_row', [rt.concat(rt.concat(rt.new_string('SHOW INDEX FROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' WHERE key_name = \'woo_idx_comment_approved_type\''))])
	if rt.is_true(rt.identical(rt.new_null(), var_comment_approved_type_index_exists)) {
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' ADD INDEX woo_idx_comment_approved_type (comment_approved, comment_type, comment_post_ID)'))])
	}
	rt.call_function('delete_transient', [rt.new_string('wc_attribute_taxonomies')])
	return var_db_delta_result.clone()
}

fn Class_WC_Install.get_schema() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_collate := rt.new_string('')
	if rt.is_true(rt.call_method(var_wpdb, 'has_cap', [rt.new_string('collation')])) {
	var_collate = rt.call_method(var_wpdb, 'get_charset_collate', []rt.PhpVal{})
	}
	mut var_max_index_length := rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil.class()]), 'get_max_index_length', []rt.PhpVal{})
	mut var_product_attributes_lookup_table_creation_sql := rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator.class()]), 'get_table_creation_sql', []rt.PhpVal{})
	mut var_feature_controller := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class()])
	mut var_hpos_enabled := rt.new_bool(rt.is_true(rt.call_method(var_feature_controller, 'feature_is_enabled', [Class_DataSynchronizer.orders_data_sync_enabled_option()])) || rt.is_true(rt.call_method(var_feature_controller, 'feature_is_enabled', [Class_CustomOrdersTableController.custom_orders_table_usage_enabled_option()])) || rt.is_true(Class_WC_Install.should_enable_hpos_for_new_shop()))
	mut var_hpos_table_schema := if rt.is_true(var_hpos_enabled) { rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_OrdersTableDataStore.class()]), 'get_database_schema', []rt.PhpVal{}) } else { rt.new_string('') }
	mut var_stock_notifications_table_schema := rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DataStores_StockNotifications_StockNotificationsDataStore.class()]), 'get_database_schema', []rt.PhpVal{})
	mut var_order_stats_table_schema := Class_WC_Install.get_order_stats_table_schema(var_collate.clone())
	mut var_mysql_version := rt.call_function('wc_get_server_database_version', []rt.PhpVal{}).array_get(rt.new_string('number'))
	if rt.is_true(rt.call_function('version_compare', [var_mysql_version.clone(), rt.new_string('5.6'), rt.new_string('>=')])) {
	mut var_datetime_default := rt.new_string('DEFAULT CURRENT_TIMESTAMP')
	} else {
	var_datetime_default = rt.new_string('DEFAULT \'1970-01-01 00:00:00\'')
	}
	mut var_tables := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\nCREATE TABLE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_sessions (\n  session_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,\n  session_key char(32) NOT NULL,\n  session_value longtext NOT NULL,\n  session_expiry bigint(20) unsigned NOT NULL,\n  PRIMARY KEY  (session_id),\n  KEY session_expiry (session_expiry),\n  UNIQUE KEY session_key (session_key)\n) ')), var_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_api_keys (\n  key_id bigint(20) unsigned NOT NULL auto_increment,\n  user_id bigint(20) unsigned NOT NULL,\n  description varchar(200) NULL,\n  permissions varchar(10) NOT NULL,\n  consumer_key char(64) NOT NULL,\n  consumer_secret char(43) NOT NULL,\n  nonces longtext NULL,\n  truncated_key char(7) NOT NULL,\n  last_access datetime NULL default null,\n  PRIMARY KEY  (key_id),\n  KEY consumer_key (consumer_key),\n  KEY consumer_secret (consumer_secret)\n) ')), var_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_attribute_taxonomies (\n  attribute_id bigint(20) unsigned NOT NULL auto_increment,\n  attribute_name varchar(200) NOT NULL,\n  attribute_label varchar(200) NULL,\n  attribute_type varchar(20) NOT NULL,\n  attribute_orderby varchar(20) NOT NULL,\n  attribute_public int(1) NOT NULL DEFAULT 1,\n  PRIMARY KEY  (attribute_id),\n  KEY attribute_name (attribute_name(20))\n) ')), var_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_downloadable_product_permissions (\n  permission_id bigint(20) unsigned NOT NULL auto_increment,\n  download_id varchar(36) NOT NULL,\n  product_id bigint(20) unsigned NOT NULL,\n  order_id bigint(20) unsigned NOT NULL DEFAULT 0,\n  order_key varchar(200) NOT NULL,\n  user_email varchar(200) NOT NULL,\n  user_id bigint(20) unsigned NULL,\n  downloads_remaining varchar(9) NULL,\n  access_granted datetime NOT NULL default \'0000-00-00 00:00:00\',\n  access_expires datetime NULL default null,\n  download_count bigint(20) unsigned NOT NULL DEFAULT 0,\n  PRIMARY KEY  (permission_id),\n  KEY download_order_key_product (product_id,order_id,order_key(16),download_id),\n  KEY download_order_product (download_id,order_id,product_id),\n  KEY order_id (order_id),\n  KEY user_order_remaining_expires (user_id,order_id,downloads_remaining,access_expires),\n  KEY idx_user_email (user_email(100))\n) ')), var_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_items (\n  order_item_id bigint(20) unsigned NOT NULL auto_increment,\n  order_item_name text NOT NULL,\n  order_item_type varchar(200) NOT NULL DEFAULT \'\',\n  order_id bigint(20) unsigned NOT NULL,\n  PRIMARY KEY  (order_item_id),\n  KEY order_id (order_id)\n) ')), var_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_itemmeta (\n  meta_id bigint(20) unsigned NOT NULL auto_increment,\n  order_item_id bigint(20) unsigned NOT NULL,\n  meta_key varchar(255) default NULL,\n  meta_value longtext NULL,\n  PRIMARY KEY  (meta_id),\n  KEY order_item_id (order_item_id),\n  KEY meta_key (meta_key(32))\n) ')), var_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_tax_rates (\n  tax_rate_id bigint(20) unsigned NOT NULL auto_increment,\n  tax_rate_country varchar(2) NOT NULL DEFAULT \'\',\n  tax_rate_state varchar(200) NOT NULL DEFAULT \'\',\n  tax_rate varchar(8) NOT NULL DEFAULT \'\',\n  tax_rate_name varchar(200) NOT NULL DEFAULT \'\',\n  tax_rate_priority bigint(20) unsigned NOT NULL,\n  tax_rate_compound int(1) NOT NULL DEFAULT 0,\n  tax_rate_shipping int(1) NOT NULL DEFAULT 1,\n  tax_rate_order bigint(20) unsigned NOT NULL,\n  tax_rate_class varchar(200) NOT NULL DEFAULT \'\',\n  PRIMARY KEY  (tax_rate_id),\n  KEY tax_rate_country (tax_rate_country),\n  KEY tax_rate_state (tax_rate_state(2)),\n  KEY tax_rate_class (tax_rate_class(10)),\n  KEY tax_rate_priority (tax_rate_priority)\n) ')), var_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_tax_rate_locations (\n  location_id bigint(20) unsigned NOT NULL auto_increment,\n  location_code varchar(200) NOT NULL,\n  tax_rate_id bigint(20) unsigned NOT NULL,\n  location_type varchar(40) NOT NULL,\n  PRIMARY KEY  (location_id),\n  KEY tax_rate_id (tax_rate_id),\n  KEY location_type_code (location_type(10),location_code(20))\n) ')), var_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_shipping_zones (\n  zone_id bigint(20) unsigned NOT NULL auto_increment,\n  zone_name varchar(200) NOT NULL,\n  zone_order bigint(20) unsigned NOT NULL,\n  PRIMARY KEY  (zone_id),\n  KEY zone_order_id (zone_order, zone_id)\n) ')), var_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_shipping_zone_locations (\n  location_id bigint(20) unsigned NOT NULL auto_increment,\n  zone_id bigint(20) unsigned NOT NULL,\n  location_code varchar(200) NOT NULL,\n  location_type varchar(40) NOT NULL,\n  PRIMARY KEY  (location_id),\n  KEY zone_id (zone_id),\n  KEY location_type_code (location_type(10),location_code(20))\n) ')), var_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_shipping_zone_methods (\n  zone_id bigint(20) unsigned NOT NULL,\n  instance_id bigint(20) unsigned NOT NULL auto_increment,\n  method_id varchar(200) NOT NULL,\n  method_order bigint(20) unsigned NOT NULL,\n  is_enabled tinyint(1) NOT NULL DEFAULT \'1\',\n  PRIMARY KEY  (instance_id),\n  KEY zone_id (zone_id),\n  KEY method_id (method_id(20))\n) ')), var_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_payment_tokens (\n  token_id bigint(20) unsigned NOT NULL auto_increment,\n  gateway_id varchar(200) NOT NULL,\n  token text NOT NULL,\n  user_id bigint(20) unsigned NOT NULL DEFAULT \'0\',\n  type varchar(200) NOT NULL,\n  is_default tinyint(1) NOT NULL DEFAULT \'0\',\n  PRIMARY KEY  (token_id),\n  KEY user_id (user_id)\n) ')), var_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_payment_tokenmeta (\n  meta_id bigint(20) unsigned NOT NULL auto_increment,\n  payment_token_id bigint(20) unsigned NOT NULL,\n  meta_key varchar(255) NULL,\n  meta_value longtext NULL,\n  PRIMARY KEY  (meta_id),\n  KEY payment_token_id (payment_token_id),\n  KEY meta_key (meta_key(32))\n) ')), var_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_log (\n  log_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,\n  timestamp datetime NOT NULL,\n  level smallint(4) NOT NULL,\n  source varchar(200) NOT NULL,\n  message longtext NOT NULL,\n  context longtext NULL,\n  PRIMARY KEY (log_id),\n  KEY level (level)\n) ')), var_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_webhooks (\n  webhook_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,\n  status varchar(200) NOT NULL,\n  name text NOT NULL,\n  user_id bigint(20) unsigned NOT NULL,\n  delivery_url text NOT NULL,\n  secret text NOT NULL,\n  topic varchar(200) NOT NULL,\n  date_created datetime NOT NULL DEFAULT \'0000-00-00 00:00:00\',\n  date_created_gmt datetime NOT NULL DEFAULT \'0000-00-00 00:00:00\',\n  date_modified datetime NOT NULL DEFAULT \'0000-00-00 00:00:00\',\n  date_modified_gmt datetime NOT NULL DEFAULT \'0000-00-00 00:00:00\',\n  api_version smallint(4) NOT NULL,\n  failure_count smallint(10) NOT NULL DEFAULT \'0\',\n  pending_delivery tinyint(1) NOT NULL DEFAULT \'0\',\n  PRIMARY KEY  (webhook_id),\n  KEY user_id (user_id)\n) ')), var_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_download_log (\n  download_log_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,\n  timestamp datetime NOT NULL,\n  permission_id bigint(20) unsigned NOT NULL,\n  user_id bigint(20) unsigned NULL,\n  user_ip_address varchar(100) NULL DEFAULT \'\',\n  PRIMARY KEY  (download_log_id),\n  KEY permission_id (permission_id),\n  KEY timestamp (timestamp)\n) ')), var_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_product_meta_lookup (\n  `product_id` bigint(20) NOT NULL,\n  `sku` varchar(100) NULL default \'\',\n  `global_unique_id` varchar(100) NULL default \'\',\n  `virtual` tinyint(1) NULL default 0,\n  `downloadable` tinyint(1) NULL default 0,\n  `min_price` decimal(19,4) NULL default NULL,\n  `max_price` decimal(19,4) NULL default NULL,\n  `onsale` tinyint(1) NULL default 0,\n  `stock_quantity` double NULL default NULL,\n  `stock_status` varchar(100) NULL default \'instock\',\n  `rating_count` bigint(20) NULL default 0,\n  `average_rating` decimal(3,2) NULL default 0.00,\n  `total_sales` bigint(20) NULL default 0,\n  `tax_status` varchar(100) NULL default \'taxable\',\n  `tax_class` varchar(100) NULL default \'\',\n  PRIMARY KEY  (`product_id`),\n  KEY `virtual` (`virtual`),\n  KEY `downloadable` (`downloadable`),\n  KEY `stock_status` (`stock_status`),\n  KEY `stock_quantity` (`stock_quantity`),\n  KEY `onsale` (`onsale`),\n  KEY min_max_price (`min_price`, `max_price`),\n  KEY sku (sku(50))\n) ')), var_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_tax_rate_classes (\n  tax_rate_class_id bigint(20) unsigned NOT NULL auto_increment,\n  name varchar(200) NOT NULL DEFAULT \'\',\n  slug varchar(200) NOT NULL DEFAULT \'\',\n  PRIMARY KEY  (tax_rate_class_id),\n  UNIQUE KEY slug (slug(')), var_max_index_length), rt.new_string('))\n) ')), var_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_reserved_stock (\n\t`order_id` bigint(20) NOT NULL,\n\t`product_id` bigint(20) NOT NULL,\n\t`stock_quantity` double NOT NULL DEFAULT 0,\n\t`timestamp` datetime NOT NULL DEFAULT \'0000-00-00 00:00:00\',\n\t`expires` datetime NOT NULL DEFAULT \'0000-00-00 00:00:00\',\n\tPRIMARY KEY  (`order_id`, `product_id`),\n\tKEY product_id_expires (product_id, expires)\n) ')), var_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_rate_limits (\n  rate_limit_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,\n  rate_limit_key varchar(200) NOT NULL,\n  rate_limit_expiry bigint(20) unsigned NOT NULL,\n  rate_limit_remaining smallint(10) NOT NULL DEFAULT \'0\',\n  PRIMARY KEY  (rate_limit_id),\n  UNIQUE KEY rate_limit_key (rate_limit_key(')), var_max_index_length), rt.new_string('))\n) ')), var_collate), rt.new_string(';\n')), var_product_attributes_lookup_table_creation_sql), rt.new_string('\nCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_product_download_directories (\n\turl_id bigint(20) unsigned NOT NULL auto_increment,\n\turl varchar(256) NOT NULL,\n\tenabled tinyint(1) NOT NULL DEFAULT 0,\n\tPRIMARY KEY (url_id),\n\tKEY url (url(')), var_max_index_length), rt.new_string('))\n) ')), var_collate), rt.new_string(';\n')), var_order_stats_table_schema), rt.new_string('\nCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_product_lookup (\n\torder_item_id bigint(20) unsigned NOT NULL,\n\torder_id bigint(20) unsigned NOT NULL,\n\tproduct_id bigint(20) unsigned NOT NULL,\n\tvariation_id bigint(20) unsigned NOT NULL,\n\tcustomer_id bigint(20) unsigned NULL,\n\tdate_created datetime ')), var_datetime_default), rt.new_string(' NOT NULL,\n\tproduct_qty int(11) NOT NULL,\n\tproduct_net_revenue double DEFAULT 0 NOT NULL,\n\tproduct_gross_revenue double DEFAULT 0 NOT NULL,\n\tcoupon_amount double DEFAULT 0 NOT NULL,\n\ttax_amount double DEFAULT 0 NOT NULL,\n\tshipping_amount double DEFAULT 0 NOT NULL,\n\tshipping_tax_amount double DEFAULT 0 NOT NULL,\n\tPRIMARY KEY  (order_item_id, order_id),\n\tKEY order_id (order_id),\n\tKEY product_id (product_id),\n\tKEY customer_id (customer_id),\n\tKEY date_created (date_created),\n\tKEY customer_product_date (customer_id, product_id, date_created)\n) ')), var_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_tax_lookup (\n\torder_id bigint(20) unsigned NOT NULL,\n\ttax_rate_id bigint(20) unsigned NOT NULL,\n\tdate_created datetime DEFAULT \'0000-00-00 00:00:00\' NOT NULL,\n\tshipping_tax double DEFAULT 0 NOT NULL,\n\torder_tax double DEFAULT 0 NOT NULL,\n\ttotal_tax double DEFAULT 0 NOT NULL,\n\tPRIMARY KEY (order_id, tax_rate_id),\n\tKEY tax_rate_id (tax_rate_id),\n\tKEY date_created (date_created)\n) ')), var_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_coupon_lookup (\n\torder_id bigint(20) unsigned NOT NULL,\n\tcoupon_id bigint(20) NOT NULL,\n\tdate_created datetime DEFAULT \'0000-00-00 00:00:00\' NOT NULL,\n\tdiscount_amount double DEFAULT 0 NOT NULL,\n\tPRIMARY KEY (order_id, coupon_id),\n\tKEY coupon_id (coupon_id),\n\tKEY date_created (date_created)\n) ')), var_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_admin_notes (\n\tnote_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,\n\tname varchar(255) NOT NULL,\n\ttype varchar(20) NOT NULL,\n\tlocale varchar(20) NOT NULL,\n\ttitle longtext NOT NULL,\n\tcontent longtext NOT NULL,\n\tcontent_data longtext NULL default null,\n\tstatus varchar(200) NOT NULL,\n\tsource varchar(200) NOT NULL,\n\tdate_created datetime NOT NULL default \'0000-00-00 00:00:00\',\n\tdate_reminder datetime NULL default null,\n\tis_snoozable tinyint(1) DEFAULT 0 NOT NULL,\n\tlayout varchar(20) DEFAULT \'\' NOT NULL,\n\timage varchar(200) NULL DEFAULT NULL,\n\tis_deleted tinyint(1) DEFAULT 0 NOT NULL,\n\tis_read tinyint(1) DEFAULT 0 NOT NULL,\n\ticon varchar(200) NOT NULL default \'info\',\n\tPRIMARY KEY (note_id)\n) ')), var_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_admin_note_actions (\n\taction_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,\n\tnote_id bigint(20) unsigned NOT NULL,\n\tname varchar(255) NOT NULL,\n\tlabel varchar(255) NOT NULL,\n\tquery longtext NOT NULL,\n\tstatus varchar(255) NOT NULL,\n\tactioned_text varchar(255) NOT NULL,\n\tnonce_action varchar(255) NULL DEFAULT NULL,\n\tnonce_name varchar(255) NULL DEFAULT NULL,\n\tPRIMARY KEY (action_id),\n\tKEY note_id (note_id)\n) ')), var_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_customer_lookup (\n\tcustomer_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,\n\tuser_id bigint(20) unsigned DEFAULT NULL,\n\tusername varchar(60) DEFAULT \'\' NOT NULL,\n\tfirst_name varchar(255) NOT NULL,\n\tlast_name varchar(255) NOT NULL,\n\temail varchar(100) NULL default NULL,\n\tdate_last_active timestamp NULL default null,\n\tdate_registered timestamp NULL default null,\n\tcountry char(2) DEFAULT \'\' NOT NULL,\n\tpostcode varchar(20) DEFAULT \'\' NOT NULL,\n\tcity varchar(100) DEFAULT \'\' NOT NULL,\n\tstate varchar(100) DEFAULT \'\' NOT NULL,\n\tPRIMARY KEY (customer_id),\n\tUNIQUE KEY user_id (user_id),\n\tKEY email (email)\n) ')), var_collate), rt.new_string(';\nCREATE TABLE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_category_lookup (\n\tcategory_tree_id bigint(20) unsigned NOT NULL,\n\tcategory_id bigint(20) unsigned NOT NULL,\n\tPRIMARY KEY (category_tree_id,category_id)\n) ')), var_collate), rt.new_string(';\n')), var_hpos_table_schema), rt.new_string(';\n')), var_stock_notifications_table_schema), rt.new_string(';\n\t\t'))).str())
	return var_tables.clone()
}

fn Class_WC_Install.get_tables() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_tables := rt.create_array([rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_download_log')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_product_download_directories')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_product_meta_lookup')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_tax_rate_classes')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_webhooks')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_api_keys')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_attribute_taxonomies')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_downloadable_product_permissions')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_log')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_order_itemmeta')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_order_items')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_payment_tokenmeta')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_payment_tokens')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_sessions')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_shipping_zone_locations')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_shipping_zone_methods')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_shipping_zones')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_tax_rate_locations')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_tax_rates')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_reserved_stock')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_rate_limits')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_product_attributes_lookup')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_stock_notifications')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_stock_notificationmeta')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_order_stats')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_order_product_lookup')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_order_tax_lookup')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_order_coupon_lookup')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_admin_notes')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_admin_note_actions')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_customer_lookup')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_category_lookup')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_order_fulfillments')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_order_fulfillment_meta')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_orders')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_order_addresses')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_order_operational_data')) }, rt.ArrayItem{ key: none, val: rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('wc_orders_meta')) }])
	var_tables = rt.call_function('apply_filters', [rt.new_string('woocommerce_install_get_tables'), var_tables.clone()])
	return var_tables.clone()
}

fn Class_WC_Install.drop_tables() {
	mut var_wpdb := rt.new_null()
	mut var_tables := Class_WC_Install.get_tables()
	mut iter_8 := var_tables.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_table := item_8.val
		rt.call_method(var_wpdb, 'query', [rt.new_string("DROP TABLE IF EXISTS ${var_table.to_string()}")])
	}
}

fn Class_WC_Install.wpmu_drop_tables(var_tables rt.PhpVal) rt.PhpVal {
	mut var_tables_mutated := var_tables
	return rt.call_function('array_merge', [var_tables_mutated.clone(), Class_WC_Install.get_tables()])
}

fn Class_WC_Install.create_roles() {
	mut var_wp_roles := rt.get_superglobal('wp_roles')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WP_Roles')]))))) {
		return
	}
	if !(!(var_wp_roles).is_null()) {
	var_wp_roles = create_wp_roles()
	}
	rt.call_function('_x', [rt.new_string('Customer'), rt.new_string('User role'), rt.new_string('woocommerce')])
	rt.call_function('_x', [rt.new_string('Shop manager'), rt.new_string('User role'), rt.new_string('woocommerce')])
	rt.call_function('add_role', [rt.new_string('customer'), rt.new_string('Customer'), rt.create_array([rt.ArrayItem{ key: 'read', val: true }])])
	rt.call_function('add_role', [rt.new_string('shop_manager'), rt.new_string('Shop manager'), rt.create_array([rt.ArrayItem{ key: 'level_9', val: true }, rt.ArrayItem{ key: 'level_8', val: true }, rt.ArrayItem{ key: 'level_7', val: true }, rt.ArrayItem{ key: 'level_6', val: true }, rt.ArrayItem{ key: 'level_5', val: true }, rt.ArrayItem{ key: 'level_4', val: true }, rt.ArrayItem{ key: 'level_3', val: true }, rt.ArrayItem{ key: 'level_2', val: true }, rt.ArrayItem{ key: 'level_1', val: true }, rt.ArrayItem{ key: 'level_0', val: true }, rt.ArrayItem{ key: 'read', val: true }, rt.ArrayItem{ key: 'read_private_pages', val: true }, rt.ArrayItem{ key: 'read_private_posts', val: true }, rt.ArrayItem{ key: 'edit_posts', val: true }, rt.ArrayItem{ key: 'edit_pages', val: true }, rt.ArrayItem{ key: 'edit_published_posts', val: true }, rt.ArrayItem{ key: 'edit_published_pages', val: true }, rt.ArrayItem{ key: 'edit_private_pages', val: true }, rt.ArrayItem{ key: 'edit_private_posts', val: true }, rt.ArrayItem{ key: 'edit_others_posts', val: true }, rt.ArrayItem{ key: 'edit_others_pages', val: true }, rt.ArrayItem{ key: 'publish_posts', val: true }, rt.ArrayItem{ key: 'publish_pages', val: true }, rt.ArrayItem{ key: 'delete_posts', val: true }, rt.ArrayItem{ key: 'delete_pages', val: true }, rt.ArrayItem{ key: 'delete_private_pages', val: true }, rt.ArrayItem{ key: 'delete_private_posts', val: true }, rt.ArrayItem{ key: 'delete_published_pages', val: true }, rt.ArrayItem{ key: 'delete_published_posts', val: true }, rt.ArrayItem{ key: 'delete_others_posts', val: true }, rt.ArrayItem{ key: 'delete_others_pages', val: true }, rt.ArrayItem{ key: 'manage_categories', val: true }, rt.ArrayItem{ key: 'manage_links', val: true }, rt.ArrayItem{ key: 'moderate_comments', val: true }, rt.ArrayItem{ key: 'upload_files', val: true }, rt.ArrayItem{ key: 'export', val: true }, rt.ArrayItem{ key: 'import', val: true }, rt.ArrayItem{ key: 'list_users', val: true }, rt.ArrayItem{ key: 'edit_theme_options', val: true }])])
	mut var_capabilities := Class_WC_Install.get_core_capabilities()
	mut iter_9 := var_capabilities.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_cap_group := item_9.val
		mut iter_10 := var_cap_group.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_cap := item_10.val
			var_wp_roles.add_cap(rt.new_string('shop_manager'), var_cap.clone())
			var_wp_roles.add_cap(rt.new_string('administrator'), var_cap.clone())
		}
	}
}

fn Class_WC_Install.get_core_capabilities() rt.PhpVal {
	mut var_capabilities := rt.new_array()
	var_capabilities.array_set('core', rt.create_array([rt.ArrayItem{ key: none, val: 'manage_woocommerce' }, rt.ArrayItem{ key: none, val: 'create_customers' }, rt.ArrayItem{ key: none, val: 'view_woocommerce_reports' }]))
	mut var_capability_types := ['product', 'shop_order', 'shop_coupon']
	for var_capability_type in var_capability_types {
		var_capabilities.array_set(capability_type, rt.create_array([rt.ArrayItem{ key: none, val: "edit_${var_capability_type}" }, rt.ArrayItem{ key: none, val: "read_${var_capability_type}" }, rt.ArrayItem{ key: none, val: "delete_${var_capability_type}" }, rt.ArrayItem{ key: none, val: "edit_${var_capability_type}s" }, rt.ArrayItem{ key: none, val: "edit_others_${var_capability_type}s" }, rt.ArrayItem{ key: none, val: "publish_${var_capability_type}s" }, rt.ArrayItem{ key: none, val: "read_private_${var_capability_type}s" }, rt.ArrayItem{ key: none, val: "delete_${var_capability_type}s" }, rt.ArrayItem{ key: none, val: "delete_private_${var_capability_type}s" }, rt.ArrayItem{ key: none, val: "delete_published_${var_capability_type}s" }, rt.ArrayItem{ key: none, val: "delete_others_${var_capability_type}s" }, rt.ArrayItem{ key: none, val: "edit_private_${var_capability_type}s" }, rt.ArrayItem{ key: none, val: "edit_published_${var_capability_type}s" }, rt.ArrayItem{ key: none, val: "manage_${var_capability_type}_terms" }, rt.ArrayItem{ key: none, val: "edit_${var_capability_type}_terms" }, rt.ArrayItem{ key: none, val: "delete_${var_capability_type}_terms" }, rt.ArrayItem{ key: none, val: "assign_${var_capability_type}_terms" }]))
	}
	return var_capabilities.clone()
}

fn Class_WC_Install.remove_roles() {
	mut var_wp_roles := rt.get_superglobal('wp_roles')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WP_Roles')]))))) {
		return
	}
	if !(!(var_wp_roles).is_null()) {
	var_wp_roles = create_wp_roles()
	}
	mut var_capabilities := Class_WC_Install.get_core_capabilities()
	mut iter_11 := var_capabilities.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_cap_group := item_11.val
		mut iter_12 := var_cap_group.iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_cap := item_12.val
			var_wp_roles.remove_cap(rt.new_string('shop_manager'), var_cap.clone())
			var_wp_roles.remove_cap(rt.new_string('administrator'), var_cap.clone())
		}
	}
	rt.call_function('remove_role', [rt.new_string('customer')])
	rt.call_function('remove_role', [rt.new_string('shop_manager')])
}

fn Class_WC_Install.create_files() {
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_install_skip_create_files'), rt.new_bool(false)])) {
		return
	}
	mut var_upload_dir := rt.call_function('wp_get_upload_dir', []rt.PhpVal{})
	mut var_download_method := rt.call_function('get_option', [rt.new_string('woocommerce_file_download_method'), rt.new_string('force')])
	mut var_files := [[(var_upload_dir.array_get(rt.new_string('basedir'))).str() + '/woocommerce_uploads', rt.new_string('index.html'), rt.new_string('')], [(var_upload_dir.array_get(rt.new_string('basedir'))).str() + '/woocommerce_uploads', rt.new_string('.htaccess'), if rt.is_true(rt.identical(rt.new_string('redirect'), var_download_method)) { 'Options -Indexes' } else { 'deny from all' }]]
	for var_file in var_files {
		if rt.is_true(rt.call_function('wp_mkdir_p', [var_file.array_get(rt.new_string('base'))])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.call_function('trailingslashit', [var_file.array_get(rt.new_string('base'))])).str() + (var_file.array_get(rt.new_string('file'))).str())]))))) {
			mut var_file_handle := rt.call_function('fopen', [rt.new_string((rt.call_function('trailingslashit', [var_file.array_get(rt.new_string('base'))])).str() + (var_file.array_get(rt.new_string('file'))).str()), rt.new_string('wb')])
			if rt.is_true(var_file_handle) {
				rt.call_function('fwrite', [var_file_handle.clone(), var_file.array_get(rt.new_string('content'))])
				rt.call_function('fclose', [var_file_handle.clone()])
			}
		}
	}
	Class_WC_Install.create_placeholder_image()
}

fn Class_WC_Install.create_placeholder_image() {
	mut var_placeholder_image := rt.call_function('get_option', [rt.new_string('woocommerce_placeholder_image'), rt.new_int(0)])
	if !(!rt.is_true(var_placeholder_image)) {
		if !(var_placeholder_image.clone().is_long() || var_placeholder_image.clone().is_double()) {
			return
		} else if rt.is_true(var_placeholder_image) && rt.is_true(rt.call_function('wp_attachment_is_image', [var_placeholder_image.clone()])) {
			return
		}
	}
	mut var_upload_dir := rt.call_function('wp_upload_dir', []rt.PhpVal{})
	mut var_source := rt.new_string((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + '/assets/images/placeholder-attachment.webp')
	mut var_filename := rt.new_string((var_upload_dir.array_get(rt.new_string('basedir'))).str() + '/woocommerce-placeholder.webp')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_filename.clone()]))))) {
		rt.call_function('copy', [var_source.clone(), var_filename.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_filename.clone()]))))) {
		rt.call_function('update_option', [rt.new_string('woocommerce_placeholder_image'), rt.new_int(0)])
		return
	}
	mut var_filetype := rt.call_function('wp_check_filetype', [rt.call_function('basename', [var_filename.clone()]), rt.new_null()])
	mut var_attachment := { 'guid': (var_upload_dir.array_get(rt.new_string('url'))).str() + '/' + (rt.call_function('basename', [var_filename.clone()])).str(), 'post_mime_type': var_filetype.array_get(rt.new_string('type')), 'post_title': rt.call_function('preg_replace', [rt.new_string('/\\.[^.]+$/'), rt.new_string(''), rt.call_function('basename', [var_filename.clone()])]), 'post_content': rt.new_string(''), 'post_status': rt.new_string('inherit') }
	mut var_attach_id := rt.call_function('wp_insert_attachment', [rt.create_array_from_native_map(var_attachment), var_filename.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_attach_id.clone()])) {
		rt.call_function('update_option', [rt.new_string('woocommerce_placeholder_image'), rt.new_int(0)])
		return
	}
	rt.call_function('update_option', [rt.new_string('woocommerce_placeholder_image'), var_attach_id.clone()])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/image.php', '4')
	mut var_attach_data := rt.call_function('wp_generate_attachment_metadata', [var_attach_id.clone(), var_filename.clone()])
	rt.call_function('wp_update_attachment_metadata', [var_attach_id.clone(), var_attach_data.clone()])
}

fn Class_WC_Install.plugin_action_links(var_links rt.PhpVal) rt.PhpVal {
	mut var_action_links := { 'settings': '<a href="' + (rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings')])).str() + '" aria-label="' + (rt.call_function('esc_attr__', [rt.new_string('View WooCommerce settings'), rt.new_string('woocommerce')])).str() + '">' + (rt.call_function('esc_html__', [rt.new_string('Settings'), rt.new_string('woocommerce')])).str() + '</a>' }
	return rt.call_function('array_merge', [rt.create_array_from_native_map(var_action_links), var_links.clone()])
}

fn Class_WC_Install.plugin_row_meta(var_links rt.PhpVal, var_file rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_constant('WC_PLUGIN_BASENAME'), var_file)))) {
		return var_links.clone()
	}
	mut var_docs_url := rt.call_function('apply_filters', [rt.new_string('woocommerce_docs_url'), rt.new_string('https://woocommerce.com/documentation/plugins/woocommerce/')])
	mut var_api_docs_url := rt.call_function('apply_filters', [rt.new_string('woocommerce_apidocs_url'), rt.new_string('https://woocommerce.com/wc-apidocs/')])
	mut var_community_support_url := rt.call_function('apply_filters', [rt.new_string('woocommerce_community_support_url'), rt.new_string('https://wordpress.org/support/plugin/woocommerce/')])
	mut var_support_url := rt.call_function('apply_filters', [rt.new_string('woocommerce_support_url'), rt.new_string('https://woocommerce.com/my-account/create-a-ticket/')])
	mut var_row_meta := { 'docs': '<a href="' + (rt.call_function('esc_url', [var_docs_url.clone()])).str() + '" aria-label="' + (rt.call_function('esc_attr__', [rt.new_string('View WooCommerce documentation'), rt.new_string('woocommerce')])).str() + '">' + (rt.call_function('esc_html__', [rt.new_string('Docs'), rt.new_string('woocommerce')])).str() + '</a>', 'apidocs': '<a href="' + (rt.call_function('esc_url', [var_api_docs_url.clone()])).str() + '" aria-label="' + (rt.call_function('esc_attr__', [rt.new_string('View WooCommerce API docs'), rt.new_string('woocommerce')])).str() + '">' + (rt.call_function('esc_html__', [rt.new_string('API docs'), rt.new_string('woocommerce')])).str() + '</a>', 'support': '<a href="' + (rt.call_function('esc_url', [var_community_support_url.clone()])).str() + '" aria-label="' + (rt.call_function('esc_attr__', [rt.new_string('Visit community forums'), rt.new_string('woocommerce')])).str() + '">' + (rt.call_function('esc_html__', [rt.new_string('Community support'), rt.new_string('woocommerce')])).str() + '</a>' }
	mut iife_temp_24 := Class_Automattic_WooCommerce_Internal_WCCom_ConnectionHelper{}
	mut iife_result_24 := iife_temp_24.is_connected()
	if rt.is_true(iife_result_24) {
		var_row_meta['premium_support'] = '<a href="' + (rt.call_function('esc_url', [var_support_url.clone()])).str() + '" aria-label="' + (rt.call_function('esc_attr__', [rt.new_string('Visit premium customer support'), rt.new_string('woocommerce')])).str() + '">' + (rt.call_function('esc_html__', [rt.new_string('Premium support'), rt.new_string('woocommerce')])).str() + '</a>'
	}
	return rt.call_function('array_merge', [var_links.clone(), rt.create_array_from_native_map(var_row_meta)])
}

fn Class_WC_Install.associate_plugin_file(var_plugins rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut var_plugins_mutated := var_plugins
	mut var_path := rt.call_function('explode', [rt.new_string('/'), var_key.clone()])
	mut var_filename := rt.call_function('end', [var_path.clone()])
	var_plugins_mutated.array_set(var_filename, var_key.clone())
	return var_plugins_mutated.clone()
}

fn Class_WC_Install.background_installer(var_plugin_to_install_id rt.PhpVal, var_plugin_to_install rt.PhpVal) {
	mut var_args := rt.call_function('func_get_args', []rt.PhpVal{})
	if !(!rt.is_true(var_plugin_to_install.array_get(rt.new_string('repo-slug')))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin-install.php', '4')
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader.php', '4')
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
		rt.call_function('WP_Filesystem', []rt.PhpVal{})
		mut var_skin := create_automatic_upgrader_skin()
		mut var_upgrader := create_wp_upgrader(var_skin)
		mut var_installed_plugins := rt.call_function('array_reduce', [rt.func_array_keys(rt.call_function('get_plugins', []rt.PhpVal{})), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'associate_plugin_file' }])])
		if !rt.is_true(var_installed_plugins) {
		var_installed_plugins = rt.new_array()
		}
		mut var_plugin_slug := var_plugin_to_install.array_get(rt.new_string('repo-slug'))
		mut var_plugin_file := if var_plugin_to_install.array_isset(rt.new_string('file')) { var_plugin_to_install.array_get(rt.new_string('file')) } else { (var_plugin_slug).str() + '.php' }
		mut var_installed := rt.new_bool(false)
		mut var_activate := rt.new_bool(false)
		if var_installed_plugins.array_isset(var_plugin_file) {
		var_installed = rt.new_bool(true)
		var_activate = rt.new_bool(!(rt.is_true(rt.call_function('is_plugin_active', [var_installed_plugins.array_get(var_plugin_file)]))))
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_installed)))) {
			rt.call_function('ob_start', []rt.PhpVal{})
			mut var_plugin_information := rt.call_function('plugins_api', [rt.new_string('plugin_information'), rt.create_array([rt.ArrayItem{ key: 'slug', val: var_plugin_slug }, rt.ArrayItem{ key: 'fields', val: rt.create_array([rt.ArrayItem{ key: 'short_description', val: false }, rt.ArrayItem{ key: 'sections', val: false }, rt.ArrayItem{ key: 'requires', val: false }, rt.ArrayItem{ key: 'rating', val: false }, rt.ArrayItem{ key: 'ratings', val: false }, rt.ArrayItem{ key: 'downloaded', val: false }, rt.ArrayItem{ key: 'last_updated', val: false }, rt.ArrayItem{ key: 'added', val: false }, rt.ArrayItem{ key: 'tags', val: false }, rt.ArrayItem{ key: 'homepage', val: false }, rt.ArrayItem{ key: 'donate_link', val: false }, rt.ArrayItem{ key: 'author_profile', val: false }, rt.ArrayItem{ key: 'author', val: false }]) }])])
			if rt.has_exception() { unsafe { goto catch_label_5 } }
			if rt.is_true(rt.call_function('is_wp_error', [var_plugin_information.clone()])) {
				rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(var_plugin_information, 'get_error_message', []rt.PhpVal{}))))
				if rt.has_exception() { unsafe { goto catch_label_5 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_5 } }
			mut var_package := rt.get_property(var_plugin_information, 'download_link')
			if rt.has_exception() { unsafe { goto catch_label_5 } }
			mut var_download := rt.call_method(var_upgrader, 'download_package', [var_package.clone()])
			if rt.has_exception() { unsafe { goto catch_label_5 } }
			if rt.is_true(rt.call_function('is_wp_error', [var_download.clone()])) {
				rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(var_download, 'get_error_message', []rt.PhpVal{}))))
				if rt.has_exception() { unsafe { goto catch_label_5 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_5 } }
			mut var_working_dir := rt.call_method(var_upgrader, 'unpack_package', [var_download.clone(), rt.new_bool(true)])
			if rt.has_exception() { unsafe { goto catch_label_5 } }
			if rt.is_true(rt.call_function('is_wp_error', [var_working_dir.clone()])) {
				rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(var_working_dir, 'get_error_message', []rt.PhpVal{}))))
				if rt.has_exception() { unsafe { goto catch_label_5 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_5 } }
			mut var_result := rt.call_method(var_upgrader, 'install_package', [rt.create_array([rt.ArrayItem{ key: 'source', val: var_working_dir }, rt.ArrayItem{ key: 'destination', val: rt.get_constant('WP_PLUGIN_DIR') }, rt.ArrayItem{ key: 'clear_destination', val: false }, rt.ArrayItem{ key: 'abort_if_destination_exists', val: false }, rt.ArrayItem{ key: 'clear_working', val: true }, rt.ArrayItem{ key: 'hook_extra', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'plugin' }, rt.ArrayItem{ key: 'action', val: 'install' }]) }])])
			if rt.has_exception() { unsafe { goto catch_label_5 } }
			if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
				rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}))))
				if rt.has_exception() { unsafe { goto catch_label_5 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_5 } }
			var_activate = rt.new_bool(true)
			if rt.has_exception() { unsafe { goto catch_label_5 } }
			unsafe { goto end_label_5 }

catch_label_5:
			mut var_e_5 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_5, 'Exception') {
				mut var_e := var_e_5.clone()
				mut iife_temp_25 := Class_WC_Admin_Notices{}
				mut iife_result_25 := iife_temp_25.add_custom_notice(rt.new_string((var_plugin_to_install_id).str() + '_install_error'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s could not be installed (%2$s). <a href="%3$s">Please install it manually by clicking here.</a>'), rt.new_string('woocommerce')]), var_plugin_to_install.array_get(rt.new_string('name')), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('index.php?wc-install-plugin-redirect=' + (var_plugin_slug).str())])])]))
				unsafe { goto end_label_5 }
			}
			else {
				rt.throw_exception(var_e_5)
				unsafe { goto end_label_5 }
			}

end_label_5:
			rt.call_function('ob_end_clean', []rt.PhpVal{})
		}
		rt.call_function('wp_clean_plugins_cache', []rt.PhpVal{})
		if rt.is_true(var_activate) {
			rt.call_function('add_action', [rt.new_string('add_option_mailchimp_woocommerce_plugin_do_activation_redirect'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'remove_mailchimps_redirect' }]), rt.new_int(10), rt.new_int(2)])
			if rt.has_exception() { unsafe { goto catch_label_6 } }
			var_result = rt.call_function('activate_plugin', [if rt.is_true(var_installed) { var_installed_plugins.array_get(var_plugin_file) } else { (var_plugin_slug).str() + '/' + (var_plugin_file).str() }])
			if rt.has_exception() { unsafe { goto catch_label_6 } }
			if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
				rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}))))
				if rt.has_exception() { unsafe { goto catch_label_6 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_6 } }
			unsafe { goto end_label_6 }

catch_label_6:
			mut var_e_6 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_6, 'Exception') {
				var_e = var_e_6.clone()
				mut iife_temp_26 := Class_WC_Admin_Notices{}
				mut iife_result_26 := iife_temp_26.add_custom_notice(rt.new_string((var_plugin_to_install_id).str() + '_install_error'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s was installed but could not be activated. <a href="%2$s">Please activate it manually by clicking here.</a>'), rt.new_string('woocommerce')]), var_plugin_to_install.array_get(rt.new_string('name')), rt.call_function('admin_url', [rt.new_string('plugins.php')])]))
				unsafe { goto end_label_6 }
			}
			else {
				rt.throw_exception(var_e_6)
				unsafe { goto end_label_6 }
			}

end_label_6:
		}
	}
}

fn Class_WC_Install.remove_mailchimps_redirect(var_option rt.PhpVal, var_value rt.PhpVal) {
	rt.call_function('remove_action', [rt.new_string('add_option_mailchimp_woocommerce_plugin_do_activation_redirect'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'remove_mailchimps_redirect' }])])
	rt.call_function('update_option', [rt.new_string('mailchimp_woocommerce_plugin_do_activation_redirect'), rt.new_bool(false)])
}

fn Class_WC_Install.theme_background_installer(var_theme_slug rt.PhpVal) {
	mut var_args := rt.call_function('func_get_args', []rt.PhpVal{})
	if !(!rt.is_true(var_theme_slug)) {
		rt.call_function('ob_start', []rt.PhpVal{})
		mut var_theme := rt.call_function('wp_get_theme', [var_theme_slug.clone()])
		if rt.has_exception() { unsafe { goto catch_label_7 } }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_theme, 'exists', []rt.PhpVal{}))))) {
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
			if rt.has_exception() { unsafe { goto catch_label_7 } }
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader.php', '2')
			if rt.has_exception() { unsafe { goto catch_label_7 } }
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/theme.php', '2')
			if rt.has_exception() { unsafe { goto catch_label_7 } }
			rt.call_function('WP_Filesystem', []rt.PhpVal{})
			if rt.has_exception() { unsafe { goto catch_label_7 } }
			mut var_skin := create_automatic_upgrader_skin()
			if rt.has_exception() { unsafe { goto catch_label_7 } }
			mut var_upgrader := create_theme_upgrader(var_skin)
			if rt.has_exception() { unsafe { goto catch_label_7 } }
			mut var_api := rt.call_function('themes_api', [rt.new_string('theme_information'), rt.create_array([rt.ArrayItem{ key: 'slug', val: var_theme_slug }, rt.ArrayItem{ key: 'fields', val: rt.create_array([rt.ArrayItem{ key: 'sections', val: false }]) }])])
			if rt.has_exception() { unsafe { goto catch_label_7 } }
			mut var_result := rt.call_method(var_upgrader, 'install', [rt.get_property(var_api, 'download_link')])
			if rt.has_exception() { unsafe { goto catch_label_7 } }
			if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
				rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}))))
				if rt.has_exception() { unsafe { goto catch_label_7 } }
			} else if rt.is_true(rt.call_function('is_wp_error', [rt.get_property(var_skin, 'result')])) {
				rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(rt.get_property(var_skin, 'result'), 'get_error_message', []rt.PhpVal{}))))
				if rt.has_exception() { unsafe { goto catch_label_7 } }
			} else if rt.is_true(rt.new_bool(var_result.clone().is_null())) {
				rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.new_string('Unable to connect to the filesystem. Please confirm your credentials.'))))
				if rt.has_exception() { unsafe { goto catch_label_7 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_7 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_7 } }
		rt.call_function('switch_theme', [var_theme_slug.clone()])
		if rt.has_exception() { unsafe { goto catch_label_7 } }
		unsafe { goto end_label_7 }

catch_label_7:
		mut var_e_7 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_7, 'Exception') {
			mut var_e := var_e_7.clone()
			mut iife_temp_27 := Class_WC_Admin_Notices{}
			mut iife_result_27 := iife_temp_27.add_custom_notice(rt.new_string((var_theme_slug).str() + '_install_error'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s could not be installed (%2$s). <a href="%3$s">Please install it manually by clicking here.</a>'), rt.new_string('woocommerce')]), var_theme_slug.clone(), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('update.php?action=install-theme&theme=' + (var_theme_slug).str() + '&_wpnonce=' + (rt.call_function('wp_create_nonce', [rt.new_string('install-theme_' + (var_theme_slug).str())])).str())])])]))
			unsafe { goto end_label_7 }
		}
		else {
			rt.throw_exception(var_e_7)
			unsafe { goto end_label_7 }
		}

end_label_7:
		rt.call_function('ob_end_clean', []rt.PhpVal{})
	}
}

fn Class_WC_Install.set_paypal_standard_load_eligibility() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Gateway_Paypal')])) {
		mut iife_temp_28 := Class_WC_Gateway_Paypal{}
		mut iife_result_28 := iife_temp_28.get_instance()
		rt.call_method(iife_result_28, 'should_load', []rt.PhpVal{})
	}
}

fn Class_WC_Install.get_refunds_return_policy_page_content() string {
	return '<!-- wp:paragraph -->\n<p><b>This is a sample page.</b></p>\n<!-- /wp:paragraph -->\n\n<!-- wp:heading -->\n<h2 class="wp-block-heading">Overview</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>Our refund and returns policy lasts 30 days. If 30 days have passed since your purchase, we can’t offer you a full refund or exchange.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>To be eligible for a return, your item must be unused and in the same condition that you received it. It must also be in the original packaging.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>Several types of goods are exempt from being returned. Perishable goods such as food, flowers, newspapers or magazines cannot be returned. We also do not accept products that are intimate or sanitary goods, hazardous materials, or flammable liquids or gases.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>Additional non-returnable items:</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:list -->\n<ul>\n<li>Gift cards</li>\n<li>Downloadable software products</li>\n<li>Some health and personal care items</li>\n</ul>\n<!-- /wp:list -->\n\n<!-- wp:paragraph -->\n<p>To complete your return, we require a receipt or proof of purchase.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>Please do not send your purchase back to the manufacturer.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>There are certain situations where only partial refunds are granted:</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:list -->\n<ul>\n<li>Book with obvious signs of use</li>\n<li>CD, DVD, VHS tape, software, video game, cassette tape, or vinyl record that has been opened.</li>\n<li>Any item not in its original condition, is damaged or missing parts for reasons not due to our error.</li>\n<li>Any item that is returned more than 30 days after delivery</li>\n</ul>\n<!-- /wp:list -->\n\n<!-- wp:heading -->\n<h2 class="wp-block-heading">Refunds</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>Once your return is received and inspected, we will send you an email to notify you that we have received your returned item. We will also notify you of the approval or rejection of your refund.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>If you are approved, then your refund will be processed, and a credit will automatically be applied to your credit card or original method of payment, within a certain amount of days.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:heading {"level":3} -->\n<h3 class="wp-block-heading">Late or missing refunds</h3>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>If you haven’t received a refund yet, first check your bank account again.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>Then contact your credit card company, it may take some time before your refund is officially posted.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>Next contact your bank. There is often some processing time before a refund is posted.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>If you’ve done all of this and you still have not received your refund yet, please contact us at {email address}.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:heading {"level":3} -->\n<h3 class="wp-block-heading">Sale items</h3>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>Only regular priced items may be refunded. Sale items cannot be refunded.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:heading -->\n<h2 class="wp-block-heading">Exchanges</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>We only replace items if they are defective or damaged. If you need to exchange it for the same item, send us an email at {email address} and send your item to: {physical address}.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:heading -->\n<h2 class="wp-block-heading">Gifts</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>If the item was marked as a gift when purchased and shipped directly to you, you’ll receive a gift credit for the value of your return. Once the returned item is received, a gift certificate will be mailed to you.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>If the item wasn’t marked as a gift when purchased, or the gift giver had the order shipped to themselves to give to you later, we will send a refund to the gift giver and they will find out about your return.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:heading -->\n<h2 class="wp-block-heading">Shipping returns</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>To return your product, you should mail your product to: {physical address}.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>You will be responsible for paying for your own shipping costs for returning your item. Shipping costs are non-refundable. If you receive a refund, the cost of return shipping will be deducted from your refund.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>Depending on where you live, the time it may take for your exchanged product to reach you may vary.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:paragraph -->\n<p>If you are returning more expensive items, you may consider using a trackable shipping service or purchasing shipping insurance. We don’t guarantee that we will receive your returned item.</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:heading -->\n<h2 class="wp-block-heading">Need help?</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>Contact us at {email} for questions related to refunds and returns.</p>\n<!-- /wp:paragraph -->'
}

fn Class_WC_Install.add_admin_note_after_page_created() {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Install::add_admin_note_after_page_created'), rt.new_string('10.5.0')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_wc_admin_active', []rt.PhpVal{}))))) {
		return
	}
	mut var_page_id := rt.call_function('get_option', [rt.new_string('woocommerce_refund_returns_page_created'), rt.new_null()])
	if rt.is_true(rt.identical(rt.new_null(), var_page_id)) {
		return
	}
mut iife_temp_29 := Class_WC_Notes_Refund_Returns{}
mut iife_result_29 := iife_temp_29.possibly_add_note(var_page_id.clone())
}

fn Class_WC_Install.page_created(var_page_id rt.PhpVal, var_page_data rt.PhpVal) {
	mut var_page_id_mutated := var_page_id
	mut iife_temp_30 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_30 := iife_temp_30.is_true(rt.new_string('WC_INSTALLING'))
	if rt.is_true(iife_result_30) {
		return
	}
	if rt.is_true(rt.identical(rt.new_string('refund_returns'), var_page_data.array_get(rt.new_string('post_name')))) && rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Notes_Refund_Returns'), rt.new_bool(false)])) {
		closure_33_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut iife_temp_32 := Class_WC_Notes_Refund_Returns{}
			mut iife_result_32 := iife_temp_32.possibly_add_note(var_page_id_mutated.clone())
			return iife_result_32
			}
		mut var_callback := rt.new_closure(closure_33_fn)
		if rt.is_true(rt.call_function('did_action', [rt.new_string('init')])) {
			rt.call_callable(var_callback, []rt.PhpVal{})
		} else {
			rt.call_function('add_action', [rt.new_string('init'), var_callback.clone()])
		}
	}
}

fn Class_WC_Install.get_cart_block_content() string {
	return '<!-- wp:woocommerce/cart -->\n<div class="wp-block-woocommerce-cart alignwide is-loading"><!-- wp:woocommerce/filled-cart-block -->\n<div class="wp-block-woocommerce-filled-cart-block"><!-- wp:woocommerce/cart-items-block -->\n<div class="wp-block-woocommerce-cart-items-block"><!-- wp:woocommerce/cart-line-items-block -->\n<div class="wp-block-woocommerce-cart-line-items-block"></div>\n<!-- /wp:woocommerce/cart-line-items-block -->\n\n<!-- wp:woocommerce/product-collection {"queryId":0,"query":{"perPage":3,"pages":1,"offset":0,"postType":"product","order":"asc","orderBy":"title","search":"","exclude":[],"inherit":false,"taxQuery":{},"isProductCollectionBlock":true,"featured":false,"woocommerceOnSale":false,"woocommerceStockStatus":["instock","outofstock","onbackorder"],"woocommerceAttributes":[],"woocommerceHandPickedProducts":[],"filterable":false,"relatedBy":{"categories":true,"tags":true}},"tagName":"div","displayLayout":{"type":"flex","columns":3,"shrinkColumns":true},"dimensions":{"widthType":"fill"},"collection":"woocommerce/product-collection/cross-sells","hideControls":["filterable"],"queryContextIncludes":["collection"],"__privatePreviewState":{"isPreview":true,"previewMessage":"Actual products will vary depending on the page being viewed."}} -->\n<div class="wp-block-woocommerce-product-collection"><!-- wp:heading {"textAlign":"left","style":{"spacing":{"margin":{"bottom":"1rem"}}}} -->\n<h2 class="wp-block-heading has-text-align-left" style="margin-bottom:1rem">' + (rt.call_function('__', [rt.new_string('You may be interested in&hellip;'), rt.new_string('woocommerce')])).str() + '</h2>\n\n<!-- /wp:heading -->\n\n<!-- wp:woocommerce/product-template -->\n<!-- wp:woocommerce/product-image {"showSaleBadge":false,"imageSizing":"thumbnail","isDescendentOfQueryLoop":true} -->\n<!-- wp:woocommerce/product-sale-badge {"align":"right"} /-->\n<!-- /wp:woocommerce/product-image -->\n\n<!-- wp:post-title {"textAlign":"center","isLink":true,"style":{"spacing":{"margin":{"bottom":"0.75rem","top":"0"}},"typography":{"lineHeight":"1.4"}},"fontSize":"medium","__woocommerceNamespace":"woocommerce/product-collection/product-title"} /-->\n\n<!-- wp:woocommerce/product-price {"isDescendentOfQueryLoop":true,"textAlign":"center","fontSize":"small"} /-->\n\n<!-- wp:woocommerce/product-button {"textAlign":"center","isDescendentOfQueryLoop":true,"fontSize":"small"} /-->\n<!-- /wp:woocommerce/product-template --></div>\n<!-- /wp:woocommerce/product-collection --></div>\n\n<!-- /wp:woocommerce/cart-items-block -->\n\n<!-- wp:woocommerce/cart-totals-block -->\n<div class="wp-block-woocommerce-cart-totals-block"><!-- wp:woocommerce/cart-order-summary-block -->\n<div class="wp-block-woocommerce-cart-order-summary-block"><!-- wp:woocommerce/cart-order-summary-heading-block -->\n<div class="wp-block-woocommerce-cart-order-summary-heading-block"></div>\n<!-- /wp:woocommerce/cart-order-summary-heading-block -->\n\n<!-- wp:woocommerce/cart-order-summary-coupon-form-block -->\n<div class="wp-block-woocommerce-cart-order-summary-coupon-form-block"></div>\n<!-- /wp:woocommerce/cart-order-summary-coupon-form-block -->\n\n<!-- wp:woocommerce/cart-order-summary-subtotal-block -->\n<div class="wp-block-woocommerce-cart-order-summary-subtotal-block"></div>\n<!-- /wp:woocommerce/cart-order-summary-subtotal-block -->\n\n<!-- wp:woocommerce/cart-order-summary-fee-block -->\n<div class="wp-block-woocommerce-cart-order-summary-fee-block"></div>\n<!-- /wp:woocommerce/cart-order-summary-fee-block -->\n\n<!-- wp:woocommerce/cart-order-summary-discount-block -->\n<div class="wp-block-woocommerce-cart-order-summary-discount-block"></div>\n<!-- /wp:woocommerce/cart-order-summary-discount-block -->\n\n<!-- wp:woocommerce/cart-order-summary-shipping-block -->\n<div class="wp-block-woocommerce-cart-order-summary-shipping-block"></div>\n<!-- /wp:woocommerce/cart-order-summary-shipping-block -->\n\n<!-- wp:woocommerce/cart-order-summary-taxes-block -->\n<div class="wp-block-woocommerce-cart-order-summary-taxes-block"></div>\n<!-- /wp:woocommerce/cart-order-summary-taxes-block --></div>\n<!-- /wp:woocommerce/cart-order-summary-block -->\n\n<!-- wp:woocommerce/cart-express-payment-block -->\n<div class="wp-block-woocommerce-cart-express-payment-block"></div>\n<!-- /wp:woocommerce/cart-express-payment-block -->\n\n<!-- wp:woocommerce/proceed-to-checkout-block -->\n<div class="wp-block-woocommerce-proceed-to-checkout-block"></div>\n<!-- /wp:woocommerce/proceed-to-checkout-block -->\n\n<!-- wp:woocommerce/cart-accepted-payment-methods-block -->\n<div class="wp-block-woocommerce-cart-accepted-payment-methods-block"></div>\n<!-- /wp:woocommerce/cart-accepted-payment-methods-block --></div>\n<!-- /wp:woocommerce/cart-totals-block --></div>\n<!-- /wp:woocommerce/filled-cart-block -->\n\n<!-- wp:woocommerce/empty-cart-block -->\n<div class="wp-block-woocommerce-empty-cart-block"><!-- wp:heading {"textAlign":"center","className":"with-empty-cart-icon wc-block-cart__empty-cart__title"} -->\n<h2 class="wp-block-heading has-text-align-center with-empty-cart-icon wc-block-cart__empty-cart__title">' + (rt.call_function('__', [rt.new_string('Your cart is currently empty!'), rt.new_string('woocommerce')])).str() + '</h2>\n<!-- /wp:heading -->\n\n<!-- wp:separator {"className":"is-style-dots"} -->\n<hr class="wp-block-separator has-alpha-channel-opacity is-style-dots"/>\n<!-- /wp:separator -->\n\n<!-- wp:heading {"textAlign":"center"} -->\n<h2 class="wp-block-heading has-text-align-center">' + (rt.call_function('__', [rt.new_string('New in store'), rt.new_string('woocommerce')])).str() + '</h2>\n<!-- /wp:heading -->\n\n<!-- wp:woocommerce/product-new {"columns":4,"rows":1} /--></div>\n<!-- /wp:woocommerce/empty-cart-block --></div>\n<!-- /wp:woocommerce/cart -->'
}

fn Class_WC_Install.get_checkout_block_content() string {
	return '<!-- wp:woocommerce/checkout -->\n<div class="wp-block-woocommerce-checkout alignwide wc-block-checkout is-loading"><!-- wp:woocommerce/checkout-fields-block -->\n<div class="wp-block-woocommerce-checkout-fields-block"><!-- wp:woocommerce/checkout-express-payment-block -->\n<div class="wp-block-woocommerce-checkout-express-payment-block"></div>\n<!-- /wp:woocommerce/checkout-express-payment-block -->\n\n<!-- wp:woocommerce/checkout-contact-information-block -->\n<div class="wp-block-woocommerce-checkout-contact-information-block"></div>\n<!-- /wp:woocommerce/checkout-contact-information-block -->\n\n<!-- wp:woocommerce/checkout-shipping-method-block -->\n<div class="wp-block-woocommerce-checkout-shipping-method-block"></div>\n<!-- /wp:woocommerce/checkout-shipping-method-block -->\n\n<!-- wp:woocommerce/checkout-pickup-options-block -->\n<div class="wp-block-woocommerce-checkout-pickup-options-block"></div>\n<!-- /wp:woocommerce/checkout-pickup-options-block -->\n\n<!-- wp:woocommerce/checkout-shipping-address-block -->\n<div class="wp-block-woocommerce-checkout-shipping-address-block"></div>\n<!-- /wp:woocommerce/checkout-shipping-address-block -->\n\n<!-- wp:woocommerce/checkout-billing-address-block -->\n<div class="wp-block-woocommerce-checkout-billing-address-block"></div>\n<!-- /wp:woocommerce/checkout-billing-address-block -->\n\n<!-- wp:woocommerce/checkout-shipping-methods-block -->\n<div class="wp-block-woocommerce-checkout-shipping-methods-block"></div>\n<!-- /wp:woocommerce/checkout-shipping-methods-block -->\n\n<!-- wp:woocommerce/checkout-payment-block -->\n<div class="wp-block-woocommerce-checkout-payment-block"></div>\n<!-- /wp:woocommerce/checkout-payment-block -->\n\n<!-- wp:woocommerce/checkout-additional-information-block -->\n<div class="wp-block-woocommerce-checkout-additional-information-block"></div>\n<!-- /wp:woocommerce/checkout-additional-information-block -->\n\n<!-- wp:woocommerce/checkout-order-note-block -->\n<div class="wp-block-woocommerce-checkout-order-note-block"></div>\n<!-- /wp:woocommerce/checkout-order-note-block -->\n\n<!-- wp:woocommerce/checkout-terms-block -->\n<div class="wp-block-woocommerce-checkout-terms-block"></div>\n<!-- /wp:woocommerce/checkout-terms-block -->\n\n<!-- wp:woocommerce/checkout-actions-block -->\n<div class="wp-block-woocommerce-checkout-actions-block"></div>\n<!-- /wp:woocommerce/checkout-actions-block --></div>\n<!-- /wp:woocommerce/checkout-fields-block -->\n\n<!-- wp:woocommerce/checkout-totals-block -->\n<div class="wp-block-woocommerce-checkout-totals-block"><!-- wp:woocommerce/checkout-order-summary-block -->\n<div class="wp-block-woocommerce-checkout-order-summary-block"><!-- wp:woocommerce/checkout-order-summary-cart-items-block -->\n<div class="wp-block-woocommerce-checkout-order-summary-cart-items-block"></div>\n<!-- /wp:woocommerce/checkout-order-summary-cart-items-block -->\n\n<!-- wp:woocommerce/checkout-order-summary-coupon-form-block -->\n<div class="wp-block-woocommerce-checkout-order-summary-coupon-form-block"></div>\n<!-- /wp:woocommerce/checkout-order-summary-coupon-form-block -->\n\n<!-- wp:woocommerce/checkout-order-summary-subtotal-block -->\n<div class="wp-block-woocommerce-checkout-order-summary-subtotal-block"></div>\n<!-- /wp:woocommerce/checkout-order-summary-subtotal-block -->\n\n<!-- wp:woocommerce/checkout-order-summary-fee-block -->\n<div class="wp-block-woocommerce-checkout-order-summary-fee-block"></div>\n<!-- /wp:woocommerce/checkout-order-summary-fee-block -->\n\n<!-- wp:woocommerce/checkout-order-summary-discount-block -->\n<div class="wp-block-woocommerce-checkout-order-summary-discount-block"></div>\n<!-- /wp:woocommerce/checkout-order-summary-discount-block -->\n\n<!-- wp:woocommerce/checkout-order-summary-shipping-block -->\n<div class="wp-block-woocommerce-checkout-order-summary-shipping-block"></div>\n<!-- /wp:woocommerce/checkout-order-summary-shipping-block -->\n\n<!-- wp:woocommerce/checkout-order-summary-taxes-block -->\n<div class="wp-block-woocommerce-checkout-order-summary-taxes-block"></div>\n<!-- /wp:woocommerce/checkout-order-summary-taxes-block --></div>\n<!-- /wp:woocommerce/checkout-order-summary-block --></div>\n<!-- /wp:woocommerce/checkout-totals-block --></div>\n<!-- /wp:woocommerce/checkout -->'
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_WC_Notes_Run_Db_Update {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Notices {
	rt.PhpObjectBase
}

struct Class_WC_Post_types {
	rt.PhpObjectBase
}

struct Class_WC_Auth {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Settings {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements {
	rt.PhpObjectBase
}

struct Class_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore {
	rt.PhpObjectBase
}

struct Class_WP_Roles {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_WCCom_ConnectionHelper {
	rt.PhpObjectBase
}

struct Class_Automatic_Upgrader_Skin {
	rt.PhpObjectBase
}

struct Class_WP_Upgrader {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
		message string
		code i64
		file string
		line i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_Theme_Upgrader {
	rt.PhpObjectBase
}

struct Class_WC_Gateway_Paypal {
	rt.PhpObjectBase
}

struct Class_WC_Notes_Refund_Returns {
	rt.PhpObjectBase
}

fn create_wc_install(_args ...rt.PhpVal) &Class_WC_Install {
	mut obj := &Class_WC_Install{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_notes_run_db_update(_args ...rt.PhpVal) &Class_WC_Notes_Run_Db_Update {
	mut obj := &Class_WC_Notes_Run_Db_Update{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_notices(_args ...rt.PhpVal) &Class_WC_Admin_Notices {
	mut obj := &Class_WC_Admin_Notices{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_post_types(_args ...rt.PhpVal) &Class_WC_Post_types {
	mut obj := &Class_WC_Post_types{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_auth(_args ...rt.PhpVal) &Class_WC_Auth {
	mut obj := &Class_WC_Auth{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_transientfiles_transientfilesengine(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine {
	mut obj := &Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_settings(_args ...rt.PhpVal) &Class_WC_Admin_Settings {
	mut obj := &Class_WC_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tax(_args ...rt.PhpVal) &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_emailimprovements_emailimprovements(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_orderutil(_args ...rt.PhpVal) &Class_OrderUtil {
	mut obj := &Class_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_orders_stats_datastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_roles(_args ...rt.PhpVal) &Class_WP_Roles {
	mut obj := &Class_WP_Roles{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_wccom_connectionhelper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_WCCom_ConnectionHelper {
	mut obj := &Class_Automattic_WooCommerce_Internal_WCCom_ConnectionHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automatic_upgrader_skin(_args ...rt.PhpVal) &Class_Automatic_Upgrader_Skin {
	mut obj := &Class_Automatic_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_upgrader(_args ...rt.PhpVal) &Class_WP_Upgrader {
	mut obj := &Class_WP_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
		code: i64(0)
		file: ''
		line: i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_theme_upgrader(_args ...rt.PhpVal) &Class_Theme_Upgrader {
	mut obj := &Class_Theme_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_gateway_paypal(_args ...rt.PhpVal) &Class_WC_Gateway_Paypal {
	mut obj := &Class_WC_Gateway_Paypal{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_notes_refund_returns(_args ...rt.PhpVal) &Class_WC_Notes_Refund_Returns {
	mut obj := &Class_WC_Notes_Refund_Returns{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Install) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_Install.init()
			return rt.new_null()
		}
		'newly_installed' {
			Class_WC_Install.newly_installed()
			return rt.new_null()
		}
		'check_version' {
			Class_WC_Install.check_version()
			return rt.new_null()
		}
		'manual_database_update' {
			Class_WC_Install.manual_database_update()
			return rt.new_null()
		}
		'wc_admin_db_update_notice' {
			Class_WC_Install.wc_admin_db_update_notice()
			return rt.new_null()
		}
		'add_update_db_notice' {
			Class_WC_Install.add_update_db_notice()
			return rt.new_null()
		}
		'remove_update_db_notice' {
			Class_WC_Install.remove_update_db_notice()
			return rt.new_null()
		}
		'run_manual_database_update' {
			Class_WC_Install.run_manual_database_update()
			return rt.new_null()
		}
		'run_update_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Install.run_update_callback(dispatch_arg_0)
			return rt.new_null()
		}
		'run_update_callback_start' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Install.run_update_callback_start(dispatch_arg_0)
			return rt.new_null()
		}
		'run_update_callback_end' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Install.run_update_callback_end(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'install_actions' {
			Class_WC_Install.install_actions()
			return rt.new_null()
		}
		'install' {
			Class_WC_Install.install()
			return rt.new_null()
		}
		'install_core' {
			Class_WC_Install.install_core()
			return rt.new_null()
		}
		'create_lock' {
			return rt.new_bool(Class_WC_Install.create_lock())
		}
		'release_lock' {
			Class_WC_Install.release_lock()
			return rt.new_null()
		}
		'verify_base_tables' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_WC_Install.verify_base_tables(dispatch_arg_0, dispatch_arg_1)
		}
		'remove_admin_notices' {
			Class_WC_Install.remove_admin_notices()
			return rt.new_null()
		}
		'setup_environment' {
			Class_WC_Install.setup_environment()
			return rt.new_null()
		}
		'is_new_install' {
			return rt.new_bool(Class_WC_Install.is_new_install())
		}
		'needs_db_update' {
			return rt.new_bool(Class_WC_Install.needs_db_update())
		}
		'is_db_auto_update_enabled' {
			return rt.new_bool(Class_WC_Install.is_db_auto_update_enabled())
		}
		'maybe_set_activation_transients' {
			Class_WC_Install.maybe_set_activation_transients()
			return rt.new_null()
		}
		'maybe_update_db_version' {
			Class_WC_Install.maybe_update_db_version()
			return rt.new_null()
		}
		'maybe_set_store_id' {
			Class_WC_Install.maybe_set_store_id()
			return rt.new_null()
		}
		'update_wc_version' {
			Class_WC_Install.update_wc_version()
			return rt.new_null()
		}
		'get_db_update_callbacks' {
			return Class_WC_Install.get_db_update_callbacks()
		}
		'update' {
			Class_WC_Install.update()
			return rt.new_null()
		}
		'update_db_version' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Install.update_db_version(dispatch_arg_0)
			return rt.new_null()
		}
		'cron_schedules' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Install.cron_schedules(dispatch_arg_0)
		}
		'clear_cron_jobs' {
			Class_WC_Install.clear_cron_jobs()
			return rt.new_null()
		}
		'maybe_create_pages' {
			Class_WC_Install.maybe_create_pages()
			return rt.new_null()
		}
		'create_pages' {
			Class_WC_Install.create_pages()
			return rt.new_null()
		}
		'create_options' {
			Class_WC_Install.create_options()
			return rt.new_null()
		}
		'maybe_enable_hpos' {
			Class_WC_Install.maybe_enable_hpos()
			return rt.new_null()
		}
		'add_coming_soon_option' {
			Class_WC_Install.add_coming_soon_option()
			return rt.new_null()
		}
		'enable_email_improvements_for_newly_installed' {
			Class_WC_Install.enable_email_improvements_for_newly_installed()
			return rt.new_null()
		}
		'enable_customer_stock_notifications_signups' {
			Class_WC_Install.enable_customer_stock_notifications_signups()
			return rt.new_null()
		}
		'enable_analytics_scheduled_import' {
			Class_WC_Install.enable_analytics_scheduled_import()
			return rt.new_null()
		}
		'enable_email_improvements_for_existing_merchants' {
			Class_WC_Install.enable_email_improvements_for_existing_merchants()
			return rt.new_null()
		}
		'should_enable_hpos_for_new_shop' {
			return rt.new_bool(Class_WC_Install.should_enable_hpos_for_new_shop())
		}
		'get_order_stats_table_schema' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WC_Install.get_order_stats_table_schema(dispatch_arg_0))
		}
		'delete_obsolete_notes' {
			Class_WC_Install.delete_obsolete_notes()
			return rt.new_null()
		}
		'migrate_options' {
			Class_WC_Install.migrate_options()
			return rt.new_null()
		}
		'create_terms' {
			Class_WC_Install.create_terms()
			return rt.new_null()
		}
		'maybe_install_legacy_api_plugin' {
			Class_WC_Install.maybe_install_legacy_api_plugin()
			return rt.new_null()
		}
		'maybe_activate_legacy_api_enabled_option' {
			Class_WC_Install.maybe_activate_legacy_api_enabled_option()
			return rt.new_null()
		}
		'create_tables' {
			return Class_WC_Install.create_tables()
		}
		'get_schema' {
			return Class_WC_Install.get_schema()
		}
		'get_tables' {
			return Class_WC_Install.get_tables()
		}
		'drop_tables' {
			Class_WC_Install.drop_tables()
			return rt.new_null()
		}
		'wpmu_drop_tables' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Install.wpmu_drop_tables(dispatch_arg_0)
		}
		'create_roles' {
			Class_WC_Install.create_roles()
			return rt.new_null()
		}
		'get_core_capabilities' {
			return Class_WC_Install.get_core_capabilities()
		}
		'remove_roles' {
			Class_WC_Install.remove_roles()
			return rt.new_null()
		}
		'create_files' {
			Class_WC_Install.create_files()
			return rt.new_null()
		}
		'create_placeholder_image' {
			Class_WC_Install.create_placeholder_image()
			return rt.new_null()
		}
		'plugin_action_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Install.plugin_action_links(dispatch_arg_0)
		}
		'plugin_row_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Install.plugin_row_meta(dispatch_arg_0, dispatch_arg_1)
		}
		'associate_plugin_file' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Install.associate_plugin_file(dispatch_arg_0, dispatch_arg_1)
		}
		'background_installer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Install.background_installer(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'remove_mailchimps_redirect' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Install.remove_mailchimps_redirect(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'theme_background_installer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Install.theme_background_installer(dispatch_arg_0)
			return rt.new_null()
		}
		'set_paypal_standard_load_eligibility' {
			Class_WC_Install.set_paypal_standard_load_eligibility()
			return rt.new_null()
		}
		'get_refunds_return_policy_page_content' {
			return rt.new_string(Class_WC_Install.get_refunds_return_policy_page_content())
		}
		'add_admin_note_after_page_created' {
			Class_WC_Install.add_admin_note_after_page_created()
			return rt.new_null()
		}
		'page_created' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Install.page_created(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_cart_block_content' {
			return rt.new_string(Class_WC_Install.get_cart_block_content())
		}
		'get_checkout_block_content' {
			return rt.new_string(Class_WC_Install.get_checkout_block_content())
		}
		else { return none }
	}
}

fn (this &Class_WC_Install) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Install) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Notes_Run_Db_Update) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Notes_Run_Db_Update) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Notes_Run_Db_Update) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Admin_Notices) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Notices) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Notices) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Post_types) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Post_types) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Post_types) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Auth) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Auth) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Auth) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Admin_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailImprovements_EmailImprovements) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Orders_Stats_DataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Roles) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Roles) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Roles) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_WCCom_ConnectionHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_WCCom_ConnectionHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_WCCom_ConnectionHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automatic_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automatic_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automatic_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else { return none }
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' { this.message = (val).str(); return true }
		'code' { this.code = (val).to_i64(); return true }
		'file' { this.file = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Theme_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Theme_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Theme_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Gateway_Paypal) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Gateway_Paypal) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Gateway_Paypal) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Notes_Refund_Returns) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Notes_Refund_Returns) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Notes_Refund_Returns) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

	// unsupported statement: Stmt_GroupUse
	// unsupported statement: Stmt_GroupUse
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
	Class_WC_Install.init()
}
