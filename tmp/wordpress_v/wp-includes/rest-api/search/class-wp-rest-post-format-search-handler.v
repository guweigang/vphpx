import rt

struct Class_WP_REST_Post_Format_Search_Handler {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_Post_Format_Search_Handler) construct()  {
	this.dispatch_set_prop('type', rt.new_string('post-format'))
}

fn (mut this Class_WP_REST_Post_Format_Search_Handler) search_items(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_format_strings := rt.call_function('get_post_format_strings', []rt.PhpVal{})
	mut var_format_slugs := rt.func_array_keys(var_format_strings.dup())
	mut var_query_args := rt.new_array()
	if !(!rt.is_true(var_request.array_get('search'))) {
		var_query_args.array_set('search', var_request.array_get('search'))
	}
	var_query_args = rt.call_function('apply_filters', [rt.new_string('rest_post_format_search_query'), var_query_args.dup(), var_request])
	mut var_found_ids := rt.new_array()
	{
		mut iter_1 := var_format_slugs.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_format_slug := item_1.val
			if !(!rt.is_true(var_query_args.array_get('search'))) {
				mut var_format_string := rt.call_function('get_post_format_string', [var_format_slug.dup()])
				mut var_format_slug_match := // unsupported expression: Expr_BinaryOp_NotIdentical
				mut var_format_string_match := // unsupported expression: Expr_BinaryOp_NotIdentical
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_format_slug_match)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_format_string_match)))))) {
					continue
				}
			}
			mut var_format_link := rt.call_function('get_post_format_link', [var_format_slug.dup()])
			if rt.is_true(var_format_link) {
				var_found_ids << var_format_slug.dup()
			}
		}
	}
	mut var_page := // unsupported expression: Expr_Cast_Int
	mut var_per_page := // unsupported expression: Expr_Cast_Int
	return rt.create_array([rt.ArrayItem{ key: Class_WP_REST_Post_Format_Search_Handler.result_ids(), val: rt.call_function('array_slice', [var_found_ids.dup(), rt.mul(rt.sub(var_page, rt.new_int(1)), var_per_page), var_per_page.dup()]) }, rt.ArrayItem{ key: Class_WP_REST_Post_Format_Search_Handler.result_total(), val: var_found_ids.len }])
}

fn (mut this Class_WP_REST_Post_Format_Search_Handler) prepare_item(var_id rt.PhpVal, mut var_fields Class_array) rt.PhpVal {
	mut var_data := rt.new_array()
	if rt.is_true(rt.call_function('in_array', [Class_WP_REST_Search_Controller.prop_id(), var_fields, rt.new_bool(true)])) {
		var_data.array_set(Class_WP_REST_Search_Controller.prop_id(), var_id.dup())
	}
	if rt.is_true(rt.call_function('in_array', [Class_WP_REST_Search_Controller.prop_title(), var_fields, rt.new_bool(true)])) {
		var_data.array_set(Class_WP_REST_Search_Controller.prop_title(), rt.call_function('get_post_format_string', [var_id.dup()]))
	}
	if rt.is_true(rt.call_function('in_array', [Class_WP_REST_Search_Controller.prop_url(), var_fields, rt.new_bool(true)])) {
		var_data.array_set(Class_WP_REST_Search_Controller.prop_url(), rt.call_function('get_post_format_link', [var_id.dup()]))
	}
	if rt.is_true(rt.call_function('in_array', [Class_WP_REST_Search_Controller.prop_type(), var_fields, rt.new_bool(true)])) {
		var_data.array_set(Class_WP_REST_Search_Controller.prop_type(), rt.get_property(rt.new_object('WP_REST_Post_Format_Search_Handler', ['WP_REST_Search_Handler'], &this), 'type'))
	}
	return var_data.dup()
}

fn (mut this Class_WP_REST_Post_Format_Search_Handler) prepare_item_links(var_id rt.PhpVal) rt.PhpVal {
	return rt.new_array()
}

struct Class_WP_REST_Search_Handler {
	rt.PhpObjectBase
}

fn create_wp_rest_post_format_search_handler() &Class_WP_REST_Post_Format_Search_Handler {
	mut obj := &Class_WP_REST_Post_Format_Search_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wp_rest_search_handler() &Class_WP_REST_Search_Handler {
	mut obj := &Class_WP_REST_Search_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Post_Format_Search_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'search_items' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.search_items(mut dispatch_arg_0)
		}
		'prepare_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.prepare_item(dispatch_arg_0, mut dispatch_arg_1)
		}
		'prepare_item_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_item_links(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WP_REST_Post_Format_Search_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Post_Format_Search_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Search_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Search_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Search_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_rest_api_search_class_wp_rest_post_format_search_handler_php() {
}
