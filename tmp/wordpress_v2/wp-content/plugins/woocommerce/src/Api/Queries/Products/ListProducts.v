import rt

struct Class_Automattic_WooCommerce_Api_Queries_Products_ListProducts {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Api_Queries_Products_ListProducts) execute(mut var_pagination Class_Automattic_WooCommerce_Api_Pagination_PaginationParams, mut var_filters Class_Automattic_WooCommerce_Api_InputTypes_Products_ProductFilterInput, mut var_product_type Class_Automattic_WooCommerce_Api_Queries_Products_?ProductType, mut var__query_info Class_Automattic_WooCommerce_Api_Queries_Products_?array) rt.PhpVal {
	mut var_t := rt.new_null()
	mut var_slug := rt.new_null()
	mut var_first := rt.get_property(var_pagination, 'first')
	mut var_last := rt.get_property(var_pagination, 'last')
	mut var_after := rt.get_property(var_pagination, 'after')
	mut var_before := rt.get_property(var_pagination, 'before')
	mut iife_temp_0 := Class_Automattic_WooCommerce_Api_Pagination_PaginationParams{}
	mut iife_result_0 := iife_temp_0.get_default_page_size()
	mut var_limit := if !(var_first).is_null() { var_first } else { if !(var_last).is_null() { var_last } else { iife_result_0 } }
	mut var_query_args := rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'product' }, rt.ArrayItem{ key: 'posts_per_page', val: rt.add(var_limit, rt.new_int(1)) }, rt.ArrayItem{ key: 'orderby', val: 'ID' }, rt.ArrayItem{ key: 'order', val: if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_last)))) { 'DESC' } else { 'ASC' } }, rt.ArrayItem{ key: 'post_status', val: if !(rt.new_null()).is_null() { rt.new_null() } else { rt.new_string('any') } }])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_product_type)))) {
		if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Api_Enums_Products_ProductType.other(), var_product_type)) {
			closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_t := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.get_property(var_t, 'value')
				}
			mut iife_temp_2 := Class_Automattic_WooCommerce_Api_Enums_Products_ProductType{}
			mut iife_result_2 := iife_temp_2.cases()
			closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_t := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.get_property(var_t, 'value')
				}
			closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_slug := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.new_bool(!rt.is_true(rt.identical(rt.get_property(Class_Automattic_WooCommerce_Api_Enums_Products_ProductType.other(), 'value'), var_slug)))
				}
			closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_t := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.get_property(var_t, 'value')
				}
			mut iife_temp_6 := Class_Automattic_WooCommerce_Api_Enums_Products_ProductType{}
			mut iife_result_6 := iife_temp_6.cases()
			closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_t := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.get_property(var_t, 'value')
				}
			closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_t := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.get_property(var_t, 'value')
				}
			mut iife_temp_9 := Class_Automattic_WooCommerce_Api_Enums_Products_ProductType{}
			mut iife_result_9 := iife_temp_9.cases()
			closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_t := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.get_property(var_t, 'value')
				}
			closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_slug := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.new_bool(!rt.is_true(rt.identical(rt.get_property(Class_Automattic_WooCommerce_Api_Enums_Products_ProductType.other(), 'value'), var_slug)))
				}
			closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_t := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.get_property(var_t, 'value')
				}
			mut iife_temp_13 := Class_Automattic_WooCommerce_Api_Enums_Products_ProductType{}
			mut iife_result_13 := iife_temp_13.cases()
			closure_15_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_t := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.get_property(var_t, 'value')
				}
			var_query_args.array_set('tax_query', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_type' }, rt.ArrayItem{ key: 'field', val: 'slug' }, rt.ArrayItem{ key: 'terms', val: rt.call_function('array_values', [rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_closure(closure_2_fn), iife_result_2]), rt.new_closure(closure_5_fn)])]) }, rt.ArrayItem{ key: 'operator', val: 'NOT IN' }]) }]))
		} else {
			var_query_args.array_set('tax_query', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_type' }, rt.ArrayItem{ key: 'field', val: 'slug' }, rt.ArrayItem{ key: 'terms', val: rt.get_property(var_product_type, 'value') }]) }]))
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.get_property(var_filters, 'stock_status'))))) {
		mut match_val_1 := rt.get_property(var_filters, 'stock_status')
		mut var_meta_clause := if rt.is_true(rt.equal(match_val_1, Class_Automattic_WooCommerce_Api_Enums_Products_StockStatus.instock())) { rt.create_array([rt.ArrayItem{ key: 'key', val: '_stock_status' }, rt.ArrayItem{ key: 'value', val: 'instock' }]) } else if rt.is_true(rt.equal(match_val_1, Class_Automattic_WooCommerce_Api_Enums_Products_StockStatus.outofstock())) { rt.create_array([rt.ArrayItem{ key: 'key', val: '_stock_status' }, rt.ArrayItem{ key: 'value', val: 'outofstock' }]) } else if rt.is_true(rt.equal(match_val_1, Class_Automattic_WooCommerce_Api_Enums_Products_StockStatus.onbackorder())) { rt.create_array([rt.ArrayItem{ key: 'key', val: '_stock_status' }, rt.ArrayItem{ key: 'value', val: 'onbackorder' }]) } else if rt.is_true(rt.equal(match_val_1, Class_Automattic_WooCommerce_Api_Enums_Products_StockStatus.other())) { rt.create_array([rt.ArrayItem{ key: 'key', val: '_stock_status' }, rt.ArrayItem{ key: 'value', val: rt.create_array([rt.ArrayItem{ key: none, val: 'instock' }, rt.ArrayItem{ key: none, val: 'outofstock' }, rt.ArrayItem{ key: none, val: 'onbackorder' }]) }, rt.ArrayItem{ key: 'compare', val: 'NOT IN' }]) } else { rt.throw_exception(rt.new_object('Automattic_WooCommerce_Api_ApiException', []string{}, create_automattic_woocommerce_api_apiexception(rt.call_function('sprintf', [rt.new_string('Unsupported stock_status filter value: %s.'), rt.get_property(rt.get_property(var_filters, 'stock_status'), 'name')]), rt.new_string('INVALID_ARGUMENT'), rt.new_int(400)))) }
		var_query_args.array_set('meta_query', rt.create_array([rt.ArrayItem{ key: none, val: var_meta_clause }]))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.get_property(var_filters, 'search'))))) {
		var_query_args.array_set('s', rt.get_property(var_filters, 'search'))
	}
	mut var_count_args := var_query_args.clone()
	var_count_args.array_set('posts_per_page', 1)
	var_count_args.array_set('fields', 'ids')
	mut var_count_query := create_automattic_woocommerce_api_queries_products_wp_query(var_count_args.clone())
	mut var_total_count := rt.get_property(var_count_query, 'found_posts')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_after)))) {
		mut iife_temp_15 := Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter{}
		mut iife_result_15 := iife_temp_15.decode_id_cursor(var_after.clone(), rt.new_string('after'))
		var_query_args.array_set(Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter.after_id(), iife_result_15)
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_before)))) {
		mut iife_temp_16 := Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter{}
		mut iife_result_16 := iife_temp_16.decode_id_cursor(var_before.clone(), rt.new_string('before'))
		var_query_args.array_set(Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter.before_id(), iife_result_16)
	}
	mut iife_temp_17 := Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter{}
	mut iife_result_17 := iife_temp_17.ensure_registered()
	mut var_query := create_automattic_woocommerce_api_queries_products_wp_query(var_query_args.clone())
	mut var_posts := rt.get_property(var_query, 'posts')
	mut var_has_extra := rt.greater(rt.new_int(var_posts.clone().array_count()), var_limit)
	if rt.is_true(var_has_extra) {
	var_posts = rt.call_function('array_slice', [var_posts.clone(), rt.new_int(0), var_limit.clone()])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_last)))) {
	var_posts = rt.call_function('array_reverse', [var_posts.clone()])
	}
	mut iife_temp_18 := Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper{}
	mut iife_result_18 := iife_temp_18.connection_node_info(rt.new_object('Automattic_WooCommerce_Api_Queries_Products_?array', []string{}, var__query_info))
	mut var_node_query_info := iife_result_18
	mut var_edges := rt.new_array()
	mut var_nodes := rt.new_array()
	mut iter_1 := var_posts.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_post := item_1.val
		mut var_wc_product := rt.call_function('wc_get_product', [rt.get_property(var_post, 'ID')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_wc_product, 'Automattic_WooCommerce_Api_Queries_Products_WC_Product')))))) {
			continue
		}
		mut iife_temp_19 := Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper{}
		mut iife_result_19 := iife_temp_19.from_wc_product(var_wc_product.clone(), var_node_query_info.clone())
		mut var_product := iife_result_19
		mut var_edge := create_automattic_woocommerce_api_pagination_edge()
		rt.set_property(var_edge, 'cursor', rt.call_function('base64_encode', [rt.new_string((rt.get_property(var_product, 'id')).str())]))
		rt.set_property(var_edge, 'node', var_product.clone())
		var_edges.array_push(var_edge)
		var_nodes.array_push(var_product.clone())
	}
	mut var_page_info := create_automattic_woocommerce_api_pagination_pageinfo()
	rt.set_property(var_page_info, 'has_next_page', if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_last)))) { rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_before))) } else { var_has_extra })
	rt.set_property(var_page_info, 'has_previous_page', if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_last)))) { var_has_extra } else { rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_after))) })
	rt.set_property(var_page_info, 'start_cursor', if !(!rt.is_true(var_edges)) { rt.get_property(var_edges.array_get(rt.new_int(0)), 'cursor') } else { rt.new_null() })
	rt.set_property(var_page_info, 'end_cursor', if !(!rt.is_true(var_edges)) { rt.get_property(var_edges.array_get(rt.new_int(var_edges.clone().array_count() - 1)), 'cursor') } else { rt.new_null() })
	mut var_connection := create_automattic_woocommerce_api_pagination_connection()
	rt.set_property(var_connection, 'edges', var_edges.clone())
	rt.set_property(var_connection, 'nodes', var_nodes.clone())
	rt.set_property(var_connection, 'page_info', var_page_info)
	rt.set_property(var_connection, 'total_count', var_total_count.clone())
	return mut var_connection
}

struct Class_Automattic_WooCommerce_Api_Pagination_PaginationParams {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Enums_Products_ProductType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_ApiException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Queries_Products_WP_Query {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Pagination_Edge {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Pagination_PageInfo {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Pagination_Connection {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_api_queries_products_listproducts(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Queries_Products_ListProducts {
	mut obj := &Class_Automattic_WooCommerce_Api_Queries_Products_ListProducts{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_pagination_paginationparams(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Pagination_PaginationParams {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_PaginationParams{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_enums_products_producttype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Enums_Products_ProductType {
	mut obj := &Class_Automattic_WooCommerce_Api_Enums_Products_ProductType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_apiexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_ApiException {
	mut obj := &Class_Automattic_WooCommerce_Api_ApiException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_queries_products_wp_query(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Queries_Products_WP_Query {
	mut obj := &Class_Automattic_WooCommerce_Api_Queries_Products_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_pagination_idcursorfilter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_utils_products_productmapper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper {
	mut obj := &Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_pagination_edge(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Pagination_Edge {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_Edge{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_pagination_pageinfo(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Pagination_PageInfo {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_PageInfo{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_pagination_connection(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Pagination_Connection {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_Connection{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Queries_Products_ListProducts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'execute' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Pagination_PaginationParams](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_InputTypes_Products_ProductFilterInput](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Queries_Products_?ProductType](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Queries_Products_?array](if args.len > 3 { args[3] } else { rt.new_null() })
			return this.execute(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Api_Queries_Products_ListProducts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Queries_Products_ListProducts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Pagination_PaginationParams) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Pagination_PaginationParams) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Pagination_PaginationParams) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Enums_Products_ProductType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Enums_Products_ProductType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Enums_Products_ProductType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_ApiException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_ApiException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_ApiException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Queries_Products_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Queries_Products_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Queries_Products_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Utils_Products_ProductMapper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Pagination_Edge) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Pagination_Edge) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Pagination_Edge) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Pagination_PageInfo) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Pagination_PageInfo) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Pagination_PageInfo) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Pagination_Connection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Pagination_Connection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Pagination_Connection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
