import rt

struct Class_WP_REST_Font_Collections_Controller {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_Font_Collections_Controller) construct() {
	this.dispatch_set_prop('rest_base', rt.new_string('font-collections'))
	this.dispatch_set_prop('namespace', rt.new_string('wp/v2'))
}

fn (mut this Class_WP_REST_Font_Collections_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Font_Collections_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Font_Collections_Controller', ['WP_REST_Controller'], &this), 'rest_base')),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Collections_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Collections_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Collections_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Font_Collections_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Font_Collections_Controller', ['WP_REST_Controller'], &this), 'rest_base') +
			'/(?P<slug>[\\/\\w-]+)'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Collections_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Collections_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
						rt.ArrayItem{ key: 'default', val: 'view' },
					])) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Collections_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
}

fn (mut this Class_WP_REST_Font_Collections_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_WP_Font_Library{}
	mut iife_result_0 := iife_temp_0.get_instance()
	mut var_collections_all := rt.call_method(iife_result_0, 'get_font_collections', []rt.PhpVal{})
	mut var_page := var_request.array_get(rt.new_string('page'))
	mut var_per_page := var_request.array_get(rt.new_string('per_page'))
	mut var_total_items := rt.new_int(var_collections_all.clone().array_count())
	mut var_max_pages := rt.new_int((rt.call_function('ceil', [
		rt.div(var_total_items, var_per_page),
	])).to_i64())
	if rt.is_true(rt.greater(var_page, var_max_pages))
		&& rt.is_true(rt.greater(var_total_items, rt.new_int(0))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_post_invalid_page_number'), rt.call_function('__', [
			rt.new_string('The page number requested is larger than the number of pages available.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	mut var_collections_page := rt.call_function('array_slice', [
		var_collections_all.clone(), rt.mul(rt.sub(var_page, rt.new_int(1)), var_per_page),
		var_per_page.clone()])
	mut var_is_head_request := rt.call_method(var_request, 'is_method', [
		rt.new_string('HEAD'),
	])
	mut var_items := []rt.PhpVal{}
	mut iter_1 := var_collections_page.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_collection := item_1.val
		mut var_item := this.prepare_item_for_response(var_collection.clone(), var_request.clone())
		if rt.is_true(rt.call_function('is_wp_error', [var_item.clone()])) {
			continue
		}
		if rt.is_true(var_is_head_request) {
			continue
		}
		var_item = this.prepare_response_for_collection(var_item.clone())
		var_items << var_item.clone()
	}
	mut var_response := if rt.is_true(var_is_head_request) { create_wp_rest_response([]rt.PhpVal{}) } else { rt.call_function('rest_ensure_response', [
			rt.create_array_from_list(var_items),
		]) }
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'),
		rt.new_int(var_total_items.to_i64())])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'),
		var_max_pages.clone()])
	mut var_request_params := rt.call_method(var_request, 'get_query_params', []rt.PhpVal{})
	mut var_collection_url := rt.call_function('rest_url', [
		rt.new_string((
			rt.get_property(rt.new_object('WP_REST_Font_Collections_Controller', ['WP_REST_Controller'], &this), 'namespace') +
			'/' +
			rt.get_property(rt.new_object('WP_REST_Font_Collections_Controller', ['WP_REST_Controller'], &this), 'rest_base')).str()),
	])
	mut var_base := rt.call_function('add_query_arg', [
		rt.call_function('urlencode_deep', [var_request_params.clone()]),
		var_collection_url.clone(),
	])
	if rt.is_true(rt.greater(var_page, rt.new_int(1))) {
		mut var_prev_page := rt.sub(var_page, rt.new_int(1))
		if rt.is_true(rt.greater(var_prev_page, var_max_pages)) {
			var_prev_page = var_max_pages.clone()
		}
		mut var_prev_link := rt.call_function('add_query_arg', [
			rt.new_string('page'), var_prev_page.clone(), var_base.clone()])
		rt.call_method(var_response, 'link_header', [rt.new_string('prev'),
			var_prev_link.clone()])
	}
	if rt.is_true(rt.greater(var_max_pages, var_page)) {
		mut var_next_page := rt.add(var_page, rt.new_int(1))
		mut var_next_link := rt.call_function('add_query_arg', [
			rt.new_string('page'), var_next_page.clone(), var_base.clone()])
		rt.call_method(var_response, 'link_header', [rt.new_string('next'),
			var_next_link.clone()])
	}
	return var_response.clone()
}

fn (mut this Class_WP_REST_Font_Collections_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_slug := rt.call_method(var_request, 'get_param', [
		rt.new_string('slug')])
	mut iife_temp_1 := Class_WP_Font_Library{}
	mut iife_result_1 := iife_temp_1.get_instance()
	mut var_collection := rt.call_method(iife_result_1, 'get_font_collection', [
		var_slug.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_collection)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_font_collection_not_found'), rt.call_function('__', [
			rt.new_string('Font collection not found.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	return this.prepare_item_for_response(var_collection.clone(), var_request.clone())
}

fn (mut this Class_WP_REST_Font_Collections_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	mut var_fields := this.get_fields_for_response(var_request.clone())
	mut var_data := []rt.PhpVal{}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('slug'), var_fields.clone()]))
	{
		var_data.array_set('slug', rt.get_property(var_item_mutated, 'slug'))
	}
	mut var_data_fields := ['name', 'description', 'font_families', 'categories']
	if !(!rt.is_true(rt.call_function('array_intersect', [var_fields.clone(),
		rt.create_array_from_list(var_data_fields)]))) {
		mut var_collection_data := rt.call_method(var_item_mutated, 'get_data', []rt.PhpVal{})
		if rt.is_true(rt.call_function('is_wp_error', [var_collection_data.clone()])) {
			rt.call_method(var_collection_data, 'add_data', [
				rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]),
			])
			return var_collection_data.clone()
		}
		if rt.is_true(rt.call_method(var_request, 'is_method', [
			rt.new_string('HEAD')]))
		{
			return rt.call_function('apply_filters', [
				rt.new_string('rest_prepare_font_collection'),
				create_wp_rest_response([]rt.PhpVal{}),
				var_item_mutated.clone(),
				var_request.clone(),
			])
		}
		for var_field in var_data_fields {
			if rt.is_true(rt.call_function('rest_is_field_included', [
				rt.new_string(field),
				var_fields.clone(),
			]))
			{
				var_data.array_set(field, var_collection_data.array_get(rt.new_string(field)))
			}
		}
	}
	if rt.is_true(rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])) {
		return rt.call_function('apply_filters', [
			rt.new_string('rest_prepare_font_collection'),
			create_wp_rest_response([]rt.PhpVal{}),
			var_item_mutated.clone(),
			var_request.clone(),
		])
	}
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('_links'), var_fields.clone()]))
	{
		mut var_links := this.prepare_links(var_item_mutated.clone())
		rt.call_method(var_response, 'add_links', [var_links.clone()])
	}
	mut var_context := if !(!rt.is_true(var_request.array_get(rt.new_string('context')))) {
		var_request.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	rt.set_property(var_response, 'data', this.add_additional_fields_to_object(rt.get_property(var_response,
		'data'), var_request.clone()))
	rt.set_property(var_response, 'data', this.filter_response_by_context(rt.get_property(var_response,
		'data'), var_context.clone()))
	return rt.call_function('apply_filters', [
		rt.new_string('rest_prepare_font_collection'),
		var_response.clone(),
		var_item_mutated.clone(),
		var_request.clone(),
	])
}

fn (mut this Class_WP_REST_Font_Collections_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Font_Collections_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
	{
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Font_Collections_Controller', [
			'WP_REST_Controller',
		], &this), 'schema'))
	}
	mut var_schema := {
		'$schema':    rt.new_string('http://json-schema.org/draft-04/schema#')
		'title':      rt.new_string('font-collection')
		'type':       rt.new_string('object')
		'properties': {
			'slug':          {
				'description': rt.call_function('__', [
					rt.new_string('Unique identifier for the font collection.'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'name':          {
				'description': rt.call_function('__', [
					rt.new_string('The name for the font collection.'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
			}
			'description':   {
				'description': rt.call_function('__', [
					rt.new_string('The description for the font collection.'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
			}
			'font_families': {
				'description': rt.call_function('__', [
					rt.new_string('The font families for the font collection.'),
				])
				'type':        rt.new_string('array')
				'context':     map[string]rt.PhpVal{}
			}
			'categories':    {
				'description': rt.call_function('__', [
					rt.new_string('The categories for the font collection.'),
				])
				'type':        rt.new_string('array')
				'context':     map[string]rt.PhpVal{}
			}
		}
	}
	this.dispatch_set_prop('schema', var_schema.clone())
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Font_Collections_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
}

fn (mut this Class_WP_REST_Font_Collections_Controller) prepare_links(var_collection rt.PhpVal) rt.PhpVal {
	mut var_collection_mutated := var_collection
	return rt.create_array([
		rt.ArrayItem{ key: 'self', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('%s/%s/%s'),
					rt.get_property(rt.new_object('WP_REST_Font_Collections_Controller', [
						'WP_REST_Controller',
					], &this), 'namespace'),
					rt.get_property(rt.new_object('WP_REST_Font_Collections_Controller', [
						'WP_REST_Controller',
					], &this), 'rest_base'),
					rt.get_property(var_collection_mutated, 'slug')]),
			]) },
		]) },
		rt.ArrayItem{ key: 'collection', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('%s/%s'),
					rt.get_property(rt.new_object('WP_REST_Font_Collections_Controller', [
						'WP_REST_Controller',
					], &this), 'namespace'),
					rt.get_property(rt.new_object('WP_REST_Font_Collections_Controller', [
						'WP_REST_Controller',
					], &this), 'rest_base')]),
			]) },
		]) },
	])
}

fn (mut this Class_WP_REST_Font_Collections_Controller) get_collection_params() rt.PhpVal {
	mut var_query_params := this.Class_WP_REST_Controller.get_collection_params()
	var_query_params.array_set('context', this.get_context_param(rt.create_array([
		rt.ArrayItem{ key: 'default', val: 'view' },
	])))
	var_query_params.array_unset(rt.new_string('search'))
	return rt.call_function('apply_filters', [
		rt.new_string('rest_font_collections_collection_params'),
		var_query_params.clone(),
	])
}

fn (mut this Class_WP_REST_Font_Collections_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_theme_options'),
	]))
	{
		return true
	}
	return (create_wp_error(rt.new_string('rest_cannot_read'), rt.call_function('__', [
		rt.new_string('Sorry, you are not allowed to access font collections.'),
	]), rt.create_array([
		rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
			[]rt.PhpVal{}) },
	]))).to_bool()
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Font_Library {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

fn create_wp_rest_font_collections_controller() &Class_WP_REST_Font_Collections_Controller {
	mut obj := &Class_WP_REST_Font_Collections_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wp_rest_controller(_args ...rt.PhpVal) &Class_WP_REST_Controller {
	mut obj := &Class_WP_REST_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_font_library(_args ...rt.PhpVal) &Class_WP_Font_Library {
	mut obj := &Class_WP_Font_Library{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_response(_args ...rt.PhpVal) &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Font_Collections_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0)
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_REST_Font_Collections_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Font_Collections_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_Font_Library) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Font_Library) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Font_Library) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
