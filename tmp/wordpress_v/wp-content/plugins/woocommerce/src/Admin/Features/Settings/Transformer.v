import rt

struct Class_Automattic_WooCommerce_Admin_Features_Settings_Transformer {
	rt.PhpObjectBase
pub mut:
		current_group rt.PhpVal = rt.new_null()
		current_checkbox_group rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_Transformer) transform(mut var_raw_settings Class_Automattic_WooCommerce_Admin_Features_Settings_array) rt.PhpVal {
	mut var_transformed := rt.new_array()
	{
		mut iter_1 := var_raw_settings.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tab := item_1.val
			mut var_tab_id := item_1.key
			if rt.is_true(rt.new_bool(!(var_tab.array_isset(rt.new_string('sections'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_tab.array_get('sections').is_array()))))))) {
				var_transformed.array_set(var_tab_id, var_tab.dup())
				continue
			}
			var_transformed.array_set(var_tab_id, var_tab.dup())
			var_transformed.array_get_mut(var_tab_id).array_set('sections', this.transform_sections(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Settings_array](var_tab.array_get('sections'))))
		}
	}
	return var_transformed.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_Transformer) transform_sections(mut var_sections Class_Automattic_WooCommerce_Admin_Features_Settings_array) rt.PhpVal {
	mut var_transformed_sections := rt.new_array()
	{
		mut iter_1 := var_sections.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_section := item_1.val
			mut var_section_id := item_1.key
			if rt.is_true(rt.new_bool(!(var_section.array_isset(rt.new_string('settings'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_section.array_get('settings').is_array()))))))) {
				var_transformed_sections.array_set(var_section_id, var_section.dup())
				continue
			}
			var_transformed_sections.array_set(var_section_id, var_section.dup())
			var_transformed_sections.array_get_mut(var_section_id).array_set('settings', this.transform_section_settings(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Settings_array](var_section.array_get('settings'))))
		}
	}
	return var_transformed_sections.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_Transformer) transform_section_settings(mut var_settings Class_Automattic_WooCommerce_Admin_Features_Settings_array) rt.PhpVal {
	this.reset_state()
	mut var_transformed_settings := rt.new_array()
	{
		mut iter_1 := var_settings.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_setting := item_1.val
			this.process_setting(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Settings_?array](var_setting), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Settings_array](var_transformed_settings))
		}
	}
	this.finalize_transformation(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Settings_array](var_transformed_settings))
	return var_transformed_settings.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_Transformer) process_setting(mut var_setting Class_Automattic_WooCommerce_Admin_Features_Settings_?array, mut var_transformed_settings Class_Automattic_WooCommerce_Admin_Features_Settings_array)  {
	mut var_setting_mutated := var_setting
	mut var_transformed_settings_mutated := var_transformed_settings
	if !(!(var_setting_mutated).is_null()) {
		return rt.new_null()
	}
	mut var_type := if !(var_setting_mutated.array_get('type')).is_null() { var_setting_mutated.array_get('type') } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(rt.is_true(this.current_checkbox_group) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		this.flush_current_checkbox_group()
	}
	mut switch_val_1 := var_type
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('title'))) {
		this.handle_group_start(mut var_setting_mutated, mut var_transformed_settings_mutated)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('sectionend'))) {
		this.handle_group_end(mut var_setting_mutated, mut var_transformed_settings_mutated)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('checkbox'))) {
		this.handle_checkbox_setting(mut var_setting_mutated, mut var_transformed_settings_mutated)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('info'))) {
		if !(!rt.is_true(var_setting_mutated.array_get('text'))) {
			var_setting_mutated.array_set('text', rt.call_function('wp_kses_post', [rt.call_function('wpautop', [rt.call_function('wptexturize', [var_setting_mutated.array_get('text')])])]))
		}
		if rt.is_true(rt.new_bool(!(!rt.is_true(var_setting_mutated.array_get('row_class'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			var_setting_mutated.array_set('row_class', 'wc-settings-row-' + (var_setting_mutated.array_get('row_class')).str())
		}
		this.add_setting(mut var_setting_mutated, mut var_transformed_settings_mutated)
	} else {
		this.add_setting(mut var_setting_mutated, mut var_transformed_settings_mutated)
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_Transformer) handle_group_start(mut var_setting Class_Automattic_WooCommerce_Admin_Features_Settings_array, mut var_transformed_settings Class_Automattic_WooCommerce_Admin_Features_Settings_array)  {
	mut var_setting_mutated := var_setting
	mut var_transformed_settings_mutated := var_transformed_settings
	if rt.is_true(this.current_group) {
		this.flush_current_group(mut var_transformed_settings_mutated)
	}
	this.current_group = rt.create_array([rt.ArrayItem{ key: none, val: var_setting_mutated }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_Transformer) handle_group_end(mut var_setting Class_Automattic_WooCommerce_Admin_Features_Settings_array, mut var_transformed_settings Class_Automattic_WooCommerce_Admin_Features_Settings_array)  {
	mut var_setting_mutated := var_setting
	mut var_transformed_settings_mutated := var_transformed_settings
	mut var_ids_match := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(this.current_group) && this.current_group.array_get(0).array_isset(rt.new_string('id')))) && var_setting_mutated.array_isset(rt.new_string('id')))) && rt.is_true(rt.identical(this.current_group.array_get(0).array_get('id'), var_setting_mutated.array_get('id')))))
	mut var_ids_match_undefined := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(this.current_group) && !(this.current_group.array_get(0).array_isset(rt.new_string('id'))))) && !(var_setting_mutated.array_isset(rt.new_string('id')))))
	if rt.is_true(rt.new_bool(rt.is_true(var_ids_match) || rt.is_true(var_ids_match_undefined))) {
		mut var_title_setting := rt.call_function('array_shift', [this.current_group])
		var_title_setting.array_set('id', if !(var_title_setting.array_get('id')).is_null() { var_title_setting.array_get('id') } else { rt.call_function('wp_unique_prefixed_id', [rt.new_string('setting_group')]) })
		var_transformed_settings_mutated.array_push(rt.call_function('array_merge', [var_title_setting.dup(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'group' }, rt.ArrayItem{ key: 'settings', val: this.current_group }])]))
		this.current_group = rt.new_null()
		return rt.new_null()
	}
	this.flush_current_group(mut var_transformed_settings_mutated)
	this.add_setting(mut var_setting_mutated, mut var_transformed_settings_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_Transformer) flush_current_group(mut var_transformed_settings Class_Automattic_WooCommerce_Admin_Features_Settings_array)  {
	mut var_transformed_settings_mutated := var_transformed_settings
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(this.current_group.is_array())) && !(!rt.is_true(this.current_group)))) {
		this.current_group.array_get_mut(0).array_set('id', if !(this.current_group.array_get(0).array_get('id')).is_null() { this.current_group.array_get(0).array_get('id') } else { rt.call_function('wp_unique_prefixed_id', [rt.new_string('setting_title')]) })
		var_transformed_settings_mutated = rt.call_function('array_merge', [var_transformed_settings_mutated.dup(), this.current_group])
	}
	this.current_group = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_Transformer) handle_checkbox_setting(mut var_setting Class_Automattic_WooCommerce_Admin_Features_Settings_array, mut var_transformed_settings Class_Automattic_WooCommerce_Admin_Features_Settings_array)  {
	mut var_setting_mutated := var_setting
	mut var_transformed_settings_mutated := var_transformed_settings
	mut var_checkboxgroup := if !(var_setting_mutated.array_get('checkboxgroup')).is_null() { var_setting_mutated.array_get('checkboxgroup') } else { rt.new_string('') }
	mut switch_val_2 := var_checkboxgroup
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('start'))) {
		this.start_checkbox_group(mut var_setting_mutated)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('end'))) {
		this.end_checkbox_group(mut var_setting_mutated, mut var_transformed_settings_mutated)
	} else {
		this.handle_checkbox_group_item(mut var_setting_mutated, mut var_transformed_settings_mutated)
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_Transformer) start_checkbox_group(mut var_setting Class_Automattic_WooCommerce_Admin_Features_Settings_array)  {
	mut var_setting_mutated := var_setting
	if rt.is_true(rt.new_bool(this.current_checkbox_group.is_array())) {
		this.flush_current_checkbox_group()
	}
	this.current_checkbox_group = rt.create_array([rt.ArrayItem{ key: none, val: var_setting_mutated }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_Transformer) end_checkbox_group(mut var_setting Class_Automattic_WooCommerce_Admin_Features_Settings_array, mut var_transformed_settings Class_Automattic_WooCommerce_Admin_Features_Settings_array)  {
	mut var_setting_mutated := var_setting
	mut var_transformed_settings_mutated := var_transformed_settings
	if !rt.is_true(this.current_checkbox_group) {
		this.add_setting(mut var_setting_mutated, mut var_transformed_settings_mutated)
		return rt.new_null()
	}
	this.current_checkbox_group.array_push(var_setting_mutated.dup())
	mut var_first_setting := this.current_checkbox_group.array_get(0)
	mut var_checkbox_group_setting := rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_function('wp_unique_prefixed_id', [rt.new_string('setting_checkboxgroup')]) }, rt.ArrayItem{ key: 'type', val: 'checkboxgroup' }, rt.ArrayItem{ key: 'title', val: if !(var_first_setting.array_get('title')).is_null() { var_first_setting.array_get('title') } else { rt.new_string('') } }, rt.ArrayItem{ key: 'settings', val: this.current_checkbox_group }])
	this.add_setting(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Settings_array](var_checkbox_group_setting), mut var_transformed_settings_mutated)
	this.current_checkbox_group = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_Transformer) handle_checkbox_group_item(mut var_setting Class_Automattic_WooCommerce_Admin_Features_Settings_array, mut var_transformed_settings Class_Automattic_WooCommerce_Admin_Features_Settings_array)  {
	mut var_setting_mutated := var_setting
	mut var_transformed_settings_mutated := var_transformed_settings
	if rt.is_true(rt.new_bool(this.current_checkbox_group.is_array())) {
		this.current_checkbox_group.array_push(var_setting_mutated.dup())
		return rt.new_null()
	}
	this.add_setting(mut var_setting_mutated, mut var_transformed_settings_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_Transformer) flush_current_checkbox_group()  {
	if rt.is_true(rt.new_bool(this.current_checkbox_group.is_array())) {
		if rt.is_true(rt.new_bool(this.current_group.is_array())) {
			this.current_group = rt.call_function('array_merge', [this.current_group, this.current_checkbox_group])
		} else {
			this.current_group = this.current_checkbox_group
		}
		this.current_checkbox_group = rt.new_null()
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_Transformer) add_setting(mut var_setting Class_Automattic_WooCommerce_Admin_Features_Settings_array, mut var_transformed_settings Class_Automattic_WooCommerce_Admin_Features_Settings_array)  {
	mut var_setting_mutated := var_setting
	mut var_transformed_settings_mutated := var_transformed_settings
	var_setting_mutated.array_set('id', if !(var_setting_mutated.array_get('id')).is_null() { var_setting_mutated.array_get('id') } else { rt.call_function('wp_unique_prefixed_id', [rt.new_string('setting_field')]) })
	if rt.is_true(rt.new_bool(this.current_group.is_array())) {
		this.current_group.array_push(var_setting_mutated.dup())
		return rt.new_null()
	}
	var_transformed_settings_mutated.array_push(var_setting_mutated.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_Transformer) finalize_transformation(mut var_transformed_settings Class_Automattic_WooCommerce_Admin_Features_Settings_array)  {
	mut var_transformed_settings_mutated := var_transformed_settings
	this.flush_current_checkbox_group()
	this.flush_current_group(mut var_transformed_settings_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_Transformer) reset_state()  {
	this.current_group = rt.new_null()
	this.current_checkbox_group = rt.new_null()
}

fn create_automattic_woocommerce_admin_features_settings_transformer() &Class_Automattic_WooCommerce_Admin_Features_Settings_Transformer {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Settings_Transformer{
		PhpObjectBase: rt.PhpObjectBase{}
		current_group: rt.new_null()
		current_checkbox_group: rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_Transformer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'transform' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.transform(mut dispatch_arg_0)
		}
		'transform_sections' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.transform_sections(mut dispatch_arg_0)
		}
		'transform_section_settings' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.transform_section_settings(mut dispatch_arg_0)
		}
		'process_setting' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Settings_?array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Settings_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.process_setting(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'handle_group_start' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Settings_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.handle_group_start(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'handle_group_end' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Settings_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.handle_group_end(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'flush_current_group' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.flush_current_group(mut dispatch_arg_0)
			return rt.new_null()
		}
		'handle_checkbox_setting' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Settings_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.handle_checkbox_setting(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'start_checkbox_group' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.start_checkbox_group(mut dispatch_arg_0)
			return rt.new_null()
		}
		'end_checkbox_group' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Settings_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.end_checkbox_group(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'handle_checkbox_group_item' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Settings_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.handle_checkbox_group_item(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'flush_current_checkbox_group' {
			this.flush_current_checkbox_group()
			return rt.new_null()
		}
		'add_setting' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Settings_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.add_setting(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'finalize_transformation' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.finalize_transformation(mut dispatch_arg_0)
			return rt.new_null()
		}
		'reset_state' {
			this.reset_state()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Settings_Transformer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'current_group' { return this.current_group }
		'current_checkbox_group' { return this.current_checkbox_group }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Settings_Transformer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'current_group' { this.current_group = val; return true }
		'current_checkbox_group' { this.current_checkbox_group = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_src_admin_features_settings_transformer_php() {
	// unsupported statement: Stmt_Declare
}
