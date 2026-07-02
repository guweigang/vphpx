import rt

fn get_category_link(var_category_arg rt.PhpVal) string {
	mut var_category := var_category_arg
	if !(var_category.clone().is_object()) {
		var_category = rt.new_int(var_category.to_i64())
	}
	var_category = rt.call_function('get_term_link', [var_category.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_category.clone()])) {
		return ''
	}
	return var_category.str()
}

fn get_category_parents(var_category_id rt.PhpVal, link bool, separator string, nicename bool, var_deprecated rt.PhpVal) rt.PhpVal {
	mut var_link := link
	mut var_separator := separator
	mut var_nicename := nicename
	mut var_format := ''
	mut var_args := rt.new_null()
	if !(!rt.is_true(var_deprecated)) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('4.8.0')])
	}
	var_format = if var_nicename { 'slug' } else { 'name' }
	var_args = rt.create_array([rt.ArrayItem{ key: 'separator', val: separator },
		rt.ArrayItem{ key: 'link', val: link }, rt.ArrayItem{ key: 'format', val: var_format }])
	return rt.new_string(get_term_parents_list(var_category_id.clone(), 'category',
		var_args.clone()))
}

fn get_the_category(post_id bool) rt.PhpVal {
	mut var_post_id := post_id
	mut var_categories := rt.new_null()
	mut var_key := rt.new_null()
	var_categories = rt.new_bool(get_the_terms(rt.new_bool(post_id), rt.new_string('category')))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_categories))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_categories.clone()])) {
		var_categories = rt.new_array()
	}
	var_categories = rt.call_function('array_values', [var_categories.clone()])
	mut iter_1 := rt.func_array_keys(var_categories.clone()).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_key_shadow := item_1.val
		rt.call_function('_make_cat_compat', [var_categories.array_get(var_key_shadow)])
	}
	return rt.call_function('apply_filters', [rt.new_string('get_the_categories'),
		var_categories.clone(), rt.new_bool(post_id)])
}

fn get_the_category_by_id(var_cat_id_arg rt.PhpVal) rt.PhpVal {
	mut var_cat_id := var_cat_id_arg
	mut var_category := rt.new_null()
	var_cat_id = rt.new_int(var_cat_id.to_i64())
	var_category = rt.call_function('get_term', [var_cat_id.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_category.clone()])) {
		return var_category.clone()
	}
	return if rt.is_true(var_category) {
		rt.get_property(var_category, 'name')
	} else {
		rt.new_string('')
	}
}

fn get_the_category_list(separator string, parents string, post_id bool) rt.PhpVal {
	mut var_separator := separator
	mut var_parents := parents
	mut var_post_id := post_id
	mut var_wp_rewrite := rt.new_null()
	mut var_categories := rt.new_null()
	mut var_rel := ''
	mut var_thelist := ''
	mut var_category := rt.new_null()
	mut var_i := i64(0)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_object_in_taxonomy', [
		rt.call_function('get_post_type', [rt.new_bool(post_id)]),
		rt.new_string('category'),
	])))))
	{
		return rt.call_function('apply_filters', [rt.new_string('the_category'),
			rt.new_string(''), rt.new_string(separator), rt.new_string(parents)])
	}
	var_categories = rt.call_function('apply_filters', [
		rt.new_string('the_category_list'),
		get_the_category(post_id),
		rt.new_bool(post_id),
	])
	if !rt.is_true(var_categories) {
		return rt.call_function('apply_filters', [rt.new_string('the_category'),
			rt.call_function('__', [rt.new_string('Uncategorized')]),
			rt.new_string(separator), rt.new_string(parents)])
	}
	var_rel = if var_wp_rewrite.clone().is_object()
		&& rt.is_true(rt.call_method(var_wp_rewrite, 'using_permalinks', []rt.PhpVal{})) {
		'rel="category tag"'
	} else {
		'rel="category"'
	}
	var_thelist = ''
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(separator))) {
		var_thelist = var_thelist + '<ul class="post-categories">'
		mut iter_2 := var_categories.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_category_shadow := item_2.val
			var_thelist = var_thelist + '\n\t<li>'
			mut switch_val_1 := rt.new_string(parents.to_lower())
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('multiple'))) {
				if rt.is_true(rt.get_property(var_category_shadow, 'parent')) {
					var_thelist = var_thelist +(get_category_parents(rt.get_property(var_category_shadow, 'parent'), true, separator, false, rt.new_null())).str()
				}
				var_thelist = var_thelist + '<a href="' +
					(rt.call_function('esc_url', [rt.new_string(get_category_link(rt.get_property(var_category_shadow, 'term_id')))])).str() +
					'" ' + var_rel + '>' + (rt.get_property(var_category_shadow, 'name')).str() +
					'</a></li>'
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('single'))) {
				var_thelist = var_thelist + '<a href="' +
					(rt.call_function('esc_url', [rt.new_string(get_category_link(rt.get_property(var_category_shadow, 'term_id')))])).str() +
					'"  ' + var_rel + '>'
				if rt.is_true(rt.get_property(var_category_shadow, 'parent')) {
					var_thelist = var_thelist +(get_category_parents(rt.get_property(var_category_shadow, 'parent'), false, separator, false, rt.new_null())).str()
				}
				var_thelist = var_thelist + (rt.get_property(var_category_shadow, 'name')).str() +
					'</a></li>'
			} else {
				var_thelist = var_thelist + '<a href="' +
					(rt.call_function('esc_url', [rt.new_string(get_category_link(rt.get_property(var_category_shadow, 'term_id')))])).str() +
					'" ' + var_rel + '>' + (rt.get_property(var_category_shadow, 'name')).str() +
					'</a></li>'
			}
		}
		var_thelist = var_thelist + '</ul>'
	} else {
		var_i = 0
		mut iter_3 := var_categories.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_category_shadow := item_3.val
			if 0 < var_i {
				var_thelist = var_thelist + separator
			}
			mut switch_val_2 := rt.new_string(parents.to_lower())
			if rt.is_true(rt.equal(switch_val_2, rt.new_string('multiple'))) {
				if rt.is_true(rt.get_property(var_category_shadow, 'parent')) {
					var_thelist = var_thelist +(get_category_parents(rt.get_property(var_category_shadow, 'parent'), true, separator, false, rt.new_null())).str()
				}
				var_thelist = var_thelist + '<a href="' +
					(rt.call_function('esc_url', [rt.new_string(get_category_link(rt.get_property(var_category_shadow, 'term_id')))])).str() +
					'" ' + var_rel + '>' + (rt.get_property(var_category_shadow, 'name')).str() +
					'</a>'
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('single'))) {
				var_thelist = var_thelist + '<a href="' +
					(rt.call_function('esc_url', [rt.new_string(get_category_link(rt.get_property(var_category_shadow, 'term_id')))])).str() +
					'" ' + var_rel + '>'
				if rt.is_true(rt.get_property(var_category_shadow, 'parent')) {
					var_thelist = var_thelist +(get_category_parents(rt.get_property(var_category_shadow, 'parent'), false, separator, false, rt.new_null())).str()
				}
				var_thelist = var_thelist +
					rt.concat(rt.get_property(var_category_shadow, 'name'), rt.new_string('</a>'))
			} else {
				var_thelist = var_thelist + '<a href="' +
					(rt.call_function('esc_url', [rt.new_string(get_category_link(rt.get_property(var_category_shadow, 'term_id')))])).str() +
					'" ' + var_rel + '>' + (rt.get_property(var_category_shadow, 'name')).str() +
					'</a>'
			}
			var_i += 1
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('the_category'),
		rt.new_string(var_thelist.str()).clone(), rt.new_string(separator),
		rt.new_string(parents)])
}

fn in_category(var_category rt.PhpVal, var_post rt.PhpVal) bool {
	if !rt.is_true(var_category) {
		return false
	}
	return (has_category(var_category.clone(), var_post.clone())).to_bool()
}

fn the_category(separator string, parents string, post_id bool) {
	mut var_separator := separator
	mut var_parents := parents
	mut var_post_id := post_id
	rt.echo_val(get_the_category_list(separator, parents, post_id))
}

fn category_description(category i64) rt.PhpVal {
	mut var_category := category
	return term_description(category, rt.new_null())
}

fn wp_dropdown_categories(args string) rt.PhpVal {
	mut var_args := args
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_parsed_args := rt.new_null()
	mut var_option_none_value := rt.new_null()
	mut var_tab_index := rt.new_null()
	mut var_tab_index_attribute := ''
	mut var_get_terms_args := rt.new_null()
	mut var_categories := rt.new_null()
	mut var_name := rt.new_null()
	mut var_class := rt.new_null()
	mut var_id := rt.new_null()
	mut var_required := ''
	mut var_aria_describedby_attribute := rt.new_null()
	mut var_output := rt.new_null()
	mut var_show_option_none := rt.new_null()
	mut var_show_option_all := rt.new_null()
	mut var_selected := rt.new_null()
	mut var_depth := rt.new_null()
	var_defaults = {
		'show_option_all':   rt.new_string('')
		'show_option_none':  rt.new_string('')
		'orderby':           rt.new_string('id')
		'order':             rt.new_string('ASC')
		'show_count':        rt.new_int(0)
		'hide_empty':        rt.new_int(1)
		'child_of':          rt.new_int(0)
		'exclude':           rt.new_string('')
		'echo':              rt.new_int(1)
		'selected':          rt.new_int(0)
		'hierarchical':      rt.new_int(0)
		'name':              rt.new_string('cat')
		'id':                rt.new_string('')
		'class':             rt.new_string('postform')
		'depth':             rt.new_int(0)
		'tab_index':         rt.new_int(0)
		'taxonomy':          rt.new_string('category')
		'hide_if_empty':     rt.new_bool(false)
		'option_none_value': -1
		'value_field':       rt.new_string('term_id')
		'required':          rt.new_bool(false)
		'aria_describedby':  rt.new_string('')
	}
	var_defaults['selected'] = if rt.is_true(rt.call_function('is_category', []rt.PhpVal{})) { rt.call_function('get_query_var', [
			rt.new_string('cat'),
		]) } else { rt.new_int(0) }
	if rt.new_string(args).array_isset(rt.new_string('type'))
		&& rt.is_true(rt.identical(rt.new_string('link'), rt.new_string(args).array_get(rt.new_string('type')))) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('3.0.0'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('%1$s is deprecated. Use %2$s instead.'),
				]),
				rt.new_string('<code>type => link</code>'),
				rt.new_string('<code>taxonomy => link_category</code>'),
			])])
		rt.new_string(args).array_set('taxonomy', 'link_category')
	}
	var_parsed_args = rt.call_function('wp_parse_args', [rt.new_string(args),
		rt.create_array_from_native_map(var_defaults)])
	var_option_none_value = var_parsed_args.array_get(rt.new_string('option_none_value'))
	if !(var_parsed_args.array_isset(rt.new_string('pad_counts')))
		&& rt.is_true(var_parsed_args.array_get(rt.new_string('show_count')))
		&& rt.is_true(var_parsed_args.array_get(rt.new_string('hierarchical'))) {
		var_parsed_args.array_set('pad_counts', true)
	}
	var_tab_index = var_parsed_args.array_get(rt.new_string('tab_index'))
	var_tab_index_attribute = ''
	if rt.new_int(var_tab_index.to_i64()) > 0 {
		var_tab_index_attribute = " tabindex=\"${var_tab_index.to_string()}\""
	}
	var_get_terms_args = var_parsed_args.clone()
	var_get_terms_args.array_unset(rt.new_string('name'))
	var_categories = rt.call_function('get_terms', [var_get_terms_args.clone()])
	var_name = rt.call_function('esc_attr', [var_parsed_args.array_get(rt.new_string('name'))])
	var_class = rt.call_function('esc_attr', [var_parsed_args.array_get(rt.new_string('class'))])
	var_id = if rt.is_true(var_parsed_args.array_get(rt.new_string('id'))) { rt.call_function('esc_attr', [
			var_parsed_args.array_get(rt.new_string('id')),
		]) } else { var_name }
	var_required = if rt.is_true(var_parsed_args.array_get(rt.new_string('required'))) {
		'required'
	} else {
		''
	}
	var_aria_describedby_attribute = rt.new_string((if rt.is_true(var_parsed_args.array_get(rt.new_string('aria_describedby'))) {
		' aria-describedby="' +
			(rt.call_function('esc_attr', [var_parsed_args.array_get(rt.new_string('aria_describedby'))])).str() +
			'"'
	} else {
		''
	}).str())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_parsed_args.array_get(rt.new_string('hide_if_empty'))))))
		|| !(!rt.is_true(var_categories)) {
		var_output =
			rt.new_string("<select ${var_required} name='${var_name.to_string()}' id='${var_id.to_string()}' class='${var_class.to_string()}'${var_tab_index_attribute}${var_aria_describedby_attribute.to_string()}>\n")
	} else {
		var_output = rt.new_string('')
	}
	if !rt.is_true(var_categories)
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_parsed_args.array_get(rt.new_string('hide_if_empty'))))))
		&& !(!rt.is_true(var_parsed_args.array_get(rt.new_string('show_option_none')))) {
		var_show_option_none = rt.call_function('apply_filters', [
			rt.new_string('list_cats'),
			var_parsed_args.array_get(rt.new_string('show_option_none')),
			rt.new_null(),
		])
		var_output = rt.concat(var_output, rt.new_string("\t<option value='" +
			(rt.call_function('esc_attr', [var_option_none_value.clone()])).str() +
			"' selected='selected'>${var_show_option_none.to_string()}</option>\n"))
	}
	if !(!rt.is_true(var_categories)) {
		if rt.is_true(var_parsed_args.array_get(rt.new_string('show_option_all'))) {
			var_show_option_all = rt.call_function('apply_filters', [
				rt.new_string('list_cats'),
				var_parsed_args.array_get(rt.new_string('show_option_all')),
				rt.new_null(),
			])
			var_selected = rt.new_string((if rt.is_true(rt.identical(rt.new_string('0'),
				(var_parsed_args.array_get(rt.new_string('selected'))).str()))
			{
				" selected='selected'"
			} else {
				''
			}).str())
			var_output = rt.concat(var_output,
				rt.new_string("\t<option value='0'${var_selected.to_string()}>${var_show_option_all.to_string()}</option>\n"))
		}
		if rt.is_true(var_parsed_args.array_get(rt.new_string('show_option_none'))) {
			var_show_option_none = rt.call_function('apply_filters', [
				rt.new_string('list_cats'),
				var_parsed_args.array_get(rt.new_string('show_option_none')),
				rt.new_null(),
			])
			var_selected = rt.call_function('selected', [var_option_none_value.clone(),
				var_parsed_args.array_get(rt.new_string('selected')),
				rt.new_bool(false)])
			var_output = rt.concat(var_output, rt.new_string("\t<option value='" +
				(rt.call_function('esc_attr', [var_option_none_value.clone()])).str() +
				"'${var_selected.to_string()}>${var_show_option_none.to_string()}</option>\n"))
		}
		if rt.is_true(var_parsed_args.array_get(rt.new_string('hierarchical'))) {
			var_depth = var_parsed_args.array_get(rt.new_string('depth'))
		} else {
			var_depth = rt.new_int(-1)
		}
		var_output = rt.concat(var_output, walk_category_dropdown_tree(var_categories.clone(),
			var_depth.clone(), var_parsed_args.clone()))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_parsed_args.array_get(rt.new_string('hide_if_empty'))))))
		|| !(!rt.is_true(var_categories)) {
		var_output = rt.concat(var_output, rt.new_string('</select>\n'))
	}
	var_output = rt.call_function('apply_filters', [rt.new_string('wp_dropdown_cats'),
		var_output.clone(), var_parsed_args.clone()])
	if rt.is_true(var_parsed_args.array_get(rt.new_string('echo'))) {
		rt.echo_val(var_output)
	}
	return var_output.clone()
}

fn wp_list_categories(args string) bool {
	mut var_args := args
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_parsed_args := rt.new_null()
	mut var_exclude_tree := rt.new_null()
	mut var_show_option_all := rt.new_null()
	mut var_show_option_none := rt.new_null()
	mut var_categories := rt.new_null()
	mut var_output := rt.new_null()
	mut var_posts_page := rt.new_null()
	mut var_taxonomy_object := rt.new_null()
	mut var_object_type := rt.new_null()
	mut var__object_type := rt.new_null()
	mut var_current_term_object := rt.new_null()
	mut var_depth := rt.new_null()
	mut var_html := rt.new_null()
	var_defaults = {
		'child_of':            rt.new_int(0)
		'current_category':    rt.new_int(0)
		'depth':               rt.new_int(0)
		'echo':                rt.new_int(1)
		'exclude':             rt.new_string('')
		'exclude_tree':        rt.new_string('')
		'feed':                rt.new_string('')
		'feed_image':          rt.new_string('')
		'feed_type':           rt.new_string('')
		'hide_empty':          rt.new_int(1)
		'hide_title_if_empty': rt.new_bool(false)
		'hierarchical':        rt.new_bool(true)
		'order':               rt.new_string('ASC')
		'orderby':             rt.new_string('name')
		'separator':           rt.new_string('<br />')
		'show_count':          rt.new_int(0)
		'show_option_all':     rt.new_string('')
		'show_option_none':    rt.call_function('__', [rt.new_string('No categories')])
		'style':               rt.new_string('list')
		'taxonomy':            rt.new_string('category')
		'title_li':            rt.call_function('__', [rt.new_string('Categories')])
		'use_desc_for_title':  rt.new_int(0)
	}
	var_parsed_args = rt.call_function('wp_parse_args', [rt.new_string(args),
		rt.create_array_from_native_map(var_defaults)])
	if !(var_parsed_args.array_isset(rt.new_string('pad_counts')))
		&& rt.is_true(var_parsed_args.array_get(rt.new_string('show_count')))
		&& rt.is_true(var_parsed_args.array_get(rt.new_string('hierarchical'))) {
		var_parsed_args.array_set('pad_counts', true)
	}
	if rt.is_true(var_parsed_args.array_get(rt.new_string('hierarchical'))) {
		var_exclude_tree = rt.new_array()
		if rt.is_true(var_parsed_args.array_get(rt.new_string('exclude_tree'))) {
			var_exclude_tree = rt.call_function('array_merge', [
				var_exclude_tree.clone(),
				rt.call_function('wp_parse_id_list', [
					var_parsed_args.array_get(rt.new_string('exclude_tree')),
				])])
		}
		if rt.is_true(var_parsed_args.array_get(rt.new_string('exclude'))) {
			var_exclude_tree = rt.call_function('array_merge', [
				var_exclude_tree.clone(),
				rt.call_function('wp_parse_id_list', [
					var_parsed_args.array_get(rt.new_string('exclude')),
				])])
		}
		var_parsed_args.array_set('exclude_tree', var_exclude_tree.clone())
		var_parsed_args.array_set('exclude', '')
	}
	if !(var_parsed_args.array_isset(rt.new_string('class'))) {
		var_parsed_args.array_set('class', if rt.is_true(rt.identical(rt.new_string('category'),
			var_parsed_args.array_get(rt.new_string('taxonomy'))))
		{
			rt.new_string('categories')
		} else {
			var_parsed_args.array_get(rt.new_string('taxonomy'))
		})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [
		var_parsed_args.array_get(rt.new_string('taxonomy')),
	])))))
	{
		return false
	}
	var_show_option_all = var_parsed_args.array_get(rt.new_string('show_option_all'))
	var_show_option_none = var_parsed_args.array_get(rt.new_string('show_option_none'))
	var_categories = rt.call_function('get_categories', [var_parsed_args.clone()])
	var_output = rt.new_string('')
	if rt.is_true(var_parsed_args.array_get(rt.new_string('title_li')))
		&& rt.is_true(rt.identical(rt.new_string('list'), var_parsed_args.array_get(rt.new_string('style'))))
		&& !(!rt.is_true(var_categories))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_parsed_args.array_get(rt.new_string('hide_title_if_empty')))))) {
		var_output = rt.new_string('<li class="' +
			(rt.call_function('esc_attr', [var_parsed_args.array_get(rt.new_string('class'))])).str() +
			'">' + (var_parsed_args.array_get(rt.new_string('title_li'))).str() + '<ul>')
	}
	if !rt.is_true(var_categories) {
		if !(!rt.is_true(var_show_option_none)) {
			if rt.is_true(rt.identical(rt.new_string('list'),
				var_parsed_args.array_get(rt.new_string('style'))))
			{
				var_output = rt.concat(var_output, rt.new_string('<li class="cat-item-none">' +
					var_show_option_none.str() + '</li>'))
			} else {
				var_output = rt.concat(var_output, var_show_option_none)
			}
		}
	} else {
		if !(!rt.is_true(var_show_option_all)) {
			var_posts_page = rt.new_string('')
			var_taxonomy_object = rt.call_function('get_taxonomy', [
				var_parsed_args.array_get(rt.new_string('taxonomy')),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('post'), rt.get_property(var_taxonomy_object, 'object_type'), rt.new_bool(true)])))))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('page'), rt.get_property(var_taxonomy_object, 'object_type'), rt.new_bool(true)]))))) {
				mut iter_4 := rt.get_property(var_taxonomy_object, 'object_type').iterator()
				for {
					item_4 := iter_4.next() or { break }
					mut var_object_type_shadow := item_4.val
					var__object_type = rt.call_function('get_post_type_object', [
						var_object_type_shadow.clone(),
					])
					if !(!rt.is_true(rt.get_property(var__object_type, 'has_archive'))) {
						var_posts_page = rt.call_function('get_post_type_archive_link', [
							var_object_type_shadow.clone(),
						])
						break
					}
				}
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_posts_page)))) {
				if rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')])))
					&& rt.is_true(rt.call_function('get_option', [rt.new_string('page_for_posts')])) {
					var_posts_page = rt.call_function('get_permalink', [
						rt.call_function('get_option', [rt.new_string('page_for_posts')]),
					])
				} else {
					var_posts_page = rt.call_function('home_url', [
						rt.new_string('/')])
				}
			}
			var_posts_page = rt.call_function('esc_url', [var_posts_page.clone()])
			if rt.is_true(rt.identical(rt.new_string('list'),
				var_parsed_args.array_get(rt.new_string('style'))))
			{
				var_output = rt.concat(var_output,
					rt.new_string("<li class='cat-item-all'><a href='${var_posts_page.to_string()}'>${var_show_option_all.to_string()}</a></li>"))
			} else {
				var_output = rt.concat(var_output,
					rt.new_string("<a href='${var_posts_page.to_string()}'>${var_show_option_all.to_string()}</a>"))
			}
		}
		if !rt.is_true(var_parsed_args.array_get(rt.new_string('current_category')))
			&& rt.is_true(rt.call_function('is_category', []rt.PhpVal{}))
			|| rt.is_true(rt.call_function('is_tax', []rt.PhpVal{}))
			|| rt.is_true(rt.call_function('is_tag', []rt.PhpVal{})) {
			var_current_term_object = rt.call_function('get_queried_object', []rt.PhpVal{})
			if rt.is_true(var_current_term_object)
				&& rt.is_true(rt.identical(var_parsed_args.array_get(rt.new_string('taxonomy')), rt.get_property(var_current_term_object, 'taxonomy'))) {
				var_parsed_args.array_set('current_category', rt.call_function('get_queried_object_id',
					[]rt.PhpVal{}))
			}
		}
		if rt.is_true(var_parsed_args.array_get(rt.new_string('hierarchical'))) {
			var_depth = var_parsed_args.array_get(rt.new_string('depth'))
		} else {
			var_depth = rt.new_int(-1)
		}
		var_output = rt.concat(var_output, walk_category_tree(var_categories.clone(),
			var_depth.clone(), var_parsed_args.clone()))
	}
	if rt.is_true(var_parsed_args.array_get(rt.new_string('title_li')))
		&& rt.is_true(rt.identical(rt.new_string('list'), var_parsed_args.array_get(rt.new_string('style'))))
		&& !(!rt.is_true(var_categories))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_parsed_args.array_get(rt.new_string('hide_title_if_empty')))))) {
		var_output = rt.concat(var_output, rt.new_string('</ul></li>'))
	}
	var_html = rt.call_function('apply_filters', [rt.new_string('wp_list_categories'),
		var_output.clone(), rt.new_string(args)])
	if rt.is_true(var_parsed_args.array_get(rt.new_string('echo'))) {
		rt.echo_val(var_html)
	} else {
		return var_html.to_bool()
	}
	return false
}

fn wp_tag_cloud(args string) rt.PhpVal {
	mut var_args := args
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_tags := rt.new_null()
	mut var_tag := rt.new_null()
	mut var_key := rt.new_null()
	mut var_link := rt.new_null()
	mut var_return := rt.new_null()
	var_defaults = {
		'smallest':   rt.new_int(8)
		'largest':    rt.new_int(22)
		'unit':       rt.new_string('pt')
		'number':     rt.new_int(45)
		'format':     rt.new_string('flat')
		'separator':  rt.new_string('\n')
		'orderby':    rt.new_string('name')
		'order':      rt.new_string('ASC')
		'exclude':    rt.new_string('')
		'include':    rt.new_string('')
		'link':       rt.new_string('view')
		'taxonomy':   rt.new_string('post_tag')
		'post_type':  rt.new_string('')
		'echo':       rt.new_bool(true)
		'show_count': rt.new_int(0)
	}
	var_args = (rt.call_function('wp_parse_args', [rt.new_string(var_args.str()),
		rt.create_array_from_native_map(var_defaults)])).str()
	var_tags = rt.call_function('get_terms', [
		rt.call_function('array_merge', [rt.new_string(var_args.str()),
			rt.create_array([rt.ArrayItem{ key: 'orderby', val: 'count' },
				rt.ArrayItem{ key: 'order', val: 'DESC' }])]),
	])
	if !rt.is_true(var_tags) || rt.is_true(rt.call_function('is_wp_error', [var_tags.clone()])) {
		return rt.new_null()
	}
	mut iter_5 := var_tags.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_tag_shadow := item_5.val
		mut var_key_shadow := item_5.key
		if rt.is_true(rt.identical(rt.new_string('edit'),
			rt.new_string(var_args.str()).array_get(rt.new_string('link'))))
		{
			var_link = rt.call_function('get_edit_term_link', [
				var_tag_shadow.clone(), rt.get_property(var_tag_shadow, 'taxonomy'),
				rt.new_string(var_args.str()).array_get(rt.new_string('post_type'))])
		} else {
			var_link = rt.call_function('get_term_link', [var_tag_shadow.clone(),
				rt.get_property(var_tag_shadow, 'taxonomy')])
		}
		if rt.is_true(rt.call_function('is_wp_error', [var_link.clone()])) {
			return rt.new_null()
		}
		rt.set_property(var_tags.array_get(var_key_shadow), 'link', var_link.clone())
		rt.set_property(var_tags.array_get(var_key_shadow), 'id', rt.get_property(var_tag_shadow,
			'term_id'))
	}
	var_return = wp_generate_tag_cloud(var_tags.clone(), var_args)
	var_return = rt.call_function('apply_filters', [rt.new_string('wp_tag_cloud'),
		var_return.clone(), rt.new_string(var_args.str())])
	if rt.is_true(rt.identical(rt.new_string('array'), rt.new_string(var_args.str()).array_get(rt.new_string('format'))))
		|| !rt.is_true(rt.new_string(var_args.str()).array_get(rt.new_string('echo'))) {
		return var_return.clone()
	}
	rt.echo_val(var_return)
	return rt.new_null()
}

fn default_topic_count_scale(var_count rt.PhpVal) i64 {
	return rt.new_int((rt.call_function('round', [
		rt.mul(rt.call_function('log10', [rt.add(var_count, rt.new_int(1))]), rt.new_int(100)),
	])).to_i64())
}

fn wp_generate_tag_cloud(var_tags_arg rt.PhpVal, args string) rt.PhpVal {
	mut var_args := args
	mut var_tags := var_tags_arg
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_return := rt.new_null()
	mut var_translate_nooped_plural := rt.new_null()
	mut var_tags_sorted := rt.new_null()
	mut var_counts := rt.new_null()
	mut var_real_counts := rt.new_null()
	mut var_tag := rt.new_null()
	mut var_key := rt.new_null()
	mut var_min_count := rt.new_null()
	mut var_spread := rt.new_null()
	mut var_font_spread := rt.new_null()
	mut var_font_step := rt.new_null()
	mut var_aria_label := false
	mut var_tags_data := rt.new_null()
	mut var_tag_id := rt.new_null()
	mut var_count := rt.new_null()
	mut var_real_count := rt.new_null()
	mut var_formatted_count := rt.new_null()
	mut var_a := []rt.PhpVal{}
	mut var_tag_data := map[string]rt.PhpVal{}
	mut var_class := rt.new_null()
	var_defaults = {
		'smallest':                   rt.new_int(8)
		'largest':                    rt.new_int(22)
		'unit':                       rt.new_string('pt')
		'number':                     rt.new_int(0)
		'format':                     rt.new_string('flat')
		'separator':                  rt.new_string('\n')
		'orderby':                    rt.new_string('name')
		'order':                      rt.new_string('ASC')
		'topic_count_text':           rt.new_null()
		'topic_count_text_callback':  rt.new_null()
		'topic_count_scale_callback': rt.new_string('default_topic_count_scale')
		'filter':                     rt.new_int(1)
		'show_count':                 rt.new_int(0)
	}
	var_args = (rt.call_function('wp_parse_args', [rt.new_string(var_args.str()),
		rt.create_array_from_native_map(var_defaults)])).str()
	var_return = if rt.is_true(rt.identical(rt.new_string('array'),
		rt.new_string(var_args.str()).array_get(rt.new_string('format'))))
	{
		rt.new_array()
	} else {
		rt.new_string('')
	}
	if !rt.is_true(var_tags) {
		return var_return.clone()
	}
	if rt.new_string(var_args.str()).array_isset(rt.new_string('topic_count_text')) {
		var_translate_nooped_plural =
			rt.new_string(var_args.str()).array_get(rt.new_string('topic_count_text'))
	} else if !(!rt.is_true(rt.new_string(var_args.str()).array_get(rt.new_string('topic_count_text_callback')))) {
		if rt.is_true(rt.identical(rt.new_string('default_topic_count_text'),
			rt.new_string(var_args.str()).array_get(rt.new_string('topic_count_text_callback'))))
		{
			var_translate_nooped_plural = rt.call_function('_n_noop', [
				rt.new_string('%s item'),
				rt.new_string('%s items'),
			])
		} else {
			var_translate_nooped_plural = rt.new_bool(false)
		}
	} else if rt.new_string(var_args.str()).array_isset(rt.new_string('single_text'))
		&& rt.new_string(var_args.str()).array_isset(rt.new_string('multiple_text')) {
		var_translate_nooped_plural = rt.call_function('_n_noop', [
			rt.new_string(var_args.str()).array_get(rt.new_string('single_text')),
			rt.new_string(var_args.str()).array_get(rt.new_string('multiple_text')),
		])
	} else {
		var_translate_nooped_plural = rt.call_function('_n_noop', [
			rt.new_string('%s item'),
			rt.new_string('%s items'),
		])
	}
	var_tags_sorted = rt.call_function('apply_filters', [rt.new_string('tag_cloud_sort'),
		var_tags.clone(), rt.new_string(var_args.str())])
	if !rt.is_true(var_tags_sorted) {
		return var_return.clone()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_tags_sorted, var_tags)))) {
		var_tags = var_tags_sorted.clone()
		var_tags_sorted = rt.new_null()
	} else {
		if rt.is_true(rt.identical(rt.new_string('RAND'),
			rt.new_string(var_args.str()).array_get(rt.new_string('order'))))
		{
			rt.call_function('shuffle', [var_tags.clone()])
		} else {
			if rt.is_true(rt.identical(rt.new_string('name'),
				rt.new_string(var_args.str()).array_get(rt.new_string('orderby'))))
			{
				rt.call_function('uasort', [var_tags.clone(),
					rt.new_string('_wp_object_name_sort_cb')])
			} else {
				rt.call_function('uasort', [var_tags.clone(),
					rt.new_string('_wp_object_count_sort_cb')])
			}
			if rt.is_true(rt.identical(rt.new_string('DESC'),
				rt.new_string(var_args.str()).array_get(rt.new_string('order'))))
			{
				var_tags = rt.call_function('array_reverse', [
					var_tags.clone(), rt.new_bool(true)])
			}
		}
	}
	if rt.is_true(rt.greater(rt.new_string(var_args.str()).array_get(rt.new_string('number')),
		rt.new_int(0)))
	{
		var_tags = rt.call_function('array_slice', [var_tags.clone(),
			rt.new_int(0), rt.new_string(var_args.str()).array_get(rt.new_string('number'))])
	}
	var_counts = rt.new_array()
	var_real_counts = rt.new_array()
	mut iter_6 := rt.cast_array(var_tags).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_tag_shadow := item_6.val
		mut var_key_shadow := item_6.key
		var_real_counts.array_set(var_key_shadow, rt.get_property(var_tag_shadow, 'count'))
		var_counts.array_set(var_key_shadow, rt.call_function('call_user_func', [
			rt.new_string(var_args.str()).array_get(rt.new_string('topic_count_scale_callback')),
			rt.get_property(var_tag_shadow, 'count'),
		]))
	}
	var_min_count = rt.call_function('min', [var_counts.clone()])
	var_spread = rt.sub(rt.call_function('max', [var_counts.clone()]), var_min_count)
	if rt.is_true(rt.less_equal(var_spread, rt.new_int(0))) {
		var_spread = rt.new_int(1)
	}
	var_font_spread = rt.sub(rt.new_string(var_args.str()).array_get(rt.new_string('largest')),
		rt.new_string(var_args.str()).array_get(rt.new_string('smallest')))
	if rt.is_true(rt.less(var_font_spread, rt.new_int(0))) {
		var_font_spread = rt.new_int(1)
	}
	var_font_step = rt.div(var_font_spread, var_spread)
	var_aria_label = false
	if rt.is_true(rt.new_string(var_args.str()).array_get(rt.new_string('show_count')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_font_spread)))) {
		var_aria_label = true
	}
	var_tags_data = rt.new_array()
	mut iter_7 := var_tags.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_tag_shadow := item_7.val
		mut var_key_shadow := item_7.key
		var_tag_id = if !(rt.get_property(var_tag_shadow, 'id')).is_null() {
			rt.get_property(var_tag_shadow, 'id')
		} else {
			var_key_shadow
		}
		var_count = var_counts.array_get(var_key_shadow)
		var_real_count = var_real_counts.array_get(var_key_shadow)
		if rt.is_true(var_translate_nooped_plural) {
			var_formatted_count = rt.call_function('sprintf', [
				rt.call_function('translate_nooped_plural', [
					var_translate_nooped_plural.clone(), var_real_count.clone()]),
				rt.call_function('number_format_i18n', [var_real_count.clone()]),
			])
		} else {
			var_formatted_count = rt.call_function('call_user_func', [
				rt.new_string(var_args.str()).array_get(rt.new_string('topic_count_text_callback')),
				var_real_count.clone(),
				var_tag_shadow.clone(),
				rt.new_string(var_args.str()),
			])
		}
		var_tags_data.array_push(rt.create_array([
			rt.ArrayItem{ key: 'id', val: var_tag_id },
			rt.ArrayItem{ key: 'url', val: rt.get_property(var_tag_shadow, 'link') },
			rt.ArrayItem{
				key: 'role'
				val: if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('#'), rt.get_property(var_tag_shadow,
					'link')))))
				{
					''
				} else {
					' role="button"'
				}
			},
			rt.ArrayItem{ key: 'name', val: rt.get_property(var_tag_shadow, 'name') },
			rt.ArrayItem{ key: 'formatted_count', val: var_formatted_count },
			rt.ArrayItem{ key: 'slug', val: rt.get_property(var_tag_shadow, 'slug') },
			rt.ArrayItem{ key: 'real_count', val: var_real_count },
			rt.ArrayItem{ key: 'class', val: 'tag-cloud-link tag-link-' + var_tag_id.str() },
			rt.ArrayItem{ key: 'font_size', val: rt.add(rt.new_string(var_args.str()).array_get(rt.new_string('smallest')), rt.mul(rt.sub(var_count,
				var_min_count), var_font_step)) },
			rt.ArrayItem{
				key: 'aria_label'
				val: if var_aria_label { rt.call_function('sprintf', [
						rt.new_string(' aria-label="%1$s (%2$s)"'),
						rt.call_function('esc_attr', [
							rt.get_property(var_tag_shadow, 'name'),
						]),
						rt.call_function('esc_attr', [
							var_formatted_count.clone(),
						]),
					]) } else { rt.new_string('') }
			},
			rt.ArrayItem{
				key: 'show_count'
				val: if rt.is_true(rt.new_string(var_args.str()).array_get(rt.new_string('show_count'))) {
					'<span class="tag-link-count"> (' + var_real_count.str() + ')</span>'
				} else {
					''
				}
			},
		]))
	}
	var_tags_data = rt.call_function('apply_filters', [
		rt.new_string('wp_generate_tag_cloud_data'),
		var_tags_data.clone(),
	])
	var_a = rt.new_array()
	mut iter_8 := var_tags_data.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_tag_data_shadow := item_8.val
		mut var_key_shadow := item_8.key
		var_class = rt.new_string((var_tag_data_shadow['class']).str() + ' tag-link-position-' +
			(rt.add(var_key_shadow, rt.new_int(1))).str())
		var_a << rt.call_function('sprintf', [
			rt.new_string('<a href="%1$s"%2$s class="%3$s" style="font-size: %4$s;"%5$s>%6$s%7$s</a>'),
			rt.call_function('esc_url', [var_tag_data_shadow['url']]),
			var_tag_data_shadow['role'],
			rt.call_function('esc_attr', [var_class.clone()]),
			rt.call_function('esc_attr', [
				rt.new_string(
					(rt.call_function('str_replace', [rt.new_string(','), rt.new_string('.'), var_tag_data_shadow['font_size']])).str() +
					(rt.new_string(var_args.str()).array_get(rt.new_string('unit'))).str()),
			]),
			var_tag_data_shadow['aria_label'],
			rt.call_function('esc_html', [
				var_tag_data_shadow['name'],
			]),
			var_tag_data_shadow['show_count'],
		])
	}
	mut switch_val_3 := rt.new_string(var_args.str()).array_get(rt.new_string('format'))
	if rt.is_true(rt.equal(switch_val_3, rt.new_string('array'))) {
		var_return = var_a
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('list'))) {
		var_return = rt.new_string("<ul class='wp-tag-cloud' role='list'>\n\t<li>")
		var_return = rt.concat(var_return, rt.call_function('implode', [
			rt.new_string('</li>\n\t<li>'),
			rt.create_array_from_list(var_a),
		]))
		var_return = rt.concat(var_return, rt.new_string('</li>\n</ul>\n'))
	} else {
		var_return = rt.call_function('implode', [
			rt.new_string(var_args.str()).array_get(rt.new_string('separator')),
			rt.create_array_from_list(var_a),
		])
	}
	if rt.is_true(rt.new_string(var_args.str()).array_get(rt.new_string('filter'))) {
		return rt.call_function('apply_filters', [rt.new_string('wp_generate_tag_cloud'),
			var_return.clone(), var_tags.clone(), rt.new_string(var_args.str())])
	} else {
		return var_return.clone()
	}
	return rt.new_null()
}

fn _wp_object_name_sort_cb(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	return rt.call_function('strnatcasecmp', [rt.get_property(var_a, 'name'),
		rt.get_property(var_b, 'name')])
}

fn _wp_object_count_sort_cb(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	return rt.sub(rt.get_property(var_a, 'count'), rt.get_property(var_b, 'count'))
}

fn walk_category_tree(var_args_origin ...rt.PhpVal) rt.PhpVal {
	mut var_args := rt.create_array_from_list(var_args_origin)
	mut var_walker := rt.new_null()
	if !rt.is_true(var_args.array_get(rt.new_int(2)).array_get(rt.new_string('walker')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_args.array_get(rt.new_int(2)).array_get(rt.new_string('walker')), 'Walker')))))) {
		var_walker = create_walker_category()
	} else {
		var_walker = var_args.array_get(rt.new_int(2)).array_get(rt.new_string('walker'))
	}
	return rt.call_method(var_walker, 'walk', [var_args.clone()])
}

fn walk_category_dropdown_tree(var_args_origin ...rt.PhpVal) rt.PhpVal {
	mut var_args := rt.create_array_from_list(var_args_origin)
	mut var_walker := rt.new_null()
	if !rt.is_true(var_args.array_get(rt.new_int(2)).array_get(rt.new_string('walker')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_args.array_get(rt.new_int(2)).array_get(rt.new_string('walker')), 'Walker')))))) {
		var_walker = create_walker_categorydropdown()
	} else {
		var_walker = var_args.array_get(rt.new_int(2)).array_get(rt.new_string('walker'))
	}
	return rt.call_method(var_walker, 'walk', [var_args.clone()])
}

fn get_tag_link(var_tag rt.PhpVal) string {
	return get_category_link(var_tag.clone())
}

fn get_the_tags(post i64) rt.PhpVal {
	mut var_post := post
	mut var_terms := rt.new_null()
	var_terms = rt.new_bool(get_the_terms(rt.new_int(post), rt.new_string('post_tag')))
	return rt.call_function('apply_filters', [rt.new_string('get_the_tags'),
		var_terms.clone()])
}

fn get_the_tag_list(before string, sep string, after string, post_id i64) rt.PhpVal {
	mut var_before := before
	mut var_sep := sep
	mut var_after := after
	mut var_post_id := post_id
	mut var_tag_list := rt.new_null()
	var_tag_list = get_the_term_list(rt.new_int(post_id), rt.new_string('post_tag'), before, sep,
		after)
	return rt.call_function('apply_filters', [rt.new_string('the_tags'),
		var_tag_list.clone(), rt.new_string(before), rt.new_string(sep),
		rt.new_string(after), rt.new_int(post_id)])
}

fn the_tags(var_before_arg rt.PhpVal, sep string, after string) {
	mut var_sep := sep
	mut var_after := after
	mut var_before := var_before_arg
	mut var_the_tags := rt.new_null()
	if rt.is_true(rt.identical(rt.new_null(), var_before)) {
		var_before = rt.call_function('__', [rt.new_string('Tags: ')])
	}
	var_the_tags = get_the_tag_list(var_before.clone(), sep, after, 0)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
		var_the_tags.clone()])))))
	{
		rt.echo_val(var_the_tags)
	}
}

fn tag_description(tag i64) rt.PhpVal {
	mut var_tag := tag
	return term_description(tag, rt.new_null())
}

fn term_description(term i64, var_deprecated rt.PhpVal) rt.PhpVal {
	mut var_term := term
	mut var_description := rt.new_null()
	if !(var_term != 0) && rt.is_true(rt.call_function('is_tax', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('is_tag', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('is_category', []rt.PhpVal{})) {
		var_term = (rt.call_function('get_queried_object', []rt.PhpVal{})).to_i64()
		if var_term != 0 {
			var_term = (rt.get_property(rt.new_int(var_term), 'term_id')).to_i64()
		}
	}
	var_description = rt.call_function('get_term_field', [rt.new_string('description'),
		rt.new_int(var_term)])
	return if rt.is_true(rt.call_function('is_wp_error', [var_description.clone()])) {
		rt.new_string('')
	} else {
		var_description
	}
}

fn get_the_terms(var_post_arg rt.PhpVal, var_taxonomy rt.PhpVal) bool {
	mut var_post := var_post_arg
	mut var_terms := rt.new_null()
	mut var_term_ids := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return false
	}
	var_terms = rt.call_function('get_object_term_cache', [
		rt.get_property(var_post, 'ID'),
		var_taxonomy.clone(),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_terms)) {
		var_terms = rt.call_function('wp_get_object_terms', [
			rt.get_property(var_post, 'ID'),
			var_taxonomy.clone(),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
			var_terms.clone(),
		])))))
		{
			var_term_ids = rt.call_function('wp_list_pluck', [
				var_terms.clone(), rt.new_string('term_id')])
			rt.call_function('wp_cache_add', [rt.get_property(var_post, 'ID'),
				var_term_ids.clone(), rt.new_string(var_taxonomy.str() + '_relationships')])
		}
	}
	var_terms = rt.call_function('apply_filters', [rt.new_string('get_the_terms'),
		var_terms.clone(), rt.get_property(var_post, 'ID'), var_taxonomy.clone()])
	if !rt.is_true(var_terms) {
		return false
	}
	return var_terms.to_bool()
}

fn get_the_term_list(var_post_id rt.PhpVal, var_taxonomy rt.PhpVal, before string, sep string, after string) rt.PhpVal {
	mut var_before := before
	mut var_sep := sep
	mut var_after := after
	mut var_terms := false
	mut var_links := []rt.PhpVal{}
	mut var_term := rt.new_null()
	mut var_link := rt.new_null()
	mut var_term_links := rt.new_null()
	var_terms = get_the_terms(var_post_id.clone(), var_taxonomy.clone())
	if rt.is_true(rt.call_function('is_wp_error', [rt.new_bool(var_terms).clone()])) {
		return rt.new_bool(var_terms)
	}
	if !var_terms {
		return rt.new_bool(false)
	}
	var_links = rt.new_array()
	mut iter_9 := rt.new_bool(var_terms).iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_term_shadow := item_9.val
		var_link = rt.call_function('get_term_link', [var_term_shadow.clone(),
			var_taxonomy.clone()])
		if rt.is_true(rt.call_function('is_wp_error', [var_link.clone()])) {
			return var_link.clone()
		}
		var_links << '<a href="' + (rt.call_function('esc_url', [var_link.clone()])).str() +
			'" rel="tag">' + (rt.get_property(var_term_shadow, 'name')).str() + '</a>'
	}
	var_term_links = rt.call_function('apply_filters', [
		rt.new_string('term_links-${var_taxonomy.to_string()}'),
		rt.create_array_from_list(var_links),
	])
	return rt.new_string(before +
		(rt.call_function('implode', [rt.new_string(sep), var_term_links.clone()])).str() + after)
}

fn get_term_parents_list(var_term_id_arg rt.PhpVal, taxonomy string, var_args_arg rt.PhpVal) string {
	mut var_taxonomy := taxonomy
	mut var_term_id := var_term_id_arg
	mut var_args := var_args_arg
	mut var_list := ''
	mut var_term := rt.new_null()
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_bool := rt.new_null()
	mut var_parents := rt.new_null()
	mut var_parent := rt.new_null()
	mut var_name := rt.new_null()
	var_list = ''
	var_term = rt.call_function('get_term', [var_term_id.clone(),
		rt.new_string(taxonomy)])
	if rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
		return var_term.str()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_term)))) {
		return var_list
	}
	var_term_id = rt.get_property(var_term, 'term_id')
	var_defaults = {
		'format':    rt.new_string('name')
		'separator': rt.new_string('/')
		'link':      rt.new_bool(true)
		'inclusive': rt.new_bool(true)
	}
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array_from_native_map(var_defaults)])
	mut iter_10 := rt.create_array([rt.ArrayItem{ key: none, val: 'link' },
		rt.ArrayItem{ key: none, val: 'inclusive' }]).iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_bool_shadow := item_10.val
		var_args.array_set(var_bool_shadow, rt.call_function('wp_validate_boolean', [
			var_args.array_get(var_bool_shadow),
		]))
	}
	var_parents = rt.call_function('get_ancestors', [var_term_id.clone(),
		rt.new_string(taxonomy), rt.new_string('taxonomy')])
	if rt.is_true(var_args.array_get(rt.new_string('inclusive'))) {
		rt.call_function('array_unshift', [var_parents.clone(),
			var_term_id.clone()])
	}
	mut iter_11 := rt.call_function('array_reverse', [var_parents.clone()]).iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_term_id_shadow := item_11.val
		var_parent = rt.call_function('get_term', [var_term_id_shadow.clone(),
			rt.new_string(taxonomy)])
		var_name = if rt.is_true(rt.identical(rt.new_string('slug'),
			var_args.array_get(rt.new_string('format'))))
		{
			rt.get_property(var_parent, 'slug')
		} else {
			rt.get_property(var_parent, 'name')
		}
		if rt.is_true(var_args.array_get(rt.new_string('link'))) {
			var_list = var_list + '<a href="' +
				(rt.call_function('esc_url', [rt.call_function('get_term_link', [rt.get_property(var_parent, 'term_id'), rt.new_string(taxonomy)])])).str() +
				'">' + var_name.str() + '</a>' +
				(var_args.array_get(rt.new_string('separator'))).str()
		} else {
			var_list = var_list + var_name.str() +
				(var_args.array_get(rt.new_string('separator'))).str()
		}
	}
	return var_list
}

fn the_terms(var_post_id rt.PhpVal, var_taxonomy rt.PhpVal, before string, sep string, after string) bool {
	mut var_before := before
	mut var_sep := sep
	mut var_after := after
	mut var_term_list := rt.new_null()
	var_term_list = get_the_term_list(var_post_id.clone(), var_taxonomy.clone(), before, sep, after)
	if rt.is_true(rt.call_function('is_wp_error', [var_term_list.clone()])) {
		return false
	}
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('the_terms'),
		var_term_list.clone(), var_taxonomy.clone(), rt.new_string(before),
		rt.new_string(sep), rt.new_string(after)]))
	return false
}

fn has_category(category string, var_post rt.PhpVal) rt.PhpVal {
	mut var_category := category
	return rt.new_bool(has_term(category, 'category', var_post.clone()))
}

fn has_tag(tag string, var_post rt.PhpVal) rt.PhpVal {
	mut var_tag := tag
	return rt.new_bool(has_term(tag, 'post_tag', var_post.clone()))
}

fn has_term(term string, taxonomy string, var_post_arg rt.PhpVal) bool {
	mut var_term := term
	mut var_taxonomy := taxonomy
	mut var_post := var_post_arg
	mut var_r := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return false
	}
	var_r = rt.call_function('is_object_in_term', [rt.get_property(var_post, 'ID'),
		rt.new_string(taxonomy), rt.new_string(var_term.str())])
	if rt.is_true(rt.call_function('is_wp_error', [var_r.clone()])) {
		return false
	}
	return var_r.to_bool()
}

struct Class_Walker_Category {
	rt.PhpObjectBase
}

struct Class_Walker_CategoryDropdown {
	rt.PhpObjectBase
}

fn create_walker_category(_args ...rt.PhpVal) &Class_Walker_Category {
	mut obj := &Class_Walker_Category{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_walker_categorydropdown(_args ...rt.PhpVal) &Class_Walker_CategoryDropdown {
	mut obj := &Class_Walker_CategoryDropdown{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Walker_Category) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Walker_Category) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Walker_Category) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Walker_CategoryDropdown) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Walker_CategoryDropdown) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Walker_CategoryDropdown) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
