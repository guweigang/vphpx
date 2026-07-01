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
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Invalid taxonomy.')])])
	}
	mut var_tax := rt.call_function('get_taxonomy', [var_taxnow.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_tax)))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Invalid taxonomy.')])])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_tax, 'name'), rt.call_function('get_taxonomies', [rt.create_array([rt.ArrayItem{ key: 'show_ui', val: true }])]), rt.new_bool(true)]))))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit terms in this taxonomy.')])])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_tax, 'cap'), 'manage_terms')]))))) {
		rt.call_function('wp_die', ['<h1>' + (rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() + '</h1>' + '<p>' + (rt.call_function('__', [rt.new_string('Sorry, you are not allowed to manage terms in this taxonomy.')])).str() + '</p>', rt.new_int(403)])
	}
	// unsupported statement: Stmt_Global
	mut var_wp_list_table := rt.call_function('_get_list_table', [rt.new_string('WP_Terms_List_Table')])
	mut var_pagenum := rt.call_method(var_wp_list_table, 'get_pagenum', []rt.PhpVal{})
	mut var_title := rt.get_property(rt.get_property(var_tax, 'labels'), 'name')
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_parent_file := if rt.is_true(rt.identical(rt.new_string('attachment'), var_post_type)) { 'upload.php' } else { "edit.php?post_type=${var_post_type.to_string()}" }
		mut var_submenu_file := "edit-tags.php?taxonomy=${var_taxonomy.to_string()}&amp;post_type=${var_post_type.to_string()}"
	} else if rt.is_true(rt.identical(rt.new_string('link_category'), rt.get_property(var_tax, 'name'))) {
		var_parent_file = 'link-manager.php'
		var_submenu_file = 'edit-tags.php?taxonomy=link_category'
	} else {
		var_parent_file = 'edit.php'
		var_submenu_file = "edit-tags.php?taxonomy=${var_taxonomy.to_string()}"
	}
	rt.call_function('add_screen_option', [rt.new_string('per_page'), rt.create_array([rt.ArrayItem{ key: 'default', val: 20 }, rt.ArrayItem{ key: 'option', val: 'edit_' + (rt.get_property(var_tax, 'name')).str() + '_per_page' }])])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_screen_reader_content', [rt.create_array([rt.ArrayItem{ key: 'heading_pagination', val: rt.get_property(rt.get_property(var_tax, 'labels'), 'items_list_navigation') }, rt.ArrayItem{ key: 'heading_list', val: rt.get_property(rt.get_property(var_tax, 'labels'), 'items_list') }])])
	mut var_location := rt.new_bool(rt.new_bool(false))
	mut var_referer := rt.call_function('wp_get_referer', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_referer)))) {
		var_referer = rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('REQUEST_URI')])
	}
	var_referer = rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: '_wp_http_referer' }, rt.ArrayItem{ key: none, val: '_wpnonce' }, rt.ArrayItem{ key: none, val: 'error' }, rt.ArrayItem{ key: none, val: 'message' }, rt.ArrayItem{ key: none, val: 'paged' }]), var_referer.dup()])
	mut switch_val_1 := rt.call_method(var_wp_list_table, 'current_action', []rt.PhpVal{})
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('add-tag'))) {
		rt.call_function('check_admin_referer', [rt.new_string('add-tag'), rt.new_string('_wpnonce_add-tag')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_tax, 'cap'), 'edit_terms')]))))) {
			rt.call_function('wp_die', ['<h1>' + (rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() + '</h1>' + '<p>' + (rt.call_function('__', [rt.new_string('Sorry, you are not allowed to create terms in this taxonomy.')])).str() + '</p>', rt.new_int(403)])
		}
		mut var_ret := rt.call_function('wp_insert_term', [rt.get_superglobal('_POST').array_get('tag-name'), var_taxonomy.dup(), rt.get_superglobal('_POST').dup()])
		if rt.is_true(rt.new_bool(rt.is_true(var_ret) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_ret.dup()]))))))) {
			var_location = rt.call_function('add_query_arg', [rt.new_string('message'), rt.new_int(1), var_referer.dup()])
		} else {
			var_location = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'error', val: true }, rt.ArrayItem{ key: 'message', val: 4 }]), var_referer.dup()])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete'))) {
		if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('tag_ID'))) {
			break
		}
		mut var_tag_ID := // unsupported expression: Expr_Cast_Int
		rt.call_function('check_admin_referer', ['delete-tag_' + (var_tag_ID).str()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_term'), var_tag_ID.dup()]))))) {
			rt.call_function('wp_die', ['<h1>' + (rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() + '</h1>' + '<p>' + (rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete this item.')])).str() + '</p>', rt.new_int(403)])
		}
		rt.call_function('wp_delete_term', [var_tag_ID.dup(), var_taxonomy.dup()])
		var_location = rt.call_function('add_query_arg', [rt.new_string('message'), rt.new_int(2), var_referer.dup()])
		var_location = rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: 'tag_ID' }, rt.ArrayItem{ key: none, val: 'action' }]), var_location.dup()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('bulk-delete'))) {
		rt.call_function('check_admin_referer', [rt.new_string('bulk-tags')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_tax, 'cap'), 'delete_terms')]))))) {
			rt.call_function('wp_die', ['<h1>' + (rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() + '</h1>' + '<p>' + (rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete these items.')])).str() + '</p>', rt.new_int(403)])
		}
		mut var_tags := rt.cast_array(rt.get_superglobal('_REQUEST').array_get('delete_tags'))
		{
			mut iter_1 := var_tags.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_tag_ID_shadow := item_1.val
				rt.call_function('wp_delete_term', [var_tag_ID_shadow.dup(), var_taxonomy.dup()])
			}
		}
		var_location = rt.call_function('add_query_arg', [rt.new_string('message'), rt.new_int(6), var_referer.dup()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit'))) {
		if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('tag_ID'))) {
			break
		}
		mut var_term_id := // unsupported expression: Expr_Cast_Int
		mut var_term := rt.call_function('get_term', [var_term_id.dup()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_term, 'WP_Term')))))) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('You attempted to edit an item that does not exist. Perhaps it was deleted?')])])
		}
		rt.call_function('wp_redirect', [rt.call_function('sanitize_url', [rt.call_function('get_edit_term_link', [var_term_id.dup(), var_taxonomy.dup(), var_post_type.dup()])])])
		// unsupported expression: Expr_Exit
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('editedtag'))) {
		var_tag_ID = // unsupported expression: Expr_Cast_Int
		rt.call_function('check_admin_referer', ['update-tag_' + (var_tag_ID).str()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_term'), var_tag_ID.dup()]))))) {
			rt.call_function('wp_die', ['<h1>' + (rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() + '</h1>' + '<p>' + (rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this item.')])).str() + '</p>', rt.new_int(403)])
		}
		mut var_tag := rt.call_function('get_term', [var_tag_ID.dup(), var_taxonomy.dup()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_tag)))) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('You attempted to edit an item that does not exist. Perhaps it was deleted?')])])
		}
		var_ret = rt.call_function('wp_update_term', [var_tag_ID.dup(), var_taxonomy.dup(), rt.get_superglobal('_POST').dup()])
		if rt.is_true(rt.new_bool(rt.is_true(var_ret) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_ret.dup()]))))))) {
			var_location = rt.call_function('add_query_arg', [rt.new_string('message'), rt.new_int(3), var_referer.dup()])
		} else {
			var_location = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'error', val: true }, rt.ArrayItem{ key: 'message', val: 5 }]), var_referer.dup()])
		}
	} else {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_list_table, 'current_action', []rt.PhpVal{}))))) || !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('delete_tags'))))) {
			break
		}
		rt.call_function('check_admin_referer', [rt.new_string('bulk-tags')])
		mut var_screen := rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'id')
		var_tags = rt.cast_array(rt.get_superglobal('_REQUEST').array_get('delete_tags'))
		var_location = rt.call_function('apply_filters', [rt.new_string("handle_bulk_actions-${var_screen.to_string()}"), var_location.dup(), rt.call_method(var_wp_list_table, 'current_action', []rt.PhpVal{}), var_tags.dup()])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_location)))) && !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('_wp_http_referer'))))) {
		var_location = rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: '_wp_http_referer' }, rt.ArrayItem{ key: none, val: '_wpnonce' }]), rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('REQUEST_URI')])])
	}
	if rt.is_true(var_location) {
		if rt.is_true(rt.greater(var_pagenum, rt.new_int(1))) {
			var_location = rt.call_function('add_query_arg', [rt.new_string('paged'), var_pagenum.dup(), var_location.dup()])
			// unsupported statement: Stmt_Nop
		}
		if rt.is_true(rt.identical(rt.new_int(1), var_pagenum)) {
			var_location = rt.call_function('remove_query_arg', [rt.new_string('paged'), var_location.dup()])
		}
		rt.call_function('wp_redirect', [rt.call_function('apply_filters', [rt.new_string('redirect_term_location'), var_location.dup(), var_tax.dup()])])
		// unsupported expression: Expr_Exit
	}
	rt.call_method(var_wp_list_table, 'prepare_items', []rt.PhpVal{})
	mut var_total_pages := rt.call_method(var_wp_list_table, 'get_pagination_arg', [rt.new_string('total_pages')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_pagenum, var_total_pages)) && rt.is_true(rt.greater(var_total_pages, rt.new_int(0))))) {
		rt.call_function('wp_redirect', [rt.call_function('add_query_arg', [rt.new_string('paged'), var_total_pages.dup()])])
		// unsupported expression: Expr_Exit
	}
	rt.call_function('wp_enqueue_script', [rt.new_string('admin-tags')])
	if rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_tax, 'cap'), 'edit_terms')])) {
		rt.call_function('wp_enqueue_script', [rt.new_string('inline-edit-tax')])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy)) || rt.is_true(rt.identical(rt.new_string('link_category'), var_taxonomy)))) || rt.is_true(rt.identical(rt.new_string('post_tag'), var_taxonomy)))) {
		mut var_help := rt.new_string(rt.new_string(''))
		if rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy)) {
			var_help = rt.new_string('<p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You can use categories to define sections of your site and group related posts. The default category is &#8220;Uncategorized&#8221; until you change it in your <a href="%s">writing settings</a>.')]), rt.new_string('options-writing.php')])).str() + '</p>')
		} else if rt.is_true(rt.identical(rt.new_string('link_category'), var_taxonomy)) {
			var_help = rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('You can create groups of links by using Link Categories. Link Category names must be unique and Link Categories are separate from the categories you use for posts.')])).str() + '</p>')
		} else {
			var_help = rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('You can assign keywords to your posts using <strong>tags</strong>. Unlike categories, tags have no hierarchy, meaning there is no relationship from one tag to another.')])).str() + '</p>')
		}
		if rt.is_true(rt.identical(rt.new_string('link_category'), var_taxonomy)) {
			// unsupported expression: Expr_AssignOp_Concat
		} else {
			// unsupported expression: Expr_AssignOp_Concat
		}
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview')]) }, rt.ArrayItem{ key: 'content', val: var_help }])])
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy)) || rt.is_true(rt.identical(rt.new_string('post_tag'), var_taxonomy)))) {
			if rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy)) {
				var_help = rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('When adding a new category on this screen, you&#8217;ll fill in the following fields:')])).str() + '</p>')
			} else {
				var_help = rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('When adding a new tag on this screen, you&#8217;ll fill in the following fields:')])).str() + '</p>')
			}
			// unsupported expression: Expr_AssignOp_Concat
			// unsupported expression: Expr_AssignOp_Concat
			if rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy)) {
				// unsupported expression: Expr_AssignOp_Concat
			}
			// unsupported expression: Expr_AssignOp_Concat
			rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'adding-terms' }, rt.ArrayItem{ key: 'title', val: if rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy)) { rt.call_function('__', [rt.new_string('Adding Categories')]) } else { rt.call_function('__', [rt.new_string('Adding Tags')]) } }, rt.ArrayItem{ key: 'content', val: var_help }])])
		}
		var_help = rt.new_string('<p><strong>' + (rt.call_function('__', [rt.new_string('For more information:')])).str() + '</strong></p>')
		if rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy)) {
			// unsupported expression: Expr_AssignOp_Concat
		} else if rt.is_true(rt.identical(rt.new_string('link_category'), var_taxonomy)) {
			// unsupported expression: Expr_AssignOp_Concat
		} else {
			// unsupported expression: Expr_AssignOp_Concat
		}
		// unsupported expression: Expr_AssignOp_Concat
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [var_help.dup()])
		var_help = rt.new_null()
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/edit-tag-messages.php', '4')
	if rt.is_true(rt.call_function('is_plugin_active', [rt.new_string('wpcat2tag-importer/wpcat2tag-importer.php')])) {
		mut var_import_link := rt.call_function('admin_url', [rt.new_string('admin.php?import=wpcat2tag')])
	} else {
		var_import_link = rt.call_function('admin_url', [])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [.dup()]))
	// unsupported statement: Stmt_InlineHTML
}
