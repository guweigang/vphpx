import rt

struct Class_WC_REST_Report_Coupons_Totals_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v3')
		rest_base rt.PhpVal = rt.new_string('reports/coupons/totals')
}

fn (mut this Class_WC_REST_Report_Coupons_Totals_Controller) get_reports() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_data := rt.call_function('get_transient', [rt.new_string('rest_api_coupons_type_count')])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_data.dup()
	}
	mut var_types := rt.call_function('wc_get_coupon_types', []rt.PhpVal{})
	var_data = rt.new_array()
	{
		mut iter_1 := var_types.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_name := item_1.val
			mut var_slug := item_1.key
			mut var_results := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('\n\t\t\t\t\tSELECT count(meta_id) AS total\n\t\t\t\t\tFROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('\n\t\t\t\t\tWHERE meta_key = \'discount_type\'\n\t\t\t\t\tAND meta_value = %s\n\t\t\t\t')), var_slug.dup()])])
			mut var_total := if var_results.array_isset(rt.new_int(0)) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
			var_data.array_push(rt.create_array([rt.ArrayItem{ key: 'slug', val: var_slug }, rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'total', val: var_total }]))
		}
	}
	rt.call_function('set_transient', [rt.new_string('rest_api_coupons_type_count'), var_data.dup(), rt.get_constant('YEAR_IN_SECONDS')])
	return var_data.dup()
}

fn (mut this Class_WC_REST_Report_Coupons_Totals_Controller) prepare_item_for_response(var_report rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'slug', val: rt.get_property(var_report, 'slug') }, rt.ArrayItem{ key: 'name', val: rt.get_property(var_report, 'name') }, rt.ArrayItem{ key: 'total', val: rt.get_property(var_report, 'total') }])
	mut var_context := if !(!rt.is_true(var_request.array_get('context'))) { var_request.array_get('context') } else { rt.new_string('view') }
	var_data = this.add_additional_fields_to_object(var_data.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_prepare_report_coupons_count'), var_response.dup(), var_report.dup(), var_request.dup()])
}

fn (mut this Class_WC_REST_Report_Coupons_Totals_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := { '$schema': rt.new_string('http://json-schema.org/draft-04/schema#'), 'title': rt.new_string('report_coupon_total'), 'type': rt.new_string('object'), 'properties': { 'slug': { 'description': rt.call_function('__', [rt.new_string('An alphanumeric identifier for the resource.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'name': { 'description': rt.call_function('__', [rt.new_string('Coupon type name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'total': { 'description': rt.call_function('__', [rt.new_string('Amount of coupons.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) } } }
	return this.add_additional_fields_schema(var_schema.dup())
}

struct Class_WC_REST_Reports_Controller {
	rt.PhpObjectBase
}

fn create_wc_rest_report_coupons_totals_controller() &Class_WC_REST_Report_Coupons_Totals_Controller {
	mut obj := &Class_WC_REST_Report_Coupons_Totals_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v3')
		rest_base: rt.new_string('reports/coupons/totals')
	}
	return obj
}

fn create_wc_rest_reports_controller() &Class_WC_REST_Reports_Controller {
	mut obj := &Class_WC_REST_Reports_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Report_Coupons_Totals_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_reports' {
			return this.get_reports()
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Report_Coupons_Totals_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Report_Coupons_Totals_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_Reports_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Reports_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Reports_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version3_class_wc_rest_report_coupons_totals_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
