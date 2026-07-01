import rt

struct Class_WP_Media_List_Table {
	rt.PhpObjectBase
pub mut:
		comment_pending_count rt.PhpVal = rt.new_array()
		detached bool
		is_trash bool
}

fn (mut this Class_WP_Media_List_Table) construct(var_args rt.PhpVal)  {
	this.detached = rt.get_superglobal('_REQUEST').array_isset(rt.new_string('attachment-filter')) && rt.is_true(rt.identical(rt.new_string('detached'), rt.get_superglobal('_REQUEST').array_get('attachment-filter')))
	this.dispatch_set_prop('modes', rt.create_array([rt.ArrayItem{ key: 'list', val: rt.call_function('__', [rt.new_string('List view')]) }, rt.ArrayItem{ key: 'grid', val: rt.call_function('__', [rt.new_string('Grid view')]) }]))
	this.Class_WP_List_Table.construct(rt.create_array([rt.ArrayItem{ key: 'plural', val: 'media' }, rt.ArrayItem{ key: 'screen', val: if !(var_args.array_get('screen')).is_null() { var_args.array_get('screen') } else { rt.new_null() } }]))
}

fn (mut this Class_WP_Media_List_Table) ajax_user_can() rt.PhpVal {
	return rt.call_function('current_user_can', [rt.new_string('upload_files')])
}

fn (mut this Class_WP_Media_List_Table) prepare_items()  {
	mut var_wp_query := rt.new_null()
	mut var_post_mime_types := rt.new_null()
	mut var_avail_post_mime_types := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_mode := if !rt.is_true(rt.get_superglobal('_REQUEST').array_get('mode')) { rt.new_string('list') } else { rt.get_superglobal('_REQUEST').array_get('mode') }
	mut var_not_in := rt.new_array()
	mut var_crons := rt.call_function('_get_cron_array', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(var_crons.dup().is_array())) {
		{
			mut iter_1 := var_crons.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_cron := item_1.val
				if var_cron.array_isset(rt.new_string('upgrader_scheduled_cleanup')) {
					mut var_details := rt.call_function('reset', [var_cron.array_get('upgrader_scheduled_cleanup')])
					if !(!rt.is_true(var_details.array_get('args').array_get(0))) {
						var_not_in.array_push(// unsupported expression: Expr_Cast_Int)
					}
				}
			}
		}
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('post__not_in'))) && rt.is_true(rt.new_bool(rt.get_superglobal('_REQUEST').array_get('post__not_in').is_array())))) {
		var_not_in = rt.call_function('array_merge', [rt.call_function('array_values', [rt.get_superglobal('_REQUEST').array_get('post__not_in')]), var_not_in.dup()])
	}
	if !(!rt.is_true(var_not_in)) {
		rt.get_superglobal('_REQUEST').array_set('post__not_in', var_not_in.dup())
	}
	// unsupported assign target: Expr_List
	this.is_trash = rt.get_superglobal('_REQUEST').array_isset(rt.new_string('attachment-filter')) && rt.is_true(rt.identical(rt.new_string('trash'), rt.get_superglobal('_REQUEST').array_get('attachment-filter')))
	this.set_pagination_args(rt.create_array([rt.ArrayItem{ key: 'total_items', val: rt.get_property(var_wp_query, 'found_posts') }, rt.ArrayItem{ key: 'total_pages', val: rt.get_property(var_wp_query, 'max_num_pages') }, rt.ArrayItem{ key: 'per_page', val: rt.get_property(var_wp_query, 'query_vars').array_get('posts_per_page') }]))
	if rt.is_true(rt.get_property(var_wp_query, 'posts')) {
		rt.call_function('update_post_thumbnail_cache', [var_wp_query.dup()])
		rt.call_function('update_post_parent_caches', [rt.get_property(var_wp_query, 'posts')])
	}
}

fn (mut this Class_WP_Media_List_Table) get_views() rt.PhpVal {
	mut var_post_mime_types := rt.new_null()
	mut var_avail_post_mime_types := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_type_links := rt.new_array()
	mut var_filter := if !rt.is_true(rt.get_superglobal('_GET').array_get('attachment-filter')) { rt.new_string('') } else { rt.get_superglobal('_GET').array_get('attachment-filter') }
	var_type_links.array_set('all', rt.call_function('sprintf', [rt.new_string('<option value=""%s>%s</option>'), rt.call_function('selected', [var_filter.dup(), rt.new_bool(true), rt.new_bool(false)]), rt.call_function('__', [rt.new_string('All media items')])]))
	{
		mut iter_1 := var_post_mime_types.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_label := item_1.val
			mut var_mime_type := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_match_mime_types', [var_mime_type.dup(), var_avail_post_mime_types.dup()]))))) {
				continue
			}
			mut var_selected := rt.call_function('selected', [rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_filter) && rt.is_true(rt.call_function('str_starts_with', [var_filter.dup(), rt.new_string('post_mime_type:')])))) && rt.is_true(rt.call_function('wp_match_mime_types', [var_mime_type.dup(), rt.call_function('str_replace', [rt.new_string('post_mime_type:'), rt.new_string(''), var_filter.dup()])]))), rt.new_bool(true), rt.new_bool(false)])
			var_type_links.array_set(var_mime_type, rt.call_function('sprintf', [rt.new_string('<option value="post_mime_type:%s"%s>%s</option>'), rt.call_function('esc_attr', [var_mime_type.dup()]), var_selected.dup(), var_label.array_get(0)]))
		}
	}
	var_type_links.array_set('detached', '<option value="detached"' + if rt.is_true(this.detached) { ' selected="selected"' } else { '' } + '>' + (rt.call_function('_x', [rt.new_string('Unattached'), rt.new_string('media items')])).str() + '</option>')
	var_type_links.array_set('mine', rt.call_function('sprintf', [rt.new_string('<option value="mine"%s>%s</option>'), rt.call_function('selected', [rt.identical(rt.new_string('mine'), var_filter), rt.new_bool(true), rt.new_bool(false)]), rt.call_function('_x', [rt.new_string('Mine'), rt.new_string('media items')])]))
	if rt.is_true(rt.new_bool(rt.is_true(this.is_trash) || rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('MEDIA_TRASH')])) && rt.is_true(rt.get_constant('MEDIA_TRASH')))))) {
		var_type_links.array_set('trash', rt.call_function('sprintf', [rt.new_string('<option value="trash"%s>%s</option>'), rt.call_function('selected', [rt.identical(rt.new_string('trash'), var_filter), rt.new_bool(true), rt.new_bool(false)]), rt.call_function('_x', [rt.new_string('Trash'), rt.new_string('attachment filter')])]))
	}
	return var_type_links.dup()
}

fn (mut this Class_WP_Media_List_Table) get_bulk_actions() rt.PhpVal {
	mut var_actions := rt.new_array()
	if rt.is_true(rt.get_constant('MEDIA_TRASH')) {
		if rt.is_true(this.is_trash) {
			var_actions.array_set('untrash', rt.call_function('__', [rt.new_string('Restore')]))
			var_actions.array_set('delete', rt.call_function('__', [rt.new_string('Delete permanently')]))
		} else {
			var_actions.array_set('trash', rt.call_function('__', [rt.new_string('Move to Trash')]))
		}
	} else {
		var_actions.array_set('delete', rt.call_function('__', [rt.new_string('Delete permanently')]))
	}
	if rt.is_true(this.detached) {
		var_actions.array_set('attach', rt.call_function('__', [rt.new_string('Attach')]))
	}
	return var_actions.dup()
}

fn (mut this Class_WP_Media_List_Table) extra_tablenav(var_which rt.PhpVal)  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_trash)))) {
		this.months_dropdown(rt.new_string('attachment'))
	}
	rt.call_function('do_action', [rt.new_string('restrict_manage_posts'), rt.get_property(rt.get_property(rt.new_object('WP_Media_List_Table', ['WP_List_Table'], &this), 'screen'), 'post_type'), var_which.dup()])
	rt.call_function('submit_button', [rt.call_function('__', [rt.new_string('Filter')]), rt.new_string(''), rt.new_string('filter_action'), rt.new_bool(false), rt.create_array([rt.ArrayItem{ key: 'id', val: 'post-query-submit' }])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(this.is_trash) && rt.is_true(this.has_items()))) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_others_posts')])))) {
		rt.call_function('submit_button', [rt.call_function('__', [rt.new_string('Empty Trash')]), rt.new_string('apply'), rt.new_string('delete_all'), rt.new_bool(false)])
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Media_List_Table) current_action() string {
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('found_post_id')) && rt.get_superglobal('_REQUEST').array_isset(rt.new_string('media')) {
		return 'attach'
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('parent_post_id')) && rt.get_superglobal('_REQUEST').array_isset(rt.new_string('media')) {
		return 'detach'
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('delete_all')) || rt.get_superglobal('_REQUEST').array_isset(rt.new_string('delete_all2')) {
		return 'delete_all'
	}
	return (this.Class_WP_List_Table.current_action()).str()
}

fn (mut this Class_WP_Media_List_Table) has_items() rt.PhpVal {
	return rt.call_function('have_posts', []rt.PhpVal{})
}

fn (mut this Class_WP_Media_List_Table) no_items()  {
	if rt.is_true(this.is_trash) {
		rt.call_function('_e', [rt.new_string('No media files found in Trash.')])
	} else {
		rt.call_function('_e', [rt.new_string('No media files found.')])
	}
}

fn (mut this Class_WP_Media_List_Table) views()  {
	mut var_mode := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_views := this.get_views()
	rt.call_method(rt.get_property(rt.new_object('WP_Media_List_Table', ['WP_List_Table'], &this), 'screen'), 'render_screen_reader_content', [rt.new_string('heading_views')])
	// unsupported statement: Stmt_InlineHTML
	this.view_switcher(var_mode.dup())
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Filter by type')])
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_views)) {
		{
			mut iter_1 := var_views.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_view := item_1.val
				mut var_class := item_1.key
				print("\t${var_view.to_string()}\n")
			}
		}
	}
	// unsupported statement: Stmt_InlineHTML
	this.extra_tablenav(rt.new_string('bar'))
	var_views = rt.call_function('apply_filters', [rt.concat(rt.new_string('views_'), rt.get_property(rt.get_property(rt.new_object('WP_Media_List_Table', ['WP_List_Table'], &this), 'screen'), 'id')), rt.new_array()])
	if !(!rt.is_true(var_views)) {
		print('<ul class="filter-links">')
		{
			mut iter_1 := var_views.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_view := item_1.val
				mut var_class := item_1.key
				print("<li class='${var_class.to_string()}'>${var_view.to_string()}</li>")
			}
		}
		print('</ul>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Search Media')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_admin_search_query', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Search Media')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Media_List_Table) get_columns() rt.PhpVal {
	mut var_posts_columns := rt.new_array()
	var_posts_columns.array_set('cb', '<input type="checkbox" />')
	var_posts_columns.array_set('title', rt.call_function('_x', [rt.new_string('File'), rt.new_string('column name')]))
	var_posts_columns.array_set('author', rt.call_function('__', [rt.new_string('Author')]))
	mut var_taxonomies := rt.call_function('get_taxonomies_for_attachments', [rt.new_string('objects')])
	var_taxonomies = rt.call_function('wp_filter_object_list', [var_taxonomies.dup(), rt.create_array([rt.ArrayItem{ key: 'show_admin_column', val: true }]), rt.new_string('and'), rt.new_string('name')])
	var_taxonomies = rt.call_function('apply_filters', [rt.new_string('manage_taxonomies_for_attachment_columns'), var_taxonomies.dup(), rt.new_string('attachment')])
	var_taxonomies = rt.call_function('array_filter', [var_taxonomies.dup(), rt.new_string('taxonomy_exists')])
	{
		mut iter_1 := var_taxonomies.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_taxonomy := item_1.val
			if rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy)) {
				mut var_column_key := rt.new_string(rt.new_string('categories'))
			} else if rt.is_true(rt.identical(rt.new_string('post_tag'), var_taxonomy)) {
				var_column_key = rt.new_string(rt.new_string('tags'))
			} else {
				var_column_key = rt.new_string('taxonomy-' + (var_taxonomy).str())
			}
			var_posts_columns.array_set(var_column_key, rt.get_property(rt.get_property(rt.call_function('get_taxonomy', [var_taxonomy.dup()]), 'labels'), 'name'))
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.detached)))) {
		var_posts_columns.array_set('parent', rt.call_function('_x', [rt.new_string('Uploaded to'), rt.new_string('column name')]))
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('post_type_supports', [rt.new_string('attachment'), rt.new_string('comments')])) && rt.is_true(rt.call_function('get_option', [rt.new_string('wp_attachment_pages_enabled')])))) {
			var_posts_columns.array_set('comments', rt.call_function('sprintf', [rt.new_string('<span class="vers comment-grey-bubble" title="%1$s" aria-hidden="true"></span><span class="screen-reader-text">%2$s</span>'), rt.call_function('esc_attr__', [rt.new_string('Comments')]), rt.call_function('__', [rt.new_string('Comments')])]))
		}
	}
	var_posts_columns.array_set('date', rt.call_function('_x', [rt.new_string('Date'), rt.new_string('column name')]))
	return rt.call_function('apply_filters', [rt.new_string('manage_media_columns'), var_posts_columns.dup(), this.detached])
}

fn (mut this Class_WP_Media_List_Table) get_sortable_columns() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: none, val: 'title' }, rt.ArrayItem{ key: none, val: false }, rt.ArrayItem{ key: none, val: rt.call_function('_x', [rt.new_string('File'), rt.new_string('column name')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Table ordered by File Name.')]) }]) }, rt.ArrayItem{ key: 'author', val: rt.create_array([rt.ArrayItem{ key: none, val: 'author' }, rt.ArrayItem{ key: none, val: false }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Author')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Table ordered by Author.')]) }]) }, rt.ArrayItem{ key: 'parent', val: rt.create_array([rt.ArrayItem{ key: none, val: 'parent' }, rt.ArrayItem{ key: none, val: false }, rt.ArrayItem{ key: none, val: rt.call_function('_x', [rt.new_string('Uploaded to'), rt.new_string('column name')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Table ordered by Uploaded To.')]) }]) }, rt.ArrayItem{ key: 'comments', val: rt.create_array([rt.ArrayItem{ key: none, val: 'comment_count' }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Comments')]) }, rt.ArrayItem{ key: none, val: false }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Table ordered by Comments.')]) }]) }, rt.ArrayItem{ key: 'date', val: rt.create_array([rt.ArrayItem{ key: none, val: 'date' }, rt.ArrayItem{ key: none, val: true }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Date')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Table ordered by Date.')]) }, rt.ArrayItem{ key: none, val: 'desc' }]) }])
}

fn (mut this Class_WP_Media_List_Table) column_cb(var_item rt.PhpVal)  {
	mut var_post := var_item
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.get_property(var_post, 'ID')])) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(var_post, 'ID'))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val()
	}
}

fn (mut this Class_WP_Media_List_Table) column_title(var_post rt.PhpVal)  {
	mut var_mime := rt.new_null()
	mut var_post_mutated := var_post
	
}

fn (mut this Class_WP_Media_List_Table) column_author(var_post rt.PhpVal)  {
	mut var_post_mutated := var_post
}

fn (mut this Class_WP_Media_List_Table) column_desc(var_post rt.PhpVal)  {
	mut var_post_mutated := var_post
}

fn (mut this Class_WP_Media_List_Table) column_date(var_post rt.PhpVal)  {
	mut var_post_mutated := var_post
}

fn (mut this Class_WP_Media_List_Table) column_parent(var_post rt.PhpVal)  {
	mut var_post_mutated := var_post
}

fn (mut this Class_WP_Media_List_Table) column_comments(var_post rt.PhpVal)  {
	mut var_post_mutated := var_post
}

fn (mut this Class_WP_Media_List_Table) column_default(var_item rt.PhpVal, var_column_name rt.PhpVal)  {
}

fn (mut this Class_WP_Media_List_Table) display_rows()  {
	mut var_post := rt.new_null()
	mut var_wp_query := rt.new_null()
}

fn (mut this Class_WP_Media_List_Table) get_default_primary_column_name() string {
}

fn (mut this Class_WP_Media_List_Table) _get_row_actions(var_post rt.PhpVal, var_att_title rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	mut var_att_title_mutated := var_att_title
}

fn (mut this Class_WP_Media_List_Table) handle_row_actions(var_item rt.PhpVal, var_column_name rt.PhpVal, var_primary rt.PhpVal) string {
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

fn create_wp_media_list_table(arg_0 rt.PhpVal) &Class_WP_Media_List_Table {
	mut obj := &Class_WP_Media_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
		comment_pending_count: rt.new_array()
		detached: false
		is_trash: false
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

fn (mut this Class_WP_Media_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'has_items' {
			return this.has_items()
		}
		'no_items' {
			this.no_items()
			return rt.new_null()
		}
		'views' {
			this.views()
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
		'column_title' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_title(dispatch_arg_0)
			return rt.new_null()
		}
		'column_author' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_author(dispatch_arg_0)
			return rt.new_null()
		}
		'column_desc' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_desc(dispatch_arg_0)
			return rt.new_null()
		}
		'column_date' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_date(dispatch_arg_0)
			return rt.new_null()
		}
		'column_parent' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_parent(dispatch_arg_0)
			return rt.new_null()
		}
		'column_comments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_comments(dispatch_arg_0)
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
		'_get_row_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this._get_row_actions(dispatch_arg_0, dispatch_arg_1)
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

fn (this &Class_WP_Media_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'comment_pending_count' { return this.comment_pending_count }
		'detached' { return rt.new_bool(this.detached) }
		'is_trash' { return rt.new_bool(this.is_trash) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Media_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'comment_pending_count' { this.comment_pending_count = val; return true }
		'detached' { this.detached = (val).to_bool(); return true }
		'is_trash' { this.is_trash = (val).to_bool(); return true }
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




pub fn init_wp_admin_includes_class_wp_media_list_table_php() {
}
