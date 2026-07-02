import rt

fn trackback_response(error i64, error_message string) {
	mut var_error := error
	mut var_error_message := error_message
	rt.call_function('header', [
		rt.new_string('Content-Type: text/xml; charset=' +
			(rt.call_function('get_option', [rt.new_string('blog_charset')])).str()),
	])
	if var_error != 0 {
		print('<?xml version="1.0" encoding="utf-8"?' + '>\n')
		print('<response>\n')
		print('<error>1</error>\n')
		print('<message>${var_error_message}</message>\n')
		print('</response>')
		exit(0)
	} else {
		print('<?xml version="1.0" encoding="utf-8"?' + '>\n')
		print('<response>\n')
		print('<error>0</error>\n')
		print('</response>')
	}
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_wp := rt.new_null()
	mut var_posts := rt.new_null()
	mut var_wpdb := rt.new_null()
	if !rt.is_true(var_wp) {
		rt.include_file(@DIR + '/wp-load.php', '4')
		rt.call_function('wp', [rt.create_array([rt.ArrayItem{ key: 'tb', val: '1' }])])
	}
	rt.call_function('wp_set_current_user', [rt.new_int(0)])
	if !(rt.get_superglobal('_GET').array_isset(rt.new_string('tb_id')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('tb_id')))))) {
		mut var_post_id := rt.call_function('explode', [rt.new_string('/'),
			rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))])
		var_post_id =
			rt.new_int((var_post_id.array_get(rt.new_int(var_post_id.clone().array_count() - 1))).to_i64())
	}
	mut var_trackback_url := if rt.get_superglobal('_POST').array_isset(rt.new_string('url')) { rt.call_function('sanitize_url', [
			rt.get_superglobal('_POST').array_get(rt.new_string('url')),
		]) } else { rt.new_string('') }
	mut var_charset := if rt.get_superglobal('_POST').array_isset(rt.new_string('charset')) { rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_POST').array_get(rt.new_string('charset')),
		]) } else { rt.new_string('') }
	mut var_title := if rt.get_superglobal('_POST').array_isset(rt.new_string('title')) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('title'))]),
		]) } else { rt.new_string('') }
	mut var_excerpt := if rt.get_superglobal('_POST').array_isset(rt.new_string('excerpt')) { rt.call_function('sanitize_textarea_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('excerpt'))]),
		]) } else { rt.new_string('') }
	mut var_blog_name := if rt.get_superglobal('_POST').array_isset(rt.new_string('blog_name')) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('blog_name'))]),
		]) } else { rt.new_string('') }
	if rt.is_true(var_charset) {
		var_charset = rt.call_function('str_replace', [
			rt.create_array([rt.ArrayItem{ key: none, val: ',' },
				rt.ArrayItem{ key: none, val: ' ' }]),
			rt.new_string(''),
			rt.new_string(var_charset.clone().to_string().trim_space().to_upper()),
		])
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('mb_list_encodings')]))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_charset.clone(), rt.call_function('mb_list_encodings', []rt.PhpVal{}), rt.new_bool(true)]))))) {
			var_charset = rt.new_string('')
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_charset)))) {
		var_charset = rt.new_string('ASCII, UTF-8, ISO-8859-1, JIS, EUC-JP, SJIS')
	}
	if rt.is_true(rt.call_function('str_contains', [var_charset.clone(),
		rt.new_string('UTF-7')]))
	{
		exit(0)
	}
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('mb_convert_encoding'),
	]))
	{
		var_title = rt.call_function('mb_convert_encoding', [
			var_title.clone(), rt.call_function('get_option', [
				rt.new_string('blog_charset'),
			]),
			var_charset.clone()])
		var_excerpt = rt.call_function('mb_convert_encoding', [
			var_excerpt.clone(), rt.call_function('get_option', [
				rt.new_string('blog_charset'),
			]),
			var_charset.clone()])
		var_blog_name = rt.call_function('mb_convert_encoding', [
			var_blog_name.clone(), rt.call_function('get_option', [
				rt.new_string('blog_charset'),
			]),
			var_charset.clone()])
	}
	var_title = rt.call_function('wp_slash', [var_title.clone()])
	var_excerpt = rt.call_function('wp_slash', [var_excerpt.clone()])
	var_blog_name = rt.call_function('wp_slash', [var_blog_name.clone()])
	if rt.is_true(rt.call_function('is_single', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('is_page', []rt.PhpVal{})) {
		var_post_id = rt.get_property(var_posts.array_get(rt.new_int(0)), 'ID')
	}
	if !(!var_post_id.is_null())
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(var_post_id.to_i64()))))) {
		trackback_response(1, rt.call_function('__', [
			rt.new_string('I really need an ID for this to work.'),
		]))
	}
	if !rt.is_true(var_title) && !rt.is_true(var_trackback_url) && !rt.is_true(var_blog_name) {
		rt.call_function('wp_redirect', [
			rt.call_function('get_permalink', [var_post_id.clone()]),
		])
		exit(0)
	}
	if !(!rt.is_true(var_trackback_url)) && !(!rt.is_true(var_title)) {
		rt.call_function('do_action', [rt.new_string('pre_trackback_post'),
			var_post_id.clone(), var_trackback_url.clone(), var_charset.clone(),
			var_title.clone(), var_excerpt.clone(), var_blog_name.clone()])
		rt.call_function('header', [
			rt.new_string('Content-Type: text/xml; charset=' +
				(rt.call_function('get_option', [rt.new_string('blog_charset')])).str()),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('pings_open', [
			var_post_id.clone(),
		])))))
		{
			trackback_response(1, rt.call_function('__', [
				rt.new_string('Sorry, trackbacks are closed for this item.'),
			]))
		}
		var_title = rt.call_function('wp_html_excerpt', [var_title.clone(),
			rt.new_int(250), rt.new_string('&#8230;')])
		var_excerpt = rt.call_function('wp_html_excerpt', [var_excerpt.clone(),
			rt.new_int(252), rt.new_string('&#8230;')])
		mut var_comment_post_id := rt.new_int(var_post_id.to_i64())
		mut var_comment_author := var_blog_name.clone()
		mut var_comment_author_email := ''
		mut var_comment_author_url := var_trackback_url.clone()
		mut var_comment_content := '<strong>${var_title.to_string()}</strong>\n\n${var_excerpt.to_string()}'
		mut var_comment_type := 'trackback'
		mut var_dupe := rt.call_method(var_wpdb, 'get_results', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
					'comments')),
					rt.new_string(' WHERE comment_post_ID = %d AND comment_author_url = %s')),
				var_comment_post_id.clone(),
				var_comment_author_url.clone(),
			]),
		])
		if rt.is_true(var_dupe) {
			trackback_response(1, rt.call_function('__', [
				rt.new_string('There is already a ping from that URL for this post.'),
			]))
		}
		mut var_commentdata := {
			'comment_post_ID': var_comment_post_id
		}
		var_commentdata = rt.add(var_commentdata, rt.call_function('compact', [
			rt.new_string('comment_author'),
			rt.new_string('comment_author_email'),
			rt.new_string('comment_author_url'),
			rt.new_string('comment_content'),
			rt.new_string('comment_type'),
		]))
		mut var_result := rt.call_function('wp_new_comment', [
			rt.create_array_from_native_map(var_commentdata),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
			trackback_response(1, rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}))
		}
		mut var_trackback_id := rt.get_property(var_wpdb, 'insert_id')
		rt.call_function('do_action', [rt.new_string('trackback_post'),
			var_trackback_id.clone()])
		trackback_response(0, '')
	}
}
