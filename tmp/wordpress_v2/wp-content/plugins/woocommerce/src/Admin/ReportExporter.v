import rt

pub fn Class_Automattic_WooCommerce_Admin_ReportExporter.export_status_option() string {
	return 'woocommerce_admin_report_export_status'
}

pub fn Class_Automattic_WooCommerce_Admin_ReportExporter.download_export_action() string {
	return 'woocommerce_admin_download_report_csv'
}

struct Class_Automattic_WooCommerce_Admin_ReportExporter {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_reportexporter() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_ReportExporter', 'name',
		rt.new_string('report_exporter'))
}

fn Class_Automattic_WooCommerce_Admin_ReportExporter.get_scheduler_actions() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'export_report', val: 'woocommerce_admin_report_export' },
		rt.ArrayItem{
			key: 'email_report_download_link'
			val: 'woocommerce_admin_email_report_download_link'
		},
	])
}

fn Class_Automattic_WooCommerce_Admin_ReportExporter.get_dependencies() rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_ReportExporter{}
	mut iife_result_0 := iife_temp_0.get_action(rt.new_string('export_report'))
	return rt.create_array([
		rt.ArrayItem{ key: 'email_report_download_link', val: iife_result_0 },
	])
}

fn Class_Automattic_WooCommerce_Admin_ReportExporter.init() {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_ReportExporter{}
	mut iife_result_1 := iife_temp_1.scheduler_init()
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'download_export_file' }])])
}

fn Class_Automattic_WooCommerce_Admin_ReportExporter.queue_report_export(var_export_id rt.PhpVal, var_report_type rt.PhpVal, var_report_args rt.PhpVal, send_email bool) rt.PhpVal {
	mut var_report_args_mutated := var_report_args
	mut var_exporter := create_automattic_woocommerce_admin_reportcsvexporter(var_report_type.clone(),
		var_report_args_mutated.clone())
	var_exporter.prepare_data_to_export()
	mut var_total_rows := var_exporter.get_total_rows()
	mut var_batch_size := var_exporter.get_limit()
	mut var_num_batches := rt.new_int((rt.call_function('ceil', [
		rt.div(var_total_rows, var_batch_size),
	])).to_i64())
	mut var_report_batch_args := rt.create_array([
		rt.ArrayItem{ key: none, val: var_export_id },
		rt.ArrayItem{ key: none, val: var_report_type },
		rt.ArrayItem{ key: none, val: var_report_args_mutated },
	])
	if rt.is_true(rt.less(rt.new_int(0), var_num_batches)) {
		mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_ReportExporter{}
		mut iife_result_2 := iife_temp_2.queue_batches(rt.new_int(1), var_num_batches.clone(),
			rt.new_string('export_report'), var_report_batch_args.clone())
		if var_send_email {
			mut var_email_action_args := rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('get_current_user_id', []rt.PhpVal{}) },
				rt.ArrayItem{ key: none, val: var_export_id },
				rt.ArrayItem{ key: none, val: var_report_type },
			])
			mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_ReportExporter{}
			mut iife_result_3 := iife_temp_3.schedule_action(rt.new_string('email_report_download_link'),
				var_email_action_args.clone())
		}
	}
	return var_total_rows.clone()
}

fn Class_Automattic_WooCommerce_Admin_ReportExporter.export_report(var_page_number rt.PhpVal, var_export_id rt.PhpVal, var_report_type rt.PhpVal, var_report_args rt.PhpVal) {
	mut var_report_args_mutated := var_report_args
	var_report_args_mutated.array_set('page', var_page_number.clone())
	mut var_exporter := create_automattic_woocommerce_admin_reportcsvexporter(var_report_type.clone(),
		var_report_args_mutated.clone())
	var_exporter.set_filename(rt.new_string('wc-${var_report_type.to_string()}-report-export-${var_export_id.to_string()}'))
	var_exporter.generate_file()
	Class_Automattic_WooCommerce_Admin_ReportExporter.update_export_percentage_complete(var_report_type.clone(),
		var_export_id.clone(), var_exporter.get_percent_complete())
}

fn Class_Automattic_WooCommerce_Admin_ReportExporter.get_status_key(var_report_type rt.PhpVal, var_export_id rt.PhpVal) string {
	return var_report_type.str() + ':' + var_export_id.str()
}

fn Class_Automattic_WooCommerce_Admin_ReportExporter.update_export_percentage_complete(var_report_type rt.PhpVal, var_export_id rt.PhpVal, var_percentage rt.PhpVal) {
	mut var_exports_status := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Admin_Automattic_WooCommerce_Admin_ReportExporter.export_status_option(),
		rt.new_array(),
	])
	mut var_status_key := Class_Automattic_WooCommerce_Admin_ReportExporter.get_status_key(var_report_type.clone(),
		var_export_id.clone())
	var_exports_status.array_set(var_status_key, var_percentage.clone())
	rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Admin_Automattic_WooCommerce_Admin_ReportExporter.export_status_option(),
		var_exports_status.clone(),
	])
}

fn Class_Automattic_WooCommerce_Admin_ReportExporter.get_export_percentage_complete(var_report_type rt.PhpVal, var_export_id rt.PhpVal) bool {
	mut var_exports_status := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Admin_Automattic_WooCommerce_Admin_ReportExporter.export_status_option(),
		rt.new_array(),
	])
	mut var_status_key := Class_Automattic_WooCommerce_Admin_ReportExporter.get_status_key(var_report_type.clone(),
		var_export_id.clone())
	if var_exports_status.array_isset(var_status_key) {
		return (var_exports_status.array_get(var_status_key)).to_bool()
	}
	return false
}

fn Class_Automattic_WooCommerce_Admin_ReportExporter.download_export_file() {
	if rt.get_superglobal('_GET').array_isset(rt.new_string('action'))
		&& !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('filename'))))
		&& rt.is_true(rt.identical(Class_Automattic_WooCommerce_Admin_Automattic_WooCommerce_Admin_ReportExporter.download_export_action(), rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('action'))])))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('view_woocommerce_reports')])) {
		mut var_exporter := create_automattic_woocommerce_admin_reportcsvexporter()
		var_exporter.set_filename(rt.call_function('wp_unslash', [
			rt.get_superglobal('_GET').array_get(rt.new_string('filename')),
		]))
		var_exporter.export()
	}
}

fn Class_Automattic_WooCommerce_Admin_ReportExporter.email_report_download_link(var_user_id rt.PhpVal, var_export_id rt.PhpVal, var_report_type rt.PhpVal) {
	mut var_percent_complete := Class_Automattic_WooCommerce_Admin_ReportExporter.get_export_percentage_complete(var_report_type.clone(),
		var_export_id.clone())
	if rt.is_true(rt.identical(rt.new_int(100), var_percent_complete)) {
		mut var_query_args := rt.create_array([
			rt.ArrayItem{
				key: 'action'
				val: Class_Automattic_WooCommerce_Admin_Automattic_WooCommerce_Admin_ReportExporter.download_export_action()
			},
			rt.ArrayItem{
				key: 'filename'
				val: 'wc-${var_report_type.to_string()}-report-export-${var_export_id.to_string()}'
			},
		])
		mut var_download_url := rt.call_function('add_query_arg', [
			var_query_args.clone(), rt.call_function('admin_url', []rt.PhpVal{})])
		mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_WC_Emails{}
		mut iife_result_4 := iife_temp_4.instance()
		mut var_email := create_automattic_woocommerce_admin_reportcsvemail()
		var_email.trigger(var_user_id.clone(), var_report_type.clone(), var_download_url.clone())
	}
}

struct Class_Automattic_WooCommerce_Admin_ReportCSVExporter {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_WC_Emails {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_ReportCSVEmail {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_reportexporter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_ReportExporter {
	mut obj := &Class_Automattic_WooCommerce_Admin_ReportExporter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_reportcsvexporter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_ReportCSVExporter {
	mut obj := &Class_Automattic_WooCommerce_Admin_ReportCSVExporter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_wc_emails(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_WC_Emails {
	mut obj := &Class_Automattic_WooCommerce_Admin_WC_Emails{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_reportcsvemail(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_ReportCSVEmail {
	mut obj := &Class_Automattic_WooCommerce_Admin_ReportCSVEmail{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportExporter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_scheduler_actions' {
			return Class_Automattic_WooCommerce_Admin_ReportExporter.get_scheduler_actions()
		}
		'get_dependencies' {
			return Class_Automattic_WooCommerce_Admin_ReportExporter.get_dependencies()
		}
		'init' {
			Class_Automattic_WooCommerce_Admin_ReportExporter.init()
			return rt.new_null()
		}
		'queue_report_export' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_Admin_ReportExporter.queue_report_export(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'export_report' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_ReportExporter.export_report(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'get_status_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Admin_ReportExporter.get_status_key(dispatch_arg_0,
				dispatch_arg_1))
		}
		'update_export_percentage_complete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_ReportExporter.update_export_percentage_complete(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_export_percentage_complete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_ReportExporter.get_export_percentage_complete(dispatch_arg_0,
				dispatch_arg_1))
		}
		'download_export_file' {
			Class_Automattic_WooCommerce_Admin_ReportExporter.download_export_file()
			return rt.new_null()
		}
		'email_report_download_link' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_ReportExporter.email_report_download_link(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_ReportExporter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportExporter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVExporter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_ReportCSVExporter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVExporter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_WC_Emails) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_WC_Emails) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_WC_Emails) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVEmail) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_ReportCSVEmail) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVEmail) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
