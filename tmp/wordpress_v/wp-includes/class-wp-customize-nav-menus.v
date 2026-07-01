import rt

struct Class_WP_Customize_Nav_Menus {
	rt.PhpObjectBase
pub mut:
		manager rt.PhpVal = rt.new_null()
		original_nav_menu_locations rt.PhpVal = rt.new_null()
		preview_nav_menu_instance_args rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Customize_Nav_Menus) construct(var_manager rt.PhpVal)  {
	this.manager = var_manager.dup()
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
	return var_nonces_mutated.dup()
}

fn (mut this Class_WP_Customize_Nav_Menus) ajax_load_available_items()  {
	rt.call_function('check_ajax_referer', [rt.new_string('customize-menus'), rt.new_string('customize-menus-nonce')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]))))) {
		rt.call_function('wp_die', [// unsupported expression: Expr_UnaryMinus])
	}
	mut var_all_items := map[string]rt.PhpVal{}
	mut var_item_types := map[string]rt.PhpVal{}
	if rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('item_types')) && rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_get('item_types').is_array())))) {
		var_item_types = rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('item_types')])
	} else if rt.get_superglobal('_POST').array_isset(rt.new_string('type')) && rt.get_superglobal('_POST').array_isset(rt.new_string('object')) {
		var_item_types.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('type')]) }, rt.ArrayItem{ key: 'object', val: rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('object')]) }, rt.ArrayItem{ key: 'page', val: if !rt.is_true(rt.get_superglobal('_POST').array_get('page')) { rt.new_int(0) } else { rt.call_function('absint', [rt.get_superglobal('_POST').array_get('page')]) } }]))
	} else {
		rt.call_function('wp_send_json_error', [rt.new_string('nav_menus_missing_type_or_object_parameter')])
	}
	{
		mut iter_1 := var_item_types.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item_type := item_1.val
			if !rt.is_true(var_item_type.array_get('type')) || !rt.is_true(var_item_type.array_get('object')) {
				rt.call_function('wp_send_json_error', [rt.new_string('nav_menus_missing_type_or_object_parameter')])
			}
			mut var_type := rt.call_function('sanitize_key', [var_item_type.array_get('type')])
			mut var_object := rt.call_function('sanitize_key', [var_item_type.array_get('object')])
			mut var_page := if !rt.is_true(var_item_type.array_get('page')) { rt.new_int(0) } else { rt.call_function('absint', [var_item_type.array_get('page')]) }
			mut var_items := this.load_available_items_query((var_type).str(), (var_object).str(), (var_page).to_i64())
			if rt.is_true(rt.call_function('is_wp_error', [var_items.dup()])) {
				rt.call_function('wp_send_json_error', [rt.call_method(var_items, 'get_error_code', []rt.PhpVal{})])
			}
			var_all_items[(var_item_type.array_get('type')).str() + ':' + (var_item_type.array_get('object')).str()] = var_items.dup()
		}
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
		if rt.is_true(rt.new_bool(0 == page_mutated && rt.is_true(rt.identical(rt.new_string('page'), rt.new_string(object_name))))) {
			mut var_front_page := if rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')]))) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
			if !(!rt.is_true(var_front_page)) {
				mut var_front_page_obj := rt.call_function('get_post', [var_front_page.dup()])
				var_important_pages << var_front_page_obj.dup()
				var_suppress_page_ids << rt.get_property(var_front_page_obj, 'ID')
			} else {
				var_items.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: 'home' }, rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [rt.new_string('Home'), rt.new_string('nav menu home label')]) }, rt.ArrayItem{ key: 'type', val: 'custom' }, rt.ArrayItem{ key: 'type_label', val: rt.call_function('__', [rt.new_string('Custom Link')]) }, rt.ArrayItem{ key: 'object', val: '' }, rt.ArrayItem{ key: 'url', val: rt.call_function('home_url', []rt.PhpVal{}) }]))
			}
			mut var_posts_page := if rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')]))) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
			if !(!rt.is_true(var_posts_page)) {
				mut var_posts_page_obj := rt.call_function('get_post', [var_posts_page.dup()])
				var_important_pages << var_posts_page_obj.dup()
				var_suppress_page_ids << rt.get_property(var_posts_page_obj, 'ID')
			}
			mut var_privacy_policy_page_id := // unsupported expression: Expr_Cast_Int
			if !(!rt.is_true(var_privacy_policy_page_id)) {
				mut var_privacy_policy_page := rt.call_function('get_post', [var_privacy_policy_page_id.dup()])
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_privacy_policy_page, 'WP_Post'))) && rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_privacy_policy_page, 'post_status'))))) {
					var_important_pages << var_privacy_policy_page.dup()
					var_suppress_page_ids << rt.get_property(var_privacy_policy_page, 'ID')
				}
			}
		} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && 0 == page_mutated)) && rt.is_true(rt.get_property(var_post_type, 'has_archive')))) {
			mut var_title := rt.get_property(rt.get_property(var_post_type, 'labels'), 'archives')
			var_items.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: object_name + '-archive' }, rt.ArrayItem{ key: 'title', val: var_title }, rt.ArrayItem{ key: 'original_title', val: var_title }, rt.ArrayItem{ key: 'type', val: 'post_type_archive' }, rt.ArrayItem{ key: 'type_label', val: rt.call_function('__', [rt.new_string('Post Type Archive')]) }, rt.ArrayItem{ key: 'object', val: object_name }, rt.ArrayItem{ key: 'url', val: rt.call_function('get_post_type_archive_link', [rt.new_string(object_name)]) }]))
		}
		mut var_posts := map[string]rt.PhpVal{}
		if rt.is_true(rt.new_bool(0 == page_mutated && rt.is_true(rt.call_method(this.manager, 'get_setting', [rt.new_string('nav_menus_created_posts')])))) {
			{
				mut iter_1 := rt.call_method(rt.call_method(this.manager, 'get_setting', [rt.new_string('nav_menus_created_posts')]), 'value', []rt.PhpVal{}).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_post_id := item_1.val
					mut var_auto_draft_post := rt.call_function('get_post', [var_post_id.dup()])
					if rt.is_true(rt.identical(rt.get_property(var_post_type, 'name'), rt.get_property(var_auto_draft_post, 'post_type'))) {
						var_posts.array_push(var_auto_draft_post.dup())
					}
				}
			}
		}
		mut var_args := { 'numberposts': rt.new_int(10), 'offset': 10 * page_mutated, 'orderby': rt.new_string('date'), 'order': rt.new_string('DESC'), 'post_type': rt.new_string(object_name) }
		if !(!rt.is_true(var_suppress_page_ids)) {
			var_args['post__not_in'] = var_suppress_page_ids.dup()
		}
		var_posts = rt.call_function('array_merge', [var_posts.dup(), var_important_pages.dup(), rt.call_function('get_posts', [var_args.dup()])])
		{
			mut iter_1 := var_posts.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_post := item_1.val
				mut var_post_title := rt.get_property(var_post, 'post_title')
				if rt.is_true(rt.identical(rt.new_string(''), var_post_title)) {
					var_post_title = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('#%d (no title)')]), rt.get_property(var_post, 'ID')])
				}
				mut var_post_type_label := rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [rt.get_property(var_post, 'post_type')]), 'labels'), 'singular_name')
				mut var_post_states := rt.call_function('get_post_states', [var_post.dup()])
				if !(!rt.is_true(var_post_states)) {
					var_post_type_label = rt.call_function('implode', [rt.new_string(','), var_post_states.dup()])
				}
				var_title = rt.call_function('html_entity_decode', [var_post_title.dup(), rt.get_constant('ENT_QUOTES'), rt.call_function('get_bloginfo', [rt.new_string('charset')])])
				var_items.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: rt.concat(rt.new_string('post-'), rt.get_property(var_post, 'ID')) }, rt.ArrayItem{ key: 'title', val: var_title }, rt.ArrayItem{ key: 'original_title', val: var_title }, rt.ArrayItem{ key: 'type', val: 'post_type' }, rt.ArrayItem{ key: 'type_label', val: var_post_type_label }, rt.ArrayItem{ key: 'object', val: rt.get_property(var_post, 'post_type') }, rt.ArrayItem{ key: 'object_id', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'url', val: rt.call_function('get_permalink', [// unsupported expression: Expr_Cast_Int]) }]))
			}
		}
	} else if rt.is_true(rt.identical(rt.new_string('taxonomy'), rt.new_string(object_type))) {
		mut var_terms := rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: object_name }, rt.ArrayItem{ key: 'child_of', val: 0 }, rt.ArrayItem{ key: 'exclude', val: '' }, rt.ArrayItem{ key: 'hide_empty', val: false }, rt.ArrayItem{ key: 'hierarchical', val: 1 }, rt.ArrayItem{ key: 'include', val: '' }, rt.ArrayItem{ key: 'number', val: 10 }, rt.ArrayItem{ key: 'offset', val: 10 * page_mutated }, rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'orderby', val: 'count' }, rt.ArrayItem{ key: 'pad_counts', val: false }])])
		if rt.is_true(rt.call_function('is_wp_error', [var_terms.dup()])) {
			return var_terms.dup()
		}
		{
			mut iter_1 := var_terms.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_term := item_1.val
				var_title = rt.call_function('html_entity_decode', [rt.get_property(var_term, 'name'), rt.get_constant('ENT_QUOTES'), rt.call_function('get_bloginfo', [rt.new_string('charset')])])
				var_items.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: rt.concat(rt.new_string('term-'), rt.get_property(var_term, 'term_id')) }, rt.ArrayItem{ key: 'title', val: var_title }, rt.ArrayItem{ key: 'original_title', val: var_title }, rt.ArrayItem{ key: 'type', val: 'taxonomy' }, rt.ArrayItem{ key: 'type_label', val: rt.get_property(rt.get_property(rt.call_function('get_taxonomy', [rt.get_property(var_term, 'taxonomy')]), 'labels'), 'singular_name') }, rt.ArrayItem{ key: 'object', val: rt.get_property(var_term, 'taxonomy') }, rt.ArrayItem{ key: 'object_id', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'url', val: rt.call_function('get_term_link', [// unsupported expression: Expr_Cast_Int, rt.get_property(var_term, 'taxonomy')]) }]))
			}
		}
	}
	var_items = rt.call_function('apply_filters', [rt.new_string('customize_nav_menu_available_items'), var_items.dup(), rt.new_string(object_type), rt.new_string(object_name), rt.new_int(page_mutated).dup()])
	return var_items.dup()
}

fn (mut this Class_WP_Customize_Nav_Menus) ajax_search_available_items()  {
	rt.call_function('check_ajax_referer', [rt.new_string('customize-menus'), rt.new_string('customize-menus-nonce')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]))))) {
		rt.call_function('wp_die', [// unsupported expression: Expr_UnaryMinus])
	}
	if !rt.is_true(rt.get_superglobal('_POST').array_get('search')) {
		rt.call_function('wp_send_json_error', [rt.new_string('nav_menus_missing_search_parameter')])
	}
	mut var_p := if rt.get_superglobal('_POST').array_isset(rt.new_string('page')) { rt.call_function('absint', [rt.get_superglobal('_POST').array_get('page')]) } else { rt.new_int(0) }
	if rt.is_true(rt.less(var_p, rt.new_int(1))) {
		var_p = rt.new_int(rt.new_int(1))
	}
	mut var_s := rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('search')])])
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
	mut var_query := { 'post_type': rt.func_array_keys(var_post_type_objects.dup()), 'suppress_filters': rt.new_bool(true), 'update_post_term_cache': rt.new_bool(false), 'update_post_meta_cache': rt.new_bool(false), 'post_status': rt.new_string('publish'), 'posts_per_page': rt.new_int(20) }
	var_args_mutated.array_set('pagenum', if var_args_mutated.array_isset(rt.new_string('pagenum')) { rt.call_function('absint', [var_args_mutated.array_get('pagenum')]) } else { rt.new_int(1) })
	var_query['offset'] = if rt.is_true(rt.greater(var_args_mutated.array_get('pagenum'), rt.new_int(1))) { rt.mul(var_query.array_get('posts_per_page'), rt.sub(var_args_mutated.array_get('pagenum'), rt.new_int(1))) } else { rt.new_int(0) }
	if var_args_mutated.array_isset(rt.new_string('s')) {
		var_query['s'] = var_args_mutated.array_get('s')
	}
	mut var_posts := map[string]rt.PhpVal{}
	mut var_nav_menus_created_posts_setting := rt.call_method(this.manager, 'get_setting', [rt.new_string('nav_menus_created_posts')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(1), .array_get())) && rt.is_true(var_nav_menus_created_posts_setting))) && rt.call_method(var_nav_menus_created_posts_setting, 'value', []rt.PhpVal{}).array_count() > 0)) {
		mut var_stub_post_query := create_wp_query(rt.call_function('array_merge', [.dup(), ]))
		var_posts = rt.call_function('array_merge', [.dup(), ])
	}
	mut var_get_posts := create_wp_query(.dup())
	var_posts = 
	{
		mut iter_1 := .iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_post := item_1.val
		}
	}
}

fn (mut this Class_WP_Customize_Nav_Menus) enqueue_scripts()  {
}

fn (mut this Class_WP_Customize_Nav_Menus) filter_dynamic_setting_args(var_setting_args rt.PhpVal, var_setting_id rt.PhpVal) rt.PhpVal {
	mut var_setting_args_mutated := var_setting_args
	mut var_setting_id_mutated := var_setting_id
}

fn (mut this Class_WP_Customize_Nav_Menus) filter_dynamic_setting_class(var_setting_class rt.PhpVal, var_setting_id rt.PhpVal, var_setting_args rt.PhpVal) rt.PhpVal {
	mut var_setting_class_mutated := var_setting_class
	mut var_setting_id_mutated := var_setting_id
	mut var_setting_args_mutated := var_setting_args
}

fn (mut this Class_WP_Customize_Nav_Menus) customize_register()  {
}

fn (mut this Class_WP_Customize_Nav_Menus) intval_base10(var_value rt.PhpVal) i64 {
	mut var_value_mutated := var_value
}

fn (mut this Class_WP_Customize_Nav_Menus) available_item_types() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Nav_Menus) insert_auto_draft_post(var_postarr rt.PhpVal) rt.PhpVal {
	mut var_postarr_mutated := var_postarr
	return rt.new_null()
}

fn (mut this Class_WP_Customize_Nav_Menus) ajax_insert_auto_draft_post()  {
}

fn (mut this Class_WP_Customize_Nav_Menus) print_templates()  {
}

fn (mut this Class_WP_Customize_Nav_Menus) available_items_template()  {
}

fn (mut this Class_WP_Customize_Nav_Menus) print_post_type_container(var_available_item_type rt.PhpVal)  {
}

fn (mut this Class_WP_Customize_Nav_Menus) print_custom_links_available_menu_item()  {
}

fn (mut this Class_WP_Customize_Nav_Menus) customize_dynamic_partial_args(var_partial_args rt.PhpVal, var_partial_id rt.PhpVal) rt.PhpVal {
	mut var_partial_args_mutated := var_partial_args
}

fn (mut this Class_WP_Customize_Nav_Menus) customize_preview_init()  {
}

fn (mut this Class_WP_Customize_Nav_Menus) make_auto_draft_status_previewable()  {
	mut var_wp_post_statuses := rt.new_null()
}

fn (mut this Class_WP_Customize_Nav_Menus) sanitize_nav_menus_created_posts(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
}

fn (mut this Class_WP_Customize_Nav_Menus) save_nav_menus_created_posts(var_setting rt.PhpVal)  {
	mut var_setting_mutated := var_setting
}

fn (mut this Class_WP_Customize_Nav_Menus) filter_wp_nav_menu_args(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_WP_Customize_Nav_Menus) filter_wp_nav_menu(var_nav_menu_content rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_nav_menu_content_mutated := var_nav_menu_content
	mut var_args_mutated := var_args
}

fn (mut this Class_WP_Customize_Nav_Menus) hash_nav_menu_args(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_WP_Customize_Nav_Menus) customize_preview_enqueue_deps()  {
}

fn (mut this Class_WP_Customize_Nav_Menus) export_preview_data()  {
}

fn (mut this Class_WP_Customize_Nav_Menus) export_partial_rendered_nav_menu_instances(var_response rt.PhpVal) rt.PhpVal {
	mut var_response_mutated := var_response
}

fn (mut this Class_WP_Customize_Nav_Menus) render_nav_menu_partial(var_partial rt.PhpVal, var_nav_menu_args rt.PhpVal) bool {
	mut var_partial_mutated := var_partial
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Query {
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

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_query() &Class_WP_Query {
	mut obj := &Class_WP_Query{
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




pub fn init_wp_includes_class_wp_customize_nav_menus_php() {
}
