import rt

struct Class_Automattic_WooCommerce_Admin_API_Taxes {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc-analytics')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Taxes) get_collection_params() rt.PhpVal {
	mut var_params := this.Class_Automattic_WooCommerce_Admin_API_WC_REST_Taxes_Controller.get_collection_params()
	var_params.array_set('search', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Search by similar tax code.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('include', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to items that have the specified rate ID(s) assigned.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	return var_params.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Taxes) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_prepared_args := rt.new_array()
	var_prepared_args.array_set('order', var_request.array_get('order'))
	var_prepared_args.array_set('number', var_request.array_get('per_page'))
	if !(!rt.is_true(var_request.array_get('offset'))) {
		var_prepared_args.array_set('offset', var_request.array_get('offset'))
	} else {
		var_prepared_args.array_set('offset', rt.mul(rt.sub(var_request.array_get('page'), rt.new_int(1)), var_prepared_args.array_get('number')))
	}
	mut var_orderby_possibles := rt.create_array([rt.ArrayItem{ key: 'id', val: 'tax_rate_id' }, rt.ArrayItem{ key: 'order', val: 'tax_rate_order' }])
	var_prepared_args.array_set('orderby', var_orderby_possibles.array_get(var_request.array_get('orderby')))
	var_prepared_args.array_set('class', var_request.array_get('class'))
	var_prepared_args.array_set('search', var_request.array_get('search'))
	var_prepared_args.array_set('include', var_request.array_get('include'))
	var_prepared_args = rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_tax_query'), var_prepared_args.dup(), var_request.dup()])
	mut var_query := rt.new_string(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT *\n\t\t\tFROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_tax_rates\n\t\t\tWHERE 1 = 1\n\t\t')))
	if !(!rt.is_true(var_prepared_args.array_get('class'))) {
		mut var_class := if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.call_function('sanitize_title', [var_prepared_args.array_get('class')]) } else { rt.new_string('') }
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_tax_code_search := var_prepared_args.array_get('search')
	if rt.is_true(var_tax_code_search) {
		mut var_code_like := rt.new_string('%' + (rt.call_method(var_wpdb, 'esc_like', [var_tax_code_search.dup()])).str() + '%')
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_included_taxes := rt.call_function('array_map', [rt.new_string('absint'), var_prepared_args.array_get('include')])
	if !(!rt.is_true(var_included_taxes)) {
		var_included_taxes = rt.call_function('implode', [rt.new_string(','), var_prepared_args.array_get('include')])
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_order_by := rt.call_function('sprintf', [rt.new_string(' ORDER BY %s'), rt.call_function('sanitize_key', [var_prepared_args.array_get('orderby')])])
	mut var_pagination := rt.call_function('sprintf', [rt.new_string(' LIMIT %d, %d'), var_prepared_args.array_get('offset'), var_prepared_args.array_get('number')])
	mut var_results := rt.call_method(var_wpdb, 'get_results', [(var_query).str() + (var_order_by).str() + (var_pagination).str()])
	mut var_taxes := rt.new_array()
	{
		mut iter_1 := var_results.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tax := item_1.val
			mut var_data := this.prepare_item_for_response(var_tax.dup(), var_request.dup())
			var_taxes.array_push(this.prepare_response_for_collection(var_data.dup()))
		}
	}
	mut var_response := rt.call_function('rest_ensure_response', [var_taxes.dup()])
	mut var_per_page := // unsupported expression: Expr_Cast_Int
	mut var_page := rt.call_function('ceil', [rt.add(rt.div(// unsupported expression: Expr_Cast_Int, var_per_page), rt.new_int(1))])
	rt.call_method(var_wpdb, 'get_results', [rt.call_function('str_replace', [rt.new_string('SELECT *'), rt.new_string('SELECT tax_rate_id'), var_query.dup()])])
	mut var_total_taxes := // unsupported expression: Expr_Cast_Int
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'), // unsupported expression: Expr_Cast_Int])
	mut var_max_pages := rt.call_function('ceil', [rt.div(var_total_taxes, var_per_page)])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'), // unsupported expression: Expr_Cast_Int])
	mut var_base := rt.call_function('add_query_arg', [rt.call_method(var_request, 'get_query_params', []rt.PhpVal{}), rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s'), this.namespace, rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Taxes', ['Automattic_WooCommerce_Admin_API_WC_REST_Taxes_Controller'], &this), 'rest_base')])])])
	if rt.is_true(rt.greater(var_page, rt.new_int(1))) {
		mut var_prev_page := rt.sub(var_page, rt.new_int(1))
		if rt.is_true(rt.greater(var_prev_page, var_max_pages)) {
			var_prev_page = var_max_pages.dup()
		}
		mut var_prev_link := rt.call_function('add_query_arg', [rt.new_string('page'), var_prev_page.dup(), var_base.dup()])
		rt.call_method(var_response, 'link_header', [rt.new_string('prev'), var_prev_link.dup()])
	}
	if rt.is_true(rt.greater(var_max_pages, var_page)) {
		mut var_next_page := rt.add(var_page, rt.new_int(1))
		mut var_next_link := rt.call_function('add_query_arg', [rt.new_string('page'), var_next_page.dup(), var_base.dup()])
		rt.call_method(var_response, 'link_header', [rt.new_string('next'), var_next_link.dup()])
	}
	return var_response.dup()
}

struct Class_Automattic_WooCommerce_Admin_API_WC_REST_Taxes_Controller {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_taxes() &Class_Automattic_WooCommerce_Admin_API_Taxes {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Taxes{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc-analytics')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_rest_taxes_controller() &Class_Automattic_WooCommerce_Admin_API_WC_REST_Taxes_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_REST_Taxes_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Taxes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_collection_params' {
			return this.get_collection_params()
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Taxes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Taxes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Taxes_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WC_REST_Taxes_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Taxes_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_taxes_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
