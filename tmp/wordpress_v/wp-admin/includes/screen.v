import rt

fn get_column_headers(var_screen rt.PhpVal) rt.PhpVal {
	mut var_column_headers := rt.new_null()
	// unsupported statement: Stmt_Static
	if rt.is_true(rt.new_bool(var_screen.dup().is_string())) {
		var_screen = rt.call_function('convert_to_screen', [var_screen.dup()])
	}
	if !(var_column_headers.array_isset(rt.get_property(var_screen, 'id'))) {
		var_column_headers.array_set(rt.get_property(var_screen, 'id'), rt.call_function('apply_filters', [
			rt.concat(rt.concat(rt.new_string('manage_'), rt.get_property(var_screen, 'id')),
				rt.new_string('_columns')),
			rt.new_array(),
		]))
	}
	return var_column_headers.array_get(rt.get_property(var_screen, 'id'))
}

fn get_hidden_columns(var_screen rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_screen.dup().is_string())) {
		var_screen = rt.call_function('convert_to_screen', [var_screen.dup()])
	}
	mut var_hidden := rt.call_function('get_user_option', [
		'manage' + (rt.get_property(var_screen, 'id')).str() + 'columnshidden',
	])
	mut var_use_defaults := !(rt.is_true(rt.new_bool(var_hidden.dup().is_array())))
	if var_use_defaults {
		var_hidden = rt.new_array()
		var_hidden = rt.call_function('apply_filters', [
			rt.new_string('default_hidden_columns'),
			var_hidden.dup(),
			var_screen.dup(),
		])
	}
	return rt.call_function('apply_filters', [rt.new_string('hidden_columns'),
		var_hidden.dup(), var_screen.dup(), rt.new_bool(var_use_defaults).dup()])
}

fn meta_box_prefs(var_screen rt.PhpVal) {
	mut var_wp_meta_boxes := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(var_screen.dup().is_string())) {
		var_screen = rt.call_function('convert_to_screen', [var_screen.dup()])
	}
	if !rt.is_true(var_wp_meta_boxes.array_get(rt.get_property(var_screen, 'id'))) {
		return rt.new_null()
	}
	mut var_hidden := get_hidden_meta_boxes(var_screen.dup())
	{
		mut iter_1 :=
			rt.func_array_keys(var_wp_meta_boxes.array_get(rt.get_property(var_screen, 'id'))).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_context := item_1.val
			{
				mut iter_2 := rt.create_array([rt.ArrayItem{ key: none, val: 'high' },
					rt.ArrayItem{ key: none, val: 'core' }, rt.ArrayItem{ key: none, val: 'default' },
					rt.ArrayItem{ key: none, val: 'low' }]).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_priority := item_2.val
					if !(var_wp_meta_boxes.array_get(rt.get_property(var_screen, 'id')).array_get(var_context).array_isset(var_priority)) {
						continue
					}
					{
						mut iter_3 :=
							var_wp_meta_boxes.array_get(rt.get_property(var_screen, 'id')).array_get(var_context).array_get(var_priority).iterator()
						for {
							item_3 := iter_3.next() or { break }
							mut var_box := item_3.val
							if rt.is_true(rt.new_bool(
								rt.is_true(rt.identical(rt.new_bool(false), var_box))
								|| rt.is_true(rt.new_bool(!(rt.is_true(var_box.array_get('title')))))))
							{
								continue
							}
							if rt.is_true(rt.new_bool(
								rt.is_true(rt.identical(rt.new_string('submitdiv'), var_box.array_get('id')))
								|| rt.is_true(rt.identical(rt.new_string('linksubmitdiv'), var_box.array_get('id')))))
							{
								continue
							}
							mut var_widget_title := var_box.array_get('title')
							if rt.is_true(rt.new_bool(
								rt.is_true(rt.new_bool(var_box.array_get('args').is_array()))
								&& var_box.array_get('args').array_isset(rt.new_string('__widget_basename'))))
							{
								var_widget_title =
									var_box.array_get('args').array_get('__widget_basename')
							}
							mut var_is_hidden := rt.call_function('in_array', [
								var_box.array_get('id'),
								var_hidden.dup(),
								rt.new_bool(true),
							])
							rt.call_function('printf', [
								rt.new_string('<label for="%1$s-hide"><input class="hide-postbox-tog" name="%1$s-hide" type="checkbox" id="%1$s-hide" value="%1$s" %2$s />%3$s</label>'),
								rt.call_function('esc_attr', [
									var_box.array_get('id')]),
								rt.call_function('checked', [
									var_is_hidden.dup(), rt.new_bool(false),
									rt.new_bool(false)]),
								var_widget_title.dup(),
							])
						}
					}
				}
			}
		}
	}
}

fn get_hidden_meta_boxes(var_screen rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_screen.dup().is_string())) {
		var_screen = rt.call_function('convert_to_screen', [var_screen.dup()])
	}
	mut var_hidden := rt.call_function('get_user_option', [
		rt.concat(rt.new_string('metaboxhidden_'), rt.get_property(var_screen, 'id')),
	])
	mut var_use_defaults := !(rt.is_true(rt.new_bool(var_hidden.dup().is_array())))
	if var_use_defaults {
		var_hidden = rt.new_array()
		if rt.is_true(rt.identical(rt.new_string('post'), rt.get_property(var_screen, 'base'))) {
			if rt.is_true(rt.call_function('in_array', [
				rt.get_property(var_screen, 'post_type'),
				rt.create_array([rt.ArrayItem{ key: none, val: 'post' },
					rt.ArrayItem{ key: none, val: 'page' }, rt.ArrayItem{
						key: none
						val: 'attachment'
					}]),
				rt.new_bool(true),
			]))
			{
				var_hidden = rt.create_array([rt.ArrayItem{ key: none, val: 'slugdiv' },
					rt.ArrayItem{ key: none, val: 'trackbacksdiv' },
					rt.ArrayItem{ key: none, val: 'postcustom' },
					rt.ArrayItem{ key: none, val: 'postexcerpt' },
					rt.ArrayItem{ key: none, val: 'commentstatusdiv' },
					rt.ArrayItem{ key: none, val: 'commentsdiv' },
					rt.ArrayItem{ key: none, val: 'authordiv' },
					rt.ArrayItem{ key: none, val: 'revisionsdiv' }])
			} else {
				var_hidden = rt.create_array([rt.ArrayItem{ key: none, val: 'slugdiv' }])
			}
		}
		var_hidden = rt.call_function('apply_filters', [
			rt.new_string('default_hidden_meta_boxes'),
			var_hidden.dup(),
			var_screen.dup(),
		])
	}
	return rt.call_function('apply_filters', [rt.new_string('hidden_meta_boxes'),
		var_hidden.dup(), var_screen.dup(), rt.new_bool(var_use_defaults).dup()])
}

fn add_screen_option(var_option rt.PhpVal, var_args rt.PhpVal) {
	mut var_current_screen := get_current_screen()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_current_screen)))) {
		return rt.new_null()
	}
	rt.call_method(var_current_screen, 'add_option', [var_option.dup(),
		var_args.dup()])
}

fn get_current_screen() rt.PhpVal {
	mut var_current_screen := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_current_screen,
		'WP_Screen'))))))
	{
		return rt.new_null()
	}
	return var_current_screen.dup()
}

fn set_current_screen(hook_name string) {
	rt.call_method(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WP_Screen{}
		return temp.get(arg_0)
	}(rt.new_string(hook_name)), 'set_current_screen', []rt.PhpVal{})
}

struct Class_WP_Screen {
	rt.PhpObjectBase
}

fn create_wp_screen() &Class_WP_Screen {
	mut obj := &Class_WP_Screen{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Screen) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Screen) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Screen) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_admin_includes_screen_php() {
}
