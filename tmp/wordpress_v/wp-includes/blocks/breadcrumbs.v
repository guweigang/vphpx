import rt

fn render_block_core_breadcrumbs(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_is_front_page := rt.call_function('is_front_page', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_attributes.array_get('showOnHomePage'))))) && rt.is_true(var_is_front_page))) {
		return ''
	}
	mut var_is_home := rt.call_function('is_home', []rt.PhpVal{})
	mut var_page_for_posts := rt.call_function('get_option', [rt.new_string('page_for_posts')])
	mut var_breadcrumb_items := rt.new_array()
	if rt.is_true(var_attributes.array_get('showHomeItem')) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_is_front_page)))) || rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')]))) && rt.is_true(rt.greater(// unsupported expression: Expr_Cast_Int, rt.new_int(1))))))) {
			var_breadcrumb_items.array_push(rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Home')]) }, rt.ArrayItem{ key: 'url', val: rt.call_function('home_url', [rt.new_string('/')]) }]))
		} else {
			var_breadcrumb_items.array_push(block_core_breadcrumbs_create_item(rt.call_function('__', [rt.new_string('Home')]), block_core_breadcrumbs_is_paged()))
		}
	}
	if rt.is_true(var_is_home) {
		if rt.is_true(var_page_for_posts) {
			var_breadcrumb_items.array_push(block_core_breadcrumbs_create_item(block_core_breadcrumbs_get_post_title(var_page_for_posts.dup()), block_core_breadcrumbs_is_paged()))
		}
		if rt.is_true(block_core_breadcrumbs_is_paged()) {
			var_breadcrumb_items.array_push(block_core_breadcrumbs_create_page_number_item(''))
		}
	} else if rt.is_true(var_is_front_page) {
		if rt.is_true(rt.greater(// unsupported expression: Expr_Cast_Int, rt.new_int(1))) {
			var_breadcrumb_items.array_push(block_core_breadcrumbs_create_page_number_item('page'))
		}
	} else if rt.is_true(rt.call_function('is_search', []rt.PhpVal{})) {
		mut var_is_paged := block_core_breadcrumbs_is_paged()
		mut var_text := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Search results for: "%s"')]), rt.call_function('wp_trim_words', [rt.call_function('get_search_query', []rt.PhpVal{}), rt.new_int(10)])])
		var_breadcrumb_items.array_push(block_core_breadcrumbs_create_item(var_text.dup(), var_is_paged.dup()))
		if rt.is_true(var_is_paged) {
			var_breadcrumb_items.array_push(block_core_breadcrumbs_create_page_number_item(''))
		}
	} else if rt.is_true(rt.call_function('is_404', []rt.PhpVal{})) {
		var_breadcrumb_items.array_push(rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Page not found')]) }]))
	} else if rt.is_true(rt.call_function('is_archive', []rt.PhpVal{})) {
		mut var_archive_breadcrumbs := block_core_breadcrumbs_get_archive_breadcrumbs()
		if !(!rt.is_true(var_archive_breadcrumbs)) {
			var_breadcrumb_items = rt.call_function('array_merge', [var_breadcrumb_items.dup(), var_archive_breadcrumbs.dup()])
		}
	} else {
		if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('postId'))) || !(rt.get_property(var_block, 'context').array_isset(rt.new_string('postType'))) {
			return ''
		}
		mut var_post_id := rt.get_property(var_block, 'context').array_get('postId')
		mut var_post_type := rt.get_property(var_block, 'context').array_get('postType')
		mut var_post := rt.call_function('get_post', [var_post_id.dup()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
			return ''
		}
		mut var_post_parent := rt.get_property(var_post, 'post_parent')
		mut var_parent_post := rt.new_null()
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_post_type_hierarchical', [var_post_type.dup()]))))) && rt.is_true(var_post_parent))) {
			var_parent_post = rt.call_function('get_post', [var_post_parent.dup()])
			if rt.is_true(var_parent_post) {
				var_post_id = rt.get_property(var_parent_post, 'ID')
				var_post_type = rt.get_property(var_parent_post, 'post_type')
				var_post_parent = rt.get_property(var_parent_post, 'post_parent')
			}
		}
		mut var_show_terms := rt.new_bool(rt.new_bool(false))
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_post_type_hierarchical', [var_post_type.dup()]))))) && rt.is_true(rt.new_bool(!(rt.is_true(var_post_parent)))))) {
			var_show_terms = rt.new_bool(rt.new_bool(true))
		} else if !rt.is_true(rt.call_function('get_object_taxonomies', [var_post_type.dup(), rt.new_string('objects')])) {
			var_show_terms = rt.new_bool(rt.new_bool(false))
		} else {
			var_show_terms = var_attributes.array_get('prefersTaxonomy')
		}
		mut var_post_type_object := rt.call_function('get_post_type_object', [var_post_type.dup()])
		mut var_archive_link := rt.call_function('get_post_type_archive_link', [var_post_type.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(var_archive_link) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			mut var_label := rt.get_property(rt.get_property(var_post_type_object, 'labels'), 'archives')
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('post'), var_post_type)) && rt.is_true(var_page_for_posts))) {
				var_label = block_core_breadcrumbs_get_post_title(var_page_for_posts.dup())
			}
			var_breadcrumb_items.array_push(rt.create_array([rt.ArrayItem{ key: 'label', val: var_label }, rt.ArrayItem{ key: 'url', val: var_archive_link }]))
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_show_terms)))) {
			var_breadcrumb_items = rt.call_function('array_merge', [var_breadcrumb_items.dup(), block_core_breadcrumbs_get_hierarchical_post_type_breadcrumbs(var_post_id.dup())])
		} else {
			var_breadcrumb_items = rt.call_function('array_merge', [var_breadcrumb_items.dup(), block_core_breadcrumbs_get_terms_breadcrumbs(var_post_id.dup(), var_post_type.dup())])
		}
		var_is_paged = rt.new_bool(rt.new_bool(rt.is_true(rt.greater(// unsupported expression: Expr_Cast_Int, rt.new_int(1))) || rt.is_true(rt.greater(// unsupported expression: Expr_Cast_Int, rt.new_int(1)))))
		mut var_title := block_core_breadcrumbs_get_post_title(var_post.dup())
		if rt.is_true(var_is_paged) {
			var_breadcrumb_items.array_push(rt.create_array([rt.ArrayItem{ key: 'label', val: var_title }, rt.ArrayItem{ key: 'url', val: rt.call_function('get_permalink', [var_post.dup()]) }, rt.ArrayItem{ key: 'allow_html', val: true }]))
			var_breadcrumb_items.array_push(block_core_breadcrumbs_create_page_number_item(if rt.is_true(rt.greater(// unsupported expression: Expr_Cast_Int, rt.new_int(1))) { 'cpage' } else { 'page' }))
		} else {
			var_breadcrumb_items.array_push(rt.create_array([rt.ArrayItem{ key: 'label', val: var_title }, rt.ArrayItem{ key: 'allow_html', val: true }]))
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_attributes.array_get('showCurrentItem'))))) && !(!rt.is_true(var_breadcrumb_items)))) {
		rt.call_function('array_pop', [var_breadcrumb_items.dup()])
	}
	var_breadcrumb_items = rt.call_function('apply_filters', [rt.new_string('block_core_breadcrumbs_items'), var_breadcrumb_items.dup()])
	if !rt.is_true(var_breadcrumb_items) {
		return ''
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [rt.create_array([rt.ArrayItem{ key: 'style', val: '--separator: "' + (rt.call_function('addcslashes', [var_attributes.array_get('separator'), rt.new_string('\\"')])).str() + '";' }, rt.ArrayItem{ key: 'aria-label', val: rt.call_function('__', [rt.new_string('Breadcrumbs')]) }])])
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_label := if !(!rt.is_true(var_item.array_get('allow_html'))) { rt.call_function('wp_kses_post', [var_item.array_get('label')]) } else { rt.call_function('esc_html', [var_item.array_get('label')]) }
	if !(!rt.is_true(var_item.array_get('url'))) {
		return '<li><a href="' + (rt.call_function('esc_url', [var_item.array_get('url')])).str() + '">' + (var_label).str() + '</a></li>'
	}
	return '<li><span aria-current="page">' + (var_label).str() + '</span></li>'
	}
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_label := if !(!rt.is_true(var_item.array_get('allow_html'))) { rt.call_function('wp_kses_post', [var_item.array_get('label')]) } else { rt.call_function('esc_html', [var_item.array_get('label')]) }
	if !(!rt.is_true(var_item.array_get('url'))) {
		return '<li><a href="' + (rt.call_function('esc_url', [var_item.array_get('url')])).str() + '">' + (var_label).str() + '</a></li>'
	}
	return '<li><span aria-current="page">' + (var_label).str() + '</span></li>'
	}
	mut var_breadcrumb_html := rt.call_function('sprintf', [rt.new_string('<nav %s><ol>%s</ol></nav>'), var_wrapper_attributes.dup(), rt.call_function('implode', [rt.new_string(''), rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_breadcrumb_items.dup()])])])
	return (var_breadcrumb_html).str()
}

fn block_core_breadcrumbs_is_paged() rt.PhpVal {
	mut var_paged := // unsupported expression: Expr_Cast_Int
	return rt.greater(var_paged, rt.new_int(1))
}

fn block_core_breadcrumbs_create_page_number_item(query_var string) rt.PhpVal {
	mut var_paged := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.identical(rt.new_string('cpage'), rt.new_string(query_var))) {
		return rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Comments Page %s')]), rt.call_function('number_format_i18n', [var_paged.dup()])]) }])
	}
	return rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Page %s')]), rt.call_function('number_format_i18n', [var_paged.dup()])]) }])
}

fn block_core_breadcrumbs_create_item(var_text rt.PhpVal, is_paged bool) rt.PhpVal {
	mut var_item := { 'label': var_text }
	if var_is_paged {
		var_item['url'] = rt.call_function('get_pagenum_link', [rt.new_int(1)])
	}
	return var_item.dup()
}

fn block_core_breadcrumbs_get_post_title(var_post_id_or_object rt.PhpVal) rt.PhpVal {
	mut var_title := rt.call_function('get_the_title', [var_post_id_or_object.dup()])
	if var_title.dup().to_string().len == 0 {
		var_title = rt.call_function('__', [rt.new_string('(no title)')])
	}
	return var_title.dup()
}

fn block_core_breadcrumbs_get_hierarchical_post_type_breadcrumbs(var_post_id rt.PhpVal) rt.PhpVal {
	mut var_breadcrumb_items := rt.new_array()
	mut var_ancestors := rt.call_function('get_post_ancestors', [var_post_id.dup()])
	var_ancestors = rt.call_function('array_reverse', [var_ancestors.dup()])
	{
		mut iter_1 := var_ancestors.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_ancestor_id := item_1.val
			var_breadcrumb_items.array_push(rt.create_array([rt.ArrayItem{ key: 'label', val: block_core_breadcrumbs_get_post_title(var_ancestor_id.dup()) }, rt.ArrayItem{ key: 'url', val: rt.call_function('get_permalink', [var_ancestor_id.dup()]) }, rt.ArrayItem{ key: 'allow_html', val: true }]))
		}
	}
	return var_breadcrumb_items.dup()
}

fn block_core_breadcrumbs_get_term_ancestors_items(var_term_id rt.PhpVal, var_taxonomy rt.PhpVal) rt.PhpVal {
	mut var_breadcrumb_items := rt.new_array()
	if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [var_taxonomy.dup()])) {
		mut var_term_ancestors := rt.call_function('get_ancestors', [var_term_id.dup(), var_taxonomy.dup(), rt.new_string('taxonomy')])
		var_term_ancestors = rt.call_function('array_reverse', [var_term_ancestors.dup()])
		{
			mut iter_1 := var_term_ancestors.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_ancestor_id := item_1.val
				mut var_ancestor_term := rt.call_function('get_term', [var_ancestor_id.dup(), var_taxonomy.dup()])
				if rt.is_true(rt.new_bool(rt.is_true(var_ancestor_term) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_ancestor_term.dup()]))))))) {
					var_breadcrumb_items.array_push(rt.create_array([rt.ArrayItem{ key: 'label', val: rt.get_property(var_ancestor_term, 'name') }, rt.ArrayItem{ key: 'url', val: rt.call_function('get_term_link', [var_ancestor_term.dup()]) }]))
				}
			}
		}
	}
	return var_breadcrumb_items.dup()
}

fn block_core_breadcrumbs_get_archive_breadcrumbs() rt.PhpVal {
	mut var_breadcrumb_items := rt.new_array()
	if rt.is_true(rt.call_function('is_date', []rt.PhpVal{})) {
		mut var_year := rt.call_function('get_query_var', [rt.new_string('year')])
		mut var_month := rt.call_function('get_query_var', [rt.new_string('monthnum')])
		mut var_day := rt.call_function('get_query_var', [rt.new_string('day')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_year)))) {
			mut var_m := rt.call_function('get_query_var', [rt.new_string('m')])
			if rt.is_true(var_m) {
				var_year = rt.call_function('substr', [var_m.dup(), rt.new_int(0), rt.new_int(4)])
				var_month = rt.call_function('substr', [.dup(), , ])
				var_day = 
			}
		}
		mut var_is_paged := block_core_breadcrumbs_is_paged()
		if rt.is_true(var_year) {
			if rt.is_true() {
			} else {
			}
		}
		if rt.is_true(var_is_paged) {
			
		}
		return .dup()
	}
	
}



pub fn init_wp_includes_blocks_breadcrumbs_php() {
}
