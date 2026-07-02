import rt

struct Class_WC_Settings_Tracking {
	rt.PhpObjectBase
pub mut:
	allowed_options       rt.PhpVal = rt.new_array()
	updated_options       rt.PhpVal = rt.new_array()
	dropdown_menu_options rt.PhpVal = rt.new_array()
	modified_options      rt.PhpVal = rt.new_array()
	deleted_options       rt.PhpVal = rt.new_array()
	added_options         rt.PhpVal = rt.new_array()
	toggled_options       rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Settings_Tracking) init() {
	rt.call_function('add_action', [rt.new_string('woocommerce_settings_page_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Tracking', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'track_settings_page_view' },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_update_option'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Tracking', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_option_to_list' },
		])])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_update_non_option_setting'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Tracking', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_option_to_list_and_track_setting_change' },
		]),
	])
	rt.call_function('add_action', [rt.new_string('woocommerce_update_options'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Tracking', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'send_settings_change_event' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Tracking', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'possibly_add_settings_tracking_scripts' },
		])])
}

fn (mut this Class_WC_Settings_Tracking) add_option_to_list_and_track_setting_change(var_option rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_option.array_get(rt.new_string('id')),
		this.allowed_options,
		rt.new_bool(true),
	])))))
	{
		this.allowed_options.array_push(var_option.array_get(rt.new_string('id')))
	}
	if var_option.array_isset(rt.new_string('action')) {
		if rt.is_true(rt.identical(rt.new_string('add'),
			var_option.array_get(rt.new_string('action'))))
		{
			this.added_options.array_push(var_option.array_get(rt.new_string('id')))
		} else if rt.is_true(rt.identical(rt.new_string('delete'),
			var_option.array_get(rt.new_string('action'))))
		{
			this.deleted_options.array_push(var_option.array_get(rt.new_string('id')))
		} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_option.array_get(rt.new_string('id')),
			this.updated_options,
			rt.new_bool(true),
		])))))
		{
			this.updated_options.array_push(var_option.array_get(rt.new_string('id')))
		}
	} else if var_option.array_isset(rt.new_string('value')) {
		if rt.is_true(rt.identical(rt.new_string('select'),
			var_option.array_get(rt.new_string('type'))))
		{
			this.modified_options.array_set(var_option.array_get(rt.new_string('id')),
				var_option.array_get(rt.new_string('value')))
		} else if rt.is_true(rt.identical(rt.new_string('checkbox'),
			var_option.array_get(rt.new_string('type'))))
		{
			mut var_option_state := rt.new_string((if rt.is_true(rt.identical(rt.new_string('yes'),
				var_option.array_get(rt.new_string('value'))))
			{
				'enabled'
			} else {
				'disabled'
			}).str())
			this.toggled_options.array_get_mut(var_option_state).array_push(var_option.array_get(rt.new_string('id')))
		}
		this.updated_options.array_push(var_option.array_get(rt.new_string('id')))
	}
}

fn (mut this Class_WC_Settings_Tracking) add_option_to_list(var_option rt.PhpVal) {
	this.allowed_options.array_push(var_option.array_get(rt.new_string('id')))
	if var_option.array_isset(rt.new_string('options')) {
		this.dropdown_menu_options.array_push(var_option.array_get(rt.new_string('id')))
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('has_action', [
		rt.new_string('update_option'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Tracking', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'track_setting_change' },
		]),
	])))
	{
		rt.call_function('add_action', [rt.new_string('update_option'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_Tracking', []string{},
					&this) },
				rt.ArrayItem{ key: none, val: 'track_setting_change' },
			]),
			rt.new_int(10), rt.new_int(3)])
	}
}

fn (mut this Class_WC_Settings_Tracking) track_setting_change(var_option_name rt.PhpVal, var_old_value rt.PhpVal, var_new_value rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_option_name.clone(), this.allowed_options, rt.new_bool(true)])))))
	{
		return
	}
	if rt.is_true(rt.call_function('is_scalar', [var_old_value.clone()]))
		&& rt.is_true(rt.call_function('is_scalar', [var_new_value.clone()]))
		&& rt.is_true(rt.identical(var_old_value.str(), var_new_value.str())) {
		return
	}
	if rt.is_true(rt.call_function('in_array', [var_option_name.clone(), this.dropdown_menu_options,
		rt.new_bool(true)]))
	{
		this.modified_options.array_set(var_option_name, var_new_value.clone())
	} else if
		rt.is_true(rt.call_function('in_array', [var_new_value.clone(), rt.create_array([rt.ArrayItem{
		key: none
		val: 'yes'
	}, rt.ArrayItem{ key: none, val: 'no' }]), rt.new_bool(true)]))
		&& rt.is_true(rt.call_function('in_array', [var_old_value.clone(), rt.create_array([rt.ArrayItem{
		key: none
		val: 'yes'
	}, rt.ArrayItem{ key: none, val: 'no' }]), rt.new_bool(true)])) {
		mut var_option_state := rt.new_string((if rt.is_true(rt.identical(rt.new_string('yes'),
			var_new_value))
		{
			'enabled'
		} else {
			'disabled'
		}).str())
		this.toggled_options.array_get_mut(var_option_state).array_push(var_option_name.clone())
	}
	this.updated_options.array_push(var_option_name.clone())
}

fn (mut this Class_WC_Settings_Tracking) send_settings_change_event() {
	mut var_current_tab := rt.new_null()
	mut var_current_section := rt.new_null()
	if !rt.is_true(this.updated_options) && !rt.is_true(this.deleted_options)
		&& !rt.is_true(this.added_options) {
		return
	}
	mut var_properties := rt.new_array()
	if !(!rt.is_true(this.updated_options)) {
		var_properties.array_set('settings', rt.call_function('implode', [
			rt.new_string(','),
			this.updated_options,
		]))
	}
	if !(!rt.is_true(this.deleted_options)) {
		var_properties.array_set('deleted', rt.call_function('implode', [
			rt.new_string(','),
			this.deleted_options,
		]))
	}
	if !(!rt.is_true(this.added_options)) {
		var_properties.array_set('added', rt.call_function('implode', [
			rt.new_string(','),
			this.added_options,
		]))
	}
	mut iter_1 := this.toggled_options.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_options := item_1.val
		mut var_state := item_1.key
		if !(!rt.is_true(var_options)) {
			var_properties.array_set(var_state, rt.call_function('implode', [
				rt.new_string(','),
				var_options.clone(),
			]))
		}
	}
	if !(!rt.is_true(this.modified_options)) {
		mut iter_2 := this.modified_options.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_selected_option := item_2.val
			mut var_option_name := item_2.key
			var_properties.array_set(var_option_name, if !var_selected_option.is_null() {
				var_selected_option
			} else {
				rt.new_string('')
			})
		}
	}
	var_properties.array_set('tab', if !var_current_tab.is_null() {
		var_current_tab
	} else {
		rt.new_string('')
	})
	var_properties.array_set('section', if !var_current_section.is_null() {
		var_current_section
	} else {
		rt.new_string('')
	})
	mut iife_temp_0 := Class_WC_Tracks{}
	mut iife_result_0 := iife_temp_0.record_event(rt.new_string('settings_change'),
		var_properties.clone())
}

fn (mut this Class_WC_Settings_Tracking) track_settings_page_view() {
	mut var_current_tab := rt.new_null()
	mut var_current_section := rt.new_null()
	mut var_properties := rt.create_array([
		rt.ArrayItem{ key: 'tab', val: var_current_tab },
		rt.ArrayItem{
			key: 'section'
			val: if !rt.is_true(var_current_section) { rt.new_null() } else { var_current_section }
		},
	])
	mut iife_temp_1 := Class_WC_Tracks{}
	mut iife_result_1 := iife_temp_1.record_event(rt.new_string('settings_view'),
		var_properties.clone())
}

fn (mut this Class_WC_Settings_Tracking) possibly_add_settings_tracking_scripts(var_hook rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wc_admin_settings_page',
		[]rt.PhpVal{})))))
	{
		return
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
	mut iife_result_2 := iife_temp_2.register_script(rt.new_string('wp-admin-scripts'),
		rt.new_string('settings-tracking'), rt.new_bool(false))
}

struct Class_WC_Tracks {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	rt.PhpObjectBase
}

fn create_wc_settings_tracking(_args ...rt.PhpVal) &Class_WC_Settings_Tracking {
	mut obj := &Class_WC_Settings_Tracking{
		PhpObjectBase:         rt.PhpObjectBase{}
		allowed_options:       rt.new_array()
		updated_options:       rt.new_array()
		dropdown_menu_options: rt.new_array()
		modified_options:      rt.new_array()
		deleted_options:       rt.new_array()
		added_options:         rt.new_array()
		toggled_options:       rt.new_array()
	}
	return obj
}

fn create_wc_tracks(_args ...rt.PhpVal) &Class_WC_Tracks {
	mut obj := &Class_WC_Tracks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcadminassets(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Settings_Tracking) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'add_option_to_list_and_track_setting_change' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_option_to_list_and_track_setting_change(dispatch_arg_0)
			return rt.new_null()
		}
		'add_option_to_list' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_option_to_list(dispatch_arg_0)
			return rt.new_null()
		}
		'track_setting_change' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.track_setting_change(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'send_settings_change_event' {
			this.send_settings_change_event()
			return rt.new_null()
		}
		'track_settings_page_view' {
			this.track_settings_page_view()
			return rt.new_null()
		}
		'possibly_add_settings_tracking_scripts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.possibly_add_settings_tracking_scripts(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Settings_Tracking) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'allowed_options' { return this.allowed_options }
		'updated_options' { return this.updated_options }
		'dropdown_menu_options' { return this.dropdown_menu_options }
		'modified_options' { return this.modified_options }
		'deleted_options' { return this.deleted_options }
		'added_options' { return this.added_options }
		'toggled_options' { return this.toggled_options }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Settings_Tracking) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'allowed_options' {
			this.allowed_options = val
			return true
		}
		'updated_options' {
			this.updated_options = val
			return true
		}
		'dropdown_menu_options' {
			this.dropdown_menu_options = val
			return true
		}
		'modified_options' {
			this.modified_options = val
			return true
		}
		'deleted_options' {
			this.deleted_options = val
			return true
		}
		'added_options' {
			this.added_options = val
			return true
		}
		'toggled_options' {
			this.toggled_options = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Tracks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tracks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
