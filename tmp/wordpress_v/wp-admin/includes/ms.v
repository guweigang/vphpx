import rt

fn check_upload_size(var_file rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('get_site_option', [rt.new_string('upload_space_check_disabled')])) {
		return var_file.dup()
	}
	if rt.is_true(rt.greater(var_file.array_get('error'), rt.new_int(0))) {
		return var_file.dup()
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_IMPORTING')])) {
		return var_file.dup()
	}
	mut var_space_left := rt.call_function('get_upload_space_available', []rt.PhpVal{})
	mut var_file_size := rt.call_function('filesize', [var_file.array_get('tmp_name')])
	if rt.is_true(rt.less(var_space_left, var_file_size)) {
		var_file['error'] = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Not enough space to upload. %s KB needed.')]), rt.call_function('number_format', [rt.div(rt.sub(var_file_size, var_space_left), rt.get_constant('KB_IN_BYTES'))])])
	}
	if rt.is_true(rt.greater(var_file_size, rt.mul(rt.get_constant('KB_IN_BYTES'), rt.call_function('get_site_option', [rt.new_string('fileupload_maxk'), rt.new_int(1500)])))) {
		var_file['error'] = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This file is too big. Files must be less than %s KB in size.')]), rt.call_function('get_site_option', [rt.new_string('fileupload_maxk'), rt.new_int(1500)])])
	}
	if rt.is_true(rt.new_bool(upload_is_user_over_quota(false))) {
		var_file['error'] = rt.call_function('__', [rt.new_string('You have used your space quota. Please delete files before uploading.')])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_file.array_get('error'), rt.new_int(0))) && !(rt.get_superglobal('_POST').array_isset(rt.new_string('html-upload'))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{}))))))) {
		rt.call_function('wp_die', [(var_file.array_get('error')).str() + ' <a href="javascript:history.go(-1)">' + (rt.call_function('__', [rt.new_string('Back')])).str() + '</a>'])
	}
	return var_file.dup()
}

fn wpmu_delete_blog(var_blog_id rt.PhpVal, drop bool) {
	var_blog_id = // unsupported expression: Expr_Cast_Int
	mut var_switch := false
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_switch = true
		rt.call_function('switch_to_blog', [var_blog_id.dup()])
	}
	mut var_blog := rt.call_function('get_site', [var_blog_id.dup()])
	mut var_current_network := rt.call_function('get_network', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(var_drop && rt.is_true(rt.new_bool(!(rt.is_true(var_blog)))))) {
		drop = false
	}
	if rt.is_true(rt.new_bool(var_drop && rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(1), var_blog_id)) || rt.is_true(rt.call_function('is_main_site', [var_blog_id.dup()])))) || rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.get_property(var_blog, 'path'), rt.get_property(var_current_network, 'path'))) && rt.is_true(rt.identical(rt.get_property(var_blog, 'domain'), rt.get_property(var_current_network, 'domain'))))))))) {
		drop = false
	}
	mut var_upload_path := rt.call_function('get_option', [rt.new_string('upload_path')]).to_string().trim_space()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_drop && rt.is_true(rt.call_function('get_site_option', [rt.new_string('ms_files_rewriting')])))) && var_upload_path == '')) {
		drop = false
	}
	if var_drop {
		rt.call_function('wp_delete_site', [var_blog_id.dup()])
	} else {
		rt.call_function('do_action_deprecated', [rt.new_string('delete_blog'), rt.create_array([rt.ArrayItem{ key: none, val: var_blog_id }, rt.ArrayItem{ key: none, val: false }]), rt.new_string('5.1.0')])
		mut var_users := rt.call_function('get_users', [rt.create_array([rt.ArrayItem{ key: 'blog_id', val: var_blog_id }, rt.ArrayItem{ key: 'fields', val: 'ids' }])])
		if !(!rt.is_true(var_users)) {
			{
				mut iter_1 := var_users.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_user_id := item_1.val
					rt.call_function('remove_user_from_blog', [var_user_id.dup(), var_blog_id.dup()])
				}
			}
		}
		rt.call_function('update_blog_status', [var_blog_id.dup(), rt.new_string('deleted'), rt.new_int(1)])
		rt.call_function('do_action_deprecated', [rt.new_string('deleted_blog'), rt.create_array([rt.ArrayItem{ key: none, val: var_blog_id }, rt.ArrayItem{ key: none, val: false }]), rt.new_string('5.1.0')])
	}
	if var_switch {
		rt.call_function('restore_current_blog', []rt.PhpVal{})
	}
}

fn wpmu_delete_user(var_id rt.PhpVal) bool {
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
	mut var__super_admins := rt.call_function('get_super_admins', []rt.PhpVal{})
	if rt.is_true(rt.call_function('in_array', [rt.get_property(var_user, 'user_login'), var__super_admins.dup(), rt.new_bool(true)])) {
		return false
	}
	rt.call_function('do_action', [rt.new_string('wpmu_delete_user'), var_id.dup(), var_user.dup()])
	mut var_blogs := rt.call_function('get_blogs_of_user', [var_id.dup()])
	if !(!rt.is_true(var_blogs)) {
		{
			mut iter_1 := var_blogs.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_blog := item_1.val
				rt.call_function('switch_to_blog', [rt.get_property(var_blog, 'userblog_id')])
				rt.call_function('remove_user_from_blog', [var_id.dup(), rt.get_property(var_blog, 'userblog_id')])
				mut var_post_ids := rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_author = %d')), var_id.dup()])])
				{
					mut iter_2 := rt.cast_array(var_post_ids).iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_post_id := item_2.val
						rt.call_function('wp_delete_post', [var_post_id.dup()])
					}
				}
				mut var_link_ids := rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT link_id FROM '), rt.get_property(var_wpdb, 'links')), rt.new_string(' WHERE link_owner = %d')), var_id.dup()])])
				if rt.is_true(var_link_ids) {
					{
						mut iter_2 := var_link_ids.iterator()
						for {
							item_2 := iter_2.next() or { break }
							mut var_link_id := item_2.val
							rt.call_function('wp_delete_link', [var_link_id.dup()])
						}
					}
				}
				rt.call_function('restore_current_blog', []rt.PhpVal{})
			}
		}
	}
	mut var_meta := rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT umeta_id FROM '), rt.get_property(var_wpdb, 'usermeta')), rt.new_string(' WHERE user_id = %d')), var_id.dup()])])
	{
		mut iter_1 := var_meta.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_mid := item_1.val
			rt.call_function('delete_metadata_by_mid', [rt.new_string('user'), var_mid.dup()])
		}
	}
	rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'users'), rt.create_array([rt.ArrayItem{ key: 'ID', val: var_id }])])
	rt.call_function('clean_user_cache', [var_user.dup()])
	rt.call_function('do_action', [rt.new_string('deleted_user'), var_id.dup(), rt.new_null(), var_user.dup()])
	return true
}

fn upload_is_user_over_quota(display_message bool) bool {
	if rt.is_true(rt.call_function('get_site_option', [rt.new_string('upload_space_check_disabled')])) {
		return false
	}
	mut var_space_allowed := rt.call_function('get_space_allowed', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_space_allowed.dup().is_long() || var_space_allowed.dup().is_double()))))) {
		var_space_allowed = rt.new_int(rt.new_int(10))
		// unsupported statement: Stmt_Nop
	}
	mut var_space_used := rt.call_function('get_space_used', []rt.PhpVal{})
	if rt.is_true(rt.less(rt.sub(var_space_allowed, var_space_used), rt.new_int(0))) {
		if var_display_message {
			rt.call_function('printf', [rt.call_function('__', [rt.new_string('Sorry, you have used your space allocation of %s. Please delete some files to upload more files.')]), rt.call_function('size_format', [rt.mul(var_space_allowed, rt.get_constant('MB_IN_BYTES'))])])
		}
		return true
	} else {
		return false
	}
	return false
}

fn display_space_usage() {
	mut var_space_allowed := rt.call_function('get_space_allowed', []rt.PhpVal{})
	mut var_space_used := rt.call_function('get_space_used', []rt.PhpVal{})
	mut var_percent_used := rt.mul(rt.div(var_space_used, var_space_allowed), rt.new_int(100))
	mut var_space := rt.call_function('size_format', [rt.mul(var_space_allowed, rt.get_constant('MB_IN_BYTES'))])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('__', [rt.new_string('Used: %1$s%% of %2$s')]), rt.call_function('number_format', [var_percent_used.dup()]), var_space.dup()])
	// unsupported statement: Stmt_InlineHTML
}

fn fix_import_form_size(var_size rt.PhpVal) i64 {
	if rt.is_true(rt.new_bool(upload_is_user_over_quota(false))) {
		return 0
	}
	mut var_available := rt.call_function('get_upload_space_available', []rt.PhpVal{})
	return (rt.call_function('min', [var_size.dup(), var_available.dup()])).to_i64()
}

fn upload_space_setting(var_id rt.PhpVal) {
	rt.call_function('switch_to_blog', [var_id.dup()])
	mut var_quota := rt.call_function('get_option', [rt.new_string('blog_upload_space')])
	rt.call_function('restore_current_blog', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_quota)))) {
		var_quota = rt.new_string(rt.new_string(''))
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Site Upload Space Quota')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_quota.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Size in megabytes')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('MB (Leave blank for network default)')])
	// unsupported statement: Stmt_InlineHTML
}

fn refresh_user_details(var_id rt.PhpVal) bool {
	var_id = // unsupported expression: Expr_Cast_Int
	mut var_user := rt.call_function('get_userdata', [var_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return false
	}
	rt.call_function('clean_user_cache', [var_user.dup()])
	return (var_id).to_bool()
}

fn format_code_lang(code string) rt.PhpVal {
	
}

struct Class_WP_User {
	rt.PhpObjectBase
}

fn create_wp_user() &Class_WP_User {
	mut obj := &Class_WP_User{
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




pub fn init_wp_admin_includes_ms_php() {
}
