import rt

struct Class_WC_Post_Types {
	rt.PhpObjectBase
}

fn Class_WC_Post_Types.init() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'register_taxonomies' }]),
		rt.new_int(5)])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'register_post_types' }]),
		rt.new_int(5)])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'register_post_status' }]),
		rt.new_int(9)])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'support_jetpack_omnisearch' }])])
	rt.call_function('add_filter', [rt.new_string('term_updated_messages'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'updated_term_messages' }])])
	rt.call_function('add_filter', [rt.new_string('rest_api_allowed_post_types'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'rest_api_allowed_post_types' }])])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_after_register_post_type'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'maybe_flush_rewrite_rules' }]),
	])
	rt.call_function('add_action', [rt.new_string('woocommerce_flush_rewrite_rules'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'flush_rewrite_rules' }])])
	rt.call_function('add_filter', [rt.new_string('gutenberg_can_edit_post_type'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'gutenberg_can_edit_post_type' }]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('use_block_editor_for_post_type'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'gutenberg_can_edit_post_type' }]),
		rt.new_int(10), rt.new_int(2)])
}

fn Class_WC_Post_Types.register_taxonomies() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_blog_installed', []rt.PhpVal{}))))) {
		return
	}
	if rt.is_true(rt.call_function('taxonomy_exists', [rt.new_string('product_type')])) {
		return
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_register_taxonomy')])
	mut var_permalinks := rt.call_function('wc_get_permalink_structure', []rt.PhpVal{})
	rt.call_function('register_taxonomy', [rt.new_string('product_type'),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_taxonomy_objects_product_type'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'product' }]),
		]),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_taxonomy_args_product_type'),
			rt.create_array([rt.ArrayItem{ key: 'hierarchical', val: false },
				rt.ArrayItem{ key: 'show_ui', val: false }, rt.ArrayItem{
					key: 'show_in_nav_menus'
					val: false
				}, rt.ArrayItem{ key: 'query_var', val: rt.call_function('is_admin', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'rewrite', val: false }, rt.ArrayItem{ key: 'public', val: false },
				rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
					rt.new_string('Product type'),
					rt.new_string('Taxonomy name'),
					rt.new_string('woocommerce'),
				]) }]),
		])])
	rt.call_function('register_taxonomy', [rt.new_string('product_visibility'),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_taxonomy_objects_product_visibility'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'product' },
				rt.ArrayItem{ key: none, val: 'product_variation' }]),
		]),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_taxonomy_args_product_visibility'),
			rt.create_array([rt.ArrayItem{ key: 'hierarchical', val: false },
				rt.ArrayItem{ key: 'show_ui', val: false }, rt.ArrayItem{
					key: 'show_in_nav_menus'
					val: false
				}, rt.ArrayItem{ key: 'query_var', val: rt.call_function('is_admin', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'rewrite', val: false }, rt.ArrayItem{ key: 'public', val: false },
				rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
					rt.new_string('Product visibility'),
					rt.new_string('Taxonomy name'),
					rt.new_string('woocommerce'),
				]) }]),
		])])
	rt.call_function('register_taxonomy', [rt.new_string('product_cat'),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_taxonomy_objects_product_cat'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'product' }]),
		]),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_taxonomy_args_product_cat'),
			rt.create_array([rt.ArrayItem{ key: 'hierarchical', val: true },
				rt.ArrayItem{ key: 'update_count_callback', val: '_wc_term_recount' },
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Categories'),
					rt.new_string('woocommerce'),
				]) }, rt.ArrayItem{ key: 'labels', val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
						rt.new_string('Product categories'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'singular_name', val: rt.call_function('__', [
						rt.new_string('Category'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'menu_name', val: rt.call_function('_x', [
						rt.new_string('Categories'),
						rt.new_string('Admin menu name'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'search_items', val: rt.call_function('__', [
						rt.new_string('Search categories'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'all_items', val: rt.call_function('__', [
						rt.new_string('All categories'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'parent_item', val: rt.call_function('__', [
						rt.new_string('Parent category'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'parent_item_colon', val: rt.call_function('__', [
						rt.new_string('Parent category:'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'edit_item', val: rt.call_function('__', [
						rt.new_string('Edit category'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'update_item', val: rt.call_function('__', [
						rt.new_string('Update category'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'add_new_item', val: rt.call_function('__', [
						rt.new_string('Add new category'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'new_item_name', val: rt.call_function('__', [
						rt.new_string('New category name'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'not_found', val: rt.call_function('__', [
						rt.new_string('No categories found'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'item_link', val: rt.call_function('__', [
						rt.new_string('Product Category Link'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'item_link_description', val: rt.call_function('__', [
						rt.new_string('A link to a product category.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'template_name', val: rt.call_function('_x', [
						rt.new_string('Products by Category'),
						rt.new_string('Template name'),
						rt.new_string('woocommerce'),
					]) },
				]) }, rt.ArrayItem{ key: 'show_in_rest', val: true },
				rt.ArrayItem{ key: 'show_ui', val: true }, rt.ArrayItem{ key: 'query_var', val: true },
				rt.ArrayItem{ key: 'capabilities', val: rt.create_array([
					rt.ArrayItem{ key: 'manage_terms', val: 'manage_product_terms' },
					rt.ArrayItem{ key: 'edit_terms', val: 'edit_product_terms' },
					rt.ArrayItem{ key: 'delete_terms', val: 'delete_product_terms' },
					rt.ArrayItem{ key: 'assign_terms', val: 'assign_product_terms' },
				]) }, rt.ArrayItem{ key: 'rewrite', val: rt.create_array([
					rt.ArrayItem{
						key: 'slug'
						val: var_permalinks.array_get(rt.new_string('category_rewrite_slug'))
					},
					rt.ArrayItem{ key: 'with_front', val: false },
					rt.ArrayItem{ key: 'hierarchical', val: true },
				]) }]),
		])])
	rt.call_function('register_taxonomy', [rt.new_string('product_tag'),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_taxonomy_objects_product_tag'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'product' }]),
		]),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_taxonomy_args_product_tag'),
			rt.create_array([rt.ArrayItem{ key: 'hierarchical', val: false },
				rt.ArrayItem{ key: 'update_count_callback', val: '_wc_term_recount' },
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Product tags'),
					rt.new_string('woocommerce'),
				]) }, rt.ArrayItem{ key: 'labels', val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
						rt.new_string('Product tags'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'singular_name', val: rt.call_function('__', [
						rt.new_string('Tag'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'menu_name', val: rt.call_function('_x', [
						rt.new_string('Tags'),
						rt.new_string('Admin menu name'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'search_items', val: rt.call_function('__', [
						rt.new_string('Search tags'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'all_items', val: rt.call_function('__', [
						rt.new_string('All tags'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'edit_item', val: rt.call_function('__', [
						rt.new_string('Edit tag'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'update_item', val: rt.call_function('__', [
						rt.new_string('Update tag'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'add_new_item', val: rt.call_function('__', [
						rt.new_string('Add new tag'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'new_item_name', val: rt.call_function('__', [
						rt.new_string('New tag name'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'popular_items', val: rt.call_function('__', [
						rt.new_string('Popular tags'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'separate_items_with_commas', val: rt.call_function('__', [
						rt.new_string('Separate tags with commas'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'add_or_remove_items', val: rt.call_function('__', [
						rt.new_string('Add or remove tags'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'choose_from_most_used', val: rt.call_function('__', [
						rt.new_string('Choose from the most used tags'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'not_found', val: rt.call_function('__', [
						rt.new_string('No tags found'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'item_link', val: rt.call_function('__', [
						rt.new_string('Product Tag Link'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'item_link_description', val: rt.call_function('__', [
						rt.new_string('A link to a product tag.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'template_name', val: rt.call_function('_x', [
						rt.new_string('Products by Tag'),
						rt.new_string('Template name'),
						rt.new_string('woocommerce'),
					]) },
				]) }, rt.ArrayItem{ key: 'show_in_rest', val: true },
				rt.ArrayItem{ key: 'show_ui', val: true }, rt.ArrayItem{ key: 'query_var', val: true },
				rt.ArrayItem{ key: 'capabilities', val: rt.create_array([
					rt.ArrayItem{ key: 'manage_terms', val: 'manage_product_terms' },
					rt.ArrayItem{ key: 'edit_terms', val: 'edit_product_terms' },
					rt.ArrayItem{ key: 'delete_terms', val: 'delete_product_terms' },
					rt.ArrayItem{ key: 'assign_terms', val: 'assign_product_terms' },
				]) }, rt.ArrayItem{ key: 'rewrite', val: rt.create_array([
					rt.ArrayItem{
						key: 'slug'
						val: var_permalinks.array_get(rt.new_string('tag_rewrite_slug'))
					},
					rt.ArrayItem{ key: 'with_front', val: false },
				]) }]),
		])])
	rt.call_function('register_taxonomy', [rt.new_string('product_shipping_class'),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_taxonomy_objects_product_shipping_class'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'product' },
				rt.ArrayItem{ key: none, val: 'product_variation' }]),
		]),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_taxonomy_args_product_shipping_class'),
			rt.create_array([rt.ArrayItem{ key: 'hierarchical', val: false },
				rt.ArrayItem{ key: 'update_count_callback', val: '_update_post_term_count' },
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Shipping classes'),
					rt.new_string('woocommerce'),
				]) }, rt.ArrayItem{ key: 'labels', val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
						rt.new_string('Product shipping classes'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'singular_name', val: rt.call_function('__', [
						rt.new_string('Shipping class'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'menu_name', val: rt.call_function('_x', [
						rt.new_string('Shipping classes'),
						rt.new_string('Admin menu name'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'search_items', val: rt.call_function('__', [
						rt.new_string('Search shipping classes'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'all_items', val: rt.call_function('__', [
						rt.new_string('All shipping classes'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'parent_item', val: rt.call_function('__', [
						rt.new_string('Parent shipping class'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'parent_item_colon', val: rt.call_function('__', [
						rt.new_string('Parent shipping class:'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'edit_item', val: rt.call_function('__', [
						rt.new_string('Edit shipping class'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'update_item', val: rt.call_function('__', [
						rt.new_string('Update shipping class'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'add_new_item', val: rt.call_function('__', [
						rt.new_string('Add new shipping class'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'new_item_name', val: rt.call_function('__', [
						rt.new_string('New shipping class Name'),
						rt.new_string('woocommerce'),
					]) },
				]) }, rt.ArrayItem{ key: 'show_ui', val: false },
				rt.ArrayItem{ key: 'show_in_quick_edit', val: false },
				rt.ArrayItem{ key: 'show_in_nav_menus', val: false },
				rt.ArrayItem{ key: 'query_var', val: rt.call_function('is_admin', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'capabilities', val: rt.create_array([
					rt.ArrayItem{ key: 'manage_terms', val: 'manage_product_terms' },
					rt.ArrayItem{ key: 'edit_terms', val: 'edit_product_terms' },
					rt.ArrayItem{ key: 'delete_terms', val: 'delete_product_terms' },
					rt.ArrayItem{ key: 'assign_terms', val: 'assign_product_terms' },
				]) }, rt.ArrayItem{ key: 'rewrite', val: false }]),
		])])
	rt.call_function('register_taxonomy', [rt.new_string('pos_product_visibility'),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_taxonomy_objects_pos_product_visibility'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'product' },
				rt.ArrayItem{ key: none, val: 'product_variation' }]),
		]),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_taxonomy_args_pos_product_visibility'),
			rt.create_array([rt.ArrayItem{ key: 'hierarchical', val: false },
				rt.ArrayItem{ key: 'show_ui', val: false }, rt.ArrayItem{
					key: 'show_in_nav_menus'
					val: false
				}, rt.ArrayItem{ key: 'query_var', val: false },
				rt.ArrayItem{ key: 'rewrite', val: false }, rt.ArrayItem{ key: 'public', val: false },
				rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
					rt.new_string('POS Product visibility'),
					rt.new_string('Taxonomy name'),
					rt.new_string('woocommerce'),
				]) }]),
		])])
	mut var_wc_product_attributes := rt.get_superglobal('wc_product_attributes')
	var_wc_product_attributes = rt.new_array()
	mut var_attribute_taxonomies := rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{})
	if rt.is_true(var_attribute_taxonomies) {
		mut iter_1 := var_attribute_taxonomies.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tax := item_1.val
			mut var_name := rt.call_function('wc_attribute_taxonomy_name', [
				rt.get_property(var_tax, 'attribute_name'),
			])
			if rt.is_true(var_name) {
				rt.set_property(var_tax, 'attribute_public', rt.call_function('absint', [
					if !(rt.get_property(var_tax, 'attribute_public')).is_null() {
						rt.get_property(var_tax, 'attribute_public')
					} else {
						rt.new_int(1)
					},
				]))
				mut var_label := if !(!rt.is_true(rt.get_property(var_tax, 'attribute_label'))) {
					rt.get_property(var_tax, 'attribute_label')
				} else {
					rt.get_property(var_tax, 'attribute_name')
				}
				var_wc_product_attributes.array_set(var_name, var_tax.clone())
				mut var_taxonomy_data := {
					'hierarchical':          rt.new_bool(false)
					'update_count_callback': rt.new_string('_update_post_term_count')
					'labels':                {
						'name':              rt.call_function('sprintf', [
							rt.call_function('_x', [rt.new_string('Product %s'),
								rt.new_string('Product Attribute'),
								rt.new_string('woocommerce')]),
							var_label.clone(),
						])
						'singular_name':     var_label
						'search_items':      rt.call_function('sprintf', [
							rt.call_function('__', [rt.new_string('Search %s'),
								rt.new_string('woocommerce')]),
							var_label.clone(),
						])
						'all_items':         rt.call_function('sprintf', [
							rt.call_function('__', [rt.new_string('All %s'),
								rt.new_string('woocommerce')]),
							var_label.clone(),
						])
						'parent_item':       rt.call_function('sprintf', [
							rt.call_function('__', [rt.new_string('Parent %s'),
								rt.new_string('woocommerce')]),
							var_label.clone(),
						])
						'parent_item_colon': rt.call_function('sprintf', [
							rt.call_function('__', [rt.new_string('Parent %s:'),
								rt.new_string('woocommerce')]),
							var_label.clone(),
						])
						'edit_item':         rt.call_function('sprintf', [
							rt.call_function('__', [rt.new_string('Edit %s'),
								rt.new_string('woocommerce')]),
							var_label.clone(),
						])
						'update_item':       rt.call_function('sprintf', [
							rt.call_function('__', [rt.new_string('Update %s'),
								rt.new_string('woocommerce')]),
							var_label.clone(),
						])
						'add_new_item':      rt.call_function('sprintf', [
							rt.call_function('__', [rt.new_string('Add new %s'),
								rt.new_string('woocommerce')]),
							var_label.clone(),
						])
						'new_item_name':     rt.call_function('sprintf', [
							rt.call_function('__', [rt.new_string('New %s'),
								rt.new_string('woocommerce')]),
							var_label.clone(),
						])
						'not_found':         rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string('No &quot;%s&quot; found'),
								rt.new_string('woocommerce'),
							]),
							var_label.clone(),
						])
						'back_to_items':     rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string('&larr; Back to "%s" attributes'),
								rt.new_string('woocommerce'),
							]),
							var_label.clone(),
						])
					}
					'show_ui':               rt.new_bool(true)
					'show_in_quick_edit':    rt.new_bool(false)
					'show_in_menu':          rt.new_bool(false)
					'meta_box_cb':           rt.new_bool(false)
					'query_var':             rt.identical(rt.new_int(1), rt.get_property(var_tax,
						'attribute_public'))
					'rewrite':               rt.new_bool(false)
					'sort':                  rt.new_bool(false)
					'public':                rt.identical(rt.new_int(1), rt.get_property(var_tax,
						'attribute_public'))
					'show_in_nav_menus':     rt.new_bool(
						rt.is_true(rt.identical(rt.new_int(1), rt.get_property(var_tax, 'attribute_public')))
						&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_attribute_show_in_nav_menus'), rt.new_bool(false), var_name.clone()])))
					'capabilities':          {
						'manage_terms': rt.new_string('manage_product_terms')
						'edit_terms':   rt.new_string('edit_product_terms')
						'delete_terms': rt.new_string('delete_product_terms')
						'assign_terms': rt.new_string('assign_product_terms')
					}
				}
				if rt.is_true(rt.identical(rt.new_int(1), rt.get_property(var_tax, 'attribute_public')))
					&& rt.is_true(rt.call_function('sanitize_title', [rt.get_property(var_tax, 'attribute_name')])) {
					var_taxonomy_data['rewrite'] = rt.create_array([
						rt.ArrayItem{
							key: 'slug'
							val:
								(rt.call_function('trailingslashit', [var_permalinks.array_get(rt.new_string('attribute_rewrite_slug'))])).str() +(rt.call_function('urldecode', [rt.call_function('sanitize_title', [rt.get_property(var_tax, 'attribute_name')])])).str()
						},
						rt.ArrayItem{ key: 'with_front', val: false },
						rt.ArrayItem{ key: 'hierarchical', val: true },
					])
				}
				rt.call_function('register_taxonomy', [var_name.clone(),
					rt.call_function('apply_filters', [
						rt.new_string('woocommerce_taxonomy_objects_${var_name.to_string()}'),
						rt.create_array([rt.ArrayItem{ key: none, val: 'product' }]),
					]),
					rt.call_function('apply_filters', [
						rt.new_string('woocommerce_taxonomy_args_${var_name.to_string()}'),
						rt.create_array_from_native_map(var_taxonomy_data),
					])])
			}
		}
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_after_register_taxonomy')])
}

fn Class_WC_Post_Types.register_post_types() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_blog_installed', []rt.PhpVal{})))))
		|| rt.is_true(rt.call_function('post_type_exists', [rt.new_string('product')])) {
		return
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_register_post_type')])
	mut var_permalinks := rt.call_function('wc_get_permalink_structure', []rt.PhpVal{})
	mut var_supports := ['title', 'editor', 'excerpt', 'thumbnail', 'custom-fields', 'publicize',
		'wpcom-markdown']
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_enable_reviews'),
		rt.new_string('yes'),
	])))
	{
		var_supports << 'comments'
	}
	mut var_shop_page_id := rt.call_function('wc_get_page_id', [
		rt.new_string('shop')])
	if rt.is_true(rt.call_function('wc_current_theme_supports_woocommerce_or_fse', []rt.PhpVal{})) {
		mut var_has_archive := if rt.is_true(var_shop_page_id) && rt.is_true(rt.call_function('get_post', [var_shop_page_id.clone()])) { rt.call_function('urldecode', [
				rt.call_function('get_page_uri', [var_shop_page_id.clone()]),
			]) } else { rt.new_string('shop') }
	} else {
		var_has_archive = rt.new_bool(false)
	}
	if !(rt.is_true(rt.call_function('defined', [rt.new_string('WP_CLI')]))
		&& rt.is_true(rt.get_constant('WP_CLI')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_doing_cron', []rt.PhpVal{}))))) {
		mut var_theme_support := rt.new_string((if rt.is_true(rt.call_function('wc_current_theme_supports_woocommerce_or_fse',
			[]rt.PhpVal{}))
		{
			'yes'
		} else {
			'no'
		}).str())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('current_theme_supports_woocommerce')]), var_theme_support))))
			&& rt.is_true(rt.call_function('update_option', [rt.new_string('current_theme_supports_woocommerce'), var_theme_support.clone()])) {
			rt.call_function('update_option', [
				rt.new_string('woocommerce_queue_flush_rewrite_rules'),
				rt.new_string('yes'),
			])
		}
	}
	rt.call_function('register_post_type', [rt.new_string('product'),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_register_post_type_product'),
			rt.create_array([
				rt.ArrayItem{ key: 'labels', val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
						rt.new_string('Products'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'singular_name', val: rt.call_function('__', [
						rt.new_string('Product'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'all_items', val: rt.call_function('__', [
						rt.new_string('All Products'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'menu_name', val: rt.call_function('_x', [
						rt.new_string('Products'),
						rt.new_string('Admin menu name'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'add_new', val: rt.call_function('__', [
						rt.new_string('Add New'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'add_new_item', val: rt.call_function('__', [
						rt.new_string('Add new product'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'edit', val: rt.call_function('__', [
						rt.new_string('Edit'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'edit_item', val: rt.call_function('__', [
						rt.new_string('Edit product'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'new_item', val: rt.call_function('__', [
						rt.new_string('New product'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'view_item', val: rt.call_function('__', [
						rt.new_string('View product'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'view_items', val: rt.call_function('__', [
						rt.new_string('View products'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'search_items', val: rt.call_function('__', [
						rt.new_string('Search products'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'not_found', val: rt.call_function('__', [
						rt.new_string('No products found'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'not_found_in_trash', val: rt.call_function('__', [
						rt.new_string('No products found in trash'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'parent', val: rt.call_function('__', [
						rt.new_string('Parent product'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'featured_image', val: rt.call_function('__', [
						rt.new_string('Product image'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'set_featured_image', val: rt.call_function('__', [
						rt.new_string('Set product image'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'remove_featured_image', val: rt.call_function('__', [
						rt.new_string('Remove product image'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'use_featured_image', val: rt.call_function('__', [
						rt.new_string('Use as product image'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'insert_into_item', val: rt.call_function('__', [
						rt.new_string('Insert into product'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'uploaded_to_this_item', val: rt.call_function('__', [
						rt.new_string('Uploaded to this product'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'filter_items_list', val: rt.call_function('__', [
						rt.new_string('Filter products'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'items_list_navigation', val: rt.call_function('__', [
						rt.new_string('Products navigation'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'items_list', val: rt.call_function('__', [
						rt.new_string('Products list'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'item_link', val: rt.call_function('__', [
						rt.new_string('Product Link'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'item_link_description', val: rt.call_function('__', [
						rt.new_string('A link to a product.'),
						rt.new_string('woocommerce'),
					]) },
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('This is where you can browse products in this store.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'public', val: true },
				rt.ArrayItem{ key: 'show_ui', val: true },
				rt.ArrayItem{ key: 'menu_icon', val: 'dashicons-archive' },
				rt.ArrayItem{ key: 'capability_type', val: 'product' },
				rt.ArrayItem{ key: 'map_meta_cap', val: true },
				rt.ArrayItem{ key: 'publicly_queryable', val: true },
				rt.ArrayItem{ key: 'exclude_from_search', val: false },
				rt.ArrayItem{ key: 'hierarchical', val: false },
				rt.ArrayItem{
					key: 'rewrite'
					val: if rt.is_true(var_permalinks.array_get(rt.new_string('product_rewrite_slug'))) { rt.create_array([
							rt.ArrayItem{
								key: 'slug'
								val: var_permalinks.array_get(rt.new_string('product_rewrite_slug'))
							},
							rt.ArrayItem{ key: 'with_front', val: false },
							rt.ArrayItem{ key: 'feeds', val: true },
						]) } else { rt.new_bool(false) }
				},
				rt.ArrayItem{ key: 'query_var', val: true },
				rt.ArrayItem{ key: 'supports', val: var_supports },
				rt.ArrayItem{ key: 'has_archive', val: var_has_archive },
				rt.ArrayItem{ key: 'show_in_nav_menus', val: true },
				rt.ArrayItem{ key: 'show_in_rest', val: true },
			]),
		])])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_0 := iife_temp_0.is_enabled(rt.new_string('product-editor-template-system'))
	if rt.is_true(iife_result_0) {
		rt.call_function('register_post_type', [rt.new_string('product_form'),
			rt.call_function('apply_filters', [
				rt.new_string('woocommerce_register_post_type_product_form'),
				rt.create_array([
					rt.ArrayItem{ key: 'labels', val: rt.create_array([
						rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
							rt.new_string('Product Forms'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'singular_name', val: rt.call_function('__', [
							rt.new_string('Product Form'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'all_items', val: rt.call_function('__', [
							rt.new_string('All Product Form'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'menu_name', val: rt.call_function('_x', [
							rt.new_string('Product Forms'),
							rt.new_string('Admin menu name'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'add_new', val: rt.call_function('__', [
							rt.new_string('Add New'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'add_new_item', val: rt.call_function('__', [
							rt.new_string('Add new product form'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'edit', val: rt.call_function('__', [
							rt.new_string('Edit'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'edit_item', val: rt.call_function('__', [
							rt.new_string('Edit product form'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'new_item', val: rt.call_function('__', [
							rt.new_string('New product form'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'view_item', val: rt.call_function('__', [
							rt.new_string('View product form'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'view_items', val: rt.call_function('__', [
							rt.new_string('View product forms'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'search_items', val: rt.call_function('__', [
							rt.new_string('Search product forms'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'not_found', val: rt.call_function('__', [
							rt.new_string('No product forms found'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'not_found_in_trash', val: rt.call_function('__', [
							rt.new_string('No product forms found in trash'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'parent', val: rt.call_function('__', [
							rt.new_string('Parent product form'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'featured_image', val: rt.call_function('__', [
							rt.new_string('Product form image'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'set_featured_image', val: rt.call_function('__', [
							rt.new_string('Set product form image'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'remove_featured_image', val: rt.call_function('__', [
							rt.new_string('Remove product form image'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'use_featured_image', val: rt.call_function('__', [
							rt.new_string('Use as product form image'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'insert_into_item', val: rt.call_function('__', [
							rt.new_string('Insert into product form'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'uploaded_to_this_item', val: rt.call_function('__', [
							rt.new_string('Uploaded to this product form'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'filter_items_list', val: rt.call_function('__', [
							rt.new_string('Filter product forms'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'items_list_navigation', val: rt.call_function('__', [
							rt.new_string('Product forms navigation'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'items_list', val: rt.call_function('__', [
							rt.new_string('Product forms list'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'item_link', val: rt.call_function('__', [
							rt.new_string('Product form Link'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'item_link_description', val: rt.call_function('__', [
							rt.new_string('A link to a product form.'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('This is where you can set up product forms for various product types in your dashboard.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'public', val: true },
					rt.ArrayItem{ key: 'menu_icon', val: 'dashicons-forms' },
					rt.ArrayItem{ key: 'capability_type', val: 'product' },
					rt.ArrayItem{ key: 'map_meta_cap', val: true },
					rt.ArrayItem{ key: 'publicly_queryable', val: true },
					rt.ArrayItem{ key: 'hierarchical', val: false },
					rt.ArrayItem{
						key: 'rewrite'
						val: if rt.is_true(var_permalinks.array_get(rt.new_string('product_rewrite_slug'))) { rt.create_array([
								rt.ArrayItem{
									key: 'slug'
									val: var_permalinks.array_get(rt.new_string('product_rewrite_slug'))
								},
								rt.ArrayItem{ key: 'with_front', val: false },
								rt.ArrayItem{ key: 'feeds', val: true },
							]) } else { rt.new_bool(false) }
					},
					rt.ArrayItem{ key: 'query_var', val: true },
					rt.ArrayItem{ key: 'supports', val: var_supports },
					rt.ArrayItem{ key: 'has_archive', val: var_has_archive },
					rt.ArrayItem{ key: 'show_in_rest', val: true },
					rt.ArrayItem{ key: 'show_ui', val: true },
					rt.ArrayItem{ key: 'show_in_menu', val: true },
					rt.ArrayItem{ key: 'exclude_from_search', val: true },
					rt.ArrayItem{ key: 'show_in_nav_menus', val: false },
				]),
			])])
	}
	rt.call_function('register_post_type', [rt.new_string('product_variation'),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_register_post_type_product_variation'),
			rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Variations'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'public', val: false },
				rt.ArrayItem{ key: 'hierarchical', val: false },
				rt.ArrayItem{ key: 'supports', val: false },
				rt.ArrayItem{ key: 'capability_type', val: 'product' },
				rt.ArrayItem{ key: 'rewrite', val: false },
			]),
		])])
	rt.call_function('wc_register_order_type', [rt.new_string('shop_order'),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_register_post_type_shop_order'),
			rt.create_array([
				rt.ArrayItem{ key: 'labels', val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
						rt.new_string('Orders'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'singular_name', val: rt.call_function('_x', [
						rt.new_string('Order'),
						rt.new_string('shop_order post type singular name'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'add_new', val: rt.call_function('__', [
						rt.new_string('Add order'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'add_new_item', val: rt.call_function('__', [
						rt.new_string('Add new order'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'edit', val: rt.call_function('__', [
						rt.new_string('Edit'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'edit_item', val: rt.call_function('__', [
						rt.new_string('Edit order'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'new_item', val: rt.call_function('__', [
						rt.new_string('New order'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'view_item', val: rt.call_function('__', [
						rt.new_string('View order'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'search_items', val: rt.call_function('__', [
						rt.new_string('Search orders'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'not_found', val: rt.call_function('__', [
						rt.new_string('No orders found'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'not_found_in_trash', val: rt.call_function('__', [
						rt.new_string('No orders found in trash'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'parent', val: rt.call_function('__', [
						rt.new_string('Parent orders'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'menu_name', val: rt.call_function('_x', [
						rt.new_string('Orders'),
						rt.new_string('Admin menu name'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'filter_items_list', val: rt.call_function('__', [
						rt.new_string('Filter orders'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'items_list_navigation', val: rt.call_function('__', [
						rt.new_string('Orders navigation'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'items_list', val: rt.call_function('__', [
						rt.new_string('Orders list'),
						rt.new_string('woocommerce'),
					]) },
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('This is where store orders are stored.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'public', val: false },
				rt.ArrayItem{ key: 'show_ui', val: true },
				rt.ArrayItem{ key: 'capability_type', val: 'shop_order' },
				rt.ArrayItem{ key: 'map_meta_cap', val: true },
				rt.ArrayItem{ key: 'publicly_queryable', val: false },
				rt.ArrayItem{ key: 'exclude_from_search', val: true },
				rt.ArrayItem{
					key: 'show_in_menu'
					val: if rt.is_true(rt.call_function('current_user_can', [
						rt.new_string('edit_others_shop_orders'),
					]))
					{ rt.new_string('woocommerce') } else { rt.new_bool(true) }
				},
				rt.ArrayItem{ key: 'hierarchical', val: false },
				rt.ArrayItem{ key: 'show_in_nav_menus', val: false },
				rt.ArrayItem{ key: 'rewrite', val: false },
				rt.ArrayItem{ key: 'query_var', val: false },
				rt.ArrayItem{ key: 'supports', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'title' },
					rt.ArrayItem{ key: none, val: 'comments' },
					rt.ArrayItem{ key: none, val: 'custom-fields' },
				]) },
				rt.ArrayItem{ key: 'has_archive', val: false },
			]),
		])])
	rt.call_function('wc_register_order_type', [rt.new_string('shop_order_refund'),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_register_post_type_shop_order_refund'),
			rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Refunds'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'capability_type', val: 'shop_order' },
				rt.ArrayItem{ key: 'public', val: false },
				rt.ArrayItem{ key: 'hierarchical', val: false },
				rt.ArrayItem{ key: 'supports', val: false },
				rt.ArrayItem{ key: 'add_order_meta_boxes', val: false },
				rt.ArrayItem{ key: 'exclude_from_order_count', val: true },
				rt.ArrayItem{ key: 'exclude_from_order_views', val: false },
				rt.ArrayItem{ key: 'exclude_from_order_reports', val: false },
				rt.ArrayItem{ key: 'exclude_from_order_sales_reports', val: true },
				rt.ArrayItem{ key: 'class_name', val: 'WC_Order_Refund' },
				rt.ArrayItem{ key: 'rewrite', val: false },
			]),
		])])
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_enable_coupons'),
	])))
	{
		rt.call_function('register_post_type', [rt.new_string('shop_coupon'),
			rt.call_function('apply_filters', [
				rt.new_string('woocommerce_register_post_type_shop_coupon'),
				rt.create_array([
					rt.ArrayItem{ key: 'labels', val: rt.create_array([
						rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
							rt.new_string('Coupons'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'singular_name', val: rt.call_function('__', [
							rt.new_string('Coupon'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'menu_name', val: rt.call_function('_x', [
							rt.new_string('Coupons'),
							rt.new_string('Admin menu name'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'add_new', val: rt.call_function('__', [
							rt.new_string('Add coupon'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'add_new_item', val: rt.call_function('__', [
							rt.new_string('Add new coupon'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'edit', val: rt.call_function('__', [
							rt.new_string('Edit'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'edit_item', val: rt.call_function('__', [
							rt.new_string('Edit coupon'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'new_item', val: rt.call_function('__', [
							rt.new_string('New coupon'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'view_item', val: rt.call_function('__', [
							rt.new_string('View coupon'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'search_items', val: rt.call_function('__', [
							rt.new_string('Search coupons'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'not_found', val: rt.call_function('__', [
							rt.new_string('No coupons found'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'not_found_in_trash', val: rt.call_function('__', [
							rt.new_string('No coupons found in trash'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'parent', val: rt.call_function('__', [
							rt.new_string('Parent coupon'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'filter_items_list', val: rt.call_function('__', [
							rt.new_string('Filter coupons'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'items_list_navigation', val: rt.call_function('__', [
							rt.new_string('Coupons navigation'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'items_list', val: rt.call_function('__', [
							rt.new_string('Coupons list'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('This is where you can add new coupons that customers can use in your store.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'public', val: false },
					rt.ArrayItem{ key: 'show_ui', val: true },
					rt.ArrayItem{ key: 'capability_type', val: 'shop_coupon' },
					rt.ArrayItem{ key: 'map_meta_cap', val: true },
					rt.ArrayItem{ key: 'publicly_queryable', val: false },
					rt.ArrayItem{ key: 'exclude_from_search', val: true },
					rt.ArrayItem{
						key: 'show_in_menu'
						val: if rt.is_true(rt.call_function('current_user_can', [
							rt.new_string('edit_others_shop_orders'),
						]))
						{ rt.new_string('woocommerce') } else { rt.new_bool(true) }
					},
					rt.ArrayItem{ key: 'hierarchical', val: false },
					rt.ArrayItem{ key: 'rewrite', val: false },
					rt.ArrayItem{ key: 'query_var', val: false },
					rt.ArrayItem{ key: 'supports', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'title' },
					]) },
					rt.ArrayItem{ key: 'show_in_nav_menus', val: false },
					rt.ArrayItem{ key: 'show_in_admin_bar', val: true },
				]),
			])])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_after_register_post_type')])
}

fn Class_WC_Post_Types.updated_term_messages(var_messages rt.PhpVal) rt.PhpVal {
	mut var_messages_mutated := var_messages
	var_messages_mutated.array_set('product_cat', rt.create_array([
		rt.ArrayItem{ key: 0, val: '' },
		rt.ArrayItem{ key: 1, val: rt.call_function('__', [
			rt.new_string('Category added.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 2, val: rt.call_function('__', [
			rt.new_string('Category deleted.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 3, val: rt.call_function('__', [
			rt.new_string('Category updated.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 4, val: rt.call_function('__', [
			rt.new_string('Category not added.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 5, val: rt.call_function('__', [
			rt.new_string('Category not updated.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 6, val: rt.call_function('__', [
			rt.new_string('Categories deleted.'),
			rt.new_string('woocommerce'),
		]) },
	]))
	var_messages_mutated.array_set('product_tag', rt.create_array([
		rt.ArrayItem{ key: 0, val: '' },
		rt.ArrayItem{ key: 1, val: rt.call_function('__', [rt.new_string('Tag added.'),
			rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 2, val: rt.call_function('__', [rt.new_string('Tag deleted.'),
			rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 3, val: rt.call_function('__', [rt.new_string('Tag updated.'),
			rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 4, val: rt.call_function('__', [rt.new_string('Tag not added.'),
			rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 5, val: rt.call_function('__', [rt.new_string('Tag not updated.'),
			rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 6, val: rt.call_function('__', [rt.new_string('Tags deleted.'),
			rt.new_string('woocommerce')]) },
	]))
	mut var_wc_product_attributes := rt.new_array()
	mut var_attribute_taxonomies := rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{})
	if rt.is_true(var_attribute_taxonomies) {
		mut iter_2 := var_attribute_taxonomies.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_tax := item_2.val
			mut var_name := rt.call_function('wc_attribute_taxonomy_name', [
				rt.get_property(var_tax, 'attribute_name'),
			])
			if rt.is_true(var_name) {
				mut var_label := if !(!rt.is_true(rt.get_property(var_tax, 'attribute_label'))) {
					rt.get_property(var_tax, 'attribute_label')
				} else {
					rt.get_property(var_tax, 'attribute_name')
				}
				var_messages_mutated.array_set(var_name, rt.create_array([
					rt.ArrayItem{ key: 0, val: '' },
					rt.ArrayItem{ key: 1, val: rt.call_function('sprintf', [
						rt.call_function('_x', [rt.new_string('%s added'),
							rt.new_string('taxonomy term messages'),
							rt.new_string('woocommerce')]),
						var_label.clone(),
					]) },
					rt.ArrayItem{ key: 2, val: rt.call_function('sprintf', [
						rt.call_function('_x', [rt.new_string('%s deleted'),
							rt.new_string('taxonomy term messages'),
							rt.new_string('woocommerce')]),
						var_label.clone(),
					]) },
					rt.ArrayItem{ key: 3, val: rt.call_function('sprintf', [
						rt.call_function('_x', [rt.new_string('%s updated'),
							rt.new_string('taxonomy term messages'),
							rt.new_string('woocommerce')]),
						var_label.clone(),
					]) },
					rt.ArrayItem{ key: 4, val: rt.call_function('sprintf', [
						rt.call_function('_x', [rt.new_string('%s not added'),
							rt.new_string('taxonomy term messages'),
							rt.new_string('woocommerce')]),
						var_label.clone(),
					]) },
					rt.ArrayItem{ key: 5, val: rt.call_function('sprintf', [
						rt.call_function('_x', [rt.new_string('%s not updated'),
							rt.new_string('taxonomy term messages'),
							rt.new_string('woocommerce')]),
						var_label.clone(),
					]) },
					rt.ArrayItem{ key: 6, val: rt.call_function('sprintf', [
						rt.call_function('_x', [rt.new_string('%s deleted'),
							rt.new_string('taxonomy term messages'),
							rt.new_string('woocommerce')]),
						var_label.clone(),
					]) },
				]))
			}
		}
	}
	return var_messages_mutated.clone()
}

fn Class_WC_Post_Types.register_post_status() {
	mut var_order_statuses := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_register_shop_order_post_statuses'),
		rt.create_array([
			rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.pending(), val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
					rt.new_string('Pending payment'),
					rt.new_string('Order status'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'public', val: false },
				rt.ArrayItem{ key: 'exclude_from_search', val: false },
				rt.ArrayItem{ key: 'show_in_admin_all_list', val: true },
				rt.ArrayItem{ key: 'show_in_admin_status_list', val: true },
				rt.ArrayItem{ key: 'label_count', val: rt.call_function('_n_noop', [
					rt.new_string('Pending payment <span class="count">(%s)</span>'),
					rt.new_string('Pending payment <span class="count">(%s)</span>'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.processing(), val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
					rt.new_string('Processing'),
					rt.new_string('Order status'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'public', val: false },
				rt.ArrayItem{ key: 'exclude_from_search', val: false },
				rt.ArrayItem{ key: 'show_in_admin_all_list', val: true },
				rt.ArrayItem{ key: 'show_in_admin_status_list', val: true },
				rt.ArrayItem{ key: 'label_count', val: rt.call_function('_n_noop', [
					rt.new_string('Processing <span class="count">(%s)</span>'),
					rt.new_string('Processing <span class="count">(%s)</span>'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.on_hold(), val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
					rt.new_string('On hold'),
					rt.new_string('Order status'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'public', val: false },
				rt.ArrayItem{ key: 'exclude_from_search', val: false },
				rt.ArrayItem{ key: 'show_in_admin_all_list', val: true },
				rt.ArrayItem{ key: 'show_in_admin_status_list', val: true },
				rt.ArrayItem{ key: 'label_count', val: rt.call_function('_n_noop', [
					rt.new_string('On hold <span class="count">(%s)</span>'),
					rt.new_string('On hold <span class="count">(%s)</span>'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.completed(), val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
					rt.new_string('Completed'),
					rt.new_string('Order status'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'public', val: false },
				rt.ArrayItem{ key: 'exclude_from_search', val: false },
				rt.ArrayItem{ key: 'show_in_admin_all_list', val: true },
				rt.ArrayItem{ key: 'show_in_admin_status_list', val: true },
				rt.ArrayItem{ key: 'label_count', val: rt.call_function('_n_noop', [
					rt.new_string('Completed <span class="count">(%s)</span>'),
					rt.new_string('Completed <span class="count">(%s)</span>'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.cancelled(), val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
					rt.new_string('Cancelled'),
					rt.new_string('Order status'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'public', val: false },
				rt.ArrayItem{ key: 'exclude_from_search', val: false },
				rt.ArrayItem{ key: 'show_in_admin_all_list', val: true },
				rt.ArrayItem{ key: 'show_in_admin_status_list', val: true },
				rt.ArrayItem{ key: 'label_count', val: rt.call_function('_n_noop', [
					rt.new_string('Cancelled <span class="count">(%s)</span>'),
					rt.new_string('Cancelled <span class="count">(%s)</span>'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.refunded(), val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
					rt.new_string('Refunded'),
					rt.new_string('Order status'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'public', val: false },
				rt.ArrayItem{ key: 'exclude_from_search', val: false },
				rt.ArrayItem{ key: 'show_in_admin_all_list', val: true },
				rt.ArrayItem{ key: 'show_in_admin_status_list', val: true },
				rt.ArrayItem{ key: 'label_count', val: rt.call_function('_n_noop', [
					rt.new_string('Refunded <span class="count">(%s)</span>'),
					rt.new_string('Refunded <span class="count">(%s)</span>'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.failed(), val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
					rt.new_string('Failed'),
					rt.new_string('Order status'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'public', val: false },
				rt.ArrayItem{ key: 'exclude_from_search', val: false },
				rt.ArrayItem{ key: 'show_in_admin_all_list', val: true },
				rt.ArrayItem{ key: 'show_in_admin_status_list', val: true },
				rt.ArrayItem{ key: 'label_count', val: rt.call_function('_n_noop', [
					rt.new_string('Failed <span class="count">(%s)</span>'),
					rt.new_string('Failed <span class="count">(%s)</span>'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]),
	])
	mut iter_3 := var_order_statuses.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_values := item_3.val
		mut var_order_status := item_3.key
		rt.call_function('register_post_status', [var_order_status.clone(),
			var_values.clone()])
	}
}

fn Class_WC_Post_Types.maybe_flush_rewrite_rules() {
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_queue_flush_rewrite_rules'),
	])))
	{
		rt.call_function('update_option', [
			rt.new_string('woocommerce_queue_flush_rewrite_rules'),
			rt.new_string('no'),
		])
		Class_WC_Post_Types.flush_rewrite_rules()
	}
}

fn Class_WC_Post_Types.flush_rewrite_rules() {
	rt.call_function('flush_rewrite_rules', []rt.PhpVal{})
}

fn Class_WC_Post_Types.gutenberg_can_edit_post_type(var_can_edit rt.PhpVal, var_post_type rt.PhpVal) rt.PhpVal {
	return if rt.is_true(rt.identical(rt.new_string('product'), var_post_type)) {
		rt.new_bool(false)
	} else {
		var_can_edit
	}
}

fn Class_WC_Post_Types.support_jetpack_omnisearch() {
	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('Jetpack_Omnisearch_Posts'),
	]))
	{
		create_jetpack_omnisearch_posts(rt.new_string('product'))
	}
}

fn Class_WC_Post_Types.rest_api_allowed_post_types(var_post_types rt.PhpVal) rt.PhpVal {
	mut var_post_types_mutated := var_post_types
	var_post_types_mutated.array_push('product')
	return var_post_types_mutated.clone()
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Jetpack_Omnisearch_Posts {
	rt.PhpObjectBase
}

struct Class_WC_Post_types {
	rt.PhpObjectBase
}

fn create_wc_post_types(_args ...rt.PhpVal) &Class_WC_Post_Types {
	mut obj := &Class_WC_Post_Types{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_jetpack_omnisearch_posts(_args ...rt.PhpVal) &Class_Jetpack_Omnisearch_Posts {
	mut obj := &Class_Jetpack_Omnisearch_Posts{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_post_types(_args ...rt.PhpVal) &Class_WC_Post_types {
	mut obj := &Class_WC_Post_types{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Post_Types) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_Post_Types.init()
			return rt.new_null()
		}
		'register_taxonomies' {
			Class_WC_Post_Types.register_taxonomies()
			return rt.new_null()
		}
		'register_post_types' {
			Class_WC_Post_Types.register_post_types()
			return rt.new_null()
		}
		'updated_term_messages' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Post_Types.updated_term_messages(dispatch_arg_0)
		}
		'register_post_status' {
			Class_WC_Post_Types.register_post_status()
			return rt.new_null()
		}
		'maybe_flush_rewrite_rules' {
			Class_WC_Post_Types.maybe_flush_rewrite_rules()
			return rt.new_null()
		}
		'flush_rewrite_rules' {
			Class_WC_Post_Types.flush_rewrite_rules()
			return rt.new_null()
		}
		'gutenberg_can_edit_post_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Post_Types.gutenberg_can_edit_post_type(dispatch_arg_0, dispatch_arg_1)
		}
		'support_jetpack_omnisearch' {
			Class_WC_Post_Types.support_jetpack_omnisearch()
			return rt.new_null()
		}
		'rest_api_allowed_post_types' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Post_Types.rest_api_allowed_post_types(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Post_Types) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Post_Types) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Jetpack_Omnisearch_Posts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Jetpack_Omnisearch_Posts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Jetpack_Omnisearch_Posts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Post_types) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Post_types) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Post_types) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	Class_WC_Post_types.init()
}
