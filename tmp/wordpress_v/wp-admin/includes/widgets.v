import rt

fn wp_list_widgets() {
	mut var_wp_registered_widgets := rt.new_null()
	mut var_wp_registered_widget_controls := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_sort := var_wp_registered_widgets
	rt.call_function('usort', [var_sort.dup(), rt.new_string('_sort_name_callback')])
	mut var_done := []rt.PhpVal{}
	{
		mut iter_1 := var_sort.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_widget := item_1.val
			if rt.is_true(rt.call_function('in_array', [var_widget.array_get('callback'), var_done.dup(), rt.new_bool(true)])) {
				continue
			}
			mut var_sidebar := rt.call_function('is_active_widget', [var_widget.array_get('callback'), var_widget.array_get('id'), rt.new_bool(false), rt.new_bool(false)])
			var_done << var_widget.array_get('callback')
			if !(var_widget.array_get('params').array_isset(rt.new_int(0))) {
				var_widget.array_get_mut('params').array_set(0, []rt.PhpVal{})
			}
			mut var_args := { 'widget_id': var_widget.array_get('id'), 'widget_name': var_widget.array_get('name'), '_display': rt.new_string('template') }
			if var_wp_registered_widget_controls.array_get(var_widget.array_get('id')).array_isset(rt.new_string('id_base')) && var_widget.array_get('params').array_get(0).array_isset(rt.new_string('number')) {
				mut var_id_base := var_wp_registered_widget_controls.array_get(var_widget.array_get('id')).array_get('id_base')
				var_args['_temp_id'] = rt.new_string("${var_id_base.to_string()}-__i__")
				var_args['_multi_num'] = next_widget_id_number(var_id_base.dup())
				var_args['_add'] = rt.new_string('multi')
			} else {
				var_args['_add'] = rt.new_string('single')
				if rt.is_true(var_sidebar) {
					var_args['_hide'] = rt.new_string('1')
				}
			}
			mut var_control_args := [var_args, var_widget.array_get('params').array_get(0)]
			mut var_sidebar_args := wp_list_widget_controls_dynamic_sidebar(var_control_args.dup())
			wp_widget_control(var_sidebar_args.dup())
		}
	}
}

fn _sort_name_callback(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	return rt.call_function('strnatcasecmp', [var_a.array_get('name'), var_b.array_get('name')])
}

fn wp_list_widget_controls(var_sidebar rt.PhpVal, sidebar_name string) {
	rt.call_function('add_filter', [rt.new_string('dynamic_sidebar_params'), rt.new_string('wp_list_widget_controls_dynamic_sidebar')])
	mut var_description := rt.call_function('wp_sidebar_description', [var_sidebar.dup()])
	print('<div id="' + (rt.call_function('esc_attr', [var_sidebar.dup()])).str() + '" class="widgets-sortables">')
	if var_sidebar_name.len > 0 && var_sidebar_name != '0' {
		mut var_add_to := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Add to: %s')]), rt.new_string(sidebar_name)])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_add_to.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [rt.new_string(sidebar_name)]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [rt.new_string(sidebar_name)]))
		// unsupported statement: Stmt_InlineHTML
	}
	if !(!rt.is_true(var_description)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_description)
		// unsupported statement: Stmt_InlineHTML
	}
	rt.call_function('dynamic_sidebar', [var_sidebar.dup()])
	print('</div>')
}

fn wp_list_widget_controls_dynamic_sidebar(var_params rt.PhpVal) rt.PhpVal {
	mut var_wp_registered_widgets := rt.new_null()
	mut var_i := rt.new_null()
	// unsupported statement: Stmt_Global
	// unsupported statement: Stmt_Static
	rt.pre_inc(var_i)
	mut var_widget_id := var_params.array_get(0).array_get('widget_id')
	mut var_id := if !(var_params.array_get(0).array_get('_temp_id')).is_null() { var_params.array_get(0).array_get('_temp_id') } else { var_widget_id }
	mut var_hidden := if var_params.array_get(0).array_isset(rt.new_string('_hide')) { ' style="display:none;"' } else { '' }
	var_params.array_get_mut(0).array_set('before_widget', "<div id='widget-${var_i.to_string()}_${var_id.to_string()}' class='widget'${var_hidden}>")
	var_params.array_get_mut(0).array_set('after_widget', '</div>')
	var_params.array_get_mut(0).array_set('before_title', '%BEG_OF_TITLE%')
	var_params.array_get_mut(0).array_set('after_title', '%END_OF_TITLE%')
	if rt.is_true(rt.call_function('is_callable', [var_wp_registered_widgets.array_get(var_widget_id).array_get('callback')])) {
		var_wp_registered_widgets.array_get_mut(var_widget_id).array_set('_callback', var_wp_registered_widgets.array_get(var_widget_id).array_get('callback'))
		var_wp_registered_widgets.array_get_mut(var_widget_id).array_set('callback', 'wp_widget_control')
	}
	return var_params.dup()
}

fn next_widget_id_number(var_id_base rt.PhpVal) rt.PhpVal {
	mut var_wp_registered_widgets := rt.new_null()
	mut var_matches := []rt.PhpVal{}
	// unsupported statement: Stmt_Global
	mut var_number := rt.new_int(rt.new_int(1))
	{
		mut iter_1 := var_wp_registered_widgets.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_widget := item_1.val
			mut var_widget_id := item_1.key
			if rt.is_true(rt.call_function('preg_match', ['/' + (rt.call_function('preg_quote', [var_id_base.dup(), rt.new_string('/')])).str() + '-([0-9]+)$/', var_widget_id.dup(), var_matches.dup()])) {
				var_number = rt.call_function('max', [var_number.dup(), var_matches.array_get(1)])
			}
		}
	}
	rt.pre_inc(var_number)
	return var_number.dup()
}

fn wp_widget_control(var_sidebar_args rt.PhpVal) rt.PhpVal {
	mut var_wp_registered_widgets := rt.new_null()
	mut var_wp_registered_widget_controls := rt.new_null()
	mut var_sidebars_widgets := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_widget_id := var_sidebar_args.array_get('widget_id')
	mut var_sidebar_id := if !(var_sidebar_args.array_get('id')).is_null() { var_sidebar_args.array_get('id') } else { rt.new_bool(false) }
	mut var_key := if rt.is_true(var_sidebar_id) { rt.call_function('array_search', [var_widget_id.dup(), var_sidebars_widgets.array_get(var_sidebar_id), rt.new_bool(true)]) } else { rt.new_string('-1') }
	mut var_control := if !(var_wp_registered_widget_controls.array_get(var_widget_id)).is_null() { var_wp_registered_widget_controls.array_get(var_widget_id) } else { []rt.PhpVal{} }
	mut var_widget := var_wp_registered_widgets.array_get(var_widget_id)
	mut var_id_format := var_widget.array_get('id')
	mut var_widget_number := if !(var_control.array_get('params').array_get(0).array_get('number')).is_null() { var_control.array_get('params').array_get(0).array_get('number') } else { rt.new_string('') }
	mut var_id_base := if !(var_control.array_get('id_base')).is_null() { var_control.array_get('id_base') } else { var_widget_id }
	mut var_width := if !(var_control.array_get('width')).is_null() { var_control.array_get('width') } else { rt.new_string('') }
	mut var_height := if !(var_control.array_get('height')).is_null() { var_control.array_get('height') } else { rt.new_string('') }
	mut var_multi_number := if !(var_sidebar_args.array_get('_multi_num')).is_null() { var_sidebar_args.array_get('_multi_num') } else { rt.new_string('') }
	mut var_add_new := if !(var_sidebar_args.array_get('_add')).is_null() { var_sidebar_args.array_get('_add') } else { rt.new_string('') }
	mut var_before_form := if !(var_sidebar_args.array_get('before_form')).is_null() { var_sidebar_args.array_get('before_form') } else { rt.new_string('<form method="post">') }
	mut var_after_form := if !(var_sidebar_args.array_get('after_form')).is_null() { var_sidebar_args.array_get('after_form') } else { rt.new_string('</form>') }
	mut var_before_widget_content := if !(var_sidebar_args.array_get('before_widget_content')).is_null() { var_sidebar_args.array_get('before_widget_content') } else { rt.new_string('<div class="widget-content">') }
	mut var_after_widget_content := if !(var_sidebar_args.array_get('after_widget_content')).is_null() { var_sidebar_args.array_get('after_widget_content') } else { rt.new_string('</div>') }
	mut var_query_arg := { 'editwidget': var_widget.array_get('id') }
	if rt.is_true(var_add_new) {
		var_query_arg['addnew'] = rt.new_int(1)
		if rt.is_true(var_multi_number) {
			var_query_arg['num'] = var_multi_number.dup()
			var_query_arg['base'] = var_id_base.dup()
		}
	} else {
		var_query_arg['sidebar'] = var_sidebar_id.dup()
		var_query_arg['key'] = var_key.dup()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_sidebar_args.array_isset(rt.new_string('_display')) && rt.is_true(rt.identical(rt.new_string('template'), var_sidebar_args.array_get('_display'))))) && rt.is_true(var_widget_number))) {
		var_control.array_get_mut('params').array_get_mut(0).array_set('number', // unsupported expression: Expr_UnaryMinus)
		if var_control.array_isset(rt.new_string('id_base')) {
			var_id_format = rt.new_string((var_control.array_get('id_base')).str() + '-__i__')
		}
	}
	var_wp_registered_widgets.array_get_mut(var_widget_id).array_set('callback', var_wp_registered_widgets.array_get(var_widget_id).array_get('_callback'))
	var_wp_registered_widgets.array_get(var_widget_id).array_unset(rt.new_string('_callback'))
	mut var_widget_title := rt.call_function('esc_html', [rt.call_function('strip_tags', [var_sidebar_args.array_get('widget_name')])])
	mut var_has_form := rt.new_string(rt.new_string('noform'))
	rt.echo_val(var_sidebar_args.array_get('before_widget'))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('__', [rt.new_string('Edit widget: %s')]), var_widget_title.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('__', [rt.new_string('Add widget: %s')]), var_widget_title.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('add_query_arg', [var_query_arg.dup()])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [, ])
	// unsupported statement: Stmt_InlineHTML
}



pub fn init_wp_admin_includes_widgets_php() {
}
