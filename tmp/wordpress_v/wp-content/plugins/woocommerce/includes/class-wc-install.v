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
pub mut:
		db_updates rt.PhpVal = rt.new_array()
}

fn Class_WC_Install.init()  {
	mut var_GLOBALS := rt.new_null()
	if !(!rt.is_true(var_GLOBALS.array_get('wc_uninstalling_plugin'))) {
		return rt.new_null()
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
	rt.call_function('add_filter', ['plugin_action_links_' + (rt.get_constant('WC_PLUGIN_BASENAME')).str(), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'plugin_action_links' }])])
	rt.call_function('add_filter', [rt.new_string('plugin_row_meta'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'plugin_row_meta' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('wpmu_drop_tables'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'wpmu_drop_tables' }])])
	rt.call_function('add_filter', [rt.new_string('cron_schedules'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'cron_schedules' }])])
	rt.call_function('add_action', [rt.new_string('admin_init'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'newly_installed' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_activate_legacy_rest_api_plugin'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'maybe_install_legacy_api_plugin' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_get_note_from_db'), rt.create_array([rt.ArrayItem{ key: none, val: Class_WC_Notes_Run_Db_Update.class() }, rt.ArrayItem{ key: none, val: 'maybe_update_notice' }]), rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('woocommerce_hide_update_notice'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'remove_update_db_notice' }])])
}

fn Class_WC_Install.newly_installed()  {
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [Class_WC_Install.newly_installed_option(), rt.new_bool(false)]))) {
		rt.call_function('do_action', [rt.new_string('woocommerce_newly_installed')])
		rt.call_function('do_action_deprecated', [rt.new_string('woocommerce_admin_newly_installed'), rt.new_array(), rt.new_string('6.5.0'), rt.new_string('woocommerce_newly_installed')])
		rt.call_function('update_option', [Class_WC_Install.newly_installed_option(), rt.new_string('no')])
		rt.call_function('add_option', [Class_WC_Install.initial_installed_version(), rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version'), rt.new_string(''), rt.new_bool(false)])
	}
}

fn Class_WC_Install.check_version()  {
	mut var_wc_version := rt.call_function('get_option', [rt.new_string('woocommerce_version')])
	mut var_wc_code_version := rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version')
	mut var_requires_update := rt.call_function('version_compare', [var_wc_version.dup(), var_wc_code_version.dup(), rt.new_string('<')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_defined(arg_0) }(rt.new_string('IFRAME_REQUEST')))))) && rt.is_true(var_requires_update))) {
		Class_WC_Install.install()
		rt.call_function('do_action', [rt.new_string('woocommerce_updated')])
		rt.call_function('do_action_deprecated', [rt.new_string('woocommerce_admin_updated'), rt.new_array(), var_wc_code_version.dup(), rt.new_string('woocommerce_updated')])
	}
}

fn Class_WC_Install.manual_database_update()  {
	mut var_blog_id := rt.call_function('get_current_blog_id', []rt.PhpVal{})
	rt.call_function('add_action', ['wp_' + (var_blog_id).str() + '_wc_updater_cron', rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'run_manual_database_update' }])])
}

fn Class_WC_Install.wc_admin_db_update_notice()  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_wc_admin_active', []rt.PhpVal{})) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		create_wc_notes_run_db_update()
	}
}

fn Class_WC_Install.add_update_db_notice()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Admin_Notices{}; return temp.has_notice(arg_0) }(rt.new_string('update')))))) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Admin_Notices{}; return temp.add_notice(arg_0, arg_1) }(rt.new_string('update'), rt.new_bool(true))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_wc_admin_active', []rt.PhpVal{})) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		fn () rt.PhpVal { mut temp := Class_WC_Notes_Run_Db_Update{}; return temp.add_notice() }()
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', ['Error adding db update note: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-updater' }])])
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
}

fn Class_WC_Install.remove_update_db_notice()  {
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Admin_Notices{}; return temp.has_notice(arg_0) }(rt.new_string('update'))) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Admin_Notices{}; return temp.remove_notice(arg_0, arg_1) }(rt.new_string('update'), rt.new_bool(true))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_wc_admin_active', []rt.PhpVal{})) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		fn () rt.PhpVal { mut temp := Class_WC_Notes_Run_Db_Update{}; return temp.set_notice_actioned() }()
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.dup()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', ['Error removing db update note: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-updater' }])])
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
}

fn Class_WC_Install.run_manual_database_update()  {
	Class_WC_Install.update()
}

fn Class_WC_Install.run_update_callback(var_update_callback rt.PhpVal)  {
	rt.include_file(@DIR + '/wc-update-functions.php', '2')
	if rt.is_true(rt.call_function('is_callable', [var_update_callback.dup()])) {
		Class_WC_Install.run_update_callback_start(var_update_callback.dup())
		mut var_result := // unsupported expression: Expr_Cast_Bool
		Class_WC_Install.run_update_callback_end(var_update_callback.dup(), var_result.dup())
	}
}

fn Class_WC_Install.run_update_callback_start(var_callback rt.PhpVal)  {
	mut var_callback_mutated := var_callback
	rt.call_function('wc_maybe_define_constant', [rt.new_string('WC_UPDATING'), rt.new_bool(true)])
}

fn Class_WC_Install.run_update_callback_end(var_callback rt.PhpVal, var_result rt.PhpVal)  {
	mut var_callback_mutated := var_callback
	mut var_result_mutated := var_result
	if rt.is_true(var_result_mutated) {
		rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{}), 'add', [rt.new_string('woocommerce_run_update_callback'), rt.create_array([rt.ArrayItem{ key: 'update_callback', val: var_callback_mutated }]), rt.new_string('woocommerce-db-updates')])
	}
}

fn Class_WC_Install.install_actions()  {
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get('do_update_woocommerce'))) {
		rt.call_function('check_admin_referer', [rt.new_string('wc_db_update'), rt.new_string('wc_db_update_nonce')])
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'info', [rt.new_string('Manual database update triggered.'), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-updater' }])])
		Class_WC_Install.update()
		Class_WC_Install.add_update_db_notice()
		mut var_return_url := if !(rt.get_superglobal('_GET').array_get('return_url')).is_null() { rt.get_superglobal('_GET').array_get('return_url') } else { rt.new_string('') }
		if !(!rt.is_true(var_return_url)) {
			if rt.is_true(rt.identical(rt.new_string('wc-admin-referer'), var_return_url)) {
				var_return_url = rt.call_function('preg_replace', ['/^' + (rt.call_function('preg_quote', [rt.call_function('untrailingslashit', [rt.call_function('admin_url', []rt.PhpVal{})]), rt.new_string('/')])).str() + '\\/?/i', rt.new_string(''), if rt.is_true(rt.call_function('wp_get_referer', []rt.PhpVal{})) { rt.call_function('wp_get_referer', []rt.PhpVal{}) } else { rt.new_string('') }])
				if rt.is_true(rt.new_bool(rt.is_true(var_return_url) && rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_return_url.dup(), rt.new_string('do_update_woocommerce')]))))) {
					var_return_url = rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: '_wpnonce' }, rt.ArrayItem{ key: none, val: '_wc_notice_nonce' }, rt.ArrayItem{ key: none, val: 'wc_db_update' }, rt.ArrayItem{ key: none, val: 'wc_db_update_nonce' }, rt.ArrayItem{ key: none, val: 'wc-hide-notice' }]), rt.call_function('admin_url', [var_return_url.dup()])])
				} else {
					var_return_url = rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings')])
				}
			}
			var_return_url = rt.call_function('esc_url_raw', [rt.call_function('wp_unslash', [var_return_url.dup()])])
			rt.call_function('wp_safe_redirect', [var_return_url.dup()])
			// unsupported expression: Expr_Exit
		}
	}
}

fn Class_WC_Install.install()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_blog_installed', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Install.create_lock())))) {
		return rt.new_null()
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

fn Class_WC_Install.install_core()  {
	if rt.is_true(rt.new_bool(rt.is_true(Class_WC_Install.is_new_install()) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [Class_WC_Install.newly_installed_option(), rt.new_bool(false)]))))))) {
		rt.call_function('update_option', [Class_WC_Install.newly_installed_option(), rt.new_string('yes')])
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
	
}

fn Class_WC_Install.create_lock() bool {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_Install.release_lock()  {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_Install.verify_base_tables(modify_notice bool, execute bool) rt.PhpVal {
}

fn Class_WC_Install.remove_admin_notices()  {
}

fn Class_WC_Install.setup_environment()  {
}

fn Class_WC_Install.is_new_install() bool {
}

fn Class_WC_Install.needs_db_update() bool {
}

fn Class_WC_Install.is_db_auto_update_enabled() bool {
}

fn Class_WC_Install.maybe_set_activation_transients()  {
}

fn Class_WC_Install.maybe_update_db_version()  {
}

fn Class_WC_Install.maybe_set_store_id()  {
}

fn Class_WC_Install.update_wc_version()  {
}

fn Class_WC_Install.get_db_update_callbacks() rt.PhpVal {
}

fn Class_WC_Install.update()  {
}

fn Class_WC_Install.update_db_version(var_version rt.PhpVal)  {
	mut var_version_mutated := var_version
}

fn Class_WC_Install.cron_schedules(var_schedules rt.PhpVal) rt.PhpVal {
	mut var_schedules_mutated := var_schedules
}

fn Class_WC_Install.clear_cron_jobs()  {
}

fn Class_WC_Install.maybe_create_pages()  {
}

fn Class_WC_Install.create_pages()  {
}

fn Class_WC_Install.create_options()  {
}

fn Class_WC_Install.maybe_enable_hpos()  {
}

fn Class_WC_Install.add_coming_soon_option()  {
}

fn Class_WC_Install.enable_email_improvements_for_newly_installed()  {
}

fn Class_WC_Install.enable_customer_stock_notifications_signups()  {
}

fn Class_WC_Install.enable_analytics_scheduled_import()  {
}

fn Class_WC_Install.enable_email_improvements_for_existing_merchants()  {
}

fn Class_WC_Install.should_enable_hpos_for_new_shop() bool {
}

fn Class_WC_Install.get_order_stats_table_schema(var_collate rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	mut var_collate_mutated := var_collate
}

fn Class_WC_Install.delete_obsolete_notes()  {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_Install.migrate_options()  {
}

fn Class_WC_Install.create_terms()  {
}

fn Class_WC_Install.maybe_install_legacy_api_plugin()  {
}

fn Class_WC_Install.maybe_activate_legacy_api_enabled_option()  {
}

fn Class_WC_Install.create_tables() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_Install.get_schema() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_Install.get_tables() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_Install.drop_tables()  {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_Install.wpmu_drop_tables(var_tables rt.PhpVal) rt.PhpVal {
	mut var_tables_mutated := var_tables
}

fn Class_WC_Install.create_roles()  {
}

fn Class_WC_Install.get_core_capabilities() rt.PhpVal {
}

fn Class_WC_Install.remove_roles()  {
}

fn Class_WC_Install.create_files()  {
}

fn Class_WC_Install.create_placeholder_image()  {
}

fn Class_WC_Install.plugin_action_links(var_links rt.PhpVal) rt.PhpVal {
}

fn Class_WC_Install.plugin_row_meta(var_links rt.PhpVal, var_file rt.PhpVal) rt.PhpVal {
}

fn Class_WC_Install.associate_plugin_file(var_plugins rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut var_plugins_mutated := var_plugins
}

fn Class_WC_Install.background_installer(var_plugin_to_install_id rt.PhpVal, var_plugin_to_install rt.PhpVal)  {
}

fn Class_WC_Install.remove_mailchimps_redirect(var_option rt.PhpVal, var_value rt.PhpVal)  {
}

fn Class_WC_Install.theme_background_installer(var_theme_slug rt.PhpVal)  {
}

fn Class_WC_Install.set_paypal_standard_load_eligibility()  {
}

fn Class_WC_Install.get_refunds_return_policy_page_content() string {
}

fn Class_WC_Install.add_admin_note_after_page_created()  {
}

fn Class_WC_Install.page_created(var_page_id rt.PhpVal, var_page_data rt.PhpVal)  {
	mut var_page_id_mutated := var_page_id
}

fn Class_WC_Install.get_cart_block_content() string {
}

fn Class_WC_Install.get_checkout_block_content() string {
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

fn create_wc_install() &Class_WC_Install {
	mut obj := &Class_WC_Install{
		PhpObjectBase: rt.PhpObjectBase{}
		db_updates: rt.new_array()
	}
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_notes_run_db_update() &Class_WC_Notes_Run_Db_Update {
	mut obj := &Class_WC_Notes_Run_Db_Update{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_notices() &Class_WC_Admin_Notices {
	mut obj := &Class_WC_Admin_Notices{
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
	match prop_name {
		'db_updates' { return this.db_updates }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Install) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'db_updates' { this.db_updates = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_class_wc_install_php() {
	// unsupported statement: Stmt_GroupUse
	// unsupported statement: Stmt_GroupUse
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
