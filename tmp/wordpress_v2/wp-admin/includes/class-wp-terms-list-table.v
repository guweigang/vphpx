import rt

struct Class_WP_Terms_List_Table {
	rt.PhpObjectBase
pub mut:
	callback_args rt.PhpVal = rt.new_null()
	level         rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Terms_List_Table) construct(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	mut var_post_type := rt.get_superglobal('post_type')
	mut var_taxonomy := rt.get_superglobal('taxonomy')
	mut var_action := rt.get_superglobal('action')
	mut var_tax := rt.get_superglobal('tax')
	this.Class_WP_List_Table.construct(rt.create_array([
		rt.ArrayItem{ key: 'plural', val: 'tags' },
		rt.ArrayItem{ key: 'singular', val: 'tag' },
		rt.ArrayItem{
			key: 'screen'
			val: if !(var_args_mutated.array_get(rt.new_string('screen'))).is_null() {
				var_args_mutated.array_get(rt.new_string('screen'))
			} else {
				rt.new_null()
			}
		},
	]))
	var_action = rt.get_property(rt.get_property(rt.new_object('WP_Terms_List_Table', [
		'WP_List_Table',
	], &this), 'screen'), 'action')
	var_post_type = rt.get_property(rt.get_property(rt.new_object('WP_Terms_List_Table', [
		'WP_List_Table',
	], &this), 'screen'), 'post_type')
	var_taxonomy = rt.get_property(rt.get_property(rt.new_object('WP_Terms_List_Table', [
		'WP_List_Table',
	], &this), 'screen'), 'taxonomy')
	if !rt.is_true(var_taxonomy) {
		var_taxonomy = rt.new_string('post_tag')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [
		var_taxonomy.clone(),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [rt.new_string('Invalid taxonomy.')]),
		])
	}
	var_tax = rt.call_function('get_taxonomy', [var_taxonomy.clone()])
	if !rt.is_true(var_post_type)
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_post_type.clone(), rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{
		key: 'show_ui'
		val: true
	}])]), rt.new_bool(true)]))))) {
		var_post_type = rt.new_string('post')
	}
}

fn (mut this Class_WP_Terms_List_Table) ajax_user_can() rt.PhpVal {
	return rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(rt.call_function('get_taxonomy', [
			rt.get_property(rt.get_property(rt.new_object('WP_Terms_List_Table', [
				'WP_List_Table',
			], &this), 'screen'), 'taxonomy'),
		]), 'cap'), 'manage_terms'),
	])
}

fn (mut this Class_WP_Terms_List_Table) prepare_items() {
	mut var_taxonomy := rt.get_property(rt.get_property(rt.new_object('WP_Terms_List_Table', [
		'WP_List_Table',
	], &this), 'screen'), 'taxonomy')
	mut var_tags_per_page :=
		this.get_items_per_page(rt.new_string('edit_${var_taxonomy.to_string()}_per_page'))
	if rt.is_true(rt.identical(rt.new_string('post_tag'), var_taxonomy)) {
		var_tags_per_page = rt.call_function('apply_filters', [
			rt.new_string('edit_tags_per_page'),
			var_tags_per_page.clone(),
		])
		var_tags_per_page = rt.call_function('apply_filters_deprecated', [
			rt.new_string('tagsperpage'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_tags_per_page }]),
			rt.new_string('2.8.0'),
			rt.new_string('edit_tags_per_page'),
		])
	} else if rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy)) {
		var_tags_per_page = rt.call_function('apply_filters', [
			rt.new_string('edit_categories_per_page'),
			var_tags_per_page.clone(),
		])
	}
	mut var_search := rt.new_string((if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('s')))) { rt.call_function('wp_unslash', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('s')),
		]).to_string().trim_space() } else { '' }).str())
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
		rt.ArrayItem{ key: 'search', val: var_search }, rt.ArrayItem{
			key: 'page'
			val: this.get_pagenum()
		}, rt.ArrayItem{ key: 'number', val: var_tags_per_page },
		rt.ArrayItem{ key: 'hide_empty', val: 0 }])
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('orderby')))) {
		var_args.array_set('orderby', rt.call_function('wp_unslash', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('orderby')),
		]).to_string().trim_space())
	}
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('order')))) {
		var_args.array_set('order', rt.call_function('wp_unslash', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('order')),
		]).to_string().trim_space())
	}
	var_args.array_set('offset', rt.mul(rt.sub(var_args.array_get(rt.new_string('page')),
		rt.new_int(1)), var_args.array_get(rt.new_string('number'))))
	this.callback_args = var_args.clone()
	if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [var_taxonomy.clone()]))
		&& !(var_args.array_isset(rt.new_string('orderby'))) {
		var_args.array_set('number', 0)
		var_args.array_set('offset', var_args.array_get(rt.new_string('number')))
	}
	this.dispatch_set_prop('items', rt.call_function('get_terms', [
		var_args.clone()]))
	this.set_pagination_args(rt.create_array([
		rt.ArrayItem{ key: 'total_items', val: rt.call_function('wp_count_terms', [
			rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
				rt.ArrayItem{ key: 'search', val: var_search }]),
		]) },
		rt.ArrayItem{ key: 'per_page', val: var_tags_per_page },
	]))
}

fn (mut this Class_WP_Terms_List_Table) no_items() {
	rt.echo_val(rt.get_property(rt.get_property(rt.call_function('get_taxonomy', [
		rt.get_property(rt.get_property(rt.new_object('WP_Terms_List_Table', [
			'WP_List_Table',
		], &this), 'screen'), 'taxonomy'),
	]), 'labels'), 'not_found'))
}

fn (mut this Class_WP_Terms_List_Table) get_bulk_actions() rt.PhpVal {
	mut var_actions := rt.new_array()
	if rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(rt.call_function('get_taxonomy', [
			rt.get_property(rt.get_property(rt.new_object('WP_Terms_List_Table', [
				'WP_List_Table',
			], &this), 'screen'), 'taxonomy'),
		]), 'cap'), 'delete_terms'),
	]))
	{
		var_actions.array_set('delete', rt.call_function('__', [
			rt.new_string('Delete')]))
	}
	return var_actions.clone()
}

fn (mut this Class_WP_Terms_List_Table) current_action() string {
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('action'))
		&& rt.get_superglobal('_REQUEST').array_isset(rt.new_string('delete_tags'))
		&& rt.is_true(rt.identical(rt.new_string('delete'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('action')))) {
		return 'bulk-delete'
	}
	return (this.Class_WP_List_Table.current_action()).str()
}

fn (mut this Class_WP_Terms_List_Table) get_columns() rt.PhpVal {
	mut var_columns := {
		'cb':          rt.new_string('<input type="checkbox" />')
		'name':        rt.call_function('_x', [rt.new_string('Name'),
			rt.new_string('term name')])
		'description': rt.call_function('__', [rt.new_string('Description')])
		'slug':        rt.call_function('__', [rt.new_string('Slug')])
	}
	if rt.is_true(rt.identical(rt.new_string('link_category'), rt.get_property(rt.get_property(rt.new_object('WP_Terms_List_Table', [
		'WP_List_Table',
	], &this), 'screen'), 'taxonomy')))
	{
		var_columns['links'] = rt.call_function('__', [rt.new_string('Links')])
	} else {
		var_columns['posts'] = rt.call_function('_x', [rt.new_string('Count'),
			rt.new_string('Number/count of items')])
	}
	return var_columns.clone()
}

fn (mut this Class_WP_Terms_List_Table) get_sortable_columns() rt.PhpVal {
	mut var_taxonomy := rt.get_property(rt.get_property(rt.new_object('WP_Terms_List_Table', [
		'WP_List_Table',
	], &this), 'screen'), 'taxonomy')
	if !(rt.get_superglobal('_GET').array_isset(rt.new_string('orderby')))
		&& rt.is_true(rt.call_function('is_taxonomy_hierarchical', [var_taxonomy.clone()])) {
		mut var_name_orderby_text := rt.call_function('__', [
			rt.new_string('Table ordered hierarchically.'),
		])
	} else {
		var_name_orderby_text = rt.call_function('__', [
			rt.new_string('Table ordered by Name.'),
		])
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'name', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'name' },
			rt.ArrayItem{ key: none, val: false },
			rt.ArrayItem{ key: none, val: rt.call_function('_x', [
				rt.new_string('Name'), rt.new_string('term name')]) },
			rt.ArrayItem{ key: none, val: var_name_orderby_text },
			rt.ArrayItem{ key: none, val: 'asc' },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'description' },
			rt.ArrayItem{ key: none, val: false },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Description')]) },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Table ordered by Description.')]) },
		]) },
		rt.ArrayItem{ key: 'slug', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'slug' },
			rt.ArrayItem{ key: none, val: false },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Slug')]) },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Table ordered by Slug.')]) },
		]) },
		rt.ArrayItem{ key: 'posts', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'count' },
			rt.ArrayItem{ key: none, val: false },
			rt.ArrayItem{ key: none, val: rt.call_function('_x', [
				rt.new_string('Count'), rt.new_string('Number/count of items')]) },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Table ordered by Posts Count.')]) },
		]) },
		rt.ArrayItem{ key: 'links', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'count' },
			rt.ArrayItem{ key: none, val: false },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Links')]) },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Table ordered by Links.')]) },
		]) },
	])
}

fn (mut this Class_WP_Terms_List_Table) display_rows_or_placeholder() {
	mut var_taxonomy := rt.get_property(rt.get_property(rt.new_object('WP_Terms_List_Table', [
		'WP_List_Table',
	], &this), 'screen'), 'taxonomy')
	mut var_number := this.callback_args.array_get(rt.new_string('number'))
	mut var_offset := this.callback_args.array_get(rt.new_string('offset'))
	mut var_count := rt.new_int(0)
	if !rt.is_true(rt.get_property(rt.new_object('WP_Terms_List_Table', ['WP_List_Table'], &this), 'items'))
		|| !(rt.get_property(rt.new_object('WP_Terms_List_Table', ['WP_List_Table'], &this), 'items').is_array()) {
		print('<tr class="no-items"><td class="colspanchange" colspan="' +
			(this.get_column_count()).str() + '">')
		this.no_items()
		print('</td></tr>')
		return
	}
	if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [var_taxonomy.clone()]))
		&& !(this.callback_args.array_isset(rt.new_string('orderby'))) {
		if !(!rt.is_true(this.callback_args.array_get(rt.new_string('search')))) {
			mut var_children := rt.new_array()
		} else {
			var_children = rt.call_function('_get_term_hierarchy', [
				var_taxonomy.clone()])
		}
		this._rows(var_taxonomy.clone(), rt.get_property(rt.new_object('WP_Terms_List_Table', [
			'WP_List_Table',
		], &this), 'items'), var_children.clone(), var_offset.clone(), var_number.clone(),
			var_count.clone(), 0, 0)
	} else {
		mut iter_1 := rt.get_property(rt.new_object('WP_Terms_List_Table', [
			'WP_List_Table',
		], &this), 'items').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_term := item_1.val
			this.single_row(var_term.clone(), 0)
		}
	}
}

fn (mut this Class_WP_Terms_List_Table) _rows(var_taxonomy rt.PhpVal, var_terms rt.PhpVal, var_children rt.PhpVal, var_start rt.PhpVal, var_per_page rt.PhpVal, var_count rt.PhpVal, parent_term i64, level i64) {
	mut var_taxonomy_mutated := var_taxonomy
	mut var_children_mutated := var_children
	mut var_count_mutated := var_count
	mut level_mutated := level
	mut var_end := rt.add(var_start, var_per_page)
	mut iter_2 := var_terms.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_term := item_2.val
		mut var_key := item_2.key
		if rt.is_true(rt.greater_equal(var_count_mutated, var_end)) {
			break
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_term, 'parent'), rt.new_int(parent_term)))))
			&& !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('s'))) {
			continue
		}
		if rt.is_true(rt.identical(var_count_mutated, var_start))
			&& rt.is_true(rt.greater(rt.get_property(var_term, 'parent'), rt.new_int(0)))
			&& !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('s'))) {
			mut var_my_parents := rt.new_array()
			mut var_parent_ids := rt.new_array()
			mut var_p := rt.get_property(var_term, 'parent')
			for rt.is_true(var_p) {
				mut var_my_parent := rt.call_function('get_term', [
					var_p.clone(), var_taxonomy_mutated.clone()])
				var_my_parents << var_my_parent.clone()
				var_p = rt.get_property(var_my_parent, 'parent')
				if rt.is_true(rt.call_function('in_array', [var_p.clone(),
					rt.create_array_from_list(var_parent_ids),
					rt.new_bool(true)]))
				{
					break
				}
				var_parent_ids << var_p.clone()
			}
			var_parent_ids = rt.new_null()
			mut var_num_parents := rt.new_int(var_my_parents.len)
			var_my_parent = rt.call_function('array_pop', [
				rt.create_array_from_list(var_my_parents),
			])
			for rt.is_true(var_my_parent) {
				print('\t')
				this.single_row(var_my_parent.clone(), (rt.sub(rt.new_int(level_mutated),
					var_num_parents)).to_i64())
				rt.pre_dec(var_num_parents)
			}
		}
		if rt.is_true(rt.greater_equal(var_count_mutated, var_start)) {
			print('\t')
			this.single_row(var_term.clone(), level_mutated)
		}
		rt.pre_inc(var_count_mutated)
		var_terms.array_unset(var_key)
		if var_children_mutated.array_isset(rt.get_property(var_term, 'term_id'))
			&& !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('s'))) {
			this._rows(var_taxonomy_mutated.clone(), var_terms.clone(),
				var_children_mutated.clone(), var_start.clone(), var_per_page.clone(),
				var_count_mutated.clone(), (rt.get_property(var_term, 'term_id')).to_i64(),

				level_mutated + 1)
		}
	}
}

fn (mut this Class_WP_Terms_List_Table) single_row(var_tag rt.PhpVal, level i64) {
	mut var_taxonomy := rt.new_null()
	mut var_tag_mutated := var_tag
	mut level_mutated := level
	var_tag_mutated = rt.call_function('sanitize_term', [var_tag_mutated.clone(),
		var_taxonomy.clone()])
	this.level = rt.new_int(level_mutated).clone()
	if rt.is_true(rt.get_property(var_tag_mutated, 'parent')) {
		mut var_count := rt.new_int(rt.call_function('get_ancestors', [
			rt.get_property(var_tag_mutated, 'term_id'),
			var_taxonomy.clone(),
			rt.new_string('taxonomy'),
		]).array_count())
		level_mutated = 'level-' + var_count.str()
	} else {
		level_mutated = 'level-0'
	}
	print('<tr id="tag-' + (rt.get_property(var_tag_mutated, 'term_id')).str() + '" class="' +
		level_mutated.str() + '">')
	this.single_row_columns(var_tag_mutated.clone())
	print('</tr>')
}

fn (mut this Class_WP_Terms_List_Table) column_cb(var_item rt.PhpVal) string {
	mut var_tag := var_item
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_term'),
		rt.get_property(var_tag, 'term_id')]))
	{
		return (rt.call_function('sprintf', [
			rt.new_string(
				'<input type="checkbox" name="delete_tags[]" value="%1$s" id="cb-select-%1$s" />' +
				'<label for="cb-select-%1$s"><span class="screen-reader-text">%2$s</span></label>'),
			rt.get_property(var_tag, 'term_id'),
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Select %s')]),
				rt.get_property(var_tag, 'name'),
			]),
		])).str()
	}
	return '&nbsp;'
}

fn (mut this Class_WP_Terms_List_Table) column_name(var_tag rt.PhpVal) rt.PhpVal {
	mut var_tag_mutated := var_tag
	mut var_taxonomy := rt.get_property(rt.get_property(rt.new_object('WP_Terms_List_Table', [
		'WP_List_Table',
	], &this), 'screen'), 'taxonomy')
	mut var_pad := rt.call_function('str_repeat', [rt.new_string('&#8212; '),
		rt.call_function('max', [rt.new_int(0), this.level])])
	mut var_name := rt.call_function('apply_filters', [rt.new_string('term_name'),
		rt.new_string(var_pad.str() + ' ' + (rt.get_property(var_tag_mutated, 'name')).str()),
		var_tag_mutated.clone()])
	mut var_qe_data := rt.call_function('get_term', [
		rt.get_property(var_tag_mutated, 'term_id'),
		var_taxonomy.clone(),
		rt.get_constant('OBJECT'),
		rt.new_string('edit'),
	])
	mut var_uri := if rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})) {
		rt.call_function('wp_get_referer', []rt.PhpVal{})
	} else {
		rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))
	}
	mut var_edit_link := rt.call_function('get_edit_term_link', [
		var_tag_mutated.clone(), var_taxonomy.clone(),
		rt.get_property(rt.get_property(rt.new_object('WP_Terms_List_Table', [
			'WP_List_Table',
		], &this), 'screen'), 'post_type')])
	if rt.is_true(var_edit_link) {
		var_edit_link = rt.call_function('add_query_arg', [
			rt.new_string('wp_http_referer'),
			rt.call_function('urlencode', [
				rt.call_function('wp_unslash', [var_uri.clone()]),
			]),
			var_edit_link.clone(),
		])
		var_name = rt.call_function('sprintf', [
			rt.new_string('<a class="row-title" href="%s">%s</a>'),
			rt.call_function('esc_url', [var_edit_link.clone()]),
			var_name.clone(),
		])
	}
	mut var_output := rt.call_function('sprintf', [
		rt.new_string('<strong>%s</strong><br />'),
		var_name.clone(),
	])
	mut var_quick_edit_enabled := rt.call_function('apply_filters', [
		rt.new_string('quick_edit_enabled_for_taxonomy'),
		rt.new_bool(true),
		var_taxonomy.clone(),
	])
	if rt.is_true(var_quick_edit_enabled) {
		var_output = rt.concat(var_output, rt.new_string('<div class="hidden" id="inline_' +
			(rt.get_property(var_qe_data, 'term_id')).str() + '">'))
		var_output = rt.concat(var_output, rt.new_string('<div class="name">' +
			(rt.get_property(var_qe_data, 'name')).str() + '</div>'))
		var_output = rt.concat(var_output, rt.new_string('<div class="slug">' +
			(rt.call_function('apply_filters', [rt.new_string('editable_slug'), rt.get_property(var_qe_data, 'slug'), var_qe_data.clone()])).str() +
			'</div>'))
		var_output = rt.concat(var_output, rt.new_string('<div class="parent">' +
			(rt.get_property(var_qe_data, 'parent')).str() + '</div></div>'))
	}
	return var_output.clone()
}

fn (mut this Class_WP_Terms_List_Table) get_default_primary_column_name() string {
	return 'name'
}

fn (mut this Class_WP_Terms_List_Table) handle_row_actions(var_item rt.PhpVal, var_column_name rt.PhpVal, var_primary rt.PhpVal) string {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_primary, var_column_name)))) {
		return ''
	}
	mut var_tag := var_item
	mut var_taxonomy := rt.get_property(rt.get_property(rt.new_object('WP_Terms_List_Table', [
		'WP_List_Table',
	], &this), 'screen'), 'taxonomy')
	mut var_uri := if rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})) {
		rt.call_function('wp_get_referer', []rt.PhpVal{})
	} else {
		rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))
	}
	mut var_actions := rt.new_array()
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_term'),
		rt.get_property(var_tag, 'term_id')]))
	{
		var_actions.array_set('edit', rt.call_function('sprintf', [
			rt.new_string('<a href="%s" aria-label="%s">%s</a>'),
			rt.call_function('esc_url', [
				rt.call_function('add_query_arg', [rt.new_string('wp_http_referer'),
					rt.call_function('urlencode', [
						rt.call_function('wp_unslash', [var_uri.clone()]),
					]),
					rt.call_function('get_edit_term_link', [
						var_tag.clone(),
						var_taxonomy.clone(),
						rt.get_property(rt.get_property(rt.new_object('WP_Terms_List_Table', [
							'WP_List_Table'], &this), 'screen'), 'post_type'),
					])]),
			]),
			rt.call_function('esc_attr', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Edit &#8220;%s&#8221;'),
					]),
					rt.get_property(var_tag, 'name'),
				]),
			]),
			rt.call_function('__', [
				rt.new_string('Edit'),
			]),
		]))
		mut var_quick_edit_enabled := rt.call_function('apply_filters', [
			rt.new_string('quick_edit_enabled_for_taxonomy'),
			rt.new_bool(true),
			var_taxonomy.clone(),
		])
		if rt.is_true(var_quick_edit_enabled) {
			var_actions.array_set('inline hide-if-no-js', rt.call_function('sprintf', [
				rt.new_string('<button type="button" class="button-link editinline" aria-label="%s" aria-expanded="false">%s</button>'),
				rt.call_function('esc_attr', [
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Quick edit &#8220;%s&#8221; inline'),
						]),
						rt.get_property(var_tag, 'name'),
					]),
				]),
				rt.call_function('__', [
					rt.new_string('Quick&nbsp;Edit'),
				]),
			]))
		}
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_term'),
		rt.get_property(var_tag, 'term_id')]))
	{
		var_actions.array_set('delete', rt.call_function('sprintf', [
			rt.new_string('<a href="%s" class="delete-tag aria-button-if-js" aria-label="%s">%s</a>'),
			rt.call_function('wp_nonce_url', [
				rt.concat(rt.concat(rt.concat(rt.new_string('edit-tags.php?action=delete&amp;taxonomy='),
					var_taxonomy), rt.new_string('&amp;tag_ID=')), rt.get_property(var_tag,
					'term_id')),
				rt.new_string('delete-tag_' + (rt.get_property(var_tag, 'term_id')).str()),
			]),
			rt.call_function('esc_attr', [
				rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('Delete &#8220;%s&#8221;')]),
					rt.get_property(var_tag, 'name'),
				]),
			]),
			rt.call_function('__', [
				rt.new_string('Delete'),
			]),
		]))
	}
	if rt.is_true(rt.call_function('is_term_publicly_viewable', [
		var_tag.clone()]))
	{
		var_actions.array_set('view', rt.call_function('sprintf', [
			rt.new_string('<a href="%s" aria-label="%s">%s</a>'),
			rt.call_function('get_term_link', [var_tag.clone()]),
			rt.call_function('esc_attr', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('View &#8220;%s&#8221; archive'),
					]),
					rt.get_property(var_tag, 'name'),
				]),
			]),
			rt.call_function('__', [
				rt.new_string('View'),
			]),
		]))
	}
	var_actions = rt.call_function('apply_filters', [rt.new_string('tag_row_actions'),
		var_actions.clone(), var_tag.clone()])
	var_actions = rt.call_function('apply_filters', [
		rt.new_string('${var_taxonomy.to_string()}_row_actions'),
		var_actions.clone(),
		var_tag.clone(),
	])
	return (this.row_actions(var_actions.clone())).str()
}

fn (mut this Class_WP_Terms_List_Table) column_description(var_tag rt.PhpVal) string {
	mut var_tag_mutated := var_tag
	if rt.is_true(rt.get_property(var_tag_mutated, 'description')) {
		return (rt.get_property(var_tag_mutated, 'description')).str()
	} else {
		return '<span aria-hidden="true">&#8212;</span><span class="screen-reader-text">' +
			(rt.call_function('__', [rt.new_string('No description')])).str() + '</span>'
	}
	return ''
}

fn (mut this Class_WP_Terms_List_Table) column_slug(var_tag rt.PhpVal) rt.PhpVal {
	mut var_tag_mutated := var_tag
	return rt.call_function('apply_filters', [rt.new_string('editable_slug'),
		rt.get_property(var_tag_mutated, 'slug'), var_tag_mutated.clone()])
}

fn (mut this Class_WP_Terms_List_Table) column_posts(var_tag rt.PhpVal) string {
	mut var_tag_mutated := var_tag
	mut var_count := rt.call_function('number_format_i18n', [
		rt.get_property(var_tag_mutated, 'count'),
	])
	mut var_tax := rt.call_function('get_taxonomy', [
		rt.get_property(rt.get_property(rt.new_object('WP_Terms_List_Table', [
			'WP_List_Table',
		], &this), 'screen'), 'taxonomy'),
	])
	mut var_ptype_object := rt.call_function('get_post_type_object', [
		rt.get_property(rt.get_property(rt.new_object('WP_Terms_List_Table', [
			'WP_List_Table',
		], &this), 'screen'), 'post_type'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_ptype_object, 'show_ui'))))) {
		return var_count.str()
	}
	if rt.is_true(rt.get_property(var_tax, 'query_var')) {
		mut var_args := rt.create_array([
			rt.ArrayItem{ key: rt.get_property(var_tax, 'query_var'), val: rt.get_property(var_tag_mutated,
				'slug') },
		])
	} else {
		var_args = rt.create_array([
			rt.ArrayItem{ key: 'taxonomy', val: rt.get_property(var_tax, 'name') },
			rt.ArrayItem{ key: 'term', val: rt.get_property(var_tag_mutated, 'slug') },
		])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('post'), rt.get_property(rt.get_property(rt.new_object('WP_Terms_List_Table', [
		'WP_List_Table',
	], &this), 'screen'), 'post_type')))))
	{
		var_args.array_set('post_type', rt.get_property(rt.get_property(rt.new_object('WP_Terms_List_Table', [
			'WP_List_Table',
		], &this), 'screen'), 'post_type'))
	}
	if rt.is_true(rt.identical(rt.new_string('attachment'), rt.get_property(rt.get_property(rt.new_object('WP_Terms_List_Table', [
		'WP_List_Table',
	], &this), 'screen'), 'post_type')))
	{
		return "<a href='" +
			(rt.call_function('esc_url', [rt.call_function('add_query_arg', [var_args.clone(), rt.new_string('upload.php')])])).str() +
			"'>${var_count.to_string()}</a>"
	}
	return "<a href='" +
		(rt.call_function('esc_url', [rt.call_function('add_query_arg', [var_args.clone(), rt.new_string('edit.php')])])).str() +
		"'>${var_count.to_string()}</a>"
}

fn (mut this Class_WP_Terms_List_Table) column_links(var_tag rt.PhpVal) rt.PhpVal {
	mut var_tag_mutated := var_tag
	mut var_count := rt.call_function('number_format_i18n', [
		rt.get_property(var_tag_mutated, 'count'),
	])
	if rt.is_true(var_count) {
		var_count = rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string("<a href='link-manager.php?cat_id="), rt.get_property(var_tag_mutated,
			'term_id')), rt.new_string("'>")), var_count), rt.new_string('</a>'))).str())
	}
	return var_count.clone()
}

fn (mut this Class_WP_Terms_List_Table) column_default(var_item rt.PhpVal, var_column_name rt.PhpVal) rt.PhpVal {
	mut var_tag := var_item
	return rt.call_function('apply_filters', [
		rt.concat(rt.concat(rt.new_string('manage_'), rt.get_property(rt.get_property(rt.new_object('WP_Terms_List_Table', [
			'WP_List_Table',
		], &this), 'screen'), 'taxonomy')), rt.new_string('_custom_column')),
		rt.new_string(''),
		var_column_name.clone(),
		rt.get_property(var_tag, 'term_id'),
	])
}

fn (mut this Class_WP_Terms_List_Table) inline_edit() {
	mut var_columns := map[string]rt.PhpVal{}
	mut var_tax := rt.call_function('get_taxonomy', [
		rt.get_property(rt.get_property(rt.new_object('WP_Terms_List_Table', [
			'WP_List_Table',
		], &this), 'screen'), 'taxonomy'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_tax, 'cap'), 'edit_terms'),
	])))))
	{
		return
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_column_count())
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Quick Edit')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Name'), rt.new_string('term name')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Slug')])
	// unsupported statement: Stmt_InlineHTML
	mut var_core_columns := {
		'cb':          true
		'description': true
		'name':        true
		'slug':        true
		'posts':       true
	}
	mut list_tmp_1 := this.get_column_info()
	var_columns = list_tmp_1.array_get(0)
	for var_column_name, var_column_display_name in var_columns {
		if var_core_columns.array_isset(rt.new_string(column_name)) {
			continue
		}
		rt.call_function('do_action', [rt.new_string('quick_edit_custom_box'),
			rt.new_string(column_name), rt.new_string('edit-tags'),
			rt.get_property(rt.get_property(rt.new_object('WP_Terms_List_Table', [
				'WP_List_Table',
			], &this), 'screen'), 'taxonomy')])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.get_property(rt.get_property(var_tax, 'labels'), 'update_item'))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Cancel')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('taxinlineeditnonce'),
		rt.new_string('_inline_edit'), rt.new_bool(false)])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.get_property(rt.get_property(rt.new_object('WP_Terms_List_Table', [
			'WP_List_Table',
		], &this), 'screen'), 'taxonomy'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.get_property(rt.get_property(rt.new_object('WP_Terms_List_Table', [
			'WP_List_Table',
		], &this), 'screen'), 'post_type'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_admin_notice', [rt.new_string('<p class="error"></p>'),
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' },
			rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'notice-alt' },
				rt.ArrayItem{ key: none, val: 'inline' },
				rt.ArrayItem{ key: none, val: 'hidden' },
			]) }, rt.ArrayItem{ key: 'paragraph_wrap', val: false }])])
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

fn create_wp_terms_list_table(arg_0 rt.PhpVal) &Class_WP_Terms_List_Table {
	mut obj := &Class_WP_Terms_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
		callback_args: rt.new_null()
		level:         rt.new_null()
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

fn (mut this Class_WP_Terms_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'current_action' {
			return rt.new_string(this.current_action())
		}
		'get_columns' {
			return this.get_columns()
		}
		'get_sortable_columns' {
			return this.get_sortable_columns()
		}
		'display_rows_or_placeholder' {
			this.display_rows_or_placeholder()
			return rt.new_null()
		}
		'_rows' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			dispatch_arg_6 := (if args.len > 6 { args[6] } else { rt.new_null() }).to_i64()
			dispatch_arg_7 := (if args.len > 7 { args[7] } else { rt.new_null() }).to_i64()
			this._rows(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4, dispatch_arg_5, dispatch_arg_6, dispatch_arg_7)
			return rt.new_null()
		}
		'single_row' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.single_row(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'column_cb' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.column_cb(dispatch_arg_0))
		}
		'column_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.column_name(dispatch_arg_0)
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
		'column_description' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.column_description(dispatch_arg_0))
		}
		'column_slug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.column_slug(dispatch_arg_0)
		}
		'column_posts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.column_posts(dispatch_arg_0))
		}
		'column_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.column_links(dispatch_arg_0)
		}
		'column_default' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.column_default(dispatch_arg_0, dispatch_arg_1)
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

fn (this &Class_WP_Terms_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'callback_args' { return this.callback_args }
		'level' { return this.level }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Terms_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'callback_args' {
			this.callback_args = val
			return true
		}
		'level' {
			this.level = val
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
