import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Export_Controller {
	rt.PhpObjectBase
pub mut:
	rest_base rt.PhpVal = rt.new_string('reports/(?P<type>[a-z]+)/export')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Export_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Export_Controller', [
			'Automattic_WooCommerce_Admin_API_Reports_Export_Automattic_WooCommerce_Admin_API_Reports_Controller',
		], &this), 'namespace'),
		rt.new_string('/' + (this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_Reports_Export_WP_REST_Server.editable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Export_Controller', [
						'Automattic_WooCommerce_Admin_API_Reports_Export_Automattic_WooCommerce_Admin_API_Reports_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'export_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Export_Controller', [
						'Automattic_WooCommerce_Admin_API_Reports_Export_Automattic_WooCommerce_Admin_API_Reports_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_export_collection_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Export_Controller', [
					'Automattic_WooCommerce_Admin_API_Reports_Export_Automattic_WooCommerce_Admin_API_Reports_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_export_public_schema' },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Export_Controller', [
			'Automattic_WooCommerce_Admin_API_Reports_Export_Automattic_WooCommerce_Admin_API_Reports_Controller',
		], &this), 'namespace'),
		rt.new_string('/' + (this.rest_base).str() + '/(?P<export_id>[a-z0-9]+)/status'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_Reports_Export_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Export_Controller', [
						'Automattic_WooCommerce_Admin_API_Reports_Export_Automattic_WooCommerce_Admin_API_Reports_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'export_status' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Export_Controller', [
						'Automattic_WooCommerce_Admin_API_Reports_Export_Automattic_WooCommerce_Admin_API_Reports_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Export_Controller', [
					'Automattic_WooCommerce_Admin_API_Reports_Export_Automattic_WooCommerce_Admin_API_Reports_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_export_status_public_schema' },
			]) },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Export_Controller) get_export_collection_params() rt.PhpVal {
	mut var_params := rt.new_array()
	var_params.array_set('report_args', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Parameters to pass on to the exported report.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('email', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('When true, email a link to download the export to the requesting user.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'boolean' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	return var_params.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Export_Controller) get_export_public_schema() rt.PhpVal {
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'report_export' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Export status.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'message', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Export status message.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'export_id', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Export ID.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
		]) },
	])
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Export_Controller) get_export_status_public_schema() rt.PhpVal {
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'report_export_status' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'percent_complete', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Percentage complete.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'int' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'download_url', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Export download URL.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
		]) },
	])
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Export_Controller) export_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_report_type := var_request.array_get(rt.new_string('type'))
	mut var_report_args := if !rt.is_true(var_request.array_get(rt.new_string('report_args'))) {
		rt.new_array()
	} else {
		var_request.array_get(rt.new_string('report_args'))
	}
	mut var_send_email := if var_request.array_isset(rt.new_string('email')) {
		var_request.array_get(rt.new_string('email'))
	} else {
		rt.new_bool(false)
	}
	mut var_default_export_id := rt.call_function('str_replace', [
		rt.new_string('.'), rt.new_string(''), rt.call_function('microtime', [
			rt.new_bool(true),
		])])
	mut var_export_id := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_export_id'),
		var_default_export_id.clone(),
	])
	var_export_id = rt.new_string((rt.call_function('sanitize_file_name', [
		var_export_id.clone()])).str())
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_ReportExporter{}
	mut iife_result_0 := iife_temp_0.queue_report_export(var_export_id.clone(),
		var_report_type.clone(), var_report_args.clone(), var_send_email.clone())
	mut var_total_rows := iife_result_0
	if rt.is_true(rt.identical(rt.new_int(0), var_total_rows)) {
		return rt.call_function('rest_ensure_response', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('There is no data to export for the given request.'),
					rt.new_string('woocommerce'),
				]) },
			]),
		])
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_ReportExporter{}
	mut iife_result_1 := iife_temp_1.update_export_percentage_complete(var_report_type.clone(),
		var_export_id.clone(), rt.new_int(0))
	mut var_response := rt.call_function('rest_ensure_response', [
		rt.create_array([
			rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
				rt.new_string('Your report file is being generated.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'export_id', val: var_export_id },
		]),
	])
	rt.call_method(var_response, 'add_links', [
		rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.create_array([
				rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
					rt.call_function('sprintf', [
						rt.new_string('%s/reports/%s/export/%s/status'),
						rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Export_Controller', [
							'Automattic_WooCommerce_Admin_API_Reports_Export_Automattic_WooCommerce_Admin_API_Reports_Controller',
						], &this), 'namespace'),
						var_report_type.clone(),
						var_export_id.clone(),
					]),
				]) },
			]) },
		]),
	])
	mut var_data := this.prepare_response_for_collection(var_response.clone())
	return rt.call_function('rest_ensure_response', [var_data.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Export_Controller) export_status(var_request rt.PhpVal) rt.PhpVal {
	mut var_report_type := var_request.array_get(rt.new_string('type'))
	mut var_export_id := var_request.array_get(rt.new_string('export_id'))
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_ReportExporter{}
	mut iife_result_2 := iife_temp_2.get_export_percentage_complete(var_report_type.clone(),
		var_export_id.clone())
	mut var_percentage := iife_result_2
	if rt.is_true(rt.identical(rt.new_bool(false), var_percentage)) {
		return rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Export_WP_Error',
			[]string{}, create_automattic_woocommerce_admin_api_reports_export_wp_error(rt.new_string('woocommerce_admin_reports_export_invalid_id'), rt.call_function('__', [
			rt.new_string('Sorry, there is no export with that ID.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'percent_complete', val: var_percentage },
	])
	if rt.is_true(rt.identical(rt.new_int(100), var_percentage)) {
		mut var_query_args := rt.create_array([
			rt.ArrayItem{
				key: 'action'
				val: Class_Automattic_WooCommerce_Admin_ReportExporter.download_export_action()
			},
			rt.ArrayItem{
				key: 'filename'
				val: 'wc-${var_report_type.to_string()}-report-export-${var_export_id.to_string()}'
			},
		])
		var_result.array_set('download_url', rt.call_function('add_query_arg', [
			var_query_args.clone(),
			rt.call_function('admin_url', []rt.PhpVal{}),
		]))
	}
	mut var_response := rt.call_function('rest_ensure_response', [
		var_result.clone()])
	rt.call_method(var_response, 'add_links', [
		rt.create_array([
			rt.ArrayItem{ key: 'self', val: rt.create_array([
				rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
					rt.call_function('sprintf', [
						rt.new_string('%s/reports/%s/export/%s/status'),
						rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Export_Controller', [
							'Automattic_WooCommerce_Admin_API_Reports_Export_Automattic_WooCommerce_Admin_API_Reports_Controller',
						], &this), 'namespace'),
						var_report_type.clone(),
						var_export_id.clone(),
					]),
				]) },
			]) },
		]),
	])
	mut var_data := this.prepare_response_for_collection(var_response.clone())
	return rt.call_function('rest_ensure_response', [var_data.clone()])
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Export_Automattic_WooCommerce_Admin_API_Reports_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_ReportExporter {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Export_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_export_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Export_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Export_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base:     rt.new_string('reports/(?P<type>[a-z]+)/export')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_export_automattic_woocommerce_admin_api_reports_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Export_Automattic_WooCommerce_Admin_API_Reports_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Export_Automattic_WooCommerce_Admin_API_Reports_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_reportexporter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_ReportExporter {
	mut obj := &Class_Automattic_WooCommerce_Admin_ReportExporter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_export_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Export_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Export_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Export_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_export_collection_params' {
			return this.get_export_collection_params()
		}
		'get_export_public_schema' {
			return this.get_export_public_schema()
		}
		'get_export_status_public_schema' {
			return this.get_export_status_public_schema()
		}
		'export_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.export_items(dispatch_arg_0)
		}
		'export_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.export_status(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Export_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Export_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' {
			this.rest_base = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Export_Automattic_WooCommerce_Admin_API_Reports_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Export_Automattic_WooCommerce_Admin_API_Reports_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Export_Automattic_WooCommerce_Admin_API_Reports_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportExporter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_ReportExporter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportExporter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Export_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Export_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Export_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
