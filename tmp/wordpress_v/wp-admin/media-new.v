import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var__FILES := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
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
	rt.call_function('wp_enqueue_script', [rt.new_string('plupload-handlers')])
	mut var_post_id := rt.new_int(rt.new_int(0))
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('post_id')) {
		var_post_id = rt.call_function('absint',
			[rt.get_superglobal('_REQUEST').array_get('post_id')])
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_post', [var_post_id.dup()])))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), var_post_id.dup()])))))))
		{
			var_post_id = rt.new_int(rt.new_int(0))
		}
	}
	if rt.is_true(rt.get_superglobal('_POST')) {
		if rt.get_superglobal('_POST').array_isset(rt.new_string('html-upload'))
			&& !(!rt.is_true(var__FILES)) {
			rt.call_function('check_admin_referer', [rt.new_string('media-form')])
			mut var_upload_id := rt.call_function('media_handle_upload', [
				rt.new_string('async-upload'),
				var_post_id.dup(),
			])
			if rt.is_true(rt.call_function('is_wp_error', [var_upload_id.dup()])) {
				rt.call_function('wp_die', [var_upload_id.dup()])
			}
		}
		rt.call_function('wp_redirect', [
			rt.call_function('admin_url', [rt.new_string('upload.php')]),
		])
		// unsupported expression: Expr_Exit
	}
	mut var_title := rt.call_function('__', [rt.new_string('Upload Media')])
	mut var_parent_file := 'upload.php'
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('You can upload media files here without creating a post first. This allows you to upload files to use with posts and pages later and/or to get a web link for a particular file that you can share. There are three options for uploading files:')])).str() +
				'</p>' + '<ul>' + '<li>' +
				(rt.call_function('__', [rt.new_string('<strong>Drag and drop</strong> your files into the area below. Multiple files are allowed.')])).str() +
				'</li>' + '<li>' +
				(rt.call_function('__', [rt.new_string('Clicking <strong>Select Files</strong> opens a navigation window showing you files in your operating system. Selecting <strong>Open</strong> after clicking on the file you want activates a progress bar on the uploader screen.')])).str() +
				'</li>' + '<li>' +
				(rt.call_function('__', [rt.new_string('Revert to the <strong>Browser Uploader</strong> by clicking the link below the drag and drop box.')])).str() +
				'</li>' + '</ul>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		'<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/media-add-new-screen/">Documentation on Uploading Media Files</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>',
	])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	mut var_form_class := 'wp-upload-form media-upload-form type-form validate'
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_function('get_user_setting', [rt.new_string('uploader')]))
		|| rt.get_superglobal('_GET').array_isset(rt.new_string('browser-uploader'))))
	{
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [rt.new_string('media-new.php')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_form_class).dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('media_upload_form', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [var_post_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [var_post_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('media-form')])
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
