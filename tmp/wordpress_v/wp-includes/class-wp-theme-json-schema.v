import rt

pub fn Class_WP_Theme_JSON_Schema.v1_to_v2_renamed_paths() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'border.customRadius', val: 'border.radius' }, rt.ArrayItem{ key: 'spacing.customMargin', val: 'spacing.margin' }, rt.ArrayItem{ key: 'spacing.customPadding', val: 'spacing.padding' }, rt.ArrayItem{ key: 'typography.customLineHeight', val: 'typography.lineHeight' }])
}
struct Class_WP_Theme_JSON_Schema {
	rt.PhpObjectBase
}

fn Class_WP_Theme_JSON_Schema.migrate(var_theme_json rt.PhpVal, origin string) rt.PhpVal {
	mut var_theme_json_mutated := var_theme_json
	if !(var_theme_json_mutated.array_isset(rt.new_string('version'))) {
		var_theme_json_mutated = rt.create_array([rt.ArrayItem{ key: 'version', val: Class_WP_Theme_JSON.latest_schema() }])
	}
	mut switch_val_1 := var_theme_json_mutated.array_get('version')
	if rt.is_true(rt.equal(switch_val_1, rt.new_int(1))) {
		var_theme_json_mutated = Class_WP_Theme_JSON_Schema.migrate_v1_to_v2(var_theme_json_mutated.dup())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(2))) {
		var_theme_json_mutated = Class_WP_Theme_JSON_Schema.migrate_v2_to_v3(var_theme_json_mutated.dup(), rt.new_string(origin))
	}
	return var_theme_json_mutated.dup()
}

fn Class_WP_Theme_JSON_Schema.migrate_v1_to_v2(var_old rt.PhpVal) rt.PhpVal {
	mut var_new := var_old
	if var_old.array_isset(rt.new_string('settings')) {
		var_new.array_set('settings', Class_WP_Theme_JSON_Schema.rename_paths(var_old.array_get('settings'), Class_WP_Theme_JSON_Schema.v1_to_v2_renamed_paths()))
	}
	var_new.array_set('version', 2)
	return var_new.dup()
}

fn Class_WP_Theme_JSON_Schema.migrate_v2_to_v3(var_old rt.PhpVal, var_origin rt.PhpVal) rt.PhpVal {
	mut var_new := var_old
	var_new.array_set('version', 3)
	if rt.is_true(rt.identical(rt.new_string('custom'), var_origin)) {
		return var_new.dup()
	}
	if var_old.array_get('settings').array_get('typography').array_isset(rt.new_string('fontSizes')) {
		var_new.array_get_mut('settings').array_get_mut('typography').array_set('defaultFontSizes', false)
	}
	if var_old.array_get('settings').array_get('spacing').array_isset(rt.new_string('spacingSizes')) || var_old.array_get('settings').array_get('spacing').array_isset(rt.new_string('spacingScale')) {
		var_new.array_get_mut('settings').array_get_mut('spacing').array_set('defaultSpacingSizes', false)
	}
	if var_old.array_get('settings').array_get('spacing').array_isset(rt.new_string('spacingSizes')) {
		var_new.array_get('settings').array_get('spacing').array_unset(rt.new_string('spacingScale'))
	}
	return var_new.dup()
}

fn Class_WP_Theme_JSON_Schema.rename_paths(var_settings rt.PhpVal, var_paths_to_rename rt.PhpVal) rt.PhpVal {
	mut var_new_settings := var_settings
	Class_WP_Theme_JSON_Schema.rename_settings(var_new_settings.dup(), var_paths_to_rename.dup())
	if rt.is_true(rt.new_bool(var_new_settings.array_isset(rt.new_string('blocks')) && rt.is_true(rt.new_bool(var_new_settings.array_get('blocks').is_array())))) {
		{
			mut iter_1 := var_new_settings.array_get('blocks').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_block_settings := item_1.val
				Class_WP_Theme_JSON_Schema.rename_settings(var_block_settings.dup(), var_paths_to_rename.dup())
			}
		}
	}
	return var_new_settings.dup()
}

fn Class_WP_Theme_JSON_Schema.rename_settings(var_settings rt.PhpVal, var_paths_to_rename rt.PhpVal)  {
	{
		mut iter_1 := var_paths_to_rename.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_renamed := item_1.val
			mut var_original := item_1.key
			mut var_original_path := rt.call_function('explode', [rt.new_string('.'), var_original.dup()])
			mut var_renamed_path := rt.call_function('explode', [rt.new_string('.'), var_renamed.dup()])
			mut var_current_value := rt.call_function('_wp_array_get', [var_settings.dup(), var_original_path.dup(), rt.new_null()])
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				rt.call_function('_wp_array_set', [var_settings.dup(), var_renamed_path.dup(), var_current_value.dup()])
				Class_WP_Theme_JSON_Schema.unset_setting_by_path(var_settings.dup(), var_original_path.dup())
			}
		}
	}
}

fn Class_WP_Theme_JSON_Schema.unset_setting_by_path(var_settings rt.PhpVal, var_path rt.PhpVal)  {
	mut var_tmp_settings := rt.new_null()
	// unsupported expression: Expr_AssignRef
	mut var_last_key := rt.call_function('array_pop', [var_path.dup()])
	{
		mut iter_1 := var_path.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			// unsupported expression: Expr_AssignRef
		}
	}
	var_tmp_settings.array_unset(var_last_key)
}

fn create_wp_theme_json_schema() &Class_WP_Theme_JSON_Schema {
	mut obj := &Class_WP_Theme_JSON_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Theme_JSON_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'migrate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_WP_Theme_JSON_Schema.migrate(dispatch_arg_0, dispatch_arg_1)
		}
		'migrate_v1_to_v2' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Theme_JSON_Schema.migrate_v1_to_v2(dispatch_arg_0)
		}
		'migrate_v2_to_v3' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Theme_JSON_Schema.migrate_v2_to_v3(dispatch_arg_0, dispatch_arg_1)
		}
		'rename_paths' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Theme_JSON_Schema.rename_paths(dispatch_arg_0, dispatch_arg_1)
		}
		'rename_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WP_Theme_JSON_Schema.rename_settings(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'unset_setting_by_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WP_Theme_JSON_Schema.unset_setting_by_path(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_Theme_JSON_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme_JSON_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_class_wp_theme_json_schema_php() {
}
