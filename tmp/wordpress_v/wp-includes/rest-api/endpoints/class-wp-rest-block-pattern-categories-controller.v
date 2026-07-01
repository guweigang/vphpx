import rt

struct Class_WP_REST_Block_Pattern_Categories_Controller {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_Block_Pattern_Categories_Controller) construct() {
	this.dispatch_set_prop('namespace', rt.new_string('wp/v2'))
	this.dispatch_set_prop('rest_base', rt.new_string('block-patterns/categories'))
}

fn (mut this Class_WP_REST_Block_Pattern_Categories_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Block_Pattern_Categories_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		'/' +
			rt.get_property(rt.new_object('WP_REST_Block_Pattern_Categories_Controller', ['WP_REST_Controller'], &this), 'rest_base'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Block_Pattern_Categories_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Block_Pattern_Categories_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Block_Pattern_Categories_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
}

fn (mut this Class_WP_REST_Block_Pattern_Categories_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
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
	return (create_wp_error(rt.new_string('rest_cannot_view'), rt.call_function('__', [
		rt.new_string('Sorry, you are not allowed to view the registered block pattern categories.'),
	]), rt.create_array([
		rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
			[]rt.PhpVal{}) },
	]))).to_bool()
}

fn (mut this Class_WP_REST_Block_Pattern_Categories_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])) {
		return create_wp_rest_response(rt.new_array())
	}
	mut var_response := rt.new_array()
	mut var_categories := rt.call_method(fn () rt.PhpVal {
		mut temp := Class_WP_Block_Pattern_Categories_Registry{}
		return temp.get_instance()
	}(), 'get_all_registered', []rt.PhpVal{})
	{
		mut iter_1 := var_categories.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_category := item_1.val
			mut var_prepared_category := this.prepare_item_for_response(var_category.dup(),
				var_request.dup())
			var_response << this.prepare_response_for_collection(var_prepared_category.dup())
		}
	}
	return rt.call_function('rest_ensure_response', [var_response.dup()])
}

fn (mut this Class_WP_REST_Block_Pattern_Categories_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_fields := this.get_fields_for_response(var_request.dup())
	mut var_keys := ['name', 'label', 'description']
	mut var_data := rt.new_array()
	for var_key in var_keys {
		if rt.is_true(rt.new_bool(var_item.array_isset(rt.new_string(key))
			&& rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string(key), var_fields.dup()]))))
		{
			var_data.array_set(key, var_item.array_get(key))
		}
	}
	mut var_context := if !(!rt.is_true(var_request.array_get('context'))) {
		var_request.array_get('context')
	} else {
		rt.new_string('view')
	}
	var_data = this.add_additional_fields_to_object(var_data.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

fn (mut this Class_WP_REST_Block_Pattern_Categories_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Block_Pattern_Categories_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
	{
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Block_Pattern_Categories_Controller', [
			'WP_REST_Controller',
		], &this), 'schema'))
	}
	mut var_schema := {
		'$schema':    rt.new_string('http://json-schema.org/draft-04/schema#')
		'title':      rt.new_string('block-pattern-category')
		'type':       rt.new_string('object')
		'properties': {
			'name':        {
				'description': rt.call_function('__', [
					rt.new_string('The category name.'),
				])
				'type':        rt.new_string('string')
				'readonly':    rt.new_bool(true)
				'context':     map[string]rt.PhpVal{}
			}
			'label':       {
				'description': rt.call_function('__', [
					rt.new_string('The category label, in human readable format.'),
				])
				'type':        rt.new_string('string')
				'readonly':    rt.new_bool(true)
				'context':     map[string]rt.PhpVal{}
			}
			'description': {
				'description': rt.call_function('__', [
					rt.new_string('The category description, in human readable format.'),
				])
				'type':        rt.new_string('string')
				'readonly':    rt.new_bool(true)
				'context':     map[string]rt.PhpVal{}
			}
		}
	}
	this.dispatch_set_prop('schema', var_schema.dup())
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Block_Pattern_Categories_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
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

struct Class_WP_Block_Pattern_Categories_Registry {
	rt.PhpObjectBase
}

fn create_wp_rest_block_pattern_categories_controller() &Class_WP_REST_Block_Pattern_Categories_Controller {
	mut obj := &Class_WP_REST_Block_Pattern_Categories_Controller{
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

fn create_wp_block_pattern_categories_registry() &Class_WP_Block_Pattern_Categories_Registry {
	mut obj := &Class_WP_Block_Pattern_Categories_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Block_Pattern_Categories_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		else {
			return none
		}
	}
}

fn (this &Class_WP_REST_Block_Pattern_Categories_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Block_Pattern_Categories_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_Block_Pattern_Categories_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Pattern_Categories_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Pattern_Categories_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_block_pattern_categories_controller_php() {
}
