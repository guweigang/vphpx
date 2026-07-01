import rt

fn wp_nav_menu(var_args rt.PhpVal) bool {
	mut var_menu_id_slugs := []rt.PhpVal{}
	mut var_matches := []rt.PhpVal{}
	// unsupported statement: Stmt_Static
	mut var_defaults := { 'menu': rt.new_string(''), 'container': rt.new_string('div'), 'container_class': rt.new_string(''), 'container_id': rt.new_string(''), 'container_aria_label': rt.new_string(''), 'menu_class': rt.new_string('menu'), 'menu_id': rt.new_string(''), 'echo': rt.new_bool(true), 'fallback_cb': rt.new_string('wp_page_menu'), 'before': rt.new_string(''), 'after': rt.new_string(''), 'link_before': rt.new_string(''), 'link_after': rt.new_string(''), 'items_wrap': rt.new_string('<ul id="%1$s" class="%2$s">%3$s</ul>'), 'item_spacing': rt.new_string('preserve'), 'depth': rt.new_int(0), 'walker': rt.new_string(''), 'theme_location': rt.new_string('') }
	var_args = rt.call_function('wp_parse_args', [var_args.dup(), var_defaults.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_args.array_get('item_spacing'), rt.create_array([rt.ArrayItem{ key: none, val: 'preserve' }, rt.ArrayItem{ key: none, val: 'discard' }]), rt.new_bool(true)]))))) {
		var_args.array_set('item_spacing', var_defaults.array_get('item_spacing'))
	}
	var_args = rt.call_function('apply_filters', [rt.new_string('wp_nav_menu_args'), var_args.dup()])
	var_args = // unsupported expression: Expr_Cast_Object
	mut var_nav_menu := rt.call_function('apply_filters', [rt.new_string('pre_wp_nav_menu'), rt.new_null(), var_args.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if rt.is_true(rt.get_property(var_args, 'echo')) {
			rt.echo_val(var_nav_menu)
			return false
		}
		return (var_nav_menu).to_bool()
	}
	mut var_menu := rt.call_function('wp_get_nav_menu_object', [rt.get_property(var_args, 'menu')])
	mut var_locations := rt.call_function('get_nav_menu_locations', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_menu)))) && rt.is_true(rt.get_property(var_args, 'theme_location')))) && rt.is_true(var_locations))) && var_locations.array_isset(rt.get_property(var_args, 'theme_location')))) {
		var_menu = rt.call_function('wp_get_nav_menu_object', [var_locations.array_get(rt.get_property(var_args, 'theme_location'))])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_menu)))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_args, 'theme_location'))))))) {
		mut var_menus := rt.call_function('wp_get_nav_menus', []rt.PhpVal{})
		{
			mut iter_1 := var_menus.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_menu_maybe := item_1.val
				mut var_menu_items := rt.call_function('wp_get_nav_menu_items', [rt.get_property(var_menu_maybe, 'term_id'), rt.create_array([rt.ArrayItem{ key: 'update_post_term_cache', val: false }])])
				if rt.is_true(var_menu_items) {
					var_menu = var_menu_maybe
					break
				}
			}
		}
	}
	if !rt.is_true(rt.get_property(var_args, 'menu')) {
		rt.set_property(var_args, 'menu', var_menu.dup())
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_menu) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_menu.dup()]))))))) && !(!(var_menu_items).is_null()))) {
		mut var_menu_items := rt.call_function('wp_get_nav_menu_items', [rt.get_property(var_menu, 'term_id'), rt.create_array([rt.ArrayItem{ key: 'update_post_term_cache', val: false }])])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_menu)))) || rt.is_true(rt.call_function('is_wp_error', [var_menu.dup()])))) || rt.is_true(rt.new_bool(!(var_menu_items).is_null() && !rt.is_true(var_menu_items) && rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_args, 'theme_location'))))))))) && !(rt.get_property(var_args, 'fallback_cb')).is_null())) && rt.is_true(rt.get_property(var_args, 'fallback_cb')))) && rt.is_true(rt.call_function('is_callable', [rt.get_property(var_args, 'fallback_cb')])))) {
		return (rt.call_function('call_user_func', [rt.get_property(var_args, 'fallback_cb'), rt.cast_array(var_args)])).to_bool()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_menu)))) || rt.is_true(rt.call_function('is_wp_error', [var_menu.dup()])))) {
		return false
	}
	var_nav_menu = rt.new_string(rt.new_string(''))
	mut var_items := rt.new_string(rt.new_string(''))
	mut var_show_container := false
	if rt.is_true(rt.get_property(var_args, 'container')) {
		mut var_allowed_tags := rt.call_function('apply_filters', [rt.new_string('wp_nav_menu_container_allowedtags'), rt.create_array([rt.ArrayItem{ key: none, val: 'div' }, rt.ArrayItem{ key: none, val: 'nav' }])])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.get_property(var_args, 'container').is_string())) && rt.is_true(rt.call_function('in_array', [rt.get_property(var_args, 'container'), var_allowed_tags.dup(), rt.new_bool(true)])))) {
			var_show_container = true
			mut var_class := rt.new_string(if rt.is_true(rt.get_property(var_args, 'container_class')) { ' class="' + (rt.call_function('esc_attr', [rt.get_property(var_args, 'container_class')])).str() + '"' } else { ' class="menu-' + (rt.get_property(var_menu, 'slug')).str() + '-container"' })
			mut var_id := rt.new_string(if rt.is_true(rt.get_property(var_args, 'container_id')) { ' id="' + (rt.call_function('esc_attr', [rt.get_property(var_args, 'container_id')])).str() + '"' } else { rt.new_string('') })
			mut var_aria_label := rt.new_string(if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('nav'), rt.get_property(var_args, 'container'))) && rt.is_true(rt.get_property(var_args, 'container_aria_label')))) { ' aria-label="' + (rt.call_function('esc_attr', [rt.get_property(var_args, 'container_aria_label')])).str() + '"' } else { rt.new_string('') })
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	_wp_menu_item_classes_by_context(var_menu_items.dup())
	mut var_sorted_menu_items := rt.new_array()
	mut var_menu_items_with_children := rt.new_array()
	{
		mut iter_1 := rt.cast_array(var_menu_items).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_menu_item := item_1.val
			if rt.is_true(rt.identical(// unsupported expression: Expr_Cast_String, // unsupported expression: Expr_Cast_String)) {
				rt.set_property(var_menu_item, 'menu_item_parent', rt.new_int(0))
			}
			var_sorted_menu_items.array_set(rt.get_property(var_menu_item, 'menu_order'), var_menu_item.dup())
			if rt.is_true(rt.get_property(var_menu_item, 'menu_item_parent')) {
				var_menu_items_with_children.array_set(rt.get_property(var_menu_item, 'menu_item_parent'), true)
			}
		}
	}
	if rt.is_true(var_menu_items_with_children) {
		{
			mut iter_1 := var_sorted_menu_items.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_menu_item := item_1.val
				if var_menu_items_with_children.array_isset(rt.get_property(var_menu_item, 'ID')) {
					rt.get_property(var_menu_item, 'classes').array_push('menu-item-has-children')
				}
			}
		}
	}
	var_menu_items = rt.new_null()
	var_menu_item = rt.new_null()
	var_sorted_menu_items = rt.call_function('apply_filters', [rt.new_string('wp_nav_menu_objects'), var_sorted_menu_items.dup(), var_args.dup()])
	// unsupported expression: Expr_AssignOp_Concat
	var_sorted_menu_items = rt.new_null()
	if !(!rt.is_true(rt.get_property(var_args, 'menu_id'))) {
		mut var_wrap_id := rt.get_property(var_args, 'menu_id')
	} else {
		var_wrap_id = rt.new_string('menu-' + (rt.get_property(var_menu, 'slug')).str())
		for rt.is_true(rt.call_function('in_array', [var_wrap_id.dup(), var_menu_id_slugs.dup(), rt.new_bool(true)])) {
			if rt.is_true(rt.call_function('preg_match', [rt.new_string('#-(\\d+)$#'), var_wrap_id.dup(), var_matches.dup()])) {
				var_wrap_id = rt.call_function('preg_replace', [rt.new_string('#-(\\d+)$#'), '-' + (rt.pre_inc(var_matches.array_get(1))).str(), var_wrap_id.dup()])
			} else {
				var_wrap_id = rt.new_string((var_wrap_id).str() + '-1')
			}
		}
	}
	var_menu_id_slugs << var_wrap_id.dup()
	mut var_wrap_class := if rt.is_true(rt.get_property(var_args, 'menu_class')) { rt.get_property(var_args, 'menu_class') } else { rt.new_string('') }
	var_items = rt.call_function('apply_filters', [rt.new_string('wp_nav_menu_items'), var_items.dup(), var_args.dup()])
	var_items = rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('wp_nav_menu_'), rt.get_property(var_menu, 'slug')), rt.new_string('_items')), var_items.dup(), var_args.dup()])
	if !rt.is_true(var_items) {
		return false
	}
	// unsupported expression: Expr_AssignOp_Concat
	var_items = rt.new_null()
	if var_show_container {
		// unsupported expression: Expr_AssignOp_Concat
	}
	var_nav_menu = rt.call_function('apply_filters', [rt.new_string('wp_nav_menu'), var_nav_menu.dup(), var_args.dup()])
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
	// unsupported statement: Stmt_Global
	mut var_queried_object := rt.call_method(var_wp_query, 'get_queried_object', []rt.PhpVal{})
	mut var_queried_object_id := // unsupported expression: Expr_Cast_Int
	mut var_active_object := rt.new_string(rt.new_string(''))
	mut var_active_ancestor_item_ids := rt.new_array()
	mut var_active_parent_item_ids := rt.new_array()
	mut var_active_parent_object_ids := rt.new_array()
	mut var_possible_taxonomy_ancestors := rt.new_array()
	mut var_possible_object_parents := rt.new_array()
	mut var_home_page_id := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.get_property(var_wp_query, 'is_singular')) && !(!rt.is_true(rt.get_property(var_queried_object, 'post_type'))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_post_type_hierarchical', [rt.get_property(var_queried_object, 'post_type')]))))))) {
		{
			mut iter_1 := rt.cast_array(rt.call_function('get_object_taxonomies', [rt.get_property(var_queried_object, 'post_type')])).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_taxonomy := item_1.val
				if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [var_taxonomy.dup()])) {
					mut var_term_hierarchy := rt.call_function('_get_term_hierarchy', [var_taxonomy.dup()])
					mut var_terms := rt.call_function('wp_get_object_terms', [var_queried_object_id.dup(), var_taxonomy.dup(), rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' }])])
					if rt.is_true(rt.new_bool(var_terms.dup().is_array())) {
						var_possible_object_parents = rt.call_function('array_merge', [var_possible_object_parents.dup(), var_terms.dup()])
						mut var_term_to_ancestor := rt.new_array()
						{
							mut iter_2 := rt.cast_array(var_term_hierarchy).iterator()
							for {
								item_2 := iter_2.next() or { break }
								mut var_descendents := item_2.val
								mut var_ancestor := item_2.key
								{
									mut iter_3 := rt.cast_array(var_descendents).iterator()
									for {
										item_3 := iter_3.next() or { break }
										mut var_desc := item_3.val
										var_term_to_ancestor.array_set(var_desc, var_ancestor.dup())
									}
								}
							}
						}
						{
							mut iter_2 := var_terms.iterator()
							for {
								item_2 := iter_2.next() or { break }
								mut var_desc := item_2.val
								for {
									var_possible_taxonomy_ancestors.array_get_mut(var_taxonomy).array_push(var_desc.dup())
									if var_term_to_ancestor.array_isset(var_desc) {
										mut var__desc := var_term_to_ancestor.array_get(var_desc)
										var_term_to_ancestor.array_unset(var_desc)
										var_desc = var__desc.dup()
									} else {
										var_desc = rt.new_int(rt.new_int(0))
									}
									if !(!(!rt.is_true(var_desc))) {
										break
									}
								}
							}
						}
					}
				}
			}
		}
	} else if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_property(var_queried_object, 'taxonomy'))) && rt.is_true(rt.call_function('is_taxonomy_hierarchical', [rt.get_property(var_queried_object, 'taxonomy')])))) {
		mut var_term_hierarchy := rt.call_function('_get_term_hierarchy', [rt.get_property(var_queried_object, 'taxonomy')])
		mut var_term_to_ancestor := rt.new_array()
		{
			mut iter_1 := rt.cast_array(var_term_hierarchy).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_descendents := item_1.val
				mut var_ancestor := item_1.key
				{
					mut iter_2 := rt.cast_array(var_descendents).iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_desc := item_2.val
						var_term_to_ancestor.array_set(var_desc, var_ancestor.dup())
					}
				}
			}
		}
		mut var_desc := rt.get_property(var_queried_object, 'term_id')
		for {
			var_possible_taxonomy_ancestors.array_get_mut(rt.get_property(, 'taxonomy')).array_push(var_desc.dup())
			if var_term_to_ancestor.array_isset(var_desc) {
				
			} else {
			}
			if !(!(!rt.is_true(var_desc))) {
				break
			}
		}
	}
	var_possible_object_parents = 
	
}



pub fn init_wp_includes_nav_menu_template_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-walker-nav-menu.php', '4')
}
