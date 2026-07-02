import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Controller {
	rt.PhpObjectBase
pub mut:
	rest_base rt.PhpVal = rt.new_string('reports/downloads')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Controller) get_datastore_data(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query := create_automattic_woocommerce_admin_api_reports_genericquery(var_query_args.clone(),
		rt.new_string('downloads'))
	return var_query.get_data()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Controller) prepare_item_for_response(var_report rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_response := this.Class_Automattic_WooCommerce_Admin_API_Reports_GenericController.prepare_item_for_response(var_report.clone(),
		var_request.clone())
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_report.clone())])
	rt.get_property(var_response, 'data').array_set('date', rt.call_function('get_date_from_gmt', [
		var_report.array_get(rt.new_string('date_gmt')),
		rt.new_string('Y-m-d H:i:s'),
	]))
	mut var_product_id := rt.new_int(var_report.array_get(rt.new_string('product_id')).to_i64())
	mut var__product := rt.call_function('wc_get_product', [var_product_id.clone()])
	if rt.is_true(var__product) {
		mut var_file_path := rt.call_method(var__product, 'get_file_download_path', [
			var_report.array_get(rt.new_string('download_id')),
		])
		mut var_filename := rt.call_function('basename', [var_file_path.clone()])
		rt.get_property(var_response, 'data').array_set('file_name', rt.call_function('apply_filters', [
			rt.new_string('woocommerce_file_download_filename'),
			var_filename.clone(),
			var_product_id.clone(),
		]))
		rt.get_property(var_response, 'data').array_set('file_path', var_file_path.clone())
	} else {
		rt.get_property(var_response, 'data').array_set('file_name', '')
		rt.get_property(var_response, 'data').array_set('file_path', '')
	}
	mut var_customer :=
		create_automattic_woocommerce_admin_api_reports_downloads_wc_customer(var_report.array_get(rt.new_string('user_id')))
	rt.get_property(var_response, 'data').array_set('username', var_customer.get_username())
	rt.get_property(var_response, 'data').array_set('order_number',
		this.get_order_number(var_report.array_get(rt.new_string('order_id'))))
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_prepare_report_downloads'),
		var_response.clone(),
		var_report.clone(),
		var_request.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Controller) prepare_links(var_object rt.PhpVal) rt.PhpVal {
	mut var_links := rt.create_array([
		rt.ArrayItem{ key: 'product', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'),
					rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Downloads_Controller', [
						'Automattic_WooCommerce_Admin_API_Reports_GenericController',
						'ExportableInterface',
					], &this), 'namespace'),
					rt.new_string('products'), var_object.array_get(rt.new_string('product_id'))]),
			]) },
			rt.ArrayItem{ key: 'embeddable', val: true },
		]) },
	])
	return var_links.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Controller) prepare_reports_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := rt.new_array()
	mut var_registered := rt.func_array_keys(this.get_collection_params())
	mut iter_1 := var_registered.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_param_name := item_1.val
		if var_request.array_isset(var_param_name) {
			var_args.array_set(var_param_name, var_request.array_get(var_param_name))
		}
	}
	return var_args.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'report_downloads' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('ID.'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: 'product_id', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Product ID.'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: 'date', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string("The date of the download, in the site's timezone."),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'date-time' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'date_gmt', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The date of the download, as GMT.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'date-time' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'download_id', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Download ID.'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: 'file_name', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('File name.'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: 'file_path', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('File URL.'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: 'order_id', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Order ID.'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: 'order_number', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Order Number.'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: 'user_id', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('User ID for the downloader.'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: 'username', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('User name of the downloader.'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: 'ip_address', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('IP address for the downloader.'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]) },
	])
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Controller) get_collection_params() rt.PhpVal {
	mut var_params :=
		this.Class_Automattic_WooCommerce_Admin_API_Reports_GenericController.get_collection_params()
	var_params.array_get_mut('orderby').array_set('enum', this.apply_custom_orderby_filters(rt.create_array([
		rt.ArrayItem{ key: none, val: 'date' },
		rt.ArrayItem{ key: none, val: 'product' },
	])))
	var_params.array_set('match', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Indicates whether all the conditions should be true for the resulting set, or if any one of them is sufficient. Match affects the following parameters: products, orders, username, ip_address.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'default', val: 'all' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'all' },
			rt.ArrayItem{ key: none, val: 'any' },
		]) },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('product_includes', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to items that have the specified product(s) assigned.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
		rt.ArrayItem{ key: 'default', val: rt.new_array() },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('product_excludes', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string("Limit result set to items that don't have the specified product(s) assigned."),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
		rt.ArrayItem{ key: 'default', val: rt.new_array() },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
	]))
	var_params.array_set('order_includes', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to items that have the specified order ids.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
	]))
	var_params.array_set('order_excludes', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string("Limit result set to items that don't have the specified order ids."),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
	]))
	var_params.array_set('customer_includes', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects that have the specified user ids.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
	]))
	var_params.array_set('customer_excludes', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string("Limit response to objects that don't have the specified user ids."),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
	]))
	var_params.array_set('ip_address_includes', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to objects that have a specified ip address.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
		]) },
	]))
	var_params.array_set('ip_address_excludes', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string("Limit response to objects that don't have a specified ip address."),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
		]) },
	]))
	return var_params.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Controller) get_export_columns() rt.PhpVal {
	mut var_export_columns := rt.create_array([
		rt.ArrayItem{ key: 'date', val: rt.call_function('__', [
			rt.new_string('Date'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'product', val: rt.call_function('__', [
			rt.new_string('Product title'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'file_name', val: rt.call_function('__', [
			rt.new_string('File name'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'order_number', val: rt.call_function('__', [
			rt.new_string('Order #'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'user_id', val: rt.call_function('__', [
			rt.new_string('User Name'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'ip_address', val: rt.call_function('__', [
			rt.new_string('IP'), rt.new_string('woocommerce')]) },
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_filter_downloads_export_columns'),
		var_export_columns.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Controller) prepare_item_for_export(var_item rt.PhpVal) rt.PhpVal {
	mut var_export_item := rt.create_array([
		rt.ArrayItem{ key: 'date', val: var_item.array_get(rt.new_string('date')) },
		rt.ArrayItem{
			key: 'product'
			val: var_item.array_get(rt.new_string('_embedded')).array_get(rt.new_string('product')).array_get(rt.new_int(0)).array_get(rt.new_string('name'))
		},
		rt.ArrayItem{ key: 'file_name', val: var_item.array_get(rt.new_string('file_name')) },
		rt.ArrayItem{ key: 'order_number', val: var_item.array_get(rt.new_string('order_number')) },
		rt.ArrayItem{ key: 'user_id', val: var_item.array_get(rt.new_string('username')) },
		rt.ArrayItem{ key: 'ip_address', val: var_item.array_get(rt.new_string('ip_address')) },
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_report_downloads_prepare_export_item'),
		var_export_item.clone(),
		var_item.clone(),
	])
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_GenericController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_WC_Customer {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_downloads_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base:     rt.new_string('reports/downloads')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_genericcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_GenericController {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_GenericController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_genericquery(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_downloads_wc_customer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_WC_Customer {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_WC_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_datastore_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_datastore_data(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0)
		}
		'prepare_reports_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_reports_query(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'get_export_columns' {
			return this.get_export_columns()
		}
		'prepare_item_for_export' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_item_for_export(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_GenericController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_WC_Customer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_WC_Customer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Downloads_WC_Customer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
