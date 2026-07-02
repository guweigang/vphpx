import rt

struct Class_WP_REST_Block_Renderer_Controller {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_Block_Renderer_Controller) construct() {
	this.dispatch_set_prop('namespace', rt.new_string('wp/v2'))
	this.dispatch_set_prop('rest_base', rt.new_string('block-renderer'))
}

fn (mut this Class_WP_REST_Block_Renderer_Controller) register_routes() {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_request := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut iife_temp_1 := Class_WP_Block_Type_Registry{}
		mut iife_result_1 := iife_temp_1.get_instance()
		mut var_block := rt.call_method(iife_result_1, 'get_registered', [
			var_request.array_get(rt.new_string('name')),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_block)))) {
			return
		}
		mut var_schema := rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'properties', val: rt.call_method(var_block, 'get_attributes',
				[]rt.PhpVal{}) }, rt.ArrayItem{ key: 'additionalProperties', val: false }])
		return
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_request := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut iife_temp_3 := Class_WP_Block_Type_Registry{}
		mut iife_result_3 := iife_temp_3.get_instance()
		mut var_block := rt.call_method(iife_result_3, 'get_registered', [
			var_request.array_get(rt.new_string('name')),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_block)))) {
			return
		}
		mut var_schema := rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'properties', val: rt.call_method(var_block, 'get_attributes',
				[]rt.PhpVal{}) }, rt.ArrayItem{ key: 'additionalProperties', val: false }])
		return
	}
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Block_Renderer_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Block_Renderer_Controller', ['WP_REST_Controller'], &this), 'rest_base') +
			'/(?P<name>[a-z0-9-]+/[a-z0-9-]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique registered name for the block.'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: rt.create_array([
					rt.ArrayItem{ key: none, val: Class_WP_REST_Server.readable() },
					rt.ArrayItem{ key: none, val: Class_WP_REST_Server.creatable() },
				]) },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Block_Renderer_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Block_Renderer_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
						rt.ArrayItem{ key: 'default', val: 'view' },
					])) },
					rt.ArrayItem{ key: 'attributes', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Attributes for the block.'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'object' },
						rt.ArrayItem{ key: 'default', val: rt.new_array() },
						rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_2_fn) },
						rt.ArrayItem{ key: 'sanitize_callback', val: rt.new_closure(closure_4_fn) },
					]) },
					rt.ArrayItem{ key: 'post_id', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('ID of the post context.'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'integer' },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Block_Renderer_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
}

fn (mut this Class_WP_REST_Block_Renderer_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_post := rt.get_superglobal('post')
	mut var_post_id := rt.new_int(if var_request.array_isset(rt.new_string('post_id')) {
		rt.new_int((var_request.array_get(rt.new_string('post_id'))).to_i64())
	} else {
		0
	})
	if rt.is_true(rt.greater(var_post_id, rt.new_int(0))) {
		var_post = rt.call_function('get_post', [var_post_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.get_property(var_post, 'ID')]))))) {
			return (create_wp_error(rt.new_string('block_cannot_read'), rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to read blocks of this post.'),
			]), rt.create_array([
				rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
					[]rt.PhpVal{}) },
			]))).to_bool()
		}
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_posts'),
		])))))
		{
			return (create_wp_error(rt.new_string('block_cannot_read'), rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to read blocks as this user.'),
			]), rt.create_array([
				rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
					[]rt.PhpVal{}) },
			]))).to_bool()
		}
	}
	return true
}

fn (mut this Class_WP_REST_Block_Renderer_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_post := rt.get_superglobal('post')
	mut var_post_id := rt.new_int(if var_request.array_isset(rt.new_string('post_id')) {
		rt.new_int((var_request.array_get(rt.new_string('post_id'))).to_i64())
	} else {
		0
	})
	if rt.is_true(rt.greater(var_post_id, rt.new_int(0))) {
		var_post = rt.call_function('get_post', [var_post_id.clone()])
		rt.call_function('setup_postdata', [var_post.clone()])
	}
	mut iife_temp_4 := Class_WP_Block_Type_Registry{}
	mut iife_result_4 := iife_temp_4.get_instance()
	mut var_registry := iife_result_4
	mut var_registered := rt.call_method(var_registry, 'get_registered', [
		var_request.array_get(rt.new_string('name')),
	])
	if rt.is_true(rt.identical(rt.new_null(), var_registered))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_registered, 'is_dynamic', []rt.PhpVal{}))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('block_invalid'), rt.call_function('__', [
			rt.new_string('Invalid block.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_attributes := rt.call_method(var_request, 'get_param', [
		rt.new_string('attributes'),
	])
	mut var_block := {
		'blockName':    var_request.array_get(rt.new_string('name'))
		'attrs':        var_attributes
		'innerBlocks':  rt.new_array()
		'innerHTML':    rt.new_string('')
		'innerContent': rt.new_array()
	}
	mut var_data := {
		'rendered': rt.call_function('render_block', [
			rt.create_array_from_native_map(var_block),
		])
	}
	return rt.call_function('rest_ensure_response', [
		rt.create_array_from_native_map(var_data),
	])
}

fn (mut this Class_WP_REST_Block_Renderer_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Block_Renderer_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
	{
		return rt.get_property(rt.new_object('WP_REST_Block_Renderer_Controller', [
			'WP_REST_Controller',
		], &this), 'schema')
	}
	this.dispatch_set_prop('schema', rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/schema#' },
		rt.ArrayItem{ key: 'title', val: 'rendered-block' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'rendered', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The rendered block.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'required', val: true },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
		]) },
	]))
	return rt.get_property(rt.new_object('WP_REST_Block_Renderer_Controller', [
		'WP_REST_Controller',
	], &this), 'schema')
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_rest_block_renderer_controller() &Class_WP_REST_Block_Renderer_Controller {
	mut obj := &Class_WP_REST_Block_Renderer_Controller{
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

fn create_wp_block_type_registry(_args ...rt.PhpVal) &Class_WP_Block_Type_Registry {
	mut obj := &Class_WP_Block_Type_Registry{
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

fn (mut this Class_WP_REST_Block_Renderer_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_REST_Block_Renderer_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Block_Renderer_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_Block_Type_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Type_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
