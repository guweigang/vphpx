import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_links'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to edit the links for this site.'),
			]),
		])
	}
	mut var_wp_list_table := rt.call_function('_get_list_table', [
		rt.new_string('WP_Links_List_Table'),
	])
	mut var_doaction := rt.call_method(var_wp_list_table, 'current_action', []rt.PhpVal{})
	if rt.is_true(var_doaction)
		&& rt.get_superglobal('_REQUEST').array_isset(rt.new_string('linkcheck')) {
		rt.call_function('check_admin_referer', [rt.new_string('bulk-bookmarks')])
		mut var_redirect_to := rt.call_function('admin_url', [
			rt.new_string('link-manager.php'),
		])
		mut var_bulklinks :=
			rt.cast_array(rt.get_superglobal('_REQUEST').array_get(rt.new_string('linkcheck')))
		if rt.is_true(rt.identical(rt.new_string('delete'), var_doaction)) {
			mut iter_1 := var_bulklinks.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_link_id := item_1.val
				var_link_id = rt.new_int(var_link_id.to_i64())
				rt.call_function('wp_delete_link', [var_link_id.clone()])
			}
			var_redirect_to = rt.call_function('add_query_arg', [
				rt.new_string('deleted'),
				rt.new_int(var_bulklinks.clone().array_count()),
				var_redirect_to.clone(),
			])
		} else {
			mut var_screen :=
				rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'id')
			var_redirect_to = rt.call_function('apply_filters', [
				rt.new_string('handle_bulk_actions-${var_screen.to_string()}'),
				var_redirect_to.clone(),
				var_doaction.clone(),
				var_bulklinks.clone(),
			])
		}
		rt.call_function('wp_redirect', [var_redirect_to.clone()])
		exit(0)
	} else if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('_wp_http_referer')))) {
		rt.call_function('wp_redirect', [
			rt.call_function('remove_query_arg', [
				rt.create_array([rt.ArrayItem{ key: none, val: '_wp_http_referer' },
					rt.ArrayItem{ key: none, val: '_wpnonce' }]),
				rt.call_function('wp_unslash',
					[rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))]),
			]),
		])
		exit(0)
	}
	rt.call_method(var_wp_list_table, 'prepare_items', []rt.PhpVal{})
	mut var_title := rt.call_function('__', [rt.new_string('Links')])
	mut var_this_file := 'link-manager.php'
	mut var_parent_file := var_this_file
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You can add links here to be displayed on your site, usually using <a href="%s">Widgets</a>. By default, links to several sites in the WordPress community are included as examples.')]), rt.new_string('widgets.php')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Links may be separated into Link Categories; these are different than the categories used on your posts.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('You can customize the display of this screen using the Screen Options tab and/or the dropdown filters above the links table.')])).str() +
				'</p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'deleting-links' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Deleting Links'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('If you delete a link, it will be removed permanently, as Links do not have a Trash function yet.')])).str() +
				'</p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://codex.wordpress.org/Links_Screen">Documentation on Managing Links</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>'),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}),
		'set_screen_reader_content', [
		rt.create_array([
			rt.ArrayItem{ key: 'heading_list', val: rt.call_function('__', [
				rt.new_string('Links list'),
			]) },
		]),
	])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_links'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to edit the links for this site.'),
			]),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Add Link')]))
	// unsupported statement: Stmt_InlineHTML
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('s'))
		&& rt.is_true(rt.new_int(rt.get_superglobal('_REQUEST').array_get(rt.new_string('s')).to_string().len)) {
		print('<span class="subtitle">')
		rt.call_function('printf', [
			rt.call_function('__', [rt.new_string('Search results for: %s')]),
			rt.new_string('<strong>' +
				(rt.call_function('esc_html', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('s'))])])).str() +
				'</strong>'),
		])
		print('</span>')
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('deleted')) {
		mut var_deleted :=
			rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('deleted'))).to_i64())
		mut var_deleted_message := rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%s link deleted.'),
				rt.new_string('%s links deleted.'), var_deleted.clone()]),
			var_deleted.clone(),
		])
		rt.call_function('wp_admin_notice', [var_deleted_message.clone(),
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'updated' },
				]) }, rt.ArrayItem{ key: 'dismissible', val: true }])])
		rt.get_superglobal('_SERVER').array_set('REQUEST_URI', rt.call_function('remove_query_arg', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'deleted' }]),
			rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
		]))
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_wp_list_table, 'search_box', [
		rt.call_function('__', [rt.new_string('Search Links')]),
		rt.new_string('link'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_wp_list_table, 'display', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
