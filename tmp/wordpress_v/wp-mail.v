import rt

struct Class_POP3 {
	rt.PhpObjectBase
}

struct Class_WP_User {
	rt.PhpObjectBase
}

fn create_pop3() &Class_POP3 {
	mut obj := &Class_POP3{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_user() &Class_WP_User {
	mut obj := &Class_WP_User{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_POP3) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_POP3) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_POP3) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_User) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_User) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_User) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	mut var_matches := []rt.PhpVal{}
	mut var_delim := []rt.PhpVal{}
	rt.include_file(@DIR + '/wp-load.php', '3')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('enable_post_by_email_configuration'), rt.new_bool(true)]))))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('This action has been disabled by the administrator.')]), rt.new_int(403)])
	}
	mut var_mailserver_url := rt.call_function('get_option', [rt.new_string('mailserver_url')])
	if rt.is_true(rt.new_bool(!rt.is_true(var_mailserver_url) || rt.is_true(rt.identical(rt.new_string('mail.example.com'), var_mailserver_url)))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('This action has been disabled by the administrator.')]), rt.new_int(403)])
	}
	rt.call_function('do_action', [rt.new_string('wp-mail.php')])
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-pop3.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_MAIL_INTERVAL')]))))) {
		rt.call_function('define', [rt.new_string('WP_MAIL_INTERVAL'), rt.mul(rt.new_int(5), rt.get_constant('MINUTE_IN_SECONDS'))])
	}
	mut var_last_checked := rt.call_function('get_transient', [rt.new_string('mailserver_last_checked')])
	if rt.is_true(var_last_checked) {
		rt.call_function('wp_die', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Email checks are rate limited to once every %s.')]), rt.call_function('human_time_diff', [rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.get_constant('WP_MAIL_INTERVAL')), rt.call_function('time', []rt.PhpVal{})])]), rt.call_function('__', [rt.new_string('Slow down, no need to check for new mails so often!')]), rt.new_int(429)])
	}
	rt.call_function('set_transient', [rt.new_string('mailserver_last_checked'), rt.new_bool(true), rt.get_constant('WP_MAIL_INTERVAL')])
	mut var_time_difference := // unsupported expression: Expr_Cast_Int
	mut var_phone_delim := '::'
	mut var_pop3 := create_pop3()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_pop3.connect(rt.call_function('get_option', [rt.new_string('mailserver_url')]), rt.call_function('get_option', [rt.new_string('mailserver_port')])))))) || rt.is_true(rt.new_bool(!(rt.is_true(var_pop3.user(rt.call_function('get_option', [rt.new_string('mailserver_login')])))))))) {
		rt.call_function('wp_die', [rt.call_function('esc_html', [rt.get_property(var_pop3, 'ERROR')])])
	}
	mut var_count := var_pop3.pass(rt.call_function('get_option', [rt.new_string('mailserver_pass')]))
	if rt.is_true(rt.identical(rt.new_bool(false), var_count)) {
		rt.call_function('wp_die', [rt.call_function('esc_html', [rt.get_property(var_pop3, 'ERROR')])])
	}
	if rt.is_true(rt.identical(rt.new_int(0), var_count)) {
		var_pop3.quit()
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('There does not seem to be any new mail.')])])
	}
	rt.call_function('wp_set_current_user', [rt.new_int(0)])
	{
		mut var_i := 1
		for {
			if !(rt.is_true(rt.less_equal(rt.new_int(var_i), var_count))) { break }
			mut var_message := var_pop3.get(rt.new_int(var_i))
			mut var_bodysignal := false
			mut var_boundary := rt.new_string(rt.new_string(''))
			mut var_charset := rt.new_string(rt.new_string(''))
			mut var_content := rt.new_string(rt.new_string(''))
			mut var_content_type := rt.new_string(rt.new_string(''))
			mut var_content_transfer_encoding := rt.new_string(rt.new_string(''))
			mut var_post_author := rt.new_int(rt.new_int(1))
			mut var_author_found := false
			mut var_post_date := rt.new_null()
			mut var_post_date_gmt := rt.new_null()
			{
				mut iter_1 := var_message.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_line := item_1.val
					if var_line.dup().to_string().len < 3 {
						var_bodysignal = true
					}
					if var_bodysignal {
						// unsupported expression: Expr_AssignOp_Concat
					} else {
						if rt.is_true(rt.call_function('preg_match', [rt.new_string('/Content-Type: /i'), var_line.dup()])) {
							var_content_type = rt.new_string(rt.new_string(var_line.dup().to_string().trim_space()))
							var_content_type = rt.call_function('substr', [var_content_type.dup(), rt.new_int(14), var_content_type.dup().to_string().len - 14])
							var_content_type = rt.call_function('explode', [rt.new_string(';'), var_content_type.dup()])
							if !(!rt.is_true(var_content_type.array_get(1))) {
								var_charset = rt.call_function('explode', [rt.new_string('='), var_content_type.array_get(1)])
								var_charset = rt.new_string(if !(!rt.is_true(var_charset.array_get(1))) { rt.new_string(var_charset.array_get(1).to_string().trim_space()) } else { rt.new_string('') })
							}
							var_content_type = var_content_type.array_get(0)
						}
						if rt.is_true(rt.call_function('preg_match', [rt.new_string('/Content-Transfer-Encoding: /i'), var_line.dup()])) {
							var_content_transfer_encoding = rt.new_string(rt.new_string(var_line.dup().to_string().trim_space()))
							var_content_transfer_encoding = rt.call_function('substr', [var_content_transfer_encoding.dup(), rt.new_int(27), var_content_transfer_encoding.dup().to_string().len - 27])
							var_content_transfer_encoding = rt.call_function('explode', [rt.new_string(';'), var_content_transfer_encoding.dup()])
							var_content_transfer_encoding = var_content_transfer_encoding.array_get(0)
						}
						if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('multipart/alternative'), var_content_type)) && rt.is_true(rt.call_function('str_contains', [var_line.dup(), rt.new_string('boundary="')])))) && rt.is_true(rt.identical(rt.new_string(''), var_boundary)))) {
							var_boundary = rt.new_string(rt.new_string(var_line.dup().to_string().trim_space()))
							var_boundary = rt.call_function('explode', [rt.new_string('"'), var_boundary.dup()])
							var_boundary = var_boundary.array_get(1)
						}
						if rt.is_true(rt.call_function('preg_match', [rt.new_string('/Subject: /i'), var_line.dup()])) {
							mut var_subject := rt.new_string(rt.new_string(var_line.dup().to_string().trim_space()))
							var_subject = rt.call_function('substr', [var_subject.dup(), rt.new_int(9), var_subject.dup().to_string().len - 9])
							if rt.is_true(rt.call_function('function_exists', [rt.new_string('iconv_mime_decode')])) {
								var_subject = rt.call_function('iconv_mime_decode', [var_subject.dup(), rt.new_int(2), rt.call_function('get_option', [rt.new_string('blog_charset')])])
							} else {
								var_subject = rt.call_function('wp_iso_descrambler', [var_subject.dup()])
							}
							var_subject = rt.call_function('explode', [rt.new_string(var_phone_delim).dup(), var_subject.dup()])
							var_subject = var_subject.array_get(0)
						}
						if rt.is_true(rt.new_bool(!(var_author_found) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/^(From|Reply-To): /'), var_line.dup()])))) {
							if rt.is_true(rt.call_function('preg_match', [rt.new_string('|[a-z0-9_.-]+@[a-z0-9_.-]+(?!.*<)|i'), var_line.dup(), var_matches.dup()])) {
								mut var_author := var_matches.array_get(0)
							} else {
								var_author = rt.new_string(rt.new_string(var_line.dup().to_string().trim_space()))
							}
							var_author = rt.call_function('sanitize_email', [var_author.dup()])
							if rt.is_true(rt.call_function('is_email', [var_author.dup()])) {
								mut var_userdata := rt.call_function('get_user_by', [rt.new_string('email'), var_author.dup()])
								if !(!rt.is_true(var_userdata)) {
									var_post_author = rt.get_property(var_userdata, 'ID')
									var_author_found = true
								}
							}
						}
						if rt.is_true(rt.call_function('preg_match', [rt.new_string('/Date: /i'), var_line.dup()])) {
							mut var_ddate := rt.call_function('str_replace', [rt.new_string('Date: '), rt.new_string(''), rt.new_string(var_line.dup().to_string().trim_space())])
							var_ddate = rt.call_function('preg_replace', [rt.new_string('!\\s*\\(.+\\)\\s*$!'), rt.new_string(''), var_ddate.dup()])
							mut var_ddate_timestamp := rt.call_function('strtotime', [var_ddate.dup()])
							var_post_date = rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.add(var_ddate_timestamp, var_time_difference)])
							var_post_date_gmt = rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), var_ddate_timestamp.dup()])
						}
					}
				}
			}
			if var_author_found {
				mut var_user := create_wp_user(var_post_author.dup())
				mut var_post_status := if rt.is_true(var_user.has_cap(rt.new_string('publish_posts'))) { 'publish' } else { 'pending' }
			} else {
				var_post_status = 'pending'
			}
			mut var_subject := rt.new_string(rt.new_string(var_subject.dup().to_string().trim_space()))
			if rt.is_true(rt.identical(rt.new_string('multipart/alternative'), var_content_type)) {
				var_content = rt.call_function('explode', ['--' + (var_boundary).str(), var_content.dup()])
				var_content = var_content.array_get(2)
				if rt.is_true(rt.call_function('preg_match', [rt.new_string('/Content-Transfer-Encoding: quoted-printable/i'), var_content.dup(), var_delim.dup()])) {
					var_content = rt.call_function('explode', [var_delim.array_get(0), var_content.dup()])
					var_content = var_content.array_get(1)
				}
				var_content = rt.call_function('strip_tags', [var_content.dup(), rt.new_string('<img><p><br><i><b><u><em><strong><strike><font><span><div>')])
			}
			var_content = rt.new_string(rt.new_string(var_content.dup().to_string().trim_space()))
			var_content = rt.call_function('apply_filters', [rt.new_string('wp_mail_original_content'), var_content.dup()])
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				var_content = rt.call_function('quoted_printable_decode', [var_content.dup()])
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('function_exists', [rt.new_string('iconv')])) && !(!rt.is_true(var_charset)))) {
				var_content = rt.call_function('iconv', [var_charset.dup(), rt.call_function('get_option', [rt.new_string('blog_charset')]), var_content.dup()])
			}
			var_content = rt.call_function('explode', [rt.new_string(var_phone_delim).dup(), var_content.dup()])
			var_content = if !rt.is_true(var_content.array_get(1)) { var_content.array_get(0) } else { var_content.array_get(1) }
			var_content = rt.new_string(rt.new_string(var_content.dup().to_string().trim_space()))
			mut var_post_content := rt.call_function('apply_filters', [rt.new_string('phone_content'), var_content.dup()])
			mut var_post_title := rt.call_function('xmlrpc_getposttitle', [var_content.dup()])
			if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_post_title.dup().to_string().trim_space()))) {
				var_post_title = var_subject.dup()
			}
			mut var_post_category := [rt.call_function('get_option', [rt.new_string('default_email_category')])]
			mut var_post_data := rt.call_function('compact', [rt.new_string('post_content'), rt.new_string('post_title'), rt.new_string('post_date'), rt.new_string('post_date_gmt'), rt.new_string('post_author'), rt.new_string('post_category'), rt.new_string('post_status')])
			var_post_data = rt.call_function('wp_slash', [var_post_data.dup()])
			mut var_post_ID := rt.call_function('wp_insert_post', [var_post_data.dup()])
			if rt.is_true(rt.call_function('is_wp_error', [var_post_ID.dup()])) {
				print('\n' + (rt.call_method(var_post_ID, 'get_error_message', []rt.PhpVal{})).str())
			}
			if !rt.is_true(var_post_ID) {
				continue
			}
			rt.call_function('do_action', [rt.new_string('publish_phone'), var_post_ID.dup()])
			print('\n<p><strong>' + (rt.call_function('__', [rt.new_string('Author:')])).str() + '</strong> ' + (rt.call_function('esc_html', [var_post_author.dup()])).str() + '</p>')
			print('\n<p><strong>' + (rt.call_function('__', [rt.new_string('Posted title:')])).str() + '</strong> ' + (rt.call_function('esc_html', [var_post_title.dup()])).str() + '</p>')
			if rt.is_true(rt.new_bool(!(rt.is_true(var_pop3.delete(rt.new_int(var_i)))))) {
				print('<p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Oops: %s')]), rt.call_function('esc_html', [rt.get_property(var_pop3, 'ERROR')])])).str() + '</p>')
				var_pop3.reset()
				// unsupported expression: Expr_Exit
			} else {
				print('<p>' + (rt.call_function('sprintf', [, ])).str() + '</p>')
			}
			var_i += 1
		}
	}
	var_pop3.quit()
}
