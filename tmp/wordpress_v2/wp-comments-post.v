import rt

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('POST'),
		rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_METHOD'))))))
	{
		mut var_protocol :=
			rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_PROTOCOL'))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_protocol.clone(),
			rt.create_array([
				rt.ArrayItem{ key: none, val: 'HTTP/1.1' },
				rt.ArrayItem{ key: none, val: 'HTTP/2' },
				rt.ArrayItem{ key: none, val: 'HTTP/2.0' },
				rt.ArrayItem{ key: none, val: 'HTTP/3' },
			]),
			rt.new_bool(true)])))))
		{
			var_protocol = rt.new_string('HTTP/1.0')
		}
		rt.call_function('header', [rt.new_string('Allow: POST')])
		rt.call_function('header', [
			rt.new_string('${var_protocol.to_string()} 405 Method Not Allowed'),
		])
		rt.call_function('header', [rt.new_string('Content-Type: text/plain')])
		exit(0)
	}
	rt.include_file(@DIR + '/wp-load.php', '3')
	rt.call_function('nocache_headers', []rt.PhpVal{})
	mut var_comment := rt.call_function('wp_handle_comment_submission', [
		rt.call_function('wp_unslash', [rt.get_superglobal('_POST').clone()]),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_comment.clone()])) {
		mut var_data :=
			rt.new_int((rt.call_method(var_comment, 'get_error_data', []rt.PhpVal{})).to_i64())
		if !(!rt.is_true(var_data)) {
			rt.call_function('wp_die', [
				rt.new_string('<p>' +
					(rt.call_method(var_comment, 'get_error_message', []rt.PhpVal{})).str() + '</p>'),
				rt.call_function('__', [rt.new_string('Comment Submission Failure')]),
				rt.create_array([rt.ArrayItem{ key: 'response', val: var_data },
					rt.ArrayItem{ key: 'back_link', val: true }]),
			])
		} else {
			exit(0)
		}
	}
	mut var_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
	mut var_cookies_consent :=
		rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('wp-comment-cookies-consent')))
	rt.call_function('do_action', [rt.new_string('set_comment_cookies'),
		var_comment.clone(), var_user.clone(), var_cookies_consent.clone()])
	mut var_location := if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('redirect_to'))) {
		rt.call_function('get_comment_link', [var_comment.clone()])
	} else {
		(rt.get_superglobal('_POST').array_get(rt.new_string('redirect_to'))).str() + '#comment-' +
			(rt.get_property(var_comment, 'comment_ID')).str()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_cookies_consent))))
		&& rt.is_true(rt.identical(rt.new_string('unapproved'), rt.call_function('wp_get_comment_status', [var_comment.clone()])))
		&& !(!rt.is_true(rt.get_property(var_comment, 'comment_author_email'))) {
		var_location = rt.call_function('add_query_arg', [
			rt.create_array([
				rt.ArrayItem{ key: 'unapproved', val: rt.get_property(var_comment, 'comment_ID') },
				rt.ArrayItem{ key: 'moderation-hash', val: rt.call_function('wp_hash', [
					rt.get_property(var_comment, 'comment_date_gmt'),
				]) },
			]),
			var_location.clone(),
		])
	}
	var_location = rt.call_function('apply_filters', [
		rt.new_string('comment_post_redirect'),
		var_location.clone(),
		var_comment.clone(),
	])
	rt.call_function('wp_safe_redirect', [var_location.clone()])
	exit(0)
}
