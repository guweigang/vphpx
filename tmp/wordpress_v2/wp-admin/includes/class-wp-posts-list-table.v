import rt

struct Class_WP_Posts_List_Table {
	rt.PhpObjectBase
pub mut:
	hierarchical_display  rt.PhpVal = rt.new_null()
	comment_pending_count rt.PhpVal = rt.new_null()
	user_posts_count      rt.PhpVal = rt.new_null()
	sticky_posts_count    rt.PhpVal = rt.new_int(0)
	is_trash              bool
	current_level         rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_WP_Posts_List_Table) construct(var_args rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	mut var_post_type_object := rt.get_superglobal('post_type_object')
	this.Class_WP_List_Table.construct(rt.create_array([
		rt.ArrayItem{ key: 'plural', val: 'posts' },
		rt.ArrayItem{
			key: 'screen'
			val: if !(var_args_mutated.array_get(rt.new_string('screen'))).is_null() {
				var_args_mutated.array_get(rt.new_string('screen'))
			} else {
				rt.new_null()
			}
		},
	]))
	mut var_post_type := rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', [
		'WP_List_Table',
	], &this), 'screen'), 'post_type')
	var_post_type_object = rt.call_function('get_post_type_object', [
		var_post_type.clone()])
	mut var_exclude_states := rt.call_function('get_post_stati', [
		rt.create_array([rt.ArrayItem{ key: 'show_in_admin_all_list', val: false }]),
	])
	this.user_posts_count = rt.new_int((rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string((
				rt.concat(rt.concat(rt.new_string('SELECT COUNT( 1 )\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string("\n\t\t\t\tWHERE post_type = %s\n\t\t\t\tAND post_status NOT IN ( '")) +
				(rt.call_function('implode', [rt.new_string("','"), var_exclude_states.clone()])).str() +
				"' )\n\t\t\t\tAND post_author = %d").str()),
			var_post_type.clone(),
			rt.call_function('get_current_user_id', []rt.PhpVal{}),
		]),
	])).to_i64())
	if rt.is_true(this.user_posts_count)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_object, 'cap'), 'edit_others_posts')])))))
		&& !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_status')))
		&& !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('all_posts')))
		&& !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('author')))
		&& !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('show_sticky'))) {
		rt.get_superglobal('_GET').array_set('author', rt.call_function('get_current_user_id',
			[]rt.PhpVal{}))
	}
	mut var_sticky_posts := rt.call_function('get_option', [
		rt.new_string('sticky_posts'),
	])
	if rt.is_true(rt.identical(rt.new_string('post'), var_post_type))
		&& rt.is_true(var_sticky_posts) {
		var_sticky_posts = rt.call_function('implode', [rt.new_string(', '),
			rt.call_function('array_map', [rt.new_string('absint'),
				rt.cast_array(var_sticky_posts)])])
		this.sticky_posts_count = rt.new_int((rt.call_method(var_wpdb, 'get_var', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT COUNT( 1 )\n\t\t\t\t\tFROM '), rt.get_property(var_wpdb,
					'posts')),
					rt.new_string("\n\t\t\t\t\tWHERE post_type = %s\n\t\t\t\t\tAND post_status NOT IN ('trash', 'auto-draft')\n\t\t\t\t\tAND ID IN (")),
					var_sticky_posts), rt.new_string(')')),
				var_post_type.clone(),
			]),
		])).to_i64())
	}
}

fn (mut this Class_WP_Posts_List_Table) set_hierarchical_display(var_display rt.PhpVal) {
	this.hierarchical_display = var_display.clone()
}

fn (mut this Class_WP_Posts_List_Table) ajax_user_can() rt.PhpVal {
	return rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [
			rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', [
				'WP_List_Table',
			], &this), 'screen'), 'post_type'),
		]), 'cap'), 'edit_posts'),
	])
}

fn (mut this Class_WP_Posts_List_Table) prepare_items() {
	mut var_wp_query := rt.new_null()
	mut var_mode := rt.get_superglobal('mode')
	mut var_avail_post_stati := rt.get_superglobal('avail_post_stati')
	mut var_per_page := rt.get_superglobal('per_page')
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('mode')))) {
		var_mode = rt.new_string((if rt.is_true(rt.identical(rt.new_string('excerpt'),
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('mode'))))
		{
			'excerpt'
		} else {
			'list'
		}).str())
		rt.call_function('set_user_setting', [rt.new_string('posts_list_mode'),
			var_mode.clone()])
	} else {
		var_mode = rt.call_function('get_user_setting', [
			rt.new_string('posts_list_mode'),
			rt.new_string('list'),
		])
	}
	var_avail_post_stati = rt.call_function('wp_edit_posts_query', []rt.PhpVal{})
	this.set_hierarchical_display(rt.new_bool(
		rt.is_true(rt.call_function('is_post_type_hierarchical', [rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', ['WP_List_Table'], &this), 'screen'), 'post_type')]))
		&& rt.is_true(rt.identical(rt.new_string('menu_order title'), rt.get_property(var_wp_query, 'query').array_get(rt.new_string('orderby'))))))
	mut var_post_type := rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', [
		'WP_List_Table',
	], &this), 'screen'), 'post_type')
	var_per_page =
		this.get_items_per_page(rt.new_string('edit_' + var_post_type.str() + '_per_page'))
	var_per_page = rt.call_function('apply_filters', [
		rt.new_string('edit_posts_per_page'),
		var_per_page.clone(),
		var_post_type.clone(),
	])
	if rt.is_true(this.hierarchical_display) {
		mut var_total_items := rt.get_property(var_wp_query, 'post_count')
	} else if rt.is_true(rt.get_property(var_wp_query, 'found_posts'))
		|| rt.is_true(rt.identical(this.get_pagenum(), rt.new_int(1))) {
		var_total_items = rt.get_property(var_wp_query, 'found_posts')
	} else {
		mut var_post_counts := rt.cast_array(rt.call_function('wp_count_posts', [
			var_post_type.clone(),
			rt.new_string('readable'),
		]))
		if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('post_status'))
			&& rt.is_true(rt.call_function('in_array', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_status')), var_avail_post_stati.clone(), rt.new_bool(true)])) {
			var_total_items =
				var_post_counts.array_get(rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_status')))
		} else if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('show_sticky'))
			&& rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('show_sticky'))) {
			var_total_items = this.sticky_posts_count
		} else if rt.get_superglobal('_GET').array_isset(rt.new_string('author'))
			&& rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('author'))).to_i64()))) {
			var_total_items = this.user_posts_count
		} else {
			var_total_items = rt.call_function('array_sum', [
				var_post_counts.clone()])
			mut iter_1 := rt.call_function('get_post_stati', [
				rt.create_array([
					rt.ArrayItem{ key: 'show_in_admin_all_list', val: false },
				]),
			]).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_state := item_1.val
				var_total_items = rt.sub(var_total_items, var_post_counts.array_get(var_state))
			}
		}
	}
	this.is_trash = rt.get_superglobal('_REQUEST').array_isset(rt.new_string('post_status'))
		&& rt.is_true(rt.identical(rt.new_string('trash'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_status'))))
	this.set_pagination_args(rt.create_array([
		rt.ArrayItem{ key: 'total_items', val: var_total_items },
		rt.ArrayItem{ key: 'per_page', val: var_per_page },
	]))
}

fn (mut this Class_WP_Posts_List_Table) has_items() rt.PhpVal {
	return rt.call_function('have_posts', []rt.PhpVal{})
}

fn (mut this Class_WP_Posts_List_Table) no_items() {
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('post_status'))
		&& rt.is_true(rt.identical(rt.new_string('trash'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_status')))) {
		rt.echo_val(rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [
			rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', [
				'WP_List_Table',
			], &this), 'screen'), 'post_type'),
		]), 'labels'), 'not_found_in_trash'))
	} else {
		rt.echo_val(rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [
			rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', [
				'WP_List_Table',
			], &this), 'screen'), 'post_type'),
		]), 'labels'), 'not_found'))
	}
}

fn (mut this Class_WP_Posts_List_Table) is_base_request() bool {
	mut var_vars := rt.get_superglobal('_GET').clone()
	var_vars.array_unset(rt.new_string('paged'))
	if !rt.is_true(var_vars) {
		return true
	} else if 1 == var_vars.clone().array_count()
		&& !(!rt.is_true(var_vars.array_get(rt.new_string('post_type')))) {
		return (rt.identical(rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', [
			'WP_List_Table',
		], &this), 'screen'), 'post_type'), var_vars.array_get(rt.new_string('post_type')))).to_bool()
	}
	return 1 == var_vars.clone().array_count()
		&& !(!rt.is_true(var_vars.array_get(rt.new_string('mode'))))
}

fn (mut this Class_WP_Posts_List_Table) get_edit_link(var_args rt.PhpVal, var_link_text rt.PhpVal, css_class string) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_url := rt.call_function('add_query_arg', [var_args_mutated.clone(),
		rt.new_string('edit.php')])
	mut var_class_html := rt.new_string('')
	mut var_aria_current := rt.new_string('')
	if !(css_class == '') {
		var_class_html = rt.call_function('sprintf', [rt.new_string(' class="%s"'),
			rt.call_function('esc_attr', [rt.new_string(css_class)])])
		if rt.is_true(rt.identical(rt.new_string('current'), rt.new_string(css_class))) {
			var_aria_current = rt.new_string(' aria-current="page"')
		}
	}
	return rt.call_function('sprintf', [rt.new_string('<a href="%s"%s%s>%s</a>'),
		rt.call_function('esc_url', [var_url.clone()]), var_class_html.clone(),
		var_aria_current.clone(), var_link_text.clone()])
}

fn (mut this Class_WP_Posts_List_Table) get_views() rt.PhpVal {
	mut var_locked_post_status := rt.new_null()
	mut var_avail_post_stati := rt.new_null()
	mut var_post_type := rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', [
		'WP_List_Table',
	], &this), 'screen'), 'post_type')
	if !(!rt.is_true(var_locked_post_status)) {
		return rt.new_array()
	}
	mut var_status_links := rt.new_array()
	mut var_num_posts := rt.call_function('wp_count_posts', [
		var_post_type.clone(), rt.new_string('readable')])
	mut var_total_posts := rt.call_function('array_sum', [rt.cast_array(var_num_posts)])
	mut var_class := rt.new_string('')
	mut var_current_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	mut var_all_args := {
		'post_type': var_post_type
	}
	mut var_mine := rt.new_string('')
	mut iter_2 := rt.call_function('get_post_stati', [
		rt.create_array([rt.ArrayItem{ key: 'show_in_admin_all_list', val: false }]),
	]).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_state := item_2.val
		var_total_posts = rt.sub(var_total_posts, rt.get_property(var_num_posts,
			'{"nodeType":"Expr_Variable","line":309,"name":"state"}'))
	}
	if rt.is_true(this.user_posts_count)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.user_posts_count, var_total_posts)))) {
		if rt.get_superglobal('_GET').array_isset(rt.new_string('author'))
			&& rt.is_true(rt.identical(var_current_user_id, rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('author'))).to_i64()))) {
			var_class = rt.new_string('current')
		}
		mut var_mine_args := {
			'post_type': var_post_type
			'author':    var_current_user_id
		}
		mut var_mine_inner_html := rt.call_function('sprintf', [
			rt.call_function('_nx', [
				rt.new_string('Mine <span class="count">(%s)</span>'),
				rt.new_string('Mine <span class="count">(%s)</span>'),
				this.user_posts_count,
				rt.new_string('posts'),
			]),
			rt.call_function('number_format_i18n', [
				this.user_posts_count,
			]),
		])
		var_mine = rt.create_array([
			rt.ArrayItem{ key: 'url', val: rt.call_function('esc_url', [
				rt.call_function('add_query_arg', [
					rt.create_array_from_native_map(var_mine_args),
					rt.new_string('edit.php'),
				]),
			]) },
			rt.ArrayItem{ key: 'label', val: var_mine_inner_html },
			rt.ArrayItem{
				key: 'current'
				val: rt.get_superglobal('_GET').array_isset(rt.new_string('author'))
					&& rt.is_true(rt.identical(var_current_user_id, rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('author'))).to_i64())))
			},
		])
		var_all_args['all_posts'] = rt.new_int(1)
		var_class = rt.new_string('')
	}
	mut var_all_inner_html := rt.call_function('sprintf', [
		rt.call_function('_nx', [rt.new_string('All <span class="count">(%s)</span>'),
			rt.new_string('All <span class="count">(%s)</span>'),
			var_total_posts.clone(), rt.new_string('posts')]),
		rt.call_function('number_format_i18n', [var_total_posts.clone()]),
	])
	var_status_links.array_set('all', rt.create_array([
		rt.ArrayItem{ key: 'url', val: rt.call_function('esc_url', [
			rt.call_function('add_query_arg', [
				rt.create_array_from_native_map(var_all_args),
				rt.new_string('edit.php'),
			]),
		]) },
		rt.ArrayItem{ key: 'label', val: var_all_inner_html },
		rt.ArrayItem{ key: 'current', val: !rt.is_true(var_class) && this.is_base_request()
			|| rt.get_superglobal('_REQUEST').array_isset(rt.new_string('all_posts')) },
	]))
	if rt.is_true(var_mine) {
		var_status_links.array_set('mine', var_mine.clone())
	}
	mut iter_3 := rt.call_function('get_post_stati', [
		rt.create_array([rt.ArrayItem{ key: 'show_in_admin_status_list', val: true }]),
		rt.new_string('objects'),
	]).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_status := item_3.val
		var_class = rt.new_string('')
		mut var_status_name := rt.get_property(var_status, 'name')
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_status_name.clone(), var_avail_post_stati.clone(), rt.new_bool(true)])))))
			|| !rt.is_true(rt.get_property(var_num_posts, '{"nodeType":"Expr_Variable","line":369,"name":"status_name"}')) {
			continue
		}
		if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('post_status'))
			&& rt.is_true(rt.identical(var_status_name, rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_status')))) {
			var_class = rt.new_string('current')
		}
		mut var_status_args := {
			'post_status': var_status_name
			'post_type':   var_post_type
		}
		mut var_status_label := rt.call_function('sprintf', [
			rt.call_function('translate_nooped_plural', [
				rt.get_property(var_status, 'label_count'),
				rt.get_property(var_num_posts,
					'{"nodeType":"Expr_Variable","line":383,"name":"status_name"}'),
			]),
			rt.call_function('number_format_i18n', [
				rt.get_property(var_num_posts,
					'{"nodeType":"Expr_Variable","line":384,"name":"status_name"}'),
			]),
		])
		var_status_links.array_set(var_status_name, rt.create_array([
			rt.ArrayItem{ key: 'url', val: rt.call_function('esc_url', [
				rt.call_function('add_query_arg', [
					rt.create_array_from_native_map(var_status_args),
					rt.new_string('edit.php'),
				]),
			]) },
			rt.ArrayItem{ key: 'label', val: var_status_label },
			rt.ArrayItem{
				key: 'current'
				val: rt.get_superglobal('_REQUEST').array_isset(rt.new_string('post_status'))
					&& rt.is_true(rt.identical(var_status_name, rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_status'))))
			},
		]))
	}
	if !(!rt.is_true(this.sticky_posts_count)) {
		var_class = rt.new_string((if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('show_sticky')))) {
			'current'
		} else {
			''
		}).str())
		mut var_sticky_args := {
			'post_type':   var_post_type
			'show_sticky': rt.new_int(1)
		}
		mut var_sticky_inner_html := rt.call_function('sprintf', [
			rt.call_function('_nx', [
				rt.new_string('Sticky <span class="count">(%s)</span>'),
				rt.new_string('Sticky <span class="count">(%s)</span>'),
				this.sticky_posts_count,
				rt.new_string('posts'),
			]),
			rt.call_function('number_format_i18n', [
				this.sticky_posts_count,
			]),
		])
		mut var_sticky_link := {
			'sticky': {
				'url':     rt.call_function('esc_url', [
					rt.call_function('add_query_arg', [
						rt.create_array_from_native_map(var_sticky_args),
						rt.new_string('edit.php'),
					]),
				])
				'label':   var_sticky_inner_html
				'current': rt.new_bool(!(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('show_sticky')))))
			}
		}
		mut var_split := rt.add(rt.new_int(1), rt.call_function('array_search', [
			rt.new_string((if var_status_links.array_isset(rt.new_string('publish')) {
				'publish'
			} else {
				'all'
			}).str()),
			rt.func_array_keys(var_status_links.clone()),
			rt.new_bool(true),
		]))
		var_status_links = rt.call_function('array_merge', [
			rt.call_function('array_slice', [var_status_links.clone(),
				rt.new_int(0), var_split.clone()]),
			rt.create_array_from_native_map(var_sticky_link),
			rt.call_function('array_slice', [var_status_links.clone(),
				var_split.clone()]),
		])
	}
	return this.get_views_links(var_status_links.clone())
}

fn (mut this Class_WP_Posts_List_Table) get_bulk_actions() rt.PhpVal {
	mut var_actions := rt.new_array()
	mut var_post_type_obj := rt.call_function('get_post_type_object', [
		rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', [
			'WP_List_Table',
		], &this), 'screen'), 'post_type'),
	])
	if rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_post_type_obj, 'cap'), 'edit_posts'),
	]))
	{
		if this.is_trash {
			var_actions.array_set('untrash', rt.call_function('__', [
				rt.new_string('Restore'),
			]))
		} else {
			var_actions.array_set('edit', rt.call_function('_x', [
				rt.new_string('Bulk edit'),
				rt.new_string('verb'),
			]))
		}
	}
	if rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_post_type_obj, 'cap'), 'delete_posts'),
	]))
	{
		if this.is_trash
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('EMPTY_TRASH_DAYS'))))) {
			var_actions.array_set('delete', rt.call_function('__', [
				rt.new_string('Delete permanently'),
			]))
		} else {
			var_actions.array_set('trash', rt.call_function('__', [
				rt.new_string('Move to Trash'),
			]))
		}
	}
	return var_actions.clone()
}

fn (mut this Class_WP_Posts_List_Table) categories_dropdown(var_post_type rt.PhpVal) {
	mut var_cat := rt.new_null()
	mut var_post_type_mutated := var_post_type
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('apply_filters', [
		rt.new_string('disable_categories_dropdown'),
		rt.new_bool(false),
		var_post_type_mutated.clone(),
	])))))
	{
		return
	}
	if rt.is_true(rt.call_function('is_object_in_taxonomy', [
		var_post_type_mutated.clone(), rt.new_string('category')]))
	{
		mut var_dropdown_options := {
			'show_option_all': rt.get_property(rt.get_property(rt.call_function('get_taxonomy', [
				rt.new_string('category'),
			]), 'labels'), 'all_items')
			'hide_empty':      rt.new_int(0)
			'hierarchical':    rt.new_int(1)
			'show_count':      rt.new_int(0)
			'orderby':         rt.new_string('name')
			'selected':        var_cat
		}
		print('<label class="screen-reader-text" for="cat">' +
			(rt.get_property(rt.get_property(rt.call_function('get_taxonomy', [rt.new_string('category')]), 'labels'), 'filter_by_item')).str() +
			'</label>')
		rt.call_function('wp_dropdown_categories', [
			rt.create_array_from_native_map(var_dropdown_options),
		])
	}
}

fn (mut this Class_WP_Posts_List_Table) formats_dropdown(var_post_type rt.PhpVal) {
	mut var_post_type_mutated := var_post_type
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('disable_formats_dropdown'),
		rt.new_bool(false),
		var_post_type_mutated.clone(),
	]))
	{
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_object_in_taxonomy', [var_post_type_mutated.clone(), rt.new_string('post_format')])))))
		|| this.is_trash {
		return
	}
	mut var_used_post_formats := rt.call_function('get_terms', [
		rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'post_format' },
			rt.ArrayItem{ key: 'hide_empty', val: true }]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_used_post_formats)))) {
		return
	}
	mut var_displayed_post_format := if !(rt.get_superglobal('_GET').array_get(rt.new_string('post_format'))).is_null() {
		rt.get_superglobal('_GET').array_get(rt.new_string('post_format'))
	} else {
		rt.new_string('')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Filter by post format')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_displayed_post_format.clone(),
		rt.new_string('')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('All formats')])
	// unsupported statement: Stmt_InlineHTML
	mut iter_4 := var_used_post_formats.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_used_post_format := item_4.val
		mut var_slug := rt.call_function('str_replace', [rt.new_string('post-format-'),
			rt.new_string(''), rt.get_property(var_used_post_format, 'slug')])
		mut var_pretty_name := rt.call_function('get_post_format_string', [
			var_slug.clone()])
		if rt.is_true(rt.identical(rt.new_string('standard'), var_slug)) {
			continue
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [var_displayed_post_format.clone(),
			var_slug.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_slug.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_pretty_name.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Posts_List_Table) extra_tablenav(var_which rt.PhpVal) {
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('top'), var_which)) {
		rt.call_function('ob_start', []rt.PhpVal{})
		this.months_dropdown(rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', [
			'WP_List_Table',
		], &this), 'screen'), 'post_type'))
		this.categories_dropdown(rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', [
			'WP_List_Table',
		], &this), 'screen'), 'post_type'))
		this.formats_dropdown(rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', [
			'WP_List_Table',
		], &this), 'screen'), 'post_type'))
		rt.call_function('do_action', [rt.new_string('restrict_manage_posts'),
			rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', [
				'WP_List_Table',
			], &this), 'screen'), 'post_type'),
			var_which.clone()])
		mut var_output := rt.call_function('ob_get_clean', []rt.PhpVal{})
		if !(!rt.is_true(var_output)) {
			rt.echo_val(var_output)
			rt.call_function('submit_button', [
				rt.call_function('__', [rt.new_string('Filter')]),
				rt.new_string(''),
				rt.new_string('filter_action'),
				rt.new_bool(false),
				rt.create_array([rt.ArrayItem{ key: 'id', val: 'post-query-submit' }]),
			])
		}
	}
	if this.is_trash && rt.is_true(this.has_items())
		&& rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', ['WP_List_Table'], &this), 'screen'), 'post_type')]), 'cap'), 'edit_others_posts')])) {
		rt.call_function('submit_button', [
			rt.call_function('__', [rt.new_string('Empty Trash')]),
			rt.new_string('apply'),
			rt.new_string('delete_all'),
			rt.new_bool(false),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('manage_posts_extra_tablenav'),
		var_which.clone()])
}

fn (mut this Class_WP_Posts_List_Table) current_action() string {
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('delete_all'))
		|| rt.get_superglobal('_REQUEST').array_isset(rt.new_string('delete_all2')) {
		return 'delete_all'
	}
	return (this.Class_WP_List_Table.current_action()).str()
}

fn (mut this Class_WP_Posts_List_Table) get_table_classes() rt.PhpVal {
	mut var_mode := rt.new_null()
	mut var_mode_class := rt.call_function('esc_attr', [
		rt.new_string('table-view-' + var_mode.str()),
	])
	return rt.create_array([rt.ArrayItem{ key: none, val: 'widefat' },
		rt.ArrayItem{ key: none, val: 'fixed' }, rt.ArrayItem{ key: none, val: 'striped' },
		rt.ArrayItem{ key: none, val: var_mode_class }, rt.ArrayItem{
			key: none
			val: if rt.is_true(rt.call_function('is_post_type_hierarchical', [
				rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', [
					'WP_List_Table',
				], &this), 'screen'), 'post_type'),
			]))
			{ 'pages' } else { 'posts' }
		}])
}

fn (mut this Class_WP_Posts_List_Table) get_columns() rt.PhpVal {
	mut var_post_type := rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', [
		'WP_List_Table',
	], &this), 'screen'), 'post_type')
	mut var_posts_columns := rt.new_array()
	var_posts_columns.array_set('cb', '<input type="checkbox" />')
	var_posts_columns.array_set('title', rt.call_function('_x', [
		rt.new_string('Title'), rt.new_string('column name')]))
	if rt.is_true(rt.call_function('post_type_supports', [var_post_type.clone(),
		rt.new_string('author')]))
	{
		var_posts_columns.array_set('author', rt.call_function('__', [
			rt.new_string('Author'),
		]))
	}
	mut var_taxonomies := rt.call_function('get_object_taxonomies', [
		var_post_type.clone(), rt.new_string('objects')])
	var_taxonomies = rt.call_function('wp_filter_object_list', [
		var_taxonomies.clone(), rt.create_array([
			rt.ArrayItem{ key: 'show_admin_column', val: true },
		]),
		rt.new_string('and'), rt.new_string('name')])
	var_taxonomies = rt.call_function('apply_filters', [
		rt.new_string('manage_taxonomies_for_${var_post_type.to_string()}_columns'),
		var_taxonomies.clone(),
		var_post_type.clone(),
	])
	var_taxonomies = rt.call_function('array_filter', [var_taxonomies.clone(),
		rt.new_string('taxonomy_exists')])
	mut iter_5 := var_taxonomies.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_taxonomy := item_5.val
		if rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy)) {
			mut var_column_key := rt.new_string('categories')
		} else if rt.is_true(rt.identical(rt.new_string('post_tag'), var_taxonomy)) {
			var_column_key = rt.new_string('tags')
		} else {
			var_column_key = rt.new_string('taxonomy-' + var_taxonomy.str())
		}
		var_posts_columns.array_set(var_column_key, rt.get_property(rt.get_property(rt.call_function('get_taxonomy', [
			var_taxonomy.clone(),
		]), 'labels'), 'name'))
	}
	mut var_post_status := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_status')))) {
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_status'))
	} else {
		rt.new_string('all')
	}
	if rt.is_true(rt.call_function('post_type_supports', [var_post_type.clone(), rt.new_string('comments')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_post_status.clone(), rt.create_array([rt.ArrayItem{
		key: none
		val: 'pending'
	}, rt.ArrayItem{ key: none, val: 'draft' }, rt.ArrayItem{ key: none, val: 'future' }]), rt.new_bool(true)]))))) {
		var_posts_columns.array_set('comments', rt.call_function('sprintf', [
			rt.new_string('<span class="vers comment-grey-bubble" title="%1$s" aria-hidden="true"></span><span class="screen-reader-text">%2$s</span>'),
			rt.call_function('esc_attr__', [rt.new_string('Comments')]),
			rt.call_function('__', [rt.new_string('Comments')]),
		]))
	}
	var_posts_columns.array_set('date', rt.call_function('__', [
		rt.new_string('Date')]))
	if rt.is_true(rt.identical(rt.new_string('page'), var_post_type)) {
		var_posts_columns = rt.call_function('apply_filters', [
			rt.new_string('manage_pages_columns'),
			var_posts_columns.clone(),
		])
	} else {
		var_posts_columns = rt.call_function('apply_filters', [
			rt.new_string('manage_posts_columns'),
			var_posts_columns.clone(),
			var_post_type.clone(),
		])
	}
	return rt.call_function('apply_filters', [
		rt.new_string('manage_${var_post_type.to_string()}_posts_columns'),
		var_posts_columns.clone(),
	])
}

fn (mut this Class_WP_Posts_List_Table) get_sortable_columns() rt.PhpVal {
	mut var_post_type := rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', [
		'WP_List_Table',
	], &this), 'screen'), 'post_type')
	if rt.is_true(rt.identical(rt.new_string('page'), var_post_type)) {
		if rt.get_superglobal('_GET').array_isset(rt.new_string('orderby')) {
			mut var_title_orderby_text := rt.call_function('__', [
				rt.new_string('Table ordered by Title.'),
			])
		} else {
			var_title_orderby_text = rt.call_function('__', [
				rt.new_string('Table ordered by Hierarchical Menu Order and Title.'),
			])
		}
		mut var_sortables := {
			'title':    map[string]rt.PhpVal{}
			'parent':   map[string]rt.PhpVal{}
			'comments': map[string]rt.PhpVal{}
			'date':     map[string]rt.PhpVal{}
		}
	} else {
		var_sortables = {
			'title':    map[string]rt.PhpVal{}
			'parent':   map[string]rt.PhpVal{}
			'comments': map[string]rt.PhpVal{}
			'date':     map[string]rt.PhpVal{}
		}
	}
	return var_sortables.clone()
}

fn (mut this Class_WP_Posts_List_Table) display_rows(var_posts rt.PhpVal, level i64) {
	mut var_wp_query := rt.new_null()
	mut var_per_page := rt.new_null()
	mut var_posts_mutated := var_posts
	mut level_mutated := level
	if !rt.is_true(var_posts_mutated) {
		var_posts_mutated = rt.get_property(var_wp_query, 'posts')
	}
	rt.call_function('add_filter', [rt.new_string('the_title'),
		rt.new_string('esc_html')])
	if rt.is_true(this.hierarchical_display) {
		this._display_rows_hierarchical(var_posts_mutated.clone(), (this.get_pagenum()).to_i64(),
			var_per_page.to_i64())
	} else {
		this._display_rows(var_posts_mutated.clone(), level_mutated)
	}
}

fn (mut this Class_WP_Posts_List_Table) _display_rows(var_posts rt.PhpVal, level i64) {
	mut var_posts_mutated := var_posts
	mut level_mutated := level
	mut var_post_type := rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', [
		'WP_List_Table',
	], &this), 'screen'), 'post_type')
	mut var_post_ids := rt.new_array()
	mut iter_6 := var_posts_mutated.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_a_post := item_6.val
		var_post_ids << rt.get_property(var_a_post, 'ID')
	}
	if rt.is_true(rt.call_function('post_type_supports', [var_post_type.clone(),
		rt.new_string('comments')]))
	{
		this.comment_pending_count = rt.call_function('get_pending_comments_num', [
			rt.create_array_from_list(var_post_ids),
		])
	}
	rt.call_function('update_post_author_caches', [var_posts_mutated.clone()])
	mut iter_7 := var_posts_mutated.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_post := item_7.val
		this.single_row(var_post.clone(), level_mutated)
	}
}

fn (mut this Class_WP_Posts_List_Table) _display_rows_hierarchical(var_pages rt.PhpVal, pagenum i64, per_page i64) {
	mut var_wpdb := rt.new_null()
	mut var_GLOBALS := rt.new_null()
	mut var_pages_mutated := var_pages
	mut per_page_mutated := per_page
	mut var_level := rt.new_int(0)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_pages_mutated)))) {
		var_pages_mutated = rt.call_function('get_pages', [
			rt.create_array([rt.ArrayItem{ key: 'sort_column', val: 'menu_order' }]),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_pages_mutated)))) {
			return
		}
	}
	if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('s'))) {
		mut var_top_level_pages := rt.new_array()
		mut var_children_pages := rt.new_array()
		mut iter_8 := var_pages_mutated.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_page := item_8.val
			if rt.is_true(rt.identical(rt.get_property(var_page, 'post_parent'), rt.get_property(var_page,
				'ID')))
			{
				rt.set_property(var_page, 'post_parent', rt.new_int(0))
				rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'posts'),
					rt.create_array([rt.ArrayItem{ key: 'post_parent', val: 0 }]),
					rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.get_property(var_page, 'ID') }])])
				rt.call_function('clean_post_cache', [var_page.clone()])
			}
			if rt.is_true(rt.greater(rt.get_property(var_page, 'post_parent'), rt.new_int(0))) {
				var_children_pages.array_get_mut(rt.get_property(var_page, 'post_parent')).array_push(var_page.clone())
			} else {
				var_top_level_pages << var_page.clone()
			}
		}
		var_pages_mutated = var_top_level_pages
	}
	mut var_count := rt.new_int(0)
	mut var_start := rt.new_int(pagenum - 1 * per_page_mutated)
	mut var_end := rt.add(var_start, rt.new_int(per_page_mutated))
	mut var_to_display := rt.new_array()
	mut iter_9 := var_pages_mutated.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_page := item_9.val
		if rt.is_true(rt.greater_equal(var_count, var_end)) {
			break
		}
		if rt.is_true(rt.greater_equal(var_count, var_start)) {
			var_to_display.array_set(rt.get_property(var_page, 'ID'), var_level.clone())
		}
		rt.pre_inc(var_count)
		if !var_children_pages.is_null() {
			this._page_rows(var_children_pages.clone(), var_count.clone(), rt.get_property(var_page,
				'ID'), rt.add(var_level, rt.new_int(1)), rt.new_int(pagenum),
				rt.new_int(per_page_mutated), var_to_display.clone())
		}
	}
	if !var_children_pages.is_null() && rt.is_true(rt.less(var_count, var_end)) {
		mut iter_10 := var_children_pages.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_orphans := item_10.val
			mut iter_11 := var_orphans.iterator()
			for {
				item_11 := iter_11.next() or { break }
				mut var_op := item_11.val
				if rt.is_true(rt.greater_equal(var_count, var_end)) {
					break
				}
				if rt.is_true(rt.greater_equal(var_count, var_start)) {
					var_to_display.array_set(rt.get_property(var_op, 'ID'), 0)
				}
				rt.pre_inc(var_count)
			}
		}
	}
	mut var_ids := rt.func_array_keys(var_to_display.clone())
	rt.call_function('_prime_post_caches', [var_ids.clone()])
	mut var__posts := rt.call_function('array_map', [rt.new_string('get_post'),
		var_ids.clone()])
	rt.call_function('update_post_author_caches', [var__posts.clone()])
	if !(var_GLOBALS.array_isset(rt.new_string('post'))) {
		var_GLOBALS.array_set('post', rt.call_function('reset', [
			var_ids.clone()]))
	}
	mut iter_12 := var_to_display.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_level_shadow := item_12.val
		mut var_page_id := item_12.key
		print('\t')
		this.single_row(var_page_id.clone(), var_level_shadow.to_i64())
	}
}

fn (mut this Class_WP_Posts_List_Table) _page_rows(var_children_pages rt.PhpVal, var_count rt.PhpVal, var_parent_page rt.PhpVal, var_level rt.PhpVal, var_pagenum rt.PhpVal, var_per_page rt.PhpVal, var_to_display rt.PhpVal) {
	mut var_children_pages_mutated := var_children_pages
	mut var_count_mutated := var_count
	mut var_level_mutated := var_level
	mut var_per_page_mutated := var_per_page
	mut var_to_display_mutated := var_to_display
	if !(var_children_pages_mutated.array_isset(var_parent_page)) {
		return
	}
	mut var_start := rt.mul(rt.sub(var_pagenum, rt.new_int(1)), var_per_page_mutated)
	mut var_end := rt.add(var_start, var_per_page_mutated)
	mut iter_13 := var_children_pages_mutated.array_get(var_parent_page).iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_page := item_13.val
		if rt.is_true(rt.greater_equal(var_count_mutated, var_end)) {
			break
		}
		if rt.is_true(rt.identical(var_count_mutated, var_start))
			&& rt.is_true(rt.greater(rt.get_property(var_page, 'post_parent'), rt.new_int(0))) {
			mut var_my_parents := rt.new_array()
			mut var_my_parent := rt.get_property(var_page, 'post_parent')
			for rt.is_true(var_my_parent) {
				mut var_parent_id := var_my_parent.clone()
				if rt.is_true(rt.new_bool(var_my_parent.clone().is_object())) {
					var_parent_id = rt.get_property(var_my_parent, 'ID')
				}
				var_my_parent = rt.call_function('get_post', [
					var_parent_id.clone()])
				var_my_parents << var_my_parent.clone()
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_my_parent, 'post_parent'))))) {
					break
				}
				var_my_parent = rt.get_property(var_my_parent, 'post_parent')
			}
			mut var_num_parents := rt.new_int(var_my_parents.len)
			var_my_parent = rt.call_function('array_pop', [
				rt.create_array_from_list(var_my_parents),
			])
			for rt.is_true(var_my_parent) {
				var_to_display_mutated.array_set(rt.get_property(var_my_parent, 'ID'), rt.sub(var_level_mutated,
					var_num_parents))
				rt.pre_dec(var_num_parents)
			}
		}
		if rt.is_true(rt.greater_equal(var_count_mutated, var_start)) {
			var_to_display_mutated.array_set(rt.get_property(var_page, 'ID'),
				var_level_mutated.clone())
		}
		rt.pre_inc(var_count_mutated)
		this._page_rows(var_children_pages_mutated.clone(), var_count_mutated.clone(), rt.get_property(var_page,
			'ID'), rt.add(var_level_mutated, rt.new_int(1)), var_pagenum.clone(),
			var_per_page_mutated.clone(), var_to_display_mutated.clone())
	}
	var_children_pages_mutated.array_unset(var_parent_page)
}

fn (mut this Class_WP_Posts_List_Table) column_cb(var_item rt.PhpVal) {
	mut var_post := var_item
	mut var_show := rt.call_function('current_user_can', [rt.new_string('edit_post'),
		rt.get_property(var_post, 'ID')])
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('wp_list_table_show_post_checkbox'),
		var_show.clone(),
		var_post.clone(),
	]))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_ID', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_ID', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_ID', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.call_function('__', [rt.new_string('Select %s')]),
			rt.call_function('_draft_or_post_title', []rt.PhpVal{})])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [rt.new_string('&#8220;%s&#8221; is locked')]),
			rt.call_function('_draft_or_post_title', []rt.PhpVal{}),
		])
		// unsupported statement: Stmt_InlineHTML
	}
}

fn (mut this Class_WP_Posts_List_Table) _column_title(var_post rt.PhpVal, var_classes rt.PhpVal, var_data rt.PhpVal, var_primary rt.PhpVal) {
	mut var_post_mutated := var_post
	mut var_classes_mutated := var_classes
	print('<td class="' + var_classes_mutated.str() + ' page-title" ')
	rt.echo_val(var_data)
	print('>')
	rt.echo_val(this.column_title(var_post_mutated.clone()))
	print(this.handle_row_actions(var_post_mutated.clone(), rt.new_string('title'),
		var_primary.clone()))
	print('</td>')
}

fn (mut this Class_WP_Posts_List_Table) column_title(var_post rt.PhpVal) {
	mut var_mode := rt.new_null()
	mut var_post_mutated := var_post
	if rt.is_true(this.hierarchical_display) {
		if rt.is_true(rt.identical(rt.new_int(0), this.current_level))
			&& rt.new_int((rt.get_property(var_post_mutated, 'post_parent')).to_i64()) > 0 {
			mut var_find_main_page :=
				rt.new_int((rt.get_property(var_post_mutated, 'post_parent')).to_i64())
			for rt.is_true(rt.greater(var_find_main_page, rt.new_int(0))) {
				mut var_parent := rt.call_function('get_post', [
					var_find_main_page.clone()])
				if rt.is_true(rt.new_bool(var_parent.clone().is_null())) {
					break
				}
				rt.pre_inc(this.current_level)
				var_find_main_page =
					rt.new_int((rt.get_property(var_parent, 'post_parent')).to_i64())
				if !(!var_parent_name.is_null()) {
					mut var_parent_name := rt.call_function('apply_filters', [
						rt.new_string('the_title'),
						rt.get_property(var_parent, 'post_title'),
						rt.get_property(var_parent, 'ID'),
					])
				}
			}
		}
	}
	mut var_can_edit_post := rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		rt.get_property(var_post_mutated, 'ID'),
	])
	if rt.is_true(var_can_edit_post)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_post_mutated, 'post_status'))))) {
		mut var_lock_holder := rt.call_function('wp_check_post_lock', [
			rt.get_property(var_post_mutated, 'ID'),
		])
		if rt.is_true(var_lock_holder) {
			var_lock_holder = rt.call_function('get_userdata', [
				var_lock_holder.clone()])
			mut var_locked_avatar := rt.call_function('get_avatar', [
				rt.get_property(var_lock_holder, 'ID'),
				rt.new_int(18),
			])
			mut var_locked_text := rt.call_function('esc_html', [
				rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('%s is currently editing')]),
					rt.get_property(var_lock_holder, 'display_name'),
				]),
			])
		} else {
			var_locked_avatar = rt.new_string('')
			var_locked_text = rt.new_string('')
		}
		print('<div class="locked-info"><span class="locked-avatar">' + var_locked_avatar.str() +
			'</span> <span class="locked-text">' + var_locked_text.str() + '</span></div>\n')
	}
	mut var_pad := rt.call_function('str_repeat', [rt.new_string('&#8212; '), this.current_level])
	print('<strong>')
	mut var_title := rt.call_function('_draft_or_post_title', []rt.PhpVal{})
	if rt.is_true(var_can_edit_post)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_post_mutated, 'post_status'))))) {
		rt.call_function('printf', [
			rt.new_string('<a class="row-title" href="%s">%s%s</a>'),
			rt.call_function('get_edit_post_link', [
				rt.get_property(var_post_mutated, 'ID'),
			]),
			var_pad.clone(),
			var_title.clone(),
		])
	} else {
		rt.call_function('printf', [rt.new_string('<span>%s%s</span>'),
			var_pad.clone(), var_title.clone()])
	}
	rt.call_function('_post_states', [var_post_mutated.clone()])
	if !var_parent_name.is_null() {
		mut var_post_type_object := rt.call_function('get_post_type_object', [
			rt.get_property(var_post_mutated, 'post_type'),
		])
		print(' | ' +
			(rt.get_property(rt.get_property(var_post_type_object, 'labels'), 'parent_item_colon')).str() +
			' ' + (rt.call_function('esc_html', [var_parent_name.clone()])).str())
	}
	print('</strong>\n')
	if rt.is_true(rt.identical(rt.new_string('excerpt'), var_mode))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_post_type_hierarchical', [rt.get_property(rt.get_property(rt.new_object('WP_Posts_List_Table', ['WP_List_Table'], &this), 'screen'), 'post_type')])))))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('read_post'), rt.get_property(var_post_mutated, 'ID')])) {
		if rt.is_true(rt.call_function('post_password_required', [
			var_post_mutated.clone()]))
		{
			print('<span class="protected-post-excerpt">' +
				(rt.call_function('esc_html', [rt.call_function('get_the_excerpt', []rt.PhpVal{})])).str() +
				'</span>')
		} else {
			rt.echo_val(rt.call_function('esc_html', [
				rt.call_function('get_the_excerpt', []rt.PhpVal{}),
			]))
		}
	}
	mut var_quick_edit_enabled := rt.call_function('apply_filters', [
		rt.new_string('quick_edit_enabled_for_post_type'),
		rt.new_bool(true),
		rt.get_property(var_post_mutated, 'post_type'),
	])
	if rt.is_true(var_quick_edit_enabled) {
		rt.call_function('get_inline_data', [var_post_mutated.clone()])
	}
}

fn (mut this Class_WP_Posts_List_Table) column_date(var_post rt.PhpVal) {
	mut var_mode := rt.new_null()
	mut var_post_mutated := var_post
	if rt.is_true(rt.identical(rt.new_string('0000-00-00 00:00:00'), rt.get_property(var_post_mutated,
		'post_date')))
	{
		mut var_t_time := rt.call_function('__', [rt.new_string('Unpublished')])
		mut var_time_diff := rt.new_int(0)
	} else {
		var_t_time = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%1$s at %2$s')]),
			rt.call_function('get_the_time', [rt.call_function('__', [
				rt.new_string('Y/m/d'),
			]),
				var_post_mutated.clone()]),
			rt.call_function('get_the_time', [rt.call_function('__', [
				rt.new_string('g:i a'),
			]),
				var_post_mutated.clone()]),
		])
		mut var_time := rt.call_function('get_post_timestamp', [
			var_post_mutated.clone()])
		var_time_diff = rt.sub(rt.call_function('time', []rt.PhpVal{}), var_time)
	}
	if rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_post_mutated,
		'post_status')))
	{
		mut var_status := rt.call_function('__', [rt.new_string('Published')])
	} else if rt.is_true(rt.identical(rt.new_string('future'), rt.get_property(var_post_mutated,
		'post_status')))
	{
		if rt.is_true(rt.greater(var_time_diff, rt.new_int(0))) {
			var_status = rt.new_string('<strong class="error-message">' +
				(rt.call_function('__', [rt.new_string('Missed schedule')])).str() + '</strong>')
		} else {
			var_status = rt.call_function('__', [rt.new_string('Scheduled')])
		}
	} else {
		var_status = rt.call_function('__', [rt.new_string('Last Modified')])
	}
	var_status = rt.call_function('apply_filters', [
		rt.new_string('post_date_column_status'),
		var_status.clone(),
		var_post_mutated.clone(),
		rt.new_string('date'),
		var_mode.clone(),
	])
	if rt.is_true(var_status) {
		print(var_status.str() + '<br />')
	}
	rt.echo_val(rt.call_function('apply_filters', [
		rt.new_string('post_date_column_time'),
		var_t_time.clone(),
		var_post_mutated.clone(),
		rt.new_string('date'),
		var_mode.clone(),
	]))
}

fn (mut this Class_WP_Posts_List_Table) column_comments(var_post rt.PhpVal) {
	mut var_post_mutated := var_post
	// unsupported statement: Stmt_InlineHTML
	mut var_pending_comments := if !(this.comment_pending_count.array_get(rt.get_property(var_post_mutated, 'ID'))).is_null() {
		this.comment_pending_count.array_get(rt.get_property(var_post_mutated, 'ID'))
	} else {
		rt.new_int(0)
	}
	this.comments_bubble(rt.get_property(var_post_mutated, 'ID'), var_pending_comments.clone())
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Posts_List_Table) column_author(var_post rt.PhpVal) {
	mut var_post_mutated := var_post
	mut var_author := rt.call_function('get_the_author', []rt.PhpVal{})
	if !(!rt.is_true(var_author)) {
		mut var_args := {
			'post_type': rt.get_property(var_post_mutated, 'post_type')
			'author':    rt.call_function('get_the_author_meta', [
				rt.new_string('ID')])
		}
		rt.echo_val(this.get_edit_link(var_args.clone(), rt.call_function('esc_html', [
			var_author.clone(),
		]), ''))
	} else {
		print('<span aria-hidden="true">&#8212;</span><span class="screen-reader-text">' +
			(rt.call_function('__', [rt.new_string('(no author)')])).str() + '</span>')
	}
}

fn (mut this Class_WP_Posts_List_Table) column_default(var_item rt.PhpVal, var_column_name rt.PhpVal) {
	mut var_post := var_item
	if rt.is_true(rt.identical(rt.new_string('categories'), var_column_name)) {
		mut var_taxonomy := rt.new_string('category')
	} else if rt.is_true(rt.identical(rt.new_string('tags'), var_column_name)) {
		var_taxonomy = rt.new_string('post_tag')
	} else if rt.is_true(rt.call_function('str_starts_with', [
		var_column_name.clone(), rt.new_string('taxonomy-')]))
	{
		var_taxonomy = rt.call_function('substr', [var_column_name.clone(),
			rt.new_int(9)])
	} else {
		var_taxonomy = rt.new_bool(false)
	}
	if rt.is_true(var_taxonomy) {
		mut var_taxonomy_object := rt.call_function('get_taxonomy', [
			var_taxonomy.clone()])
		mut var_terms := rt.call_function('get_the_terms', [
			rt.get_property(var_post, 'ID'),
			var_taxonomy.clone(),
		])
		if rt.is_true(rt.new_bool(var_terms.clone().is_array())) {
			mut var_term_links := rt.new_array()
			mut iter_14 := var_terms.iterator()
			for {
				item_14 := iter_14.next() or { break }
				mut var_t := item_14.val
				mut var_posts_in_term_qv := rt.new_array()
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('post'), rt.get_property(var_post,
					'post_type')))))
				{
					var_posts_in_term_qv.array_set('post_type', rt.get_property(var_post,
						'post_type'))
				}
				if rt.is_true(rt.get_property(var_taxonomy_object, 'query_var')) {
					var_posts_in_term_qv.array_set(rt.get_property(var_taxonomy_object, 'query_var'), rt.get_property(var_t,
						'slug'))
				} else {
					var_posts_in_term_qv.array_set('taxonomy', var_taxonomy.clone())
					var_posts_in_term_qv.array_set('term', rt.get_property(var_t, 'slug'))
				}
				mut var_label := rt.call_function('esc_html', [
					rt.call_function('sanitize_term_field', [
						rt.new_string('name'), rt.get_property(var_t, 'name'),
						rt.get_property(var_t, 'term_id'), var_taxonomy.clone(),
						rt.new_string('display')]),
				])
				var_term_links.array_push(this.get_edit_link(var_posts_in_term_qv.clone(),
					var_label.clone(), ''))
			}
			var_term_links = rt.call_function('apply_filters', [
				rt.new_string('post_column_taxonomy_links'),
				var_term_links.clone(),
				var_taxonomy.clone(),
				var_terms.clone(),
			])
			rt.echo_val(rt.call_function('implode', [
				rt.call_function('wp_get_list_item_separator', []rt.PhpVal{}),
				var_term_links.clone(),
			]))
		} else {
			print('<span aria-hidden="true">&#8212;</span><span class="screen-reader-text">' +
				(rt.get_property(rt.get_property(var_taxonomy_object, 'labels'), 'no_terms')).str() +
				'</span>')
		}
		return
	}
	if rt.is_true(rt.call_function('is_post_type_hierarchical', [
		rt.get_property(var_post, 'post_type'),
	]))
	{
		rt.call_function('do_action', [rt.new_string('manage_pages_custom_column'),
			var_column_name.clone(), rt.get_property(var_post, 'ID')])
	} else {
		rt.call_function('do_action', [rt.new_string('manage_posts_custom_column'),
			var_column_name.clone(), rt.get_property(var_post, 'ID')])
	}
	rt.call_function('do_action', [
		rt.concat(rt.concat(rt.new_string('manage_'), rt.get_property(var_post, 'post_type')),
			rt.new_string('_posts_custom_column')),
		var_column_name.clone(),
		rt.get_property(var_post, 'ID'),
	])
}

fn (mut this Class_WP_Posts_List_Table) single_row(var_post rt.PhpVal, level i64) {
	mut var_GLOBALS := rt.new_null()
	mut var_post_mutated := var_post
	mut level_mutated := level
	mut var_global_post := rt.call_function('get_post', []rt.PhpVal{})
	var_post_mutated = rt.call_function('get_post', [var_post_mutated.clone()])
	this.current_level = rt.new_int(level_mutated).clone()
	var_GLOBALS.array_set('post', var_post_mutated.clone())
	rt.call_function('setup_postdata', [var_post_mutated.clone()])
	mut var_classes := rt.new_string('iedit author-' +
		if rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.new_int((rt.get_property(var_post_mutated, 'post_author')).to_i64()))) { 'self' } else { 'other' })
	mut var_lock_holder := rt.call_function('wp_check_post_lock', [
		rt.get_property(var_post_mutated, 'ID'),
	])
	if rt.is_true(var_lock_holder) {
		var_classes = rt.concat(var_classes, rt.new_string(' wp-locked'))
	}
	if rt.is_true(rt.get_property(var_post_mutated, 'post_parent')) {
		mut var_count := rt.new_int(rt.call_function('get_post_ancestors', [
			rt.get_property(var_post_mutated, 'ID'),
		]).array_count())
		var_classes = rt.concat(var_classes, rt.new_string(' level-' + var_count.str()))
	} else {
		var_classes = rt.concat(var_classes, rt.new_string(' level-0'))
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.get_property(var_post_mutated, 'ID'))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('implode', [rt.new_string(' '),
		rt.call_function('get_post_class', [var_classes.clone(),
			rt.get_property(var_post_mutated, 'ID')])]))
	// unsupported statement: Stmt_InlineHTML
	this.single_row_columns(var_post_mutated.clone())
	// unsupported statement: Stmt_InlineHTML
	var_GLOBALS.array_set('post', var_global_post.clone())
}

fn (mut this Class_WP_Posts_List_Table) get_default_primary_column_name() string {
	return 'title'
}

fn (mut this Class_WP_Posts_List_Table) handle_row_actions(var_item rt.PhpVal, var_column_name rt.PhpVal, var_primary rt.PhpVal) string {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_primary, var_column_name)))) {
		return ''
	}
	mut var_post := var_item
	mut var_post_type_object := rt.call_function('get_post_type_object', [
		rt.get_property(var_post, 'post_type'),
	])
	mut var_can_edit_post := rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		rt.get_property(var_post, 'ID'),
	])
	mut var_actions := rt.new_array()
	mut var_title := rt.call_function('_draft_or_post_title', []rt.PhpVal{})
	if rt.is_true(var_can_edit_post)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_post, 'post_status'))))) {
		var_actions.array_set('edit', rt.call_function('sprintf', [
			rt.new_string('<a href="%s" aria-label="%s">%s</a>'),
			rt.call_function('get_edit_post_link', [rt.get_property(var_post, 'ID')]),
			rt.call_function('esc_attr', [
				rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('Edit &#8220;%s&#8221;')]),
					var_title.clone(),
				]),
			]),
			rt.call_function('__', [
				rt.new_string('Edit'),
			]),
		]))
		mut var_quick_edit_enabled := rt.call_function('apply_filters', [
			rt.new_string('quick_edit_enabled_for_post_type'),
			rt.new_bool(true),
			rt.get_property(var_post, 'post_type'),
		])
		if rt.is_true(var_quick_edit_enabled)
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('wp_block'), rt.get_property(var_post, 'post_type'))))) {
			var_actions.array_set('inline hide-if-no-js', rt.call_function('sprintf', [
				rt.new_string('<button type="button" class="button-link editinline" aria-label="%s" aria-expanded="false">%s</button>'),
				rt.call_function('esc_attr', [
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Quick edit &#8220;%s&#8221; inline'),
						]),
						var_title.clone(),
					]),
				]),
				rt.call_function('__', [
					rt.new_string('Quick&nbsp;Edit'),
				]),
			]))
		}
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_post'),
		rt.get_property(var_post, 'ID')]))
	{
		if rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_post, 'post_status'))) {
			var_actions.array_set('untrash', rt.call_function('sprintf', [
				rt.new_string('<a href="%s" aria-label="%s">%s</a>'),
				rt.call_function('wp_nonce_url', [
					rt.call_function('admin_url', [
						rt.call_function('sprintf', [
							rt.new_string(
								(rt.get_property(var_post_type_object, '_edit_link')).str() +
								'&amp;action=untrash'),
							rt.get_property(var_post, 'ID'),
						]),
					]),
					rt.new_string('untrash-post_' + (rt.get_property(var_post, 'ID')).str()),
				]),
				rt.call_function('esc_attr', [
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Restore &#8220;%s&#8221; from the Trash'),
						]),
						var_title.clone(),
					]),
				]),
				rt.call_function('__', [
					rt.new_string('Restore'),
				]),
			]))
		} else if rt.is_true(rt.get_constant('EMPTY_TRASH_DAYS')) {
			var_actions.array_set('trash', rt.call_function('sprintf', [
				rt.new_string('<a href="%s" class="submitdelete" aria-label="%s">%s</a>'),
				rt.call_function('get_delete_post_link', [
					rt.get_property(var_post, 'ID'),
				]),
				rt.call_function('esc_attr', [
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Move &#8220;%s&#8221; to the Trash'),
						]),
						var_title.clone(),
					]),
				]),
				rt.call_function('_x', [
					rt.new_string('Trash'),
					rt.new_string('verb'),
				]),
			]))
		}
		if rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_post, 'post_status')))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('EMPTY_TRASH_DAYS'))))) {
			var_actions.array_set('delete', rt.call_function('sprintf', [
				rt.new_string('<a href="%s" class="submitdelete" aria-label="%s">%s</a>'),
				rt.call_function('get_delete_post_link', [
					rt.get_property(var_post, 'ID'),
					rt.new_string(''),
					rt.new_bool(true),
				]),
				rt.call_function('esc_attr', [
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Delete &#8220;%s&#8221; permanently'),
						]),
						var_title.clone(),
					]),
				]),
				rt.call_function('__', [
					rt.new_string('Delete Permanently'),
				]),
			]))
		}
	}
	if rt.is_true(rt.call_function('is_post_type_viewable', [
		var_post_type_object.clone()]))
	{
		if rt.is_true(rt.call_function('in_array', [
			rt.get_property(var_post, 'post_status'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'pending' },
				rt.ArrayItem{ key: none, val: 'draft' }, rt.ArrayItem{ key: none, val: 'future' }]),
			rt.new_bool(true),
		]))
		{
			if rt.is_true(var_can_edit_post) {
				mut var_preview_link := rt.call_function('get_preview_post_link', [
					var_post.clone(),
				])
				var_actions.array_set('view', rt.call_function('sprintf', [
					rt.new_string('<a href="%s" rel="bookmark" aria-label="%s">%s</a>'),
					rt.call_function('esc_url', [var_preview_link.clone()]),
					rt.call_function('esc_attr', [
						rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string('Preview &#8220;%s&#8221;'),
							]),
							var_title.clone(),
						]),
					]),
					rt.call_function('_x', [
						rt.new_string('Preview'),
						rt.new_string('verb'),
					]),
				]))
			}
		} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_post,
			'post_status')))))
		{
			var_actions.array_set('view', rt.call_function('sprintf', [
				rt.new_string('<a href="%s" rel="bookmark" aria-label="%s">%s</a>'),
				rt.call_function('get_permalink', [rt.get_property(var_post, 'ID')]),
				rt.call_function('esc_attr', [
					rt.call_function('sprintf', [
						rt.call_function('__', [rt.new_string('View &#8220;%s&#8221;')]),
						var_title.clone(),
					]),
				]),
				rt.call_function('__', [
					rt.new_string('View'),
				]),
			]))
		}
	}
	if rt.is_true(rt.identical(rt.new_string('wp_block'), rt.get_property(var_post, 'post_type'))) {
		var_actions.array_set('export', rt.call_function('sprintf', [
			rt.new_string('<button type="button" class="wp-list-reusable-blocks__export button-link" data-id="%s" aria-label="%s">%s</button>'),
			rt.get_property(var_post, 'ID'),
			rt.call_function('esc_attr', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Export &#8220;%s&#8221; as JSON'),
					]),
					var_title.clone(),
				]),
			]),
			rt.call_function('__', [
				rt.new_string('Export as JSON'),
			]),
		]))
	}
	if rt.is_true(rt.call_function('is_post_type_hierarchical', [
		rt.get_property(var_post, 'post_type'),
	]))
	{
		var_actions = rt.call_function('apply_filters', [
			rt.new_string('page_row_actions'),
			var_actions.clone(),
			var_post.clone(),
		])
	} else {
		var_actions = rt.call_function('apply_filters', [
			rt.new_string('post_row_actions'),
			var_actions.clone(),
			var_post.clone(),
		])
	}
	return (this.row_actions(var_actions.clone())).str()
}

fn (mut this Class_WP_Posts_List_Table) inline_edit() {
	mut var_mode := rt.new_null()
	mut var_columns := rt.new_null()
	mut var_screen := rt.get_property(rt.new_object('WP_Posts_List_Table', [
		'WP_List_Table',
	], &this), 'screen')
	mut var_post := rt.call_function('get_default_post_to_edit', [
		rt.get_property(var_screen, 'post_type'),
	])
	mut var_post_type_object := rt.call_function('get_post_type_object', [
		rt.get_property(var_screen, 'post_type'),
	])
	mut var_taxonomy_names := rt.call_function('get_object_taxonomies', [
		rt.get_property(var_screen, 'post_type'),
	])
	mut var_hierarchical_taxonomies := rt.new_array()
	mut var_flat_taxonomies := rt.new_array()
	mut iter_15 := var_taxonomy_names.iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_taxonomy_name := item_15.val
		mut var_taxonomy := rt.call_function('get_taxonomy', [
			var_taxonomy_name.clone()])
		mut var_show_in_quick_edit := rt.get_property(var_taxonomy, 'show_in_quick_edit')
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('quick_edit_show_taxonomy'),
			var_show_in_quick_edit.clone(),
			var_taxonomy_name.clone(),
			rt.get_property(var_screen, 'post_type'),
		])))))
		{
			continue
		}
		if rt.is_true(rt.get_property(var_taxonomy, 'hierarchical')) {
			var_hierarchical_taxonomies << var_taxonomy.clone()
		} else {
			var_flat_taxonomies << var_taxonomy.clone()
		}
	}
	mut var_m := rt.new_string((if !var_mode.is_null()
		&& rt.is_true(rt.identical(rt.new_string('excerpt'), var_mode)) {
		'excerpt'
	} else {
		'list'
	}).str())
	mut var_can_publish := rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_post_type_object, 'cap'), 'publish_posts'),
	])
	mut var_core_columns := {
		'cb':         true
		'date':       true
		'title':      true
		'categories': true
		'tags':       true
		'comments':   true
		'author':     true
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_hclass := rt.new_string((if rt.is_true(rt.new_int(var_hierarchical_taxonomies.len)) {
		'post'
	} else {
		'page'
	}).str())
	mut var_inline_edit_classes :=
		rt.new_string('inline-edit-row inline-edit-row-${var_hclass.to_string()}')
	mut var_bulk_edit_classes := rt.new_string((rt.concat(rt.concat(rt.concat(rt.new_string('bulk-edit-row bulk-edit-row-'),
		var_hclass), rt.new_string(' bulk-edit-')), rt.get_property(var_screen, 'post_type'))).str())
	mut var_quick_edit_classes := rt.new_string((rt.concat(rt.concat(rt.concat(rt.new_string('quick-edit-row quick-edit-row-'),
		var_hclass), rt.new_string(' inline-edit-')), rt.get_property(var_screen, 'post_type'))).str())
	mut var_bulk := rt.new_int(0)
	for rt.is_true(rt.less(var_bulk, rt.new_int(2))) {
		mut var_classes := rt.new_string(var_inline_edit_classes.str() + ' ')
		var_classes = rt.concat(var_classes, if rt.is_true(var_bulk) {
			var_bulk_edit_classes
		} else {
			var_quick_edit_classes
		})
		// unsupported statement: Stmt_InlineHTML
		print(if rt.is_true(var_bulk) { 'bulk-edit' } else { 'inline-edit' })
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_classes)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(this.get_column_count())
		// unsupported statement: Stmt_InlineHTML
		print(if rt.is_true(var_bulk) { 'bulk' } else { 'quick' })
		// unsupported statement: Stmt_InlineHTML
		print(if rt.is_true(var_bulk) { 'bulk' } else { 'quick' })
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(if rt.is_true(var_bulk) { rt.call_function('__', [
				rt.new_string('Bulk Edit'),
			]) } else { rt.call_function('__', [rt.new_string('Quick Edit')]) })
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('post_type_supports', [
			rt.get_property(var_screen, 'post_type'),
			rt.new_string('title'),
		]))
		{
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(var_bulk) {
				// unsupported statement: Stmt_InlineHTML
			} else {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [rt.new_string('Title')])
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(rt.call_function('is_post_type_viewable', [
					rt.get_property(var_screen, 'post_type'),
				]))
				{
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [rt.new_string('Slug')])
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!(rt.is_true(var_bulk)))) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Date')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('touch_time', [rt.new_int(1), rt.new_int(1),
				rt.new_int(0), rt.new_int(1)])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('post_type_supports', [
			rt.get_property(var_screen, 'post_type'),
			rt.new_string('author'),
		]))
		{
			mut var_authors_dropdown := rt.new_string('')
			if rt.is_true(rt.call_function('current_user_can', [
				rt.get_property(rt.get_property(var_post_type_object, 'cap'), 'edit_others_posts'),
			]))
			{
				mut var_dropdown_name := rt.new_string('post_author')
				mut var_dropdown_class := rt.new_string('authors')
				if rt.is_true(rt.call_function('wp_is_large_user_count', []rt.PhpVal{})) {
					var_authors_dropdown = rt.call_function('sprintf', [
						rt.new_string('<select name="%s" class="%s hidden"></select>'),
						rt.call_function('esc_attr', [var_dropdown_name.clone()]),
						rt.call_function('esc_attr', [var_dropdown_class.clone()]),
					])
				} else {
					mut var_users_opt := rt.create_array([
						rt.ArrayItem{ key: 'hide_if_only_one_author', val: false },
						rt.ArrayItem{ key: 'capability', val: rt.create_array([
							rt.ArrayItem{ key: none, val: rt.get_property(rt.get_property(var_post_type_object,
								'cap'), 'edit_posts') },
						]) },
						rt.ArrayItem{ key: 'name', val: var_dropdown_name },
						rt.ArrayItem{ key: 'class', val: var_dropdown_class },
						rt.ArrayItem{ key: 'multi', val: 1 },
						rt.ArrayItem{ key: 'echo', val: 0 },
						rt.ArrayItem{ key: 'show', val: 'display_name_with_login' },
					])
					if rt.is_true(var_bulk) {
						var_users_opt.array_set('show_option_none', rt.call_function('__', [
							rt.new_string('&mdash; No Change &mdash;'),
						]))
					}
					var_users_opt = rt.call_function('apply_filters', [
						rt.new_string('quick_edit_dropdown_authors_args'),
						var_users_opt.clone(),
						var_bulk.clone(),
					])
					mut var_authors := rt.call_function('wp_dropdown_users', [
						var_users_opt.clone()])
					if rt.is_true(var_authors) {
						var_authors_dropdown = rt.new_string('<label class="inline-edit-author">')
						var_authors_dropdown = rt.concat(var_authors_dropdown, rt.new_string(
							'<span class="title">' +
							(rt.call_function('__', [rt.new_string('Author')])).str() + '</span>'))
						var_authors_dropdown = rt.concat(var_authors_dropdown, var_authors)
						var_authors_dropdown = rt.concat(var_authors_dropdown,
							rt.new_string('</label>'))
					}
				}
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_bulk)))) {
				rt.echo_val(var_authors_dropdown)
			}
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!(rt.is_true(var_bulk)))) && rt.is_true(var_can_publish) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Password')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('&ndash;OR&ndash;')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Private')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_int(var_hierarchical_taxonomies.len))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_bulk)))) {
			// unsupported statement: Stmt_InlineHTML
			for var_taxonomy in var_hierarchical_taxonomies {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [
					rt.get_property(rt.get_property(var_taxonomy, 'labels'), 'name'),
				]))
				// unsupported statement: Stmt_InlineHTML
				print(if rt.is_true(rt.identical(rt.new_string('category'), rt.get_property(var_taxonomy,
					'name')))
				{
					'post_category[]'
				} else {
					'tax_input[' +
						(rt.call_function('esc_attr', [rt.get_property(var_taxonomy, 'name')])).str() +
						'][]'
				})
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [
					rt.get_property(var_taxonomy, 'name'),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('wp_terms_checklist', [rt.new_int(0),
					rt.create_array([
						rt.ArrayItem{ key: 'taxonomy', val: rt.get_property(var_taxonomy, 'name') },
					])])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('post_type_supports', [rt.get_property(var_screen, 'post_type'), rt.new_string('author')]))
			&& rt.is_true(var_bulk) {
			rt.echo_val(var_authors_dropdown)
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('post_type_supports', [
			rt.get_property(var_screen, 'post_type'),
			rt.new_string('page-attributes'),
		]))
		{
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.get_property(var_post_type_object, 'hierarchical')) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [rt.new_string('Parent')])
				// unsupported statement: Stmt_InlineHTML
				mut var_dropdown_args := rt.create_array([
					rt.ArrayItem{ key: 'post_type', val: rt.get_property(var_post_type_object,
						'name') },
					rt.ArrayItem{ key: 'selected', val: rt.get_property(var_post, 'post_parent') },
					rt.ArrayItem{ key: 'name', val: 'post_parent' },
					rt.ArrayItem{ key: 'show_option_none', val: rt.call_function('__', [
						rt.new_string('Main Page (no parent)'),
					]) },
					rt.ArrayItem{ key: 'option_none_value', val: 0 },
					rt.ArrayItem{ key: 'sort_column', val: 'menu_order, post_title' },
				])
				if rt.is_true(var_bulk) {
					var_dropdown_args.array_set('show_option_no_change', rt.call_function('__', [
						rt.new_string('&mdash; No Change &mdash;'),
					]))
					var_dropdown_args.array_set('id', 'bulk_edit_post_parent')
				}
				var_dropdown_args = rt.call_function('apply_filters', [
					rt.new_string('quick_edit_dropdown_pages_args'),
					var_dropdown_args.clone(),
					var_bulk.clone(),
				])
				rt.call_function('wp_dropdown_pages', [var_dropdown_args.clone()])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.new_bool(!(rt.is_true(var_bulk)))) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [rt.new_string('Order')])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.get_property(var_post, 'menu_order'))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if 0 < rt.call_function('get_page_templates', [rt.new_null(),
			rt.get_property(var_screen, 'post_type')]).array_count() {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Template')])
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(var_bulk) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [rt.new_string('&mdash; No Change &mdash;')])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			mut var_default_title := rt.call_function('apply_filters', [
				rt.new_string('default_page_template_title'),
				rt.call_function('__', [rt.new_string('Default template')]),
				rt.new_string('quick-edit'),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_default_title.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('page_template_dropdown', [rt.new_string(''),
				rt.get_property(var_screen, 'post_type')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_int(var_flat_taxonomies.len))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_bulk)))) {
			// unsupported statement: Stmt_InlineHTML
			for var_taxonomy in var_flat_taxonomies {
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(rt.call_function('current_user_can', [
					rt.get_property(rt.get_property(var_taxonomy, 'cap'), 'assign_terms'),
				]))
				{
					// unsupported statement: Stmt_InlineHTML
					mut var_taxonomy_name := rt.call_function('esc_attr', [
						rt.get_property(var_taxonomy, 'name'),
					])
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_html', [
						rt.get_property(rt.get_property(var_taxonomy, 'labels'), 'name'),
					]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(var_taxonomy_name)
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [
						rt.get_property(var_taxonomy, 'name'),
					]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [
						rt.get_property(var_taxonomy, 'name'),
					]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [
						rt.get_property(var_taxonomy, 'name'),
					]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [
						rt.get_property(var_taxonomy, 'name'),
					]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_html', [
						rt.get_property(rt.get_property(var_taxonomy, 'labels'),
							'separate_items_with_commas'),
					]))
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('post_type_supports', [rt.get_property(var_screen, 'post_type'), rt.new_string('comments')]))
			|| rt.is_true(rt.call_function('post_type_supports', [rt.get_property(var_screen, 'post_type'), rt.new_string('trackbacks')])) {
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(var_bulk) {
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(rt.call_function('post_type_supports', [
					rt.get_property(var_screen, 'post_type'),
					rt.new_string('comments'),
				]))
				{
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [rt.new_string('Comments')])
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [rt.new_string('&mdash; No Change &mdash;')])
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [rt.new_string('Allow')])
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [rt.new_string('Do not allow')])
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(rt.call_function('post_type_supports', [
					rt.get_property(var_screen, 'post_type'),
					rt.new_string('trackbacks'),
				]))
				{
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [rt.new_string('Pings')])
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [rt.new_string('&mdash; No Change &mdash;')])
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [rt.new_string('Allow')])
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [rt.new_string('Do not allow')])
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
			} else {
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(rt.call_function('post_type_supports', [
					rt.get_property(var_screen, 'post_type'),
					rt.new_string('comments'),
				]))
				{
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [rt.new_string('Allow Comments')])
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(rt.call_function('post_type_supports', [
					rt.get_property(var_screen, 'post_type'),
					rt.new_string('trackbacks'),
				]))
				{
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [rt.new_string('Allow Pings')])
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Status')])
		// unsupported statement: Stmt_InlineHTML
		mut var_inline_edit_statuses := rt.new_array()
		if rt.is_true(var_bulk) {
			var_inline_edit_statuses.array_set('-1', rt.call_function('__', [
				rt.new_string('&mdash; No Change &mdash;'),
			]))
		}
		if rt.is_true(var_can_publish) {
			var_inline_edit_statuses.array_set('publish', rt.call_function('__', [
				rt.new_string('Published'),
			]))
			var_inline_edit_statuses.array_set('future', rt.call_function('__', [
				rt.new_string('Scheduled'),
			]))
			if rt.is_true(var_bulk) {
				var_inline_edit_statuses.array_set('private', rt.call_function('__', [
					rt.new_string('Private'),
				]))
			}
		}
		var_inline_edit_statuses.array_set('pending', rt.call_function('__', [
			rt.new_string('Pending Review'),
		]))
		var_inline_edit_statuses.array_set('draft', rt.call_function('__', [
			rt.new_string('Draft'),
		]))
		var_inline_edit_statuses = rt.call_function('apply_filters', [
			rt.new_string('quick_edit_statuses'),
			var_inline_edit_statuses.clone(),
			rt.get_property(var_screen, 'post_type'),
			var_bulk.clone(),
			var_can_publish.clone(),
		])
		mut iter_16 := var_inline_edit_statuses.iterator()
		for {
			item_16 := iter_16.next() or { break }
			mut var_inline_status_text := item_16.val
			mut var_inline_status_value := item_16.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_inline_status_value.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_inline_status_text.clone()]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.identical(rt.new_string('post'), rt.get_property(var_screen, 'post_type')))
			&& rt.is_true(var_can_publish)
			&& rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_object, 'cap'), 'edit_others_posts')])) {
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(var_bulk) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [rt.new_string('Sticky')])
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [rt.new_string('&mdash; No Change &mdash;')])
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [rt.new_string('Sticky')])
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [rt.new_string('Not Sticky')])
				// unsupported statement: Stmt_InlineHTML
			} else {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [rt.new_string('Make this post sticky')])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_bulk)
			&& rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-formats')]))
			&& rt.is_true(rt.call_function('post_type_supports', [rt.get_property(var_screen, 'post_type'), rt.new_string('post-formats')])) {
			// unsupported statement: Stmt_InlineHTML
			mut var_post_formats := rt.call_function('get_theme_support', [
				rt.new_string('post-formats'),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_ex', [rt.new_string('Format'),
				rt.new_string('post format')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('&mdash; No Change &mdash;')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('get_post_format_string', [
				rt.new_string('standard'),
			]))
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.new_bool(var_post_formats.array_get(rt.new_int(0)).is_array())) {
				// unsupported statement: Stmt_InlineHTML
				mut iter_17 := var_post_formats.array_get(rt.new_int(0)).iterator()
				for {
					item_17 := iter_17.next() or { break }
					mut var_format := item_17.val
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [
						var_format.clone()]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_html', [
						rt.call_function('get_post_format_string', [
							var_format.clone()]),
					]))
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		mut list_tmp_1 := this.get_column_info()
		var_columns = list_tmp_1.array_get(0)
		mut iter_18 := var_columns.iterator()
		for {
			item_18 := iter_18.next() or { break }
			mut var_column_display_name := item_18.val
			mut var_column_name := item_18.key
			if var_core_columns.array_isset(var_column_name) {
				continue
			}
			if rt.is_true(var_bulk) {
				rt.call_function('do_action', [rt.new_string('bulk_edit_custom_box'),
					var_column_name.clone(), rt.get_property(var_screen, 'post_type')])
			} else {
				rt.call_function('do_action', [rt.new_string('quick_edit_custom_box'),
					var_column_name.clone(), rt.get_property(var_screen, 'post_type'),
					rt.new_string('')])
			}
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!(rt.is_true(var_bulk)))) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('wp_nonce_field', [rt.new_string('inlineeditnonce'),
				rt.new_string('_inline_edit'), rt.new_bool(false)])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Update')])
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('submit_button', [
				rt.call_function('__', [rt.new_string('Update')]),
				rt.new_string('primary'),
				rt.new_string('bulk_edit'),
				rt.new_bool(false),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Cancel')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!(rt.is_true(var_bulk)))) {
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_m.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_screen, 'id')]))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!(rt.is_true(var_bulk))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('post_type_supports', [rt.get_property(var_screen, 'post_type'), rt.new_string('author')]))))) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.get_property(var_post, 'post_author'),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_admin_notice', [rt.new_string('<p class="error"></p>'),
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'notice-alt' },
					rt.ArrayItem{ key: none, val: 'inline' },
					rt.ArrayItem{ key: none, val: 'hidden' },
				]) }, rt.ArrayItem{ key: 'paragraph_wrap', val: false }])])
		// unsupported statement: Stmt_InlineHTML
		rt.pre_inc(var_bulk)
	}
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

fn create_wp_posts_list_table(arg_0 rt.PhpVal) &Class_WP_Posts_List_Table {
	mut obj := &Class_WP_Posts_List_Table{
		PhpObjectBase:         rt.PhpObjectBase{}
		hierarchical_display:  rt.new_null()
		comment_pending_count: rt.new_null()
		user_posts_count:      rt.new_null()
		sticky_posts_count:    rt.new_int(0)
		is_trash:              false
		current_level:         rt.new_int(0)
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
			this._page_rows(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4, dispatch_arg_5, dispatch_arg_6)
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
			return rt.new_string(this.handle_row_actions(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
		}
		'inline_edit' {
			this.inline_edit()
			return rt.new_null()
		}
		else {
			return none
		}
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
		'hierarchical_display' {
			this.hierarchical_display = val
			return true
		}
		'comment_pending_count' {
			this.comment_pending_count = val
			return true
		}
		'user_posts_count' {
			this.user_posts_count = val
			return true
		}
		'sticky_posts_count' {
			this.sticky_posts_count = val
			return true
		}
		'is_trash' {
			this.is_trash = val.to_bool()
			return true
		}
		'current_level' {
			this.current_level = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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
