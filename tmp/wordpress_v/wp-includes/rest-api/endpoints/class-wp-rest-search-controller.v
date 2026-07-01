import rt

pub fn Class_WP_REST_Search_Controller.prop_id() string {
	return 'id'
}
pub fn Class_WP_REST_Search_Controller.prop_title() string {
	return 'title'
}
pub fn Class_WP_REST_Search_Controller.prop_url() string {
	return 'url'
}
pub fn Class_WP_REST_Search_Controller.prop_type() string {
	return 'type'
}
pub fn Class_WP_REST_Search_Controller.prop_subtype() string {
	return 'subtype'
}
pub fn Class_WP_REST_Search_Controller.type_any() string {
	return 'any'
}
struct Class_WP_REST_Search_Controller {
	rt.PhpObjectBase
pub mut:
		search_handlers rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_REST_Search_Controller) construct(mut var_search_handlers Class_array)  {
	this.dispatch_set_prop('namespace', rt.new_string('wp/v2'))
	this.dispatch_set_prop('rest_base', rt.new_string('search'))
	{
		mut iter_1 := var_search_handlers.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_search_handler := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_search_handler, 'WP_REST_Search_Handler')))))) {
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('REST search handlers must extend the %s class.')]), rt.new_string('WP_REST_Search_Handler')]), rt.new_string('5.0.0')])
				continue
			}
			this.search_handlers.array_set(rt.call_method(var_search_handler, 'get_type', []rt.PhpVal{}), var_search_handler.dup())
		}
	}
}

fn (mut this Class_WP_REST_Search_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Search_Controller', ['WP_REST_Controller'], &this), 'namespace'), '/' + rt.get_property(rt.new_object('WP_REST_Search_Controller', ['WP_REST_Controller'], &this), 'rest_base'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Search_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Search_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permission_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Search_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WP_REST_Search_Controller) get_items_permission_check(var_request rt.PhpVal) bool {
	return true
}

fn (mut this Class_WP_REST_Search_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_handler := this.get_search_handler(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_handler.dup()])) {
		return var_handler.dup()
	}
	mut var_result := rt.call_method(var_handler, 'search_items', [var_request.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(var_result.array_isset(Class_WP_REST_Search_Handler.result_ids())) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_result.array_get(Class_WP_REST_Search_Handler.result_ids()).is_array()))))))) || !(var_result.array_isset(Class_WP_REST_Search_Handler.result_total())))) {
		return create_wp_error(rt.new_string('rest_search_handler_error'), rt.call_function('__', [rt.new_string('Internal search handler error.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
	}
	mut var_ids := var_result.array_get(Class_WP_REST_Search_Handler.result_ids())
	mut var_is_head_request := rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_head_request)))) {
		mut var_results := []rt.PhpVal{}
		{
			mut iter_1 := var_ids.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_id := item_1.val
				mut var_data := this.prepare_item_for_response(var_id.dup(), var_request.dup())
				var_results << this.prepare_response_for_collection(var_data.dup())
			}
		}
	}
	mut var_total := // unsupported expression: Expr_Cast_Int
	mut var_page := // unsupported expression: Expr_Cast_Int
	mut var_per_page := // unsupported expression: Expr_Cast_Int
	mut var_max_pages := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_page, var_max_pages)) && rt.is_true(rt.greater(var_total, rt.new_int(0))))) {
		return create_wp_error(rt.new_string('rest_search_invalid_page_number'), rt.call_function('__', [rt.new_string('The page number requested is larger than the number of pages available.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_response := if rt.is_true(var_is_head_request) { create_wp_rest_response([]rt.PhpVal{}) } else { rt.call_function('rest_ensure_response', [var_results.dup()]) }
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'), var_total.dup()])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'), var_max_pages.dup()])
	mut var_request_params := rt.call_method(var_request, 'get_query_params', []rt.PhpVal{})
	mut var_base := rt.call_function('add_query_arg', [rt.call_function('urlencode_deep', [var_request_params.dup()]), rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('%s/%s'), rt.get_property(rt.new_object('WP_REST_Search_Controller', ['WP_REST_Controller'], &this), 'namespace'), rt.get_property(rt.new_object('WP_REST_Search_Controller', ['WP_REST_Controller'], &this), 'rest_base')])])])
	if rt.is_true(rt.greater(var_page, rt.new_int(1))) {
		mut var_prev_link := rt.call_function('add_query_arg', [rt.new_string('page'), rt.sub(var_page, rt.new_int(1)), var_base.dup()])
		rt.call_method(var_response, 'link_header', [rt.new_string('prev'), var_prev_link.dup()])
	}
	if rt.is_true(rt.less(var_page, var_max_pages)) {
		mut var_next_link := rt.call_function('add_query_arg', [rt.new_string('page'), rt.add(var_page, rt.new_int(1)), var_base.dup()])
		rt.call_method(var_response, 'link_header', [rt.new_string('next'), var_next_link.dup()])
	}
	return var_response.dup()
}

fn (mut this Class_WP_REST_Search_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_item_id := var_item
	mut var_handler := this.get_search_handler(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_handler.dup()])) {
		return create_wp_rest_response()
	}
	mut var_fields := this.get_fields_for_response(var_request.dup())
	mut var_data := rt.call_method(var_handler, 'prepare_item', [var_item_id.dup(), var_fields.dup()])
	var_data = this.add_additional_fields_to_object(var_data.dup(), var_request.dup())
	mut var_context := if !(!rt.is_true(var_request.array_get('context'))) { var_request.array_get('context') } else { rt.new_string('view') }
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_links'), var_fields.dup()])) || rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_embedded'), var_fields.dup()])))) {
		mut var_links := rt.call_method(var_handler, 'prepare_item_links', [var_item_id.dup()])
		var_links.array_set('collection', rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('%s/%s'), rt.get_property(rt.new_object('WP_REST_Search_Controller', ['WP_REST_Controller'], &this), 'namespace'), rt.get_property(rt.new_object('WP_REST_Search_Controller', ['WP_REST_Controller'], &this), 'rest_base')])]) }]))
		rt.call_method(var_response, 'add_links', [var_links.dup()])
	}
	return var_response.dup()
}

fn (mut this Class_WP_REST_Search_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Search_Controller', ['WP_REST_Controller'], &this), 'schema')) {
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Search_Controller', ['WP_REST_Controller'], &this), 'schema'))
	}
	mut var_types := []rt.PhpVal{}
	mut var_subtypes := []rt.PhpVal{}
	{
		mut iter_1 := this.search_handlers.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_search_handler := item_1.val
			var_types.array_push(rt.call_method(var_search_handler, 'get_type', []rt.PhpVal{}))
			var_subtypes = rt.call_function('array_merge', [var_subtypes.dup(), rt.call_method(var_search_handler, 'get_subtypes', []rt.PhpVal{})])
		}
	}
	var_types = rt.call_function('array_unique', [var_types.dup()])
	var_subtypes = rt.call_function('array_unique', [var_subtypes.dup()])
	mut var_schema := { '$schema': rt.new_string('http://json-schema.org/draft-04/schema#'), 'title': rt.new_string('search-result'), 'type': rt.new_string('object'), 'properties': { Class_WP_REST_Search_Controller.prop_id(): { 'description': rt.call_function('__', [rt.new_string('Unique identifier for the object.')]), 'type': map[string]rt.PhpVal{}, 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, Class_WP_REST_Search_Controller.prop_title(): { 'description': rt.call_function('__', [rt.new_string('The title for the object.')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, Class_WP_REST_Search_Controller.prop_url(): { 'description': rt.call_function('__', [rt.new_string('URL to the object.')]), 'type': rt.new_string('string'), 'format': rt.new_string('uri'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, Class_WP_REST_Search_Controller.prop_type(): { 'description': rt.call_function('__', [rt.new_string('Object type.')]), 'type': rt.new_string('string'), 'enum': var_types, 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, Class_WP_REST_Search_Controller.prop_subtype(): { 'description': rt.call_function('__', [rt.new_string('Object subtype.')]), 'type': rt.new_string('string'), 'enum': var_subtypes, 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) } } }
	this.dispatch_set_prop('schema', var_schema.dup())
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Search_Controller', ['WP_REST_Controller'], &this), 'schema'))
}

fn (mut this Class_WP_REST_Search_Controller) get_collection_params() rt.PhpVal {
	mut var_types := []rt.PhpVal{}
	mut var_subtypes := []rt.PhpVal{}
	{
		mut iter_1 := this.search_handlers.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_search_handler := item_1.val
			var_types.array_push(rt.call_method(var_search_handler, 'get_type', []rt.PhpVal{}))
			var_subtypes = rt.call_function('array_merge', [var_subtypes.dup(), rt.call_method(var_search_handler, 'get_subtypes', []rt.PhpVal{})])
		}
	}
	var_types = rt.call_function('array_unique', [var_types.dup()])
	var_subtypes = rt.call_function('array_unique', [var_subtypes.dup()])
	mut var_query_params := this.Class_WP_REST_Controller.get_collection_params()
	var_query_params.array_get_mut('context').array_set('default', 'view')
	var_query_params.array_set(Class_WP_REST_Search_Controller.prop_type(), rt.create_array([rt.ArrayItem{ key: 'default', val: var_types.array_get(0) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit results to items of an object type.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: var_types }]))
	var_query_params.array_set(Class_WP_REST_Search_Controller.prop_subtype(), rt.create_array([rt.ArrayItem{ key: 'default', val: Class_WP_REST_Search_Controller.type_any() }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit results to items of one or more object subtypes.')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'enum', val: rt.call_function('array_merge', [var_subtypes.dup(), rt.create_array([rt.ArrayItem{ key: none, val: Class_WP_REST_Search_Controller.type_any() }])]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Search_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'sanitize_subtypes' }]) }]))
	var_query_params.array_set('exclude', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Ensure result set excludes specific IDs.')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'default', val: []rt.PhpVal{} }]))
	var_query_params.array_set('include', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to specific IDs.')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'default', val: []rt.PhpVal{} }]))
	return var_query_params.dup()
}

fn (mut this Class_WP_REST_Search_Controller) sanitize_subtypes(var_subtypes rt.PhpVal, var_request rt.PhpVal, var_parameter rt.PhpVal) rt.PhpVal {
	mut var_subtypes_mutated := var_subtypes
	var_subtypes_mutated = rt.call_function('wp_parse_slug_list', [var_subtypes_mutated.dup()])
	var_subtypes_mutated = rt.call_function('rest_parse_request_arg', [var_subtypes_mutated.dup(), var_request.dup(), var_parameter.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_subtypes_mutated.dup()])) {
		return var_subtypes_mutated.dup()
	}
	if rt.is_true(rt.call_function('in_array', [Class_WP_REST_Search_Controller.type_any(), var_subtypes_mutated.dup(), rt.new_bool(true)])) {
		return rt.create_array([rt.ArrayItem{ key: none, val: Class_WP_REST_Search_Controller.type_any() }])
	}
	mut var_handler := this.get_search_handler(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_handler.dup()])) {
		return var_handler.dup()
	}
	return rt.call_function('array_intersect', [var_subtypes_mutated.dup(), rt.call_method(var_handler, 'get_subtypes', []rt.PhpVal{})])
}

fn (mut this Class_WP_REST_Search_Controller) get_search_handler(var_request rt.PhpVal) rt.PhpVal {
	mut var_type := rt.call_method(var_request, 'get_param', [Class_WP_REST_Search_Controller.prop_type()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_type)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_type.dup().is_string()))))))) || !(this.search_handlers.array_isset(var_type)))) {
		return create_wp_error(rt.new_string('rest_search_invalid_type'), rt.call_function('__', [rt.new_string('Invalid type parameter.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	return this.search_handlers.array_get(var_type)
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

fn create_wp_rest_search_controller(arg_0 rt.PhpVal) &Class_WP_REST_Search_Controller {
	mut obj := &Class_WP_REST_Search_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		search_handlers: rt.new_array()
	}
	obj.construct(arg_0)
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

fn (mut this Class_WP_REST_Search_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_items_permission_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permission_check(dispatch_arg_0))
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
		'sanitize_subtypes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.sanitize_subtypes(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_search_handler' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_search_handler(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WP_REST_Search_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'search_handlers' { return this.search_handlers }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Search_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'search_handlers' { this.search_handlers = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_search_controller_php() {
}
