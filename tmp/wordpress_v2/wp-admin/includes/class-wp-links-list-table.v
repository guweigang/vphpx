import rt

struct Class_WP_Links_List_Table {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Links_List_Table) construct(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	this.Class_WP_List_Table.construct(rt.create_array([
		rt.ArrayItem{ key: 'plural', val: 'bookmarks' },
		rt.ArrayItem{
			key: 'screen'
			val: if !(var_args_mutated.array_get(rt.new_string('screen'))).is_null() {
				var_args_mutated.array_get(rt.new_string('screen'))
			} else {
				rt.new_null()
			}
		},
	]))
}

fn (mut this Class_WP_Links_List_Table) ajax_user_can() rt.PhpVal {
	return rt.call_function('current_user_can', [rt.new_string('manage_links')])
}

fn (mut this Class_WP_Links_List_Table) prepare_items() {
	mut var_cat_id := rt.get_superglobal('cat_id')
	mut var_s := rt.get_superglobal('s')
	mut var_orderby := rt.get_superglobal('orderby')
	mut var_order := rt.get_superglobal('order')
	var_cat_id = if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('cat_id')))) { rt.call_function('absint', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('cat_id')),
		]) } else { rt.new_int(0) }
	var_orderby = if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('orderby')))) { rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('orderby')),
		]) } else { rt.new_string('') }
	var_order = if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('order')))) { rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('order')),
		]) } else { rt.new_string('') }
	var_s = if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('s')))) { rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('s')),
		]) } else { rt.new_string('') }
	mut var_args := {
		'hide_invisible': rt.new_int(0)
		'hide_empty':     rt.new_int(0)
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('all'), var_cat_id)))) {
		var_args['category'] = var_cat_id.clone()
	}
	if !(!rt.is_true(var_s)) {
		var_args['search'] = var_s.clone()
	}
	if !(!rt.is_true(var_orderby)) {
		var_args['orderby'] = var_orderby.clone()
	}
	if !(!rt.is_true(var_order)) {
		var_args['order'] = var_order.clone()
	}
	this.dispatch_set_prop('items', rt.call_function('get_bookmarks', [
		rt.create_array_from_native_map(var_args),
	]))
}

fn (mut this Class_WP_Links_List_Table) no_items() {
	rt.call_function('_e', [rt.new_string('No links found.')])
}

fn (mut this Class_WP_Links_List_Table) get_bulk_actions() rt.PhpVal {
	mut var_actions := map[string]rt.PhpVal{}
	var_actions['delete'] = rt.call_function('__', [rt.new_string('Delete')])
	return var_actions.clone()
}

fn (mut this Class_WP_Links_List_Table) extra_tablenav(var_which rt.PhpVal) {
	mut var_cat_id := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('top'), var_which)))) {
		return
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_dropdown_options := {
		'selected':        var_cat_id
		'name':            rt.new_string('cat_id')
		'taxonomy':        rt.new_string('link_category')
		'show_option_all': rt.get_property(rt.get_property(rt.call_function('get_taxonomy', [
			rt.new_string('link_category'),
		]), 'labels'), 'all_items')
		'hide_empty':      rt.new_bool(true)
		'hierarchical':    rt.new_int(1)
		'show_count':      rt.new_int(0)
		'orderby':         rt.new_string('name')
	}
	print('<label class="screen-reader-text" for="cat_id">' +
		(rt.get_property(rt.get_property(rt.call_function('get_taxonomy', [rt.new_string('link_category')]), 'labels'), 'filter_by_item')).str() +
		'</label>')
	rt.call_function('wp_dropdown_categories', [
		rt.create_array_from_native_map(var_dropdown_options),
	])
	rt.call_function('submit_button', [rt.call_function('__', [
		rt.new_string('Filter')]),
		rt.new_string(''), rt.new_string('filter_action'), rt.new_bool(false),
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'post-query-submit' }])])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Links_List_Table) get_columns() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'cb', val: '<input type="checkbox" />' },
		rt.ArrayItem{ key: 'name', val: rt.call_function('_x', [
			rt.new_string('Name'), rt.new_string('link name')]) },
		rt.ArrayItem{ key: 'url', val: rt.call_function('__', [
			rt.new_string('URL')]) }, rt.ArrayItem{ key: 'categories', val: rt.call_function('__', [
			rt.new_string('Categories')]) }, rt.ArrayItem{ key: 'rel', val: rt.call_function('__', [
			rt.new_string('Relationship')]) }, rt.ArrayItem{ key: 'visible', val: rt.call_function('__', [
			rt.new_string('Visible')]) }, rt.ArrayItem{ key: 'rating', val: rt.call_function('__', [
			rt.new_string('Rating')]) }])
}

fn (mut this Class_WP_Links_List_Table) get_sortable_columns() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'name', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'name' },
			rt.ArrayItem{ key: none, val: false },
			rt.ArrayItem{ key: none, val: rt.call_function('_x', [
				rt.new_string('Name'), rt.new_string('link name')]) },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Table ordered by Name.')]) },
			rt.ArrayItem{ key: none, val: 'asc' },
		]) },
		rt.ArrayItem{ key: 'url', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'url' },
			rt.ArrayItem{ key: none, val: false },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('URL')]) },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Table ordered by URL.')]) },
		]) },
		rt.ArrayItem{ key: 'visible', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'visible' },
			rt.ArrayItem{ key: none, val: false },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Visible')]) },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Table ordered by Visibility.')]) },
		]) },
		rt.ArrayItem{ key: 'rating', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'rating' },
			rt.ArrayItem{ key: none, val: false },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Rating')]) },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Table ordered by Rating.')]) },
		]) },
	])
}

fn (mut this Class_WP_Links_List_Table) get_default_primary_column_name() string {
	return 'name'
}

fn (mut this Class_WP_Links_List_Table) column_cb(var_item rt.PhpVal) {
	mut var_link := var_item
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.get_property(var_link, 'link_id'))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_link, 'link_id')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.get_property(var_link, 'link_id'))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('__', [rt.new_string('Select %s')]),
		rt.get_property(var_link, 'link_name')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Links_List_Table) column_name(var_link rt.PhpVal) {
	mut var_link_mutated := var_link
	mut var_edit_link := rt.call_function('get_edit_bookmark_link', [
		var_link_mutated.clone()])
	rt.call_function('printf', [
		rt.new_string('<strong><a class="row-title" href="%s" aria-label="%s">%s</a></strong>'),
		var_edit_link.clone(),
		rt.call_function('esc_attr', [
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Edit &#8220;%s&#8221;')]),
				rt.get_property(var_link_mutated, 'link_name'),
			]),
		]),
		rt.get_property(var_link_mutated, 'link_name'),
	])
}

fn (mut this Class_WP_Links_List_Table) column_url(var_link rt.PhpVal) {
	mut var_link_mutated := var_link
	mut var_short_url := rt.call_function('url_shorten', [
		rt.get_property(var_link_mutated, 'link_url'),
	])
	print(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string("<a href='"), rt.get_property(var_link_mutated,
		'link_url')), rt.new_string("'>")), var_short_url), rt.new_string('</a>')))
}

fn (mut this Class_WP_Links_List_Table) column_categories(var_link rt.PhpVal) {
	mut var_cat_id := rt.new_null()
	mut var_link_mutated := var_link
	mut var_cat_names := map[string]rt.PhpVal{}
	mut iter_1 := rt.get_property(var_link_mutated, 'link_category').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_category := item_1.val
		mut var_cat := rt.call_function('get_term', [var_category.clone(),
			rt.new_string('link_category'), rt.get_constant('OBJECT'),
			rt.new_string('display')])
		if rt.is_true(rt.call_function('is_wp_error', [var_cat.clone()])) {
			rt.echo_val(rt.call_method(var_cat, 'get_error_message', []rt.PhpVal{}))
		}
		mut var_cat_name := rt.get_property(var_cat, 'name')
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(var_cat_id.to_i64()),
			var_category))))
		{
			var_cat_name =
				rt.new_string("<a href='link-manager.php?cat_id=${var_category.to_string()}'>${var_cat_name.to_string()}</a>")
		}
		var_cat_names << var_cat_name.clone()
	}
	rt.echo_val(rt.call_function('implode', [rt.new_string(', '),
		rt.create_array_from_list(var_cat_names)]))
}

fn (mut this Class_WP_Links_List_Table) column_rel(var_link rt.PhpVal) {
	mut var_link_mutated := var_link
	rt.echo_val(if !rt.is_true(rt.get_property(var_link_mutated, 'link_rel')) {
		rt.new_string('<br />')
	} else {
		rt.get_property(var_link_mutated, 'link_rel')
	})
}

fn (mut this Class_WP_Links_List_Table) column_visible(var_link rt.PhpVal) {
	mut var_link_mutated := var_link
	if rt.is_true(rt.identical(rt.new_string('Y'),
		rt.get_property(var_link_mutated, 'link_visible')))
	{
		rt.call_function('_e', [rt.new_string('Yes')])
	} else {
		rt.call_function('_e', [rt.new_string('No')])
	}
}

fn (mut this Class_WP_Links_List_Table) column_rating(var_link rt.PhpVal) {
	mut var_link_mutated := var_link
	rt.echo_val(rt.get_property(var_link_mutated, 'link_rating'))
}

fn (mut this Class_WP_Links_List_Table) column_default(var_item rt.PhpVal, var_column_name rt.PhpVal) {
	mut var_link := var_item
	rt.call_function('do_action', [rt.new_string('manage_link_custom_column'),
		var_column_name.clone(), rt.get_property(var_link, 'link_id')])
}

fn (mut this Class_WP_Links_List_Table) display_rows() {
	mut iter_2 := rt.get_property(rt.new_object('WP_Links_List_Table', [
		'WP_List_Table',
	], &this), 'items').iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_link := item_2.val
		var_link = rt.call_function('sanitize_bookmark', [var_link.clone()])
		rt.set_property(var_link, 'link_name', rt.call_function('esc_attr', [
			rt.get_property(var_link, 'link_name'),
		]))
		rt.set_property(var_link, 'link_category', rt.call_function('wp_get_link_cats', [
			rt.get_property(var_link, 'link_id'),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(var_link, 'link_id'))
		// unsupported statement: Stmt_InlineHTML
		this.single_row_columns(var_link.clone())
		// unsupported statement: Stmt_InlineHTML
	}
}

fn (mut this Class_WP_Links_List_Table) handle_row_actions(var_item rt.PhpVal, var_column_name rt.PhpVal, var_primary rt.PhpVal) string {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_primary, var_column_name)))) {
		return ''
	}
	mut var_link := var_item
	mut var_edit_link := rt.call_function('get_edit_bookmark_link', [
		var_link.clone()])
	mut var_actions := map[string]rt.PhpVal{}
	var_actions['edit'] = '<a href="' + var_edit_link.str() + '">' +
		(rt.call_function('__', [rt.new_string('Edit')])).str() + '</a>'
	var_actions['delete'] = rt.call_function('sprintf', [
		rt.new_string('<a class="submitdelete" href="%s" onclick="return confirm( \'%s\' );">%s</a>'),
		rt.call_function('wp_nonce_url', [
			rt.concat(rt.new_string('link.php?action=delete&amp;link_id='), rt.get_property(var_link,
				'link_id')),
			rt.new_string('delete-bookmark_' + (rt.get_property(var_link, 'link_id')).str()),
		]),
		rt.call_function('esc_js', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string("You are about to delete this link '%s'\n  'Cancel' to stop, 'OK' to delete."),
				]),
				rt.get_property(var_link, 'link_name'),
			]),
		]),
		rt.call_function('__', [
			rt.new_string('Delete'),
		]),
	])
	return (this.row_actions(var_actions.clone())).str()
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

fn create_wp_links_list_table(arg_0 rt.PhpVal) &Class_WP_Links_List_Table {
	mut obj := &Class_WP_Links_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
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

fn (mut this Class_WP_Links_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'get_bulk_actions' {
			return this.get_bulk_actions()
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
		'get_default_primary_column_name' {
			return rt.new_string(this.get_default_primary_column_name())
		}
		'column_cb' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_cb(dispatch_arg_0)
			return rt.new_null()
		}
		'column_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_name(dispatch_arg_0)
			return rt.new_null()
		}
		'column_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_url(dispatch_arg_0)
			return rt.new_null()
		}
		'column_categories' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_categories(dispatch_arg_0)
			return rt.new_null()
		}
		'column_rel' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_rel(dispatch_arg_0)
			return rt.new_null()
		}
		'column_visible' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_visible(dispatch_arg_0)
			return rt.new_null()
		}
		'column_rating' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_rating(dispatch_arg_0)
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
		'handle_row_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.handle_row_actions(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Links_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Links_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
