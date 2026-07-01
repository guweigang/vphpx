import rt

fn wc_admin_update_0201_order_status_index() {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_max_index_length := 191
	mut var_index := rt.call_method(var_wpdb, 'get_row', [rt.concat(rt.concat(rt.new_string('SHOW INDEX FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_stats WHERE key_name = \'status\''))])
	if rt.is_true(rt.call_function('property_exists', [var_index.dup(), rt.new_string('Sub_part')])) {
		if rt.is_true(rt.identical(rt.new_int(var_max_index_length), rt.get_property(var_index, 'Sub_part'))) {
			return rt.new_null()
		}
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('DROP INDEX `status` ON '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_stats'))])
	}
	rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_stats ADD INDEX status (status(%d))')), rt.new_int(var_max_index_length).dup()])])
}

fn wc_admin_update_0230_rename_gross_total() {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_stats DROP COLUMN `total_sales`'))])
	rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_stats CHANGE COLUMN `gross_total` `total_sales` double DEFAULT 0 NOT NULL'))])
}

fn wc_admin_update_0251_remove_unsnooze_action() {
	rt.call_function('as_unschedule_action', [Class_Automattic_WooCommerce_Admin_Notes_Notes.unsnooze_hook(), rt.new_null(), rt.new_string('wc-admin-data')])
	rt.call_function('as_unschedule_action', [Class_Automattic_WooCommerce_Admin_Notes_Notes.unsnooze_hook(), rt.new_null(), rt.new_string('wc-admin-notes')])
	// unsupported statement: Stmt_Nop
}

fn wc_admin_update_110_remove_facebook_note() {
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Notes_Notes{}; return temp.delete_notes_with_name(arg_0) }(rt.new_string('wc-admin-facebook-extension'))
}

fn wc_admin_update_130_remove_dismiss_action_from_tracking_opt_in_note() {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE actions FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_admin_note_actions actions INNER JOIN ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_admin_notes notes USING (note_id) WHERE actions.name = \'tracking-dismiss\' AND notes.name = \'wc-admin-usage-tracking-opt-in\''))])
}

fn wc_admin_update_130_db_version() {
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Installer{}; return temp.update_db_version(arg_0) }(rt.new_string('1.3.0'))
}

fn wc_admin_update_140_db_version() {
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Installer{}; return temp.update_db_version(arg_0) }(rt.new_string('1.4.0'))
}

fn wc_admin_update_160_remove_facebook_note() {
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Notes_Notes{}; return temp.delete_notes_with_name(arg_0) }(rt.new_string('wc-admin-facebook-marketing-expert'))
}

fn wc_admin_update_170_homescreen_layout() {
	rt.call_function('add_option', [rt.new_string('woocommerce_default_homepage_layout'), rt.new_string('two_columns'), rt.new_string(''), rt.new_string('no')])
}

fn wc_admin_update_270_delete_report_downloads() {
	mut var_report_type := rt.new_null()
	mut var_export_id := rt.new_null()
	mut var_upload_dir := rt.call_function('wp_upload_dir', []rt.PhpVal{})
	mut var_base_dir := rt.call_function('trailingslashit', [var_upload_dir.array_get('basedir')])
	mut var_failed_files := rt.new_array()
	mut var_exports_status := rt.call_function('get_option', [Class_Automattic_WooCommerce_Admin_ReportExporter.export_status_option(), rt.new_array()])
	mut var_has_failure := false
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_exports_status.dup().is_array()))))) {
		return rt.new_null()
	}
	{
		mut iter_1 := var_exports_status.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_progress := item_1.val
			mut var_key := item_1.key
			// unsupported assign target: Expr_List
			if rt.is_true(rt.new_bool(!(rt.is_true(var_export_id)))) {
				continue
			}
			mut var_file := "${var_base_dir.to_string()}wc-${var_report_type.to_string()}-report-export-${var_export_id.to_string()}.csv"
			mut var_header := rt.new_string(var_file + '.headers')
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('file_exists', [rt.new_string(var_file).dup()])) && rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('unlink', [rt.new_string(var_file).dup()]))))) {
				var_failed_files.dup().array_push(rt.new_string(var_file).dup())
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('file_exists', [var_header.dup()])) && rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('unlink', [var_header.dup()]))))) {
				var_failed_files.dup().array_push(var_header.dup())
			}
		}
	}
	mut var_potential_exports := rt.call_function('glob', [(var_base_dir).str() + 'wc-*-report-export-*.csv'])
	mut var_reports_pattern := '(revenue|products|variations|orders|categories|coupons|taxes|stock|customers|downloads)'
	{
		mut iter_1 := var_potential_exports.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_potential_export := item_1.val
			mut var_matches := rt.new_array()
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.concat(rt.concat(rt.new_string('/wc-'), rt.new_string(var_reports_pattern)), rt.new_string('-report-export-(?P<export_id>\\d{11,14})\\.csv$/')), var_potential_export.dup(), var_matches.dup()]))))) {
				var_has_failure = true
				continue
			}
			mut var_timestamp := // unsupported expression: Expr_Cast_Int
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_timestamp)))) || rt.is_true(rt.greater(var_timestamp, rt.call_function('time', []rt.PhpVal{}))))) {
				var_has_failure = true
				continue
			}
			if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('unlink', [var_potential_export.dup()]))) {
				var_failed_files.dup().array_push(var_potential_export.dup())
			}
		}
	}
	{
		mut iter_1 := var_failed_files.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_failed_file := item_1.val
			if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('unlink', [var_failed_file.dup()]))) {
				var_has_failure = true
			}
		}
	}
	if var_has_failure {
		fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Notes_UnsecuredReportFiles{}; return temp.possibly_add_note() }()
	}
}

fn wc_admin_update_271_update_task_list_options() {
	mut var_hidden_lists := rt.call_function('get_option', [rt.new_string('woocommerce_task_list_hidden_lists'), rt.new_array()])
	mut var_setup_list_hidden := rt.call_function('get_option', [rt.new_string('woocommerce_task_list_hidden'), rt.new_string('no')])
	mut var_extended_list_hidden := rt.call_function('get_option', [rt.new_string('woocommerce_extended_task_list_hidden'), rt.new_string('no')])
	if rt.is_true(rt.identical(rt.new_string('yes'), var_setup_list_hidden)) {
		var_hidden_lists.array_push('setup')
	}
	if rt.is_true(rt.identical(rt.new_string('yes'), var_extended_list_hidden)) {
		var_hidden_lists.array_push('extended')
	}
	rt.call_function('update_option', [rt.new_string('woocommerce_task_list_hidden_lists'), rt.call_function('array_unique', [var_hidden_lists.dup()])])
	rt.call_function('delete_option', [rt.new_string('woocommerce_task_list_hidden')])
	rt.call_function('delete_option', [rt.new_string('woocommerce_extended_task_list_hidden')])
}

fn wc_admin_update_280_order_status() {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_stats refunds\n\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_stats orders\n\t\t\tON orders.order_id = refunds.parent_id\n\t\tSET refunds.status = orders.status\n\t\tWHERE refunds.parent_id != 0'))])
}

fn wc_admin_update_290_update_apperance_task_option() {
	mut var_is_actioned := rt.call_function('get_option', [rt.new_string('woocommerce_task_list_appearance_complete'), rt.new_bool(false)])
	mut var_task := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}; return temp.get_task(arg_0) }(rt.new_string('appearance'))
	if rt.is_true(rt.new_bool(rt.is_true(var_task) && rt.is_true(var_is_actioned))) {
		rt.call_method(var_task, 'mark_actioned', []rt.PhpVal{})
	}
	rt.call_function('delete_option', [rt.new_string('woocommerce_task_list_appearance_complete')])
}

fn wc_admin_update_290_delete_default_homepage_layout_option() {
	rt.call_function('delete_option', [rt.new_string('woocommerce_default_homepage_layout')])
}

fn wc_admin_update_300_update_is_read_from_last_read() {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_meta_key := 'woocommerce_admin_activity_panel_inbox_last_read'
	mut var_users := rt.call_function('get_users', [rt.new_string("meta_key=${var_meta_key}&orderby=${var_meta_key}&fields=all_with_meta&number=1")])
	if rt.is_true(rt.new_int(var_users.dup().array_count())) {
		mut var_last_read := rt.get_property(rt.call_function('current', [var_users.dup()]), '{"nodeType":"Expr_Variable","line":257,"name":"meta_key"}')
		mut var_date_in_utc := rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), var_last_read.dup().to_i64() / 1000])
		rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('\n\t\t\t\tupdate '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_admin_notes set is_read = 1\n\t\t\t\twhere\n\t\t\t\tdate_created <= %s')), var_date_in_utc.dup()])])
		rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('delete from '), rt.get_property(var_wpdb, 'usermeta')), rt.new_string(' where meta_key=%s')), rt.new_string(var_meta_key).dup()])])
	}
}

fn wc_admin_update_340_remove_is_primary_from_note_action() {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_admin_note_actions DROP COLUMN `is_primary`'))])
}

fn wc_update_670_delete_deprecated_remote_inbox_notifications_option() {
	rt.call_function('delete_option', [rt.new_string('wc_remote_inbox_notifications_specs')])
}

fn wc_update_1040_add_idx_date_paid_status_parent() {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_index_exists := rt.call_method(var_wpdb, 'get_row', [rt.concat(rt.concat(rt.new_string('SHOW INDEX FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_stats WHERE key_name = \'idx_date_paid_status_parent\''))])
	if rt.is_true(rt.new_bool(var_index_exists.dup().is_null())) {
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_stats ADD INDEX idx_date_paid_status_parent (date_paid, status, parent_id)'))])
	}
}

fn wc_update_1050_add_idx_user_email() {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_index_exists := rt.call_method(, 'get_row', [])
	if rt.is_true(rt.new_bool(.dup().is_null())) {
		
	}
}

struct Class_Automattic_WooCommerce_Admin_Notes_Notes {
	rt.PhpObjectBase
}

struct Class_Installer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_UnsecuredReportFiles {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_notes_notes() &Class_Automattic_WooCommerce_Admin_Notes_Notes {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Notes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_installer() &Class_Installer {
	mut obj := &Class_Installer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_notes_unsecuredreportfiles() &Class_Automattic_WooCommerce_Internal_Admin_Notes_UnsecuredReportFiles {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_UnsecuredReportFiles{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasklists() &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Installer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Installer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Installer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_UnsecuredReportFiles) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_UnsecuredReportFiles) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_UnsecuredReportFiles) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_react_admin_wc_admin_update_functions_php() {
}
