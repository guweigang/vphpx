import rt
import crypto.md5

fn create_initial_taxonomies() {
	mut var_wp_rewrite := rt.new_null()
	mut var_rewrite := map[string]rt.PhpVal{}
	mut var_post_format_base := rt.new_null()
	mut iife_temp_0 := Class_WP_Taxonomy{}
	mut iife_result_0 := iife_temp_0.reset_default_labels()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [
		rt.new_string('init'),
	])))))
	{
		var_rewrite = {
			'category':    rt.new_bool(false)
			'post_tag':    rt.new_bool(false)
			'post_format': rt.new_bool(false)
		}
	} else {
		var_post_format_base = rt.call_function('apply_filters', [
			rt.new_string('post_format_rewrite_base'),
			rt.new_string('type'),
		])
		var_rewrite = {
			'category':    {
				'hierarchical': rt.new_bool(true)
				'slug':         if rt.is_true(rt.call_function('get_option', [
					rt.new_string('category_base'),
				]))
				{
					rt.call_function('get_option', [rt.new_string('category_base')])
				} else {
					rt.new_string('category')
				}
				'with_front':   rt.new_bool(
					rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [rt.new_string('category_base')])))))
					|| rt.is_true(rt.call_method(var_wp_rewrite, 'using_index_permalinks', []rt.PhpVal{})))
				'ep_mask':      rt.get_constant('EP_CATEGORIES')
			}
			'post_tag':    {
				'hierarchical': rt.new_bool(false)
				'slug':         if rt.is_true(rt.call_function('get_option', [
					rt.new_string('tag_base'),
				]))
				{
					rt.call_function('get_option', [rt.new_string('tag_base')])
				} else {
					rt.new_string('tag')
				}
				'with_front':   rt.new_bool(
					rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [rt.new_string('tag_base')])))))
					|| rt.is_true(rt.call_method(var_wp_rewrite, 'using_index_permalinks', []rt.PhpVal{})))
				'ep_mask':      rt.get_constant('EP_TAGS')
			}
			'post_format': if rt.is_true(var_post_format_base) {
				{
					'slug': var_post_format_base
				}
			} else {
				rt.new_bool(false)
			}
		}
	}
	register_taxonomy('category', rt.new_string('post'), rt.create_array([
		rt.ArrayItem{ key: 'hierarchical', val: true },
		rt.ArrayItem{ key: 'query_var', val: 'category_name' },
		rt.ArrayItem{ key: 'rewrite', val: var_rewrite['category'] },
		rt.ArrayItem{ key: 'public', val: true },
		rt.ArrayItem{ key: 'show_ui', val: true },
		rt.ArrayItem{ key: 'show_admin_column', val: true },
		rt.ArrayItem{ key: '_builtin', val: true },
		rt.ArrayItem{ key: 'capabilities', val: rt.create_array([
			rt.ArrayItem{ key: 'manage_terms', val: 'manage_categories' },
			rt.ArrayItem{ key: 'edit_terms', val: 'edit_categories' },
			rt.ArrayItem{ key: 'delete_terms', val: 'delete_categories' },
			rt.ArrayItem{ key: 'assign_terms', val: 'assign_categories' },
		]) },
		rt.ArrayItem{ key: 'show_in_rest', val: true },
		rt.ArrayItem{ key: 'rest_base', val: 'categories' },
		rt.ArrayItem{ key: 'rest_controller_class', val: 'WP_REST_Terms_Controller' },
	]))
	register_taxonomy('post_tag', rt.new_string('post'), rt.create_array([
		rt.ArrayItem{ key: 'hierarchical', val: false },
		rt.ArrayItem{ key: 'query_var', val: 'tag' },
		rt.ArrayItem{ key: 'rewrite', val: var_rewrite['post_tag'] },
		rt.ArrayItem{ key: 'public', val: true },
		rt.ArrayItem{ key: 'show_ui', val: true },
		rt.ArrayItem{ key: 'show_admin_column', val: true },
		rt.ArrayItem{ key: '_builtin', val: true },
		rt.ArrayItem{ key: 'capabilities', val: rt.create_array([
			rt.ArrayItem{ key: 'manage_terms', val: 'manage_post_tags' },
			rt.ArrayItem{ key: 'edit_terms', val: 'edit_post_tags' },
			rt.ArrayItem{ key: 'delete_terms', val: 'delete_post_tags' },
			rt.ArrayItem{ key: 'assign_terms', val: 'assign_post_tags' },
		]) },
		rt.ArrayItem{ key: 'show_in_rest', val: true },
		rt.ArrayItem{ key: 'rest_base', val: 'tags' },
		rt.ArrayItem{ key: 'rest_controller_class', val: 'WP_REST_Terms_Controller' },
	]))
	register_taxonomy('nav_menu', rt.new_string('nav_menu_item'), rt.create_array([
		rt.ArrayItem{ key: 'public', val: false },
		rt.ArrayItem{ key: 'hierarchical', val: false },
		rt.ArrayItem{ key: 'labels', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Navigation Menus'),
			]) },
			rt.ArrayItem{ key: 'singular_name', val: rt.call_function('__', [
				rt.new_string('Navigation Menu'),
			]) },
		]) },
		rt.ArrayItem{ key: 'query_var', val: false },
		rt.ArrayItem{ key: 'rewrite', val: false },
		rt.ArrayItem{ key: 'show_ui', val: false },
		rt.ArrayItem{ key: '_builtin', val: true },
		rt.ArrayItem{ key: 'show_in_nav_menus', val: false },
		rt.ArrayItem{ key: 'capabilities', val: rt.create_array([
			rt.ArrayItem{ key: 'manage_terms', val: 'edit_theme_options' },
			rt.ArrayItem{ key: 'edit_terms', val: 'edit_theme_options' },
			rt.ArrayItem{ key: 'delete_terms', val: 'edit_theme_options' },
			rt.ArrayItem{ key: 'assign_terms', val: 'edit_theme_options' },
		]) },
		rt.ArrayItem{ key: 'show_in_rest', val: true },
		rt.ArrayItem{ key: 'rest_base', val: 'menus' },
		rt.ArrayItem{ key: 'rest_controller_class', val: 'WP_REST_Menus_Controller' },
	]))
	register_taxonomy('link_category', rt.new_string('link'), rt.create_array([
		rt.ArrayItem{ key: 'hierarchical', val: false },
		rt.ArrayItem{ key: 'labels', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Link Categories'),
			]) },
			rt.ArrayItem{ key: 'singular_name', val: rt.call_function('__', [
				rt.new_string('Link Category'),
			]) },
			rt.ArrayItem{ key: 'search_items', val: rt.call_function('__', [
				rt.new_string('Search Link Categories'),
			]) },
			rt.ArrayItem{ key: 'popular_items', val: rt.new_null() },
			rt.ArrayItem{ key: 'all_items', val: rt.call_function('__', [
				rt.new_string('All Link Categories'),
			]) },
			rt.ArrayItem{ key: 'edit_item', val: rt.call_function('__', [
				rt.new_string('Edit Link Category'),
			]) },
			rt.ArrayItem{ key: 'update_item', val: rt.call_function('__', [
				rt.new_string('Update Link Category'),
			]) },
			rt.ArrayItem{ key: 'add_new_item', val: rt.call_function('__', [
				rt.new_string('Add Link Category'),
			]) },
			rt.ArrayItem{ key: 'new_item_name', val: rt.call_function('__', [
				rt.new_string('New Link Category Name'),
			]) },
			rt.ArrayItem{ key: 'separate_items_with_commas', val: rt.new_null() },
			rt.ArrayItem{ key: 'add_or_remove_items', val: rt.new_null() },
			rt.ArrayItem{ key: 'choose_from_most_used', val: rt.new_null() },
			rt.ArrayItem{ key: 'back_to_items', val: rt.call_function('__', [
				rt.new_string('&larr; Go to Link Categories'),
			]) },
		]) },
		rt.ArrayItem{ key: 'capabilities', val: rt.create_array([
			rt.ArrayItem{ key: 'manage_terms', val: 'manage_links' },
			rt.ArrayItem{ key: 'edit_terms', val: 'manage_links' },
			rt.ArrayItem{ key: 'delete_terms', val: 'manage_links' },
			rt.ArrayItem{ key: 'assign_terms', val: 'manage_links' },
		]) },
		rt.ArrayItem{ key: 'query_var', val: false },
		rt.ArrayItem{ key: 'rewrite', val: false },
		rt.ArrayItem{ key: 'public', val: false },
		rt.ArrayItem{ key: 'show_ui', val: true },
		rt.ArrayItem{ key: '_builtin', val: true },
	]))
	register_taxonomy('post_format', rt.new_string('post'), rt.create_array([
		rt.ArrayItem{ key: 'public', val: true },
		rt.ArrayItem{ key: 'hierarchical', val: false },
		rt.ArrayItem{ key: 'labels', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('_x', [
				rt.new_string('Formats'),
				rt.new_string('post format'),
			]) },
			rt.ArrayItem{ key: 'singular_name', val: rt.call_function('_x', [
				rt.new_string('Format'),
				rt.new_string('post format'),
			]) },
		]) },
		rt.ArrayItem{ key: 'query_var', val: true },
		rt.ArrayItem{ key: 'rewrite', val: var_rewrite['post_format'] },
		rt.ArrayItem{ key: 'show_ui', val: false },
		rt.ArrayItem{ key: '_builtin', val: true },
		rt.ArrayItem{ key: 'show_in_nav_menus', val: rt.call_function('current_theme_supports', [
			rt.new_string('post-formats'),
		]) },
	]))
	register_taxonomy('wp_theme', rt.create_array([
		rt.ArrayItem{ key: none, val: 'wp_template' },
		rt.ArrayItem{ key: none, val: 'wp_template_part' },
		rt.ArrayItem{ key: none, val: 'wp_global_styles' },
	]), rt.create_array([rt.ArrayItem{ key: 'public', val: false },
		rt.ArrayItem{ key: 'hierarchical', val: false }, rt.ArrayItem{ key: 'labels', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Themes'),
			]) },
			rt.ArrayItem{ key: 'singular_name', val: rt.call_function('__', [
				rt.new_string('Theme'),
			]) },
		]) }, rt.ArrayItem{ key: 'query_var', val: false }, rt.ArrayItem{ key: 'rewrite', val: false },
		rt.ArrayItem{ key: 'show_ui', val: false }, rt.ArrayItem{ key: '_builtin', val: true },
		rt.ArrayItem{ key: 'show_in_nav_menus', val: false },
		rt.ArrayItem{ key: 'show_in_rest', val: false }]))
	register_taxonomy('wp_template_part_area', rt.create_array([
		rt.ArrayItem{ key: none, val: 'wp_template_part' },
	]), rt.create_array([rt.ArrayItem{ key: 'public', val: false },
		rt.ArrayItem{ key: 'hierarchical', val: false }, rt.ArrayItem{ key: 'labels', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Template Part Areas'),
			]) },
			rt.ArrayItem{ key: 'singular_name', val: rt.call_function('__', [
				rt.new_string('Template Part Area'),
			]) },
		]) }, rt.ArrayItem{ key: 'query_var', val: false }, rt.ArrayItem{ key: 'rewrite', val: false },
		rt.ArrayItem{ key: 'show_ui', val: false }, rt.ArrayItem{ key: '_builtin', val: true },
		rt.ArrayItem{ key: 'show_in_nav_menus', val: false },
		rt.ArrayItem{ key: 'show_in_rest', val: false }]))
	register_taxonomy('wp_pattern_category', rt.create_array([
		rt.ArrayItem{ key: none, val: 'wp_block' },
	]), rt.create_array([rt.ArrayItem{ key: 'public', val: false },
		rt.ArrayItem{ key: 'publicly_queryable', val: false },
		rt.ArrayItem{ key: 'hierarchical', val: false }, rt.ArrayItem{ key: 'labels', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('_x', [
				rt.new_string('Pattern Categories'),
				rt.new_string('taxonomy general name'),
			]) },
			rt.ArrayItem{ key: 'singular_name', val: rt.call_function('_x', [
				rt.new_string('Pattern Category'),
				rt.new_string('taxonomy singular name'),
			]) },
			rt.ArrayItem{ key: 'add_new_item', val: rt.call_function('__', [
				rt.new_string('Add Category'),
			]) },
			rt.ArrayItem{ key: 'add_or_remove_items', val: rt.call_function('__', [
				rt.new_string('Add or remove pattern categories'),
			]) },
			rt.ArrayItem{ key: 'back_to_items', val: rt.call_function('__', [
				rt.new_string('&larr; Go to Pattern Categories'),
			]) },
			rt.ArrayItem{ key: 'choose_from_most_used', val: rt.call_function('__', [
				rt.new_string('Choose from the most used pattern categories'),
			]) },
			rt.ArrayItem{ key: 'edit_item', val: rt.call_function('__', [
				rt.new_string('Edit Pattern Category'),
			]) },
			rt.ArrayItem{ key: 'item_link', val: rt.call_function('__', [
				rt.new_string('Pattern Category Link'),
			]) },
			rt.ArrayItem{ key: 'item_link_description', val: rt.call_function('__', [
				rt.new_string('A link to a pattern category.'),
			]) },
			rt.ArrayItem{ key: 'items_list', val: rt.call_function('__', [
				rt.new_string('Pattern Categories list'),
			]) },
			rt.ArrayItem{ key: 'items_list_navigation', val: rt.call_function('__', [
				rt.new_string('Pattern Categories list navigation'),
			]) },
			rt.ArrayItem{ key: 'new_item_name', val: rt.call_function('__', [
				rt.new_string('New Pattern Category Name'),
			]) },
			rt.ArrayItem{ key: 'no_terms', val: rt.call_function('__', [
				rt.new_string('No pattern categories'),
			]) },
			rt.ArrayItem{ key: 'not_found', val: rt.call_function('__', [
				rt.new_string('No pattern categories found.'),
			]) },
			rt.ArrayItem{ key: 'popular_items', val: rt.call_function('__', [
				rt.new_string('Popular Pattern Categories'),
			]) },
			rt.ArrayItem{ key: 'search_items', val: rt.call_function('__', [
				rt.new_string('Search Pattern Categories'),
			]) },
			rt.ArrayItem{ key: 'separate_items_with_commas', val: rt.call_function('__', [
				rt.new_string('Separate pattern categories with commas'),
			]) },
			rt.ArrayItem{ key: 'update_item', val: rt.call_function('__', [
				rt.new_string('Update Pattern Category'),
			]) },
			rt.ArrayItem{ key: 'view_item', val: rt.call_function('__', [
				rt.new_string('View Pattern Category'),
			]) },
		]) }, rt.ArrayItem{ key: 'query_var', val: false }, rt.ArrayItem{ key: 'rewrite', val: false },
		rt.ArrayItem{ key: 'show_ui', val: true }, rt.ArrayItem{ key: '_builtin', val: true },
		rt.ArrayItem{ key: 'show_in_nav_menus', val: false },
		rt.ArrayItem{ key: 'show_in_rest', val: true }, rt.ArrayItem{
			key: 'show_admin_column'
			val: true
		}, rt.ArrayItem{ key: 'show_tagcloud', val: false }]))
}

fn get_taxonomies(var_args rt.PhpVal, output string, operator string) rt.PhpVal {
	mut var_output := output
	mut var_operator := operator
	mut var_wp_taxonomies := rt.new_null()
	mut var_field := rt.new_null()
	var_field = if rt.is_true(rt.identical(rt.new_string('names'), rt.new_string(output))) {
		rt.new_string('name')
	} else {
		rt.new_bool(false)
	}
	return rt.call_function('wp_filter_object_list', [var_wp_taxonomies.clone(),
		var_args.clone(), rt.new_string(operator), var_field.clone()])
}

fn get_object_taxonomies(var_object_type_arg rt.PhpVal, output string) rt.PhpVal {
	mut var_output := output
	mut var_object_type := var_object_type_arg
	mut var_wp_taxonomies := rt.new_null()
	mut var_taxonomies := rt.new_null()
	mut var_tax_obj := rt.new_null()
	mut var_tax_name := rt.new_null()
	if rt.is_true(rt.new_bool(var_object_type.clone().is_object())) {
		if rt.is_true(rt.identical(rt.new_string('attachment'), rt.get_property(var_object_type,
			'post_type')))
		{
			return rt.call_function('get_attachment_taxonomies', [
				var_object_type.clone(), rt.new_string(output)])
		}
		var_object_type = rt.get_property(var_object_type, 'post_type')
	}
	var_object_type = rt.cast_array(var_object_type)
	var_taxonomies = rt.new_array()
	mut iter_1 := rt.cast_array(var_wp_taxonomies).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_tax_obj_shadow := item_1.val
		mut var_tax_name_shadow := item_1.key
		if rt.is_true(rt.call_function('array_intersect', [var_object_type.clone(),
			rt.cast_array(rt.get_property(var_tax_obj_shadow, 'object_type'))]))
		{
			if rt.is_true(rt.identical(rt.new_string('names'), rt.new_string(output))) {
				var_taxonomies.array_push(var_tax_name_shadow.clone())
			} else {
				var_taxonomies.array_set(var_tax_name_shadow, var_tax_obj_shadow.clone())
			}
		}
	}
	return var_taxonomies.clone()
}

fn get_taxonomy(var_taxonomy rt.PhpVal) bool {
	mut var_wp_taxonomies := rt.new_null()
	if !(taxonomy_exists(var_taxonomy.clone())) {
		return false
	}
	return (var_wp_taxonomies.array_get(var_taxonomy)).to_bool()
}

fn taxonomy_exists(var_taxonomy rt.PhpVal) bool {
	mut var_wp_taxonomies := rt.new_null()
	return var_taxonomy.clone().is_string() && var_wp_taxonomies.array_isset(var_taxonomy)
}

fn is_taxonomy_hierarchical(var_taxonomy_arg rt.PhpVal) bool {
	mut var_taxonomy := var_taxonomy_arg
	if !(taxonomy_exists(var_taxonomy)) {
		return false
	}
	var_taxonomy = get_taxonomy(var_taxonomy)
	return (rt.get_property(rt.new_bool(var_taxonomy), 'hierarchical')).to_bool()
}

fn register_taxonomy(taxonomy string, var_object_type rt.PhpVal, var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_taxonomy := taxonomy
	mut var_args := var_args_arg
	mut var_wp_taxonomies := rt.new_null()
	mut var_taxonomy_object := rt.new_null()
	mut var_term := rt.new_null()
	if !(var_wp_taxonomies.clone().is_array()) {
		var_wp_taxonomies = rt.new_array()
	}
	var_args = rt.call_function('wp_parse_args', [var_args.clone()])
	if taxonomy == '' || taxonomy.len > 32 {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Taxonomy names must be between 1 and 32 characters in length.'),
			]),
			rt.new_string('4.2.0')])
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('taxonomy_length_invalid'), rt.call_function('__', [
			rt.new_string('Taxonomy names must be between 1 and 32 characters in length.'),
		])))
	}
	var_taxonomy_object = create_wp_taxonomy(rt.new_string(taxonomy), var_object_type.clone(),
		var_args.clone())
	rt.call_method(var_taxonomy_object, 'add_rewrite_rules', []rt.PhpVal{})
	var_wp_taxonomies.array_set(taxonomy, var_taxonomy_object.clone())
	rt.call_method(var_taxonomy_object, 'add_hooks', []rt.PhpVal{})
	if !(!rt.is_true(rt.get_property(var_taxonomy_object, 'default_term'))) {
		var_term = term_exists(rt.get_property(var_taxonomy_object, 'default_term').array_get(rt.new_string('name')),
			taxonomy, rt.new_null())
		if rt.is_true(var_term) {
			rt.call_function('update_option', [
				rt.new_string('default_term_' + (rt.get_property(var_taxonomy_object, 'name')).str()),
				var_term.array_get(rt.new_string('term_id')),
			])
		} else {
			var_term = wp_insert_term(rt.get_property(var_taxonomy_object, 'default_term').array_get(rt.new_string('name')),
				rt.new_string(taxonomy), rt.create_array([
				rt.ArrayItem{ key: 'slug', val: rt.call_function('sanitize_title', [
					rt.get_property(var_taxonomy_object, 'default_term').array_get(rt.new_string('slug')),
				]) },
				rt.ArrayItem{ key: 'description', val: rt.get_property(var_taxonomy_object,
					'default_term').array_get(rt.new_string('description')) },
			]))
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
				var_term.clone(),
			])))))
			{
				rt.call_function('update_option', [
					rt.new_string('default_term_' +
						(rt.get_property(var_taxonomy_object, 'name')).str()),
					var_term.array_get(rt.new_string('term_id')),
				])
			}
		}
	}
	rt.call_function('do_action', [rt.new_string('registered_taxonomy'),
		rt.new_string(taxonomy), var_object_type.clone(), rt.cast_array(var_taxonomy_object)])
	rt.call_function('do_action', [rt.new_string('registered_taxonomy_${var_taxonomy}'),
		rt.new_string(taxonomy), var_object_type.clone(), rt.cast_array(var_taxonomy_object)])
	return var_taxonomy_object.clone()
}

fn unregister_taxonomy(var_taxonomy rt.PhpVal) bool {
	mut var_wp_taxonomies := rt.new_null()
	mut var_taxonomy_object := false
	if !(taxonomy_exists(var_taxonomy.clone())) {
		return (create_wp_error(rt.new_string('invalid_taxonomy'), rt.call_function('__', [
			rt.new_string('Invalid taxonomy.'),
		]))).to_bool()
	}
	var_taxonomy_object = get_taxonomy(var_taxonomy.clone())
	if rt.is_true(rt.get_property(rt.new_bool(var_taxonomy_object), '_builtin')) {
		return (create_wp_error(rt.new_string('invalid_taxonomy'), rt.call_function('__', [
			rt.new_string('Unregistering a built-in taxonomy is not allowed.'),
		]))).to_bool()
	}
	rt.call_method(rt.new_bool(var_taxonomy_object), 'remove_rewrite_rules', []rt.PhpVal{})
	rt.call_method(rt.new_bool(var_taxonomy_object), 'remove_hooks', []rt.PhpVal{})
	var_wp_taxonomies.array_unset(var_taxonomy)
	rt.call_function('do_action', [rt.new_string('unregistered_taxonomy'),
		var_taxonomy.clone()])
	return true
}

fn get_taxonomy_labels(var_tax rt.PhpVal) rt.PhpVal {
	mut var_nohier_vs_hier_defaults := rt.new_null()
	mut var_labels := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_default_labels := rt.new_null()
	rt.set_property(var_tax, 'labels', rt.cast_array(rt.get_property(var_tax, 'labels')))
	if !(rt.get_property(var_tax, 'helps')).is_null()
		&& !rt.is_true(rt.get_property(var_tax, 'labels').array_get(rt.new_string('separate_items_with_commas'))) {
		rt.get_property(var_tax, 'labels').array_set('separate_items_with_commas', rt.get_property(var_tax,
			'helps'))
	}
	if !(rt.get_property(var_tax, 'no_tagcloud')).is_null()
		&& !rt.is_true(rt.get_property(var_tax, 'labels').array_get(rt.new_string('not_found'))) {
		rt.get_property(var_tax, 'labels').array_set('not_found', rt.get_property(var_tax,
			'no_tagcloud'))
	}
	mut iife_temp_1 := Class_WP_Taxonomy{}
	mut iife_result_1 := iife_temp_1.get_default_labels()
	var_nohier_vs_hier_defaults = iife_result_1
	var_nohier_vs_hier_defaults.array_set('menu_name',
		var_nohier_vs_hier_defaults.array_get(rt.new_string('name')))
	var_labels = rt.call_function('_get_custom_object_labels', [
		var_tax.clone(), var_nohier_vs_hier_defaults.clone()])
	if !(!(rt.get_property(rt.get_property(var_tax, 'labels'), 'template_name')).is_null())
		&& !(rt.get_property(var_labels, 'singular_name')).is_null() {
		rt.set_property(var_labels, 'template_name', rt.call_function('sprintf', [
			rt.call_function('_x', [rt.new_string('%s Archives'),
				rt.new_string('taxonomy template name')]),
			rt.get_property(var_labels, 'singular_name'),
		]))
	}
	var_taxonomy = rt.get_property(var_tax, 'name')
	var_default_labels = var_labels.dup()
	var_labels = rt.call_function('apply_filters', [
		rt.new_string('taxonomy_labels_${var_taxonomy.to_string()}'),
		var_labels.clone(),
	])
	var_labels = rt.array_to_object(rt.call_function('array_merge', [
		rt.cast_array(var_default_labels),
		rt.cast_array(var_labels),
	]))
	return var_labels.clone()
}

fn register_taxonomy_for_object_type(var_taxonomy rt.PhpVal, var_object_type rt.PhpVal) bool {
	mut var_wp_taxonomies := rt.new_null()
	if !(var_wp_taxonomies.array_isset(var_taxonomy)) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_post_type_object', [
		var_object_type.clone(),
	])))))
	{
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_object_type.clone(),
		rt.get_property(var_wp_taxonomies.array_get(var_taxonomy),
			'object_type'),
		rt.new_bool(true)])))))
	{
		rt.get_property(var_wp_taxonomies.array_get(var_taxonomy), 'object_type').array_push(var_object_type.clone())
	}
	rt.set_property(var_wp_taxonomies.array_get(var_taxonomy), 'object_type', rt.call_function('array_filter', [
		rt.get_property(var_wp_taxonomies.array_get(var_taxonomy), 'object_type'),
	]))
	rt.call_function('do_action', [rt.new_string('registered_taxonomy_for_object_type'),
		var_taxonomy.clone(), var_object_type.clone()])
	return true
}

fn unregister_taxonomy_for_object_type(var_taxonomy rt.PhpVal, var_object_type rt.PhpVal) bool {
	mut var_wp_taxonomies := rt.new_null()
	mut var_key := rt.new_null()
	if !(var_wp_taxonomies.array_isset(var_taxonomy)) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_post_type_object', [
		var_object_type.clone(),
	])))))
	{
		return false
	}
	var_key = rt.call_function('array_search', [var_object_type.clone(),
		rt.get_property(var_wp_taxonomies.array_get(var_taxonomy), 'object_type'),
		rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_key)) {
		return false
	}
	rt.get_property(var_wp_taxonomies.array_get(var_taxonomy), 'object_type').array_unset(var_key)
	rt.call_function('do_action', [
		rt.new_string('unregistered_taxonomy_for_object_type'),
		var_taxonomy.clone(),
		var_object_type.clone(),
	])
	return true
}

fn get_objects_in_term(var_term_ids_arg rt.PhpVal, var_taxonomies_arg rt.PhpVal, var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_term_ids := var_term_ids_arg
	mut var_taxonomies := var_taxonomies_arg
	mut var_args := var_args_arg
	mut var_wpdb := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_defaults := rt.new_null()
	mut var_order := ''
	mut var_sql := ''
	mut var_last_changed := rt.new_null()
	mut var_cache_key := rt.new_null()
	mut var_cache := rt.new_null()
	mut var_object_ids := rt.new_null()
	if !(var_term_ids.clone().is_array()) {
		var_term_ids = rt.create_array([rt.ArrayItem{ key: none, val: var_term_ids }])
	}
	if !(var_taxonomies.clone().is_array()) {
		var_taxonomies = rt.create_array([rt.ArrayItem{ key: none, val: var_taxonomies }])
	}
	mut iter_2 := rt.cast_array(var_taxonomies).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_taxonomy_shadow := item_2.val
		if !(taxonomy_exists(var_taxonomy_shadow.clone())) {
			return create_wp_error(rt.new_string('invalid_taxonomy'), rt.call_function('__', [
				rt.new_string('Invalid taxonomy.'),
			]))
		}
	}
	var_defaults = rt.create_array([rt.ArrayItem{ key: 'order', val: 'ASC' }])
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		var_defaults.clone()])
	var_order = if rt.is_true(rt.identical(rt.new_string('desc'),
		rt.new_string(var_args.array_get(rt.new_string('order')).to_string().to_lower())))
	{
		'DESC'
	} else {
		'ASC'
	}
	var_term_ids = rt.call_function('array_map', [rt.new_string('intval'),
		var_term_ids.clone()])
	var_taxonomies = rt.new_string("'" +
		(rt.call_function('implode', [rt.new_string("', '"), rt.call_function('array_map', [rt.new_string('esc_sql'), var_taxonomies.clone()])])).str() +
		"'")
	var_term_ids = rt.new_string("'" +
		(rt.call_function('implode', [rt.new_string("', '"), var_term_ids.clone()])).str() + "'")
	var_sql = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT tr.object_id FROM '), rt.get_property(var_wpdb,
		'term_relationships')), rt.new_string(' AS tr INNER JOIN ')), rt.get_property(var_wpdb,
		'term_taxonomy')),
		rt.new_string(' AS tt ON tr.term_taxonomy_id = tt.term_taxonomy_id WHERE tt.taxonomy IN (')),
		var_taxonomies), rt.new_string(') AND tt.term_id IN (')), var_term_ids),
		rt.new_string(') ORDER BY tr.object_id ')), rt.new_string(var_order.str()))
	var_last_changed = rt.call_function('wp_cache_get_last_changed', [
		rt.new_string('terms'),
	])
	var_cache_key = rt.new_string('get_objects_in_term:' + md5.hexhash(var_sql))
	var_cache = rt.call_function('wp_cache_get_salted', [var_cache_key.clone(),
		rt.new_string('term-queries'), var_last_changed.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_cache)) {
		var_object_ids = rt.call_method(var_wpdb, 'get_col', [
			rt.new_string(var_sql.str()).clone()])
		rt.call_function('wp_cache_set_salted', [var_cache_key.clone(),
			var_object_ids.clone(), rt.new_string('term-queries'),
			var_last_changed.clone()])
	} else {
		var_object_ids = rt.cast_array(var_cache)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_object_ids)))) {
		return rt.new_array()
	}
	return var_object_ids.clone()
}

fn get_tax_sql(var_tax_query rt.PhpVal, var_primary_table rt.PhpVal, var_primary_id_column rt.PhpVal) rt.PhpVal {
	mut var_tax_query_obj := rt.new_null()
	var_tax_query_obj = create_wp_tax_query(var_tax_query.clone())
	return var_tax_query_obj.get_sql(var_primary_table.clone(), var_primary_id_column.clone())
}

fn get_term(var_term rt.PhpVal, taxonomy string, var_output rt.PhpVal, filter string) rt.PhpVal {
	mut var_taxonomy := taxonomy
	mut var_filter := filter
	mut var__term := rt.new_null()
	mut var_old_term := rt.new_null()
	if !rt.is_true(var_term) {
		return create_wp_error(rt.new_string('invalid_term'), rt.call_function('__', [
			rt.new_string('Empty Term.'),
		]))
	}
	if var_taxonomy.len > 0 && var_taxonomy != '0' && !(taxonomy_exists(var_taxonomy)) {
		return create_wp_error(rt.new_string('invalid_taxonomy'), rt.call_function('__', [
			rt.new_string('Invalid taxonomy.'),
		]))
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_term, 'WP_Term'))) {
		var__term = var_term.clone()
	} else if rt.is_true(rt.new_bool(var_term.clone().is_object())) {
		if !rt.is_true(rt.get_property(var_term, 'filter'))
			|| rt.is_true(rt.identical(rt.new_string('raw'), rt.get_property(var_term, 'filter'))) {
			var__term = sanitize_term(var_term.clone(), rt.new_string(var_taxonomy.str()), 'raw')
			var__term = create_wp_term(var__term.clone())
		} else {
			mut iife_temp_2 := Class_WP_Term{}
			mut iife_result_2 := iife_temp_2.get_instance(rt.get_property(var_term, 'term_id'))
			var__term = iife_result_2
		}
	} else {
		mut iife_temp_3 := Class_WP_Term{}
		mut iife_result_3 := iife_temp_3.get_instance(var_term.clone(),
			rt.new_string(var_taxonomy.str()))
		var__term = iife_result_3
	}
	if rt.is_true(rt.call_function('is_wp_error', [var__term.clone()])) {
		return var__term.clone()
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var__term)))) {
		return rt.new_null()
	}
	var_taxonomy = (rt.get_property(var__term, 'taxonomy')).str()
	var_old_term = var__term.clone()
	var__term = rt.call_function('apply_filters', [rt.new_string('get_term'),
		var__term.clone(), rt.new_string(var_taxonomy.str())])
	var__term = rt.call_function('apply_filters', [rt.new_string('get_${var_taxonomy}'),
		var__term.clone(), rt.new_string(var_taxonomy.str())])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var__term, 'WP_Term')))))) {
		return var__term.clone()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var__term, var_old_term))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var__term, 'filter'), rt.new_string(filter))))) {
		rt.call_method(var__term, 'filter', [rt.new_string(filter)])
	}
	if rt.is_true(rt.identical(rt.get_constant('ARRAY_A'), var_output)) {
		return rt.call_method(var__term, 'to_array', []rt.PhpVal{})
	} else if rt.is_true(rt.identical(rt.get_constant('ARRAY_N'), var_output)) {
		return rt.call_function('array_values', [
			rt.call_method(var__term, 'to_array', []rt.PhpVal{}),
		])
	}
	return var__term.clone()
}

fn get_term_by(field string, var_value_arg rt.PhpVal, taxonomy string, var_output rt.PhpVal, filter string) rt.PhpVal {
	mut var_field := field
	mut var_taxonomy := taxonomy
	mut var_filter := filter
	mut var_value := var_value_arg
	mut var_term := rt.new_null()
	mut var_args := rt.new_null()
	mut var_terms := rt.new_null()
	if rt.is_true(rt.new_bool('term_taxonomy_id' != field)) && !(taxonomy_exists(var_taxonomy)) {
		return rt.new_bool(false)
	}
	if rt.is_true(rt.identical(rt.new_string('slug'), rt.new_string(field)))
		|| rt.is_true(rt.identical(rt.new_string('name'), rt.new_string(field))) {
		var_value = rt.new_string(var_value.str())
		if 0 == var_value.clone().to_string().len {
			return rt.new_bool(false)
		}
	}
	if rt.is_true(rt.identical(rt.new_string('id'), rt.new_string(field)))
		|| rt.is_true(rt.identical(rt.new_string('ID'), rt.new_string(field)))
		|| rt.is_true(rt.identical(rt.new_string('term_id'), rt.new_string(field))) {
		var_term = get_term(rt.new_int(var_value.to_i64()), var_taxonomy, var_output.clone(),
			filter)
		if rt.is_true(rt.call_function('is_wp_error', [var_term.clone()]))
			|| rt.is_true(rt.identical(rt.new_null(), var_term)) {
			var_term = rt.new_bool(false)
		}
		return var_term.clone()
	}
	var_args = rt.create_array([rt.ArrayItem{ key: 'get', val: 'all' },
		rt.ArrayItem{ key: 'number', val: 1 }, rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
		rt.ArrayItem{ key: 'update_term_meta_cache', val: false },
		rt.ArrayItem{ key: 'orderby', val: 'none' }, rt.ArrayItem{ key: 'suppress_filter', val: true }])
	mut switch_val_1 := rt.new_string(field)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('slug'))) {
		var_args.array_set('slug', var_value.clone())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('name'))) {
		var_args.array_set('name', var_value.clone())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('term_taxonomy_id'))) {
		var_args.array_set('term_taxonomy_id', var_value.clone())
		var_args.array_unset(rt.new_string('taxonomy'))
	} else {
		return rt.new_bool(false)
	}
	var_terms = get_terms(var_args.clone(), '')
	if rt.is_true(rt.call_function('is_wp_error', [var_terms.clone()])) || !rt.is_true(var_terms) {
		return rt.new_bool(false)
	}
	var_term = rt.call_function('array_shift', [var_terms.clone()])
	if rt.is_true(rt.identical(rt.new_string('term_taxonomy_id'), rt.new_string(field))) {
		var_taxonomy = (rt.get_property(var_term, 'taxonomy')).str()
	}
	return get_term(var_term.clone(), var_taxonomy, var_output.clone(), filter)
}

fn get_term_children(var_term_id_arg rt.PhpVal, var_taxonomy rt.PhpVal) rt.PhpVal {
	mut var_term_id := var_term_id_arg
	mut var_terms := rt.new_null()
	mut var_children := rt.new_null()
	mut var_child := rt.new_null()
	if !(taxonomy_exists(var_taxonomy.clone())) {
		return create_wp_error(rt.new_string('invalid_taxonomy'), rt.call_function('__', [
			rt.new_string('Invalid taxonomy.'),
		]))
	}
	var_term_id = rt.new_int(var_term_id.to_i64())
	var_terms = _get_term_hierarchy(var_taxonomy.clone())
	if !(var_terms.array_isset(var_term_id)) {
		return rt.new_array()
	}
	var_children = var_terms.array_get(var_term_id)
	mut iter_3 := rt.cast_array(var_terms.array_get(var_term_id)).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_child_shadow := item_3.val
		if rt.is_true(rt.identical(var_term_id, var_child_shadow)) {
			continue
		}
		if var_terms.array_isset(var_child_shadow) {
			var_children = rt.call_function('array_merge', [var_children.clone(),
				get_term_children(var_child_shadow.clone(), var_taxonomy.clone())])
		}
	}
	return var_children.clone()
}

fn get_term_field(var_field rt.PhpVal, var_term_arg rt.PhpVal, taxonomy string, context string) string {
	mut var_taxonomy := taxonomy
	mut var_context := context
	mut var_term := var_term_arg
	var_term = get_term(var_term.clone(), var_taxonomy, rt.new_null(), '')
	if rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
		return var_term.str()
	}
	if !(var_term.clone().is_object()) {
		return ''
	}
	if !(!(rt.get_property(var_term, '{"nodeType":"Expr_Variable","line":1231,"name":"field"}')).is_null()) {
		return ''
	}
	return (sanitize_term_field(var_field.clone(), rt.get_property(var_term,
		'{"nodeType":"Expr_Variable","line":1235,"name":"field"}'), rt.get_property(var_term,
		'term_id'), rt.get_property(var_term, 'taxonomy'), rt.new_string(context))).str()
}

fn get_term_to_edit(var_id rt.PhpVal, var_taxonomy rt.PhpVal) string {
	mut var_term := rt.new_null()
	var_term = get_term(var_id.clone(), var_taxonomy.clone(), rt.new_null(), '')
	if rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
		return var_term.str()
	}
	if !(var_term.clone().is_object()) {
		return ''
	}
	return (sanitize_term(var_term.clone(), var_taxonomy.clone(), 'edit')).str()
}

fn get_terms(var_args_arg rt.PhpVal, deprecated string) rt.PhpVal {
	mut var_deprecated := deprecated
	mut var_args := var_args_arg
	mut var_term_query := rt.new_null()
	mut var_defaults := rt.new_null()
	mut var__args := rt.new_null()
	mut var_key_intersect := rt.new_null()
	mut var_do_legacy_args := false
	mut var_taxonomies := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_suppress_filter := rt.new_null()
	mut var_terms := rt.new_null()
	var_term_query = create_wp_term_query()
	var_defaults = rt.create_array([rt.ArrayItem{ key: 'suppress_filter', val: false }])
	var__args = rt.call_function('wp_parse_args', [var_args.clone()])
	var_key_intersect = rt.call_function('array_intersect_key', [
		rt.get_property(var_term_query, 'query_var_defaults'),
		rt.cast_array(var__args),
	])
	var_do_legacy_args = var_deprecated.len > 0 && var_deprecated != '0'
		|| !rt.is_true(var_key_intersect)
	if var_do_legacy_args {
		var_taxonomies = rt.cast_array(var_args)
		var_args = rt.call_function('wp_parse_args', [rt.new_string(deprecated),
			var_defaults.clone()])
		var_args.array_set('taxonomy', var_taxonomies.clone())
	} else {
		var_args = rt.call_function('wp_parse_args', [var_args.clone(),
			var_defaults.clone()])
		if var_args.array_isset(rt.new_string('taxonomy')) {
			var_args.array_set('taxonomy',
				rt.cast_array(var_args.array_get(rt.new_string('taxonomy'))))
		}
	}
	if !(!rt.is_true(var_args.array_get(rt.new_string('taxonomy')))) {
		mut iter_4 := var_args.array_get(rt.new_string('taxonomy')).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_taxonomy_shadow := item_4.val
			if !(taxonomy_exists(var_taxonomy_shadow.clone())) {
				return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_taxonomy'), rt.call_function('__', [
					rt.new_string('Invalid taxonomy.'),
				])))
			}
		}
	}
	var_suppress_filter = var_args.array_get(rt.new_string('suppress_filter'))
	var_args.array_unset(rt.new_string('suppress_filter'))
	var_terms = var_term_query.query(var_args.clone())
	if !(var_terms.clone().is_array()) {
		return var_terms.clone()
	}
	if rt.is_true(var_suppress_filter) {
		return var_terms.clone()
	}
	return rt.call_function('apply_filters', [rt.new_string('get_terms'),
		var_terms.clone(), rt.get_property(var_term_query, 'query_vars').array_get(rt.new_string('taxonomy')),
		rt.get_property(var_term_query, 'query_vars'), var_term_query])
}

fn add_term_meta(var_term_id rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal, unique bool) rt.PhpVal {
	mut var_unique := unique
	if rt.is_true(rt.new_bool(wp_term_is_shared(var_term_id.clone()))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('ambiguous_term_id'), rt.call_function('__', [
			rt.new_string('Term meta cannot be added to terms that are shared between taxonomies.'),
		]), var_term_id.clone()))
	}
	return rt.call_function('add_metadata', [rt.new_string('term'),
		var_term_id.clone(), var_meta_key.clone(), var_meta_value.clone(),
		rt.new_bool(unique)])
}

fn delete_term_meta(var_term_id rt.PhpVal, var_meta_key rt.PhpVal, meta_value string) rt.PhpVal {
	mut var_meta_value := meta_value
	return rt.call_function('delete_metadata', [rt.new_string('term'),
		var_term_id.clone(), var_meta_key.clone(), rt.new_string(meta_value)])
}

fn get_term_meta(var_term_id rt.PhpVal, key string, single bool) rt.PhpVal {
	mut var_key := key
	mut var_single := single
	return rt.call_function('get_metadata', [rt.new_string('term'),
		var_term_id.clone(), rt.new_string(key), rt.new_bool(single)])
}

fn update_term_meta(var_term_id rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal, prev_value string) rt.PhpVal {
	mut var_prev_value := prev_value
	if rt.is_true(rt.new_bool(wp_term_is_shared(var_term_id.clone()))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('ambiguous_term_id'), rt.call_function('__', [
			rt.new_string('Term meta cannot be added to terms that are shared between taxonomies.'),
		]), var_term_id.clone()))
	}
	return rt.call_function('update_metadata', [rt.new_string('term'),
		var_term_id.clone(), var_meta_key.clone(), var_meta_value.clone(),
		rt.new_string(prev_value)])
}

fn update_termmeta_cache(var_term_ids rt.PhpVal) rt.PhpVal {
	return rt.call_function('update_meta_cache', [rt.new_string('term'),
		var_term_ids.clone()])
}

fn wp_lazyload_term_meta(var_term_ids rt.PhpVal) {
	mut var_lazyloader := rt.new_null()
	if !rt.is_true(var_term_ids) {
		return
	}
	var_lazyloader = rt.call_function('wp_metadata_lazyloader', []rt.PhpVal{})
	rt.call_method(var_lazyloader, 'queue_objects', [rt.new_string('term'),
		var_term_ids.clone()])
}

fn has_term_meta(var_term_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_check := rt.new_null()
	var_check = rt.new_bool(wp_check_term_meta_support_prefilter(rt.new_null()))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_check)))) {
		return var_check.clone()
	}
	return rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT meta_key, meta_value, meta_id, term_id FROM '), rt.get_property(var_wpdb,
				'termmeta')), rt.new_string(' WHERE term_id = %d ORDER BY meta_key,meta_id')),
			var_term_id.clone(),
		]),
		rt.get_constant('ARRAY_A'),
	])
}

fn register_term_meta(var_taxonomy rt.PhpVal, var_meta_key rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	var_args.array_set('object_subtype', var_taxonomy.clone())
	return rt.call_function('register_meta', [rt.new_string('term'),
		var_meta_key.clone(), var_args.clone()])
}

fn unregister_term_meta(var_taxonomy rt.PhpVal, var_meta_key rt.PhpVal) rt.PhpVal {
	return rt.call_function('unregister_meta_key', [rt.new_string('term'),
		var_meta_key.clone(), var_taxonomy.clone()])
}

fn term_exists(var_term_arg rt.PhpVal, taxonomy string, var_parent_term rt.PhpVal) rt.PhpVal {
	mut var_taxonomy := taxonomy
	mut var_term := var_term_arg
	mut var__wp_suspend_cache_invalidation := rt.new_null()
	mut var_defaults := rt.new_null()
	mut var_args := rt.new_null()
	mut var_terms := rt.new_null()
	mut var__term := rt.new_null()
	if rt.is_true(rt.identical(rt.new_null(), rt.new_string(var_term.str()))) {
		return rt.new_null()
	}
	var_defaults = rt.create_array([rt.ArrayItem{ key: 'get', val: 'all' },
		rt.ArrayItem{ key: 'fields', val: 'ids' }, rt.ArrayItem{ key: 'number', val: 1 },
		rt.ArrayItem{ key: 'update_term_meta_cache', val: false },
		rt.ArrayItem{ key: 'order', val: 'ASC' }, rt.ArrayItem{ key: 'orderby', val: 'term_id' },
		rt.ArrayItem{ key: 'suppress_filter', val: true }])
	if !(!rt.is_true(var__wp_suspend_cache_invalidation)) {
		var_defaults.array_set('cache_results', false)
	}
	if !(var_taxonomy == '') {
		var_defaults.array_set('taxonomy', var_taxonomy)
		var_defaults.array_set('fields', 'all')
	}
	var_defaults = rt.call_function('apply_filters', [
		rt.new_string('term_exists_default_query_args'),
		var_defaults.clone(),
		rt.new_string(var_term.str()).clone(),
		rt.new_string(var_taxonomy.str()),
		var_parent_term.clone(),
	])
	if !(var_taxonomy == '') && var_parent_term.clone().is_long()
		|| var_parent_term.clone().is_double() {
		var_defaults.array_set('parent', rt.new_int(var_parent_term.to_i64()))
	}
	if rt.is_true(rt.new_bool(rt.new_string(var_term.str()).clone().is_long())) {
		if rt.is_true(rt.identical(rt.new_int(0), rt.new_string(var_term.str()))) {
			return rt.new_int(0)
		}
		var_args = rt.call_function('wp_parse_args', [
			rt.create_array([
				rt.ArrayItem{ key: 'include', val: rt.create_array([
					rt.ArrayItem{ key: none, val: var_term },
				]) },
			]),
			var_defaults.clone(),
		])
		var_terms = get_terms(var_args.clone(), '')
	} else {
		var_term =
			rt.call_function('wp_unslash', [rt.new_string(var_term.str()).clone()]).to_string().trim_space()
		if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_term.str()))) {
			return rt.new_null()
		}
		var_args = rt.call_function('wp_parse_args', [
			rt.create_array([
				rt.ArrayItem{ key: 'slug', val: rt.call_function('sanitize_title', [
					rt.new_string(var_term.str()).clone(),
				]) },
			]),
			var_defaults.clone(),
		])
		var_terms = get_terms(var_args.clone(), '')
		if !rt.is_true(var_terms)
			|| rt.is_true(rt.call_function('is_wp_error', [var_terms.clone()])) {
			var_args = rt.call_function('wp_parse_args', [
				rt.create_array([rt.ArrayItem{ key: 'name', val: var_term }]),
				var_defaults.clone(),
			])
			var_terms = get_terms(var_args.clone(), '')
		}
	}
	if !rt.is_true(var_terms) || rt.is_true(rt.call_function('is_wp_error', [var_terms.clone()])) {
		return rt.new_null()
	}
	var__term = rt.call_function('array_shift', [var_terms.clone()])
	if !(var_taxonomy == '') {
		return rt.create_array([
			rt.ArrayItem{ key: 'term_id', val: (rt.get_property(var__term, 'term_id')).str() },
			rt.ArrayItem{ key: 'term_taxonomy_id', val: (rt.get_property(var__term,
				'term_taxonomy_id')).str() },
		])
	}
	return rt.new_string(var__term.str())
}

fn term_is_ancestor_of(var_term1_arg rt.PhpVal, var_term2_arg rt.PhpVal, var_taxonomy rt.PhpVal) bool {
	mut var_term1 := var_term1_arg
	mut var_term2 := var_term2_arg
	if !(!(rt.get_property(var_term1, 'term_id')).is_null()) {
		var_term1 = get_term(var_term1.clone(), var_taxonomy.clone(), rt.new_null(), '')
	}
	if !(!(rt.get_property(var_term2, 'parent')).is_null()) {
		var_term2 = get_term(var_term2.clone(), var_taxonomy.clone(), rt.new_null(), '')
	}
	if !rt.is_true(rt.get_property(var_term1, 'term_id'))
		|| !rt.is_true(rt.get_property(var_term2, 'parent')) {
		return false
	}
	if rt.is_true(rt.identical(rt.get_property(var_term2, 'parent'), rt.get_property(var_term1,
		'term_id')))
	{
		return true
	}
	return term_is_ancestor_of(var_term1.clone(), get_term(rt.get_property(var_term2, 'parent'),
		var_taxonomy.clone(), rt.new_null(), ''), var_taxonomy.clone())
}

fn sanitize_term(var_term rt.PhpVal, var_taxonomy rt.PhpVal, context string) rt.PhpVal {
	mut var_context := context
	mut var_fields := []rt.PhpVal{}
	mut var_do_object := false
	mut var_term_id := rt.new_null()
	mut var_field := rt.new_null()
	var_fields = ['term_id', 'name', 'description', 'slug', 'count', 'parent', 'term_group',
		'term_taxonomy_id', 'object_id']
	var_do_object = var_term.clone().is_object()
	var_term_id = if var_do_object {
		if !(rt.get_property(var_term, 'term_id')).is_null() {
			rt.get_property(var_term, 'term_id')
		} else {
			rt.new_int(0)
		}
	} else {
		if !(var_term.array_get(rt.new_string('term_id'))).is_null() {
			var_term.array_get(rt.new_string('term_id'))
		} else {
			rt.new_int(0)
		}
	}
	mut iter_5 := rt.cast_array(var_fields).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_field_shadow := item_5.val
		if var_do_object {
			if !(rt.get_property(var_term,
				'{"nodeType":"Expr_Variable","line":1730,"name":"field"}')).is_null() {
				rt.set_property(var_term,
					'{"nodeType":"Expr_Variable","line":1731,"name":"field"}', sanitize_term_field(var_field_shadow.clone(), rt.get_property(var_term,
					'{"nodeType":"Expr_Variable","line":1731,"name":"field"}'),
					var_term_id.clone(), var_taxonomy.clone(), rt.new_string(context)))
			}
		} else {
			if var_term.array_isset(var_field_shadow) {
				var_term.array_set(var_field_shadow, sanitize_term_field(var_field_shadow.clone(),
					var_term.array_get(var_field_shadow), var_term_id.clone(),
					var_taxonomy.clone(), rt.new_string(context)))
			}
		}
	}
	if var_do_object {
		rt.set_property(var_term, 'filter', rt.new_string(context))
	} else {
		var_term.array_set('filter', context)
	}
	return var_term.clone()
}

fn sanitize_term_field(var_field rt.PhpVal, var_value_arg rt.PhpVal, var_term_id rt.PhpVal, var_taxonomy rt.PhpVal, var_context_arg rt.PhpVal) rt.PhpVal {
	mut var_value := var_value_arg
	mut var_context := var_context_arg
	mut var_int_fields := []rt.PhpVal{}
	var_int_fields = ['parent', 'term_id', 'count', 'term_group', 'term_taxonomy_id', 'object_id']
	if rt.is_true(rt.call_function('in_array', [var_field.clone(),
		rt.create_array_from_list(var_int_fields), rt.new_bool(true)]))
	{
		var_value = rt.new_int(var_value.to_i64())
		if rt.is_true(rt.less(var_value, rt.new_int(0))) {
			var_value = rt.new_int(0)
		}
	}
	var_context = var_context.to_lower()
	if rt.is_true(rt.identical(rt.new_string('raw'), rt.new_string(var_context.str()))) {
		return var_value.clone()
	}
	if rt.is_true(rt.identical(rt.new_string('edit'), rt.new_string(var_context.str()))) {
		var_value = rt.call_function('apply_filters', [
			rt.new_string('edit_term_${var_field.to_string()}'),
			var_value.clone(),
			var_term_id.clone(),
			var_taxonomy.clone(),
		])
		var_value = rt.call_function('apply_filters', [
			rt.new_string('edit_${var_taxonomy.to_string()}_${var_field.to_string()}'),
			var_value.clone(),
			var_term_id.clone(),
		])
		if rt.is_true(rt.identical(rt.new_string('description'), var_field)) {
			var_value = rt.call_function('esc_html', [var_value.clone()])
		} else {
			var_value = rt.call_function('esc_attr', [var_value.clone()])
		}
	} else if rt.is_true(rt.identical(rt.new_string('db'), rt.new_string(var_context.str()))) {
		var_value = rt.call_function('apply_filters', [
			rt.new_string('pre_term_${var_field.to_string()}'),
			var_value.clone(),
			var_taxonomy.clone(),
		])
		var_value = rt.call_function('apply_filters', [
			rt.new_string('pre_${var_taxonomy.to_string()}_${var_field.to_string()}'),
			var_value.clone(),
		])
		if rt.is_true(rt.identical(rt.new_string('slug'), var_field)) {
			var_value = rt.call_function('apply_filters', [
				rt.new_string('pre_category_nicename'),
				var_value.clone(),
			])
		}
	} else if rt.is_true(rt.identical(rt.new_string('rss'), rt.new_string(var_context.str()))) {
		var_value = rt.call_function('apply_filters', [
			rt.new_string('term_${var_field.to_string()}_rss'),
			var_value.clone(),
			var_taxonomy.clone(),
		])
		var_value = rt.call_function('apply_filters', [
			rt.new_string('${var_taxonomy.to_string()}_${var_field.to_string()}_rss'),
			var_value.clone(),
		])
	} else {
		var_value = rt.call_function('apply_filters', [
			rt.new_string('term_${var_field.to_string()}'),
			var_value.clone(),
			var_term_id.clone(),
			var_taxonomy.clone(),
			rt.new_string(var_context.str()).clone(),
		])
		var_value = rt.call_function('apply_filters', [
			rt.new_string('${var_taxonomy.to_string()}_${var_field.to_string()}'),
			var_value.clone(),
			var_term_id.clone(),
			rt.new_string(var_context.str()).clone(),
		])
	}
	if rt.is_true(rt.identical(rt.new_string('attribute'), rt.new_string(var_context.str()))) {
		var_value = rt.call_function('esc_attr', [var_value.clone()])
	} else if rt.is_true(rt.identical(rt.new_string('js'), rt.new_string(var_context.str()))) {
		var_value = rt.call_function('esc_js', [var_value.clone()])
	}
	if rt.is_true(rt.call_function('in_array', [var_field.clone(),
		rt.create_array_from_list(var_int_fields), rt.new_bool(true)]))
	{
		var_value = rt.new_int(var_value.to_i64())
	}
	return var_value.clone()
}

fn wp_count_terms(var_args_arg rt.PhpVal, deprecated string) rt.PhpVal {
	mut var_deprecated := deprecated
	mut var_args := var_args_arg
	mut var_use_legacy_args := false
	mut var_defaults := rt.new_null()
	var_use_legacy_args = false
	if rt.is_true(var_args) && (var_args.clone().is_string() && taxonomy_exists(var_args.clone()))
		|| (var_args.clone().is_array()
		&& rt.is_true(rt.call_function('wp_is_numeric_array', [var_args.clone()]))) {
		var_use_legacy_args = true
	}
	var_defaults = rt.create_array([rt.ArrayItem{ key: 'hide_empty', val: false }])
	if var_use_legacy_args {
		var_defaults.array_set('taxonomy', var_args.clone())
		var_args = rt.new_string(deprecated)
	}
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		var_defaults.clone()])
	if var_args.array_isset(rt.new_string('ignore_empty')) {
		var_args.array_set('hide_empty', var_args.array_get(rt.new_string('ignore_empty')))
		var_args.array_unset(rt.new_string('ignore_empty'))
	}
	var_args.array_set('fields', 'count')
	return get_terms(var_args.clone(), '')
}

fn wp_delete_object_term_relationships(var_object_id_arg rt.PhpVal, var_taxonomies_arg rt.PhpVal) {
	mut var_object_id := var_object_id_arg
	mut var_taxonomies := var_taxonomies_arg
	mut var_taxonomy := rt.new_null()
	mut var_term_ids := rt.new_null()
	var_object_id = rt.new_int(var_object_id.to_i64())
	if !(var_taxonomies.clone().is_array()) {
		var_taxonomies = rt.create_array([rt.ArrayItem{ key: none, val: var_taxonomies }])
	}
	mut iter_6 := rt.cast_array(var_taxonomies).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_taxonomy_shadow := item_6.val
		var_term_ids = wp_get_object_terms(var_object_id.clone(), var_taxonomy_shadow.clone(), rt.create_array([
			rt.ArrayItem{ key: 'fields', val: 'ids' },
		]))
		if !(var_term_ids.clone().is_array()) {
			continue
		}
		var_term_ids = rt.call_function('array_map', [rt.new_string('intval'),
			var_term_ids.clone()])
		rt.new_bool(wp_remove_object_terms(var_object_id.clone(), var_term_ids.clone(),
			var_taxonomy_shadow.clone()))
	}
}

fn wp_delete_term(var_term_arg rt.PhpVal, taxonomy string, var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_taxonomy := taxonomy
	mut var_term := var_term_arg
	mut var_args := var_args_arg
	mut var_wpdb := rt.new_null()
	mut var_ids := rt.new_null()
	mut var_tt_id := rt.new_null()
	mut var_defaults := rt.new_null()
	mut var_taxonomy_object := false
	mut var_default := rt.new_null()
	mut var_force_default := rt.new_null()
	mut var_term_obj := rt.new_null()
	mut var_parent := rt.new_null()
	mut var_edit_ids := rt.new_null()
	mut var_edit_tt_ids := rt.new_null()
	mut var_edit_term_ids := rt.new_null()
	mut var_deleted_term := rt.new_null()
	mut var_object_ids := rt.new_null()
	mut var_object_id := rt.new_null()
	mut var_terms := rt.new_null()
	mut var_tax_object := false
	mut var_object_type := rt.new_null()
	mut var_term_meta_ids := rt.new_null()
	mut var_mid := rt.new_null()
	var_term = rt.new_int(var_term.to_i64())
	var_ids = term_exists(var_term.clone(), var_taxonomy, rt.new_null())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_ids)))) {
		return rt.new_bool(false)
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_ids.clone()])) {
		return var_ids.clone()
	}
	var_tt_id = var_ids.array_get(rt.new_string('term_taxonomy_id'))
	var_defaults = rt.new_array()
	if rt.is_true(rt.identical(rt.new_string('category'), rt.new_string(var_taxonomy.str()))) {
		var_defaults.array_set('default', rt.new_int((rt.call_function('get_option', [
			rt.new_string('default_category'),
		])).to_i64()))
		if rt.is_true(rt.identical(var_defaults.array_get(rt.new_string('default')), var_term)) {
			return rt.new_int(0)
		}
	}
	var_taxonomy_object = get_taxonomy(var_taxonomy)
	if !(!rt.is_true(rt.get_property(rt.new_bool(var_taxonomy_object), 'default_term'))) {
		var_defaults.array_set('default', rt.new_int((rt.call_function('get_option', [
			rt.new_string('default_term_' + var_taxonomy),
		])).to_i64()))
		if rt.is_true(rt.identical(var_defaults.array_get(rt.new_string('default')), var_term)) {
			return rt.new_int(0)
		}
	}
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		var_defaults.clone()])
	if var_args.array_isset(rt.new_string('default')) {
		var_default = rt.new_int((var_args.array_get(rt.new_string('default'))).to_i64())
		if rt.is_true(rt.new_bool(!(rt.is_true(term_exists(var_default.clone(), var_taxonomy,
			rt.new_null())))))
		{
			var_default = rt.new_null()
		}
	}
	if var_args.array_isset(rt.new_string('force_default')) {
		var_force_default = var_args.array_get(rt.new_string('force_default'))
	}
	rt.call_function('do_action', [rt.new_string('pre_delete_term'),
		var_term.clone(), rt.new_string(var_taxonomy.str())])
	if rt.is_true(rt.new_bool(is_taxonomy_hierarchical(rt.new_string(var_taxonomy.str())))) {
		var_term_obj = get_term(var_term.clone(), var_taxonomy, rt.new_null(), '')
		if rt.is_true(rt.call_function('is_wp_error', [var_term_obj.clone()])) {
			return var_term_obj.clone()
		}
		var_parent = rt.get_property(var_term_obj, 'parent')
		var_edit_ids = rt.call_method(var_wpdb, 'get_results', [
			rt.new_string((
				rt.concat(rt.concat(rt.new_string('SELECT term_id, term_taxonomy_id FROM '), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' WHERE `parent` = ')) +
				rt.new_int((rt.get_property(var_term_obj, 'term_id')).to_i64()).str()).str()),
		])
		var_edit_tt_ids = rt.call_function('wp_list_pluck', [
			var_edit_ids.clone(), rt.new_string('term_taxonomy_id')])
		rt.call_function('do_action', [rt.new_string('edit_term_taxonomies'),
			var_edit_tt_ids.clone()])
		rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'term_taxonomy'),
			rt.call_function('compact', [rt.new_string('parent')]),
			rt.add(rt.create_array([rt.ArrayItem{ key: 'parent', val: rt.get_property(var_term_obj,
				'term_id') }]), rt.call_function('compact', [
				rt.new_string('taxonomy')]))])
		var_edit_term_ids = rt.call_function('wp_list_pluck', [
			var_edit_ids.clone(), rt.new_string('term_id')])
		clean_term_cache(var_edit_term_ids.clone(), var_taxonomy, false)
		rt.call_function('do_action', [rt.new_string('edited_term_taxonomies'),
			var_edit_tt_ids.clone()])
	}
	var_deleted_term = get_term(var_term.clone(), var_taxonomy, rt.new_null(), '')
	var_object_ids = rt.cast_array(rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT object_id FROM '), rt.get_property(var_wpdb,
				'term_relationships')), rt.new_string(' WHERE term_taxonomy_id = %d')),
			var_tt_id.clone(),
		]),
	]))
	mut iter_7 := var_object_ids.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_object_id_shadow := item_7.val
		if !(!var_default.is_null()) {
			rt.new_bool(wp_remove_object_terms(var_object_id_shadow.clone(), var_term.clone(),
				rt.new_string(var_taxonomy.str())))
			continue
		}
		var_terms = wp_get_object_terms(var_object_id_shadow.clone(),
			rt.new_string(var_taxonomy.str()), rt.create_array([
			rt.ArrayItem{ key: 'fields', val: 'ids' },
			rt.ArrayItem{ key: 'orderby', val: 'none' },
		]))
		if 1 == var_terms.clone().array_count() {
			var_terms = rt.create_array([rt.ArrayItem{ key: none, val: var_default }])
		} else {
			var_terms = rt.call_function('array_diff', [var_terms.clone(),
				rt.create_array([rt.ArrayItem{ key: none, val: var_term }])])
			if !var_force_default.is_null() && rt.is_true(var_force_default) {
				var_terms = rt.call_function('array_merge', [
					var_terms.clone(), rt.create_array([
						rt.ArrayItem{ key: none, val: var_default },
					])])
			}
		}
		var_terms = rt.call_function('array_map', [rt.new_string('intval'),
			var_terms.clone()])
		wp_set_object_terms(var_object_id_shadow.clone(), var_terms.clone(),
			rt.new_string(var_taxonomy.str()), false)
	}
	var_tax_object = get_taxonomy(var_taxonomy)
	mut iter_8 := rt.get_property(rt.new_bool(var_tax_object), 'object_type').iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_object_type_shadow := item_8.val
		clean_object_term_cache(var_object_ids.clone(), var_object_type_shadow.clone())
	}
	var_term_meta_ids = rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT meta_id FROM '), rt.get_property(var_wpdb,
				'termmeta')), rt.new_string(' WHERE term_id = %d ')),
			var_term.clone(),
		]),
	])
	mut iter_9 := var_term_meta_ids.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_mid_shadow := item_9.val
		rt.call_function('delete_metadata_by_mid', [rt.new_string('term'),
			var_mid_shadow.clone()])
	}
	rt.call_function('do_action', [rt.new_string('delete_term_taxonomy'),
		var_tt_id.clone()])
	rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'term_taxonomy'),
		rt.create_array([rt.ArrayItem{ key: 'term_taxonomy_id', val: var_tt_id }])])
	rt.call_function('do_action', [rt.new_string('deleted_term_taxonomy'),
		var_tt_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM '), rt.get_property(var_wpdb,
				'term_taxonomy')), rt.new_string(' WHERE term_id = %d')),
			var_term.clone(),
		]),
	])))))
	{
		rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'terms'),
			rt.create_array([rt.ArrayItem{ key: 'term_id', val: var_term }])])
	}
	clean_term_cache(var_term.clone(), var_taxonomy, false)
	rt.call_function('do_action', [rt.new_string('delete_term'),
		var_term.clone(), var_tt_id.clone(), rt.new_string(var_taxonomy.str()),
		var_deleted_term.clone(), var_object_ids.clone()])
	rt.call_function('do_action', [rt.new_string('delete_${var_taxonomy}'),
		var_term.clone(), var_tt_id.clone(), var_deleted_term.clone(),
		var_object_ids.clone()])
	return rt.new_bool(true)
}

fn wp_delete_category(var_cat_id rt.PhpVal) rt.PhpVal {
	return wp_delete_term(var_cat_id.clone(), 'category', rt.new_null())
}

fn wp_get_object_terms(var_object_ids_arg rt.PhpVal, var_taxonomies_arg rt.PhpVal, var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_object_ids := var_object_ids_arg
	mut var_taxonomies := var_taxonomies_arg
	mut var_args := var_args_arg
	mut var_taxonomy := rt.new_null()
	mut var_defaults := rt.new_null()
	mut var_terms := rt.new_null()
	mut var_index := rt.new_null()
	mut var_t := false
	mut var_terms_from_remaining_taxonomies := rt.new_null()
	if !rt.is_true(var_object_ids) || !rt.is_true(var_taxonomies) {
		return rt.new_array()
	}
	if !(var_taxonomies.clone().is_array()) {
		var_taxonomies = rt.create_array([rt.ArrayItem{ key: none, val: var_taxonomies }])
	}
	mut iter_10 := var_taxonomies.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_taxonomy_shadow := item_10.val
		if !(taxonomy_exists(var_taxonomy_shadow.clone())) {
			return create_wp_error(rt.new_string('invalid_taxonomy'), rt.call_function('__', [
				rt.new_string('Invalid taxonomy.'),
			]))
		}
	}
	if !(var_object_ids.clone().is_array()) {
		var_object_ids = rt.create_array([rt.ArrayItem{ key: none, val: var_object_ids }])
	}
	var_object_ids = rt.call_function('array_map', [rt.new_string('intval'),
		var_object_ids.clone()])
	var_defaults = rt.create_array([
		rt.ArrayItem{ key: 'update_term_meta_cache', val: false },
	])
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		var_defaults.clone()])
	var_args = rt.call_function('apply_filters', [
		rt.new_string('wp_get_object_terms_args'),
		var_args.clone(),
		var_object_ids.clone(),
		var_taxonomies.clone(),
	])
	var_terms = rt.new_array()
	if var_taxonomies.clone().array_count() > 1 {
		mut iter_11 := var_taxonomies.iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_taxonomy_shadow := item_11.val
			mut var_index_shadow := item_11.key
			var_t = get_taxonomy(var_taxonomy_shadow.clone())
			if !(rt.get_property(rt.new_bool(var_t), 'args')).is_null()
				&& rt.get_property(rt.new_bool(var_t), 'args').is_array()
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.call_function('array_merge', [var_args.clone(), rt.get_property(rt.new_bool(var_t), 'args')]), var_args)))) {
				var_taxonomies.array_unset(var_index_shadow)
				var_terms = rt.call_function('array_merge', [
					var_terms.clone(),
					wp_get_object_terms(var_object_ids.clone(),
						var_taxonomy_shadow.clone(), rt.call_function('array_merge', [
						var_args.clone(),
						rt.get_property(rt.new_bool(var_t), 'args'),
					]))])
			}
		}
	} else {
		var_t = get_taxonomy(var_taxonomies.array_get(rt.new_int(0)))
		if !(rt.get_property(rt.new_bool(var_t), 'args')).is_null()
			&& rt.get_property(rt.new_bool(var_t), 'args').is_array() {
			var_args = rt.call_function('array_merge', [var_args.clone(),
				rt.get_property(rt.new_bool(var_t), 'args')])
		}
	}
	var_args.array_set('taxonomy', var_taxonomies.clone())
	var_args.array_set('object_ids', var_object_ids.clone())
	if !(!rt.is_true(var_taxonomies)) {
		var_terms_from_remaining_taxonomies = get_terms(var_args.clone(), '')
		if !(!rt.is_true(var_args.array_get(rt.new_string('fields'))))
			&& rt.is_true(rt.call_function('str_starts_with', [var_args.array_get(rt.new_string('fields')), rt.new_string('id=>')])) {
			var_terms = rt.add(var_terms, var_terms_from_remaining_taxonomies)
		} else {
			var_terms = rt.call_function('array_merge', [var_terms.clone(),
				var_terms_from_remaining_taxonomies.clone()])
		}
	}
	var_terms = rt.call_function('apply_filters', [rt.new_string('get_object_terms'),
		var_terms.clone(), var_object_ids.clone(), var_taxonomies.clone(),
		var_args.clone()])
	var_object_ids = rt.call_function('implode', [rt.new_string(','),
		var_object_ids.clone()])
	var_taxonomies = rt.new_string("'" +
		(rt.call_function('implode', [rt.new_string("', '"), rt.call_function('array_map', [rt.new_string('esc_sql'), var_taxonomies.clone()])])).str() +
		"'")
	return rt.call_function('apply_filters', [rt.new_string('wp_get_object_terms'),
		var_terms.clone(), var_object_ids.clone(), var_taxonomies.clone(),
		var_args.clone()])
}

fn wp_insert_term(var_term_arg rt.PhpVal, var_taxonomy rt.PhpVal, var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_term := var_term_arg
	mut var_args := var_args_arg
	mut var_wpdb := rt.new_null()
	mut var_defaults := rt.new_null()
	mut var_name := rt.new_null()
	mut var_description := rt.new_null()
	mut var_parent := rt.new_null()
	mut var_slug_provided := false
	mut var_slug := rt.new_null()
	mut var_term_group := rt.new_null()
	mut var_alias := rt.new_null()
	mut var_name_matches := rt.new_null()
	mut var_name_match := rt.new_null()
	mut var__match := rt.new_null()
	mut var_slug_match := rt.new_null()
	mut var_siblings := rt.new_null()
	mut var_existing_term := rt.new_null()
	mut var_sibling_names := rt.new_null()
	mut var_sibling_slugs := rt.new_null()
	mut var_data := rt.new_null()
	mut var_term_id := rt.new_null()
	mut var_tt_id := rt.new_null()
	mut var_duplicate_term := rt.new_null()
	if !(taxonomy_exists(var_taxonomy.clone())) {
		return create_wp_error(rt.new_string('invalid_taxonomy'), rt.call_function('__', [
			rt.new_string('Invalid taxonomy.'),
		]))
	}
	var_term = rt.call_function('apply_filters', [rt.new_string('pre_insert_term'),
		var_term.clone(), var_taxonomy.clone(), var_args.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
		return var_term.clone()
	}
	if var_term.clone().is_long() && rt.is_true(rt.identical(rt.new_int(0), var_term)) {
		return create_wp_error(rt.new_string('invalid_term_id'), rt.call_function('__', [
			rt.new_string('Invalid term ID.'),
		]))
	}
	if rt.is_true(rt.identical(rt.new_string(''),
		rt.new_string(var_term.clone().to_string().trim_space())))
	{
		return create_wp_error(rt.new_string('empty_term_name'), rt.call_function('__', [
			rt.new_string('A name is required for this term.'),
		]))
	}
	var_defaults = rt.create_array([rt.ArrayItem{ key: 'alias_of', val: '' },
		rt.ArrayItem{ key: 'description', val: '' }, rt.ArrayItem{ key: 'parent', val: 0 },
		rt.ArrayItem{ key: 'slug', val: '' }])
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		var_defaults.clone()])
	if rt.new_int((var_args.array_get(rt.new_string('parent'))).to_i64()) > 0
		&& rt.is_true(rt.new_bool(!(rt.is_true(term_exists(rt.new_int((var_args.array_get(rt.new_string('parent'))).to_i64()), '', rt.new_null()))))) {
		return create_wp_error(rt.new_string('missing_parent'), rt.call_function('__', [
			rt.new_string('Parent term does not exist.'),
		]))
	}
	var_args.array_set('name', var_term.clone())
	var_args.array_set('taxonomy', var_taxonomy.clone())
	var_args.array_set('description', (var_args.array_get(rt.new_string('description'))).str())
	var_args = sanitize_term(var_args.clone(), var_taxonomy.clone(), 'db')
	var_name = rt.call_function('wp_unslash', [var_args.array_get(rt.new_string('name'))])
	var_description = rt.call_function('wp_unslash', [
		var_args.array_get(rt.new_string('description')),
	])
	var_parent = rt.new_int((var_args.array_get(rt.new_string('parent'))).to_i64())
	if rt.is_true(rt.identical(rt.new_string(''), var_name)) {
		return create_wp_error(rt.new_string('invalid_term_name'), rt.call_function('__', [
			rt.new_string('Invalid term name.'),
		]))
	}
	var_slug_provided = !(!rt.is_true(var_args.array_get(rt.new_string('slug'))))
	if !var_slug_provided {
		var_slug = rt.call_function('sanitize_title', [var_name.clone()])
	} else {
		var_slug = var_args.array_get(rt.new_string('slug'))
	}
	var_term_group = rt.new_int(0)
	if rt.is_true(var_args.array_get(rt.new_string('alias_of'))) {
		var_alias = get_term_by('slug', var_args.array_get(rt.new_string('alias_of')),
			var_taxonomy.clone(), rt.new_null(), '')
		if !(!rt.is_true(rt.get_property(var_alias, 'term_group'))) {
			var_term_group = rt.get_property(var_alias, 'term_group')
		} else if !(!rt.is_true(rt.get_property(var_alias, 'term_id'))) {
			var_term_group = rt.add(rt.call_method(var_wpdb, 'get_var', [
				rt.concat(rt.new_string('SELECT MAX(term_group) FROM '), rt.get_property(var_wpdb,
					'terms')),
			]), rt.new_int(1))
			wp_update_term(rt.get_property(var_alias, 'term_id'), var_taxonomy.clone(), rt.create_array([
				rt.ArrayItem{ key: 'term_group', val: var_term_group },
			]))
		}
	}
	var_name_matches = get_terms(rt.create_array([
		rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
		rt.ArrayItem{ key: 'name', val: var_name },
		rt.ArrayItem{ key: 'hide_empty', val: false },
		rt.ArrayItem{ key: 'parent', val: var_args.array_get(rt.new_string('parent')) },
		rt.ArrayItem{ key: 'update_term_meta_cache', val: false },
	]), '')
	var_name_match = rt.new_null()
	if rt.is_true(var_name_matches) {
		mut iter_12 := var_name_matches.iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var__match_shadow := item_12.val
			if rt.is_true(rt.identical(rt.new_string(var_name.clone().to_string().to_lower()), rt.new_string(rt.get_property(var__match_shadow,
				'name').to_string().to_lower())))
			{
				var_name_match = var__match_shadow
				break
			}
		}
	}
	if rt.is_true(var_name_match) {
		var_slug_match =
			get_term_by('slug', var_slug.clone(), var_taxonomy.clone(), rt.new_null(), '')
		if !var_slug_provided
			|| rt.is_true(rt.identical(rt.get_property(var_name_match, 'slug'), var_slug))
			|| rt.is_true(var_slug_match) {
			if rt.is_true(rt.new_bool(is_taxonomy_hierarchical(var_taxonomy.clone()))) {
				var_siblings = get_terms(rt.create_array([
					rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
					rt.ArrayItem{ key: 'get', val: 'all' },
					rt.ArrayItem{ key: 'parent', val: var_parent },
					rt.ArrayItem{ key: 'update_term_meta_cache', val: false },
				]), '')
				var_existing_term = rt.new_null()
				var_sibling_names = rt.call_function('wp_list_pluck', [
					var_siblings.clone(), rt.new_string('name')])
				var_sibling_slugs = rt.call_function('wp_list_pluck', [
					var_siblings.clone(), rt.new_string('slug')])
				if !var_slug_provided
					|| rt.is_true(rt.identical(rt.get_property(var_name_match, 'slug'), var_slug))
					&& rt.is_true(rt.call_function('in_array', [var_name.clone(), var_sibling_names.clone(), rt.new_bool(true)])) {
					var_existing_term = var_name_match.clone()
				} else if rt.is_true(var_slug_match)
					&& rt.is_true(rt.call_function('in_array', [var_slug.clone(), var_sibling_slugs.clone(), rt.new_bool(true)])) {
					var_existing_term = var_slug_match.clone()
				}
				if rt.is_true(var_existing_term) {
					return create_wp_error(rt.new_string('term_exists'), rt.call_function('__', [
						rt.new_string('A term with the name provided already exists with this parent.'),
					]), rt.get_property(var_existing_term, 'term_id'))
				}
			} else {
				return create_wp_error(rt.new_string('term_exists'), rt.call_function('__', [
					rt.new_string('A term with the name provided already exists in this taxonomy.'),
				]), rt.get_property(var_name_match, 'term_id'))
			}
		}
	}
	var_slug = wp_unique_term_slug(var_slug.clone(), rt.array_to_object(var_args))
	var_data = rt.call_function('compact', [rt.new_string('name'),
		rt.new_string('slug'), rt.new_string('term_group')])
	var_data = rt.call_function('apply_filters', [rt.new_string('wp_insert_term_data'),
		var_data.clone(), var_taxonomy.clone(), var_args.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_method(var_wpdb, 'insert', [
		rt.get_property(var_wpdb, 'terms'),
		var_data.clone(),
	])))
	{
		return create_wp_error(rt.new_string('db_insert_error'), rt.call_function('__', [
			rt.new_string('Could not insert term into the database.'),
		]), rt.get_property(var_wpdb, 'last_error'))
	}
	var_term_id = rt.new_int((rt.get_property(var_wpdb, 'insert_id')).to_i64())
	if !rt.is_true(var_slug) {
		var_slug = rt.call_function('sanitize_title', [var_slug.clone(),
			var_term_id.clone()])
		rt.call_function('do_action', [rt.new_string('edit_terms'),
			var_term_id.clone(), var_taxonomy.clone()])
		rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'terms'),
			rt.call_function('compact', [rt.new_string('slug')]),
			rt.call_function('compact', [rt.new_string('term_id')])])
		rt.call_function('do_action', [rt.new_string('edited_terms'),
			var_term_id.clone(), var_taxonomy.clone()])
	}
	var_tt_id = rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT tt.term_taxonomy_id FROM '), rt.get_property(var_wpdb,
				'term_taxonomy')), rt.new_string(' AS tt INNER JOIN ')), rt.get_property(var_wpdb,
				'terms')),
				rt.new_string(' AS t ON tt.term_id = t.term_id WHERE tt.taxonomy = %s AND t.term_id = %d')),
			var_taxonomy.clone(),
			var_term_id.clone(),
		]),
	])
	if !(!rt.is_true(var_tt_id)) {
		return rt.create_array([rt.ArrayItem{ key: 'term_id', val: var_term_id },
			rt.ArrayItem{ key: 'term_taxonomy_id', val: var_tt_id }])
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_method(var_wpdb, 'insert', [
		rt.get_property(var_wpdb, 'term_taxonomy'),
		rt.add(rt.call_function('compact', [rt.new_string('term_id'),
			rt.new_string('taxonomy'), rt.new_string('description'),
			rt.new_string('parent')]), rt.create_array([rt.ArrayItem{ key: 'count', val: 0 }])),
	])))
	{
		return create_wp_error(rt.new_string('db_insert_error'), rt.call_function('__', [
			rt.new_string('Could not insert term taxonomy into the database.'),
		]), rt.get_property(var_wpdb, 'last_error'))
	}
	var_tt_id = rt.new_int((rt.get_property(var_wpdb, 'insert_id')).to_i64())
	var_duplicate_term = rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT t.term_id, t.slug, tt.term_taxonomy_id, tt.taxonomy FROM '), rt.get_property(var_wpdb,
				'terms')), rt.new_string(' AS t INNER JOIN ')), rt.get_property(var_wpdb,
				'term_taxonomy')),
				rt.new_string(' AS tt ON ( tt.term_id = t.term_id ) WHERE t.slug = %s AND tt.parent = %d AND tt.taxonomy = %s AND t.term_id < %d AND tt.term_taxonomy_id != %d')),
			var_slug.clone(),
			var_parent.clone(),
			var_taxonomy.clone(),
			var_term_id.clone(),
			var_tt_id.clone(),
		]),
	])
	var_duplicate_term = rt.call_function('apply_filters', [
		rt.new_string('wp_insert_term_duplicate_term_check'),
		var_duplicate_term.clone(),
		var_term.clone(),
		var_taxonomy.clone(),
		var_args.clone(),
		var_tt_id.clone(),
	])
	if rt.is_true(var_duplicate_term) {
		rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'terms'),
			rt.create_array([rt.ArrayItem{ key: 'term_id', val: var_term_id }])])
		rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'term_taxonomy'),
			rt.create_array([rt.ArrayItem{ key: 'term_taxonomy_id', val: var_tt_id }])])
		var_term_id = rt.new_int((rt.get_property(var_duplicate_term, 'term_id')).to_i64())
		var_tt_id = rt.new_int((rt.get_property(var_duplicate_term, 'term_taxonomy_id')).to_i64())
		clean_term_cache(var_term_id.clone(), var_taxonomy.clone(), false)
		return rt.create_array([rt.ArrayItem{ key: 'term_id', val: var_term_id },
			rt.ArrayItem{ key: 'term_taxonomy_id', val: var_tt_id }])
	}
	rt.call_function('do_action', [rt.new_string('create_term'),
		var_term_id.clone(), var_tt_id.clone(), var_taxonomy.clone(),
		var_args.clone()])
	rt.call_function('do_action', [rt.new_string('create_${var_taxonomy.to_string()}'),
		var_term_id.clone(), var_tt_id.clone(), var_args.clone()])
	var_term_id = rt.call_function('apply_filters', [rt.new_string('term_id_filter'),
		var_term_id.clone(), var_tt_id.clone(), var_args.clone()])
	clean_term_cache(var_term_id.clone(), var_taxonomy.clone(), false)
	rt.call_function('do_action', [rt.new_string('created_term'),
		var_term_id.clone(), var_tt_id.clone(), var_taxonomy.clone(),
		var_args.clone()])
	rt.call_function('do_action', [rt.new_string('created_${var_taxonomy.to_string()}'),
		var_term_id.clone(), var_tt_id.clone(), var_args.clone()])
	rt.call_function('do_action', [rt.new_string('saved_term'),
		var_term_id.clone(), var_tt_id.clone(), var_taxonomy.clone(),
		rt.new_bool(false), var_args.clone()])
	rt.call_function('do_action', [rt.new_string('saved_${var_taxonomy.to_string()}'),
		var_term_id.clone(), var_tt_id.clone(), rt.new_bool(false),
		var_args.clone()])
	return rt.create_array([rt.ArrayItem{ key: 'term_id', val: var_term_id },
		rt.ArrayItem{ key: 'term_taxonomy_id', val: var_tt_id }])
}

fn wp_set_object_terms(var_object_id_arg rt.PhpVal, var_terms_arg rt.PhpVal, var_taxonomy rt.PhpVal, append bool) rt.PhpVal {
	mut var_append := append
	mut var_object_id := var_object_id_arg
	mut var_terms := var_terms_arg
	mut var_wpdb := rt.new_null()
	mut var_old_tt_ids := rt.new_null()
	mut var_tt_ids := rt.new_null()
	mut var_new_tt_ids := []rt.PhpVal{}
	mut var_term := rt.new_null()
	mut var_term_info := rt.new_null()
	mut var_tt_id := rt.new_null()
	mut var_delete_tt_ids := rt.new_null()
	mut var_in_delete_tt_ids := rt.new_null()
	mut var_delete_term_ids := rt.new_null()
	mut var_remove := rt.new_null()
	mut var_t := false
	mut var_values := []rt.PhpVal{}
	mut var_term_order := i64(0)
	mut var_final_tt_ids := rt.new_null()
	var_object_id = rt.new_int(var_object_id.to_i64())
	if !(taxonomy_exists(var_taxonomy.clone())) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_taxonomy'), rt.call_function('__', [
			rt.new_string('Invalid taxonomy.'),
		])))
	}
	if !rt.is_true(var_terms) {
		var_terms = rt.new_array()
	} else if !(var_terms.clone().is_array()) {
		var_terms = rt.create_array([rt.ArrayItem{ key: none, val: var_terms }])
	}
	if !var_append {
		var_old_tt_ids = wp_get_object_terms(var_object_id.clone(), var_taxonomy.clone(), rt.create_array([
			rt.ArrayItem{ key: 'fields', val: 'tt_ids' },
			rt.ArrayItem{ key: 'orderby', val: 'none' },
			rt.ArrayItem{ key: 'update_term_meta_cache', val: false },
		]))
	} else {
		var_old_tt_ids = rt.new_array()
	}
	var_tt_ids = rt.new_array()
	var_new_tt_ids = rt.new_array()
	mut iter_13 := rt.cast_array(var_terms).iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_term_shadow := item_13.val
		if rt.is_true(rt.identical(rt.new_string(''),
			rt.new_string(var_term_shadow.clone().to_string().trim_space())))
		{
			continue
		}
		var_term_info = term_exists(var_term_shadow.clone(), var_taxonomy.clone(), rt.new_null())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_term_info)))) {
			if rt.is_true(rt.new_bool(var_term_shadow.clone().is_long())) {
				continue
			}
			var_term_info = wp_insert_term(var_term_shadow.clone(), var_taxonomy.clone(),
				rt.new_null())
		}
		if rt.is_true(rt.call_function('is_wp_error', [var_term_info.clone()])) {
			return var_term_info.clone()
		}
		var_tt_id = var_term_info.array_get(rt.new_string('term_taxonomy_id'))
		var_tt_ids.array_push(var_tt_id.clone())
		if rt.is_true(rt.call_method(var_wpdb, 'get_var', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT term_taxonomy_id FROM '), rt.get_property(var_wpdb,
					'term_relationships')),
					rt.new_string(' WHERE object_id = %d AND term_taxonomy_id = %d')),
				var_object_id.clone(),
				var_tt_id.clone(),
			]),
		]))
		{
			continue
		}
		rt.call_function('do_action', [rt.new_string('add_term_relationship'),
			var_object_id.clone(), var_tt_id.clone(), var_taxonomy.clone()])
		rt.call_method(var_wpdb, 'insert', [
			rt.get_property(var_wpdb, 'term_relationships'),
			rt.create_array([rt.ArrayItem{ key: 'object_id', val: var_object_id },
				rt.ArrayItem{ key: 'term_taxonomy_id', val: var_tt_id }]),
		])
		rt.call_function('do_action', [rt.new_string('added_term_relationship'),
			var_object_id.clone(), var_tt_id.clone(), var_taxonomy.clone()])
		var_new_tt_ids << var_tt_id.clone()
	}
	if rt.is_true(var_new_tt_ids) {
		rt.new_bool(wp_update_term_count(rt.create_array_from_list(var_new_tt_ids),
			var_taxonomy.clone(), false))
	}
	if !var_append {
		var_delete_tt_ids = rt.call_function('array_diff', [var_old_tt_ids.clone(),
			var_tt_ids.clone()])
		if rt.is_true(var_delete_tt_ids) {
			var_in_delete_tt_ids = rt.new_string("'" +
				(rt.call_function('implode', [rt.new_string("', '"), var_delete_tt_ids.clone()])).str() +
				"'")
			var_delete_term_ids = rt.call_method(var_wpdb, 'get_col', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT tt.term_id FROM '), rt.get_property(var_wpdb,
						'term_taxonomy')),
						rt.new_string(' AS tt WHERE tt.taxonomy = %s AND tt.term_taxonomy_id IN (')),
						var_in_delete_tt_ids), rt.new_string(')')),
					var_taxonomy.clone(),
				]),
			])
			var_delete_term_ids = rt.call_function('array_map', [
				rt.new_string('intval'), var_delete_term_ids.clone()])
			var_remove = rt.new_bool(wp_remove_object_terms(var_object_id.clone(),
				var_delete_term_ids.clone(), var_taxonomy.clone()))
			if rt.is_true(rt.call_function('is_wp_error', [var_remove.clone()])) {
				return var_remove.clone()
			}
		}
	}
	var_t = get_taxonomy(var_taxonomy.clone())
	if !var_append && !(rt.get_property(rt.new_bool(var_t), 'sort')).is_null()
		&& rt.is_true(rt.get_property(rt.new_bool(var_t), 'sort')) {
		var_values = rt.new_array()
		var_term_order = 0
		var_final_tt_ids = wp_get_object_terms(var_object_id.clone(), var_taxonomy.clone(), rt.create_array([
			rt.ArrayItem{ key: 'fields', val: 'tt_ids' },
			rt.ArrayItem{ key: 'update_term_meta_cache', val: false },
		]))
		mut iter_14 := var_tt_ids.iterator()
		for {
			item_14 := iter_14.next() or { break }
			mut var_tt_id_shadow := item_14.val
			if rt.is_true(rt.call_function('in_array', [
				rt.new_int(var_tt_id_shadow.to_i64()),
				var_final_tt_ids.clone(),
				rt.new_bool(true),
			]))
			{
				var_values << rt.call_method(var_wpdb, 'prepare', [
					rt.new_string('(%d, %d, %d)'),
					var_object_id.clone(),
					var_tt_id_shadow.clone(),
					rt.pre_inc(rt.new_int(var_term_order)),
				])
			}
		}
		if rt.is_true(var_values) {
			if rt.is_true(rt.identical(rt.new_bool(false), rt.call_method(var_wpdb, 'query', [
				rt.new_string((
					rt.concat(rt.concat(rt.new_string('INSERT INTO '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' (object_id, term_taxonomy_id, term_order) VALUES ')) +
					(rt.call_function('implode', [rt.new_string(','), rt.create_array_from_list(var_values)])).str() +
					' ON DUPLICATE KEY UPDATE term_order = VALUES(term_order)').str()),
			])))
			{
				return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('db_insert_error'), rt.call_function('__', [
					rt.new_string('Could not insert term relationship into the database.'),
				]), rt.get_property(var_wpdb, 'last_error')))
			}
		}
	}
	rt.call_function('wp_cache_delete', [var_object_id.clone(),
		rt.new_string(var_taxonomy.str() + '_relationships')])
	wp_cache_set_terms_last_changed()
	rt.call_function('do_action', [rt.new_string('set_object_terms'),
		var_object_id.clone(), var_terms.clone(), var_tt_ids.clone(),
		var_taxonomy.clone(), rt.new_bool(append), var_old_tt_ids.clone()])
	return var_tt_ids.clone()
}

fn wp_add_object_terms(var_object_id rt.PhpVal, var_terms rt.PhpVal, var_taxonomy rt.PhpVal) rt.PhpVal {
	return wp_set_object_terms(var_object_id.clone(), var_terms.clone(), var_taxonomy.clone(), true)
}

fn wp_remove_object_terms(var_object_id_arg rt.PhpVal, var_terms_arg rt.PhpVal, var_taxonomy rt.PhpVal) bool {
	mut var_object_id := var_object_id_arg
	mut var_terms := var_terms_arg
	mut var_wpdb := rt.new_null()
	mut var_tt_ids := rt.new_null()
	mut var_term := rt.new_null()
	mut var_term_info := rt.new_null()
	mut var_in_tt_ids := rt.new_null()
	mut var_deleted := rt.new_null()
	var_object_id = rt.new_int(var_object_id.to_i64())
	if !(taxonomy_exists(var_taxonomy.clone())) {
		return (create_wp_error(rt.new_string('invalid_taxonomy'), rt.call_function('__', [
			rt.new_string('Invalid taxonomy.'),
		]))).to_bool()
	}
	if !(var_terms.clone().is_array()) {
		var_terms = rt.create_array([rt.ArrayItem{ key: none, val: var_terms }])
	}
	var_tt_ids = rt.new_array()
	mut iter_15 := rt.cast_array(var_terms).iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_term_shadow := item_15.val
		if rt.is_true(rt.identical(rt.new_string(''),
			rt.new_string(var_term_shadow.clone().to_string().trim_space())))
		{
			continue
		}
		var_term_info = term_exists(var_term_shadow.clone(), var_taxonomy.clone(), rt.new_null())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_term_info)))) {
			if rt.is_true(rt.new_bool(var_term_shadow.clone().is_long())) {
				continue
			}
		}
		if rt.is_true(rt.call_function('is_wp_error', [var_term_info.clone()])) {
			return var_term_info.to_bool()
		}
		var_tt_ids.array_push(var_term_info.array_get(rt.new_string('term_taxonomy_id')))
	}
	if rt.is_true(var_tt_ids) {
		var_in_tt_ids = rt.new_string("'" +
			(rt.call_function('implode', [rt.new_string("', '"), var_tt_ids.clone()])).str() + "'")
		rt.call_function('do_action', [rt.new_string('delete_term_relationships'),
			var_object_id.clone(), var_tt_ids.clone(), var_taxonomy.clone()])
		var_deleted = rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb,
					'term_relationships')),
					rt.new_string(' WHERE object_id = %d AND term_taxonomy_id IN (')),
					var_in_tt_ids), rt.new_string(')')),
				var_object_id.clone(),
			]),
		])
		rt.call_function('wp_cache_delete', [var_object_id.clone(),
			rt.new_string(var_taxonomy.str() + '_relationships')])
		wp_cache_set_terms_last_changed()
		rt.call_function('do_action', [rt.new_string('deleted_term_relationships'),
			var_object_id.clone(), var_tt_ids.clone(), var_taxonomy.clone()])
		rt.new_bool(wp_update_term_count(var_tt_ids.clone(), var_taxonomy.clone(), false))
		return var_deleted.to_bool()
	}
	return false
}

fn wp_unique_term_slug(var_slug_arg rt.PhpVal, var_term rt.PhpVal) rt.PhpVal {
	mut var_slug := var_slug_arg
	mut var_wpdb := rt.new_null()
	mut var_needs_suffix := false
	mut var_original_slug := rt.new_null()
	mut var_parent_suffix := ''
	mut var_the_parent := rt.new_null()
	mut var_parent_term := rt.new_null()
	mut var_query := rt.new_null()
	mut var_num := i64(0)
	mut var_alt_slug := rt.new_null()
	mut var_slug_check := rt.new_null()
	var_needs_suffix = true
	var_original_slug = var_slug.clone()
	if rt.is_true(rt.new_bool(!(rt.is_true(term_exists(var_slug.clone(), '', rt.new_null())))))|| (rt.is_true(rt.greater_equal(rt.call_function('get_option', [rt.new_string('db_version')]), rt.new_int(30133)))
		&& rt.is_true(rt.new_bool(!(rt.is_true(get_term_by('slug', var_slug.clone(), rt.get_property(var_term, 'taxonomy'), rt.new_null(), '')))))) {
		var_needs_suffix = false
	}
	var_parent_suffix = ''
	if var_needs_suffix && is_taxonomy_hierarchical(rt.get_property(var_term, 'taxonomy'))
		&& !(!rt.is_true(rt.get_property(var_term, 'parent'))) {
		var_the_parent = rt.get_property(var_term, 'parent')
		for !(!rt.is_true(var_the_parent)) {
			var_parent_term = get_term(var_the_parent.clone(),
				rt.get_property(var_term, 'taxonomy'), rt.new_null(), '')
			if rt.is_true(rt.call_function('is_wp_error', [var_parent_term.clone()]))
				|| !rt.is_true(var_parent_term) {
				break
			}
			var_parent_suffix = var_parent_suffix + '-' +
				(rt.get_property(var_parent_term, 'slug')).str()
			if rt.is_true(rt.new_bool(!(rt.is_true(term_exists(rt.new_string(var_slug.str() +
				var_parent_suffix), '', rt.new_null())))))
			{
				break
			}
			if !rt.is_true(rt.get_property(var_parent_term, 'parent')) {
				break
			}
			var_the_parent = rt.get_property(var_parent_term, 'parent')
		}
	}
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('wp_unique_term_slug_is_bad_slug'),
		rt.new_bool(var_needs_suffix).clone(),
		var_slug.clone(),
		var_term.clone(),
	]))
	{
		if var_parent_suffix.len > 0 && var_parent_suffix != '0' {
			var_slug = rt.concat(var_slug, rt.new_string(var_parent_suffix.str()))
		}
		if !(!rt.is_true(rt.get_property(var_term, 'term_id'))) {
			var_query = rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT slug FROM '), rt.get_property(var_wpdb,
					'terms')), rt.new_string(' WHERE slug = %s AND term_id != %d')),
				var_slug.clone(),
				rt.get_property(var_term, 'term_id'),
			])
		} else {
			var_query = rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT slug FROM '), rt.get_property(var_wpdb,
					'terms')), rt.new_string(' WHERE slug = %s')),
				var_slug.clone(),
			])
		}
		if rt.is_true(rt.call_method(var_wpdb, 'get_var', [var_query.clone()])) {
			var_num = 2
			for {
				var_alt_slug = rt.new_string(var_slug.str() + '-${var_num.str()}')
				var_num += 1
				var_slug_check = rt.call_method(var_wpdb, 'get_var', [
					rt.call_method(var_wpdb, 'prepare', [
						rt.concat(rt.concat(rt.new_string('SELECT slug FROM '), rt.get_property(var_wpdb,
							'terms')), rt.new_string(' WHERE slug = %s')),
						var_alt_slug.clone(),
					]),
				])
				if !(rt.is_true(var_slug_check)) {
					break
				}
			}
			var_slug = var_alt_slug.clone()
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('wp_unique_term_slug'),
		var_slug.clone(), var_term.clone(), var_original_slug.clone()])
}

fn wp_update_term(var_term_id_arg rt.PhpVal, var_taxonomy rt.PhpVal, var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_term_id := var_term_id_arg
	mut var_args := var_args_arg
	mut var_wpdb := rt.new_null()
	mut var_term := rt.new_null()
	mut var_defaults := rt.new_null()
	mut var_parsed_args := rt.new_null()
	mut var_name := rt.new_null()
	mut var_description := rt.new_null()
	mut var_empty_slug := false
	mut var_slug := rt.new_null()
	mut var_term_group := rt.new_null()
	mut var_alias := rt.new_null()
	mut var_parent := rt.new_null()
	mut var_duplicate := rt.new_null()
	mut var_tt_id := rt.new_null()
	mut var__term_id := rt.new_null()
	mut var_data := rt.new_null()
	if !(taxonomy_exists(var_taxonomy.clone())) {
		return create_wp_error(rt.new_string('invalid_taxonomy'), rt.call_function('__', [
			rt.new_string('Invalid taxonomy.'),
		]))
	}
	var_term_id = rt.new_int(var_term_id.to_i64())
	var_term = get_term(var_term_id.clone(), var_taxonomy.clone(), rt.new_null(), '')
	if rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
		return var_term.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_term)))) {
		return create_wp_error(rt.new_string('invalid_term'), rt.call_function('__', [
			rt.new_string('Empty Term.'),
		]))
	}
	var_term = rt.cast_array(rt.get_property(var_term, 'data'))
	var_term = rt.call_function('wp_slash', [var_term.clone()])
	var_args = rt.call_function('array_merge', [var_term.clone(),
		var_args.clone()])
	var_defaults = rt.create_array([rt.ArrayItem{ key: 'alias_of', val: '' },
		rt.ArrayItem{ key: 'description', val: '' }, rt.ArrayItem{ key: 'parent', val: 0 },
		rt.ArrayItem{ key: 'slug', val: '' }])
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		var_defaults.clone()])
	var_args = sanitize_term(var_args.clone(), var_taxonomy.clone(), 'db')
	var_parsed_args = var_args.clone()
	var_name = rt.call_function('wp_unslash', [var_args.array_get(rt.new_string('name'))])
	var_description = rt.call_function('wp_unslash', [
		var_args.array_get(rt.new_string('description')),
	])
	var_parsed_args.array_set('name', var_name.clone())
	var_parsed_args.array_set('description', var_description.clone())
	if rt.is_true(rt.identical(rt.new_string(''),
		rt.new_string(var_name.clone().to_string().trim_space())))
	{
		return create_wp_error(rt.new_string('empty_term_name'), rt.call_function('__', [
			rt.new_string('A name is required for this term.'),
		]))
	}
	if rt.new_int((var_parsed_args.array_get(rt.new_string('parent'))).to_i64()) > 0
		&& rt.is_true(rt.new_bool(!(rt.is_true(term_exists(rt.new_int((var_parsed_args.array_get(rt.new_string('parent'))).to_i64()), '', rt.new_null()))))) {
		return create_wp_error(rt.new_string('missing_parent'), rt.call_function('__', [
			rt.new_string('Parent term does not exist.'),
		]))
	}
	var_empty_slug = false
	if !rt.is_true(var_args.array_get(rt.new_string('slug'))) {
		var_empty_slug = true
		var_slug = rt.call_function('sanitize_title', [var_name.clone()])
	} else {
		var_slug = var_args.array_get(rt.new_string('slug'))
	}
	var_parsed_args.array_set('slug', var_slug.clone())
	var_term_group = if !(var_parsed_args.array_get(rt.new_string('term_group'))).is_null() {
		var_parsed_args.array_get(rt.new_string('term_group'))
	} else {
		rt.new_int(0)
	}
	if rt.is_true(var_args.array_get(rt.new_string('alias_of'))) {
		var_alias = get_term_by('slug', var_args.array_get(rt.new_string('alias_of')),
			var_taxonomy.clone(), rt.new_null(), '')
		if !(!rt.is_true(rt.get_property(var_alias, 'term_group'))) {
			var_term_group = rt.get_property(var_alias, 'term_group')
		} else if !(!rt.is_true(rt.get_property(var_alias, 'term_id'))) {
			var_term_group = rt.add(rt.call_method(var_wpdb, 'get_var', [
				rt.concat(rt.new_string('SELECT MAX(term_group) FROM '), rt.get_property(var_wpdb,
					'terms')),
			]), rt.new_int(1))
			wp_update_term(rt.get_property(var_alias, 'term_id'), var_taxonomy.clone(), rt.create_array([
				rt.ArrayItem{ key: 'term_group', val: var_term_group },
			]))
		}
		var_parsed_args.array_set('term_group', var_term_group.clone())
	}
	var_parent = rt.new_int((rt.call_function('apply_filters', [
		rt.new_string('wp_update_term_parent'),
		var_args.array_get(rt.new_string('parent')),
		var_term_id.clone(),
		var_taxonomy.clone(),
		var_parsed_args.clone(),
		var_args.clone(),
	])).to_i64())
	var_duplicate = get_term_by('slug', var_slug.clone(), var_taxonomy.clone(), rt.new_null(), '')
	if rt.is_true(var_duplicate)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_duplicate, 'term_id'), var_term_id)))) {
		if var_empty_slug
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_parent, rt.new_int((var_term.array_get(rt.new_string('parent'))).to_i64()))))) {
			var_slug = wp_unique_term_slug(var_slug.clone(), rt.array_to_object(var_args))
		} else {
			return create_wp_error(rt.new_string('duplicate_term_slug'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The slug &#8220;%s&#8221; is already in use by another term.'),
				]),
				var_slug.clone(),
			]))
		}
	}
	var_tt_id = rt.new_int((rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT tt.term_taxonomy_id FROM '), rt.get_property(var_wpdb,
				'term_taxonomy')), rt.new_string(' AS tt INNER JOIN ')), rt.get_property(var_wpdb,
				'terms')),
				rt.new_string(' AS t ON tt.term_id = t.term_id WHERE tt.taxonomy = %s AND t.term_id = %d')),
			var_taxonomy.clone(),
			var_term_id.clone(),
		]),
	])).to_i64())
	var__term_id = _split_shared_term(var_term_id.clone(), var_tt_id.clone(), false)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
		var__term_id.clone()])))))
	{
		var_term_id = var__term_id.clone()
	}
	rt.call_function('do_action', [rt.new_string('edit_terms'),
		var_term_id.clone(), var_taxonomy.clone(), var_args.clone()])
	var_data = rt.call_function('compact', [rt.new_string('name'),
		rt.new_string('slug'), rt.new_string('term_group')])
	var_data = rt.call_function('apply_filters', [rt.new_string('wp_update_term_data'),
		var_data.clone(), var_term_id.clone(), var_taxonomy.clone(),
		var_args.clone()])
	rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'terms'),
		var_data.clone(), rt.call_function('compact', [rt.new_string('term_id')])])
	if !rt.is_true(var_slug) {
		var_slug = rt.call_function('sanitize_title', [var_name.clone(),
			var_term_id.clone()])
		rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'terms'),
			rt.call_function('compact', [rt.new_string('slug')]),
			rt.call_function('compact', [rt.new_string('term_id')])])
	}
	rt.call_function('do_action', [rt.new_string('edited_terms'),
		var_term_id.clone(), var_taxonomy.clone(), var_args.clone()])
	rt.call_function('do_action', [rt.new_string('edit_term_taxonomy'),
		var_tt_id.clone(), var_taxonomy.clone(), var_args.clone()])
	rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'term_taxonomy'),
		rt.call_function('compact', [rt.new_string('term_id'),
			rt.new_string('taxonomy'), rt.new_string('description'),
			rt.new_string('parent')]),
		rt.create_array([rt.ArrayItem{ key: 'term_taxonomy_id', val: var_tt_id }])])
	rt.call_function('do_action', [rt.new_string('edited_term_taxonomy'),
		var_tt_id.clone(), var_taxonomy.clone(), var_args.clone()])
	rt.call_function('do_action', [rt.new_string('edit_term'),
		var_term_id.clone(), var_tt_id.clone(), var_taxonomy.clone(),
		var_args.clone()])
	rt.call_function('do_action', [rt.new_string('edit_${var_taxonomy.to_string()}'),
		var_term_id.clone(), var_tt_id.clone(), var_args.clone()])
	var_term_id = rt.call_function('apply_filters', [rt.new_string('term_id_filter'),
		var_term_id.clone(), var_tt_id.clone()])
	clean_term_cache(var_term_id.clone(), var_taxonomy.clone(), false)
	rt.call_function('do_action', [rt.new_string('edited_term'),
		var_term_id.clone(), var_tt_id.clone(), var_taxonomy.clone(),
		var_args.clone()])
	rt.call_function('do_action', [rt.new_string('edited_${var_taxonomy.to_string()}'),
		var_term_id.clone(), var_tt_id.clone(), var_args.clone()])
	rt.call_function('do_action', [rt.new_string('saved_term'),
		var_term_id.clone(), var_tt_id.clone(), var_taxonomy.clone(),
		rt.new_bool(true), var_args.clone()])
	rt.call_function('do_action', [rt.new_string('saved_${var_taxonomy.to_string()}'),
		var_term_id.clone(), var_tt_id.clone(), rt.new_bool(true),
		var_args.clone()])
	return rt.create_array([rt.ArrayItem{ key: 'term_id', val: var_term_id },
		rt.ArrayItem{ key: 'term_taxonomy_id', val: var_tt_id }])
}

fn wp_defer_term_counting(var_defer rt.PhpVal) rt.PhpVal {
	mut var__defer := rt.new_null()
	if rt.is_true(rt.new_bool(var_defer.clone().is_bool())) {
		var__defer = var_defer
		if rt.is_true(rt.new_bool(!(rt.is_true(var_defer)))) {
			rt.new_bool(wp_update_term_count(rt.new_null(), rt.new_null(), true))
		}
	}
	return var__defer.clone()
}

fn wp_update_term_count(var_terms_arg rt.PhpVal, var_taxonomy rt.PhpVal, do_deferred bool) bool {
	mut var_do_deferred := do_deferred
	mut var_terms := var_terms_arg
	mut var__deferred := rt.new_null()
	mut var_tax := rt.new_null()
	if var_do_deferred {
		mut iter_16 := rt.cast_array(rt.func_array_keys(var__deferred.clone())).iterator()
		for {
			item_16 := iter_16.next() or { break }
			mut var_tax_shadow := item_16.val
			rt.new_bool(wp_update_term_count_now(var__deferred.array_get(var_tax_shadow),
				var_tax_shadow.clone()))
			var__deferred.array_unset(var_tax_shadow)
		}
	}
	if !rt.is_true(var_terms) {
		return false
	}
	if !(var_terms.clone().is_array()) {
		var_terms = rt.create_array([rt.ArrayItem{ key: none, val: var_terms }])
	}
	if rt.is_true(wp_defer_term_counting(rt.new_null())) {
		if !(var__deferred.array_isset(var_taxonomy)) {
			var__deferred.array_set(var_taxonomy, rt.new_array())
		}
		var__deferred.array_set(var_taxonomy, rt.call_function('array_unique', [
			rt.call_function('array_merge', [var__deferred.array_get(var_taxonomy),
				var_terms.clone()]),
		]))
		return true
	}
	return wp_update_term_count_now(var_terms.clone(), var_taxonomy.clone())
}

fn wp_update_term_count_now(var_terms_arg rt.PhpVal, var_taxonomy_arg rt.PhpVal) bool {
	mut var_terms := var_terms_arg
	mut var_taxonomy := var_taxonomy_arg
	mut var_object_types := rt.new_null()
	mut var_object_type := rt.new_null()
	var_terms = rt.call_function('array_map', [rt.new_string('intval'),
		var_terms.clone()])
	var_taxonomy = get_taxonomy(var_taxonomy)
	if !(!rt.is_true(rt.get_property(rt.new_bool(var_taxonomy), 'update_count_callback'))) {
		rt.call_function('call_user_func', [
			rt.get_property(rt.new_bool(var_taxonomy), 'update_count_callback'),
			var_terms.clone(),
			rt.new_bool(var_taxonomy).clone(),
		])
	} else {
		var_object_types = rt.cast_array(rt.get_property(rt.new_bool(var_taxonomy), 'object_type'))
		mut iter_17 := var_object_types.iterator()
		for {
			item_17 := iter_17.next() or { break }
			mut var_object_type_shadow := item_17.val
			if rt.is_true(rt.call_function('str_starts_with', [
				var_object_type_shadow.clone(), rt.new_string('attachment:')]))
			{
				mut list_tmp_1 := rt.call_function('explode', [
					rt.new_string(':'), var_object_type_shadow.clone()])
				var_object_type_shadow = list_tmp_1.array_get(0)
			}
		}
		if rt.is_true(rt.equal(rt.call_function('array_filter', [
			var_object_types.clone(), rt.new_string('post_type_exists')]), var_object_types))
		{
			_update_post_term_count(var_terms.clone(), rt.new_bool(var_taxonomy).clone())
		} else {
			_update_generic_term_count(var_terms.clone(), rt.new_bool(var_taxonomy).clone())
		}
	}
	clean_term_cache(var_terms.clone(), '', false)
	return true
}

fn clean_object_term_cache(var_object_ids_arg rt.PhpVal, var_object_type rt.PhpVal) {
	mut var_object_ids := var_object_ids_arg
	mut var__wp_suspend_cache_invalidation := rt.new_null()
	mut var_taxonomies := rt.new_null()
	mut var_taxonomy := rt.new_null()
	if !(!rt.is_true(var__wp_suspend_cache_invalidation)) {
		return
	}
	if !(var_object_ids.clone().is_array()) {
		var_object_ids = rt.create_array([rt.ArrayItem{ key: none, val: var_object_ids }])
	}
	var_taxonomies = get_object_taxonomies(var_object_type.clone(), '')
	mut iter_18 := var_taxonomies.iterator()
	for {
		item_18 := iter_18.next() or { break }
		mut var_taxonomy_shadow := item_18.val
		rt.call_function('wp_cache_delete_multiple', [var_object_ids.clone(),
			rt.new_string('${var_taxonomy.to_string()}_relationships')])
	}
	wp_cache_set_terms_last_changed()
	rt.call_function('do_action', [rt.new_string('clean_object_term_cache'),
		var_object_ids.clone(), var_object_type.clone()])
}

fn clean_term_cache(var_ids_arg rt.PhpVal, taxonomy string, clean_taxonomy bool) {
	mut var_taxonomy := taxonomy
	mut var_clean_taxonomy := clean_taxonomy
	mut var_ids := var_ids_arg
	mut var_wpdb := rt.new_null()
	mut var__wp_suspend_cache_invalidation := rt.new_null()
	mut var_taxonomies := rt.new_null()
	mut var_tt_ids := rt.new_null()
	mut var_terms := rt.new_null()
	mut var_term := rt.new_null()
	if !(!rt.is_true(var__wp_suspend_cache_invalidation)) {
		return
	}
	if !(var_ids.clone().is_array()) {
		var_ids = rt.create_array([rt.ArrayItem{ key: none, val: var_ids }])
	}
	var_taxonomies = rt.new_array()
	if var_taxonomy == '' {
		var_tt_ids = rt.call_function('array_map', [rt.new_string('intval'),
			var_ids.clone()])
		var_tt_ids = rt.call_function('implode', [rt.new_string(', '),
			var_tt_ids.clone()])
		var_terms = rt.call_method(var_wpdb, 'get_results', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT term_id, taxonomy FROM '), rt.get_property(var_wpdb,
				'term_taxonomy')), rt.new_string(' WHERE term_taxonomy_id IN (')), var_tt_ids),
				rt.new_string(')')),
		])
		var_ids = rt.new_array()
		mut iter_19 := rt.cast_array(var_terms).iterator()
		for {
			item_19 := iter_19.next() or { break }
			mut var_term_shadow := item_19.val
			var_taxonomies.array_push(rt.get_property(var_term_shadow, 'taxonomy'))
			var_ids.array_push(rt.get_property(var_term_shadow, 'term_id'))
		}
		rt.call_function('wp_cache_delete_multiple', [var_ids.clone(),
			rt.new_string('terms')])
		var_taxonomies = rt.call_function('array_unique', [var_taxonomies.clone()])
	} else {
		rt.call_function('wp_cache_delete_multiple', [var_ids.clone(),
			rt.new_string('terms')])
		var_taxonomies = rt.create_array([rt.ArrayItem{ key: none, val: var_taxonomy }])
	}
	mut iter_20 := var_taxonomies.iterator()
	for {
		item_20 := iter_20.next() or { break }
		mut var_taxonomy_shadow := item_20.val
		if var_clean_taxonomy {
			clean_taxonomy_cache(rt.new_string(var_taxonomy_shadow.str()))
		}
		rt.call_function('do_action', [rt.new_string('clean_term_cache'),
			var_ids.clone(), rt.new_string(var_taxonomy_shadow.str()),
			rt.new_bool(clean_taxonomy)])
	}
	wp_cache_set_terms_last_changed()
}

fn clean_taxonomy_cache(var_taxonomy rt.PhpVal) {
	rt.call_function('wp_cache_delete', [rt.new_string('all_ids'),
		var_taxonomy.clone()])
	rt.call_function('wp_cache_delete', [rt.new_string('get'),
		var_taxonomy.clone()])
	wp_cache_set_terms_last_changed()
	if rt.is_true(rt.new_bool(is_taxonomy_hierarchical(var_taxonomy.clone()))) {
		rt.call_function('delete_option', [
			rt.new_string('${var_taxonomy.to_string()}_children'),
		])
		_get_term_hierarchy(var_taxonomy.clone())
	}
	rt.call_function('do_action', [rt.new_string('clean_taxonomy_cache'),
		var_taxonomy.clone()])
}

fn get_object_term_cache(var_id rt.PhpVal, var_taxonomy rt.PhpVal) bool {
	mut var__term_ids := rt.new_null()
	mut var_term_ids := rt.new_null()
	mut var_term_id := rt.new_null()
	mut var_terms := rt.new_null()
	mut var_term := rt.new_null()
	var__term_ids = rt.call_function('wp_cache_get', [var_id.clone(),
		rt.new_string('${var_taxonomy.to_string()}_relationships')])
	if rt.is_true(rt.identical(rt.new_bool(false), var__term_ids)) {
		return false
	}
	var_term_ids = rt.new_array()
	mut iter_21 := var__term_ids.iterator()
	for {
		item_21 := iter_21.next() or { break }
		mut var_term_id_shadow := item_21.val
		if rt.is_true(rt.new_bool(var_term_id_shadow.clone().is_long()
			|| var_term_id_shadow.clone().is_double()))
		{
			var_term_ids.array_push(rt.new_int(var_term_id_shadow.to_i64()))
		} else if !(rt.get_property(var_term_id_shadow, 'term_id')).is_null() {
			var_term_ids.array_push(rt.new_int((rt.get_property(var_term_id_shadow, 'term_id')).to_i64()))
		}
	}
	_prime_term_caches(var_term_ids.clone(), false)
	var_terms = rt.new_array()
	mut iter_22 := var_term_ids.iterator()
	for {
		item_22 := iter_22.next() or { break }
		mut var_term_id_shadow := item_22.val
		var_term = get_term(var_term_id_shadow.clone(), var_taxonomy.clone(), rt.new_null(), '')
		if rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
			return var_term.to_bool()
		}
		var_terms.array_push(var_term.clone())
	}
	return var_terms.to_bool()
}

fn update_object_term_cache(var_object_ids_arg rt.PhpVal, var_object_type rt.PhpVal) bool {
	mut var_object_ids := var_object_ids_arg
	mut var_non_cached_ids := rt.new_null()
	mut var_taxonomies := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_cache_values := rt.new_null()
	mut var_value := rt.new_null()
	mut var_id := rt.new_null()
	mut var_terms := rt.new_null()
	mut var_object_terms := rt.new_null()
	mut var_term := rt.new_null()
	mut var_data := rt.new_null()
	if !rt.is_true(var_object_ids) {
		return false
	}
	if !(var_object_ids.clone().is_array()) {
		var_object_ids = rt.call_function('explode', [rt.new_string(','),
			var_object_ids.clone()])
	}
	var_object_ids = rt.call_function('array_map', [rt.new_string('intval'),
		var_object_ids.clone()])
	var_non_cached_ids = rt.new_array()
	var_taxonomies = get_object_taxonomies(var_object_type.clone(), '')
	mut iter_23 := var_taxonomies.iterator()
	for {
		item_23 := iter_23.next() or { break }
		mut var_taxonomy_shadow := item_23.val
		var_cache_values = rt.call_function('wp_cache_get_multiple', [
			rt.cast_array(var_object_ids),
			rt.new_string('${var_taxonomy.to_string()}_relationships'),
		])
		mut iter_24 := var_cache_values.iterator()
		for {
			item_24 := iter_24.next() or { break }
			mut var_value_shadow := item_24.val
			mut var_id_shadow := item_24.key
			if rt.is_true(rt.identical(rt.new_bool(false), var_value_shadow)) {
				var_non_cached_ids.array_push(var_id_shadow.clone())
			}
		}
	}
	if !rt.is_true(var_non_cached_ids) {
		return false
	}
	var_non_cached_ids = rt.call_function('array_unique', [var_non_cached_ids.clone()])
	var_terms = wp_get_object_terms(var_non_cached_ids.clone(), var_taxonomies.clone(), rt.create_array([
		rt.ArrayItem{ key: 'fields', val: 'all_with_object_id' },
		rt.ArrayItem{ key: 'orderby', val: 'name' },
		rt.ArrayItem{ key: 'update_term_meta_cache', val: false },
	]))
	var_object_terms = rt.new_array()
	mut iter_25 := rt.cast_array(var_terms).iterator()
	for {
		item_25 := iter_25.next() or { break }
		mut var_term_shadow := item_25.val
		var_object_terms.array_get_mut(rt.get_property(var_term_shadow, 'object_id')).array_get_mut(rt.get_property(var_term_shadow,
			'taxonomy')).array_push(rt.get_property(var_term_shadow, 'term_id'))
	}
	mut iter_26 := var_non_cached_ids.iterator()
	for {
		item_26 := iter_26.next() or { break }
		mut var_id_shadow := item_26.val
		mut iter_27 := var_taxonomies.iterator()
		for {
			item_27 := iter_27.next() or { break }
			mut var_taxonomy_shadow := item_27.val
			if !(var_object_terms.array_get(var_id_shadow).array_isset(var_taxonomy_shadow)) {
				if !(var_object_terms.array_isset(var_id_shadow)) {
					var_object_terms.array_set(var_id_shadow, rt.new_array())
				}
				var_object_terms.array_get_mut(var_id_shadow).array_set(var_taxonomy_shadow,
					rt.new_array())
			}
		}
	}
	var_cache_values = rt.new_array()
	mut iter_28 := var_object_terms.iterator()
	for {
		item_28 := iter_28.next() or { break }
		mut var_value_shadow := item_28.val
		mut var_id_shadow := item_28.key
		mut iter_29 := var_value_shadow.iterator()
		for {
			item_29 := iter_29.next() or { break }
			mut var_terms_shadow := item_29.val
			mut var_taxonomy_shadow := item_29.key
			var_cache_values.array_get_mut(var_taxonomy_shadow).array_set(var_id_shadow,
				var_terms_shadow.clone())
		}
	}
	mut iter_30 := var_cache_values.iterator()
	for {
		item_30 := iter_30.next() or { break }
		mut var_data_shadow := item_30.val
		mut var_taxonomy_shadow := item_30.key
		rt.call_function('wp_cache_add_multiple', [var_data_shadow.clone(),
			rt.new_string('${var_taxonomy.to_string()}_relationships')])
	}
	return false
}

fn update_term_cache(var_terms rt.PhpVal, taxonomy string) {
	mut var_taxonomy := taxonomy
	mut var_data := rt.new_null()
	mut var_term := rt.new_null()
	mut var__term := rt.new_null()
	var_data = rt.new_array()
	mut iter_31 := rt.cast_array(var_terms).iterator()
	for {
		item_31 := iter_31.next() or { break }
		mut var_term_shadow := item_31.val
		var__term = var_term_shadow.dup()
		rt.get_property(var__term, 'object_id') = rt.new_null()
		var_data.array_set(rt.get_property(var_term_shadow, 'term_id'), var__term.clone())
	}
	rt.call_function('wp_cache_add_multiple', [var_data.clone(),
		rt.new_string('terms')])
}

fn _get_term_hierarchy(var_taxonomy rt.PhpVal) rt.PhpVal {
	mut var_children := rt.new_null()
	mut var_terms := rt.new_null()
	mut var_parent := rt.new_null()
	mut var_term_id := rt.new_null()
	if !(is_taxonomy_hierarchical(var_taxonomy.clone())) {
		return rt.new_array()
	}
	var_children = rt.call_function('get_option', [
		rt.new_string('${var_taxonomy.to_string()}_children'),
	])
	if rt.is_true(rt.new_bool(var_children.clone().is_array())) {
		return var_children.clone()
	}
	var_children = rt.new_array()
	var_terms = get_terms(rt.create_array([
		rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
		rt.ArrayItem{ key: 'get', val: 'all' },
		rt.ArrayItem{ key: 'orderby', val: 'id' },
		rt.ArrayItem{ key: 'fields', val: 'id=>parent' },
		rt.ArrayItem{ key: 'update_term_meta_cache', val: false },
	]), '')
	mut iter_32 := var_terms.iterator()
	for {
		item_32 := iter_32.next() or { break }
		mut var_parent_shadow := item_32.val
		mut var_term_id_shadow := item_32.key
		if rt.is_true(rt.greater(var_parent_shadow, rt.new_int(0))) {
			var_children.array_get_mut(var_parent_shadow).array_push(var_term_id_shadow.clone())
		}
	}
	rt.call_function('update_option', [
		rt.new_string('${var_taxonomy.to_string()}_children'),
		var_children.clone(),
	])
	return var_children.clone()
}

fn _get_term_children(var_term_id_arg rt.PhpVal, var_terms rt.PhpVal, var_taxonomy rt.PhpVal, var_ancestors rt.PhpVal) rt.PhpVal {
	mut var_term_id := var_term_id_arg
	mut var_empty_array := rt.new_null()
	mut var_term_list := rt.new_null()
	mut var_has_children := rt.new_null()
	mut var_term := rt.new_null()
	mut var_use_id := false
	mut var_children := rt.new_null()
	var_empty_array = rt.new_array()
	if !rt.is_true(var_terms) {
		return var_empty_array.clone()
	}
	var_term_id = rt.new_int(var_term_id.to_i64())
	var_term_list = rt.new_array()
	var_has_children = _get_term_hierarchy(var_taxonomy.clone())
	if rt.is_true(var_term_id) && !(var_has_children.array_isset(var_term_id)) {
		return var_empty_array.clone()
	}
	if !rt.is_true(var_ancestors) {
		var_ancestors.array_set(var_term_id, 1)
	}
	mut iter_33 := rt.cast_array(var_terms).iterator()
	for {
		item_33 := iter_33.next() or { break }
		mut var_term_shadow := item_33.val
		var_use_id = false
		if !(var_term_shadow.clone().is_object()) {
			var_term_shadow = get_term(var_term_shadow.clone(), var_taxonomy.clone(),
				rt.new_null(), '')
			if rt.is_true(rt.call_function('is_wp_error', [var_term_shadow.clone()])) {
				return var_term_shadow.clone()
			}
			var_use_id = true
		}
		if var_ancestors.array_isset(rt.get_property(var_term_shadow, 'term_id')) {
			continue
		}
		if rt.is_true(rt.identical(rt.new_int((rt.get_property(var_term_shadow, 'parent')).to_i64()),
			var_term_id))
		{
			if var_use_id {
				var_term_list.array_push(rt.get_property(var_term_shadow, 'term_id'))
			} else {
				var_term_list.array_push(var_term_shadow.clone())
			}
			if !(var_has_children.array_isset(rt.get_property(var_term_shadow, 'term_id'))) {
				continue
			}
			var_ancestors.array_set(rt.get_property(var_term_shadow, 'term_id'), 1)
			var_children = _get_term_children(rt.get_property(var_term_shadow, 'term_id'),
				var_terms.clone(), var_taxonomy.clone(), var_ancestors.clone())
			if rt.is_true(var_children) {
				var_term_list = rt.call_function('array_merge', [
					var_term_list.clone(), var_children.clone()])
			}
		}
	}
	return var_term_list.clone()
}

fn _pad_term_counts(var_terms rt.PhpVal, var_taxonomy rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_term_hier := rt.new_null()
	mut var_term_items := rt.new_null()
	mut var_terms_by_id := rt.new_null()
	mut var_term_ids := rt.new_null()
	mut var_term := rt.new_null()
	mut var_key := rt.new_null()
	mut var_tax_obj := false
	mut var_object_types := rt.new_null()
	mut var_results := rt.new_null()
	mut var_row := rt.new_null()
	mut var_id := rt.new_null()
	mut var_term_id := rt.new_null()
	mut var_child := rt.new_null()
	mut var_ancestors := rt.new_null()
	mut var_parent := rt.new_null()
	mut var_touches := rt.new_null()
	mut var_item_id := rt.new_null()
	mut var_items := rt.new_null()
	if !(is_taxonomy_hierarchical(var_taxonomy.clone())) {
		return
	}
	var_term_hier = _get_term_hierarchy(var_taxonomy.clone())
	if !rt.is_true(var_term_hier) {
		return
	}
	var_term_items = rt.new_array()
	var_terms_by_id = rt.new_array()
	var_term_ids = rt.new_array()
	mut iter_34 := rt.cast_array(var_terms).iterator()
	for {
		item_34 := iter_34.next() or { break }
		mut var_term_shadow := item_34.val
		mut var_key_shadow := item_34.key
		var_terms_by_id.array_get(rt.get_property(var_term_shadow, 'term_id')) =
			var_terms.array_get(var_key_shadow)
		var_term_ids.array_set(rt.get_property(var_term_shadow, 'term_taxonomy_id'), rt.get_property(var_term_shadow,
			'term_id'))
	}
	var_tax_obj = get_taxonomy(var_taxonomy.clone())
	var_object_types = rt.call_function('esc_sql', [
		rt.get_property(rt.new_bool(var_tax_obj), 'object_type'),
	])
	var_results = rt.call_method(var_wpdb, 'get_results', [
		rt.new_string((
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT object_id, term_taxonomy_id FROM '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' INNER JOIN ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' ON object_id = ID WHERE term_taxonomy_id IN (')) + (rt.call_function('implode', [rt.new_string(','), rt.func_array_keys(var_term_ids.clone())])).str() +
			") AND post_type IN ('" + (rt.call_function('implode', [rt.new_string("', '"), var_object_types.clone()])).str() +
			"') AND post_status = 'publish'").str()),
	])
	mut iter_35 := var_results.iterator()
	for {
		item_35 := iter_35.next() or { break }
		mut var_row_shadow := item_35.val
		var_id = var_term_ids.array_get(rt.get_property(var_row_shadow, 'term_taxonomy_id'))
		var_term_items.array_get_mut(var_id).array_set(rt.get_property(var_row_shadow, 'object_id'), if var_term_items.array_get(var_id).array_isset(rt.get_property(var_row_shadow,
			'object_id'))
		{
			rt.pre_inc(var_term_items.array_get(var_id).array_get(rt.get_property(var_row_shadow,
				'object_id')))
		} else {
			rt.new_int(1)
		})
	}
	mut iter_36 := var_term_ids.iterator()
	for {
		item_36 := iter_36.next() or { break }
		mut var_term_id_shadow := item_36.val
		var_child = var_term_id_shadow.clone()
		var_ancestors = rt.new_array()
		var_parent = rt.get_property(var_terms_by_id.array_get(var_child), 'parent')
		for !(!rt.is_true(var_terms_by_id.array_get(var_child))) && rt.is_true(var_parent) {
			var_ancestors.array_push(var_child.clone())
			if !(!rt.is_true(var_term_items.array_get(var_term_id_shadow))) {
				mut iter_37 := var_term_items.array_get(var_term_id_shadow).iterator()
				for {
					item_37 := iter_37.next() or { break }
					mut var_touches_shadow := item_37.val
					mut var_item_id_shadow := item_37.key
					var_term_items.array_get_mut(var_parent).array_set(var_item_id_shadow, if var_term_items.array_get(var_parent).array_isset(var_item_id_shadow) {
						rt.pre_inc(var_term_items.array_get(var_parent).array_get(var_item_id_shadow))
					} else {
						rt.new_int(1)
					})
				}
			}
			var_child = var_parent.clone()
			if rt.is_true(rt.call_function('in_array', [var_parent.clone(),
				var_ancestors.clone(), rt.new_bool(true)]))
			{
				break
			}
		}
	}
	mut iter_38 := rt.cast_array(var_term_items).iterator()
	for {
		item_38 := iter_38.next() or { break }
		mut var_items_shadow := item_38.val
		mut var_id_shadow := item_38.key
		if var_terms_by_id.array_isset(var_id_shadow) {
			rt.set_property(var_terms_by_id.array_get(var_id_shadow), 'count',
				rt.new_int(var_items_shadow.clone().array_count()))
		}
	}
}

fn _prime_term_caches(var_term_ids rt.PhpVal, update_meta_cache bool) {
	mut var_update_meta_cache := update_meta_cache
	mut var_wpdb := rt.new_null()
	mut var_non_cached_ids := rt.new_null()
	mut var_fresh_terms := rt.new_null()
	var_non_cached_ids = rt.call_function('_get_non_cached_ids', [
		var_term_ids.clone(), rt.new_string('terms')])
	if !(!rt.is_true(var_non_cached_ids)) {
		var_fresh_terms = rt.call_method(var_wpdb, 'get_results', [
			rt.call_function('sprintf', [
				rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT t.*, tt.* FROM '), rt.get_property(var_wpdb,
					'terms')), rt.new_string(' AS t INNER JOIN ')), rt.get_property(var_wpdb,
					'term_taxonomy')),
					rt.new_string(' AS tt ON t.term_id = tt.term_id WHERE t.term_id IN (%s)')),
				rt.call_function('implode', [rt.new_string(','),
					rt.call_function('array_map', [rt.new_string('intval'),
						var_non_cached_ids.clone()])]),
			]),
		])
		update_term_cache(var_fresh_terms.clone(), '')
	}
	if var_update_meta_cache {
		wp_lazyload_term_meta(var_term_ids.clone())
	}
}

fn _update_post_term_count(var_terms rt.PhpVal, var_taxonomy rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_object_types := rt.new_null()
	mut var_object_type := rt.new_null()
	mut var_check_attachments := rt.new_null()
	mut var_post_statuses := rt.new_null()
	mut var_tt_id := rt.new_null()
	mut var_count := i64(0)
	var_object_types = rt.cast_array(rt.get_property(var_taxonomy, 'object_type'))
	mut iter_39 := var_object_types.iterator()
	for {
		item_39 := iter_39.next() or { break }
		mut var_object_type_shadow := item_39.val
		mut list_tmp_2 := rt.call_function('explode', [rt.new_string(':'),
			var_object_type_shadow.clone()])
		var_object_type_shadow = list_tmp_2.array_get(0)
	}
	var_object_types = rt.call_function('array_unique', [var_object_types.clone()])
	var_check_attachments = rt.call_function('array_search', [
		rt.new_string('attachment'),
		var_object_types.clone(),
		rt.new_bool(true),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_check_attachments)))) {
		var_object_types.array_unset(var_check_attachments)
		var_check_attachments = rt.new_bool(true)
	}
	if rt.is_true(var_object_types) {
		var_object_types = rt.call_function('esc_sql', [
			rt.call_function('array_filter', [var_object_types.clone(),
				rt.new_string('post_type_exists')]),
		])
	}
	var_post_statuses = rt.create_array([rt.ArrayItem{ key: none, val: 'publish' }])
	var_post_statuses = rt.call_function('esc_sql', [
		rt.call_function('apply_filters', [
			rt.new_string('update_post_term_count_statuses'),
			var_post_statuses.clone(),
			var_taxonomy.clone(),
		]),
	])
	mut iter_40 := rt.cast_array(var_terms).iterator()
	for {
		item_40 := iter_40.next() or { break }
		mut var_tt_id_shadow := item_40.val
		var_count = 0
		if rt.is_true(var_check_attachments) {
			var_count = var_count +
				rt.new_int((rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(', ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' p1 WHERE p1.ID = ')), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(".object_id AND ( post_status IN ('")) + (rt.call_function('implode', [rt.new_string("', '"), var_post_statuses.clone()])).str() +
				rt.concat(rt.concat(rt.new_string("') OR ( post_status = 'inherit' AND post_parent > 0 AND ( SELECT post_status FROM "), rt.get_property(var_wpdb, 'posts')), rt.new_string(" WHERE ID = p1.post_parent ) IN ('")) + (rt.call_function('implode', [rt.new_string("', '"), var_post_statuses.clone()])).str() +
				"') ) ) AND post_type = 'attachment' AND term_taxonomy_id = %d").str()), var_tt_id_shadow.clone()])])).to_i64())
		}
		if rt.is_true(var_object_types) {
			var_count = var_count +
				rt.new_int((rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(', ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID = ')), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(".object_id AND post_status IN ('")) + (rt.call_function('implode', [rt.new_string("', '"), var_post_statuses.clone()])).str() +
				"') AND post_type IN ('" + (rt.call_function('implode', [rt.new_string("', '"), var_object_types.clone()])).str() +
				"') AND term_taxonomy_id = %d").str()), var_tt_id_shadow.clone()])])).to_i64())
		}
		rt.call_function('do_action', [rt.new_string('update_term_count'),
			var_tt_id_shadow.clone(), rt.get_property(var_taxonomy, 'name'),
			rt.new_int(var_count).clone()])
		rt.call_function('do_action', [rt.new_string('edit_term_taxonomy'),
			var_tt_id_shadow.clone(), rt.get_property(var_taxonomy, 'name')])
		rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'term_taxonomy'),
			rt.call_function('compact', [rt.new_string('count')]),
			rt.create_array([rt.ArrayItem{ key: 'term_taxonomy_id', val: var_tt_id_shadow }])])
		rt.call_function('do_action', [rt.new_string('edited_term_taxonomy'),
			var_tt_id_shadow.clone(), rt.get_property(var_taxonomy, 'name')])
	}
}

fn _update_generic_term_count(var_terms rt.PhpVal, var_taxonomy rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_term := rt.new_null()
	mut var_count := rt.new_null()
	mut iter_41 := rt.cast_array(var_terms).iterator()
	for {
		item_41 := iter_41.next() or { break }
		mut var_term_shadow := item_41.val
		var_count = rt.call_method(var_wpdb, 'get_var', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM '), rt.get_property(var_wpdb,
					'term_relationships')), rt.new_string(' WHERE term_taxonomy_id = %d')),
				var_term_shadow.clone(),
			]),
		])
		rt.call_function('do_action', [rt.new_string('update_term_count'),
			var_term_shadow.clone(), rt.get_property(var_taxonomy, 'name'),
			var_count.clone()])
		rt.call_function('do_action', [rt.new_string('edit_term_taxonomy'),
			var_term_shadow.clone(), rt.get_property(var_taxonomy, 'name')])
		rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'term_taxonomy'),
			rt.call_function('compact', [rt.new_string('count')]),
			rt.create_array([rt.ArrayItem{ key: 'term_taxonomy_id', val: var_term_shadow }])])
		rt.call_function('do_action', [rt.new_string('edited_term_taxonomy'),
			var_term_shadow.clone(), rt.get_property(var_taxonomy, 'name')])
	}
}

fn _split_shared_term(var_term_id_arg rt.PhpVal, var_term_taxonomy_id_arg rt.PhpVal, record bool) rt.PhpVal {
	mut var_record := record
	mut var_term_id := var_term_id_arg
	mut var_term_taxonomy_id := var_term_taxonomy_id_arg
	mut var_wpdb := rt.new_null()
	mut var_shared_term := rt.new_null()
	mut var_term_taxonomy := rt.new_null()
	mut var_shared_tt_count := rt.new_null()
	mut var_check_term_id := rt.new_null()
	mut var_new_term_data := map[string]rt.PhpVal{}
	mut var_new_term_id := rt.new_null()
	mut var_children_tt_ids := rt.new_null()
	mut var_child_tt_id := rt.new_null()
	mut var_taxonomies_to_clean := rt.new_null()
	mut var_shared_term_taxonomies := rt.new_null()
	mut var_taxonomy_to_clean := rt.new_null()
	mut var_split_term_data := rt.new_null()
	mut var_shared_terms_exist := rt.new_null()
	if rt.is_true(rt.new_bool(var_term_id.clone().is_object())) {
		var_shared_term = var_term_id.clone()
		var_term_id = rt.new_int((rt.get_property(var_shared_term, 'term_id')).to_i64())
	}
	if rt.is_true(rt.new_bool(var_term_taxonomy_id.clone().is_object())) {
		var_term_taxonomy = var_term_taxonomy_id.clone()
		var_term_taxonomy_id =
			rt.new_int((rt.get_property(var_term_taxonomy, 'term_taxonomy_id')).to_i64())
	}
	var_shared_tt_count = rt.new_int((rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM '), rt.get_property(var_wpdb,
				'term_taxonomy')),
				rt.new_string(' tt WHERE tt.term_id = %d AND tt.term_taxonomy_id != %d')),
			var_term_id.clone(),
			var_term_taxonomy_id.clone(),
		]),
	])).to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_shared_tt_count)))) {
		return var_term_id.clone()
	}
	var_check_term_id = rt.new_int((rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT term_id FROM '), rt.get_property(var_wpdb,
				'term_taxonomy')), rt.new_string(' WHERE term_taxonomy_id = %d')),
			var_term_taxonomy_id.clone(),
		]),
	])).to_i64())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_check_term_id, var_term_id)))) {
		return var_check_term_id.clone()
	}
	if !rt.is_true(var_shared_term) {
		var_shared_term = rt.call_method(var_wpdb, 'get_row', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT t.* FROM '), rt.get_property(var_wpdb,
					'terms')), rt.new_string(' t WHERE t.term_id = %d')),
				var_term_id.clone(),
			]),
		])
	}
	var_new_term_data = {
		'name':       rt.get_property(var_shared_term, 'name')
		'slug':       rt.get_property(var_shared_term, 'slug')
		'term_group': rt.get_property(var_shared_term, 'term_group')
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_method(var_wpdb, 'insert', [
		rt.get_property(var_wpdb, 'terms'),
		rt.create_array_from_native_map(var_new_term_data),
	])))
	{
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('db_insert_error'), rt.call_function('__', [
			rt.new_string('Could not split shared term.'),
		]), rt.get_property(var_wpdb, 'last_error')))
	}
	var_new_term_id = rt.new_int((rt.get_property(var_wpdb, 'insert_id')).to_i64())
	rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'term_taxonomy'),
		rt.create_array([rt.ArrayItem{ key: 'term_id', val: var_new_term_id }]),
		rt.create_array([rt.ArrayItem{ key: 'term_taxonomy_id', val: var_term_taxonomy_id }])])
	if !rt.is_true(var_term_taxonomy) {
		var_term_taxonomy = rt.call_method(var_wpdb, 'get_row', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
					'term_taxonomy')), rt.new_string(' WHERE term_taxonomy_id = %d')),
				var_term_taxonomy_id.clone(),
			]),
		])
	}
	var_children_tt_ids = rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT term_taxonomy_id FROM '), rt.get_property(var_wpdb,
				'term_taxonomy')), rt.new_string(' WHERE parent = %d AND taxonomy = %s')),
			var_term_id.clone(),
			rt.get_property(var_term_taxonomy, 'taxonomy'),
		]),
	])
	if !(!rt.is_true(var_children_tt_ids)) {
		mut iter_42 := var_children_tt_ids.iterator()
		for {
			item_42 := iter_42.next() or { break }
			mut var_child_tt_id_shadow := item_42.val
			rt.call_method(var_wpdb, 'update', [
				rt.get_property(var_wpdb, 'term_taxonomy'),
				rt.create_array([rt.ArrayItem{ key: 'parent', val: var_new_term_id }]),
				rt.create_array([rt.ArrayItem{ key: 'term_taxonomy_id', val: var_child_tt_id_shadow }]),
			])
			clean_term_cache(rt.new_int(var_child_tt_id_shadow.to_i64()), '', false)
		}
	} else {
		clean_term_cache(var_new_term_id.clone(), rt.get_property(var_term_taxonomy, 'taxonomy'),
			false)
	}
	clean_term_cache(var_term_id.clone(), rt.get_property(var_term_taxonomy, 'taxonomy'), false)
	var_taxonomies_to_clean = rt.create_array([
		rt.ArrayItem{ key: none, val: rt.get_property(var_term_taxonomy, 'taxonomy') },
	])
	var_shared_term_taxonomies = rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT taxonomy FROM '), rt.get_property(var_wpdb,
				'term_taxonomy')), rt.new_string(' WHERE term_id = %d')),
			var_term_id.clone(),
		]),
	])
	var_taxonomies_to_clean = rt.call_function('array_merge', [
		var_taxonomies_to_clean.clone(), var_shared_term_taxonomies.clone()])
	mut iter_43 := var_taxonomies_to_clean.iterator()
	for {
		item_43 := iter_43.next() or { break }
		mut var_taxonomy_to_clean_shadow := item_43.val
		clean_taxonomy_cache(var_taxonomy_to_clean_shadow.clone())
	}
	if var_record {
		var_split_term_data = rt.call_function('get_option', [
			rt.new_string('_split_terms'),
			rt.new_array(),
		])
		if !(var_split_term_data.array_isset(var_term_id)) {
			var_split_term_data.array_set(var_term_id, rt.new_array())
		}
		var_split_term_data.array_get_mut(var_term_id).array_set(rt.get_property(var_term_taxonomy,
			'taxonomy'), var_new_term_id.clone())
		rt.call_function('update_option', [rt.new_string('_split_terms'),
			var_split_term_data.clone()])
	}
	var_shared_terms_exist = rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT tt.term_id, t.*, count(*) as term_tt_count FROM '), rt.get_property(var_wpdb,
			'term_taxonomy')), rt.new_string(' tt\n\t\t LEFT JOIN ')), rt.get_property(var_wpdb,
			'terms')),
			rt.new_string(' t ON t.term_id = tt.term_id\n\t\t GROUP BY t.term_id\n\t\t HAVING term_tt_count > 1\n\t\t LIMIT 1')),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_shared_terms_exist)))) {
		rt.call_function('update_option', [
			rt.new_string('finished_splitting_shared_terms'),
			rt.new_bool(true),
		])
	}
	rt.call_function('do_action', [rt.new_string('split_shared_term'),
		var_term_id.clone(), var_new_term_id.clone(), var_term_taxonomy_id.clone(),
		rt.get_property(var_term_taxonomy, 'taxonomy')])
	return var_new_term_id.clone()
}

fn _wp_batch_split_terms() {
	mut var_wpdb := rt.new_null()
	mut var_lock_name := ''
	mut var_lock_result := rt.new_null()
	mut var_shared_terms := rt.new_null()
	mut var__shared_terms := rt.new_null()
	mut var_shared_term := rt.new_null()
	mut var_term_id := rt.new_null()
	mut var_shared_term_ids := rt.new_null()
	mut var_shared_tts := rt.new_null()
	mut var_split_term_data := rt.new_null()
	mut var_skipped_first_term := rt.new_null()
	mut var_taxonomies := rt.new_null()
	mut var_shared_tt := rt.new_null()
	mut var_tax := rt.new_null()
	var_lock_name = 'term_split.lock'
	var_lock_result = rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('INSERT IGNORE INTO `'), rt.get_property(var_wpdb,
				'options')),
				rt.new_string("` ( `option_name`, `option_value`, `autoload` ) VALUES (%s, %s, 'off') /* LOCK */")),
			rt.new_string(var_lock_name.str()).clone(),
			rt.call_function('time', []rt.PhpVal{}),
		]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_lock_result)))) {
		var_lock_result = rt.call_function('get_option',
			[rt.new_string(var_lock_name.str()).clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_lock_result))))
			|| rt.is_true(rt.greater(var_lock_result, rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.get_constant('HOUR_IN_SECONDS')))) {
			rt.call_function('wp_schedule_single_event', [
				rt.add(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.new_int(5),
					rt.get_constant('MINUTE_IN_SECONDS'))),
				rt.new_string('wp_split_shared_term_batch'),
			])
			return
		}
	}
	rt.call_function('update_option', [rt.new_string(var_lock_name.str()).clone(),
		rt.call_function('time', []rt.PhpVal{})])
	var_shared_terms = rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT tt.term_id, t.*, count(*) as term_tt_count FROM '), rt.get_property(var_wpdb,
			'term_taxonomy')), rt.new_string(' tt\n\t\t LEFT JOIN ')), rt.get_property(var_wpdb,
			'terms')),
			rt.new_string(' t ON t.term_id = tt.term_id\n\t\t GROUP BY t.term_id\n\t\t HAVING term_tt_count > 1\n\t\t LIMIT 10')),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_shared_terms)))) {
		rt.call_function('update_option', [
			rt.new_string('finished_splitting_shared_terms'),
			rt.new_bool(true),
		])
		rt.call_function('delete_option', [rt.new_string(var_lock_name.str()).clone()])
		return
	}
	rt.call_function('wp_schedule_single_event', [
		rt.add(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.new_int(2),
			rt.get_constant('MINUTE_IN_SECONDS'))),
		rt.new_string('wp_split_shared_term_batch'),
	])
	var__shared_terms = rt.new_array()
	mut iter_44 := var_shared_terms.iterator()
	for {
		item_44 := iter_44.next() or { break }
		mut var_shared_term_shadow := item_44.val
		var_term_id = rt.new_int((rt.get_property(var_shared_term_shadow, 'term_id')).to_i64())
		var__shared_terms.array_set(var_term_id, var_shared_term_shadow.clone())
	}
	var_shared_terms = var__shared_terms.clone()
	var_shared_term_ids = rt.call_function('implode', [rt.new_string(','),
		rt.func_array_keys(var_shared_terms.clone())])
	var_shared_tts = rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
			'term_taxonomy')), rt.new_string(' WHERE `term_id` IN (')), var_shared_term_ids),
			rt.new_string(')')),
	])
	var_split_term_data = rt.call_function('get_option', [rt.new_string('_split_terms'),
		rt.new_array()])
	var_skipped_first_term = rt.new_array()
	var_taxonomies = rt.new_array()
	mut iter_45 := var_shared_tts.iterator()
	for {
		item_45 := iter_45.next() or { break }
		mut var_shared_tt_shadow := item_45.val
		var_term_id = rt.new_int((rt.get_property(var_shared_tt_shadow, 'term_id')).to_i64())
		if !(var_skipped_first_term.array_isset(var_term_id)) {
			var_skipped_first_term.array_set(var_term_id, 1)
			continue
		}
		if !(var_split_term_data.array_isset(var_term_id)) {
			var_split_term_data.array_set(var_term_id, rt.new_array())
		}
		if !(var_taxonomies.array_isset(rt.get_property(var_shared_tt_shadow, 'taxonomy'))) {
			var_taxonomies.array_set(rt.get_property(var_shared_tt_shadow, 'taxonomy'), 1)
		}
		var_split_term_data.array_get_mut(var_term_id).array_set(rt.get_property(var_shared_tt_shadow,
			'taxonomy'), _split_shared_term(var_shared_terms.array_get(var_term_id),
			var_shared_tt_shadow.clone(), false))
	}
	mut iter_46 := rt.func_array_keys(var_taxonomies.clone()).iterator()
	for {
		item_46 := iter_46.next() or { break }
		mut var_tax_shadow := item_46.val
		rt.call_function('delete_option', [
			rt.new_string('${var_tax.to_string()}_children'),
		])
		_get_term_hierarchy(var_tax_shadow.clone())
	}
	rt.call_function('update_option', [rt.new_string('_split_terms'),
		var_split_term_data.clone()])
	rt.call_function('delete_option', [rt.new_string(var_lock_name.str()).clone()])
}

fn _wp_check_for_scheduled_split_terms() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [rt.new_string('finished_splitting_shared_terms')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_next_scheduled', [rt.new_string('wp_split_shared_term_batch')]))))) {
		rt.call_function('wp_schedule_single_event', [
			rt.add(rt.call_function('time', []rt.PhpVal{}), rt.get_constant('MINUTE_IN_SECONDS')),
			rt.new_string('wp_split_shared_term_batch'),
		])
	}
}

fn _wp_check_split_default_terms(var_term_id rt.PhpVal, var_new_term_id rt.PhpVal, var_term_taxonomy_id rt.PhpVal, var_taxonomy rt.PhpVal) {
	mut var_option := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('category'), var_taxonomy)))) {
		return
	}
	mut iter_47 := rt.create_array([rt.ArrayItem{ key: none, val: 'default_category' },
		rt.ArrayItem{ key: none, val: 'default_link_category' },
		rt.ArrayItem{ key: none, val: 'default_email_category' }]).iterator()
	for {
		item_47 := iter_47.next() or { break }
		mut var_option_shadow := item_47.val
		if rt.is_true(rt.identical(rt.new_int((rt.call_function('get_option', [
			var_option_shadow.clone(),
			rt.new_int(-1),
		])).to_i64()), var_term_id))
		{
			rt.call_function('update_option', [var_option_shadow.clone(),
				var_new_term_id.clone()])
		}
	}
}

fn _wp_check_split_terms_in_menus(var_term_id rt.PhpVal, var_new_term_id rt.PhpVal, var_term_taxonomy_id rt.PhpVal, var_taxonomy rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_post_ids := rt.new_null()
	mut var_post_id := rt.new_null()
	var_post_ids = rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT m1.post_id\n\t\tFROM '), rt.get_property(var_wpdb,
				'postmeta')), rt.new_string(' AS m1\n\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
				'postmeta')),
				rt.new_string(' AS m2 ON ( m2.post_id = m1.post_id )\n\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
				'postmeta')),
				rt.new_string(" AS m3 ON ( m3.post_id = m1.post_id )\n\t\tWHERE ( m1.meta_key = '_menu_item_type' AND m1.meta_value = 'taxonomy' )\n\t\t\tAND ( m2.meta_key = '_menu_item_object' AND m2.meta_value = %s )\n\t\t\tAND ( m3.meta_key = '_menu_item_object_id' AND m3.meta_value = %d )")),
			var_taxonomy.clone(),
			var_term_id.clone(),
		]),
	])
	if rt.is_true(var_post_ids) {
		mut iter_48 := var_post_ids.iterator()
		for {
			item_48 := iter_48.next() or { break }
			mut var_post_id_shadow := item_48.val
			rt.call_function('update_post_meta', [var_post_id_shadow.clone(),
				rt.new_string('_menu_item_object_id'), var_new_term_id.clone(),
				var_term_id.clone()])
		}
	}
}

fn _wp_check_split_nav_menu_terms(var_term_id rt.PhpVal, var_new_term_id rt.PhpVal, var_term_taxonomy_id rt.PhpVal, var_taxonomy rt.PhpVal) {
	mut var_locations := rt.new_null()
	mut var_menu_id := rt.new_null()
	mut var_location := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('nav_menu'), var_taxonomy)))) {
		return
	}
	var_locations = rt.call_function('get_nav_menu_locations', []rt.PhpVal{})
	mut iter_49 := var_locations.iterator()
	for {
		item_49 := iter_49.next() or { break }
		mut var_menu_id_shadow := item_49.val
		mut var_location_shadow := item_49.key
		if rt.is_true(rt.identical(var_term_id, var_menu_id_shadow)) {
			var_locations.array_set(var_location_shadow, var_new_term_id.clone())
		}
	}
	rt.call_function('set_theme_mod', [rt.new_string('nav_menu_locations'),
		var_locations.clone()])
}

fn wp_get_split_terms(var_old_term_id rt.PhpVal) rt.PhpVal {
	mut var_split_terms := rt.new_null()
	mut var_terms := rt.new_null()
	var_split_terms = rt.call_function('get_option', [rt.new_string('_split_terms'),
		rt.new_array()])
	var_terms = rt.new_array()
	if var_split_terms.array_isset(var_old_term_id) {
		var_terms = var_split_terms.array_get(var_old_term_id)
	}
	return var_terms.clone()
}

fn wp_get_split_term(var_old_term_id rt.PhpVal, var_taxonomy rt.PhpVal) rt.PhpVal {
	mut var_split_terms := rt.new_null()
	mut var_term_id := rt.new_null()
	var_split_terms = wp_get_split_terms(var_old_term_id.clone())
	var_term_id = rt.new_bool(false)
	if var_split_terms.array_isset(var_taxonomy) {
		var_term_id = rt.new_int((var_split_terms.array_get(var_taxonomy)).to_i64())
	}
	return var_term_id.clone()
}

fn wp_term_is_shared(var_term_id rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_tt_count := rt.new_null()
	if rt.is_true(rt.call_function('get_option', [
		rt.new_string('finished_splitting_shared_terms'),
	]))
	{
		return false
	}
	var_tt_count = rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM '), rt.get_property(var_wpdb,
				'term_taxonomy')), rt.new_string(' WHERE term_id = %d')),
			var_term_id.clone(),
		]),
	])
	return (rt.greater(var_tt_count, rt.new_int(1))).to_bool()
}

fn get_term_link(var_term_arg rt.PhpVal, taxonomy string) rt.PhpVal {
	mut var_taxonomy := taxonomy
	mut var_term := var_term_arg
	mut var_wp_rewrite := rt.new_null()
	mut var_termlink := rt.new_null()
	mut var_slug := rt.new_null()
	mut var_t := false
	mut var_hierarchical_slugs := rt.new_null()
	mut var_ancestors := rt.new_null()
	mut var_ancestor := rt.new_null()
	mut var_ancestor_term := rt.new_null()
	if !(var_term.clone().is_object()) {
		if rt.is_true(rt.new_bool(var_term.clone().is_long())) {
			var_term = get_term(var_term.clone(), var_taxonomy, rt.new_null(), '')
		} else {
			var_term = get_term_by('slug', var_term.clone(), var_taxonomy, rt.new_null(), '')
		}
	}
	if !(var_term.clone().is_object()) {
		var_term = create_wp_error(rt.new_string('invalid_term'), rt.call_function('__', [
			rt.new_string('Empty Term.'),
		]))
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
		return var_term.clone()
	}
	var_taxonomy = (rt.get_property(var_term, 'taxonomy')).str()
	var_termlink = rt.call_method(var_wp_rewrite, 'get_extra_permastruct', [
		rt.new_string(var_taxonomy.str()),
	])
	var_termlink = rt.call_function('apply_filters', [rt.new_string('pre_term_link'),
		var_termlink.clone(), var_term.clone()])
	var_slug = rt.get_property(var_term, 'slug')
	var_t = get_taxonomy(var_taxonomy)
	if !rt.is_true(var_termlink) {
		if rt.is_true(rt.identical(rt.new_string('category'), rt.new_string(var_taxonomy.str()))) {
			var_termlink = rt.new_string('?cat=' + (rt.get_property(var_term, 'term_id')).str())
		} else if rt.is_true(rt.get_property(rt.new_bool(var_t), 'query_var')) {
			var_termlink = rt.new_string((rt.concat(rt.concat(rt.concat(rt.new_string('?'), rt.get_property(rt.new_bool(var_t),
				'query_var')), rt.new_string('=')), var_slug)).str())
		} else {
			var_termlink = rt.new_string('?taxonomy=${var_taxonomy}&term=${var_slug.to_string()}')
		}
		var_termlink = rt.call_function('home_url', [var_termlink.clone()])
	} else {
		if !(!rt.is_true(rt.get_property(rt.new_bool(var_t), 'rewrite').array_get(rt.new_string('hierarchical')))) {
			var_hierarchical_slugs = rt.new_array()
			var_ancestors = get_ancestors(rt.get_property(var_term, 'term_id'), var_taxonomy,
				'taxonomy')
			mut iter_50 := rt.cast_array(var_ancestors).iterator()
			for {
				item_50 := iter_50.next() or { break }
				mut var_ancestor_shadow := item_50.val
				var_ancestor_term = get_term(var_ancestor_shadow.clone(), var_taxonomy,
					rt.new_null(), '')
				var_hierarchical_slugs.array_push(rt.get_property(var_ancestor_term, 'slug'))
			}
			var_hierarchical_slugs = rt.call_function('array_reverse', [
				var_hierarchical_slugs.clone()])
			var_hierarchical_slugs.array_push(var_slug.clone())
			var_termlink = rt.call_function('str_replace', [
				rt.new_string('%${var_taxonomy}%'),
				rt.call_function('implode', [rt.new_string('/'),
					var_hierarchical_slugs.clone()]),
				var_termlink.clone(),
			])
		} else {
			var_termlink = rt.call_function('str_replace', [
				rt.new_string('%${var_taxonomy}%'),
				var_slug.clone(),
				var_termlink.clone(),
			])
		}
		var_termlink = rt.call_function('home_url', [
			rt.call_function('user_trailingslashit', [var_termlink.clone(),
				rt.new_string('category')]),
		])
	}
	if rt.is_true(rt.identical(rt.new_string('post_tag'), rt.new_string(var_taxonomy.str()))) {
		var_termlink = rt.call_function('apply_filters', [rt.new_string('tag_link'),
			var_termlink.clone(), rt.get_property(var_term, 'term_id')])
	} else if rt.is_true(rt.identical(rt.new_string('category'), rt.new_string(var_taxonomy.str()))) {
		var_termlink = rt.call_function('apply_filters', [rt.new_string('category_link'),
			var_termlink.clone(), rt.get_property(var_term, 'term_id')])
	}
	return rt.call_function('apply_filters', [rt.new_string('term_link'),
		var_termlink.clone(), var_term.clone(), rt.new_string(var_taxonomy.str())])
}

fn the_taxonomies(var_args rt.PhpVal) {
	mut var_defaults := rt.new_null()
	mut var_parsed_args := rt.new_null()
	var_defaults = rt.create_array([rt.ArrayItem{ key: 'post', val: 0 },
		rt.ArrayItem{ key: 'before', val: '' }, rt.ArrayItem{ key: 'sep', val: ' ' },
		rt.ArrayItem{ key: 'after', val: '' }])
	var_parsed_args = rt.call_function('wp_parse_args', [var_args.clone(),
		var_defaults.clone()])
	print(
		(var_parsed_args.array_get(rt.new_string('before'))).str() + (rt.call_function('implode', [var_parsed_args.array_get(rt.new_string('sep')), get_the_taxonomies(var_parsed_args.array_get(rt.new_string('post')), var_parsed_args.clone())])).str() +
		(var_parsed_args.array_get(rt.new_string('after'))).str())
}

fn get_the_taxonomies(post i64, var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_post := post
	mut var_args := var_args_arg
	mut var_taxonomies := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_t := rt.new_null()
	mut var_terms := rt.new_null()
	mut var_links := []rt.PhpVal{}
	mut var_term := rt.new_null()
	var_post = (rt.call_function('get_post', [rt.new_int(var_post)])).to_i64()
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'template', val: rt.call_function('__', [
				rt.new_string('%s: %l.'),
			]) },
			rt.ArrayItem{ key: 'term_template', val: '<a href="%1$s">%2$s</a>' },
		])])
	var_taxonomies = rt.new_array()
	if !(var_post != 0) {
		return var_taxonomies.clone()
	}
	mut iter_51 := get_object_taxonomies(rt.new_int(var_post), '').iterator()
	for {
		item_51 := iter_51.next() or { break }
		mut var_taxonomy_shadow := item_51.val
		var_t = rt.cast_array(rt.new_bool(get_taxonomy(var_taxonomy_shadow.clone())))
		if !rt.is_true(var_t.array_get(rt.new_string('label'))) {
			var_t.array_set('label', var_taxonomy_shadow.clone())
		}
		if !rt.is_true(var_t.array_get(rt.new_string('args'))) {
			var_t.array_set('args', rt.new_array())
		}
		if !rt.is_true(var_t.array_get(rt.new_string('template'))) {
			var_t.array_set('template', var_args.array_get(rt.new_string('template')))
		}
		if !rt.is_true(var_t.array_get(rt.new_string('term_template'))) {
			var_t.array_set('term_template', var_args.array_get(rt.new_string('term_template')))
		}
		var_terms = rt.new_bool(get_object_term_cache(rt.get_property(rt.new_int(var_post), 'ID'),
			var_taxonomy_shadow.clone()))
		if rt.is_true(rt.identical(rt.new_bool(false), var_terms)) {
			var_terms = wp_get_object_terms(rt.get_property(rt.new_int(var_post), 'ID'),
				var_taxonomy_shadow.clone(), var_t.array_get(rt.new_string('args')))
		}
		var_links = rt.new_array()
		mut iter_52 := var_terms.iterator()
		for {
			item_52 := iter_52.next() or { break }
			mut var_term_shadow := item_52.val
			var_links << rt.call_function('wp_sprintf', [
				var_t.array_get(rt.new_string('term_template')),
				rt.call_function('esc_attr', [
					get_term_link(var_term_shadow.clone(), ''),
				]),
				rt.get_property(var_term_shadow, 'name'),
			])
		}
		if rt.is_true(var_links) {
			var_taxonomies.array_set(var_taxonomy_shadow, rt.call_function('wp_sprintf', [
				var_t.array_get(rt.new_string('template')),
				var_t.array_get(rt.new_string('label')),
				rt.create_array_from_list(var_links),
				var_terms.clone(),
			]))
		}
	}
	return var_taxonomies.clone()
}

fn get_post_taxonomies(post i64) rt.PhpVal {
	mut var_post := post
	var_post = (rt.call_function('get_post', [rt.new_int(var_post)])).to_i64()
	return get_object_taxonomies(rt.new_int(var_post), '')
}

fn is_object_in_term(var_object_id_arg rt.PhpVal, var_taxonomy rt.PhpVal, var_terms_arg rt.PhpVal) bool {
	mut var_object_id := var_object_id_arg
	mut var_terms := var_terms_arg
	mut var_object_terms := rt.new_null()
	mut var_ints := rt.new_null()
	mut var_strs := rt.new_null()
	mut var_object_term := rt.new_null()
	mut var_numeric_strs := rt.new_null()
	var_object_id = rt.new_int(var_object_id.to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_object_id)))) {
		return (create_wp_error(rt.new_string('invalid_object'), rt.call_function('__', [
			rt.new_string('Invalid object ID.'),
		]))).to_bool()
	}
	var_object_terms = rt.new_bool(get_object_term_cache(var_object_id.clone(),
		var_taxonomy.clone()))
	if rt.is_true(rt.identical(rt.new_bool(false), var_object_terms)) {
		var_object_terms = wp_get_object_terms(var_object_id.clone(), var_taxonomy.clone(), rt.create_array([
			rt.ArrayItem{ key: 'update_term_meta_cache', val: false },
		]))
		if rt.is_true(rt.call_function('is_wp_error', [var_object_terms.clone()])) {
			return var_object_terms.to_bool()
		}
		rt.call_function('wp_cache_set', [var_object_id.clone(),
			rt.call_function('wp_list_pluck', [var_object_terms.clone(),
				rt.new_string('term_id')]),
			rt.new_string('${var_taxonomy.to_string()}_relationships')])
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_object_terms.clone()])) {
		return var_object_terms.to_bool()
	}
	if !rt.is_true(var_object_terms) {
		return false
	}
	if !rt.is_true(var_terms) {
		return true
	}
	var_terms = rt.cast_array(var_terms)
	var_ints = rt.call_function('array_filter', [var_terms.clone(),
		rt.new_string('is_int')])
	if rt.is_true(var_ints) {
		var_strs = rt.call_function('array_diff', [var_terms.clone(),
			var_ints.clone()])
	} else {
		var_strs = var_terms
	}
	mut iter_53 := var_object_terms.iterator()
	for {
		item_53 := iter_53.next() or { break }
		mut var_object_term_shadow := item_53.val
		if rt.is_true(var_ints)
			&& rt.is_true(rt.call_function('in_array', [rt.get_property(var_object_term_shadow, 'term_id'), var_ints.clone(), rt.new_bool(true)])) {
			return true
		}
		if rt.is_true(var_strs) {
			var_numeric_strs = rt.call_function('array_map', [
				rt.new_string('intval'),
				rt.call_function('array_filter', [
					var_strs.clone(), rt.new_string('is_numeric')])])
			if rt.is_true(rt.call_function('in_array', [
				rt.get_property(var_object_term_shadow, 'term_id'),
				var_numeric_strs.clone(),
				rt.new_bool(true),
			]))
			{
				return true
			}
			if rt.is_true(rt.call_function('in_array', [
				rt.get_property(var_object_term_shadow, 'name'),
				var_strs.clone(),
				rt.new_bool(true),
			]))
			{
				return true
			}
			if rt.is_true(rt.call_function('in_array', [
				rt.get_property(var_object_term_shadow, 'slug'),
				var_strs.clone(),
				rt.new_bool(true),
			]))
			{
				return true
			}
		}
	}
	return false
}

fn is_object_in_taxonomy(var_object_type rt.PhpVal, var_taxonomy rt.PhpVal) bool {
	mut var_taxonomies := rt.new_null()
	var_taxonomies = get_object_taxonomies(var_object_type.clone(), '')
	if !rt.is_true(var_taxonomies) {
		return false
	}
	return (rt.call_function('in_array', [var_taxonomy.clone(),
		var_taxonomies.clone(), rt.new_bool(true)])).to_bool()
}

fn get_ancestors(object_id i64, object_type string, resource_type string) rt.PhpVal {
	mut var_object_id := object_id
	mut var_object_type := object_type
	mut var_resource_type := resource_type
	mut var_ancestors := rt.new_null()
	mut var_term := rt.new_null()
	var_object_id = var_object_id
	var_ancestors = rt.new_array()
	if var_object_id == 0 {
		return rt.call_function('apply_filters', [rt.new_string('get_ancestors'),
			var_ancestors.clone(), rt.new_int(var_object_id),
			rt.new_string(object_type), rt.new_string(var_resource_type.str())])
	}
	if !(var_resource_type.len > 0 && var_resource_type != '0') {
		if rt.is_true(rt.new_bool(is_taxonomy_hierarchical(rt.new_string(object_type)))) {
			var_resource_type = 'taxonomy'
		} else if rt.is_true(rt.call_function('post_type_exists', [
			rt.new_string(object_type),
		]))
		{
			var_resource_type = 'post_type'
		}
	}
	if rt.is_true(rt.identical(rt.new_string('taxonomy'), rt.new_string(var_resource_type.str()))) {
		var_term = get_term(rt.new_int(var_object_id), object_type, rt.new_null(), '')
		for rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])))))
			&& !(!rt.is_true(rt.get_property(var_term, 'parent')))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_term, 'parent'), var_ancestors.clone(), rt.new_bool(true)]))))) {
			var_ancestors.array_push(rt.new_int((rt.get_property(var_term, 'parent')).to_i64()))
			var_term = get_term(rt.get_property(var_term, 'parent'), object_type, rt.new_null(), '')
		}
	} else if rt.is_true(rt.identical(rt.new_string('post_type'),
		rt.new_string(var_resource_type.str())))
	{
		var_ancestors = rt.call_function('get_post_ancestors', [
			rt.new_int(var_object_id),
		])
	}
	return rt.call_function('apply_filters', [rt.new_string('get_ancestors'),
		var_ancestors.clone(), rt.new_int(var_object_id), rt.new_string(object_type),
		rt.new_string(var_resource_type.str())])
}

fn wp_get_term_taxonomy_parent_id(var_term_id rt.PhpVal, var_taxonomy rt.PhpVal) rt.PhpVal {
	mut var_term := rt.new_null()
	var_term = get_term(var_term_id.clone(), var_taxonomy.clone(), rt.new_null(), '')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_term))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
		return rt.new_bool(false)
	}
	return rt.new_int((rt.get_property(var_term, 'parent')).to_i64())
}

fn wp_check_term_hierarchy_for_loops(var_parent_term rt.PhpVal, var_term_id rt.PhpVal, var_taxonomy rt.PhpVal) i64 {
	mut var_loop := rt.new_null()
	mut var_loop_member := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_parent_term)))) {
		return 0
	}
	if rt.is_true(rt.identical(var_parent_term, var_term_id)) {
		return 0
	}
	var_loop = rt.call_function('wp_find_hierarchy_loop', [
		rt.new_string('wp_get_term_taxonomy_parent_id'),
		var_term_id.clone(),
		var_parent_term.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: var_taxonomy }]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_loop)))) {
		return var_parent_term.to_i64()
	}
	if var_loop.array_isset(var_term_id) {
		return 0
	}
	mut iter_54 := rt.func_array_keys(var_loop.clone()).iterator()
	for {
		item_54 := iter_54.next() or { break }
		mut var_loop_member_shadow := item_54.val
		wp_update_term(var_loop_member_shadow.clone(), var_taxonomy.clone(), rt.create_array([
			rt.ArrayItem{ key: 'parent', val: 0 },
		]))
	}
	return var_parent_term.to_i64()
}

fn is_taxonomy_viewable(var_taxonomy_arg rt.PhpVal) bool {
	mut var_taxonomy := var_taxonomy_arg
	if rt.is_true(rt.call_function('is_scalar', [rt.new_bool(var_taxonomy).clone()])) {
		var_taxonomy = get_taxonomy(var_taxonomy)
		if !var_taxonomy {
			return false
		}
	}
	return (rt.get_property(rt.new_bool(var_taxonomy), 'publicly_queryable')).to_bool()
}

fn is_term_publicly_viewable(var_term_arg rt.PhpVal) bool {
	mut var_term := var_term_arg
	var_term = get_term(var_term.clone(), '', rt.new_null(), '')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_term)))) {
		return false
	}
	return is_taxonomy_viewable(rt.get_property(var_term, 'taxonomy'))
}

fn wp_cache_set_terms_last_changed() {
	rt.call_function('wp_cache_set_last_changed', [rt.new_string('terms')])
}

fn wp_check_term_meta_support_prefilter(var_check rt.PhpVal) bool {
	if rt.is_true(rt.less(rt.call_function('get_option', [rt.new_string('db_version')]),
		rt.new_int(34370)))
	{
		return false
	}
	return var_check.to_bool()
}

struct Class_WP_Taxonomy {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Tax_Query {
	rt.PhpObjectBase
}

struct Class_WP_Term {
	rt.PhpObjectBase
}

struct Class_WP_Term_Query {
	rt.PhpObjectBase
}

fn create_wp_taxonomy(_args ...rt.PhpVal) &Class_WP_Taxonomy {
	mut obj := &Class_WP_Taxonomy{
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

fn create_wp_tax_query(_args ...rt.PhpVal) &Class_WP_Tax_Query {
	mut obj := &Class_WP_Tax_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_term(_args ...rt.PhpVal) &Class_WP_Term {
	mut obj := &Class_WP_Term{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_term_query(_args ...rt.PhpVal) &Class_WP_Term_Query {
	mut obj := &Class_WP_Term_Query{
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

fn (mut this Class_WP_Tax_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Tax_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Tax_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Term) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Term) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Term) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Term_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Term_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Term_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
