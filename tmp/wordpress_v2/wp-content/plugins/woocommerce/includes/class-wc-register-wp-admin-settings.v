import rt

struct Class_WC_Register_WP_Admin_Settings {
	rt.PhpObjectBase
pub mut:
	object rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Register_WP_Admin_Settings) construct(var_object rt.PhpVal, var_type rt.PhpVal) {
	if !(var_object.clone().is_object()) {
		return
	}
	this.object = var_object.clone()
	if rt.is_true(rt.identical(rt.new_string('page'), var_type)) {
		rt.call_function('add_filter', [rt.new_string('woocommerce_settings_groups'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Register_WP_Admin_Settings',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'register_page_group' },
			])])
		rt.call_function('add_filter', [
			rt.new_string('woocommerce_settings-' +
				(rt.call_method(this.object, 'get_id', []rt.PhpVal{})).str()),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Register_WP_Admin_Settings',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'register_page_settings' },
			]),
		])
	} else if rt.is_true(rt.identical(rt.new_string('email'), var_type)) {
		rt.call_function('add_filter', [rt.new_string('woocommerce_settings_groups'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Register_WP_Admin_Settings',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'register_email_group' },
			])])
		rt.call_function('add_filter', [
			rt.new_string('woocommerce_settings-email_' + (rt.get_property(this.object, 'id')).str()),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Register_WP_Admin_Settings',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'register_email_settings' },
			]),
		])
	}
}

fn (mut this Class_WC_Register_WP_Admin_Settings) register_email_group(var_groups rt.PhpVal) rt.PhpVal {
	mut var_groups_mutated := var_groups
	var_groups_mutated.array_push(rt.create_array([
		rt.ArrayItem{ key: 'id', val: 'email_' + (rt.get_property(this.object, 'id')).str() },
		rt.ArrayItem{ key: 'label', val: rt.get_property(this.object, 'title') },
		rt.ArrayItem{ key: 'description', val: rt.get_property(this.object, 'description') },
		rt.ArrayItem{ key: 'parent_id', val: 'email' },
	]))
	return var_groups_mutated.clone()
}

fn (mut this Class_WC_Register_WP_Admin_Settings) register_email_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	mut iter_1 := rt.get_property(this.object, 'form_fields').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_setting := item_1.val
		mut var_id := item_1.key
		var_setting.array_set('id', var_id.clone())
		var_setting.array_set('option_key', rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_method(this.object, 'get_option_key',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: none, val: var_id },
		]))
		mut var_new_setting := this.register_setting(var_setting.clone())
		if rt.is_true(var_new_setting) {
			var_settings_mutated.array_push(var_new_setting.clone())
		}
	}
	return var_settings_mutated.clone()
}

fn (mut this Class_WC_Register_WP_Admin_Settings) register_page_group(var_groups rt.PhpVal) rt.PhpVal {
	mut var_groups_mutated := var_groups
	var_groups_mutated.array_push(rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.call_method(this.object, 'get_id', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'label', val: rt.call_method(this.object, 'get_label', []rt.PhpVal{}) },
	]))
	return var_groups_mutated.clone()
}

fn (mut this Class_WC_Register_WP_Admin_Settings) register_page_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	mut var_sections := rt.call_method(this.object, 'get_sections', []rt.PhpVal{})
	if !rt.is_true(var_sections) {
		var_sections = rt.create_array([rt.ArrayItem{ key: '', val: '' }])
	}
	mut iter_2 := var_sections.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_section_label := item_2.val
		mut var_section := item_2.key
		mut var_settings_from_section := rt.call_method(this.object, 'get_settings', [
			var_section.clone(),
		])
		mut iter_3 := var_settings_from_section.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_setting := item_3.val
			if !(var_setting.array_isset(rt.new_string('id'))) {
				continue
			}
			var_setting.array_set('option_key', var_setting.array_get(rt.new_string('id')))
			mut var_new_setting := this.register_setting(var_setting.clone())
			if rt.is_true(var_new_setting) {
				var_settings_mutated.array_push(var_new_setting.clone())
			}
		}
	}
	return var_settings_mutated.clone()
}

fn (mut this Class_WC_Register_WP_Admin_Settings) register_setting(var_setting rt.PhpVal) rt.PhpVal {
	mut var_setting_mutated := var_setting
	if !(var_setting_mutated.array_isset(rt.new_string('id'))) {
		return rt.new_bool(false)
	}
	mut var_description := rt.new_string('')
	if !(!rt.is_true(var_setting_mutated.array_get(rt.new_string('desc')))) {
		var_description = var_setting_mutated.array_get(rt.new_string('desc'))
	} else if !(!rt.is_true(var_setting_mutated.array_get(rt.new_string('description')))) {
		var_description = var_setting_mutated.array_get(rt.new_string('description'))
	}
	mut var_new_setting := rt.create_array([
		rt.ArrayItem{ key: 'id', val: var_setting_mutated.array_get(rt.new_string('id')) },
		rt.ArrayItem{
			key: 'label'
			val: if !(!rt.is_true(var_setting_mutated.array_get(rt.new_string('title')))) {
				var_setting_mutated.array_get(rt.new_string('title'))
			} else {
				rt.new_string('')
			}
		},
		rt.ArrayItem{ key: 'description', val: var_description },
		rt.ArrayItem{ key: 'type', val: var_setting_mutated.array_get(rt.new_string('type')) },
		rt.ArrayItem{
			key: 'option_key'
			val: var_setting_mutated.array_get(rt.new_string('option_key'))
		},
	])
	if var_setting_mutated.array_isset(rt.new_string('default')) {
		var_new_setting.array_set('default',
			var_setting_mutated.array_get(rt.new_string('default')))
	}
	if var_setting_mutated.array_isset(rt.new_string('options')) {
		var_new_setting.array_set('options',
			var_setting_mutated.array_get(rt.new_string('options')))
	}
	if var_setting_mutated.array_isset(rt.new_string('desc_tip')) {
		if rt.is_true(rt.identical(rt.new_bool(true),
			var_setting_mutated.array_get(rt.new_string('desc_tip'))))
		{
			var_new_setting.array_set('tip', var_description.clone())
		} else if !(!rt.is_true(var_setting_mutated.array_get(rt.new_string('desc_tip')))) {
			var_new_setting.array_set('tip',
				var_setting_mutated.array_get(rt.new_string('desc_tip')))
		}
	}
	return var_new_setting.clone()
}

fn create_wc_register_wp_admin_settings(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_WC_Register_WP_Admin_Settings {
	mut obj := &Class_WC_Register_WP_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
		object:        rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn (mut this Class_WC_Register_WP_Admin_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'register_email_group' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.register_email_group(dispatch_arg_0)
		}
		'register_email_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.register_email_settings(dispatch_arg_0)
		}
		'register_page_group' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.register_page_group(dispatch_arg_0)
		}
		'register_page_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.register_page_settings(dispatch_arg_0)
		}
		'register_setting' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.register_setting(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Register_WP_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'object' { return this.object }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Register_WP_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'object' {
			this.object = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
