import rt

fn wp_nav_menu(var_args_arg rt.PhpVal) bool {
	mut var_args := var_args_arg
	mut var_menu_id_slugs := []rt.PhpVal{}
	mut var_matches := []rt.PhpVal{}
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_nav_menu := rt.new_null()
	mut var_menu := rt.new_null()
	mut var_locations := rt.new_null()
	mut var_menus := rt.new_null()
	mut var_menu_maybe := rt.new_null()
	mut var_menu_items := rt.new_null()
	mut var_items := rt.new_null()
	mut var_show_container := false
	mut var_allowed_tags := rt.new_null()
	mut var_class := rt.new_null()
	mut var_id := rt.new_null()
	mut var_aria_label := rt.new_null()
	mut var_sorted_menu_items := rt.new_null()
	mut var_menu_items_with_children := rt.new_null()
	mut var_menu_item := rt.new_null()
	mut var_wrap_id := rt.new_null()
	mut var_wrap_class := rt.new_null()
	var_defaults = { 'menu': rt.new_string(''), 'container': rt.new_string('div'), 'container_class': rt.new_string(''), 'container_id': rt.new_string(''), 'container_aria_label': rt.new_string(''), 'menu_class': rt.new_string('menu'), 'menu_id': rt.new_string(''), 'echo': rt.new_bool(true), 'fallback_cb': rt.new_string('wp_page_menu'), 'before': rt.new_string(''), 'after': rt.new_string(''), 'link_before': rt.new_string(''), 'link_after': rt.new_string(''), 'items_wrap': rt.new_string('<ul id="%1$s" class="%2$s">%3$s</ul>'), 'item_spacing': rt.new_string('preserve'), 'depth': rt.new_int(0), 'walker': rt.new_string(''), 'theme_location': rt.new_string('') }
	var_args = rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array_from_native_map(var_defaults)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_args.array_get(rt.new_string('item_spacing')), rt.create_array([rt.ArrayItem{ key: none, val: 'preserve' }, rt.ArrayItem{ key: none, val: 'discard' }]), rt.new_bool(true)]))))) {
		var_args.array_set('item_spacing', var_defaults['item_spacing'])
	}
	var_args = rt.call_function('apply_filters', [rt.new_string('wp_nav_menu_args'), var_args.clone()])
	var_args = rt.array_to_object(var_args)
	var_nav_menu = rt.call_function('apply_filters', [rt.new_string('pre_wp_nav_menu'), rt.new_null(), var_args.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_nav_menu)))) {
		if rt.is_true(rt.get_property(var_args, 'echo')) {
			rt.echo_val(var_nav_menu)
			return false
		}
		return (var_nav_menu).to_bool()
	}
	var_menu = rt.call_function('wp_get_nav_menu_object', [rt.get_property(var_args, 'menu')])
	var_locations = rt.call_function('get_nav_menu_locations', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_menu)))) && rt.is_true(rt.get_property(var_args, 'theme_location')) && rt.is_true(var_locations) && var_locations.array_isset(rt.get_property(var_args, 'theme_location')) {
	var_menu = rt.call_function('wp_get_nav_menu_object', [var_locations.array_get(rt.get_property(var_args, 'theme_location'))])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_menu)))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_args, 'theme_location'))))) {
		var_menus = rt.call_function('wp_get_nav_menus', []rt.PhpVal{})
		mut iter_1 := var_menus.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_menu_maybe_shadow := item_1.val
			var_menu_items = rt.call_function('wp_get_nav_menu_items', [rt.get_property(var_menu_maybe_shadow, 'term_id'), rt.create_array([rt.ArrayItem{ key: 'update_post_term_cache', val: false }])])
			if rt.is_true(var_menu_items) {
				var_menu = var_menu_maybe_shadow
				break
			}
		}
	}
	if !rt.is_true(rt.get_property(var_args, 'menu')) {
		rt.set_property(var_args, 'menu', var_menu.clone())
	}
	if rt.is_true(var_menu) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_menu.clone()]))))) && !(!(var_menu_items).is_null()) {
	var_menu_items = rt.call_function('wp_get_nav_menu_items', [rt.get_property(var_menu, 'term_id'), rt.create_array([rt.ArrayItem{ key: 'update_post_term_cache', val: false }])])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_menu)))) || rt.is_true(rt.call_function('is_wp_error', [var_menu.clone()])) || (!(var_menu_items).is_null() && !rt.is_true(var_menu_items) && rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_args, 'theme_location')))))) && !(rt.get_property(var_args, 'fallback_cb')).is_null() && rt.is_true(rt.get_property(var_args, 'fallback_cb')) && rt.call_function('is_callable', [rt.get_property(var_args, 'fallback_cb')]) {
		return (rt.call_function('call_user_func', [rt.get_property(var_args, 'fallback_cb'), rt.cast_array(var_args)])).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_menu)))) || rt.is_true(rt.call_function('is_wp_error', [var_menu.clone()])) {
		return false
	}
	var_nav_menu = rt.new_string('')
	var_items = rt.new_string('')
	var_show_container = false
	if rt.is_true(rt.get_property(var_args, 'container')) {
		var_allowed_tags = rt.call_function('apply_filters', [rt.new_string('wp_nav_menu_container_allowedtags'), rt.create_array([rt.ArrayItem{ key: none, val: 'div' }, rt.ArrayItem{ key: none, val: 'nav' }])])
		if rt.get_property(var_args, 'container').is_string() && rt.is_true(rt.call_function('in_array', [rt.get_property(var_args, 'container'), var_allowed_tags.clone(), rt.new_bool(true)])) {
			var_show_container = true
			var_class = rt.new_string((if rt.is_true(rt.get_property(var_args, 'container_class')) { ' class="' + (rt.call_function('esc_attr', [rt.get_property(var_args, 'container_class')])).str() + '"' } else { ' class="menu-' + (rt.get_property(var_menu, 'slug')).str() + '-container"' }).str())
			var_id = rt.new_string((if rt.is_true(rt.get_property(var_args, 'container_id')) { ' id="' + (rt.call_function('esc_attr', [rt.get_property(var_args, 'container_id')])).str() + '"' } else { '' }).str())
			var_aria_label = rt.new_string((if rt.is_true(rt.identical(rt.new_string('nav'), rt.get_property(var_args, 'container'))) && rt.is_true(rt.get_property(var_args, 'container_aria_label')) { ' aria-label="' + (rt.call_function('esc_attr', [rt.get_property(var_args, 'container_aria_label')])).str() + '"' } else { '' }).str())
			var_nav_menu = rt.concat(var_nav_menu, rt.new_string('<' + (rt.get_property(var_args, 'container')).str() + (var_id).str() + (var_class).str() + (var_aria_label).str() + '>'))
		}
	}
	_wp_menu_item_classes_by_context(var_menu_items.clone())
	var_sorted_menu_items = rt.new_array()
	var_menu_items_with_children = rt.new_array()
	mut iter_2 := rt.cast_array(var_menu_items).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_menu_item_shadow := item_2.val
		if rt.is_true(rt.identical((rt.get_property(var_menu_item_shadow, 'ID')).str(), (rt.get_property(var_menu_item_shadow, 'menu_item_parent')).str())) {
			rt.set_property(var_menu_item_shadow, 'menu_item_parent', rt.new_int(0))
		}
		var_sorted_menu_items.array_set(rt.get_property(var_menu_item_shadow, 'menu_order'), var_menu_item_shadow.clone())
		if rt.is_true(rt.get_property(var_menu_item_shadow, 'menu_item_parent')) {
			var_menu_items_with_children.array_set(rt.get_property(var_menu_item_shadow, 'menu_item_parent'), true)
		}
	}
	if rt.is_true(var_menu_items_with_children) {
		mut iter_3 := var_sorted_menu_items.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_menu_item_shadow := item_3.val
			if var_menu_items_with_children.array_isset(rt.get_property(var_menu_item_shadow, 'ID')) {
				rt.get_property(var_menu_item_shadow, 'classes').array_push('menu-item-has-children')
			}
		}
	}
	var_menu_items = rt.new_null()
	var_menu_item = rt.new_null()
	var_sorted_menu_items = rt.call_function('apply_filters', [rt.new_string('wp_nav_menu_objects'), var_sorted_menu_items.clone(), var_args.clone()])
	var_items = rt.concat(var_items, walk_nav_menu_tree(var_sorted_menu_items.clone(), rt.get_property(var_args, 'depth'), var_args.clone()))
	var_sorted_menu_items = rt.new_null()
	if !(!rt.is_true(rt.get_property(var_args, 'menu_id'))) {
	var_wrap_id = rt.get_property(var_args, 'menu_id')
	} else {
		var_wrap_id = rt.new_string('menu-' + (rt.get_property(var_menu, 'slug')).str())
		for rt.is_true(rt.call_function('in_array', [var_wrap_id.clone(), rt.create_array_from_list(var_menu_id_slugs), rt.new_bool(true)])) {
			if rt.is_true(rt.call_function('preg_match', [rt.new_string('#-(\\d+)$#'), var_wrap_id.clone(), rt.create_array_from_list(var_matches)])) {
			var_wrap_id = rt.call_function('preg_replace', [rt.new_string('#-(\\d+)$#'), rt.new_string('-' + (rt.pre_inc(var_matches[1])).str()), var_wrap_id.clone()])
			} else {
			var_wrap_id = rt.new_string((var_wrap_id).str() + '-1')
			}
		}
	}
	var_menu_id_slugs << var_wrap_id.clone()
	var_wrap_class = if rt.is_true(rt.get_property(var_args, 'menu_class')) { rt.get_property(var_args, 'menu_class') } else { rt.new_string('') }
	var_items = rt.call_function('apply_filters', [rt.new_string('wp_nav_menu_items'), var_items.clone(), var_args.clone()])
	var_items = rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('wp_nav_menu_'), rt.get_property(var_menu, 'slug')), rt.new_string('_items')), var_items.clone(), var_args.clone()])
	if !rt.is_true(var_items) {
		return false
	}
	var_nav_menu = rt.concat(var_nav_menu, rt.call_function('sprintf', [rt.get_property(var_args, 'items_wrap'), rt.call_function('esc_attr', [var_wrap_id.clone()]), rt.call_function('esc_attr', [var_wrap_class.clone()]), var_items.clone()]))
	var_items = rt.new_null()
	if var_show_container {
		var_nav_menu = rt.concat(var_nav_menu, rt.new_string('</' + (rt.get_property(var_args, 'container')).str() + '>'))
	}
	var_nav_menu = rt.call_function('apply_filters', [rt.new_string('wp_nav_menu'), var_nav_menu.clone(), var_args.clone()])
	if rt.is_true(rt.get_property(var_args, 'echo')) {
		rt.echo_val(var_nav_menu)
	} else {
		return (var_nav_menu).to_bool()
	}
	return false
}

fn _wp_menu_item_classes_by_context(var_menu_items rt.PhpVal) {
	mut var_wp_query := rt.new_null()
	mut var_wp_rewrite := rt.new_null()
	mut var_queried_object := rt.new_null()
	mut var_queried_object_id := rt.new_null()
	mut var_active_object := rt.new_null()
	mut var_active_ancestor_item_ids := rt.new_null()
	mut var_active_parent_item_ids := rt.new_null()
	mut var_active_parent_object_ids := rt.new_null()
	mut var_possible_taxonomy_ancestors := rt.new_null()
	mut var_possible_object_parents := rt.new_null()
	mut var_home_page_id := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_term_hierarchy := rt.new_null()
	mut var_terms := rt.new_null()
	mut var_term_to_ancestor := rt.new_null()
	mut var_descendents := rt.new_null()
	mut var_ancestor := rt.new_null()
	mut var_desc := rt.new_null()
	mut var__desc := rt.new_null()
	mut var_front_page_url := rt.new_null()
	mut var_front_page_id := rt.new_null()
	mut var_privacy_policy_page_id := rt.new_null()
	mut var_menu_item := rt.new_null()
	mut var_key := rt.new_null()
	mut var_classes := rt.new_null()
	mut var_ancestor_id := rt.new_null()
	mut var__root_relative_current := rt.new_null()
	mut var_current_url := rt.new_null()
	mut var_raw_item_url := rt.new_null()
	mut var_item_url := rt.new_null()
	mut var__indexless_current := rt.new_null()
	mut var_matches := []rt.PhpVal{}
	mut var_parent_item := rt.new_null()
	var_queried_object = rt.call_method(var_wp_query, 'get_queried_object', []rt.PhpVal{})
	var_queried_object_id = rt.new_int((rt.get_property(var_wp_query, 'queried_object_id')).to_i64())
	var_active_object = rt.new_string('')
	var_active_ancestor_item_ids = rt.new_array()
	var_active_parent_item_ids = rt.new_array()
	var_active_parent_object_ids = rt.new_array()
	var_possible_taxonomy_ancestors = rt.new_array()
	var_possible_object_parents = rt.new_array()
	var_home_page_id = rt.new_int((rt.call_function('get_option', [rt.new_string('page_for_posts')])).to_i64())
	if rt.is_true(rt.get_property(var_wp_query, 'is_singular')) && !(!rt.is_true(rt.get_property(var_queried_object, 'post_type'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_post_type_hierarchical', [rt.get_property(var_queried_object, 'post_type')]))))) {
		mut iter_4 := rt.cast_array(rt.call_function('get_object_taxonomies', [rt.get_property(var_queried_object, 'post_type')])).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_taxonomy_shadow := item_4.val
			if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [var_taxonomy_shadow.clone()])) {
				var_term_hierarchy = rt.call_function('_get_term_hierarchy', [var_taxonomy_shadow.clone()])
				var_terms = rt.call_function('wp_get_object_terms', [var_queried_object_id.clone(), var_taxonomy_shadow.clone(), rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' }])])
				if rt.is_true(rt.new_bool(var_terms.clone().is_array())) {
					var_possible_object_parents = rt.call_function('array_merge', [var_possible_object_parents.clone(), var_terms.clone()])
					var_term_to_ancestor = rt.new_array()
					mut iter_5 := rt.cast_array(var_term_hierarchy).iterator()
					for {
						item_5 := iter_5.next() or { break }
						mut var_descendents_shadow := item_5.val
						mut var_ancestor_shadow := item_5.key
						mut iter_6 := rt.cast_array(var_descendents_shadow).iterator()
						for {
							item_6 := iter_6.next() or { break }
							mut var_desc_shadow := item_6.val
							var_term_to_ancestor.array_set(var_desc_shadow, var_ancestor_shadow.clone())
						}
					}
					mut iter_7 := var_terms.iterator()
					for {
						item_7 := iter_7.next() or { break }
						mut var_desc_shadow := item_7.val
						for {
							var_possible_taxonomy_ancestors.array_get_mut(var_taxonomy_shadow).array_push(var_desc_shadow.clone())
							if var_term_to_ancestor.array_isset(var_desc_shadow) {
								var__desc = var_term_to_ancestor.array_get(var_desc_shadow)
								var_term_to_ancestor.array_unset(var_desc_shadow)
							var_desc_shadow = var__desc.clone()
							} else {
							var_desc_shadow = rt.new_int(0)
							}
							if !(!(!rt.is_true(var_desc_shadow))) {
								break
							}
						}
					}
				}
			}
		}
	} else if !(!rt.is_true(rt.get_property(var_queried_object, 'taxonomy'))) && rt.is_true(rt.call_function('is_taxonomy_hierarchical', [rt.get_property(var_queried_object, 'taxonomy')])) {
		var_term_hierarchy = rt.call_function('_get_term_hierarchy', [rt.get_property(var_queried_object, 'taxonomy')])
		var_term_to_ancestor = rt.new_array()
		mut iter_8 := rt.cast_array(var_term_hierarchy).iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_descendents_shadow := item_8.val
			mut var_ancestor_shadow := item_8.key
			mut iter_9 := rt.cast_array(var_descendents_shadow).iterator()
			for {
				item_9 := iter_9.next() or { break }
				mut var_desc_shadow := item_9.val
				var_term_to_ancestor.array_set(var_desc_shadow, var_ancestor_shadow.clone())
			}
		}
		var_desc = rt.get_property(var_queried_object, 'term_id')
		for {
			var_possible_taxonomy_ancestors.array_get_mut(rt.get_property(var_queried_object, 'taxonomy')).array_push(var_desc.clone())
			if var_term_to_ancestor.array_isset(var_desc) {
				var__desc = var_term_to_ancestor.array_get(var_desc)
				var_term_to_ancestor.array_unset(var_desc)
			var_desc = var__desc.clone()
			} else {
			var_desc = rt.new_int(0)
			}
			if !(!(!rt.is_true(var_desc))) {
				break
			}
		}
	}
	var_possible_object_parents = rt.call_function('array_filter', [var_possible_object_parents.clone()])
	var_front_page_url = rt.call_function('home_url', []rt.PhpVal{})
	var_front_page_id = rt.new_int((rt.call_function('get_option', [rt.new_string('page_on_front')])).to_i64())
	var_privacy_policy_page_id = rt.new_int((rt.call_function('get_option', [rt.new_string('wp_page_for_privacy_policy')])).to_i64())
	mut iter_10 := rt.cast_array(var_menu_items).iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_menu_item_shadow := item_10.val
		mut var_key_shadow := item_10.key
		rt.set_property(var_menu_items.array_get(var_key_shadow), 'current', rt.new_bool(false))
		var_classes = rt.cast_array(rt.get_property(var_menu_item_shadow, 'classes'))
		var_classes.array_push('menu-item')
		var_classes.array_push('menu-item-type-' + (rt.get_property(var_menu_item_shadow, 'type')).str())
		var_classes.array_push('menu-item-object-' + (rt.get_property(var_menu_item_shadow, 'object')).str())
		if rt.is_true(rt.identical(rt.new_string('post_type'), rt.get_property(var_menu_item_shadow, 'type'))) && rt.is_true(rt.identical(var_front_page_id, rt.new_int((rt.get_property(var_menu_item_shadow, 'object_id')).to_i64()))) {
			var_classes.array_push('menu-item-home')
		}
		if rt.is_true(rt.identical(rt.new_string('post_type'), rt.get_property(var_menu_item_shadow, 'type'))) && rt.is_true(rt.identical(var_privacy_policy_page_id, rt.new_int((rt.get_property(var_menu_item_shadow, 'object_id')).to_i64()))) {
			var_classes.array_push('menu-item-privacy-policy')
		}
		if rt.is_true(rt.get_property(var_wp_query, 'is_singular')) && rt.is_true(rt.identical(rt.new_string('taxonomy'), rt.get_property(var_menu_item_shadow, 'type'))) && rt.is_true(rt.call_function('in_array', [rt.new_int((rt.get_property(var_menu_item_shadow, 'object_id')).to_i64()), var_possible_object_parents.clone(), rt.new_bool(true)])) {
			var_active_parent_object_ids.array_push(rt.new_int((rt.get_property(var_menu_item_shadow, 'object_id')).to_i64()))
			var_active_parent_item_ids.array_push(rt.new_int((rt.get_property(var_menu_item_shadow, 'db_id')).to_i64()))
		var_active_object = rt.get_property(var_queried_object, 'post_type')
		} else if rt.is_true(rt.identical(rt.new_int((rt.get_property(var_menu_item_shadow, 'object_id')).to_i64()), var_queried_object_id)) && ((!(!rt.is_true(var_home_page_id)) && rt.is_true(rt.identical(rt.new_string('post_type'), rt.get_property(var_menu_item_shadow, 'type'))) && rt.is_true(rt.get_property(var_wp_query, 'is_home')) && rt.is_true(rt.identical(var_home_page_id, rt.new_int((rt.get_property(var_menu_item_shadow, 'object_id')).to_i64())))) || (rt.is_true(rt.identical(rt.new_string('post_type'), rt.get_property(var_menu_item_shadow, 'type'))) && rt.is_true(rt.get_property(var_wp_query, 'is_singular')))) || (rt.is_true(rt.identical(rt.new_string('taxonomy'), rt.get_property(var_menu_item_shadow, 'type'))) && rt.is_true(rt.get_property(var_wp_query, 'is_category')) || rt.is_true(rt.get_property(var_wp_query, 'is_tag')) || rt.is_true(rt.get_property(var_wp_query, 'is_tax')) && rt.is_true(rt.identical(rt.get_property(var_queried_object, 'taxonomy'), rt.get_property(var_menu_item_shadow, 'object')))) {
			var_classes.array_push('current-menu-item')
			rt.set_property(var_menu_items.array_get(var_key_shadow), 'current', rt.new_bool(true))
			var_ancestor_id = rt.new_int((rt.get_property(var_menu_item_shadow, 'db_id')).to_i64())
			var_ancestor_id = rt.new_int((rt.call_function('get_post_meta', [var_ancestor_id.clone(), rt.new_string('_menu_item_menu_item_parent'), rt.new_bool(true)])).to_i64())
			for rt.is_true(var_ancestor_id) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_ancestor_id.clone(), var_active_ancestor_item_ids.clone(), rt.new_bool(true)]))))) {
				var_active_ancestor_item_ids.array_push(var_ancestor_id.clone())
			}
			if rt.is_true(rt.identical(rt.new_string('post_type'), rt.get_property(var_menu_item_shadow, 'type'))) && rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_menu_item_shadow, 'object'))) {
				var_classes.array_push('page_item')
				var_classes.array_push('page-item-' + (rt.get_property(var_menu_item_shadow, 'object_id')).str())
				var_classes.array_push('current_page_item')
			}
			var_active_parent_item_ids.array_push(rt.new_int((rt.get_property(var_menu_item_shadow, 'menu_item_parent')).to_i64()))
			var_active_parent_object_ids.array_push(rt.new_int((rt.get_property(var_menu_item_shadow, 'post_parent')).to_i64()))
		var_active_object = rt.get_property(var_menu_item_shadow, 'object')
		} else if rt.is_true(rt.identical(rt.new_string('post_type_archive'), rt.get_property(var_menu_item_shadow, 'type'))) && rt.is_true(rt.call_function('is_post_type_archive', [rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_menu_item_shadow, 'object') }])])) {
			var_classes.array_push('current-menu-item')
			rt.set_property(var_menu_items.array_get(var_key_shadow), 'current', rt.new_bool(true))
			var_ancestor_id = rt.new_int((rt.get_property(var_menu_item_shadow, 'db_id')).to_i64())
			var_ancestor_id = rt.new_int((rt.call_function('get_post_meta', [var_ancestor_id.clone(), rt.new_string('_menu_item_menu_item_parent'), rt.new_bool(true)])).to_i64())
			for rt.is_true(var_ancestor_id) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_ancestor_id.clone(), var_active_ancestor_item_ids.clone(), rt.new_bool(true)]))))) {
				var_active_ancestor_item_ids.array_push(var_ancestor_id.clone())
			}
			var_active_parent_item_ids.array_push(rt.new_int((rt.get_property(var_menu_item_shadow, 'menu_item_parent')).to_i64()))
		} else if rt.is_true(rt.identical(rt.new_string('custom'), rt.get_property(var_menu_item_shadow, 'object'))) && rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_HOST')) {
			var__root_relative_current = rt.call_function('untrailingslashit', [rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))])
			if rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{})) {
			var__root_relative_current = rt.call_function('strtok', [rt.call_function('untrailingslashit', [rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))]), rt.new_string('?')])
			}
			var_current_url = rt.call_function('set_url_scheme', [rt.new_string('http://' + (rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_HOST'))).str() + (var__root_relative_current).str())])
			var_raw_item_url = if rt.is_true(rt.call_function('strpos', [rt.get_property(var_menu_item_shadow, 'url'), rt.new_string('#')])) { rt.call_function('substr', [rt.get_property(var_menu_item_shadow, 'url'), rt.new_int(0), rt.call_function('strpos', [rt.get_property(var_menu_item_shadow, 'url'), rt.new_string('#')])]) } else { rt.get_property(var_menu_item_shadow, 'url') }
			var_item_url = rt.call_function('set_url_scheme', [rt.call_function('untrailingslashit', [var_raw_item_url.clone()])])
			var__indexless_current = rt.call_function('untrailingslashit', [rt.call_function('preg_replace', [rt.new_string('/' + (rt.call_function('preg_quote', [rt.get_property(var_wp_rewrite, 'index'), rt.new_string('/')])).str() + '$/'), rt.new_string(''), var_current_url.clone()])])
			var_matches = [var_current_url, rt.call_function('urldecode', [var_current_url.clone()]), var__indexless_current, rt.call_function('urldecode', [var__indexless_current.clone()]), var__root_relative_current, rt.call_function('urldecode', [var__root_relative_current.clone()])]
			if rt.is_true(var_raw_item_url) && rt.is_true(rt.call_function('in_array', [var_item_url.clone(), rt.create_array_from_list(var_matches), rt.new_bool(true)])) {
				var_classes.array_push('current-menu-item')
				rt.set_property(var_menu_items.array_get(var_key_shadow), 'current', rt.new_bool(true))
				var_ancestor_id = rt.new_int((rt.get_property(var_menu_item_shadow, 'db_id')).to_i64())
				var_ancestor_id = rt.new_int((rt.call_function('get_post_meta', [var_ancestor_id.clone(), rt.new_string('_menu_item_menu_item_parent'), rt.new_bool(true)])).to_i64())
				for rt.is_true(var_ancestor_id) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_ancestor_id.clone(), var_active_ancestor_item_ids.clone(), rt.new_bool(true)]))))) {
					var_active_ancestor_item_ids.array_push(var_ancestor_id.clone())
				}
				if rt.is_true(rt.call_function('in_array', [rt.call_function('home_url', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('untrailingslashit', [var_current_url.clone()]) }, rt.ArrayItem{ key: none, val: rt.call_function('untrailingslashit', [var__indexless_current.clone()]) }]), rt.new_bool(true)])) {
					var_classes.array_push('current_page_item')
				}
				var_active_parent_item_ids.array_push(rt.new_int((rt.get_property(var_menu_item_shadow, 'menu_item_parent')).to_i64()))
				var_active_parent_object_ids.array_push(rt.new_int((rt.get_property(var_menu_item_shadow, 'post_parent')).to_i64()))
			var_active_object = rt.get_property(var_menu_item_shadow, 'object')
			} else if rt.is_true(rt.identical(var_item_url, var_front_page_url)) && rt.is_true(rt.call_function('is_front_page', []rt.PhpVal{})) {
				var_classes.array_push('current-menu-item')
			}
			if rt.is_true(rt.identical(rt.call_function('untrailingslashit', [var_item_url.clone()]), rt.call_function('home_url', []rt.PhpVal{}))) {
				var_classes.array_push('menu-item-home')
			}
		}
		if !(!rt.is_true(var_home_page_id)) && rt.is_true(rt.identical(rt.new_string('post_type'), rt.get_property(var_menu_item_shadow, 'type'))) && !rt.is_true(rt.get_property(var_wp_query, 'is_page')) && rt.is_true(rt.identical(var_home_page_id, rt.new_int((rt.get_property(var_menu_item_shadow, 'object_id')).to_i64()))) {
			var_classes.array_push('current_page_parent')
		}
		rt.set_property(var_menu_items.array_get(var_key_shadow), 'classes', rt.call_function('array_unique', [var_classes.clone()]))
	}
	var_active_ancestor_item_ids = rt.call_function('array_filter', [rt.call_function('array_unique', [var_active_ancestor_item_ids.clone()])])
	var_active_parent_item_ids = rt.call_function('array_filter', [rt.call_function('array_unique', [var_active_parent_item_ids.clone()])])
	var_active_parent_object_ids = rt.call_function('array_filter', [rt.call_function('array_unique', [var_active_parent_object_ids.clone()])])
	mut iter_11 := rt.cast_array(var_menu_items).iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_parent_item_shadow := item_11.val
		mut var_key_shadow := item_11.key
		var_classes = rt.cast_array(rt.get_property(var_parent_item_shadow, 'classes'))
		rt.set_property(var_menu_items.array_get(var_key_shadow), 'current_item_ancestor', rt.new_bool(false))
		rt.set_property(var_menu_items.array_get(var_key_shadow), 'current_item_parent', rt.new_bool(false))
		if !(rt.get_property(var_parent_item_shadow, 'type')).is_null() && (rt.is_true(rt.identical(rt.new_string('post_type'), rt.get_property(var_parent_item_shadow, 'type'))) && !(!rt.is_true(rt.get_property(var_queried_object, 'post_type'))) && rt.is_true(rt.call_function('is_post_type_hierarchical', [rt.get_property(var_queried_object, 'post_type')])) && rt.is_true(rt.call_function('in_array', [rt.new_int((rt.get_property(var_parent_item_shadow, 'object_id')).to_i64()), rt.get_property(var_queried_object, 'ancestors'), rt.new_bool(true)])) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int((rt.get_property(var_parent_item_shadow, 'object_id')).to_i64()), rt.get_property(var_queried_object, 'ID')))))) || (rt.is_true(rt.identical(rt.new_string('taxonomy'), rt.get_property(var_parent_item_shadow, 'type'))) && var_possible_taxonomy_ancestors.array_isset(rt.get_property(var_parent_item_shadow, 'object')) && rt.is_true(rt.call_function('in_array', [rt.new_int((rt.get_property(var_parent_item_shadow, 'object_id')).to_i64()), var_possible_taxonomy_ancestors.array_get(rt.get_property(var_parent_item_shadow, 'object')), rt.new_bool(true)])) && !(!(rt.get_property(var_queried_object, 'term_id')).is_null()) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int((rt.get_property(var_parent_item_shadow, 'object_id')).to_i64()), rt.get_property(var_queried_object, 'term_id')))))) {
			if !(!rt.is_true(rt.get_property(var_queried_object, 'taxonomy'))) {
				var_classes.array_push('current-' + (rt.get_property(var_queried_object, 'taxonomy')).str() + '-ancestor')
			} else {
				var_classes.array_push('current-' + (rt.get_property(var_queried_object, 'post_type')).str() + '-ancestor')
			}
		}
		if rt.is_true(rt.call_function('in_array', [rt.new_int((rt.get_property(var_parent_item_shadow, 'db_id')).to_i64()), var_active_ancestor_item_ids.clone(), rt.new_bool(true)])) {
			var_classes.array_push('current-menu-ancestor')
			rt.set_property(var_menu_items.array_get(var_key_shadow), 'current_item_ancestor', rt.new_bool(true))
		}
		if rt.is_true(rt.call_function('in_array', [rt.new_int((rt.get_property(var_parent_item_shadow, 'db_id')).to_i64()), var_active_parent_item_ids.clone(), rt.new_bool(true)])) {
			var_classes.array_push('current-menu-parent')
			rt.set_property(var_menu_items.array_get(var_key_shadow), 'current_item_parent', rt.new_bool(true))
		}
		if rt.is_true(rt.call_function('in_array', [rt.new_int((rt.get_property(var_parent_item_shadow, 'object_id')).to_i64()), var_active_parent_object_ids.clone(), rt.new_bool(true)])) {
			var_classes.array_push('current-' + (var_active_object).str() + '-parent')
		}
		if rt.is_true(rt.identical(rt.new_string('post_type'), rt.get_property(var_parent_item_shadow, 'type'))) && rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_parent_item_shadow, 'object'))) {
			if rt.is_true(rt.call_function('in_array', [rt.new_string('current-menu-parent'), var_classes.clone(), rt.new_bool(true)])) {
				var_classes.array_push('current_page_parent')
			}
			if rt.is_true(rt.call_function('in_array', [rt.new_string('current-menu-ancestor'), var_classes.clone(), rt.new_bool(true)])) {
				var_classes.array_push('current_page_ancestor')
			}
		}
		rt.set_property(var_menu_items.array_get(var_key_shadow), 'classes', rt.call_function('array_unique', [var_classes.clone()]))
	}
}

fn walk_nav_menu_tree(var_items rt.PhpVal, var_depth rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_walker := rt.new_null()
	var_walker = if !rt.is_true(rt.get_property(var_args, 'walker')) { create_walker_nav_menu() } else { rt.get_property(var_args, 'walker') }
	return rt.call_method(var_walker, 'walk', [var_items.clone(), var_depth.clone(), var_args.clone()])
}

fn _nav_menu_item_id_use_once(var_id rt.PhpVal, var_item rt.PhpVal) string {
	mut var__used_ids := []rt.PhpVal{}
	if rt.is_true(rt.call_function('in_array', [rt.get_property(var_item, 'ID'), rt.create_array_from_list(var__used_ids), rt.new_bool(true)])) {
		return ''
	}
	var__used_ids << rt.get_property(var_item, 'ID')
	return (var_id).str()
}

fn wp_nav_menu_remove_menu_item_has_children_class(var_classes_arg rt.PhpVal, var_menu_item rt.PhpVal, args bool, depth bool) rt.PhpVal {
	mut var_args := args
	mut var_depth := depth
	mut var_classes := var_classes_arg
	mut var_max_depth := rt.new_null()
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(var_depth))) || rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(args))) {
		return var_classes.clone()
	}
	var_max_depth = rt.new_int(if !(rt.get_property(rt.new_bool(args), 'depth')).is_null() { rt.new_int((rt.get_property(rt.new_bool(args), 'depth')).to_i64()) } else { 0 })
	var_depth = (var_depth + 1).to_bool()
	if rt.is_true(rt.identical(rt.new_int(0), var_max_depth)) {
		return var_classes.clone()
	}
	if rt.is_true(rt.identical(-1, var_max_depth)) || rt.is_true(rt.greater_equal(rt.new_bool(var_depth), var_max_depth)) {
	var_classes = rt.call_function('array_diff', [var_classes.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'menu-item-has-children' }])])
	}
	return var_classes.clone()
}

struct Class_Walker_Nav_Menu {
	rt.PhpObjectBase
}

fn create_walker_nav_menu(_args ...rt.PhpVal) &Class_Walker_Nav_Menu {
	mut obj := &Class_Walker_Nav_Menu{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Walker_Nav_Menu) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Walker_Nav_Menu) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Walker_Nav_Menu) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		fn () { print((rt.new_string('-1')).str()); exit(0) }()
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-walker-nav-menu.php', '4')
}
