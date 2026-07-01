import rt

struct Class_Automattic_WooCommerce_Admin_API_Products {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc-analytics')
		last_order_dates rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Products) get_item_schema() rt.PhpVal {
	mut var_schema := this.Class_Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller.get_item_schema()
	mut var_properties_to_embed := rt.create_array([rt.ArrayItem{ key: none, val: 'id' }, rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'slug' }, rt.ArrayItem{ key: none, val: 'permalink' }, rt.ArrayItem{ key: none, val: 'images' }, rt.ArrayItem{ key: none, val: 'description' }, rt.ArrayItem{ key: none, val: 'short_description' }])
	{
		mut iter_1 := var_properties_to_embed.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_property := item_1.val
			var_schema.array_get_mut('properties').array_get_mut(var_property).array_get_mut('context').array_push('embed')
		}
	}
	var_schema.array_get_mut('properties').array_set('last_order_date', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the last order for this product was placed, in the site\'s timezone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]))
	return var_schema.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Products) get_collection_params() rt.PhpVal {
	mut var_params := this.Class_Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller.get_collection_params()
	var_params.array_set('low_in_stock', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to products that are low or out of stock. (Deprecated)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wc_string_to_bool' }]))
	var_params.array_set('search', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Search by similar product name or sku.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	return var_params.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Products) prepare_objects_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := this.Class_Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller.prepare_objects_query(var_request.dup())
	if !(!rt.is_true(var_request.array_get('search'))) {
		var_args.array_set('search', var_request.array_get('search').to_string().trim_space())
		var_args.array_unset(rt.new_string('s'))
	}
	if !(!rt.is_true(var_request.array_get('low_in_stock'))) {
		var_args.array_set('low_in_stock', var_request.array_get('low_in_stock'))
		var_args.array_set('post_type', rt.create_array([rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'product_variation' }]))
	}
	return var_args.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Products) get_items(var_request rt.PhpVal) rt.PhpVal {
	rt.call_function('add_filter', [rt.new_string('posts_fields'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_wp_query_fields' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('posts_where'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_wp_query_filter' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('posts_join'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_wp_query_join' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('posts_groupby'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_wp_query_group_by' }]), rt.new_int(10), rt.new_int(2)])
	mut var_response := this.Class_Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller.get_items(var_request.dup())
	rt.call_function('remove_filter', [rt.new_string('posts_fields'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_wp_query_fields' }]), rt.new_int(10)])
	rt.call_function('remove_filter', [rt.new_string('posts_where'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_wp_query_filter' }]), rt.new_int(10)])
	rt.call_function('remove_filter', [rt.new_string('posts_join'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_wp_query_join' }]), rt.new_int(10)])
	rt.call_function('remove_filter', [rt.new_string('posts_groupby'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_wp_query_group_by' }]), rt.new_int(10)])
	if this.is_low_in_stock_request(var_request.dup()) {
		rt.call_method(var_response, 'header', [rt.new_string('Cache-Control'), rt.new_string('max-age=300')])
	}
	return var_response.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Products) is_low_in_stock_request(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.call_method(var_request, 'get_param', [rt.new_string('low_in_stock')]), rt.new_bool(true))) && rt.is_true(rt.identical(rt.call_method(var_request, 'get_param', [rt.new_string('page')]), rt.new_int(1))))) && rt.is_true(rt.new_bool(rt.call_method(var_request, 'get_param', [rt.new_string('_fields')]).is_array())))) && rt.call_method(var_request, 'get_param', [rt.new_string('_fields')]).array_count() == 1)) && rt.is_true(rt.call_function('in_array', [rt.new_string('id'), rt.call_method(var_request, 'get_param', [rt.new_string('_fields')]), rt.new_bool(true)])))) {
		return true
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Products) get_object(var_object_data rt.PhpVal) rt.PhpVal {
	mut var_object_data_mutated := var_object_data
	if !(rt.get_property(var_object_data_mutated, 'last_order_date')).is_null() {
		this.last_order_dates.array_set(rt.get_property(var_object_data_mutated, 'ID'), rt.get_property(var_object_data_mutated, 'last_order_date'))
	}
	return this.Class_Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller.get_object(var_object_data_mutated.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Products) prepare_object_for_response(var_object rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_data := this.Class_Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller.prepare_object_for_response(var_object.dup(), var_request.dup())
	mut var_object_data := rt.call_method(var_object, 'get_data', []rt.PhpVal{})
	mut var_product_id := var_object_data.array_get('id')
	if rt.is_true(rt.call_method(var_request, 'get_param', [rt.new_string('low_in_stock')])) {
		if rt.is_true(rt.new_bool(var_object_data.array_get('low_stock_amount').is_long() || var_object_data.array_get('low_stock_amount').is_double())) {
			rt.get_property(var_data, 'data').array_set('low_stock_amount', var_object_data.array_get('low_stock_amount'))
		}
		if this.last_order_dates.array_isset(var_product_id) {
			rt.get_property(var_data, 'data').array_set('last_order_date', rt.call_function('wc_rest_prepare_date_response', [this.last_order_dates.array_get(var_product_id)]))
		}
	}
	if rt.get_property(var_data, 'data').array_isset(rt.new_string('name')) {
		rt.get_property(var_data, 'data').array_set('name', rt.call_function('wp_strip_all_tags', [rt.get_property(var_data, 'data').array_get('name')]))
	}
	return var_data.dup()
}

fn Class_Automattic_WooCommerce_Admin_API_Products.add_wp_query_fields(var_select rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_method(var_wp_query, 'get', [rt.new_string('low_in_stock')])) {
		mut var_fields := rt.create_array([rt.ArrayItem{ key: none, val: 'low_stock_amount_meta.meta_value AS low_stock_amount' }, rt.ArrayItem{ key: none, val: 'MAX( product_lookup.date_created ) AS last_order_date' }])
		// unsupported expression: Expr_AssignOp_Concat
	}
	return var_select.dup()
}

fn Class_Automattic_WooCommerce_Admin_API_Products.add_wp_query_filter(var_where rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_search := rt.call_method(var_wp_query, 'get', [rt.new_string('search')])
	if rt.is_true(var_search) {
		mut var_title_like := rt.new_string('%' + (rt.call_method(var_wpdb, 'esc_like', [var_search.dup()])).str() + '%')
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(rt.call_method(var_wp_query, 'get', [rt.new_string('low_in_stock')])) {
		mut var_low_stock_amount := rt.call_function('absint', [rt.call_function('max', [rt.call_function('get_option', [rt.new_string('woocommerce_notify_low_stock_amount')]), rt.new_int(1)])])
		// unsupported expression: Expr_AssignOp_Concat
	}
	return var_where.dup()
}

fn Class_Automattic_WooCommerce_Admin_API_Products.add_wp_query_join(var_join rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_join_mutated := var_join
	// unsupported statement: Stmt_Global
	mut var_search := rt.call_method(var_wp_query, 'get', [rt.new_string('search')])
	if rt.is_true(rt.new_bool(rt.is_true(var_search) && rt.is_true(rt.call_function('wc_product_sku_enabled', []rt.PhpVal{})))) {
		var_join_mutated = Class_Automattic_WooCommerce_Admin_API_Products.append_product_sorting_table_join(var_join_mutated.dup())
	}
	if rt.is_true(rt.call_method(var_wp_query, 'get', [rt.new_string('low_in_stock')])) {
		mut var_product_lookup_table := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'wc_order_product_lookup')
		var_join_mutated = Class_Automattic_WooCommerce_Admin_API_Products.append_product_sorting_table_join(var_join_mutated.dup())
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
	}
	return var_join_mutated.dup()
}

fn Class_Automattic_WooCommerce_Admin_API_Products.append_product_sorting_table_join(var_sql rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strstr', [var_sql.dup(), rt.new_string('wc_product_meta_lookup')]))))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return var_sql.dup()
}

fn Class_Automattic_WooCommerce_Admin_API_Products.add_wp_query_group_by(var_groupby rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_groupby_mutated := var_groupby
	// unsupported statement: Stmt_Global
	mut var_search := rt.call_method(var_wp_query, 'get', [rt.new_string('search')])
	mut var_low_in_stock := rt.call_method(var_wp_query, 'get', [rt.new_string('low_in_stock')])
	if rt.is_true(rt.new_bool(!rt.is_true(var_groupby_mutated) && rt.is_true(rt.new_bool(rt.is_true(var_search) || rt.is_true(var_low_in_stock))))) {
		var_groupby_mutated = rt.new_string((rt.get_property(var_wpdb, 'posts')).str() + '.ID')
	}
	return var_groupby_mutated.dup()
}

struct Class_Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_products() &Class_Automattic_WooCommerce_Admin_API_Products {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Products{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc-analytics')
		last_order_dates: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_rest_products_controller() &Class_Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Products) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'prepare_objects_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_objects_query(dispatch_arg_0)
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'is_low_in_stock_request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_low_in_stock_request(dispatch_arg_0))
		}
		'get_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_object(dispatch_arg_0)
		}
		'prepare_object_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_object_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'add_wp_query_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Products.add_wp_query_fields(dispatch_arg_0, dispatch_arg_1)
		}
		'add_wp_query_filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Products.add_wp_query_filter(dispatch_arg_0, dispatch_arg_1)
		}
		'add_wp_query_join' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Products.add_wp_query_join(dispatch_arg_0, dispatch_arg_1)
		}
		'append_product_sorting_table_join' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Products.append_product_sorting_table_join(dispatch_arg_0)
		}
		'add_wp_query_group_by' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Products.add_wp_query_group_by(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Products) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'last_order_dates' { return this.last_order_dates }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Products) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'last_order_dates' { this.last_order_dates = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Products_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_products_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
