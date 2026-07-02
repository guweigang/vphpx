import rt

struct Class_WP_Users_List_Table {
	rt.PhpObjectBase
pub mut:
	site_id       rt.PhpVal = rt.new_null()
	is_site_users bool
}

fn (mut this Class_WP_Users_List_Table) construct(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	this.Class_WP_List_Table.construct(rt.create_array([
		rt.ArrayItem{ key: 'singular', val: 'user' },
		rt.ArrayItem{ key: 'plural', val: 'users' },
		rt.ArrayItem{
			key: 'screen'
			val: if !(var_args_mutated.array_get(rt.new_string('screen'))).is_null() {
				var_args_mutated.array_get(rt.new_string('screen'))
			} else {
				rt.new_null()
			}
		},
	]))
	this.is_site_users = rt.identical(rt.new_string('site-users-network'), rt.get_property(rt.get_property(rt.new_object('WP_Users_List_Table', [
		'WP_List_Table',
	], &this), 'screen'), 'id'))
	if this.is_site_users {
		this.site_id = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('id')) {
			rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('id'))).to_i64())
		} else {
			0
		}
	}
}

fn (mut this Class_WP_Users_List_Table) ajax_user_can() rt.PhpVal {
	if this.is_site_users {
		return rt.call_function('current_user_can', [rt.new_string('manage_sites')])
	} else {
		return rt.call_function('current_user_can', [rt.new_string('list_users')])
	}
	return rt.new_null()
}

fn (mut this Class_WP_Users_List_Table) prepare_items() {
	mut var_role := rt.get_superglobal('role')
	mut var_usersearch := rt.get_superglobal('usersearch')
	var_usersearch = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('s')) { rt.call_function('wp_unslash', [
			rt.new_string(rt.get_superglobal('_REQUEST').array_get(rt.new_string('s')).to_string().trim_space()),
		]) } else { rt.new_string('') }
	var_role = if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('role'))).is_null() {
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('role'))
	} else {
		rt.new_string('')
	}
	mut var_per_page := rt.new_string((if this.is_site_users {
		'site_users_network_per_page'
	} else {
		'users_per_page'
	}).str())
	mut var_users_per_page := this.get_items_per_page(var_per_page.clone())
	mut var_paged := this.get_pagenum()
	if rt.is_true(rt.identical(rt.new_string('none'), var_role)) {
		mut var_args := rt.create_array([
			rt.ArrayItem{ key: 'number', val: var_users_per_page },
			rt.ArrayItem{ key: 'offset', val: rt.mul(rt.sub(var_paged, rt.new_int(1)),
				var_users_per_page) },
			rt.ArrayItem{ key: 'include', val: rt.call_function('wp_get_users_with_no_role', [
				this.site_id,
			]) },
			rt.ArrayItem{ key: 'search', val: var_usersearch },
			rt.ArrayItem{ key: 'fields', val: 'all_with_meta' },
		])
	} else {
		var_args = rt.create_array([
			rt.ArrayItem{ key: 'number', val: var_users_per_page },
			rt.ArrayItem{ key: 'offset', val: rt.mul(rt.sub(var_paged, rt.new_int(1)),
				var_users_per_page) },
			rt.ArrayItem{ key: 'role', val: var_role },
			rt.ArrayItem{ key: 'search', val: var_usersearch },
			rt.ArrayItem{ key: 'fields', val: 'all_with_meta' },
		])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''),
		var_args.array_get(rt.new_string('search'))))))
	{
		var_args.array_set('search',
			'*' + (var_args.array_get(rt.new_string('search'))).str() + '*')
	}
	if this.is_site_users {
		var_args.array_set('blog_id', this.site_id)
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('orderby')) {
		var_args.array_set('orderby',
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('orderby')))
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('order')) {
		var_args.array_set('order',
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('order')))
	}
	var_args = rt.call_function('apply_filters', [
		rt.new_string('users_list_table_query_args'),
		var_args.clone(),
	])
	mut var_wp_user_search := create_wp_user_query(var_args.clone())
	this.dispatch_set_prop('items', var_wp_user_search.get_results())
	this.set_pagination_args(rt.create_array([
		rt.ArrayItem{ key: 'total_items', val: var_wp_user_search.get_total() },
		rt.ArrayItem{ key: 'per_page', val: var_users_per_page },
	]))
}

fn (mut this Class_WP_Users_List_Table) no_items() {
	rt.call_function('_e', [rt.new_string('No users found.')])
}

fn (mut this Class_WP_Users_List_Table) get_views() rt.PhpVal {
	mut var_role := rt.new_null()
	mut var_wp_roles := rt.call_function('wp_roles', []rt.PhpVal{})
	mut var_count_users := rt.new_bool(!(rt.is_true(rt.call_function('wp_is_large_user_count',
		[]rt.PhpVal{}))))
	if this.is_site_users {
		mut var_url := rt.new_string('site-users.php?id=' + (this.site_id).str())
	} else {
		var_url = rt.new_string('users.php')
	}
	mut var_role_links := rt.new_array()
	mut var_avail_roles := rt.new_array()
	mut var_all_text := rt.call_function('__', [rt.new_string('All')])
	if rt.is_true(var_count_users) {
		if this.is_site_users {
			rt.call_function('switch_to_blog', [this.site_id])
			mut var_users_of_blog := rt.call_function('count_users', [
				rt.new_string('time'),
				this.site_id,
			])
			rt.call_function('restore_current_blog', []rt.PhpVal{})
		} else {
			var_users_of_blog = rt.call_function('count_users', []rt.PhpVal{})
		}
		mut var_total_users := var_users_of_blog.array_get(rt.new_string('total_users'))
		var_avail_roles = var_users_of_blog.array_get(rt.new_string('avail_roles'))
		var_users_of_blog = rt.new_null()
		var_all_text = rt.call_function('sprintf', [
			rt.call_function('_nx', [
				rt.new_string('All <span class="count">(%s)</span>'),
				rt.new_string('All <span class="count">(%s)</span>'),
				var_total_users.clone(),
				rt.new_string('users'),
			]),
			rt.call_function('number_format_i18n', [
				var_total_users.clone(),
			]),
		])
	}
	var_role_links.array_set('all', rt.create_array([
		rt.ArrayItem{ key: 'url', val: var_url },
		rt.ArrayItem{ key: 'label', val: var_all_text },
		rt.ArrayItem{ key: 'current', val: rt.new_bool(!rt.is_true(var_role)) },
	]))
	mut iter_1 := rt.call_method(var_wp_roles, 'get_names', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_name := item_1.val
		mut var_this_role := item_1.key
		if rt.is_true(var_count_users) && !(var_avail_roles.array_isset(var_this_role)) {
			continue
		}
		var_name = rt.call_function('translate_user_role', [var_name.clone()])
		if rt.is_true(var_count_users) {
			var_name = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('%1$s <span class="count">(%2$s)</span>'),
				]),
				var_name.clone(),
				rt.call_function('number_format_i18n', [
					var_avail_roles.array_get(var_this_role),
				]),
			])
		}
		var_role_links.array_set(var_this_role, rt.create_array([
			rt.ArrayItem{ key: 'url', val: rt.call_function('esc_url', [
				rt.call_function('add_query_arg', [rt.new_string('role'),
					var_this_role.clone(), var_url.clone()]),
			]) },
			rt.ArrayItem{ key: 'label', val: var_name },
			rt.ArrayItem{ key: 'current', val: rt.identical(var_this_role, var_role) },
		]))
	}
	if !(!rt.is_true(var_avail_roles.array_get(rt.new_string('none')))) {
		mut var_name := rt.call_function('__', [rt.new_string('No role')])
		var_name = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('%1$s <span class="count">(%2$s)</span>'),
			]),
			var_name.clone(),
			rt.call_function('number_format_i18n', [
				var_avail_roles.array_get(rt.new_string('none')),
			]),
		])
		var_role_links.array_set('none', rt.create_array([
			rt.ArrayItem{ key: 'url', val: rt.call_function('esc_url', [
				rt.call_function('add_query_arg', [rt.new_string('role'),
					rt.new_string('none'), var_url.clone()]),
			]) },
			rt.ArrayItem{ key: 'label', val: var_name },
			rt.ArrayItem{ key: 'current', val: rt.identical(rt.new_string('none'), var_role) },
		]))
	}
	return this.get_views_links(var_role_links.clone())
}

fn (mut this Class_WP_Users_List_Table) get_bulk_actions() rt.PhpVal {
	mut var_actions := rt.new_array()
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('remove_users'),
		]))
		{
			var_actions.array_set('remove', rt.call_function('__', [
				rt.new_string('Remove'),
			]))
		}
	} else {
		if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('delete_users'),
		]))
		{
			var_actions.array_set('delete', rt.call_function('__', [
				rt.new_string('Delete'),
			]))
		}
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_users')])) {
		var_actions.array_set('resetpassword', rt.call_function('__', [
			rt.new_string('Send password reset'),
		]))
	}
	return var_actions.clone()
}

fn (mut this Class_WP_Users_List_Table) extra_tablenav(var_which rt.PhpVal) {
	mut var_id := rt.new_string((if rt.is_true(rt.identical(rt.new_string('bottom'), var_which)) {
		'new_role2'
	} else {
		'new_role'
	}).str())
	mut var_button_id := rt.new_string((if rt.is_true(rt.identical(rt.new_string('bottom'),
		var_which))
	{
		'changeit2'
	} else {
		'changeit'
	}).str())
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('promote_users')]))
		&& rt.is_true(this.has_items()) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_id)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Change role to&hellip;')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_id)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_id)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Change role to&hellip;')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_dropdown_roles', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('&mdash; No role for this site &mdash;')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('submit_button', [
			rt.call_function('__', [rt.new_string('Change')]),
			rt.new_string(''),
			var_button_id.clone(),
			rt.new_bool(false),
		])
	}
	rt.call_function('do_action', [rt.new_string('restrict_manage_users'),
		var_which.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('manage_users_extra_tablenav'),
		var_which.clone()])
}

fn (mut this Class_WP_Users_List_Table) current_action() string {
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('changeit')) {
		return 'promote'
	}
	return (this.Class_WP_List_Table.current_action()).str()
}

fn (mut this Class_WP_Users_List_Table) get_columns() rt.PhpVal {
	mut var_columns := {
		'cb':       rt.new_string('<input type="checkbox" />')
		'username': rt.call_function('__', [rt.new_string('Username')])
		'name':     rt.call_function('__', [rt.new_string('Name')])
		'email':    rt.call_function('__', [rt.new_string('Email')])
		'role':     rt.call_function('__', [rt.new_string('Role')])
		'posts':    rt.call_function('_x', [rt.new_string('Posts'),
			rt.new_string('post type general name')])
	}
	if this.is_site_users {
		var_columns.delete('posts')
	}
	return var_columns.clone()
}

fn (mut this Class_WP_Users_List_Table) get_sortable_columns() rt.PhpVal {
	mut var_columns := {
		'username': map[string]rt.PhpVal{}
		'email':    map[string]rt.PhpVal{}
	}
	return var_columns.clone()
}

fn (mut this Class_WP_Users_List_Table) display_rows() {
	if !(this.is_site_users) {
		mut var_post_counts := rt.call_function('count_many_users_posts', [
			rt.func_array_keys(rt.get_property(rt.new_object('WP_Users_List_Table', [
				'WP_List_Table',
			], &this), 'items')),
		])
	}
	mut iter_2 := rt.get_property(rt.new_object('WP_Users_List_Table', [
		'WP_List_Table',
	], &this), 'items').iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_user_object := item_2.val
		mut var_userid := item_2.key
		print('\n\t' +(this.single_row(var_user_object.clone(), '', '', (if !var_post_counts.is_null() { var_post_counts.array_get(var_userid) } else { rt.new_int(0) }).to_i64())).str())
	}
}

fn (mut this Class_WP_Users_List_Table) single_row(var_user_object rt.PhpVal, style string, role string, numposts i64) rt.PhpVal {
	mut var_columns := map[string]rt.PhpVal{}
	mut var_hidden := rt.new_null()
	mut var_sortable := rt.new_null()
	mut var_primary := rt.new_null()
	mut var_user_object_mutated := var_user_object
	mut role_mutated := role
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_user_object_mutated,
		'WP_User'))))))
	{
		var_user_object_mutated = rt.call_function('get_userdata', [
			rt.new_int(var_user_object_mutated.to_i64()),
		])
	}
	rt.set_property(var_user_object_mutated, 'filter', rt.new_string('display'))
	mut var_email := rt.get_property(var_user_object_mutated, 'user_email')
	if this.is_site_users {
		mut var_url := rt.new_string((rt.concat(rt.concat(rt.new_string('site-users.php?id='),
			this.site_id), rt.new_string('&amp;'))).str())
	} else {
		var_url = rt.new_string('users.php?')
	}
	mut var_user_roles := this.get_role_list(var_user_object_mutated.clone())
	mut var_actions := rt.new_array()
	mut var_checkbox := rt.new_string('')
	mut var_super_admin := rt.new_string('')
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_users')])) {
		if rt.is_true(rt.call_function('in_array', [
			rt.get_property(var_user_object_mutated, 'user_login'),
			rt.call_function('get_super_admins', []rt.PhpVal{}),
			rt.new_bool(true),
		]))
		{
			var_super_admin = rt.new_string(' &mdash; ' +
				(rt.call_function('__', [rt.new_string('Super Admin')])).str())
		}
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('list_users')])) {
		mut var_edit_link := rt.call_function('esc_url', [
			rt.call_function('add_query_arg', [rt.new_string('wp_http_referer'),
				rt.call_function('urlencode', [
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
					]),
				]),
				rt.call_function('get_edit_user_link', [
					rt.get_property(var_user_object_mutated, 'ID'),
				])]),
		])
		if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_user'),
			rt.get_property(var_user_object_mutated, 'ID')]))
		{
			mut var_edit := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('<strong><a href="'),
				var_edit_link), rt.new_string('">')), rt.get_property(var_user_object_mutated,
				'user_login')), rt.new_string('</a>')), var_super_admin),
				rt.new_string('</strong><br />'))).str())
			var_actions.array_set('edit', '<a href="' + var_edit_link.str() + '">' +
				(rt.call_function('__', [rt.new_string('Edit')])).str() + '</a>')
		} else {
			var_edit = rt.new_string((rt.concat(rt.concat(rt.concat(rt.new_string('<strong>'), rt.get_property(var_user_object_mutated,
				'user_login')), var_super_admin), rt.new_string('</strong><br />'))).str())
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.get_property(var_user_object_mutated, 'ID')))))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_user'), rt.get_property(var_user_object_mutated, 'ID')])) {
			var_actions.array_set('delete', "<a class='submitdelete' href='" +
				(rt.call_function('wp_nonce_url', [rt.concat(rt.new_string('users.php?action=delete&amp;user='), rt.get_property(var_user_object_mutated, 'ID')), rt.new_string('bulk-users')])).str() +
				"'>" + (rt.call_function('__', [rt.new_string('Delete')])).str() + '</a>')
		}
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('remove_user'), rt.get_property(var_user_object_mutated, 'ID')])) {
			var_actions.array_set('remove', "<a class='submitdelete' href='" +
				(rt.call_function('wp_nonce_url', [rt.new_string(var_url.str() +
				rt.concat(rt.new_string('action=remove&amp;user='), rt.get_property(var_user_object_mutated, 'ID'))), rt.new_string('bulk-users')])).str() +
				"'>" + (rt.call_function('__', [rt.new_string('Remove')])).str() + '</a>')
		}
		mut var_author_posts_url := rt.call_function('get_author_posts_url', [
			rt.get_property(var_user_object_mutated, 'ID'),
		])
		if rt.is_true(var_author_posts_url) {
			var_actions.array_set('view', rt.call_function('sprintf', [
				rt.new_string('<a href="%s" aria-label="%s">%s</a>'),
				rt.call_function('esc_url', [var_author_posts_url.clone()]),
				rt.call_function('esc_attr', [
					rt.call_function('sprintf', [
						rt.call_function('__', [rt.new_string('View posts by %s')]),
						rt.get_property(var_user_object_mutated, 'display_name'),
					]),
				]),
				rt.call_function('__', [
					rt.new_string('View'),
				]),
			]))
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.get_property(var_user_object_mutated, 'ID')))))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_user'), rt.get_property(var_user_object_mutated, 'ID')]))
			&& rt.is_true(rt.identical(rt.new_bool(true), rt.call_function('wp_is_password_reset_allowed_for_user', [var_user_object_mutated.clone()]))) {
			var_actions.array_set('resetpassword', "<a class='resetpassword' href='" +
				(rt.call_function('wp_nonce_url', [rt.concat(rt.new_string('users.php?action=resetpassword&amp;users='), rt.get_property(var_user_object_mutated, 'ID')), rt.new_string('bulk-users')])).str() +
				"'>" + (rt.call_function('__', [rt.new_string('Send password reset')])).str() +
				'</a>')
		}
		var_actions = rt.call_function('apply_filters', [
			rt.new_string('user_row_actions'),
			var_actions.clone(),
			var_user_object_mutated.clone(),
		])
		mut var_role_classes := rt.call_function('esc_attr', [
			rt.call_function('implode',
				[rt.new_string(' '), rt.func_array_keys(var_user_roles.clone())]),
		])
		var_checkbox = rt.call_function('sprintf', [
			rt.new_string(
				'<input type="checkbox" name="users[]" id="user_%1$s" class="%2$s" value="%1$s" />' +
				'<label for="user_%1$s"><span class="screen-reader-text">%3$s</span></label>'),
			rt.get_property(var_user_object_mutated, 'ID'),
			var_role_classes.clone(),
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Select %s')]),
				rt.get_property(var_user_object_mutated, 'user_login'),
			]),
		])
	} else {
		var_edit = rt.new_string((rt.concat(rt.concat(rt.concat(rt.new_string('<strong>'), rt.get_property(var_user_object_mutated,
			'user_login')), var_super_admin), rt.new_string('</strong>'))).str())
	}
	mut var_avatar := rt.call_function('get_avatar', [
		rt.get_property(var_user_object_mutated, 'ID'),
		rt.new_int(32),
	])
	mut var_roles_list := rt.call_function('implode', [rt.new_string(', '),
		var_user_roles.clone()])
	mut var_row := rt.new_string((rt.concat(rt.concat(rt.new_string("<tr id='user-"),
		rt.get_property(var_user_object_mutated, 'ID')), rt.new_string("'>"))).str())
	mut list_tmp_1 := this.get_column_info()
	var_columns = list_tmp_1.array_get(0)
	var_hidden = list_tmp_1.array_get(1)
	var_sortable = list_tmp_1.array_get(2)
	var_primary = list_tmp_1.array_get(3)
	for var_column_name, var_column_display_name in var_columns {
		mut var_classes := rt.new_string('${var_column_name} column-${var_column_name}')
		if rt.is_true(rt.identical(var_primary, rt.new_string(column_name))) {
			var_classes = rt.concat(var_classes, rt.new_string(' has-row-actions column-primary'))
		}
		if rt.is_true(rt.identical(rt.new_string('posts'), rt.new_string(column_name))) {
			var_classes = rt.concat(var_classes, rt.new_string(' num'))
		}
		if rt.is_true(rt.call_function('in_array', [rt.new_string(column_name),
			var_hidden.clone(), rt.new_bool(true)]))
		{
			var_classes = rt.concat(var_classes, rt.new_string(' hidden'))
		}
		mut var_data := rt.new_string('data-colname="' +
			(rt.call_function('esc_attr', [rt.call_function('wp_strip_all_tags', [var_column_display_name.clone()])])).str() +
			'"')
		mut var_attributes :=
			rt.new_string("class='${var_classes.to_string()}' ${var_data.to_string()}")
		if rt.is_true(rt.identical(rt.new_string('cb'), rt.new_string(column_name))) {
			var_row = rt.concat(var_row,
				rt.new_string("<th scope='row' class='check-column'>${var_checkbox.to_string()}</th>"))
		} else {
			var_row = rt.concat(var_row, rt.new_string('<td ${var_attributes.to_string()}>'))
			mut switch_val_1 := rt.new_string(column_name)
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('username'))) {
				var_row = rt.concat(var_row,
					rt.new_string('${var_avatar.to_string()} ${var_edit.to_string()}'))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('name'))) {
				if rt.is_true(rt.get_property(var_user_object_mutated, 'first_name'))
					&& rt.is_true(rt.get_property(var_user_object_mutated, 'last_name')) {
					var_row = rt.concat(var_row, rt.call_function('sprintf', [
						rt.call_function('_x', [rt.new_string('%1$s %2$s'),
							rt.new_string('Display name based on first name and last name')]),
						rt.get_property(var_user_object_mutated, 'first_name'),
						rt.get_property(var_user_object_mutated, 'last_name'),
					]))
				} else if rt.is_true(rt.get_property(var_user_object_mutated, 'first_name')) {
					var_row = rt.concat(var_row, rt.get_property(var_user_object_mutated,
						'first_name'))
				} else if rt.is_true(rt.get_property(var_user_object_mutated, 'last_name')) {
					var_row = rt.concat(var_row, rt.get_property(var_user_object_mutated,
						'last_name'))
				} else {
					var_row = rt.concat(var_row, rt.call_function('sprintf', [
						rt.new_string('<span aria-hidden="true">&#8212;</span><span class="screen-reader-text">%s</span>'),
						rt.call_function('_x', [rt.new_string('Unknown'),
							rt.new_string('name')]),
					]))
				}
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('email'))) {
				var_row = rt.concat(var_row, rt.new_string("<a href='" +
					(rt.call_function('esc_url', [rt.new_string('mailto:${var_email.to_string()}')])).str() +
					"'>${var_email.to_string()}</a>"))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('role'))) {
				var_row = rt.concat(var_row, rt.call_function('esc_html', [
					var_roles_list.clone()]))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('posts'))) {
				if numposts > 0 {
					var_row = rt.concat(var_row, rt.call_function('sprintf', [
						rt.new_string('<a href="%s" class="edit"><span aria-hidden="true">%s</span><span class="screen-reader-text">%s</span></a>'),
						rt.concat(rt.new_string('edit.php?author='),
							rt.get_property(var_user_object_mutated, 'ID')),
						rt.new_int(numposts),
						rt.call_function('sprintf', [
							rt.call_function('_n', [
								rt.new_string('%s post by this author'),
								rt.new_string('%s posts by this author'),
								rt.new_int(numposts),
							]),
							rt.call_function('number_format_i18n', [
								rt.new_int(numposts),
							]),
						]),
					]))
				} else {
					var_row = rt.concat(var_row, rt.new_int(0))
				}
			} else {
				var_row = rt.concat(var_row, rt.call_function('apply_filters', [
					rt.new_string('manage_users_custom_column'),
					rt.new_string(''),
					rt.new_string(column_name),
					rt.get_property(var_user_object_mutated, 'ID'),
				]))
			}
			if rt.is_true(rt.identical(var_primary, rt.new_string(column_name))) {
				var_row = rt.concat(var_row, this.row_actions(var_actions.clone()))
			}
			var_row = rt.concat(var_row, rt.new_string('</td>'))
		}
	}
	var_row = rt.concat(var_row, rt.new_string('</tr>'))
	return var_row.clone()
}

fn (mut this Class_WP_Users_List_Table) get_default_primary_column_name() string {
	return 'username'
}

fn (mut this Class_WP_Users_List_Table) get_role_list(var_user_object rt.PhpVal) rt.PhpVal {
	mut var_user_object_mutated := var_user_object
	mut var_wp_roles := rt.call_function('wp_roles', []rt.PhpVal{})
	mut var_role_list := rt.new_array()
	mut iter_3 := rt.get_property(var_user_object_mutated, 'roles').iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_role := item_3.val
		if rt.get_property(var_wp_roles, 'role_names').array_isset(var_role) {
			var_role_list.array_set(var_role, rt.call_function('translate_user_role', [
				rt.get_property(var_wp_roles, 'role_names').array_get(var_role),
			]))
		}
	}
	if !rt.is_true(var_role_list) {
		var_role_list.array_set('none', rt.call_function('_x', [
			rt.new_string('None'), rt.new_string('no user roles')]))
	}
	return rt.call_function('apply_filters', [rt.new_string('get_role_list'),
		var_role_list.clone(), var_user_object_mutated.clone()])
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

struct Class_WP_User_Query {
	rt.PhpObjectBase
}

fn create_wp_users_list_table(arg_0 rt.PhpVal) &Class_WP_Users_List_Table {
	mut obj := &Class_WP_Users_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
		site_id:       rt.new_null()
		is_site_users: false
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_list_table(_args ...rt.PhpVal) &Class_WP_List_Table {
	mut obj := &Class_WP_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_user_query(_args ...rt.PhpVal) &Class_WP_User_Query {
	mut obj := &Class_WP_User_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Users_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'ajax_user_can' {
			return this.ajax_user_can()
		}
		'prepare_items' {
			this.prepare_items()
			return rt.new_null()
		}
		'no_items' {
			this.no_items()
			return rt.new_null()
		}
		'get_views' {
			return this.get_views()
		}
		'get_bulk_actions' {
			return this.get_bulk_actions()
		}
		'extra_tablenav' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.extra_tablenav(dispatch_arg_0)
			return rt.new_null()
		}
		'current_action' {
			return rt.new_string(this.current_action())
		}
		'get_columns' {
			return this.get_columns()
		}
		'get_sortable_columns' {
			return this.get_sortable_columns()
		}
		'display_rows' {
			this.display_rows()
			return rt.new_null()
		}
		'single_row' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			return this.single_row(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'get_default_primary_column_name' {
			return rt.new_string(this.get_default_primary_column_name())
		}
		'get_role_list' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_role_list(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Users_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'site_id' { return this.site_id }
		'is_site_users' { return rt.new_bool(this.is_site_users) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Users_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'site_id' {
			this.site_id = val
			return true
		}
		'is_site_users' {
			this.is_site_users = val.to_bool()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_User_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_User_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_User_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
