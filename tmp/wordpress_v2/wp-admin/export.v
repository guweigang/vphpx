import rt

mut var_title := rt.call_function('__', [rt.new_string('Export')])
fn export_add_js() {
	// unsupported statement: Stmt_InlineHTML
}

fn export_date_options(post_type string) {
	mut var_post_type := post_type
	mut var_wpdb := rt.new_null()
	mut var_wp_locale := rt.new_null()
	mut var_months := rt.new_null()
	mut var_month_count := i64(0)
	mut var_date := rt.new_null()
	mut var_month := rt.new_null()
	var_months = rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT DISTINCT YEAR( post_date ) AS year, MONTH( post_date ) AS month\n\t\t\tFROM '), rt.get_property(var_wpdb,
				'posts')),
				rt.new_string("\n\t\t\tWHERE post_type = %s AND post_status != 'auto-draft'\n\t\t\tORDER BY post_date DESC")),
			rt.new_string(post_type),
		]),
	])
	var_month_count = var_months.clone().array_count()
	if !(var_month_count != 0) || (1 == var_month_count
		&& 0 == rt.new_int((rt.get_property(var_months.array_get(rt.new_int(0)), 'month')).to_i64())) {
		return
	}
	mut iter_1 := var_months.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_date_shadow := item_1.val
		if 0 == rt.new_int((rt.get_property(var_date_shadow, 'year')).to_i64()) {
			continue
		}
		var_month = rt.call_function('zeroise', [
			rt.get_property(var_date_shadow, 'month'),
			rt.new_int(2),
		])
		rt.call_function('printf', [rt.new_string('<option value="%1$s">%2$s</option>'),
			rt.call_function('esc_attr', [
				rt.new_string((rt.get_property(var_date_shadow, 'year')).str() + '-' +
					var_month.str()),
			]),
			rt.new_string((rt.call_method(var_wp_locale, 'get_month', [var_month.clone()])).str() +
				' ' + (rt.get_property(var_date_shadow, 'year')).str())])
	}
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_wpdb := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('export'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to export the content of this site.'),
			]),
		])
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/export.php', '4')
	rt.call_function('add_action', [rt.new_string('admin_head'),
		rt.new_string('export_add_js')])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('You can export a file of your site&#8217;s content in order to import it into another installation or platform. The export file will be an XML file format called WXR. Posts, pages, comments, custom fields, categories, and tags can be included. You can choose for the WXR file to include only certain posts or pages by setting the dropdown filters to limit the export by category, author, date range by month, or publishing status.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Once generated, your WXR file can be imported by another WordPress site or by another blogging platform able to access this format.')])).str() +
				'</p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/tools-export-screen/">Documentation on Export</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>'),
	])
	if rt.get_superglobal('_GET').array_isset(rt.new_string('download')) {
		mut var_args := rt.new_array()
		if !(rt.get_superglobal('_GET').array_isset(rt.new_string('content')))
			|| rt.is_true(rt.identical(rt.new_string('all'), rt.get_superglobal('_GET').array_get(rt.new_string('content')))) {
			var_args.array_set('content', 'all')
		} else if rt.is_true(rt.identical(rt.new_string('posts'),
			rt.get_superglobal('_GET').array_get(rt.new_string('content'))))
		{
			var_args.array_set('content', 'post')
			if rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('cat'))) {
				var_args.array_set('category',
					rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('cat'))).to_i64()))
			}
			if rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('post_author'))) {
				var_args.array_set('author',
					rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('post_author'))).to_i64()))
			}
			if rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('post_start_date')))
				|| rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('post_end_date'))) {
				var_args.array_set('start_date',
					rt.get_superglobal('_GET').array_get(rt.new_string('post_start_date')))
				var_args.array_set('end_date',
					rt.get_superglobal('_GET').array_get(rt.new_string('post_end_date')))
			}
			if rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('post_status'))) {
				var_args.array_set('status',
					rt.get_superglobal('_GET').array_get(rt.new_string('post_status')))
			}
		} else if rt.is_true(rt.identical(rt.new_string('pages'),
			rt.get_superglobal('_GET').array_get(rt.new_string('content'))))
		{
			var_args.array_set('content', 'page')
			if rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('page_author'))) {
				var_args.array_set('author',
					rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('page_author'))).to_i64()))
			}
			if rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('page_start_date')))
				|| rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('page_end_date'))) {
				var_args.array_set('start_date',
					rt.get_superglobal('_GET').array_get(rt.new_string('page_start_date')))
				var_args.array_set('end_date',
					rt.get_superglobal('_GET').array_get(rt.new_string('page_end_date')))
			}
			if rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('page_status'))) {
				var_args.array_set('status',
					rt.get_superglobal('_GET').array_get(rt.new_string('page_status')))
			}
		} else if rt.is_true(rt.identical(rt.new_string('attachment'),
			rt.get_superglobal('_GET').array_get(rt.new_string('content'))))
		{
			var_args.array_set('content', 'attachment')
			if rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('attachment_start_date')))
				|| rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('attachment_end_date'))) {
				var_args.array_set('start_date',
					rt.get_superglobal('_GET').array_get(rt.new_string('attachment_start_date')))
				var_args.array_set('end_date',
					rt.get_superglobal('_GET').array_get(rt.new_string('attachment_end_date')))
			}
		} else {
			var_args.array_set('content',
				rt.get_superglobal('_GET').array_get(rt.new_string('content')))
		}
		var_args = rt.call_function('apply_filters', [rt.new_string('export_args'),
			var_args.clone()])
		rt.call_function('export_wp', [var_args.clone()])
		exit(0)
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('When you click the button below WordPress will create an XML file for you to save to your computer.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('This format, which is called WordPress eXtended RSS or WXR, will contain your posts, pages, comments, custom fields, categories, and tags.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Once you&#8217;ve saved the download file, you can use the Import function in another WordPress installation to import the content from this site.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Choose what to export')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Content to export')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('All content')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('This will contain all of your posts, pages, comments, custom fields, terms, navigation menus, and custom posts.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Posts'), rt.new_string('post type general name')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Categories:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_dropdown_categories', [
		rt.create_array([
			rt.ArrayItem{ key: 'show_option_all', val: rt.call_function('__', [
				rt.new_string('All'),
			]) },
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Authors:')])
	// unsupported statement: Stmt_InlineHTML
	mut var_authors := rt.call_method(var_wpdb, 'get_col', [
		rt.concat(rt.concat(rt.new_string('SELECT DISTINCT post_author FROM '), rt.get_property(var_wpdb,
			'posts')), rt.new_string(" WHERE post_type = 'post'")),
	])
	rt.call_function('wp_dropdown_users', [
		rt.create_array([rt.ArrayItem{ key: 'include', val: var_authors },
			rt.ArrayItem{ key: 'name', val: 'post_author' }, rt.ArrayItem{ key: 'multi', val: true },
			rt.ArrayItem{ key: 'show_option_all', val: rt.call_function('__', [
				rt.new_string('All'),
			]) }, rt.ArrayItem{ key: 'show', val: 'display_name_with_login' }]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Date range:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Start date:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('&mdash; Select &mdash;')])
	// unsupported statement: Stmt_InlineHTML
	export_date_options('')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('End date:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('&mdash; Select &mdash;')])
	// unsupported statement: Stmt_InlineHTML
	export_date_options('')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Status:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('All')])
	// unsupported statement: Stmt_InlineHTML
	mut var_post_statuses := rt.call_function('get_post_stati', [
		rt.create_array([rt.ArrayItem{ key: 'internal', val: false }]),
		rt.new_string('objects'),
	])
	mut iter_2 := var_post_statuses.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_status := item_2.val
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_status, 'name')]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [rt.get_property(var_status, 'label')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Pages')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Authors:')])
	// unsupported statement: Stmt_InlineHTML
	var_authors = rt.call_method(var_wpdb, 'get_col', [
		rt.concat(rt.concat(rt.new_string('SELECT DISTINCT post_author FROM '), rt.get_property(var_wpdb,
			'posts')), rt.new_string(" WHERE post_type = 'page'")),
	])
	rt.call_function('wp_dropdown_users', [
		rt.create_array([rt.ArrayItem{ key: 'include', val: var_authors },
			rt.ArrayItem{ key: 'name', val: 'page_author' }, rt.ArrayItem{ key: 'multi', val: true },
			rt.ArrayItem{ key: 'show_option_all', val: rt.call_function('__', [
				rt.new_string('All'),
			]) }, rt.ArrayItem{ key: 'show', val: 'display_name_with_login' }]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Date range:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Start date:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('&mdash; Select &mdash;')])
	// unsupported statement: Stmt_InlineHTML
	export_date_options('page')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('End date:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('&mdash; Select &mdash;')])
	// unsupported statement: Stmt_InlineHTML
	export_date_options('page')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Status:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('All')])
	// unsupported statement: Stmt_InlineHTML
	mut iter_3 := var_post_statuses.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_status := item_3.val
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_status, 'name')]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [rt.get_property(var_status, 'label')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut iter_4 := rt.call_function('get_post_types', [
		rt.create_array([rt.ArrayItem{ key: '_builtin', val: false },
			rt.ArrayItem{ key: 'can_export', val: true }]),
		rt.new_string('objects'),
	]).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_post_type := item_4.val
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_post_type, 'name')]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			rt.get_property(var_post_type, 'label'),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Media')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Date range:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Start date:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('&mdash; Select &mdash;')])
	// unsupported statement: Stmt_InlineHTML
	export_date_options('attachment')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('End date:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('&mdash; Select &mdash;')])
	// unsupported statement: Stmt_InlineHTML
	export_date_options('attachment')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('export_filters')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [
		rt.call_function('__', [rt.new_string('Download Export File')]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
