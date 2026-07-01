import rt

struct Class_WP_Posts_List_Table {
	rt.PhpObjectBase
pub mut:
		hierarchical_display rt.PhpVal = rt.new_null()
		comment_pending_count rt.PhpVal = rt.new_null()
		user_posts_count rt.PhpVal = rt.new_null()
		sticky_posts_count rt.PhpVal = rt.new_int(0)
		is_trash bool
		current_level rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_WP_Posts_List_Table) construct(var_args rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	// unsupported statement: Stmt_Global
	this.Class_WP_List_Table.construct(rt.create_array([rt.ArrayItem{ key: 'plural', val: 'posts' }, rt.ArrayItem{ key: 'screen', val: if !(var_args_mutated.array_get('screen')).is_null() { var_args_mutated.array_get('screen') } else { rt.new_null() } }]))
	mut var_post_type := rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', ['WP_List_Table'], &this), 'screen'), 'post_type')
	mut var_post_type_object := rt.call_function('get_post_type_object', [var_post_type.dup()])
	mut var_exclude_states := rt.call_function('get_post_stati', [rt.create_array([rt.ArrayItem{ key: 'show_in_admin_all_list', val: false }])])
	this.user_posts_count = // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(this.user_posts_count) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_object, 'cap'), 'edit_others_posts')]))))))) && !rt.is_true(rt.get_superglobal('_REQUEST').array_get('post_status')))) && !rt.is_true(rt.get_superglobal('_REQUEST').array_get('all_posts')))) && !rt.is_true(rt.get_superglobal('_REQUEST').array_get('author')))) && !rt.is_true(rt.get_superglobal('_REQUEST').array_get('show_sticky')))) {
		rt.get_superglobal('_GET').array_set('author', rt.call_function('get_current_user_id', []rt.PhpVal{}))
	}
	mut var_sticky_posts := rt.call_function('get_option', [rt.new_string('sticky_posts')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('post'), var_post_type)) && rt.is_true(var_sticky_posts))) {
		var_sticky_posts = rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_map', [rt.new_string('absint'), rt.cast_array(var_sticky_posts)])])
		this.sticky_posts_count = // unsupported expression: Expr_Cast_Int
	}
}

fn (mut this Class_WP_Posts_List_Table) set_hierarchical_display(var_display rt.PhpVal)  {
	this.hierarchical_display = var_display.dup()
}

fn (mut this Class_WP_Posts_List_Table) ajax_user_can() rt.PhpVal {
	return rt.call_function('current_user_can', [rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', ['WP_List_Table'], &this), 'screen'), 'post_type')]), 'cap'), 'edit_posts')])
}

fn (mut this Class_WP_Posts_List_Table) prepare_items()  {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('mode'))) {
		mut var_mode := rt.new_string(if rt.is_true(rt.identical(rt.new_string('excerpt'), rt.get_superglobal('_REQUEST').array_get('mode'))) { rt.new_string('excerpt') } else { rt.new_string('list') })
		rt.call_function('set_user_setting', [rt.new_string('posts_list_mode'), var_mode.dup()])
	} else {
		var_mode = rt.call_function('get_user_setting', [rt.new_string('posts_list_mode'), rt.new_string('list')])
	}
	mut var_avail_post_stati := rt.call_function('wp_edit_posts_query', []rt.PhpVal{})
	this.set_hierarchical_display(rt.new_bool(rt.is_true(rt.call_function('is_post_type_hierarchical', [rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', ['WP_List_Table'], &this), 'screen'), 'post_type')])) && rt.is_true(rt.identical(rt.new_string('menu_order title'), rt.get_property(var_wp_query, 'query').array_get('orderby')))))
	mut var_post_type := rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', ['WP_List_Table'], &this), 'screen'), 'post_type')
	mut var_per_page := this.get_items_per_page(rt.new_string('edit_' + (var_post_type).str() + '_per_page'))
	var_per_page = rt.call_function('apply_filters', [rt.new_string('edit_posts_per_page'), var_per_page.dup(), var_post_type.dup()])
	if rt.is_true(this.hierarchical_display) {
		mut var_total_items := rt.get_property(var_wp_query, 'post_count')
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.get_property(var_wp_query, 'found_posts')) || rt.is_true(rt.identical(this.get_pagenum(), rt.new_int(1))))) {
		var_total_items = rt.get_property(var_wp_query, 'found_posts')
	} else {
		mut var_post_counts := rt.cast_array(rt.call_function('wp_count_posts', [var_post_type.dup(), rt.new_string('readable')]))
		if rt.is_true(rt.new_bool(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('post_status')) && rt.is_true(rt.call_function('in_array', [rt.get_superglobal('_REQUEST').array_get('post_status'), var_avail_post_stati.dup(), rt.new_bool(true)])))) {
			var_total_items = var_post_counts.array_get(rt.get_superglobal('_REQUEST').array_get('post_status'))
		} else if rt.is_true(rt.new_bool(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('show_sticky')) && rt.is_true(rt.get_superglobal('_REQUEST').array_get('show_sticky')))) {
			var_total_items = this.sticky_posts_count
		} else if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('author')) && rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), // unsupported expression: Expr_Cast_Int)))) {
			var_total_items = this.user_posts_count
		} else {
			var_total_items = rt.call_function('array_sum', [var_post_counts.dup()])
			{
				mut iter_1 := rt.call_function('get_post_stati', [rt.create_array([rt.ArrayItem{ key: 'show_in_admin_all_list', val: false }])]).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_state := item_1.val
					// unsupported expression: Expr_AssignOp_Minus
				}
			}
		}
	}
	this.is_trash = rt.get_superglobal('_REQUEST').array_isset(rt.new_string('post_status')) && rt.is_true(rt.identical(rt.new_string('trash'), rt.get_superglobal('_REQUEST').array_get('post_status')))
	this.set_pagination_args(rt.create_array([rt.ArrayItem{ key: 'total_items', val: var_total_items }, rt.ArrayItem{ key: 'per_page', val: var_per_page }]))
}

fn (mut this Class_WP_Posts_List_Table) has_items() rt.PhpVal {
	return rt.call_function('have_posts', []rt.PhpVal{})
}

fn (mut this Class_WP_Posts_List_Table) no_items()  {
	if rt.is_true(rt.new_bool(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('post_status')) && rt.is_true(rt.identical(rt.new_string('trash'), rt.get_superglobal('_REQUEST').array_get('post_status'))))) {
		rt.echo_val(rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', ['WP_List_Table'], &this), 'screen'), 'post_type')]), 'labels'), 'not_found_in_trash'))
	} else {
		rt.echo_val(rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', ['WP_List_Table'], &this), 'screen'), 'post_type')]), 'labels'), 'not_found'))
	}
}

fn (mut this Class_WP_Posts_List_Table) is_base_request() bool {
	mut var_vars := rt.get_superglobal('_GET').dup()
	var_vars.array_unset(rt.new_string('paged'))
	if !rt.is_true(var_vars) {
		return true
	} else if 1 == var_vars.dup().array_count() && !(!rt.is_true(var_vars.array_get('post_type'))) {
		return (rt.identical(rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', ['WP_List_Table'], &this), 'screen'), 'post_type'), var_vars.array_get('post_type'))).to_bool()
	}
	return 1 == var_vars.dup().array_count() && !(!rt.is_true(var_vars.array_get('mode')))
}

fn (mut this Class_WP_Posts_List_Table) get_edit_link(var_args rt.PhpVal, var_link_text rt.PhpVal, css_class string) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_url := rt.call_function('add_query_arg', [var_args_mutated.dup(), rt.new_string('edit.php')])
	mut var_class_html := rt.new_string(rt.new_string(''))
	mut var_aria_current := rt.new_string(rt.new_string(''))
	if !(css_class == '') {
		var_class_html = rt.call_function('sprintf', [rt.new_string(' class="%s"'), rt.call_function('esc_attr', [rt.new_string(css_class)])])
		if rt.is_true(rt.identical(rt.new_string('current'), rt.new_string(css_class))) {
			var_aria_current = rt.new_string(rt.new_string(' aria-current="page"'))
		}
	}
	return rt.call_function('sprintf', [rt.new_string('<a href="%s"%s%s>%s</a>'), rt.call_function('esc_url', [var_url.dup()]), var_class_html.dup(), var_aria_current.dup(), var_link_text.dup()])
}

fn (mut this Class_WP_Posts_List_Table) get_views() rt.PhpVal {
	mut var_locked_post_status := rt.new_null()
	mut var_avail_post_stati := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_post_type := rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', ['WP_List_Table'], &this), 'screen'), 'post_type')
	if !(!rt.is_true(var_locked_post_status)) {
		return rt.new_array()
	}
	mut var_status_links := rt.new_array()
	mut var_num_posts := rt.call_function('wp_count_posts', [var_post_type.dup(), rt.new_string('readable')])
	mut var_total_posts := rt.call_function('array_sum', [rt.cast_array(var_num_posts)])
	mut var_class := rt.new_string(rt.new_string(''))
	mut var_current_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	mut var_all_args := { 'post_type': var_post_type }
	mut var_mine := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := rt.call_function('get_post_stati', [rt.create_array([rt.ArrayItem{ key: 'show_in_admin_all_list', val: false }])]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_state := item_1.val
			// unsupported expression: Expr_AssignOp_Minus
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(this.user_posts_count) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('author')) && rt.is_true(rt.identical(var_current_user_id, // unsupported expression: Expr_Cast_Int)))) {
			var_class = rt.new_string(rt.new_string('current'))
		}
		mut var_mine_args := { 'post_type': var_post_type, 'author': var_current_user_id }
		mut var_mine_inner_html := rt.call_function('sprintf', [rt.call_function('_nx', [rt.new_string('Mine <span class="count">(%s)</span>'), rt.new_string('Mine <span class="count">(%s)</span>'), this.user_posts_count, rt.new_string('posts')]), rt.call_function('number_format_i18n', [this.user_posts_count])])
		var_mine = rt.create_array([rt.ArrayItem{ key: 'url', val: rt.call_function('esc_url', [rt.call_function('add_query_arg', [var_mine_args.dup(), rt.new_string('edit.php')])]) }, rt.ArrayItem{ key: 'label', val: var_mine_inner_html }, rt.ArrayItem{ key: 'current', val: rt.get_superglobal('_GET').array_isset(rt.new_string('author')) && rt.is_true(rt.identical(var_current_user_id, // unsupported expression: Expr_Cast_Int)) }])
		var_all_args['all_posts'] = rt.new_int(1)
		var_class = rt.new_string(rt.new_string(''))
	}
	mut var_all_inner_html := rt.call_function('sprintf', [rt.call_function('_nx', [rt.new_string('All <span class="count">(%s)</span>'), rt.new_string('All <span class="count">(%s)</span>'), var_total_posts.dup(), rt.new_string('posts')]), rt.call_function('number_format_i18n', [var_total_posts.dup()])])
	var_status_links.array_set('all', rt.create_array([rt.ArrayItem{ key: 'url', val: rt.call_function('esc_url', [rt.call_function('add_query_arg', [var_all_args.dup(), rt.new_string('edit.php')])]) }, rt.ArrayItem{ key: 'label', val: var_all_inner_html }, rt.ArrayItem{ key: 'current', val: !rt.is_true(var_class) && this.is_base_request() || rt.get_superglobal('_REQUEST').array_isset(rt.new_string('all_posts')) }]))
	if rt.is_true(var_mine) {
		var_status_links.array_set('mine', var_mine.dup())
	}
	{
		mut iter_1 := rt.call_function('get_post_stati', [rt.create_array([rt.ArrayItem{ key: 'show_in_admin_status_list', val: true }]), rt.new_string('objects')]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_status := item_1.val
			var_class = rt.new_string(rt.new_string(''))
			mut var_status_name := rt.get_property(var_status, 'name')
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_status_name.dup(), var_avail_post_stati.dup(), rt.new_bool(true)]))))) || !rt.is_true(rt.get_property(var_num_posts, '{"nodeType":"Expr_Variable","line":369,"name":"status_name"}')))) {
				continue
			}
			if rt.is_true(rt.new_bool(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('post_status')) && rt.is_true(rt.identical(var_status_name, rt.get_superglobal('_REQUEST').array_get('post_status'))))) {
				var_class = rt.new_string(rt.new_string('current'))
			}
			mut var_status_args := { 'post_status': var_status_name, 'post_type': var_post_type }
			mut var_status_label := rt.call_function('sprintf', [rt.call_function('translate_nooped_plural', [rt.get_property(var_status, 'label_count'), rt.get_property(var_num_posts, '{"nodeType":"Expr_Variable","line":383,"name":"status_name"}')]), rt.call_function('number_format_i18n', [rt.get_property(var_num_posts, '{"nodeType":"Expr_Variable","line":384,"name":"status_name"}')])])
			var_status_links.array_set(var_status_name, rt.create_array([rt.ArrayItem{ key: 'url', val: rt.call_function('esc_url', [rt.call_function('add_query_arg', [var_status_args.dup(), rt.new_string('edit.php')])]) }, rt.ArrayItem{ key: 'label', val: var_status_label }, rt.ArrayItem{ key: 'current', val: rt.get_superglobal('_REQUEST').array_isset(rt.new_string('post_status')) && rt.is_true(rt.identical(var_status_name, rt.get_superglobal('_REQUEST').array_get('post_status'))) }]))
		}
	}
	if !(!rt.is_true(this.sticky_posts_count)) {
		var_class = rt.new_string(if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('show_sticky'))) { rt.new_string('current') } else { rt.new_string('') })
		mut var_sticky_args := { 'post_type': var_post_type, 'show_sticky': rt.new_int(1) }
		mut var_sticky_inner_html := rt.call_function('sprintf', [rt.call_function('_nx', [rt.new_string('Sticky <span class="count">(%s)</span>'), rt.new_string('Sticky <span class="count">(%s)</span>'), this.sticky_posts_count, rt.new_string('posts')]), rt.call_function('number_format_i18n', [this.sticky_posts_count])])
		mut var_sticky_link := { 'sticky': { 'url': rt.call_function('esc_url', [rt.call_function('add_query_arg', [var_sticky_args.dup(), rt.new_string('edit.php')])]), 'label': var_sticky_inner_html, 'current': rt.new_bool(!(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('show_sticky')))) } }
		mut var_split := rt.add(rt.new_int(1), rt.call_function('array_search', [if var_status_links.array_isset(rt.new_string('publish')) { rt.new_string('publish') } else { rt.new_string('all') }, rt.func_array_keys(var_status_links.dup()), rt.new_bool(true)]))
		var_status_links = rt.call_function('array_merge', [rt.call_function('array_slice', [var_status_links.dup(), rt.new_int(0), var_split.dup()]), var_sticky_link.dup(), rt.call_function('array_slice', [var_status_links.dup(), var_split.dup()])])
	}
	return this.get_views_links(var_status_links.dup())
}

fn (mut this Class_WP_Posts_List_Table) get_bulk_actions() rt.PhpVal {
	mut var_actions := rt.new_array()
	mut var_post_type_obj := rt.call_function('get_post_type_object', [rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', ['WP_List_Table'], &this), 'screen'), 'post_type')])
	if rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_obj, 'cap'), 'edit_posts')])) {
		if rt.is_true(this.is_trash) {
			var_actions.array_set('untrash', rt.call_function('__', [rt.new_string('Restore')]))
		} else {
			var_actions.array_set('edit', rt.call_function('_x', [rt.new_string('Bulk edit'), rt.new_string('verb')]))
		}
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_obj, 'cap'), 'delete_posts')])) {
		if rt.is_true(rt.new_bool(rt.is_true(this.is_trash) || rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('EMPTY_TRASH_DAYS'))))))) {
			var_actions.array_set('delete', rt.call_function('__', [rt.new_string('Delete permanently')]))
		} else {
			var_actions.array_set('trash', rt.call_function('__', [rt.new_string('Move to Trash')]))
		}
	}
	return var_actions.dup()
}

fn (mut this Class_WP_Posts_List_Table) categories_dropdown(var_post_type rt.PhpVal)  {
	mut var_cat := rt.new_null()
	mut var_post_type_mutated := var_post_type
	// unsupported statement: Stmt_Global
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('is_object_in_taxonomy', [var_post_type_mutated.dup(), rt.new_string('category')])) {
		mut var_dropdown_options := { 'show_option_all': rt.get_property(rt.get_property(rt.call_function('get_taxonomy', []), 'labels'), 'all_items'), 'hide_empty': rt.new_int(0), 'hierarchical': rt.new_int(1), 'show_count': rt.new_int(0), 'orderby': rt.new_string('name'), 'selected': var_cat }
		print('<label class="screen-reader-text" for="cat">' + (rt.get_property(rt.get_property(rt.call_function('get_taxonomy', []), 'labels'), 'filter_by_item')).str() + '</label>')
		rt.call_function('wp_dropdown_categories', [var_dropdown_options.dup()])
	}
}

fn (mut this Class_WP_Posts_List_Table) formats_dropdown(var_post_type rt.PhpVal)  {
	mut var_post_type_mutated := var_post_type
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('disable_formats_dropdown'), rt.new_bool(false), var_post_type_mutated.dup()])) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_object_in_taxonomy', [.dup(), ]))))) || rt.is_true(this.is_trash))) {
		return rt.new_null()
	}
	mut var_used_post_formats := rt.call_function('get_terms', [])
	if rt.is_true(rt.new_bool(!(rt.is_true()))) {
		return rt.new_null()
	}
	
}

fn (mut this Class_WP_Posts_List_Table) extra_tablenav(var_which rt.PhpVal)  {
}

fn (mut this Class_WP_Posts_List_Table) current_action() string {
}

fn (mut this Class_WP_Posts_List_Table) get_table_classes() rt.PhpVal {
	mut var_mode := rt.new_null()
}

fn (mut this Class_WP_Posts_List_Table) get_columns() rt.PhpVal {
}

fn (mut this Class_WP_Posts_List_Table) get_sortable_columns() rt.PhpVal {
}

fn (mut this Class_WP_Posts_List_Table) display_rows(var_posts rt.PhpVal, level i64)  {
	mut var_wp_query := rt.new_null()
	mut var_per_page := rt.new_null()
	mut var_posts_mutated := var_posts
	mut level_mutated := level
}

fn (mut this Class_WP_Posts_List_Table) _display_rows(var_posts rt.PhpVal, level i64)  {
	mut var_posts_mutated := var_posts
	mut level_mutated := level
}

fn (mut this Class_WP_Posts_List_Table) _display_rows_hierarchical(var_pages rt.PhpVal, pagenum i64, per_page i64)  {
	mut var_wpdb := rt.new_null()
	mut var_GLOBALS := rt.new_null()
	mut var_pages_mutated := var_pages
	mut per_page_mutated := per_page
}

fn (mut this Class_WP_Posts_List_Table) _page_rows(var_children_pages rt.PhpVal, var_count rt.PhpVal, var_parent_page rt.PhpVal, var_level rt.PhpVal, var_pagenum rt.PhpVal, var_per_page rt.PhpVal, var_to_display rt.PhpVal)  {
	mut var_children_pages_mutated := var_children_pages
	mut var_count_mutated := var_count
	mut var_level_mutated := var_level
	mut var_per_page_mutated := var_per_page
	mut var_to_display_mutated := var_to_display
}

fn (mut this Class_WP_Posts_List_Table) column_cb(var_item rt.PhpVal)  {
}

fn (mut this Class_WP_Posts_List_Table) _column_title(var_post rt.PhpVal, var_classes rt.PhpVal, var_data rt.PhpVal, var_primary rt.PhpVal)  {
	mut var_post_mutated := var_post
	mut var_classes_mutated := var_classes
}

fn (mut this Class_WP_Posts_List_Table) column_title(var_post rt.PhpVal)  {
	mut var_mode := rt.new_null()
	mut var_post_mutated := var_post
}

fn (mut this Class_WP_Posts_List_Table) column_date(var_post rt.PhpVal)  {
	mut var_mode := rt.new_null()
	mut var_post_mutated := var_post
}

fn (mut this Class_WP_Posts_List_Table) column_comments(var_post rt.PhpVal)  {
	mut var_post_mutated := var_post
}

fn (mut this Class_WP_Posts_List_Table) column_author(var_post rt.PhpVal)  {
	mut var_post_mutated := var_post
}

fn (mut this Class_WP_Posts_List_Table) column_default(var_item rt.PhpVal, var_column_name rt.PhpVal)  {
}

fn (mut this Class_WP_Posts_List_Table) single_row(var_post rt.PhpVal, level i64)  {
	mut var_GLOBALS := rt.new_null()
	mut var_post_mutated := var_post
	mut level_mutated := level
}

fn (mut this Class_WP_Posts_List_Table) get_default_primary_column_name() string {
}

fn (mut this Class_WP_Posts_List_Table) handle_row_actions(var_item rt.PhpVal, var_column_name rt.PhpVal, var_primary rt.PhpVal) string {
}

fn (mut this Class_WP_Posts_List_Table) inline_edit()  {
	mut var_mode := rt.new_null()
	mut var_columns := rt.new_null()
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

fn create_wp_posts_list_table(arg_0 rt.PhpVal) &Class_WP_Posts_List_Table {
	mut obj := &Class_WP_Posts_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
		hierarchical_display: rt.new_null()
		comment_pending_count: rt.new_null()
		user_posts_count: rt.new_null()
		sticky_posts_count: rt.new_int(0)
		is_trash: false
		current_level: rt.new_int(0)
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

fn (mut this Class_WP_Posts_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'set_hierarchical_display' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_hierarchical_display(dispatch_arg_0)
			return rt.new_null()
		}
		'ajax_user_can' {
			return this.ajax_user_can()
		}
		'prepare_items' {
			this.prepare_items()
			return rt.new_null()
		}
		'has_items' {
			return this.has_items()
		}
		'no_items' {
			this.no_items()
			return rt.new_null()
		}
		'is_base_request' {
			return rt.new_bool(this.is_base_request())
		}
		'get_edit_link' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.get_edit_link(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_views' {
			return this.get_views()
		}
		'get_bulk_actions' {
			return this.get_bulk_actions()
		}
		'categories_dropdown' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.categories_dropdown(dispatch_arg_0)
			return rt.new_null()
		}
		'formats_dropdown' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.formats_dropdown(dispatch_arg_0)
			return rt.new_null()
		}
		'extra_tablenav' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.extra_tablenav(dispatch_arg_0)
			return rt.new_null()
		}
		'current_action' {
			return rt.new_string(this.current_action())
		}
		'get_table_classes' {
			return this.get_table_classes()
		}
		'get_columns' {
			return this.get_columns()
		}
		'get_sortable_columns' {
			return this.get_sortable_columns()
		}
		'display_rows' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.display_rows(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'_display_rows' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this._display_rows(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'_display_rows_hierarchical' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			this._display_rows_hierarchical(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'_page_rows' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			dispatch_arg_6 := if args.len > 6 { args[6] } else { rt.new_null() }
			this._page_rows(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5, dispatch_arg_6)
			return rt.new_null()
		}
		'column_cb' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_cb(dispatch_arg_0)
			return rt.new_null()
		}
		'_column_title' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this._column_title(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'column_title' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_title(dispatch_arg_0)
			return rt.new_null()
		}
		'column_date' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_date(dispatch_arg_0)
			return rt.new_null()
		}
		'column_comments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_comments(dispatch_arg_0)
			return rt.new_null()
		}
		'column_author' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_author(dispatch_arg_0)
			return rt.new_null()
		}
		'column_default' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.column_default(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'single_row' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.single_row(dispatch_arg_0, dispatch_arg_1)
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
		'inline_edit' {
			this.inline_edit()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_Posts_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'hierarchical_display' { return this.hierarchical_display }
		'comment_pending_count' { return this.comment_pending_count }
		'user_posts_count' { return this.user_posts_count }
		'sticky_posts_count' { return this.sticky_posts_count }
		'is_trash' { return rt.new_bool(this.is_trash) }
		'current_level' { return this.current_level }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Posts_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'hierarchical_display' { this.hierarchical_display = val; return true }
		'comment_pending_count' { this.comment_pending_count = val; return true }
		'user_posts_count' { this.user_posts_count = val; return true }
		'sticky_posts_count' { this.sticky_posts_count = val; return true }
		'is_trash' { this.is_trash = (val).to_bool(); return true }
		'current_level' { this.current_level = val; return true }
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




pub fn init_wp_admin_includes_class_wp_posts_list_table_php() {
}
