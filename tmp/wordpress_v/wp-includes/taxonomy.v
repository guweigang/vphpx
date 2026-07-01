import rt

fn create_initial_taxonomies() {
	mut var_wp_rewrite := rt.new_null()
	// unsupported statement: Stmt_Global
	fn () rt.PhpVal { mut temp := Class_WP_Taxonomy{}; return temp.reset_default_labels() }()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))))) {
		mut var_rewrite := { 'category': rt.new_bool(false), 'post_tag': rt.new_bool(false), 'post_format': rt.new_bool(false) }
	} else {
		mut var_post_format_base := rt.call_function('apply_filters', [rt.new_string('post_format_rewrite_base'), rt.new_string('type')])
		var_rewrite = { 'category': { 'hierarchical': rt.new_bool(true), 'slug': if rt.is_true(rt.call_function('get_option', [rt.new_string('category_base')])) { rt.call_function('get_option', [rt.new_string('category_base')]) } else { rt.new_string('category') }, 'with_front': rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [rt.new_string('category_base')]))))) || rt.is_true(rt.call_method(var_wp_rewrite, 'using_index_permalinks', []rt.PhpVal{}))), 'ep_mask': rt.get_constant('EP_CATEGORIES') }, 'post_tag': { 'hierarchical': rt.new_bool(false), 'slug': if rt.is_true(rt.call_function('get_option', [rt.new_string('tag_base')])) { rt.call_function('get_option', [rt.new_string('tag_base')]) } else { rt.new_string('tag') }, 'with_front': rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [rt.new_string('tag_base')]))))) || rt.is_true(rt.call_method(var_wp_rewrite, 'using_index_permalinks', []rt.PhpVal{}))), 'ep_mask': rt.get_constant('EP_TAGS') }, 'post_format': if rt.is_true(var_post_format_base) { { 'slug': var_post_format_base } } else { rt.new_bool(false) } }
	}
	register_taxonomy('category', rt.new_string('post'), rt.create_array([rt.ArrayItem{ key: 'hierarchical', val: true }, rt.ArrayItem{ key: 'query_var', val: 'category_name' }, rt.ArrayItem{ key: 'rewrite', val: var_rewrite.array_get('category') }, rt.ArrayItem{ key: 'public', val: true }, rt.ArrayItem{ key: 'show_ui', val: true }, rt.ArrayItem{ key: 'show_admin_column', val: true }, rt.ArrayItem{ key: '_builtin', val: true }, rt.ArrayItem{ key: 'capabilities', val: rt.create_array([rt.ArrayItem{ key: 'manage_terms', val: 'manage_categories' }, rt.ArrayItem{ key: 'edit_terms', val: 'edit_categories' }, rt.ArrayItem{ key: 'delete_terms', val: 'delete_categories' }, rt.ArrayItem{ key: 'assign_terms', val: 'assign_categories' }]) }, rt.ArrayItem{ key: 'show_in_rest', val: true }, rt.ArrayItem{ key: 'rest_base', val: 'categories' }, rt.ArrayItem{ key: 'rest_controller_class', val: 'WP_REST_Terms_Controller' }]))
	register_taxonomy('post_tag', rt.new_string('post'), rt.create_array([rt.ArrayItem{ key: 'hierarchical', val: false }, rt.ArrayItem{ key: 'query_var', val: 'tag' }, rt.ArrayItem{ key: 'rewrite', val: var_rewrite.array_get('post_tag') }, rt.ArrayItem{ key: 'public', val: true }, rt.ArrayItem{ key: 'show_ui', val: true }, rt.ArrayItem{ key: 'show_admin_column', val: true }, rt.ArrayItem{ key: '_builtin', val: true }, rt.ArrayItem{ key: 'capabilities', val: rt.create_array([rt.ArrayItem{ key: 'manage_terms', val: 'manage_post_tags' }, rt.ArrayItem{ key: 'edit_terms', val: 'edit_post_tags' }, rt.ArrayItem{ key: 'delete_terms', val: 'delete_post_tags' }, rt.ArrayItem{ key: 'assign_terms', val: 'assign_post_tags' }]) }, rt.ArrayItem{ key: 'show_in_rest', val: true }, rt.ArrayItem{ key: 'rest_base', val: 'tags' }, rt.ArrayItem{ key: 'rest_controller_class', val: 'WP_REST_Terms_Controller' }]))
	register_taxonomy('nav_menu', rt.new_string('nav_menu_item'), rt.create_array([rt.ArrayItem{ key: 'public', val: false }, rt.ArrayItem{ key: 'hierarchical', val: false }, rt.ArrayItem{ key: 'labels', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Navigation Menus')]) }, rt.ArrayItem{ key: 'singular_name', val: rt.call_function('__', [rt.new_string('Navigation Menu')]) }]) }, rt.ArrayItem{ key: 'query_var', val: false }, rt.ArrayItem{ key: 'rewrite', val: false }, rt.ArrayItem{ key: 'show_ui', val: false }, rt.ArrayItem{ key: '_builtin', val: true }, rt.ArrayItem{ key: 'show_in_nav_menus', val: false }, rt.ArrayItem{ key: 'capabilities', val: rt.create_array([rt.ArrayItem{ key: 'manage_terms', val: 'edit_theme_options' }, rt.ArrayItem{ key: 'edit_terms', val: 'edit_theme_options' }, rt.ArrayItem{ key: 'delete_terms', val: 'edit_theme_options' }, rt.ArrayItem{ key: 'assign_terms', val: 'edit_theme_options' }]) }, rt.ArrayItem{ key: 'show_in_rest', val: true }, rt.ArrayItem{ key: 'rest_base', val: 'menus' }, rt.ArrayItem{ key: 'rest_controller_class', val: 'WP_REST_Menus_Controller' }]))
	register_taxonomy('link_category', rt.new_string('link'), rt.create_array([rt.ArrayItem{ key: 'hierarchical', val: false }, rt.ArrayItem{ key: 'labels', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Link Categories')]) }, rt.ArrayItem{ key: 'singular_name', val: rt.call_function('__', [rt.new_string('Link Category')]) }, rt.ArrayItem{ key: 'search_items', val: rt.call_function('__', [rt.new_string('Search Link Categories')]) }, rt.ArrayItem{ key: 'popular_items', val: rt.new_null() }, rt.ArrayItem{ key: 'all_items', val: rt.call_function('__', [rt.new_string('All Link Categories')]) }, rt.ArrayItem{ key: 'edit_item', val: rt.call_function('__', [rt.new_string('Edit Link Category')]) }, rt.ArrayItem{ key: 'update_item', val: rt.call_function('__', [rt.new_string('Update Link Category')]) }, rt.ArrayItem{ key: 'add_new_item', val: rt.call_function('__', [rt.new_string('Add Link Category')]) }, rt.ArrayItem{ key: 'new_item_name', val: rt.call_function('__', [rt.new_string('New Link Category Name')]) }, rt.ArrayItem{ key: 'separate_items_with_commas', val: rt.new_null() }, rt.ArrayItem{ key: 'add_or_remove_items', val: rt.new_null() }, rt.ArrayItem{ key: 'choose_from_most_used', val: rt.new_null() }, rt.ArrayItem{ key: 'back_to_items', val: rt.call_function('__', [rt.new_string('&larr; Go to Link Categories')]) }]) }, rt.ArrayItem{ key: 'capabilities', val: rt.create_array([rt.ArrayItem{ key: 'manage_terms', val: 'manage_links' }, rt.ArrayItem{ key: 'edit_terms', val: 'manage_links' }, rt.ArrayItem{ key: 'delete_terms', val: 'manage_links' }, rt.ArrayItem{ key: 'assign_terms', val: 'manage_links' }]) }, rt.ArrayItem{ key: 'query_var', val: false }, rt.ArrayItem{ key: 'rewrite', val: false }, rt.ArrayItem{ key: 'public', val: false }, rt.ArrayItem{ key: 'show_ui', val: true }, rt.ArrayItem{ key: '_builtin', val: true }]))
	register_taxonomy('post_format', rt.new_string('post'), rt.create_array([rt.ArrayItem{ key: 'public', val: true }, rt.ArrayItem{ key: 'hierarchical', val: false }, rt.ArrayItem{ key: 'labels', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('_x', [rt.new_string('Formats'), rt.new_string('post format')]) }, rt.ArrayItem{ key: 'singular_name', val: rt.call_function('_x', [rt.new_string('Format'), rt.new_string('post format')]) }]) }, rt.ArrayItem{ key: 'query_var', val: true }, rt.ArrayItem{ key: 'rewrite', val: var_rewrite.array_get('post_format') }, rt.ArrayItem{ key: 'show_ui', val: false }, rt.ArrayItem{ key: '_builtin', val: true }, rt.ArrayItem{ key: 'show_in_nav_menus', val: rt.call_function('current_theme_supports', [rt.new_string('post-formats')]) }]))
	register_taxonomy('wp_theme', rt.create_array([rt.ArrayItem{ key: none, val: 'wp_template' }, rt.ArrayItem{ key: none, val: 'wp_template_part' }, rt.ArrayItem{ key: none, val: 'wp_global_styles' }]), rt.create_array([rt.ArrayItem{ key: 'public', val: false }, rt.ArrayItem{ key: 'hierarchical', val: false }, rt.ArrayItem{ key: 'labels', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Themes')]) }, rt.ArrayItem{ key: 'singular_name', val: rt.call_function('__', [rt.new_string('Theme')]) }]) }, rt.ArrayItem{ key: 'query_var', val: false }, rt.ArrayItem{ key: 'rewrite', val: false }, rt.ArrayItem{ key: 'show_ui', val: false }, rt.ArrayItem{ key: '_builtin', val: true }, rt.ArrayItem{ key: 'show_in_nav_menus', val: false }, rt.ArrayItem{ key: 'show_in_rest', val: false }]))
	register_taxonomy('wp_template_part_area', rt.create_array([rt.ArrayItem{ key: none, val: 'wp_template_part' }]), rt.create_array([rt.ArrayItem{ key: 'public', val: false }, rt.ArrayItem{ key: 'hierarchical', val: false }, rt.ArrayItem{ key: 'labels', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Template Part Areas')]) }, rt.ArrayItem{ key: 'singular_name', val: rt.call_function('__', [rt.new_string('Template Part Area')]) }]) }, rt.ArrayItem{ key: 'query_var', val: false }, rt.ArrayItem{ key: 'rewrite', val: false }, rt.ArrayItem{ key: 'show_ui', val: false }, rt.ArrayItem{ key: '_builtin', val: true }, rt.ArrayItem{ key: 'show_in_nav_menus', val: false }, rt.ArrayItem{ key: 'show_in_rest', val: false }]))
	register_taxonomy('wp_pattern_category', rt.create_array([rt.ArrayItem{ key: none, val: 'wp_block' }]), rt.create_array([rt.ArrayItem{ key: 'public', val: false }, rt.ArrayItem{ key: 'publicly_queryable', val: false }, rt.ArrayItem{ key: 'hierarchical', val: false }, rt.ArrayItem{ key: 'labels', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('_x', [rt.new_string('Pattern Categories'), rt.new_string('taxonomy general name')]) }, rt.ArrayItem{ key: 'singular_name', val: rt.call_function('_x', [rt.new_string('Pattern Category'), rt.new_string('taxonomy singular name')]) }, rt.ArrayItem{ key: 'add_new_item', val: rt.call_function('__', [rt.new_string('Add Category')]) }, rt.ArrayItem{ key: 'add_or_remove_items', val: rt.call_function('__', [rt.new_string('Add or remove pattern categories')]) }, rt.ArrayItem{ key: 'back_to_items', val: rt.call_function('__', [rt.new_string('&larr; Go to Pattern Categories')]) }, rt.ArrayItem{ key: 'choose_from_most_used', val: rt.call_function('__', [rt.new_string('Choose from the most used pattern categories')]) }, rt.ArrayItem{ key: 'edit_item', val: rt.call_function('__', [rt.new_string('Edit Pattern Category')]) }, rt.ArrayItem{ key: 'item_link', val: rt.call_function('__', [rt.new_string('Pattern Category Link')]) }, rt.ArrayItem{ key: 'item_link_description', val: rt.call_function('__', [rt.new_string('A link to a pattern category.')]) }, rt.ArrayItem{ key: 'items_list', val: rt.call_function('__', [rt.new_string('Pattern Categories list')]) }, rt.ArrayItem{ key: 'items_list_navigation', val: rt.call_function('__', [rt.new_string('Pattern Categories list navigation')]) }, rt.ArrayItem{ key: 'new_item_name', val: rt.call_function('__', [rt.new_string('New Pattern Category Name')]) }, rt.ArrayItem{ key: 'no_terms', val: rt.call_function('__', [rt.new_string('No pattern categories')]) }, rt.ArrayItem{ key: 'not_found', val: rt.call_function('__', [rt.new_string('No pattern categories found.')]) }, rt.ArrayItem{ key: 'popular_items', val: rt.call_function('__', [rt.new_string('Popular Pattern Categories')]) }, rt.ArrayItem{ key: 'search_items', val: rt.call_function('__', [rt.new_string('Search Pattern Categories')]) }, rt.ArrayItem{ key: 'separate_items_with_commas', val: rt.call_function('__', [rt.new_string('Separate pattern categories with commas')]) }, rt.ArrayItem{ key: 'update_item', val: rt.call_function('__', [rt.new_string('Update Pattern Category')]) }, rt.ArrayItem{ key: 'view_item', val: rt.call_function('__', [rt.new_string('View Pattern Category')]) }]) }, rt.ArrayItem{ key: 'query_var', val: false }, rt.ArrayItem{ key: 'rewrite', val: false }, rt.ArrayItem{ key: 'show_ui', val: true }, rt.ArrayItem{ key: '_builtin', val: true }, rt.ArrayItem{ key: 'show_in_nav_menus', val: false }, rt.ArrayItem{ key: 'show_in_rest', val: true }, rt.ArrayItem{ key: 'show_admin_column', val: true }, rt.ArrayItem{ key: 'show_tagcloud', val: false }]))
}

fn get_taxonomies(var_args rt.PhpVal, output string, operator string) rt.PhpVal {
	mut var_wp_taxonomies := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_field := if rt.is_true(rt.identical(rt.new_string('names'), rt.new_string(output))) { rt.new_string('name') } else { rt.new_bool(false) }
	return rt.call_function('wp_filter_object_list', [var_wp_taxonomies.dup(), var_args.dup(), rt.new_string(operator), var_field.dup()])
}

fn get_object_taxonomies(var_object_type rt.PhpVal, output string) rt.PhpVal {
	mut var_wp_taxonomies := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(var_object_type.dup().is_object())) {
		if rt.is_true(rt.identical(rt.new_string('attachment'), rt.get_property(var_object_type, 'post_type'))) {
			return rt.call_function('get_attachment_taxonomies', [var_object_type.dup(), rt.new_string(output)])
		}
		var_object_type = rt.get_property(var_object_type, 'post_type')
	}
	var_object_type = rt.cast_array(var_object_type)
	mut var_taxonomies := rt.new_array()
	{
		mut iter_1 := rt.cast_array(var_wp_taxonomies).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tax_obj := item_1.val
			mut var_tax_name := item_1.key
			if rt.is_true(rt.call_function('array_intersect', [var_object_type.dup(), rt.cast_array(rt.get_property(var_tax_obj, 'object_type'))])) {
				if rt.is_true(rt.identical(rt.new_string('names'), rt.new_string(output))) {
					var_taxonomies.array_push(var_tax_name.dup())
				} else {
					var_taxonomies.array_set(var_tax_name, var_tax_obj.dup())
				}
			}
		}
	}
	return var_taxonomies.dup()
}

fn get_taxonomy(var_taxonomy rt.PhpVal) bool {
	mut var_wp_taxonomies := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(taxonomy_exists(var_taxonomy.dup())) {
		return false
	}
	return (var_wp_taxonomies.array_get(var_taxonomy)).to_bool()
}

fn taxonomy_exists(var_taxonomy rt.PhpVal) bool {
	mut var_wp_taxonomies := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.is_true(rt.new_bool(var_taxonomy.dup().is_string())) && var_wp_taxonomies.array_isset(var_taxonomy)
}

fn is_taxonomy_hierarchical(var_taxonomy rt.PhpVal) bool {
	if !(taxonomy_exists(var_taxonomy)) {
		return false
	}
	var_taxonomy = get_taxonomy(var_taxonomy)
	return (rt.get_property(rt.new_bool(var_taxonomy), 'hierarchical')).to_bool()
}

fn register_taxonomy(taxonomy string, var_object_type rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_wp_taxonomies.dup().is_array()))))) {
		mut var_wp_taxonomies := rt.new_array()
	}
	var_args = rt.call_function('wp_parse_args', [var_args.dup()])
	if taxonomy == '' || taxonomy.len > 32 {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Taxonomy names must be between 1 and 32 characters in length.')]), rt.new_string('4.2.0')])
		return create_wp_error(rt.new_string('taxonomy_length_invalid'), rt.call_function('__', [rt.new_string('Taxonomy names must be between 1 and 32 characters in length.')]))
	}
	mut var_taxonomy_object := create_wp_taxonomy(rt.new_string(taxonomy).dup(), var_object_type.dup(), var_args.dup())
	rt.call_method(var_taxonomy_object, 'add_rewrite_rules', []rt.PhpVal{})
	var_wp_taxonomies.array_set(taxonomy, var_taxonomy_object.dup())
	rt.call_method(var_taxonomy_object, 'add_hooks', []rt.PhpVal{})
	if !(!rt.is_true(rt.get_property(var_taxonomy_object, 'default_term'))) {
		mut var_term := term_exists(rt.get_property(var_taxonomy_object, 'default_term').array_get('name'), taxonomy, rt.new_null())
		if rt.is_true(var_term) {
			rt.call_function('update_option', ['default_term_' + (rt.get_property(var_taxonomy_object, 'name')).str(), var_term.array_get('term_id')])
		} else {
			var_term = wp_insert_term(rt.get_property(var_taxonomy_object, 'default_term').array_get('name'), rt.new_string(taxonomy), rt.create_array([rt.ArrayItem{ key: 'slug', val: rt.call_function('sanitize_title', [rt.get_property(var_taxonomy_object, 'default_term').array_get('slug')]) }, rt.ArrayItem{ key: 'description', val: rt.get_property(var_taxonomy_object, 'default_term').array_get('description') }]))
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.dup()]))))) {
				rt.call_function('update_option', ['default_term_' + (rt.get_property(var_taxonomy_object, 'name')).str(), var_term.array_get('term_id')])
			}
		}
	}
	rt.call_function('do_action', [rt.new_string('registered_taxonomy'), rt.new_string(taxonomy), var_object_type.dup(), rt.cast_array(var_taxonomy_object)])
	rt.call_function('do_action', [rt.new_string("registered_taxonomy_${var_taxonomy}"), rt.new_string(taxonomy), var_object_type.dup(), rt.cast_array(var_taxonomy_object)])
	return var_taxonomy_object.dup()
}

fn unregister_taxonomy(var_taxonomy rt.PhpVal) bool {
	mut var_wp_taxonomies := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(taxonomy_exists(var_taxonomy.dup())) {
		return (create_wp_error(rt.new_string('invalid_taxonomy'), rt.call_function('__', [rt.new_string('Invalid taxonomy.')]))).to_bool()
	}
	mut var_taxonomy_object := get_taxonomy(var_taxonomy.dup())
	if rt.is_true(rt.get_property(rt.new_bool(var_taxonomy_object), '_builtin')) {
		return (create_wp_error(rt.new_string('invalid_taxonomy'), rt.call_function('__', [rt.new_string('Unregistering a built-in taxonomy is not allowed.')]))).to_bool()
	}
	rt.call_method(rt.new_bool(var_taxonomy_object), 'remove_rewrite_rules', []rt.PhpVal{})
	rt.call_method(rt.new_bool(var_taxonomy_object), 'remove_hooks', []rt.PhpVal{})
	var_wp_taxonomies.array_unset(var_taxonomy)
	rt.call_function('do_action', [rt.new_string('unregistered_taxonomy'), var_taxonomy.dup()])
	return true
}

fn get_taxonomy_labels(var_tax rt.PhpVal) rt.PhpVal {
	rt.set_property(var_tax, 'labels', rt.cast_array(rt.get_property(var_tax, 'labels')))
	if !(rt.get_property(var_tax, 'helps')).is_null() && !rt.is_true(rt.get_property(var_tax, 'labels').array_get('separate_items_with_commas')) {
		rt.get_property(var_tax, 'labels').array_set('separate_items_with_commas', rt.get_property(var_tax, 'helps'))
	}
	if !(rt.get_property(var_tax, 'no_tagcloud')).is_null() && !rt.is_true(rt.get_property(var_tax, 'labels').array_get('not_found')) {
		rt.get_property(var_tax, 'labels').array_set('not_found', rt.get_property(var_tax, 'no_tagcloud'))
	}
	mut var_nohier_vs_hier_defaults := fn () rt.PhpVal { mut temp := Class_WP_Taxonomy{}; return temp.get_default_labels() }()
	var_nohier_vs_hier_defaults.array_set('menu_name', var_nohier_vs_hier_defaults.array_get('name'))
	mut var_labels := rt.call_function('_get_custom_object_labels', [var_tax.dup(), var_nohier_vs_hier_defaults.dup()])
	if !(!(rt.get_property(rt.get_property(var_tax, 'labels'), 'template_name')).is_null()) && !(rt.get_property(var_labels, 'singular_name')).is_null() {
		rt.set_property(var_labels, 'template_name', rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('%s Archives'), rt.new_string('taxonomy template name')]), rt.get_property(var_labels, 'singular_name')]))
	}
	mut var_taxonomy := rt.get_property(var_tax, 'name')
	mut var_default_labels := // unsupported expression: Expr_Clone
	var_labels = rt.call_function('apply_filters', [rt.new_string("taxonomy_labels_${var_taxonomy.to_string()}"), var_labels.dup()])
	var_labels = // unsupported expression: Expr_Cast_Object
	return var_labels.dup()
}

fn register_taxonomy_for_object_type(var_taxonomy rt.PhpVal, var_object_type rt.PhpVal) bool {
	mut var_wp_taxonomies := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(var_wp_taxonomies.array_isset(var_taxonomy)) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_post_type_object', [var_object_type.dup()]))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_object_type.dup(), rt.get_property(var_wp_taxonomies.array_get(var_taxonomy), 'object_type'), rt.new_bool(true)]))))) {
		rt.get_property(var_wp_taxonomies.array_get(var_taxonomy), 'object_type').array_push(var_object_type.dup())
	}
	rt.set_property(var_wp_taxonomies.array_get(var_taxonomy), 'object_type', rt.call_function('array_filter', [rt.get_property(var_wp_taxonomies.array_get(var_taxonomy), 'object_type')]))
	rt.call_function('do_action', [rt.new_string('registered_taxonomy_for_object_type'), var_taxonomy.dup(), var_object_type.dup()])
	return true
}

fn unregister_taxonomy_for_object_type(var_taxonomy rt.PhpVal, var_object_type rt.PhpVal) bool {
	mut var_wp_taxonomies := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(var_wp_taxonomies.array_isset(var_taxonomy)) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_post_type_object', [var_object_type.dup()]))))) {
		return false
	}
	mut var_key := rt.call_function('array_search', [var_object_type.dup(), rt.get_property(var_wp_taxonomies.array_get(var_taxonomy), 'object_type'), rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_key)) {
		return false
	}
	rt.get_property(var_wp_taxonomies.array_get(var_taxonomy), 'object_type').array_unset(var_key)
	rt.call_function('do_action', [rt.new_string('unregistered_taxonomy_for_object_type'), var_taxonomy.dup(), var_object_type.dup()])
	return true
}

fn get_objects_in_term(var_term_ids rt.PhpVal, var_taxonomies rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true()))) {
		
	}
	if rt.is_true() {
	}
	{
		mut iter_1 := .iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_taxonomy := item_1.val
		}
	}
}

struct Class_WP_Taxonomy {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_taxonomy() &Class_WP_Taxonomy {
	mut obj := &Class_WP_Taxonomy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Taxonomy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Taxonomy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Taxonomy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_taxonomy_php() {
}
