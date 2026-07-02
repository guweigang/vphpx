import rt

struct Class_WC_REST_Setting_Options_V2_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v2')
	rest_base rt.PhpVal = rt.new_string('settings/(?P<group_id>[\\w-]+)')
}

fn (mut this Class_WC_REST_Setting_Options_V2_Controller) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' +
		(this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'group', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Settings group ID.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Setting_Options_V2_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Setting_Options_V2_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Setting_Options_V2_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/batch'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'group', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Settings group ID.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Setting_Options_V2_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'batch_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Setting_Options_V2_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_items_permissions_check' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable())
				},
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Setting_Options_V2_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_batch_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[\\w-]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'group', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Settings group ID.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique identifier for the resource.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Setting_Options_V2_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Setting_Options_V2_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Setting_Options_V2_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Setting_Options_V2_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_items_permissions_check' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable())
				},
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Setting_Options_V2_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
}

fn (mut this Class_WC_REST_Setting_Options_V2_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_setting := this.get_setting(var_request_mutated.array_get(rt.new_string('group_id')),
		var_request_mutated.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_setting.clone()])) {
		return var_setting.clone()
	}
	mut var_response := this.prepare_item_for_response(var_setting.clone(),
		var_request_mutated.clone())
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_WC_REST_Setting_Options_V2_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_settings :=
		this.get_group_settings(var_request_mutated.array_get(rt.new_string('group_id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_settings.clone()])) {
		return var_settings.clone()
	}
	mut var_data := rt.new_array()
	mut iter_1 := var_settings.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_setting_obj := item_1.val
		mut var_setting := this.prepare_item_for_response(var_setting_obj.clone(),
			var_request_mutated.clone())
		var_setting = this.prepare_response_for_collection(var_setting.clone())
		if rt.is_true(this.is_setting_type_valid(var_setting.array_get(rt.new_string('type')))) {
			var_data.array_push(var_setting.clone())
		}
	}
	return rt.call_function('rest_ensure_response', [var_data.clone()])
}

fn (mut this Class_WC_REST_Setting_Options_V2_Controller) get_group_settings(var_group_id rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_group_id) {
		return create_wp_error(rt.new_string('rest_setting_setting_group_invalid'), rt.call_function('__', [
			rt.new_string('Invalid setting group.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_settings := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_settings-' + var_group_id.str()),
		rt.new_array(),
	])
	if !rt.is_true(var_settings) {
		return create_wp_error(rt.new_string('rest_setting_setting_group_invalid'), rt.call_function('__', [
			rt.new_string('Invalid setting group.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	this.prime_options_cache_for_settings(mut rt.cast_object_ptr[Class_array](var_settings))
	mut var_filtered_settings := rt.new_array()
	mut iter_2 := var_settings.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_setting := item_2.val
		mut var_option_key := var_setting.array_get(rt.new_string('option_key'))
		var_setting = this.filter_setting(var_setting.clone())
		mut var_default := if var_setting.array_isset(rt.new_string('default')) {
			var_setting.array_get(rt.new_string('default'))
		} else {
			rt.new_string('')
		}
		if rt.is_true(rt.call_function('in_array', [if !(var_setting.array_get(rt.new_string('type'))).is_null() {
			var_setting.array_get(rt.new_string('type'))
		} else {
			rt.new_string('')
		},
			rt.create_array([rt.ArrayItem{ key: none, val: 'title' },
				rt.ArrayItem{ key: none, val: 'sectionend' }]),
			rt.new_bool(true)]))
		{
			var_filtered_settings << var_setting.clone()
			continue
		}
		if rt.is_true(rt.new_bool(var_option_key.clone().is_array())) {
			mut var_option := rt.call_function('get_option', [
				var_option_key.array_get(rt.new_int(0)),
			])
			var_setting.array_set('value', if var_option.array_isset(var_option_key.array_get(rt.new_int(1))) {
				var_option.array_get(var_option_key.array_get(rt.new_int(1)))
			} else {
				var_default
			})
		} else {
			mut iife_temp_0 := Class_WC_Admin_Settings{}
			mut iife_result_0 := iife_temp_0.get_option(var_option_key.clone(), var_default.clone())
			mut var_admin_setting_value := iife_result_0
			var_setting.array_set('value', var_admin_setting_value.clone())
		}
		if rt.is_true(rt.identical(rt.new_string('multi_select_countries'),
			var_setting.array_get(rt.new_string('type'))))
		{
			var_setting.array_set('options', rt.call_method(rt.get_property(rt.call_function('WC',
				[]rt.PhpVal{}), 'countries'), 'get_countries', []rt.PhpVal{}))
			var_setting.array_set('type', 'multiselect')
		} else if rt.is_true(rt.identical(rt.new_string('single_select_country'),
			var_setting.array_get(rt.new_string('type'))))
		{
			var_setting.array_set('type', 'select')
			var_setting.array_set('options', this.get_countries_and_states())
		}
		var_filtered_settings << var_setting.clone()
	}
	return var_filtered_settings.clone()
}

fn (mut this Class_WC_REST_Setting_Options_V2_Controller) prime_options_cache_for_settings(mut var_settings Class_array) {
	mut var_option_array := rt.new_null()
	mut var_settings_mutated := var_settings
	mut var_prefetch := rt.new_array()
	mut iter_3 := var_settings_mutated.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_setting := item_3.val
		mut var_option_key := var_setting.array_get(rt.new_string('option_key'))
		if rt.is_true(rt.new_bool(var_option_key.clone().is_array())) {
			var_prefetch << var_option_key.array_get(rt.new_int(0))
		} else if rt.is_true(rt.call_function('strstr', [var_option_key.clone(),
			rt.new_string('[')]))
		{
			rt.call_function('parse_str', [var_option_key.clone(),
				var_option_array.clone()])
			var_prefetch << rt.call_function('current', [
				rt.func_array_keys(var_option_array.clone()),
			])
		} else {
			var_prefetch << var_option_key.clone()
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_array(), var_prefetch)))) {
		rt.call_function('wp_prime_option_caches', [
			rt.create_array_from_list(var_prefetch),
		])
	}
}

fn (mut this Class_WC_REST_Setting_Options_V2_Controller) get_countries_and_states() rt.PhpVal {
	mut var_countries := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'countries'), 'get_countries', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_countries)))) {
		return rt.new_array()
	}
	mut var_output := rt.new_array()
	mut iter_4 := var_countries.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_value := item_4.val
		mut var_key := item_4.key
		mut var_states := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
			'countries'), 'get_states', [var_key.clone()])
		if rt.is_true(var_states) {
			mut iter_5 := var_states.iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_state_value := item_5.val
				mut var_state_key := item_5.key
				var_output.array_set(var_key.str() + ':' + var_state_key.str(), var_value.str() +
					' - ' + var_state_value.str())
			}
		} else {
			var_output.array_set(var_key, var_value.clone())
		}
	}
	return var_output.clone()
}

fn (mut this Class_WC_REST_Setting_Options_V2_Controller) get_setting(var_group_id rt.PhpVal, var_setting_id rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_setting_id) {
		return create_wp_error(rt.new_string('rest_setting_setting_invalid'), rt.call_function('__', [
			rt.new_string('Invalid setting.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_settings := this.get_group_settings(var_group_id.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_settings.clone()])) {
		return var_settings.clone()
	}
	mut var_array_key := rt.func_array_keys(rt.call_function('wp_list_pluck', [
		var_settings.clone(),
		rt.new_string('id'),
	]), var_setting_id.clone(), rt.new_bool(true))
	if !rt.is_true(var_array_key) {
		return create_wp_error(rt.new_string('rest_setting_setting_invalid'), rt.call_function('__', [
			rt.new_string('Invalid setting.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_setting := var_settings.array_get(var_array_key.array_get(rt.new_int(0)))
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_setting_type_valid(var_setting.array_get(rt.new_string('type'))))))) {
		return create_wp_error(rt.new_string('rest_setting_setting_invalid'), rt.call_function('__', [
			rt.new_string('Invalid setting.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	return var_setting.clone()
}

fn (mut this Class_WC_REST_Setting_Options_V2_Controller) batch_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_items := rt.call_function('array_filter', [
		rt.call_method(var_request_mutated, 'get_params', []rt.PhpVal{}),
	])
	if !(!rt.is_true(var_items.array_get(rt.new_string('update')))) {
		mut var_to_update := rt.new_array()
		mut iter_6 := var_items.array_get(rt.new_string('update')).iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_item := item_6.val
			var_to_update << rt.call_function('array_merge', [
				rt.call_method(var_request_mutated, 'get_url_params', []rt.PhpVal{}),
				var_item.clone(),
			])
		}
		var_request_mutated = create_wp_rest_request(rt.call_method(var_request_mutated,
			'get_method', []rt.PhpVal{}))
		rt.call_method(var_request_mutated, 'set_body_params', [
			rt.create_array([rt.ArrayItem{ key: 'update', val: var_to_update }]),
		])
	}
	return this.Class_WC_REST_Controller.batch_items(var_request_mutated.clone())
}

fn (mut this Class_WC_REST_Setting_Options_V2_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_setting := this.get_setting(var_request_mutated.array_get(rt.new_string('group_id')),
		var_request_mutated.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_setting.clone()])) {
		return var_setting.clone()
	}
	if rt.is_true(rt.call_function('is_callable', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Setting_Options_V2_Controller', [
				'WC_REST_Controller',
			], &this) },
			rt.ArrayItem{ key: none, val: 'validate_setting_' +
				(var_setting.array_get(rt.new_string('type'))).str() + '_field' },
		]),
	]))
	{
		mut var_value := rt.call_method(rt.new_object('WC_REST_Setting_Options_V2_Controller', [
			'WC_REST_Controller',
		], &this), 'validate_setting_' +
			(var_setting.array_get(rt.new_string('type'))).str() + '_field', [
			var_request_mutated.array_get(rt.new_string('value')),
			var_setting.clone(),
		])
	} else {
		var_value = this.validate_setting_text_field(var_request_mutated.array_get(rt.new_string('value')),
			var_setting.clone())
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_value.clone()])) {
		return var_value.clone()
	}
	if rt.is_true(rt.new_bool(var_setting.array_get(rt.new_string('option_key')).is_array())) {
		var_setting.array_set('value', var_value.clone())
		mut var_option_key := var_setting.array_get(rt.new_string('option_key'))
		mut var_prev := if !(rt.call_function('get_option', [
			var_option_key.array_get(rt.new_int(0)), rt.new_null()])).is_null() { rt.call_function('get_option', [
				var_option_key.array_get(rt.new_int(0)),
				rt.new_null(),
			]) } else { rt.new_array() }
		var_prev.array_set(var_option_key.array_get(rt.new_int(1)),
			var_request_mutated.array_get(rt.new_string('value')))
		rt.call_function('update_option', [var_option_key.array_get(rt.new_int(0)),
			var_prev.clone()])
	} else {
		mut var_update_data := rt.new_array()
		var_update_data.array_set(var_setting.array_get(rt.new_string('option_key')),
			var_value.clone())
		var_setting.array_set('value', var_value.clone())
		mut iife_temp_1 := Class_WC_Admin_Settings{}
		mut iife_result_1 := iife_temp_1.save_fields(rt.create_array([
			rt.ArrayItem{ key: none, val: var_setting },
		]), var_update_data.clone())
	}
	mut var_response := this.prepare_item_for_response(var_setting.clone(),
		var_request_mutated.clone())
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_WC_REST_Setting_Options_V2_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	var_item.array_unset(rt.new_string('option_key'))
	mut var_data := this.filter_setting(var_item.clone())
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request_mutated.clone())
	var_data = this.filter_response_by_context(var_data.clone(), if !rt.is_true(var_request_mutated.array_get(rt.new_string('context'))) {
		rt.new_string('view')
	} else {
		var_request_mutated.array_get(rt.new_string('context'))
	})
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	rt.call_method(var_response, 'add_links', [
		this.prepare_links(var_data.array_get(rt.new_string('id')),
			var_request_mutated.array_get(rt.new_string('group_id'))),
	])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Setting_Options_V2_Controller) prepare_links(var_setting_id rt.PhpVal, var_group_id rt.PhpVal) rt.PhpVal {
	mut var_base := rt.call_function('str_replace', [
		rt.new_string('(?P<group_id>[\\w-]+)'),
		var_group_id.clone(),
		this.rest_base,
	])
	mut var_links := {
		'self':       {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('/%s/%s/%s'), this.namespace,
					var_base.clone(), var_setting_id.clone()]),
			])
		}
		'collection': {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf',
					[rt.new_string('/%s/%s'), this.namespace, var_base.clone()]),
			])
		}
	}
	return var_links.clone()
}

fn (mut this Class_WC_REST_Setting_Options_V2_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('settings'),
		rt.new_string('read'),
	])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [
			rt.new_string('Sorry, you cannot list resources.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Setting_Options_V2_Controller) update_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('settings'),
		rt.new_string('edit'),
	])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_edit'), rt.call_function('__', [
			rt.new_string('Sorry, you cannot edit this resource.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Setting_Options_V2_Controller) update_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	return rt.new_bool(this.update_items_permissions_check(var_request_mutated.clone()))
	return rt.new_null()
}

fn (mut this Class_WC_REST_Setting_Options_V2_Controller) filter_setting(var_setting rt.PhpVal) rt.PhpVal {
	mut var_setting_mutated := var_setting
	var_setting_mutated = rt.call_function('array_intersect_key', [
		var_setting_mutated.clone(),
		rt.call_function('array_flip', [
			rt.call_function('array_filter', [
				rt.func_array_keys(var_setting_mutated.clone()),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Setting_Options_V2_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'allowed_setting_keys' },
				]),
			]),
		])])
	if !rt.is_true(var_setting_mutated.array_get(rt.new_string('options'))) {
		var_setting_mutated.array_unset(rt.new_string('options'))
	}
	if rt.is_true(rt.identical(rt.new_string('image_width'),
		var_setting_mutated.array_get(rt.new_string('type'))))
	{
		var_setting_mutated = this.cast_image_width(var_setting_mutated.clone())
	}
	return var_setting_mutated.clone()
}

fn (mut this Class_WC_REST_Setting_Options_V2_Controller) cast_image_width(var_setting rt.PhpVal) rt.PhpVal {
	mut var_setting_mutated := var_setting
	mut iter_7 := rt.create_array([rt.ArrayItem{ key: none, val: 'default' },
		rt.ArrayItem{ key: none, val: 'value' }]).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_key := item_7.val
		if var_setting_mutated.array_isset(var_key) {
			var_setting_mutated.array_get_mut(var_key).array_set('width',
				var_setting_mutated.array_get(var_key).array_get(rt.new_string('width')).to_i64())
			var_setting_mutated.array_get_mut(var_key).array_set('height',
				var_setting_mutated.array_get(var_key).array_get(rt.new_string('height')).to_i64())
			var_setting_mutated.array_get_mut(var_key).array_set('crop',
				(var_setting_mutated.array_get(var_key).array_get(rt.new_string('crop'))).to_bool())
		}
	}
	return var_setting_mutated.clone()
}

fn (mut this Class_WC_REST_Setting_Options_V2_Controller) allowed_setting_keys(var_key rt.PhpVal) rt.PhpVal {
	return rt.call_function('in_array', [var_key.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'id' },
			rt.ArrayItem{ key: none, val: 'label' }, rt.ArrayItem{ key: none, val: 'description' },
			rt.ArrayItem{ key: none, val: 'default' }, rt.ArrayItem{ key: none, val: 'tip' },
			rt.ArrayItem{ key: none, val: 'placeholder' }, rt.ArrayItem{ key: none, val: 'type' },
			rt.ArrayItem{ key: none, val: 'options' }, rt.ArrayItem{ key: none, val: 'value' },
			rt.ArrayItem{ key: none, val: 'option_key' }]),
		rt.new_bool(true)])
}

fn (mut this Class_WC_REST_Setting_Options_V2_Controller) is_setting_type_valid(var_type rt.PhpVal) rt.PhpVal {
	return rt.call_function('in_array', [var_type.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'text' },
			rt.ArrayItem{ key: none, val: 'email' }, rt.ArrayItem{ key: none, val: 'number' },
			rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'password' },
			rt.ArrayItem{ key: none, val: 'textarea' }, rt.ArrayItem{ key: none, val: 'select' },
			rt.ArrayItem{ key: none, val: 'multiselect' }, rt.ArrayItem{ key: none, val: 'radio' },
			rt.ArrayItem{ key: none, val: 'checkbox' }, rt.ArrayItem{ key: none, val: 'image_width' },
			rt.ArrayItem{ key: none, val: 'thumbnail_cropping' }]),
		rt.new_bool(true)])
}

fn (mut this Class_WC_REST_Setting_Options_V2_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := {
		'$schema':    rt.new_string('http://json-schema.org/draft-04/schema#')
		'title':      rt.new_string('setting')
		'type':       rt.new_string('object')
		'properties': {
			'id':          {
				'description': rt.call_function('__', [
					rt.new_string('A unique identifier for the setting.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'arg_options': {
					'sanitize_callback': rt.new_string('sanitize_title')
				}
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'label':       {
				'description': rt.call_function('__', [
					rt.new_string('A human readable label for the setting used in interfaces.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'arg_options': {
					'sanitize_callback': rt.new_string('sanitize_text_field')
				}
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'description': {
				'description': rt.call_function('__', [
					rt.new_string('A human readable description for the setting used in interfaces.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'arg_options': {
					'sanitize_callback': rt.new_string('sanitize_text_field')
				}
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'value':       {
				'description': rt.call_function('__', [rt.new_string('Setting value.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('mixed')
				'context':     map[string]rt.PhpVal{}
			}
			'default':     {
				'description': rt.call_function('__', [
					rt.new_string('Default value for the setting.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('mixed')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'tip':         {
				'description': rt.call_function('__', [
					rt.new_string('Additional help text shown to the user about the setting.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'arg_options': {
					'sanitize_callback': rt.new_string('sanitize_text_field')
				}
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'placeholder': {
				'description': rt.call_function('__', [
					rt.new_string('Placeholder text to be displayed in text inputs.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'arg_options': {
					'sanitize_callback': rt.new_string('sanitize_text_field')
				}
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'type':        {
				'description': rt.call_function('__', [rt.new_string('Type of setting.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('string')
				'arg_options': {
					'sanitize_callback': rt.new_string('sanitize_text_field')
				}
				'context':     map[string]rt.PhpVal{}
				'enum':        map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'options':     {
				'description': rt.call_function('__', [
					rt.new_string('Array of options (key value pairs) for inputs such as select, multiselect, and radio buttons.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('object')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
		}
	}
	return this.add_additional_fields_schema(var_schema.clone())
}

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Settings {
	rt.PhpObjectBase
}

struct Class_WP_REST_Request {
	rt.PhpObjectBase
}

fn create_wc_rest_setting_options_v2_controller(_args ...rt.PhpVal) &Class_WC_REST_Setting_Options_V2_Controller {
	mut obj := &Class_WC_REST_Setting_Options_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v2')
		rest_base:     rt.new_string('settings/(?P<group_id>[\\w-]+)')
	}
	return obj
}

fn create_wc_rest_controller(_args ...rt.PhpVal) &Class_WC_REST_Controller {
	mut obj := &Class_WC_REST_Controller{
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

fn create_wc_admin_settings(_args ...rt.PhpVal) &Class_WC_Admin_Settings {
	mut obj := &Class_WC_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_request(_args ...rt.PhpVal) &Class_WP_REST_Request {
	mut obj := &Class_WP_REST_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Setting_Options_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_group_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_group_settings(dispatch_arg_0)
		}
		'prime_options_cache_for_settings' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.prime_options_cache_for_settings(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_countries_and_states' {
			return this.get_countries_and_states()
		}
		'get_setting' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_setting(dispatch_arg_0, dispatch_arg_1)
		}
		'batch_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.batch_items(dispatch_arg_0)
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0, dispatch_arg_1)
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'update_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.update_items_permissions_check(dispatch_arg_0))
		}
		'update_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item_permissions_check(dispatch_arg_0)
		}
		'filter_setting' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_setting(dispatch_arg_0)
		}
		'cast_image_width' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.cast_image_width(dispatch_arg_0)
		}
		'allowed_setting_keys' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.allowed_setting_keys(dispatch_arg_0)
		}
		'is_setting_type_valid' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_setting_type_valid(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_REST_Setting_Options_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Setting_Options_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		'rest_base' {
			this.rest_base = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_WC_Admin_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_REST_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
