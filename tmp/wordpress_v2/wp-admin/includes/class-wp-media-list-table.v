import rt

struct Class_WP_Media_List_Table {
	rt.PhpObjectBase
pub mut:
		comment_pending_count rt.PhpVal = rt.new_array()
		detached bool
		is_trash bool
}

fn (mut this Class_WP_Media_List_Table) construct(var_args rt.PhpVal) {
	this.detached = rt.get_superglobal('_REQUEST').array_isset(rt.new_string('attachment-filter')) && rt.is_true(rt.identical(rt.new_string('detached'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('attachment-filter'))))
	this.dispatch_set_prop('modes', rt.create_array([rt.ArrayItem{ key: 'list', val: rt.call_function('__', [rt.new_string('List view')]) }, rt.ArrayItem{ key: 'grid', val: rt.call_function('__', [rt.new_string('Grid view')]) }]))
	this.Class_WP_List_Table.construct(rt.create_array([rt.ArrayItem{ key: 'plural', val: 'media' }, rt.ArrayItem{ key: 'screen', val: if !(var_args.array_get(rt.new_string('screen'))).is_null() { var_args.array_get(rt.new_string('screen')) } else { rt.new_null() } }]))
}

fn (mut this Class_WP_Media_List_Table) ajax_user_can() rt.PhpVal {
	return rt.call_function('current_user_can', [rt.new_string('upload_files')])
}

fn (mut this Class_WP_Media_List_Table) prepare_items() {
	mut var_wp_query := rt.new_null()
	mut var_post_mime_types := rt.new_null()
	mut var_avail_post_mime_types := rt.new_null()
	mut var_mode := rt.get_superglobal('mode')
	var_mode = if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('mode'))) { rt.new_string('list') } else { rt.get_superglobal('_REQUEST').array_get(rt.new_string('mode')) }
	mut var_not_in := rt.new_array()
	mut var_crons := rt.call_function('_get_cron_array', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(var_crons.clone().is_array())) {
		mut iter_1 := var_crons.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_cron := item_1.val
			if var_cron.array_isset(rt.new_string('upgrader_scheduled_cleanup')) {
				mut var_details := rt.call_function('reset', [var_cron.array_get(rt.new_string('upgrader_scheduled_cleanup'))])
				if !(!rt.is_true(var_details.array_get(rt.new_string('args')).array_get(rt.new_int(0)))) {
					var_not_in.array_push(rt.new_int((var_details.array_get(rt.new_string('args')).array_get(rt.new_int(0))).to_i64()))
				}
			}
		}
	}
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('post__not_in')))) && rt.get_superglobal('_REQUEST').array_get(rt.new_string('post__not_in')).is_array() {
	var_not_in = rt.call_function('array_merge', [rt.call_function('array_values', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('post__not_in'))]), var_not_in.clone()])
	}
	if !(!rt.is_true(var_not_in)) {
		rt.get_superglobal('_REQUEST').array_set('post__not_in', var_not_in.clone())
	}
	mut list_tmp_1 := rt.call_function('wp_edit_attachments_query', [rt.get_superglobal('_REQUEST').clone()])
	var_post_mime_types = (list_tmp_1).array_get(0)
	var_avail_post_mime_types = (list_tmp_1).array_get(1)
	this.is_trash = rt.get_superglobal('_REQUEST').array_isset(rt.new_string('attachment-filter')) && rt.is_true(rt.identical(rt.new_string('trash'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('attachment-filter'))))
	this.set_pagination_args(rt.create_array([rt.ArrayItem{ key: 'total_items', val: rt.get_property(var_wp_query, 'found_posts') }, rt.ArrayItem{ key: 'total_pages', val: rt.get_property(var_wp_query, 'max_num_pages') }, rt.ArrayItem{ key: 'per_page', val: rt.get_property(var_wp_query, 'query_vars').array_get(rt.new_string('posts_per_page')) }]))
	if rt.is_true(rt.get_property(var_wp_query, 'posts')) {
		rt.call_function('update_post_thumbnail_cache', [var_wp_query.clone()])
		rt.call_function('update_post_parent_caches', [rt.get_property(var_wp_query, 'posts')])
	}
}

fn (mut this Class_WP_Media_List_Table) get_views() rt.PhpVal {
	mut var_post_mime_types := rt.new_null()
	mut var_avail_post_mime_types := rt.new_null()
	mut var_type_links := rt.new_array()
	mut var_filter := if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('attachment-filter'))) { rt.new_string('') } else { rt.get_superglobal('_GET').array_get(rt.new_string('attachment-filter')) }
	var_type_links.array_set('all', rt.call_function('sprintf', [rt.new_string('<option value=""%s>%s</option>'), rt.call_function('selected', [var_filter.clone(), rt.new_bool(true), rt.new_bool(false)]), rt.call_function('__', [rt.new_string('All media items')])]))
	mut iter_2 := var_post_mime_types.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_label := item_2.val
		mut var_mime_type := item_2.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_match_mime_types', [var_mime_type.clone(), var_avail_post_mime_types.clone()]))))) {
			continue
		}
		mut var_selected := rt.call_function('selected', [rt.new_bool(rt.is_true(var_filter) && rt.is_true(rt.call_function('str_starts_with', [var_filter.clone(), rt.new_string('post_mime_type:')])) && rt.is_true(rt.call_function('wp_match_mime_types', [var_mime_type.clone(), rt.call_function('str_replace', [rt.new_string('post_mime_type:'), rt.new_string(''), var_filter.clone()])]))), rt.new_bool(true), rt.new_bool(false)])
		var_type_links.array_set(var_mime_type, rt.call_function('sprintf', [rt.new_string('<option value="post_mime_type:%s"%s>%s</option>'), rt.call_function('esc_attr', [var_mime_type.clone()]), var_selected.clone(), var_label.array_get(rt.new_int(0))]))
	}
	var_type_links.array_set('detached', '<option value="detached"' + if this.detached { ' selected="selected"' } else { '' } + '>' + (rt.call_function('_x', [rt.new_string('Unattached'), rt.new_string('media items')])).str() + '</option>')
	var_type_links.array_set('mine', rt.call_function('sprintf', [rt.new_string('<option value="mine"%s>%s</option>'), rt.call_function('selected', [rt.identical(rt.new_string('mine'), var_filter), rt.new_bool(true), rt.new_bool(false)]), rt.call_function('_x', [rt.new_string('Mine'), rt.new_string('media items')])]))
	if this.is_trash || (rt.is_true(rt.call_function('defined', [rt.new_string('MEDIA_TRASH')])) && rt.is_true(rt.get_constant('MEDIA_TRASH'))) {
		var_type_links.array_set('trash', rt.call_function('sprintf', [rt.new_string('<option value="trash"%s>%s</option>'), rt.call_function('selected', [rt.identical(rt.new_string('trash'), var_filter), rt.new_bool(true), rt.new_bool(false)]), rt.call_function('_x', [rt.new_string('Trash'), rt.new_string('attachment filter')])]))
	}
	return var_type_links.clone()
}

fn (mut this Class_WP_Media_List_Table) get_bulk_actions() rt.PhpVal {
	mut var_actions := rt.new_array()
	if rt.is_true(rt.get_constant('MEDIA_TRASH')) {
		if this.is_trash {
			var_actions.array_set('untrash', rt.call_function('__', [rt.new_string('Restore')]))
			var_actions.array_set('delete', rt.call_function('__', [rt.new_string('Delete permanently')]))
		} else {
			var_actions.array_set('trash', rt.call_function('__', [rt.new_string('Move to Trash')]))
		}
	} else {
		var_actions.array_set('delete', rt.call_function('__', [rt.new_string('Delete permanently')]))
	}
	if this.detached {
		var_actions.array_set('attach', rt.call_function('__', [rt.new_string('Attach')]))
	}
	return var_actions.clone()
}

fn (mut this Class_WP_Media_List_Table) extra_tablenav(var_which rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('bar'), var_which)))) {
		return
	}
	// unsupported statement: Stmt_InlineHTML
	if !(this.is_trash) {
		this.months_dropdown(rt.new_string('attachment'))
	}
	rt.call_function('do_action', [rt.new_string('restrict_manage_posts'), rt.get_property(rt.get_property(rt.new_object('WP_Media_List_Table', ['WP_List_Table'], &this), 'screen'), 'post_type'), var_which.clone()])
	rt.call_function('submit_button', [rt.call_function('__', [rt.new_string('Filter')]), rt.new_string(''), rt.new_string('filter_action'), rt.new_bool(false), rt.create_array([rt.ArrayItem{ key: 'id', val: 'post-query-submit' }])])
	if this.is_trash && rt.is_true(this.has_items()) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_others_posts')])) {
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

fn (mut this Class_WP_Media_List_Table) no_items() {
	if this.is_trash {
		rt.call_function('_e', [rt.new_string('No media files found in Trash.')])
	} else {
		rt.call_function('_e', [rt.new_string('No media files found.')])
	}
}

fn (mut this Class_WP_Media_List_Table) views() {
	mut var_mode := rt.new_null()
	mut var_views := this.get_views()
	rt.call_method(rt.get_property(rt.new_object('WP_Media_List_Table', ['WP_List_Table'], &this), 'screen'), 'render_screen_reader_content', [rt.new_string('heading_views')])
	// unsupported statement: Stmt_InlineHTML
	this.view_switcher(var_mode.clone())
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Filter by type')])
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_views)) {
		mut iter_3 := var_views.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_view := item_3.val
			mut var_class := item_3.key
			print("\t${var_view.to_string()}\n")
		}
	}
	// unsupported statement: Stmt_InlineHTML
	this.extra_tablenav(rt.new_string('bar'))
	var_views = rt.call_function('apply_filters', [rt.concat(rt.new_string('views_'), rt.get_property(rt.get_property(rt.new_object('WP_Media_List_Table', ['WP_List_Table'], &this), 'screen'), 'id')), rt.new_array()])
	if !(!rt.is_true(var_views)) {
		print('<ul class="filter-links">')
		mut iter_4 := var_views.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_view := item_4.val
			mut var_class := item_4.key
			print("<li class='${var_class.to_string()}'>${var_view.to_string()}</li>")
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
	var_taxonomies = rt.call_function('wp_filter_object_list', [var_taxonomies.clone(), rt.create_array([rt.ArrayItem{ key: 'show_admin_column', val: true }]), rt.new_string('and'), rt.new_string('name')])
	var_taxonomies = rt.call_function('apply_filters', [rt.new_string('manage_taxonomies_for_attachment_columns'), var_taxonomies.clone(), rt.new_string('attachment')])
	var_taxonomies = rt.call_function('array_filter', [var_taxonomies.clone(), rt.new_string('taxonomy_exists')])
	mut iter_5 := var_taxonomies.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_taxonomy := item_5.val
		if rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy)) {
		mut var_column_key := rt.new_string('categories')
		} else if rt.is_true(rt.identical(rt.new_string('post_tag'), var_taxonomy)) {
		var_column_key = rt.new_string('tags')
		} else {
		var_column_key = rt.new_string('taxonomy-' + (var_taxonomy).str())
		}
		var_posts_columns.array_set(var_column_key, rt.get_property(rt.get_property(rt.call_function('get_taxonomy', [var_taxonomy.clone()]), 'labels'), 'name'))
	}
	if !(this.detached) {
		var_posts_columns.array_set('parent', rt.call_function('_x', [rt.new_string('Uploaded to'), rt.new_string('column name')]))
		if rt.is_true(rt.call_function('post_type_supports', [rt.new_string('attachment'), rt.new_string('comments')])) && rt.is_true(rt.call_function('get_option', [rt.new_string('wp_attachment_pages_enabled')])) {
			var_posts_columns.array_set('comments', rt.call_function('sprintf', [rt.new_string('<span class="vers comment-grey-bubble" title="%1$s" aria-hidden="true"></span><span class="screen-reader-text">%2$s</span>'), rt.call_function('esc_attr__', [rt.new_string('Comments')]), rt.call_function('__', [rt.new_string('Comments')])]))
		}
	}
	var_posts_columns.array_set('date', rt.call_function('_x', [rt.new_string('Date'), rt.new_string('column name')]))
	return rt.call_function('apply_filters', [rt.new_string('manage_media_columns'), var_posts_columns.clone(), rt.new_bool(this.detached)])
}

fn (mut this Class_WP_Media_List_Table) get_sortable_columns() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: none, val: 'title' }, rt.ArrayItem{ key: none, val: false }, rt.ArrayItem{ key: none, val: rt.call_function('_x', [rt.new_string('File'), rt.new_string('column name')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Table ordered by File Name.')]) }]) }, rt.ArrayItem{ key: 'author', val: rt.create_array([rt.ArrayItem{ key: none, val: 'author' }, rt.ArrayItem{ key: none, val: false }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Author')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Table ordered by Author.')]) }]) }, rt.ArrayItem{ key: 'parent', val: rt.create_array([rt.ArrayItem{ key: none, val: 'parent' }, rt.ArrayItem{ key: none, val: false }, rt.ArrayItem{ key: none, val: rt.call_function('_x', [rt.new_string('Uploaded to'), rt.new_string('column name')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Table ordered by Uploaded To.')]) }]) }, rt.ArrayItem{ key: 'comments', val: rt.create_array([rt.ArrayItem{ key: none, val: 'comment_count' }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Comments')]) }, rt.ArrayItem{ key: none, val: false }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Table ordered by Comments.')]) }]) }, rt.ArrayItem{ key: 'date', val: rt.create_array([rt.ArrayItem{ key: none, val: 'date' }, rt.ArrayItem{ key: none, val: true }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Date')]) }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('Table ordered by Date.')]) }, rt.ArrayItem{ key: none, val: 'desc' }]) }])
}

fn (mut this Class_WP_Media_List_Table) column_cb(var_item rt.PhpVal) {
	mut var_post := var_item
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.get_property(var_post, 'ID')])) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(var_post, 'ID'))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(var_post, 'ID'))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(var_post, 'ID'))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('__', [rt.new_string('Select %s')]), rt.call_function('_draft_or_post_title', []rt.PhpVal{})])
		// unsupported statement: Stmt_InlineHTML
	}
}

fn (mut this Class_WP_Media_List_Table) column_title(var_post rt.PhpVal) {
	mut var_mime := rt.new_null()
	mut var_post_mutated := var_post
	mut list_tmp_2 := rt.call_function('explode', [rt.new_string('/'), rt.get_property(var_post_mutated, 'post_mime_type')])
	var_mime = (list_tmp_2).array_get(0)
	mut var_attachment_id := rt.get_property(var_post_mutated, 'ID')
	if rt.is_true(rt.call_function('has_post_thumbnail', [var_post_mutated.clone()])) {
		mut var_thumbnail_id := rt.call_function('get_post_thumbnail_id', [var_post_mutated.clone()])
		if !(!rt.is_true(var_thumbnail_id)) {
		var_attachment_id = var_thumbnail_id.clone()
		}
	}
	mut var_title := rt.call_function('_draft_or_post_title', []rt.PhpVal{})
	mut var_thumb := rt.call_function('wp_get_attachment_image', [var_attachment_id.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 60 }, rt.ArrayItem{ key: none, val: 60 }]), rt.new_bool(true), rt.create_array([rt.ArrayItem{ key: 'alt', val: '' }])])
	mut var_link_start := rt.new_string('')
	mut var_link_end := rt.new_string('')
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.get_property(var_post_mutated, 'ID')])) && !(this.is_trash) {
	var_link_start = rt.call_function('sprintf', [rt.new_string('<a href="%s">'), rt.call_function('get_edit_post_link', [rt.get_property(var_post_mutated, 'ID')])])
	var_link_end = rt.new_string('</a>')
	}
	mut var_class := rt.new_string((if rt.is_true(var_thumb) { ' class="has-media-icon"' } else { '' }).str())
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_class)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_link_start)
	if rt.is_true(var_thumb) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('sanitize_html_class', [rt.new_string((var_mime).str() + '-icon')]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_thumb)
		// unsupported statement: Stmt_InlineHTML
	}
	print((var_title).str() + (var_link_end).str())
	rt.call_function('_media_states', [var_post_mutated.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('File name:')])
	// unsupported statement: Stmt_InlineHTML
	mut var_file := rt.call_function('get_attached_file', [rt.get_property(var_post_mutated, 'ID')])
	rt.echo_val(rt.call_function('esc_html', [rt.call_function('wp_basename', [var_file.clone()])]))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Media_List_Table) column_author(var_post rt.PhpVal) {
	mut var_post_mutated := var_post
	mut var_author := rt.call_function('get_the_author', []rt.PhpVal{})
	if !(!rt.is_true(var_author)) {
		rt.call_function('printf', [rt.new_string('<a href="%s">%s</a>'), rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'author', val: rt.call_function('get_the_author_meta', [rt.new_string('ID')]) }]), rt.new_string('upload.php')])]), rt.call_function('esc_html', [var_author.clone()])])
	} else {
		print('<span aria-hidden="true">&#8212;</span><span class="screen-reader-text">' + (rt.call_function('__', [rt.new_string('(no author)')])).str() + '</span>')
	}
}

fn (mut this Class_WP_Media_List_Table) column_desc(var_post rt.PhpVal) {
	mut var_post_mutated := var_post
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('6.2.0')])
	rt.echo_val(if rt.is_true(rt.call_function('has_excerpt', []rt.PhpVal{})) { rt.get_property(var_post_mutated, 'post_excerpt') } else { rt.new_string('') })
}

fn (mut this Class_WP_Media_List_Table) column_date(var_post rt.PhpVal) {
	mut var_post_mutated := var_post
	if rt.is_true(rt.identical(rt.new_string('0000-00-00 00:00:00'), rt.get_property(var_post_mutated, 'post_date'))) {
	mut var_h_time := rt.call_function('__', [rt.new_string('Unpublished')])
	} else {
		mut var_time := rt.call_function('get_post_timestamp', [var_post_mutated.clone()])
		mut var_time_diff := rt.sub(rt.call_function('time', []rt.PhpVal{}), var_time)
		if rt.is_true(var_time) && rt.is_true(rt.greater(var_time_diff, rt.new_int(0))) && rt.is_true(rt.less(var_time_diff, rt.get_constant('DAY_IN_SECONDS'))) {
		var_h_time = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s ago')]), rt.call_function('human_time_diff', [var_time.clone()])])
		} else {
		var_h_time = rt.call_function('get_the_time', [rt.call_function('__', [rt.new_string('Y/m/d')]), var_post_mutated.clone()])
		}
	}
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('media_date_column_time'), var_h_time.clone(), var_post_mutated.clone(), rt.new_string('date')]))
}

fn (mut this Class_WP_Media_List_Table) column_parent(var_post rt.PhpVal) {
	mut var_post_mutated := var_post
	mut var_user_can_edit := rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.get_property(var_post_mutated, 'ID')])
	if rt.is_true(rt.greater(rt.get_property(var_post_mutated, 'post_parent'), rt.new_int(0))) {
	mut var_parent := rt.call_function('get_post', [rt.get_property(var_post_mutated, 'post_parent')])
	} else {
	var_parent = rt.new_bool(false)
	}
	if rt.is_true(var_parent) {
		mut var_title := rt.call_function('_draft_or_post_title', [rt.get_property(var_post_mutated, 'post_parent')])
		mut var_parent_type := rt.call_function('get_post_type_object', [rt.get_property(var_parent, 'post_type')])
		if rt.is_true(var_parent_type) && rt.is_true(rt.get_property(var_parent_type, 'show_ui')) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.get_property(var_post_mutated, 'post_parent')])) {
			rt.call_function('printf', [rt.new_string('<strong><a href="%s">%s</a></strong>'), rt.call_function('get_edit_post_link', [rt.get_property(var_post_mutated, 'post_parent')]), var_title.clone()])
		} else if rt.is_true(var_parent_type) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('read_post'), rt.get_property(var_post_mutated, 'post_parent')])) {
			rt.call_function('printf', [rt.new_string('<strong>%s</strong>'), var_title.clone()])
		} else {
			rt.call_function('_e', [rt.new_string('(Private post)')])
		}
		if rt.is_true(var_user_can_edit) {
			mut var_detach_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'parent_post_id', val: rt.get_property(var_post_mutated, 'post_parent') }, rt.ArrayItem{ key: 'media[]', val: rt.get_property(var_post_mutated, 'ID') }, rt.ArrayItem{ key: '_wpnonce', val: rt.call_function('wp_create_nonce', [rt.new_string('bulk-' + (rt.get_property(rt.new_object('WP_Media_List_Table', ['WP_List_Table'], &this), '_args').array_get(rt.new_string('plural'))).str())]) }]), rt.new_string('upload.php')])
			rt.call_function('printf', [rt.new_string('<br /><a href="%s" class="hide-if-no-js detach-from-parent" aria-label="%s">%s</a>'), var_detach_url.clone(), rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Detach from &#8220;%s&#8221;')]), var_title.clone()])]), rt.call_function('__', [rt.new_string('Detach')])])
		}
	} else {
		rt.call_function('_e', [rt.new_string('(Unattached)')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_user_can_edit) {
			var_title = rt.call_function('_draft_or_post_title', [rt.get_property(var_post_mutated, 'post_parent')])
			rt.call_function('printf', [rt.new_string('<br /><a href="#the-list" onclick="findPosts.open( \'media[]\', \'%s\' ); return false;" class="hide-if-no-js aria-button-if-js" aria-label="%s">%s</a>'), rt.get_property(var_post_mutated, 'ID'), rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Attach &#8220;%s&#8221; to existing content')]), var_title.clone()])]), rt.call_function('__', [rt.new_string('Attach')])])
		}
	}
}

fn (mut this Class_WP_Media_List_Table) column_comments(var_post rt.PhpVal) {
	mut var_post_mutated := var_post
	print('<div class="post-com-count-wrapper">')
	if this.comment_pending_count.array_isset(rt.get_property(var_post_mutated, 'ID')) {
	mut var_pending_comments := this.comment_pending_count.array_get(rt.get_property(var_post_mutated, 'ID'))
	} else {
	var_pending_comments = rt.call_function('get_pending_comments_num', [rt.get_property(var_post_mutated, 'ID')])
	}
	this.comments_bubble(rt.get_property(var_post_mutated, 'ID'), var_pending_comments.clone())
	print('</div>')
}

fn (mut this Class_WP_Media_List_Table) column_default(var_item rt.PhpVal, var_column_name rt.PhpVal) {
	mut var_post := var_item
	if rt.is_true(rt.identical(rt.new_string('categories'), var_column_name)) {
	mut var_taxonomy := rt.new_string('category')
	} else if rt.is_true(rt.identical(rt.new_string('tags'), var_column_name)) {
	var_taxonomy = rt.new_string('post_tag')
	} else if rt.is_true(rt.call_function('str_starts_with', [var_column_name.clone(), rt.new_string('taxonomy-')])) {
	var_taxonomy = rt.call_function('substr', [var_column_name.clone(), rt.new_int(9)])
	} else {
	var_taxonomy = rt.new_bool(false)
	}
	if rt.is_true(var_taxonomy) {
		mut var_terms := rt.call_function('get_the_terms', [rt.get_property(var_post, 'ID'), var_taxonomy.clone()])
		if rt.is_true(rt.new_bool(var_terms.clone().is_array())) {
			mut var_output := rt.new_array()
			mut iter_6 := var_terms.iterator()
			for {
				item_6 := iter_6.next() or { break }
				mut var_t := item_6.val
				mut var_posts_in_term_qv := rt.new_array()
				var_posts_in_term_qv['taxonomy'] = var_taxonomy.clone()
				var_posts_in_term_qv['term'] = rt.get_property(var_t, 'slug')
				var_output << rt.call_function('sprintf', [rt.new_string('<a href="%s">%s</a>'), rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.create_array_from_native_map(var_posts_in_term_qv), rt.new_string('upload.php')])]), rt.call_function('esc_html', [rt.call_function('sanitize_term_field', [rt.new_string('name'), rt.get_property(var_t, 'name'), rt.get_property(var_t, 'term_id'), var_taxonomy.clone(), rt.new_string('display')])])])
			}
			rt.echo_val(rt.call_function('implode', [rt.call_function('wp_get_list_item_separator', []rt.PhpVal{}), rt.create_array_from_list(var_output)]))
		} else {
			print('<span aria-hidden="true">&#8212;</span><span class="screen-reader-text">' + (rt.get_property(rt.get_property(rt.call_function('get_taxonomy', [var_taxonomy.clone()]), 'labels'), 'no_terms')).str() + '</span>')
		}
		return
	}
	rt.call_function('do_action', [rt.new_string('manage_media_custom_column'), var_column_name.clone(), rt.get_property(var_post, 'ID')])
}

fn (mut this Class_WP_Media_List_Table) display_rows() {
	mut var_post := rt.new_null()
	mut var_wp_query := rt.new_null()
	mut var_post_ids := rt.call_function('wp_list_pluck', [rt.get_property(var_wp_query, 'posts'), rt.new_string('ID')])
	rt.call_function('reset', [rt.get_property(var_wp_query, 'posts')])
	this.comment_pending_count = rt.call_function('get_pending_comments_num', [var_post_ids.clone()])
	rt.call_function('add_filter', [rt.new_string('the_title'), rt.new_string('esc_html')])
	for rt.is_true(rt.call_function('have_posts', []rt.PhpVal{})) {
		rt.call_function('the_post', []rt.PhpVal{})
		if (this.is_trash && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_post, 'post_status')))))) || (!(this.is_trash) && rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_post, 'post_status')))) {
			continue
		}
		mut var_post_owner := rt.new_string((if rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.new_int((rt.get_property(var_post, 'post_author')).to_i64()))) { 'self' } else { 'other' }).str())
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(var_post, 'ID'))
		// unsupported statement: Stmt_InlineHTML
		print(' author-' + (var_post_owner).str() + ' status-' + (rt.get_property(var_post, 'post_status')).str().trim_space())
		// unsupported statement: Stmt_InlineHTML
		this.single_row_columns(var_post.clone())
		// unsupported statement: Stmt_InlineHTML
	}
}

fn (mut this Class_WP_Media_List_Table) get_default_primary_column_name() string {
	return 'title'
}

fn (mut this Class_WP_Media_List_Table) _get_row_actions(var_post rt.PhpVal, var_att_title rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	mut var_att_title_mutated := var_att_title
	mut var_actions := rt.new_array()
	if !(this.is_trash) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.get_property(var_post_mutated, 'ID')])) {
		var_actions.array_set('edit', rt.call_function('sprintf', [rt.new_string('<a href="%s" aria-label="%s">%s</a>'), rt.call_function('esc_url', [rt.call_function('get_edit_post_link', [rt.get_property(var_post_mutated, 'ID')])]), rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Edit &#8220;%s&#8221;')]), var_att_title_mutated.clone()])]), rt.call_function('__', [rt.new_string('Edit')])]))
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_post'), rt.get_property(var_post_mutated, 'ID')])) {
		if this.is_trash {
			var_actions.array_set('untrash', rt.call_function('sprintf', [rt.new_string('<a href="%s" class="submitdelete aria-button-if-js" aria-label="%s">%s</a>'), rt.call_function('esc_url', [rt.call_function('wp_nonce_url', [rt.concat(rt.new_string('post.php?action=untrash&amp;post='), rt.get_property(var_post_mutated, 'ID')), rt.new_string('untrash-post_' + (rt.get_property(var_post_mutated, 'ID')).str())])]), rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Restore &#8220;%s&#8221; from the Trash')]), var_att_title_mutated.clone()])]), rt.call_function('__', [rt.new_string('Restore')])]))
		} else if rt.is_true(rt.get_constant('EMPTY_TRASH_DAYS')) && rt.is_true(rt.get_constant('MEDIA_TRASH')) {
			var_actions.array_set('trash', rt.call_function('sprintf', [rt.new_string('<a href="%s" class="submitdelete aria-button-if-js" aria-label="%s">%s</a>'), rt.call_function('esc_url', [rt.call_function('wp_nonce_url', [rt.concat(rt.new_string('post.php?action=trash&amp;post='), rt.get_property(var_post_mutated, 'ID')), rt.new_string('trash-post_' + (rt.get_property(var_post_mutated, 'ID')).str())])]), rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Move &#8220;%s&#8221; to the Trash')]), var_att_title_mutated.clone()])]), rt.call_function('_x', [rt.new_string('Trash'), rt.new_string('verb')])]))
		}
		if this.is_trash || rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('EMPTY_TRASH_DAYS'))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('MEDIA_TRASH'))))) {
			mut var_show_confirmation := rt.new_string((if !(this.is_trash) && rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('MEDIA_TRASH'))))) { ' onclick=\'return showNotice.warn();\'' } else { '' }).str())
			var_actions.array_set('delete', rt.call_function('sprintf', [rt.new_string('<a href="%s" class="submitdelete aria-button-if-js"%s aria-label="%s">%s</a>'), rt.call_function('esc_url', [rt.call_function('wp_nonce_url', [rt.concat(rt.new_string('post.php?action=delete&amp;post='), rt.get_property(var_post_mutated, 'ID')), rt.new_string('delete-post_' + (rt.get_property(var_post_mutated, 'ID')).str())])]), var_show_confirmation.clone(), rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Delete &#8220;%s&#8221; permanently')]), var_att_title_mutated.clone()])]), rt.call_function('__', [rt.new_string('Delete Permanently')])]))
		}
	}
	mut var_attachment_url := rt.call_function('wp_get_attachment_url', [rt.get_property(var_post_mutated, 'ID')])
	if !(this.is_trash) {
		mut var_permalink := rt.call_function('get_permalink', [rt.get_property(var_post_mutated, 'ID')])
		if rt.is_true(var_permalink) {
			var_actions.array_set('view', rt.call_function('sprintf', [rt.new_string('<a href="%s" aria-label="%s" rel="bookmark">%s</a>'), rt.call_function('esc_url', [var_permalink.clone()]), rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('View &#8220;%s&#8221;')]), var_att_title_mutated.clone()])]), rt.call_function('__', [rt.new_string('View')])]))
		}
		if rt.is_true(var_attachment_url) {
			var_actions.array_set('copy', rt.call_function('sprintf', [rt.new_string('<span class="copy-to-clipboard-container"><button type="button" class="button-link copy-attachment-url media-library" data-clipboard-text="%s" aria-label="%s">%s</button><span class="success hidden" aria-hidden="true">%s</span></span>'), rt.call_function('esc_url', [var_attachment_url.clone()]), rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Copy &#8220;%s&#8221; URL to clipboard')]), var_att_title_mutated.clone()])]), rt.call_function('__', [rt.new_string('Copy URL')]), rt.call_function('__', [rt.new_string('Copied!')])]))
		}
	}
	if rt.is_true(var_attachment_url) {
		var_actions.array_set('download', rt.call_function('sprintf', [rt.new_string('<a href="%s" aria-label="%s" download>%s</a>'), rt.call_function('esc_url', [var_attachment_url.clone()]), rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Download &#8220;%s&#8221;')]), var_att_title_mutated.clone()])]), rt.call_function('__', [rt.new_string('Download file')])]))
	}
	if this.detached && rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.get_property(var_post_mutated, 'ID')])) {
		var_actions.array_set('attach', rt.call_function('sprintf', [rt.new_string('<a href="#the-list" onclick="findPosts.open( \'media[]\', \'%s\' ); return false;" class="hide-if-no-js aria-button-if-js" aria-label="%s">%s</a>'), rt.get_property(var_post_mutated, 'ID'), rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Attach &#8220;%s&#8221; to existing content')]), var_att_title_mutated.clone()])]), rt.call_function('__', [rt.new_string('Attach')])]))
	}
	return rt.call_function('apply_filters', [rt.new_string('media_row_actions'), var_actions.clone(), var_post_mutated.clone(), rt.new_bool(this.detached)])
}

fn (mut this Class_WP_Media_List_Table) handle_row_actions(var_item rt.PhpVal, var_column_name rt.PhpVal, var_primary rt.PhpVal) string {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_primary, var_column_name)))) {
		return ''
	}
	mut var_post := var_item
	mut var_att_title := rt.call_function('_draft_or_post_title', []rt.PhpVal{})
	mut var_actions := this._get_row_actions(var_post.clone(), var_att_title.clone())
	return (this.row_actions(var_actions.clone())).str()
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

fn create_wp_list_table(_args ...rt.PhpVal) &Class_WP_List_Table {
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



fn main() {
	defer {
		rt.shutdown()
	}

}
