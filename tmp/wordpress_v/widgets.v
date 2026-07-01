module wp_includes

import rt

fn register_widget(widget string) {
	mut var_widget := widget
	mut var_wp_widget_factory := rt.new_null()
	rt.call_method(var_wp_widget_factory, 'register', [rt.new_string(widget)])
}

fn unregister_widget(var_widget rt.PhpVal) {
	mut var_wp_widget_factory := rt.new_null()
	rt.call_method(var_wp_widget_factory, 'unregister', [var_widget.clone()])
}

fn register_sidebars(number i64, var_args rt.PhpVal) {
	mut var_number := number
	mut var_wp_registered_sidebars := rt.new_null()
	mut var__args := rt.new_null()
	mut var_n := i64(0)
	mut var_i := i64(0)
	var_number = var_number
	if rt.is_true(rt.new_bool(var_args.clone().is_string())) {
		rt.call_function('parse_str', [var_args.clone(), var_args.clone()])
	}
	{
		var_i = 1
		for {
			if !(var_i <= var_number) { break }
			var__args = var_args.clone()
			if var_number > 1 {
				if var_args.array_isset(rt.new_string('name')) {
					var__args.array_set('name', rt.call_function('sprintf', [var_args.array_get('name'), rt.new_int(var_i).clone()]))
				} else {
					var__args.array_set('name', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Sidebar %d')]), rt.new_int(var_i).clone()]))
				}
			} else {
				var__args.array_set('name', if !(var_args.array_get('name')).is_null() { var_args.array_get('name') } else { rt.call_function('__', [rt.new_string('Sidebar')]) })
			}
			if var_args.array_isset(rt.new_string('id')) {
				var__args.array_set('id', var_args.array_get('id'))
				var_n = 2
				for rt.is_true(is_registered_sidebar(var__args.array_get('id'))) {
					var__args.array_set('id', (var_args.array_get('id')).str() + '-' + (rt.post_inc(rt.new_int(var_n))).str())
				}
			} else {
				var_n = var_wp_registered_sidebars.clone().array_count()
				for {
					var__args.array_set('id', 'sidebar-' + (rt.pre_inc(rt.new_int(var_n))).str())
					if !(rt.is_true(is_registered_sidebar(var__args.array_get('id')))) {
						break
					}
				}
			}
			register_sidebar(var__args.clone())
			var_i += 1
		}
	}
}

fn register_sidebar(var_args rt.PhpVal) rt.PhpVal {
	mut var_wp_registered_sidebars := rt.new_null()
	mut var_i := i64(0)
	mut var_id_is_empty := rt.new_null()
	mut var_defaults := rt.new_null()
	mut var_sidebar := rt.new_null()
	var_i = var_wp_registered_sidebars.clone().array_count() + 1
	var_id_is_empty = rt.new_bool(!rt.is_true(var_args.array_get('id')))
	var_defaults = rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Sidebar %d')]), rt.new_int(var_i).clone()]) }, rt.ArrayItem{ key: 'id', val: "sidebar-${var_i.str()}" }, rt.ArrayItem{ key: 'description', val: '' }, rt.ArrayItem{ key: 'class', val: '' }, rt.ArrayItem{ key: 'before_widget', val: '<li id="%1$s" class="widget %2$s">' }, rt.ArrayItem{ key: 'after_widget', val: '</li>\n' }, rt.ArrayItem{ key: 'before_title', val: '<h2 class="widgettitle">' }, rt.ArrayItem{ key: 'after_title', val: '</h2>\n' }, rt.ArrayItem{ key: 'before_sidebar', val: '' }, rt.ArrayItem{ key: 'after_sidebar', val: '' }, rt.ArrayItem{ key: 'show_in_rest', val: false }])
	var_sidebar = rt.call_function('wp_parse_args', [var_args.clone(), rt.call_function('apply_filters', [rt.new_string('register_sidebar_defaults'), var_defaults.clone()])])
	if rt.is_true(var_id_is_empty) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('No %1$s was set in the arguments array for the "%2$s" sidebar. Defaulting to "%3$s". Manually set the %1$s to "%3$s" to silence this notice and keep existing sidebar content.')]), rt.new_string('<code>id</code>'), var_sidebar.array_get('name'), var_sidebar.array_get('id')]), rt.new_string('4.2.0')])
	}
	var_wp_registered_sidebars.array_set(var_sidebar.array_get('id'), var_sidebar.clone())
	rt.call_function('add_theme_support', [rt.new_string('widgets')])
	rt.call_function('do_action', [rt.new_string('register_sidebar'), var_sidebar.clone()])
	return var_sidebar.array_get('id')
}

fn unregister_sidebar(var_sidebar_id rt.PhpVal) {
	mut var_wp_registered_sidebars := rt.new_null()
	var_wp_registered_sidebars.array_unset(var_sidebar_id)
}

fn is_registered_sidebar(var_sidebar_id rt.PhpVal) rt.PhpVal {
	mut var_wp_registered_sidebars := rt.new_null()
	return rt.new_bool(var_wp_registered_sidebars.array_isset(var_sidebar_id))
}

fn wp_register_sidebar_widget(var_id_arg rt.PhpVal, name string, output_callback string, var_options_arg rt.PhpVal, var_params_origin ...rt.PhpVal) {
	mut var_params := rt.create_array_from_list(var_params_origin)
	mut var_name := name
	mut var_output_callback := output_callback
	mut var_id := var_id_arg
	mut var_options := var_options_arg
	mut var_wp_registered_widgets := rt.new_null()
	mut var_wp_registered_widget_controls := rt.new_null()
	mut var_wp_registered_widget_updates := rt.new_null()
	mut var__wp_deprecated_widgets_callbacks := rt.new_null()
	mut var_id_base := rt.new_null()
	mut var_defaults := rt.new_null()
	mut var_widget := rt.new_null()
	var_id = var_id.to_lower()
	if output_callback == '' {
		var_wp_registered_widgets.array_unset(rt.new_string((var_id).str()))
		return
	}
	var_id_base = _get_widget_id_base(rt.new_string((var_id).str()).clone())
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [rt.new_string(output_callback), var__wp_deprecated_widgets_callbacks.clone(), rt.new_bool(true)])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string(output_callback)]))))))) {
		var_wp_registered_widget_controls.array_unset(rt.new_string((var_id).str()))
		var_wp_registered_widget_updates.array_unset(var_id_base)
		return
	}
	var_defaults = rt.create_array([rt.ArrayItem{ key: 'classname', val: output_callback }])
	var_options = rt.call_function('wp_parse_args', [var_options.clone(), var_defaults.clone()])
	var_widget = rt.create_array([rt.ArrayItem{ key: 'name', val: name }, rt.ArrayItem{ key: 'id', val: var_id }, rt.ArrayItem{ key: 'callback', val: output_callback }, rt.ArrayItem{ key: 'params', val: var_params }])
	var_widget = rt.call_function('array_merge', [var_widget.clone(), var_options.clone()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_callable', [rt.new_string(output_callback)])) && rt.is_true(rt.new_bool(!(var_wp_registered_widgets.array_isset(rt.new_string((var_id).str()))) || rt.is_true(rt.call_function('did_action', [rt.new_string('widgets_init')])))))) {
		rt.call_function('do_action', [rt.new_string('wp_register_sidebar_widget'), var_widget.clone()])
		var_wp_registered_widgets.array_set(var_id, var_widget.clone())
	}
}

fn wp_widget_description(var_id rt.PhpVal) rt.PhpVal {
	mut var_wp_registered_widgets := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [var_id.clone()]))))) {
		return rt.new_null()
	}
	if var_wp_registered_widgets.array_get(var_id).array_isset(rt.new_string('description')) {
		return rt.call_function('esc_html', [var_wp_registered_widgets.array_get(var_id).array_get('description')])
	}
	return rt.new_null()
}

fn wp_sidebar_description(var_id rt.PhpVal) rt.PhpVal {
	mut var_wp_registered_sidebars := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [var_id.clone()]))))) {
		return rt.new_null()
	}
	if var_wp_registered_sidebars.array_get(var_id).array_isset(rt.new_string('description')) {
		return rt.call_function('wp_kses', [var_wp_registered_sidebars.array_get(var_id).array_get('description'), rt.new_string('sidebar_description')])
	}
	return rt.new_null()
}

fn wp_unregister_sidebar_widget(var_id rt.PhpVal) {
	rt.call_function('do_action', [rt.new_string('wp_unregister_sidebar_widget'), var_id.clone()])
	wp_register_sidebar_widget(var_id.clone(), '', '', rt.new_null())
	wp_unregister_widget_control(var_id.clone())
}

fn wp_register_widget_control(var_id_arg rt.PhpVal, name string, control_callback string, var_options_arg rt.PhpVal, var_params_origin ...rt.PhpVal) {
	mut var_params := rt.create_array_from_list(var_params_origin)
	mut var_name := name
	mut var_control_callback := control_callback
	mut var_id := var_id_arg
	mut var_options := var_options_arg
	mut var_wp_registered_widget_controls := rt.new_null()
	mut var_wp_registered_widget_updates := rt.new_null()
	mut var_wp_registered_widgets := rt.new_null()
	mut var__wp_deprecated_widgets_callbacks := rt.new_null()
	mut var_id_base := rt.new_null()
	mut var_defaults := rt.new_null()
	mut var_widget := rt.new_null()
	var_id = var_id.to_lower()
	var_id_base = _get_widget_id_base(rt.new_string((var_id).str()).clone())
	if control_callback == '' {
		var_wp_registered_widget_controls.array_unset(rt.new_string((var_id).str()))
		var_wp_registered_widget_updates.array_unset(var_id_base)
		return
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [rt.new_string(control_callback), var__wp_deprecated_widgets_callbacks.clone(), rt.new_bool(true)])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.new_string(control_callback)]))))))) {
		var_wp_registered_widgets.array_unset(rt.new_string((var_id).str()))
		return
	}
	if rt.is_true(rt.new_bool(var_wp_registered_widget_controls.array_isset(rt.new_string((var_id).str())) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('widgets_init')]))))))) {
		return
	}
	var_defaults = rt.create_array([rt.ArrayItem{ key: 'width', val: 250 }, rt.ArrayItem{ key: 'height', val: 200 }])
	var_options = rt.call_function('wp_parse_args', [var_options.clone(), var_defaults.clone()])
	var_options.array_set('width', rt.new_int((var_options.array_get('width')).to_i64()))
	var_options.array_set('height', rt.new_int((var_options.array_get('height')).to_i64()))
	var_widget = rt.create_array([rt.ArrayItem{ key: 'name', val: name }, rt.ArrayItem{ key: 'id', val: var_id }, rt.ArrayItem{ key: 'callback', val: control_callback }, rt.ArrayItem{ key: 'params', val: var_params }])
	var_widget = rt.call_function('array_merge', [var_widget.clone(), var_options.clone()])
	var_wp_registered_widget_controls.array_set(var_id, var_widget.clone())
	if var_wp_registered_widget_updates.array_isset(var_id_base) {
		return
	}
	if var_widget.array_get('params').array_get(0).array_isset(rt.new_string('number')) {
		var_widget.array_get_mut('params').array_get_mut(0).array_set('number', -1)
	}
	var_widget.array_unset(rt.new_string('width'))
	var_widget.array_unset(rt.new_string('height'))
	var_widget.array_unset(rt.new_string('name'))
	var_widget.array_unset(rt.new_string('id'))
	var_wp_registered_widget_updates.array_set(var_id_base, var_widget.clone())
}

fn _register_widget_update_callback(var_id_base rt.PhpVal, var_update_callback rt.PhpVal, var_options rt.PhpVal, var_params_origin ...rt.PhpVal) {
	mut var_params := rt.create_array_from_list(var_params_origin)
	mut var_wp_registered_widget_updates := rt.new_null()
	mut var_widget := rt.new_null()
	if var_wp_registered_widget_updates.array_isset(var_id_base) {
		if !rt.is_true(var_update_callback) {
			var_wp_registered_widget_updates.array_unset(var_id_base)
		}
		return
	}
	var_widget = rt.create_array([rt.ArrayItem{ key: 'callback', val: var_update_callback }, rt.ArrayItem{ key: 'params', val: var_params }])
	var_widget = rt.call_function('array_merge', [var_widget.clone(), var_options.clone()])
	var_wp_registered_widget_updates.array_set(var_id_base, var_widget.clone())
}

fn _register_widget_form_callback(var_id_arg rt.PhpVal, var_name rt.PhpVal, var_form_callback rt.PhpVal, var_options_arg rt.PhpVal, var_params_origin ...rt.PhpVal) {
	mut var_params := rt.create_array_from_list(var_params_origin)
	mut var_id := var_id_arg
	mut var_options := var_options_arg
	mut var_wp_registered_widget_controls := rt.new_null()
	mut var_defaults := rt.new_null()
	mut var_widget := rt.new_null()
	var_id = var_id.to_lower()
	if !rt.is_true(var_form_callback) {
		var_wp_registered_widget_controls.array_unset(rt.new_string((var_id).str()))
		return
	}
	if rt.is_true(rt.new_bool(var_wp_registered_widget_controls.array_isset(rt.new_string((var_id).str())) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('widgets_init')]))))))) {
		return
	}
	var_defaults = rt.create_array([rt.ArrayItem{ key: 'width', val: 250 }, rt.ArrayItem{ key: 'height', val: 200 }])
	var_options = rt.call_function('wp_parse_args', [var_options.clone(), var_defaults.clone()])
	var_options.array_set('width', rt.new_int((var_options.array_get('width')).to_i64()))
	var_options.array_set('height', rt.new_int((var_options.array_get('height')).to_i64()))
	var_widget = rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'id', val: var_id }, rt.ArrayItem{ key: 'callback', val: var_form_callback }, rt.ArrayItem{ key: 'params', val: var_params }])
	var_widget = rt.call_function('array_merge', [var_widget.clone(), var_options.clone()])
	var_wp_registered_widget_controls.array_set(var_id, var_widget.clone())
}

fn wp_unregister_widget_control(var_id rt.PhpVal) {
	wp_register_widget_control(var_id.clone(), '', '', rt.new_null())
}

fn dynamic_sidebar(index i64) rt.PhpVal {
	mut var_index := index
	mut var_wp_registered_sidebars := rt.new_null()
	mut var_wp_registered_widgets := rt.new_null()
	mut var_value := map[string]rt.PhpVal{}
	mut var_key := rt.new_null()
	mut var_sidebars_widgets := rt.new_null()
	mut var_sidebar := rt.new_null()
	mut var_did_one := false
	mut var_id := rt.new_null()
	mut var_params := rt.new_null()
	mut var_classname_ := ''
	mut var_cn := rt.new_null()
	mut var_callback := rt.new_null()
	if rt.is_true(rt.new_bool(rt.new_int(var_index).is_long())) {
		var_index = "sidebar-${var_index.str()}"
	} else {
		var_index = (rt.call_function('sanitize_title', [rt.new_int(var_index)])).to_i64()
		{
			mut iter_1 := rt.cast_array(var_wp_registered_sidebars).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value_shadow := item_1.val
				mut var_key_shadow := item_1.key
				if rt.is_true(rt.identical(rt.call_function('sanitize_title', [var_value_shadow.array_get('name')]), rt.new_int(var_index))) {
					var_index = (var_key_shadow).to_i64()
					break
				}
			}
		}
	}
	var_sidebars_widgets = wp_get_sidebars_widgets(false)
	if rt.is_true(rt.new_bool(!rt.is_true(var_wp_registered_sidebars.array_get(var_index)) || !rt.is_true(var_sidebars_widgets.array_get(var_index)) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_sidebars_widgets.array_get(var_index).is_array()))))))) {
		rt.call_function('do_action', [rt.new_string('dynamic_sidebar_before'), rt.new_int(var_index), rt.new_bool(false)])
		rt.call_function('do_action', [rt.new_string('dynamic_sidebar_after'), rt.new_int(var_index), rt.new_bool(false)])
		return rt.call_function('apply_filters', [rt.new_string('dynamic_sidebar_has_widgets'), rt.new_bool(false), rt.new_int(var_index)])
	}
	var_sidebar = var_wp_registered_sidebars.array_get(var_index)
	var_sidebar.array_set('before_sidebar', rt.call_function('sprintf', [var_sidebar.array_get('before_sidebar'), var_sidebar.array_get('id'), var_sidebar.array_get('class')]))
	rt.call_function('do_action', [rt.new_string('dynamic_sidebar_before'), rt.new_int(var_index), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) && !(!rt.is_true(var_sidebar.array_get('before_sidebar'))))) {
		rt.echo_val(var_sidebar.array_get('before_sidebar'))
	}
	var_did_one = false
	{
		mut iter_1 := rt.cast_array(var_sidebars_widgets.array_get(var_index)).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_id_shadow := item_1.val
			if !(var_wp_registered_widgets.array_isset(var_id_shadow)) {
				continue
			}
			var_params = rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('array_merge', [var_sidebar.clone(), rt.create_array([rt.ArrayItem{ key: 'widget_id', val: var_id_shadow }, rt.ArrayItem{ key: 'widget_name', val: var_wp_registered_widgets.array_get(var_id_shadow).array_get('name') }])]) }]), rt.cast_array(var_wp_registered_widgets.array_get(var_id_shadow).array_get('params'))])
			var_classname_ = ''
			{
				mut iter_2 := rt.cast_array(var_wp_registered_widgets.array_get(var_id_shadow).array_get('classname')).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_cn_shadow := item_2.val
					if rt.is_true(rt.new_bool(var_cn_shadow.clone().is_string())) {
						var_classname_ = var_classname_ + '_' + (var_cn_shadow).str()
					} else if rt.is_true(rt.new_bool(var_cn_shadow.clone().is_object())) {
						var_classname_ = var_classname_ + '_' + (rt.call_function('get_class', [var_cn_shadow.clone()])).str()
					}
				}
			}
			var_classname_ = var_classname_.trim_left(' \t\n\r')
			var_params.array_get_mut(0).array_set('before_widget', rt.call_function('sprintf', [var_params.array_get(0).array_get('before_widget'), rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('_'), var_id_shadow.clone()]), rt.new_string((var_classname_).str()).clone()]))
			var_params = rt.call_function('apply_filters', [rt.new_string('dynamic_sidebar_params'), var_params.clone()])
			var_callback = var_wp_registered_widgets.array_get(var_id_shadow).array_get('callback')
			rt.call_function('do_action', [rt.new_string('dynamic_sidebar'), var_wp_registered_widgets.array_get(var_id_shadow)])
			if rt.is_true(rt.call_function('is_callable', [var_callback.clone()])) {
				rt.call_function('call_user_func_array', [var_callback.clone(), var_params.clone()])
				var_did_one = true
			}
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) && !(!rt.is_true(var_sidebar.array_get('after_sidebar'))))) {
		rt.echo_val(var_sidebar.array_get('after_sidebar'))
	}
	rt.call_function('do_action', [rt.new_string('dynamic_sidebar_after'), rt.new_int(var_index), rt.new_bool(true)])
	return rt.call_function('apply_filters', [rt.new_string('dynamic_sidebar_has_widgets'), rt.new_bool(var_did_one).clone(), rt.new_int(var_index)])
}

fn is_active_widget(callback bool, widget_id bool, id_base bool, skip_inactive bool) bool {
	mut var_callback := callback
	mut var_widget_id := widget_id
	mut var_id_base := id_base
	mut var_skip_inactive := skip_inactive
	mut var_wp_registered_widgets := rt.new_null()
	mut var_sidebars_widgets := rt.new_null()
	mut var_widgets := rt.new_null()
	mut var_sidebar := rt.new_null()
	mut var_widget := rt.new_null()
	var_sidebars_widgets = wp_get_sidebars_widgets(false)
	if rt.is_true(rt.new_bool(var_sidebars_widgets.clone().is_array())) {
		{
			mut iter_1 := var_sidebars_widgets.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_widgets_shadow := item_1.val
				mut var_sidebar_shadow := item_1.key
				if rt.is_true(rt.new_bool(var_skip_inactive && rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('wp_inactive_widgets'), var_sidebar_shadow)) || rt.is_true(rt.call_function('str_starts_with', [var_sidebar_shadow.clone(), rt.new_string('orphaned_widgets')])))))) {
					continue
				}
				if rt.is_true(rt.new_bool(var_widgets_shadow.clone().is_array())) {
					{
						mut iter_2 := var_widgets_shadow.iterator()
						for {
							item_2 := iter_2.next() or { break }
							mut var_widget_shadow := item_2.val
							if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_callback && var_wp_registered_widgets.array_get(var_widget_shadow).array_isset(rt.new_string('callback')) && rt.is_true(rt.identical(var_wp_registered_widgets.array_get(var_widget_shadow).array_get('callback'), rt.new_bool(callback))))) || rt.is_true(rt.new_bool(var_id_base && rt.is_true(rt.identical(_get_widget_id_base(var_widget_shadow.clone()), rt.new_bool(id_base))))))) {
								if rt.is_true(rt.new_bool(!(var_widget_id) || rt.is_true(rt.new_bool(var_wp_registered_widgets.array_get(var_widget_shadow).array_isset(rt.new_string('id')) && rt.is_true(rt.identical(rt.new_bool(widget_id), var_wp_registered_widgets.array_get(var_widget_shadow).array_get('id'))))))) {
									return (var_sidebar_shadow).to_bool()
								}
							}
						}
					}
				}
			}
		}
	}
	return false
}

fn is_dynamic_sidebar() bool {
	mut var_wp_registered_widgets := rt.new_null()
	mut var_wp_registered_sidebars := rt.new_null()
	mut var_sidebars_widgets := rt.new_null()
	mut var_sidebar := rt.new_null()
	mut var_index := rt.new_null()
	mut var_widget := rt.new_null()
	var_sidebars_widgets = rt.call_function('get_option', [rt.new_string('sidebars_widgets')])
	{
		mut iter_1 := rt.cast_array(var_wp_registered_sidebars).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_sidebar_shadow := item_1.val
			mut var_index_shadow := item_1.key
			if !(!rt.is_true(var_sidebars_widgets.array_get(var_index_shadow))) {
				{
					mut iter_2 := rt.cast_array(var_sidebars_widgets.array_get(var_index_shadow)).iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_widget_shadow := item_2.val
						if rt.is_true(rt.new_bool(var_wp_registered_widgets.clone().array_isset(var_widget_shadow.clone()))) {
							return true
						}
					}
				}
			}
		}
	}
	return false
}

fn is_active_sidebar(var_index_arg rt.PhpVal) rt.PhpVal {
	mut var_index := var_index_arg
	mut var_sidebars_widgets := rt.new_null()
	mut var_is_active_sidebar := false
	var_index = if rt.is_true(rt.new_bool(var_index.clone().is_long())) { rt.new_string("sidebar-${var_index.to_string()}") } else { rt.call_function('sanitize_title', [var_index.clone()]) }
	var_sidebars_widgets = wp_get_sidebars_widgets(false)
	var_is_active_sidebar = !(!rt.is_true(var_sidebars_widgets.array_get(var_index)))
	return rt.call_function('apply_filters', [rt.new_string('is_active_sidebar'), rt.new_bool(var_is_active_sidebar).clone(), var_index.clone()])
}

fn wp_get_sidebars_widgets(deprecated bool) rt.PhpVal {
	mut var_deprecated := deprecated
	mut var__wp_sidebars_widgets := rt.new_null()
	mut var_sidebars_widgets := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), rt.new_bool(deprecated))))) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN), rt.new_string('2.8.1')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		if !rt.is_true(var__wp_sidebars_widgets) {
			var__wp_sidebars_widgets = rt.call_function('get_option', [rt.new_string('sidebars_widgets'), rt.new_array()])
		}
		var_sidebars_widgets = var__wp_sidebars_widgets.clone()
	} else {
		var_sidebars_widgets = rt.call_function('get_option', [rt.new_string('sidebars_widgets'), rt.new_array()])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_sidebars_widgets.clone().is_array())) && var_sidebars_widgets.array_isset(rt.new_string('array_version')))) {
		var_sidebars_widgets.array_unset(rt.new_string('array_version'))
	}
	return rt.call_function('apply_filters', [rt.new_string('sidebars_widgets'), var_sidebars_widgets.clone()])
}

fn wp_get_sidebar(var_id rt.PhpVal) rt.PhpVal {
	mut var_wp_registered_sidebars := rt.new_null()
	mut var_sidebar := rt.new_null()
	{
		mut iter_1 := rt.cast_array(var_wp_registered_sidebars).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_sidebar_shadow := item_1.val
			if rt.is_true(rt.identical(var_sidebar_shadow.array_get('id'), var_id)) {
				return var_sidebar_shadow.clone()
			}
		}
	}
	if rt.is_true(rt.identical(rt.new_string('wp_inactive_widgets'), var_id)) {
		return rt.create_array([rt.ArrayItem{ key: 'id', val: 'wp_inactive_widgets' }, rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Inactive widgets')]) }])
	}
	return rt.new_null()
}

fn wp_set_sidebars_widgets(var_sidebars_widgets rt.PhpVal) {
	mut var__wp_sidebars_widgets := rt.new_null()
	var__wp_sidebars_widgets = rt.new_null()
	if !(var_sidebars_widgets.array_isset(rt.new_string('array_version'))) {
		var_sidebars_widgets.array_set('array_version', 3)
	}
	rt.call_function('update_option', [rt.new_string('sidebars_widgets'), var_sidebars_widgets.clone()])
}

fn wp_get_widget_defaults() rt.PhpVal {
	mut var_wp_registered_sidebars := rt.new_null()
	mut var_defaults := rt.new_null()
	mut var_sidebar := rt.new_null()
	mut var_index := rt.new_null()
	var_defaults = rt.new_array()
	{
		mut iter_1 := rt.cast_array(var_wp_registered_sidebars).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_sidebar_shadow := item_1.val
			mut var_index_shadow := item_1.key
			var_defaults.array_set(var_index_shadow, rt.new_array())
		}
	}
	return var_defaults.clone()
}

fn wp_convert_widget_settings(var_base_name rt.PhpVal, var_option_name rt.PhpVal, var_settings_arg rt.PhpVal) rt.PhpVal {
	mut var_settings := var_settings_arg
	mut var_GLOBALS := rt.new_null()
	mut var_single := false
	mut var_changed := false
	mut var_number := rt.new_null()
	mut var_sidebars_widgets := rt.new_null()
	mut var_sidebar := rt.new_null()
	mut var_index := rt.new_null()
	mut var_name := rt.new_null()
	mut var_i := rt.new_null()
	var_single = false
	var_changed = false
	if !rt.is_true(var_settings) {
		var_single = true
	} else {
		{
			mut iter_1 := rt.func_array_keys(var_settings.clone()).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_number_shadow := item_1.val
				if rt.is_true(rt.identical(rt.new_string('number'), var_number_shadow)) {
					continue
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_number_shadow.clone().is_long() || var_number_shadow.clone().is_double()))))) {
					var_single = true
					break
				}
			}
		}
	}
	if var_single {
		var_settings = rt.create_array([rt.ArrayItem{ key: 2, val: var_settings }])
		if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
			var_sidebars_widgets = rt.call_function('get_option', [rt.new_string('sidebars_widgets')])
		} else {
			if !rt.is_true(var_GLOBALS.array_get('_wp_sidebars_widgets')) {
				var_GLOBALS.array_set('_wp_sidebars_widgets', rt.call_function('get_option', [rt.new_string('sidebars_widgets'), rt.new_array()]))
			}
			var_sidebars_widgets = var_GLOBALS.array_get('_wp_sidebars_widgets')
		}
		{
			mut iter_1 := rt.cast_array(var_sidebars_widgets).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_sidebar_shadow := item_1.val
				mut var_index_shadow := item_1.key
				if rt.is_true(rt.new_bool(var_sidebar_shadow.clone().is_array())) {
					{
						mut iter_2 := var_sidebar_shadow.iterator()
						for {
							item_2 := iter_2.next() or { break }
							mut var_name_shadow := item_2.val
							mut var_i_shadow := item_2.key
							if rt.is_true(rt.identical(var_base_name, var_name_shadow)) {
								var_sidebars_widgets.array_get_mut(var_index_shadow).array_set(var_i_shadow, "${var_name.to_string()}-2")
								var_changed = true
								break
							}
						}
					}
				}
			}
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) && var_changed)) {
			rt.call_function('update_option', [rt.new_string('sidebars_widgets'), var_sidebars_widgets.clone()])
		}
	}
	var_settings.array_set('_multiwidget', 1)
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		rt.call_function('update_option', [var_option_name.clone(), var_settings.clone()])
	}
	return var_settings.clone()
}

fn the_widget(var_widget rt.PhpVal, var_instance_arg rt.PhpVal, var_args_arg rt.PhpVal) {
	mut var_instance := var_instance_arg
	mut var_args := var_args_arg
	mut var_wp_widget_factory := rt.new_null()
	mut var_widget_obj := rt.new_null()
	mut var_default_args := map[string]rt.PhpVal{}
	if !(rt.get_property(var_wp_widget_factory, 'widgets').array_isset(var_widget)) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Widgets need to be registered using %s, before they can be displayed.')]), rt.new_string('<code>register_widget()</code>')]), rt.new_string('4.9.0')])
		return
	}
	var_widget_obj = rt.get_property(var_wp_widget_factory, 'widgets').array_get(var_widget)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_widget_obj, 'WP_Widget')))))) {
		return
	}
	var_default_args = { 'before_widget': rt.new_string('<div class="widget %s">'), 'after_widget': rt.new_string('</div>'), 'before_title': rt.new_string('<h2 class="widgettitle">'), 'after_title': rt.new_string('</h2>') }
	var_args = rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array_from_native_map(var_default_args)])
	var_args.array_set('before_widget', rt.call_function('sprintf', [var_args.array_get('before_widget'), rt.get_property(var_widget_obj, 'widget_options').array_get('classname')]))
	var_instance = rt.call_function('wp_parse_args', [var_instance.clone()])
	var_instance = rt.call_function('apply_filters', [rt.new_string('widget_display_callback'), var_instance.clone(), var_widget_obj.clone(), var_args.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_instance)) {
		return
	}
	rt.call_function('do_action', [rt.new_string('the_widget'), var_widget.clone(), var_instance.clone(), var_args.clone()])
	rt.call_method(var_widget_obj, '_set', [-1])
	rt.call_method(var_widget_obj, 'widget', [var_args.clone(), var_instance.clone()])
}

fn _get_widget_id_base(var_id rt.PhpVal) rt.PhpVal {
	return rt.call_function('preg_replace', [rt.new_string('/-[0-9]+$/'), rt.new_string(''), var_id.clone()])
}

fn _wp_sidebars_changed() {
	mut var_sidebars_widgets := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_sidebars_widgets.clone().is_array()))))) {
		var_sidebars_widgets = wp_get_sidebars_widgets(false)
	}
	retrieve_widgets(true)
}

fn retrieve_widgets(theme_changed bool) rt.PhpVal {
	mut var_theme_changed := theme_changed
	mut var_wp_registered_sidebars := rt.new_null()
	mut var_wp_registered_widgets := rt.new_null()
	mut var_registered_sidebars_keys := rt.new_null()
	mut var_registered_widgets_ids := rt.new_null()
	mut var_sidebars_widgets_keys := rt.new_null()
	mut var_sidebars_widgets := rt.new_null()
	mut var_value := map[string]rt.PhpVal{}
	mut var_key := rt.new_null()
	mut var_shown_widgets := rt.new_null()
	mut var_lost_widgets := rt.new_null()
	mut var_widget_id := rt.new_null()
	mut var_number := rt.new_null()
	var_registered_sidebars_keys = rt.func_array_keys(var_wp_registered_sidebars.clone())
	var_registered_widgets_ids = rt.func_array_keys(var_wp_registered_widgets.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.call_function('get_theme_mod', [rt.new_string('sidebars_widgets')]).is_array()))))) {
		if !rt.is_true(var_sidebars_widgets) {
			return rt.new_array()
		}
		var_sidebars_widgets.array_unset(rt.new_string('array_version'))
		var_sidebars_widgets_keys = rt.func_array_keys(var_sidebars_widgets.clone())
		rt.call_function('sort', [var_sidebars_widgets_keys.clone()])
		rt.call_function('sort', [var_registered_sidebars_keys.clone()])
		if rt.is_true(rt.identical(var_sidebars_widgets_keys, var_registered_sidebars_keys)) {
			var_sidebars_widgets = _wp_remove_unregistered_widgets(var_sidebars_widgets.clone(), var_registered_widgets_ids.clone())
			return var_sidebars_widgets.clone()
		}
	}
	var_sidebars_widgets = _wp_remove_unregistered_widgets(var_sidebars_widgets.clone(), var_registered_widgets_ids.clone())
	var_sidebars_widgets = wp_map_sidebars_widgets(var_sidebars_widgets.clone())
	{
		mut iter_1 := var_sidebars_widgets.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value_shadow := item_1.val
			mut var_key_shadow := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_shadow.clone().is_array()))))) {
				var_sidebars_widgets.array_set(var_key_shadow, rt.new_array())
			}
		}
	}
	var_shown_widgets = rt.call_function('array_merge', [rt.call_function('array_values', [var_sidebars_widgets.clone()])])
	var_lost_widgets = rt.call_function('array_diff', [var_registered_widgets_ids.clone(), var_shown_widgets.clone()])
	{
		mut iter_1 := var_lost_widgets.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_widget_id_shadow := item_1.val
			mut var_key_shadow := item_1.key
			var_number = rt.call_function('preg_replace', [rt.new_string('/.+?-([0-9]+)$/'), rt.new_string('$1'), var_widget_id_shadow.clone()])
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_number.clone().is_long() || var_number.clone().is_double())) && rt.new_int((var_number).to_i64()) < 2)) {
				var_lost_widgets.array_unset(var_key_shadow)
			}
		}
	}
	var_sidebars_widgets.array_set('wp_inactive_widgets', rt.call_function('array_merge', [var_lost_widgets.clone(), rt.cast_array(var_sidebars_widgets.array_get('wp_inactive_widgets'))]))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('customize'), rt.new_bool(theme_changed))))) {
		wp_set_sidebars_widgets(var_sidebars_widgets.clone())
	}
	return var_sidebars_widgets.clone()
}

fn wp_map_sidebars_widgets(var_existing_sidebars_widgets rt.PhpVal) rt.PhpVal {
	mut var_wp_registered_sidebars := rt.new_null()
	mut var_new_sidebars_widgets := rt.new_null()
	mut var_widgets := rt.new_null()
	mut var_sidebar := rt.new_null()
	mut var_existing_sidebars := rt.new_null()
	mut var_name := rt.new_null()
	mut var_common_slug_groups := []rt.PhpVal{}
	mut var_slug_group := rt.new_null()
	mut var_slug := rt.new_null()
	mut var_args := rt.new_null()
	mut var_new_sidebar := rt.new_null()
	mut var_old_sidebars_widgets := rt.new_null()
	mut var_new_widgets := rt.new_null()
	mut var_value := map[string]rt.PhpVal{}
	mut var_key := rt.new_null()
	mut var_old_widgets := rt.new_null()
	mut var_old_sidebar := rt.new_null()
	mut var_widget_id := rt.new_null()
	mut var_active_key := rt.new_null()
	var_new_sidebars_widgets = rt.create_array([rt.ArrayItem{ key: 'wp_inactive_widgets', val: rt.new_array() }])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_existing_sidebars_widgets.clone().is_array()))))) || !rt.is_true(var_existing_sidebars_widgets))) {
		return var_new_sidebars_widgets.clone()
	}
	{
		mut iter_1 := var_existing_sidebars_widgets.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_widgets_shadow := item_1.val
			mut var_sidebar_shadow := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('wp_inactive_widgets'), var_sidebar_shadow)) || rt.is_true(rt.call_function('str_starts_with', [var_sidebar_shadow.clone(), rt.new_string('orphaned_widgets')])))) {
				var_new_sidebars_widgets.array_set('wp_inactive_widgets', rt.call_function('array_merge', [var_new_sidebars_widgets.array_get('wp_inactive_widgets'), rt.cast_array(var_widgets_shadow)]))
				var_existing_sidebars_widgets.array_unset(var_sidebar_shadow)
			}
		}
	}
	if 1 == var_existing_sidebars_widgets.clone().array_count() && 1 == var_wp_registered_sidebars.clone().array_count() {
		var_new_sidebars_widgets.array_set(rt.call_function('key', [var_wp_registered_sidebars.clone()]), rt.call_function('array_pop', [var_existing_sidebars_widgets.clone()]))
		return var_new_sidebars_widgets.clone()
	}
	var_existing_sidebars = rt.func_array_keys(var_existing_sidebars_widgets.clone())
	{
		mut iter_1 := var_wp_registered_sidebars.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_name_shadow := item_1.val
			mut var_sidebar_shadow := item_1.key
			if rt.is_true(rt.call_function('in_array', [var_sidebar_shadow.clone(), var_existing_sidebars.clone(), rt.new_bool(true)])) {
				var_new_sidebars_widgets.array_set(var_sidebar_shadow, var_existing_sidebars_widgets.array_get(var_sidebar_shadow))
				var_existing_sidebars_widgets.array_unset(var_sidebar_shadow)
			} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_new_sidebars_widgets.clone().array_isset(var_sidebar_shadow.clone())))))) {
				var_new_sidebars_widgets.array_set(var_sidebar_shadow, rt.new_array())
			}
		}
	}
	if !(!rt.is_true(var_existing_sidebars_widgets)) {
		var_common_slug_groups = [[rt.new_string('sidebar'), rt.new_string('primary'), rt.new_string('main'), rt.new_string('right')], [rt.new_string('second'), rt.new_string('left')], [rt.new_string('sidebar-2'), rt.new_string('footer'), rt.new_string('bottom')], [rt.new_string('header'), rt.new_string('top')]]
		for var_slug_group_shadow in var_common_slug_groups {
			{
				mut iter_1 := var_slug_group_shadow.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_slug_shadow := item_1.val
					{
						mut iter_2 := var_wp_registered_sidebars.iterator()
						for {
							item_2 := iter_2.next() or { break }
							mut var_args_shadow := item_2.val
							mut var_new_sidebar_shadow := item_2.key
							if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [var_new_sidebar_shadow.clone(), var_slug_shadow.clone()]))) && rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [var_slug_shadow.clone(), var_new_sidebar_shadow.clone()]))))) {
								continue
							}
							{
								mut iter_3 := var_existing_sidebars_widgets.iterator()
								for {
									item_3 := iter_3.next() or { break }
									mut var_widgets_shadow := item_3.val
									mut var_sidebar_shadow := item_3.key
									{
										mut iter_4 := var_slug_group_shadow.iterator()
										for {
											item_4 := iter_4.next() or { break }
											mut var_slug_shadow := item_4.val
											if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [var_sidebar_shadow.clone(), var_slug_shadow.clone()]))) && rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [var_slug_shadow.clone(), var_sidebar_shadow.clone()]))))) {
												continue
											}
											if !(!rt.is_true(var_existing_sidebars_widgets.array_get(var_sidebar_shadow))) {
												var_new_sidebars_widgets.array_set(var_new_sidebar_shadow, rt.call_function('array_merge', [var_new_sidebars_widgets.array_get(var_new_sidebar_shadow), var_existing_sidebars_widgets.array_get(var_sidebar_shadow)]))
												var_existing_sidebars_widgets.array_unset(var_sidebar_shadow)
												continue
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
	{
		mut iter_1 := var_existing_sidebars_widgets.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_widgets_shadow := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_widgets_shadow.clone().is_array())) && !(!rt.is_true(var_widgets_shadow)))) {
				var_new_sidebars_widgets.array_set('wp_inactive_widgets', rt.call_function('array_merge', [var_new_sidebars_widgets.array_get('wp_inactive_widgets'), var_widgets_shadow.clone()]))
			}
		}
	}
	var_old_sidebars_widgets = rt.call_function('get_theme_mod', [rt.new_string('sidebars_widgets')])
	var_old_sidebars_widgets = if !(var_old_sidebars_widgets.array_get('data')).is_null() { var_old_sidebars_widgets.array_get('data') } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(var_old_sidebars_widgets.clone().is_array())) {
		var_old_sidebars_widgets = rt.call_function('array_filter', [var_old_sidebars_widgets.clone()])
		{
			mut iter_1 := var_new_sidebars_widgets.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_new_widgets_shadow := item_1.val
				mut var_new_sidebar_shadow := item_1.key
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_old_sidebars_widgets.clone().array_isset(var_new_sidebar_shadow.clone()))) && !(!rt.is_true(var_new_widgets_shadow)))) {
					var_old_sidebars_widgets.array_unset(var_new_sidebar_shadow)
				}
			}
		}
		{
			mut iter_1 := var_old_sidebars_widgets.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_widgets_shadow := item_1.val
				mut var_sidebar_shadow := item_1.key
				if rt.is_true(rt.call_function('str_starts_with', [var_sidebar_shadow.clone(), rt.new_string('orphaned_widgets')])) {
					var_old_sidebars_widgets.array_unset(var_sidebar_shadow)
				}
			}
		}
		var_old_sidebars_widgets = _wp_remove_unregistered_widgets(var_old_sidebars_widgets.clone(), rt.new_null())
		{
			mut iter_1 := var_new_sidebars_widgets.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value_shadow := item_1.val
				mut var_key_shadow := item_1.key
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_shadow.clone().is_array()))))) {
					var_new_sidebars_widgets.array_set(var_key_shadow, rt.new_array())
				}
			}
		}
		if !(!rt.is_true(var_old_sidebars_widgets)) {
			{
				mut iter_1 := var_old_sidebars_widgets.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_old_widgets_shadow := item_1.val
					mut var_old_sidebar_shadow := item_1.key
					{
						mut iter_2 := var_new_sidebars_widgets.iterator()
						for {
							item_2 := iter_2.next() or { break }
							mut var_new_widgets_shadow := item_2.val
							mut var_new_sidebar_shadow := item_2.key
							{
								mut iter_3 := var_old_widgets_shadow.iterator()
								for {
									item_3 := iter_3.next() or { break }
									mut var_widget_id_shadow := item_3.val
									mut var_key_shadow := item_3.key
									var_active_key = rt.call_function('array_search', [var_widget_id_shadow.clone(), var_new_widgets_shadow.clone(), rt.new_bool(true)])
									if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_active_key)))) {
										if rt.is_true(rt.identical(rt.new_string('wp_inactive_widgets'), var_new_sidebar_shadow)) {
											var_new_sidebars_widgets.array_get('wp_inactive_widgets').array_unset(var_active_key)
										} else {
											var_old_sidebars_widgets.array_get(var_old_sidebar_shadow).array_unset(var_key_shadow)
										}
									}
								}
							}
						}
					}
				}
			}
		}
		var_new_sidebars_widgets = rt.call_function('array_merge', [var_new_sidebars_widgets.clone(), var_old_sidebars_widgets.clone()])
	}
	return var_new_sidebars_widgets.clone()
}

fn _wp_remove_unregistered_widgets(var_sidebars_widgets rt.PhpVal, var_allowed_widget_ids_arg rt.PhpVal) rt.PhpVal {
	mut var_allowed_widget_ids := var_allowed_widget_ids_arg
	mut var_GLOBALS := rt.new_null()
	mut var_widgets := rt.new_null()
	mut var_sidebar := rt.new_null()
	if !rt.is_true(var_allowed_widget_ids) {
		var_allowed_widget_ids = rt.func_array_keys(var_GLOBALS.array_get('wp_registered_widgets'))
	}
	{
		mut iter_1 := var_sidebars_widgets.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_widgets_shadow := item_1.val
			mut var_sidebar_shadow := item_1.key
			if rt.is_true(rt.new_bool(var_widgets_shadow.clone().is_array())) {
				var_sidebars_widgets.array_set(var_sidebar_shadow, rt.call_function('array_intersect', [var_widgets_shadow.clone(), var_allowed_widget_ids.clone()]))
			}
		}
	}
	return var_sidebars_widgets.clone()
}

fn wp_widget_rss_output(var_rss_arg rt.PhpVal, var_args_arg rt.PhpVal) {
	mut var_rss := var_rss_arg
	mut var_args := var_args_arg
	mut var_default_args := map[string]rt.PhpVal{}
	mut var_items := rt.new_null()
	mut var_show_summary := rt.new_null()
	mut var_show_author := rt.new_null()
	mut var_show_date := rt.new_null()
	mut var_item := rt.new_null()
	mut var_link := rt.new_null()
	mut var_title := rt.new_null()
	mut var_desc := rt.new_null()
	mut var_summary := rt.new_null()
	mut var_date := rt.new_null()
	mut var_author := rt.new_null()
	if rt.is_true(rt.new_bool(var_rss.clone().is_string())) {
		var_rss = rt.call_function('fetch_feed', [var_rss.clone()])
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_rss.clone().is_array())) && var_rss.array_isset(rt.new_string('url')))) {
		var_args = var_rss.clone()
		var_rss = rt.call_function('fetch_feed', [var_rss.array_get('url')])
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_rss.clone().is_object()))))) {
		return
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_rss.clone()])) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) || rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_options')])))) {
			print('<p><strong>' + (rt.call_function('__', [rt.new_string('RSS Error:')])).str() + '</strong> ' + (rt.call_function('esc_html', [rt.call_method(var_rss, 'get_error_message', []rt.PhpVal{})])).str() + '</p>')
		}
		return
	}
	var_default_args = { 'show_author': rt.new_int(0), 'show_date': rt.new_int(0), 'show_summary': rt.new_int(0), 'items': rt.new_int(0) }
	var_args = rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array_from_native_map(var_default_args)])
	var_items = rt.new_int((var_args.array_get('items')).to_i64())
	if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_items, rt.new_int(1))) || rt.is_true(rt.less(rt.new_int(20), var_items)))) {
		var_items = rt.new_int(10)
	}
	var_show_summary = rt.new_int((var_args.array_get('show_summary')).to_i64())
	var_show_author = rt.new_int((var_args.array_get('show_author')).to_i64())
	var_show_date = rt.new_int((var_args.array_get('show_date')).to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_rss, 'get_item_quantity', []rt.PhpVal{}))))) {
		print('<ul><li>' + (rt.call_function('__', [rt.new_string('An error has occurred, which probably means the feed is down. Try again later.')])).str() + '</li></ul>')
		rt.call_method(var_rss, '__destruct', []rt.PhpVal{})
		var_rss = rt.new_null()
		return
	}
	print('<ul>')
	{
		mut iter_1 := rt.call_method(var_rss, 'get_items', [rt.new_int(0), var_items.clone()]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item_shadow := item_1.val
			var_link = rt.call_method(var_item_shadow, 'get_link', []rt.PhpVal{})
			for rt.is_true(rt.new_bool(!(!rt.is_true(var_link)) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('stristr', [var_link.clone(), rt.new_string('http')]), var_link)))))) {
				var_link = rt.call_function('substr', [var_link.clone(), rt.new_int(1)])
			}
			var_link = rt.call_function('esc_url', [rt.call_function('strip_tags', [var_link.clone()])])
			var_title = rt.call_function('esc_html', [rt.new_string(rt.call_function('strip_tags', [rt.call_method(var_item_shadow, 'get_title', []rt.PhpVal{})]).to_string().trim_space())])
			if !rt.is_true(var_title) {
				var_title = rt.call_function('__', [rt.new_string('Untitled')])
			}
			var_desc = rt.call_function('html_entity_decode', [rt.call_method(var_item_shadow, 'get_description', []rt.PhpVal{}), rt.get_constant('ENT_QUOTES'), rt.call_function('get_option', [rt.new_string('blog_charset')])])
			var_desc = rt.call_function('esc_attr', [rt.call_function('wp_trim_words', [var_desc.clone(), rt.new_int(55), rt.new_string(' [&hellip;]')])])
			var_summary = rt.new_string('')
			if rt.is_true(var_show_summary) {
				var_summary = var_desc.clone()
				if rt.is_true(rt.call_function('str_ends_with', [var_summary.clone(), rt.new_string('[...]')])) {
					var_summary = rt.new_string((rt.call_function('substr', [var_summary.clone(), rt.new_int(0), -5])).str() + '[&hellip;]')
				}
				var_summary = rt.new_string('<div class="rssSummary">' + (rt.call_function('esc_html', [var_summary.clone()])).str() + '</div>')
			}
			var_date = rt.new_string('')
			if rt.is_true(var_show_date) {
				var_date = rt.call_method(var_item_shadow, 'get_date', [rt.new_string('U')])
				if rt.is_true(var_date) {
					var_date = rt.new_string(' <span class="rss-date">' + (rt.call_function('date_i18n', [rt.call_function('get_option', [rt.new_string('date_format')]), var_date.clone()])).str() + '</span>')
				}
			}
			var_author = rt.new_string('')
			if rt.is_true(var_show_author) {
				var_author = rt.call_method(var_item_shadow, 'get_author', []rt.PhpVal{})
				if rt.is_true(rt.new_bool(var_author.clone().is_object())) {
					var_author = rt.call_method(var_author, 'get_name', []rt.PhpVal{})
					var_author = rt.new_string(' <cite>' + (rt.call_function('esc_html', [rt.call_function('strip_tags', [var_author.clone()])])).str() + '</cite>')
				}
			}
			if rt.is_true(rt.identical(rt.new_string(''), var_link)) {
				print("<li>${var_title.to_string()}${var_date.to_string()}${var_summary.to_string()}${var_author.to_string()}</li>")
			} else if rt.is_true(var_show_summary) {
				print("<li><a class='rsswidget' href='${var_link.to_string()}'>${var_title.to_string()}</a>${var_date.to_string()}${var_summary.to_string()}${var_author.to_string()}</li>")
			} else {
				print("<li><a class='rsswidget' href='${var_link.to_string()}'>${var_title.to_string()}</a>${var_date.to_string()}${var_author.to_string()}</li>")
			}
		}
	}
	print('</ul>')
	rt.call_method(var_rss, '__destruct', []rt.PhpVal{})
	var_rss = rt.new_null()
}

fn wp_widget_rss_form(var_args rt.PhpVal, var_inputs_arg rt.PhpVal) {
	mut var_inputs := var_inputs_arg
	mut var_default_inputs := map[string]rt.PhpVal{}
	mut var_esc_number := rt.new_null()
	mut var_i := i64(0)
	mut var_input := rt.new_null()
	mut var_id := rt.new_null()
	var_default_inputs = { 'url': true, 'title': true, 'items': true, 'show_summary': true, 'show_author': true, 'show_date': true }
	var_inputs = rt.call_function('wp_parse_args', [var_inputs.clone(), rt.create_array_from_native_map(var_default_inputs)])
	var_args.array_set('title', if !(var_args.array_get('title')).is_null() { var_args.array_get('title') } else { rt.new_string('') })
	var_args.array_set('url', if !(var_args.array_get('url')).is_null() { var_args.array_get('url') } else { rt.new_string('') })
	var_args.array_set('items', rt.new_int((if !(var_args.array_get('items')).is_null() { var_args.array_get('items') } else { rt.new_int(0) }).to_i64()))
	if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_args.array_get('items'), rt.new_int(1))) || rt.is_true(rt.less(rt.new_int(20), var_args.array_get('items'))))) {
		var_args.array_set('items', 10)
	}
	var_args.array_set('show_summary', rt.new_int((if !(var_args.array_get('show_summary')).is_null() { var_args.array_get('show_summary') } else { var_inputs.array_get('show_summary') }).to_i64()))
	var_args.array_set('show_author', rt.new_int((if !(var_args.array_get('show_author')).is_null() { var_args.array_get('show_author') } else { var_inputs.array_get('show_author') }).to_i64()))
	var_args.array_set('show_date', rt.new_int((if !(var_args.array_get('show_date')).is_null() { var_args.array_get('show_date') } else { var_inputs.array_get('show_date') }).to_i64()))
	if !(!rt.is_true(var_args.array_get('error'))) {
		print('<p class="widget-error"><strong>' + (rt.call_function('__', [rt.new_string('RSS Error:')])).str() + '</strong> ' + (rt.call_function('esc_html', [var_args.array_get('error')])).str() + '</p>')
	}
	var_esc_number = rt.call_function('esc_attr', [var_args.array_get('number')])
	if rt.is_true(var_inputs.array_get('url')) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_esc_number)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Enter the RSS feed URL here:')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_esc_number)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_esc_number)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_args.array_get('url')]))
		// unsupported statement: Stmt_InlineHTML
	}
	if rt.is_true(var_inputs.array_get('title')) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_esc_number)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Give the feed a title (optional):')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_esc_number)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_esc_number)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_args.array_get('title')]))
		// unsupported statement: Stmt_InlineHTML
	}
	if rt.is_true(var_inputs.array_get('items')) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_esc_number)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('How many items would you like to display?')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_esc_number)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_esc_number)
		// unsupported statement: Stmt_InlineHTML
		{
			var_i = 1
			for {
				if !(var_i <= 20) { break }
				print("<option value='${var_i.str()}' " + (rt.call_function('selected', [var_args.array_get('items'), rt.new_int(var_i).clone(), rt.new_bool(false)])).str() + ">${var_i.str()}</option>")
				var_i += 1
			}
		}
		// unsupported statement: Stmt_InlineHTML
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_inputs.array_get('show_summary')) || rt.is_true(var_inputs.array_get('show_author')))) || rt.is_true(var_inputs.array_get('show_date')))) {
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_inputs.array_get('show_summary')) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_esc_number)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_esc_number)
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('checked', [var_args.array_get('show_summary')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_esc_number)
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Display item content?')])
			// unsupported statement: Stmt_InlineHTML
		}
		if rt.is_true(var_inputs.array_get('show_author')) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_esc_number)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_esc_number)
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('checked', [var_args.array_get('show_author')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_esc_number)
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Display item author if available?')])
			// unsupported statement: Stmt_InlineHTML
		}
		if rt.is_true(var_inputs.array_get('show_date')) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_esc_number)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_esc_number)
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('checked', [var_args.array_get('show_date')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_esc_number)
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Display item date?')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	{
		mut iter_1 := rt.func_array_keys(rt.create_array_from_native_map(var_default_inputs)).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_input_shadow := item_1.val
			if rt.is_true(rt.identical(rt.new_string('hidden'), var_inputs.array_get(var_input_shadow))) {
				var_id = rt.call_function('str_replace', [rt.new_string('_'), rt.new_string('-'), var_input_shadow.clone()])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_id.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(var_esc_number)
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(var_esc_number)
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_input_shadow.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_args.array_get(var_input_shadow)]))
				// unsupported statement: Stmt_InlineHTML
			}
		}
	}
}

fn wp_widget_rss_process(var_widget_rss rt.PhpVal, check_feed bool) rt.PhpVal {
	mut var_check_feed := check_feed
	mut var_items := rt.new_null()
	mut var_url := rt.new_null()
	mut var_title := ''
	mut var_show_summary := rt.new_null()
	mut var_show_author := rt.new_null()
	mut var_show_date := rt.new_null()
	mut var_error := rt.new_null()
	mut var_link := rt.new_null()
	mut var_rss := rt.new_null()
	var_items = rt.new_int((var_widget_rss.array_get('items')).to_i64())
	if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_items, rt.new_int(1))) || rt.is_true(rt.less(rt.new_int(20), var_items)))) {
		var_items = rt.new_int(10)
	}
	var_url = rt.call_function('sanitize_url', [rt.call_function('strip_tags', [var_widget_rss.array_get('url')])])
	var_title = rt.call_function('strip_tags', [if !(var_widget_rss.array_get('title')).is_null() { var_widget_rss.array_get('title') } else { rt.new_string('') }]).to_string().trim_space()
	var_show_summary = rt.new_int((if !(var_widget_rss.array_get('show_summary')).is_null() { var_widget_rss.array_get('show_summary') } else { rt.new_int(0) }).to_i64())
	var_show_author = rt.new_int((if !(var_widget_rss.array_get('show_author')).is_null() { var_widget_rss.array_get('show_author') } else { rt.new_int(0) }).to_i64())
	var_show_date = rt.new_int((if !(var_widget_rss.array_get('show_date')).is_null() { var_widget_rss.array_get('show_date') } else { rt.new_int(0) }).to_i64())
	var_error = rt.new_bool(false)
	var_link = rt.new_string('')
	if var_check_feed {
		var_rss = rt.call_function('fetch_feed', [var_url.clone()])
		if rt.is_true(rt.call_function('is_wp_error', [var_rss.clone()])) {
			var_error = rt.call_method(var_rss, 'get_error_message', []rt.PhpVal{})
		} else {
			var_link = rt.call_function('esc_url', [rt.call_function('strip_tags', [rt.call_method(var_rss, 'get_permalink', []rt.PhpVal{})])])
			for rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('stristr', [var_link.clone(), rt.new_string('http')]), var_link)))) {
				var_link = rt.call_function('substr', [var_link.clone(), rt.new_int(1)])
			}
			rt.call_method(var_rss, '__destruct', []rt.PhpVal{})
			var_rss = rt.new_null()
		}
	}
	return rt.call_function('compact', [rt.new_string('title'), rt.new_string('url'), rt.new_string('link'), rt.new_string('items'), rt.new_string('error'), rt.new_string('show_summary'), rt.new_string('show_author'), rt.new_string('show_date')])
}

fn wp_widgets_init() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_blog_installed', []rt.PhpVal{}))))) {
		return
	}
	register_widget('WP_Widget_Pages')
	register_widget('WP_Widget_Calendar')
	register_widget('WP_Widget_Archives')
	if rt.is_true(rt.call_function('get_option', [rt.new_string('link_manager_enabled')])) {
		register_widget('WP_Widget_Links')
	}
	register_widget('WP_Widget_Media_Audio')
	register_widget('WP_Widget_Media_Image')
	register_widget('WP_Widget_Media_Gallery')
	register_widget('WP_Widget_Media_Video')
	register_widget('WP_Widget_Meta')
	register_widget('WP_Widget_Search')
	register_widget('WP_Widget_Text')
	register_widget('WP_Widget_Categories')
	register_widget('WP_Widget_Recent_Posts')
	register_widget('WP_Widget_Recent_Comments')
	register_widget('WP_Widget_RSS')
	register_widget('WP_Widget_Tag_Cloud')
	register_widget('WP_Nav_Menu_Widget')
	register_widget('WP_Widget_Custom_HTML')
	register_widget('WP_Widget_Block')
	rt.call_function('do_action', [rt.new_string('widgets_init')])
}

fn wp_setup_widgets_block_editor() {
	rt.call_function('add_theme_support', [rt.new_string('widgets-block-editor')])
}

fn wp_use_widgets_block_editor() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('use_widgets_block_editor'), rt.call_function('get_theme_support', [rt.new_string('widgets-block-editor')])])
}

fn wp_parse_widget_id(var_id rt.PhpVal) rt.PhpVal {
	mut var_matches := []rt.PhpVal{}
	mut var_parsed := map[string]rt.PhpVal{}
	var_parsed = rt.new_array()
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^(.+)-(\\d+)$/'), var_id.clone(), rt.create_array_from_list(var_matches)])) {
		var_parsed['id_base'] = var_matches.array_get(1)
		var_parsed['number'] = rt.new_int((var_matches.array_get(2)).to_i64())
	} else {
		var_parsed['id_base'] = var_id.clone()
	}
	return var_parsed.clone()
}

fn wp_find_widgets_sidebar(var_widget_id rt.PhpVal) rt.PhpVal {
	mut var_widget_ids := rt.new_null()
	mut var_sidebar_id := rt.new_null()
	mut var_maybe_widget_id := rt.new_null()
	{
		mut iter_1 := wp_get_sidebars_widgets(false).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_widget_ids_shadow := item_1.val
			mut var_sidebar_id_shadow := item_1.key
			{
				mut iter_2 := var_widget_ids_shadow.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_maybe_widget_id_shadow := item_2.val
					if rt.is_true(rt.identical(var_maybe_widget_id_shadow, var_widget_id)) {
						return rt.new_string((var_sidebar_id_shadow).str())
					}
				}
			}
		}
	}
	return rt.new_null()
}

fn wp_assign_widget_to_sidebar(var_widget_id rt.PhpVal, var_sidebar_id rt.PhpVal) {
	mut var_sidebars := rt.new_null()
	mut var_widgets := rt.new_null()
	mut var_maybe_sidebar_id := rt.new_null()
	mut var_maybe_widget_id := rt.new_null()
	mut var_i := rt.new_null()
	var_sidebars = wp_get_sidebars_widgets(false)
	{
		mut iter_1 := var_sidebars.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_widgets_shadow := item_1.val
			mut var_maybe_sidebar_id_shadow := item_1.key
			{
				mut iter_2 := var_widgets_shadow.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_maybe_widget_id_shadow := item_2.val
					mut var_i_shadow := item_2.key
					if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_widget_id, var_maybe_widget_id_shadow)) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_sidebar_id, var_maybe_sidebar_id_shadow)))))) {
						var_sidebars.array_get(var_maybe_sidebar_id_shadow).array_unset(var_i_shadow)
						continue
					}
				}
			}
		}
	}
	if rt.is_true(var_sidebar_id) {
		var_sidebars.array_get_mut(var_sidebar_id).array_push(var_widget_id.clone())
	}
	wp_set_sidebars_widgets(var_sidebars.clone())
}

fn wp_render_widget(var_widget_id rt.PhpVal, var_sidebar_id rt.PhpVal) string {
	mut var_wp_registered_widgets := rt.new_null()
	mut var_wp_registered_sidebars := rt.new_null()
	mut var_sidebar := rt.new_null()
	mut var_params := rt.new_null()
	mut var_classname_ := ''
	mut var_cn := rt.new_null()
	mut var_callback := rt.new_null()
	if !(var_wp_registered_widgets.array_isset(var_widget_id)) {
		return ''
	}
	if var_wp_registered_sidebars.array_isset(var_sidebar_id) {
		var_sidebar = var_wp_registered_sidebars.array_get(var_sidebar_id)
	} else if rt.is_true(rt.identical(rt.new_string('wp_inactive_widgets'), var_sidebar_id)) {
		var_sidebar = rt.new_array()
	} else {
		return ''
	}
	var_params = rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('array_merge', [var_sidebar.clone(), rt.create_array([rt.ArrayItem{ key: 'widget_id', val: var_widget_id }, rt.ArrayItem{ key: 'widget_name', val: var_wp_registered_widgets.array_get(var_widget_id).array_get('name') }])]) }]), rt.cast_array(var_wp_registered_widgets.array_get(var_widget_id).array_get('params'))])
	var_classname_ = ''
	{
		mut iter_1 := rt.cast_array(var_wp_registered_widgets.array_get(var_widget_id).array_get('classname')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_cn_shadow := item_1.val
			if rt.is_true(rt.new_bool(var_cn_shadow.clone().is_string())) {
				var_classname_ = var_classname_ + '_' + (var_cn_shadow).str()
			} else if rt.is_true(rt.new_bool(var_cn_shadow.clone().is_object())) {
				var_classname_ = var_classname_ + '_' + (rt.call_function('get_class', [var_cn_shadow.clone()])).str()
			}
		}
	}
	var_classname_ = var_classname_.trim_left(' \t\n\r')
	var_params.array_get_mut(0).array_set('before_widget', rt.call_function('sprintf', [var_params.array_get(0).array_get('before_widget'), var_widget_id.clone(), rt.new_string((var_classname_).str()).clone()]))
	var_params = rt.call_function('apply_filters', [rt.new_string('dynamic_sidebar_params'), var_params.clone()])
	var_callback = var_wp_registered_widgets.array_get(var_widget_id).array_get('callback')
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('dynamic_sidebar'), var_wp_registered_widgets.array_get(var_widget_id)])
	if rt.is_true(rt.call_function('is_callable', [var_callback.clone()])) {
		rt.call_function('call_user_func_array', [var_callback.clone(), var_params.clone()])
	}
	return (rt.call_function('ob_get_clean', []rt.PhpVal{})).str()
}

fn wp_render_widget_control(var_id rt.PhpVal) rt.PhpVal {
	mut var_wp_registered_widget_controls := rt.new_null()
	mut var_callback := rt.new_null()
	mut var_params := rt.new_null()
	if !(var_wp_registered_widget_controls.array_get(var_id).array_isset(rt.new_string('callback'))) {
		return rt.new_null()
	}
	var_callback = var_wp_registered_widget_controls.array_get(var_id).array_get('callback')
	var_params = var_wp_registered_widget_controls.array_get(var_id).array_get('params')
	rt.call_function('ob_start', []rt.PhpVal{})
	if rt.is_true(rt.call_function('is_callable', [var_callback.clone()])) {
		rt.call_function('call_user_func_array', [var_callback.clone(), var_params.clone()])
	}
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn wp_check_widget_editor_deps() {
	mut var_wp_scripts := rt.new_null()
	mut var_wp_styles := rt.new_null()
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_wp_scripts, 'query', [rt.new_string('wp-edit-widgets'), rt.new_string('enqueued')])) || rt.is_true(rt.call_method(var_wp_scripts, 'query', [rt.new_string('wp-customize-widgets'), rt.new_string('enqueued')])))) {
		if rt.is_true(rt.call_method(var_wp_scripts, 'query', [rt.new_string('wp-editor'), rt.new_string('enqueued')])) {
			rt.call_function('_doing_it_wrong', [rt.new_string('wp_enqueue_script()'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('"%1$s" script should not be enqueued together with the new widgets editor (%2$s or %3$s).')]), rt.new_string('wp-editor'), rt.new_string('wp-edit-widgets'), rt.new_string('wp-customize-widgets')]), rt.new_string('5.8.0')])
		}
		if rt.is_true(rt.call_method(var_wp_styles, 'query', [rt.new_string('wp-edit-post'), rt.new_string('enqueued')])) {
			rt.call_function('_doing_it_wrong', [rt.new_string('wp_enqueue_style()'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('"%1$s" style should not be enqueued together with the new widgets editor (%2$s or %3$s).')]), rt.new_string('wp-edit-post'), rt.new_string('wp-edit-widgets'), rt.new_string('wp-customize-widgets')]), rt.new_string('5.8.0')])
		}
	}
}

fn _wp_block_theme_register_classic_sidebars() {
	mut var_wp_registered_sidebars := rt.new_null()
	mut var_classic_sidebars := rt.new_null()
	mut var_sidebar := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))))) {
		return
	}
	var_classic_sidebars = rt.call_function('get_theme_mod', [rt.new_string('wp_classic_sidebars')])
	if !rt.is_true(var_classic_sidebars) {
		return
	}
	{
		mut iter_1 := var_classic_sidebars.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_sidebar_shadow := item_1.val
			var_wp_registered_sidebars.array_set(var_sidebar_shadow.array_get('id'), var_sidebar_shadow.clone())
		}
	}
}



pub fn init_wp_includes_widgets_php() {
	mut var_GLOBALS := rt.new_null()
	mut var_wp_registered_sidebars := rt.get_superglobal('wp_registered_sidebars')
	mut var_wp_registered_widgets := rt.get_superglobal('wp_registered_widgets')
	mut var_wp_registered_widget_controls := rt.get_superglobal('wp_registered_widget_controls')
	mut var_wp_registered_widget_updates := rt.get_superglobal('wp_registered_widget_updates')
	var_wp_registered_sidebars = rt.new_array()
	var_wp_registered_widgets = rt.new_array()
	var_wp_registered_widget_controls = rt.new_array()
	var_wp_registered_widget_updates = rt.new_array()
	mut var__wp_sidebars_widgets := rt.new_array()
	var_GLOBALS.array_set('_wp_deprecated_widgets_callbacks', rt.create_array([rt.ArrayItem{ key: none, val: 'wp_widget_pages' }, rt.ArrayItem{ key: none, val: 'wp_widget_pages_control' }, rt.ArrayItem{ key: none, val: 'wp_widget_calendar' }, rt.ArrayItem{ key: none, val: 'wp_widget_calendar_control' }, rt.ArrayItem{ key: none, val: 'wp_widget_archives' }, rt.ArrayItem{ key: none, val: 'wp_widget_archives_control' }, rt.ArrayItem{ key: none, val: 'wp_widget_links' }, rt.ArrayItem{ key: none, val: 'wp_widget_meta' }, rt.ArrayItem{ key: none, val: 'wp_widget_meta_control' }, rt.ArrayItem{ key: none, val: 'wp_widget_search' }, rt.ArrayItem{ key: none, val: 'wp_widget_recent_entries' }, rt.ArrayItem{ key: none, val: 'wp_widget_recent_entries_control' }, rt.ArrayItem{ key: none, val: 'wp_widget_tag_cloud' }, rt.ArrayItem{ key: none, val: 'wp_widget_tag_cloud_control' }, rt.ArrayItem{ key: none, val: 'wp_widget_categories' }, rt.ArrayItem{ key: none, val: 'wp_widget_categories_control' }, rt.ArrayItem{ key: none, val: 'wp_widget_text' }, rt.ArrayItem{ key: none, val: 'wp_widget_text_control' }, rt.ArrayItem{ key: none, val: 'wp_widget_rss' }, rt.ArrayItem{ key: none, val: 'wp_widget_rss_control' }, rt.ArrayItem{ key: none, val: 'wp_widget_recent_comments' }, rt.ArrayItem{ key: none, val: 'wp_widget_recent_comments_control' }]))
}
