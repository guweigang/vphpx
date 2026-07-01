import rt

fn add_user() rt.PhpVal {
	return rt.new_object('WP_Error', []string{}, edit_user(0))
}

fn edit_user(user_id i64) rt.PhpVal {
	mut var_wp_roles := rt.call_function('wp_roles', []rt.PhpVal{})
	mut var_user := create_stdclass()
	user_id = (// unsupported expression: Expr_Cast_Int).to_i64()
	if var_user_id != 0 {
		mut var_update := true
		rt.set_property(var_user, 'ID', rt.new_int(user_id))
		mut var_userdata := rt.call_function('get_userdata', [rt.new_int(user_id)])
		rt.set_property(var_user, 'user_login', rt.call_function('wp_slash', [rt.get_property(var_userdata, 'user_login')]))
	} else {
		var_update = false
	}
	if !(var_update) && rt.get_superglobal('_POST').array_isset(rt.new_string('user_login')) {
		rt.set_property(var_user, 'user_login', rt.call_function('sanitize_user', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('user_login')]), rt.new_bool(true)]))
	}
	mut var_pass1 := ''
	mut var_pass2 := ''
	if rt.get_superglobal('_POST').array_isset(rt.new_string('pass1')) {
		var_pass1 = rt.get_superglobal('_POST').array_get('pass1').to_string().trim_space()
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('pass2')) {
		var_pass2 = rt.get_superglobal('_POST').array_get('pass2').to_string().trim_space()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('role')) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('promote_users')])))) && rt.is_true(rt.new_bool(!(var_user_id != 0) || rt.is_true(rt.call_function('current_user_can', [rt.new_string('promote_user'), rt.new_int(user_id)])))))) {
		mut var_new_role := rt.call_function('sanitize_text_field', [rt.get_superglobal('_POST').array_get('role')])
		mut var_editable_roles := get_editable_roles()
		if !(!rt.is_true(var_new_role)) && !rt.is_true(var_editable_roles.array_get(var_new_role)) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to give users that role.')]), rt.new_int(403)])
		}
		mut var_potential_role := if !(rt.get_property(var_wp_roles, 'role_objects').array_get(var_new_role)).is_null() { rt.get_property(var_wp_roles, 'role_objects').array_get(var_new_role) } else { rt.new_bool(false) }
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_users')])))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) || rt.is_true(rt.new_bool(rt.is_true(var_potential_role) && rt.is_true(rt.call_method(var_potential_role, 'has_cap', [rt.new_string('promote_users')])))))) {
			rt.set_property(var_user, 'role', var_new_role.dup())
		}
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('email')) {
		rt.set_property(var_user, 'user_email', rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('email')])]))
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('url')) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.get_superglobal('_POST').array_get('url')) || rt.is_true(rt.identical(rt.new_string('http://'), rt.get_superglobal('_POST').array_get('url'))))) {
			rt.set_property(var_user, 'user_url', rt.new_string(''))
		} else {
			rt.set_property(var_user, 'user_url', rt.call_function('sanitize_url', [rt.get_superglobal('_POST').array_get('url')]))
			mut var_protocols := rt.call_function('implode', [rt.new_string('|'), rt.call_function('array_map', [rt.new_string('preg_quote'), rt.call_function('wp_allowed_protocols', []rt.PhpVal{})])])
			rt.set_property(var_user, 'user_url', if rt.is_true(rt.call_function('preg_match', ['/^(' + (var_protocols).str() + '):/is', rt.get_property(var_user, 'user_url')])) { rt.get_property(var_user, 'user_url') } else { 'http://' + (rt.get_property(var_user, 'user_url')).str() })
		}
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('first_name')) {
		rt.set_property(var_user, 'first_name', rt.call_function('sanitize_text_field', [rt.get_superglobal('_POST').array_get('first_name')]))
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('last_name')) {
		rt.set_property(var_user, 'last_name', rt.call_function('sanitize_text_field', [rt.get_superglobal('_POST').array_get('last_name')]))
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('nickname')) {
		rt.set_property(var_user, 'nickname', rt.call_function('sanitize_text_field', [rt.get_superglobal('_POST').array_get('nickname')]))
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('display_name')) {
		rt.set_property(var_user, 'display_name', rt.call_function('sanitize_text_field', [rt.get_superglobal('_POST').array_get('display_name')]))
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('description')) {
		rt.set_property(var_user, 'description', rt.new_string(rt.get_superglobal('_POST').array_get('description').to_string().trim_space()))
	}
	{
		mut iter_1 := rt.call_function('wp_get_user_contact_methods', [var_user.dup()]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_name := item_1.val
			mut var_method := item_1.key
			if rt.get_superglobal('_POST').array_isset(var_method) {
				rt.set_property(var_user, '{"nodeType":"Expr_Variable","line":111,"name":"method"}', rt.call_function('sanitize_text_field', [rt.get_superglobal('_POST').array_get(var_method)]))
			}
		}
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('locale')) {
		mut var_locale := rt.call_function('sanitize_text_field', [rt.get_superglobal('_POST').array_get('locale')])
		if rt.is_true(rt.identical(rt.new_string('site-default'), var_locale)) {
			var_locale = rt.new_string(rt.new_string(''))
		} else if rt.is_true(rt.identical(rt.new_string(''), var_locale)) {
			var_locale = rt.new_string(rt.new_string('en_US'))
		} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_locale.dup(), rt.call_function('get_available_languages', []rt.PhpVal{}), rt.new_bool(true)]))))) {
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_languages')])) && rt.is_true(rt.call_function('wp_can_install_language_pack', []rt.PhpVal{})))) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_download_language_pack', [var_locale.dup()]))))) {
					var_locale = rt.new_string(rt.new_string(''))
				}
			} else {
				var_locale = rt.new_string(rt.new_string(''))
			}
		}
		rt.set_property(var_user, 'locale', var_locale.dup())
	}
	if var_update {
		rt.set_property(var_user, 'rich_editing', if rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('rich_editing')) && rt.is_true(rt.identical(rt.new_string('false'), rt.get_superglobal('_POST').array_get('rich_editing'))))) { rt.new_string('false') } else { rt.new_string('true') })
		rt.set_property(var_user, 'syntax_highlighting', if rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('syntax_highlighting')) && rt.is_true(rt.identical(rt.new_string('false'), rt.get_superglobal('_POST').array_get('syntax_highlighting'))))) { rt.new_string('false') } else { rt.new_string('true') })
		rt.set_property(var_user, 'admin_color', if rt.get_superglobal('_POST').array_isset(rt.new_string('admin_color')) { rt.call_function('sanitize_text_field', [rt.get_superglobal('_POST').array_get('admin_color')]) } else { rt.new_string('modern') })
		rt.set_property(var_user, 'show_admin_bar_front', if rt.get_superglobal('_POST').array_isset(rt.new_string('admin_bar_front')) { rt.new_string('true') } else { rt.new_string('false') })
	}
	rt.set_property(var_user, 'comment_shortcuts', if rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('comment_shortcuts')) && rt.is_true(rt.identical(rt.new_string('true'), rt.get_superglobal('_POST').array_get('comment_shortcuts'))))) { rt.new_string('true') } else { rt.new_string('') })
	rt.set_property(var_user, 'use_ssl', rt.new_int(0))
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get('use_ssl'))) {
		rt.set_property(var_user, 'use_ssl', rt.new_int(1))
	}
	mut var_errors := create_wp_error()
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
	if rt.is_true(rt.call_function('str_contains', [rt.call_function('wp_unslash', [rt.new_string(var_pass1).dup()]), rt.new_string('\\')])) {
		var_errors.add(rt.new_string('pass'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> Passwords may not contain the character "\\".')]), rt.create_array([rt.ArrayItem{ key: 'form-field', val: 'pass1' }]))
	}
	if rt.is_true(rt.new_bool(var_update || !(var_pass1 == '') && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_errors.add(rt.new_string('pass'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> Passwords do not match. Please enter the same password in both password fields.')]), rt.create_array([rt.ArrayItem{ key: 'form-field', val: 'pass1' }]))
	}
	if !(var_pass1 == '') {
		rt.set_property(var_user, 'user_pass', rt.new_string(var_pass1).dup())
	}
	if rt.is_true(rt.new_bool(!(var_update) && rt.get_superglobal('_POST').array_isset(rt.new_string('user_login')) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('validate_username', [rt.get_superglobal('_POST').array_get('user_login')]))))))) {
		var_errors.add(rt.new_string('user_login'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> This username is invalid because it uses illegal characters. Please enter a valid username.')]))
	}
	if rt.is_true(rt.new_bool(!(var_update) && rt.is_true(rt.call_function('username_exists', [rt.get_property(var_user, 'user_login')])))) {
		var_errors.add(rt.new_string('user_login'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> This username is already registered. Please choose another one.')]))
	}
	mut var_illegal_logins := rt.cast_array(rt.call_function('apply_filters', [rt.new_string('illegal_user_logins'), rt.new_array()]))
	if rt.is_true(rt.call_function('in_array', [rt.new_string(rt.get_property(var_user, 'user_login').to_string().to_lower()), rt.call_function('array_map', [rt.new_string('strtolower'), var_illegal_logins.dup()]), rt.new_bool(true)])) {
		var_errors.add(rt.new_string('invalid_username'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> Sorry, that username is not allowed.')]))
	}
	if !rt.is_true(rt.get_property(var_user, 'user_email')) {
		var_errors.add(rt.new_string('empty_email'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> Please enter an email address.')]), rt.create_array([rt.ArrayItem{ key: 'form-field', val: 'email' }]))
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [rt.get_property(var_user, 'user_email')]))))) {
		var_errors.add(rt.new_string('invalid_email'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> The email address is not correct.')]), rt.create_array([rt.ArrayItem{ key: 'form-field', val: 'email' }]))
	} else {
		mut var_owner_id := rt.call_function('email_exists', [rt.get_property(var_user, 'user_email')])
		if rt.is_true(rt.new_bool(rt.is_true(var_owner_id) && rt.is_true(rt.new_bool(!(var_update) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))))) {
			var_errors.add(rt.new_string('email_exists'), rt.call_function('__', [rt.new_string('<strong>Error:</strong> This email is already registered. Please choose another one.')]), rt.create_array([rt.ArrayItem{ key: 'form-field', val: 'email' }]))
		}
	}
	rt.call_function('do_action_ref_array', [rt.new_string('user_profile_update_errors'), rt.create_array([rt.ArrayItem{ key: none, val: var_errors }, rt.ArrayItem{ key: none, val: var_update }, rt.ArrayItem{ key: none, val: var_user }])])
	if rt.is_true(var_errors.has_errors()) {
		return mut var_errors
	}
	if var_update {
		user_id = (rt.call_function('wp_update_user', [var_user.dup()])).to_i64()
	} else {
		user_id = (rt.call_function('wp_insert_user', [var_user.dup()])).to_i64()
		mut var_notify := if rt.get_superglobal('_POST').array_isset(rt.new_string('send_user_notification')) { 'both' } else { 'admin' }
		rt.call_function('do_action', [rt.new_string('edit_user_created_user'), rt.new_int(user_id), rt.new_string(var_notify).dup()])
	}
	return mut user_id
}

fn get_editable_roles() rt.PhpVal {
	mut var_all_roles := rt.get_property(rt.call_function('wp_roles', []rt.PhpVal{}), 'roles')
	mut var_editable_roles := rt.call_function('apply_filters', [rt.new_string('editable_roles'), var_all_roles.dup()])
	return var_editable_roles.dup()
}

fn get_user_to_edit(var_user_id rt.PhpVal) rt.PhpVal {
	mut var_user := rt.call_function('get_userdata', [var_user_id.dup()])
	if rt.is_true(var_user) {
		rt.set_property(var_user, 'filter', rt.new_string('edit'))
	}
	return var_user.dup()
}

fn get_users_drafts(var_user_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_query := rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT ID, post_title FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_type = \'post\' AND post_status = \'draft\' AND post_author = %d ORDER BY post_modified DESC')), var_user_id.dup()])
	var_query = rt.call_function('apply_filters', [rt.new_string('get_users_drafts'), var_query.dup()])
	return rt.call_method(var_wpdb, 'get_results', [var_query.dup()])
}

fn wp_delete_user(var_id rt.PhpVal, var_reassign rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_id.dup().is_long() || var_id.dup().is_double()))))) {
		return false
	}
	var_id = // unsupported expression: Expr_Cast_Int
	mut var_user := create_wp_user(var_id.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_user, 'exists', []rt.PhpVal{}))))) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('novalue'), var_reassign)) {
		var_reassign = rt.new_null()
	} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_reassign = // unsupported expression: Expr_Cast_Int
	}
	rt.call_function('do_action', [rt.new_string('delete_user'), var_id.dup(), var_reassign.dup(), var_user.dup()])
	if rt.is_true(rt.identical(rt.new_null(), var_reassign)) {
		mut var_post_types_to_delete := rt.new_array()
		{
			mut iter_1 := rt.call_function('get_post_types', [rt.new_array(), rt.new_string('objects')]).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_post_type := item_1.val
				if rt.is_true(rt.get_property(var_post_type, 'delete_with_user')) {
					var_post_types_to_delete.array_push(rt.get_property(var_post_type, 'name'))
				} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_null(), rt.get_property(var_post_type, 'delete_with_user'))) && rt.is_true(rt.call_function('post_type_supports', [rt.get_property(var_post_type, 'name'), rt.new_string('author')])))) {
					var_post_types_to_delete.array_push(rt.get_property(var_post_type, 'name'))
				}
			}
		}
		var_post_types_to_delete = rt.call_function('apply_filters', [rt.new_string('post_types_to_delete_with_user'), var_post_types_to_delete.dup(), var_id.dup()])
		var_post_types_to_delete = rt.call_function('implode', [, .dup()])
		mut var_post_ids := 
		if rt.is_true() {
		}
		
	} else {
	}
	if rt.is_true() {
	} else {
	}
	
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

fn create_stdclass() &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
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




pub fn init_wp_admin_includes_user_php() {
}
