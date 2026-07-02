import rt

struct Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination) add_headers(var_response rt.PhpVal, var_request rt.PhpVal, var_total_items rt.PhpVal, var_total_pages rt.PhpVal) rt.PhpVal {
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'),
		var_total_items.clone()])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'),
		var_total_pages.clone()])
	mut var_current_page := rt.new_int(this.get_current_page(var_request.clone()))
	mut var_link_base := this.get_link_base(var_request.clone())
	if rt.is_true(rt.greater(var_current_page, rt.new_int(1))) {
		mut var_previous_page := rt.sub(var_current_page, rt.new_int(1))
		if rt.is_true(rt.greater(var_previous_page, var_total_pages)) {
			var_previous_page = var_total_pages
		}
		this.add_page_link(var_response.clone(), rt.new_string('prev'), var_previous_page.clone(),
			var_link_base.clone())
	}
	if rt.is_true(rt.greater(var_total_pages, var_current_page)) {
		this.add_page_link(var_response.clone(), rt.new_string('next'), rt.add(var_current_page,
			rt.new_int(1)), var_link_base.clone())
	}
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination) get_current_page(var_request rt.PhpVal) i64 {
	return rt.new_int((rt.call_method(var_request, 'get_param', [
		rt.new_string('page')])).to_i64())
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination) get_link_base(var_request rt.PhpVal) rt.PhpVal {
	return rt.call_function('esc_url', [
		rt.call_function('add_query_arg', [
			rt.call_method(var_request, 'get_query_params', []rt.PhpVal{}),
			rt.call_function('rest_url', [
				rt.call_method(var_request, 'get_route', []rt.PhpVal{}),
			]),
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination) add_page_link(var_response rt.PhpVal, var_name rt.PhpVal, var_page rt.PhpVal, var_link_base rt.PhpVal) {
	mut var_link_base_mutated := var_link_base
	rt.call_method(var_response, 'link_header', [var_name.clone(),
		rt.call_function('add_query_arg', [rt.new_string('page'),
			var_page.clone(), var_link_base_mutated.clone()])])
}

fn create_automattic_woocommerce_storeapi_utilities_pagination(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add_headers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.add_headers(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'get_current_page' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.get_current_page(dispatch_arg_0))
		}
		'get_link_base' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_link_base(dispatch_arg_0)
		}
		'add_page_link' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.add_page_link(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
