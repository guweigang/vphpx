import rt


fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_protocol := rt.get_superglobal('_SERVER').array_get('SERVER_PROTOCOL')
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_protocol.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'HTTP/1.1' }, rt.ArrayItem{ key: none, val: 'HTTP/2' }, rt.ArrayItem{ key: none, val: 'HTTP/2.0' }, rt.ArrayItem{ key: none, val: 'HTTP/3' }]), rt.new_bool(true)]))))) {
			var_protocol = rt.new_string(rt.new_string('HTTP/1.0'))
		}
		rt.call_function('header', [rt.new_string('Allow: POST')])
		rt.call_function('header', [rt.new_string("${var_protocol.to_string()} 405 Method Not Allowed")])
		rt.call_function('header', [rt.new_string('Content-Type: text/plain')])
		// unsupported expression: Expr_Exit
	}
	rt.include_file(@DIR + '/wp-load.php', '3')
	rt.call_function('nocache_headers', []rt.PhpVal{})
	mut var_comment := rt.call_function('wp_handle_comment_submission', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').dup()])])
	if rt.is_true(rt.call_function('is_wp_error', [var_comment.dup()])) {
		mut var_data := // unsupported expression: Expr_Cast_Int
		if !(!rt.is_true(var_data)) {
			rt.call_function('wp_die', ['<p>' + (rt.call_method(var_comment, 'get_error_message', []rt.PhpVal{})).str() + '</p>', rt.call_function('__', [rt.new_string('Comment Submission Failure')]), rt.create_array([rt.ArrayItem{ key: 'response', val: var_data }, rt.ArrayItem{ key: 'back_link', val: true }])])
		} else {
			// unsupported expression: Expr_Exit
		}
	}
	mut var_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
	mut var_cookies_consent := rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('wp-comment-cookies-consent')))
	rt.call_function('do_action', [rt.new_string('set_comment_cookies'), var_comment.dup(), var_user.dup(), var_cookies_consent.dup()])
	mut var_location := if !rt.is_true(rt.get_superglobal('_POST').array_get('redirect_to')) { rt.call_function('get_comment_link', [var_comment.dup()]) } else { (rt.get_superglobal('_POST').array_get('redirect_to')).str() + '#comment-' + (rt.get_property(var_comment, 'comment_ID')).str() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_cookies_consent)))) && rt.is_true(rt.identical(rt.new_string('unapproved'), rt.call_function('wp_get_comment_status', [var_comment.dup()]))))) && !(!rt.is_true(rt.get_property(var_comment, 'comment_author_email'))))) {
		var_location = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'unapproved', val: rt.get_property(var_comment, 'comment_ID') }, rt.ArrayItem{ key: 'moderation-hash', val: rt.call_function('wp_hash', [rt.get_property(var_comment, 'comment_date_gmt')]) }]), var_location.dup()])
	}
	var_location = rt.call_function('apply_filters', [rt.new_string('comment_post_redirect'), var_location.dup(), var_comment.dup()])
	rt.call_function('wp_safe_redirect', [var_location.dup()])
	// unsupported expression: Expr_Exit
}
