import rt


fn main() {
	defer {
		rt.shutdown()
	}

	mut var_action := rt.new_null()
	if !(rt.get_superglobal('_GET').array_isset(rt.new_string('inline'))) {
		rt.call_function('define', [rt.new_string('IFRAME_REQUEST'), rt.new_bool(true)])
	}
	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('upload_files')]))))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to upload files.')]), rt.new_int(403)])
	}
	rt.call_function('wp_enqueue_script', [rt.new_string('plupload-handlers')])
	rt.call_function('wp_enqueue_script', [rt.new_string('image-edit')])
	rt.call_function('wp_enqueue_script', [rt.new_string('set-post-thumbnail')])
	rt.call_function('wp_enqueue_style', [rt.new_string('imgareaselect')])
	rt.call_function('wp_enqueue_script', [rt.new_string('media-gallery')])
	rt.call_function('header', [rt.new_string('Content-Type: ' + (rt.call_function('get_option', [rt.new_string('html_type')])).str() + '; charset=' + (rt.call_function('get_option', [rt.new_string('blog_charset')])).str())])
	mut var_ID := rt.new_int(if !(var_ID).is_null() { rt.new_int((var_ID).to_i64()) } else { 0 })
	mut var_post_id := rt.new_int(if !(var_post_id).is_null() { rt.new_int((var_post_id).to_i64()) } else { 0 })
	if !(var_action).is_null() && rt.is_true(rt.identical(rt.new_string('edit'), var_action)) && rt.is_true(rt.new_bool(!(rt.is_true(var_ID)))) {
		rt.call_function('wp_die', [rt.new_string('<h1>' + (rt.call_function('__', [rt.new_string('An error occurred during the upload process.')])).str() + '</h1>' + '<p>' + (rt.call_function('__', [rt.new_string('Invalid item ID. You can view all media items in the <a href="upload.php">Media Library</a>.')])).str() + '</p>'), rt.new_int(403)])
	}
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_id')))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_id'))]))))) {
		rt.call_function('wp_die', [rt.new_string('<h1>' + (rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() + '</h1>' + '<p>' + (rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this item.')])).str() + '</p>'), rt.new_int(403)])
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('type')) {
	mut var_type := rt.new_string((rt.get_superglobal('_GET').array_get(rt.new_string('type'))).str())
	} else {
	var_type = rt.call_function('apply_filters', [rt.new_string('media_upload_default_type'), rt.new_string('file')])
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('tab')) {
	mut var_tab := rt.new_string((rt.get_superglobal('_GET').array_get(rt.new_string('tab'))).str())
	} else {
	var_tab = rt.call_function('apply_filters', [rt.new_string('media_upload_default_tab'), rt.new_string('type')])
	}
	mut var_body_id := 'media-upload'
	if rt.is_true(rt.identical(rt.new_string('type'), var_tab)) || rt.is_true(rt.identical(rt.new_string('type_url'), var_tab)) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.call_function('media_upload_tabs', []rt.PhpVal{}).array_isset(var_tab.clone())))))) {
		rt.call_function('do_action', [rt.new_string("media_upload_${var_type.to_string()}")])
	} else {
		rt.call_function('do_action', [rt.new_string("media_upload_${var_tab.to_string()}")])
	}
}
