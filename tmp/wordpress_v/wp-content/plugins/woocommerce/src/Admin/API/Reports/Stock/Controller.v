import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller {
	rt.PhpObjectBase
pub mut:
		rest_base rt.PhpVal = rt.new_string('reports/stock')
		status_options rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller) construct()  {
	this.status_options = rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller) prepare_reports_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := rt.new_array()
	var_args.array_set('offset', var_request.array_get('offset'))
	var_args.array_set('order', var_request.array_get('order'))
	var_args.array_set('orderby', var_request.array_get('orderby'))
	var_args.array_set('paged', var_request.array_get('page'))
	var_args.array_set('post__in', var_request.array_get('include'))
	var_args.array_set('post__not_in', var_request.array_get('exclude'))
	var_args.array_set('posts_per_page', var_request.array_get('per_page'))
	var_args.array_set('post_parent__in', var_request.array_get('parent'))
	var_args.array_set('post_parent__not_in', var_request.array_get('parent_exclude'))
	if rt.is_true(rt.identical(rt.new_string('date'), var_args.array_get('orderby'))) {
		var_args.array_set('orderby', 'date ID')
	} else if rt.is_true(rt.identical(rt.new_string('include'), var_args.array_get('orderby'))) {
		var_args.array_set('orderby', 'post__in')
	} else if rt.is_true(rt.identical(rt.new_string('id'), var_args.array_get('orderby'))) {
		var_args.array_set('orderby', 'ID')
		// unsupported statement: Stmt_Nop
	}
	var_args.array_set('post_type', rt.create_array([rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'product_variation' }]))
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStockStatus.low_stock(), var_request.array_get('type'))) {
		var_args.array_set('low_in_stock', true)
	} else if rt.is_true(rt.call_function('in_array', [var_request.array_get('type'), rt.func_array_keys(this.status_options), rt.new_bool(true)])) {
		var_args.array_set('stock_status', var_request.array_get('type'))
	}
	var_args.array_set('ignore_sticky_posts', true)
	return var_args.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller) get_products(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query_args_mutated := var_query_args
	mut var_query := create_automattic_woocommerce_admin_api_reports_stock_wp_query()
	mut var_result := var_query.query(var_query_args_mutated.dup())
	mut var_total_posts := rt.get_property(var_query, 'found_posts')
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.less(var_total_posts, rt.new_int(1))) && var_query_args_mutated.array_isset(rt.new_string('paged')))) && rt.is_true(rt.greater(rt.call_function('absint', [var_query_args_mutated.array_get('paged')]), rt.new_int(1))))) {
		var_query_args_mutated.array_unset(rt.new_string('paged'))
		mut var_count_query := create_automattic_woocommerce_admin_api_reports_stock_wp_query()
		var_count_query.query(var_query_args_mutated.dup())
		var_total_posts = rt.get_property(var_count_query, 'found_posts')
	}
	return rt.create_array([rt.ArrayItem{ key: 'objects', val: rt.call_function('array_map', [rt.new_string('wc_get_product'), var_result.dup()]) }, rt.ArrayItem{ key: 'total', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'pages', val: // unsupported expression: Expr_Cast_Int }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	rt.call_function('add_filter', [rt.new_string('posts_where'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_wp_query_filter' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('posts_join'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_wp_query_join' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('posts_groupby'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_wp_query_group_by' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('posts_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_wp_query_orderby' }]), rt.new_int(10), rt.new_int(2)])
	mut var_query_args := this.prepare_reports_query(var_request.dup())
	mut var_query_results := this.get_products(var_query_args.dup())
	rt.call_function('remove_filter', [rt.new_string('posts_where'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_wp_query_filter' }]), rt.new_int(10)])
	rt.call_function('remove_filter', [rt.new_string('posts_join'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_wp_query_join' }]), rt.new_int(10)])
	rt.call_function('remove_filter', [rt.new_string('posts_groupby'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_wp_query_group_by' }]), rt.new_int(10)])
	rt.call_function('remove_filter', [rt.new_string('posts_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_wp_query_orderby' }]), rt.new_int(10)])
	mut var_objects := rt.new_array()
	{
		mut iter_1 := var_query_results.array_get('objects').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_object := item_1.val
			mut var_data := this.prepare_item_for_response(var_object.dup(), var_request.dup())
			var_objects.array_push(this.prepare_response_for_collection(var_data.dup()))
		}
	}
	return this.add_pagination_headers(var_request.dup(), var_objects.dup(), // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int)
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller.add_wp_query_filter(var_where rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_stock_status := rt.call_method(var_wp_query, 'get', [rt.new_string('stock_status')])
	if rt.is_true(var_stock_status) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(rt.call_method(var_wp_query, 'get', [rt.new_string('low_in_stock')])) {
		mut var_no_stock_amount := rt.call_function('absint', [rt.call_function('max', [rt.call_function('get_option', [rt.new_string('woocommerce_notify_no_stock_amount')]), rt.new_int(0)])])
		mut var_low_stock_amount := rt.call_function('absint', [rt.call_function('max', [rt.call_function('get_option', [rt.new_string('woocommerce_notify_low_stock_amount')]), rt.new_int(1)])])
		// unsupported expression: Expr_AssignOp_Concat
	}
	return var_where.dup()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller.add_wp_query_join(var_join rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_join_mutated := var_join
	// unsupported statement: Stmt_Global
	mut var_stock_status := rt.call_method(var_wp_query, 'get', [rt.new_string('stock_status')])
	if rt.is_true(var_stock_status) {
		var_join_mutated = Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller.append_product_sorting_table_join(var_join_mutated.dup())
	}
	if rt.is_true(rt.call_method(var_wp_query, 'get', [rt.new_string('low_in_stock')])) {
		var_join_mutated = Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller.append_product_sorting_table_join(var_join_mutated.dup())
		// unsupported expression: Expr_AssignOp_Concat
	}
	return var_join_mutated.dup()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller.append_product_sorting_table_join(var_sql rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strstr', [var_sql.dup(), rt.new_string('wc_product_meta_lookup')]))))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return var_sql.dup()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller.add_wp_query_group_by(var_groupby rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_groupby_mutated := var_groupby
	// unsupported statement: Stmt_Global
	if !rt.is_true(var_groupby_mutated) {
		var_groupby_mutated = rt.new_string((rt.get_property(var_wpdb, 'posts')).str() + '.ID')
	}
	return var_groupby_mutated.dup()
}

fn Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller.add_wp_query_orderby(var_args rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	// unsupported statement: Stmt_Global
	mut var_orderby := rt.call_method(var_wp_query, 'get', [rt.new_string('orderby')])
	mut var_order := rt.call_function('esc_sql', [if rt.is_true(rt.call_method(var_wp_query, 'get', [rt.new_string('order')])) { rt.call_method(var_wp_query, 'get', [rt.new_string('order')]) } else { rt.new_string('desc') }])
	mut switch_val_1 := var_orderby
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('stock_quantity'))) {
		var_args_mutated.array_set('join', Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller.append_product_sorting_table_join(var_args_mutated.array_get('join')))
		var_args_mutated.array_set('orderby', " wc_product_meta_lookup.stock_quantity ${var_order.to_string()}, wc_product_meta_lookup.product_id ${var_order.to_string()} ")
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('stock_status'))) {
		var_args_mutated.array_set('join', Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller.append_product_sorting_table_join(var_args_mutated.array_get('join')))
		var_args_mutated.array_set('orderby', " wc_product_meta_lookup.stock_status ${var_order.to_string()}, wc_product_meta_lookup.stock_quantity ${var_order.to_string()} ")
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('sku'))) {
		var_args_mutated.array_set('join', Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller.append_product_sorting_table_join(var_args_mutated.array_get('join')))
		var_args_mutated.array_set('orderby', " wc_product_meta_lookup.sku ${var_order.to_string()}, wc_product_meta_lookup.product_id ${var_order.to_string()} ")
	}
	return var_args_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller) prepare_item_for_response(var_product rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_product, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'parent_id', val: rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'name', val: rt.call_function('wp_strip_all_tags', [rt.call_method(var_product, 'get_name', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'sku', val: rt.call_method(var_product, 'get_sku', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'stock_status', val: rt.call_method(var_product, 'get_stock_status', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'stock_quantity', val: // unsupported expression: Expr_Cast_Double }, rt.ArrayItem{ key: 'manage_stock', val: rt.call_method(var_product, 'get_manage_stock', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'low_stock_amount', val: rt.call_method(var_product, 'get_low_stock_amount', []rt.PhpVal{}) }])
	if rt.is_true(rt.identical(rt.new_string(''), var_data.array_get('low_stock_amount'))) {
		var_data.array_set('low_stock_amount', rt.call_function('absint', [rt.call_function('max', [rt.call_function('get_option', [rt.new_string('woocommerce_notify_low_stock_amount')]), rt.new_int(1)])]))
	}
	mut var_response := this.Class_Automattic_WooCommerce_Admin_API_Reports_GenericController.prepare_item_for_response(var_data.dup(), var_request.dup())
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_product.dup())])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_prepare_report_stock'), var_response.dup(), var_product.dup(), var_request.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller) prepare_links(var_product rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()])) {
		mut var_links := rt.create_array([rt.ArrayItem{ key: 'product', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/products/%d/variations/%d'), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Stock_Controller', ['Automattic_WooCommerce_Admin_API_Reports_GenericController', 'ExportableInterface'], &this), 'namespace'), rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{}), rt.call_method(var_product, 'get_id', []rt.PhpVal{})])]) }]) }, rt.ArrayItem{ key: 'parent', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/products/%d'), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Stock_Controller', ['Automattic_WooCommerce_Admin_API_Reports_GenericController', 'ExportableInterface'], &this), 'namespace'), rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{})])]) }]) }])
	} else if rt.is_true(rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{})) {
		var_links = rt.create_array([rt.ArrayItem{ key: 'product', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/products/%d'), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Stock_Controller', ['Automattic_WooCommerce_Admin_API_Reports_GenericController', 'ExportableInterface'], &this), 'namespace'), rt.call_method(var_product, 'get_id', []rt.PhpVal{})])]) }]) }, rt.ArrayItem{ key: 'parent', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/products/%d'), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Stock_Controller', ['Automattic_WooCommerce_Admin_API_Reports_GenericController', 'ExportableInterface'], &this), 'namespace'), rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{})])]) }]) }])
	} else {
		var_links = rt.create_array([rt.ArrayItem{ key: 'product', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/products/%d'), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Stock_Controller', ['Automattic_WooCommerce_Admin_API_Reports_GenericController', 'ExportableInterface'], &this), 'namespace'), rt.call_method(var_product, 'get_id', []rt.PhpVal{})])]) }]) }])
	}
	return var_links.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := rt.create_array([rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: 'report_stock' }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'parent_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product parent ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'sku', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'stock_status', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Stock status.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.func_array_keys(rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'stock_quantity', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Stock quantity.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'manage_stock', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Manage stock.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }])
	return this.add_additional_fields_schema(var_schema.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller) get_collection_params() rt.PhpVal {
	mut var_params := this.Class_Automattic_WooCommerce_Admin_API_Reports_GenericController.get_collection_params()
	var_params.array_unset(rt.new_string('after'))
	var_params.array_unset(rt.new_string('before'))
	var_params.array_unset(rt.new_string('force_cache_refresh'))
	var_params.array_set('exclude', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Ensure result set excludes specific IDs.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }]))
	var_params.array_set('include', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [, ]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: , val:  }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }]))
	var_params.array_set('offset', rt.create_array([rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }]))
	.array_get_mut().array_set(, )
	
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller) get_export_columns() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller) prepare_item_for_export(var_item rt.PhpVal) rt.PhpVal {
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_GenericController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Stock_WP_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_stock_controller() &Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base: rt.new_string('reports/stock')
		status_options: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_genericcontroller() &Class_Automattic_WooCommerce_Admin_API_Reports_GenericController {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_GenericController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_stock_wp_query() &Class_Automattic_WooCommerce_Admin_API_Reports_Stock_WP_Query {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Stock_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'prepare_reports_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_reports_query(dispatch_arg_0)
		}
		'get_products' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_products(dispatch_arg_0)
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'add_wp_query_filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller.add_wp_query_filter(dispatch_arg_0, dispatch_arg_1)
		}
		'add_wp_query_join' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller.add_wp_query_join(dispatch_arg_0, dispatch_arg_1)
		}
		'append_product_sorting_table_join' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller.append_product_sorting_table_join(dispatch_arg_0)
		}
		'add_wp_query_group_by' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller.add_wp_query_group_by(dispatch_arg_0, dispatch_arg_1)
		}
		'add_wp_query_orderby' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller.add_wp_query_orderby(dispatch_arg_0, dispatch_arg_1)
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

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		'status_options' { return this.status_options }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' { this.rest_base = val; return true }
		'status_options' { this.status_options = val; return true }
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


fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Stock_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Stock_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_stock_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
