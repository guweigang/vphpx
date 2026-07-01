import rt

struct Class_WC_REST_Settings_V2_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v2')
		rest_base rt.PhpVal = rt.new_string('settings')
}

fn (mut this Class_WC_REST_Settings_V2_Controller) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Settings_V2_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Settings_V2_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Settings_V2_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WC_REST_Settings_V2_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_groups := rt.call_function('apply_filters', [rt.new_string('woocommerce_settings_groups'), rt.new_array()])
	if !rt.is_true(var_groups) {
		return create_wp_error(rt.new_string('rest_setting_groups_empty'), rt.call_function('__', [rt.new_string('No setting groups have been registered.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
	}
	mut var_defaults := this.group_defaults()
	mut var_filtered_groups := rt.new_array()
	{
		mut iter_1 := var_groups.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_group := item_1.val
			mut var_sub_groups := rt.new_array()
			{
				mut iter_2 := var_groups.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var__group := item_2.val
					if rt.is_true(rt.new_bool(!(!rt.is_true(var__group.array_get('parent_id'))) && rt.is_true(rt.identical(var_group.array_get('id'), var__group.array_get('parent_id'))))) {
						var_sub_groups << var__group.array_get('id')
					}
				}
			}
			var_group.array_set('sub_groups', var_sub_groups.dup())
			var_group = rt.call_function('wp_parse_args', [var_group.dup(), var_defaults.dup()])
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_group.array_get('id').is_null()))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_group.array_get('label').is_null()))))))) {
				mut var_group_obj := this.filter_group(var_group.dup())
				mut var_group_data := this.prepare_item_for_response(var_group_obj.dup(), var_request.dup())
				var_group_data = this.prepare_response_for_collection(var_group_data.dup())
				var_filtered_groups << var_group_data.dup()
			}
		}
	}
	mut var_response := rt.call_function('rest_ensure_response', [var_filtered_groups.dup()])
	return var_response.dup()
}

fn (mut this Class_WC_REST_Settings_V2_Controller) prepare_links(var_group_id rt.PhpVal) rt.PhpVal {
	mut var_base := rt.new_string('/' + (this.namespace).str() + '/' + (this.rest_base).str())
	mut var_links := { 'options': { 'href': rt.call_function('rest_url', [rt.concat(rt.call_function('trailingslashit', [var_base.dup()]), var_group_id)]) } }
	return var_links.dup()
}

fn (mut this Class_WC_REST_Settings_V2_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_context := if !rt.is_true(var_request.array_get('context')) { rt.new_string('view') } else { var_request.array_get('context') }
	mut var_data := this.add_additional_fields_to_object(var_item.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_item.array_get('id'))])
	return var_response.dup()
}

fn (mut this Class_WC_REST_Settings_V2_Controller) filter_group(var_group rt.PhpVal) rt.PhpVal {
	mut var_group_mutated := var_group
	return rt.call_function('array_intersect_key', [var_group_mutated.dup(), rt.call_function('array_flip', [rt.call_function('array_filter', [rt.func_array_keys(var_group_mutated.dup()), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Settings_V2_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'allowed_group_keys' }])])])])
}

fn (mut this Class_WC_REST_Settings_V2_Controller) allowed_group_keys(var_key rt.PhpVal) rt.PhpVal {
	return rt.call_function('in_array', [var_key.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'id' }, rt.ArrayItem{ key: none, val: 'label' }, rt.ArrayItem{ key: none, val: 'description' }, rt.ArrayItem{ key: none, val: 'parent_id' }, rt.ArrayItem{ key: none, val: 'sub_groups' }])])
}

fn (mut this Class_WC_REST_Settings_V2_Controller) group_defaults() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'id', val: rt.new_null() }, rt.ArrayItem{ key: 'label', val: rt.new_null() }, rt.ArrayItem{ key: 'description', val: '' }, rt.ArrayItem{ key: 'parent_id', val: '' }, rt.ArrayItem{ key: 'sub_groups', val: rt.new_array() }])
}

fn (mut this Class_WC_REST_Settings_V2_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('settings'), rt.new_string('read')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot list resources.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Settings_V2_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := { '$schema': rt.new_string('http://json-schema.org/draft-04/schema#'), 'title': rt.new_string('setting_group'), 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('A unique identifier that can be used to link settings together.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'label': { 'description': rt.call_function('__', [rt.new_string('A human readable label for the setting used in interfaces.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'description': { 'description': rt.call_function('__', [rt.new_string('A human readable description for the setting used in interfaces.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'parent_id': { 'description': rt.call_function('__', [rt.new_string('ID of parent grouping.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'sub_groups': { 'description': rt.call_function('__', [rt.new_string('IDs for settings sub groups.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) } } }
	return this.add_additional_fields_schema(var_schema.dup())
}

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_rest_settings_v2_controller() &Class_WC_REST_Settings_V2_Controller {
	mut obj := &Class_WC_REST_Settings_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v2')
		rest_base: rt.new_string('settings')
	}
	return obj
}

fn create_wc_rest_controller() &Class_WC_REST_Controller {
	mut obj := &Class_WC_REST_Controller{
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

fn (mut this Class_WC_REST_Settings_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'filter_group' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_group(dispatch_arg_0)
		}
		'allowed_group_keys' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.allowed_group_keys(dispatch_arg_0)
		}
		'group_defaults' {
			return this.group_defaults()
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Settings_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Settings_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version2_class_wc_rest_settings_v2_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
