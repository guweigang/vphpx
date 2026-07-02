import rt

fn render_block_core_navigation_overlay_close(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_text := rt.new_null()
	mut var_display_mode := rt.new_null()
	mut var_show_icon := false
	mut var_show_text := false
	mut var_button_text := ''
	mut var_wrapper_attributes := rt.new_null()
	mut var_html_content := rt.new_null()
	var_text = if !rt.is_true(var_attributes.array_get(rt.new_string('text'))) { rt.call_function('__', [
			rt.new_string('Close'),
		]) } else { var_attributes.array_get(rt.new_string('text')) }
	var_display_mode = if !rt.is_true(var_attributes.array_get(rt.new_string('displayMode'))) {
		rt.new_string('icon')
	} else {
		var_attributes.array_get(rt.new_string('displayMode'))
	}
	var_show_icon = rt.is_true(rt.identical(rt.new_string('both'), var_display_mode))
		|| rt.is_true(rt.identical(rt.new_string('icon'), var_display_mode))
	var_show_text = rt.is_true(rt.identical(rt.new_string('both'), var_display_mode))
		|| rt.is_true(rt.identical(rt.new_string('text'), var_display_mode))
	var_button_text = ''
	if var_show_icon {
		var_button_text = var_button_text +
			'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24" aria-hidden="true" focusable="false"><path d="M13 11.8l6.1-6.3-1.1-1-6.1 6.2-6.1-6.2-1.1 1 6.1 6.3-6.5 6.7 1.1 1 6.5-6.6 6.5 6.6 1.1-1z" /></svg>'
	}
	if var_show_text {
		var_button_text = var_button_text +
			'<span class="wp-block-navigation-overlay-close__text">' +
			(rt.call_function('wp_kses_post', [var_text.clone()])).str() + '</span>'
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})
	var_html_content = rt.call_function('sprintf', [
		rt.new_string('<button %1$s type="button" %2$s >%3$s</button>'),
		var_wrapper_attributes.clone(),
		rt.new_string((if !var_show_text {
			'aria-label="' + (rt.call_function('__', [rt.new_string('Close')])).str() + '"'
		} else {
			''
		}).str()),
		rt.new_string(var_button_text.str()).clone(),
	])
	return var_html_content.clone()
}

fn register_block_core_navigation_overlay_close() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/navigation-overlay-close'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_navigation_overlay_close' },
		]),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_navigation_overlay_close')])
}
