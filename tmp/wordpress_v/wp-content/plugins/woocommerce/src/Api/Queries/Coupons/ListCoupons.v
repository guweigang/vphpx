import rt

struct Class_Automattic_WooCommerce_Api_Queries_Coupons_ListCoupons {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Api_Queries_Coupons_ListCoupons) execute(mut var_pagination Class_Automattic_WooCommerce_Api_Pagination_PaginationParams, mut var_status Class_Automattic_WooCommerce_Api_Queries_Coupons_?CouponStatus) rt.PhpVal {
	mut var_first := rt.get_property(var_pagination, 'first')
	mut var_last := rt.get_property(var_pagination, 'last')
	mut var_after := rt.get_property(var_pagination, 'after')
	mut var_before := rt.get_property(var_pagination, 'before')
	mut var_limit := if !(var_first).is_null() { var_first } else { if !(var_last).is_null() { var_last } else { fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Api_Pagination_PaginationParams{}; return temp.get_default_page_size() }() } }
	mut var_count_args := rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'shop_coupon' }, rt.ArrayItem{ key: 'posts_per_page', val: 1 }, rt.ArrayItem{ key: 'fields', val: 'ids' }, rt.ArrayItem{ key: 'post_status', val: if !(// unsupported expression: Expr_NullsafePropertyFetch).is_null() { // unsupported expression: Expr_NullsafePropertyFetch } else { rt.new_string('any') } }])
	mut var_count_query := create_automattic_woocommerce_api_queries_coupons_wp_query(var_count_args.dup())
	mut var_total_count := rt.get_property(var_count_query, 'found_posts')
	mut var_posts_query_args := rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'shop_coupon' }, rt.ArrayItem{ key: 'posts_per_page', val: rt.add(var_limit, rt.new_int(1)) }, rt.ArrayItem{ key: 'orderby', val: 'ID' }, rt.ArrayItem{ key: 'order', val: if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { 'DESC' } else { 'ASC' } }, rt.ArrayItem{ key: 'post_status', val: if !(// unsupported expression: Expr_NullsafePropertyFetch).is_null() { // unsupported expression: Expr_NullsafePropertyFetch } else { rt.new_string('any') } }])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_posts_query_args.array_set(Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter.after_id(), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter{}; return temp.decode_id_cursor(arg_0, arg_1) }(var_after.dup(), rt.new_string('after')))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_posts_query_args.array_set(Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter.before_id(), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter{}; return temp.decode_id_cursor(arg_0, arg_1) }(var_before.dup(), rt.new_string('before')))
	}
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter{}; return temp.ensure_registered() }()
	mut var_query := create_automattic_woocommerce_api_queries_coupons_wp_query(var_posts_query_args.dup())
	mut var_posts := rt.get_property(var_query, 'posts')
	mut var_has_extra := rt.greater(rt.new_int(var_posts.dup().array_count()), var_limit)
	if rt.is_true(var_has_extra) {
		var_posts = rt.call_function('array_slice', [var_posts.dup(), rt.new_int(0), var_limit.dup()])
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_posts = rt.call_function('array_reverse', [var_posts.dup()])
	}
	mut var_edges := rt.new_array()
	mut var_nodes := rt.new_array()
	{
		mut iter_1 := var_posts.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_post := item_1.val
			mut var_wc_coupon := create_automattic_woocommerce_api_queries_coupons_wc_coupon(rt.get_property(var_post, 'ID'))
			mut var_coupon := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper{}; return temp.from_wc_coupon(arg_0) }(rt.new_object('Automattic_WooCommerce_Api_Queries_Coupons_WC_Coupon', []string{}, var_wc_coupon))
			mut var_edge := create_automattic_woocommerce_api_pagination_edge()
			rt.set_property(var_edge, 'cursor', rt.call_function('base64_encode', [// unsupported expression: Expr_Cast_String]))
			rt.set_property(var_edge, 'node', var_coupon.dup())
			var_edges.array_push(var_edge.dup())
			var_nodes.array_push(var_coupon.dup())
		}
	}
	mut var_page_info := create_automattic_woocommerce_api_pagination_pageinfo()
	rt.set_property(var_page_info, 'has_next_page', if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { // unsupported expression: Expr_BinaryOp_NotIdentical } else { var_has_extra })
	rt.set_property(var_page_info, 'has_previous_page', if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_has_extra } else { // unsupported expression: Expr_BinaryOp_NotIdentical })
	rt.set_property(var_page_info, 'start_cursor', if !(!rt.is_true(var_edges)) { rt.get_property(var_edges.array_get(0), 'cursor') } else { rt.new_null() })
	rt.set_property(var_page_info, 'end_cursor', if !(!rt.is_true(var_edges)) { rt.get_property(var_edges.array_get(var_edges.dup().array_count() - 1), 'cursor') } else { rt.new_null() })
	mut var_connection := create_automattic_woocommerce_api_pagination_connection()
	rt.set_property(var_connection, 'edges', var_edges.dup())
	rt.set_property(var_connection, 'nodes', var_nodes.dup())
	rt.set_property(var_connection, 'page_info', var_page_info.dup())
	rt.set_property(var_connection, 'total_count', var_total_count.dup())
	return mut var_connection
}

struct Class_Automattic_WooCommerce_Api_Pagination_PaginationParams {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Queries_Coupons_WP_Query {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Queries_Coupons_WC_Coupon {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper {
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

fn create_automattic_woocommerce_api_queries_coupons_listcoupons() &Class_Automattic_WooCommerce_Api_Queries_Coupons_ListCoupons {
	mut obj := &Class_Automattic_WooCommerce_Api_Queries_Coupons_ListCoupons{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_pagination_paginationparams() &Class_Automattic_WooCommerce_Api_Pagination_PaginationParams {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_PaginationParams{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_queries_coupons_wp_query() &Class_Automattic_WooCommerce_Api_Queries_Coupons_WP_Query {
	mut obj := &Class_Automattic_WooCommerce_Api_Queries_Coupons_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_pagination_idcursorfilter() &Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_IdCursorFilter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_queries_coupons_wc_coupon() &Class_Automattic_WooCommerce_Api_Queries_Coupons_WC_Coupon {
	mut obj := &Class_Automattic_WooCommerce_Api_Queries_Coupons_WC_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_utils_coupons_couponmapper() &Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper {
	mut obj := &Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_pagination_edge() &Class_Automattic_WooCommerce_Api_Pagination_Edge {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_Edge{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_pagination_pageinfo() &Class_Automattic_WooCommerce_Api_Pagination_PageInfo {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_PageInfo{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_api_pagination_connection() &Class_Automattic_WooCommerce_Api_Pagination_Connection {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_Connection{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Queries_Coupons_ListCoupons) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'execute' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Pagination_PaginationParams](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Queries_Coupons_?CouponStatus](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.execute(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Api_Queries_Coupons_ListCoupons) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Queries_Coupons_ListCoupons) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Api_Queries_Coupons_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Queries_Coupons_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Queries_Coupons_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Api_Queries_Coupons_WC_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Queries_Coupons_WC_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Queries_Coupons_WC_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Utils_Coupons_CouponMapper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_api_queries_coupons_listcoupons_php() {
	// unsupported statement: Stmt_Declare
}
