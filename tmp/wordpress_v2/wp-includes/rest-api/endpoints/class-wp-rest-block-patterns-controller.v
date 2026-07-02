import rt

struct Class_WP_REST_Block_Patterns_Controller {
	rt.PhpObjectBase
pub mut:
	remote_patterns_loaded bool
}

fn init_static_wp_rest_block_patterns_controller() {
	rt.init_static_prop('WP_REST_Block_Patterns_Controller', 'categories_migration', rt.create_array([
		rt.ArrayItem{ key: 'buttons', val: 'call-to-action' },
		rt.ArrayItem{ key: 'columns', val: 'text' },
		rt.ArrayItem{ key: 'query', val: 'posts' },
	]))
}

fn (mut this Class_WP_REST_Block_Patterns_Controller) construct() {
	this.dispatch_set_prop('namespace', rt.new_string('wp/v2'))
	this.dispatch_set_prop('rest_base', rt.new_string('block-patterns/patterns'))
}

fn (mut this Class_WP_REST_Block_Patterns_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Block_Patterns_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Block_Patterns_Controller', ['WP_REST_Controller'], &this), 'rest_base')),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Block_Patterns_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Block_Patterns_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Block_Patterns_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
}

fn (mut this Class_WP_REST_Block_Patterns_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')])) {
		return true
	}
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
	return (create_wp_error(rt.new_string('rest_cannot_view'), rt.call_function('__', [
		rt.new_string('Sorry, you are not allowed to view the registered block patterns.'),
	]), rt.create_array([
		rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
			[]rt.PhpVal{}) },
	]))).to_bool()
}

fn (mut this Class_WP_REST_Block_Patterns_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	if !(this.remote_patterns_loaded) {
		rt.call_function('_load_remote_block_patterns', []rt.PhpVal{})
		rt.call_function('_load_remote_featured_patterns', []rt.PhpVal{})
		rt.call_function('_register_remote_theme_patterns', []rt.PhpVal{})
		this.remote_patterns_loaded = true
	}
	mut var_response := []rt.PhpVal{}
	mut iife_temp_0 := Class_WP_Block_Patterns_Registry{}
	mut iife_result_0 := iife_temp_0.get_instance()
	mut var_patterns := rt.call_method(iife_result_0, 'get_all_registered', []rt.PhpVal{})
	mut iter_2 := var_patterns.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_pattern := item_2.val
		mut var_migrated_pattern := this.migrate_pattern_categories(var_pattern.clone())
		mut var_prepared_pattern := this.prepare_item_for_response(var_migrated_pattern.clone(),
			var_request.clone())
		var_response << this.prepare_response_for_collection(var_prepared_pattern.clone())
	}
	return rt.call_function('rest_ensure_response', [
		rt.create_array_from_list(var_response),
	])
}

fn (mut this Class_WP_REST_Block_Patterns_Controller) migrate_pattern_categories(var_pattern rt.PhpVal) rt.PhpVal {
	if !(var_pattern.array_isset(rt.new_string('categories')))
		|| !(var_pattern.array_get(rt.new_string('categories')).is_array()) {
		return var_pattern.clone()
	}
	mut iter_3 := var_pattern.array_get(rt.new_string('categories')).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_category := item_3.val
		mut var_index := item_3.key
		if rt.get_static_prop('WP_REST_Block_Patterns_Controller', 'categories_migration').array_isset(var_category) {
			var_pattern.array_get_mut('categories').array_set(var_index, rt.get_static_prop('WP_REST_Block_Patterns_Controller',
				'categories_migration').array_get(var_category))
		}
	}
	return var_pattern.clone()
}

fn (mut this Class_WP_REST_Block_Patterns_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	mut var_blocks := rt.call_function('parse_blocks', [
		var_item_mutated.array_get(rt.new_string('content')),
	])
	var_blocks = rt.call_function('resolve_pattern_blocks', [
		var_blocks.clone()])
	var_item_mutated.array_set('content', rt.call_function('serialize_blocks', [
		var_blocks.clone(),
	]))
	mut var_fields := this.get_fields_for_response(var_request.clone())
	mut var_keys := {
		'name':          'name'
		'title':         'title'
		'content':       'content'
		'description':   'description'
		'viewportWidth': 'viewport_width'
		'inserter':      'inserter'
		'categories':    'categories'
		'keywords':      'keywords'
		'blockTypes':    'block_types'
		'postTypes':     'post_types'
		'templateTypes': 'template_types'
		'source':        'source'
	}
	mut var_data := []rt.PhpVal{}
	for var_item_key, var_rest_key in var_keys {
		if var_item_mutated.array_isset(rt.new_string(item_key))
			&& rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string(rest_key), var_fields.clone()])) {
			var_data.array_set(rest_key, var_item_mutated.array_get(rt.new_string(item_key)))
		}
	}
	mut var_context := if !(!rt.is_true(var_request.array_get(rt.new_string('context')))) {
		var_request.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	return rt.call_function('rest_ensure_response', [var_data.clone()])
}

fn (mut this Class_WP_REST_Block_Patterns_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Block_Patterns_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
	{
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Block_Patterns_Controller', [
			'WP_REST_Controller',
		], &this), 'schema'))
	}
	mut var_schema := {
		'$schema':    rt.new_string('http://json-schema.org/draft-04/schema#')
		'title':      rt.new_string('block-pattern')
		'type':       rt.new_string('object')
		'properties': {
			'name':           {
				'description': rt.call_function('__', [
					rt.new_string('The pattern name.'),
				])
				'type':        rt.new_string('string')
				'readonly':    rt.new_bool(true)
				'context':     map[string]rt.PhpVal{}
			}
			'title':          {
				'description': rt.call_function('__', [
					rt.new_string('The pattern title, in human readable format.'),
				])
				'type':        rt.new_string('string')
				'readonly':    rt.new_bool(true)
				'context':     map[string]rt.PhpVal{}
			}
			'content':        {
				'description': rt.call_function('__', [
					rt.new_string('The pattern content.'),
				])
				'type':        rt.new_string('string')
				'readonly':    rt.new_bool(true)
				'context':     map[string]rt.PhpVal{}
			}
			'description':    {
				'description': rt.call_function('__', [
					rt.new_string('The pattern detailed description.'),
				])
				'type':        rt.new_string('string')
				'readonly':    rt.new_bool(true)
				'context':     map[string]rt.PhpVal{}
			}
			'viewport_width': {
				'description': rt.call_function('__', [
					rt.new_string('The pattern viewport width for inserter preview.'),
				])
				'type':        rt.new_string('number')
				'readonly':    rt.new_bool(true)
				'context':     map[string]rt.PhpVal{}
			}
			'inserter':       {
				'description': rt.call_function('__', [
					rt.new_string('Determines whether the pattern is visible in inserter.'),
				])
				'type':        rt.new_string('boolean')
				'readonly':    rt.new_bool(true)
				'context':     map[string]rt.PhpVal{}
			}
			'categories':     {
				'description': rt.call_function('__', [
					rt.new_string('The pattern category slugs.'),
				])
				'type':        rt.new_string('array')
				'readonly':    rt.new_bool(true)
				'context':     map[string]rt.PhpVal{}
			}
			'keywords':       {
				'description': rt.call_function('__', [
					rt.new_string('The pattern keywords.'),
				])
				'type':        rt.new_string('array')
				'readonly':    rt.new_bool(true)
				'context':     map[string]rt.PhpVal{}
			}
			'block_types':    {
				'description': rt.call_function('__', [
					rt.new_string('Block types that the pattern is intended to be used with.'),
				])
				'type':        rt.new_string('array')
				'readonly':    rt.new_bool(true)
				'context':     map[string]rt.PhpVal{}
			}
			'post_types':     {
				'description': rt.call_function('__', [
					rt.new_string('An array of post types that the pattern is restricted to be used with.'),
				])
				'type':        rt.new_string('array')
				'readonly':    rt.new_bool(true)
				'context':     map[string]rt.PhpVal{}
			}
			'template_types': {
				'description': rt.call_function('__', [
					rt.new_string('An array of template types where the pattern fits.'),
				])
				'type':        rt.new_string('array')
				'readonly':    rt.new_bool(true)
				'context':     map[string]rt.PhpVal{}
			}
			'source':         {
				'description': rt.call_function('__', [
					rt.new_string('Where the pattern comes from e.g. core'),
				])
				'type':        rt.new_string('string')
				'readonly':    rt.new_bool(true)
				'context':     map[string]rt.PhpVal{}
				'enum':        map[string]rt.PhpVal{}
			}
		}
	}
	this.dispatch_set_prop('schema', var_schema.clone())
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Block_Patterns_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Block_Patterns_Registry {
	rt.PhpObjectBase
}

fn create_wp_rest_block_patterns_controller() &Class_WP_REST_Block_Patterns_Controller {
	mut obj := &Class_WP_REST_Block_Patterns_Controller{
		PhpObjectBase:          rt.PhpObjectBase{}
		remote_patterns_loaded: false
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

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_patterns_registry(_args ...rt.PhpVal) &Class_WP_Block_Patterns_Registry {
	mut obj := &Class_WP_Block_Patterns_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Block_Patterns_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'migrate_pattern_categories' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.migrate_pattern_categories(dispatch_arg_0)
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

fn (this &Class_WP_REST_Block_Patterns_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'remote_patterns_loaded' { return rt.new_bool(this.remote_patterns_loaded) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Block_Patterns_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'remote_patterns_loaded' {
			this.remote_patterns_loaded = val.to_bool()
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

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Block_Patterns_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Patterns_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Patterns_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
