import rt

struct Class_WP_Customize_Nav_Menus {
	rt.PhpObjectBase
pub mut:
		manager rt.PhpVal = rt.new_null()
		original_nav_menu_locations rt.PhpVal = rt.new_null()
		preview_nav_menu_instance_args rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Customize_Nav_Menus) construct(var_manager rt.PhpVal) {
	this.manager = var_manager.clone()
	this.original_nav_menu_locations = rt.call_function('get_nav_menu_locations', []rt.PhpVal{})
	rt.call_function('add_action', [rt.new_string('customize_register'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menus', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'customize_register' }]), rt.new_int(11)])
	rt.call_function('add_filter', [rt.new_string('customize_dynamic_setting_args'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menus', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'filter_dynamic_setting_args' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('customize_dynamic_setting_class'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menus', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'filter_dynamic_setting_class' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('customize_save_nav_menus_created_posts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menus', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'save_nav_menus_created_posts' }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]))))) {
		return
	}
	rt.call_function('add_filter', [rt.new_string('customize_refresh_nonces'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menus', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'filter_nonces' }])])
	rt.call_function('add_action', [rt.new_string('wp_ajax_load-available-menu-items-customizer'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menus', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'ajax_load_available_items' }])])
	rt.call_function('add_action', [rt.new_string('wp_ajax_search-available-menu-items-customizer'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menus', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'ajax_search_available_items' }])])
	rt.call_function('add_action', [rt.new_string('wp_ajax_customize-nav-menus-insert-auto-draft'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menus', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'ajax_insert_auto_draft_post' }])])
	rt.call_function('add_action', [rt.new_string('customize_controls_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menus', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'enqueue_scripts' }])])
	rt.call_function('add_action', [rt.new_string('customize_controls_print_footer_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menus', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'print_templates' }])])
	rt.call_function('add_action', [rt.new_string('customize_controls_print_footer_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menus', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'available_items_template' }])])
	rt.call_function('add_action', [rt.new_string('customize_preview_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menus', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'customize_preview_init' }])])
	rt.call_function('add_action', [rt.new_string('customize_preview_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menus', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'make_auto_draft_status_previewable' }])])
	rt.call_function('add_filter', [rt.new_string('customize_dynamic_partial_args'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menus', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'customize_dynamic_partial_args' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_WP_Customize_Nav_Menus) filter_nonces(var_nonces rt.PhpVal) rt.PhpVal {
	mut var_nonces_mutated := var_nonces
	var_nonces_mutated.array_set('customize-menus', rt.call_function('wp_create_nonce', [rt.new_string('customize-menus')]))
	return var_nonces_mutated.clone()
}

fn (mut this Class_WP_Customize_Nav_Menus) ajax_load_available_items() {
	rt.call_function('check_ajax_referer', [rt.new_string('customize-menus'), rt.new_string('customize-menus-nonce')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]))))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_all_items := map[string]rt.PhpVal{}
	mut var_item_types := map[string]rt.PhpVal{}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('item_types')) && rt.get_superglobal('_POST').array_get(rt.new_string('item_types')).is_array() {
	var_item_types = rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('item_types'))])
	} else if rt.get_superglobal('_POST').array_isset(rt.new_string('type')) && rt.get_superglobal('_POST').array_isset(rt.new_string('object')) {
		var_item_types.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('type'))]) }, rt.ArrayItem{ key: 'object', val: rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('object'))]) }, rt.ArrayItem{ key: 'page', val: if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('page'))) { rt.new_int(0) } else { rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('page'))]) } }]))
	} else {
		rt.call_function('wp_send_json_error', [rt.new_string('nav_menus_missing_type_or_object_parameter')])
	}
	mut iter_1 := var_item_types.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_item_type := item_1.val
		if !rt.is_true(var_item_type.array_get(rt.new_string('type'))) || !rt.is_true(var_item_type.array_get(rt.new_string('object'))) {
			rt.call_function('wp_send_json_error', [rt.new_string('nav_menus_missing_type_or_object_parameter')])
		}
		mut var_type := rt.call_function('sanitize_key', [var_item_type.array_get(rt.new_string('type'))])
		mut var_object := rt.call_function('sanitize_key', [var_item_type.array_get(rt.new_string('object'))])
		mut var_page := if !rt.is_true(var_item_type.array_get(rt.new_string('page'))) { rt.new_int(0) } else { rt.call_function('absint', [var_item_type.array_get(rt.new_string('page'))]) }
		mut var_items := this.load_available_items_query((var_type).str(), (var_object).str(), (var_page).to_i64())
		if rt.is_true(rt.call_function('is_wp_error', [var_items.clone()])) {
			rt.call_function('wp_send_json_error', [rt.call_method(var_items, 'get_error_code', []rt.PhpVal{})])
		}
		var_all_items[(var_item_type.array_get(rt.new_string('type'))).str() + ':' + (var_item_type.array_get(rt.new_string('object'))).str()] = var_items.clone()
	}
	rt.call_function('wp_send_json_success', [rt.create_array([rt.ArrayItem{ key: 'items', val: var_all_items }])])
}

fn (mut this Class_WP_Customize_Nav_Menus) load_available_items_query(object_type string, object_name string, page i64) rt.PhpVal {
	mut page_mutated := page
	mut var_items := map[string]rt.PhpVal{}
	if rt.is_true(rt.identical(rt.new_string('post_type'), rt.new_string(object_type))) {
		mut var_post_type := rt.call_function('get_post_type_object', [rt.new_string(object_name)])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type)))) {
			return create_wp_error(rt.new_string('nav_menus_invalid_post_type'))
		}
		mut var_important_pages := map[string]rt.PhpVal{}
		mut var_suppress_page_ids := map[string]rt.PhpVal{}
		if 0 == page_mutated && rt.is_true(rt.identical(rt.new_string('page'), rt.new_string(object_name))) {
			mut var_front_page := rt.new_int(if rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')]))) { rt.new_int((rt.call_function('get_option', [rt.new_string('page_on_front')])).to_i64()) } else { 0 })
			if !(!rt.is_true(var_front_page)) {
				mut var_front_page_obj := rt.call_function('get_post', [var_front_page.clone()])
				var_important_pages << var_front_page_obj.clone()
				var_suppress_page_ids << rt.get_property(var_front_page_obj, 'ID')
			} else {
				var_items.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: 'home' }, rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [rt.new_string('Home'), rt.new_string('nav menu home label')]) }, rt.ArrayItem{ key: 'type', val: 'custom' }, rt.ArrayItem{ key: 'type_label', val: rt.call_function('__', [rt.new_string('Custom Link')]) }, rt.ArrayItem{ key: 'object', val: '' }, rt.ArrayItem{ key: 'url', val: rt.call_function('home_url', []rt.PhpVal{}) }]))
			}
			mut var_posts_page := rt.new_int(if rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')]))) { rt.new_int((rt.call_function('get_option', [rt.new_string('page_for_posts')])).to_i64()) } else { 0 })
			if !(!rt.is_true(var_posts_page)) {
				mut var_posts_page_obj := rt.call_function('get_post', [var_posts_page.clone()])
				var_important_pages << var_posts_page_obj.clone()
				var_suppress_page_ids << rt.get_property(var_posts_page_obj, 'ID')
			}
			mut var_privacy_policy_page_id := rt.new_int((rt.call_function('get_option', [rt.new_string('wp_page_for_privacy_policy')])).to_i64())
			if !(!rt.is_true(var_privacy_policy_page_id)) {
				mut var_privacy_policy_page := rt.call_function('get_post', [var_privacy_policy_page_id.clone()])
				if rt.is_true(rt.new_bool(rt.instance_of(var_privacy_policy_page, 'WP_Post'))) && rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_privacy_policy_page, 'post_status'))) {
					var_important_pages << var_privacy_policy_page.clone()
					var_suppress_page_ids << rt.get_property(var_privacy_policy_page, 'ID')
				}
			}
		} else if rt.is_true(rt.new_bool('post' != object_name)) && 0 == page_mutated && rt.is_true(rt.get_property(var_post_type, 'has_archive')) {
			mut var_title := rt.get_property(rt.get_property(var_post_type, 'labels'), 'archives')
			var_items.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: object_name + '-archive' }, rt.ArrayItem{ key: 'title', val: var_title }, rt.ArrayItem{ key: 'original_title', val: var_title }, rt.ArrayItem{ key: 'type', val: 'post_type_archive' }, rt.ArrayItem{ key: 'type_label', val: rt.call_function('__', [rt.new_string('Post Type Archive')]) }, rt.ArrayItem{ key: 'object', val: object_name }, rt.ArrayItem{ key: 'url', val: rt.call_function('get_post_type_archive_link', [rt.new_string(object_name)]) }]))
		}
		mut var_posts := map[string]rt.PhpVal{}
		if 0 == page_mutated && rt.is_true(rt.call_method(this.manager, 'get_setting', [rt.new_string('nav_menus_created_posts')])) {
			mut iter_2 := rt.call_method(rt.call_method(this.manager, 'get_setting', [rt.new_string('nav_menus_created_posts')]), 'value', []rt.PhpVal{}).iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_post_id := item_2.val
				mut var_auto_draft_post := rt.call_function('get_post', [var_post_id.clone()])
				if rt.is_true(rt.identical(rt.get_property(var_post_type, 'name'), rt.get_property(var_auto_draft_post, 'post_type'))) {
					var_posts.array_push(var_auto_draft_post.clone())
				}
			}
		}
		mut var_args := { 'numberposts': rt.new_int(10), 'offset': 10 * page_mutated, 'orderby': rt.new_string('date'), 'order': rt.new_string('DESC'), 'post_type': rt.new_string(object_name) }
		if !(!rt.is_true(var_suppress_page_ids)) {
			var_args['post__not_in'] = var_suppress_page_ids.clone()
		}
		var_posts = rt.call_function('array_merge', [var_posts.clone(), rt.create_array_from_list(var_important_pages), rt.call_function('get_posts', [rt.create_array_from_native_map(var_args)])])
		mut iter_3 := var_posts.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_post := item_3.val
			mut var_post_title := rt.get_property(var_post, 'post_title')
			if rt.is_true(rt.identical(rt.new_string(''), var_post_title)) {
			var_post_title = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('#%d (no title)')]), rt.get_property(var_post, 'ID')])
			}
			mut var_post_type_label := rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [rt.get_property(var_post, 'post_type')]), 'labels'), 'singular_name')
			mut var_post_states := rt.call_function('get_post_states', [var_post.clone()])
			if !(!rt.is_true(var_post_states)) {
			var_post_type_label = rt.call_function('implode', [rt.new_string(','), var_post_states.clone()])
			}
			var_title = rt.call_function('html_entity_decode', [var_post_title.clone(), rt.get_constant('ENT_QUOTES'), rt.call_function('get_bloginfo', [rt.new_string('charset')])])
			var_items.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: rt.concat(rt.new_string('post-'), rt.get_property(var_post, 'ID')) }, rt.ArrayItem{ key: 'title', val: var_title }, rt.ArrayItem{ key: 'original_title', val: var_title }, rt.ArrayItem{ key: 'type', val: 'post_type' }, rt.ArrayItem{ key: 'type_label', val: var_post_type_label }, rt.ArrayItem{ key: 'object', val: rt.get_property(var_post, 'post_type') }, rt.ArrayItem{ key: 'object_id', val: rt.new_int((rt.get_property(var_post, 'ID')).to_i64()) }, rt.ArrayItem{ key: 'url', val: rt.call_function('get_permalink', [rt.new_int((rt.get_property(var_post, 'ID')).to_i64())]) }]))
		}
	} else if rt.is_true(rt.identical(rt.new_string('taxonomy'), rt.new_string(object_type))) {
		mut var_terms := rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: object_name }, rt.ArrayItem{ key: 'child_of', val: 0 }, rt.ArrayItem{ key: 'exclude', val: '' }, rt.ArrayItem{ key: 'hide_empty', val: false }, rt.ArrayItem{ key: 'hierarchical', val: 1 }, rt.ArrayItem{ key: 'include', val: '' }, rt.ArrayItem{ key: 'number', val: 10 }, rt.ArrayItem{ key: 'offset', val: 10 * page_mutated }, rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'orderby', val: 'count' }, rt.ArrayItem{ key: 'pad_counts', val: false }])])
		if rt.is_true(rt.call_function('is_wp_error', [var_terms.clone()])) {
			return var_terms.clone()
		}
		mut iter_4 := var_terms.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_term := item_4.val
			var_title = rt.call_function('html_entity_decode', [rt.get_property(var_term, 'name'), rt.get_constant('ENT_QUOTES'), rt.call_function('get_bloginfo', [rt.new_string('charset')])])
			var_items.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: rt.concat(rt.new_string('term-'), rt.get_property(var_term, 'term_id')) }, rt.ArrayItem{ key: 'title', val: var_title }, rt.ArrayItem{ key: 'original_title', val: var_title }, rt.ArrayItem{ key: 'type', val: 'taxonomy' }, rt.ArrayItem{ key: 'type_label', val: rt.get_property(rt.get_property(rt.call_function('get_taxonomy', [rt.get_property(var_term, 'taxonomy')]), 'labels'), 'singular_name') }, rt.ArrayItem{ key: 'object', val: rt.get_property(var_term, 'taxonomy') }, rt.ArrayItem{ key: 'object_id', val: rt.new_int((rt.get_property(var_term, 'term_id')).to_i64()) }, rt.ArrayItem{ key: 'url', val: rt.call_function('get_term_link', [rt.new_int((rt.get_property(var_term, 'term_id')).to_i64()), rt.get_property(var_term, 'taxonomy')]) }]))
		}
	}
	var_items = rt.call_function('apply_filters', [rt.new_string('customize_nav_menu_available_items'), var_items.clone(), rt.new_string(object_type), rt.new_string(object_name), rt.new_int(page_mutated).clone()])
	return var_items.clone()
}

fn (mut this Class_WP_Customize_Nav_Menus) ajax_search_available_items() {
	rt.call_function('check_ajax_referer', [rt.new_string('customize-menus'), rt.new_string('customize-menus-nonce')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]))))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('search'))) {
		rt.call_function('wp_send_json_error', [rt.new_string('nav_menus_missing_search_parameter')])
	}
	mut var_p := if rt.get_superglobal('_POST').array_isset(rt.new_string('page')) { rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('page'))]) } else { rt.new_int(0) }
	if rt.is_true(rt.less(var_p, rt.new_int(1))) {
	var_p = rt.new_int(1)
	}
	mut var_s := rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('search'))])])
	mut var_items := this.search_available_items_query(rt.create_array([rt.ArrayItem{ key: 'pagenum', val: var_p }, rt.ArrayItem{ key: 's', val: var_s }]))
	if !rt.is_true(var_items) {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('No results found.')]) }])])
	} else {
		rt.call_function('wp_send_json_success', [rt.create_array([rt.ArrayItem{ key: 'items', val: var_items }])])
	}
}

fn (mut this Class_WP_Customize_Nav_Menus) search_available_items_query(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_items := map[string]rt.PhpVal{}
	mut var_post_type_objects := rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'show_in_nav_menus', val: true }]), rt.new_string('objects')])
	mut var_query := { 'post_type': rt.func_array_keys(var_post_type_objects.clone()), 'suppress_filters': rt.new_bool(true), 'update_post_term_cache': rt.new_bool(false), 'update_post_meta_cache': rt.new_bool(false), 'post_status': rt.new_string('publish'), 'posts_per_page': rt.new_int(20) }
	var_args_mutated.array_set('pagenum', if var_args_mutated.array_isset(rt.new_string('pagenum')) { rt.call_function('absint', [var_args_mutated.array_get(rt.new_string('pagenum'))]) } else { rt.new_int(1) })
	var_query['offset'] = if rt.is_true(rt.greater(var_args_mutated.array_get(rt.new_string('pagenum')), rt.new_int(1))) { rt.mul(var_query['posts_per_page'], rt.sub(var_args_mutated.array_get(rt.new_string('pagenum')), rt.new_int(1))) } else { rt.new_int(0) }
	if var_args_mutated.array_isset(rt.new_string('s')) {
		var_query['s'] = var_args_mutated.array_get(rt.new_string('s'))
	}
	mut var_posts := map[string]rt.PhpVal{}
	mut var_nav_menus_created_posts_setting := rt.call_method(this.manager, 'get_setting', [rt.new_string('nav_menus_created_posts')])
	if rt.is_true(rt.identical(rt.new_int(1), var_args_mutated.array_get(rt.new_string('pagenum')))) && rt.is_true(var_nav_menus_created_posts_setting) && rt.call_method(var_nav_menus_created_posts_setting, 'value', []rt.PhpVal{}).array_count() > 0 {
	mut var_stub_post_query := create_wp_query(rt.call_function('array_merge', [rt.create_array_from_native_map(var_query), rt.create_array([rt.ArrayItem{ key: 'post_status', val: 'auto-draft' }, rt.ArrayItem{ key: 'post__in', val: rt.call_method(var_nav_menus_created_posts_setting, 'value', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'posts_per_page', val: -1 }])]))
	var_posts = rt.call_function('array_merge', [var_posts.clone(), rt.get_property(var_stub_post_query, 'posts')])
	}
	mut var_get_posts := create_wp_query(var_query.clone())
	var_posts = rt.call_function('array_merge', [var_posts.clone(), rt.get_property(var_get_posts, 'posts')])
	mut iter_5 := var_posts.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_post := item_5.val
		mut var_post_title := rt.get_property(var_post, 'post_title')
		if rt.is_true(rt.identical(rt.new_string(''), var_post_title)) {
		var_post_title = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('#%d (no title)')]), rt.get_property(var_post, 'ID')])
		}
		mut var_post_type_label := rt.get_property(rt.get_property(var_post_type_objects.array_get(rt.get_property(var_post, 'post_type')), 'labels'), 'singular_name')
		mut var_post_states := rt.call_function('get_post_states', [var_post.clone()])
		if !(!rt.is_true(var_post_states)) {
		var_post_type_label = rt.call_function('implode', [rt.new_string(','), var_post_states.clone()])
		}
		var_items.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: 'post-' + (rt.get_property(var_post, 'ID')).str() }, rt.ArrayItem{ key: 'title', val: rt.call_function('html_entity_decode', [var_post_title.clone(), rt.get_constant('ENT_QUOTES'), rt.call_function('get_bloginfo', [rt.new_string('charset')])]) }, rt.ArrayItem{ key: 'type', val: 'post_type' }, rt.ArrayItem{ key: 'type_label', val: var_post_type_label }, rt.ArrayItem{ key: 'object', val: rt.get_property(var_post, 'post_type') }, rt.ArrayItem{ key: 'object_id', val: rt.new_int((rt.get_property(var_post, 'ID')).to_i64()) }, rt.ArrayItem{ key: 'url', val: rt.call_function('get_permalink', [rt.new_int((rt.get_property(var_post, 'ID')).to_i64())]) }]))
	}
	mut var_taxonomies := rt.call_function('get_taxonomies', [rt.create_array([rt.ArrayItem{ key: 'show_in_nav_menus', val: true }]), rt.new_string('names')])
	mut var_terms := rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomies', val: var_taxonomies }, rt.ArrayItem{ key: 'name__like', val: var_args_mutated.array_get(rt.new_string('s')) }, rt.ArrayItem{ key: 'number', val: 20 }, rt.ArrayItem{ key: 'hide_empty', val: false }, rt.ArrayItem{ key: 'offset', val: rt.mul(rt.new_int(20), rt.sub(var_args_mutated.array_get(rt.new_string('pagenum')), rt.new_int(1))) }])])
	if !(!rt.is_true(var_terms)) {
		mut iter_6 := var_terms.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_term := item_6.val
			var_items.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: 'term-' + (rt.get_property(var_term, 'term_id')).str() }, rt.ArrayItem{ key: 'title', val: rt.call_function('html_entity_decode', [rt.get_property(var_term, 'name'), rt.get_constant('ENT_QUOTES'), rt.call_function('get_bloginfo', [rt.new_string('charset')])]) }, rt.ArrayItem{ key: 'type', val: 'taxonomy' }, rt.ArrayItem{ key: 'type_label', val: rt.get_property(rt.get_property(rt.call_function('get_taxonomy', [rt.get_property(var_term, 'taxonomy')]), 'labels'), 'singular_name') }, rt.ArrayItem{ key: 'object', val: rt.get_property(var_term, 'taxonomy') }, rt.ArrayItem{ key: 'object_id', val: rt.new_int((rt.get_property(var_term, 'term_id')).to_i64()) }, rt.ArrayItem{ key: 'url', val: rt.call_function('get_term_link', [rt.new_int((rt.get_property(var_term, 'term_id')).to_i64()), rt.get_property(var_term, 'taxonomy')]) }]))
		}
	}
	if var_args_mutated.array_isset(rt.new_string('s')) {
		mut var_front_page := rt.new_int(if rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')]))) { rt.new_int((rt.call_function('get_option', [rt.new_string('page_on_front')])).to_i64()) } else { 0 })
		if !rt.is_true(var_front_page) {
			mut var_title := rt.call_function('_x', [rt.new_string('Home'), rt.new_string('nav menu home label')])
			mut var_matches := rt.new_bool(if rt.is_true(rt.call_function('function_exists', [rt.new_string('mb_stripos')])) { rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('mb_stripos', [var_title.clone(), var_args_mutated.array_get(rt.new_string('s'))])))) } else { rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [var_title.clone(), var_args_mutated.array_get(rt.new_string('s'))])))) })
			if rt.is_true(var_matches) {
				var_items.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: 'home' }, rt.ArrayItem{ key: 'title', val: var_title }, rt.ArrayItem{ key: 'type', val: 'custom' }, rt.ArrayItem{ key: 'type_label', val: rt.call_function('__', [rt.new_string('Custom Link')]) }, rt.ArrayItem{ key: 'object', val: '' }, rt.ArrayItem{ key: 'url', val: rt.call_function('home_url', []rt.PhpVal{}) }]))
			}
		}
	}
	var_items = rt.call_function('apply_filters', [rt.new_string('customize_nav_menu_searched_items'), var_items.clone(), var_args_mutated.clone()])
	return var_items.clone()
}

fn (mut this Class_WP_Customize_Nav_Menus) enqueue_scripts() {
	rt.call_function('wp_enqueue_style', [rt.new_string('customize-nav-menus')])
	rt.call_function('wp_enqueue_script', [rt.new_string('customize-nav-menus')])
	mut var_temp_nav_menu_setting := create_wp_customize_nav_menu_setting(this.manager, rt.new_string('nav_menu[-1]'))
	mut var_temp_nav_menu_item_setting := create_wp_customize_nav_menu_item_setting(this.manager, rt.new_string('nav_menu_item[-1]'))
	mut var_num_locations := rt.new_int(rt.call_function('get_registered_nav_menus', []rt.PhpVal{}).array_count())
	if rt.is_true(rt.identical(rt.new_int(1), var_num_locations)) {
	mut var_locations_description := rt.call_function('__', [rt.new_string('Your theme can display menus in one location.')])
	} else {
	var_locations_description = rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('Your theme can display menus in %s location.'), rt.new_string('Your theme can display menus in %s locations.'), var_num_locations.clone()]), rt.call_function('number_format_i18n', [var_num_locations.clone()])])
	}
	mut var_settings := rt.create_array([rt.ArrayItem{ key: 'allMenus', val: rt.call_function('wp_get_nav_menus', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'itemTypes', val: this.available_item_types() }, rt.ArrayItem{ key: 'l10n', val: rt.create_array([rt.ArrayItem{ key: 'untitled', val: rt.call_function('_x', [rt.new_string('(no label)'), rt.new_string('missing menu item navigation label')]) }, rt.ArrayItem{ key: 'unnamed', val: rt.call_function('_x', [rt.new_string('(unnamed)'), rt.new_string('Missing menu name.')]) }, rt.ArrayItem{ key: 'custom_label', val: rt.call_function('__', [rt.new_string('Custom Link')]) }, rt.ArrayItem{ key: 'page_label', val: rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [rt.new_string('page')]), 'labels'), 'singular_name') }, rt.ArrayItem{ key: 'menuLocation', val: rt.call_function('_x', [rt.new_string('(Currently set to: %s)'), rt.new_string('menu')]) }, rt.ArrayItem{ key: 'locationsTitle', val: if rt.is_true(rt.identical(rt.new_int(1), var_num_locations)) { rt.call_function('__', [rt.new_string('Menu Location')]) } else { rt.call_function('__', [rt.new_string('Menu Locations')]) } }, rt.ArrayItem{ key: 'locationsDescription', val: var_locations_description }, rt.ArrayItem{ key: 'menuNameLabel', val: rt.call_function('__', [rt.new_string('Menu Name')]) }, rt.ArrayItem{ key: 'newMenuNameDescription', val: rt.call_function('__', [rt.new_string('If your theme has multiple menus, giving them clear names will help you manage them.')]) }, rt.ArrayItem{ key: 'itemAdded', val: rt.call_function('__', [rt.new_string('Menu item added')]) }, rt.ArrayItem{ key: 'itemDeleted', val: rt.call_function('__', [rt.new_string('Menu item deleted')]) }, rt.ArrayItem{ key: 'menuAdded', val: rt.call_function('__', [rt.new_string('Menu created')]) }, rt.ArrayItem{ key: 'menuDeleted', val: rt.call_function('__', [rt.new_string('Menu deleted')]) }, rt.ArrayItem{ key: 'movedUp', val: rt.call_function('__', [rt.new_string('Menu item moved up')]) }, rt.ArrayItem{ key: 'movedDown', val: rt.call_function('__', [rt.new_string('Menu item moved down')]) }, rt.ArrayItem{ key: 'movedLeft', val: rt.call_function('__', [rt.new_string('Menu item moved out of submenu')]) }, rt.ArrayItem{ key: 'movedRight', val: rt.call_function('__', [rt.new_string('Menu item is now a sub-item')]) }, rt.ArrayItem{ key: 'customizingMenus', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Customizing &#9656; %s')]), rt.call_function('esc_html', [rt.get_property(rt.call_method(this.manager, 'get_panel', [rt.new_string('nav_menus')]), 'title')])]) }, rt.ArrayItem{ key: 'invalidTitleTpl', val: rt.call_function('__', [rt.new_string('%s (Invalid)')]) }, rt.ArrayItem{ key: 'pendingTitleTpl', val: rt.call_function('__', [rt.new_string('%s (Pending)')]) }, rt.ArrayItem{ key: 'itemsFound', val: rt.call_function('__', [rt.new_string('Number of items found: %d')]) }, rt.ArrayItem{ key: 'itemsFoundMore', val: rt.call_function('__', [rt.new_string('Additional items found: %d')]) }, rt.ArrayItem{ key: 'itemsLoadingMore', val: rt.call_function('__', [rt.new_string('Loading more results... please wait.')]) }, rt.ArrayItem{ key: 'reorderModeOn', val: rt.call_function('__', [rt.new_string('Reorder mode enabled')]) }, rt.ArrayItem{ key: 'reorderModeOff', val: rt.call_function('__', [rt.new_string('Reorder mode closed')]) }, rt.ArrayItem{ key: 'reorderLabelOn', val: rt.call_function('esc_attr__', [rt.new_string('Reorder menu items')]) }, rt.ArrayItem{ key: 'reorderLabelOff', val: rt.call_function('esc_attr__', [rt.new_string('Close reorder mode')]) }]) }, rt.ArrayItem{ key: 'settingTransport', val: 'postMessage' }, rt.ArrayItem{ key: 'phpIntMax', val: rt.get_constant('PHP_INT_MAX') }, rt.ArrayItem{ key: 'defaultSettingValues', val: rt.create_array([rt.ArrayItem{ key: 'nav_menu', val: rt.get_property(var_temp_nav_menu_setting, 'default') }, rt.ArrayItem{ key: 'nav_menu_item', val: rt.get_property(var_temp_nav_menu_item_setting, 'default') }]) }, rt.ArrayItem{ key: 'locationSlugMappedToName', val: rt.call_function('get_registered_nav_menus', []rt.PhpVal{}) }])
	mut var_data := rt.call_function('sprintf', [rt.new_string('var _wpCustomizeNavMenusSettings = %s;'), rt.call_function('wp_json_encode', [var_settings.clone(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])])
	rt.call_method(rt.call_function('wp_scripts', []rt.PhpVal{}), 'add_data', [rt.new_string('customize-nav-menus'), rt.new_string('data'), var_data.clone()])
	mut var_nav_menus_l10n := { 'oneThemeLocationNoMenus': rt.new_null(), 'moveUp': rt.call_function('__', [rt.new_string('Move up one')]), 'moveDown': rt.call_function('__', [rt.new_string('Move down one')]), 'moveToTop': rt.call_function('__', [rt.new_string('Move to the top')]), 'moveUnder': rt.call_function('__', [rt.new_string('Move under %s')]), 'moveOutFrom': rt.call_function('__', [rt.new_string('Move out from under %s')]), 'under': rt.call_function('__', [rt.new_string('Under %s')]), 'outFrom': rt.call_function('__', [rt.new_string('Out from under %s')]), 'menuFocus': rt.call_function('__', [rt.new_string('Edit %1$s (%2$s, %3$d of %4$d)')]), 'subMenuFocus': rt.call_function('__', [rt.new_string('Edit %1$s (%2$s, sub-item %3$d of %4$d under %5$s)')]), 'subMenuMoreDepthFocus': rt.call_function('__', [rt.new_string('Edit %1$s (%2$s, sub-item %3$d of %4$d under %5$s, level %6$d)')]) }
	rt.call_function('wp_localize_script', [rt.new_string('nav-menu'), rt.new_string('menus'), rt.create_array_from_native_map(var_nav_menus_l10n)])
}

fn (mut this Class_WP_Customize_Nav_Menus) filter_dynamic_setting_args(var_setting_args rt.PhpVal, var_setting_id rt.PhpVal) rt.PhpVal {
	mut var_setting_args_mutated := var_setting_args
	mut var_setting_id_mutated := var_setting_id
	if rt.is_true(rt.call_function('preg_match', [Class_WP_Customize_Nav_Menu_Setting.id_pattern(), var_setting_id_mutated.clone()])) {
	var_setting_args_mutated = rt.create_array([rt.ArrayItem{ key: 'type', val: Class_WP_Customize_Nav_Menu_Setting.type() }, rt.ArrayItem{ key: 'transport', val: 'postMessage' }])
	} else if rt.is_true(rt.call_function('preg_match', [Class_WP_Customize_Nav_Menu_Item_Setting.id_pattern(), var_setting_id_mutated.clone()])) {
	var_setting_args_mutated = rt.create_array([rt.ArrayItem{ key: 'type', val: Class_WP_Customize_Nav_Menu_Item_Setting.type() }, rt.ArrayItem{ key: 'transport', val: 'postMessage' }])
	}
	return var_setting_args_mutated.clone()
}

fn (mut this Class_WP_Customize_Nav_Menus) filter_dynamic_setting_class(var_setting_class rt.PhpVal, var_setting_id rt.PhpVal, var_setting_args rt.PhpVal) rt.PhpVal {
	mut var_setting_class_mutated := var_setting_class
	mut var_setting_id_mutated := var_setting_id
	mut var_setting_args_mutated := var_setting_args
	var_setting_id_mutated = rt.new_null()
	if !(!rt.is_true(var_setting_args_mutated.array_get(rt.new_string('type')))) && rt.is_true(rt.identical(Class_WP_Customize_Nav_Menu_Setting.type(), var_setting_args_mutated.array_get(rt.new_string('type')))) {
	var_setting_class_mutated = rt.new_string('WP_Customize_Nav_Menu_Setting')
	} else if !(!rt.is_true(var_setting_args_mutated.array_get(rt.new_string('type')))) && rt.is_true(rt.identical(Class_WP_Customize_Nav_Menu_Item_Setting.type(), var_setting_args_mutated.array_get(rt.new_string('type')))) {
	var_setting_class_mutated = rt.new_string('WP_Customize_Nav_Menu_Item_Setting')
	}
	return var_setting_class_mutated.clone()
}

fn (mut this Class_WP_Customize_Nav_Menus) customize_register() {
	mut var_changeset := rt.call_method(this.manager, 'unsanitized_post_values', []rt.PhpVal{})
	mut var_nav_menus_setting_ids := map[string]rt.PhpVal{}
	mut iter_7 := rt.func_array_keys(var_changeset.clone()).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_setting_id := item_7.val
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^(nav_menu_locations|nav_menu|nav_menu_item)\\[/'), var_setting_id.clone()])) {
			var_nav_menus_setting_ids << var_setting_id.clone()
		}
	}
	mut var_settings := rt.call_method(this.manager, 'add_dynamic_settings', [rt.create_array_from_list(var_nav_menus_setting_ids)])
	if rt.is_true(rt.call_method(this.manager, 'settings_previewed', []rt.PhpVal{})) {
		mut iter_8 := var_settings.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_setting := item_8.val
			rt.call_method(var_setting, 'preview', []rt.PhpVal{})
		}
	}
	rt.call_method(this.manager, 'register_panel_type', [rt.new_string('WP_Customize_Nav_Menus_Panel')])
	rt.call_method(this.manager, 'register_control_type', [rt.new_string('WP_Customize_Nav_Menu_Control')])
	rt.call_method(this.manager, 'register_control_type', [rt.new_string('WP_Customize_Nav_Menu_Name_Control')])
	rt.call_method(this.manager, 'register_control_type', [rt.new_string('WP_Customize_Nav_Menu_Locations_Control')])
	rt.call_method(this.manager, 'register_control_type', [rt.new_string('WP_Customize_Nav_Menu_Auto_Add_Control')])
	rt.call_method(this.manager, 'register_control_type', [rt.new_string('WP_Customize_Nav_Menu_Item_Control')])
	mut var_description := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('This panel is used for managing navigation menus for content you have already published on your site. You can create menus and add items for existing content such as pages, posts, categories, tags, formats, or custom links.')])).str() + '</p>')
	if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('widgets')])) {
		var_description = rt.concat(var_description, rt.new_string('<p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Menus can be displayed in locations defined by your theme or in <a href="%s">widget areas</a> by adding a &#8220;Navigation Menu&#8221; widget.')]), rt.new_string('javascript:wp.customize.panel( \'widgets\' ).focus();')])).str() + '</p>'))
	} else {
		var_description = rt.concat(var_description, rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('Menus can be displayed in locations defined by your theme.')])).str() + '</p>'))
	}
	rt.call_method(this.manager, 'add_panel', [create_wp_customize_nav_menus_panel(this.manager, rt.new_string('nav_menus'), rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Menus')]) }, rt.ArrayItem{ key: 'description', val: var_description }, rt.ArrayItem{ key: 'priority', val: 100 }]))])
	mut var_menus := rt.call_function('wp_get_nav_menus', []rt.PhpVal{})
	mut var_locations := rt.call_function('get_registered_nav_menus', []rt.PhpVal{})
	mut var_num_locations := rt.new_int(var_locations.clone().array_count())
	if rt.is_true(rt.identical(rt.new_int(1), var_num_locations)) {
	var_description = rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('Your theme can display menus in one location. Select which menu you would like to use.')])).str() + '</p>')
	} else {
	var_description = rt.new_string('<p>' + (rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('Your theme can display menus in %s location. Select which menu you would like to use.'), rt.new_string('Your theme can display menus in %s locations. Select which menu appears in each location.'), var_num_locations.clone()]), rt.call_function('number_format_i18n', [var_num_locations.clone()])])).str() + '</p>')
	}
	if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('widgets')])) {
		var_description = rt.concat(var_description, rt.new_string('<p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('If your theme has widget areas, you can also add menus there. Visit the <a href="%s">Widgets panel</a> and add a &#8220;Navigation Menu widget&#8221; to display a menu in a sidebar or footer.')]), rt.new_string('javascript:wp.customize.panel( \'widgets\' ).focus();')])).str() + '</p>'))
	}
	rt.call_method(this.manager, 'add_section', [rt.new_string('menu_locations'), rt.create_array([rt.ArrayItem{ key: 'title', val: if rt.is_true(rt.identical(rt.new_int(1), var_num_locations)) { rt.call_function('_x', [rt.new_string('View Location'), rt.new_string('menu locations')]) } else { rt.call_function('_x', [rt.new_string('View All Locations'), rt.new_string('menu locations')]) } }, rt.ArrayItem{ key: 'panel', val: 'nav_menus' }, rt.ArrayItem{ key: 'priority', val: 30 }, rt.ArrayItem{ key: 'description', val: var_description }])])
	mut var_choices := rt.create_array([rt.ArrayItem{ key: '0', val: rt.call_function('__', [rt.new_string('&mdash; Select &mdash;')]) }])
	mut iter_9 := var_menus.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_menu := item_9.val
		var_choices.array_set(rt.get_property(var_menu, 'term_id'), rt.call_function('wp_html_excerpt', [rt.get_property(var_menu, 'name'), rt.new_int(40), rt.new_string('&hellip;')]))
	}
	mut var_mapped_nav_menu_locations := map[string]rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.manager, 'is_theme_active', []rt.PhpVal{}))))) {
		mut var_theme_mods := rt.call_function('get_option', [rt.new_string('theme_mods_' + (rt.call_method(this.manager, 'get_stylesheet', []rt.PhpVal{})).str()), map[string]rt.PhpVal{}])
		if !rt.is_true(var_theme_mods.array_get(rt.new_string('nav_menu_locations'))) {
			var_theme_mods.array_set('nav_menu_locations', map[string]rt.PhpVal{})
		}
	var_mapped_nav_menu_locations = rt.call_function('wp_map_nav_menu_locations', [var_theme_mods.array_get(rt.new_string('nav_menu_locations')), this.original_nav_menu_locations])
	}
	mut iter_10 := var_locations.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_description_shadow := item_10.val
		mut var_location := item_10.key
		mut var_setting_id := rt.new_string("nav_menu_locations[${var_location.to_string()}]")
		mut var_setting := rt.call_method(this.manager, 'get_setting', [var_setting_id.clone()])
		if rt.is_true(var_setting) {
			rt.set_property(var_setting, 'transport', rt.new_string('postMessage'))
			rt.call_function('remove_filter', [rt.new_string("customize_sanitize_${var_setting_id.to_string()}"), rt.new_string('absint')])
			rt.call_function('add_filter', [rt.new_string("customize_sanitize_${var_setting_id.to_string()}"), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menus', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'intval_base10' }])])
		} else {
			rt.call_method(this.manager, 'add_setting', [var_setting_id.clone(), rt.create_array([rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menus', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'intval_base10' }]) }, rt.ArrayItem{ key: 'theme_supports', val: 'menus' }, rt.ArrayItem{ key: 'type', val: 'theme_mod' }, rt.ArrayItem{ key: 'transport', val: 'postMessage' }, rt.ArrayItem{ key: 'default', val: 0 }])])
		}
		if !rt.is_true(var_changeset.array_get(var_setting_id)) && var_mapped_nav_menu_locations.array_isset(var_location) {
			rt.call_method(this.manager, 'set_post_value', [var_setting_id.clone(), var_mapped_nav_menu_locations.array_get(var_location)])
		}
		rt.call_method(this.manager, 'add_control', [create_wp_customize_nav_menu_location_control(this.manager, var_setting_id.clone(), rt.create_array([rt.ArrayItem{ key: 'label', val: var_description_shadow }, rt.ArrayItem{ key: 'location_id', val: var_location }, rt.ArrayItem{ key: 'section', val: 'menu_locations' }, rt.ArrayItem{ key: 'choices', val: var_choices }]))])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('get_post_states')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/template.php', '4')
	}
	mut iter_11 := var_menus.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_menu := item_11.val
		mut var_menu_id := rt.get_property(var_menu, 'term_id')
		mut var_section_id := rt.new_string('nav_menu[' + (var_menu_id).str() + ']')
		rt.call_method(this.manager, 'add_section', [create_wp_customize_nav_menu_section(this.manager, var_section_id.clone(), rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('html_entity_decode', [rt.get_property(var_menu, 'name'), rt.get_constant('ENT_QUOTES'), rt.call_function('get_bloginfo', [rt.new_string('charset')])]) }, rt.ArrayItem{ key: 'priority', val: 10 }, rt.ArrayItem{ key: 'panel', val: 'nav_menus' }]))])
		mut var_nav_menu_setting_id := rt.new_string('nav_menu[' + (var_menu_id).str() + ']')
		rt.call_method(this.manager, 'add_setting', [create_wp_customize_nav_menu_setting(this.manager, var_nav_menu_setting_id.clone(), rt.create_array([rt.ArrayItem{ key: 'transport', val: 'postMessage' }]))])
		mut var_menu_items := rt.cast_array(rt.call_function('wp_get_nav_menu_items', [var_menu_id.clone()]))
		mut iter_12 := rt.call_function('array_values', [var_menu_items.clone()]).iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_item := item_12.val
			mut var_i := item_12.key
			mut var_menu_item_setting_id := rt.new_string('nav_menu_item[' + (rt.get_property(var_item, 'ID')).str() + ']')
			mut var_value := rt.cast_array(var_item)
			if !rt.is_true(var_value.array_get(rt.new_string('post_title'))) {
				var_value.array_set('title', '')
			}
			var_value.array_set('nav_menu_term_id', var_menu_id.clone())
			rt.call_method(this.manager, 'add_setting', [create_wp_customize_nav_menu_item_setting(this.manager, var_menu_item_setting_id.clone(), rt.create_array([rt.ArrayItem{ key: 'value', val: var_value }, rt.ArrayItem{ key: 'transport', val: 'postMessage' }]))])
			rt.call_method(this.manager, 'add_control', [create_wp_customize_nav_menu_item_control(this.manager, var_menu_item_setting_id.clone(), rt.create_array([rt.ArrayItem{ key: 'label', val: rt.get_property(var_item, 'title') }, rt.ArrayItem{ key: 'section', val: var_section_id }, rt.ArrayItem{ key: 'priority', val: rt.add(rt.new_int(10), var_i) }]))])
		}
	}
	rt.call_method(this.manager, 'add_section', [rt.new_string('add_menu'), rt.create_array([rt.ArrayItem{ key: 'type', val: 'new_menu' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('New Menu')]) }, rt.ArrayItem{ key: 'panel', val: 'nav_menus' }, rt.ArrayItem{ key: 'priority', val: 20 }])])
	rt.call_method(this.manager, 'add_setting', [create_wp_customize_filter_setting(this.manager, rt.new_string('nav_menus_created_posts'), rt.create_array([rt.ArrayItem{ key: 'transport', val: 'postMessage' }, rt.ArrayItem{ key: 'type', val: 'option' }, rt.ArrayItem{ key: 'default', val: map[string]rt.PhpVal{} }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menus', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'sanitize_nav_menus_created_posts' }]) }]))])
}

fn (mut this Class_WP_Customize_Nav_Menus) intval_base10(var_value rt.PhpVal) i64 {
	mut var_value_mutated := var_value
	return var_value_mutated.clone().to_i64()
}

fn (mut this Class_WP_Customize_Nav_Menus) available_item_types() rt.PhpVal {
	mut var_item_types := map[string]rt.PhpVal{}
	mut var_post_types := rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'show_in_nav_menus', val: true }]), rt.new_string('objects')])
	if rt.is_true(var_post_types) {
		mut iter_13 := var_post_types.iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_post_type := item_13.val
			mut var_slug := item_13.key
			var_item_types.array_push(rt.create_array([rt.ArrayItem{ key: 'title', val: rt.get_property(rt.get_property(var_post_type, 'labels'), 'name') }, rt.ArrayItem{ key: 'type_label', val: rt.get_property(rt.get_property(var_post_type, 'labels'), 'singular_name') }, rt.ArrayItem{ key: 'type', val: 'post_type' }, rt.ArrayItem{ key: 'object', val: rt.get_property(var_post_type, 'name') }]))
		}
	}
	mut var_taxonomies := rt.call_function('get_taxonomies', [rt.create_array([rt.ArrayItem{ key: 'show_in_nav_menus', val: true }]), rt.new_string('objects')])
	if rt.is_true(var_taxonomies) {
		mut iter_14 := var_taxonomies.iterator()
		for {
			item_14 := iter_14.next() or { break }
			mut var_taxonomy := item_14.val
			mut var_slug := item_14.key
			if rt.is_true(rt.identical(rt.new_string('post_format'), var_taxonomy)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('post-formats')]))))) {
				continue
			}
			var_item_types.array_push(rt.create_array([rt.ArrayItem{ key: 'title', val: rt.get_property(rt.get_property(var_taxonomy, 'labels'), 'name') }, rt.ArrayItem{ key: 'type_label', val: rt.get_property(rt.get_property(var_taxonomy, 'labels'), 'singular_name') }, rt.ArrayItem{ key: 'type', val: 'taxonomy' }, rt.ArrayItem{ key: 'object', val: rt.get_property(var_taxonomy, 'name') }]))
		}
	}
	var_item_types = rt.call_function('apply_filters', [rt.new_string('customize_nav_menu_available_item_types'), var_item_types.clone()])
	return var_item_types.clone()
}

fn (mut this Class_WP_Customize_Nav_Menus) insert_auto_draft_post(var_postarr rt.PhpVal) rt.PhpVal {
	mut var_postarr_mutated := var_postarr
	if !(var_postarr_mutated.array_isset(rt.new_string('post_type'))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('unknown_post_type'), rt.call_function('__', [rt.new_string('Invalid post type.')])))
	}
	if !rt.is_true(var_postarr_mutated.array_get(rt.new_string('post_title'))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('empty_title'), rt.call_function('__', [rt.new_string('Empty title.')])))
	}
	if !(!rt.is_true(var_postarr_mutated.array_get(rt.new_string('post_status')))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('status_forbidden'), rt.call_function('__', [rt.new_string('Status is forbidden.')])))
	}
	var_postarr_mutated.array_set('post_status', 'auto-draft')
	if !rt.is_true(var_postarr_mutated.array_get(rt.new_string('post_name'))) {
		var_postarr_mutated.array_set('post_name', rt.call_function('sanitize_title', [var_postarr_mutated.array_get(rt.new_string('post_title'))]))
	}
	if !(var_postarr_mutated.array_isset(rt.new_string('meta_input'))) {
		var_postarr_mutated.array_set('meta_input', map[string]rt.PhpVal{})
	}
	var_postarr_mutated.array_get_mut('meta_input').array_set('_customize_draft_post_name', var_postarr_mutated.array_get(rt.new_string('post_name')))
	var_postarr_mutated.array_get_mut('meta_input').array_set('_customize_changeset_uuid', rt.call_method(this.manager, 'changeset_uuid', []rt.PhpVal{}))
	var_postarr_mutated.array_unset(rt.new_string('post_name'))
	rt.call_function('add_filter', [rt.new_string('wp_insert_post_empty_content'), rt.new_string('__return_false'), rt.new_int(1000)])
	mut var_r := rt.call_function('wp_insert_post', [rt.call_function('wp_slash', [var_postarr_mutated.clone()]), rt.new_bool(true)])
	rt.call_function('remove_filter', [rt.new_string('wp_insert_post_empty_content'), rt.new_string('__return_false'), rt.new_int(1000)])
	if rt.is_true(rt.call_function('is_wp_error', [var_r.clone()])) {
		return var_r.clone()
	} else {
		return rt.call_function('get_post', [var_r.clone()])
	}
	return rt.new_null()
}

fn (mut this Class_WP_Customize_Nav_Menus) ajax_insert_auto_draft_post() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('check_ajax_referer', [rt.new_string('customize-menus'), rt.new_string('customize-menus-nonce'), rt.new_bool(false)]))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('bad_nonce'), rt.new_int(400)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('customize')]))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('customize_not_allowed'), rt.new_int(403)])
	}
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('params'))) || !(rt.get_superglobal('_POST').array_get(rt.new_string('params')).is_array()) {
		rt.call_function('wp_send_json_error', [rt.new_string('missing_params'), rt.new_int(400)])
	}
	mut var_params := rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('params'))])
	mut var_illegal_params := rt.call_function('array_diff', [rt.func_array_keys(var_params.clone()), rt.create_array([rt.ArrayItem{ key: none, val: 'post_type' }, rt.ArrayItem{ key: none, val: 'post_title' }])])
	if !(!rt.is_true(var_illegal_params)) {
		rt.call_function('wp_send_json_error', [rt.new_string('illegal_params'), rt.new_int(400)])
	}
	var_params = rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'post_type', val: '' }, rt.ArrayItem{ key: 'post_title', val: '' }]), var_params.clone()])
	if !rt.is_true(var_params.array_get(rt.new_string('post_type'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('post_type_exists', [var_params.array_get(rt.new_string('post_type'))]))))) {
		rt.call_function('status_header', [rt.new_int(400)])
		rt.call_function('wp_send_json_error', [rt.new_string('missing_post_type_param')])
	}
	mut var_post_type_object := rt.call_function('get_post_type_object', [var_params.array_get(rt.new_string('post_type'))])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_object, 'cap'), 'create_posts')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_object, 'cap'), 'publish_posts')]))))) {
		rt.call_function('status_header', [rt.new_int(403)])
		rt.call_function('wp_send_json_error', [rt.new_string('insufficient_post_permissions')])
	}
	var_params.array_set('post_title', var_params.array_get(rt.new_string('post_title')).to_string().trim_space())
	if rt.is_true(rt.identical(rt.new_string(''), var_params.array_get(rt.new_string('post_title')))) {
		rt.call_function('status_header', [rt.new_int(400)])
		rt.call_function('wp_send_json_error', [rt.new_string('missing_post_title')])
	}
	mut var_r := this.insert_auto_draft_post(var_params.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_r.clone()])) {
		mut var_error := var_r.clone()
		if !(!rt.is_true(rt.get_property(rt.get_property(var_post_type_object, 'labels'), 'singular_name'))) {
		mut var_singular_name := rt.get_property(rt.get_property(var_post_type_object, 'labels'), 'singular_name')
		} else {
		var_singular_name = rt.call_function('__', [rt.new_string('Post')])
		}
		mut var_data := rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s could not be created: %2$s')]), var_singular_name.clone(), rt.call_method(var_error, 'get_error_message', []rt.PhpVal{})]) }])
		rt.call_function('wp_send_json_error', [var_data.clone()])
	} else {
		mut var_post := var_r.clone()
		var_data = rt.create_array([rt.ArrayItem{ key: 'post_id', val: rt.get_property(var_post, 'ID') }, rt.ArrayItem{ key: 'url', val: rt.call_function('get_permalink', [rt.get_property(var_post, 'ID')]) }])
		rt.call_function('wp_send_json_success', [var_data.clone()])
	}
}

fn (mut this Class_WP_Customize_Nav_Menus) print_templates() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('__', [rt.new_string('Add to menu: %1$s (%2$s)')]), rt.new_string('{{ data.title || wp.customize.Menus.data.l10n.untitled }}'), rt.new_string('{{ data.type_label }}')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.new_string('<button type="button" class="menus-move-up">%1$s</button><button type="button" class="menus-move-down">%2$s</button><button type="button" class="menus-move-left">%3$s</button><button type="button" class="menus-move-right">%4$s</button>'), rt.call_function('__', [rt.new_string('Move up')]), rt.call_function('__', [rt.new_string('Move down')]), rt.call_function('__', [rt.new_string('Move one level up')]), rt.call_function('__', [rt.new_string('Move one level down')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Delete Menu')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Click &#8220;Next&#8221; to start adding links to your new menu.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Next')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('It does not look like your site has any menus yet. Want to build one? Click the button to start.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('You&#8217;ll create a menu, assign it a location, and add menu items like links to pages and categories. If your theme has multiple menu areas, you might need to create more than one.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Create New Menu')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Customize_Nav_Menus) available_items_template() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Back')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('__', [rt.new_string('Customizing &#9656; %s')]), rt.call_function('esc_html', [rt.get_property(rt.call_method(this.manager, 'get_panel', [rt.new_string('nav_menus')]), 'title')])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Add Menu Items')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Search Menu Items')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('The search results will be updated as you type.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Clear Results')])
	// unsupported statement: Stmt_InlineHTML
	mut var_item_types := this.available_item_types()
	mut var_page_item_type := rt.new_null()
	mut iter_15 := var_item_types.iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_item_type := item_15.val
		mut var_i := item_15.key
		if var_item_type.array_isset(rt.new_string('object')) && rt.is_true(rt.identical(rt.new_string('page'), var_item_type.array_get(rt.new_string('object')))) {
			var_page_item_type = var_item_type
			var_item_types.array_unset(var_i)
		}
	}
	this.print_custom_links_available_menu_item()
	if rt.is_true(var_page_item_type) {
		this.print_post_type_container(var_page_item_type.clone())
	}
	mut iter_16 := var_item_types.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_item_type := item_16.val
		this.print_post_type_container(var_item_type.clone())
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Customize_Nav_Menus) print_post_type_container(var_available_item_type rt.PhpVal) {
	mut var_id := rt.call_function('sprintf', [rt.new_string('available-menu-items-%s-%s'), var_available_item_type.array_get(rt.new_string('type')), var_available_item_type.array_get(rt.new_string('object'))])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_available_item_type.array_get(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('No items')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('post_type'), var_available_item_type.array_get(rt.new_string('type')))) {
		// unsupported statement: Stmt_InlineHTML
		mut var_post_type_obj := rt.call_function('get_post_type_object', [var_available_item_type.array_get(rt.new_string('object'))])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_obj, 'cap'), 'create_posts')])) && rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_obj, 'cap'), 'publish_posts')])) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.new_string('create-item-input-' + (var_available_item_type.array_get(rt.new_string('object'))).str())]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [rt.get_property(rt.get_property(var_post_type_obj, 'labels'), 'add_new_item')]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.new_string('create-item-input-' + (var_available_item_type.array_get(rt.new_string('object'))).str())]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Add')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_available_item_type.array_get(rt.new_string('object'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Please enter an item title')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_available_item_type.array_get(rt.new_string('type'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_available_item_type.array_get(rt.new_string('object'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [if !(var_available_item_type.array_get(rt.new_string('type_label'))).is_null() { var_available_item_type.array_get(rt.new_string('type_label')) } else { var_available_item_type.array_get(rt.new_string('type')) }]))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Customize_Nav_Menus) print_custom_links_available_menu_item() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Custom Links')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('URL')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Please provide a valid link.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Link Text')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('The link text cannot be empty.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Add to Menu')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Customize_Nav_Menus) customize_dynamic_partial_args(var_partial_args rt.PhpVal, var_partial_id rt.PhpVal) rt.PhpVal {
	mut var_partial_args_mutated := var_partial_args
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^nav_menu_instance\\[[0-9a-f]{32}\\]$/'), var_partial_id.clone()])) {
		if rt.is_true(rt.identical(rt.new_bool(false), var_partial_args_mutated)) {
		var_partial_args_mutated = map[string]rt.PhpVal{}
		}
	var_partial_args_mutated = rt.call_function('array_merge', [var_partial_args_mutated.clone(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'nav_menu_instance' }, rt.ArrayItem{ key: 'render_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menus', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_nav_menu_partial' }]) }, rt.ArrayItem{ key: 'container_inclusive', val: true }, rt.ArrayItem{ key: 'settings', val: map[string]rt.PhpVal{} }, rt.ArrayItem{ key: 'capability', val: 'edit_theme_options' }])])
	}
	return var_partial_args_mutated.clone()
}

fn (mut this Class_WP_Customize_Nav_Menus) customize_preview_init() {
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menus', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'customize_preview_enqueue_deps' }])])
	rt.call_function('add_filter', [rt.new_string('wp_nav_menu_args'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menus', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'filter_wp_nav_menu_args' }]), rt.new_int(1000)])
	rt.call_function('add_filter', [rt.new_string('wp_nav_menu'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menus', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'filter_wp_nav_menu' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('wp_footer'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menus', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'export_preview_data' }]), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('customize_render_partials_response'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menus', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'export_partial_rendered_nav_menu_instances' }])])
}

fn (mut this Class_WP_Customize_Nav_Menus) make_auto_draft_status_previewable() {
	mut var_wp_post_statuses := rt.new_null()
	rt.set_property(var_wp_post_statuses.array_get(rt.new_string('auto-draft')), 'protected', rt.new_bool(true))
}

fn (mut this Class_WP_Customize_Nav_Menus) sanitize_nav_menus_created_posts(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_post_ids := map[string]rt.PhpVal{}
	mut iter_17 := rt.call_function('wp_parse_id_list', [var_value_mutated.clone()]).iterator()
	for {
		item_17 := iter_17.next() or { break }
		mut var_post_id := item_17.val
		if !rt.is_true(var_post_id) {
			continue
		}
		mut var_post := rt.call_function('get_post', [var_post_id.clone()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('auto-draft'), rt.get_property(var_post, 'post_status'))))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('draft'), rt.get_property(var_post, 'post_status'))))) {
			continue
		}
		mut var_post_type_obj := rt.call_function('get_post_type_object', [rt.get_property(var_post, 'post_type')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type_obj)))) {
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_obj, 'cap'), 'publish_posts')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), var_post_id.clone()]))))) {
			continue
		}
		var_post_ids.array_push(rt.get_property(var_post, 'ID'))
	}
	return var_post_ids.clone()
}

fn (mut this Class_WP_Customize_Nav_Menus) save_nav_menus_created_posts(var_setting rt.PhpVal) {
	mut var_setting_mutated := var_setting
	mut var_post_ids := rt.call_method(var_setting_mutated, 'post_value', []rt.PhpVal{})
	if !(!rt.is_true(var_post_ids)) {
		mut iter_18 := var_post_ids.iterator()
		for {
			item_18 := iter_18.next() or { break }
			mut var_post_id := item_18.val
			mut var_current_status := rt.call_function('get_post_status', [var_post_id.clone()])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('auto-draft'), var_current_status)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('draft'), var_current_status)))) {
				continue
			}
			mut var_target_status := rt.new_string((if rt.is_true(rt.identical(rt.new_string('attachment'), rt.call_function('get_post_type', [var_post_id.clone()]))) { 'inherit' } else { 'publish' }).str())
			mut var_args := { 'ID': var_post_id, 'post_status': var_target_status }
			mut var_post_name := rt.call_function('get_post_meta', [var_post_id.clone(), rt.new_string('_customize_draft_post_name'), rt.new_bool(true)])
			if rt.is_true(var_post_name) {
				var_args['post_name'] = var_post_name.clone()
			}
			rt.call_function('wp_update_post', [rt.call_function('wp_slash', [rt.create_array_from_native_map(var_args)])])
			rt.call_function('delete_post_meta', [var_post_id.clone(), rt.new_string('_customize_draft_post_name')])
		}
	}
}

fn (mut this Class_WP_Customize_Nav_Menus) filter_wp_nav_menu_args(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_can_partial_refresh := rt.new_bool(!(!rt.is_true(var_args_mutated.array_get(rt.new_string('echo')))) && !rt.is_true(var_args_mutated.array_get(rt.new_string('fallback_cb'))) || var_args_mutated.array_get(rt.new_string('fallback_cb')).is_string() && !rt.is_true(var_args_mutated.array_get(rt.new_string('walker'))) || var_args_mutated.array_get(rt.new_string('walker')).is_string() && !(!rt.is_true(var_args_mutated.array_get(rt.new_string('theme_location')))) || (!(!rt.is_true(var_args_mutated.array_get(rt.new_string('menu')))) && var_args_mutated.array_get(rt.new_string('menu')).is_long() || var_args_mutated.array_get(rt.new_string('menu')).is_double() || var_args_mutated.array_get(rt.new_string('menu')).is_object()) && !(!rt.is_true(var_args_mutated.array_get(rt.new_string('container')))) || (var_args_mutated.array_isset(rt.new_string('items_wrap')) && rt.is_true(rt.call_function('str_starts_with', [var_args_mutated.array_get(rt.new_string('items_wrap')), rt.new_string('<')]))))
	var_args_mutated.array_set('can_partial_refresh', var_can_partial_refresh.clone())
	mut var_exported_args := var_args_mutated.clone()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_can_partial_refresh)))) {
		var_exported_args.array_set('fallback_cb', '')
		var_exported_args.array_set('walker', '')
	}
	if !(!rt.is_true(var_exported_args.array_get(rt.new_string('menu')))) && var_exported_args.array_get(rt.new_string('menu')).is_object() {
		var_exported_args.array_set('menu', rt.get_property(var_exported_args.array_get(rt.new_string('menu')), 'term_id'))
	}
	rt.call_function('ksort', [var_exported_args.clone()])
	var_exported_args.array_set('args_hmac', this.hash_nav_menu_args(var_exported_args.clone()))
	var_args_mutated.array_set('customize_preview_nav_menus_args', var_exported_args.clone())
	this.preview_nav_menu_instance_args.array_set(var_exported_args.array_get(rt.new_string('args_hmac')), var_exported_args.clone())
	return var_args_mutated.clone()
}

fn (mut this Class_WP_Customize_Nav_Menus) filter_wp_nav_menu(var_nav_menu_content rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_nav_menu_content_mutated := var_nav_menu_content
	mut var_args_mutated := var_args
	if rt.get_property(var_args_mutated, 'customize_preview_nav_menus_args').array_isset(rt.new_string('can_partial_refresh')) && rt.is_true(rt.get_property(var_args_mutated, 'customize_preview_nav_menus_args').array_get(rt.new_string('can_partial_refresh'))) {
		mut var_attributes := rt.call_function('sprintf', [rt.new_string(' data-customize-partial-id="%s"'), rt.call_function('esc_attr', [rt.new_string('nav_menu_instance[' + (rt.get_property(var_args_mutated, 'customize_preview_nav_menus_args').array_get(rt.new_string('args_hmac'))).str() + ']')])])
		var_attributes = rt.concat(var_attributes, rt.new_string(' data-customize-partial-type="nav_menu_instance"'))
		var_attributes = rt.concat(var_attributes, rt.call_function('sprintf', [rt.new_string(' data-customize-partial-placement-context="%s"'), rt.call_function('esc_attr', [rt.call_function('wp_json_encode', [rt.get_property(var_args_mutated, 'customize_preview_nav_menus_args')])])]))
	var_nav_menu_content_mutated = rt.call_function('preg_replace', [rt.new_string('#^(<\\w+)#'), rt.new_string('$1 ' + (rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('\\\\'), var_attributes.clone()])).str()), var_nav_menu_content_mutated.clone(), rt.new_int(1)])
	}
	return var_nav_menu_content_mutated.clone()
}

fn (mut this Class_WP_Customize_Nav_Menus) hash_nav_menu_args(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	return rt.call_function('wp_hash', [rt.call_function('serialize', [var_args_mutated.clone()])])
}

fn (mut this Class_WP_Customize_Nav_Menus) customize_preview_enqueue_deps() {
	rt.call_function('wp_enqueue_script', [rt.new_string('customize-preview-nav-menus')])
}

fn (mut this Class_WP_Customize_Nav_Menus) export_preview_data() {
	mut var_exports := { 'navMenuInstanceArgs': this.preview_nav_menu_instance_args }
	rt.call_function('wp_print_inline_script_tag', [rt.new_string((rt.call_function('sprintf', [rt.new_string('var _wpCustomizePreviewNavMenusExports = %s;'), rt.call_function('wp_json_encode', [rt.create_array_from_native_map(var_exports), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])])).str() + '\n//# sourceURL=' + (rt.call_function('rawurlencode', [rt.new_string(@METHOD)])).str())])
}

fn (mut this Class_WP_Customize_Nav_Menus) export_partial_rendered_nav_menu_instances(var_response rt.PhpVal) rt.PhpVal {
	mut var_response_mutated := var_response
	var_response_mutated.array_set('nav_menu_instance_args', this.preview_nav_menu_instance_args)
	return var_response_mutated.clone()
}

fn (mut this Class_WP_Customize_Nav_Menus) render_nav_menu_partial(var_partial rt.PhpVal, var_nav_menu_args rt.PhpVal) bool {
	mut var_partial_mutated := var_partial
	var_partial_mutated = rt.new_null()
	if !(var_nav_menu_args.array_isset(rt.new_string('args_hmac'))) {
		return false
	}
	mut var_nav_menu_args_hmac := var_nav_menu_args.array_get(rt.new_string('args_hmac'))
	var_nav_menu_args.array_unset(rt.new_string('args_hmac'))
	rt.call_function('ksort', [var_nav_menu_args.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_equals', [this.hash_nav_menu_args(var_nav_menu_args.clone()), var_nav_menu_args_hmac.clone()]))))) {
		return false
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('wp_nav_menu', [var_nav_menu_args.clone()])
	mut var_content := rt.call_function('ob_get_clean', []rt.PhpVal{})
	return (var_content).to_bool()
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

struct Class_WP_Customize_Nav_Menu_Setting {
	rt.PhpObjectBase
}

struct Class_WP_Customize_Nav_Menu_Item_Setting {
	rt.PhpObjectBase
}

struct Class_WP_Customize_Nav_Menus_Panel {
	rt.PhpObjectBase
}

struct Class_WP_Customize_Nav_Menu_Location_Control {
	rt.PhpObjectBase
}

struct Class_WP_Customize_Nav_Menu_Section {
	rt.PhpObjectBase
}

struct Class_WP_Customize_Nav_Menu_Item_Control {
	rt.PhpObjectBase
}

struct Class_WP_Customize_Filter_Setting {
	rt.PhpObjectBase
}

fn create_wp_customize_nav_menus(arg_0 rt.PhpVal) &Class_WP_Customize_Nav_Menus {
	mut obj := &Class_WP_Customize_Nav_Menus{
		PhpObjectBase: rt.PhpObjectBase{}
		manager: rt.new_null()
		original_nav_menu_locations: rt.new_null()
		preview_nav_menu_instance_args: rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
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

fn create_wp_customize_nav_menu_setting(_args ...rt.PhpVal) &Class_WP_Customize_Nav_Menu_Setting {
	mut obj := &Class_WP_Customize_Nav_Menu_Setting{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_nav_menu_item_setting(_args ...rt.PhpVal) &Class_WP_Customize_Nav_Menu_Item_Setting {
	mut obj := &Class_WP_Customize_Nav_Menu_Item_Setting{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_nav_menus_panel(_args ...rt.PhpVal) &Class_WP_Customize_Nav_Menus_Panel {
	mut obj := &Class_WP_Customize_Nav_Menus_Panel{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_nav_menu_location_control(_args ...rt.PhpVal) &Class_WP_Customize_Nav_Menu_Location_Control {
	mut obj := &Class_WP_Customize_Nav_Menu_Location_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_nav_menu_section(_args ...rt.PhpVal) &Class_WP_Customize_Nav_Menu_Section {
	mut obj := &Class_WP_Customize_Nav_Menu_Section{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_nav_menu_item_control(_args ...rt.PhpVal) &Class_WP_Customize_Nav_Menu_Item_Control {
	mut obj := &Class_WP_Customize_Nav_Menu_Item_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_filter_setting(_args ...rt.PhpVal) &Class_WP_Customize_Filter_Setting {
	mut obj := &Class_WP_Customize_Filter_Setting{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Nav_Menus) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'filter_nonces' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_nonces(dispatch_arg_0)
		}
		'ajax_load_available_items' {
			this.ajax_load_available_items()
			return rt.new_null()
		}
		'load_available_items_query' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.load_available_items_query(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'ajax_search_available_items' {
			this.ajax_search_available_items()
			return rt.new_null()
		}
		'search_available_items_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.search_available_items_query(dispatch_arg_0)
		}
		'enqueue_scripts' {
			this.enqueue_scripts()
			return rt.new_null()
		}
		'filter_dynamic_setting_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.filter_dynamic_setting_args(dispatch_arg_0, dispatch_arg_1)
		}
		'filter_dynamic_setting_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.filter_dynamic_setting_class(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'customize_register' {
			this.customize_register()
			return rt.new_null()
		}
		'intval_base10' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.intval_base10(dispatch_arg_0))
		}
		'available_item_types' {
			return this.available_item_types()
		}
		'insert_auto_draft_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.insert_auto_draft_post(dispatch_arg_0)
		}
		'ajax_insert_auto_draft_post' {
			this.ajax_insert_auto_draft_post()
			return rt.new_null()
		}
		'print_templates' {
			this.print_templates()
			return rt.new_null()
		}
		'available_items_template' {
			this.available_items_template()
			return rt.new_null()
		}
		'print_post_type_container' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.print_post_type_container(dispatch_arg_0)
			return rt.new_null()
		}
		'print_custom_links_available_menu_item' {
			this.print_custom_links_available_menu_item()
			return rt.new_null()
		}
		'customize_dynamic_partial_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.customize_dynamic_partial_args(dispatch_arg_0, dispatch_arg_1)
		}
		'customize_preview_init' {
			this.customize_preview_init()
			return rt.new_null()
		}
		'make_auto_draft_status_previewable' {
			this.make_auto_draft_status_previewable()
			return rt.new_null()
		}
		'sanitize_nav_menus_created_posts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize_nav_menus_created_posts(dispatch_arg_0)
		}
		'save_nav_menus_created_posts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.save_nav_menus_created_posts(dispatch_arg_0)
			return rt.new_null()
		}
		'filter_wp_nav_menu_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_wp_nav_menu_args(dispatch_arg_0)
		}
		'filter_wp_nav_menu' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.filter_wp_nav_menu(dispatch_arg_0, dispatch_arg_1)
		}
		'hash_nav_menu_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.hash_nav_menu_args(dispatch_arg_0)
		}
		'customize_preview_enqueue_deps' {
			this.customize_preview_enqueue_deps()
			return rt.new_null()
		}
		'export_preview_data' {
			this.export_preview_data()
			return rt.new_null()
		}
		'export_partial_rendered_nav_menu_instances' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.export_partial_rendered_nav_menu_instances(dispatch_arg_0)
		}
		'render_nav_menu_partial' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.render_nav_menu_partial(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_WP_Customize_Nav_Menus) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'manager' { return this.manager }
		'original_nav_menu_locations' { return this.original_nav_menu_locations }
		'preview_nav_menu_instance_args' { return this.preview_nav_menu_instance_args }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Nav_Menus) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'manager' { this.manager = val; return true }
		'original_nav_menu_locations' { this.original_nav_menu_locations = val; return true }
		'preview_nav_menu_instance_args' { this.preview_nav_menu_instance_args = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Customize_Nav_Menu_Setting) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Nav_Menu_Setting) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Nav_Menu_Setting) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Customize_Nav_Menu_Item_Setting) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Nav_Menu_Item_Setting) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Nav_Menu_Item_Setting) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Customize_Nav_Menus_Panel) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Nav_Menus_Panel) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Nav_Menus_Panel) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Customize_Nav_Menu_Location_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Nav_Menu_Location_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Nav_Menu_Location_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Customize_Nav_Menu_Section) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Nav_Menu_Section) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Nav_Menu_Section) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Customize_Nav_Menu_Item_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Nav_Menu_Item_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Nav_Menu_Item_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Customize_Filter_Setting) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Filter_Setting) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Filter_Setting) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
