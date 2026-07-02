import rt

fn wp_list_widgets() {
	mut var_wp_registered_widgets := rt.new_null()
	mut var_wp_registered_widget_controls := rt.new_null()
	mut var_sort := rt.new_null()
	mut var_done := []rt.PhpVal{}
	mut var_widget := rt.new_null()
	mut var_sidebar := rt.new_null()
	mut var_args := map[string]rt.PhpVal{}
	mut var_id_base := rt.new_null()
	mut var_control_args := []rt.PhpVal{}
	mut var_sidebar_args := rt.new_null()
	var_sort = var_wp_registered_widgets
	rt.call_function('usort', [var_sort.clone(), rt.new_string('_sort_name_callback')])
	var_done = []rt.PhpVal{}
	mut iter_1 := var_sort.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_widget_shadow := item_1.val
		if rt.is_true(rt.call_function('in_array', [
			var_widget_shadow.array_get(rt.new_string('callback')),
			rt.create_array_from_list(var_done),
			rt.new_bool(true),
		]))
		{
			continue
		}
		var_sidebar = rt.call_function('is_active_widget', [
			var_widget_shadow.array_get(rt.new_string('callback')),
			var_widget_shadow.array_get(rt.new_string('id')),
			rt.new_bool(false),
			rt.new_bool(false),
		])
		var_done << var_widget_shadow.array_get(rt.new_string('callback'))
		if !(var_widget_shadow.array_get(rt.new_string('params')).array_isset(rt.new_int(0))) {
			var_widget_shadow.array_get_mut('params').array_set(0, []rt.PhpVal{})
		}
		var_args = {
			'widget_id':   var_widget_shadow.array_get(rt.new_string('id'))
			'widget_name': var_widget_shadow.array_get(rt.new_string('name'))
			'_display':    rt.new_string('template')
		}
		if var_wp_registered_widget_controls.array_get(var_widget_shadow.array_get(rt.new_string('id'))).array_isset(rt.new_string('id_base'))
			&& var_widget_shadow.array_get(rt.new_string('params')).array_get(rt.new_int(0)).array_isset(rt.new_string('number')) {
			var_id_base =
				var_wp_registered_widget_controls.array_get(var_widget_shadow.array_get(rt.new_string('id'))).array_get(rt.new_string('id_base'))
			var_args['_temp_id'] = rt.new_string('${var_id_base.to_string()}-__i__')
			var_args['_multi_num'] = next_widget_id_number(var_id_base.clone())
			var_args['_add'] = rt.new_string('multi')
		} else {
			var_args['_add'] = rt.new_string('single')
			if rt.is_true(var_sidebar) {
				var_args['_hide'] = rt.new_string('1')
			}
		}
		var_control_args = [var_args, var_widget_shadow.array_get(rt.new_string('params')).array_get(rt.new_int(0))]
		var_sidebar_args =
			wp_list_widget_controls_dynamic_sidebar(rt.create_array_from_list(var_control_args))
		wp_widget_control(var_sidebar_args.clone())
	}
}

fn _sort_name_callback(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	return rt.call_function('strnatcasecmp', [var_a.array_get(rt.new_string('name')),
		var_b.array_get(rt.new_string('name'))])
}

fn wp_list_widget_controls(var_sidebar rt.PhpVal, sidebar_name string) {
	mut var_sidebar_name := sidebar_name
	mut var_description := rt.new_null()
	mut var_add_to := rt.new_null()
	rt.call_function('add_filter', [rt.new_string('dynamic_sidebar_params'),
		rt.new_string('wp_list_widget_controls_dynamic_sidebar')])
	var_description = rt.call_function('wp_sidebar_description', [
		var_sidebar.clone()])
	print('<div id="' + (rt.call_function('esc_attr', [var_sidebar.clone()])).str() +
		'" class="widgets-sortables">')
	if var_sidebar_name.len > 0 && var_sidebar_name != '0' {
		var_add_to = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Add to: %s')]),
			rt.new_string(sidebar_name),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_add_to.clone()]))
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
	rt.call_function('dynamic_sidebar', [var_sidebar.clone()])
	print('</div>')
}

fn wp_list_widget_controls_dynamic_sidebar(var_params rt.PhpVal) rt.PhpVal {
	mut var_wp_registered_widgets := rt.new_null()
	mut var_i := rt.new_null()
	mut var_widget_id := rt.new_null()
	mut var_id := rt.new_null()
	mut var_hidden := ''
	rt.pre_inc(var_i)
	var_widget_id = var_params.array_get(rt.new_int(0)).array_get(rt.new_string('widget_id'))
	var_id = if !(var_params.array_get(rt.new_int(0)).array_get(rt.new_string('_temp_id'))).is_null() {
		var_params.array_get(rt.new_int(0)).array_get(rt.new_string('_temp_id'))
	} else {
		var_widget_id
	}
	var_hidden = if var_params.array_get(rt.new_int(0)).array_isset(rt.new_string('_hide')) {
		' style="display:none;"'
	} else {
		''
	}
	var_params.array_get_mut(0).array_set('before_widget',
		"<div id='widget-${var_i.to_string()}_${var_id.to_string()}' class='widget'${var_hidden}>")
	var_params.array_get_mut(0).array_set('after_widget', '</div>')
	var_params.array_get_mut(0).array_set('before_title', '%BEG_OF_TITLE%')
	var_params.array_get_mut(0).array_set('after_title', '%END_OF_TITLE%')
	if rt.is_true(rt.call_function('is_callable', [
		var_wp_registered_widgets.array_get(var_widget_id).array_get(rt.new_string('callback')),
	]))
	{
		var_wp_registered_widgets.array_get_mut(var_widget_id).array_set('_callback',
			var_wp_registered_widgets.array_get(var_widget_id).array_get(rt.new_string('callback')))
		var_wp_registered_widgets.array_get_mut(var_widget_id).array_set('callback',
			'wp_widget_control')
	}
	return var_params.clone()
}

fn next_widget_id_number(var_id_base rt.PhpVal) rt.PhpVal {
	mut var_wp_registered_widgets := rt.new_null()
	mut var_matches := []rt.PhpVal{}
	mut var_number := rt.new_null()
	mut var_widget := rt.new_null()
	mut var_widget_id := rt.new_null()
	var_number = rt.new_int(1)
	mut iter_2 := var_wp_registered_widgets.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_widget_shadow := item_2.val
		mut var_widget_id_shadow := item_2.key
		if rt.is_true(rt.call_function('preg_match', [
			rt.new_string('/' +
				(rt.call_function('preg_quote', [var_id_base.clone(), rt.new_string('/')])).str() +
				'-([0-9]+)$/'),
			var_widget_id_shadow.clone(),
			rt.create_array_from_list(var_matches),
		]))
		{
			var_number = rt.call_function('max', [var_number.clone(), var_matches[1]])
		}
	}
	rt.pre_inc(var_number)
	return var_number.clone()
}

fn wp_widget_control(var_sidebar_args rt.PhpVal) rt.PhpVal {
	mut var_wp_registered_widgets := rt.new_null()
	mut var_wp_registered_widget_controls := rt.new_null()
	mut var_sidebars_widgets := rt.new_null()
	mut var_widget_id := rt.new_null()
	mut var_sidebar_id := rt.new_null()
	mut var_key := rt.new_null()
	mut var_control := rt.new_null()
	mut var_widget := rt.new_null()
	mut var_id_format := rt.new_null()
	mut var_widget_number := rt.new_null()
	mut var_id_base := rt.new_null()
	mut var_width := rt.new_null()
	mut var_height := rt.new_null()
	mut var_multi_number := rt.new_null()
	mut var_add_new := rt.new_null()
	mut var_before_form := rt.new_null()
	mut var_after_form := rt.new_null()
	mut var_before_widget_content := rt.new_null()
	mut var_after_widget_content := rt.new_null()
	mut var_query_arg := map[string]rt.PhpVal{}
	mut var_widget_title := rt.new_null()
	mut var_has_form := rt.new_null()
	mut var_noform_class := ''
	mut var_widget_description := rt.new_null()
	var_widget_id = var_sidebar_args.array_get(rt.new_string('widget_id'))
	var_sidebar_id = if !(var_sidebar_args.array_get(rt.new_string('id'))).is_null() {
		var_sidebar_args.array_get(rt.new_string('id'))
	} else {
		rt.new_bool(false)
	}
	var_key = if rt.is_true(var_sidebar_id) { rt.call_function('array_search', [
			var_widget_id.clone(),
			var_sidebars_widgets.array_get(var_sidebar_id),
			rt.new_bool(true),
		]) } else { rt.new_string('-1') }
	var_control = if !(var_wp_registered_widget_controls.array_get(var_widget_id)).is_null() {
		var_wp_registered_widget_controls.array_get(var_widget_id)
	} else {
		[]rt.PhpVal{}
	}
	var_widget = var_wp_registered_widgets.array_get(var_widget_id)
	var_id_format = var_widget.array_get(rt.new_string('id'))
	var_widget_number = if !(var_control.array_get(rt.new_string('params')).array_get(rt.new_int(0)).array_get(rt.new_string('number'))).is_null() {
		var_control.array_get(rt.new_string('params')).array_get(rt.new_int(0)).array_get(rt.new_string('number'))
	} else {
		rt.new_string('')
	}
	var_id_base = if !(var_control.array_get(rt.new_string('id_base'))).is_null() {
		var_control.array_get(rt.new_string('id_base'))
	} else {
		var_widget_id
	}
	var_width = if !(var_control.array_get(rt.new_string('width'))).is_null() {
		var_control.array_get(rt.new_string('width'))
	} else {
		rt.new_string('')
	}
	var_height = if !(var_control.array_get(rt.new_string('height'))).is_null() {
		var_control.array_get(rt.new_string('height'))
	} else {
		rt.new_string('')
	}
	var_multi_number = if !(var_sidebar_args.array_get(rt.new_string('_multi_num'))).is_null() {
		var_sidebar_args.array_get(rt.new_string('_multi_num'))
	} else {
		rt.new_string('')
	}
	var_add_new = if !(var_sidebar_args.array_get(rt.new_string('_add'))).is_null() {
		var_sidebar_args.array_get(rt.new_string('_add'))
	} else {
		rt.new_string('')
	}
	var_before_form = if !(var_sidebar_args.array_get(rt.new_string('before_form'))).is_null() {
		var_sidebar_args.array_get(rt.new_string('before_form'))
	} else {
		rt.new_string('<form method="post">')
	}
	var_after_form = if !(var_sidebar_args.array_get(rt.new_string('after_form'))).is_null() {
		var_sidebar_args.array_get(rt.new_string('after_form'))
	} else {
		rt.new_string('</form>')
	}
	var_before_widget_content = if !(var_sidebar_args.array_get(rt.new_string('before_widget_content'))).is_null() {
		var_sidebar_args.array_get(rt.new_string('before_widget_content'))
	} else {
		rt.new_string('<div class="widget-content">')
	}
	var_after_widget_content = if !(var_sidebar_args.array_get(rt.new_string('after_widget_content'))).is_null() {
		var_sidebar_args.array_get(rt.new_string('after_widget_content'))
	} else {
		rt.new_string('</div>')
	}
	var_query_arg = {
		'editwidget': var_widget.array_get(rt.new_string('id'))
	}
	if rt.is_true(var_add_new) {
		var_query_arg['addnew'] = rt.new_int(1)
		if rt.is_true(var_multi_number) {
			var_query_arg['num'] = var_multi_number.clone()
			var_query_arg['base'] = var_id_base.clone()
		}
	} else {
		var_query_arg['sidebar'] = var_sidebar_id.clone()
		var_query_arg['key'] = var_key.clone()
	}
	if var_sidebar_args.array_isset(rt.new_string('_display'))
		&& rt.is_true(rt.identical(rt.new_string('template'), var_sidebar_args.array_get(rt.new_string('_display'))))
		&& rt.is_true(var_widget_number) {
		var_control.array_get_mut('params').array_get_mut(0).array_set('number', -1)
		if var_control.array_isset(rt.new_string('id_base')) {
			var_id_format = rt.new_string(
				(var_control.array_get(rt.new_string('id_base'))).str() + '-__i__')
		}
	}
	var_wp_registered_widgets.array_get_mut(var_widget_id).array_set('callback',
		var_wp_registered_widgets.array_get(var_widget_id).array_get(rt.new_string('_callback')))
	var_wp_registered_widgets.array_get(var_widget_id).array_unset(rt.new_string('_callback'))
	var_widget_title = rt.call_function('esc_html', [
		rt.call_function('strip_tags', [var_sidebar_args.array_get(rt.new_string('widget_name'))]),
	])
	var_has_form = rt.new_string('noform')
	rt.echo_val(var_sidebar_args.array_get(rt.new_string('before_widget')))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('Edit widget: %s')]),
		var_widget_title.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('Add widget: %s')]),
		var_widget_title.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('add_query_arg', [
			rt.create_array_from_native_map(var_query_arg),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Edit'), rt.new_string('widget')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Add'), rt.new_string('widget')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_widget_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_widget_title)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_before_form)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_before_widget_content)
	// unsupported statement: Stmt_InlineHTML
	if var_control.array_isset(rt.new_string('callback')) {
		var_has_form = rt.call_function('call_user_func_array', [
			var_control.array_get(rt.new_string('callback')),
			var_control.array_get(rt.new_string('params')),
		])
	} else {
		print('\t\t<p>' +
			(rt.call_function('__', [rt.new_string('There are no options for this widget.')])).str() +
			'</p>\n')
	}
	var_noform_class = ''
	if rt.is_true(rt.identical(rt.new_string('noform'), var_has_form)) {
		var_noform_class = ' widget-control-noform'
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_after_widget_content)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_id_format.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_id_base.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_width.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_height.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_widget_number.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_multi_number.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_add_new.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Delete')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Done')])
	// unsupported statement: Stmt_InlineHTML
	print(var_noform_class)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [rt.call_function('__', [
		rt.new_string('Save')]),
		rt.new_string('primary widget-control-save right'), rt.new_string('savewidget'),
		rt.new_bool(false),
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'widget-' +
			(rt.call_function('esc_attr', [var_id_format.clone()])).str() + '-savewidget' }])])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_after_form)
	// unsupported statement: Stmt_InlineHTML
	var_widget_description = rt.call_function('wp_widget_description', [
		var_widget_id.clone()])
	print(if rt.is_true(var_widget_description) {
		'${var_widget_description.to_string()}\n'
	} else {
		'${var_widget_title.to_string()}\n'
	})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_sidebar_args.array_get(rt.new_string('after_widget')))
	return var_sidebar_args.clone()
}

fn wp_widgets_access_body_class(var_classes rt.PhpVal) string {
	return '${var_classes.to_string()} widgets_access '
}

fn main() {
	defer {
		rt.shutdown()
	}
}
