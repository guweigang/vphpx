import rt

fn wp_set_current_user(id i64, name string) rt.PhpVal {
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(var_current_user).is_null() && true && rt.is_true(rt.identical(// unsupported expression: Expr_Cast_Int, rt.get_property(var_current_user, 'ID'))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return mut var_current_user
	}
	mut var_current_user := create_wp_user(rt.new_int(id).dup(), rt.new_string(name).dup())
	rt.call_function('setup_userdata', [rt.get_property(var_current_user, 'ID')])
	rt.call_function('do_action', [rt.new_string('set_current_user')])
	return mut var_current_user
}

fn wp_get_current_user() rt.PhpVal {
	return rt.call_function('_wp_get_current_user', []rt.PhpVal{})
}

fn get_userdata(var_user_id rt.PhpVal) rt.PhpVal {
	return rt.new_bool(get_user_by('id', var_user_id.dup()))
}

fn get_user_by(field string, var_value rt.PhpVal) bool {
	mut var_userdata := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_User{}; return temp.get_data_by(arg_0, arg_1) }(rt.new_string(field), var_value.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_userdata)))) {
		return false
	}
	mut var_user := create_wp_user()
	rt.call_method(var_user, 'init', [var_userdata.dup()])
	return (var_user).to_bool()
}

fn cache_users(var_user_ids rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_function('update_meta_cache', [rt.new_string('user'), var_user_ids.dup()])
	mut var_clean := rt.call_function('_get_non_cached_ids', [var_user_ids.dup(), rt.new_string('users')])
	if !rt.is_true(var_clean) {
		return rt.new_null()
	}
	mut var_list := rt.call_function('implode', [rt.new_string(','), var_clean.dup()])
	mut var_users := rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'users')), rt.new_string(' WHERE ID IN (')), var_list), rt.new_string(')'))])
	{
		mut iter_1 := var_users.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_user := item_1.val
			rt.call_function('update_user_caches', [var_user.dup()])
		}
	}
}

fn wp_mail(var_to rt.PhpVal, var_subject rt.PhpVal, var_message rt.PhpVal, headers string, var_attachments rt.PhpVal, var_embeds rt.PhpVal) rt.PhpVal {
	mut var_type := rt.new_null()
	mut var_charset_content := rt.new_null()
	mut var_matches := []rt.PhpVal{}
	mut var_atts := rt.call_function('apply_filters', [rt.new_string('wp_mail'), rt.call_function('compact', [rt.new_string('to'), rt.new_string('subject'), rt.new_string('message'), rt.new_string('headers'), rt.new_string('attachments'), rt.new_string('embeds')])])
	mut var_pre_wp_mail := rt.call_function('apply_filters', [rt.new_string('pre_wp_mail'), rt.new_null(), var_atts.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_pre_wp_mail.dup()
	}
	if var_atts.array_isset(rt.new_string('to')) {
		var_to = var_atts.array_get('to')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_to.dup().is_array()))))) {
		var_to = rt.call_function('explode', [rt.new_string(','), var_to.dup()])
	}
	if var_atts.array_isset(rt.new_string('subject')) {
		var_subject = var_atts.array_get('subject')
	}
	if var_atts.array_isset(rt.new_string('message')) {
		var_message = var_atts.array_get('message')
	}
	if var_atts.array_isset(rt.new_string('headers')) {
		headers = (var_atts.array_get('headers')).str()
	}
	if var_atts.array_isset(rt.new_string('attachments')) {
		var_attachments = var_atts.array_get('attachments')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_attachments.dup().is_array()))))) {
		var_attachments = rt.call_function('explode', [rt.new_string('\n'), rt.call_function('str_replace', [rt.new_string('\r\n'), rt.new_string('\n'), var_attachments.dup()])])
	}
	if var_atts.array_isset(rt.new_string('embeds')) {
		var_embeds = var_atts.array_get('embeds')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_embeds.dup().is_array()))))) {
		var_embeds = rt.call_function('explode', [rt.new_string('\n'), rt.call_function('str_replace', [rt.new_string('\r\n'), rt.new_string('\n'), var_embeds.dup()])])
	}
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('WP_PHPMailer', []string{}, var_phpmailer), 'PHPMailer_PHPMailer_PHPMailer')))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/PHPMailer/PHPMailer.php', '4')
		rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/PHPMailer/SMTP.php', '4')
		rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/PHPMailer/Exception.php', '4')
		rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-phpmailer.php', '4')
		mut var_phpmailer := create_wp_phpmailer(rt.new_bool(true))
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	mut var_cc := rt.new_array()
	mut var_bcc := rt.new_array()
	mut var_reply_to := rt.new_array()
	if headers == '' {
		headers = (rt.new_array()).str()
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.new_string(headers).is_array()))))) {
			mut var_tempheaders := rt.call_function('explode', [rt.new_string('\n'), rt.call_function('str_replace', [rt.new_string('\r\n'), rt.new_string('\n'), rt.new_string(headers)])])
		} else {
			var_tempheaders = rt.new_string(rt.new_string(headers)).dup()
		}
		headers = (rt.new_array()).str()
		if !(!rt.is_true(var_tempheaders)) {
			{
				mut iter_1 := rt.cast_array(var_tempheaders).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_header := item_1.val
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_header.dup(), rt.new_string(':')]))))) {
						if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
							mut var_parts := rt.call_function('preg_split', [rt.new_string('/boundary=/i'), rt.new_string(var_header.dup().to_string().trim_space())])
							mut var_boundary := rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '\'' }, rt.ArrayItem{ key: none, val: '"' }]), rt.new_string(''), var_parts.array_get(1)]).to_string().trim_space()
						}
						continue
					}
					// unsupported assign target: Expr_List
					mut var_name := var_name.trim_space()
					mut var_content := var_content.trim_space()
					mut switch_val_1 := rt.new_string(var_name.to_lower())
					if rt.is_true(rt.equal(switch_val_1, rt.new_string('from'))) {
						mut var_bracket_pos := rt.call_function('strpos', [rt.new_string(var_content).dup(), rt.new_string('<')])
						if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
							if rt.is_true(rt.greater(var_bracket_pos, rt.new_int(0))) {
								mut var_from_name := rt.call_function('substr', [rt.new_string(var_content).dup(), rt.new_int(0), var_bracket_pos.dup()])
								var_from_name = rt.call_function('str_replace', [rt.new_string('"'), rt.new_string(''), var_from_name.dup()])
								var_from_name = rt.new_string(rt.new_string(var_from_name.dup().to_string().trim_space()))
							}
							mut var_from_email := rt.call_function('substr', [rt.new_string(var_content).dup(), rt.add(var_bracket_pos, rt.new_int(1))])
							var_from_email = rt.call_function('str_replace', [rt.new_string('>'), rt.new_string(''), var_from_email.dup()])
							var_from_email = rt.new_string(rt.new_string(var_from_email.dup().to_string().trim_space()))
							// unsupported statement: Stmt_Nop
						} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
							var_from_email = rt.new_string(rt.new_string(var_content.trim_space()))
						}
					} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('content-type'))) {
						if rt.is_true(rt.call_function('str_contains', [rt.new_string(var_content).dup(), rt.new_string(';')])) {
							// unsupported assign target: Expr_List
							mut var_content_type := rt.new_string(rt.new_string(var_type.dup().to_string().trim_space()))
							if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
								mut var_charset := rt.new_string(rt.new_string(rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: 'charset=' }, rt.ArrayItem{ key: none, val: '"' }]), rt.new_string(''), var_charset_content.dup()]).to_string().trim_space()))
							} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
								var_boundary = rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: 'BOUNDARY=' }, rt.ArrayItem{ key: none, val: 'boundary=' }, rt.ArrayItem{ key: none, val: '"' }]), rt.new_string(''), var_charset_content.dup()]).to_string().trim_space()
								var_charset = rt.new_string(rt.new_string(''))
								if rt.is_true(rt.call_function('preg_match', [rt.new_string('~^multipart/(\\S+)~'), var_content_type.dup(), var_matches.dup()])) {
									var_content_type = rt.new_string('multipart/' + var_matches.array_get(1).to_string().to_lower() + '; boundary="' + var_boundary + '"')
								}
							}
							// unsupported statement: Stmt_Nop
						} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
							var_content_type = rt.new_string(rt.new_string(var_content.trim_space()))
						}
					} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('cc'))) {
						var_cc = rt.call_function('array_merge', [rt.cast_array(var_cc), rt.call_function('explode', [rt.new_string(','), rt.new_string(var_content).dup()])])
					} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('bcc'))) {
						var_bcc = rt.call_function('array_merge', [rt.cast_array(var_bcc), rt.call_function('explode', [rt.new_string(','), rt.new_string(var_content).dup()])])
					} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('reply-to'))) {
						var_reply_to = rt.call_function('array_merge', [rt.cast_array(var_reply_to), rt.call_function('explode', [rt.new_string(','), rt.new_string(var_content).dup()])])
					} else {
						rt.new_string(headers).array_set(var_name.trim_space(), var_content.trim_space())
					}
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
	if !(!(var_from_name).is_null()) {
		mut var_from_name := rt.new_string(rt.new_string('WordPress'))
	}
	if !(!(var_from_email).is_null()) {
		mut var_sitename := rt.call_function('wp_parse_url', [rt.call_function('network_home_url', []rt.PhpVal{}), rt.get_constant('PHP_URL_HOST')])
		mut var_from_email := rt.new_string(rt.new_string('wordpress@'))
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			if rt.is_true(rt.call_function('str_starts_with', [var_sitename.dup(), rt.new_string('www.')])) {
				var_sitename = rt.call_function('substr', [var_sitename.dup(), rt.new_int(4)])
			}
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	var_from_email = rt.call_function('apply_filters', [rt.new_string('wp_mail_from'), var_from_email.dup()])
	var_from_name = rt.call_function('apply_filters', [rt.new_string('wp_mail_from_name'), var_from_name.dup()])
	.setfrom(.dup(), .dup(), rt.new_bool())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'PHPMailer_PHPMailer_Exception') {
		mut var_e := var_e_1.dup()
		
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
}

struct Class_WP_User {
	rt.PhpObjectBase
}

struct Class_WP_PHPMailer {
	rt.PhpObjectBase
}

fn create_wp_user() &Class_WP_User {
	mut obj := &Class_WP_User{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_phpmailer() &Class_WP_PHPMailer {
	mut obj := &Class_WP_PHPMailer{
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




pub fn init_wp_includes_pluggable_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_set_current_user')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_get_current_user')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('get_userdata')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('get_user_by')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('cache_users')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_mail')]))))) {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
}
