import rt

fn render_block_core_calendar(var_attributes rt.PhpVal) string {
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(block_core_calendar_has_published_posts())))) {
		if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
			return '<div>' + (rt.call_function('__', [rt.new_string('The calendar block is hidden because there are no published posts.')])).str() + '</div>'
		}
		return ''
	}
	mut var_previous_monthnum := var_monthnum.dup()
	mut var_previous_year := var_year.dup()
	if var_attributes.array_isset(rt.new_string('month')) && var_attributes.array_isset(rt.new_string('year')) {
		mut var_permalink_structure := rt.call_function('get_option', [rt.new_string('permalink_structure')])
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('str_contains', [var_permalink_structure.dup(), rt.new_string('%monthnum%')])) && rt.is_true(rt.call_function('str_contains', [var_permalink_structure.dup(), rt.new_string('%year%')])))) {
			mut var_monthnum := var_attributes.array_get('month')
			mut var_year := var_attributes.array_get('year')
		}
	}
	mut var_color_block_styles := map[string]rt.PhpVal{}
	mut var_preset_text_color := if rt.is_true(rt.new_bool(var_attributes.dup().array_isset(rt.new_string('textColor')))) { rt.concat(rt.new_string('var:preset|color|'), var_attributes.array_get('textColor')) } else { rt.new_null() }
	mut var_custom_text_color := if !(var_attributes.array_get('style').array_get('color').array_get('text')).is_null() { var_attributes.array_get('style').array_get('color').array_get('text') } else { rt.new_null() }
	var_color_block_styles['text'] = if rt.is_true(var_preset_text_color) { var_preset_text_color } else { var_custom_text_color }
	mut var_preset_background_color := if rt.is_true(rt.new_bool(var_attributes.dup().array_isset(rt.new_string('backgroundColor')))) { rt.concat(rt.new_string('var:preset|color|'), var_attributes.array_get('backgroundColor')) } else { rt.new_null() }
	mut var_custom_background_color := if !(var_attributes.array_get('style').array_get('color').array_get('background')).is_null() { var_attributes.array_get('style').array_get('color').array_get('background') } else { rt.new_null() }
	var_color_block_styles['background'] = if rt.is_true(var_preset_background_color) { var_preset_background_color } else { var_custom_background_color }
	mut var_styles := rt.call_function('wp_style_engine_get_styles', [rt.create_array([rt.ArrayItem{ key: 'color', val: var_color_block_styles }]), rt.create_array([rt.ArrayItem{ key: 'convert_vars_to_classnames', val: true }])])
	mut var_inline_styles := if !rt.is_true(var_styles.array_get('css')) { rt.new_string('') } else { rt.call_function('sprintf', [rt.new_string(' style="%s"'), rt.call_function('esc_attr', [var_styles.array_get('css')])]) }
	mut var_classnames := rt.new_string(if !rt.is_true(var_styles.array_get('classnames')) { rt.new_string('') } else { ' ' + (rt.call_function('esc_attr', [var_styles.array_get('classnames')])).str() })
	if var_attributes.array_get('style').array_get('elements').array_get('link').array_get('color').array_isset(rt.new_string('text')) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_calendar := rt.call_function('str_replace', [rt.new_string('<table'), '<table' + (var_inline_styles).str(), rt.call_function('get_calendar', [rt.new_bool(true), rt.new_bool(false)])])
	var_calendar = rt.call_function('str_replace', [rt.new_string('class="wp-calendar-table'), 'class="wp-calendar-table' + (var_classnames).str(), var_calendar.dup()])
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})
	mut var_output := rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'), var_wrapper_attributes.dup(), var_calendar.dup()])
	var_monthnum = var_previous_monthnum.dup()
	var_year = var_previous_year.dup()
	return (var_output).str()
}

fn register_block_core_calendar() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/calendar', rt.create_array([rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_calendar' }])])
}

fn block_core_calendar_has_published_posts() rt.PhpVal {
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		return rt.less(rt.new_int(0), // unsupported expression: Expr_Cast_Int)
	}
	mut var_has_published_posts := rt.call_function('get_option', [rt.new_string('wp_calendar_block_has_published_posts'), rt.new_null()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return // unsupported expression: Expr_Cast_Bool
	}
	return block_core_calendar_update_has_published_posts()
}

fn block_core_calendar_update_has_published_posts() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_has_published_posts := // unsupported expression: Expr_Cast_Bool
	rt.call_function('update_option', [rt.new_string('wp_calendar_block_has_published_posts'), var_has_published_posts.dup()])
	return var_has_published_posts.dup()
}

fn block_core_calendar_update_has_published_post_on_delete(var_post_id rt.PhpVal) {
	mut var_post := rt.call_function('get_post', [var_post_id.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	block_core_calendar_update_has_published_posts()
}

fn block_core_calendar_update_has_published_post_on_transition_post_status(var_new_status rt.PhpVal, var_old_status rt.PhpVal, var_post rt.PhpVal) {
	if rt.is_true(rt.identical(var_new_status, var_old_status)) {
		return rt.new_null()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	block_core_calendar_update_has_published_posts()
}



pub fn init_wp_includes_blocks_calendar_php() {
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('register_block_core_calendar')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		rt.call_function('add_action', [rt.new_string('delete_post'), rt.new_string('block_core_calendar_update_has_published_post_on_delete')])
		rt.call_function('add_action', [rt.new_string('transition_post_status'), rt.new_string('block_core_calendar_update_has_published_post_on_transition_post_status'), rt.new_int(10), rt.new_int(3)])
	}
}
