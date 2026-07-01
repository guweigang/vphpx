import rt

fn _wp_ajax_menu_quick_search(var_request rt.PhpVal) {
	mut var_matches := []rt.PhpVal{}
	mut var_args := rt.new_array()
	mut var_type := if !(var_request.array_get('type')).is_null() { var_request.array_get('type') } else { rt.new_string('') }
	mut var_object_type := if !(var_request.array_get('object_type')).is_null() { var_request.array_get('object_type') } else { rt.new_string('') }
	mut var_query := if !(var_request.array_get('q')).is_null() { var_request.array_get('q') } else { rt.new_string('') }
	mut var_response_format := if !(var_request.array_get('response-format')).is_null() { var_request.array_get('response-format') } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_response_format)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_response_format.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'json' }, rt.ArrayItem{ key: none, val: 'markup' }]), rt.new_bool(true)]))))))) {
		var_response_format = rt.new_string(rt.new_string('json'))
	}
	if rt.is_true(rt.identical(rt.new_string('markup'), var_response_format)) {
		var_args.array_set('walker', create_walker_nav_menu_checklist())
	}
	if rt.is_true(rt.identical(rt.new_string('get-post-item'), var_type)) {
		if rt.is_true(rt.call_function('post_type_exists', [var_object_type.dup()])) {
			if var_request.array_isset(rt.new_string('ID')) {
				mut var_object_id := // unsupported expression: Expr_Cast_Int
				if rt.is_true(rt.identical(rt.new_string('markup'), var_response_format)) {
					rt.echo_val(rt.call_function('walk_nav_menu_tree', [rt.call_function('array_map', [rt.new_string('wp_setup_nav_menu_item'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('get_post', [var_object_id.dup()]) }])]), rt.new_int(0), // unsupported expression: Expr_Cast_Object]))
				} else if rt.is_true(rt.identical(rt.new_string('json'), var_response_format)) {
					rt.echo_val(rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'ID', val: var_object_id }, rt.ArrayItem{ key: 'post_title', val: rt.call_function('get_the_title', [var_object_id.dup()]) }, rt.ArrayItem{ key: 'post_type', val: rt.call_function('get_post_type', [var_object_id.dup()]) }])]))
					print('\n')
				}
			}
		} else if rt.is_true(rt.call_function('taxonomy_exists', [var_object_type.dup()])) {
			if var_request.array_isset(rt.new_string('ID')) {
				var_object_id = // unsupported expression: Expr_Cast_Int
				if rt.is_true(rt.identical(rt.new_string('markup'), var_response_format)) {
					rt.echo_val(rt.call_function('walk_nav_menu_tree', [rt.call_function('array_map', [rt.new_string('wp_setup_nav_menu_item'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('get_term', [var_object_id.dup(), var_object_type.dup()]) }])]), rt.new_int(0), // unsupported expression: Expr_Cast_Object]))
				} else if rt.is_true(rt.identical(rt.new_string('json'), var_response_format)) {
					mut var_post_obj := rt.call_function('get_term', [var_object_id.dup(), var_object_type.dup()])
					rt.echo_val(rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'ID', val: var_object_id }, rt.ArrayItem{ key: 'post_title', val: rt.get_property(var_post_obj, 'name') }, rt.ArrayItem{ key: 'post_type', val: var_object_type }])]))
					print('\n')
				}
			}
		}
	} else if rt.is_true(rt.call_function('preg_match', [rt.new_string('/quick-search-(posttype|taxonomy)-([a-zA-Z0-9_-]*\\b)/'), var_type.dup(), var_matches.dup()])) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('posttype'), var_matches.array_get(1))) && rt.is_true(rt.call_function('get_post_type_object', [var_matches.array_get(2)])))) {
			mut var_post_type_obj := _wp_nav_menu_meta_box_object(rt.call_function('get_post_type_object', [var_matches.array_get(2)]))
			mut var_query_args := rt.create_array([rt.ArrayItem{ key: 'no_found_rows', val: true }, rt.ArrayItem{ key: 'update_post_meta_cache', val: false }, rt.ArrayItem{ key: 'update_post_term_cache', val: false }, rt.ArrayItem{ key: 'posts_per_page', val: 10 }, rt.ArrayItem{ key: 'post_type', val: var_matches.array_get(2) }, rt.ArrayItem{ key: 's', val: var_query }, rt.ArrayItem{ key: 'search_columns', val: rt.create_array([rt.ArrayItem{ key: none, val: 'post_title' }]) }])
			var_query_args = rt.call_function('apply_filters', [rt.new_string('wp_ajax_menu_quick_search_args'), var_query_args.dup()])
			var_args = rt.call_function('array_merge', [var_args.dup(), var_query_args.dup()])
			if !(rt.get_property(var_post_type_obj, '_default_query')).is_null() {
				var_args = rt.call_function('array_merge', [var_args.dup(), rt.cast_array(rt.get_property(var_post_type_obj, '_default_query'))])
			}
			mut var_search_results_query := create_wp_query(var_args.dup())
			if rt.is_true(rt.new_bool(!(rt.is_true(var_search_results_query.have_posts())))) {
				return rt.new_null()
			}
			for rt.is_true(var_search_results_query.have_posts()) {
				mut var_post := var_search_results_query.next_post()
				if rt.is_true(rt.identical(rt.new_string('markup'), var_response_format)) {
					mut var_var_by_ref := rt.get_property(var_post, 'ID')
					rt.echo_val(rt.call_function('walk_nav_menu_tree', [rt.call_function('array_map', [rt.new_string('wp_setup_nav_menu_item'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('get_post', [var_var_by_ref.dup()]) }])]), rt.new_int(0), // unsupported expression: Expr_Cast_Object]))
				} else if rt.is_true(rt.identical(rt.new_string('json'), var_response_format)) {
					rt.echo_val(rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.get_property(var_post, 'ID') }, rt.ArrayItem{ key: 'post_title', val: rt.call_function('get_the_title', [rt.get_property(var_post, 'ID')]) }, rt.ArrayItem{ key: 'post_type', val: var_matches.array_get(2) }])]))
					print('\n')
				}
			}
		} else if rt.is_true(rt.identical(rt.new_string('taxonomy'), var_matches.array_get(1))) {
			mut var_terms := rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_matches.array_get(2) }, rt.ArrayItem{ key: 'name__like', val: var_query }, rt.ArrayItem{ key: 'number', val: 10 }, rt.ArrayItem{ key: 'hide_empty', val: false }])])
			if rt.is_true(rt.new_bool(!rt.is_true(var_terms) || rt.is_true(rt.call_function('is_wp_error', [var_terms.dup()])))) {
				return rt.new_null()
			}
			{
				mut iter_1 := rt.cast_array(var_terms).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_term := item_1.val
					if rt.is_true(rt.identical(rt.new_string('markup'), var_response_format)) {
						rt.echo_val(rt.call_function('walk_nav_menu_tree', [rt.call_function('array_map', [rt.new_string('wp_setup_nav_menu_item'), rt.create_array([rt.ArrayItem{ key: none, val: var_term }])]), rt.new_int(0), // unsupported expression: Expr_Cast_Object]))
					} else if rt.is_true(rt.identical(rt.new_string('json'), var_response_format)) {
						rt.echo_val(rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.get_property(var_term, 'term_id') }, rt.ArrayItem{ key: 'post_title', val: rt.get_property(var_term, 'name') }, rt.ArrayItem{ key: 'post_type', val: var_matches.array_get(2) }])]))
						print('\n')
					}
				}
			}
		}
	}
}

fn wp_nav_menu_setup() {
	wp_nav_menu_post_type_meta_boxes()
	rt.call_function('add_meta_box', [rt.new_string('add-custom-links'), rt.call_function('__', [rt.new_string('Custom Links')]), rt.new_string('wp_nav_menu_item_link_meta_box'), rt.new_string('nav-menus'), rt.new_string('side'), rt.new_string('default')])
	wp_nav_menu_taxonomy_meta_boxes()
	rt.call_function('add_filter', [rt.new_string('manage_nav-menus_columns'), rt.new_string('wp_nav_menu_manage_columns')])
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('get_user_option', [rt.new_string('managenav-menuscolumnshidden')]))) {
		mut var_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
		rt.call_function('update_user_meta', [rt.get_property(var_user, 'ID'), rt.new_string('managenav-menuscolumnshidden'), rt.create_array([rt.ArrayItem{ key: 0, val: 'link-target' }, rt.ArrayItem{ key: 1, val: 'css-classes' }, rt.ArrayItem{ key: 2, val: 'xfn' }, rt.ArrayItem{ key: 3, val: 'description' }, rt.ArrayItem{ key: 4, val: 'title-attribute' }])])
	}
}

fn wp_initial_nav_menu_meta_boxes() {
	mut var_wp_meta_boxes := map[string]rt.PhpVal{}
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_wp_meta_boxes.dup().is_array()))))))) {
		return rt.new_null()
	}
	mut var_initial_meta_boxes := ['add-post-type-page', 'add-post-type-post', 'add-custom-links', 'add-category']
	mut var_hidden_meta_boxes := rt.new_array()
	{
		mut iter_1 := rt.func_array_keys(var_wp_meta_boxes.array_get('nav-menus')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_context := item_1.val
			{
				mut iter_2 := rt.func_array_keys(var_wp_meta_boxes.array_get('nav-menus').array_get(var_context)).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_priority := item_2.val
					{
						mut iter_3 := var_wp_meta_boxes.array_get('nav-menus').array_get(var_context).array_get(var_priority).iterator()
						for {
							item_3 := iter_3.next() or { break }
							mut var_box := item_3.val
							if rt.is_true(rt.call_function('in_array', [var_box.array_get('id'), var_initial_meta_boxes.dup(), rt.new_bool(true)])) {
								var_box.array_unset(rt.new_string('id'))
							} else {
								var_hidden_meta_boxes << var_box.array_get('id')
							}
						}
					}
				}
			}
		}
	}
	mut var_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
	rt.call_function('update_user_meta', [rt.get_property(var_user, 'ID'), rt.new_string('metaboxhidden_nav-menus'), var_hidden_meta_boxes.dup()])
}

fn wp_nav_menu_post_type_meta_boxes() {
	mut var_post_types := rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'show_in_nav_menus', val: true }]), rt.new_string('object')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_types)))) {
		return rt.new_null()
	}
	{
		mut iter_1 := var_post_types.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_post_type := item_1.val
			var_post_type = rt.call_function('apply_filters', [rt.new_string('nav_menu_meta_box_object'), var_post_type.dup()])
			if rt.is_true(var_post_type) {
				mut var_id := rt.get_property(var_post_type, 'name')
				mut var_priority := if rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_post_type, 'name'))) { 'core' } else { 'default' }
				rt.call_function('add_meta_box', [rt.new_string("add-post-type-${var_id.to_string()}"), rt.get_property(rt.get_property(var_post_type, 'labels'), 'name'), rt.new_string('wp_nav_menu_item_post_type_meta_box'), rt.new_string('nav-menus'), rt.new_string('side'), rt.new_string(var_priority).dup(), var_post_type.dup()])
			}
		}
	}
}

fn wp_nav_menu_taxonomy_meta_boxes() {
	mut var_taxonomies := rt.call_function('get_taxonomies', [rt.create_array([rt.ArrayItem{ key: 'show_in_nav_menus', val: true }]), rt.new_string('object')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_taxonomies)))) {
		return rt.new_null()
	}
	{
		mut iter_1 := var_taxonomies.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tax := item_1.val
			var_tax = rt.call_function('apply_filters', [rt.new_string('nav_menu_meta_box_object'), var_tax.dup()])
			if rt.is_true(var_tax) {
				mut var_id := rt.get_property(var_tax, 'name')
				rt.call_function('add_meta_box', [rt.new_string("add-${var_id.to_string()}"), rt.get_property(rt.get_property(var_tax, 'labels'), 'name'), rt.new_string('wp_nav_menu_item_taxonomy_meta_box'), rt.new_string('nav-menus'), rt.new_string('side'), rt.new_string('default'), var_tax.dup()])
			}
		}
	}
}

fn wp_nav_menu_disabled_check(var_nav_menu_selected_id rt.PhpVal, display bool) bool {
	mut var_one_theme_location_no_menus := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(var_one_theme_location_no_menus) {
		return false
	}
	return (rt.call_function('disabled', [var_nav_menu_selected_id.dup(), rt.new_int(0), rt.new_bool(display)])).to_bool()
}

fn wp_nav_menu_item_link_meta_box() {
	mut var_nav_menu_selected_id := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var__nav_menu_placeholder := if rt.is_true(rt.greater(rt.new_int(0), var__nav_menu_placeholder)) { rt.sub(var__nav_menu_placeholder, rt.new_int(1)) } else { // unsupported expression: Expr_UnaryMinus }
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var__nav_menu_placeholder)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('URL')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var__nav_menu_placeholder)
	// unsupported statement: Stmt_InlineHTML
	rt.new_bool(wp_nav_menu_disabled_check(var_nav_menu_selected_id.dup(), false))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Please provide a valid link.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Link Text')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var__nav_menu_placeholder)
	// unsupported statement: Stmt_InlineHTML
	rt.new_bool(wp_nav_menu_disabled_check(var_nav_menu_selected_id.dup(), false))
	// unsupported statement: Stmt_InlineHTML
	rt.new_bool(wp_nav_menu_disabled_check(var_nav_menu_selected_id.dup(), false))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [])
	// unsupported statement: Stmt_InlineHTML
}

struct Class_Walker_Nav_Menu_Checklist {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_walker_nav_menu_checklist() &Class_Walker_Nav_Menu_Checklist {
	mut obj := &Class_Walker_Nav_Menu_Checklist{
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


fn init_registry() {
	rt.register_class_factory('Walker_Nav_Menu_Checklist', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_walker_nav_menu_checklist()
		return rt.new_object('Walker_Nav_Menu_Checklist', []string{}, obj)
	})
	rt.register_class_factory('WP_Query', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_query()
		return rt.new_object('WP_Query', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_admin_includes_nav_menu_php() {
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-walker-nav-menu-edit.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-walker-nav-menu-checklist.php', '4')
}
