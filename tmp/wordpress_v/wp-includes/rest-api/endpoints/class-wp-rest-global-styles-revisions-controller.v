import rt

struct Class_WP_REST_Global_Styles_Revisions_Controller {
	rt.PhpObjectBase
pub mut:
		parent_controller rt.PhpVal = rt.new_null()
		parent_base rt.PhpVal = rt.new_null()
		parent_post_type rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_REST_Global_Styles_Revisions_Controller) construct(parent_post_type string)  {
	this.Class_WP_REST_Revisions_Controller.construct(rt.new_string(parent_post_type))
	mut var_post_type_object := rt.call_function('get_post_type_object', [rt.new_string(parent_post_type)])
	mut var_parent_controller := rt.call_method(var_post_type_object, 'get_rest_controller', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_parent_controller)))) {
		var_parent_controller = create_wp_rest_global_styles_controller(rt.new_string(parent_post_type).dup())
	}
	this.parent_controller = var_parent_controller.dup()
	this.dispatch_set_prop('rest_base', rt.new_string('revisions'))
	this.parent_base = if !(!rt.is_true(rt.get_property(var_post_type_object, 'rest_base'))) { rt.get_property(var_post_type_object, 'rest_base') } else { rt.get_property(var_post_type_object, 'name') }
	this.dispatch_set_prop('namespace', if !(!rt.is_true(rt.get_property(var_post_type_object, 'rest_namespace'))) { rt.get_property(var_post_type_object, 'rest_namespace') } else { rt.new_string('wp/v2') })
}

fn (mut this Class_WP_REST_Global_Styles_Revisions_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Global_Styles_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this), 'namespace'), '/' + (this.parent_base).str() + '/(?P<parent>[\\d]+)/' + rt.get_property(rt.new_object('WP_REST_Global_Styles_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this), 'rest_base'), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'parent', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The ID for the parent of the revision.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Global_Styles_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Global_Styles_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Global_Styles_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Global_Styles_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this), 'namespace'), '/' + (this.parent_base).str() + '/(?P<parent>[\\d]+)/' + rt.get_property(rt.new_object('WP_REST_Global_Styles_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this), 'rest_base') + '/(?P<id>[\\d]+)', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'parent', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The ID for the parent of the global styles revision.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the global styles revision.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Global_Styles_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Global_Styles_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Global_Styles_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WP_REST_Global_Styles_Revisions_Controller) get_decoded_global_styles_json(var_raw_json rt.PhpVal) rt.PhpVal {
	mut var_decoded_json := rt.call_function('json_decode', [var_raw_json.dup(), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_decoded_json.dup().is_array())) && var_decoded_json.array_isset(rt.new_string('isGlobalStylesUserThemeJSON')))) && rt.is_true(rt.identical(rt.new_bool(true), var_decoded_json.array_get('isGlobalStylesUserThemeJSON'))))) {
		return var_decoded_json.dup()
	}
	return create_wp_error(rt.new_string('rest_global_styles_not_found'), rt.call_function('__', [rt.new_string('Cannot find user global styles revisions.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
}

fn (mut this Class_WP_REST_Global_Styles_Revisions_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_parent := this.get_parent(var_request.array_get('parent'))
	if rt.is_true(rt.call_function('is_wp_error', [var_parent.dup()])) {
		return var_parent.dup()
	}
	mut var_global_styles_config := this.get_decoded_global_styles_json(rt.get_property(var_parent, 'post_content'))
	if rt.is_true(rt.call_function('is_wp_error', [var_global_styles_config.dup()])) {
		return var_global_styles_config.dup()
	}
	mut var_is_head_request := rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])
	if rt.is_true(rt.call_function('wp_revisions_enabled', [var_parent.dup()])) {
		mut var_registered := this.get_collection_params()
		mut var_query_args := rt.create_array([rt.ArrayItem{ key: 'post_parent', val: rt.get_property(var_parent, 'ID') }, rt.ArrayItem{ key: 'post_type', val: 'revision' }, rt.ArrayItem{ key: 'post_status', val: 'inherit' }, rt.ArrayItem{ key: 'posts_per_page', val: // unsupported expression: Expr_UnaryMinus }, rt.ArrayItem{ key: 'orderby', val: 'date ID' }, rt.ArrayItem{ key: 'order', val: 'DESC' }])
		mut var_parameter_mappings := { 'offset': 'offset', 'page': 'paged', 'per_page': 'posts_per_page' }
		for var_api_param, var_wp_param in var_parameter_mappings {
			if var_registered.array_isset(rt.new_string(api_param)) && var_request.array_isset(rt.new_string(api_param)) {
				var_query_args.array_set(wp_param, var_request.array_get(api_param))
			}
		}
		if rt.is_true(var_is_head_request) {
			var_query_args.array_set('fields', 'ids')
			var_query_args.array_set('update_post_term_cache', false)
			var_query_args.array_set('update_post_meta_cache', false)
		}
		mut var_revisions_query := create_wp_query()
		mut var_revisions := var_revisions_query.query(var_query_args.dup())
		mut var_offset := if var_query_args.array_isset(rt.new_string('offset')) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
		mut var_page := if var_query_args.array_isset(rt.new_string('paged')) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
		mut var_total_revisions := rt.get_property(var_revisions_query, 'found_posts')
		if rt.is_true(rt.less(var_total_revisions, rt.new_int(1))) {
			var_query_args.array_unset(rt.new_string('paged'))
			var_query_args.array_unset(rt.new_string('offset'))
			mut var_count_query := create_wp_query()
			var_query_args.array_set('fields', 'ids')
			var_query_args.array_set('posts_per_page', 1)
			var_query_args.array_set('update_post_meta_cache', false)
			var_query_args.array_set('update_post_term_cache', false)
			var_count_query.query(var_query_args.dup())
			var_total_revisions = rt.get_property(var_count_query, 'found_posts')
		}
		if rt.is_true(rt.greater(rt.get_property(var_revisions_query, 'query_vars').array_get('posts_per_page'), rt.new_int(0))) {
			mut var_max_pages := // unsupported expression: Expr_Cast_Int
		} else {
			var_max_pages = rt.new_int(if rt.is_true(rt.greater(var_total_revisions, rt.new_int(0))) { rt.new_int(1) } else { rt.new_int(0) })
		}
		if rt.is_true(rt.greater(var_total_revisions, rt.new_int(0))) {
			if rt.is_true(rt.greater_equal(var_offset, var_total_revisions)) {
				return create_wp_error(rt.new_string('rest_revision_invalid_offset_number'), rt.call_function('__', [rt.new_string('The offset number requested is larger than or equal to the number of available revisions.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
			} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_offset)))) && rt.is_true(rt.greater(var_page, var_max_pages)))) {
				return create_wp_error(rt.new_string('rest_revision_invalid_page_number'), rt.call_function('__', [rt.new_string('The page number requested is larger than the number of pages available.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
			}
		}
	} else {
		var_revisions = rt.new_array()
		var_total_revisions = rt.new_int(rt.new_int(0))
		var_max_pages = rt.new_int(rt.new_int(0))
		var_page = // unsupported expression: Expr_Cast_Int
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_head_request)))) {
		mut var_response := rt.new_array()
		{
			mut iter_1 := var_revisions.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_revision := item_1.val
				mut var_data := this.prepare_item_for_response(var_revision.dup(), var_request.dup())
				var_response.array_push(this.prepare_response_for_collection(var_data.dup()))
			}
		}
		var_response = rt.call_function('rest_ensure_response', [var_response.dup()])
	} else {
		var_response = create_wp_rest_response(rt.new_array())
	}
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'), // unsupported expression: Expr_Cast_Int])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'), // unsupported expression: Expr_Cast_Int])
	mut var_request_params := rt.call_method(var_request, 'get_query_params', []rt.PhpVal{})
	mut var_base_path := rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('%s/%s/%d/%s'), rt.get_property(rt.new_object('WP_REST_Global_Styles_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this), 'namespace'), this.parent_base, var_request.array_get('parent'), rt.get_property(rt.new_object('WP_REST_Global_Styles_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this), 'rest_base')])])
	mut var_base := rt.call_function('add_query_arg', [rt.call_function('urlencode_deep', [var_request_params.dup()]), var_base_path.dup()])
	if rt.is_true(rt.greater(var_page, rt.new_int(1))) {
		mut var_prev_page := rt.sub(var_page, rt.new_int(1))
		if rt.is_true(rt.greater(var_prev_page, var_max_pages)) {
			var_prev_page = var_max_pages.dup()
		}
		mut var_prev_link := rt.call_function('add_query_arg', [rt.new_string('page'), var_prev_page.dup(), var_base.dup()])
		rt.call_method(var_response, 'link_header', [rt.new_string('prev'), var_prev_link.dup()])
	}
	if rt.is_true(rt.greater(var_max_pages, var_page)) {
		mut var_next_page := rt.add(var_page, rt.new_int(1))
		mut var_next_link := rt.call_function('add_query_arg', [rt.new_string('page'), var_next_page.dup(), var_base.dup()])
		rt.call_method(var_response, 'link_header', [rt.new_string('next'), var_next_link.dup()])
	}
	return var_response.dup()
}

fn (mut this Class_WP_REST_Global_Styles_Revisions_Controller) prepare_item_for_response(var_post rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])) {
		return create_wp_rest_response(rt.new_array())
	}
	mut var_parent := this.get_parent(var_request.array_get('parent'))
	mut var_global_styles_config := this.get_decoded_global_styles_json(rt.get_property(var_post, 'post_content'))
	if rt.is_true(rt.call_function('is_wp_error', [var_global_styles_config.dup()])) {
		return var_global_styles_config.dup()
	}
	mut var_fields := this.get_fields_for_response(var_request.dup())
	mut var_data := rt.new_array()
	mut var_theme_json := rt.new_null()
	if !(!rt.is_true(var_global_styles_config.array_get('styles'))) || !(!rt.is_true(var_global_styles_config.array_get('settings'))) {
		if !(!rt.is_true(var_global_styles_config.array_get('styles').array_get('blocks'))) {
			mut var_variations := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Theme_JSON_Resolver{}; return temp.get_style_variations(arg_0) }(rt.new_string('block'))
			rt.call_function('wp_register_block_style_variations_from_theme_json_partials', [var_variations.dup()])
		}
		var_theme_json = create_wp_theme_json(var_global_styles_config.dup(), rt.new_string('custom'))
		var_global_styles_config = rt.call_method(var_theme_json, 'get_raw_data', []rt.PhpVal{})
		if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('settings'), var_fields.dup()])) {
			var_data.array_set('settings', if !(!rt.is_true(var_global_styles_config.array_get('settings'))) { var_global_styles_config.array_get('settings') } else { create_stdclass() })
		}
		if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('styles'), var_fields.dup()])) {
			var_data.array_set('styles', if !(!rt.is_true(var_global_styles_config.array_get('styles'))) { var_global_styles_config.array_get('styles') } else { create_stdclass() })
		}
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('author'), var_fields.dup()])) {
		var_data.array_set('author', // unsupported expression: Expr_Cast_Int)
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('date'), var_fields.dup()])) {
		var_data.array_set('date', this.prepare_date_response(rt.get_property(var_post, 'post_date_gmt'), rt.get_property(var_post, 'post_date')))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('date_gmt'), var_fields.dup()])) {
		var_data.array_set('date_gmt', this.prepare_date_response(rt.get_property(var_post, 'post_date_gmt')))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('id'), var_fields.dup()])) {
		var_data.array_set('id', // unsupported expression: Expr_Cast_Int)
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('modified'), var_fields.dup()])) {
		var_data.array_set('modified', this.prepare_date_response(rt.get_property(var_post, 'post_modified_gmt'), rt.get_property(var_post, 'post_modified')))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('modified_gmt'), var_fields.dup()])) {
		var_data.array_set('modified_gmt', this.prepare_date_response(rt.get_property(var_post, 'post_modified_gmt')))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('parent'), var_fields.dup()])) {
		var_data.array_set('parent', // unsupported expression: Expr_Cast_Int)
	}
	mut var_context := if !(!rt.is_true(var_request.array_get('context'))) { var_request.array_get('context') } else { rt.new_string('view') }
	var_data = this.add_additional_fields_to_object(var_data.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	mut var_resolved_theme_uris := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Theme_JSON_Resolver{}; return temp.get_resolved_theme_uris(arg_0) }(var_theme_json.dup())
	if !(!rt.is_true(var_resolved_theme_uris)) {
		rt.call_method(var_response, 'add_links', [rt.create_array([rt.ArrayItem{ key: 'https://api.w.org/theme-file', val: var_resolved_theme_uris }])])
	}
	return var_response.dup()
}

fn (mut this Class_WP_REST_Global_Styles_Revisions_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Global_Styles_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this), 'schema')) {
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Global_Styles_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this), 'schema'))
	}
	mut var_schema := this.Class_WP_REST_Revisions_Controller.get_item_schema()
	mut var_parent_schema := rt.call_method(this.parent_controller, 'get_item_schema', []rt.PhpVal{})
	var_schema.array_set('properties', rt.call_function('array_merge', [, ]))
	.array_get().array_unset(rt.new_string('guid'))
	.array_get().array_unset(rt.new_string('slug'))
	.array_get().array_unset(rt.new_string('meta'))
	.array_get().array_unset(rt.new_string('content'))
	.array_get().array_unset(rt.new_string('title'))
	
}

fn (mut this Class_WP_REST_Global_Styles_Revisions_Controller) get_collection_params() rt.PhpVal {
}

struct Class_WP_REST_Revisions_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Global_Styles_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

struct Class_WP_Theme_JSON_Resolver {
	rt.PhpObjectBase
}

struct Class_WP_Theme_JSON {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_wp_rest_global_styles_revisions_controller(parent_post_type string) &Class_WP_REST_Global_Styles_Revisions_Controller {
	mut obj := &Class_WP_REST_Global_Styles_Revisions_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		parent_controller: rt.new_null()
		parent_base: rt.new_null()
		parent_post_type: rt.new_null()
	}
	obj.construct(parent_post_type)
	return obj
}

fn create_wp_rest_revisions_controller() &Class_WP_REST_Revisions_Controller {
	mut obj := &Class_WP_REST_Revisions_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_global_styles_controller() &Class_WP_REST_Global_Styles_Controller {
	mut obj := &Class_WP_REST_Global_Styles_Controller{
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

fn create_wp_query() &Class_WP_Query {
	mut obj := &Class_WP_Query{
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

fn create_wp_theme_json_resolver() &Class_WP_Theme_JSON_Resolver {
	mut obj := &Class_WP_Theme_JSON_Resolver{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_theme_json() &Class_WP_Theme_JSON {
	mut obj := &Class_WP_Theme_JSON{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_stdclass() &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Global_Styles_Revisions_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_decoded_global_styles_json' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_decoded_global_styles_json(dispatch_arg_0)
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
		else { return none }
	}
}

fn (this &Class_WP_REST_Global_Styles_Revisions_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'parent_controller' { return this.parent_controller }
		'parent_base' { return this.parent_base }
		'parent_post_type' { return this.parent_post_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Global_Styles_Revisions_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'parent_controller' { this.parent_controller = val; return true }
		'parent_base' { this.parent_base = val; return true }
		'parent_post_type' { this.parent_post_type = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_REST_Revisions_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Revisions_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Revisions_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Global_Styles_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Global_Styles_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Global_Styles_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_Theme_JSON_Resolver) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme_JSON_Resolver) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme_JSON_Resolver) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Theme_JSON) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme_JSON) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme_JSON) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_global_styles_revisions_controller_php() {
}
