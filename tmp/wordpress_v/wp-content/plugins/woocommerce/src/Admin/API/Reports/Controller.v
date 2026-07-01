import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Controller {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_data := rt.new_array()
	mut var_reports := rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'slug', val: 'performance-indicators' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Batch endpoint for getting specific performance indicators from `stats` endpoints.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'slug', val: 'revenue/stats' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Stats about revenue.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'slug', val: 'orders/stats' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Stats about orders.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'slug', val: 'products' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Products detailed reports.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'slug', val: 'products/stats' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Stats about products.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'slug', val: 'variations' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Variations detailed reports.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'slug', val: 'variations/stats' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Stats about variations.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'slug', val: 'categories' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product categories detailed reports.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'slug', val: 'categories/stats' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Stats about product categories.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'slug', val: 'coupons' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Coupons detailed reports.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'slug', val: 'coupons/stats' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Stats about coupons.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'slug', val: 'taxes' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Taxes detailed reports.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'slug', val: 'taxes/stats' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Stats about taxes.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'slug', val: 'downloads' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product downloads detailed reports.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'slug', val: 'downloads/files' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product download files detailed reports.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'slug', val: 'downloads/stats' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Stats about product downloads.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'slug', val: 'customers' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Customers detailed reports.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'slug', val: 'customers/stats' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Stats about groups of customers.'), rt.new_string('woocommerce')]) }]) }])
	var_reports = rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_reports'), var_reports.dup()])
	{
		mut iter_1 := var_reports.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_report := item_1.val
			if !rt.is_true(var_report.array_get('slug')) {
				continue
			}
			if !rt.is_true(var_report.array_get('path')) {
				var_report.array_set('path', '/' + (rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Controller', ['Automattic_WooCommerce_Admin_API_Reports_GenericController'], &this), 'namespace')).str() + '/reports/' + (var_report.array_get('slug')).str())
			}
			if !(var_report.array_isset(rt.new_string('url'))) {
				if rt.is_true(rt.identical(rt.new_string('/stats'), rt.call_function('substr', [var_report.array_get('slug'), // unsupported expression: Expr_UnaryMinus]))) {
					mut var_url_slug := rt.call_function('substr', [var_report.array_get('slug'), rt.new_int(0), // unsupported expression: Expr_UnaryMinus])
				} else {
					var_url_slug = var_report.array_get('slug')
				}
				var_report.array_set('url', '/analytics/' + (var_url_slug).str())
			}
			mut var_item := this.prepare_item_for_response(// unsupported expression: Expr_Cast_Object, var_request.dup())
			var_data.array_push(this.prepare_response_for_collection(var_item.dup()))
		}
	}
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Controller) prepare_item_for_response(var_report rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_report_mutated := var_report
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'slug', val: rt.get_property(var_report_mutated, 'slug') }, rt.ArrayItem{ key: 'description', val: rt.get_property(var_report_mutated, 'description') }, rt.ArrayItem{ key: 'path', val: rt.get_property(var_report_mutated, 'path') }])
	mut var_response := this.Class_Automattic_WooCommerce_Admin_API_Reports_GenericController.prepare_item_for_response(var_data.dup(), var_request.dup())
	rt.call_method(var_response, 'add_links', [rt.create_array([rt.ArrayItem{ key: 'self', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.get_property(var_report_mutated, 'path')]) }]) }, rt.ArrayItem{ key: 'report', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.get_property(var_report_mutated, 'url') }]) }, rt.ArrayItem{ key: 'collection', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('%s/%s'), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Controller', ['Automattic_WooCommerce_Admin_API_Reports_GenericController'], &this), 'namespace'), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Controller', ['Automattic_WooCommerce_Admin_API_Reports_GenericController'], &this), 'rest_base')])]) }]) }])])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_prepare_report'), var_response.dup(), var_report_mutated.dup(), var_request.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := rt.create_array([rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: 'report' }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'slug', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('An alphanumeric identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A human-readable description of the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('API path.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }])
	return this.add_additional_fields_schema(var_schema.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Controller) get_collection_params() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }])
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_GenericController {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_controller() &Class_Automattic_WooCommerce_Admin_API_Reports_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_genericcontroller() &Class_Automattic_WooCommerce_Admin_API_Reports_GenericController {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_GenericController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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




pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
