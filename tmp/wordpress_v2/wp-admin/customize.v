import rt

const global_const_iframe_request = true

struct Class_WP_Scripts {
	rt.PhpObjectBase
}

fn create_wp_scripts(_args ...rt.PhpVal) &Class_WP_Scripts {
	mut obj := &Class_WP_Scripts{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Scripts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Scripts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Scripts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_wp_customize := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('customize'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.new_string('<h1>' +
				(rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() +
				'</h1>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Sorry, you are not allowed to customize this site.')])).str() +
				'</p>'),
			rt.new_int(403),
		])
	}
	mut var_wp_scripts := rt.get_superglobal('wp_scripts')
	if rt.is_true(rt.call_method(var_wp_customize, 'changeset_post_id', []rt.PhpVal{})) {
		mut var_changeset_post := rt.call_function('get_post', [
			rt.call_method(var_wp_customize, 'changeset_post_id', []rt.PhpVal{}),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [
				rt.new_string('customize_changeset'),
			]), 'cap'), 'edit_post'),
			rt.get_property(var_changeset_post, 'ID'),
		])))))
		{
			rt.call_function('wp_die', [
				rt.new_string('<h1>' +
					(rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() +
					'</h1>' + '<p>' +
					(rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this changeset.')])).str() +
					'</p>'),
				rt.new_int(403),
			])
		}
		mut var_missed_schedule :=
			rt.is_true(rt.identical(rt.new_string('future'), rt.get_property(var_changeset_post, 'post_status')))
			&& rt.is_true(rt.less(rt.call_function('get_post_time', [rt.new_string('G'), rt.new_bool(true), var_changeset_post.clone()]), rt.call_function('time', []rt.PhpVal{})))
		if var_missed_schedule {
			mut var_nonces := rt.call_method(var_wp_customize, 'get_nonces', []rt.PhpVal{})
			mut var_request_args := {
				'nonce':                      var_nonces.array_get(rt.new_string('save'))
				'customize_changeset_uuid':   rt.call_method(var_wp_customize, 'changeset_uuid',
					[]rt.PhpVal{})
				'wp_customize':               rt.new_string('on')
				'customize_changeset_status': rt.new_string('publish')
			}
			rt.call_function('ob_start', []rt.PhpVal{})
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('wp_print_scripts', [
				rt.create_array([rt.ArrayItem{ key: none, val: 'wp-util' }]),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_json_encode', [
				rt.create_array_from_native_map(var_request_args),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES')),
			]))
			// unsupported statement: Stmt_InlineHTML
			mut var_script := rt.call_function('ob_get_clean', []rt.PhpVal{})
			rt.call_function('wp_die', [
				rt.new_string('<h1>' +
					(rt.call_function('__', [rt.new_string('Your scheduled changes just published')])).str() +
					'</h1>' + '<p><a href="' +
					(rt.call_function('esc_url', [rt.call_function('remove_query_arg', [rt.new_string('changeset_uuid')])])).str() +
					'">' +
					(rt.call_function('__', [rt.new_string('Customize New Changes')])).str() +
					'</a></p>' + var_script.str()),
				rt.new_int(200),
			])
		}
		if rt.is_true(rt.call_function('in_array', [
			rt.call_function('get_post_status', [
				rt.get_property(var_changeset_post, 'ID'),
			]),
			rt.create_array([
				rt.ArrayItem{ key: none, val: 'publish' },
				rt.ArrayItem{ key: none, val: 'trash' },
			]),
			rt.new_bool(true),
		]))
		{
			rt.call_function('wp_die', [
				rt.new_string('<h1>' +
					(rt.call_function('__', [rt.new_string('An error occurred while saving your changeset.')])).str() +
					'</h1>' + '<p>' +
					(rt.call_function('__', [rt.new_string('Please try again or start a new changeset. This changeset cannot be further modified.')])).str() +
					'</p>' + '<p><a href="' +
					(rt.call_function('esc_url', [rt.call_function('remove_query_arg', [rt.new_string('changeset_uuid')])])).str() +
					'">' +
					(rt.call_function('__', [rt.new_string('Customize New Changes')])).str() +
					'</a></p>'),
				rt.new_int(403),
			])
		}
	}
	mut var_url := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('url')))) { rt.call_function('esc_url_raw', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('url'))]),
		]) } else { rt.new_string('') }
	mut var_return := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('return')))) { rt.call_function('esc_url_raw', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('return'))]),
		]) } else { rt.new_string('') }
	mut var_autofocus := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('autofocus')))) && rt.get_superglobal('_REQUEST').array_get(rt.new_string('autofocus')).is_array() { rt.call_function('array_map', [
			rt.new_string('sanitize_text_field'),
			rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('autofocus'))]),
		]) } else { rt.new_array() }
	if !(!rt.is_true(var_url)) {
		rt.call_method(var_wp_customize, 'set_preview_url', [
			var_url.clone()])
	}
	if !(!rt.is_true(var_return)) {
		rt.call_method(var_wp_customize, 'set_return_url', [var_return.clone()])
	}
	if !(!rt.is_true(var_autofocus)) {
		rt.call_method(var_wp_customize, 'set_autofocus', [var_autofocus.clone()])
	}
	rt.call_function('header', [
		rt.new_string('Content-Type: ' +
			(rt.call_function('get_option', [rt.new_string('html_type')])).str() + '; charset=' +
			(rt.call_function('get_option', [rt.new_string('blog_charset')])).str()),
	])
	rt.call_function('wp_user_settings', []rt.PhpVal{})
	rt.call_function('_wp_admin_html_begin', []rt.PhpVal{})
	mut var_registered := rt.get_property(var_wp_scripts, 'registered')
	var_wp_scripts = create_wp_scripts()
	rt.set_property(var_wp_scripts, 'registered', var_registered.clone())
	rt.call_function('add_action', [rt.new_string('customize_controls_print_scripts'),
		rt.new_string('print_head_scripts'), rt.new_int(20)])
	rt.call_function('add_action', [
		rt.new_string('customize_controls_print_footer_scripts'),
		rt.new_string('_wp_footer_scripts'),
	])
	rt.call_function('add_action', [rt.new_string('customize_controls_print_styles'),
		rt.new_string('print_admin_styles'), rt.new_int(20)])
	rt.call_function('do_action', [rt.new_string('customize_controls_init')])
	rt.call_function('wp_enqueue_script', [rt.new_string('heartbeat')])
	rt.call_function('wp_enqueue_script', [rt.new_string('customize-controls')])
	rt.call_function('wp_enqueue_style', [rt.new_string('customize-controls')])
	rt.call_function('do_action', [rt.new_string('customize_controls_enqueue_scripts')])
	mut var_body_class := 'wp-core-ui wp-customizer js'
	if rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{})) {
		var_body_class = var_body_class + ' mobile'
		rt.call_function('add_filter', [rt.new_string('admin_viewport_meta'),
			rt.new_string('_customizer_mobile_viewport_meta')])
	}
	if rt.is_true(rt.call_method(var_wp_customize, 'is_ios', []rt.PhpVal{})) {
		var_body_class = var_body_class + ' ios'
	}
	if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) {
		var_body_class = var_body_class + ' rtl'
	}
	var_body_class = var_body_class + ' locale-' +(rt.call_function('sanitize_html_class', [rt.new_string(rt.call_function('str_replace', [rt.new_string('_'), rt.new_string('-'), rt.call_function('get_user_locale', []rt.PhpVal{})]).to_string().to_lower())])).str()
	mut var_admin_color := rt.call_function('get_user_option', [
		rt.new_string('admin_color'),
	])
	var_body_class = var_body_class + ' admin-color-' +(rt.call_function('sanitize_html_class', [if var_admin_color.clone().is_string() { var_admin_color } else { rt.new_string('') }, rt.new_string('modern')])).str()
	if rt.is_true(rt.call_function('wp_use_widgets_block_editor', []rt.PhpVal{})) {
		var_body_class = var_body_class + ' wp-embed-responsive'
	}
	mut var_admin_title := rt.call_function('sprintf', [
		rt.call_method(var_wp_customize, 'get_document_title_template', []rt.PhpVal{}),
		rt.call_function('__', [rt.new_string('Loading&hellip;')]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_admin_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_json_encode', [
		rt.call_function('admin_url', [rt.new_string('admin-ajax.php'),
			rt.new_string('relative')]),
		rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES')),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('customize_controls_print_styles')])
	rt.call_function('do_action', [rt.new_string('customize_controls_print_scripts')])
	rt.call_function('do_action', [rt.new_string('customize_controls_head')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_body_class.str()).clone()]))
	// unsupported statement: Stmt_InlineHTML
	mut var_compatible_wp := rt.call_function('is_wp_version_compatible', [
		rt.call_method(rt.call_method(var_wp_customize, 'theme', []rt.PhpVal{}), 'get', [
			rt.new_string('RequiresWP'),
		]),
	])
	mut var_compatible_php := rt.call_function('is_php_version_compatible', [
		rt.call_method(rt.call_method(var_wp_customize, 'theme', []rt.PhpVal{}), 'get', [
			rt.new_string('RequiresPHP'),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_compatible_wp) && rt.is_true(var_compatible_php) {
		// unsupported statement: Stmt_InlineHTML
		mut var_save_text := if rt.is_true(rt.call_method(var_wp_customize, 'is_theme_active', []rt.PhpVal{})) { rt.call_function('__', [
				rt.new_string('Publish'),
			]) } else { rt.call_function('__', [rt.new_string('Activate &amp; Publish')]) }
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('submit_button', [var_save_text.clone(),
			rt.new_string('primary button-compact save'), rt.new_string('save'),
			rt.new_bool(false)])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Publish Settings')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		var_save_text = rt.call_function('_x', [rt.new_string('Cannot Activate'),
			rt.new_string('theme')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Publish Settings')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_save_text)
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Customize')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('Preview'),
		rt.new_string('noun')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_method(var_wp_customize, 'get_return_url', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Close the Customizer and go back to the previous page'),
	])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	print(rt.new_int((rt.call_function('wp_is_block_theme', []rt.PhpVal{})).to_i64()).str())
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('You are customizing %s')]),
		rt.new_string('<strong class="panel-title site-title">' +
			(rt.call_function('get_bloginfo', [rt.new_string('name'), rt.new_string('display')])).str() +
			'</strong>'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Help')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('The Customizer allows you to preview changes to your site before publishing them. You can navigate to different pages on your site within the preview. Edit shortcuts are shown for some editable elements. The Customizer is intended for use with non-block themes.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('<a href="https://wordpress.org/documentation/article/customizer/">Documentation on Customizer</a>'),
	])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr_x', [rt.new_string('Hide Controls'),
		rt.new_string('label for hide controls button without length constraints')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Hide Controls'),
		rt.new_string('short (~12 characters) label for hide controls button')])
	// unsupported statement: Stmt_InlineHTML
	mut var_previewable_devices := rt.call_method(var_wp_customize, 'get_previewable_devices',
		[]rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_previewable_devices)) {
		// unsupported statement: Stmt_InlineHTML
		mut iter_1 := rt.cast_array(var_previewable_devices).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_settings := item_1.val
			mut var_device := item_1.key
			// unsupported statement: Stmt_InlineHTML
			if !rt.is_true(var_settings.array_get(rt.new_string('label'))) {
				continue
			}
			mut var_active := !(!rt.is_true(var_settings.array_get(rt.new_string('default'))))
			mut var_class := rt.new_string('preview-' + var_device.str())
			if var_active {
				var_class = rt.concat(var_class, rt.new_string(' active'))
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_class.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.new_bool(var_active).clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_device.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				var_settings.array_get(rt.new_string('label')),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('customize_controls_print_footer_scripts'),
	])
	// unsupported statement: Stmt_InlineHTML
}
