import rt

fn add_user() rt.PhpVal {
	return rt.new_object('WP_Error', []string{}, edit_user(0))
}

fn edit_user(user_id i64) rt.PhpVal {
	mut var_user_id := user_id
	mut var_wp_roles := rt.new_null()
	mut var_user := rt.new_null()
	mut var_update := false
	mut var_userdata := rt.new_null()
	mut var_pass1 := ''
	mut var_pass2 := ''
	mut var_new_role := rt.new_null()
	mut var_editable_roles := rt.new_null()
	mut var_potential_role := rt.new_null()
	mut var_protocols := rt.new_null()
	mut var_name := rt.new_null()
	mut var_method := rt.new_null()
	mut var_locale := rt.new_null()
	mut var_errors := rt.new_null()
	mut var_illegal_logins := rt.new_null()
	mut var_owner_id := rt.new_null()
	mut var_notify := ''
	var_wp_roles = rt.call_function('wp_roles', []rt.PhpVal{})
	var_user = create_stdclass()
	var_user_id = var_user_id
	if var_user_id != 0 {
		var_update = true
		rt.set_property(var_user, 'ID', rt.new_int(var_user_id))
		var_userdata = rt.call_function('get_userdata', [rt.new_int(var_user_id)])
		rt.set_property(var_user, 'user_login', rt.call_function('wp_slash', [rt.get_property(var_userdata, 'user_login')]))
	} else {
	var_update = false
	}
	if !(var_update) && rt.get_superglobal('_POST').array_isset(rt.new_string('user_login')) {
		rt.set_property(var_user, 'user_login', rt.call_function('sanitize_user', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('user_login'))]), rt.new_bool(true)]))
	}
	var_pass1 = ''
	var_pass2 = ''
	if rt.get_superglobal('_POST').array_isset(rt.new_string('pass1')) {
	var_pass1 = rt.get_superglobal('_POST').array_get(rt.new_string('pass1')).to_string().trim_space()
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('pass2')) {
	var_pass2 = rt.get_superglobal('_POST').array_get(rt.new_string('pass2')).to_string().trim_space()
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('role')) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('promote_users')])) && !(var_user_id != 0) || rt.is_true(rt.call_function('current_user_can', [rt.new_string('promote_user'), rt.new_int(var_user_id)])) {
		var_new_role = rt.call_function('sanitize_text_field', [rt.get_superglobal('_POST').array_get(rt.new_string('role'))])
		var_editable_roles = get_editable_roles()
		if !(!rt.is_true(var_new_role)) && !rt.is_true(var_editable_roles.array_get(var_new_role)) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to give users that role.')]), rt.new_int(403)])
		}
		var_potential_role = if !(rt.get_property(var_wp_roles, 'role_objects').array_get(var_new_role)).is_null() { rt.get_property(var_wp_roles, 'role_objects').array_get(var_new_role) } else { rt.new_bool(false) }
		if ((rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_users')]))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.new_int(var_user_id)))))) || (rt.is_true(var_potential_role) && rt.is_true(rt.call_method(var_potential_role, 'has_cap', [rt.new_string('promote_users')]))) {
			rt.set_property(var_user, 'role', var_new_role.clone())
		}
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('email')) {
		rt.set_property(var_user, 'user_email', rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('email'))])]))
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('url')) {
		if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('url'))) || rt.is_true(rt.identical(rt.new_string('http://'), rt.get_superglobal('_POST').array_get(rt.new_string('url')))) {
			rt.set_property(var_user, 'user_url', rt.new_string(''))
		} else {
			rt.set_property(var_user, 'user_url', rt.call_function('sanitize_url', [rt.get_superglobal('_POST').array_get(rt.new_string('url'))]))
			var_protocols = rt.call_function('implode', [rt.new_string('|'), rt.call_function('array_map', [rt.new_string('preg_quote'), rt.call_function('wp_allowed_protocols', []rt.PhpVal{})])])
			rt.set_property(var_user, 'user_url', if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^(' + (var_protocols).str() + '):/is'), rt.get_property(var_user, 'user_url')])) { rt.get_property(var_user, 'user_url') } else { 'http://' + (rt.get_property(var_user, 'user_url')).str() })
		}
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('first_name')) {
		rt.set_property(var_user, 'first_name', rt.call_function('sanitize_text_field', [rt.get_superglobal('_POST').array_get(rt.new_string('first_name'))]))
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('last_name')) {
		rt.set_property(var_user, 'last_name', rt.call_function('sanitize_text_field', [rt.get_superglobal('_POST').array_get(rt.new_string('last_name'))]))
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('nickname')) {
		rt.set_property(var_user, 'nickname', rt.call_function('sanitize_text_field', [rt.get_superglobal('_POST').array_get(rt.new_string('nickname'))]))
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('display_name')) {
		rt.set_property(var_user, 'display_name', rt.call_function('sanitize_text_field', [rt.get_superglobal('_POST').array_get(rt.new_string('display_name'))]))
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('description')) {
		rt.set_property(var_user, 'description', rt.new_string(rt.get_superglobal('_POST').array_get(rt.new_string('description')).to_string().trim_space()))
	}
	mut iter_1 := rt.call_function('wp_get_user_contact_methods', [var_user.clone()]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_name_shadow := item_1.val
		mut var_method_shadow := item_1.key
		if rt.get_superglobal('_POST').array_isset(var_method_shadow) {
			rt.set_property(var_user, '{"nodeType":"Expr_Variable","line":111,"name":"method"}', rt.call_function('sanitize_text_field', [rt.get_superglobal('_POST').array_get(var_method_shadow)]))
		}
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('locale')) {
		var_locale = rt.call_function('sanitize_text_field', [rt.get_superglobal('_POST').array_get(rt.new_string('locale'))])
		if rt.is_true(rt.identical(rt.new_string('site-default'), var_locale)) {
		var_locale = rt.new_string('')
		} else if rt.is_true(rt.identical(rt.new_string(''), var_locale)) {
		var_locale = rt.new_string('en_US')
		} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_locale.clone(), rt.call_function('get_available_languages', []rt.PhpVal{}), rt.new_bool(true)]))))) {
			if rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_languages')])) && rt.is_true(rt.call_function('wp_can_install_language_pack', []rt.PhpVal{})) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_download_language_pack', [var_locale.clone()]))))) {
				var_locale = rt.new_string('')
				}
			} else {
			var_locale = rt.new_string('')
			}
		}
		rt.set_property(var_user, 'locale', var_locale.clone())
	}
	if var_update {
		rt.set_property(var_user, 'rich_editing', if rt.get_superglobal('_POST').array_isset(rt.new_string('rich_editing')) && rt.is_true(rt.identical(rt.new_string('false'), rt.get_superglobal('_POST').array_get(rt.new_string('rich_editing')))) { 'false' } else { 'true' })
		rt.set_property(var_user, 'syntax_highlighting', if rt.get_superglobal('_POST').array_isset(rt.new_string('syntax_highlighting')) && rt.is_true(rt.identical(rt.new_string('false'), rt.get_superglobal('_POST').array_get(rt.new_string('syntax_highlighting')))) { 'false' } else { 'true' })
		rt.set_property(var_user, 'admin_color', if rt.get_superglobal('_POST').array_isset(rt.new_string('admin_color')) { rt.call_function('sanitize_text_field', [rt.get_superglobal('_POST').array_get(rt.new_string('admin_color'))]) } else { rt.new_string('modern') })
		rt.set_property(var_user, 'show_admin_bar_front', if rt.get_superglobal('_POST').array_isset(rt.new_string('admin_bar_front')) { 'true' } else { 'false' })
	}
	rt.set_property(var_user, 'comment_shortcuts', if rt.get_superglobal('_POST').array_isset(rt.new_string('comment_shortcuts')) && rt.is_true(rt.identical(rt.new_string('true'), rt.get_superglobal('_POST').array_get(rt.new_string('comment_shortcuts')))) { 'true' } else { '' })
	rt.set_property(var_user, 'use_ssl', rt.new_int(0))
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('use_ssl')))) {
		rt.set_property(var_user, 'use_ssl', rt.new_int(1))
	}
	var_errors = create_wp_error()
	if rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_user, 'user_login'))) {
		var_errors.add(rt.new_string('user_login'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> Please enter a username.')]))
	}
	if var_update && !rt.is_true(rt.get_property(var_user, 'nickname')) {
		var_errors.add(rt.new_string('nickname'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> Please enter a nickname.')]))
	}
	rt.call_function('do_action_ref_array', [rt.new_string('check_passwords'), rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_user, 'user_login') }, rt.ArrayItem{ key: none, val: var_pass1 }, rt.ArrayItem{ key: none, val: var_pass2 }])])
	if !(var_update) && var_pass1 == '' {
		var_errors.add(rt.new_string('pass'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> Please enter a password.')]), rt.create_array([rt.ArrayItem{ key: 'form-field', val: 'pass1' }]))
	}
	if rt.is_true(rt.call_function('str_contains', [rt.call_function('wp_unslash', [rt.new_string((var_pass1).str()).clone()]), rt.new_string('\\')])) {
		var_errors.add(rt.new_string('pass'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> Passwords may not contain the character "\\".')]), rt.create_array([rt.ArrayItem{ key: 'form-field', val: 'pass1' }]))
	}
	if var_update || !(var_pass1 == '') && rt.is_true(rt.new_bool(var_pass1 != var_pass2)) {
		var_errors.add(rt.new_string('pass'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> Passwords do not match. Please enter the same password in both password fields.')]), rt.create_array([rt.ArrayItem{ key: 'form-field', val: 'pass1' }]))
	}
	if !(var_pass1 == '') {
		rt.set_property(var_user, 'user_pass', rt.new_string((var_pass1).str()).clone())
	}
	if !(var_update) && rt.get_superglobal('_POST').array_isset(rt.new_string('user_login')) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('validate_username', [rt.get_superglobal('_POST').array_get(rt.new_string('user_login'))]))))) {
		var_errors.add(rt.new_string('user_login'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> This username is invalid because it uses illegal characters. Please enter a valid username.')]))
	}
	if !(var_update) && rt.is_true(rt.call_function('username_exists', [rt.get_property(var_user, 'user_login')])) {
		var_errors.add(rt.new_string('user_login'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> This username is already registered. Please choose another one.')]))
	}
	var_illegal_logins = rt.cast_array(rt.call_function('apply_filters', [rt.new_string('illegal_user_logins'), rt.new_array()]))
	if rt.is_true(rt.call_function('in_array', [rt.new_string(rt.get_property(var_user, 'user_login').to_string().to_lower()), rt.call_function('array_map', [rt.new_string('strtolower'), var_illegal_logins.clone()]), rt.new_bool(true)])) {
		var_errors.add(rt.new_string('invalid_username'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> Sorry, that username is not allowed.')]))
	}
	if !rt.is_true(rt.get_property(var_user, 'user_email')) {
		var_errors.add(rt.new_string('empty_email'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> Please enter an email address.')]), rt.create_array([rt.ArrayItem{ key: 'form-field', val: 'email' }]))
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [rt.get_property(var_user, 'user_email')]))))) {
		var_errors.add(rt.new_string('invalid_email'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> The email address is not correct.')]), rt.create_array([rt.ArrayItem{ key: 'form-field', val: 'email' }]))
	} else {
		var_owner_id = rt.call_function('email_exists', [rt.get_property(var_user, 'user_email')])
		if rt.is_true(var_owner_id) && !(var_update) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_owner_id, rt.get_property(var_user, 'ID'))))) {
			var_errors.add(rt.new_string('email_exists'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> This email is already registered. Please choose another one.')]), rt.create_array([rt.ArrayItem{ key: 'form-field', val: 'email' }]))
		}
	}
	rt.call_function('do_action_ref_array', [rt.new_string('user_profile_update_errors'), rt.create_array([rt.ArrayItem{ key: none, val: var_errors }, rt.ArrayItem{ key: none, val: var_update }, rt.ArrayItem{ key: none, val: var_user }])])
	if rt.is_true(var_errors.has_errors()) {
		return mut var_errors
	}
	if var_update {
	var_user_id = (rt.call_function('wp_update_user', [var_user.clone()])).to_i64()
	} else {
		var_user_id = (rt.call_function('wp_insert_user', [var_user.clone()])).to_i64()
		var_notify = if rt.get_superglobal('_POST').array_isset(rt.new_string('send_user_notification')) { 'both' } else { 'admin' }
		rt.call_function('do_action', [rt.new_string('edit_user_created_user'), rt.new_int(var_user_id), rt.new_string((var_notify).str()).clone()])
	}
	return mut var_user_id
}

fn get_editable_roles() rt.PhpVal {
	mut var_all_roles := rt.new_null()
	mut var_editable_roles := rt.new_null()
	var_all_roles = rt.get_property(rt.call_function('wp_roles', []rt.PhpVal{}), 'roles')
	var_editable_roles = rt.call_function('apply_filters', [rt.new_string('editable_roles'), var_all_roles.clone()])
	return var_editable_roles.clone()
}

fn get_user_to_edit(var_user_id rt.PhpVal) rt.PhpVal {
	mut var_user := rt.new_null()
	var_user = rt.call_function('get_userdata', [var_user_id.clone()])
	if rt.is_true(var_user) {
		rt.set_property(var_user, 'filter', rt.new_string('edit'))
	}
	return var_user.clone()
}

fn get_users_drafts(var_user_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query := rt.new_null()
	var_query = rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT ID, post_title FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_type = \'post\' AND post_status = \'draft\' AND post_author = %d ORDER BY post_modified DESC')), var_user_id.clone()])
	var_query = rt.call_function('apply_filters', [rt.new_string('get_users_drafts'), var_query.clone()])
	return rt.call_method(var_wpdb, 'get_results', [var_query.clone()])
}

fn wp_delete_user(var_id_arg rt.PhpVal, var_reassign_arg rt.PhpVal) bool {
	mut var_id := var_id_arg
	mut var_reassign := var_reassign_arg
	mut var_wpdb := rt.new_null()
	mut var_user := rt.new_null()
	mut var_post_types_to_delete := rt.new_null()
	mut var_post_type := rt.new_null()
	mut var_post_ids := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_link_ids := rt.new_null()
	mut var_link_id := rt.new_null()
	mut var_meta := rt.new_null()
	mut var_mid := rt.new_null()
	if !(var_id.clone().is_long() || var_id.clone().is_double()) {
		return false
	}
	var_id = rt.new_int((var_id).to_i64())
	var_user = create_wp_user(var_id.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_user, 'exists', []rt.PhpVal{}))))) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('novalue'), var_reassign)) {
	var_reassign = rt.new_null()
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_reassign)))) {
	var_reassign = rt.new_int((var_reassign).to_i64())
	}
	rt.call_function('do_action', [rt.new_string('delete_user'), var_id.clone(), var_reassign.clone(), var_user.clone()])
	if rt.is_true(rt.identical(rt.new_null(), var_reassign)) {
		var_post_types_to_delete = rt.new_array()
		mut iter_2 := rt.call_function('get_post_types', [rt.new_array(), rt.new_string('objects')]).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_post_type_shadow := item_2.val
			if rt.is_true(rt.get_property(var_post_type_shadow, 'delete_with_user')) {
				var_post_types_to_delete.array_push(rt.get_property(var_post_type_shadow, 'name'))
			} else if rt.is_true(rt.identical(rt.new_null(), rt.get_property(var_post_type_shadow, 'delete_with_user'))) && rt.is_true(rt.call_function('post_type_supports', [rt.get_property(var_post_type_shadow, 'name'), rt.new_string('author')])) {
				var_post_types_to_delete.array_push(rt.get_property(var_post_type_shadow, 'name'))
			}
		}
		var_post_types_to_delete = rt.call_function('apply_filters', [rt.new_string('post_types_to_delete_with_user'), var_post_types_to_delete.clone(), var_id.clone()])
		var_post_types_to_delete = rt.call_function('implode', [rt.new_string('\', \''), var_post_types_to_delete.clone()])
		var_post_ids = rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_author = %d AND post_type IN (\'')), var_post_types_to_delete), rt.new_string('\')')), var_id.clone()])])
		if rt.is_true(var_post_ids) {
			mut iter_3 := var_post_ids.iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_post_id_shadow := item_3.val
				rt.call_function('wp_delete_post', [var_post_id_shadow.clone()])
			}
		}
		var_link_ids = rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT link_id FROM '), rt.get_property(var_wpdb, 'links')), rt.new_string(' WHERE link_owner = %d')), var_id.clone()])])
		if rt.is_true(var_link_ids) {
			mut iter_4 := var_link_ids.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_link_id_shadow := item_4.val
				rt.call_function('wp_delete_link', [var_link_id_shadow.clone()])
			}
		}
	} else {
		var_post_ids = rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_author = %d')), var_id.clone()])])
		rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'posts'), rt.create_array([rt.ArrayItem{ key: 'post_author', val: var_reassign }]), rt.create_array([rt.ArrayItem{ key: 'post_author', val: var_id }])])
		if !(!rt.is_true(var_post_ids)) {
			mut iter_5 := var_post_ids.iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_post_id_shadow := item_5.val
				rt.call_function('clean_post_cache', [var_post_id_shadow.clone()])
			}
		}
		var_link_ids = rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT link_id FROM '), rt.get_property(var_wpdb, 'links')), rt.new_string(' WHERE link_owner = %d')), var_id.clone()])])
		rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'links'), rt.create_array([rt.ArrayItem{ key: 'link_owner', val: var_reassign }]), rt.create_array([rt.ArrayItem{ key: 'link_owner', val: var_id }])])
		if !(!rt.is_true(var_link_ids)) {
			mut iter_6 := var_link_ids.iterator()
			for {
				item_6 := iter_6.next() or { break }
				mut var_link_id_shadow := item_6.val
				rt.call_function('clean_bookmark_cache', [var_link_id_shadow.clone()])
			}
		}
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		rt.call_function('remove_user_from_blog', [var_id.clone(), rt.call_function('get_current_blog_id', []rt.PhpVal{})])
	} else {
		var_meta = rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT umeta_id FROM '), rt.get_property(var_wpdb, 'usermeta')), rt.new_string(' WHERE user_id = %d')), var_id.clone()])])
		mut iter_7 := var_meta.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_mid_shadow := item_7.val
			rt.call_function('delete_metadata_by_mid', [rt.new_string('user'), var_mid_shadow.clone()])
		}
		rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'users'), rt.create_array([rt.ArrayItem{ key: 'ID', val: var_id }])])
	}
	rt.call_function('clean_user_cache', [var_user.clone()])
	rt.call_function('do_action', [rt.new_string('deleted_user'), var_id.clone(), var_reassign.clone(), var_user.clone()])
	return true
}

fn wp_revoke_user(var_id_arg rt.PhpVal) {
	mut var_id := var_id_arg
	mut var_user := rt.new_null()
	var_id = rt.new_int((var_id).to_i64())
	var_user = create_wp_user(var_id.clone())
	rt.call_method(var_user, 'remove_all_caps', []rt.PhpVal{})
}

fn default_password_nag_handler(errors bool) {
	mut var_errors := errors
	mut var_user_ID := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_user_option', [rt.new_string('default_password_nag')]))))) {
		return
	}
	if rt.is_true(rt.identical(rt.new_string('hide'), rt.call_function('get_user_setting', [rt.new_string('default_password_nag')]))) || (rt.get_superglobal('_GET').array_isset(rt.new_string('default_password_nag')) && rt.is_true(rt.identical(rt.new_string('0'), rt.get_superglobal('_GET').array_get(rt.new_string('default_password_nag'))))) {
		rt.call_function('delete_user_setting', [rt.new_string('default_password_nag')])
		rt.call_function('update_user_meta', [var_user_ID.clone(), rt.new_string('default_password_nag'), rt.new_bool(false)])
	}
}

fn default_password_nag_edit_user(var_user_ID rt.PhpVal, var_old_data rt.PhpVal) {
	mut var_new_data := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_user_option', [rt.new_string('default_password_nag'), var_user_ID.clone()]))))) {
		return
	}
	var_new_data = rt.call_function('get_userdata', [var_user_ID.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_new_data, 'user_pass'), rt.get_property(var_old_data, 'user_pass'))))) {
		rt.call_function('delete_user_setting', [rt.new_string('default_password_nag')])
		rt.call_function('update_user_meta', [var_user_ID.clone(), rt.new_string('default_password_nag'), rt.new_bool(false)])
	}
}

fn default_password_nag() {
	mut var_pagenow := rt.new_null()
	mut var_default_password_nag_message := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('profile.php'), var_pagenow)) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_user_option', [rt.new_string('default_password_nag')]))))) {
		return
	}
	var_default_password_nag_message = rt.call_function('sprintf', [rt.new_string('<p><strong>%1$s</strong> %2$s</p>'), rt.call_function('__', [rt.new_string('Notice:')]), rt.call_function('__', [rt.new_string('You are using the auto-generated password for your account. Would you like to change it?')])])
	var_default_password_nag_message = rt.concat(var_default_password_nag_message, rt.call_function('sprintf', [rt.new_string('<p><a href="%1$s">%2$s</a> | '), rt.call_function('esc_url', [rt.new_string((rt.call_function('get_edit_profile_url', []rt.PhpVal{})).str() + '#password')]), rt.call_function('__', [rt.new_string('Yes, take me to my profile page')])]))
	var_default_password_nag_message = rt.concat(var_default_password_nag_message, rt.call_function('sprintf', [rt.new_string('<a href="%1$s" id="default-password-nag-no">%2$s</a></p>'), rt.new_string('?default_password_nag=0'), rt.call_function('__', [rt.new_string('No thanks, do not remind me again')])]))
	rt.call_function('wp_admin_notice', [var_default_password_nag_message.clone(), rt.create_array([rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'error' }, rt.ArrayItem{ key: none, val: 'default-password-nag' }]) }, rt.ArrayItem{ key: 'paragraph_wrap', val: false }])])
}

fn delete_users_add_js() {
	// unsupported statement: Stmt_InlineHTML
}

fn use_ssl_preference(var_user rt.PhpVal) {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Use https')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.new_string('1'), rt.get_property(var_user, 'use_ssl')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Always use https when visiting the admin')])
	// unsupported statement: Stmt_InlineHTML
}

fn admin_created_user_email(var_text rt.PhpVal) rt.PhpVal {
	mut var_roles := rt.new_null()
	mut var_role := rt.new_null()
	mut var_site_title := rt.new_null()
	var_roles = get_editable_roles()
	var_role = var_roles.array_get(rt.get_superglobal('_REQUEST').array_get(rt.new_string('role')))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.call_function('get_bloginfo', [rt.new_string('name')]))))) {
	var_site_title = rt.call_function('wp_specialchars_decode', [rt.call_function('get_bloginfo', [rt.new_string('name')]), rt.get_constant('ENT_QUOTES')])
	} else {
	var_site_title = rt.call_function('parse_url', [rt.call_function('home_url', []rt.PhpVal{}), rt.get_constant('PHP_URL_HOST')])
	}
	return rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Hi,\nYou\'ve been invited to join \'%1$s\' at\n%2$s with the role of %3$s.\nIf you do not want to join this site please ignore\nthis email. This invitation will expire in a few days.\n\nPlease click the following link to activate your user account:\n%%s')]), var_site_title.clone(), rt.call_function('home_url', []rt.PhpVal{}), rt.call_function('wp_specialchars_decode', [rt.call_function('translate_user_role', [var_role.array_get(rt.new_string('name'))])])])
}

fn wp_is_authorize_application_password_request_valid(var_request rt.PhpVal, var_user rt.PhpVal) rt.PhpVal {
	mut var_error := rt.new_null()
	mut var_validated_success_url := rt.new_null()
	mut var_validated_reject_url := rt.new_null()
	var_error = create_wp_error()
	if var_request.array_isset(rt.new_string('success_url')) {
		var_validated_success_url = rt.new_bool(wp_is_authorize_application_redirect_url_valid(var_request.array_get(rt.new_string('success_url'))))
		if rt.is_true(rt.call_function('is_wp_error', [var_validated_success_url.clone()])) {
			var_error.add(rt.call_method(var_validated_success_url, 'get_error_code', []rt.PhpVal{}), rt.call_method(var_validated_success_url, 'get_error_message', []rt.PhpVal{}))
		}
	}
	if var_request.array_isset(rt.new_string('reject_url')) {
		var_validated_reject_url = rt.new_bool(wp_is_authorize_application_redirect_url_valid(var_request.array_get(rt.new_string('reject_url'))))
		if rt.is_true(rt.call_function('is_wp_error', [var_validated_reject_url.clone()])) {
			var_error.add(rt.call_method(var_validated_reject_url, 'get_error_code', []rt.PhpVal{}), rt.call_method(var_validated_reject_url, 'get_error_message', []rt.PhpVal{}))
		}
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('app_id')))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_uuid', [var_request.array_get(rt.new_string('app_id'))]))))) {
		var_error.add(rt.new_string('invalid_app_id'), rt.call_function('__', [rt.new_string('The application ID must be a UUID.')]))
	}
	rt.call_function('do_action', [rt.new_string('wp_authorize_application_password_request_errors'), var_error, rt.create_array_from_native_map(var_request), var_user.clone()])
	if rt.is_true(var_error.has_errors()) {
		return rt.new_object('WP_Error', []string{}, var_error)
	}
	return rt.new_bool(true)
}

fn wp_is_authorize_application_redirect_url_valid(var_url rt.PhpVal) bool {
	mut var_bad_protocols := []rt.PhpVal{}
	mut var_valid_scheme_regex := ''
	mut var_invalid_protocols := rt.new_null()
	mut var_scheme := rt.new_null()
	mut var_host := rt.new_null()
	mut var_is_local := false
	mut var_is_loopback := rt.new_null()
	var_bad_protocols = ['javascript', 'data']
	if !rt.is_true(var_url) {
		return true
	}
	var_valid_scheme_regex = '/^[a-zA-Z][a-zA-Z0-9+.-]*:/'
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string((var_valid_scheme_regex).str()).clone(), var_url.clone()]))))) {
		return (create_wp_error(rt.new_string('invalid_redirect_url_format'), rt.call_function('__', [rt.new_string('Invalid URL format.')]))).to_bool()
	}
	var_invalid_protocols = rt.call_function('apply_filters', [rt.new_string('wp_authorize_application_redirect_url_invalid_protocols'), rt.create_array_from_list(var_bad_protocols), var_url.clone()])
	var_invalid_protocols = rt.call_function('array_map', [rt.new_string('strtolower'), var_invalid_protocols.clone()])
	var_scheme = rt.call_function('wp_parse_url', [var_url.clone(), rt.get_constant('PHP_URL_SCHEME')])
	var_host = rt.call_function('wp_parse_url', [var_url.clone(), rt.get_constant('PHP_URL_HOST')])
	var_is_local = (rt.identical(rt.new_string('local'), rt.call_function('wp_get_environment_type', []rt.PhpVal{}))).to_bool()
	if !rt.is_true(var_host) || !rt.is_true(var_scheme) || rt.is_true(rt.call_function('in_array', [rt.new_string(var_scheme.clone().to_string().to_lower()), var_invalid_protocols.clone(), rt.new_bool(true)])) {
		return (create_wp_error(rt.new_string('invalid_redirect_url_format'), rt.call_function('__', [rt.new_string('Invalid URL format.')]))).to_bool()
	}
	var_is_loopback = rt.call_function('in_array', [rt.new_string(var_host.clone().to_string().to_lower()), rt.create_array([rt.ArrayItem{ key: none, val: '127.0.0.1' }, rt.ArrayItem{ key: none, val: '[::1]' }]), rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_string('http'), var_scheme)) && !(var_is_local) && rt.is_true(rt.new_bool(!(rt.is_true(var_is_loopback)))) {
		return (create_wp_error(rt.new_string('invalid_redirect_scheme'), rt.call_function('__', [rt.new_string('The URL must be served over a secure connection.')]))).to_bool()
	}
	return true
}

struct Class_stdClass {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_User {
	rt.PhpObjectBase
}

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
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

fn create_wp_user(_args ...rt.PhpVal) &Class_WP_User {
	mut obj := &Class_WP_User{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

}
