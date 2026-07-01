import rt

fn wp_underscore_audio_template() {
	mut var_audio_types := rt.call_function('wp_get_audio_extensions', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'autoplay' },
			rt.ArrayItem{ key: none, val: 'loop' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_attr := item_1.val
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_attr)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_attr)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_attr)
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_audio_types.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_type := item_1.val
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_type)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_type)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_type)
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
}

fn wp_underscore_video_template() {
	mut var_video_types := rt.call_function('wp_get_video_extensions', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	mut var_props := {
		'poster':  ''
		'preload': 'metadata'
	}
	for var_key, var_value in var_props {
		if value == '' {
			// unsupported statement: Stmt_InlineHTML
			print(var_key)
			// unsupported statement: Stmt_InlineHTML
			print(var_key)
			// unsupported statement: Stmt_InlineHTML
			print(var_key)
			// unsupported statement: Stmt_InlineHTML
			print(var_key)
			// unsupported statement: Stmt_InlineHTML
		} else {
			print(var_key)
			// unsupported statement: Stmt_InlineHTML
			print(var_key)
			// unsupported statement: Stmt_InlineHTML
			print(var_value)
			// unsupported statement: Stmt_InlineHTML
			print(var_key)
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'autoplay' },
			rt.ArrayItem{ key: none, val: 'loop' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_attr := item_1.val
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_attr)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_attr)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_attr)
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_video_types.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_type := item_1.val
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_type)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_type)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_type)
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
}

fn wp_print_media_templates() {
	mut var_class := 'media-modal wp-core-ui'
	mut var_alt_text_description := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('<a href="%1$s" %2$s>Learn how to describe the purpose of the image%3$s</a>. Leave empty if the image is purely decorative.'),
		]),
		rt.call_function('esc_url', [
			rt.call_function('__', [
				rt.new_string('https://www.w3.org/WAI/tutorials/images/decision-tree/'),
			]),
		]),
		rt.new_string('target="_blank"'),
		rt.call_function('sprintf', [
			rt.new_string('<span class="screen-reader-text"> %s</span><span aria-hidden="true" class="dashicons dashicons-external"></span>'),
			rt.call_function('__', [
				rt.new_string('(opens in a new tab)'),
			]),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Actions'), rt.new_string('media modal menu actions')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Menu'), rt.new_string('media modal menu')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Selected media actions')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	print(var_class)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Close dialog')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Drop files to upload')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Drop files to upload')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Close uploader')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('_device_can_upload', []rt.PhpVal{}))))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Your browser cannot upload files')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('The web browser on your device cannot be used to upload files. You may be able to use the <a href="%s">native app for your device</a> instead.'),
			]),
			rt.new_string('https://apps.wordpress.org/'),
		])
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true())))))
	{
		// unsupported statement: Stmt_InlineHTML
	} else {
	}
	// unsupported statement: Stmt_InlineHTML
}

pub fn init_wp_includes_media_template_php() {
}
