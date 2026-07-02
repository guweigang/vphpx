import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_taxnow := rt.new_null()
	mut var_post_type := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_message := rt.new_null()
	mut var_current_screen := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_taxnow)))) {
		rt.call_function('wp_die', [
			rt.call_function('__', [rt.new_string('Invalid taxonomy.')]),
		])
	}
	mut var_tax := rt.call_function('get_taxonomy', [var_taxnow.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_tax)))) {
		rt.call_function('wp_die', [
			rt.call_function('__', [rt.new_string('Invalid taxonomy.')]),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.get_property(var_tax, 'name'),
		rt.call_function('get_taxonomies', [
			rt.create_array([rt.ArrayItem{ key: 'show_ui', val: true }]),
		]),
		rt.new_bool(true),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to edit terms in this taxonomy.'),
			]),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_tax, 'cap'), 'manage_terms'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.new_string('<h1>' +
				(rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() +
				'</h1>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Sorry, you are not allowed to manage terms in this taxonomy.')])).str() +
				'</p>'),
			rt.new_int(403),
		])
	}
	mut var_wp_list_table := rt.call_function('_get_list_table', [
		rt.new_string('WP_Terms_List_Table'),
	])
	mut var_pagenum := rt.call_method(var_wp_list_table, 'get_pagenum', []rt.PhpVal{})
	mut var_title := rt.get_property(rt.get_property(var_tax, 'labels'), 'name')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('post'), var_post_type)))) {
		mut var_parent_file := if rt.is_true(rt.identical(rt.new_string('attachment'),
			var_post_type))
		{
			'upload.php'
		} else {
			'edit.php?post_type=${var_post_type.to_string()}'
		}
		mut var_submenu_file := 'edit-tags.php?taxonomy=${var_taxonomy.to_string()}&amp;post_type=${var_post_type.to_string()}'
	} else if rt.is_true(rt.identical(rt.new_string('link_category'), rt.get_property(var_tax,
		'name')))
	{
		var_parent_file = 'link-manager.php'
		var_submenu_file = 'edit-tags.php?taxonomy=link_category'
	} else {
		var_parent_file = 'edit.php'
		var_submenu_file = 'edit-tags.php?taxonomy=${var_taxonomy.to_string()}'
	}
	rt.call_function('add_screen_option', [rt.new_string('per_page'),
		rt.create_array([rt.ArrayItem{ key: 'default', val: 20 },
			rt.ArrayItem{ key: 'option', val: 'edit_' + (rt.get_property(var_tax, 'name')).str() +
				'_per_page' }])])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}),
		'set_screen_reader_content', [
		rt.create_array([
			rt.ArrayItem{ key: 'heading_pagination', val: rt.get_property(rt.get_property(var_tax,
				'labels'), 'items_list_navigation') },
			rt.ArrayItem{ key: 'heading_list', val: rt.get_property(rt.get_property(var_tax,
				'labels'), 'items_list') },
		]),
	])
	mut var_location := rt.new_bool(false)
	mut var_referer := rt.call_function('wp_get_referer', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_referer)))) {
		var_referer = rt.call_function('wp_unslash', [
			rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
		])
	}
	var_referer = rt.call_function('remove_query_arg', [
		rt.create_array([rt.ArrayItem{ key: none, val: '_wp_http_referer' },
			rt.ArrayItem{ key: none, val: '_wpnonce' }, rt.ArrayItem{ key: none, val: 'error' },
			rt.ArrayItem{ key: none, val: 'message' }, rt.ArrayItem{ key: none, val: 'paged' }]),
		var_referer.clone(),
	])
	mut switch_val_1 := rt.call_method(var_wp_list_table, 'current_action', []rt.PhpVal{})
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('add-tag'))) {
		rt.call_function('check_admin_referer', [rt.new_string('add-tag'),
			rt.new_string('_wpnonce_add-tag')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.get_property(rt.get_property(var_tax, 'cap'), 'edit_terms'),
		])))))
		{
			rt.call_function('wp_die', [
				rt.new_string('<h1>' +
					(rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() +
					'</h1>' + '<p>' +
					(rt.call_function('__', [rt.new_string('Sorry, you are not allowed to create terms in this taxonomy.')])).str() +
					'</p>'),
				rt.new_int(403),
			])
		}
		mut var_ret := rt.call_function('wp_insert_term', [
			rt.get_superglobal('_POST').array_get(rt.new_string('tag-name')),
			var_taxonomy.clone(),
			rt.get_superglobal('_POST').clone(),
		])
		if rt.is_true(var_ret)
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_ret.clone()]))))) {
			var_location = rt.call_function('add_query_arg', [
				rt.new_string('message'), rt.new_int(1), var_referer.clone()])
		} else {
			var_location = rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'error', val: true },
					rt.ArrayItem{ key: 'message', val: 4 }]),
				var_referer.clone(),
			])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete'))) {
		if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('tag_ID'))) {
		}
		mut var_tag_ID :=
			rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('tag_ID'))).to_i64())
		rt.call_function('check_admin_referer', [
			rt.new_string('delete-tag_' + var_tag_ID.str()),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('delete_term'),
			var_tag_ID.clone(),
		])))))
		{
			rt.call_function('wp_die', [
				rt.new_string('<h1>' +
					(rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() +
					'</h1>' + '<p>' +
					(rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete this item.')])).str() +
					'</p>'),
				rt.new_int(403),
			])
		}
		rt.call_function('wp_delete_term', [var_tag_ID.clone(),
			var_taxonomy.clone()])
		var_location = rt.call_function('add_query_arg', [rt.new_string('message'),
			rt.new_int(2), var_referer.clone()])
		var_location = rt.call_function('remove_query_arg', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'tag_ID' },
				rt.ArrayItem{ key: none, val: 'action' }]),
			var_location.clone(),
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('bulk-delete'))) {
		rt.call_function('check_admin_referer', [rt.new_string('bulk-tags')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.get_property(rt.get_property(var_tax, 'cap'), 'delete_terms'),
		])))))
		{
			rt.call_function('wp_die', [
				rt.new_string('<h1>' +
					(rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() +
					'</h1>' + '<p>' +
					(rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete these items.')])).str() +
					'</p>'),
				rt.new_int(403),
			])
		}
		mut var_tags :=
			rt.cast_array(rt.get_superglobal('_REQUEST').array_get(rt.new_string('delete_tags')))
		mut iter_1 := var_tags.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tag_ID_shadow := item_1.val
			rt.call_function('wp_delete_term', [var_tag_ID_shadow.clone(),
				var_taxonomy.clone()])
		}
		var_location = rt.call_function('add_query_arg', [rt.new_string('message'),
			rt.new_int(6), var_referer.clone()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit'))) {
		if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('tag_ID'))) {
		}
		mut var_term_id :=
			rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('tag_ID'))).to_i64())
		mut var_term := rt.call_function('get_term', [var_term_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_term, 'WP_Term')))))) {
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('You attempted to edit an item that does not exist. Perhaps it was deleted?'),
				]),
			])
		}
		rt.call_function('wp_redirect', [
			rt.call_function('sanitize_url', [
				rt.call_function('get_edit_term_link', [var_term_id.clone(),
					var_taxonomy.clone(), var_post_type.clone()]),
			]),
		])
		exit(0)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('editedtag'))) {
		var_tag_ID =
			rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('tag_ID'))).to_i64())
		rt.call_function('check_admin_referer', [
			rt.new_string('update-tag_' + var_tag_ID.str()),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_term'),
			var_tag_ID.clone(),
		])))))
		{
			rt.call_function('wp_die', [
				rt.new_string('<h1>' +
					(rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() +
					'</h1>' + '<p>' +
					(rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this item.')])).str() +
					'</p>'),
				rt.new_int(403),
			])
		}
		mut var_tag := rt.call_function('get_term', [var_tag_ID.clone(),
			var_taxonomy.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_tag)))) {
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('You attempted to edit an item that does not exist. Perhaps it was deleted?'),
				]),
			])
		}
		var_ret = rt.call_function('wp_update_term', [var_tag_ID.clone(),
			var_taxonomy.clone(), rt.get_superglobal('_POST').clone()])
		if rt.is_true(var_ret)
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_ret.clone()]))))) {
			var_location = rt.call_function('add_query_arg', [
				rt.new_string('message'), rt.new_int(3), var_referer.clone()])
		} else {
			var_location = rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'error', val: true },
					rt.ArrayItem{ key: 'message', val: 5 }]),
				var_referer.clone(),
			])
		}
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_list_table, 'current_action', []rt.PhpVal{})))))
			|| !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('delete_tags'))) {
		}
		rt.call_function('check_admin_referer', [rt.new_string('bulk-tags')])
		mut var_screen :=
			rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'id')
		var_tags =
			rt.cast_array(rt.get_superglobal('_REQUEST').array_get(rt.new_string('delete_tags')))
		var_location = rt.call_function('apply_filters', [
			rt.new_string('handle_bulk_actions-${var_screen.to_string()}'),
			var_location.clone(),
			rt.call_method(var_wp_list_table, 'current_action', []rt.PhpVal{}),
			var_tags.clone(),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_location))))
		&& !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wp_http_referer')))) {
		var_location = rt.call_function('remove_query_arg', [
			rt.create_array([rt.ArrayItem{ key: none, val: '_wp_http_referer' },
				rt.ArrayItem{ key: none, val: '_wpnonce' }]),
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))]),
		])
	}
	if rt.is_true(var_location) {
		if rt.is_true(rt.greater(var_pagenum, rt.new_int(1))) {
			var_location = rt.call_function('add_query_arg', [
				rt.new_string('paged'), var_pagenum.clone(), var_location.clone()])
		}
		if rt.is_true(rt.identical(rt.new_int(1), var_pagenum)) {
			var_location = rt.call_function('remove_query_arg', [
				rt.new_string('paged'), var_location.clone()])
		}
		rt.call_function('wp_redirect', [
			rt.call_function('apply_filters', [rt.new_string('redirect_term_location'),
				var_location.clone(), var_tax.clone()]),
		])
		exit(0)
	}
	rt.call_method(var_wp_list_table, 'prepare_items', []rt.PhpVal{})
	mut var_total_pages := rt.call_method(var_wp_list_table, 'get_pagination_arg', [
		rt.new_string('total_pages'),
	])
	if rt.is_true(rt.greater(var_pagenum, var_total_pages))
		&& rt.is_true(rt.greater(var_total_pages, rt.new_int(0))) {
		rt.call_function('wp_redirect', [
			rt.call_function('add_query_arg', [rt.new_string('paged'),
				var_total_pages.clone()]),
		])
		exit(0)
	}
	rt.call_function('wp_enqueue_script', [rt.new_string('admin-tags')])
	if rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_tax, 'cap'), 'edit_terms'),
	]))
	{
		rt.call_function('wp_enqueue_script', [rt.new_string('inline-edit-tax')])
	}
	if rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy))
		|| rt.is_true(rt.identical(rt.new_string('link_category'), var_taxonomy))
		|| rt.is_true(rt.identical(rt.new_string('post_tag'), var_taxonomy)) {
		mut var_help := rt.new_string('')
		if rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy)) {
			var_help = rt.new_string('<p>' +
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You can use categories to define sections of your site and group related posts. The default category is &#8220;Uncategorized&#8221; until you change it in your <a href="%s">writing settings</a>.')]), rt.new_string('options-writing.php')])).str() +
				'</p>')
		} else if rt.is_true(rt.identical(rt.new_string('link_category'), var_taxonomy)) {
			var_help = rt.new_string('<p>' +
				(rt.call_function('__', [rt.new_string('You can create groups of links by using Link Categories. Link Category names must be unique and Link Categories are separate from the categories you use for posts.')])).str() +
				'</p>')
		} else {
			var_help = rt.new_string('<p>' +
				(rt.call_function('__', [rt.new_string('You can assign keywords to your posts using <strong>tags</strong>. Unlike categories, tags have no hierarchy, meaning there is no relationship from one tag to another.')])).str() +
				'</p>')
		}
		if rt.is_true(rt.identical(rt.new_string('link_category'), var_taxonomy)) {
			var_help = rt.concat(var_help, rt.new_string('<p>' +
				(rt.call_function('__', [rt.new_string('You can delete Link Categories in the Bulk Action pull-down, but that action does not delete the links within the category. Instead, it moves them to the default Link Category.')])).str() +
				'</p>'))
		} else {
			var_help = rt.concat(var_help, rt.new_string('<p>' +
				(rt.call_function('__', [rt.new_string('What&#8217;s the difference between categories and tags? Normally, tags are ad-hoc keywords that identify important information in your post (names, subjects, etc) that may or may not recur in other posts, while categories are pre-determined sections. If you think of your site like a book, the categories are like the Table of Contents and the tags are like the terms in the index.')])).str() +
				'</p>'))
		}
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Overview'),
				]) }, rt.ArrayItem{ key: 'content', val: var_help }]),
		])
		if rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy))
			|| rt.is_true(rt.identical(rt.new_string('post_tag'), var_taxonomy)) {
			if rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy)) {
				var_help = rt.new_string('<p>' +
					(rt.call_function('__', [rt.new_string('When adding a new category on this screen, you&#8217;ll fill in the following fields:')])).str() +
					'</p>')
			} else {
				var_help = rt.new_string('<p>' +
					(rt.call_function('__', [rt.new_string('When adding a new tag on this screen, you&#8217;ll fill in the following fields:')])).str() +
					'</p>')
			}
			var_help = rt.concat(var_help, rt.new_string('<ul>' + '<li>' +
				(rt.call_function('__', [rt.new_string('<strong>Name</strong> &mdash; The name is how it appears on your site.')])).str() +
				'</li>'))
			var_help = rt.concat(var_help, rt.new_string('<li>' +
				(rt.call_function('__', [rt.new_string('<strong>Slug</strong> &mdash; The &#8220;slug&#8221; is the URL-friendly version of the name. It is usually all lowercase and contains only letters, numbers, and hyphens.')])).str() +
				'</li>'))
			if rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy)) {
				var_help = rt.concat(var_help, rt.new_string('<li>' +
					(rt.call_function('__', [rt.new_string('<strong>Parent</strong> &mdash; Categories, unlike tags, can have a hierarchy. You might have a Jazz category, and under that have child categories for Bebop and Big Band. Totally optional. To create a subcategory, just choose another category from the Parent dropdown.')])).str() +
					'</li>'))
			}
			var_help = rt.concat(var_help, rt.new_string('<li>' +
				(rt.call_function('__', [rt.new_string('<strong>Description</strong> &mdash; The description is not prominent by default; however, some themes may display it.')])).str() +
				'</li>' + '</ul>' + '<p>' +
				(rt.call_function('__', [rt.new_string('You can change the display of this screen using the Screen Options tab to set how many items are displayed per screen and to display/hide columns in the table.')])).str() +
				'</p>'))
			rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
				rt.create_array([rt.ArrayItem{ key: 'id', val: 'adding-terms' },
					rt.ArrayItem{
						key: 'title'
						val: if rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy)) { rt.call_function('__', [
								rt.new_string('Adding Categories'),
							]) } else { rt.call_function('__', [
								rt.new_string('Adding Tags'),
							]) }
					}, rt.ArrayItem{ key: 'content', val: var_help }]),
			])
		}
		var_help = rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>')
		if rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy)) {
			var_help = rt.concat(var_help, rt.new_string('<p>' +
				(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/posts-categories-screen/">Documentation on Categories</a>')])).str() +
				'</p>'))
		} else if rt.is_true(rt.identical(rt.new_string('link_category'), var_taxonomy)) {
			var_help = rt.concat(var_help, rt.new_string('<p>' +
				(rt.call_function('__', [rt.new_string('<a href="https://codex.wordpress.org/Links_Link_Categories_Screen">Documentation on Link Categories</a>')])).str() +
				'</p>'))
		} else {
			var_help = rt.concat(var_help, rt.new_string('<p>' +
				(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/posts-tags-screen/">Documentation on Tags</a>')])).str() +
				'</p>'))
		}
		var_help = rt.concat(var_help, rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>'))
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
			var_help.clone(),
		])
		var_help = rt.new_null()
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/edit-tag-messages.php',
		'4')
	if rt.is_true(rt.call_function('is_plugin_active', [
		rt.new_string('wpcat2tag-importer/wpcat2tag-importer.php'),
	]))
	{
		mut var_import_link := rt.call_function('admin_url', [
			rt.new_string('admin.php?import=wpcat2tag'),
		])
	} else {
		var_import_link = rt.call_function('admin_url', [rt.new_string('import.php')])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
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
	mut var_class := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('error')) {
		'error'
	} else {
		'updated'
	}
	if rt.is_true(var_message) {
		rt.call_function('wp_admin_notice', [var_message.clone(),
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: var_class },
				]) }, rt.ArrayItem{ key: 'dismissible', val: true }])])
		rt.get_superglobal('_SERVER').array_set('REQUEST_URI', rt.call_function('remove_query_arg', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'message' },
				rt.ArrayItem{ key: none, val: 'error' }]),
			rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
		]))
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_taxonomy.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_post_type.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_wp_list_table, 'search_box', [
		rt.get_property(rt.get_property(var_tax, 'labels'), 'search_items'),
		rt.new_string('tag'),
	])
	// unsupported statement: Stmt_InlineHTML
	mut var_can_edit_terms := rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_tax, 'cap'), 'edit_terms'),
	])
	if rt.is_true(var_can_edit_terms) {
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy)) {
			rt.call_function('do_action_deprecated', [
				rt.new_string('add_category_form_pre'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
						rt.ArrayItem{ key: 'parent', val: 0 },
					])) },
				]),
				rt.new_string('3.0.0'),
				rt.new_string('{$taxonomy}_pre_add_form'),
			])
		} else if rt.is_true(rt.identical(rt.new_string('link_category'), var_taxonomy)) {
			rt.call_function('do_action_deprecated', [
				rt.new_string('add_link_category_form_pre'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
						rt.ArrayItem{ key: 'parent', val: 0 },
					])) },
				]),
				rt.new_string('3.0.0'),
				rt.new_string('{$taxonomy}_pre_add_form'),
			])
		} else {
			rt.call_function('do_action_deprecated', [rt.new_string('add_tag_form_pre'),
				rt.create_array([rt.ArrayItem{ key: none, val: var_taxonomy }]),
				rt.new_string('3.0.0'), rt.new_string('{$taxonomy}_pre_add_form')])
		}
		rt.call_function('do_action', [
			rt.new_string('${var_taxonomy.to_string()}_pre_add_form'),
			var_taxonomy.clone(),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(rt.get_property(var_tax, 'labels'), 'add_new_item'))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [
			rt.new_string('${var_taxonomy.to_string()}_term_new_form_tag'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.get_property(var_current_screen, 'id'),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_taxonomy.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_post_type.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [rt.new_string('add-tag'),
			rt.new_string('_wpnonce_add-tag')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_ex', [rt.new_string('Name'), rt.new_string('term name')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(rt.get_property(var_tax, 'labels'), 'name_field_description'))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Slug')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(rt.get_property(var_tax, 'labels'), 'slug_field_description'))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [
			var_taxonomy.clone()]))
		{
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				rt.get_property(rt.get_property(var_tax, 'labels'), 'parent_item'),
			]))
			// unsupported statement: Stmt_InlineHTML
			mut var_dropdown_args := rt.create_array([
				rt.ArrayItem{ key: 'hide_empty', val: 0 },
				rt.ArrayItem{ key: 'hide_if_empty', val: false },
				rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
				rt.ArrayItem{ key: 'name', val: 'parent' },
				rt.ArrayItem{ key: 'orderby', val: 'name' },
				rt.ArrayItem{ key: 'hierarchical', val: true },
				rt.ArrayItem{ key: 'show_option_none', val: rt.call_function('__', [
					rt.new_string('None'),
				]) },
			])
			var_dropdown_args = rt.call_function('apply_filters', [
				rt.new_string('taxonomy_parent_dropdown_args'),
				var_dropdown_args.clone(),
				var_taxonomy.clone(),
				rt.new_string('new'),
			])
			var_dropdown_args.array_set('aria_describedby', 'parent-description')
			rt.call_function('wp_dropdown_categories', [var_dropdown_args.clone()])
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy)) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [
					rt.new_string('Categories, unlike tags, can have a hierarchy. You might have a Jazz category, and under that have children categories for Bebop and Big Band. Totally optional.'),
				])
				// unsupported statement: Stmt_InlineHTML
			} else {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.get_property(rt.get_property(var_tax, 'labels'),
					'parent_field_description'))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Description')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(rt.get_property(var_tax, 'labels'), 'desc_field_description'))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_taxonomy_hierarchical', [
			var_taxonomy.clone(),
		])))))
		{
			rt.call_function('do_action', [rt.new_string('add_tag_form_fields'),
				var_taxonomy.clone()])
		}
		rt.call_function('do_action', [
			rt.new_string('${var_taxonomy.to_string()}_add_form_fields'),
			var_taxonomy.clone(),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('submit_button', [
			rt.get_property(rt.get_property(var_tax, 'labels'), 'add_new_item'),
			rt.new_string('primary'),
			rt.new_string('submit'),
			rt.new_bool(false),
		])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy)) {
			rt.call_function('do_action_deprecated', [
				rt.new_string('edit_category_form'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
						rt.ArrayItem{ key: 'parent', val: 0 },
					])) },
				]),
				rt.new_string('3.0.0'),
				rt.new_string('{$taxonomy}_add_form'),
			])
		} else if rt.is_true(rt.identical(rt.new_string('link_category'), var_taxonomy)) {
			rt.call_function('do_action_deprecated', [
				rt.new_string('edit_link_category_form'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
						rt.ArrayItem{ key: 'parent', val: 0 },
					])) },
				]),
				rt.new_string('3.0.0'),
				rt.new_string('{$taxonomy}_add_form'),
			])
		} else {
			rt.call_function('do_action_deprecated', [rt.new_string('add_tag_form'),
				rt.create_array([rt.ArrayItem{ key: none, val: var_taxonomy }]),
				rt.new_string('3.0.0'), rt.new_string('{$taxonomy}_add_form')])
		}
		rt.call_function('do_action', [
			rt.new_string('${var_taxonomy.to_string()}_add_form'),
			var_taxonomy.clone(),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_wp_list_table, 'views', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_taxonomy.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_post_type.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_wp_list_table, 'display', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy)) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('Deleting a category does not delete the posts in that category. Instead, posts that were only assigned to the deleted category are set to the default category %s. The default category cannot be deleted.'),
			]),
			rt.new_string('<strong>' +
				(rt.call_function('apply_filters', [rt.new_string('the_category'), rt.call_function('get_cat_name', [rt.call_function('get_option', [rt.new_string('default_category')])]), rt.new_string(''), rt.new_string('')])).str() +
				'</strong>'),
		])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('current_user_can', [rt.new_string('import')])) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('Categories can be selectively converted to tags using the <a href="%s">category to tag converter</a>.'),
				]),
				rt.call_function('esc_url', [
					var_import_link.clone(),
				]),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.identical(rt.new_string('post_tag'), var_taxonomy))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('import')])) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('Tags can be selectively converted to categories using the <a href="%s">tag to category converter</a>.'),
			]),
			rt.call_function('esc_url', [
				var_import_link.clone(),
			]),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	rt.call_function('do_action', [
		rt.new_string('after-${var_taxonomy.to_string()}-table'),
		var_taxonomy.clone(),
	])
	if rt.is_true(var_can_edit_terms) {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{}))))) {
		// unsupported statement: Stmt_InlineHTML
	}
	rt.call_method(var_wp_list_table, 'inline_edit', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
