import rt

fn wp_get_theme_preview_path(var_current_stylesheet rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('switch_themes'),
	])))))
	{
		return var_current_stylesheet.dup()
	}
	mut var_preview_stylesheet := if !(!rt.is_true(rt.get_superglobal('_GET').array_get('wp_theme_preview'))) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('wp_theme_preview')]),
		]) } else { rt.new_null() }
	mut var_wp_theme := rt.call_function('wp_get_theme', [var_preview_stylesheet.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
		rt.call_method(var_wp_theme, 'errors', []rt.PhpVal{}),
	])))))
	{
		if rt.is_true(rt.identical(rt.call_function('current_filter', []rt.PhpVal{}),
			rt.new_string('template')))
		{
			mut var_theme_path := rt.call_method(var_wp_theme, 'get_template', []rt.PhpVal{})
		} else {
			var_theme_path = rt.call_method(var_wp_theme, 'get_stylesheet', []rt.PhpVal{})
		}
		return rt.call_function('sanitize_text_field', [var_theme_path.dup()])
	}
	return var_current_stylesheet.dup()
}

fn wp_attach_theme_preview_middleware() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('switch_themes'),
	])))))
	{
		return rt.new_null()
	}
	rt.call_function('wp_add_inline_script', [rt.new_string('wp-api-fetch'),
		rt.call_function('sprintf', [
			rt.new_string('wp.apiFetch.use( wp.apiFetch.createThemePreviewMiddleware( %s ) );'),
			rt.call_function('wp_json_encode', [
				rt.call_function('sanitize_text_field', [
					rt.call_function('wp_unslash',
						[rt.get_superglobal('_GET').array_get('wp_theme_preview')]),
				]),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES')),
			]),
		]),
		rt.new_string('after')])
}

fn wp_block_theme_activate_nonce() {
	mut var_nonce_handle := rt.new_string('switch-theme_' +
		(wp_get_theme_preview_path(rt.new_null())).str())
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_json_encode', [
		rt.call_function('wp_create_nonce', [var_nonce_handle.dup()]),
		rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES')),
	]))
	// unsupported statement: Stmt_InlineHTML
}

fn wp_initialize_theme_preview_hooks() {
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get('wp_theme_preview'))) {
		rt.call_function('add_filter', [rt.new_string('stylesheet'),
			rt.new_string('wp_get_theme_preview_path')])
		rt.call_function('add_filter', [rt.new_string('template'),
			rt.new_string('wp_get_theme_preview_path')])
		rt.call_function('add_action', [rt.new_string('init'),
			rt.new_string('wp_attach_theme_preview_middleware')])
		rt.call_function('add_action', [rt.new_string('admin_head'),
			rt.new_string('wp_block_theme_activate_nonce')])
	}
}

pub fn init_wp_includes_theme_previews_php() {
}
