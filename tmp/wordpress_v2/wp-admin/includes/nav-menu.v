import rt

fn _wp_ajax_menu_quick_search(var_request rt.PhpVal) {
	mut var_matches := []rt.PhpVal{}
	mut var_args := rt.new_null()
	mut var_type := rt.new_null()
	mut var_object_type := rt.new_null()
	mut var_query := rt.new_null()
	mut var_response_format := rt.new_null()
	mut var_object_id := rt.new_null()
	mut var_post_obj := rt.new_null()
	mut var_post_type_obj := rt.new_null()
	mut var_query_args := rt.new_null()
	mut var_search_results_query := rt.new_null()
	mut var_post := rt.new_null()
	mut var_var_by_ref := rt.new_null()
	mut var_terms := rt.new_null()
	mut var_term := rt.new_null()
	var_args = rt.new_array()
	var_type = if !(var_request.array_get(rt.new_string('type'))).is_null() { var_request.array_get(rt.new_string('type')) } else { rt.new_string('') }
	var_object_type = if !(var_request.array_get(rt.new_string('object_type'))).is_null() { var_request.array_get(rt.new_string('object_type')) } else { rt.new_string('') }
	var_query = if !(var_request.array_get(rt.new_string('q'))).is_null() { var_request.array_get(rt.new_string('q')) } else { rt.new_string('') }
	var_response_format = if !(var_request.array_get(rt.new_string('response-format'))).is_null() { var_request.array_get(rt.new_string('response-format')) } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_response_format)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_response_format.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'json' }, rt.ArrayItem{ key: none, val: 'markup' }]), rt.new_bool(true)]))))) {
	var_response_format = rt.new_string('json')
	}
	if rt.is_true(rt.identical(rt.new_string('markup'), var_response_format)) {
		var_args.array_set('walker', create_walker_nav_menu_checklist())
	}
	if rt.is_true(rt.identical(rt.new_string('get-post-item'), var_type)) {
		if rt.is_true(rt.call_function('post_type_exists', [var_object_type.clone()])) {
			if var_request.array_isset(rt.new_string('ID')) {
				var_object_id = rt.new_int((var_request.array_get(rt.new_string('ID'))).to_i64())
				if rt.is_true(rt.identical(rt.new_string('markup'), var_response_format)) {
					rt.echo_val(rt.call_function('walk_nav_menu_tree', [rt.call_function('array_map', [rt.new_string('wp_setup_nav_menu_item'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('get_post', [var_object_id.clone()]) }])]), rt.new_int(0), rt.array_to_object(var_args)]))
				} else if rt.is_true(rt.identical(rt.new_string('json'), var_response_format)) {
					rt.echo_val(rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'ID', val: var_object_id }, rt.ArrayItem{ key: 'post_title', val: rt.call_function('get_the_title', [var_object_id.clone()]) }, rt.ArrayItem{ key: 'post_type', val: rt.call_function('get_post_type', [var_object_id.clone()]) }])]))
					print('\n')
				}
			}
		} else if rt.is_true(rt.call_function('taxonomy_exists', [var_object_type.clone()])) {
			if var_request.array_isset(rt.new_string('ID')) {
				var_object_id = rt.new_int((var_request.array_get(rt.new_string('ID'))).to_i64())
				if rt.is_true(rt.identical(rt.new_string('markup'), var_response_format)) {
					rt.echo_val(rt.call_function('walk_nav_menu_tree', [rt.call_function('array_map', [rt.new_string('wp_setup_nav_menu_item'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('get_term', [var_object_id.clone(), var_object_type.clone()]) }])]), rt.new_int(0), rt.array_to_object(var_args)]))
				} else if rt.is_true(rt.identical(rt.new_string('json'), var_response_format)) {
					var_post_obj = rt.call_function('get_term', [var_object_id.clone(), var_object_type.clone()])
					rt.echo_val(rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'ID', val: var_object_id }, rt.ArrayItem{ key: 'post_title', val: rt.get_property(var_post_obj, 'name') }, rt.ArrayItem{ key: 'post_type', val: var_object_type }])]))
					print('\n')
				}
			}
		}
	} else if rt.is_true(rt.call_function('preg_match', [rt.new_string('/quick-search-(posttype|taxonomy)-([a-zA-Z0-9_-]*\\b)/'), var_type.clone(), rt.create_array_from_list(var_matches)])) {
		if rt.is_true(rt.identical(rt.new_string('posttype'), var_matches[1])) && rt.is_true(rt.call_function('get_post_type_object', [var_matches[2]])) {
			var_post_type_obj = _wp_nav_menu_meta_box_object(rt.call_function('get_post_type_object', [var_matches[2]]))
			var_query_args = rt.create_array([rt.ArrayItem{ key: 'no_found_rows', val: true }, rt.ArrayItem{ key: 'update_post_meta_cache', val: false }, rt.ArrayItem{ key: 'update_post_term_cache', val: false }, rt.ArrayItem{ key: 'posts_per_page', val: 10 }, rt.ArrayItem{ key: 'post_type', val: var_matches[2] }, rt.ArrayItem{ key: 's', val: var_query }, rt.ArrayItem{ key: 'search_columns', val: rt.create_array([rt.ArrayItem{ key: none, val: 'post_title' }]) }])
			var_query_args = rt.call_function('apply_filters', [rt.new_string('wp_ajax_menu_quick_search_args'), var_query_args.clone()])
			var_args = rt.call_function('array_merge', [var_args.clone(), var_query_args.clone()])
			if !(rt.get_property(var_post_type_obj, '_default_query')).is_null() {
			var_args = rt.call_function('array_merge', [var_args.clone(), rt.cast_array(rt.get_property(var_post_type_obj, '_default_query'))])
			}
			var_search_results_query = create_wp_query(var_args.clone())
			if rt.is_true(rt.new_bool(!(rt.is_true(var_search_results_query.have_posts())))) {
				return
			}
			for rt.is_true(var_search_results_query.have_posts()) {
				var_post = var_search_results_query.next_post()
				if rt.is_true(rt.identical(rt.new_string('markup'), var_response_format)) {
					var_var_by_ref = rt.get_property(var_post, 'ID')
					rt.echo_val(rt.call_function('walk_nav_menu_tree', [rt.call_function('array_map', [rt.new_string('wp_setup_nav_menu_item'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('get_post', [var_var_by_ref.clone()]) }])]), rt.new_int(0), rt.array_to_object(var_args)]))
				} else if rt.is_true(rt.identical(rt.new_string('json'), var_response_format)) {
					rt.echo_val(rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.get_property(var_post, 'ID') }, rt.ArrayItem{ key: 'post_title', val: rt.call_function('get_the_title', [rt.get_property(var_post, 'ID')]) }, rt.ArrayItem{ key: 'post_type', val: var_matches[2] }])]))
					print('\n')
				}
			}
		} else if rt.is_true(rt.identical(rt.new_string('taxonomy'), var_matches[1])) {
			var_terms = rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_matches[2] }, rt.ArrayItem{ key: 'name__like', val: var_query }, rt.ArrayItem{ key: 'number', val: 10 }, rt.ArrayItem{ key: 'hide_empty', val: false }])])
			if !rt.is_true(var_terms) || rt.is_true(rt.call_function('is_wp_error', [var_terms.clone()])) {
				return
			}
			mut iter_1 := rt.cast_array(var_terms).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_term_shadow := item_1.val
				if rt.is_true(rt.identical(rt.new_string('markup'), var_response_format)) {
					rt.echo_val(rt.call_function('walk_nav_menu_tree', [rt.call_function('array_map', [rt.new_string('wp_setup_nav_menu_item'), rt.create_array([rt.ArrayItem{ key: none, val: var_term_shadow }])]), rt.new_int(0), rt.array_to_object(var_args)]))
				} else if rt.is_true(rt.identical(rt.new_string('json'), var_response_format)) {
					rt.echo_val(rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.get_property(var_term_shadow, 'term_id') }, rt.ArrayItem{ key: 'post_title', val: rt.get_property(var_term_shadow, 'name') }, rt.ArrayItem{ key: 'post_type', val: var_matches[2] }])]))
					print('\n')
				}
			}
		}
	}
}

fn wp_nav_menu_setup() {
	mut var_user := rt.new_null()
	wp_nav_menu_post_type_meta_boxes()
	rt.call_function('add_meta_box', [rt.new_string('add-custom-links'), rt.call_function('__', [rt.new_string('Custom Links')]), rt.new_string('wp_nav_menu_item_link_meta_box'), rt.new_string('nav-menus'), rt.new_string('side'), rt.new_string('default')])
	wp_nav_menu_taxonomy_meta_boxes()
	rt.call_function('add_filter', [rt.new_string('manage_nav-menus_columns'), rt.new_string('wp_nav_menu_manage_columns')])
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('get_user_option', [rt.new_string('managenav-menuscolumnshidden')]))) {
		var_user = rt.call_function('wp_get_current_user', []rt.PhpVal{})
		rt.call_function('update_user_meta', [rt.get_property(var_user, 'ID'), rt.new_string('managenav-menuscolumnshidden'), rt.create_array([rt.ArrayItem{ key: 0, val: 'link-target' }, rt.ArrayItem{ key: 1, val: 'css-classes' }, rt.ArrayItem{ key: 2, val: 'xfn' }, rt.ArrayItem{ key: 3, val: 'description' }, rt.ArrayItem{ key: 4, val: 'title-attribute' }])])
	}
}

fn wp_initial_nav_menu_meta_boxes() {
	mut var_wp_meta_boxes := map[string]rt.PhpVal{}
	mut var_initial_meta_boxes := []rt.PhpVal{}
	mut var_hidden_meta_boxes := []rt.PhpVal{}
	mut var_context := rt.new_null()
	mut var_priority := rt.new_null()
	mut var_box := map[string]rt.PhpVal{}
	mut var_user := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_user_option', [rt.new_string('metaboxhidden_nav-menus')]), rt.new_bool(false))))) || !(rt.create_array_from_native_map(var_wp_meta_boxes).is_array()) {
		return
	}
	var_initial_meta_boxes = ['add-post-type-page', 'add-post-type-post', 'add-custom-links', 'add-category']
	var_hidden_meta_boxes = rt.new_array()
	mut iter_2 := rt.func_array_keys(var_wp_meta_boxes['nav-menus']).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_context_shadow := item_2.val
		mut iter_3 := rt.func_array_keys(var_wp_meta_boxes['nav-menus'].array_get(var_context_shadow)).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_priority_shadow := item_3.val
			mut iter_4 := var_wp_meta_boxes['nav-menus'].array_get(var_context_shadow).array_get(var_priority_shadow).iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_box_shadow := item_4.val
				if rt.is_true(rt.call_function('in_array', [var_box_shadow['id'], rt.create_array_from_list(var_initial_meta_boxes), rt.new_bool(true)])) {
					var_box_shadow.delete('id')
				} else {
					var_hidden_meta_boxes << var_box_shadow['id']
				}
			}
		}
	}
	var_user = rt.call_function('wp_get_current_user', []rt.PhpVal{})
	rt.call_function('update_user_meta', [rt.get_property(var_user, 'ID'), rt.new_string('metaboxhidden_nav-menus'), rt.create_array_from_list(var_hidden_meta_boxes)])
}

fn wp_nav_menu_post_type_meta_boxes() {
	mut var_post_types := rt.new_null()
	mut var_post_type := rt.new_null()
	mut var_id := rt.new_null()
	mut var_priority := ''
	var_post_types = rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'show_in_nav_menus', val: true }]), rt.new_string('object')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_types)))) {
		return
	}
	mut iter_5 := var_post_types.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_post_type_shadow := item_5.val
		var_post_type_shadow = rt.call_function('apply_filters', [rt.new_string('nav_menu_meta_box_object'), var_post_type_shadow.clone()])
		if rt.is_true(var_post_type_shadow) {
			var_id = rt.get_property(var_post_type_shadow, 'name')
			var_priority = if rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_post_type_shadow, 'name'))) { 'core' } else { 'default' }
			rt.call_function('add_meta_box', [rt.new_string("add-post-type-${var_id.to_string()}"), rt.get_property(rt.get_property(var_post_type_shadow, 'labels'), 'name'), rt.new_string('wp_nav_menu_item_post_type_meta_box'), rt.new_string('nav-menus'), rt.new_string('side'), rt.new_string((var_priority).str()).clone(), var_post_type_shadow.clone()])
		}
	}
}

fn wp_nav_menu_taxonomy_meta_boxes() {
	mut var_taxonomies := rt.new_null()
	mut var_tax := rt.new_null()
	mut var_id := rt.new_null()
	var_taxonomies = rt.call_function('get_taxonomies', [rt.create_array([rt.ArrayItem{ key: 'show_in_nav_menus', val: true }]), rt.new_string('object')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_taxonomies)))) {
		return
	}
	mut iter_6 := var_taxonomies.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_tax_shadow := item_6.val
		var_tax_shadow = rt.call_function('apply_filters', [rt.new_string('nav_menu_meta_box_object'), var_tax_shadow.clone()])
		if rt.is_true(var_tax_shadow) {
			var_id = rt.get_property(var_tax_shadow, 'name')
			rt.call_function('add_meta_box', [rt.new_string("add-${var_id.to_string()}"), rt.get_property(rt.get_property(var_tax_shadow, 'labels'), 'name'), rt.new_string('wp_nav_menu_item_taxonomy_meta_box'), rt.new_string('nav-menus'), rt.new_string('side'), rt.new_string('default'), var_tax_shadow.clone()])
		}
	}
}

fn wp_nav_menu_disabled_check(var_nav_menu_selected_id rt.PhpVal, display bool) bool {
	mut var_display := display
	mut var_one_theme_location_no_menus := rt.new_null()
	if rt.is_true(var_one_theme_location_no_menus) {
		return false
	}
	return (rt.call_function('disabled', [var_nav_menu_selected_id.clone(), rt.new_int(0), rt.new_bool(display)])).to_bool()
}

fn wp_nav_menu_item_link_meta_box() {
	mut var_nav_menu_selected_id := rt.new_null()
	mut var__nav_menu_placeholder := rt.new_null()
	var__nav_menu_placeholder = if rt.is_true(rt.greater(rt.new_int(0), var__nav_menu_placeholder)) { rt.sub(var__nav_menu_placeholder, rt.new_int(1)) } else { -1 }
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var__nav_menu_placeholder)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('URL')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var__nav_menu_placeholder)
	// unsupported statement: Stmt_InlineHTML
	rt.new_bool(wp_nav_menu_disabled_check(var_nav_menu_selected_id.clone(), false))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Please provide a valid link.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Link Text')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var__nav_menu_placeholder)
	// unsupported statement: Stmt_InlineHTML
	rt.new_bool(wp_nav_menu_disabled_check(var_nav_menu_selected_id.clone(), false))
	// unsupported statement: Stmt_InlineHTML
	rt.new_bool(wp_nav_menu_disabled_check(var_nav_menu_selected_id.clone(), false))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Add to Menu')])
	// unsupported statement: Stmt_InlineHTML
}

fn wp_nav_menu_item_post_type_meta_box(var_data_object rt.PhpVal, var_box rt.PhpVal) {
	mut var_nav_menu_selected_id := rt.new_null()
	mut var_post_type_name := rt.new_null()
	mut var_post_type := rt.new_null()
	mut var_tab_name := rt.new_null()
	mut var_per_page := i64(0)
	mut var_pagenum := rt.new_null()
	mut var_offset := rt.new_null()
	mut var_args := rt.new_null()
	mut var_important_pages := []rt.PhpVal{}
	mut var_suppress_page_ids := []rt.PhpVal{}
	mut var_front_page := rt.new_null()
	mut var_front_page_obj := rt.new_null()
	mut var__nav_menu_placeholder := rt.new_null()
	mut var_posts_page := rt.new_null()
	mut var_posts_page_obj := rt.new_null()
	mut var_privacy_policy_page_id := rt.new_null()
	mut var_privacy_policy_page := rt.new_null()
	mut var_get_posts := rt.new_null()
	mut var_posts := rt.new_null()
	mut var_num_pages := rt.new_null()
	mut var_page_links := rt.new_null()
	mut var_db_fields := rt.new_null()
	mut var_walker := rt.new_null()
	mut var_current_tab := rt.new_null()
	mut var_removed_args := []rt.PhpVal{}
	mut var_most_recent_url := rt.new_null()
	mut var_view_all_url := rt.new_null()
	mut var_search_url := rt.new_null()
	mut var_recent_args := rt.new_null()
	mut var_most_recent := rt.new_null()
	mut var_searched := rt.new_null()
	mut var_search_results := rt.new_null()
	mut var_checkbox_items := rt.new_null()
	var_post_type_name = rt.get_property(var_box['args'], 'name')
	var_post_type = rt.call_function('get_post_type_object', [var_post_type_name.clone()])
	var_tab_name = rt.new_string((var_post_type_name).str() + '-tab')
	var_per_page = 50
	var_pagenum = if rt.get_superglobal('_REQUEST').array_isset(var_tab_name) && rt.get_superglobal('_REQUEST').array_isset(rt.new_string('paged')) { rt.call_function('absint', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('paged'))]) } else { rt.new_int(1) }
	var_offset = if rt.is_true(rt.less(rt.new_int(0), var_pagenum)) { rt.mul(rt.new_int(var_per_page), rt.sub(var_pagenum, rt.new_int(1))) } else { rt.new_int(0) }
	var_args = rt.create_array([rt.ArrayItem{ key: 'offset', val: var_offset }, rt.ArrayItem{ key: 'order', val: 'ASC' }, rt.ArrayItem{ key: 'orderby', val: 'title' }, rt.ArrayItem{ key: 'posts_per_page', val: var_per_page }, rt.ArrayItem{ key: 'post_type', val: var_post_type_name }, rt.ArrayItem{ key: 'suppress_filters', val: true }, rt.ArrayItem{ key: 'update_post_term_cache', val: false }, rt.ArrayItem{ key: 'update_post_meta_cache', val: false }])
	if !(rt.get_property(var_box['args'], '_default_query')).is_null() {
	var_args = rt.call_function('array_merge', [var_args.clone(), rt.cast_array(rt.get_property(var_box['args'], '_default_query'))])
	}
	var_important_pages = rt.new_array()
	if rt.is_true(rt.identical(rt.new_string('page'), var_post_type_name)) {
		var_suppress_page_ids = rt.new_array()
		var_front_page = rt.new_int(if rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')]))) { rt.new_int((rt.call_function('get_option', [rt.new_string('page_on_front')])).to_i64()) } else { 0 })
		var_front_page_obj = rt.new_null()
		if !(!rt.is_true(var_front_page)) {
		var_front_page_obj = rt.call_function('get_post', [var_front_page.clone()])
		}
		if rt.is_true(var_front_page_obj) {
			rt.set_property(var_front_page_obj, 'front_or_home', rt.new_bool(true))
			var_important_pages << var_front_page_obj.clone()
			var_suppress_page_ids << rt.get_property(var_front_page_obj, 'ID')
		} else {
			var__nav_menu_placeholder = rt.new_int(if rt.is_true(rt.greater(rt.new_int(0), var__nav_menu_placeholder)) { rt.new_int((var__nav_menu_placeholder).to_i64()) - 1 } else { -1 })
			var_front_page_obj = rt.array_to_object(rt.create_array([rt.ArrayItem{ key: 'front_or_home', val: true }, rt.ArrayItem{ key: 'ID', val: 0 }, rt.ArrayItem{ key: 'object_id', val: var__nav_menu_placeholder }, rt.ArrayItem{ key: 'post_content', val: '' }, rt.ArrayItem{ key: 'post_excerpt', val: '' }, rt.ArrayItem{ key: 'post_parent', val: '' }, rt.ArrayItem{ key: 'post_title', val: rt.call_function('_x', [rt.new_string('Home'), rt.new_string('nav menu home label')]) }, rt.ArrayItem{ key: 'post_type', val: 'nav_menu_item' }, rt.ArrayItem{ key: 'type', val: 'custom' }, rt.ArrayItem{ key: 'url', val: rt.call_function('home_url', [rt.new_string('/')]) }]))
			var_important_pages << var_front_page_obj.clone()
		}
		var_posts_page = rt.new_int(if rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')]))) { rt.new_int((rt.call_function('get_option', [rt.new_string('page_for_posts')])).to_i64()) } else { 0 })
		if !(!rt.is_true(var_posts_page)) {
			var_posts_page_obj = rt.call_function('get_post', [var_posts_page.clone()])
			if rt.is_true(var_posts_page_obj) {
				rt.set_property(var_front_page_obj, 'posts_page', rt.new_bool(true))
				var_important_pages << var_posts_page_obj.clone()
				var_suppress_page_ids << rt.get_property(var_posts_page_obj, 'ID')
			}
		}
		var_privacy_policy_page_id = rt.new_int((rt.call_function('get_option', [rt.new_string('wp_page_for_privacy_policy')])).to_i64())
		if !(!rt.is_true(var_privacy_policy_page_id)) {
			var_privacy_policy_page = rt.call_function('get_post', [var_privacy_policy_page_id.clone()])
			if rt.is_true(rt.new_bool(rt.instance_of(var_privacy_policy_page, 'WP_Post'))) && rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_privacy_policy_page, 'post_status'))) {
				rt.set_property(var_privacy_policy_page, 'privacy_policy_page', rt.new_bool(true))
				var_important_pages << var_privacy_policy_page.clone()
				var_suppress_page_ids << rt.get_property(var_privacy_policy_page, 'ID')
			}
		}
		if !(!rt.is_true(var_suppress_page_ids)) {
			var_args.array_set('post__not_in', var_suppress_page_ids.clone())
		}
	}
	var_get_posts = create_wp_query()
	var_posts = var_get_posts.query(var_args.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_get_posts, 'post_count'))))) {
		if !(!rt.is_true(var_suppress_page_ids)) {
			var_args.array_unset(rt.new_string('post__not_in'))
		var_get_posts = create_wp_query()
		var_posts = var_get_posts.query(var_args.clone())
		} else {
			print('<p>' + (rt.call_function('__', [rt.new_string('No items.')])).str() + '</p>')
			return
		}
	} else if !(!rt.is_true(var_important_pages)) {
	var_posts = rt.call_function('array_merge', [rt.create_array_from_list(var_important_pages), var_posts.clone()])
	}
	var_num_pages = rt.get_property(var_get_posts, 'max_num_pages')
	var_page_links = rt.call_function('paginate_links', [rt.create_array([rt.ArrayItem{ key: 'base', val: rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: var_tab_name, val: 'all' }, rt.ArrayItem{ key: 'paged', val: '%#%' }, rt.ArrayItem{ key: 'item-type', val: 'post_type' }, rt.ArrayItem{ key: 'item-object', val: var_post_type_name }])]) }, rt.ArrayItem{ key: 'format', val: '' }, rt.ArrayItem{ key: 'prev_text', val: '<span aria-label="' + (rt.call_function('esc_attr__', [rt.new_string('Previous page')])).str() + '">' + (rt.call_function('__', [rt.new_string('&laquo;')])).str() + '</span>' }, rt.ArrayItem{ key: 'next_text', val: '<span aria-label="' + (rt.call_function('esc_attr__', [rt.new_string('Next page')])).str() + '">' + (rt.call_function('__', [rt.new_string('&raquo;')])).str() + '</span>' }, rt.ArrayItem{ key: 'before_page_number', val: '<span class="screen-reader-text">' + (rt.call_function('__', [rt.new_string('Page')])).str() + '</span> ' }, rt.ArrayItem{ key: 'total', val: var_num_pages }, rt.ArrayItem{ key: 'current', val: var_pagenum }])])
	var_db_fields = rt.new_bool(false)
	if rt.is_true(rt.call_function('is_post_type_hierarchical', [var_post_type_name.clone()])) {
	var_db_fields = rt.create_array([rt.ArrayItem{ key: 'parent', val: 'post_parent' }, rt.ArrayItem{ key: 'id', val: 'ID' }])
	}
	var_walker = create_walker_nav_menu_checklist(var_db_fields.clone())
	var_current_tab = rt.new_string('most-recent')
	if rt.get_superglobal('_REQUEST').array_isset(var_tab_name) && rt.is_true(rt.call_function('in_array', [rt.get_superglobal('_REQUEST').array_get(var_tab_name), rt.create_array([rt.ArrayItem{ key: none, val: 'all' }, rt.ArrayItem{ key: none, val: 'search' }]), rt.new_bool(true)])) {
	var_current_tab = rt.get_superglobal('_REQUEST').array_get(var_tab_name)
	}
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string("quick-search-posttype-${var_post_type_name.to_string()}")))) {
	var_current_tab = rt.new_string('search')
	}
	var_removed_args = ['action', 'customlink-tab', 'edit-menu-item', 'menu-item', 'page-tab', '_wpnonce']
	var_most_recent_url = rt.new_string('')
	var_view_all_url = rt.new_string('')
	var_search_url = rt.new_string('')
	if rt.is_true(var_nav_menu_selected_id) {
	var_most_recent_url = rt.call_function('add_query_arg', [var_tab_name.clone(), rt.new_string('most-recent'), rt.call_function('remove_query_arg', [rt.create_array_from_list(var_removed_args)])])
	var_view_all_url = rt.call_function('add_query_arg', [var_tab_name.clone(), rt.new_string('all'), rt.call_function('remove_query_arg', [rt.create_array_from_list(var_removed_args)])])
	var_search_url = rt.call_function('add_query_arg', [var_tab_name.clone(), rt.new_string('search'), rt.call_function('remove_query_arg', [rt.create_array_from_list(var_removed_args)])])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("posttype-${var_post_type_name.to_string()}")]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("posttype-${var_post_type_name.to_string()}-tabs")]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.identical(rt.new_string('most-recent'), var_current_tab)) { ' class="tabs"' } else { '' })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("tabs-panel-posttype-${var_post_type_name.to_string()}-most-recent")]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.new_string((var_most_recent_url).str() + "#tabs-panel-posttype-${var_post_type_name.to_string()}-most-recent")]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Most Recent')])
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.identical(rt.new_string('all'), var_current_tab)) { ' class="tabs"' } else { '' })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("${var_post_type_name.to_string()}-all")]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.new_string((var_view_all_url).str() + "#${var_post_type_name.to_string()}-all")]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('View All')])
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.identical(rt.new_string('search'), var_current_tab)) { ' class="tabs"' } else { '' })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("tabs-panel-posttype-${var_post_type_name.to_string()}-search")]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.new_string((var_search_url).str() + "#tabs-panel-posttype-${var_post_type_name.to_string()}-search")]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Search')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("tabs-panel-posttype-${var_post_type_name.to_string()}-most-recent")]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.identical(rt.new_string('most-recent'), var_current_tab)) { 'tabs-panel-active' } else { 'tabs-panel-inactive' })
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Most Recent')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("${var_post_type_name.to_string()}checklist-most-recent")]))
	// unsupported statement: Stmt_InlineHTML
	var_recent_args = rt.call_function('array_merge', [var_args.clone(), rt.create_array([rt.ArrayItem{ key: 'orderby', val: 'post_date' }, rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'posts_per_page', val: 15 }])])
	var_most_recent = var_get_posts.query(var_recent_args.clone())
	var_args.array_set('walker', var_walker.clone())
	var_most_recent = rt.call_function('apply_filters', [rt.new_string("nav_menu_items_${var_post_type_name.to_string()}_recent"), var_most_recent.clone(), var_args.clone(), rt.create_array_from_native_map(var_box), var_recent_args.clone()])
	rt.echo_val(rt.call_function('walk_nav_menu_tree', [rt.call_function('array_map', [rt.new_string('wp_setup_nav_menu_item'), var_most_recent.clone()]), rt.new_int(0), rt.array_to_object(var_args)]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("tabs-panel-posttype-${var_post_type_name.to_string()}-search")]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.identical(rt.new_string('search'), var_current_tab)) { 'tabs-panel-active' } else { 'tabs-panel-inactive' })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(rt.get_property(var_post_type, 'labels'), 'search_items')]))
	// unsupported statement: Stmt_InlineHTML
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string("quick-search-posttype-${var_post_type_name.to_string()}")) {
	var_searched = rt.call_function('esc_attr', [rt.get_superglobal('_REQUEST').array_get(rt.new_string("quick-search-posttype-${var_post_type_name.to_string()}"))])
	var_search_results = rt.call_function('get_posts', [rt.create_array([rt.ArrayItem{ key: 's', val: var_searched }, rt.ArrayItem{ key: 'post_type', val: var_post_type_name }, rt.ArrayItem{ key: 'fields', val: 'all' }, rt.ArrayItem{ key: 'order', val: 'DESC' }])])
	} else {
	var_searched = rt.new_string('')
	var_search_results = rt.new_array()
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("quick-search-posttype-${var_post_type_name.to_string()}")]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Search')])
	// unsupported statement: Stmt_InlineHTML
	rt.new_bool(wp_nav_menu_disabled_check(var_nav_menu_selected_id.clone(), false))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_searched)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("quick-search-posttype-${var_post_type_name.to_string()}")]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("quick-search-posttype-${var_post_type_name.to_string()}")]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [rt.call_function('__', [rt.new_string('Search')]), rt.new_string('small quick-search-submit hide-if-js'), rt.new_string('submit'), rt.new_bool(false), rt.create_array([rt.ArrayItem{ key: 'id', val: "submit-quick-search-posttype-${var_post_type_name.to_string()}" }])])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("${var_post_type_name.to_string()}-search-checklist")]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("list:${var_post_type_name.to_string()}")]))
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_search_results)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_search_results.clone()]))))) {
		// unsupported statement: Stmt_InlineHTML
		var_args.array_set('walker', var_walker.clone())
		rt.echo_val(rt.call_function('walk_nav_menu_tree', [rt.call_function('array_map', [rt.new_string('wp_setup_nav_menu_item'), var_search_results.clone()]), rt.new_int(0), rt.array_to_object(var_args)]))
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.call_function('is_wp_error', [var_search_results.clone()])) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_method(var_search_results, 'get_error_message', []rt.PhpVal{}))
		// unsupported statement: Stmt_InlineHTML
	} else if !(!rt.is_true(var_searched)) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('No results found.')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("${var_post_type_name.to_string()}-all")]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.identical(rt.new_string('all'), var_current_tab)) { 'tabs-panel-active' } else { 'tabs-panel-inactive' })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(rt.get_property(var_post_type, 'labels'), 'all_items')]))
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_page_links)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_page_links)
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("${var_post_type_name.to_string()}checklist")]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("list:${var_post_type_name.to_string()}")]))
	// unsupported statement: Stmt_InlineHTML
	var_args.array_set('walker', var_walker.clone())
	if rt.is_true(rt.get_property(var_post_type, 'has_archive')) {
		var__nav_menu_placeholder = rt.new_int(if rt.is_true(rt.greater(rt.new_int(0), var__nav_menu_placeholder)) { rt.new_int((var__nav_menu_placeholder).to_i64()) - 1 } else { -1 })
		rt.call_function('array_unshift', [var_posts.clone(), rt.array_to_object(rt.create_array([rt.ArrayItem{ key: 'ID', val: 0 }, rt.ArrayItem{ key: 'object_id', val: var__nav_menu_placeholder }, rt.ArrayItem{ key: 'object', val: var_post_type_name }, rt.ArrayItem{ key: 'post_content', val: '' }, rt.ArrayItem{ key: 'post_excerpt', val: '' }, rt.ArrayItem{ key: 'post_title', val: rt.get_property(rt.get_property(var_post_type, 'labels'), 'archives') }, rt.ArrayItem{ key: 'post_type', val: 'nav_menu_item' }, rt.ArrayItem{ key: 'type', val: 'post_type_archive' }, rt.ArrayItem{ key: 'url', val: rt.call_function('get_post_type_archive_link', [var_post_type_name.clone()]) }]))])
	}
	var_posts = rt.call_function('apply_filters', [rt.new_string("nav_menu_items_${var_post_type_name.to_string()}"), var_posts.clone(), var_args.clone(), var_post_type.clone()])
	var_checkbox_items = rt.call_function('walk_nav_menu_tree', [rt.call_function('array_map', [rt.new_string('wp_setup_nav_menu_item'), var_posts.clone()]), rt.new_int(0), rt.array_to_object(var_args)])
	rt.echo_val(var_checkbox_items)
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_page_links)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_page_links)
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("posttype-${var_post_type_name.to_string()}")]))
	// unsupported statement: Stmt_InlineHTML
	rt.new_bool(wp_nav_menu_disabled_check(var_nav_menu_selected_id.clone(), false))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_tab_name.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_tab_name.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Select All')])
	// unsupported statement: Stmt_InlineHTML
	rt.new_bool(wp_nav_menu_disabled_check(var_nav_menu_selected_id.clone(), false))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Add to Menu')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("submit-posttype-${var_post_type_name.to_string()}")]))
	// unsupported statement: Stmt_InlineHTML
}

fn wp_nav_menu_item_taxonomy_meta_box(var_data_object rt.PhpVal, var_box rt.PhpVal) {
	mut var_nav_menu_selected_id := rt.new_null()
	mut var_taxonomy_name := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_tab_name := rt.new_null()
	mut var_per_page := i64(0)
	mut var_pagenum := rt.new_null()
	mut var_offset := rt.new_null()
	mut var_args := rt.new_null()
	mut var_terms := rt.new_null()
	mut var_num_pages := rt.new_null()
	mut var_page_links := rt.new_null()
	mut var_db_fields := rt.new_null()
	mut var_walker := rt.new_null()
	mut var_current_tab := rt.new_null()
	mut var_removed_args := []rt.PhpVal{}
	mut var_most_used_url := rt.new_null()
	mut var_view_all_url := rt.new_null()
	mut var_search_url := rt.new_null()
	mut var_popular_terms := rt.new_null()
	mut var_searched := rt.new_null()
	mut var_search_results := rt.new_null()
	var_taxonomy_name = rt.get_property(var_box['args'], 'name')
	var_taxonomy = rt.call_function('get_taxonomy', [var_taxonomy_name.clone()])
	var_tab_name = rt.new_string((var_taxonomy_name).str() + '-tab')
	var_per_page = 50
	var_pagenum = if rt.get_superglobal('_REQUEST').array_isset(var_tab_name) && rt.get_superglobal('_REQUEST').array_isset(rt.new_string('paged')) { rt.call_function('absint', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('paged'))]) } else { rt.new_int(1) }
	var_offset = if rt.is_true(rt.less(rt.new_int(0), var_pagenum)) { rt.mul(rt.new_int(var_per_page), rt.sub(var_pagenum, rt.new_int(1))) } else { rt.new_int(0) }
	var_args = rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy_name }, rt.ArrayItem{ key: 'child_of', val: 0 }, rt.ArrayItem{ key: 'exclude', val: '' }, rt.ArrayItem{ key: 'hide_empty', val: false }, rt.ArrayItem{ key: 'hierarchical', val: 1 }, rt.ArrayItem{ key: 'include', val: '' }, rt.ArrayItem{ key: 'number', val: var_per_page }, rt.ArrayItem{ key: 'offset', val: var_offset }, rt.ArrayItem{ key: 'order', val: 'ASC' }, rt.ArrayItem{ key: 'orderby', val: 'name' }, rt.ArrayItem{ key: 'pad_counts', val: false }])
	var_terms = rt.call_function('get_terms', [var_args.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_terms)))) || rt.is_true(rt.call_function('is_wp_error', [var_terms.clone()])) {
		print('<p>' + (rt.call_function('__', [rt.new_string('No items.')])).str() + '</p>')
		return
	}
	var_num_pages = rt.new_int((rt.call_function('ceil', [rt.new_int((rt.call_function('wp_count_terms', [rt.call_function('array_merge', [var_args.clone(), rt.create_array([rt.ArrayItem{ key: 'number', val: '' }, rt.ArrayItem{ key: 'offset', val: '' }])])])).to_i64()) / var_per_page])).to_i64())
	var_page_links = rt.call_function('paginate_links', [rt.create_array([rt.ArrayItem{ key: 'base', val: rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: var_tab_name, val: 'all' }, rt.ArrayItem{ key: 'paged', val: '%#%' }, rt.ArrayItem{ key: 'item-type', val: 'taxonomy' }, rt.ArrayItem{ key: 'item-object', val: var_taxonomy_name }])]) }, rt.ArrayItem{ key: 'format', val: '' }, rt.ArrayItem{ key: 'prev_text', val: '<span aria-label="' + (rt.call_function('esc_attr__', [rt.new_string('Previous page')])).str() + '">' + (rt.call_function('__', [rt.new_string('&laquo;')])).str() + '</span>' }, rt.ArrayItem{ key: 'next_text', val: '<span aria-label="' + (rt.call_function('esc_attr__', [rt.new_string('Next page')])).str() + '">' + (rt.call_function('__', [rt.new_string('&raquo;')])).str() + '</span>' }, rt.ArrayItem{ key: 'before_page_number', val: '<span class="screen-reader-text">' + (rt.call_function('__', [rt.new_string('Page')])).str() + '</span> ' }, rt.ArrayItem{ key: 'total', val: var_num_pages }, rt.ArrayItem{ key: 'current', val: var_pagenum }])])
	var_db_fields = rt.new_bool(false)
	if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [var_taxonomy_name.clone()])) {
	var_db_fields = rt.create_array([rt.ArrayItem{ key: 'parent', val: 'parent' }, rt.ArrayItem{ key: 'id', val: 'term_id' }])
	}
	var_walker = create_walker_nav_menu_checklist(var_db_fields.clone())
	var_current_tab = rt.new_string('most-used')
	if rt.get_superglobal('_REQUEST').array_isset(var_tab_name) && rt.is_true(rt.call_function('in_array', [rt.get_superglobal('_REQUEST').array_get(var_tab_name), rt.create_array([rt.ArrayItem{ key: none, val: 'all' }, rt.ArrayItem{ key: none, val: 'most-used' }, rt.ArrayItem{ key: none, val: 'search' }]), rt.new_bool(true)])) {
	var_current_tab = rt.get_superglobal('_REQUEST').array_get(var_tab_name)
	}
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string("quick-search-taxonomy-${var_taxonomy_name.to_string()}")))) {
	var_current_tab = rt.new_string('search')
	}
	var_removed_args = ['action', 'customlink-tab', 'edit-menu-item', 'menu-item', 'page-tab', '_wpnonce']
	var_most_used_url = rt.new_string('')
	var_view_all_url = rt.new_string('')
	var_search_url = rt.new_string('')
	if rt.is_true(var_nav_menu_selected_id) {
	var_most_used_url = rt.call_function('add_query_arg', [var_tab_name.clone(), rt.new_string('most-used'), rt.call_function('remove_query_arg', [rt.create_array_from_list(var_removed_args)])])
	var_view_all_url = rt.call_function('add_query_arg', [var_tab_name.clone(), rt.new_string('all'), rt.call_function('remove_query_arg', [rt.create_array_from_list(var_removed_args)])])
	var_search_url = rt.call_function('add_query_arg', [var_tab_name.clone(), rt.new_string('search'), rt.call_function('remove_query_arg', [rt.create_array_from_list(var_removed_args)])])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("taxonomy-${var_taxonomy_name.to_string()}")]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("taxonomy-${var_taxonomy_name.to_string()}-tabs")]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.identical(rt.new_string('most-used'), var_current_tab)) { ' class="tabs"' } else { '' })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("tabs-panel-${var_taxonomy_name.to_string()}-pop")]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.new_string((var_most_used_url).str() + "#tabs-panel-${var_taxonomy_name.to_string()}-pop")]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [rt.get_property(rt.get_property(var_taxonomy, 'labels'), 'most_used')]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.identical(rt.new_string('all'), var_current_tab)) { ' class="tabs"' } else { '' })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("tabs-panel-${var_taxonomy_name.to_string()}-all")]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.new_string((var_view_all_url).str() + "#tabs-panel-${var_taxonomy_name.to_string()}-all")]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('View All')])
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.identical(rt.new_string('search'), var_current_tab)) { ' class="tabs"' } else { '' })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("tabs-panel-search-taxonomy-${var_taxonomy_name.to_string()}")]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.new_string((var_search_url).str() + "#tabs-panel-search-taxonomy-${var_taxonomy_name.to_string()}")]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Search')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("tabs-panel-${var_taxonomy_name.to_string()}-pop")]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.identical(rt.new_string('most-used'), var_current_tab)) { 'tabs-panel-active' } else { 'tabs-panel-inactive' })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(rt.get_property(var_taxonomy, 'labels'), 'most_used')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("${var_taxonomy_name.to_string()}checklist-pop")]))
	// unsupported statement: Stmt_InlineHTML
	var_popular_terms = rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy_name }, rt.ArrayItem{ key: 'orderby', val: 'count' }, rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'number', val: 10 }, rt.ArrayItem{ key: 'hierarchical', val: false }])])
	var_args.array_set('walker', var_walker.clone())
	rt.echo_val(rt.call_function('walk_nav_menu_tree', [rt.call_function('array_map', [rt.new_string('wp_setup_nav_menu_item'), var_popular_terms.clone()]), rt.new_int(0), rt.array_to_object(var_args)]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("tabs-panel-${var_taxonomy_name.to_string()}-all")]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.identical(rt.new_string('all'), var_current_tab)) { 'tabs-panel-active' } else { 'tabs-panel-inactive' })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(rt.get_property(var_taxonomy, 'labels'), 'all_items')]))
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_page_links)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_page_links)
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("${var_taxonomy_name.to_string()}checklist")]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("list:${var_taxonomy_name.to_string()}")]))
	// unsupported statement: Stmt_InlineHTML
	var_args.array_set('walker', var_walker.clone())
	rt.echo_val(rt.call_function('walk_nav_menu_tree', [rt.call_function('array_map', [rt.new_string('wp_setup_nav_menu_item'), var_terms.clone()]), rt.new_int(0), rt.array_to_object(var_args)]))
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_page_links)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_page_links)
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("tabs-panel-search-taxonomy-${var_taxonomy_name.to_string()}")]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.identical(rt.new_string('search'), var_current_tab)) { 'tabs-panel-active' } else { 'tabs-panel-inactive' })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(rt.get_property(var_taxonomy, 'labels'), 'search_items')]))
	// unsupported statement: Stmt_InlineHTML
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string("quick-search-taxonomy-${var_taxonomy_name.to_string()}")) {
	var_searched = rt.call_function('esc_attr', [rt.get_superglobal('_REQUEST').array_get(rt.new_string("quick-search-taxonomy-${var_taxonomy_name.to_string()}"))])
	var_search_results = rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy_name }, rt.ArrayItem{ key: 'name__like', val: var_searched }, rt.ArrayItem{ key: 'fields', val: 'all' }, rt.ArrayItem{ key: 'orderby', val: 'count' }, rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'hierarchical', val: false }])])
	} else {
	var_searched = rt.new_string('')
	var_search_results = rt.new_array()
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("quick-search-taxonomy-${var_taxonomy_name.to_string()}")]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Search')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_searched)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("quick-search-taxonomy-${var_taxonomy_name.to_string()}")]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("quick-search-taxonomy-${var_taxonomy_name.to_string()}")]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [rt.call_function('__', [rt.new_string('Search')]), rt.new_string('small quick-search-submit hide-if-js'), rt.new_string('submit'), rt.new_bool(false), rt.create_array([rt.ArrayItem{ key: 'id', val: "submit-quick-search-taxonomy-${var_taxonomy_name.to_string()}" }])])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("${var_taxonomy_name.to_string()}-search-checklist")]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("list:${var_taxonomy_name.to_string()}")]))
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_search_results)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_search_results.clone()]))))) {
		// unsupported statement: Stmt_InlineHTML
		var_args.array_set('walker', var_walker.clone())
		rt.echo_val(rt.call_function('walk_nav_menu_tree', [rt.call_function('array_map', [rt.new_string('wp_setup_nav_menu_item'), var_search_results.clone()]), rt.new_int(0), rt.array_to_object(var_args)]))
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.call_function('is_wp_error', [var_search_results.clone()])) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_method(var_search_results, 'get_error_message', []rt.PhpVal{}))
		// unsupported statement: Stmt_InlineHTML
	} else if !(!rt.is_true(var_searched)) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('No results found.')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("taxonomy-${var_taxonomy_name.to_string()}")]))
	// unsupported statement: Stmt_InlineHTML
	rt.new_bool(wp_nav_menu_disabled_check(var_nav_menu_selected_id.clone(), false))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_tab_name.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_tab_name.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Select All')])
	// unsupported statement: Stmt_InlineHTML
	rt.new_bool(wp_nav_menu_disabled_check(var_nav_menu_selected_id.clone(), false))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Add to Menu')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string("submit-taxonomy-${var_taxonomy_name.to_string()}")]))
	// unsupported statement: Stmt_InlineHTML
}

fn wp_save_nav_menu_items(menu_id i64, var_menu_data rt.PhpVal) rt.PhpVal {
	mut var_menu_id := menu_id
	mut var_items_saved := []rt.PhpVal{}
	mut var__item_object_data := map[string]rt.PhpVal{}
	mut var__possible_db_id := rt.new_null()
	mut var__actual_db_id := rt.new_null()
	mut var_args := rt.new_null()
	var_menu_id = var_menu_id
	var_items_saved = rt.new_array()
	if 0 == var_menu_id || rt.is_true(rt.call_function('is_nav_menu', [rt.new_int(var_menu_id)])) {
		mut iter_7 := rt.cast_array(var_menu_data).iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var__item_object_data_shadow := item_7.val
			mut var__possible_db_id_shadow := item_7.key
			if !rt.is_true(var__item_object_data_shadow['menu-item-object-id']) && (!(var__item_object_data_shadow.array_isset(rt.new_string('menu-item-type'))) || rt.is_true(rt.call_function('in_array', [var__item_object_data_shadow['menu-item-url'], rt.create_array([rt.ArrayItem{ key: none, val: 'https://' }, rt.ArrayItem{ key: none, val: 'http://' }, rt.ArrayItem{ key: none, val: '' }]), rt.new_bool(true)])) || (!(rt.is_true(rt.identical(rt.new_string('custom'), var__item_object_data_shadow['menu-item-type'])) && !(var__item_object_data_shadow.array_isset(rt.new_string('menu-item-db-id')))))) || !(!rt.is_true(var__item_object_data_shadow['menu-item-db-id'])) {
				continue
			}
			if !rt.is_true(var__item_object_data_shadow['menu-item-db-id']) || rt.is_true(rt.greater(rt.new_int(0), var__possible_db_id_shadow)) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var__possible_db_id_shadow, rt.new_int((var__item_object_data_shadow['menu-item-db-id']).to_i64()))))) {
			var__actual_db_id = rt.new_int(0)
			} else {
			var__actual_db_id = rt.new_int((var__item_object_data_shadow['menu-item-db-id']).to_i64())
			}
			var_args = rt.create_array([rt.ArrayItem{ key: 'menu-item-db-id', val: if !(var__item_object_data_shadow['menu-item-db-id']).is_null() { var__item_object_data_shadow['menu-item-db-id'] } else { rt.new_string('') } }, rt.ArrayItem{ key: 'menu-item-object-id', val: if !(var__item_object_data_shadow['menu-item-object-id']).is_null() { var__item_object_data_shadow['menu-item-object-id'] } else { rt.new_string('') } }, rt.ArrayItem{ key: 'menu-item-object', val: if !(var__item_object_data_shadow['menu-item-object']).is_null() { var__item_object_data_shadow['menu-item-object'] } else { rt.new_string('') } }, rt.ArrayItem{ key: 'menu-item-parent-id', val: if !(var__item_object_data_shadow['menu-item-parent-id']).is_null() { var__item_object_data_shadow['menu-item-parent-id'] } else { rt.new_string('') } }, rt.ArrayItem{ key: 'menu-item-position', val: if !(var__item_object_data_shadow['menu-item-position']).is_null() { var__item_object_data_shadow['menu-item-position'] } else { rt.new_string('') } }, rt.ArrayItem{ key: 'menu-item-type', val: if !(var__item_object_data_shadow['menu-item-type']).is_null() { var__item_object_data_shadow['menu-item-type'] } else { rt.new_string('') } }, rt.ArrayItem{ key: 'menu-item-title', val: if !(var__item_object_data_shadow['menu-item-title']).is_null() { var__item_object_data_shadow['menu-item-title'] } else { rt.new_string('') } }, rt.ArrayItem{ key: 'menu-item-url', val: if !(var__item_object_data_shadow['menu-item-url']).is_null() { var__item_object_data_shadow['menu-item-url'] } else { rt.new_string('') } }, rt.ArrayItem{ key: 'menu-item-description', val: if !(var__item_object_data_shadow['menu-item-description']).is_null() { var__item_object_data_shadow['menu-item-description'] } else { rt.new_string('') } }, rt.ArrayItem{ key: 'menu-item-attr-title', val: if !(var__item_object_data_shadow['menu-item-attr-title']).is_null() { var__item_object_data_shadow['menu-item-attr-title'] } else { rt.new_string('') } }, rt.ArrayItem{ key: 'menu-item-target', val: if !(var__item_object_data_shadow['menu-item-target']).is_null() { var__item_object_data_shadow['menu-item-target'] } else { rt.new_string('') } }, rt.ArrayItem{ key: 'menu-item-classes', val: if !(var__item_object_data_shadow['menu-item-classes']).is_null() { var__item_object_data_shadow['menu-item-classes'] } else { rt.new_string('') } }, rt.ArrayItem{ key: 'menu-item-xfn', val: if !(var__item_object_data_shadow['menu-item-xfn']).is_null() { var__item_object_data_shadow['menu-item-xfn'] } else { rt.new_string('') } }])
			var_items_saved << rt.call_function('wp_update_nav_menu_item', [rt.new_int(var_menu_id), var__actual_db_id.clone(), var_args.clone()])
		}
	}
	return var_items_saved.clone()
}

fn _wp_nav_menu_meta_box_object(var_data_object rt.PhpVal) rt.PhpVal {
	if !(rt.get_property(var_data_object, 'name')).is_null() {
		if rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_data_object, 'name'))) {
			rt.set_property(var_data_object, '_default_query', rt.create_array([rt.ArrayItem{ key: 'orderby', val: 'menu_order title' }, rt.ArrayItem{ key: 'post_status', val: 'publish' }]))
		} else if rt.is_true(rt.identical(rt.new_string('post'), rt.get_property(var_data_object, 'name'))) {
			rt.set_property(var_data_object, '_default_query', rt.create_array([rt.ArrayItem{ key: 'post_status', val: 'publish' }]))
		} else if rt.is_true(rt.identical(rt.new_string('category'), rt.get_property(var_data_object, 'name'))) {
			rt.set_property(var_data_object, '_default_query', rt.create_array([rt.ArrayItem{ key: 'orderby', val: 'id' }, rt.ArrayItem{ key: 'order', val: 'DESC' }]))
		} else {
			rt.set_property(var_data_object, '_default_query', rt.create_array([rt.ArrayItem{ key: 'post_status', val: 'publish' }]))
		}
	}
	return var_data_object.clone()
}

fn wp_get_nav_menu_to_edit(menu_id i64) rt.PhpVal {
	mut var_menu_id := menu_id
	mut var_menu := rt.new_null()
	mut var_menu_items := rt.new_null()
	mut var_result := ''
	mut var_walker_class_name := rt.new_null()
	mut var_walker := rt.new_null()
	mut var_some_pending_menu_items := false
	mut var_some_invalid_menu_items := false
	mut var_menu_item := rt.new_null()
	mut var_message := rt.new_null()
	mut var_notice_args := map[string]rt.PhpVal{}
	var_menu = rt.call_function('wp_get_nav_menu_object', [rt.new_int(var_menu_id)])
	if rt.is_true(rt.call_function('is_nav_menu', [var_menu.clone()])) {
		var_menu_items = rt.call_function('wp_get_nav_menu_items', [rt.get_property(var_menu, 'term_id'), rt.create_array([rt.ArrayItem{ key: 'post_status', val: 'any' }])])
		var_result = '<div id="menu-instructions" class="post-body-plain'
		var_result = var_result + if !(!rt.is_true(var_menu_items)) { ' menu-instructions-inactive">' } else { '">' }
		var_result = var_result + '<p>' + (rt.call_function('__', [rt.new_string('Add menu items from the column on the left.')])).str() + '</p>'
		var_result = var_result + '</div>'
		if !rt.is_true(var_menu_items) {
			return rt.new_string((var_result + ' <ul class="menu" id="menu-to-edit"> </ul>').str())
		}
		var_walker_class_name = rt.call_function('apply_filters', [rt.new_string('wp_edit_nav_menu_walker'), rt.new_string('Walker_Nav_Menu_Edit'), rt.new_int(var_menu_id)])
		if rt.is_true(rt.call_function('class_exists', [var_walker_class_name.clone()])) {
		var_walker = rt.create_object_dynamically(var_walker_class_name, []rt.PhpVal{})
		} else {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('menu_walker_not_exist'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The Walker class named %s does not exist.')]), rt.new_string('<strong>' + (var_walker_class_name).str() + '</strong>')])))
		}
		var_some_pending_menu_items = false
		var_some_invalid_menu_items = false
		mut iter_8 := rt.cast_array(var_menu_items).iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_menu_item_shadow := item_8.val
			if !(rt.get_property(var_menu_item_shadow, 'post_status')).is_null() && rt.is_true(rt.identical(rt.new_string('draft'), rt.get_property(var_menu_item_shadow, 'post_status'))) {
			var_some_pending_menu_items = true
			}
			if !(!rt.is_true(rt.get_property(var_menu_item_shadow, '_invalid'))) {
			var_some_invalid_menu_items = true
			}
		}
		if var_some_pending_menu_items {
			var_message = rt.call_function('__', [rt.new_string('Click Save Menu to make pending menu items public.')])
			var_notice_args = { 'type': rt.new_string('info'), 'additional_classes': map[string]rt.PhpVal{} }
			var_result = var_result + (rt.call_function('wp_get_admin_notice', [var_message.clone(), rt.create_array_from_native_map(var_notice_args)])).str()
		}
		if var_some_invalid_menu_items {
			var_message = rt.call_function('__', [rt.new_string('There are some invalid menu items. Please check or delete them.')])
			var_notice_args = { 'type': rt.new_string('error'), 'additional_classes': map[string]rt.PhpVal{} }
			var_result = var_result + (rt.call_function('wp_get_admin_notice', [var_message.clone(), rt.create_array_from_native_map(var_notice_args)])).str()
		}
		var_result = var_result + '<ul class="menu" id="menu-to-edit"> '
		var_result = var_result + (rt.call_function('walk_nav_menu_tree', [rt.call_function('array_map', [rt.new_string('wp_setup_nav_menu_item'), var_menu_items.clone()]), rt.new_int(0), rt.array_to_object(rt.create_array([rt.ArrayItem{ key: 'walker', val: var_walker }]))])).str()
		var_result = var_result + ' </ul> '
		return rt.new_string((var_result).str())
	} else if rt.is_true(rt.call_function('is_wp_error', [var_menu.clone()])) {
		return var_menu.clone()
	}
	return rt.new_null()
}

fn wp_nav_menu_manage_columns() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: '_title', val: rt.call_function('__', [rt.new_string('Show advanced menu properties')]) }, rt.ArrayItem{ key: 'cb', val: '<input type="checkbox" />' }, rt.ArrayItem{ key: 'link-target', val: rt.call_function('__', [rt.new_string('Link Target')]) }, rt.ArrayItem{ key: 'title-attribute', val: rt.call_function('__', [rt.new_string('Title Attribute')]) }, rt.ArrayItem{ key: 'css-classes', val: rt.call_function('__', [rt.new_string('CSS Classes')]) }, rt.ArrayItem{ key: 'xfn', val: rt.call_function('__', [rt.new_string('Link Relationship (XFN)')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Description')]) }])
}

fn _wp_delete_orphaned_draft_menu_items() {
	mut var_wpdb := rt.new_null()
	mut var_delete_timestamp := rt.new_null()
	mut var_menu_items_to_delete := rt.new_null()
	mut var_menu_item_id := rt.new_null()
	var_delete_timestamp = rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.get_constant('DAY_IN_SECONDS'), rt.get_constant('EMPTY_TRASH_DAYS')))
	var_menu_items_to_delete = rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' AS p\n\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' AS m ON p.ID = m.post_id\n\t\t\tWHERE post_type = \'nav_menu_item\' AND post_status = \'draft\'\n\t\t\tAND meta_key = \'_menu_item_orphaned\' AND meta_value < %d')), var_delete_timestamp.clone()])])
	mut iter_9 := rt.cast_array(var_menu_items_to_delete).iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_menu_item_id_shadow := item_9.val
		rt.call_function('wp_delete_post', [var_menu_item_id_shadow.clone(), rt.new_bool(true)])
	}
}

fn wp_nav_menu_update_menu_items(var_nav_menu_selected_id rt.PhpVal, var_nav_menu_selected_title rt.PhpVal) rt.PhpVal {
	mut var_unsorted_menu_items := rt.new_null()
	mut var_messages := []rt.PhpVal{}
	mut var_menu_items := rt.new_null()
	mut var__item := rt.new_null()
	mut var_post_fields := []rt.PhpVal{}
	mut var_k := rt.new_null()
	mut var__key := rt.new_null()
	mut var_args := rt.new_null()
	mut var_field := rt.new_null()
	mut var_menu_item_db_id := rt.new_null()
	mut var_menu_item_id := rt.new_null()
	mut var_auto_add := false
	mut var_nav_menu_option := rt.new_null()
	mut var_key := rt.new_null()
	mut var_message := rt.new_null()
	mut var_notice_args := map[string]rt.PhpVal{}
	var_unsorted_menu_items = rt.call_function('wp_get_nav_menu_items', [var_nav_menu_selected_id.clone(), rt.create_array([rt.ArrayItem{ key: 'orderby', val: 'ID' }, rt.ArrayItem{ key: 'output', val: rt.get_constant('ARRAY_A') }, rt.ArrayItem{ key: 'output_key', val: 'ID' }, rt.ArrayItem{ key: 'post_status', val: 'draft,publish' }])])
	var_messages = rt.new_array()
	var_menu_items = rt.new_array()
	mut iter_10 := var_unsorted_menu_items.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var__item_shadow := item_10.val
		var_menu_items.array_set(rt.get_property(var__item_shadow, 'db_id'), var__item_shadow.clone())
	}
	var_post_fields = ['menu-item-db-id', 'menu-item-object-id', 'menu-item-object', 'menu-item-parent-id', 'menu-item-position', 'menu-item-type', 'menu-item-title', 'menu-item-url', 'menu-item-description', 'menu-item-attr-title', 'menu-item-target', 'menu-item-classes', 'menu-item-xfn']
	rt.call_function('wp_defer_term_counting', [rt.new_bool(true)])
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('menu-item-db-id')))) {
		mut iter_11 := rt.cast_array(rt.get_superglobal('_POST').array_get(rt.new_string('menu-item-db-id'))).iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_k_shadow := item_11.val
			mut var__key_shadow := item_11.key
			if !(rt.get_superglobal('_POST').array_get(rt.new_string('menu-item-title')).array_isset(var__key_shadow)) || rt.is_true(rt.identical(rt.new_string(''), rt.get_superglobal('_POST').array_get(rt.new_string('menu-item-title')).array_get(var__key_shadow))) {
				continue
			}
			var_args = rt.new_array()
			for var_field_shadow in var_post_fields {
				var_args.array_set(rt.new_string((var_field_shadow).str()), if !(rt.get_superglobal('_POST').array_get(rt.new_string((var_field_shadow).str())).array_get(var__key_shadow)).is_null() { rt.get_superglobal('_POST').array_get(rt.new_string((var_field_shadow).str())).array_get(var__key_shadow) } else { rt.new_string('') })
			}
			var_menu_item_db_id = rt.call_function('wp_update_nav_menu_item', [var_nav_menu_selected_id.clone(), if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('menu-item-db-id')).array_get(var__key_shadow)).to_i64()), var__key_shadow)))) { rt.new_int(0) } else { var__key_shadow }, var_args.clone()])
			if rt.is_true(rt.call_function('is_wp_error', [var_menu_item_db_id.clone()])) {
				var_messages << rt.call_function('wp_get_admin_notice', [rt.call_method(var_menu_item_db_id, 'get_error_message', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'error' }]) }])])
			} else {
				var_menu_items.array_unset(var_menu_item_db_id)
			}
		}
	}
	if !(!rt.is_true(var_menu_items)) {
		mut iter_12 := rt.func_array_keys(var_menu_items.clone()).iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_menu_item_id_shadow := item_12.val
			if rt.is_true(rt.call_function('is_nav_menu_item', [var_menu_item_id_shadow.clone()])) {
				rt.call_function('wp_delete_post', [var_menu_item_id_shadow.clone()])
			}
		}
	}
	var_auto_add = !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('auto-add-pages'))))
	var_nav_menu_option = rt.cast_array(rt.call_function('get_option', [rt.new_string('nav_menu_options')]))
	if !(var_nav_menu_option.array_isset(rt.new_string('auto_add'))) {
		var_nav_menu_option.array_set('auto_add', rt.new_array())
	}
	if var_auto_add {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_nav_menu_selected_id.clone(), var_nav_menu_option.array_get(rt.new_string('auto_add')), rt.new_bool(true)]))))) {
			var_nav_menu_option.array_get_mut('auto_add').array_push(var_nav_menu_selected_id.clone())
		}
	} else {
		var_key = rt.call_function('array_search', [var_nav_menu_selected_id.clone(), var_nav_menu_option.array_get(rt.new_string('auto_add')), rt.new_bool(true)])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_key)))) {
			var_nav_menu_option.array_get(rt.new_string('auto_add')).array_unset(var_key)
		}
	}
	var_nav_menu_option.array_set('auto_add', rt.call_function('array_intersect', [var_nav_menu_option.array_get(rt.new_string('auto_add')), rt.call_function('wp_get_nav_menus', [rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' }])])]))
	rt.call_function('update_option', [rt.new_string('nav_menu_options'), var_nav_menu_option.clone(), rt.new_bool(false)])
	rt.call_function('wp_defer_term_counting', [rt.new_bool(false)])
	rt.call_function('do_action', [rt.new_string('wp_update_nav_menu'), var_nav_menu_selected_id.clone()])
	var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s has been updated.')]), rt.new_string('<strong>' + (var_nav_menu_selected_title).str() + '</strong>')])
	var_notice_args = { 'id': rt.new_string('message'), 'dismissible': rt.new_bool(true), 'additional_classes': map[string]rt.PhpVal{} }
	var_messages << rt.call_function('wp_get_admin_notice', [var_message.clone(), rt.create_array_from_native_map(var_notice_args)])
	var_menu_items = rt.new_null()
	var_unsorted_menu_items = rt.new_null()
	return var_messages.clone()
}

fn _wp_expand_nav_menu_post_data() {
	mut var_matches := []rt.PhpVal{}
	mut var_data := rt.new_null()
	mut var_post_input_data := rt.new_null()
	mut var_array_bits := rt.new_null()
	mut var_new_post_data := rt.new_null()
	mut var_i := i64(0)
	mut var__POST := rt.new_null()
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('nav-menu-data'))) {
		return
	}
	var_data = rt.call_function('json_decode', [rt.call_function('stripslashes', [rt.get_superglobal('_POST').array_get(rt.new_string('nav-menu-data'))])])
	if !(var_data.clone().is_null()) && rt.is_true(var_data) {
		mut iter_13 := var_data.iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_post_input_data_shadow := item_13.val
			rt.call_function('preg_match', [rt.new_string('#([^\\[]*)(\\[(.+)\\])?#'), rt.get_property(var_post_input_data_shadow, 'name'), rt.create_array_from_list(var_matches)])
			var_array_bits = rt.create_array([rt.ArrayItem{ key: none, val: var_matches[1] }])
			if var_matches.array_isset(rt.new_int(3)) {
			var_array_bits = rt.call_function('array_merge', [var_array_bits.clone(), rt.call_function('explode', [rt.new_string(']['), var_matches[3]])])
			}
			var_new_post_data = rt.new_array()
			var_i = var_array_bits.clone().array_count() - 1
			for {
				if !(var_i >= 0) { break }
				if var_array_bits.clone().array_count() - 1 == var_i {
					var_new_post_data.array_set(var_array_bits.array_get(rt.new_int(var_i)), rt.call_function('wp_slash', [rt.get_property(var_post_input_data_shadow, 'value')]))
				} else {
				var_new_post_data = rt.create_array([rt.ArrayItem{ key: var_array_bits.array_get(rt.new_int(var_i)), val: var_new_post_data }])
				}
				var_i -= 1
			}
		var__POST = rt.call_function('array_replace_recursive', [rt.get_superglobal('_POST').clone(), var_new_post_data.clone()])
		}
	}
}

struct Class_Walker_Nav_Menu_Checklist {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_walker_nav_menu_checklist(_args ...rt.PhpVal) &Class_Walker_Nav_Menu_Checklist {
	mut obj := &Class_Walker_Nav_Menu_Checklist{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Walker_Nav_Menu_Checklist) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Walker_Nav_Menu_Checklist) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Walker_Nav_Menu_Checklist) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('Walker_Nav_Menu_Checklist', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_walker_nav_menu_checklist()
		return rt.new_object('Walker_Nav_Menu_Checklist', []string{}, obj)
	})
	rt.register_class_factory('WP_Query', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_query()
		return rt.new_object('WP_Query', []string{}, obj)
	})
	rt.register_class_factory('WP_Error', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_error()
		return rt.new_object('WP_Error', []string{}, obj)
	})
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-walker-nav-menu-edit.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-walker-nav-menu-checklist.php', '4')
}
