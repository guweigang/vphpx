import rt

struct Class_WP_REST_Term_Search_Handler {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_Term_Search_Handler) construct()  {
	this.dispatch_set_prop('type', rt.new_string('term'))
	this.dispatch_set_prop('subtypes', rt.call_function('array_values', [rt.call_function('get_taxonomies', [rt.create_array([rt.ArrayItem{ key: 'public', val: true }, rt.ArrayItem{ key: 'show_in_rest', val: true }]), rt.new_string('names')])]))
}

fn (mut this Class_WP_REST_Term_Search_Handler) search_items(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_taxonomies := var_request.array_get(Class_WP_REST_Search_Controller.prop_subtype())
	if rt.is_true(rt.call_function('in_array', [Class_WP_REST_Search_Controller.type_any(), var_taxonomies.dup(), rt.new_bool(true)])) {
		var_taxonomies = rt.get_property(rt.new_object('WP_REST_Term_Search_Handler', ['WP_REST_Search_Handler'], &this), 'subtypes')
	}
	mut var_page := // unsupported expression: Expr_Cast_Int
	mut var_per_page := // unsupported expression: Expr_Cast_Int
	mut var_query_args := rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomies }, rt.ArrayItem{ key: 'hide_empty', val: false }, rt.ArrayItem{ key: 'offset', val: rt.mul(rt.sub(var_page, rt.new_int(1)), var_per_page) }, rt.ArrayItem{ key: 'number', val: var_per_page }])
	if !(!rt.is_true(var_request.array_get('search'))) {
		var_query_args.array_set('search', var_request.array_get('search'))
	}
	if !(!rt.is_true(var_request.array_get('exclude'))) {
		var_query_args.array_set('exclude', var_request.array_get('exclude'))
	}
	if !(!rt.is_true(var_request.array_get('include'))) {
		var_query_args.array_set('include', var_request.array_get('include'))
	}
	var_query_args = rt.call_function('apply_filters', [rt.new_string('rest_term_search_query'), var_query_args.dup(), var_request])
	mut var_query := create_wp_term_query()
	mut var_found_terms := var_query.query(var_query_args.dup())
	mut var_found_ids := rt.call_function('wp_list_pluck', [var_found_terms.dup(), rt.new_string('term_id')])
	var_query_args.array_unset(rt.new_string('offset'))
	var_query_args.array_unset(rt.new_string('number'))
	mut var_total := rt.call_function('wp_count_terms', [var_query_args.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_total)))) {
		var_total = rt.new_int(rt.new_int(0))
	}
	return rt.create_array([rt.ArrayItem{ key: Class_WP_REST_Term_Search_Handler.result_ids(), val: var_found_ids }, rt.ArrayItem{ key: Class_WP_REST_Term_Search_Handler.result_total(), val: var_total }])
}

fn (mut this Class_WP_REST_Term_Search_Handler) prepare_item(var_id rt.PhpVal, mut var_fields Class_array) rt.PhpVal {
	mut var_term := rt.call_function('get_term', [var_id.dup()])
	mut var_data := rt.new_array()
	if rt.is_true(rt.call_function('in_array', [Class_WP_REST_Search_Controller.prop_id(), var_fields, rt.new_bool(true)])) {
		var_data.array_set(Class_WP_REST_Search_Controller.prop_id(), // unsupported expression: Expr_Cast_Int)
	}
	if rt.is_true(rt.call_function('in_array', [Class_WP_REST_Search_Controller.prop_title(), var_fields, rt.new_bool(true)])) {
		var_data.array_set(Class_WP_REST_Search_Controller.prop_title(), rt.get_property(var_term, 'name'))
	}
	if rt.is_true(rt.call_function('in_array', [Class_WP_REST_Search_Controller.prop_url(), var_fields, rt.new_bool(true)])) {
		var_data.array_set(Class_WP_REST_Search_Controller.prop_url(), rt.call_function('get_term_link', [var_id.dup()]))
	}
	if rt.is_true(rt.call_function('in_array', [Class_WP_REST_Search_Controller.prop_type(), var_fields, rt.new_bool(true)])) {
		var_data.array_set(Class_WP_REST_Search_Controller.prop_type(), rt.get_property(var_term, 'taxonomy'))
	}
	return var_data.dup()
}

fn (mut this Class_WP_REST_Term_Search_Handler) prepare_item_links(var_id rt.PhpVal) rt.PhpVal {
	mut var_term := rt.call_function('get_term', [var_id.dup()])
	mut var_links := rt.new_array()
	mut var_item_route := rt.call_function('rest_get_route_for_term', [var_term.dup()])
	if rt.is_true(var_item_route) {
		var_links['self'] = rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [var_item_route.dup()]) }, rt.ArrayItem{ key: 'embeddable', val: true }])
	}
	var_links['about'] = rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('wp/v2/taxonomies/%s'), rt.get_property(var_term, 'taxonomy')])]) }])
	return var_links.dup()
}

struct Class_WP_REST_Search_Handler {
	rt.PhpObjectBase
}

struct Class_WP_Term_Query {
	rt.PhpObjectBase
}

fn create_wp_rest_term_search_handler() &Class_WP_REST_Term_Search_Handler {
	mut obj := &Class_WP_REST_Term_Search_Handler{
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

fn create_wp_term_query() &Class_WP_Term_Query {
	mut obj := &Class_WP_Term_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Term_Search_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_WP_REST_Term_Search_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Term_Search_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_Term_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Term_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Term_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_rest_api_search_class_wp_rest_term_search_handler_php() {
}
