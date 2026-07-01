import rt

struct Class_WP_REST_Post_Search_Handler {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_Post_Search_Handler) construct()  {
	this.dispatch_set_prop('type', rt.new_string('post'))
	this.dispatch_set_prop('subtypes', rt.call_function('array_diff', [rt.call_function('array_values', [rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'public', val: true }, rt.ArrayItem{ key: 'show_in_rest', val: true }]), rt.new_string('names')])]), rt.create_array([rt.ArrayItem{ key: none, val: 'attachment' }])]))
}

fn (mut this Class_WP_REST_Post_Search_Handler) search_items(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_post_types := var_request.array_get(Class_WP_REST_Search_Controller.prop_subtype())
	if rt.is_true(rt.call_function('in_array', [Class_WP_REST_Search_Controller.type_any(), var_post_types.dup(), rt.new_bool(true)])) {
		var_post_types = rt.get_property(rt.new_object('WP_REST_Post_Search_Handler', ['WP_REST_Search_Handler'], &this), 'subtypes')
	}
	mut var_query_args := rt.create_array([rt.ArrayItem{ key: 'post_type', val: var_post_types }, rt.ArrayItem{ key: 'post_status', val: 'publish' }, rt.ArrayItem{ key: 'paged', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'posts_per_page', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'ignore_sticky_posts', val: true }])
	if !(!rt.is_true(var_request.array_get('search'))) {
		var_query_args.array_set('s', var_request.array_get('search'))
	}
	if !(!rt.is_true(var_request.array_get('exclude'))) {
		var_query_args.array_set('post__not_in', var_request.array_get('exclude'))
	}
	if !(!rt.is_true(var_request.array_get('include'))) {
		var_query_args.array_set('post__in', var_request.array_get('include'))
	}
	var_query_args = rt.call_function('apply_filters', [rt.new_string('rest_post_search_query'), var_query_args.dup(), var_request])
	mut var_query := create_wp_query()
	mut var_posts := var_query.query(var_query_args.dup())
	mut var_found_ids := rt.call_function('wp_list_pluck', [var_posts.dup(), rt.new_string('ID')])
	mut var_total := rt.get_property(var_query, 'found_posts')
	return rt.create_array([rt.ArrayItem{ key: Class_WP_REST_Post_Search_Handler.result_ids(), val: var_found_ids }, rt.ArrayItem{ key: Class_WP_REST_Post_Search_Handler.result_total(), val: var_total }])
}

fn (mut this Class_WP_REST_Post_Search_Handler) prepare_item(var_id rt.PhpVal, mut var_fields Class_array) rt.PhpVal {
	mut var_post := rt.call_function('get_post', [var_id.dup()])
	mut var_data := rt.new_array()
	if rt.is_true(rt.call_function('in_array', [Class_WP_REST_Search_Controller.prop_id(), var_fields, rt.new_bool(true)])) {
		var_data.array_set(Class_WP_REST_Search_Controller.prop_id(), // unsupported expression: Expr_Cast_Int)
	}
	if rt.is_true(rt.call_function('in_array', [Class_WP_REST_Search_Controller.prop_title(), var_fields, rt.new_bool(true)])) {
		if rt.is_true(rt.call_function('post_type_supports', [rt.get_property(var_post, 'post_type'), rt.new_string('title')])) {
			rt.call_function('add_filter', [rt.new_string('protected_title_format'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Post_Search_Handler', ['WP_REST_Search_Handler'], &this) }, rt.ArrayItem{ key: none, val: 'protected_title_format' }])])
			rt.call_function('add_filter', [rt.new_string('private_title_format'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Post_Search_Handler', ['WP_REST_Search_Handler'], &this) }, rt.ArrayItem{ key: none, val: 'protected_title_format' }])])
			var_data.array_set(Class_WP_REST_Search_Controller.prop_title(), rt.call_function('get_the_title', [rt.get_property(var_post, 'ID')]))
			rt.call_function('remove_filter', [rt.new_string('protected_title_format'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Post_Search_Handler', ['WP_REST_Search_Handler'], &this) }, rt.ArrayItem{ key: none, val: 'protected_title_format' }])])
			rt.call_function('remove_filter', [rt.new_string('private_title_format'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Post_Search_Handler', ['WP_REST_Search_Handler'], &this) }, rt.ArrayItem{ key: none, val: 'protected_title_format' }])])
		} else {
			var_data.array_set(Class_WP_REST_Search_Controller.prop_title(), '')
		}
	}
	if rt.is_true(rt.call_function('in_array', [Class_WP_REST_Search_Controller.prop_url(), var_fields, rt.new_bool(true)])) {
		var_data.array_set(Class_WP_REST_Search_Controller.prop_url(), rt.call_function('get_permalink', [rt.get_property(var_post, 'ID')]))
	}
	if rt.is_true(rt.call_function('in_array', [Class_WP_REST_Search_Controller.prop_type(), var_fields, rt.new_bool(true)])) {
		var_data.array_set(Class_WP_REST_Search_Controller.prop_type(), rt.get_property(rt.new_object('WP_REST_Post_Search_Handler', ['WP_REST_Search_Handler'], &this), 'type'))
	}
	if rt.is_true(rt.call_function('in_array', [Class_WP_REST_Search_Controller.prop_subtype(), var_fields, rt.new_bool(true)])) {
		var_data.array_set(Class_WP_REST_Search_Controller.prop_subtype(), rt.get_property(var_post, 'post_type'))
	}
	return var_data.dup()
}

fn (mut this Class_WP_REST_Post_Search_Handler) prepare_item_links(var_id rt.PhpVal) rt.PhpVal {
	mut var_post := rt.call_function('get_post', [var_id.dup()])
	mut var_links := rt.new_array()
	mut var_item_route := rt.call_function('rest_get_route_for_post', [var_post.dup()])
	if !(!rt.is_true(var_item_route)) {
		var_links['self'] = rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [var_item_route.dup()]) }, rt.ArrayItem{ key: 'embeddable', val: true }])
	}
	var_links['about'] = rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', ['wp/v2/types/' + (rt.get_property(var_post, 'post_type')).str()]) }])
	return var_links.dup()
}

fn (mut this Class_WP_REST_Post_Search_Handler) protected_title_format() string {
	return '%s'
}

fn (mut this Class_WP_REST_Post_Search_Handler) detect_rest_item_route(var_post rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('5.5.0'), rt.new_string('rest_get_route_for_post()')])
	return rt.call_function('rest_get_route_for_post', [var_post_mutated.dup()])
}

struct Class_WP_REST_Search_Handler {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_wp_rest_post_search_handler() &Class_WP_REST_Post_Search_Handler {
	mut obj := &Class_WP_REST_Post_Search_Handler{
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

fn create_wp_query() &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Post_Search_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'protected_title_format' {
			return rt.new_string(this.protected_title_format())
		}
		'detect_rest_item_route' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.detect_rest_item_route(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WP_REST_Post_Search_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Post_Search_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_rest_api_search_class_wp_rest_post_search_handler_php() {
}
