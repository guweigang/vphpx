import rt

fn render_block_core_navigation_overlay_close(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_text := if !rt.is_true(var_attributes.array_get('text')) { rt.call_function('__', [
			rt.new_string('Close'),
		]) } else { var_attributes.array_get('text') }
	mut var_display_mode := if !rt.is_true(var_attributes.array_get('displayMode')) {
		rt.new_string('icon')
	} else {
		var_attributes.array_get('displayMode')
	}
	mut var_show_icon := rt.is_true(rt.identical(rt.new_string('both'), var_display_mode))
		|| rt.is_true(rt.identical(rt.new_string('icon'), var_display_mode))
	mut var_show_text := rt.is_true(rt.identical(rt.new_string('both'), var_display_mode))
		|| rt.is_true(rt.identical(rt.new_string('text'), var_display_mode))
	mut var_button_text := ''
	if var_show_icon {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if var_show_text {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})
	mut var_html_content := rt.call_function('sprintf', [
		rt.new_string('<button %1$s type="button" %2$s >%3$s</button>'),
		var_wrapper_attributes.dup(),
		if !var_show_text {
			'aria-label="' + (rt.call_function('__', [rt.new_string('Close')])).str() + '"'
		} else {
			rt.new_string('')
		},
		rt.new_string(var_button_text).dup(),
	])
	return var_html_content.dup()
}

fn register_block_core_navigation_overlay_close() {
	rt.call_function('register_block_type_from_metadata', [
		@DIR + '/navigation-overlay-close',
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_navigation_overlay_close' },
		]),
	])
}

pub fn init_wp_includes_blocks_navigation_overlay_close_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_navigation_overlay_close')])
}
