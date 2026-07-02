import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var__FILES := rt.new_null()
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('action'))
		&& rt.is_true(rt.identical(rt.new_string('upload-attachment'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('action')))) {
		rt.call_function('define', [rt.new_string('DOING_AJAX'),
			rt.new_bool(true)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_ADMIN'),
	])))))
	{
		rt.call_function('define', [rt.new_string('WP_ADMIN'),
			rt.new_bool(true)])
	}
	rt.include_file((rt.call_function('dirname', [rt.new_string(@DIR)])).str() + '/wp-load.php',
		'4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin.php', '4')
	rt.call_function('header', [
		rt.new_string('Content-Type: text/plain; charset=' +
			(rt.call_function('get_option', [rt.new_string('blog_charset')])).str()),
	])
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('action'))
		&& rt.is_true(rt.identical(rt.new_string('upload-attachment'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('action')))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/ajax-actions.php',
			'3')
		rt.call_function('send_nosniff_header', []rt.PhpVal{})
		rt.call_function('nocache_headers', []rt.PhpVal{})
		rt.call_function('wp_ajax_upload_attachment', []rt.PhpVal{})
		fn () {
			print((rt.new_string('0')).str())
			exit(0)
		}()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('upload_files'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to upload files.'),
			]),
		])
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('attachment_id'))
		&& rt.is_true(rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('attachment_id'))).to_i64()))
		&& rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('fetch'))) {
		mut var_id :=
			rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('attachment_id'))).to_i64())
		mut var_post := rt.call_function('get_post', [var_id.clone()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('attachment'), rt.get_property(var_post,
			'post_type')))))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [rt.new_string('Invalid post type.')]),
			])
		}
		mut switch_val_1 := rt.get_superglobal('_REQUEST').array_get(rt.new_string('fetch'))
		if rt.is_true(rt.equal(switch_val_1, rt.new_int(3))) {
			// unsupported statement: Stmt_InlineHTML
			mut var_thumb_url := rt.call_function('wp_get_attachment_image_src', [
				var_id.clone(),
				rt.new_string('thumbnail'),
				rt.new_bool(true),
			])
			if rt.is_true(var_thumb_url) {
				print('<img class="pinkynail" src="' +
					(rt.call_function('esc_url', [var_thumb_url.array_get(rt.new_int(0))])).str() +
					'" alt="" />')
			}
			mut var_file := rt.call_function('get_attached_file', [
				rt.get_property(var_post, 'ID'),
			])
			mut var_file_url := rt.call_function('wp_get_attachment_url', [
				rt.get_property(var_post, 'ID'),
			])
			mut var_title := if rt.is_true(rt.get_property(var_post, 'post_title')) { rt.get_property(var_post, 'post_title') } else { rt.call_function('wp_basename', [
					var_file.clone(),
				]) }
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				rt.call_function('wp_html_excerpt', [var_title.clone(),
					rt.new_int(60), rt.new_string('&hellip;')]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				rt.call_function('wp_basename', [var_file.clone()]),
			]))
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('edit_post'),
				var_id.clone(),
			]))
			{
				print('<a class="edit-attachment" href="' +
					(rt.call_function('esc_url', [rt.call_function('get_edit_post_link', [var_id.clone()])])).str() +
					'">' +
					(rt.call_function('_x', [rt.new_string('Edit'), rt.new_string('media item')])).str() +
					'</a>')
			} else {
				print('<span class="edit-attachment">' +
					(rt.call_function('_x', [rt.new_string('Success'), rt.new_string('media item')])).str() +
					'</span>')
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [var_file_url.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Copy URL to clipboard')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Copied!')])
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(2))) {
			rt.call_function('add_filter', [rt.new_string('attachment_fields_to_edit'),
				rt.new_string('media_single_attachment_fields_to_edit'),
				rt.new_int(10), rt.new_int(2)])
			rt.echo_val(rt.call_function('get_media_item', [var_id.clone(),
				rt.create_array([rt.ArrayItem{ key: 'send', val: false },
					rt.ArrayItem{ key: 'delete', val: true }])]))
		} else {
			rt.call_function('add_filter', [rt.new_string('attachment_fields_to_edit'),
				rt.new_string('media_post_single_attachment_fields_to_edit'),
				rt.new_int(10), rt.new_int(2)])
			rt.echo_val(rt.call_function('get_media_item', [var_id.clone()]))
		}
		exit(0)
	}
	rt.call_function('check_admin_referer', [rt.new_string('media-form')])
	mut var_post_id := rt.new_int(0)
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('post_id')) {
		var_post_id = rt.call_function('absint',
			[rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_id'))])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_post', [var_post_id.clone()])))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), var_post_id.clone()]))))) {
			var_post_id = rt.new_int(0)
		}
	}
	var_id = rt.call_function('media_handle_upload', [rt.new_string('async-upload'),
		var_post_id.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_id.clone()])) {
		mut var_button_unique_id := rt.call_function('uniqid', [
			rt.new_string('dismiss-'),
		])
		mut var_error_description_id := rt.call_function('uniqid', [
			rt.new_string('error-description-'),
		])
		mut var_message := rt.call_function('sprintf', [
			rt.new_string('%s <strong>%s</strong><br />%s'),
			rt.call_function('sprintf', [
				rt.new_string('<button type="button" id="%1$s" class="dismiss button-link" aria-describedby="%2$s">%3$s</button>'),
				rt.call_function('esc_attr', [var_button_unique_id.clone()]),
				rt.call_function('esc_attr', [var_error_description_id.clone()]),
				rt.call_function('__', [rt.new_string('Dismiss')]),
			]),
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('&#8220;%s&#8221; has failed to upload.')]),
				rt.call_function('esc_html',
					[var__FILES.array_get(rt.new_string('async-upload')).array_get(rt.new_string('name'))]),
			]),
			rt.call_function('esc_html', [
				rt.call_method(var_id, 'get_error_message', []rt.PhpVal{}),
			]),
		])
		rt.call_function('wp_admin_notice', [var_message.clone(),
			rt.create_array([rt.ArrayItem{ key: 'id', val: var_error_description_id },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'error-div' },
					rt.ArrayItem{ key: none, val: 'error' },
				]) }, rt.ArrayItem{ key: 'paragraph_wrap', val: false }])])
		mut var_speak_message := rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s has failed to upload.')]),
			var__FILES.array_get(rt.new_string('async-upload')).array_get(rt.new_string('name')),
		])
		print('<script>_.delay(function() {wp.a11y.speak(' +
			(rt.call_function('wp_json_encode', [var_speak_message.clone(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])).str() +
			");}, 1500);jQuery( 'button#${var_button_unique_id.to_string()}' ).on( 'click', function() {jQuery(this).parents('div.media-item').slideUp(200, function(){jQuery(this).remove();wp.a11y.speak( wp.i18n.__( 'Error dismissed.' ) );jQuery( '#plupload-browse-button' ).trigger( 'focus' );})});</script>\n")
		exit(0)
	}
	if rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('short'))) {
		rt.echo_val(var_id)
	} else {
		mut var_type := rt.get_superglobal('_REQUEST').array_get(rt.new_string('type'))
		rt.echo_val(rt.call_function('apply_filters', [
			rt.new_string('async_upload_${var_type.to_string()}'),
			var_id.clone(),
		]))
	}
}
