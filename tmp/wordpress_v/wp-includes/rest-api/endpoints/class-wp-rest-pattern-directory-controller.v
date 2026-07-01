import rt
import crypto.md5

struct Class_WP_REST_Pattern_Directory_Controller {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_Pattern_Directory_Controller) construct() {
	this.dispatch_set_prop('namespace', rt.new_string('wp/v2'))
	this.dispatch_set_prop('rest_base', rt.new_string('pattern-directory'))
}

fn (mut this Class_WP_REST_Pattern_Directory_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Pattern_Directory_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		'/' +
			rt.get_property(rt.new_object('WP_REST_Pattern_Directory_Controller', ['WP_REST_Controller'], &this), 'rest_base') +
			'/patterns',
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Pattern_Directory_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Pattern_Directory_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Pattern_Directory_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
}

fn (mut this Class_WP_REST_Pattern_Directory_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')])) {
		return true
	}
	{
		mut iter_1 := rt.call_function('get_post_types', [
			rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]),
			rt.new_string('objects'),
		]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_post_type := item_1.val
			if rt.is_true(rt.call_function('current_user_can', [
				rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_posts'),
			]))
			{
				return true
			}
		}
	}
	return (create_wp_error(rt.new_string('rest_pattern_directory_cannot_view'), rt.call_function('__', [
		rt.new_string('Sorry, you are not allowed to browse the local block pattern directory.'),
	]), rt.create_array([
		rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
			[]rt.PhpVal{}) },
	]))).to_bool()
}

fn (mut this Class_WP_REST_Pattern_Directory_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_valid_query_args := {
		'offset':   true
		'order':    true
		'orderby':  true
		'page':     true
		'per_page': true
		'search':   true
		'slug':     true
	}
	mut var_query_args := rt.call_function('array_intersect_key', [
		rt.call_method(var_request, 'get_params', []rt.PhpVal{}),
		var_valid_query_args.dup(),
	])
	var_query_args.array_set('locale', rt.call_function('get_user_locale', []rt.PhpVal{}))
	var_query_args.array_set('wp-version', rt.call_function('wp_get_wp_version', []rt.PhpVal{}))
	var_query_args.array_set('pattern-categories', if !(var_request.array_get('category')).is_null() {
		var_request.array_get('category')
	} else {
		rt.new_bool(false)
	})
	var_query_args.array_set('pattern-keywords', if !(var_request.array_get('keyword')).is_null() {
		var_request.array_get('keyword')
	} else {
		rt.new_bool(false)
	})
	var_query_args = rt.call_function('array_filter', [var_query_args.dup()])
	mut var_transient_key := rt.new_string(this.get_transient_key(var_query_args.dup()))
	mut var_raw_patterns := rt.call_function('get_site_transient', [
		var_transient_key.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_raw_patterns)))) {
		mut var_api_url := rt.new_string('http://api.wordpress.org/patterns/1.0/?' +
			(rt.call_function('build_query', [var_query_args.dup()])).str())
		if rt.is_true(rt.call_function('wp_http_supports', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'ssl' }]),
		]))
		{
			var_api_url = rt.call_function('set_url_scheme', [
				var_api_url.dup(), rt.new_string('https')])
		}
		mut var_cache_ttl := rt.new_int(rt.new_int(5))
		mut var_wporg_response := rt.call_function('wp_remote_get', [
			var_api_url.dup()])
		var_raw_patterns = rt.call_function('json_decode', [
			rt.call_function('wp_remote_retrieve_body', [var_wporg_response.dup()]),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_wporg_response.dup()])) {
			var_raw_patterns = var_wporg_response.dup()
		} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_raw_patterns.dup().is_array()))))) {
			var_raw_patterns = create_wp_error(rt.new_string('pattern_api_failed'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('An unexpected error occurred. Something may be wrong with WordPress.org or this server&#8217;s configuration. If you continue to have problems, please try the <a href="%s">support forums</a>.'),
				]),
				rt.call_function('__', [
					rt.new_string('https://wordpress.org/support/forums/'),
				]),
			]), rt.create_array([
				rt.ArrayItem{ key: 'response', val: rt.call_function('wp_remote_retrieve_body', [
					var_wporg_response.dup(),
				]) },
			]))
		} else {
			var_cache_ttl = rt.get_constant('HOUR_IN_SECONDS')
		}
		rt.call_function('set_site_transient', [var_transient_key.dup(),
			var_raw_patterns.dup(), var_cache_ttl.dup()])
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_raw_patterns.dup()])) {
		rt.call_method(var_raw_patterns, 'add_data', [
			rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]),
		])
		return var_raw_patterns.dup()
	}
	if rt.is_true(rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])) {
		return create_wp_rest_response(rt.new_array())
	}
	mut var_response := rt.new_array()
	if rt.is_true(var_raw_patterns) {
		{
			mut iter_1 := var_raw_patterns.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_pattern := item_1.val
				var_response.array_push(this.prepare_response_for_collection(this.prepare_item_for_response(var_pattern.dup(),
					var_request.dup())))
			}
		}
	}
	return create_wp_rest_response(var_response.dup())
}

fn (mut this Class_WP_REST_Pattern_Directory_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_raw_pattern := var_item
	mut var_prepared_pattern := rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.call_function('absint', [
			rt.get_property(var_raw_pattern, 'id'),
		]) },
		rt.ArrayItem{ key: 'title', val: rt.call_function('sanitize_text_field', [
			rt.get_property(rt.get_property(var_raw_pattern, 'title'), 'rendered'),
		]) },
		rt.ArrayItem{ key: 'content', val: rt.call_function('wp_kses_post', [
			rt.get_property(var_raw_pattern, 'pattern_content'),
		]) },
		rt.ArrayItem{ key: 'categories', val: rt.call_function('array_map', [
			rt.new_string('sanitize_title'),
			rt.get_property(var_raw_pattern, 'category_slugs'),
		]) },
		rt.ArrayItem{ key: 'keywords', val: rt.call_function('array_map', [
			rt.new_string('sanitize_text_field'),
			rt.call_function('explode', [rt.new_string(','),
				rt.get_property(rt.get_property(var_raw_pattern, 'meta'), 'wpop_keywords')]),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('sanitize_text_field', [
			rt.get_property(rt.get_property(var_raw_pattern, 'meta'), 'wpop_description'),
		]) },
		rt.ArrayItem{ key: 'viewport_width', val: rt.call_function('absint', [
			rt.get_property(rt.get_property(var_raw_pattern, 'meta'), 'wpop_viewport_width'),
		]) },
		rt.ArrayItem{ key: 'block_types', val: rt.call_function('array_map', [
			rt.new_string('sanitize_text_field'),
			rt.get_property(rt.get_property(var_raw_pattern, 'meta'), 'wpop_block_types'),
		]) },
	])
	var_prepared_pattern = this.add_additional_fields_to_object(var_prepared_pattern.dup(),
		var_request.dup())
	mut var_response := create_wp_rest_response(var_prepared_pattern.dup())
	return rt.call_function('apply_filters', [
		rt.new_string('rest_prepare_block_pattern'),
		var_response.dup(),
		var_raw_pattern.dup(),
		var_request.dup(),
	])
}

fn (mut this Class_WP_REST_Pattern_Directory_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Pattern_Directory_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
	{
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Pattern_Directory_Controller', [
			'WP_REST_Controller',
		], &this), 'schema'))
	}
	this.dispatch_set_prop('schema', rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'pattern-directory-item' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The pattern ID.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'minimum', val: 1 },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
			]) },
			rt.ArrayItem{ key: 'title', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The pattern title, in human readable format.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'minLength', val: 1 },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
			]) },
			rt.ArrayItem{ key: 'content', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The pattern content.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'minLength', val: 1 },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
			]) },
			rt.ArrayItem{ key: 'categories', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string("The pattern's category slugs."),
				]) },
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'uniqueItems', val: true },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
			]) },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string("The pattern's keywords."),
				]) },
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'uniqueItems', val: true },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
			]) },
			rt.ArrayItem{ key: 'description', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('A description of the pattern.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'minLength', val: 1 },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
			]) },
			rt.ArrayItem{ key: 'viewport_width', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The preferred width of the viewport when previewing a pattern, in pixels.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
			]) },
			rt.ArrayItem{ key: 'block_types', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The block types which can use this pattern.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'uniqueItems', val: true },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
			]) },
		]) },
	]))
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Pattern_Directory_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
}

fn (mut this Class_WP_REST_Pattern_Directory_Controller) get_collection_params() rt.PhpVal {
	mut var_query_params := this.Class_WP_REST_Controller.get_collection_params()
	var_query_params.array_get_mut('per_page').array_set('default', 100)
	var_query_params.array_get_mut('search').array_set('minLength', 1)
	var_query_params.array_get_mut('context').array_set('default', 'view')
	var_query_params.array_set('category', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit results to those matching a category ID.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'minimum', val: 1 },
	]))
	var_query_params.array_set('keyword', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit results to those matching a keyword ID.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'minimum', val: 1 },
	]))
	var_query_params.array_set('slug', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit results to those matching a pattern (slug).'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
	]))
	var_query_params.array_set('offset', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Offset the result set by a specific number of items.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
	]))
	var_query_params.array_set('order', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Order sort attribute ascending or descending.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'default', val: 'desc' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'asc' },
			rt.ArrayItem{ key: none, val: 'desc' },
		]) },
	]))
	var_query_params.array_set('orderby', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Sort collection by post attribute.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'default', val: 'date' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'author' },
			rt.ArrayItem{ key: none, val: 'date' },
			rt.ArrayItem{ key: none, val: 'id' },
			rt.ArrayItem{ key: none, val: 'include' },
			rt.ArrayItem{ key: none, val: 'modified' },
			rt.ArrayItem{ key: none, val: 'parent' },
			rt.ArrayItem{ key: none, val: 'relevance' },
			rt.ArrayItem{ key: none, val: 'slug' },
			rt.ArrayItem{ key: none, val: 'include_slugs' },
			rt.ArrayItem{ key: none, val: 'title' },
			rt.ArrayItem{ key: none, val: 'favorite_count' },
		]) },
	]))
	return rt.call_function('apply_filters', [
		rt.new_string('rest_pattern_directory_collection_params'),
		var_query_params.dup(),
	])
}

fn (mut this Class_WP_REST_Pattern_Directory_Controller) get_transient_key(var_query_args rt.PhpVal) string {
	mut var_query_args_mutated := var_query_args
	if var_query_args_mutated.array_isset(rt.new_string('slug')) {
		var_query_args_mutated.array_set('slug', rt.call_function('wp_parse_list', [
			var_query_args_mutated.array_get('slug'),
		]))
		if !rt.is_true(var_query_args_mutated.array_get('slug')) {
			var_query_args_mutated.array_unset(rt.new_string('slug'))
		} else {
			rt.call_function('sort', [var_query_args_mutated.array_get('slug')])
		}
	}
	return 'wp_remote_block_patterns_' +
		md5.hexhash(rt.call_function('serialize', [var_query_args_mutated.dup()]).to_string())
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

fn create_wp_rest_pattern_directory_controller() &Class_WP_REST_Pattern_Directory_Controller {
	mut obj := &Class_WP_REST_Pattern_Directory_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wp_rest_controller() &Class_WP_REST_Controller {
	mut obj := &Class_WP_REST_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_response() &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Pattern_Directory_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'get_transient_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_transient_key(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_REST_Pattern_Directory_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Pattern_Directory_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_REST_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_pattern_directory_controller_php() {
}
