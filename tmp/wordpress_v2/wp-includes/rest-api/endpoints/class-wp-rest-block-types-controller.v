import rt

pub fn Class_WP_REST_Block_Types_Controller.name_pattern() string {
	return '^[a-z][a-z0-9-]*/[a-z][a-z0-9-]*$'
}

struct Class_WP_REST_Block_Types_Controller {
	rt.PhpObjectBase
pub mut:
	block_registry rt.PhpVal = rt.new_null()
	style_registry rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_REST_Block_Types_Controller) construct() {
	this.dispatch_set_prop('namespace', rt.new_string('wp/v2'))
	this.dispatch_set_prop('rest_base', rt.new_string('block-types'))
	mut iife_temp_0 := Class_WP_Block_Type_Registry{}
	mut iife_result_0 := iife_temp_0.get_instance()
	this.block_registry = iife_result_0
	mut iife_temp_1 := Class_WP_Block_Styles_Registry{}
	mut iife_result_1 := iife_temp_1.get_instance()
	this.style_registry = iife_result_1
}

fn (mut this Class_WP_REST_Block_Types_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Block_Types_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Block_Types_Controller', ['WP_REST_Controller'], &this), 'rest_base')),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Block_Types_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Block_Types_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Block_Types_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Block_Types_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Block_Types_Controller', ['WP_REST_Controller'], &this), 'rest_base') +
			'/(?P<namespace>[a-zA-Z0-9_-]+)'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Block_Types_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Block_Types_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Block_Types_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Block_Types_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Block_Types_Controller', ['WP_REST_Controller'], &this), 'rest_base') +
			'/(?P<namespace>[a-zA-Z0-9_-]+)/(?P<name>[a-zA-Z0-9_-]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Block name.'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'namespace', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Block namespace.'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Block_Types_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Block_Types_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
						rt.ArrayItem{ key: 'default', val: 'view' },
					])) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Block_Types_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
}

fn (mut this Class_WP_REST_Block_Types_Controller) get_items_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	return rt.new_bool(this.check_read_permission())
}

fn (mut this Class_WP_REST_Block_Types_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_block_namespace := rt.new_null()
	if rt.is_true(rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])) {
		return rt.new_object('WP_REST_Response', []string{},
			create_wp_rest_response(rt.new_array()))
	}
	mut var_data := rt.new_array()
	mut var_block_types := rt.call_method(this.block_registry, 'get_all_registered', []rt.PhpVal{})
	mut var_registered := this.get_collection_params()
	mut var_namespace := rt.new_string('')
	if var_registered.array_isset(rt.new_string('namespace'))
		&& !(!rt.is_true(var_request.array_get(rt.new_string('namespace')))) {
		var_namespace = var_request.array_get(rt.new_string('namespace'))
	}
	mut iter_1 := var_block_types.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_obj := item_1.val
		if rt.is_true(var_namespace) {
			mut list_tmp_1 := rt.call_function('explode', [rt.new_string('/'),
				rt.get_property(var_obj, 'name')])
			var_block_namespace = list_tmp_1.array_get(0)
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_namespace, var_block_namespace)))) {
				continue
			}
		}
		mut var_block_type := this.prepare_item_for_response(var_obj.clone(), var_request.clone())
		var_data.array_push(this.prepare_response_for_collection(var_block_type.clone()))
	}
	return rt.call_function('rest_ensure_response', [var_data.clone()])
}

fn (mut this Class_WP_REST_Block_Types_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_check := rt.new_bool(this.check_read_permission())
	if rt.is_true(rt.call_function('is_wp_error', [var_check.clone()])) {
		return var_check.to_bool()
	}
	mut var_block_name := rt.call_function('sprintf', [rt.new_string('%s/%s'),
		var_request.array_get(rt.new_string('namespace')), var_request.array_get(rt.new_string('name'))])
	mut var_block_type := this.get_block(var_block_name.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_block_type.clone()])) {
		return var_block_type.to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Block_Types_Controller) check_read_permission() bool {
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')])) {
		return true
	}
	mut iter_2 := rt.call_function('get_post_types', [
		rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]),
		rt.new_string('objects'),
	]).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_post_type := item_2.val
		if rt.is_true(rt.call_function('current_user_can', [
			rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_posts'),
		]))
		{
			return true
		}
	}
	return (create_wp_error(rt.new_string('rest_block_type_cannot_view'), rt.call_function('__', [
		rt.new_string('Sorry, you are not allowed to manage block types.'),
	]), rt.create_array([
		rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
			[]rt.PhpVal{}) },
	]))).to_bool()
}

fn (mut this Class_WP_REST_Block_Types_Controller) get_block(var_name rt.PhpVal) rt.PhpVal {
	mut var_block_type := rt.call_method(this.block_registry, 'get_registered', [
		var_name.clone(),
	])
	if !rt.is_true(var_block_type) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_block_type_invalid'), rt.call_function('__', [
			rt.new_string('Invalid block type.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	return var_block_type.clone()
}

fn (mut this Class_WP_REST_Block_Types_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_block_name := rt.call_function('sprintf', [rt.new_string('%s/%s'),
		var_request.array_get(rt.new_string('namespace')), var_request.array_get(rt.new_string('name'))])
	mut var_block_type := this.get_block(var_block_name.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_block_type.clone()])) {
		return var_block_type.clone()
	}
	mut var_data := this.prepare_item_for_response(var_block_type.clone(), var_request.clone())
	return rt.call_function('rest_ensure_response', [var_data.clone()])
}

fn (mut this Class_WP_REST_Block_Types_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_block_type := var_item
	if rt.is_true(rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])) {
		return rt.call_function('apply_filters', [
			rt.new_string('rest_prepare_block_type'),
			create_wp_rest_response(rt.new_array()),
			var_block_type.clone(),
			var_request.clone(),
		])
	}
	mut var_fields := this.get_fields_for_response(var_request.clone())
	mut var_data := rt.new_array()
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('attributes'),
		var_fields.clone(),
	]))
	{
		var_data.array_set('attributes', rt.call_method(var_block_type, 'get_attributes',
			[]rt.PhpVal{}))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('is_dynamic'),
		var_fields.clone(),
	]))
	{
		var_data.array_set('is_dynamic',
			rt.call_method(var_block_type, 'is_dynamic', []rt.PhpVal{}))
	}
	mut var_schema := this.get_item_schema()
	mut var_deprecated_fields := ['editor_script', 'script', 'view_script', 'editor_style', 'style']
	mut var_extra_fields := rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'api_version' },
			rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'title' },
			rt.ArrayItem{ key: none, val: 'description' }, rt.ArrayItem{ key: none, val: 'icon' },
			rt.ArrayItem{ key: none, val: 'category' }, rt.ArrayItem{ key: none, val: 'keywords' },
			rt.ArrayItem{ key: none, val: 'parent' }, rt.ArrayItem{ key: none, val: 'ancestor' },
			rt.ArrayItem{ key: none, val: 'allowed_blocks' },
			rt.ArrayItem{ key: none, val: 'provides_context' },
			rt.ArrayItem{ key: none, val: 'uses_context' }, rt.ArrayItem{
				key: none
				val: 'selectors'
			}, rt.ArrayItem{ key: none, val: 'supports' }, rt.ArrayItem{ key: none, val: 'styles' },
			rt.ArrayItem{ key: none, val: 'textdomain' }, rt.ArrayItem{ key: none, val: 'example' },
			rt.ArrayItem{ key: none, val: 'editor_script_handles' },
			rt.ArrayItem{ key: none, val: 'script_handles' },
			rt.ArrayItem{ key: none, val: 'view_script_handles' },
			rt.ArrayItem{ key: none, val: 'view_script_module_ids' },
			rt.ArrayItem{ key: none, val: 'editor_style_handles' },
			rt.ArrayItem{ key: none, val: 'style_handles' }, rt.ArrayItem{
				key: none
				val: 'view_style_handles'
			}, rt.ArrayItem{ key: none, val: 'variations' }, rt.ArrayItem{
				key: none
				val: 'block_hooks'
			}]),
		rt.create_array_from_list(var_deprecated_fields),
	])
	mut iter_3 := var_extra_fields.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_extra_field := item_3.val
		if rt.is_true(rt.call_function('rest_is_field_included', [
			var_extra_field.clone(), var_fields.clone()]))
		{
			if !(rt.get_property(var_block_type,
				'{"nodeType":"Expr_Variable","line":317,"name":"extra_field"}')).is_null() {
				mut var_field := rt.get_property(var_block_type,
					'{"nodeType":"Expr_Variable","line":318,"name":"extra_field"}')
				if rt.is_true(rt.call_function('in_array', [var_extra_field.clone(), rt.create_array_from_list(var_deprecated_fields), rt.new_bool(true)]))
					&& var_field.clone().is_array() {
					var_field = if !(!rt.is_true(var_field)) { rt.call_function('array_shift', [
							var_field.clone(),
						]) } else { rt.new_string('') }
				}
			} else if rt.is_true(rt.new_bool(var_schema.array_get(rt.new_string('properties')).array_get(var_extra_field).array_isset(rt.new_string('default')))) {
				var_field =
					var_schema.array_get(rt.new_string('properties')).array_get(var_extra_field).array_get(rt.new_string('default'))
			} else {
				var_field = rt.new_string('')
			}
			var_data.array_set(var_extra_field, rt.call_function('rest_sanitize_value_from_schema', [
				var_field.clone(),
				var_schema.array_get(rt.new_string('properties')).array_get(var_extra_field),
			]))
		}
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('styles'), var_fields.clone()]))
	{
		mut var_styles := rt.call_method(this.style_registry, 'get_registered_styles_for_block', [
			rt.get_property(var_block_type, 'name'),
		])
		var_styles = rt.call_function('array_values', [var_styles.clone()])
		var_data.array_set('styles', rt.call_function('wp_parse_args', [
			var_styles.clone(), var_data.array_get(rt.new_string('styles'))]))
		var_data.array_set('styles', rt.call_function('array_filter', [
			var_data.array_get(rt.new_string('styles')),
		]))
	}
	mut var_context := if !(!rt.is_true(var_request.array_get(rt.new_string('context')))) {
		var_request.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_links'), var_fields.clone()]))
		|| rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_embedded'), var_fields.clone()])) {
		rt.call_method(var_response, 'add_links', [
			this.prepare_links(var_block_type.clone()),
		])
	}
	return rt.call_function('apply_filters', [rt.new_string('rest_prepare_block_type'),
		var_response.clone(), var_block_type.clone(), var_request.clone()])
}

fn (mut this Class_WP_REST_Block_Types_Controller) prepare_links(var_block_type rt.PhpVal) rt.PhpVal {
	mut var_namespace := rt.new_null()
	mut var_block_type_mutated := var_block_type
	mut list_tmp_2 := rt.call_function('explode', [rt.new_string('/'),
		rt.get_property(var_block_type_mutated, 'name')])
	var_namespace = list_tmp_2.array_get(0)
	mut var_links := {
		'collection': {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('%s/%s'),
					rt.get_property(rt.new_object('WP_REST_Block_Types_Controller', [
						'WP_REST_Controller',
					], &this), 'namespace'),
					rt.get_property(rt.new_object('WP_REST_Block_Types_Controller', [
						'WP_REST_Controller',
					], &this), 'rest_base')]),
			])
		}
		'self':       {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('%s/%s/%s'),
					rt.get_property(rt.new_object('WP_REST_Block_Types_Controller', [
						'WP_REST_Controller',
					], &this), 'namespace'),
					rt.get_property(rt.new_object('WP_REST_Block_Types_Controller', [
						'WP_REST_Controller',
					], &this), 'rest_base'),
					rt.get_property(var_block_type_mutated, 'name')]),
			])
		}
		'up':         {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('%s/%s/%s'),
					rt.get_property(rt.new_object('WP_REST_Block_Types_Controller', [
						'WP_REST_Controller',
					], &this), 'namespace'),
					rt.get_property(rt.new_object('WP_REST_Block_Types_Controller', [
						'WP_REST_Controller',
					], &this), 'rest_base'),
					var_namespace.clone()]),
			])
		}
	}
	if rt.is_true(rt.call_method(var_block_type_mutated, 'is_dynamic', []rt.PhpVal{})) {
		var_links['https://api.w.org/render-block'] = rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('add_query_arg', [
				rt.new_string('context'),
				rt.new_string('edit'),
				rt.call_function('rest_url', [
					rt.call_function('sprintf', [rt.new_string('%s/%s/%s'),
						rt.new_string('wp/v2'), rt.new_string('block-renderer'),
						rt.get_property(var_block_type_mutated, 'name')]),
				]),
			]) },
		])
	}
	return var_links.clone()
}

fn (mut this Class_WP_REST_Block_Types_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Block_Types_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
	{
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Block_Types_Controller', [
			'WP_REST_Controller',
		], &this), 'schema'))
	}
	mut var_inner_blocks_definition := {
		'description': rt.call_function('__', [
			rt.new_string('The list of inner blocks used in the example.'),
		])
		'type':        rt.new_string('array')
		'items':       {
			'type':       rt.new_string('object')
			'properties': {
				'name':        {
					'description': rt.call_function('__', [
						rt.new_string('The name of the inner block.'),
					])
					'type':        rt.new_string('string')
					'pattern':     Class_WP_REST_Block_Types_Controller.name_pattern()
					'required':    rt.new_bool(true)
				}
				'attributes':  {
					'description': rt.call_function('__', [
						rt.new_string('The attributes of the inner block.'),
					])
					'type':        rt.new_string('object')
				}
				'innerBlocks': {
					'description': rt.call_function('__', [
						rt.new_string("A list of the inner block's own inner blocks. This is a recursive definition following the parent innerBlocks schema."),
					])
					'type':        rt.new_string('array')
				}
			}
		}
	}
	mut var_example_definition := {
		'description': rt.call_function('__', [rt.new_string('Block example.')])
		'type':        map[string]rt.PhpVal{}
		'default':     rt.new_null()
		'properties':  {
			'attributes':  {
				'description': rt.call_function('__', [
					rt.new_string('The attributes used in the example.'),
				])
				'type':        rt.new_string('object')
			}
			'innerBlocks': var_inner_blocks_definition
		}
		'context':     map[string]rt.PhpVal{}
		'readonly':    rt.new_bool(true)
	}
	mut var_keywords_definition := {
		'description': rt.call_function('__', [rt.new_string('Block keywords.')])
		'type':        rt.new_string('array')
		'items':       {
			'type': rt.new_string('string')
		}
		'default':     rt.new_array()
		'context':     map[string]rt.PhpVal{}
		'readonly':    rt.new_bool(true)
	}
	mut var_icon_definition := {
		'description': rt.call_function('__', [rt.new_string('Icon of block type.')])
		'type':        map[string]rt.PhpVal{}
		'default':     rt.new_null()
		'context':     map[string]rt.PhpVal{}
		'readonly':    rt.new_bool(true)
	}
	mut var_category_definition := {
		'description': rt.call_function('__', [rt.new_string('Block category.')])
		'type':        map[string]rt.PhpVal{}
		'default':     rt.new_null()
		'context':     map[string]rt.PhpVal{}
		'readonly':    rt.new_bool(true)
	}
	this.dispatch_set_prop('schema', rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'block-type' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'api_version', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Version of block API.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'default', val: 1 },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'title', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Title of block type.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'default', val: '' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'name', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Unique name identifying the block type.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{
					key: 'pattern'
					val: Class_WP_REST_Block_Types_Controller.name_pattern()
				},
				rt.ArrayItem{ key: 'required', val: true },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'description', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Description of block type.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'default', val: '' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'icon', val: var_icon_definition },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Block attributes.'),
				]) },
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'object' },
					rt.ArrayItem{ key: none, val: 'null' },
				]) },
				rt.ArrayItem{ key: 'properties', val: rt.new_array() },
				rt.ArrayItem{ key: 'default', val: rt.new_null() },
				rt.ArrayItem{ key: 'additionalProperties', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'provides_context', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Context provided by blocks of this type.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: rt.new_array() },
				rt.ArrayItem{ key: 'additionalProperties', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'default', val: rt.new_array() },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'uses_context', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Context values inherited by blocks of this type.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'default', val: rt.new_array() },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'selectors', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Custom CSS selectors.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'default', val: rt.new_array() },
				rt.ArrayItem{ key: 'properties', val: rt.new_array() },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Block supports.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'default', val: rt.new_array() },
				rt.ArrayItem{ key: 'properties', val: rt.new_array() },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'category', val: var_category_definition },
			rt.ArrayItem{ key: 'is_dynamic', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Is the block dynamically rendered.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'boolean' },
				rt.ArrayItem{ key: 'default', val: false },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'editor_script_handles', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Editor script handles.'),
				]) },
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'array' },
				]) },
				rt.ArrayItem{ key: 'default', val: rt.new_array() },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'script_handles', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Public facing and editor script handles.'),
				]) },
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'array' },
				]) },
				rt.ArrayItem{ key: 'default', val: rt.new_array() },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'view_script_handles', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Public facing script handles.'),
				]) },
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'array' },
				]) },
				rt.ArrayItem{ key: 'default', val: rt.new_array() },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'view_script_module_ids', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Public facing script module IDs.'),
				]) },
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'array' },
				]) },
				rt.ArrayItem{ key: 'default', val: rt.new_array() },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'editor_style_handles', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Editor style handles.'),
				]) },
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'array' },
				]) },
				rt.ArrayItem{ key: 'default', val: rt.new_array() },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'style_handles', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Public facing and editor style handles.'),
				]) },
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'array' },
				]) },
				rt.ArrayItem{ key: 'default', val: rt.new_array() },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'view_style_handles', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Public facing style handles.'),
				]) },
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'array' },
				]) },
				rt.ArrayItem{ key: 'default', val: rt.new_array() },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'styles', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Block style variations.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'properties', val: rt.create_array([
						rt.ArrayItem{ key: 'name', val: rt.create_array([
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('Unique name identifying the style.'),
							]) },
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'required', val: true },
						]) },
						rt.ArrayItem{ key: 'label', val: rt.create_array([
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('The human-readable label for the style.'),
							]) },
							rt.ArrayItem{ key: 'type', val: 'string' },
						]) },
						rt.ArrayItem{ key: 'inline_style', val: rt.create_array([
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('Inline CSS code that registers the CSS class required for the style.'),
							]) },
							rt.ArrayItem{ key: 'type', val: 'string' },
						]) },
						rt.ArrayItem{ key: 'style_handle', val: rt.create_array([
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('Contains the handle that defines the block style.'),
							]) },
							rt.ArrayItem{ key: 'type', val: 'string' },
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'default', val: rt.new_array() },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'variations', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Block variations.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'properties', val: rt.create_array([
						rt.ArrayItem{ key: 'name', val: rt.create_array([
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('The unique and machine-readable name.'),
							]) },
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'required', val: true },
						]) },
						rt.ArrayItem{ key: 'title', val: rt.create_array([
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('A human-readable variation title.'),
							]) },
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'required', val: true },
						]) },
						rt.ArrayItem{ key: 'description', val: rt.create_array([
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('A detailed variation description.'),
							]) },
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'required', val: false },
						]) },
						rt.ArrayItem{ key: 'category', val: var_category_definition },
						rt.ArrayItem{ key: 'icon', val: var_icon_definition },
						rt.ArrayItem{ key: 'isDefault', val: rt.create_array([
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('Indicates whether the current variation is the default one.'),
							]) },
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'required', val: false },
							rt.ArrayItem{ key: 'default', val: false },
						]) },
						rt.ArrayItem{ key: 'attributes', val: rt.create_array([
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('The initial values for attributes.'),
							]) },
							rt.ArrayItem{ key: 'type', val: 'object' },
						]) },
						rt.ArrayItem{ key: 'innerBlocks', val: var_inner_blocks_definition },
						rt.ArrayItem{ key: 'example', val: var_example_definition },
						rt.ArrayItem{ key: 'scope', val: rt.create_array([
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('The list of scopes where the variation is applicable. When not provided, it assumes all available scopes.'),
							]) },
							rt.ArrayItem{ key: 'type', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'array' },
								rt.ArrayItem{ key: none, val: 'null' },
							]) },
							rt.ArrayItem{ key: 'default', val: rt.new_null() },
							rt.ArrayItem{ key: 'items', val: rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'string' },
								rt.ArrayItem{ key: 'enum', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'block' },
									rt.ArrayItem{ key: none, val: 'inserter' },
									rt.ArrayItem{ key: none, val: 'transform' },
								]) },
							]) },
							rt.ArrayItem{ key: 'readonly', val: true },
						]) },
						rt.ArrayItem{ key: 'keywords', val: var_keywords_definition },
					]) },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'default', val: rt.new_null() },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Public text domain.'),
				]) },
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'string' },
					rt.ArrayItem{ key: none, val: 'null' },
				]) },
				rt.ArrayItem{ key: 'default', val: rt.new_null() },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Parent blocks.'),
				]) },
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'array' },
					rt.ArrayItem{ key: none, val: 'null' },
				]) },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'pattern'
						val: Class_WP_REST_Block_Types_Controller.name_pattern()
					},
				]) },
				rt.ArrayItem{ key: 'default', val: rt.new_null() },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Ancestor blocks.'),
				]) },
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'array' },
					rt.ArrayItem{ key: none, val: 'null' },
				]) },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'pattern'
						val: Class_WP_REST_Block_Types_Controller.name_pattern()
					},
				]) },
				rt.ArrayItem{ key: 'default', val: rt.new_null() },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'allowed_blocks', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Allowed child block types.'),
				]) },
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'array' },
					rt.ArrayItem{ key: none, val: 'null' },
				]) },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'pattern'
						val: Class_WP_REST_Block_Types_Controller.name_pattern()
					},
				]) },
				rt.ArrayItem{ key: 'default', val: rt.new_null() },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'keywords', val: var_keywords_definition },
			rt.ArrayItem{ key: 'example', val: var_example_definition },
			rt.ArrayItem{ key: 'block_hooks', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('This block is automatically inserted near any occurrence of the block types used as keys of this map, into a relative position given by the corresponding value.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'patternProperties', val: rt.create_array([
					rt.ArrayItem{ key: Class_WP_REST_Block_Types_Controller.name_pattern(), val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'enum', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'before' },
							rt.ArrayItem{ key: none, val: 'after' },
							rt.ArrayItem{ key: none, val: 'first_child' },
							rt.ArrayItem{ key: none, val: 'last_child' },
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'default', val: rt.new_array() },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
		]) },
	]))
	mut var_deprecated_properties := {
		'editor_script': {
			'description': rt.call_function('__', [
				rt.new_string('Editor script handle. DEPRECATED: Use `editor_script_handles` instead.'),
			])
			'type':        map[string]rt.PhpVal{}
			'default':     rt.new_null()
			'context':     map[string]rt.PhpVal{}
			'readonly':    rt.new_bool(true)
		}
		'script':        {
			'description': rt.call_function('__', [
				rt.new_string('Public facing and editor script handle. DEPRECATED: Use `script_handles` instead.'),
			])
			'type':        map[string]rt.PhpVal{}
			'default':     rt.new_null()
			'context':     map[string]rt.PhpVal{}
			'readonly':    rt.new_bool(true)
		}
		'view_script':   {
			'description': rt.call_function('__', [
				rt.new_string('Public facing script handle. DEPRECATED: Use `view_script_handles` instead.'),
			])
			'type':        map[string]rt.PhpVal{}
			'default':     rt.new_null()
			'context':     map[string]rt.PhpVal{}
			'readonly':    rt.new_bool(true)
		}
		'editor_style':  {
			'description': rt.call_function('__', [
				rt.new_string('Editor style handle. DEPRECATED: Use `editor_style_handles` instead.'),
			])
			'type':        map[string]rt.PhpVal{}
			'default':     rt.new_null()
			'context':     map[string]rt.PhpVal{}
			'readonly':    rt.new_bool(true)
		}
		'style':         {
			'description': rt.call_function('__', [
				rt.new_string('Public facing and editor style handle. DEPRECATED: Use `style_handles` instead.'),
			])
			'type':        map[string]rt.PhpVal{}
			'default':     rt.new_null()
			'context':     map[string]rt.PhpVal{}
			'readonly':    rt.new_bool(true)
		}
	}
	rt.get_property(rt.new_object('WP_REST_Block_Types_Controller', [
		'WP_REST_Controller',
	], &this), 'schema').array_set('properties', rt.call_function('array_merge', [
		rt.get_property(rt.new_object('WP_REST_Block_Types_Controller', [
			'WP_REST_Controller',
		], &this), 'schema').array_get(rt.new_string('properties')),
		rt.create_array_from_native_map(var_deprecated_properties),
	]))
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Block_Types_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
}

fn (mut this Class_WP_REST_Block_Types_Controller) get_collection_params() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
			rt.ArrayItem{ key: 'default', val: 'view' },
		])) },
		rt.ArrayItem{ key: 'namespace', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Block namespace.'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
		]) },
	])
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

struct Class_WP_Block_Styles_Registry {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_rest_block_types_controller() &Class_WP_REST_Block_Types_Controller {
	mut obj := &Class_WP_REST_Block_Types_Controller{
		PhpObjectBase:  rt.PhpObjectBase{}
		block_registry: rt.new_null()
		style_registry: rt.new_null()
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

fn create_wp_block_type_registry(_args ...rt.PhpVal) &Class_WP_Block_Type_Registry {
	mut obj := &Class_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_styles_registry(_args ...rt.PhpVal) &Class_WP_Block_Styles_Registry {
	mut obj := &Class_WP_Block_Styles_Registry{
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

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Block_Types_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
			return this.get_items_permissions_check(dispatch_arg_0)
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
		}
		'check_read_permission' {
			return rt.new_bool(this.check_read_permission())
		}
		'get_block' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block(dispatch_arg_0)
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
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_REST_Block_Types_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_registry' { return this.block_registry }
		'style_registry' { return this.style_registry }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Block_Types_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_registry' {
			this.block_registry = val
			return true
		}
		'style_registry' {
			this.style_registry = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_WP_Block_Type_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Type_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Block_Styles_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Styles_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Styles_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
