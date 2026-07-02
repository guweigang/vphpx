import rt

fn wp_underscore_audio_template() {
	mut var_audio_types := rt.new_null()
	mut var_attr := rt.new_null()
	mut var_type := rt.new_null()
	var_audio_types = rt.call_function('wp_get_audio_extensions', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'autoplay' },
		rt.ArrayItem{ key: none, val: 'loop' }]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_attr_shadow := item_1.val
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_attr_shadow)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_attr_shadow)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_attr_shadow)
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut iter_2 := var_audio_types.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_type_shadow := item_2.val
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_type_shadow)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_type_shadow)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_type_shadow)
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn wp_underscore_video_template() {
	mut var_video_types := rt.new_null()
	mut var_props := map[string]rt.PhpVal{}
	mut var_value := rt.new_null()
	mut var_key := rt.new_null()
	mut var_attr := rt.new_null()
	mut var_type := rt.new_null()
	var_video_types = rt.call_function('wp_get_video_extensions', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	var_props = {
		'poster':  ''
		'preload': 'metadata'
	}
	for var_key_shadow, var_value_shadow in var_props {
		if !rt.is_true(rt.new_string(var_value_shadow.str())) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.new_string(var_key_shadow.str()))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.new_string(var_key_shadow.str()))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.new_string(var_key_shadow.str()))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.new_string(var_key_shadow.str()))
			// unsupported statement: Stmt_InlineHTML
		} else {
			rt.echo_val(rt.new_string(var_key_shadow.str()))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.new_string(var_key_shadow.str()))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.new_string(var_value_shadow.str()))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.new_string(var_key_shadow.str()))
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	mut iter_3 := rt.create_array([rt.ArrayItem{ key: none, val: 'autoplay' },
		rt.ArrayItem{ key: none, val: 'loop' }]).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_attr_shadow := item_3.val
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_attr_shadow)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_attr_shadow)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_attr_shadow)
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut iter_4 := var_video_types.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_type_shadow := item_4.val
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_type_shadow)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_type_shadow)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_type_shadow)
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn wp_print_media_templates() {
	mut var_class := ''
	mut var_alt_text_description := rt.new_null()
	mut var_max_upload_size := rt.new_null()
	mut var_label := rt.new_null()
	mut var_key := rt.new_null()
	mut var_view_media_text := rt.new_null()
	mut var_sizes := rt.new_null()
	mut var_name := rt.new_null()
	mut var_value := rt.new_null()
	mut var_i := i64(0)
	mut var_size_names := rt.new_null()
	mut var_size := rt.new_null()
	mut var_audio_types := rt.new_null()
	mut var_type := rt.new_null()
	mut var_video_types := rt.new_null()
	var_class = 'media-modal wp-core-ui'
	var_alt_text_description = rt.call_function('sprintf', [
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
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Actions'), rt.new_string('media modal menu actions')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Menu'), rt.new_string('media modal menu')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Selected media actions')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	print(var_class)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Close dialog')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Drop files to upload')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Drop files to upload')])
	// unsupported statement: Stmt_InlineHTML
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
	} else if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_upload_space_available', []rt.PhpVal{}))))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Upload Limit Exceeded')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('upload_ui_over_quota')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Drop files to upload')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_ex', [rt.new_string('or'),
			rt.new_string('Uploader: Drop files here - or - Select Files')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Select Files')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('pre-upload-ui')])
		rt.call_function('do_action', [rt.new_string('pre-plupload-upload-ui')])
		if rt.is_true(rt.identical(rt.new_int(10), rt.call_function('remove_action', [
			rt.new_string('post-plupload-upload-ui'),
			rt.new_string('media_upload_flash_bypass'),
		])))
		{
			rt.call_function('do_action', [rt.new_string('post-plupload-upload-ui')])
			rt.call_function('add_action', [rt.new_string('post-plupload-upload-ui'),
				rt.new_string('media_upload_flash_bypass')])
		} else {
			rt.call_function('do_action', [rt.new_string('post-plupload-upload-ui')])
		}
		var_max_upload_size = rt.call_function('wp_max_upload_size', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(var_max_upload_size)))) {
			var_max_upload_size = rt.new_int(0)
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [rt.new_string('Maximum upload file size: %s.')]),
			rt.call_function('esc_html', [
				rt.call_function('size_format', [var_max_upload_size.clone()]),
			]),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('Suggested image dimensions: %1$s by %2$s pixels.'),
			]),
			rt.new_string('{{data.suggestedWidth}}'),
			rt.new_string('{{data.suggestedHeight}}'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('post-upload-ui')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('add_query_arg', [rt.new_string('mode'),
			rt.new_string('list'), rt.call_function('admin_url', [
				rt.new_string('upload.php'),
			])]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('List view')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('add_query_arg', [rt.new_string('mode'),
			rt.new_string('grid'), rt.call_function('admin_url', [
				rt.new_string('upload.php'),
			])]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Grid view')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Uploading')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Dismiss errors')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Edit previous media item')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Edit next media item')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Close dialog')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	if rt.get_superglobal('_GET').array_isset(rt.new_string('error'))
		&& rt.is_true(rt.identical(rt.new_string('deprecated'), rt.get_superglobal('_GET').array_get(rt.new_string('error')))) {
		rt.call_function('wp_admin_notice', [
			rt.call_function('__', [
				rt.new_string('The Edit Media screen is deprecated as of WordPress 6.3. Please use the Media Library instead.'),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'id', val: 'message' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'error' },
				]) },
			]),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Attachment Preview')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Edit Image')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Document Preview')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Saved.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Details')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Uploaded on:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Uploaded by:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Uploaded to:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('File name:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('File type:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('File size:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Dimensions:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('%1$s by %2$s pixels')]),
		rt.new_string('{{ data.width }}'),
		rt.new_string('{{ data.height }}'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Original image:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Length:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Bitrate:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Used as:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Alternative Text')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_alt_text_description)
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('post_type_supports', [rt.new_string('attachment'),
		rt.new_string('title')]))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Title')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut iter_5 := rt.create_array([
		rt.ArrayItem{ key: 'artist', val: rt.call_function('__', [
			rt.new_string('Artist'),
		]) },
		rt.ArrayItem{ key: 'album', val: rt.call_function('__', [
			rt.new_string('Album'),
		]) },
	]).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_label_shadow := item_5.val
		mut var_key_shadow := item_5.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_key_shadow.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_key_shadow.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_label_shadow)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_key_shadow.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_key_shadow)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_key_shadow)
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Caption')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Description')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('File URL:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Copy URL to clipboard')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Copied!')])
	// unsupported statement: Stmt_InlineHTML
	var_view_media_text = if rt.is_true(rt.identical(rt.new_string('1'), rt.call_function('get_option', [
		rt.new_string('wp_attachment_pages_enabled'),
	])))
	{ rt.call_function('__', [rt.new_string('View attachment page')]) } else { rt.call_function('__', [
			rt.new_string('View media file'),
		]) }
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_view_media_text)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Edit more details')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Download file')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.get_constant('MEDIA_TRASH')) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Restore from Trash')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Move to Trash')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Delete permanently')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Remove')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Deselect')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Caption')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Caption&hellip;')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Video title')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Video title&hellip;')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Audio title')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Audio title&hellip;')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Media title')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Media title&hellip;')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Attachment Details')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Saved.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('%1$s by %2$s pixels')]),
		rt.new_string('{{ data.width }}'),
		rt.new_string('{{ data.height }}'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Original image:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Edit Image')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Length:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Used as:')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.get_constant('MEDIA_TRASH')) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Restore from Trash')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Move to Trash')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Delete permanently')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Alt Text')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_alt_text_description)
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('post_type_supports', [rt.new_string('attachment'),
		rt.new_string('title')]))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Title')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut iter_6 := rt.create_array([
		rt.ArrayItem{ key: 'artist', val: rt.call_function('__', [
			rt.new_string('Artist'),
		]) },
		rt.ArrayItem{ key: 'album', val: rt.call_function('__', [
			rt.new_string('Album'),
		]) },
	]).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_label_shadow := item_6.val
		mut var_key_shadow := item_6.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_key_shadow.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_key_shadow.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_label_shadow)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_key_shadow.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_key_shadow)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_key_shadow)
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Caption')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Description')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('File URL:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Copy URL to clipboard')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Copied!')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Edit Selection')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Clear')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Attachment Display Settings')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Alignment')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Left')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Center')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Right')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('None'),
		rt.new_string('Alignment option')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Embed or Link')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Link To')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Embed Media Player')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('None'),
		rt.new_string('Media item link option')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Link to Media File')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Media File')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Link to Attachment Page')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Attachment Page')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Custom URL')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('URL')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Size')])
	// unsupported statement: Stmt_InlineHTML
	var_sizes = rt.call_function('apply_filters', [
		rt.new_string('image_size_names_choose'),
		rt.create_array([
			rt.ArrayItem{ key: 'thumbnail', val: rt.call_function('__', [
				rt.new_string('Thumbnail'),
			]) },
			rt.ArrayItem{ key: 'medium', val: rt.call_function('__', [
				rt.new_string('Medium'),
			]) },
			rt.ArrayItem{ key: 'large', val: rt.call_function('__', [
				rt.new_string('Large'),
			]) },
			rt.ArrayItem{ key: 'full', val: rt.call_function('__', [
				rt.new_string('Full Size'),
			]) },
		]),
	])
	mut iter_7 := var_sizes.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_name_shadow := item_7.val
		mut var_value_shadow := item_7.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_js', [var_value_shadow.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_value_shadow.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [var_value_shadow.clone(),
			rt.new_string('full')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_name_shadow.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Gallery Settings')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Link To')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Attachment Page')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Media File')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('None'),
		rt.new_string('Media item link option')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Columns')])
	// unsupported statement: Stmt_InlineHTML
	var_i = 1
	for {
		if !(var_i <= 9) { break
		 }
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_int(var_i).clone()]))
		// unsupported statement: Stmt_InlineHTML
		print(var_i.str())
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [rt.new_int(var_i).clone()]))
		// unsupported statement: Stmt_InlineHTML
		var_i += 1
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Random Order')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Size')])
	// unsupported statement: Stmt_InlineHTML
	var_size_names = rt.call_function('apply_filters', [
		rt.new_string('image_size_names_choose'),
		rt.create_array([
			rt.ArrayItem{ key: 'thumbnail', val: rt.call_function('__', [
				rt.new_string('Thumbnail'),
			]) },
			rt.ArrayItem{ key: 'medium', val: rt.call_function('__', [
				rt.new_string('Medium'),
			]) },
			rt.ArrayItem{ key: 'large', val: rt.call_function('__', [
				rt.new_string('Large'),
			]) },
			rt.ArrayItem{ key: 'full', val: rt.call_function('__', [
				rt.new_string('Full Size'),
			]) },
		]),
	])
	mut iter_8 := var_size_names.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_label_shadow := item_8.val
		mut var_size_shadow := item_8.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_size_shadow.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_label_shadow.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Playlist Settings')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Show Video List')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Show Tracklist')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Show Artist Name in Tracklist')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Show Images')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Link Text')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Alternative Text')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_alt_text_description)
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('disable_captions'),
		rt.new_string(''),
	])))))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Caption')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Align')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Left')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Center')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Right')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('None'),
		rt.new_string('Alignment option')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Link To')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Image URL')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Custom URL')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('None'),
		rt.new_string('Media item link option')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('URL')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Alternative Text')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_alt_text_description)
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('disable_captions'),
		rt.new_string(''),
	])))))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Caption')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Display Settings')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Align')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Left')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Center')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Right')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('None'),
		rt.new_string('Alignment option')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Size')])
	// unsupported statement: Stmt_InlineHTML
	var_sizes = rt.call_function('apply_filters', [
		rt.new_string('image_size_names_choose'),
		rt.create_array([
			rt.ArrayItem{ key: 'thumbnail', val: rt.call_function('__', [
				rt.new_string('Thumbnail'),
			]) },
			rt.ArrayItem{ key: 'medium', val: rt.call_function('__', [
				rt.new_string('Medium'),
			]) },
			rt.ArrayItem{ key: 'large', val: rt.call_function('__', [
				rt.new_string('Large'),
			]) },
			rt.ArrayItem{ key: 'full', val: rt.call_function('__', [
				rt.new_string('Full Size'),
			]) },
		]),
	])
	mut iter_9 := var_sizes.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_name_shadow := item_9.val
		mut var_value_shadow := item_9.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_js', [var_value_shadow.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_value_shadow.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_name_shadow.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string('custom')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Custom Size')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Width')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Height')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Image size in pixels')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Link To')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Media File')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Attachment Page')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Image URL')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Custom URL')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('None'),
		rt.new_string('Media item link option')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('URL')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Advanced Options')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Image Title Attribute')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Image CSS Class')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Open link in a new tab')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Link Rel')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Link CSS Class')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Edit Original')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Replace')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	var_audio_types = rt.call_function('wp_get_audio_extensions', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	wp_underscore_audio_template()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('URL')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Remove audio source')])
	// unsupported statement: Stmt_InlineHTML
	mut iter_10 := var_audio_types.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_type_shadow := item_10.val
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_type_shadow)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_type_shadow)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_type_shadow)
		// unsupported statement: Stmt_InlineHTML
		print(var_type_shadow.str() + '-source')
		// unsupported statement: Stmt_InlineHTML
		print(var_type_shadow.clone().to_string().to_upper())
		// unsupported statement: Stmt_InlineHTML
		print(var_type_shadow.str() + '-source')
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_type_shadow)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_type_shadow)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Remove audio source')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Add alternate sources for maximum HTML5 playback'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Preload')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Auto'), rt.new_string('auto preload')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Metadata')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('None'), rt.new_string('Preload value')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Autoplay')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Loop')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	var_video_types = rt.call_function('wp_get_video_extensions', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	wp_underscore_video_template()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('URL')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Remove video source')])
	// unsupported statement: Stmt_InlineHTML
	mut iter_11 := var_video_types.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_type_shadow := item_11.val
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_type_shadow)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_type_shadow)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_type_shadow)
		// unsupported statement: Stmt_InlineHTML
		print(var_type_shadow.str() + '-source')
		// unsupported statement: Stmt_InlineHTML
		print(var_type_shadow.clone().to_string().to_upper())
		// unsupported statement: Stmt_InlineHTML
		print(var_type_shadow.str() + '-source')
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_type_shadow)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_type_shadow)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Remove video source')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Add alternate sources for maximum HTML5 playback'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Poster Image')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Remove poster image')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Preload')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Auto'), rt.new_string('auto preload')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Metadata')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('None'), rt.new_string('Preload value')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Autoplay')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Loop')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Tracks (subtitles, captions, descriptions, chapters, or metadata)'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('The %1$s, %2$s, and %3$s values can be edited to set the video track language and kind.'),
		]),
		rt.new_string('srclang'),
		rt.new_string('label'),
		rt.new_string('kind'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Remove video track'),
		rt.new_string('media')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Tracks (subtitles, captions, descriptions, chapters, or metadata)'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('There are no associated subtitles.')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('No items found.')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Image crop area preview. Requires mouse interaction.'),
	])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Site Icon Preview'),
		rt.new_string('noun')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('As an app icon and a browser icon.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Preview as an app icon')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Preview as a browser icon')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('get_bloginfo', [rt.new_string('name')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('print_media_templates')])
}

fn main() {
	defer {
		rt.shutdown()
	}
}
