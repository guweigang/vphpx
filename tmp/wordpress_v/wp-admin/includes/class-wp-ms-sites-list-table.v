import rt

struct Class_WP_MS_Sites_List_Table {
	rt.PhpObjectBase
pub mut:
		status_list rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_MS_Sites_List_Table) construct(var_args rt.PhpVal)  {
	mut var_args_mutated := var_args
	this.status_list = rt.create_array([rt.ArrayItem{ key: 'archived', val: rt.create_array([rt.ArrayItem{ key: none, val: 'site-archived' }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Archived')]) }]) }, rt.ArrayItem{ key: 'spam', val: rt.create_array([rt.ArrayItem{ key: none, val: 'site-spammed' }, rt.ArrayItem{ key: none, val: rt.call_function('_x', [rt.new_string('Spam'), rt.new_string('site')]) }]) }, rt.ArrayItem{ key: 'deleted', val: rt.create_array([rt.ArrayItem{ key: none, val: 'site-deleted' }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Flagged for Deletion')]) }]) }, rt.ArrayItem{ key: 'mature', val: rt.create_array([rt.ArrayItem{ key: none, val: 'site-mature' }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Mature')]) }]) }])
	this.Class_WP_List_Table.construct(rt.create_array([rt.ArrayItem{ key: 'plural', val: 'sites' }, rt.ArrayItem{ key: 'screen', val: if !(var_args_mutated.array_get('screen')).is_null() { var_args_mutated.array_get('screen') } else { rt.new_null() } }]))
}

fn (mut this Class_WP_MS_Sites_List_Table) ajax_user_can() rt.PhpVal {
	return rt.call_function('current_user_can', [rt.new_string('manage_sites')])
}

fn (mut this Class_WP_MS_Sites_List_Table) prepare_items()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('mode'))) {
		mut var_mode := rt.new_string(if rt.is_true(rt.identical(rt.new_string('excerpt'), rt.get_superglobal('_REQUEST').array_get('mode'))) { rt.new_string('excerpt') } else { rt.new_string('list') })
		rt.call_function('set_user_setting', [rt.new_string('sites_list_mode'), var_mode.dup()])
	} else {
		var_mode = rt.call_function('get_user_setting', [rt.new_string('sites_list_mode'), rt.new_string('list')])
	}
	mut var_per_page := this.get_items_per_page(rt.new_string('sites_network_per_page'))
	mut var_pagenum := this.get_pagenum()
	mut var_s := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('s')) { rt.call_function('wp_unslash', [rt.new_string(rt.get_superglobal('_REQUEST').array_get('s').to_string().trim_space())]) } else { rt.new_string('') }
	mut var_wild := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.call_function('str_contains', [var_s.dup(), rt.new_string('*')])) {
		var_wild = rt.new_string(rt.new_string('*'))
		var_s = rt.new_string(rt.new_string(var_s.dup().to_string().trim_space()))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_s)))) && rt.is_true(rt.call_function('wp_is_large_network', []rt.PhpVal{})))) {
		if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('orderby'))) {
			rt.get_superglobal('_GET').array_set('orderby', '')
			rt.get_superglobal('_REQUEST').array_set('orderby', '')
		}
		if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('order'))) {
			rt.get_superglobal('_GET').array_set('order', 'DESC')
			rt.get_superglobal('_REQUEST').array_set('order', 'DESC')
		}
	}
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'number', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'offset', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'network_id', val: rt.call_function('get_current_network_id', []rt.PhpVal{}) }])
	if !rt.is_true(var_s) {
		// unsupported statement: Stmt_Nop
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}$/'), var_s.dup()])) || rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.?$/'), var_s.dup()])))) || rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[0-9]{1,3}\\.[0-9]{1,3}\\.?$/'), var_s.dup()])))) || rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[0-9]{1,3}\\.$/'), var_s.dup()])))) {
		mut var_reg_blog_ids := rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT blog_id FROM '), rt.get_property(var_wpdb, 'registration_log')), rt.new_string(' WHERE ')), rt.get_property(var_wpdb, 'registration_log')), rt.new_string('.IP LIKE %s')), (rt.call_method(var_wpdb, 'esc_like', [var_s.dup()])).str() + if !(!rt.is_true(var_wild)) { '%' } else { '' }])])
		if rt.is_true(var_reg_blog_ids) {
			var_args.array_set('site__in', var_reg_blog_ids.dup())
		}
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_s.dup().is_long() || var_s.dup().is_double())) && !rt.is_true(var_wild))) {
		var_args.array_set('ID', var_s.dup())
	} else {
		var_args.array_set('search', var_s.dup())
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{}))))) {
			var_args.array_set('search_columns', rt.create_array([rt.ArrayItem{ key: none, val: 'path' }]))
		}
	}
	mut var_order_by := if !(rt.get_superglobal('_REQUEST').array_get('orderby')).is_null() { rt.get_superglobal('_REQUEST').array_get('orderby') } else { rt.new_string('') }
	if rt.is_true(rt.identical(rt.new_string('registered'), var_order_by)) {
		// unsupported statement: Stmt_Nop
	} else if rt.is_true(rt.identical(rt.new_string('lastupdated'), var_order_by)) {
		var_order_by = rt.new_string(rt.new_string('last_updated'))
	} else if rt.is_true(rt.identical(rt.new_string('blogname'), var_order_by)) {
		if rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{})) {
			var_order_by = rt.new_string(rt.new_string('domain'))
		} else {
			var_order_by = rt.new_string(rt.new_string('path'))
		}
	} else if rt.is_true(rt.identical(rt.new_string('blog_id'), var_order_by)) {
		var_order_by = rt.new_string(rt.new_string('id'))
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_order_by)))) {
		var_order_by = rt.new_bool(rt.new_bool(false))
	}
	var_args.array_set('orderby', var_order_by.dup())
	if rt.is_true(var_order_by) {
		var_args.array_set('order', if rt.is_true(rt.new_bool(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('order')) && rt.is_true(rt.identical(rt.new_string('DESC'), rt.new_string(rt.get_superglobal('_REQUEST').array_get('order').to_string().to_upper()))))) { 'DESC' } else { 'ASC' })
	}
	if rt.is_true(rt.call_function('wp_is_large_network', []rt.PhpVal{})) {
		var_args.array_set('no_found_rows', true)
	} else {
		var_args.array_set('no_found_rows', false)
	}
	mut var_status := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('status')) { rt.call_function('wp_unslash', [rt.new_string(rt.get_superglobal('_REQUEST').array_get('status').to_string().trim_space())]) } else { rt.new_string('') }
	if rt.is_true(rt.call_function('in_array', [var_status.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'public' }, rt.ArrayItem{ key: none, val: 'archived' }, rt.ArrayItem{ key: none, val: 'mature' }, rt.ArrayItem{ key: none, val: 'spam' }, rt.ArrayItem{ key: none, val: 'deleted' }]), rt.new_bool(true)])) {
		var_args.array_set(var_status, 1)
	}
	var_args = rt.call_function('apply_filters', [rt.new_string('ms_sites_list_table_query_args'), var_args.dup()])
	mut var__sites := rt.call_function('get_sites', [var_args.dup()])
	if rt.is_true(rt.new_bool(var__sites.dup().is_array())) {
		rt.call_function('update_site_cache', [var__sites.dup()])
		this.dispatch_set_prop('items', rt.call_function('array_slice', [var__sites.dup(), rt.new_int(0), var_per_page.dup()]))
	}
	mut var_total_sites := rt.call_function('get_sites', [rt.call_function('array_merge', [var_args.dup(), rt.create_array([rt.ArrayItem{ key: 'count', val: true }, rt.ArrayItem{ key: 'offset', val: 0 }, rt.ArrayItem{ key: 'number', val: 0 }])])])
	this.set_pagination_args(rt.create_array([rt.ArrayItem{ key: 'total_items', val: var_total_sites }, rt.ArrayItem{ key: 'per_page', val: var_per_page }]))
}

fn (mut this Class_WP_MS_Sites_List_Table) no_items()  {
	rt.call_function('_e', [rt.new_string('No sites found.')])
}

fn (mut this Class_WP_MS_Sites_List_Table) get_views() rt.PhpVal {
	mut var_counts := rt.call_function('wp_count_sites', []rt.PhpVal{})
	mut var_statuses := { 'all': rt.call_function('_nx_noop', [rt.new_string('All <span class="count">(%s)</span>'), rt.new_string('All <span class="count">(%s)</span>'), rt.new_string('sites')]), 'public': rt.call_function('_n_noop', [rt.new_string('Public <span class="count">(%s)</span>'), rt.new_string('Public <span class="count">(%s)</span>')]), 'archived': rt.call_function('_n_noop', [rt.new_string('Archived <span class="count">(%s)</span>'), rt.new_string('Archived <span class="count">(%s)</span>')]), 'mature': rt.call_function('_n_noop', [rt.new_string('Mature <span class="count">(%s)</span>'), rt.new_string('Mature <span class="count">(%s)</span>')]), 'spam': rt.call_function('_nx_noop', [rt.new_string('Spam <span class="count">(%s)</span>'), rt.new_string('Spam <span class="count">(%s)</span>'), rt.new_string('sites')]), 'deleted': rt.call_function('_n_noop', [rt.new_string('Flagged for Deletion <span class="count">(%s)</span>'), rt.new_string('Flagged for Deletion <span class="count">(%s)</span>')]) }
	mut var_view_links := rt.new_array()
	mut var_requested_status := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('status')) { rt.call_function('wp_unslash', [rt.new_string(rt.get_superglobal('_REQUEST').array_get('status').to_string().trim_space())]) } else { rt.new_string('') }
	mut var_url := rt.new_string(rt.new_string('sites.php'))
	for var_status, var_label_count in var_statuses {
		if rt.is_true(rt.greater(// unsupported expression: Expr_Cast_Int, rt.new_int(0))) {
			mut var_label := rt.call_function('sprintf', [rt.call_function('translate_nooped_plural', [var_label_count.dup(), var_counts.array_get(status)]), rt.call_function('number_format_i18n', [var_counts.array_get(status)])])
			mut var_full_url := if rt.is_true(rt.identical(rt.new_string('all'), rt.new_string(status))) { var_url } else { rt.call_function('add_query_arg', [rt.new_string('status'), rt.new_string(status), var_url.dup()]) }
			var_view_links.array_set(status, rt.create_array([rt.ArrayItem{ key: 'url', val: rt.call_function('esc_url', [var_full_url.dup()]) }, rt.ArrayItem{ key: 'label', val: var_label }, rt.ArrayItem{ key: 'current', val: rt.is_true(rt.identical(var_requested_status, rt.new_string(status))) || rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string(''), var_requested_status)) && rt.is_true(rt.identical(rt.new_string('all'), rt.new_string(status))))) }]))
		}
	}
	return this.get_views_links(var_view_links.dup())
}

fn (mut this Class_WP_MS_Sites_List_Table) get_bulk_actions() rt.PhpVal {
	mut var_actions := rt.new_array()
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_sites')])) {
		var_actions.array_set('delete', rt.call_function('__', [rt.new_string('Delete')]))
	}
	var_actions.array_set('spam', rt.call_function('_x', [rt.new_string('Mark as spam'), rt.new_string('site')]))
	var_actions.array_set('notspam', rt.call_function('_x', [rt.new_string('Not spam'), rt.new_string('site')]))
	return var_actions.dup()
}

fn (mut this Class_WP_MS_Sites_List_Table) pagination(var_which rt.PhpVal)  {
	mut var_mode := rt.new_null()
	// unsupported statement: Stmt_Global
	this.Class_WP_List_Table.pagination(var_which.dup())
	if rt.is_true(rt.identical(rt.new_string('top'), var_which)) {
		this.view_switcher(var_mode.dup())
	}
}

fn (mut this Class_WP_MS_Sites_List_Table) extra_tablenav(var_which rt.PhpVal)  {
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('top'), var_which)) {
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.call_function('do_action', [rt.new_string('restrict_manage_sites'), var_which.dup()])
		mut var_output := rt.call_function('ob_get_clean', []rt.PhpVal{})
		if !(!rt.is_true(var_output)) {
			rt.echo_val(var_output)
			rt.call_function('submit_button', [rt.call_function('__', [rt.new_string('Filter')]), rt.new_string(''), rt.new_string('filter_action'), rt.new_bool(false), rt.create_array([rt.ArrayItem{ key: 'id', val: 'site-query-submit' }])])
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('manage_sites_extra_tablenav'), var_which.dup()])
}

fn (mut this Class_WP_MS_Sites_List_Table) get_columns() rt.PhpVal {
	mut var_sites_columns := { 'cb': rt.new_string('<input type="checkbox" />'), 'blogname': rt.call_function('__', [rt.new_string('URL')]), 'lastupdated': rt.call_function('__', [rt.new_string('Last Updated')]), 'registered': rt.call_function('_x', [rt.new_string('Registered'), rt.new_string('site')]), 'users': rt.call_function('__', [rt.new_string('Users')]) }
	if rt.is_true(rt.call_function('has_filter', [rt.new_string('wpmublogsaction')])) {
		var_sites_columns['plugins'] = rt.call_function('__', [rt.new_string('Actions')])
	}
	return rt.call_function('apply_filters', [rt.new_string('wpmu_blogs_columns'), var_sites_columns.dup()])
}

fn (mut this Class_WP_MS_Sites_List_Table) get_sortable_columns() rt.PhpVal {
	if rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{})) {
		mut var_blogname_abbr := rt.call_function('__', [rt.new_string('Domain')])
		mut var_blogname_orderby_text := rt.call_function('__', [rt.new_string('Table ordered by Site Domain Name.')])
	} else {
		var_blogname_abbr = rt.call_function('__', [rt.new_string('Path')])
		var_blogname_orderby_text = rt.call_function('__', [rt.new_string('Table ordered by Site Path.')])
	}
	return rt.create_array([rt.ArrayItem{ key: 'blogname', val: rt.create_array([rt.ArrayItem{ key: none, val: 'blogname' }, rt.ArrayItem{ key: none, val: false }, rt.ArrayItem{ key: none, val: var_blogname_abbr }, rt.ArrayItem{ key: none, val: var_blogname_orderby_text }]) }, rt.ArrayItem{ key: 'lastupdated', val: rt.create_array([rt.ArrayItem{ key: none, val: 'lastupdated' }, rt.ArrayItem{ key: none, val: true }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Last Updated')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Table ordered by Last Updated.')]) }]) }, rt.ArrayItem{ key: 'registered', val: rt.create_array([rt.ArrayItem{ key: none, val: 'blog_id' }, rt.ArrayItem{ key: none, val: true }, rt.ArrayItem{ key: none, val: rt.call_function('_x', [rt.new_string('Registered'), rt.new_string('site')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Table ordered by Site Registered Date.')]) }, rt.ArrayItem{ key: none, val: 'desc' }]) }])
}

fn (mut this Class_WP_MS_Sites_List_Table) column_cb(var_item rt.PhpVal)  {
	mut var_blog := var_item
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_main_site', [var_blog.array_get('blog_id')]))))) {
		mut var_blogname := rt.call_function('untrailingslashit', [rt.concat(var_blog.array_get('domain'), var_blog.array_get('path'))])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_blog.array_get('blog_id'))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_blog.array_get('blog_id')]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_blog.array_get('blog_id'))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('__', [rt.new_string('Select %s')]), var_blogname.dup()])
		// unsupported statement: Stmt_InlineHTML
	}
}

fn (mut this Class_WP_MS_Sites_List_Table) column_id(var_blog rt.PhpVal)  {
	mut var_blog_mutated := var_blog
	rt.echo_val(var_blog_mutated.array_get('blog_id'))
}

fn (mut this Class_WP_MS_Sites_List_Table) column_blogname(var_blog rt.PhpVal)  {
	mut var_mode := rt.new_null()
	mut var_blog_mutated := var_blog
	// unsupported statement: Stmt_Global
	mut var_blogname := rt.call_function('untrailingslashit', [rt.concat(var_blog_mutated.array_get('domain'), var_blog_mutated.array_get('path'))])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.new_string('<a href="%1$s" class="edit">%2$s</a>'), rt.call_function('esc_url', [rt.call_function('network_admin_url', ['site-info.php?id=' + (.array_get()).str()])]), var_blogname.dup()])
	this.site_states(var_blog_mutated.dup())
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_function('switch_to_blog', [])
		print('<p>')
	}
}

fn (mut this Class_WP_MS_Sites_List_Table) column_lastupdated(var_blog rt.PhpVal)  {
	mut var_mode := rt.new_null()
	mut var_blog_mutated := var_blog
	// unsupported statement: Stmt_Global
}

fn (mut this Class_WP_MS_Sites_List_Table) column_registered(var_blog rt.PhpVal)  {
	mut var_mode := rt.new_null()
	mut var_blog_mutated := var_blog
}

fn (mut this Class_WP_MS_Sites_List_Table) column_users(var_blog rt.PhpVal)  {
	mut var_blog_mutated := var_blog
}

fn (mut this Class_WP_MS_Sites_List_Table) column_plugins(var_blog rt.PhpVal)  {
	mut var_blog_mutated := var_blog
}

fn (mut this Class_WP_MS_Sites_List_Table) column_default(var_item rt.PhpVal, var_column_name rt.PhpVal)  {
}

fn (mut this Class_WP_MS_Sites_List_Table) display_rows()  {
}

fn (mut this Class_WP_MS_Sites_List_Table) site_states(var_site rt.PhpVal)  {
}

fn (mut this Class_WP_MS_Sites_List_Table) get_default_primary_column_name() string {
}

fn (mut this Class_WP_MS_Sites_List_Table) handle_row_actions(var_item rt.PhpVal, var_column_name rt.PhpVal, var_primary rt.PhpVal) string {
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

fn create_wp_ms_sites_list_table(arg_0 rt.PhpVal) &Class_WP_MS_Sites_List_Table {
	mut obj := &Class_WP_MS_Sites_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
		status_list: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_list_table() &Class_WP_List_Table {
	mut obj := &Class_WP_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_MS_Sites_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'pagination' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.pagination(dispatch_arg_0)
			return rt.new_null()
		}
		'extra_tablenav' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.extra_tablenav(dispatch_arg_0)
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
		'column_blogname' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_blogname(dispatch_arg_0)
			return rt.new_null()
		}
		'column_lastupdated' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_lastupdated(dispatch_arg_0)
			return rt.new_null()
		}
		'column_registered' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_registered(dispatch_arg_0)
			return rt.new_null()
		}
		'column_users' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_users(dispatch_arg_0)
			return rt.new_null()
		}
		'column_plugins' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_plugins(dispatch_arg_0)
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
		'site_states' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.site_states(dispatch_arg_0)
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

fn (this &Class_WP_MS_Sites_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'status_list' { return this.status_list }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_MS_Sites_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'status_list' { this.status_list = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_admin_includes_class_wp_ms_sites_list_table_php() {
}
