import rt

struct Class_WP_MS_Users_List_Table {
	rt.PhpObjectBase
}

fn (mut this Class_WP_MS_Users_List_Table) ajax_user_can() rt.PhpVal {
	return rt.call_function('current_user_can', [rt.new_string('manage_network_users')])
}

fn (mut this Class_WP_MS_Users_List_Table) prepare_items()  {
	// unsupported statement: Stmt_Global
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('mode'))) {
		mut var_mode := rt.new_string(if rt.is_true(rt.identical(rt.new_string('excerpt'), rt.get_superglobal('_REQUEST').array_get('mode'))) { rt.new_string('excerpt') } else { rt.new_string('list') })
		rt.call_function('set_user_setting', [rt.new_string('network_users_list_mode'), var_mode.dup()])
	} else {
		var_mode = rt.call_function('get_user_setting', [rt.new_string('network_users_list_mode'), rt.new_string('list')])
	}
	mut var_usersearch := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('s')) { rt.call_function('wp_unslash', [rt.new_string(rt.get_superglobal('_REQUEST').array_get('s').to_string().trim_space())]) } else { rt.new_string('') }
	mut var_users_per_page := this.get_items_per_page(rt.new_string('users_network_per_page'))
	mut var_role := if !(rt.get_superglobal('_REQUEST').array_get('role')).is_null() { rt.get_superglobal('_REQUEST').array_get('role') } else { rt.new_string('') }
	mut var_paged := this.get_pagenum()
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'number', val: var_users_per_page }, rt.ArrayItem{ key: 'offset', val: rt.mul(rt.sub(var_paged, rt.new_int(1)), var_users_per_page) }, rt.ArrayItem{ key: 'search', val: var_usersearch }, rt.ArrayItem{ key: 'blog_id', val: 0 }, rt.ArrayItem{ key: 'fields', val: 'all_with_meta' }])
	if rt.is_true(rt.call_function('wp_is_large_network', [rt.new_string('users')])) {
		var_args.array_set('search', var_args.array_get('search').to_string().trim_left(' \t\n\r'))
	} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_args.array_set('search', var_args.array_get('search').to_string().trim_space())
		var_args.array_set('search', '*' + (var_args.array_get('search')).str() + '*')
	}
	if rt.is_true(rt.identical(rt.new_string('super'), var_role)) {
		var_args.array_set('login__in', rt.call_function('get_super_admins', []rt.PhpVal{}))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_usersearch)))) && rt.is_true(rt.call_function('wp_is_large_network', [rt.new_string('users')])))) {
		if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('orderby'))) {
			rt.get_superglobal('_GET').array_set('orderby', 'id')
			rt.get_superglobal('_REQUEST').array_set('orderby', 'id')
		}
		if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('order'))) {
			rt.get_superglobal('_GET').array_set('order', 'DESC')
			rt.get_superglobal('_REQUEST').array_set('order', 'DESC')
		}
		var_args.array_set('count_total', false)
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('orderby')) {
		var_args.array_set('orderby', rt.get_superglobal('_REQUEST').array_get('orderby'))
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('order')) {
		var_args.array_set('order', rt.get_superglobal('_REQUEST').array_get('order'))
	}
	var_args = rt.call_function('apply_filters', [rt.new_string('users_list_table_query_args'), var_args.dup()])
	mut var_wp_user_search := create_wp_user_query(var_args.dup())
	this.dispatch_set_prop('items', var_wp_user_search.get_results())
	this.set_pagination_args(rt.create_array([rt.ArrayItem{ key: 'total_items', val: var_wp_user_search.get_total() }, rt.ArrayItem{ key: 'per_page', val: var_users_per_page }]))
}

fn (mut this Class_WP_MS_Users_List_Table) get_bulk_actions() rt.PhpVal {
	mut var_actions := rt.new_array()
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_users')])) {
		var_actions.array_set('delete', rt.call_function('__', [rt.new_string('Delete')]))
	}
	var_actions.array_set('spam', rt.call_function('_x', [rt.new_string('Mark as spam'), rt.new_string('user')]))
	var_actions.array_set('notspam', rt.call_function('_x', [rt.new_string('Not spam'), rt.new_string('user')]))
	return var_actions.dup()
}

fn (mut this Class_WP_MS_Users_List_Table) no_items()  {
	rt.call_function('_e', [rt.new_string('No users found.')])
}

fn (mut this Class_WP_MS_Users_List_Table) get_views() rt.PhpVal {
	mut var_role := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_total_users := rt.call_function('get_user_count', []rt.PhpVal{})
	mut var_super_admins := rt.call_function('get_super_admins', []rt.PhpVal{})
	mut var_total_admins := rt.new_int(rt.new_int(var_super_admins.dup().array_count()))
	mut var_role_links := rt.new_array()
	var_role_links['all'] = rt.create_array([rt.ArrayItem{ key: 'url', val: rt.call_function('network_admin_url', [rt.new_string('users.php')]) }, rt.ArrayItem{ key: 'label', val: rt.call_function('sprintf', [rt.call_function('_nx', [rt.new_string('All <span class="count">(%s)</span>'), rt.new_string('All <span class="count">(%s)</span>'), var_total_users.dup(), rt.new_string('users')]), rt.call_function('number_format_i18n', [var_total_users.dup()])]) }, rt.ArrayItem{ key: 'current', val: // unsupported expression: Expr_BinaryOp_NotIdentical }])
	var_role_links['super'] = rt.create_array([rt.ArrayItem{ key: 'url', val: rt.call_function('network_admin_url', [rt.new_string('users.php?role=super')]) }, rt.ArrayItem{ key: 'label', val: rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('Super Admin <span class="count">(%s)</span>'), rt.new_string('Super Admins <span class="count">(%s)</span>'), var_total_admins.dup()]), rt.call_function('number_format_i18n', [var_total_admins.dup()])]) }, rt.ArrayItem{ key: 'current', val: rt.identical(rt.new_string('super'), var_role) }])
	return this.get_views_links(var_role_links.dup())
}

fn (mut this Class_WP_MS_Users_List_Table) pagination(var_which rt.PhpVal)  {
	mut var_mode := rt.new_null()
	// unsupported statement: Stmt_Global
	this.Class_WP_List_Table.pagination(var_which.dup())
	if rt.is_true(rt.identical(rt.new_string('top'), var_which)) {
		this.view_switcher(var_mode.dup())
	}
}

fn (mut this Class_WP_MS_Users_List_Table) get_columns() rt.PhpVal {
	mut var_users_columns := { 'cb': rt.new_string('<input type="checkbox" />'), 'username': rt.call_function('__', [rt.new_string('Username')]), 'name': rt.call_function('__', [rt.new_string('Name')]), 'email': rt.call_function('__', [rt.new_string('Email')]), 'registered': rt.call_function('_x', [rt.new_string('Registered'), rt.new_string('user')]), 'blogs': rt.call_function('__', [rt.new_string('Sites')]) }
	return rt.call_function('apply_filters', [rt.new_string('wpmu_users_columns'), var_users_columns.dup()])
}

fn (mut this Class_WP_MS_Users_List_Table) get_sortable_columns() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'username', val: rt.create_array([rt.ArrayItem{ key: none, val: 'login' }, rt.ArrayItem{ key: none, val: false }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Username')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Table ordered by Username.')]) }, rt.ArrayItem{ key: none, val: 'asc' }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: false }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Name')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Table ordered by Name.')]) }]) }, rt.ArrayItem{ key: 'email', val: rt.create_array([rt.ArrayItem{ key: none, val: 'email' }, rt.ArrayItem{ key: none, val: false }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('E-mail')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Table ordered by E-mail.')]) }]) }, rt.ArrayItem{ key: 'registered', val: rt.create_array([rt.ArrayItem{ key: none, val: 'id' }, rt.ArrayItem{ key: none, val: false }, rt.ArrayItem{ key: none, val: rt.call_function('_x', [rt.new_string('Registered'), rt.new_string('user')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Table ordered by User Registered Date.')]) }]) }])
}

fn (mut this Class_WP_MS_Users_List_Table) column_cb(var_item rt.PhpVal)  {
	mut var_user := var_item
	if rt.is_true(rt.call_function('is_super_admin', [rt.get_property(var_user, 'ID')])) {
		return rt.new_null()
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.get_property(var_user, 'ID'))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_user, 'ID')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.get_property(var_user, 'ID'))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('__', [rt.new_string('Select %s')]), rt.get_property(var_user, 'user_login')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_MS_Users_List_Table) column_id(var_user rt.PhpVal)  {
	mut var_user_mutated := var_user
	rt.echo_val(rt.get_property(var_user_mutated, 'ID'))
}

fn (mut this Class_WP_MS_Users_List_Table) column_username(var_user rt.PhpVal)  {
	mut var_user_mutated := var_user
	mut var_super_admins := rt.call_function('get_super_admins', []rt.PhpVal{})
	mut var_avatar := rt.call_function('get_avatar', [rt.get_property(var_user_mutated, 'user_email'), rt.new_int(32)])
	rt.echo_val(var_avatar)
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_user'), rt.get_property(var_user_mutated, 'ID')])) {
		mut var_edit_link := rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.new_string('wp_http_referer'), rt.call_function('urlencode', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('REQUEST_URI')])]), rt.call_function('get_edit_user_link', [rt.get_property(var_user_mutated, 'ID')])])])
		mut var_edit := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('<a href="'), var_edit_link), rt.new_string('">')), rt.get_property(var_user_mutated, 'user_login')), rt.new_string('</a>')))
	} else {
		var_edit = rt.get_property(var_user_mutated, 'user_login')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_edit)
	if rt.is_true(rt.call_function('in_array', [rt.get_property(var_user_mutated, 'user_login'), var_super_admins.dup(), rt.new_bool(true)])) {
		print(' &mdash; ' + (rt.call_function('__', [rt.new_string('Super Admin')])).str())
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_MS_Users_List_Table) column_name(var_user rt.PhpVal)  {
	mut var_user_mutated := var_user
	if rt.is_true(rt.new_bool(rt.is_true(rt.get_property(var_user_mutated, 'first_name')) && rt.is_true(rt.get_property(var_user_mutated, 'last_name')))) {
		rt.call_function('printf', [rt.call_function('_x', [rt.new_string('%1$s %2$s'), rt.new_string('Display name based on first name and last name')]), rt.get_property(var_user_mutated, 'first_name'), rt.get_property(var_user_mutated, 'last_name')])
	} else if rt.is_true(rt.get_property(var_user_mutated, 'first_name')) {
		rt.echo_val(rt.get_property(var_user_mutated, 'first_name'))
	} else if rt.is_true(rt.get_property(var_user_mutated, 'last_name')) {
		rt.echo_val(rt.get_property(var_user_mutated, 'last_name'))
	} else {
		print('<span aria-hidden="true">&#8212;</span><span class="screen-reader-text">' + (rt.call_function('_x', [rt.new_string('Unknown'), rt.new_string('name')])).str() + '</span>')
	}
}

fn (mut this Class_WP_MS_Users_List_Table) column_email(var_user rt.PhpVal)  {
	mut var_user_mutated := var_user
	print('<a href=\'' + (rt.call_function('esc_url', [rt.concat(rt.new_string('mailto:'), rt.get_property(var_user_mutated, 'user_email'))])).str() + rt.concat(rt.concat(rt.new_string('\'>'), rt.get_property(var_user_mutated, 'user_email')), rt.new_string('</a>')))
}

fn (mut this Class_WP_MS_Users_List_Table) column_registered(var_user rt.PhpVal)  {
	mut var_mode := rt.new_null()
	mut var_user_mutated := var_user
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.identical(rt.new_string('list'), var_mode)) {
		mut var_date := rt.call_function('__', [rt.new_string('Y/m/d')])
	} else {
		var_date = rt.call_function('__', [rt.new_string('Y/m/d g:i:s a')])
	}
	rt.echo_val(rt.call_function('mysql2date', [var_date.dup(), rt.get_property(var_user_mutated, 'user_registered')]))
}

fn (mut this Class_WP_MS_Users_List_Table) _column_blogs(var_user rt.PhpVal, var_classes rt.PhpVal, var_data rt.PhpVal, var_primary rt.PhpVal)  {
	mut var_user_mutated := var_user
	print('<td class="')
	rt.echo_val(var_classes)
	print(' has-row-actions" ')
	rt.echo_val(var_data)
	print('>')
	rt.echo_val(this.column_blogs(var_user_mutated.dup()))
	print(this.handle_row_actions(var_user_mutated.dup(), rt.new_string('blogs'), var_primary.dup()))
	print('</td>')
}

fn (mut this Class_WP_MS_Users_List_Table) column_blogs(var_user rt.PhpVal)  {
	mut var_user_mutated := var_user
	mut var_blogs := rt.call_function('get_blogs_of_user', [rt.get_property(var_user_mutated, 'ID'), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_blogs.dup().is_array()))))) {
		return rt.new_null()
	}
	{
		mut iter_1 := var_blogs.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_site := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('can_edit_network', [rt.get_property(var_site, 'site_id')]))))) {
				continue
			}
			mut var_path := if rt.is_true(rt.identical(rt.new_string('/'), rt.get_property(var_site, 'path'))) { rt.new_string('') } else { rt.get_property(var_site, 'path') }
			mut var_site_classes := rt.create_array([rt.ArrayItem{ key: none, val: 'site-' + (rt.get_property(var_site, 'site_id')).str() }])
			var_site_classes = rt.call_function('apply_filters', [rt.new_string('ms_user_list_site_class'), var_site_classes.dup(), rt.get_property(var_site, 'userblog_id'), rt.get_property(var_site, 'site_id'), var_user_mutated.dup()])
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_site_classes.dup().is_array())) && !(!rt.is_true(var_site_classes)))) {
				var_site_classes = rt.call_function('array_map', [rt.new_string('sanitize_html_class'), rt.call_function('array_unique', [var_site_classes.dup()])])
				print('<span class="' + (rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_site_classes.dup()])])).str() + '">')
			} else {
				print('<span>')
			}
			print('<a href="' + (rt.call_function('esc_url', [rt.call_function('network_admin_url', ['site-info.php?id=' + (rt.get_property(, 'userblog_id')).str()])])).str() + '">' + (rt.call_function('str_replace', ['.' + (rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'domain')).str(), rt.new_string(''), rt.concat(rt.get_property(var_site, 'domain'), var_path)])).str() + '</a>')
			print(' <small class="row-actions">')
			mut var_actions := rt.new_array()
			var_actions.array_set('edit',  + ().str() + '">' + (rt.call_function('__', [rt.new_string('Edit')])).str() + '</a>')
			mut var_class := rt.new_string(rt.new_string(''))
			if rt.is_true(rt.identical(rt.new_int(1), // unsupported expression: Expr_Cast_Int)) {
				// unsupported expression: Expr_AssignOp_Concat
			}
			if rt.is_true(rt.identical(rt.new_int(1), // unsupported expression: Expr_Cast_Int)) {
				// unsupported expression: Expr_AssignOp_Concat
			}
			if rt.is_true(rt.identical(, )) {
				
			}
			if rt.is_true() {
			}
			
		}
	}
}

fn (mut this Class_WP_MS_Users_List_Table) column_default(var_item rt.PhpVal, var_column_name rt.PhpVal)  {
}

fn (mut this Class_WP_MS_Users_List_Table) display_rows()  {
}

fn (mut this Class_WP_MS_Users_List_Table) get_default_primary_column_name() string {
}

fn (mut this Class_WP_MS_Users_List_Table) handle_row_actions(var_item rt.PhpVal, var_column_name rt.PhpVal, var_primary rt.PhpVal) string {
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

struct Class_WP_User_Query {
	rt.PhpObjectBase
}

fn create_wp_ms_users_list_table() &Class_WP_MS_Users_List_Table {
	mut obj := &Class_WP_MS_Users_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_list_table() &Class_WP_List_Table {
	mut obj := &Class_WP_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_user_query() &Class_WP_User_Query {
	mut obj := &Class_WP_User_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_MS_Users_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'ajax_user_can' {
			return this.ajax_user_can()
		}
		'prepare_items' {
			this.prepare_items()
			return rt.new_null()
		}
		'get_bulk_actions' {
			return this.get_bulk_actions()
		}
		'no_items' {
			this.no_items()
			return rt.new_null()
		}
		'get_views' {
			return this.get_views()
		}
		'pagination' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.pagination(dispatch_arg_0)
			return rt.new_null()
		}
		'get_columns' {
			return this.get_columns()
		}
		'get_sortable_columns' {
			return this.get_sortable_columns()
		}
		'column_cb' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_cb(dispatch_arg_0)
			return rt.new_null()
		}
		'column_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_id(dispatch_arg_0)
			return rt.new_null()
		}
		'column_username' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_username(dispatch_arg_0)
			return rt.new_null()
		}
		'column_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_name(dispatch_arg_0)
			return rt.new_null()
		}
		'column_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_email(dispatch_arg_0)
			return rt.new_null()
		}
		'column_registered' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_registered(dispatch_arg_0)
			return rt.new_null()
		}
		'_column_blogs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this._column_blogs(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'column_blogs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_blogs(dispatch_arg_0)
			return rt.new_null()
		}
		'column_default' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.column_default(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'display_rows' {
			this.display_rows()
			return rt.new_null()
		}
		'get_default_primary_column_name' {
			return rt.new_string(this.get_default_primary_column_name())
		}
		'handle_row_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.handle_row_actions(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		else { return none }
	}
}

fn (this &Class_WP_MS_Users_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_MS_Users_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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




pub fn init_wp_admin_includes_class_wp_ms_users_list_table_php() {
}
