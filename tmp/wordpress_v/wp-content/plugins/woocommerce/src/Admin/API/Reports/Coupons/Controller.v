import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Controller {
	rt.PhpObjectBase
pub mut:
		rest_base rt.PhpVal = rt.new_string('reports/coupons')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Controller) get_datastore_data(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query := create_automattic_woocommerce_admin_api_reports_genericquery(var_query_args.dup(), rt.new_string('coupons'))
	return var_query.get_data()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Controller) prepare_reports_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := rt.new_array()
	var_args.array_set('before', var_request.array_get('before'))
	var_args.array_set('after', var_request.array_get('after'))
	var_args.array_set('page', var_request.array_get('page'))
	var_args.array_set('per_page', var_request.array_get('per_page'))
	var_args.array_set('orderby', var_request.array_get('orderby'))
	var_args.array_set('order', var_request.array_get('order'))
	var_args.array_set('coupons', rt.cast_array(var_request.array_get('coupons')))
	var_args.array_set('extended_info', var_request.array_get('extended_info'))
	var_args.array_set('force_cache_refresh', var_request.array_get('force_cache_refresh'))
	return var_args.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Controller) prepare_item_for_response(var_report rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_response := this.Class_Automattic_WooCommerce_Admin_API_Reports_GenericController.prepare_item_for_response(var_report.dup(), var_request.dup())
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_report.dup())])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_prepare_report_coupons'), var_response.dup(), var_report.dup(), var_request.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Controller) prepare_links(var_object rt.PhpVal) rt.PhpVal {
	mut var_links := rt.create_array([rt.ArrayItem{ key: 'coupon', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/coupons/%d'), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Coupons_Controller', ['Automattic_WooCommerce_Admin_API_Reports_GenericController', 'ExportableInterface'], &this), 'namespace'), var_object.array_get('coupon_id')])]) }]) }])
	return var_links.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := rt.create_array([rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: 'report_coupons' }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'coupon_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Coupon ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'amount', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Net discount amount.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'orders_count', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Number of orders.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'extended_info', val: rt.create_array([rt.ArrayItem{ key: 'code', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Coupon code.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'date_created', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Coupon creation date.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'date_created_gmt', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Coupon creation date in GMT.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'date_expires', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Coupon expiration date.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'date_expires_gmt', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Coupon expiration date in GMT.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'discount_type', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'enum', val: rt.func_array_keys(rt.call_function('wc_get_coupon_types', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Coupon discount type.'), rt.new_string('woocommerce')]) }]) }]) }]) }])
	return this.add_additional_fields_schema(var_schema.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Controller) get_collection_params() rt.PhpVal {
	mut var_params := this.Class_Automattic_WooCommerce_Admin_API_Reports_GenericController.get_collection_params()
	var_params.array_get_mut('orderby').array_set('default', 'coupon_id')
	var_params.array_get_mut('orderby').array_set('enum', this.apply_custom_orderby_filters(rt.create_array([rt.ArrayItem{ key: none, val: 'coupon_id' }, rt.ArrayItem{ key: none, val: 'code' }, rt.ArrayItem{ key: none, val: 'amount' }, rt.ArrayItem{ key: none, val: 'orders_count' }])))
	var_params.array_set('coupons', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to coupons assigned specific coupon IDs.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }]))
	var_params.array_set('extended_info', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Add additional piece of info about each coupon to the report.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wc_string_to_bool' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	return var_params.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Controller) get_export_columns() rt.PhpVal {
	mut var_export_columns := rt.create_array([rt.ArrayItem{ key: 'code', val: rt.call_function('__', [rt.new_string('Coupon code'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'orders_count', val: rt.call_function('__', [rt.new_string('Orders'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'amount', val: rt.call_function('__', [rt.new_string('Amount discounted'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'created', val: rt.call_function('__', [rt.new_string('Created'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'expires', val: rt.call_function('__', [rt.new_string('Expires'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.call_function('__', [rt.new_string('Type'), rt.new_string('woocommerce')]) }])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_report_coupons_export_columns'), var_export_columns.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Controller) prepare_item_for_export(var_item rt.PhpVal) rt.PhpVal {
	mut var_date_expires := if !rt.is_true(var_item.array_get('extended_info').array_get('date_expires')) { rt.call_function('__', [rt.new_string('N/A'), rt.new_string('woocommerce')]) } else { var_item.array_get('extended_info').array_get('date_expires') }
	mut var_export_item := rt.create_array([rt.ArrayItem{ key: 'code', val: var_item.array_get('extended_info').array_get('code') }, rt.ArrayItem{ key: 'orders_count', val: var_item.array_get('orders_count') }, rt.ArrayItem{ key: 'amount', val: var_item.array_get('amount') }, rt.ArrayItem{ key: 'created', val: var_item.array_get('extended_info').array_get('date_created') }, rt.ArrayItem{ key: 'expires', val: var_date_expires }, rt.ArrayItem{ key: 'type', val: var_item.array_get('extended_info').array_get('discount_type') }])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_report_coupons_prepare_export_item'), var_export_item.dup(), var_item.dup()])
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_GenericController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_coupons_controller() &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base: rt.new_string('reports/coupons')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_genericcontroller() &Class_Automattic_WooCommerce_Admin_API_Reports_GenericController {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_GenericController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_genericquery() &Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_datastore_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_datastore_data(dispatch_arg_0)
		}
		'prepare_reports_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_reports_query(dispatch_arg_0)
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
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Coupons_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' { this.rest_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_coupons_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
