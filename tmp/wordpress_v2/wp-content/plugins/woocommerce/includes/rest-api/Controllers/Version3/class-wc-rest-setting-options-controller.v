import rt

struct Class_WC_REST_Setting_Options_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v3')
}

fn (mut this Class_WC_REST_Setting_Options_Controller) get_setting(var_group_id rt.PhpVal, var_setting_id rt.PhpVal) rt.PhpVal {
	mut var_setting := this.Class_WC_REST_Setting_Options_V2_Controller.get_setting(var_group_id.clone(),
		var_setting_id.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_setting.clone()])) {
		return var_setting.clone()
	}
	var_setting.array_set('group_id', var_group_id.clone())
	return var_setting.clone()
}

fn (mut this Class_WC_REST_Setting_Options_Controller) allowed_setting_keys(var_key rt.PhpVal) rt.PhpVal {
	return rt.call_function('in_array', [var_key.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'id' },
			rt.ArrayItem{ key: none, val: 'group_id' }, rt.ArrayItem{ key: none, val: 'label' },
			rt.ArrayItem{ key: none, val: 'description' }, rt.ArrayItem{ key: none, val: 'default' },
			rt.ArrayItem{ key: none, val: 'tip' }, rt.ArrayItem{ key: none, val: 'placeholder' },
			rt.ArrayItem{ key: none, val: 'type' }, rt.ArrayItem{ key: none, val: 'options' },
			rt.ArrayItem{ key: none, val: 'value' }, rt.ArrayItem{ key: none, val: 'option_key' }]),
		rt.new_bool(true)])
}

fn (mut this Class_WC_REST_Setting_Options_Controller) get_group_settings(var_group_id rt.PhpVal) rt.PhpVal {
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
	this.prime_options_cache_for_settings(var_settings.clone())
	mut var_filtered_settings := rt.new_array()
	mut iter_1 := var_settings.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_setting := item_1.val
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
		} else if
			rt.is_true(rt.identical(var_setting.array_get(rt.new_string('type')), rt.new_string('single_select_page')))
			|| rt.is_true(rt.identical(var_setting.array_get(rt.new_string('type')), rt.new_string('single_select_page_with_search'))) {
			mut var_pages := rt.call_function('get_pages', [
				rt.create_array([rt.ArrayItem{ key: 'sort_column', val: 'menu_order' },
					rt.ArrayItem{ key: 'sort_order', val: 'ASC' },
					rt.ArrayItem{ key: 'hierarchical', val: 0 }]),
			])
			mut var_options := rt.new_array()
			mut iter_2 := var_pages.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_page := item_2.val
				var_options.array_set(rt.get_property(var_page, 'ID'), if !(!rt.is_true(rt.get_property(var_page,
					'post_title'))) {
					rt.get_property(var_page, 'post_title')
				} else {
					'#' + (rt.get_property(var_page, 'ID')).str()
				})
			}
			var_setting.array_set('type', 'select')
			var_setting.array_set('options', var_options.clone())
		}
		var_filtered_settings << var_setting.clone()
	}
	return var_filtered_settings.clone()
}

fn (mut this Class_WC_REST_Setting_Options_Controller) get_countries_and_states() rt.PhpVal {
	mut var_countries := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'countries'), 'get_countries', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_countries)))) {
		return rt.new_array()
	}
	mut var_output := rt.new_array()
	mut iter_3 := var_countries.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_value := item_3.val
		mut var_key := item_3.key
		mut var_states := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
			'countries'), 'get_states', [var_key.clone()])
		if rt.is_true(var_states) {
			mut iter_4 := var_states.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_state_value := item_4.val
				mut var_state_key := item_4.key
				var_output.array_set(var_key.str() + ':' + var_state_key.str(), var_value.str() +
					' - ' + var_state_value.str())
			}
		} else {
			var_output.array_set(var_key, var_value.clone())
		}
	}
	return var_output.clone()
}

fn (mut this Class_WC_REST_Setting_Options_Controller) get_item_schema() rt.PhpVal {
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
			'group_id':    {
				'description': rt.call_function('__', [
					rt.new_string('An identifier for the group this setting belongs to.'),
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

struct Class_WC_REST_Setting_Options_V2_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Settings {
	rt.PhpObjectBase
}

fn create_wc_rest_setting_options_controller(_args ...rt.PhpVal) &Class_WC_REST_Setting_Options_Controller {
	mut obj := &Class_WC_REST_Setting_Options_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v3')
	}
	return obj
}

fn create_wc_rest_setting_options_v2_controller(_args ...rt.PhpVal) &Class_WC_REST_Setting_Options_V2_Controller {
	mut obj := &Class_WC_REST_Setting_Options_V2_Controller{
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

fn (mut this Class_WC_REST_Setting_Options_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_setting' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_setting(dispatch_arg_0, dispatch_arg_1)
		}
		'allowed_setting_keys' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.allowed_setting_keys(dispatch_arg_0)
		}
		'get_group_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_group_settings(dispatch_arg_0)
		}
		'get_countries_and_states' {
			return this.get_countries_and_states()
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_REST_Setting_Options_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Setting_Options_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_REST_Setting_Options_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Setting_Options_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Setting_Options_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
