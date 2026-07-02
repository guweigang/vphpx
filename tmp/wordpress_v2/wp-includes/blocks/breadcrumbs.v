import rt

fn render_block_core_breadcrumbs(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_is_front_page := rt.new_null()
	mut var_is_home := rt.new_null()
	mut var_page_for_posts := rt.new_null()
	mut var_breadcrumb_items := rt.new_null()
	mut var_is_paged := rt.new_null()
	mut var_text := rt.new_null()
	mut var_archive_breadcrumbs := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_post_type := rt.new_null()
	mut var_post := rt.new_null()
	mut var_post_parent := rt.new_null()
	mut var_parent_post := rt.new_null()
	mut var_show_terms := rt.new_null()
	mut var_post_type_object := rt.new_null()
	mut var_archive_link := rt.new_null()
	mut var_label := rt.new_null()
	mut var_title := rt.new_null()
	mut var_wrapper_attributes := rt.new_null()
	mut var_breadcrumb_html := rt.new_null()
	var_is_front_page = rt.call_function('is_front_page', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_attributes.array_get(rt.new_string('showOnHomePage'))))))
		&& rt.is_true(var_is_front_page) {
		return ''
	}
	var_is_home = rt.call_function('is_home', []rt.PhpVal{})
	var_page_for_posts = rt.call_function('get_option', [rt.new_string('page_for_posts')])
	var_breadcrumb_items = rt.new_array()
	if rt.is_true(var_attributes.array_get(rt.new_string('showHomeItem'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_is_front_page))))|| (rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')])))
			&& rt.new_int((rt.call_function('get_query_var', [rt.new_string('page')])).to_i64()) > 1) {
			var_breadcrumb_items.array_push(rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Home'),
				]) },
				rt.ArrayItem{ key: 'url', val: rt.call_function('home_url', [
					rt.new_string('/'),
				]) },
			]))
		} else {
			var_breadcrumb_items.array_push(block_core_breadcrumbs_create_item(rt.call_function('__', [
				rt.new_string('Home'),
			]), block_core_breadcrumbs_is_paged()))
		}
	}
	if rt.is_true(var_is_home) {
		if rt.is_true(var_page_for_posts) {
			var_breadcrumb_items.array_push(block_core_breadcrumbs_create_item(block_core_breadcrumbs_get_post_title(var_page_for_posts.clone()),
				block_core_breadcrumbs_is_paged()))
		}
		if rt.is_true(block_core_breadcrumbs_is_paged()) {
			var_breadcrumb_items.array_push(block_core_breadcrumbs_create_page_number_item(''))
		}
	} else if rt.is_true(var_is_front_page) {
		if rt.new_int((rt.call_function('get_query_var', [rt.new_string('page')])).to_i64()) > 1 {
			var_breadcrumb_items.array_push(block_core_breadcrumbs_create_page_number_item('page'))
		}
	} else if rt.is_true(rt.call_function('is_search', []rt.PhpVal{})) {
		var_is_paged = block_core_breadcrumbs_is_paged()
		var_text = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Search results for: "%s"')]),
			rt.call_function('wp_trim_words', [rt.call_function('get_search_query', []rt.PhpVal{}),
				rt.new_int(10)]),
		])
		var_breadcrumb_items.array_push(block_core_breadcrumbs_create_item(var_text.clone(),
			var_is_paged.clone()))
		if rt.is_true(var_is_paged) {
			var_breadcrumb_items.array_push(block_core_breadcrumbs_create_page_number_item(''))
		}
	} else if rt.is_true(rt.call_function('is_404', []rt.PhpVal{})) {
		var_breadcrumb_items.array_push(rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Page not found'),
			]) },
		]))
	} else if rt.is_true(rt.call_function('is_archive', []rt.PhpVal{})) {
		var_archive_breadcrumbs = block_core_breadcrumbs_get_archive_breadcrumbs()
		if !(!rt.is_true(var_archive_breadcrumbs)) {
			var_breadcrumb_items = rt.call_function('array_merge', [
				var_breadcrumb_items.clone(), var_archive_breadcrumbs.clone()])
		}
	} else {
		if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('postId')))
			|| !(rt.get_property(var_block, 'context').array_isset(rt.new_string('postType'))) {
			return ''
		}
		var_post_id = rt.get_property(var_block, 'context').array_get(rt.new_string('postId'))
		var_post_type = rt.get_property(var_block, 'context').array_get(rt.new_string('postType'))
		var_post = rt.call_function('get_post', [var_post_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
			return ''
		}
		var_post_parent = rt.get_property(var_post, 'post_parent')
		var_parent_post = rt.new_null()
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_post_type_hierarchical', [var_post_type.clone()])))))
			&& rt.is_true(var_post_parent) {
			var_parent_post = rt.call_function('get_post', [var_post_parent.clone()])
			if rt.is_true(var_parent_post) {
				var_post_id = rt.get_property(var_parent_post, 'ID')
				var_post_type = rt.get_property(var_parent_post, 'post_type')
				var_post_parent = rt.get_property(var_parent_post, 'post_parent')
			}
		}
		var_show_terms = rt.new_bool(false)
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_post_type_hierarchical', [var_post_type.clone()])))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_post_parent)))) {
			var_show_terms = rt.new_bool(true)
		} else if !rt.is_true(rt.call_function('get_object_taxonomies', [
			var_post_type.clone(), rt.new_string('objects')])) {
			var_show_terms = rt.new_bool(false)
		} else {
			var_show_terms = var_attributes.array_get(rt.new_string('prefersTaxonomy'))
		}
		var_post_type_object = rt.call_function('get_post_type_object', [
			var_post_type.clone()])
		var_archive_link = rt.call_function('get_post_type_archive_link', [
			var_post_type.clone()])
		if rt.is_true(var_archive_link)
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('untrailingslashit', [rt.call_function('home_url', []rt.PhpVal{})]), rt.call_function('untrailingslashit', [var_archive_link.clone()]))))) {
			var_label = rt.get_property(rt.get_property(var_post_type_object, 'labels'), 'archives')
			if rt.is_true(rt.identical(rt.new_string('post'), var_post_type))
				&& rt.is_true(var_page_for_posts) {
				var_label = block_core_breadcrumbs_get_post_title(var_page_for_posts.clone())
			}
			var_breadcrumb_items.array_push(rt.create_array([
				rt.ArrayItem{ key: 'label', val: var_label },
				rt.ArrayItem{ key: 'url', val: var_archive_link },
			]))
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_show_terms)))) {
			var_breadcrumb_items = rt.call_function('array_merge', [
				var_breadcrumb_items.clone(),
				block_core_breadcrumbs_get_hierarchical_post_type_breadcrumbs(var_post_id.clone())])
		} else {
			var_breadcrumb_items = rt.call_function('array_merge', [
				var_breadcrumb_items.clone(),
				block_core_breadcrumbs_get_terms_breadcrumbs(var_post_id.clone(),
					var_post_type.clone())])
		}
		var_is_paged = rt.new_bool(
			rt.new_int((rt.call_function('get_query_var', [rt.new_string('page')])).to_i64()) > 1
			|| rt.new_int((rt.call_function('get_query_var', [rt.new_string('cpage')])).to_i64()) > 1)
		var_title = block_core_breadcrumbs_get_post_title(var_post.clone())
		if rt.is_true(var_is_paged) {
			var_breadcrumb_items.array_push(rt.create_array([
				rt.ArrayItem{ key: 'label', val: var_title },
				rt.ArrayItem{ key: 'url', val: rt.call_function('get_permalink', [
					var_post.clone(),
				]) },
				rt.ArrayItem{ key: 'allow_html', val: true },
			]))
			var_breadcrumb_items.array_push(block_core_breadcrumbs_create_page_number_item(if rt.new_int((rt.call_function('get_query_var', [
				rt.new_string('cpage'),
			])).to_i64()) > 1 { 'cpage' } else { 'page' }))
		} else {
			var_breadcrumb_items.array_push(rt.create_array([
				rt.ArrayItem{ key: 'label', val: var_title },
				rt.ArrayItem{ key: 'allow_html', val: true },
			]))
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_attributes.array_get(rt.new_string('showCurrentItem'))))))
		&& !(!rt.is_true(var_breadcrumb_items)) {
		rt.call_function('array_pop', [var_breadcrumb_items.clone()])
	}
	var_breadcrumb_items = rt.call_function('apply_filters', [
		rt.new_string('block_core_breadcrumbs_items'),
		var_breadcrumb_items.clone(),
	])
	if !rt.is_true(var_breadcrumb_items) {
		return ''
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'style', val: '--separator: "' +
				(rt.call_function('addcslashes', [var_attributes.array_get(rt.new_string('separator')), rt.new_string('\\"')])).str() +
				'";' },
			rt.ArrayItem{ key: 'aria-label', val: rt.call_function('__', [
				rt.new_string('Breadcrumbs'),
			]) },
		]),
	])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_label := if !(!rt.is_true(var_item.array_get(rt.new_string('allow_html')))) { rt.call_function('wp_kses_post', [
				var_item.array_get(rt.new_string('label')),
			]) } else { rt.call_function('esc_html', [
				var_item.array_get(rt.new_string('label')),
			]) }
		if !(!rt.is_true(var_item.array_get(rt.new_string('url')))) {
			return '<li><a href="' +
				(rt.call_function('esc_url', [var_item.array_get(rt.new_string('url'))])).str() +
				'">' + var_label.str() + '</a></li>'
		}
		return '<li><span aria-current="page">' + var_label.str() + '</span></li>'
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_label := if !(!rt.is_true(var_item.array_get(rt.new_string('allow_html')))) { rt.call_function('wp_kses_post', [
				var_item.array_get(rt.new_string('label')),
			]) } else { rt.call_function('esc_html', [
				var_item.array_get(rt.new_string('label')),
			]) }
		if !(!rt.is_true(var_item.array_get(rt.new_string('url')))) {
			return '<li><a href="' +
				(rt.call_function('esc_url', [var_item.array_get(rt.new_string('url'))])).str() +
				'">' + var_label.str() + '</a></li>'
		}
		return '<li><span aria-current="page">' + var_label.str() + '</span></li>'
	}
	var_breadcrumb_html = rt.call_function('sprintf', [
		rt.new_string('<nav %s><ol>%s</ol></nav>'),
		var_wrapper_attributes.clone(),
		rt.call_function('implode', [rt.new_string(''),
			rt.call_function('array_map', [rt.new_closure(closure_1_fn),
				var_breadcrumb_items.clone()])]),
	])
	return var_breadcrumb_html.str()
}

fn block_core_breadcrumbs_is_paged() rt.PhpVal {
	mut var_paged := rt.new_null()
	var_paged = rt.new_int((rt.call_function('get_query_var', [
		rt.new_string('paged')])).to_i64())
	return rt.greater(var_paged, rt.new_int(1))
}

fn block_core_breadcrumbs_create_page_number_item(query_var string) rt.PhpVal {
	mut var_query_var := query_var
	mut var_paged := rt.new_null()
	var_paged = rt.new_int((rt.call_function('get_query_var', [
		rt.new_string(query_var)])).to_i64())
	if rt.is_true(rt.identical(rt.new_string('cpage'), rt.new_string(query_var))) {
		return rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Comments Page %s')]),
				rt.call_function('number_format_i18n', [var_paged.clone()]),
			]) },
		])
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Page %s')]),
			rt.call_function('number_format_i18n', [var_paged.clone()]),
		]) },
	])
}

fn block_core_breadcrumbs_create_item(var_text rt.PhpVal, is_paged bool) rt.PhpVal {
	mut var_is_paged := is_paged
	mut var_item := map[string]rt.PhpVal{}
	var_item = {
		'label': var_text
	}
	if var_is_paged {
		var_item['url'] = rt.call_function('get_pagenum_link', [
			rt.new_int(1)])
	}
	return var_item.clone()
}

fn block_core_breadcrumbs_get_post_title(var_post_id_or_object rt.PhpVal) rt.PhpVal {
	mut var_title := rt.new_null()
	var_title = rt.call_function('get_the_title', [var_post_id_or_object.clone()])
	if var_title.clone().to_string().len == 0 {
		var_title = rt.call_function('__', [rt.new_string('(no title)')])
	}
	return var_title.clone()
}

fn block_core_breadcrumbs_get_hierarchical_post_type_breadcrumbs(var_post_id rt.PhpVal) rt.PhpVal {
	mut var_breadcrumb_items := rt.new_null()
	mut var_ancestors := rt.new_null()
	mut var_ancestor_id := rt.new_null()
	var_breadcrumb_items = rt.new_array()
	var_ancestors = rt.call_function('get_post_ancestors', [var_post_id.clone()])
	var_ancestors = rt.call_function('array_reverse', [var_ancestors.clone()])
	mut iter_1 := var_ancestors.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_ancestor_id_shadow := item_1.val
		var_breadcrumb_items.array_push(rt.create_array([
			rt.ArrayItem{
				key: 'label'
				val: block_core_breadcrumbs_get_post_title(var_ancestor_id_shadow.clone())
			},
			rt.ArrayItem{ key: 'url', val: rt.call_function('get_permalink', [
				var_ancestor_id_shadow.clone()]) },
			rt.ArrayItem{ key: 'allow_html', val: true },
		]))
	}
	return var_breadcrumb_items.clone()
}

fn block_core_breadcrumbs_get_term_ancestors_items(var_term_id rt.PhpVal, var_taxonomy rt.PhpVal) rt.PhpVal {
	mut var_breadcrumb_items := rt.new_null()
	mut var_term_ancestors := rt.new_null()
	mut var_ancestor_id := rt.new_null()
	mut var_ancestor_term := rt.new_null()
	var_breadcrumb_items = rt.new_array()
	if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [
		var_taxonomy.clone()]))
	{
		var_term_ancestors = rt.call_function('get_ancestors', [
			var_term_id.clone(), var_taxonomy.clone(), rt.new_string('taxonomy')])
		var_term_ancestors = rt.call_function('array_reverse', [
			var_term_ancestors.clone()])
		mut iter_2 := var_term_ancestors.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_ancestor_id_shadow := item_2.val
			var_ancestor_term = rt.call_function('get_term', [
				var_ancestor_id_shadow.clone(), var_taxonomy.clone()])
			if rt.is_true(var_ancestor_term)
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_ancestor_term.clone()]))))) {
				var_breadcrumb_items.array_push(rt.create_array([
					rt.ArrayItem{ key: 'label', val: rt.get_property(var_ancestor_term, 'name') },
					rt.ArrayItem{ key: 'url', val: rt.call_function('get_term_link', [
						var_ancestor_term.clone(),
					]) },
				]))
			}
		}
	}
	return var_breadcrumb_items.clone()
}

fn block_core_breadcrumbs_get_archive_breadcrumbs() rt.PhpVal {
	mut var_breadcrumb_items := rt.new_null()
	mut var_year := rt.new_null()
	mut var_month := rt.new_null()
	mut var_day := rt.new_null()
	mut var_m := rt.new_null()
	mut var_is_paged := rt.new_null()
	mut var_queried_object := rt.new_null()
	mut var_term := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_post_type := rt.new_null()
	mut var_post_type_object := rt.new_null()
	mut var_title := rt.new_null()
	mut var_author := rt.new_null()
	var_breadcrumb_items = rt.new_array()
	if rt.is_true(rt.call_function('is_date', []rt.PhpVal{})) {
		var_year = rt.call_function('get_query_var', [rt.new_string('year')])
		var_month = rt.call_function('get_query_var', [rt.new_string('monthnum')])
		var_day = rt.call_function('get_query_var', [rt.new_string('day')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_year)))) {
			var_m = rt.call_function('get_query_var', [rt.new_string('m')])
			if rt.is_true(var_m) {
				var_year = rt.call_function('substr', [var_m.clone(),
					rt.new_int(0), rt.new_int(4)])
				var_month = rt.call_function('substr', [var_m.clone(),
					rt.new_int(4), rt.new_int(2)])
				var_day = rt.new_int((rt.call_function('substr', [
					var_m.clone(), rt.new_int(6), rt.new_int(2)])).to_i64())
			}
		}
		var_is_paged = block_core_breadcrumbs_is_paged()
		if rt.is_true(var_year) {
			if rt.is_true(var_month) {
				var_breadcrumb_items.array_push(rt.create_array([
					rt.ArrayItem{ key: 'label', val: var_year },
					rt.ArrayItem{ key: 'url', val: rt.call_function('get_year_link', [
						var_year.clone(),
					]) },
				]))
				if rt.is_true(var_day) {
					var_breadcrumb_items.array_push(rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('date_i18n', [
							rt.new_string('F'),
							rt.call_function('mktime', [rt.new_int(0),
								rt.new_int(0), rt.new_int(0),
								var_month.clone(), rt.new_int(1),
								var_year.clone()]),
						]) },
						rt.ArrayItem{ key: 'url', val: rt.call_function('get_month_link', [
							var_year.clone(),
							var_month.clone(),
						]) },
					]))
					var_breadcrumb_items.array_push(block_core_breadcrumbs_create_item(var_day.clone(),
						var_is_paged.clone()))
				} else {
					var_breadcrumb_items.array_push(block_core_breadcrumbs_create_item(rt.call_function('date_i18n', [
						rt.new_string('F'),
						rt.call_function('mktime', [rt.new_int(0),
							rt.new_int(0), rt.new_int(0), var_month.clone(),
							rt.new_int(1), var_year.clone()]),
					]), var_is_paged.clone()))
				}
			} else {
				var_breadcrumb_items.array_push(block_core_breadcrumbs_create_item(var_year.clone(),
					var_is_paged.clone()))
			}
		}
		if rt.is_true(var_is_paged) {
			var_breadcrumb_items.array_push(block_core_breadcrumbs_create_page_number_item(''))
		}
		return var_breadcrumb_items.clone()
	}
	var_queried_object = rt.call_function('get_queried_object', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_queried_object)))) {
		return rt.new_array()
	}
	var_is_paged = block_core_breadcrumbs_is_paged()
	if rt.is_true(rt.new_bool(rt.instance_of(var_queried_object, 'WP_Term'))) {
		var_term = var_queried_object.clone()
		var_taxonomy = rt.get_property(var_term, 'taxonomy')
		var_breadcrumb_items = rt.call_function('array_merge', [
			var_breadcrumb_items.clone(),
			block_core_breadcrumbs_get_term_ancestors_items(rt.get_property(var_term,
				'term_id'), var_taxonomy.clone())])
		var_breadcrumb_items.array_push(block_core_breadcrumbs_create_item(rt.get_property(var_term,
			'name'), var_is_paged.clone()))
	} else if rt.is_true(rt.call_function('is_post_type_archive', []rt.PhpVal{})) {
		var_post_type = rt.call_function('get_query_var', [rt.new_string('post_type')])
		if rt.is_true(rt.new_bool(var_post_type.clone().is_array())) {
			var_post_type = rt.call_function('reset', [var_post_type.clone()])
		}
		var_post_type_object = rt.call_function('get_post_type_object', [
			var_post_type.clone()])
		var_title = rt.call_function('apply_filters', [
			rt.new_string('post_type_archive_title'),
			rt.get_property(rt.get_property(var_post_type_object, 'labels'), 'archives'),
			var_post_type.clone(),
		])
		if rt.is_true(var_post_type_object) {
			var_breadcrumb_items.array_push(block_core_breadcrumbs_create_item(if rt.is_true(var_title) {
				var_title
			} else {
				rt.get_property(rt.get_property(var_post_type_object, 'labels'), 'archives')
			}, var_is_paged.clone()))
		}
	} else if rt.is_true(rt.call_function('is_author', []rt.PhpVal{})) {
		var_author = var_queried_object.clone()
		var_breadcrumb_items.array_push(block_core_breadcrumbs_create_item(rt.get_property(var_author,
			'display_name'), var_is_paged.clone()))
	}
	if rt.is_true(var_is_paged) {
		var_breadcrumb_items.array_push(block_core_breadcrumbs_create_page_number_item(''))
	}
	return var_breadcrumb_items.clone()
}

fn block_core_breadcrumbs_get_terms_breadcrumbs(var_post_id rt.PhpVal, var_post_type rt.PhpVal) rt.PhpVal {
	mut var_breadcrumb_items := rt.new_null()
	mut var_taxonomies := rt.new_null()
	mut var_settings := rt.new_null()
	mut var_taxonomy_name := rt.new_null()
	mut var_terms := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_post_terms := rt.new_null()
	mut var_term := rt.new_null()
	mut var_candidate_term := rt.new_null()
	var_breadcrumb_items = rt.new_array()
	var_taxonomies = rt.call_function('wp_filter_object_list', [
		rt.call_function('get_object_taxonomies', [var_post_type.clone(),
			rt.new_string('objects')]),
		rt.create_array([rt.ArrayItem{ key: 'publicly_queryable', val: true },
			rt.ArrayItem{ key: 'show_in_rest', val: true }]),
	])
	if !rt.is_true(var_taxonomies) {
		return var_breadcrumb_items.clone()
	}
	var_settings = rt.call_function('apply_filters', [
		rt.new_string('block_core_breadcrumbs_post_type_settings'),
		rt.new_array(),
		var_post_type.clone(),
		var_post_id.clone(),
	])
	var_taxonomy_name = rt.new_null()
	var_terms = rt.new_array()
	if !(!rt.is_true(var_settings.array_get(rt.new_string('taxonomy')))) {
		mut iter_3 := var_taxonomies.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_taxonomy_shadow := item_3.val
			if rt.is_true(rt.identical(rt.get_property(var_taxonomy_shadow, 'name'),
				var_settings.array_get(rt.new_string('taxonomy'))))
			{
				var_post_terms = rt.call_function('get_the_terms', [
					var_post_id.clone(), rt.get_property(var_taxonomy_shadow, 'name')])
				if !(!rt.is_true(var_post_terms))
					&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_post_terms.clone()]))))) {
					var_taxonomy_name = rt.get_property(var_taxonomy_shadow, 'name')
					var_terms = var_post_terms.clone()
				}
				break
			}
		}
	}
	if !rt.is_true(var_terms) {
		mut iter_4 := var_taxonomies.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_taxonomy_shadow := item_4.val
			var_post_terms = rt.call_function('get_the_terms', [
				var_post_id.clone(), rt.get_property(var_taxonomy_shadow, 'name')])
			if !(!rt.is_true(var_post_terms))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_post_terms.clone()]))))) {
				var_taxonomy_name = rt.get_property(var_taxonomy_shadow, 'name')
				var_terms = var_post_terms.clone()
				break
			}
		}
	}
	if !(!rt.is_true(var_terms)) {
		var_term = rt.call_function('reset', [var_terms.clone()])
		if !(!rt.is_true(var_settings.array_get(rt.new_string('term'))))
			&& var_terms.clone().array_count() > 1 {
			mut iter_5 := var_terms.iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_candidate_term_shadow := item_5.val
				if rt.is_true(rt.identical(rt.get_property(var_candidate_term_shadow, 'slug'),
					var_settings.array_get(rt.new_string('term'))))
				{
					var_term = var_candidate_term_shadow
					break
				}
			}
		}
		var_breadcrumb_items = rt.call_function('array_merge', [
			var_breadcrumb_items.clone(),
			block_core_breadcrumbs_get_term_ancestors_items(rt.get_property(var_term,
				'term_id'), var_taxonomy_name.clone())])
		var_breadcrumb_items.array_push(rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.get_property(var_term, 'name') },
			rt.ArrayItem{ key: 'url', val: rt.call_function('get_term_link', [
				var_term.clone()]) },
		]))
	}
	return var_breadcrumb_items.clone()
}

fn register_block_core_breadcrumbs() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/breadcrumbs'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_breadcrumbs' },
		]),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_breadcrumbs')])
}
