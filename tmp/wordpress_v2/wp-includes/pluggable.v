import rt
import crypto.md5
import crypto.sha1

fn wp_set_current_user(id i64, name string) rt.PhpVal {
	mut var_id := id
	mut var_name := name
	mut var_current_user := rt.new_null()
	if !var_current_user.is_null() && true
		&& rt.is_true(rt.identical(id, rt.get_property(var_current_user, 'ID')))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.new_int(id))))) {
		return mut var_current_user
	}
	var_current_user = create_wp_user(rt.new_int(id), rt.new_string(name))
	rt.call_function('setup_userdata', [rt.get_property(var_current_user, 'ID')])
	rt.call_function('do_action', [rt.new_string('set_current_user')])
	return mut var_current_user
}

fn wp_get_current_user() rt.PhpVal {
	return rt.call_function('_wp_get_current_user', []rt.PhpVal{})
}

fn get_userdata(var_user_id rt.PhpVal) rt.PhpVal {
	return rt.new_bool(get_user_by('id', var_user_id.clone()))
}

fn get_user_by(field string, var_value rt.PhpVal) bool {
	mut var_field := field
	mut var_userdata := rt.new_null()
	mut var_user := rt.new_null()
	mut iife_temp_0 := Class_WP_User{}
	mut iife_result_0 := iife_temp_0.get_data_by(rt.new_string(field), var_value.clone())
	var_userdata = iife_result_0
	if rt.is_true(rt.new_bool(!(rt.is_true(var_userdata)))) {
		return false
	}
	var_user = create_wp_user()
	rt.call_method(var_user, 'init', [var_userdata.clone()])
	return var_user.to_bool()
}

fn cache_users(var_user_ids rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_clean := rt.new_null()
	mut var_list := rt.new_null()
	mut var_users := rt.new_null()
	mut var_user := rt.new_null()
	rt.call_function('update_meta_cache', [rt.new_string('user'),
		var_user_ids.clone()])
	var_clean = rt.call_function('_get_non_cached_ids', [var_user_ids.clone(),
		rt.new_string('users')])
	if !rt.is_true(var_clean) {
		return
	}
	var_list = rt.call_function('implode', [rt.new_string(','),
		var_clean.clone()])
	var_users = rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
			'users')), rt.new_string(' WHERE ID IN (')), var_list), rt.new_string(')')),
	])
	mut iter_1 := var_users.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_user_shadow := item_1.val
		rt.call_function('update_user_caches', [var_user_shadow.clone()])
	}
}

fn wp_mail(var_to_arg rt.PhpVal, var_subject_arg rt.PhpVal, var_message_arg rt.PhpVal, headers string, var_attachments_arg rt.PhpVal, var_embeds_arg rt.PhpVal) bool {
	mut var_headers := headers
	mut var_to := var_to_arg
	mut var_subject := var_subject_arg
	mut var_message := var_message_arg
	mut var_attachments := var_attachments_arg
	mut var_embeds := var_embeds_arg
	mut var_type := rt.new_null()
	mut var_charset_content := rt.new_null()
	mut var_matches := []rt.PhpVal{}
	mut var_atts := rt.new_null()
	mut var_pre_wp_mail := rt.new_null()
	mut var_phpmailer := rt.new_null()
	mut var_cc := rt.new_null()
	mut var_bcc := rt.new_null()
	mut var_reply_to := rt.new_null()
	mut var_tempheaders := rt.new_null()
	mut var_header := rt.new_null()
	mut var_parts := rt.new_null()
	mut var_boundary := ''
	mut var_name := ''
	mut var_content := ''
	mut var_bracket_pos := rt.new_null()
	mut var_from_name := rt.new_null()
	mut var_from_email := rt.new_null()
	mut var_content_type := rt.new_null()
	mut var_charset := rt.new_null()
	mut var_sitename := rt.new_null()
	mut var_e := rt.new_null()
	mut var_mail_error_data := rt.new_null()
	mut var_address_headers := rt.new_null()
	mut var_addresses := rt.new_null()
	mut var_address_header := rt.new_null()
	mut var_address := rt.new_null()
	mut var_recipient_name := rt.new_null()
	mut var_attachment := rt.new_null()
	mut var_filename := rt.new_null()
	mut var_embed_path := rt.new_null()
	mut var_key := rt.new_null()
	mut var_embed_args := rt.new_null()
	mut var_mail_data := rt.new_null()
	mut var_send := rt.new_null()
	var_atts = rt.call_function('apply_filters', [rt.new_string('wp_mail'),
		rt.call_function('compact', [rt.new_string('to'), rt.new_string('subject'),
			rt.new_string('message'), rt.new_string('headers'),
			rt.new_string('attachments'), rt.new_string('embeds')])])
	var_pre_wp_mail = rt.call_function('apply_filters', [rt.new_string('pre_wp_mail'),
		rt.new_null(), var_atts.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_pre_wp_mail)))) {
		return var_pre_wp_mail.to_bool()
	}
	if var_atts.array_isset(rt.new_string('to')) {
		var_to = var_atts.array_get(rt.new_string('to'))
	}
	if !(var_to.clone().is_array()) {
		var_to = rt.call_function('explode', [rt.new_string(','),
			var_to.clone()])
	}
	if var_atts.array_isset(rt.new_string('subject')) {
		var_subject = var_atts.array_get(rt.new_string('subject'))
	}
	if var_atts.array_isset(rt.new_string('message')) {
		var_message = var_atts.array_get(rt.new_string('message'))
	}
	if var_atts.array_isset(rt.new_string('headers')) {
		var_headers = (var_atts.array_get(rt.new_string('headers'))).str()
	}
	if var_atts.array_isset(rt.new_string('attachments')) {
		var_attachments = var_atts.array_get(rt.new_string('attachments'))
	}
	if !(var_attachments.clone().is_array()) {
		var_attachments = rt.call_function('explode', [rt.new_string('\n'),
			rt.call_function('str_replace', [rt.new_string('\r\n'),
				rt.new_string('\n'), var_attachments.clone()])])
	}
	if var_atts.array_isset(rt.new_string('embeds')) {
		var_embeds = var_atts.array_get(rt.new_string('embeds'))
	}
	if !(var_embeds.clone().is_array()) {
		var_embeds = rt.call_function('explode', [rt.new_string('\n'),
			rt.call_function('str_replace', [rt.new_string('\r\n'),
				rt.new_string('\n'), var_embeds.clone()])])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('WP_PHPMailer',
		[]string{}, var_phpmailer), 'PHPMailer_PHPMailer_PHPMailer'))))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/PHPMailer/PHPMailer.php',
			'4')
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/PHPMailer/SMTP.php',
			'4')
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/PHPMailer/Exception.php',
			'4')
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-phpmailer.php',
			'4')
		var_phpmailer = create_wp_phpmailer(rt.new_bool(true))
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_email := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return (rt.call_function('is_email', [var_email.clone()])).to_bool()
		}
		rt.set_static_prop('{"nodeType":"Expr_Variable","line":285,"name":"phpmailer"}',
			'validator', rt.new_closure(closure_2_fn))
	}
	var_cc = rt.new_array()
	var_bcc = rt.new_array()
	var_reply_to = rt.new_array()
	if var_headers == '' {
		var_headers = (rt.new_array()).str()
	} else {
		if !(rt.new_string(var_headers.str()).is_array()) {
			var_tempheaders = rt.call_function('explode', [rt.new_string('\n'),
				rt.call_function('str_replace', [rt.new_string('\r\n'),
					rt.new_string('\n'), rt.new_string(var_headers.str())])])
		} else {
			var_tempheaders = rt.new_string(var_headers.str())
		}
		var_headers = (rt.new_array()).str()
		if !(!rt.is_true(var_tempheaders)) {
			mut iter_2 := rt.cast_array(var_tempheaders).iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_header_shadow := item_2.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
					var_header_shadow.clone(),
					rt.new_string(':'),
				])))))
				{
					if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [
						var_header_shadow.clone(),
						rt.new_string('boundary='),
					])))))
					{
						var_parts = rt.call_function('preg_split', [
							rt.new_string('/boundary=/i'),
							rt.new_string(var_header_shadow.clone().to_string().trim_space()),
						])
						var_boundary = rt.call_function('str_replace', [
							rt.create_array([rt.ArrayItem{ key: none, val: "'" },
								rt.ArrayItem{ key: none, val: '"' }]),
							rt.new_string(''),
							var_parts.array_get(rt.new_int(1)),
						]).to_string().trim_space()
					}
					continue
				}
				mut list_tmp_1 := rt.call_function('explode', [
					rt.new_string(':'),
					rt.new_string(var_header_shadow.clone().to_string().trim_space()),
					rt.new_int(2)])
				var_name = list_tmp_1.array_get(0)
				var_content = list_tmp_1.array_get(1)
				var_name = var_name.trim_space()
				var_content = var_content.trim_space()
				mut switch_val_1 := rt.new_string(var_name.to_lower())
				if rt.is_true(rt.equal(switch_val_1, rt.new_string('from'))) {
					var_bracket_pos = rt.call_function('strpos', [
						rt.new_string(var_content.str()).clone(),
						rt.new_string('<')])
					if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false),
						var_bracket_pos))))
					{
						if rt.is_true(rt.greater(var_bracket_pos, rt.new_int(0))) {
							var_from_name = rt.call_function('substr', [
								rt.new_string(var_content.str()).clone(),
								rt.new_int(0), var_bracket_pos.clone()])
							var_from_name = rt.call_function('str_replace', [
								rt.new_string('"'),
								rt.new_string(''),
								var_from_name.clone(),
							])
							var_from_name =
								rt.new_string(var_from_name.clone().to_string().trim_space())
						}
						var_from_email = rt.call_function('substr', [
							rt.new_string(var_content.str()).clone(),
							rt.add(var_bracket_pos, rt.new_int(1))])
						var_from_email = rt.call_function('str_replace', [
							rt.new_string('>'),
							rt.new_string(''),
							var_from_email.clone(),
						])
						var_from_email =
							rt.new_string(var_from_email.clone().to_string().trim_space())
					} else if rt.is_true(rt.new_bool('' != var_content.trim_space())) {
						var_from_email = rt.new_string(var_content.trim_space())
					}
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('content-type'))) {
					if rt.is_true(rt.call_function('str_contains', [
						rt.new_string(var_content.str()).clone(),
						rt.new_string(';')]))
					{
						mut list_tmp_2 := rt.call_function('explode', [
							rt.new_string(';'),
							rt.new_string(var_content.str()).clone(),
						])
						var_type = list_tmp_2.array_get(0)
						var_charset_content = list_tmp_2.array_get(1)
						var_content_type = rt.new_string(var_type.clone().to_string().trim_space())
						if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [
							var_charset_content.clone(),
							rt.new_string('charset='),
						])))))
						{
							var_charset = rt.new_string(rt.call_function('str_replace', [
								rt.create_array([
									rt.ArrayItem{ key: none, val: 'charset=' },
									rt.ArrayItem{ key: none, val: '"' },
								]),
								rt.new_string(''),
								var_charset_content.clone(),
							]).to_string().trim_space())
						} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [
							var_charset_content.clone(),
							rt.new_string('boundary='),
						])))))
						{
							var_boundary = rt.call_function('str_replace', [
								rt.create_array([
									rt.ArrayItem{ key: none, val: 'BOUNDARY=' },
									rt.ArrayItem{ key: none, val: 'boundary=' },
									rt.ArrayItem{ key: none, val: '"' },
								]),
								rt.new_string(''),
								var_charset_content.clone(),
							]).to_string().trim_space()
							var_charset = rt.new_string('')
							if rt.is_true(rt.call_function('preg_match', [
								rt.new_string('~^multipart/(\\S+)~'),
								var_content_type.clone(),
								rt.create_array_from_list(var_matches),
							]))
							{
								var_content_type = rt.new_string('multipart/' +
									var_matches[1].to_string().to_lower() + '; boundary="' +
									var_boundary + '"')
							}
						}
					} else if rt.is_true(rt.new_bool('' != var_content.trim_space())) {
						var_content_type = rt.new_string(var_content.trim_space())
					}
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('cc'))) {
					var_cc = rt.call_function('array_merge', [
						rt.cast_array(var_cc),
						rt.call_function('explode', [
							rt.new_string(','),
							rt.new_string(var_content.str()).clone(),
						])])
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('bcc'))) {
					var_bcc = rt.call_function('array_merge', [
						rt.cast_array(var_bcc),
						rt.call_function('explode', [
							rt.new_string(','),
							rt.new_string(var_content.str()).clone(),
						])])
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('reply-to'))) {
					var_reply_to = rt.call_function('array_merge', [
						rt.cast_array(var_reply_to),
						rt.call_function('explode', [rt.new_string(','),
							rt.new_string(var_content.str()).clone()]),
					])
				} else {
					rt.new_string(var_headers.str()).array_set(var_name.trim_space(),
						var_content.trim_space())
				}
			}
		}
	}
	var_phpmailer.clearallrecipients()
	var_phpmailer.clearattachments()
	var_phpmailer.clearcustomheaders()
	var_phpmailer.clearreplytos()
	rt.set_property(var_phpmailer, 'Body', rt.new_string(''))
	rt.set_property(var_phpmailer, 'AltBody', rt.new_string(''))
	rt.set_property(var_phpmailer, 'Encoding', Class_PHPMailer_PHPMailer_PHPMailer.encoding_8bit())
	if !(!var_from_name.is_null()) {
		var_from_name = rt.new_string('WordPress')
	}
	if !(!var_from_email.is_null()) {
		var_sitename = rt.call_function('wp_parse_url', [
			rt.call_function('network_home_url', []rt.PhpVal{}),
			rt.get_constant('PHP_URL_HOST'),
		])
		var_from_email = rt.new_string('wordpress@')
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_sitename)))) {
			if rt.is_true(rt.call_function('str_starts_with', [
				var_sitename.clone(), rt.new_string('www.')]))
			{
				var_sitename = rt.call_function('substr', [var_sitename.clone(),
					rt.new_int(4)])
			}
			var_from_email = rt.concat(var_from_email, var_sitename)
		}
	}
	var_from_email = rt.call_function('apply_filters', [rt.new_string('wp_mail_from'),
		var_from_email.clone()])
	var_from_name = rt.call_function('apply_filters', [
		rt.new_string('wp_mail_from_name'),
		var_from_name.clone(),
	])
	var_phpmailer.setfrom(var_from_email.clone(), var_from_name.clone(), rt.new_bool(false))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'PHPMailer_PHPMailer_Exception') {
		var_e = var_e_1.clone()
		var_mail_error_data = rt.call_function('compact', [rt.new_string('to'),
			rt.new_string('subject'), rt.new_string('message'),
			rt.new_string('headers'), rt.new_string('attachments')])
		var_mail_error_data.array_set('phpmailer_exception_code', rt.call_method(var_e, 'getCode',
			[]rt.PhpVal{}))
		rt.call_function('do_action', [rt.new_string('wp_mail_failed'),
			create_wp_error(rt.new_string('wp_mail_failed'), rt.call_method(var_e, 'getMessage',
				[]rt.PhpVal{}), var_mail_error_data.clone())])
		return false
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	rt.set_property(var_phpmailer, 'Subject', var_subject.clone())
	rt.set_property(var_phpmailer, 'Body', var_message.clone())
	var_address_headers = rt.call_function('compact', [rt.new_string('to'),
		rt.new_string('cc'), rt.new_string('bcc'), rt.new_string('reply_to')])
	mut iter_3 := var_address_headers.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_addresses_shadow := item_3.val
		mut var_address_header_shadow := item_3.key
		if !rt.is_true(var_addresses_shadow) {
			continue
		}
		mut iter_4 := rt.cast_array(var_addresses_shadow).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_address_shadow := item_4.val
			var_recipient_name = rt.new_string('')
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
			if rt.is_true(rt.call_function('preg_match', [rt.new_string('/(.*)<(.+)>/'),
				var_address_shadow.clone(), rt.create_array_from_list(var_matches)]))
			{
				if var_matches.len == 3 {
					var_recipient_name = var_matches[1]
					if rt.has_exception() {
						unsafe {
							goto catch_label_2
						}
					}
					var_address_shadow = var_matches[2]
					if rt.has_exception() {
						unsafe {
							goto catch_label_2
						}
					}
				}
				if rt.has_exception() {
					unsafe {
						goto catch_label_2
					}
				}
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
			mut switch_val_2 := var_address_header_shadow
			if rt.is_true(rt.equal(switch_val_2, rt.new_string('to'))) {
				var_phpmailer.addaddress(var_address_shadow.clone(), var_recipient_name.clone())
				if rt.has_exception() {
					unsafe {
						goto catch_label_2
					}
				}
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('cc'))) {
				var_phpmailer.addcc(var_address_shadow.clone(), var_recipient_name.clone())
				if rt.has_exception() {
					unsafe {
						goto catch_label_2
					}
				}
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('bcc'))) {
				var_phpmailer.addbcc(var_address_shadow.clone(), var_recipient_name.clone())
				if rt.has_exception() {
					unsafe {
						goto catch_label_2
					}
				}
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('reply_to'))) {
				var_phpmailer.addreplyto(var_address_shadow.clone(), var_recipient_name.clone())
				if rt.has_exception() {
					unsafe {
						goto catch_label_2
					}
				}
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
			unsafe {
				goto end_label_2
			}
			catch_label_2:
			mut var_e_2 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_2, 'PHPMailer_PHPMailer_Exception') {
				var_e = var_e_2.clone()
				continue
				unsafe {
					goto end_label_2
				}
			} else {
				rt.throw_exception(var_e_2)
				unsafe {
					goto end_label_2
				}
			}

			end_label_2:
		}
	}
	var_phpmailer.ismail()
	if !(!var_content_type.is_null()) {
		var_content_type = rt.new_string('text/plain')
	}
	var_content_type = rt.call_function('apply_filters', [
		rt.new_string('wp_mail_content_type'),
		var_content_type.clone(),
	])
	rt.set_property(var_phpmailer, 'ContentType', var_content_type.clone())
	if rt.is_true(rt.identical(rt.new_string('text/html'), var_content_type)) {
		var_phpmailer.ishtml(rt.new_bool(true))
	}
	if !(!var_charset.is_null()) {
		var_charset = rt.call_function('get_bloginfo', [rt.new_string('charset')])
	}
	rt.set_property(var_phpmailer, 'CharSet', rt.call_function('apply_filters', [
		rt.new_string('wp_mail_charset'),
		var_charset.clone(),
	]))
	if !(var_headers == '') {
		mut iter_5 := rt.cast_array(rt.new_string(var_headers.str())).iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_content_shadow := item_5.val
			mut var_name_shadow := item_5.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
				rt.new_string(var_name_shadow.str()),
				rt.create_array([rt.ArrayItem{ key: none, val: 'MIME-Version' },
					rt.ArrayItem{ key: none, val: 'X-Mailer' }]),
				rt.new_bool(true),
			])))))
			{
				var_phpmailer.addcustomheader(rt.call_function('sprintf', [
					rt.new_string('%1$s: %2$s'),
					rt.new_string(var_name_shadow.str()),
					rt.new_string(var_content_shadow.str()),
				]))
				if rt.has_exception() {
					unsafe {
						goto catch_label_3
					}
				}
				unsafe {
					goto end_label_3
				}
				catch_label_3:
				mut var_e_3 := rt.get_and_clear_exception()
				if rt.instance_of(var_e_3, 'PHPMailer_PHPMailer_Exception') {
					var_e = var_e_3.clone()
					continue
					unsafe {
						goto end_label_3
					}
				} else {
					rt.throw_exception(var_e_3)
					unsafe {
						goto end_label_3
					}
				}

				end_label_3:
			}
		}
	}
	if !(!rt.is_true(var_attachments)) {
		mut iter_6 := var_attachments.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_attachment_shadow := item_6.val
			mut var_filename_shadow := item_6.key
			var_filename_shadow = if var_filename_shadow.clone().is_string() {
				var_filename_shadow
			} else {
				rt.new_string('')
			}
			var_phpmailer.addattachment(var_attachment_shadow.clone(), var_filename_shadow.clone())
			if rt.has_exception() {
				unsafe {
					goto catch_label_4
				}
			}
			unsafe {
				goto end_label_4
			}
			catch_label_4:
			mut var_e_4 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_4, 'PHPMailer_PHPMailer_Exception') {
				var_e = var_e_4.clone()
				continue
				unsafe {
					goto end_label_4
				}
			} else {
				rt.throw_exception(var_e_4)
				unsafe {
					goto end_label_4
				}
			}

			end_label_4:
		}
	}
	if !(!rt.is_true(var_embeds)) {
		mut iter_7 := var_embeds.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_embed_path_shadow := item_7.val
			mut var_key_shadow := item_7.key
			var_embed_args = rt.call_function('apply_filters', [
				rt.new_string('wp_mail_embed_args'),
				rt.create_array([rt.ArrayItem{ key: 'path', val: var_embed_path_shadow },
					rt.ArrayItem{ key: 'cid', val: var_key_shadow.str() },
					rt.ArrayItem{ key: 'name', val: rt.call_function('basename', [
						var_embed_path_shadow.clone(),
					]) }, rt.ArrayItem{ key: 'encoding', val: 'base64' },
					rt.ArrayItem{ key: 'type', val: '' }, rt.ArrayItem{
						key: 'disposition'
						val: 'inline'
					}]),
			])
			var_phpmailer.addembeddedimage(var_embed_args.array_get(rt.new_string('path')),
				var_embed_args.array_get(rt.new_string('cid')),
				var_embed_args.array_get(rt.new_string('name')),
				var_embed_args.array_get(rt.new_string('encoding')),
				var_embed_args.array_get(rt.new_string('type')),
				var_embed_args.array_get(rt.new_string('disposition')))
			if rt.has_exception() {
				unsafe {
					goto catch_label_5
				}
			}
			unsafe {
				goto end_label_5
			}
			catch_label_5:
			mut var_e_5 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_5, 'PHPMailer_PHPMailer_Exception') {
				var_e = var_e_5.clone()
				continue
				unsafe {
					goto end_label_5
				}
			} else {
				rt.throw_exception(var_e_5)
				unsafe {
					goto end_label_5
				}
			}

			end_label_5:
		}
	}
	rt.call_function('do_action_ref_array', [rt.new_string('phpmailer_init'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_phpmailer }])])
	var_mail_data = rt.call_function('compact', [rt.new_string('to'),
		rt.new_string('subject'), rt.new_string('message'), rt.new_string('headers'),
		rt.new_string('attachments'), rt.new_string('embeds')])
	var_send = var_phpmailer.send()
	if rt.has_exception() {
		unsafe {
			goto catch_label_6
		}
	}
	rt.call_function('do_action', [rt.new_string('wp_mail_succeeded'),
		var_mail_data.clone()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_6
		}
	}
	return var_send.to_bool()
	unsafe {
		goto end_label_6
	}
	catch_label_6:
	mut var_e_6 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_6, 'PHPMailer_PHPMailer_Exception') {
		var_e = var_e_6.clone()
		var_mail_data.array_set('phpmailer_exception_code', rt.call_method(var_e, 'getCode',
			[]rt.PhpVal{}))
		rt.call_function('do_action', [rt.new_string('wp_mail_failed'),
			create_wp_error(rt.new_string('wp_mail_failed'), rt.call_method(var_e, 'getMessage',
				[]rt.PhpVal{}), var_mail_data.clone())])
		return false
		unsafe {
			goto end_label_6
		}
	} else {
		rt.throw_exception(var_e_6)
		unsafe {
			goto end_label_6
		}
	}

	end_label_6:
	return false
}

fn wp_authenticate(var_username_arg rt.PhpVal, var_password_arg rt.PhpVal) rt.PhpVal {
	mut var_username := var_username_arg
	mut var_password := var_password_arg
	mut var_user := rt.new_null()
	mut var_ignore_codes := []rt.PhpVal{}
	mut var_error := rt.new_null()
	var_username = rt.call_function('sanitize_user', [var_username.clone()])
	var_password = var_password.trim_space()
	var_user = rt.call_function('apply_filters', [rt.new_string('authenticate'),
		rt.new_null(), var_username.clone(), rt.new_string(var_password.str()).clone()])
	if rt.is_true(rt.identical(rt.new_null(), var_user))
		|| rt.is_true(rt.identical(rt.new_bool(false), var_user)) {
		var_user = create_wp_error(rt.new_string('authentication_failed'), rt.call_function('__', [
			rt.new_string('<strong>Error:</strong> Invalid username, email address or incorrect password.'),
		]))
	}
	var_ignore_codes = ['empty_username', 'empty_password']
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.call_method(var_user, 'get_error_code', []rt.PhpVal{}), rt.create_array_from_list(var_ignore_codes), rt.new_bool(true)]))))) {
		var_error = var_user.clone()
		rt.call_function('do_action', [rt.new_string('wp_login_failed'),
			var_username.clone(), var_error.clone()])
	}
	return var_user.clone()
}

fn wp_logout() {
	mut var_user_id := rt.new_null()
	var_user_id = rt.call_function('get_current_user_id', []rt.PhpVal{})
	rt.call_function('wp_destroy_current_session', []rt.PhpVal{})
	wp_clear_auth_cookie()
	wp_set_current_user(0, '')
	rt.call_function('do_action', [rt.new_string('wp_logout'),
		var_user_id.clone()])
}

fn wp_validate_auth_cookie(cookie string, scheme string) bool {
	mut var_cookie := cookie
	mut var_scheme := scheme
	mut var_GLOBALS := rt.new_null()
	mut var_cookie_elements := rt.new_null()
	mut var_username := rt.new_null()
	mut var_hmac := rt.new_null()
	mut var_token := rt.new_null()
	mut var_expiration := rt.new_null()
	mut var_expired := rt.new_null()
	mut var_user := false
	mut var_pass_frag := rt.new_null()
	mut var_key := rt.new_null()
	mut var_hash := rt.new_null()
	mut var_manager := rt.new_null()
	var_cookie_elements = rt.new_bool(wp_parse_auth_cookie(cookie, var_scheme))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_cookie_elements)))) {
		rt.call_function('do_action', [rt.new_string('auth_cookie_malformed'),
			rt.new_string(cookie), rt.new_string(var_scheme.str())])
		return false
	}
	var_scheme = (var_cookie_elements.array_get(rt.new_string('scheme'))).str()
	var_username = var_cookie_elements.array_get(rt.new_string('username'))
	var_hmac = var_cookie_elements.array_get(rt.new_string('hmac'))
	var_token = var_cookie_elements.array_get(rt.new_string('token'))
	var_expiration = var_cookie_elements.array_get(rt.new_string('expiration'))
	var_expired = rt.new_int(var_expiration.to_i64())
	if rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{}))
		|| rt.is_true(rt.identical(rt.new_string('POST'), rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_METHOD')))) {
		var_expired = rt.add(var_expired, rt.get_constant('HOUR_IN_SECONDS'))
	}
	if rt.is_true(rt.less(var_expired, rt.call_function('time', []rt.PhpVal{}))) {
		rt.call_function('do_action', [rt.new_string('auth_cookie_expired'),
			var_cookie_elements.clone()])
		return false
	}
	var_user = get_user_by('login', var_username.clone())
	if !var_user {
		rt.call_function('do_action', [rt.new_string('auth_cookie_bad_username'),
			var_cookie_elements.clone()])
		return false
	}
	if rt.is_true(rt.call_function('str_starts_with', [rt.get_property(rt.new_bool(var_user), 'user_pass'), rt.new_string('$P$')]))
		|| rt.is_true(rt.call_function('str_starts_with', [rt.get_property(rt.new_bool(var_user), 'user_pass'), rt.new_string('$2y$')])) {
		var_pass_frag = rt.call_function('substr', [
			rt.get_property(rt.new_bool(var_user), 'user_pass'),
			rt.new_int(8),
			rt.new_int(4),
		])
	} else {
		var_pass_frag = rt.call_function('substr', [
			rt.get_property(rt.new_bool(var_user), 'user_pass'),
			rt.new_int(-4),
		])
	}
	var_key = wp_hash(rt.new_string(var_username.str() + '|' + var_pass_frag.str() + '|' +
		var_expiration.str() + '|' + var_token.str()), var_scheme, '')
	var_hash = rt.call_function('hash_hmac', [rt.new_string('sha256'),
		rt.new_string(var_username.str() + '|' + var_expiration.str() + '|' + var_token.str()),
		var_key.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_equals', [
		var_hash.clone(), var_hmac.clone()])))))
	{
		rt.call_function('do_action', [rt.new_string('auth_cookie_bad_hash'),
			var_cookie_elements.clone()])
		return false
	}
	mut iife_temp_2 := Class_WP_Session_Tokens{}
	mut iife_result_2 := iife_temp_2.get_instance(rt.get_property(rt.new_bool(var_user), 'ID'))
	var_manager = iife_result_2
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_manager, 'verify', [
		var_token.clone(),
	])))))
	{
		rt.call_function('do_action', [rt.new_string('auth_cookie_bad_session_token'),
			var_cookie_elements.clone()])
		return false
	}
	if rt.is_true(rt.less(var_expiration, rt.call_function('time', []rt.PhpVal{}))) {
		var_GLOBALS.array_set('login_grace_period', 1)
	}
	rt.call_function('do_action', [rt.new_string('auth_cookie_valid'),
		var_cookie_elements.clone(), rt.new_bool(var_user).clone()])
	return (rt.get_property(rt.new_bool(var_user), 'ID')).to_bool()
}

fn wp_generate_auth_cookie(var_user_id rt.PhpVal, var_expiration rt.PhpVal, scheme string, token string) string {
	mut var_scheme := scheme
	mut var_token := token
	mut var_user := rt.new_null()
	mut var_manager := rt.new_null()
	mut var_pass_frag := rt.new_null()
	mut var_key := rt.new_null()
	mut var_hash := rt.new_null()
	mut var_cookie := rt.new_null()
	var_user = get_userdata(var_user_id.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return ''
	}
	if !(var_token.len > 0 && var_token != '0') {
		mut iife_temp_3 := Class_WP_Session_Tokens{}
		mut iife_result_3 := iife_temp_3.get_instance(var_user_id.clone())
		var_manager = iife_result_3
		var_token = (rt.call_method(var_manager, 'create', [var_expiration.clone()])).str()
	}
	if rt.is_true(rt.call_function('str_starts_with', [rt.get_property(var_user, 'user_pass'), rt.new_string('$P$')]))
		|| rt.is_true(rt.call_function('str_starts_with', [rt.get_property(var_user, 'user_pass'), rt.new_string('$2y$')])) {
		var_pass_frag = rt.call_function('substr', [
			rt.get_property(var_user, 'user_pass'),
			rt.new_int(8),
			rt.new_int(4),
		])
	} else {
		var_pass_frag = rt.call_function('substr', [
			rt.get_property(var_user, 'user_pass'),
			rt.new_int(-4),
		])
	}
	var_key = wp_hash(rt.new_string((rt.get_property(var_user, 'user_login')).str() + '|' +
		var_pass_frag.str() + '|' + var_expiration.str() + '|' + var_token), var_scheme, '')
	var_hash = rt.call_function('hash_hmac', [rt.new_string('sha256'),
		rt.new_string((rt.get_property(var_user, 'user_login')).str() + '|' + var_expiration.str() +
			'|' + var_token),
		var_key.clone()])
	var_cookie = rt.new_string((rt.get_property(var_user, 'user_login')).str() + '|' +
		var_expiration.str() + '|' + var_token + '|' + var_hash.str())
	return (rt.call_function('apply_filters', [rt.new_string('auth_cookie'),
		var_cookie.clone(), var_user_id.clone(), var_expiration.clone(),
		rt.new_string(var_scheme.str()), rt.new_string(var_token.str())])).str()
}

fn wp_parse_auth_cookie(cookie string, scheme string) bool {
	mut var_cookie := cookie
	mut var_scheme := scheme
	mut var_username := rt.new_null()
	mut var_expiration := rt.new_null()
	mut var_token := rt.new_null()
	mut var_hmac := rt.new_null()
	mut var_cookie_name := rt.new_null()
	mut var_cookie_elements := rt.new_null()
	if var_cookie == '' {
		mut switch_val_3 := rt.new_string(var_scheme.str())
		if rt.is_true(rt.equal(switch_val_3, rt.new_string('auth'))) {
			var_cookie_name = rt.get_constant('AUTH_COOKIE')
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('secure_auth'))) {
			var_cookie_name = rt.get_constant('SECURE_AUTH_COOKIE')
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('logged_in'))) {
			var_cookie_name = rt.get_constant('LOGGED_IN_COOKIE')
		} else {
			if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) {
				var_cookie_name = rt.get_constant('SECURE_AUTH_COOKIE')
				var_scheme = 'secure_auth'
			} else {
				var_cookie_name = rt.get_constant('AUTH_COOKIE')
				var_scheme = 'auth'
			}
		}
		if !rt.is_true(rt.get_superglobal('_COOKIE').array_get(var_cookie_name)) {
			return false
		}
		var_cookie = (rt.get_superglobal('_COOKIE').array_get(var_cookie_name)).str()
	}
	var_cookie_elements = rt.call_function('explode', [rt.new_string('|'),
		rt.new_string(var_cookie.str())])
	if rt.is_true(rt.new_bool(var_cookie_elements.clone().array_count() != 4)) {
		return false
	}
	mut list_tmp_3 := var_cookie_elements
	var_username = list_tmp_3.array_get(0)
	var_expiration = list_tmp_3.array_get(1)
	var_token = list_tmp_3.array_get(2)
	var_hmac = list_tmp_3.array_get(3)
	return (rt.call_function('compact', [rt.new_string('username'),
		rt.new_string('expiration'), rt.new_string('token'), rt.new_string('hmac'),
		rt.new_string('scheme')])).to_bool()
}

fn wp_set_auth_cookie(var_user_id rt.PhpVal, remember bool, secure string, token string) {
	mut var_remember := remember
	mut var_secure := secure
	mut var_token := token
	mut var_expiration := rt.new_null()
	mut var_expire := rt.new_null()
	mut var_secure_logged_in_cookie := rt.new_null()
	mut var_auth_cookie_name := rt.new_null()
	mut var_scheme := ''
	mut var_manager := rt.new_null()
	mut var_auth_cookie := ''
	mut var_logged_in_cookie := ''
	if var_remember {
		var_expiration = rt.add(rt.call_function('time', []rt.PhpVal{}), rt.call_function('apply_filters', [
			rt.new_string('auth_cookie_expiration'),
			rt.mul(rt.new_int(14), rt.get_constant('DAY_IN_SECONDS')),
			var_user_id.clone(),
			rt.new_bool(remember),
		]))
		var_expire = rt.add(var_expiration, rt.mul(rt.new_int(12),
			rt.get_constant('HOUR_IN_SECONDS')))
	} else {
		var_expiration = rt.add(rt.call_function('time', []rt.PhpVal{}), rt.call_function('apply_filters', [
			rt.new_string('auth_cookie_expiration'),
			rt.mul(rt.new_int(2), rt.get_constant('DAY_IN_SECONDS')),
			var_user_id.clone(),
			rt.new_bool(remember),
		]))
		var_expire = rt.new_int(0)
	}
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_secure.str()))) {
		var_secure = (rt.call_function('is_ssl', []rt.PhpVal{})).str()
	}
	var_secure_logged_in_cookie = rt.new_bool(var_secure.len > 0 && var_secure != '0'
		&& rt.is_true(rt.identical(rt.new_string('https'), rt.call_function('parse_url', [rt.call_function('get_option', [rt.new_string('home')]), rt.get_constant('PHP_URL_SCHEME')]))))
	var_secure = (rt.call_function('apply_filters', [rt.new_string('secure_auth_cookie'),
		rt.new_string(var_secure.str()), var_user_id.clone()])).str()
	var_secure_logged_in_cookie = rt.call_function('apply_filters', [
		rt.new_string('secure_logged_in_cookie'),
		var_secure_logged_in_cookie.clone(),
		var_user_id.clone(),
		rt.new_string(var_secure.str()),
	])
	if var_secure.len > 0 && var_secure != '0' {
		var_auth_cookie_name = rt.get_constant('SECURE_AUTH_COOKIE')
		var_scheme = 'secure_auth'
	} else {
		var_auth_cookie_name = rt.get_constant('AUTH_COOKIE')
		var_scheme = 'auth'
	}
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_token.str()))) {
		mut iife_temp_4 := Class_WP_Session_Tokens{}
		mut iife_result_4 := iife_temp_4.get_instance(var_user_id.clone())
		var_manager = iife_result_4
		var_token = (rt.call_method(var_manager, 'create', [var_expiration.clone()])).str()
	}
	var_auth_cookie = wp_generate_auth_cookie(var_user_id.clone(), var_expiration.clone(),
		var_scheme, var_token)
	var_logged_in_cookie = wp_generate_auth_cookie(var_user_id.clone(), var_expiration.clone(),
		'logged_in', var_token)
	rt.call_function('do_action', [rt.new_string('set_auth_cookie'),
		rt.new_string(var_auth_cookie.str()).clone(), var_expire.clone(),
		var_expiration.clone(), var_user_id.clone(), rt.new_string(var_scheme.str()).clone(),
		rt.new_string(var_token.str())])
	rt.call_function('do_action', [rt.new_string('set_logged_in_cookie'),
		rt.new_string(var_logged_in_cookie.str()).clone(), var_expire.clone(),
		var_expiration.clone(), var_user_id.clone(), rt.new_string('logged_in'),
		rt.new_string(var_token.str())])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('send_auth_cookies'),
		rt.new_bool(true),
		var_expire.clone(),
		var_expiration.clone(),
		var_user_id.clone(),
		rt.new_string(var_scheme.str()).clone(),
		rt.new_string(var_token.str()),
	])))))
	{
		return
	}
	rt.call_function('setcookie', [var_auth_cookie_name.clone(),
		rt.new_string(var_auth_cookie.str()).clone(), var_expire.clone(),
		rt.get_constant('PLUGINS_COOKIE_PATH'), rt.get_constant('COOKIE_DOMAIN'),
		rt.new_string(var_secure.str()), rt.new_bool(true)])
	rt.call_function('setcookie', [var_auth_cookie_name.clone(),
		rt.new_string(var_auth_cookie.str()).clone(), var_expire.clone(),
		rt.get_constant('ADMIN_COOKIE_PATH'), rt.get_constant('COOKIE_DOMAIN'),
		rt.new_string(var_secure.str()), rt.new_bool(true)])
	rt.call_function('setcookie', [rt.get_constant('LOGGED_IN_COOKIE'),
		rt.new_string(var_logged_in_cookie.str()).clone(), var_expire.clone(),
		rt.get_constant('COOKIEPATH'), rt.get_constant('COOKIE_DOMAIN'),
		var_secure_logged_in_cookie.clone(), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_constant('COOKIEPATH'),
		rt.get_constant('SITECOOKIEPATH')))))
	{
		rt.call_function('setcookie', [rt.get_constant('LOGGED_IN_COOKIE'),
			rt.new_string(var_logged_in_cookie.str()).clone(),
			var_expire.clone(), rt.get_constant('SITECOOKIEPATH'),
			rt.get_constant('COOKIE_DOMAIN'), var_secure_logged_in_cookie.clone(),
			rt.new_bool(true)])
	}
}

fn wp_clear_auth_cookie() {
	rt.call_function('do_action', [rt.new_string('clear_auth_cookie')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('send_auth_cookies'),
		rt.new_bool(true),
		rt.new_int(0),
		rt.new_int(0),
		rt.new_int(0),
		rt.new_string(''),
		rt.new_string(''),
	])))))
	{
		return
	}
	rt.call_function('setcookie', [rt.get_constant('AUTH_COOKIE'),
		rt.new_string(' '),
		rt.sub(rt.call_function('time', []rt.PhpVal{}),
			rt.get_constant('YEAR_IN_SECONDS')),
		rt.get_constant('ADMIN_COOKIE_PATH'), rt.get_constant('COOKIE_DOMAIN')])
	rt.call_function('setcookie', [rt.get_constant('SECURE_AUTH_COOKIE'),
		rt.new_string(' '),
		rt.sub(rt.call_function('time', []rt.PhpVal{}),
			rt.get_constant('YEAR_IN_SECONDS')),
		rt.get_constant('ADMIN_COOKIE_PATH'), rt.get_constant('COOKIE_DOMAIN')])
	rt.call_function('setcookie', [rt.get_constant('AUTH_COOKIE'),
		rt.new_string(' '),
		rt.sub(rt.call_function('time', []rt.PhpVal{}),
			rt.get_constant('YEAR_IN_SECONDS')),
		rt.get_constant('PLUGINS_COOKIE_PATH'), rt.get_constant('COOKIE_DOMAIN')])
	rt.call_function('setcookie', [rt.get_constant('SECURE_AUTH_COOKIE'),
		rt.new_string(' '),
		rt.sub(rt.call_function('time', []rt.PhpVal{}),
			rt.get_constant('YEAR_IN_SECONDS')),
		rt.get_constant('PLUGINS_COOKIE_PATH'), rt.get_constant('COOKIE_DOMAIN')])
	rt.call_function('setcookie', [rt.get_constant('LOGGED_IN_COOKIE'),
		rt.new_string(' '),
		rt.sub(rt.call_function('time', []rt.PhpVal{}),
			rt.get_constant('YEAR_IN_SECONDS')),
		rt.get_constant('COOKIEPATH'), rt.get_constant('COOKIE_DOMAIN')])
	rt.call_function('setcookie', [rt.get_constant('LOGGED_IN_COOKIE'),
		rt.new_string(' '),
		rt.sub(rt.call_function('time', []rt.PhpVal{}),
			rt.get_constant('YEAR_IN_SECONDS')),
		rt.get_constant('SITECOOKIEPATH'), rt.get_constant('COOKIE_DOMAIN')])
	rt.call_function('setcookie', [
		rt.new_string('wp-settings-' +
			(rt.call_function('get_current_user_id', []rt.PhpVal{})).str()),
		rt.new_string(' '),
		rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.get_constant('YEAR_IN_SECONDS')),
		rt.get_constant('SITECOOKIEPATH'),
	])
	rt.call_function('setcookie', [
		rt.new_string('wp-settings-time-' +
			(rt.call_function('get_current_user_id', []rt.PhpVal{})).str()),
		rt.new_string(' '),
		rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.get_constant('YEAR_IN_SECONDS')),
		rt.get_constant('SITECOOKIEPATH'),
	])
	rt.call_function('setcookie', [rt.get_constant('AUTH_COOKIE'),
		rt.new_string(' '),
		rt.sub(rt.call_function('time', []rt.PhpVal{}),
			rt.get_constant('YEAR_IN_SECONDS')),
		rt.get_constant('COOKIEPATH'), rt.get_constant('COOKIE_DOMAIN')])
	rt.call_function('setcookie', [rt.get_constant('AUTH_COOKIE'),
		rt.new_string(' '),
		rt.sub(rt.call_function('time', []rt.PhpVal{}),
			rt.get_constant('YEAR_IN_SECONDS')),
		rt.get_constant('SITECOOKIEPATH'), rt.get_constant('COOKIE_DOMAIN')])
	rt.call_function('setcookie', [rt.get_constant('SECURE_AUTH_COOKIE'),
		rt.new_string(' '),
		rt.sub(rt.call_function('time', []rt.PhpVal{}),
			rt.get_constant('YEAR_IN_SECONDS')),
		rt.get_constant('COOKIEPATH'), rt.get_constant('COOKIE_DOMAIN')])
	rt.call_function('setcookie', [rt.get_constant('SECURE_AUTH_COOKIE'),
		rt.new_string(' '),
		rt.sub(rt.call_function('time', []rt.PhpVal{}),
			rt.get_constant('YEAR_IN_SECONDS')),
		rt.get_constant('SITECOOKIEPATH'), rt.get_constant('COOKIE_DOMAIN')])
	rt.call_function('setcookie', [rt.get_constant('USER_COOKIE'),
		rt.new_string(' '),
		rt.sub(rt.call_function('time', []rt.PhpVal{}),
			rt.get_constant('YEAR_IN_SECONDS')),
		rt.get_constant('COOKIEPATH'), rt.get_constant('COOKIE_DOMAIN')])
	rt.call_function('setcookie', [rt.get_constant('PASS_COOKIE'),
		rt.new_string(' '),
		rt.sub(rt.call_function('time', []rt.PhpVal{}),
			rt.get_constant('YEAR_IN_SECONDS')),
		rt.get_constant('COOKIEPATH'), rt.get_constant('COOKIE_DOMAIN')])
	rt.call_function('setcookie', [rt.get_constant('USER_COOKIE'),
		rt.new_string(' '),
		rt.sub(rt.call_function('time', []rt.PhpVal{}),
			rt.get_constant('YEAR_IN_SECONDS')),
		rt.get_constant('SITECOOKIEPATH'), rt.get_constant('COOKIE_DOMAIN')])
	rt.call_function('setcookie', [rt.get_constant('PASS_COOKIE'),
		rt.new_string(' '),
		rt.sub(rt.call_function('time', []rt.PhpVal{}),
			rt.get_constant('YEAR_IN_SECONDS')),
		rt.get_constant('SITECOOKIEPATH'), rt.get_constant('COOKIE_DOMAIN')])
	rt.call_function('setcookie', [
		rt.new_string('wp-postpass_' + (rt.get_constant('COOKIEHASH')).str()),
		rt.new_string(' '),
		rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.get_constant('YEAR_IN_SECONDS')),
		rt.get_constant('COOKIEPATH'),
		rt.get_constant('COOKIE_DOMAIN'),
	])
}

fn is_user_logged_in() rt.PhpVal {
	mut var_user := rt.new_null()
	var_user = wp_get_current_user()
	return rt.call_method(var_user, 'exists', []rt.PhpVal{})
}

fn auth_redirect() {
	mut var_secure := rt.new_null()
	mut var_scheme := rt.new_null()
	mut var_user_id := false
	mut var_redirect := rt.new_null()
	mut var_login_url := rt.new_null()
	var_secure = rt.new_bool(rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('force_ssl_admin', []rt.PhpVal{})))
	var_secure = rt.call_function('apply_filters', [
		rt.new_string('secure_auth_redirect'),
		var_secure.clone(),
	])
	if rt.is_true(var_secure)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')), rt.new_string('wp-admin')])) {
		if rt.is_true(rt.call_function('str_starts_with', [
			rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
			rt.new_string('http'),
		]))
		{
			rt.new_bool(wp_redirect(rt.call_function('set_url_scheme', [
				rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
				rt.new_string('https'),
			]), 0, ''))
			exit(0)
		} else {
			rt.new_bool(wp_redirect(rt.new_string('https://' +
				(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_HOST'))).str() +
				(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))).str()), 0,
				''))
			exit(0)
		}
	}
	var_scheme = rt.call_function('apply_filters', [
		rt.new_string('auth_redirect_scheme'),
		rt.new_string(''),
	])
	var_user_id = wp_validate_auth_cookie('', var_scheme.clone())
	if var_user_id {
		rt.call_function('do_action', [rt.new_string('auth_redirect'),
			rt.new_bool(var_user_id).clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_secure))))
			&& rt.is_true(rt.call_function('get_user_option', [rt.new_string('use_ssl'), rt.new_bool(var_user_id).clone()]))
			&& rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')), rt.new_string('wp-admin')])) {
			if rt.is_true(rt.call_function('str_starts_with', [
				rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
				rt.new_string('http'),
			]))
			{
				rt.new_bool(wp_redirect(rt.call_function('set_url_scheme', [
					rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
					rt.new_string('https'),
				]), 0, ''))
				exit(0)
			} else {
				rt.new_bool(wp_redirect(rt.new_string('https://' +
					(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_HOST'))).str() +
					(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))).str()),
					0, ''))
				exit(0)
			}
		}
		return
	}
	rt.call_function('nocache_headers', []rt.PhpVal{})
	if rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')), rt.new_string('/options.php')]))
		&& rt.is_true(rt.call_function('wp_get_referer', []rt.PhpVal{})) {
		var_redirect = rt.call_function('wp_get_referer', []rt.PhpVal{})
	} else {
		var_redirect = rt.call_function('set_url_scheme', [
			rt.new_string('http://' +
				(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_HOST'))).str() +
				(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))).str()),
		])
	}
	var_login_url = rt.call_function('wp_login_url', [var_redirect.clone(),
		rt.new_bool(true)])
	rt.new_bool(wp_redirect(var_login_url.clone(), 0, ''))
	exit(0)
}

fn check_admin_referer(var_action rt.PhpVal, query_arg string) rt.PhpVal {
	mut var_query_arg := query_arg
	mut var_adminurl := ''
	mut var_referer := ''
	mut var_result := rt.new_null()
	if rt.is_true(rt.identical(-1, var_action)) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('You should specify an action to be verified by using the first parameter.'),
			]),
			rt.new_string('3.2.0')])
	}
	var_adminurl = rt.call_function('admin_url', []rt.PhpVal{}).to_string().to_lower()
	var_referer = rt.call_function('wp_get_referer', []rt.PhpVal{}).to_string().to_lower()
	var_result = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string(query_arg)) {
		wp_verify_nonce(rt.get_superglobal('_REQUEST').array_get(rt.new_string(query_arg)),
			var_action.clone())
	} else {
		rt.new_bool(false)
	}
	rt.call_function('do_action', [rt.new_string('check_admin_referer'),
		var_action.clone(), var_result.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result))))
		&& !(rt.is_true(rt.identical(-1, var_action))
		&& rt.is_true(rt.call_function('str_starts_with', [rt.new_string(var_referer.str()).clone(), rt.new_string(var_adminurl.str()).clone()]))) {
		rt.call_function('wp_nonce_ays', [var_action.clone()])
		exit(0)
	}
	return var_result.clone()
}

fn check_ajax_referer(var_action rt.PhpVal, query_arg bool, stop bool) rt.PhpVal {
	mut var_query_arg := query_arg
	mut var_stop := stop
	mut var_nonce := rt.new_null()
	mut var_result := rt.new_null()
	if rt.is_true(rt.identical(-1, var_action)) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('You should specify an action to be verified by using the first parameter.'),
			]),
			rt.new_string('4.7.0')])
	}
	var_nonce = rt.new_string('')
	if var_query_arg && rt.get_superglobal('_REQUEST').array_isset(rt.new_bool(query_arg)) {
		var_nonce = rt.get_superglobal('_REQUEST').array_get(rt.new_bool(query_arg))
	} else if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('_ajax_nonce')) {
		var_nonce = rt.get_superglobal('_REQUEST').array_get(rt.new_string('_ajax_nonce'))
	} else if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('_wpnonce')) {
		var_nonce = rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wpnonce'))
	}
	var_result = wp_verify_nonce(var_nonce.clone(), var_action.clone())
	rt.call_function('do_action', [rt.new_string('check_ajax_referer'),
		var_action.clone(), var_result.clone()])
	if var_stop && rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
		if rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})) {
			rt.call_function('wp_die', [rt.new_int(-1), rt.new_int(403)])
		} else {
			fn () {
				print((rt.new_string('-1')).str())
				exit(0)
			}()
		}
	}
	return var_result.clone()
}

fn wp_redirect(var_location_arg rt.PhpVal, status i64, x_redirect_by string) bool {
	mut var_status := status
	mut var_x_redirect_by := x_redirect_by
	mut var_location := var_location_arg
	mut var_is_IIS := rt.new_null()
	var_location = rt.call_function('apply_filters', [rt.new_string('wp_redirect'),
		var_location.clone(), rt.new_int(var_status)])
	var_status = (rt.call_function('apply_filters', [rt.new_string('wp_redirect_status'),
		rt.new_int(var_status), var_location.clone()])).to_i64()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_location)))) {
		return false
	}
	if var_status < 300 || 399 < var_status {
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('HTTP redirect status code must be a redirection code, 3xx.'),
			]),
		])
	}
	var_location = wp_sanitize_redirect(var_location.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_IIS))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('cgi-fcgi'), rt.get_constant('PHP_SAPI'))))) {
		rt.call_function('status_header', [rt.new_int(var_status)])
	}
	var_x_redirect_by = (rt.call_function('apply_filters', [
		rt.new_string('x_redirect_by'),
		rt.new_string(var_x_redirect_by.str()),
		rt.new_int(var_status),
		var_location.clone(),
	])).str()
	if rt.is_true(rt.new_bool(rt.new_string(var_x_redirect_by.str()).is_string())) {
		rt.call_function('header', [rt.new_string('X-Redirect-By: ${var_x_redirect_by}')])
	}
	rt.call_function('header', [rt.new_string('Location: ${var_location.to_string()}'),
		rt.new_bool(true), rt.new_int(var_status)])
	return true
}

fn wp_sanitize_redirect(var_location_arg rt.PhpVal) rt.PhpVal {
	mut var_location := var_location_arg
	mut var_regex := ''
	mut var_strip := []rt.PhpVal{}
	var_location = rt.call_function('str_replace', [rt.new_string(' '),
		rt.new_string('%20'), var_location.clone()])
	var_regex = '/\n\t\t(\n\t\t\t(?: [\\xC2-\\xDF][\\x80-\\xBF]        # double-byte sequences   110xxxxx 10xxxxxx\n\t\t\t|   \\xE0[\\xA0-\\xBF][\\x80-\\xBF]    # triple-byte sequences   1110xxxx 10xxxxxx * 2\n\t\t\t|   [\\xE1-\\xEC][\\x80-\\xBF]{2}\n\t\t\t|   \\xED[\\x80-\\x9F][\\x80-\\xBF]\n\t\t\t|   [\\xEE-\\xEF][\\x80-\\xBF]{2}\n\t\t\t|   \\xF0[\\x90-\\xBF][\\x80-\\xBF]{2} # four-byte sequences   11110xxx 10xxxxxx * 3\n\t\t\t|   [\\xF1-\\xF3][\\x80-\\xBF]{3}\n\t\t\t|   \\xF4[\\x80-\\x8F][\\x80-\\xBF]{2}\n\t\t){1,40}                              # ...one or more times\n\t\t)/x'
	var_location = rt.call_function('preg_replace_callback', [
		rt.new_string(var_regex.str()).clone(), rt.new_string('_wp_sanitize_utf8_in_redirect'),
		var_location.clone()])
	var_location = rt.call_function('preg_replace', [
		rt.new_string('|[^a-z0-9-~+_.?#=&;,/:%!*\\[\\]()@]|i'),
		rt.new_string(''),
		var_location.clone(),
	])
	var_location = rt.call_function('wp_kses_no_null', [var_location.clone()])
	var_strip = ['%0d', '%0a', '%0D', '%0A']
	return rt.call_function('_deep_replace', [rt.create_array_from_list(var_strip),
		var_location.clone()])
}

fn _wp_sanitize_utf8_in_redirect(var_matches rt.PhpVal) rt.PhpVal {
	return rt.call_function('urlencode', [var_matches[0]])
}

fn wp_safe_redirect(var_location_arg rt.PhpVal, status i64, x_redirect_by string) bool {
	mut var_status := status
	mut var_x_redirect_by := x_redirect_by
	mut var_location := var_location_arg
	mut var_fallback_url := rt.new_null()
	var_location = wp_sanitize_redirect(var_location.clone())
	var_fallback_url = rt.call_function('apply_filters', [
		rt.new_string('wp_safe_redirect_fallback'),
		rt.call_function('admin_url', []rt.PhpVal{}),
		rt.new_int(var_status),
	])
	var_location = rt.new_string(wp_validate_redirect(var_location.clone(),
		var_fallback_url.clone()))
	return wp_redirect(var_location.clone(), var_status, var_x_redirect_by)
}

fn wp_validate_redirect(var_location_arg rt.PhpVal, fallback_url string) string {
	mut var_fallback_url := fallback_url
	mut var_location := var_location_arg
	mut var_cut := rt.new_null()
	mut var_test := rt.new_null()
	mut var_lp := rt.new_null()
	mut var_path := rt.new_null()
	mut var_component := rt.new_null()
	mut var_wpp := rt.new_null()
	mut var_allowed_hosts := rt.new_null()
	var_location =
		wp_sanitize_redirect(rt.new_string(var_location.clone().to_string().trim_space()))
	if rt.is_true(rt.call_function('str_starts_with', [var_location.clone(),
		rt.new_string('//')]))
	{
		var_location = rt.new_string('http:' + var_location.str())
	}
	var_cut = rt.call_function('strpos', [var_location.clone(),
		rt.new_string('?')])
	var_test = if rt.is_true(var_cut) { rt.call_function('substr', [
			var_location.clone(), rt.new_int(0), var_cut.clone()]) } else { var_location }
	var_lp = rt.call_function('parse_url', [var_test.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_lp)) {
		return fallback_url
	}
	if var_lp.array_isset(rt.new_string('scheme'))
		&& !(rt.is_true(rt.identical(rt.new_string('http'), var_lp.array_get(rt.new_string('scheme'))))
		|| rt.is_true(rt.identical(rt.new_string('https'), var_lp.array_get(rt.new_string('scheme'))))) {
		return fallback_url
	}
	if !(var_lp.array_isset(rt.new_string('host')))
		&& !(!rt.is_true(var_lp.array_get(rt.new_string('path'))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('/'), var_lp.array_get(rt.new_string('path')).array_get(rt.new_int(0)))))) {
		var_path = rt.new_string('')
		if !(!rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')))) {
			var_path = rt.call_function('dirname', [
				rt.new_string(
					(rt.call_function('parse_url', [rt.new_string('http://placeholder' + (rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))).str()), rt.get_constant('PHP_URL_PATH')])).str() +
					'?'),
			])
			var_path = rt.call_function('wp_normalize_path', [
				var_path.clone()])
		}
		var_location = rt.new_string('/' + var_path.str() + '/'.trim_left(' \t\n\r') +
			var_location.str())
	}
	if !(var_lp.array_isset(rt.new_string('host'))) && var_lp.array_isset(rt.new_string('scheme'))
		|| var_lp.array_isset(rt.new_string('user'))
		|| var_lp.array_isset(rt.new_string('pass'))
		|| var_lp.array_isset(rt.new_string('port')) {
		return fallback_url
	}
	mut iter_8 := rt.create_array([rt.ArrayItem{ key: none, val: 'user' },
		rt.ArrayItem{ key: none, val: 'pass' }, rt.ArrayItem{ key: none, val: 'host' }]).iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_component_shadow := item_8.val
		if var_lp.array_isset(var_component_shadow)
			&& rt.is_true(rt.call_function('strpbrk', [var_lp.array_get(var_component_shadow), rt.new_string(':/?#@')])) {
			return fallback_url
		}
	}
	var_wpp = rt.call_function('parse_url', [rt.call_function('home_url', []rt.PhpVal{})])
	var_allowed_hosts = rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('allowed_redirect_hosts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: var_wpp.array_get(rt.new_string('host')) },
		]),
		if !(var_lp.array_get(rt.new_string('host'))).is_null() {
			var_lp.array_get(rt.new_string('host'))
		} else {
			rt.new_string('')
		},
	]))
	if var_lp.array_isset(rt.new_string('host'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_lp.array_get(rt.new_string('host')), var_allowed_hosts.clone(), rt.new_bool(true)])))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(var_wpp.array_get(rt.new_string('host')).to_string().to_lower()), var_lp.array_get(rt.new_string('host')))))) {
		var_location = rt.new_string(fallback_url)
	}
	return var_location.str()
}

fn wp_notify_postauthor(var_comment_id rt.PhpVal, var_deprecated rt.PhpVal) bool {
	mut var_comment := rt.new_null()
	mut var_post := rt.new_null()
	mut var_author := rt.new_null()
	mut var_emails := rt.new_null()
	mut var_notify_author := rt.new_null()
	mut var_comment_author_domain := rt.new_null()
	mut var_blogname := rt.new_null()
	mut var_comment_content := rt.new_null()
	mut var_wp_email := rt.new_null()
	mut var_from := ''
	mut var_reply_to := ''
	mut var_message_headers := rt.new_null()
	mut var_email := rt.new_null()
	mut var_user := false
	mut var_switched_locale := rt.new_null()
	mut var_notify_message := rt.new_null()
	mut var_subject := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_deprecated)))) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('3.8.0')])
	}
	var_comment = rt.call_function('get_comment', [var_comment_id.clone()])
	if !rt.is_true(var_comment) || !rt.is_true(rt.get_property(var_comment, 'comment_post_ID')) {
		return false
	}
	var_post = rt.call_function('get_post', [
		rt.get_property(var_comment, 'comment_post_ID'),
	])
	var_author = get_userdata(rt.get_property(var_post, 'post_author'))
	var_emails = rt.new_array()
	if rt.is_true(var_author) {
		var_emails.array_push(rt.get_property(var_author, 'user_email'))
	}
	var_emails = rt.call_function('apply_filters', [
		rt.new_string('comment_notification_recipients'),
		var_emails.clone(),
		rt.get_property(var_comment, 'comment_ID'),
	])
	var_emails = rt.call_function('array_filter', [var_emails.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(var_emails.clone().array_count()))))) {
		return false
	}
	var_emails = rt.call_function('array_flip', [var_emails.clone()])
	var_notify_author = rt.call_function('apply_filters', [
		rt.new_string('comment_notification_notify_author'),
		rt.new_bool(false),
		rt.get_property(var_comment, 'comment_ID'),
	])
	if rt.is_true(var_author) && rt.is_true(rt.new_bool(!(rt.is_true(var_notify_author))))
		&& rt.new_int((rt.get_property(var_comment, 'user_id')).to_i64()) == rt.new_int((rt.get_property(var_post, 'post_author')).to_i64()) {
		var_emails.array_unset(rt.get_property(var_author, 'user_email'))
	}
	if rt.is_true(var_author) && rt.is_true(rt.new_bool(!(rt.is_true(var_notify_author))))
		&& rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.new_int((rt.get_property(var_post, 'post_author')).to_i64()))) {
		var_emails.array_unset(rt.get_property(var_author, 'user_email'))
	}
	if rt.is_true(var_author) && rt.is_true(rt.new_bool(!(rt.is_true(var_notify_author))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('user_can', [rt.get_property(var_post, 'post_author'), rt.new_string('read_post'), rt.get_property(var_post, 'ID')]))))) {
		var_emails.array_unset(rt.get_property(var_author, 'user_email'))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(var_emails.clone().array_count()))))) {
		return false
	} else {
		var_emails = rt.call_function('array_flip', [var_emails.clone()])
	}
	var_comment_author_domain = rt.new_string('')
	mut iife_temp_5 := Class_WP_Http{}
	mut iife_result_5 :=
		iife_temp_5.is_ip_address(rt.get_property(var_comment, 'comment_author_IP'))
	if rt.is_true(iife_result_5) {
		var_comment_author_domain = rt.call_function('gethostbyaddr', [
			rt.get_property(var_comment, 'comment_author_IP'),
		])
	}
	var_blogname = rt.call_function('wp_specialchars_decode', [
		rt.call_function('get_option', [rt.new_string('blogname')]),
		rt.get_constant('ENT_QUOTES'),
	])
	var_comment_content = rt.call_function('wp_specialchars_decode', [
		rt.get_property(var_comment, 'comment_content'),
	])
	var_wp_email =
		rt.new_string('wordpress@' +(rt.call_function('preg_replace', [rt.new_string('#^www\\.#'), rt.new_string(''), rt.call_function('wp_parse_url', [rt.call_function('network_home_url', []rt.PhpVal{}), rt.get_constant('PHP_URL_HOST')])])).str())
	if rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_comment, 'comment_author'))) {
		var_from = "From: \"${var_blogname.to_string()}\" <${var_wp_email.to_string()}>"
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_comment,
			'comment_author_email')))))
		{
			var_reply_to = rt.concat(rt.new_string('Reply-To: '), rt.get_property(var_comment,
				'comment_author_email'))
		}
	} else {
		var_from = rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('From: "'), rt.get_property(var_comment,
			'comment_author')), rt.new_string('" <')), var_wp_email), rt.new_string('>'))
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_comment,
			'comment_author_email')))))
		{
			var_reply_to = rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Reply-To: "'), rt.get_property(var_comment,
				'comment_author_email')), rt.new_string('" <')), rt.get_property(var_comment,
				'comment_author_email')), rt.new_string('>'))
		}
	}
	var_message_headers = rt.new_string('${var_from}\n' + 'Content-Type: text/plain; charset="' +
		(rt.call_function('get_option', [rt.new_string('blog_charset')])).str() + '"\n')
	if !(rt.new_string(var_reply_to.str())).is_null() {
		var_message_headers = rt.concat(var_message_headers, rt.new_string(var_reply_to + '\n'))
	}
	var_message_headers = rt.call_function('apply_filters', [
		rt.new_string('comment_notification_headers'),
		var_message_headers.clone(),
		rt.get_property(var_comment, 'comment_ID'),
	])
	mut iter_9 := var_emails.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_email_shadow := item_9.val
		var_user = get_user_by('email', var_email_shadow.clone())
		if var_user {
			var_switched_locale = rt.call_function('switch_to_user_locale', [
				rt.get_property(rt.new_bool(var_user), 'ID'),
			])
		} else {
			var_switched_locale = rt.call_function('switch_to_locale', [
				rt.call_function('get_locale', []rt.PhpVal{}),
			])
		}
		mut switch_val_4 := rt.get_property(var_comment, 'comment_type')
		if rt.is_true(rt.equal(switch_val_4, rt.new_string('trackback'))) {
			var_notify_message = rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('New trackback on your post "%s"')]), rt.get_property(var_post, 'post_title')])).str() +
				'\r\n')
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Website: %1$s (IP address: %2$s, %3$s)')]), rt.get_property(var_comment, 'comment_author'), rt.get_property(var_comment, 'comment_author_IP'), var_comment_author_domain.clone()])).str() +
				'\r\n'))
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('URL: %s')]), rt.get_property(var_comment, 'comment_author_url')])).str() +
				'\r\n'))
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Comment: %s')]), rt.new_string('\r\n' + var_comment_content.str())])).str() +
				'\r\n\r\n'))
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('__', [rt.new_string('You can see all trackbacks on this post here:')])).str() +
				'\r\n'))
			var_subject = rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('[%1$s] Trackback: "%2$s"')]),
				var_blogname.clone(),
				rt.get_property(var_post, 'post_title'),
			])
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('pingback'))) {
			var_notify_message = rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('New pingback on your post "%s"')]), rt.get_property(var_post, 'post_title')])).str() +
				'\r\n')
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Website: %1$s (IP address: %2$s, %3$s)')]), rt.get_property(var_comment, 'comment_author'), rt.get_property(var_comment, 'comment_author_IP'), var_comment_author_domain.clone()])).str() +
				'\r\n'))
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('URL: %s')]), rt.get_property(var_comment, 'comment_author_url')])).str() +
				'\r\n'))
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Comment: %s')]), rt.new_string('\r\n' + var_comment_content.str())])).str() +
				'\r\n\r\n'))
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('__', [rt.new_string('You can see all pingbacks on this post here:')])).str() +
				'\r\n'))
			var_subject = rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('[%1$s] Pingback: "%2$s"')]),
				var_blogname.clone(),
				rt.get_property(var_post, 'post_title'),
			])
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('note'))) {
			var_notify_message = rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('New note on your post "%s"')]), rt.get_property(var_post, 'post_title')])).str() +
				'\r\n')
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Author: %1$s (IP address: %2$s, %3$s)')]), rt.get_property(var_comment, 'comment_author'), rt.get_property(var_comment, 'comment_author_IP'), var_comment_author_domain.clone()])).str() +
				'\r\n'))
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Email: %s')]), rt.get_property(var_comment, 'comment_author_email')])).str() +
				'\r\n'))
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Note: %s')]), rt.new_string('\r\n' + (if !rt.is_true(var_comment_content) { rt.call_function('__', [rt.new_string('resolved/reopened')]) } else { var_comment_content }).str())])).str() +
				'\r\n\r\n'))
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('__', [rt.new_string('You can see all notes on this post here:')])).str() +
				'\r\n'))
			var_subject = rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('[%1$s] Note: "%2$s"')]),
				var_blogname.clone(),
				rt.get_property(var_post, 'post_title'),
			])
		} else {
			var_notify_message = rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('New comment on your post "%s"')]), rt.get_property(var_post, 'post_title')])).str() +
				'\r\n')
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Author: %1$s (IP address: %2$s, %3$s)')]), rt.get_property(var_comment, 'comment_author'), rt.get_property(var_comment, 'comment_author_IP'), var_comment_author_domain.clone()])).str() +
				'\r\n'))
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Email: %s')]), rt.get_property(var_comment, 'comment_author_email')])).str() +
				'\r\n'))
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('URL: %s')]), rt.get_property(var_comment, 'comment_author_url')])).str() +
				'\r\n'))
			if rt.is_true(rt.get_property(var_comment, 'comment_parent'))
				&& rt.is_true(rt.call_function('user_can', [rt.get_property(var_post, 'post_author'), rt.new_string('edit_comment'), rt.get_property(var_comment, 'comment_parent')])) {
				var_notify_message = rt.concat(var_notify_message, rt.new_string(
					(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('In reply to: %s')]), rt.call_function('admin_url', [rt.concat(rt.concat(rt.new_string('comment.php?action=editcomment&c='), rt.get_property(var_comment, 'comment_parent')), rt.new_string('#wpbody-content'))])])).str() +
					'\r\n'))
			}
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Comment: %s')]), rt.new_string('\r\n' + var_comment_content.str())])).str() +
				'\r\n\r\n'))
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('__', [rt.new_string('You can see all comments on this post here:')])).str() +
				'\r\n'))
			var_subject = rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('[%1$s] Comment: "%2$s"')]),
				var_blogname.clone(),
				rt.get_property(var_post, 'post_title'),
			])
		}
		if rt.is_true(rt.identical(rt.new_string('note'), rt.get_property(var_comment,
			'comment_type')))
		{
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('get_edit_post_link', [rt.get_property(var_comment, 'comment_post_ID'), rt.new_string('url')])).str() +
				'\r\n'))
		} else {
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('get_permalink', [rt.get_property(var_comment, 'comment_post_ID')])).str() +
				'#comments\r\n\r\n'))
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Permalink: %s')]), rt.call_function('get_comment_link', [var_comment.clone()])])).str() +
				'\r\n'))
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('note'), rt.get_property(var_comment, 'comment_type')))))
			&& rt.is_true(rt.call_function('user_can', [rt.get_property(var_post, 'post_author'), rt.new_string('edit_comment'), rt.get_property(var_comment, 'comment_ID')])) {
			if rt.is_true(rt.get_constant('EMPTY_TRASH_DAYS')) {
				var_notify_message = rt.concat(var_notify_message, rt.new_string(
					(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Trash it: %s')]), rt.call_function('admin_url', [rt.concat(rt.concat(rt.new_string('comment.php?action=trash&c='), rt.get_property(var_comment, 'comment_ID')), rt.new_string('#wpbody-content'))])])).str() +
					'\r\n'))
			} else {
				var_notify_message = rt.concat(var_notify_message, rt.new_string(
					(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Delete it: %s')]), rt.call_function('admin_url', [rt.concat(rt.concat(rt.new_string('comment.php?action=delete&c='), rt.get_property(var_comment, 'comment_ID')), rt.new_string('#wpbody-content'))])])).str() +
					'\r\n'))
			}
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Spam it: %s')]), rt.call_function('admin_url', [rt.concat(rt.concat(rt.new_string('comment.php?action=spam&c='), rt.get_property(var_comment, 'comment_ID')), rt.new_string('#wpbody-content'))])])).str() +
				'\r\n'))
		}
		var_notify_message = rt.call_function('apply_filters', [
			rt.new_string('comment_notification_text'),
			var_notify_message.clone(),
			rt.get_property(var_comment, 'comment_ID'),
		])
		var_subject = rt.call_function('apply_filters', [
			rt.new_string('comment_notification_subject'),
			var_subject.clone(),
			rt.get_property(var_comment, 'comment_ID'),
		])
		rt.new_bool(wp_mail(var_email_shadow.clone(), rt.call_function('wp_specialchars_decode', [
			var_subject.clone(),
		]), var_notify_message.clone(), var_message_headers.clone(), rt.new_null(), rt.new_null()))
		if rt.is_true(var_switched_locale) {
			rt.call_function('restore_previous_locale', []rt.PhpVal{})
		}
	}
	return true
}

fn wp_notify_moderator(var_comment_id rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_maybe_notify := rt.new_null()
	mut var_comment := rt.new_null()
	mut var_post := rt.new_null()
	mut var_user := rt.new_null()
	mut var_emails := rt.new_null()
	mut var_comment_author_domain := rt.new_null()
	mut var_comments_waiting := rt.new_null()
	mut var_blogname := rt.new_null()
	mut var_comment_content := rt.new_null()
	mut var_message_headers := rt.new_null()
	mut var_email := rt.new_null()
	mut var_switched_locale := rt.new_null()
	mut var_notify_message := rt.new_null()
	mut var_subject := rt.new_null()
	var_maybe_notify = rt.call_function('get_option', [
		rt.new_string('moderation_notify'),
	])
	var_maybe_notify = rt.call_function('apply_filters', [
		rt.new_string('notify_moderator'),
		var_maybe_notify.clone(),
		var_comment_id.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_maybe_notify)))) {
		return true
	}
	var_comment = rt.call_function('get_comment', [var_comment_id.clone()])
	var_post = rt.call_function('get_post', [
		rt.get_property(var_comment, 'comment_post_ID'),
	])
	var_user = get_userdata(rt.get_property(var_post, 'post_author'))
	var_emails = rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_function('get_option', [
			rt.new_string('admin_email'),
		]) },
	])
	if rt.is_true(var_user)
		&& rt.is_true(rt.call_function('user_can', [rt.get_property(var_user, 'ID'), rt.new_string('edit_comment'), var_comment_id.clone()]))
		&& !(!rt.is_true(rt.get_property(var_user, 'user_email'))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strcasecmp', [
			rt.get_property(var_user, 'user_email'),
			rt.call_function('get_option', [rt.new_string('admin_email')]),
		])))))
		{
			var_emails.array_push(rt.get_property(var_user, 'user_email'))
		}
	}
	var_comment_author_domain = rt.new_string('')
	mut iife_temp_6 := Class_WP_Http{}
	mut iife_result_6 :=
		iife_temp_6.is_ip_address(rt.get_property(var_comment, 'comment_author_IP'))
	if rt.is_true(iife_result_6) {
		var_comment_author_domain = rt.call_function('gethostbyaddr', [
			rt.get_property(var_comment, 'comment_author_IP'),
		])
	}
	var_comments_waiting = rt.call_method(var_wpdb, 'get_var', [
		rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM '), rt.get_property(var_wpdb,
			'comments')), rt.new_string(" WHERE comment_approved = '0'")),
	])
	var_blogname = rt.call_function('wp_specialchars_decode', [
		rt.call_function('get_option', [rt.new_string('blogname')]),
		rt.get_constant('ENT_QUOTES'),
	])
	var_comment_content = rt.call_function('wp_specialchars_decode', [
		rt.get_property(var_comment, 'comment_content'),
	])
	var_message_headers = rt.new_string('')
	var_emails = rt.call_function('apply_filters', [
		rt.new_string('comment_moderation_recipients'),
		var_emails.clone(),
		var_comment_id.clone(),
	])
	var_message_headers = rt.call_function('apply_filters', [
		rt.new_string('comment_moderation_headers'),
		var_message_headers.clone(),
		var_comment_id.clone(),
	])
	mut iter_10 := var_emails.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_email_shadow := item_10.val
		var_user = rt.new_bool(get_user_by('email', var_email_shadow.clone()))
		if rt.is_true(var_user) {
			var_switched_locale = rt.call_function('switch_to_user_locale', [
				rt.get_property(var_user, 'ID'),
			])
		} else {
			var_switched_locale = rt.call_function('switch_to_locale', [
				rt.call_function('get_locale', []rt.PhpVal{}),
			])
		}
		mut switch_val_5 := rt.get_property(var_comment, 'comment_type')
		if rt.is_true(rt.equal(switch_val_5, rt.new_string('trackback'))) {
			var_notify_message = rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('A new trackback on the post "%s" is waiting for your approval')]), rt.get_property(var_post, 'post_title')])).str() +
				'\r\n')
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('get_permalink', [rt.get_property(var_comment, 'comment_post_ID')])).str() +
				'\r\n\r\n'))
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Website: %1$s (IP address: %2$s, %3$s)')]), rt.get_property(var_comment, 'comment_author'), rt.get_property(var_comment, 'comment_author_IP'), var_comment_author_domain.clone()])).str() +
				'\r\n'))
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('URL: %s')]), rt.get_property(var_comment, 'comment_author_url')])).str() +
				'\r\n'))
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('__', [rt.new_string('Trackback excerpt: ')])).str() + '\r\n' +
				var_comment_content.str() + '\r\n\r\n'))
		} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('pingback'))) {
			var_notify_message = rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('A new pingback on the post "%s" is waiting for your approval')]), rt.get_property(var_post, 'post_title')])).str() +
				'\r\n')
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('get_permalink', [rt.get_property(var_comment, 'comment_post_ID')])).str() +
				'\r\n\r\n'))
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Website: %1$s (IP address: %2$s, %3$s)')]), rt.get_property(var_comment, 'comment_author'), rt.get_property(var_comment, 'comment_author_IP'), var_comment_author_domain.clone()])).str() +
				'\r\n'))
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('URL: %s')]), rt.get_property(var_comment, 'comment_author_url')])).str() +
				'\r\n'))
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('__', [rt.new_string('Pingback excerpt: ')])).str() + '\r\n' +
				var_comment_content.str() + '\r\n\r\n'))
		} else {
			var_notify_message = rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('A new comment on the post "%s" is waiting for your approval')]), rt.get_property(var_post, 'post_title')])).str() +
				'\r\n')
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('get_permalink', [rt.get_property(var_comment, 'comment_post_ID')])).str() +
				'\r\n\r\n'))
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Author: %1$s (IP address: %2$s, %3$s)')]), rt.get_property(var_comment, 'comment_author'), rt.get_property(var_comment, 'comment_author_IP'), var_comment_author_domain.clone()])).str() +
				'\r\n'))
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Email: %s')]), rt.get_property(var_comment, 'comment_author_email')])).str() +
				'\r\n'))
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('URL: %s')]), rt.get_property(var_comment, 'comment_author_url')])).str() +
				'\r\n'))
			if rt.is_true(rt.get_property(var_comment, 'comment_parent')) {
				var_notify_message = rt.concat(var_notify_message, rt.new_string(
					(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('In reply to: %s')]), rt.call_function('admin_url', [rt.concat(rt.concat(rt.new_string('comment.php?action=editcomment&c='), rt.get_property(var_comment, 'comment_parent')), rt.new_string('#wpbody-content'))])])).str() +
					'\r\n'))
			}
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Comment: %s')]), rt.new_string('\r\n' + var_comment_content.str())])).str() +
				'\r\n\r\n'))
		}
		var_notify_message = rt.concat(var_notify_message, rt.new_string(
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Approve it: %s')]), rt.call_function('admin_url', [rt.new_string('comment.php?action=approve&c=${var_comment_id.to_string()}#wpbody-content')])])).str() +
			'\r\n'))
		if rt.is_true(rt.get_constant('EMPTY_TRASH_DAYS')) {
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Trash it: %s')]), rt.call_function('admin_url', [rt.new_string('comment.php?action=trash&c=${var_comment_id.to_string()}#wpbody-content')])])).str() +
				'\r\n'))
		} else {
			var_notify_message = rt.concat(var_notify_message, rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Delete it: %s')]), rt.call_function('admin_url', [rt.new_string('comment.php?action=delete&c=${var_comment_id.to_string()}#wpbody-content')])])).str() +
				'\r\n'))
		}
		var_notify_message = rt.concat(var_notify_message, rt.new_string(
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Spam it: %s')]), rt.call_function('admin_url', [rt.new_string('comment.php?action=spam&c=${var_comment_id.to_string()}#wpbody-content')])])).str() +
			'\r\n'))
		var_notify_message = rt.concat(var_notify_message, rt.new_string(
			(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('Currently %s comment is waiting for approval. Please visit the moderation panel:'), rt.new_string('Currently %s comments are waiting for approval. Please visit the moderation panel:'), var_comments_waiting.clone()]), rt.call_function('number_format_i18n', [var_comments_waiting.clone()])])).str() +
			'\r\n'))
		var_notify_message = rt.concat(var_notify_message, rt.new_string(
			(rt.call_function('admin_url', [rt.new_string('edit-comments.php?comment_status=moderated#wpbody-content')])).str() +
			'\r\n'))
		var_subject = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('[%1$s] Please moderate: "%2$s"')]),
			var_blogname.clone(),
			rt.get_property(var_post, 'post_title'),
		])
		var_notify_message = rt.call_function('apply_filters', [
			rt.new_string('comment_moderation_text'),
			var_notify_message.clone(),
			var_comment_id.clone(),
		])
		var_subject = rt.call_function('apply_filters', [
			rt.new_string('comment_moderation_subject'),
			var_subject.clone(),
			var_comment_id.clone(),
		])
		rt.new_bool(wp_mail(var_email_shadow.clone(), rt.call_function('wp_specialchars_decode', [
			var_subject.clone(),
		]), var_notify_message.clone(), var_message_headers.clone(), rt.new_null(), rt.new_null()))
		if rt.is_true(var_switched_locale) {
			rt.call_function('restore_previous_locale', []rt.PhpVal{})
		}
	}
	return true
}

fn wp_password_change_notification(var_user rt.PhpVal) {
	mut var_admin_user := false
	mut var_switched_locale := rt.new_null()
	mut var_message := rt.new_null()
	mut var_blogname := rt.new_null()
	mut var_wp_password_change_notification_email := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strcasecmp', [
		rt.get_property(var_user, 'user_email'),
		rt.call_function('get_option', [rt.new_string('admin_email')]),
	])))))
	{
		var_admin_user = get_user_by('email', rt.call_function('get_option', [
			rt.new_string('admin_email'),
		]))
		if var_admin_user {
			var_switched_locale = rt.call_function('switch_to_user_locale', [
				rt.get_property(rt.new_bool(var_admin_user), 'ID'),
			])
		} else {
			var_switched_locale = rt.call_function('switch_to_locale', [
				rt.call_function('get_locale', []rt.PhpVal{}),
			])
		}
		var_message = rt.new_string(
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Password changed for user: %s')]), rt.get_property(var_user, 'user_login')])).str() +
			'\r\n')
		var_blogname = rt.call_function('wp_specialchars_decode', [
			rt.call_function('get_option', [rt.new_string('blogname')]),
			rt.get_constant('ENT_QUOTES'),
		])
		var_wp_password_change_notification_email = rt.create_array([
			rt.ArrayItem{ key: 'to', val: rt.call_function('get_option', [
				rt.new_string('admin_email'),
			]) },
			rt.ArrayItem{ key: 'subject', val: rt.call_function('__', [
				rt.new_string('[%s] Password Changed'),
			]) },
			rt.ArrayItem{ key: 'message', val: var_message },
			rt.ArrayItem{ key: 'headers', val: '' },
		])
		var_wp_password_change_notification_email = rt.call_function('apply_filters', [
			rt.new_string('wp_password_change_notification_email'),
			var_wp_password_change_notification_email.clone(),
			var_user.clone(),
			var_blogname.clone(),
		])
		rt.new_bool(wp_mail(var_wp_password_change_notification_email.array_get(rt.new_string('to')), rt.call_function('wp_specialchars_decode', [
			rt.call_function('sprintf', [var_wp_password_change_notification_email.array_get(rt.new_string('subject')),
				var_blogname.clone()]),
		]), var_wp_password_change_notification_email.array_get(rt.new_string('message')),
			var_wp_password_change_notification_email.array_get(rt.new_string('headers')),
			rt.new_null(), rt.new_null()))
		if rt.is_true(var_switched_locale) {
			rt.call_function('restore_previous_locale', []rt.PhpVal{})
		}
	}
}

fn wp_new_user_notification(var_user_id rt.PhpVal, var_deprecated rt.PhpVal, notify string) {
	mut var_notify := notify
	mut var_user := rt.new_null()
	mut var_blogname := rt.new_null()
	mut var_send_notification_to_admin := rt.new_null()
	mut var_admin_user := false
	mut var_switched_locale := rt.new_null()
	mut var_message := rt.new_null()
	mut var_wp_new_user_notification_email_admin := rt.new_null()
	mut var_send_notification_to_user := rt.new_null()
	mut var_key := rt.new_null()
	mut var_wp_new_user_notification_email := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_deprecated)))) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('4.3.1')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.new_string(notify),
		rt.create_array([rt.ArrayItem{ key: none, val: 'user' },
			rt.ArrayItem{ key: none, val: 'admin' }, rt.ArrayItem{ key: none, val: 'both' },
			rt.ArrayItem{ key: none, val: '' }]),
		rt.new_bool(true),
	])))))
	{
		return
	}
	var_user = get_userdata(var_user_id.clone())
	var_blogname = rt.call_function('wp_specialchars_decode', [
		rt.call_function('get_option', [rt.new_string('blogname')]),
		rt.get_constant('ENT_QUOTES'),
	])
	var_send_notification_to_admin = rt.call_function('apply_filters', [
		rt.new_string('wp_send_new_user_notification_to_admin'),
		rt.new_bool(true),
		var_user.clone(),
	])
	if rt.is_true(rt.new_bool('user' != notify))
		&& rt.is_true(rt.identical(rt.new_bool(true), var_send_notification_to_admin)) {
		var_admin_user = get_user_by('email', rt.call_function('get_option', [
			rt.new_string('admin_email'),
		]))
		if var_admin_user {
			var_switched_locale = rt.call_function('switch_to_user_locale', [
				rt.get_property(rt.new_bool(var_admin_user), 'ID'),
			])
		} else {
			var_switched_locale = rt.call_function('switch_to_locale', [
				rt.call_function('get_locale', []rt.PhpVal{}),
			])
		}
		var_message = rt.new_string(
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('New user registration on your site %s:')]), var_blogname.clone()])).str() +
			'\r\n\r\n')
		var_message = rt.concat(var_message, rt.new_string(
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Username: %s')]), rt.get_property(var_user, 'user_login')])).str() +
			'\r\n\r\n'))
		var_message = rt.concat(var_message, rt.new_string(
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Email: %s')]), rt.get_property(var_user, 'user_email')])).str() +
			'\r\n'))
		var_wp_new_user_notification_email_admin = rt.create_array([
			rt.ArrayItem{ key: 'to', val: rt.call_function('get_option', [
				rt.new_string('admin_email'),
			]) },
			rt.ArrayItem{ key: 'subject', val: rt.call_function('__', [
				rt.new_string('[%s] New User Registration'),
			]) },
			rt.ArrayItem{ key: 'message', val: var_message },
			rt.ArrayItem{ key: 'headers', val: '' },
		])
		var_wp_new_user_notification_email_admin = rt.call_function('apply_filters', [
			rt.new_string('wp_new_user_notification_email_admin'),
			var_wp_new_user_notification_email_admin.clone(),
			var_user.clone(),
			var_blogname.clone(),
		])
		rt.new_bool(wp_mail(var_wp_new_user_notification_email_admin.array_get(rt.new_string('to')), rt.call_function('wp_specialchars_decode', [
			rt.call_function('sprintf', [var_wp_new_user_notification_email_admin.array_get(rt.new_string('subject')),
				var_blogname.clone()]),
		]), var_wp_new_user_notification_email_admin.array_get(rt.new_string('message')),
			var_wp_new_user_notification_email_admin.array_get(rt.new_string('headers')),
			rt.new_null(), rt.new_null()))
		if rt.is_true(var_switched_locale) {
			rt.call_function('restore_previous_locale', []rt.PhpVal{})
		}
	}
	var_send_notification_to_user = rt.call_function('apply_filters', [
		rt.new_string('wp_send_new_user_notification_to_user'),
		rt.new_bool(true),
		var_user.clone(),
	])
	if rt.is_true(rt.identical(rt.new_string('admin'), rt.new_string(notify)))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), var_send_notification_to_user))))
		|| (!rt.is_true(var_deprecated) && notify == '') {
		return
	}
	var_key = rt.call_function('get_password_reset_key', [var_user.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_key.clone()])) {
		return
	}
	var_switched_locale = rt.call_function('switch_to_user_locale', [
		var_user_id.clone()])
	var_message = rt.new_string(
		(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Username: %s')]), rt.get_property(var_user, 'user_login')])).str() +
		'\r\n\r\n')
	var_message = rt.concat(var_message, rt.new_string(
		(rt.call_function('__', [rt.new_string('To set your password, visit the following address:')])).str() +
		'\r\n\r\n'))
	var_message = rt.concat(var_message, rt.new_string(
		(rt.call_function('network_site_url', [rt.new_string('wp-login.php?login=' + (rt.call_function('rawurlencode', [rt.get_property(var_user, 'user_login')])).str() +
		'&key=${var_key.to_string()}&action=rp'), rt.new_string('login')])).str() + '\r\n'))
	var_wp_new_user_notification_email = rt.create_array([
		rt.ArrayItem{ key: 'to', val: rt.get_property(var_user, 'user_email') },
		rt.ArrayItem{ key: 'subject', val: rt.call_function('__', [
			rt.new_string('[%s] Login Details'),
		]) },
		rt.ArrayItem{ key: 'message', val: var_message },
		rt.ArrayItem{ key: 'headers', val: '' },
	])
	var_wp_new_user_notification_email = rt.call_function('apply_filters', [
		rt.new_string('wp_new_user_notification_email'),
		var_wp_new_user_notification_email.clone(),
		var_user.clone(),
		var_blogname.clone(),
	])
	rt.new_bool(wp_mail(var_wp_new_user_notification_email.array_get(rt.new_string('to')), rt.call_function('wp_specialchars_decode', [
		rt.call_function('sprintf', [var_wp_new_user_notification_email.array_get(rt.new_string('subject')),
			var_blogname.clone()]),
	]), var_wp_new_user_notification_email.array_get(rt.new_string('message')),
		var_wp_new_user_notification_email.array_get(rt.new_string('headers')), rt.new_null(),
		rt.new_null()))
	if rt.is_true(var_switched_locale) {
		rt.call_function('restore_previous_locale', []rt.PhpVal{})
	}
}

fn wp_nonce_tick(var_action rt.PhpVal) rt.PhpVal {
	mut var_nonce_life := rt.new_null()
	var_nonce_life = rt.call_function('apply_filters', [rt.new_string('nonce_life'),
		rt.get_constant('DAY_IN_SECONDS'), var_action.clone()])
	return rt.call_function('ceil', [
		rt.div(rt.call_function('time', []rt.PhpVal{}), rt.div(var_nonce_life, rt.new_int(2))),
	])
}

fn wp_verify_nonce(var_nonce_arg rt.PhpVal, var_action rt.PhpVal) rt.PhpVal {
	mut var_nonce := var_nonce_arg
	mut var_user := rt.new_null()
	mut var_uid := rt.new_null()
	mut var_token := rt.new_null()
	mut var_i := rt.new_null()
	mut var_expected := rt.new_null()
	var_nonce = rt.new_string(var_nonce.str())
	var_user = wp_get_current_user()
	var_uid = rt.new_int((rt.get_property(var_user, 'ID')).to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_uid)))) {
		var_uid = rt.call_function('apply_filters', [
			rt.new_string('nonce_user_logged_out'),
			var_uid.clone(),
			var_action.clone(),
		])
	}
	if !rt.is_true(var_nonce) {
		return rt.new_bool(false)
	}
	var_token = rt.call_function('wp_get_session_token', []rt.PhpVal{})
	var_i = wp_nonce_tick(var_action.clone())
	var_expected = rt.call_function('substr', [
		wp_hash(rt.new_string(var_i.str() + '|' + var_action.str() + '|' + var_uid.str() + '|' +
			var_token.str()), 'nonce', ''),
		rt.new_int(-12),
		rt.new_int(10),
	])
	if rt.is_true(rt.call_function('hash_equals', [var_expected.clone(),
		var_nonce.clone()]))
	{
		return rt.new_int(1)
	}
	var_expected = rt.call_function('substr', [
		wp_hash(rt.new_string((rt.sub(var_i, rt.new_int(1))).str() + '|' + var_action.str() + '|' +
			var_uid.str() + '|' + var_token.str()), 'nonce', ''),
		rt.new_int(-12),
		rt.new_int(10),
	])
	if rt.is_true(rt.call_function('hash_equals', [var_expected.clone(),
		var_nonce.clone()]))
	{
		return rt.new_int(2)
	}
	rt.call_function('do_action', [rt.new_string('wp_verify_nonce_failed'),
		var_nonce.clone(), var_action.clone(), var_user.clone(),
		var_token.clone()])
	return rt.new_bool(false)
}

fn wp_create_nonce(var_action rt.PhpVal) rt.PhpVal {
	mut var_user := rt.new_null()
	mut var_uid := rt.new_null()
	mut var_token := rt.new_null()
	mut var_i := rt.new_null()
	var_user = wp_get_current_user()
	var_uid = rt.new_int((rt.get_property(var_user, 'ID')).to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_uid)))) {
		var_uid = rt.call_function('apply_filters', [
			rt.new_string('nonce_user_logged_out'),
			var_uid.clone(),
			var_action.clone(),
		])
	}
	var_token = rt.call_function('wp_get_session_token', []rt.PhpVal{})
	var_i = wp_nonce_tick(var_action.clone())
	return rt.call_function('substr', [
		wp_hash(rt.new_string(var_i.str() + '|' + var_action.str() + '|' + var_uid.str() + '|' +
			var_token.str()), 'nonce', ''),
		rt.new_int(-12),
		rt.new_int(10),
	])
}

fn wp_salt(scheme string) rt.PhpVal {
	mut var_scheme := scheme
	mut var_cached_salts := rt.new_null()
	mut var_duplicated_keys := rt.new_null()
	mut var_first := rt.new_null()
	mut var_second := rt.new_null()
	mut var_value := rt.new_null()
	mut var_options_to_prime := []rt.PhpVal{}
	mut var_key := rt.new_null()
	mut var_const := ''
	mut var_values := rt.new_null()
	mut var_type := rt.new_null()
	if var_cached_salts.array_isset(rt.new_string(var_scheme.str())) {
		return rt.call_function('apply_filters', [rt.new_string('salt'),
			var_cached_salts.array_get(rt.new_string(var_scheme.str())),
			rt.new_string(var_scheme.str())])
	}
	if rt.is_true(rt.identical(rt.new_null(), var_duplicated_keys)) {
		var_duplicated_keys = rt.new_array()
		mut iter_11 := rt.create_array([rt.ArrayItem{ key: none, val: 'AUTH' },
			rt.ArrayItem{ key: none, val: 'SECURE_AUTH' }, rt.ArrayItem{ key: none, val: 'LOGGED_IN' },
			rt.ArrayItem{ key: none, val: 'NONCE' }, rt.ArrayItem{ key: none, val: 'SECRET' }]).iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_first_shadow := item_11.val
			mut iter_12 := rt.create_array([rt.ArrayItem{ key: none, val: 'KEY' },
				rt.ArrayItem{ key: none, val: 'SALT' }]).iterator()
			for {
				item_12 := iter_12.next() or { break }
				mut var_second_shadow := item_12.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
					rt.new_string('${var_first.to_string()}_${var_second.to_string()}'),
				])))))
				{
					continue
				}
				var_value = rt.call_function('constant', [
					rt.new_string('${var_first.to_string()}_${var_second.to_string()}'),
				])
				var_duplicated_keys.array_set(var_value,
					rt.new_bool(var_duplicated_keys.array_isset(var_value)))
			}
		}
		var_duplicated_keys.array_set('put your unique phrase here', true)
		var_duplicated_keys.array_set(rt.call_function('__', [
			rt.new_string('put your unique phrase here'),
		]), true)
	}
	var_options_to_prime = rt.new_array()
	mut iter_13 := rt.create_array([rt.ArrayItem{ key: none, val: 'auth' },
		rt.ArrayItem{ key: none, val: 'secure_auth' }, rt.ArrayItem{ key: none, val: 'logged_in' },
		rt.ArrayItem{ key: none, val: 'nonce' }]).iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_key_shadow := item_13.val
		mut iter_14 := rt.create_array([rt.ArrayItem{ key: none, val: 'key' },
			rt.ArrayItem{ key: none, val: 'salt' }]).iterator()
		for {
			item_14 := iter_14.next() or { break }
			mut var_second_shadow := item_14.val
			var_const = '${var_key.to_string()}_${var_second.to_string()}'.to_upper()
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string(var_const.str()).clone()])))))
				|| rt.is_true(rt.identical(rt.new_bool(true), var_duplicated_keys.array_get(rt.call_function('constant', [rt.new_string(var_const.str()).clone()])))) {
				var_options_to_prime << '${var_key.to_string()}_${var_second.to_string()}'
			}
		}
	}
	if !(!rt.is_true(var_options_to_prime)) {
		var_options_to_prime << 'secret_key'
		rt.call_function('wp_prime_site_option_caches', [
			rt.create_array_from_list(var_options_to_prime),
		])
	}
	var_values = rt.create_array([rt.ArrayItem{ key: 'key', val: '' },
		rt.ArrayItem{ key: 'salt', val: '' }])
	if rt.is_true(rt.call_function('defined', [rt.new_string('SECRET_KEY')]))
		&& rt.is_true(rt.get_constant('SECRET_KEY'))
		&& !rt.is_true(var_duplicated_keys.array_get(rt.get_constant('SECRET_KEY'))) {
		var_values.array_set('key', rt.get_constant('SECRET_KEY'))
	}
	if rt.is_true(rt.identical(rt.new_string('auth'), rt.new_string(var_scheme.str())))
		&& rt.is_true(rt.call_function('defined', [rt.new_string('SECRET_SALT')]))
		&& rt.is_true(rt.get_constant('SECRET_SALT'))
		&& !rt.is_true(var_duplicated_keys.array_get(rt.get_constant('SECRET_SALT'))) {
		var_values.array_set('salt', rt.get_constant('SECRET_SALT'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string(var_scheme.str()),
		rt.create_array([rt.ArrayItem{ key: none, val: 'auth' },
			rt.ArrayItem{ key: none, val: 'secure_auth' }, rt.ArrayItem{ key: none, val: 'logged_in' },
			rt.ArrayItem{ key: none, val: 'nonce' }]),
		rt.new_bool(true)]))
	{
		mut iter_15 := rt.create_array([rt.ArrayItem{ key: none, val: 'key' },
			rt.ArrayItem{ key: none, val: 'salt' }]).iterator()
		for {
			item_15 := iter_15.next() or { break }
			mut var_type_shadow := item_15.val
			var_const = '${var_scheme}_${var_type.to_string()}'.to_upper()
			if rt.is_true(rt.call_function('defined', [rt.new_string(var_const.str()).clone()]))
				&& rt.is_true(rt.call_function('constant', [rt.new_string(var_const.str()).clone()]))
				&& !rt.is_true(var_duplicated_keys.array_get(rt.call_function('constant', [rt.new_string(var_const.str()).clone()]))) {
				var_values.array_set(var_type_shadow, rt.call_function('constant', [
					rt.new_string(var_const.str()).clone(),
				]))
			} else if rt.is_true(rt.new_bool(!(rt.is_true(var_values.array_get(var_type_shadow))))) {
				var_values.array_set(var_type_shadow, rt.call_function('get_site_option', [
					rt.new_string('${var_scheme}_${var_type.to_string()}'),
				]))
				if rt.is_true(rt.new_bool(!(rt.is_true(var_values.array_get(var_type_shadow))))) {
					var_values.array_set(var_type_shadow, wp_generate_password(64, true, true))
					rt.call_function('update_site_option', [
						rt.new_string('${var_scheme}_${var_type.to_string()}'),
						var_values.array_get(var_type_shadow),
					])
				}
			}
		}
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_values.array_get(rt.new_string('key')))))) {
			var_values.array_set('key', rt.call_function('get_site_option', [
				rt.new_string('secret_key'),
			]))
			if rt.is_true(rt.new_bool(!(rt.is_true(var_values.array_get(rt.new_string('key')))))) {
				var_values.array_set('key', wp_generate_password(64, true, true))
				rt.call_function('update_site_option', [rt.new_string('secret_key'),
					var_values.array_get(rt.new_string('key'))])
			}
		}
		var_values.array_set('salt', rt.call_function('hash_hmac', [
			rt.new_string('md5'), rt.new_string(var_scheme.str()),
			var_values.array_get(rt.new_string('key'))]))
	}
	var_cached_salts.array_set(var_scheme, (var_values.array_get(rt.new_string('key'))).str() +
		(var_values.array_get(rt.new_string('salt'))).str())
	return rt.call_function('apply_filters', [rt.new_string('salt'),
		var_cached_salts.array_get(rt.new_string(var_scheme.str())),
		rt.new_string(var_scheme.str())])
}

fn wp_hash(var_data rt.PhpVal, scheme string, algo string) rt.PhpVal {
	mut var_scheme := scheme
	mut var_algo := algo
	mut var_salt := rt.new_null()
	var_salt = wp_salt(var_scheme)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.new_string(algo),
		rt.call_function('hash_hmac_algos', []rt.PhpVal{}),
		rt.new_bool(true),
	])))))
	{
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Unsupported hashing algorithm: %1$s. Supported algorithms are: %2$s'),
			]),
			rt.new_string(algo),
			rt.call_function('implode', [
				rt.new_string(', '),
				rt.call_function('hash_hmac_algos', []rt.PhpVal{}),
			]),
		]))))
	}
	return rt.call_function('hash_hmac', [rt.new_string(algo),
		var_data.clone(), var_salt.clone()])
}

fn wp_hash_password(var_password rt.PhpVal) string {
	mut var_wp_hasher := rt.new_null()
	mut var_algorithm := rt.new_null()
	mut var_options := rt.new_null()
	mut var_password_to_hash := rt.new_null()
	if !(!rt.is_true(var_wp_hasher)) {
		return (rt.call_method(var_wp_hasher, 'HashPassword', [
			rt.new_string(var_password.clone().to_string().trim_space()),
		])).str()
	}
	if var_password.clone().to_string().len > 4096 {
		return '*'
	}
	var_algorithm = rt.call_function('apply_filters', [
		rt.new_string('wp_hash_password_algorithm'),
		rt.get_constant('PASSWORD_BCRYPT'),
	])
	var_options = rt.call_function('apply_filters', [
		rt.new_string('wp_hash_password_options'),
		rt.new_array(),
		var_algorithm.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_constant('PASSWORD_BCRYPT'),
		var_algorithm))))
	{
		return (rt.call_function('password_hash', [var_password.clone(),
			var_algorithm.clone(), var_options.clone()])).str()
	}
	var_password_to_hash = rt.call_function('base64_encode', [
		rt.call_function('hash_hmac', [rt.new_string('sha384'),
			rt.new_string(var_password.clone().to_string().trim_space()),
			rt.new_string('wp-sha384'), rt.new_bool(true)]),
	])
	return '$wp' +(rt.call_function('password_hash', [var_password_to_hash.clone(), var_algorithm.clone(), var_options.clone()])).str()
}

fn wp_check_password(var_password rt.PhpVal, var_hash rt.PhpVal, user_id string) rt.PhpVal {
	mut var_user_id := user_id
	mut var_wp_hasher := rt.new_null()
	mut var_check := rt.new_null()
	mut var_password_to_verify := rt.new_null()
	if var_hash.clone().to_string().len <= 32 {
		var_check = rt.call_function('hash_equals', [var_hash.clone(),
			rt.new_string(md5.hexhash(var_password.clone().to_string()))])
	} else if !(!rt.is_true(var_wp_hasher)) {
		var_check = rt.call_method(var_wp_hasher, 'CheckPassword', [
			var_password.clone(), var_hash.clone()])
	} else if var_password.clone().to_string().len > 4096 {
		var_check = rt.new_bool(false)
	} else if rt.is_true(rt.call_function('str_starts_with', [
		var_hash.clone(), rt.new_string('$wp')]))
	{
		var_password_to_verify = rt.call_function('base64_encode', [
			rt.call_function('hash_hmac', [rt.new_string('sha384'),
				var_password.clone(), rt.new_string('wp-sha384'),
				rt.new_bool(true)]),
		])
		var_check = rt.call_function('password_verify', [var_password_to_verify.clone(),
			rt.call_function('substr', [var_hash.clone(), rt.new_int(3)])])
	} else if rt.is_true(rt.call_function('str_starts_with', [
		var_hash.clone(), rt.new_string('$P$')]))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-phpass.php',
			'4')
		var_check = rt.call_method(create_passwordhash(rt.new_int(8), rt.new_bool(true)),
			'CheckPassword', [var_password.clone(), var_hash.clone()])
	} else {
		var_check = rt.call_function('password_verify', [var_password.clone(),
			var_hash.clone()])
	}
	return rt.call_function('apply_filters', [rt.new_string('check_password'),
		var_check.clone(), var_password.clone(), var_hash.clone(),
		rt.new_string(user_id)])
}

fn wp_password_needs_rehash(var_hash rt.PhpVal, user_id string) bool {
	mut var_user_id := user_id
	mut var_wp_hasher := rt.new_null()
	mut var_algorithm := rt.new_null()
	mut var_options := rt.new_null()
	mut var_prefixed := rt.new_null()
	mut var_needs_rehash := rt.new_null()
	mut var_hash_to_check := rt.new_null()
	if !(!rt.is_true(var_wp_hasher)) {
		return false
	}
	var_algorithm = rt.call_function('apply_filters', [
		rt.new_string('wp_hash_password_algorithm'),
		rt.get_constant('PASSWORD_BCRYPT'),
	])
	var_options = rt.call_function('apply_filters', [
		rt.new_string('wp_hash_password_options'),
		rt.new_array(),
		var_algorithm.clone(),
	])
	var_prefixed = rt.call_function('str_starts_with', [var_hash.clone(),
		rt.new_string('$wp')])
	if rt.is_true(rt.identical(rt.get_constant('PASSWORD_BCRYPT'), var_algorithm))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_prefixed)))) {
		var_needs_rehash = rt.new_bool(true)
	} else {
		var_hash_to_check = if rt.is_true(var_prefixed) { rt.call_function('substr', [
				var_hash.clone(),
				rt.new_int(3),
			]) } else { var_hash }
		var_needs_rehash = rt.call_function('password_needs_rehash', [
			var_hash_to_check.clone(), var_algorithm.clone(),
			var_options.clone()])
	}
	return (rt.call_function('apply_filters', [rt.new_string('password_needs_rehash'),
		var_needs_rehash.clone(), var_hash.clone(), rt.new_string(user_id)])).to_bool()
}

fn wp_generate_password(length i64, special_chars bool, extra_special_chars bool) rt.PhpVal {
	mut var_length := length
	mut var_special_chars := special_chars
	mut var_extra_special_chars := extra_special_chars
	mut var_chars := ''
	mut var_password := ''
	mut var_i := i64(0)
	var_chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
	if var_special_chars {
		var_chars = var_chars + '!@#$%^&*()'
	}
	if var_extra_special_chars {
		var_chars = var_chars + '-_ []{}<>~`+=,.;:/?|'
	}
	var_password = ''
	var_i = 0
	for {
		if !(var_i < length) { break
		 }
		var_password = var_password +
			(rt.call_function('substr', [rt.new_string(var_chars.str()).clone(), wp_rand(rt.new_int(0), rt.new_int(var_chars.len -
			1)), rt.new_int(1)])).str()
		var_i += 1
	}
	return rt.call_function('apply_filters', [rt.new_string('random_password'),
		rt.new_string(var_password.str()).clone(), rt.new_int(length),
		rt.new_bool(special_chars), rt.new_bool(extra_special_chars)])
}

fn wp_rand(var_min_arg rt.PhpVal, var_max_arg rt.PhpVal) rt.PhpVal {
	mut var_min := var_min_arg
	mut var_max := var_max_arg
	mut var_max_random_number := rt.new_null()
	mut var__max := rt.new_null()
	mut var__min := rt.new_null()
	mut var_val := rt.new_null()
	mut var_use_random_int_functionality := false
	mut var_e := rt.new_null()
	mut var_seed := rt.new_null()
	mut var_rnd_value := rt.new_null()
	mut var_value := rt.new_null()
	var_max_random_number = if 3000000000 == 2147483647 {
		'4294967295'.f64()
	} else {
		rt.new_int(4294967295)
	}
	if rt.is_true(rt.identical(rt.new_null(), var_min)) {
		var_min = rt.new_int(0)
	}
	if rt.is_true(rt.identical(rt.new_null(), var_max)) {
		var_max = var_max_random_number.clone()
	}
	var_min = rt.new_int(var_min.to_i64())
	var_max = rt.new_int(var_max.to_i64())
	if var_use_random_int_functionality {
		var__max = rt.call_function('max', [var_min.clone(), var_max.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_7
			}
		}
		var__min = rt.call_function('min', [var_min.clone(), var_max.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_7
			}
		}
		var_val = rt.call_function('random_int', [var__min.clone(),
			var__max.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_7
			}
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_val)))) {
			return rt.call_function('absint', [var_val.clone()])
		} else {
			var_use_random_int_functionality = false
			if rt.has_exception() {
				unsafe {
					goto catch_label_7
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_7
			}
		}
		unsafe {
			goto end_label_7
		}
		catch_label_7:
		mut var_e_7 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_7, 'Error') {
			var_e = var_e_7.clone()
			var_use_random_int_functionality = false
			unsafe {
				goto end_label_7
			}
		} else if rt.instance_of(var_e_7, 'Exception') {
			var_e = var_e_7.clone()
			var_use_random_int_functionality = false
			unsafe {
				goto end_label_7
			}
		} else {
			rt.throw_exception(var_e_7)
			unsafe {
				goto end_label_7
			}
		}

		end_label_7:
	}
	if var_rnd_value.clone().to_string().len < 8 {
		if rt.is_true(rt.call_function('defined', [rt.new_string('WP_SETUP_CONFIG')])) {
		} else {
			var_seed = rt.call_function('get_transient', [rt.new_string('random_seed')])
		}
		var_rnd_value = rt.new_string(md5.hexhash(
			(rt.call_function('uniqid', [rt.new_string((rt.call_function('microtime', []rt.PhpVal{})).str() +
			(rt.call_function('mt_rand', []rt.PhpVal{})).str()), rt.new_bool(true)])).str() +
			var_seed.str()))
		var_rnd_value = rt.concat(var_rnd_value,
			rt.new_string(sha1.hexhash(var_rnd_value.clone().to_string())))
		var_rnd_value = rt.concat(var_rnd_value, rt.new_string(sha1.hexhash(var_rnd_value.str() +
			var_seed.str())))
		var_seed = rt.new_string(md5.hexhash(var_seed.str() + var_rnd_value.str()))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_SETUP_CONFIG')])))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_INSTALLING')]))))) {
			rt.call_function('set_transient', [rt.new_string('random_seed'),
				var_seed.clone()])
		}
	}
	var_value = rt.call_function('substr', [var_rnd_value.clone(),
		rt.new_int(0), rt.new_int(8)])
	var_rnd_value = rt.call_function('substr', [var_rnd_value.clone(),
		rt.new_int(8)])
	var_value = rt.call_function('abs', [rt.call_function('hexdec', [
		var_value.clone()])])
	var_value = rt.add(var_min, rt.div(rt.mul(rt.add(rt.sub(var_max, var_min), rt.new_int(1)),
		var_value), rt.add(var_max_random_number, rt.new_int(1))))
	return rt.call_function('abs', [rt.new_int(var_value.to_i64())])
}

fn wp_set_password(var_password rt.PhpVal, var_user_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_old_user_data := rt.new_null()
	mut var_hash := ''
	var_old_user_data = get_userdata(var_user_id.clone())
	var_hash = wp_hash_password(var_password.clone())
	rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'users'),
		rt.create_array([rt.ArrayItem{ key: 'user_pass', val: var_hash },
			rt.ArrayItem{ key: 'user_activation_key', val: '' }]),
		rt.create_array([rt.ArrayItem{ key: 'ID', val: var_user_id }])])
	rt.call_function('clean_user_cache', [var_user_id.clone()])
	rt.call_function('do_action', [rt.new_string('wp_set_password'),
		var_password.clone(), var_user_id.clone(), var_old_user_data.clone()])
}

fn get_avatar(var_id_or_email_arg rt.PhpVal, size i64, default_value string, alt string, var_args_arg rt.PhpVal) bool {
	mut var_size := size
	mut var_default_value := default_value
	mut var_alt := alt
	mut var_id_or_email := var_id_or_email_arg
	mut var_args := var_args_arg
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_loading_optimization_attr := rt.new_null()
	mut var_avatar := rt.new_null()
	mut var_url2x := rt.new_null()
	mut var_url := rt.new_null()
	mut var_class := rt.new_null()
	mut var_extra_attr := rt.new_null()
	var_defaults = {
		'size':          rt.new_int(96)
		'height':        rt.new_null()
		'width':         rt.new_null()
		'default':       rt.call_function('get_option', [rt.new_string('avatar_default'),
			rt.new_string('mystery')])
		'force_default': rt.new_bool(false)
		'rating':        rt.call_function('get_option', [rt.new_string('avatar_rating')])
		'scheme':        rt.new_null()
		'alt':           rt.new_string('')
		'class':         rt.new_null()
		'force_display': rt.new_bool(false)
		'loading':       rt.new_null()
		'fetchpriority': rt.new_null()
		'decoding':      rt.new_null()
		'extra_attr':    rt.new_string('')
	}
	if !rt.is_true(var_args) {
		var_args = rt.new_array()
	}
	var_args.array_set('size', size)
	var_args.array_set('default', default_value)
	var_args.array_set('alt', alt)
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array_from_native_map(var_defaults)])
	if !rt.is_true(var_args.array_get(rt.new_string('height'))) {
		var_args.array_set('height', var_args.array_get(rt.new_string('size')))
	}
	if !rt.is_true(var_args.array_get(rt.new_string('width'))) {
		var_args.array_set('width', var_args.array_get(rt.new_string('size')))
	}
	var_loading_optimization_attr = rt.call_function('wp_get_loading_optimization_attributes', [
		rt.new_string('img'),
		var_args.clone(),
		rt.new_string('get_avatar'),
	])
	var_args = rt.call_function('array_merge', [var_args.clone(),
		var_loading_optimization_attr.clone()])
	if var_id_or_email.clone().is_object()
		&& !(rt.get_property(var_id_or_email, 'comment_ID')).is_null() {
		var_id_or_email = rt.call_function('get_comment', [var_id_or_email.clone()])
	}
	var_avatar = rt.call_function('apply_filters', [rt.new_string('pre_get_avatar'),
		rt.new_null(), var_id_or_email.clone(), var_args.clone()])
	if !(var_avatar.clone().is_null()) {
		return (rt.call_function('apply_filters', [rt.new_string('get_avatar'),
			var_avatar.clone(), var_id_or_email.clone(), var_args.array_get(rt.new_string('size')),
			var_args.array_get(rt.new_string('default')), var_args.array_get(rt.new_string('alt')),
			var_args.clone()])).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_args.array_get(rt.new_string('force_display'))))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [rt.new_string('show_avatars')]))))) {
		return false
	}
	var_url2x = rt.call_function('get_avatar_url', [var_id_or_email.clone(),
		rt.call_function('array_merge', [var_args.clone(),
			rt.create_array([
				rt.ArrayItem{ key: 'size', val: rt.mul(var_args.array_get(rt.new_string('size')),
					rt.new_int(2)) },
			])])])
	var_args = rt.call_function('get_avatar_data', [var_id_or_email.clone(),
		var_args.clone()])
	var_url = var_args.array_get(rt.new_string('url'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_url))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_url.clone()])) {
		return false
	}
	var_class = rt.create_array([rt.ArrayItem{ key: none, val: 'avatar' },
		rt.ArrayItem{ key: none, val: 'avatar-' +
			rt.new_int((var_args.array_get(rt.new_string('size'))).to_i64()).str() },
		rt.ArrayItem{ key: none, val: 'photo' }])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_args.array_get(rt.new_string('found_avatar'))))))
		|| rt.is_true(var_args.array_get(rt.new_string('force_default'))) {
		var_class.array_push('avatar-default')
	}
	if rt.is_true(var_args.array_get(rt.new_string('class'))) {
		if rt.is_true(rt.new_bool(var_args.array_get(rt.new_string('class')).is_array())) {
			var_class = rt.call_function('array_merge', [var_class.clone(),
				var_args.array_get(rt.new_string('class'))])
		} else {
			var_class.array_push(var_args.array_get(rt.new_string('class')))
		}
	}
	var_extra_attr = var_args.array_get(rt.new_string('extra_attr'))
	if rt.is_true(rt.call_function('in_array', [var_args.array_get(rt.new_string('loading')), rt.create_array([rt.ArrayItem{
		key: none
		val: 'lazy'
	}, rt.ArrayItem{ key: none, val: 'eager' }]), rt.new_bool(true)]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/\\bloading\\s*=/'), var_extra_attr.clone()]))))) {
		if !(!rt.is_true(var_extra_attr)) {
			var_extra_attr = rt.concat(var_extra_attr, rt.new_string(' '))
		}
		var_extra_attr = rt.concat(var_extra_attr, rt.concat(rt.concat(rt.new_string("loading='"),
			var_args.array_get(rt.new_string('loading'))), rt.new_string("'")))
	}
	if rt.is_true(rt.call_function('in_array', [var_args.array_get(rt.new_string('fetchpriority')), rt.create_array([rt.ArrayItem{
		key: none
		val: 'high'
	}, rt.ArrayItem{ key: none, val: 'low' }, rt.ArrayItem{ key: none, val: 'auto' }]), rt.new_bool(true)]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/\\bfetchpriority\\s*=/'), var_extra_attr.clone()]))))) {
		if !(!rt.is_true(var_extra_attr)) {
			var_extra_attr = rt.concat(var_extra_attr, rt.new_string(' '))
		}
		var_extra_attr = rt.concat(var_extra_attr, rt.concat(rt.concat(rt.new_string("fetchpriority='"),
			var_args.array_get(rt.new_string('fetchpriority'))), rt.new_string("'")))
	}
	if rt.is_true(rt.call_function('in_array', [var_args.array_get(rt.new_string('decoding')), rt.create_array([rt.ArrayItem{
		key: none
		val: 'async'
	}, rt.ArrayItem{ key: none, val: 'sync' }, rt.ArrayItem{ key: none, val: 'auto' }]), rt.new_bool(true)]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/\\bdecoding\\s*=/'), var_extra_attr.clone()]))))) {
		if !(!rt.is_true(var_extra_attr)) {
			var_extra_attr = rt.concat(var_extra_attr, rt.new_string(' '))
		}
		var_extra_attr = rt.concat(var_extra_attr, rt.concat(rt.concat(rt.new_string("decoding='"),
			var_args.array_get(rt.new_string('decoding'))), rt.new_string("'")))
	}
	var_avatar = rt.call_function('sprintf', [
		rt.new_string("<img alt='%s' src='%s' srcset='%s' class='%s' height='%d' width='%d' %s/>"),
		rt.call_function('esc_attr', [var_args.array_get(rt.new_string('alt'))]),
		rt.call_function('esc_url', [var_url.clone()]),
		rt.new_string((rt.call_function('esc_url', [var_url2x.clone()])).str() + ' 2x'),
		rt.call_function('esc_attr', [
			rt.call_function('implode', [rt.new_string(' '), var_class.clone()]),
		]),
		rt.new_int((var_args.array_get(rt.new_string('height'))).to_i64()),
		rt.new_int((var_args.array_get(rt.new_string('width'))).to_i64()),
		var_extra_attr.clone(),
	])
	return (rt.call_function('apply_filters', [rt.new_string('get_avatar'),
		var_avatar.clone(), var_id_or_email.clone(), var_args.array_get(rt.new_string('size')),
		var_args.array_get(rt.new_string('default')), var_args.array_get(rt.new_string('alt')),
		var_args.clone()])).to_bool()
}

fn wp_text_diff(var_left_string_arg rt.PhpVal, var_right_string_arg rt.PhpVal, var_args_arg rt.PhpVal) string {
	mut var_left_string := var_left_string_arg
	mut var_right_string := var_right_string_arg
	mut var_args := var_args_arg
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_left_lines := rt.new_null()
	mut var_right_lines := rt.new_null()
	mut var_text_diff := rt.new_null()
	mut var_renderer := rt.new_null()
	mut var_diff := rt.new_null()
	mut var_is_split_view := false
	mut var_is_split_view_class := ''
	mut var_r := ''
	mut var_th_or_td_left := ''
	mut var_th_or_td_right := ''
	var_defaults = {
		'title':           rt.new_string('')
		'title_left':      rt.new_string('')
		'title_right':     rt.new_string('')
		'show_split_view': rt.new_bool(true)
	}
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array_from_native_map(var_defaults)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WP_Text_Diff_Renderer_Table'),
		rt.new_bool(false),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/wp-diff.php',
			'3')
	}
	var_left_string = rt.call_function('normalize_whitespace', [
		var_left_string.clone()])
	var_right_string = rt.call_function('normalize_whitespace', [
		var_right_string.clone()])
	var_left_lines = rt.call_function('explode', [rt.new_string('\n'),
		var_left_string.clone()])
	var_right_lines = rt.call_function('explode', [rt.new_string('\n'),
		var_right_string.clone()])
	var_text_diff = create_text_diff(var_left_lines.clone(), var_right_lines.clone())
	var_renderer = create_wp_text_diff_renderer_table(var_args.clone())
	var_diff = var_renderer.render(rt.new_object('Text_Diff', []string{}, var_text_diff))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_diff)))) {
		return ''
	}
	var_is_split_view = !(!rt.is_true(var_args.array_get(rt.new_string('show_split_view'))))
	var_is_split_view_class = if var_is_split_view { ' is-split-view' } else { '' }
	var_r = "<table class='diff${var_is_split_view_class}'>\n"
	if rt.is_true(var_args.array_get(rt.new_string('title'))) {
		var_r = var_r +
			rt.concat(rt.concat(rt.new_string("<caption class='diff-title'>"), var_args.array_get(rt.new_string('title'))), rt.new_string('</caption>\n'))
	}
	if rt.is_true(var_args.array_get(rt.new_string('title_left')))
		|| rt.is_true(var_args.array_get(rt.new_string('title_right'))) {
		var_r = var_r + '<thead>'
	}
	if rt.is_true(var_args.array_get(rt.new_string('title_left')))
		|| rt.is_true(var_args.array_get(rt.new_string('title_right'))) {
		var_th_or_td_left = if !rt.is_true(var_args.array_get(rt.new_string('title_left'))) {
			'td'
		} else {
			'th'
		}
		var_th_or_td_right = if !rt.is_true(var_args.array_get(rt.new_string('title_right'))) {
			'td'
		} else {
			'th'
		}
		var_r = var_r + "<tr class='diff-sub-title'>\n"
		var_r = var_r +
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\t<'), rt.new_string(var_th_or_td_left.str())), rt.new_string('>')), var_args.array_get(rt.new_string('title_left'))), rt.new_string('</')), rt.new_string(var_th_or_td_left.str())), rt.new_string('>\n'))
		if var_is_split_view {
			var_r = var_r +
				rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\t<'), rt.new_string(var_th_or_td_right.str())), rt.new_string('>')), var_args.array_get(rt.new_string('title_right'))), rt.new_string('</')), rt.new_string(var_th_or_td_right.str())), rt.new_string('>\n'))
		}
		var_r = var_r + '</tr>\n'
	}
	if rt.is_true(var_args.array_get(rt.new_string('title_left')))
		|| rt.is_true(var_args.array_get(rt.new_string('title_right'))) {
		var_r = var_r + '</thead>\n'
	}
	var_r = var_r + '<tbody>\n${var_diff.to_string()}\n</tbody>\n'
	var_r = var_r + '</table>'
	return var_r
}

struct Class_WP_User {
	rt.PhpObjectBase
}

struct Class_WP_PHPMailer {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Session_Tokens {
	rt.PhpObjectBase
}

struct Class_WP_Http {
	rt.PhpObjectBase
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_PasswordHash {
	rt.PhpObjectBase
}

struct Class_Text_Diff {
	rt.PhpObjectBase
}

struct Class_WP_Text_Diff_Renderer_Table {
	rt.PhpObjectBase
}

fn create_wp_user(_args ...rt.PhpVal) &Class_WP_User {
	mut obj := &Class_WP_User{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_phpmailer(_args ...rt.PhpVal) &Class_WP_PHPMailer {
	mut obj := &Class_WP_PHPMailer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_session_tokens(_args ...rt.PhpVal) &Class_WP_Session_Tokens {
	mut obj := &Class_WP_Session_Tokens{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_http(_args ...rt.PhpVal) &Class_WP_Http {
	mut obj := &Class_WP_Http{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_invalidargumentexception(_args ...rt.PhpVal) &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_passwordhash(_args ...rt.PhpVal) &Class_PasswordHash {
	mut obj := &Class_PasswordHash{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_text_diff(_args ...rt.PhpVal) &Class_Text_Diff {
	mut obj := &Class_Text_Diff{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_text_diff_renderer_table(_args ...rt.PhpVal) &Class_WP_Text_Diff_Renderer_Table {
	mut obj := &Class_WP_Text_Diff_Renderer_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
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

fn (mut this Class_WP_PHPMailer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_PHPMailer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_PHPMailer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Session_Tokens) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Session_Tokens) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Session_Tokens) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Http) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Http) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Http) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_PasswordHash) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_PasswordHash) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_PasswordHash) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Text_Diff) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Text_Diff) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Text_Diff) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Text_Diff_Renderer_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Text_Diff_Renderer_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Text_Diff_Renderer_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_set_current_user'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_get_current_user'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_userdata'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_user_by'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('cache_users'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_mail'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_authenticate'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_logout'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_validate_auth_cookie'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_generate_auth_cookie'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_parse_auth_cookie'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_set_auth_cookie'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_clear_auth_cookie'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('is_user_logged_in'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('auth_redirect'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('check_admin_referer'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('check_ajax_referer'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_redirect'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_sanitize_redirect'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_safe_redirect'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_validate_redirect'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_notify_postauthor'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_notify_moderator'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_password_change_notification'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_new_user_notification'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_nonce_tick'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_verify_nonce'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_create_nonce'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_salt'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_hash'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_hash_password'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_check_password'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_password_needs_rehash'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_generate_password'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_rand'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_set_password'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_avatar'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_text_diff'),
	])))))
	{
	}
}
