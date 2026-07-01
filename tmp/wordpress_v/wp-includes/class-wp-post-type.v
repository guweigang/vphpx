import rt

struct Class_WP_Post_Type {
	rt.PhpObjectBase
pub mut:
		name rt.PhpVal = rt.new_null()
		label rt.PhpVal = rt.new_null()
		labels rt.PhpVal = rt.new_null()
		default_labels rt.PhpVal = rt.new_array()
		description rt.PhpVal = rt.new_string('')
		public rt.PhpVal = rt.new_bool(false)
		hierarchical rt.PhpVal = rt.new_bool(false)
		exclude_from_search rt.PhpVal = rt.new_null()
		publicly_queryable rt.PhpVal = rt.new_null()
		embeddable rt.PhpVal = rt.new_null()
		show_ui rt.PhpVal = rt.new_null()
		show_in_menu rt.PhpVal = rt.new_null()
		show_in_nav_menus rt.PhpVal = rt.new_null()
		show_in_admin_bar rt.PhpVal = rt.new_null()
		menu_position rt.PhpVal = rt.new_null()
		menu_icon rt.PhpVal = rt.new_null()
		capability_type rt.PhpVal = rt.new_string('post')
		map_meta_cap rt.PhpVal = rt.new_bool(false)
		register_meta_box_cb rt.PhpVal = rt.new_null()
		taxonomies rt.PhpVal = rt.new_array()
		has_archive rt.PhpVal = rt.new_bool(false)
		query_var rt.PhpVal = rt.new_null()
		can_export rt.PhpVal = rt.new_bool(true)
		delete_with_user rt.PhpVal = rt.new_null()
		template rt.PhpVal = rt.new_array()
		template_lock rt.PhpVal = rt.new_bool(false)
		_builtin rt.PhpVal = rt.new_bool(false)
		_edit_link rt.PhpVal = rt.new_string('post.php?post=%d')
		cap rt.PhpVal = rt.new_null()
		rewrite rt.PhpVal = rt.new_null()
		supports rt.PhpVal = rt.new_null()
		show_in_rest rt.PhpVal = rt.new_null()
		rest_base rt.PhpVal = rt.new_null()
		rest_namespace rt.PhpVal = rt.new_null()
		rest_controller_class rt.PhpVal = rt.new_null()
		rest_controller rt.PhpVal = rt.new_null()
		revisions_rest_controller_class rt.PhpVal = rt.new_null()
		revisions_rest_controller rt.PhpVal = rt.new_null()
		autosave_rest_controller_class rt.PhpVal = rt.new_null()
		autosave_rest_controller rt.PhpVal = rt.new_null()
		late_route_registration rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Post_Type) construct(var_post_type rt.PhpVal, var_args rt.PhpVal)  {
	mut var_post_type_mutated := var_post_type
	mut var_args_mutated := var_args
	this.name = var_post_type_mutated.dup()
	this.set_props(var_args_mutated.dup())
}

fn (mut this Class_WP_Post_Type) set_props(var_args rt.PhpVal)  {
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.dup()])
	var_args_mutated = rt.call_function('apply_filters', [rt.new_string('register_post_type_args'), var_args_mutated.dup(), this.name])
	mut var_post_type := this.name
	var_args_mutated = rt.call_function('apply_filters', [rt.new_string("register_${var_post_type.to_string()}_post_type_args"), var_args_mutated.dup(), this.name])
	mut var_has_edit_link := rt.new_bool(rt.new_bool(!(!rt.is_true(var_args_mutated.array_get('_edit_link')))))
	mut var_defaults := { 'labels': map[string]rt.PhpVal{}, 'description': rt.new_string(''), 'public': rt.new_bool(false), 'hierarchical': rt.new_bool(false), 'exclude_from_search': rt.new_null(), 'publicly_queryable': rt.new_null(), 'embeddable': rt.new_null(), 'show_ui': rt.new_null(), 'show_in_menu': rt.new_null(), 'show_in_nav_menus': rt.new_null(), 'show_in_admin_bar': rt.new_null(), 'menu_position': rt.new_null(), 'menu_icon': rt.new_null(), 'capability_type': rt.new_string('post'), 'capabilities': map[string]rt.PhpVal{}, 'map_meta_cap': rt.new_null(), 'supports': map[string]rt.PhpVal{}, 'register_meta_box_cb': rt.new_null(), 'taxonomies': map[string]rt.PhpVal{}, 'has_archive': rt.new_bool(false), 'rewrite': rt.new_bool(true), 'query_var': rt.new_bool(true), 'can_export': rt.new_bool(true), 'delete_with_user': rt.new_null(), 'show_in_rest': rt.new_bool(false), 'rest_base': rt.new_bool(false), 'rest_namespace': rt.new_bool(false), 'rest_controller_class': rt.new_bool(false), 'autosave_rest_controller_class': rt.new_bool(false), 'revisions_rest_controller_class': rt.new_bool(false), 'late_route_registration': rt.new_bool(false), 'template': map[string]rt.PhpVal{}, 'template_lock': rt.new_bool(false), '_builtin': rt.new_bool(false), '_edit_link': rt.new_string('post.php?post=%d') }
	var_args_mutated = rt.call_function('array_merge', [var_defaults.dup(), var_args_mutated.dup()])
	var_args_mutated.array_set('name', this.name)
	if rt.is_true(rt.identical(rt.new_null(), var_args_mutated.array_get('publicly_queryable'))) {
		var_args_mutated.array_set('publicly_queryable', var_args_mutated.array_get('public'))
	}
	if rt.is_true(rt.identical(rt.new_null(), var_args_mutated.array_get('show_ui'))) {
		var_args_mutated.array_set('show_ui', var_args_mutated.array_get('public'))
	}
	if rt.is_true(rt.identical(rt.new_null(), var_args_mutated.array_get('embeddable'))) {
		var_args_mutated.array_set('embeddable', var_args_mutated.array_get('public'))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), var_args_mutated.array_get('rest_namespace'))) && !(!rt.is_true(var_args_mutated.array_get('show_in_rest'))))) {
		var_args_mutated.array_set('rest_namespace', 'wp/v2')
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_null(), var_args_mutated.array_get('show_in_menu'))) || rt.is_true(rt.new_bool(!(rt.is_true(var_args_mutated.array_get('show_ui'))))))) {
		var_args_mutated.array_set('show_in_menu', var_args_mutated.array_get('show_ui'))
	}
	if rt.is_true(rt.identical(rt.new_null(), var_args_mutated.array_get('show_in_admin_bar'))) {
		var_args_mutated.array_set('show_in_admin_bar', // unsupported expression: Expr_Cast_Bool)
	}
	if rt.is_true(rt.identical(rt.new_null(), var_args_mutated.array_get('show_in_nav_menus'))) {
		var_args_mutated.array_set('show_in_nav_menus', var_args_mutated.array_get('public'))
	}
	if rt.is_true(rt.identical(rt.new_null(), var_args_mutated.array_get('exclude_from_search'))) {
		var_args_mutated.array_set('exclude_from_search', !(rt.is_true(var_args_mutated.array_get('public'))))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!rt.is_true(var_args_mutated.array_get('capabilities')) && rt.is_true(rt.identical(rt.new_null(), var_args_mutated.array_get('map_meta_cap'))))) && rt.is_true(rt.call_function('in_array', [var_args_mutated.array_get('capability_type'), rt.create_array([rt.ArrayItem{ key: none, val: 'post' }, rt.ArrayItem{ key: none, val: 'page' }]), rt.new_bool(true)])))) {
		var_args_mutated.array_set('map_meta_cap', true)
	}
	if rt.is_true(rt.identical(rt.new_null(), var_args_mutated.array_get('map_meta_cap'))) {
		var_args_mutated.array_set('map_meta_cap', false)
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_args_mutated.array_get('show_ui'))))) && rt.is_true(rt.new_bool(!(rt.is_true(var_has_edit_link)))))) {
		var_args_mutated.array_set('_edit_link', '')
	}
	this.cap = rt.call_function('get_post_type_capabilities', [// unsupported expression: Expr_Cast_Object])
	var_args_mutated.array_unset(rt.new_string('capabilities'))
	if rt.is_true(rt.new_bool(var_args_mutated.array_get('capability_type').is_array())) {
		var_args_mutated.array_set('capability_type', var_args_mutated.array_get('capability_type').array_get(0))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if rt.is_true(rt.identical(rt.new_bool(true), var_args_mutated.array_get('query_var'))) {
			var_args_mutated.array_set('query_var', this.name)
		} else {
			var_args_mutated.array_set('query_var', rt.call_function('sanitize_title_with_dashes', [var_args_mutated.array_get('query_var')]))
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) || rt.is_true(rt.call_function('get_option', [rt.new_string('permalink_structure')])))))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args_mutated.array_get('rewrite').is_array()))))) {
			var_args_mutated.array_set('rewrite', map[string]rt.PhpVal{})
		}
		if !rt.is_true(var_args_mutated.array_get('rewrite').array_get('slug')) {
			var_args_mutated.array_get_mut('rewrite').array_set('slug', this.name)
		}
		if !(var_args_mutated.array_get('rewrite').array_isset(rt.new_string('with_front'))) {
			var_args_mutated.array_get_mut('rewrite').array_set('with_front', true)
		}
		if !(var_args_mutated.array_get('rewrite').array_isset(rt.new_string('pages'))) {
			var_args_mutated.array_get_mut('rewrite').array_set('pages', true)
		}
		if rt.is_true(rt.new_bool(!(var_args_mutated.array_get('rewrite').array_isset(rt.new_string('feeds'))) || rt.is_true(rt.new_bool(!(rt.is_true(var_args_mutated.array_get('has_archive'))))))) {
			var_args_mutated.array_get_mut('rewrite').array_set('feeds', // unsupported expression: Expr_Cast_Bool)
		}
		if !(var_args_mutated.array_get('rewrite').array_isset(rt.new_string('ep_mask'))) {
			var_args_mutated.array_get_mut('rewrite').array_set('ep_mask', if !(var_args_mutated.array_get('permalink_epmask')).is_null() { var_args_mutated.array_get('permalink_epmask') } else { rt.get_constant('EP_PERMALINK') })
		}
	}
	{
		mut iter_1 := var_args_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_property_value := item_1.val
			mut var_property_name := item_1.key
			this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":664,"name":"property_name"}', var_property_value.dup())
		}
	}
	this.labels = rt.call_function('get_post_type_labels', [rt.new_object('WP_Post_Type', []string{}, &this)])
	this.label = rt.get_property(this.labels, 'name')
}

fn (mut this Class_WP_Post_Type) add_supports()  {
	if !(!rt.is_true(this.supports)) {
		{
			mut iter_1 := this.supports.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_args := item_1.val
				mut var_feature := item_1.key
				if rt.is_true(rt.new_bool(var_args.dup().is_array())) {
					rt.call_function('add_post_type_support', [this.name, var_feature.dup(), var_args.dup()])
				} else {
					rt.call_function('add_post_type_support', [this.name, var_args.dup()])
				}
			}
		}
		this.supports = rt.new_null()
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('post_type_supports', [this.name, rt.new_string('editor')])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('post_type_supports', [this.name, rt.new_string('autosave')]))))))) {
			rt.call_function('add_post_type_support', [this.name, rt.new_string('autosave')])
		}
	} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_function('add_post_type_support', [this.name, rt.create_array([rt.ArrayItem{ key: none, val: 'title' }, rt.ArrayItem{ key: none, val: 'editor' }, rt.ArrayItem{ key: none, val: 'autosave' }])])
	}
}

fn (mut this Class_WP_Post_Type) add_rewrite_rules()  {
	mut var_wp_rewrite := rt.new_null()
	mut var_wp := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(var_wp))) && rt.is_true(rt.call_function('is_post_type_viewable', [rt.new_object('WP_Post_Type', []string{}, &this)])))) {
		rt.call_method(var_wp, 'add_query_var', [this.query_var])
	}
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) || rt.is_true(rt.call_function('get_option', [rt.new_string('permalink_structure')])))))) {
		if rt.is_true(this.hierarchical) {
			rt.call_function('add_rewrite_tag', [rt.concat(rt.concat(rt.new_string('%'), this.name), rt.new_string('%')), rt.new_string('(.+?)'), if rt.is_true(this.query_var) { rt.concat(this.query_var, rt.new_string('=')) } else { rt.concat(rt.concat(rt.new_string('post_type='), this.name), rt.new_string('&pagename=')) }])
		} else {
			rt.call_function('add_rewrite_tag', [rt.concat(rt.concat(rt.new_string('%'), this.name), rt.new_string('%')), rt.new_string('([^/]+)'), if rt.is_true(this.query_var) { rt.concat(this.query_var, rt.new_string('=')) } else { rt.concat(rt.concat(rt.new_string('post_type='), this.name), rt.new_string('&name=')) }])
		}
		if rt.is_true(this.has_archive) {
			mut var_archive_slug := if rt.is_true(rt.identical(rt.new_bool(true), this.has_archive)) { this.rewrite.array_get('slug') } else { this.has_archive }
			if rt.is_true(this.rewrite.array_get('with_front')) {
				var_archive_slug = rt.new_string(rt.concat(rt.call_function('substr', [rt.get_property(var_wp_rewrite, 'front'), rt.new_int(1)]), var_archive_slug))
			} else {
				var_archive_slug = rt.new_string(rt.concat(rt.get_property(var_wp_rewrite, 'root'), var_archive_slug))
			}
			rt.call_function('add_rewrite_rule', [rt.concat(var_archive_slug, rt.new_string('/?$')), rt.concat(rt.new_string('index.php?post_type='), this.name), rt.new_string('top')])
			if rt.is_true(rt.new_bool(rt.is_true(this.rewrite.array_get('feeds')) && rt.is_true(rt.get_property(var_wp_rewrite, 'feeds')))) {
				mut var_feeds := rt.new_string('(' + rt.call_function('implode', [rt.new_string('|'), rt.get_property(var_wp_rewrite, 'feeds')]).to_string().trim_space() + ')')
				rt.call_function('add_rewrite_rule', [rt.concat(rt.concat(rt.concat(var_archive_slug, rt.new_string('/feed/')), var_feeds), rt.new_string('/?$')), rt.concat(rt.new_string('index.php?post_type='), this.name) + '&feed=$matches[1]', rt.new_string('top')])
				rt.call_function('add_rewrite_rule', [rt.concat(rt.concat(rt.concat(var_archive_slug, rt.new_string('/')), var_feeds), rt.new_string('/?$')), rt.concat(rt.new_string('index.php?post_type='), this.name) + '&feed=$matches[1]', rt.new_string('top')])
			}
			if rt.is_true(this.rewrite.array_get('pages')) {
				rt.call_function('add_rewrite_rule', [rt.concat(rt.concat(rt.concat(var_archive_slug, rt.new_string('/')), rt.get_property(var_wp_rewrite, 'pagination_base')), rt.new_string('/([0-9]{1,})/?$')), rt.concat(rt.new_string('index.php?post_type='), this.name) + '&paged=$matches[1]', rt.new_string('top')])
			}
		}
		mut var_permastruct_args := this.rewrite
		var_permastruct_args.array_set('feed', var_permastruct_args.array_get('feeds'))
		rt.call_function('add_permastruct', [this.name, rt.concat(rt.concat(rt.concat(this.rewrite.array_get('slug'), rt.new_string('/%')), this.name), rt.new_string('%')), var_permastruct_args.dup()])
	}
}

fn (mut this Class_WP_Post_Type) register_meta_boxes()  {
	if rt.is_true(this.register_meta_box_cb) {
		rt.call_function('add_action', ['add_meta_boxes_' + (this.name).str(), this.register_meta_box_cb, rt.new_int(10), rt.new_int(1)])
	}
}

fn (mut this Class_WP_Post_Type) add_hooks()  {
	rt.call_function('add_action', ['future_' + (this.name).str(), rt.new_string('_future_post_hook'), rt.new_int(5), rt.new_int(2)])
}

fn (mut this Class_WP_Post_Type) register_taxonomies()  {
	{
		mut iter_1 := this.taxonomies.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_taxonomy := item_1.val
			rt.call_function('register_taxonomy_for_object_type', [var_taxonomy.dup(), this.name])
		}
	}
}

fn (mut this Class_WP_Post_Type) remove_supports()  {
	mut var__wp_post_type_features := rt.new_null()
	// unsupported statement: Stmt_Global
	var__wp_post_type_features.array_unset(this.name)
}

fn (mut this Class_WP_Post_Type) remove_rewrite_rules()  {
	mut var_wp := rt.new_null()
	mut var_wp_rewrite := rt.new_null()
	mut var_post_type_meta_caps := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_method(var_wp, 'remove_query_var', [this.query_var])
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_function('remove_rewrite_tag', [rt.concat(rt.concat(rt.new_string('%'), this.name), rt.new_string('%'))])
		rt.call_function('remove_permastruct', [this.name])
		{
			mut iter_1 := rt.get_property(var_wp_rewrite, 'extra_rules_top').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_query := item_1.val
				mut var_regex := item_1.key
				if rt.is_true(rt.call_function('str_contains', [var_query.dup(), rt.concat(rt.new_string('index.php?post_type='), this.name)])) {
					rt.get_property(var_wp_rewrite, 'extra_rules_top').array_unset(var_regex)
				}
			}
		}
	}
	{
		mut iter_1 := this.cap.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_cap := item_1.val
			var_post_type_meta_caps.array_unset(var_cap)
		}
	}
}

fn (mut this Class_WP_Post_Type) unregister_meta_boxes()  {
	if rt.is_true(this.register_meta_box_cb) {
		rt.call_function('remove_action', ['add_meta_boxes_' + (this.name).str(), this.register_meta_box_cb, rt.new_int(10)])
	}
}

fn (mut this Class_WP_Post_Type) unregister_taxonomies()  {
	{
		mut iter_1 := rt.call_function('get_object_taxonomies', [this.name]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_taxonomy := item_1.val
			rt.call_function('unregister_taxonomy_for_object_type', [var_taxonomy.dup(), this.name])
		}
	}
}

fn (mut this Class_WP_Post_Type) remove_hooks()  {
	rt.call_function('remove_action', ['future_' + (this.name).str(), rt.new_string('_future_post_hook'), rt.new_int(5)])
}

fn (mut this Class_WP_Post_Type) get_rest_controller() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.show_in_rest)))) {
		return rt.new_null()
	}
	mut var_class := if rt.is_true(this.rest_controller_class) { this.rest_controller_class } else { Class_WP_REST_Posts_Controller.class() }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [var_class.dup()]))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subclass_of', [var_class.dup(), Class_WP_REST_Controller.class()]))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.rest_controller)))) {
		this.rest_controller = rt.create_object_dynamically(var_class, [this.name])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(this.rest_controller, '{"nodeType":"Expr_Variable","line":888,"name":"class"}')))))) {
		return rt.new_null()
	}
	return this.rest_controller
}

fn (mut this Class_WP_Post_Type) get_revisions_rest_controller() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.show_in_rest)))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('post_type_supports', [this.name, rt.new_string('revisions')]))))) {
		return rt.new_null()
	}
	mut var_class := if rt.is_true(this.revisions_rest_controller_class) { this.revisions_rest_controller_class } else { Class_WP_REST_Revisions_Controller.class() }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [var_class.dup()]))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subclass_of', [var_class.dup(), Class_WP_REST_Controller.class()]))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.revisions_rest_controller)))) {
		this.revisions_rest_controller = rt.create_object_dynamically(var_class, [this.name])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(this.revisions_rest_controller, '{"nodeType":"Expr_Variable","line":927,"name":"class"}')))))) {
		return rt.new_null()
	}
	return this.revisions_rest_controller
}

fn (mut this Class_WP_Post_Type) get_autosave_rest_controller() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.show_in_rest)))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('post_type_supports', [this.name, rt.new_string('autosave')]))))) {
		return rt.new_null()
	}
	mut var_class := if rt.is_true(this.autosave_rest_controller_class) { this.autosave_rest_controller_class } else { Class_WP_REST_Autosaves_Controller.class() }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [var_class.dup()]))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subclass_of', [var_class.dup(), Class_WP_REST_Controller.class()]))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.autosave_rest_controller)))) {
		this.autosave_rest_controller = rt.create_object_dynamically(, [])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(, '{"nodeType":"Expr_Variable","line":967,"name":"class"}')))))) {
		return rt.new_null()
	}
	return this.autosave_rest_controller
}

fn Class_WP_Post_Type.get_default_labels() rt.PhpVal {
	if !(!rt.is_true()) {
	}
	
}

fn Class_WP_Post_Type.reset_default_labels()  {
}

fn create_wp_post_type(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_WP_Post_Type {
	mut obj := &Class_WP_Post_Type{
		PhpObjectBase: rt.PhpObjectBase{}
		name: rt.new_null()
		label: rt.new_null()
		labels: rt.new_null()
		default_labels: rt.new_array()
		description: rt.new_string('')
		public: rt.new_bool(false)
		hierarchical: rt.new_bool(false)
		exclude_from_search: rt.new_null()
		publicly_queryable: rt.new_null()
		embeddable: rt.new_null()
		show_ui: rt.new_null()
		show_in_menu: rt.new_null()
		show_in_nav_menus: rt.new_null()
		show_in_admin_bar: rt.new_null()
		menu_position: rt.new_null()
		menu_icon: rt.new_null()
		capability_type: rt.new_string('post')
		map_meta_cap: rt.new_bool(false)
		register_meta_box_cb: rt.new_null()
		taxonomies: rt.new_array()
		has_archive: rt.new_bool(false)
		query_var: rt.new_null()
		can_export: rt.new_bool(true)
		delete_with_user: rt.new_null()
		template: rt.new_array()
		template_lock: rt.new_bool(false)
		_builtin: rt.new_bool(false)
		_edit_link: rt.new_string('post.php?post=%d')
		cap: rt.new_null()
		rewrite: rt.new_null()
		supports: rt.new_null()
		show_in_rest: rt.new_null()
		rest_base: rt.new_null()
		rest_namespace: rt.new_null()
		rest_controller_class: rt.new_null()
		rest_controller: rt.new_null()
		revisions_rest_controller_class: rt.new_null()
		revisions_rest_controller: rt.new_null()
		autosave_rest_controller_class: rt.new_null()
		autosave_rest_controller: rt.new_null()
		late_route_registration: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn (mut this Class_WP_Post_Type) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'set_props' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_props(dispatch_arg_0)
			return rt.new_null()
		}
		'add_supports' {
			this.add_supports()
			return rt.new_null()
		}
		'add_rewrite_rules' {
			this.add_rewrite_rules()
			return rt.new_null()
		}
		'register_meta_boxes' {
			this.register_meta_boxes()
			return rt.new_null()
		}
		'add_hooks' {
			this.add_hooks()
			return rt.new_null()
		}
		'register_taxonomies' {
			this.register_taxonomies()
			return rt.new_null()
		}
		'remove_supports' {
			this.remove_supports()
			return rt.new_null()
		}
		'remove_rewrite_rules' {
			this.remove_rewrite_rules()
			return rt.new_null()
		}
		'unregister_meta_boxes' {
			this.unregister_meta_boxes()
			return rt.new_null()
		}
		'unregister_taxonomies' {
			this.unregister_taxonomies()
			return rt.new_null()
		}
		'remove_hooks' {
			this.remove_hooks()
			return rt.new_null()
		}
		'get_rest_controller' {
			return this.get_rest_controller()
		}
		'get_revisions_rest_controller' {
			return this.get_revisions_rest_controller()
		}
		'get_autosave_rest_controller' {
			return this.get_autosave_rest_controller()
		}
		'get_default_labels' {
			return Class_WP_Post_Type.get_default_labels()
		}
		'reset_default_labels' {
			Class_WP_Post_Type.reset_default_labels()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_Post_Type) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'label' { return this.label }
		'labels' { return this.labels }
		'default_labels' { return this.default_labels }
		'description' { return this.description }
		'public' { return this.public }
		'hierarchical' { return this.hierarchical }
		'exclude_from_search' { return this.exclude_from_search }
		'publicly_queryable' { return this.publicly_queryable }
		'embeddable' { return this.embeddable }
		'show_ui' { return this.show_ui }
		'show_in_menu' { return this.show_in_menu }
		'show_in_nav_menus' { return this.show_in_nav_menus }
		'show_in_admin_bar' { return this.show_in_admin_bar }
		'menu_position' { return this.menu_position }
		'menu_icon' { return this.menu_icon }
		'capability_type' { return this.capability_type }
		'map_meta_cap' { return this.map_meta_cap }
		'register_meta_box_cb' { return this.register_meta_box_cb }
		'taxonomies' { return this.taxonomies }
		'has_archive' { return this.has_archive }
		'query_var' { return this.query_var }
		'can_export' { return this.can_export }
		'delete_with_user' { return this.delete_with_user }
		'template' { return this.template }
		'template_lock' { return this.template_lock }
		'_builtin' { return this._builtin }
		'_edit_link' { return this._edit_link }
		'cap' { return this.cap }
		'rewrite' { return this.rewrite }
		'supports' { return this.supports }
		'show_in_rest' { return this.show_in_rest }
		'rest_base' { return this.rest_base }
		'rest_namespace' { return this.rest_namespace }
		'rest_controller_class' { return this.rest_controller_class }
		'rest_controller' { return this.rest_controller }
		'revisions_rest_controller_class' { return this.revisions_rest_controller_class }
		'revisions_rest_controller' { return this.revisions_rest_controller }
		'autosave_rest_controller_class' { return this.autosave_rest_controller_class }
		'autosave_rest_controller' { return this.autosave_rest_controller }
		'late_route_registration' { return this.late_route_registration }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Post_Type) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' { this.name = val; return true }
		'label' { this.label = val; return true }
		'labels' { this.labels = val; return true }
		'default_labels' { this.default_labels = val; return true }
		'description' { this.description = val; return true }
		'public' { this.public = val; return true }
		'hierarchical' { this.hierarchical = val; return true }
		'exclude_from_search' { this.exclude_from_search = val; return true }
		'publicly_queryable' { this.publicly_queryable = val; return true }
		'embeddable' { this.embeddable = val; return true }
		'show_ui' { this.show_ui = val; return true }
		'show_in_menu' { this.show_in_menu = val; return true }
		'show_in_nav_menus' { this.show_in_nav_menus = val; return true }
		'show_in_admin_bar' { this.show_in_admin_bar = val; return true }
		'menu_position' { this.menu_position = val; return true }
		'menu_icon' { this.menu_icon = val; return true }
		'capability_type' { this.capability_type = val; return true }
		'map_meta_cap' { this.map_meta_cap = val; return true }
		'register_meta_box_cb' { this.register_meta_box_cb = val; return true }
		'taxonomies' { this.taxonomies = val; return true }
		'has_archive' { this.has_archive = val; return true }
		'query_var' { this.query_var = val; return true }
		'can_export' { this.can_export = val; return true }
		'delete_with_user' { this.delete_with_user = val; return true }
		'template' { this.template = val; return true }
		'template_lock' { this.template_lock = val; return true }
		'_builtin' { this._builtin = val; return true }
		'_edit_link' { this._edit_link = val; return true }
		'cap' { this.cap = val; return true }
		'rewrite' { this.rewrite = val; return true }
		'supports' { this.supports = val; return true }
		'show_in_rest' { this.show_in_rest = val; return true }
		'rest_base' { this.rest_base = val; return true }
		'rest_namespace' { this.rest_namespace = val; return true }
		'rest_controller_class' { this.rest_controller_class = val; return true }
		'rest_controller' { this.rest_controller = val; return true }
		'revisions_rest_controller_class' { this.revisions_rest_controller_class = val; return true }
		'revisions_rest_controller' { this.revisions_rest_controller = val; return true }
		'autosave_rest_controller_class' { this.autosave_rest_controller_class = val; return true }
		'autosave_rest_controller' { this.autosave_rest_controller = val; return true }
		'late_route_registration' { this.late_route_registration = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn init_registry() {
	rt.register_class_factory('WP_Post_Type', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		c_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		obj := create_wp_post_type(c_arg_0, c_arg_1)
		return rt.new_object('WP_Post_Type', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_includes_class_wp_post_type_php() {
}
