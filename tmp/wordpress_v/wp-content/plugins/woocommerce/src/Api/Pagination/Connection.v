import rt

struct Class_Automattic_WooCommerce_Api_Pagination_Connection {
	rt.PhpObjectBase
pub mut:
		edges rt.PhpVal = rt.new_null()
		nodes rt.PhpVal = rt.new_null()
		page_info rt.PhpVal = rt.new_null()
		total_count rt.PhpVal = rt.new_null()
		sliced rt.PhpVal = rt.new_bool(false)
}

fn Class_Automattic_WooCommerce_Api_Pagination_Connection.pre_sliced(mut var_edges Class_Automattic_WooCommerce_Api_Pagination_array, mut var_page_info Class_Automattic_WooCommerce_Api_Pagination_PageInfo, total_count i64) rt.PhpVal {
	mut var_e := rt.new_null()
	mut var_edges_mutated := var_edges
	mut var_page_info_mutated := var_page_info
	mut var_connection := create_automattic_woocommerce_api_pagination_self()
	rt.set_property(var_connection, 'edges', var_edges_mutated.dup())
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_e := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.get_property(var_e, 'node')
	}
	mut var_e := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.get_property(var_e, 'node')
	}
	rt.set_property(var_connection, 'nodes', rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_edges_mutated.dup()]))
	rt.set_property(var_connection, 'page_info', var_page_info_mutated.dup())
	rt.set_property(var_connection, 'total_count', rt.new_int(total_count))
	rt.set_property(var_connection, 'sliced', rt.new_bool(true))
	return mut var_connection
}

fn (mut this Class_Automattic_WooCommerce_Api_Pagination_Connection) slice(mut var_args Class_Automattic_WooCommerce_Api_Pagination_array) rt.PhpVal {
	mut var_e := rt.new_null()
	if rt.is_true(this.sliced) {
		return mut this
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Api_Pagination_PaginationParams{}; return temp.validate_args(arg_0) }(rt.new_object('Automattic_WooCommerce_Api_Pagination_array', []string{}, var_args))
	mut var_first := if !(var_args.array_get('first')).is_null() { var_args.array_get('first') } else { rt.new_null() }
	mut var_last := if !(var_args.array_get('last')).is_null() { var_args.array_get('last') } else { rt.new_null() }
	mut var_after := if !(var_args.array_get('after')).is_null() { var_args.array_get('after') } else { rt.new_null() }
	mut var_before := if !(var_args.array_get('before')).is_null() { var_args.array_get('before') } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_null(), var_first)) && rt.is_true(rt.identical(rt.new_null(), var_last)))) && rt.is_true(rt.identical(rt.new_null(), var_after)))) && rt.is_true(rt.identical(rt.new_null(), var_before)))) {
		return mut this
	}
	mut var_edges := this.edges
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_found := rt.new_bool(rt.new_bool(false))
		{
			mut iter_1 := var_edges.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_edge := item_1.val
				mut var_i := item_1.key
				if rt.is_true(rt.identical(rt.get_property(var_edge, 'cursor'), var_after)) {
					var_edges = rt.call_function('array_slice', [var_edges.dup(), rt.add(var_i, rt.new_int(1))])
					var_found = rt.new_bool(rt.new_bool(true))
					break
				}
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_found)))) {
			var_edges = rt.new_array()
		}
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_filtered := rt.new_array()
		{
			mut iter_1 := var_edges.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_edge := item_1.val
				if rt.is_true(rt.identical(rt.get_property(var_edge, 'cursor'), var_before)) {
					break
				}
				var_filtered.array_push(var_edge.dup())
			}
		}
		var_edges = var_filtered.dup()
	}
	mut var_total_after_cursors := rt.new_int(rt.new_int(var_edges.dup().array_count()))
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.greater_equal(var_first, rt.new_int(0))))) {
		var_edges = rt.call_function('array_slice', [var_edges.dup(), rt.new_int(0), var_first.dup()])
	}
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.greater_equal(var_last, rt.new_int(0))))) {
		var_edges = rt.call_function('array_slice', [var_edges.dup(), rt.call_function('max', [rt.new_int(0), rt.sub(rt.new_int(var_edges.dup().array_count()), var_last)])])
	}
	mut var_connection := create_automattic_woocommerce_api_pagination_self()
	rt.set_property(var_connection, 'edges', rt.call_function('array_values', [var_edges.dup()]))
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_e := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.get_property(var_e, 'node')
	}
	mut var_e := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.get_property(var_e, 'node')
	}
	rt.set_property(var_connection, 'nodes', rt.call_function('array_map', [rt.new_closure(closure_3_fn), var_edges.dup()]))
	rt.set_property(var_connection, 'total_count', this.total_count)
	rt.set_property(var_connection, 'sliced', rt.new_bool(true))
	mut var_page_info := create_automattic_woocommerce_api_pagination_pageinfo()
	rt.set_property(var_page_info, 'start_cursor', if !(!rt.is_true(var_edges)) { rt.get_property(var_edges.array_get(0), 'cursor') } else { rt.new_null() })
	rt.set_property(var_page_info, 'end_cursor', if !(!rt.is_true(var_edges)) { rt.get_property(var_edges.array_get(var_edges.dup().array_count() - 1), 'cursor') } else { rt.new_null() })
	rt.set_property(var_page_info, 'has_next_page', if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.less(rt.new_int(var_edges.dup().array_count()), var_total_after_cursors) } else { rt.get_property(this.page_info, 'has_next_page') })
	rt.set_property(var_page_info, 'has_previous_page', if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.less(rt.new_int(var_edges.dup().array_count()), var_total_after_cursors) } else { // unsupported expression: Expr_BinaryOp_NotIdentical })
	rt.set_property(var_connection, 'page_info', var_page_info.dup())
	return mut var_connection
}

struct Class_Automattic_WooCommerce_Api_Pagination_self {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Pagination_PaginationParams {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Api_Pagination_PageInfo {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_api_pagination_connection() &Class_Automattic_WooCommerce_Api_Pagination_Connection {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_Connection{
		PhpObjectBase: rt.PhpObjectBase{}
		edges: rt.new_null()
		nodes: rt.new_null()
		page_info: rt.new_null()
		total_count: rt.new_null()
		sliced: rt.new_bool(false)
	}
	return obj
}

fn create_automattic_woocommerce_api_pagination_self() &Class_Automattic_WooCommerce_Api_Pagination_self {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_self{
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

fn create_automattic_woocommerce_api_pagination_pageinfo() &Class_Automattic_WooCommerce_Api_Pagination_PageInfo {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_PageInfo{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Pagination_Connection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'pre_sliced' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Pagination_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Pagination_PageInfo](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return Class_Automattic_WooCommerce_Api_Pagination_Connection.pre_sliced(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'slice' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Pagination_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.slice(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Api_Pagination_Connection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'edges' { return this.edges }
		'nodes' { return this.nodes }
		'page_info' { return this.page_info }
		'total_count' { return this.total_count }
		'sliced' { return this.sliced }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Api_Pagination_Connection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'edges' { this.edges = val; return true }
		'nodes' { this.nodes = val; return true }
		'page_info' { this.page_info = val; return true }
		'total_count' { this.total_count = val; return true }
		'sliced' { this.sliced = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Api_Pagination_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Pagination_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Pagination_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Api_Pagination_PageInfo) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Pagination_PageInfo) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Pagination_PageInfo) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_api_pagination_connection_php() {
	// unsupported statement: Stmt_Declare
}
