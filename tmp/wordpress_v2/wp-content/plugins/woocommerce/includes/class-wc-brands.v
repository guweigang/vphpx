import rt

struct Class_WC_Brands {
	rt.PhpObjectBase
pub mut:
	template_url rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Brands) construct() {
	this.template_url = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_template_url'),
		rt.new_string('woocommerce/'),
	])
	rt.call_function('add_action', [rt.new_string('plugins_loaded'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_hooks' },
		]),
		rt.new_int(11)])
	this.register_shortcodes()
}

fn (mut this Class_WC_Brands) register_hooks() {
	rt.call_function('add_action', [rt.new_string('woocommerce_register_taxonomy'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'init_taxonomy' }])])
	rt.call_function('add_action', [rt.new_string('widgets_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'init_widgets' },
		])])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))))) {
		rt.call_function('add_filter', [rt.new_string('template_include'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'template_loader' },
			])])
	}
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'styles' },
		])])
	rt.call_function('add_action', [rt.new_string('wp'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'body_class' },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_product_meta_end'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'show_brand' },
		])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_structured_data_product'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_structured_data' },
		]),
		rt.new_int(20)])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_product_duplicate_before_save'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'duplicate_store_temporary_brands' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [rt.new_string('woocommerce_new_product'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'duplicate_add_product_brand_terms' },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_new_product'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'invalidate_wc_layered_nav_counts_cache' },
		]),
		rt.new_int(10), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('woocommerce_update_product'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'invalidate_wc_layered_nav_counts_cache' },
		]),
		rt.new_int(10), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('transition_post_status'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'reset_layered_nav_counts_on_status_change' },
		]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('post_type_link'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'post_type_link' },
		]),
		rt.new_int(11), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_archive_description'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'brand_description' },
		])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_product_query_tax_query'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'update_product_query_tax_query' },
		]),
		rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('rest_api_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'rest_api_register_routes' },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_rest_insert_product'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'rest_api_maybe_set_brands' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_rest_prepare_product'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'rest_api_prepare_brands_to_product' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_rest_prepare_product_object'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'rest_api_prepare_brands_to_product' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [rt.new_string('woocommerce_rest_insert_product'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'rest_api_add_brands_to_product' },
		]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_rest_insert_product_object'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'rest_api_add_brands_to_product' },
		]),
		rt.new_int(10),
		rt.new_int(3),
	])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_rest_product_object_query'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'rest_api_filter_products_by_brand' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_filter', [rt.new_string('rest_product_collection_params'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'rest_api_product_collection_params' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_layered_nav_term_html'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'woocommerce_brands_update_layered_nav_link' },
		]),
		rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_product_set_stock_status'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'recount_after_stock_change' },
		]),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_update_options_products_inventory'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'recount_all_brands' },
		]),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_layout_template_after_instantiation'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'wc_brands_on_block_template_register' },
		]),
		rt.new_int(10),
		rt.new_int(3),
	])
	rt.call_function('add_filter', [rt.new_string('hooked_block_types'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'hook_product_brand_block' },
		]),
		rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_filter', [rt.new_string('hooked_block_core/post-terms'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'configure_product_brand_block' },
		]),
		rt.new_int(10), rt.new_int(5)])
}

fn (mut this Class_WC_Brands) recount_after_stock_change(var_product_id rt.PhpVal) {
	mut var_product_id_mutated := var_product_id
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_hide_out_of_stock_items')])))))
		|| !rt.is_true(var_product_id_mutated) {
		return
	}
	mut var_product_terms := rt.call_function('get_the_terms', [
		var_product_id_mutated.clone(), rt.new_string('product_brand')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product_terms)))) {
		return
	}
	if rt.is_true(rt.call_function('wp_defer_term_counting', []rt.PhpVal{})) {
		var_product_terms = rt.call_function('get_the_terms', [
			var_product_id_mutated.clone(), rt.new_string('product_brand')])
		if rt.is_true(rt.new_bool(var_product_terms.clone().is_array())) {
			rt.call_function('wp_update_term_count', [
				rt.call_function('array_column', [var_product_terms.clone(),
					rt.new_string('term_taxonomy_id')]),
				rt.new_string('product_brand'),
			])
		}
		return
	}
	mut var_product_brands := rt.new_array()
	mut iter_1 := var_product_terms.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_term := item_1.val
		var_product_brands.array_set(rt.get_property(var_term, 'term_id'), rt.get_property(var_term,
			'parent'))
	}
	rt.call_function('_wc_term_recount', [var_product_brands.clone(),
		rt.call_function('get_taxonomy', [rt.new_string('product_brand')]),
		rt.new_bool(false), rt.new_bool(false)])
}

fn (mut this Class_WC_Brands) recount_all_brands() {
	mut var_product_brands := rt.call_function('get_terms', [
		rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_brand' },
			rt.ArrayItem{ key: 'hide_empty', val: false }, rt.ArrayItem{
				key: 'fields'
				val: 'id=>parent'
			}]),
	])
	rt.call_function('_wc_term_recount', [var_product_brands.clone(),
		rt.call_function('get_taxonomy', [rt.new_string('product_brand')]),
		rt.new_bool(true), rt.new_bool(false)])
}

fn (mut this Class_WC_Brands) update_product_query_tax_query(mut var_tax_query Class_array) rt.PhpVal {
	mut var_tax_query_mutated := var_tax_query
	if rt.get_superglobal('_GET').array_isset(rt.new_string('filter_product_brand')) {
		mut var_filter_product_brand := rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_GET').array_get(rt.new_string('filter_product_brand')),
			]),
		])
		mut var_brands_filter := rt.call_function('array_filter', [
			rt.call_function('array_map', [rt.new_string('absint'),
				rt.call_function('explode', [rt.new_string(','),
					var_filter_product_brand.clone()])]),
		])
		if rt.is_true(var_brands_filter) {
			var_tax_query_mutated.array_push(rt.create_array([
				rt.ArrayItem{ key: 'taxonomy', val: 'product_brand' },
				rt.ArrayItem{ key: 'terms', val: var_brands_filter },
				rt.ArrayItem{ key: 'operator', val: 'IN' },
			]))
		}
	}
	return rt.new_object('array', []string{}, var_tax_query_mutated)
}

fn (mut this Class_WC_Brands) post_type_link(var_permalink rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_permalink_mutated := var_permalink
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product'), rt.get_property(var_post,
		'post_type')))))
	{
		return var_permalink_mutated.clone()
	}
	if !rt.is_true(var_permalink_mutated) {
		return var_permalink_mutated.clone()
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [
		var_permalink_mutated.clone(),
		rt.new_string('%'),
	])))
	{
		return var_permalink_mutated.clone()
	}
	mut var_terms := rt.call_function('get_the_terms', [rt.get_property(var_post, 'ID'),
		rt.new_string('product_brand')])
	mut var_product_brand := rt.call_function('_x', [rt.new_string('uncategorized'),
		rt.new_string('slug'), rt.new_string('woocommerce')])
	if var_terms.clone().is_array() && !(!rt.is_true(var_terms)) {
		mut var_first_term := rt.call_function('array_shift', [
			var_terms.clone()])
		if rt.is_true(rt.new_bool(rt.instance_of(var_first_term, 'WP_Term'))) {
			var_product_brand = rt.get_property(var_first_term, 'slug')
		}
	}
	mut var_find := [rt.new_string('%product_brand%')]
	mut var_replace := rt.create_array([
		rt.ArrayItem{ key: none, val: var_product_brand },
	])
	var_replace = rt.call_function('array_map', [rt.new_string('sanitize_title'),
		var_replace.clone()])
	var_permalink_mutated = rt.call_function('str_replace', [
		rt.create_array_from_list(var_find),
		var_replace.clone(),
		var_permalink_mutated.clone(),
	])
	return var_permalink_mutated.clone()
}

fn (mut this Class_WC_Brands) body_class() {
	if rt.is_true(rt.call_function('is_tax', [rt.new_string('product_brand')])) {
		rt.call_function('add_filter', [rt.new_string('body_class'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'add_body_class' },
			])])
	}
}

fn (mut this Class_WC_Brands) add_body_class(var_classes rt.PhpVal) rt.PhpVal {
	mut var_classes_mutated := var_classes
	var_classes_mutated.array_push('woocommerce')
	var_classes_mutated.array_push('woocommerce-page')
	return var_classes_mutated.clone()
}

fn (mut this Class_WC_Brands) styles() {
	if !(this.should_load_brands_styles()) {
		return
	}
	mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_0 := iife_temp_0.get_constant(rt.new_string('WC_VERSION'))
	mut var_version := iife_result_0
	rt.call_function('wp_enqueue_style', [rt.new_string('brands-styles'),
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
			'/assets/css/brands.css'),
		rt.new_array(), var_version.clone()])
}

fn (mut this Class_WC_Brands) should_load_brands_styles() bool {
	mut var_post := rt.new_null()
	if rt.is_true(rt.call_function('is_tax', [rt.new_string('product_brand')])) {
		return true
	}
	if rt.is_true(rt.call_function('is_singular', [rt.new_string('product')]))
		&& rt.is_true(rt.call_function('has_term', [rt.new_string(''), rt.new_string('product_brand')])) {
		return true
	}
	if rt.is_true(var_post) && !(!rt.is_true(rt.get_property(var_post, 'post_content'))) {
		mut var_brand_shortcodes := ['brand_products', 'product_brand', 'product_brand_list',
			'product_brand_thumbnails', 'product_brand_thumbnails_description']
		for var_shortcode in var_brand_shortcodes {
			if rt.is_true(rt.call_function('has_shortcode', [
				rt.get_property(var_post, 'post_content'),
				rt.new_string(shortcode),
			]))
			{
				return true
			}
		}
	}
	if rt.is_true(rt.call_function('is_active_widget', [rt.new_bool(false), rt.new_bool(false), rt.new_string('wc_brands_brand_description')]))
		|| rt.is_true(rt.call_function('is_active_widget', [rt.new_bool(false), rt.new_bool(false), rt.new_string('woocommerce_brand_nav')]))
		|| rt.is_true(rt.call_function('is_active_widget', [rt.new_bool(false), rt.new_bool(false), rt.new_string('wc_brands_brand_thumbnails')])) {
		return true
	}
	return (rt.call_function('apply_filters', [
		rt.new_string('woocommerce_should_load_brands_styles'),
		rt.new_bool(false),
	])).to_bool()
}

fn Class_WC_Brands.init_taxonomy() {
	mut var_slug := rt.call_function('get_option', [
		rt.new_string('woocommerce_brand_permalink'),
		rt.new_string(''),
	])
	if rt.is_true(rt.identical(rt.new_string(''), var_slug)) {
		var_slug = rt.call_function('__', [rt.new_string('brand'),
			rt.new_string('woocommerce')])
	}
	rt.call_function('register_taxonomy', [rt.new_string('product_brand'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'product' }]),
		rt.call_function('apply_filters', [rt.new_string('register_taxonomy_product_brand'),
			rt.create_array([rt.ArrayItem{ key: 'hierarchical', val: true },
				rt.ArrayItem{ key: 'update_count_callback', val: '_wc_term_recount' },
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Brands'),
					rt.new_string('woocommerce'),
				]) }, rt.ArrayItem{ key: 'labels', val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
						rt.new_string('Brands'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'singular_name', val: rt.call_function('__', [
						rt.new_string('Brand'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'template_name', val: rt.call_function('_x', [
						rt.new_string('Products by Brand'),
						rt.new_string('Template name'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'search_items', val: rt.call_function('__', [
						rt.new_string('Search Brands'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'all_items', val: rt.call_function('__', [
						rt.new_string('All Brands'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'parent_item', val: rt.call_function('__', [
						rt.new_string('Parent Brand'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'parent_item_colon', val: rt.call_function('__', [
						rt.new_string('Parent Brand:'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'edit_item', val: rt.call_function('__', [
						rt.new_string('Edit Brand'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'update_item', val: rt.call_function('__', [
						rt.new_string('Update Brand'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'add_new_item', val: rt.call_function('__', [
						rt.new_string('Add New Brand'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'new_item_name', val: rt.call_function('__', [
						rt.new_string('New Brand Name'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'not_found', val: rt.call_function('__', [
						rt.new_string('No Brands Found'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'no_terms', val: rt.call_function('__', [
						rt.new_string('No brands'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'back_to_items', val: rt.call_function('__', [
						rt.new_string('&larr; Go to Brands'),
						rt.new_string('woocommerce'),
					]) },
				]) }, rt.ArrayItem{ key: 'show_ui', val: true },
				rt.ArrayItem{ key: 'show_admin_column', val: true },
				rt.ArrayItem{ key: 'show_in_nav_menus', val: true },
				rt.ArrayItem{ key: 'show_in_rest', val: true },
				rt.ArrayItem{ key: 'capabilities', val: rt.create_array([
					rt.ArrayItem{ key: 'manage_terms', val: 'manage_product_terms' },
					rt.ArrayItem{ key: 'edit_terms', val: 'edit_product_terms' },
					rt.ArrayItem{ key: 'delete_terms', val: 'delete_product_terms' },
					rt.ArrayItem{ key: 'assign_terms', val: 'assign_product_terms' },
				]) }, rt.ArrayItem{ key: 'rewrite', val: rt.create_array([
					rt.ArrayItem{ key: 'slug', val: var_slug },
					rt.ArrayItem{ key: 'with_front', val: false },
					rt.ArrayItem{ key: 'hierarchical', val: true },
				]) }])])])
}

fn (mut this Class_WC_Brands) init_widgets() {
	rt.include_file(
		(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
		'/includes/widgets/class-wc-widget-brand-description.php', '4')
	rt.include_file(
		(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
		'/includes/widgets/class-wc-widget-brand-nav.php', '4')
	rt.include_file(
		(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
		'/includes/widgets/class-wc-widget-brand-thumbnails.php', '4')
	rt.call_function('register_widget', [rt.new_string('WC_Widget_Brand_Description')])
	rt.call_function('register_widget', [rt.new_string('WC_Widget_Brand_Nav')])
	rt.call_function('register_widget', [rt.new_string('WC_Widget_Brand_Thumbnails')])
}

fn (mut this Class_WC_Brands) template_loader(var_template rt.PhpVal) rt.PhpVal {
	mut var_template_mutated := var_template
	mut var_find := [rt.new_string('woocommerce.php')]
	mut var_file := rt.new_string('')
	if rt.is_true(rt.call_function('is_tax', [rt.new_string('product_brand')])) {
		mut var_term := rt.call_function('get_queried_object', []rt.PhpVal{})
		var_file = rt.new_string('taxonomy-' + (rt.get_property(var_term, 'taxonomy')).str() +
			'.php')
		var_find << 'taxonomy-' + (rt.get_property(var_term, 'taxonomy')).str() + '-' +
			(rt.get_property(var_term, 'slug')).str() + '.php'
		var_find <<
			(this.template_url).str() + 'taxonomy-' + (rt.get_property(var_term, 'taxonomy')).str() +
			'-' + (rt.get_property(var_term, 'slug')).str() + '.php'
		var_find << var_file.clone()
		var_find << (this.template_url).str() + var_file.str()
	}
	if rt.is_true(var_file) {
		var_template_mutated = rt.call_function('locate_template', [
			rt.create_array_from_list(var_find),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_template_mutated)))) {
			var_template_mutated = rt.new_string(
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
				'/templates/brands/' + var_file.str())
		}
	}
	return var_template_mutated.clone()
}

fn (mut this Class_WC_Brands) brand_description() {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('wc_brands_show_description'),
	])))))
	{
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_tax', [
		rt.new_string('product_brand'),
	])))))
	{
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_query_var', [
		rt.new_string('term'),
	])))))
	{
		return
	}
	mut var_thumbnail := rt.new_string('')
	mut var_term := rt.call_function('get_term_by', [rt.new_string('slug'),
		rt.call_function('get_query_var', [rt.new_string('term')]),
		rt.new_string('product_brand')])
	var_thumbnail = rt.call_function('wc_get_brand_thumbnail_url', [
		rt.get_property(var_term, 'term_id'),
		rt.new_string('full'),
	])
	rt.call_function('wc_get_template', [rt.new_string('brand-description.php'),
		rt.create_array([rt.ArrayItem{ key: 'thumbnail', val: var_thumbnail }]),
		rt.new_string('woocommerce'),
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
			'/templates/brands/')])
}

fn (mut this Class_WC_Brands) show_brand() {
	mut var_post := rt.new_null()
	if rt.is_true(rt.call_function('is_singular', [rt.new_string('product')])) {
		mut var_terms := rt.call_function('get_the_terms', [
			rt.get_property(var_post, 'ID'),
			rt.new_string('product_brand'),
		])
		mut var_brand_count := rt.new_int(if var_terms.clone().is_array() {
			var_terms.clone().array_count()
		} else {
			0
		})
		mut var_taxonomy := rt.call_function('get_taxonomy', [
			rt.new_string('product_brand'),
		])
		mut var_labels := rt.get_property(var_taxonomy, 'labels')
		mut var_brand_output := rt.call_function('wc_get_brands', [
			rt.get_property(var_post, 'ID'),
			rt.new_string(', '),
			rt.new_string(' <span class="posted_in">' +(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%s: '), rt.new_string('%s: '), var_brand_count.clone(), rt.new_string('woocommerce')]), rt.get_property(var_labels, 'singular_name'), rt.get_property(var_labels, 'name')])).str()),
			rt.new_string('</span>'),
		])
		rt.echo_val(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_product_brands_output'),
			var_brand_output.clone(),
			var_terms.clone(),
			rt.get_property(var_post, 'ID'),
		]))
	}
}

fn (mut this Class_WC_Brands) add_structured_data(var_markup rt.PhpVal) rt.PhpVal {
	mut var_post := rt.new_null()
	mut var_markup_mutated := var_markup
	if !(var_markup_mutated.clone().is_array()) {
		var_markup_mutated = rt.new_array()
	}
	if rt.is_true(rt.new_bool(var_markup_mutated.clone().array_isset(rt.new_string('brand')))) {
		return var_markup_mutated.clone()
	}
	mut var_brands := rt.call_function('get_the_terms', [rt.get_property(var_post, 'ID'),
		rt.new_string('product_brand')])
	if !(!rt.is_true(var_brands)) && var_brands.clone().is_array() {
		mut var_brand_thumbnail := rt.call_function('wc_get_brand_thumbnail_url', [
			rt.get_property(var_brands.array_get(rt.new_int(0)), 'term_id'),
			rt.new_string('full'),
		])
		var_markup_mutated.array_set('brand', rt.create_array([
			rt.ArrayItem{ key: '@type', val: 'Brand' },
			rt.ArrayItem{ key: 'name', val: rt.get_property(var_brands.array_get(rt.new_int(0)),
				'name') },
		]))
		if rt.is_true(var_brand_thumbnail) {
			var_markup_mutated.array_get_mut('brand').array_set('logo', var_brand_thumbnail.clone())
		}
	}
	return var_markup_mutated.clone()
}

fn (mut this Class_WC_Brands) register_shortcodes() {
	rt.call_function('add_shortcode', [rt.new_string('product_brand'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'output_product_brand' },
		])])
	rt.call_function('add_shortcode', [rt.new_string('product_brand_thumbnails'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'output_product_brand_thumbnails' },
		])])
	rt.call_function('add_shortcode', [
		rt.new_string('product_brand_thumbnails_description'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'output_product_brand_thumbnails_description' },
		]),
	])
	rt.call_function('add_shortcode', [rt.new_string('product_brand_list'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'output_product_brand_list' },
		])])
	rt.call_function('add_shortcode', [rt.new_string('brand_products'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'output_brand_products' },
		])])
}

fn (mut this Class_WC_Brands) output_product_brand(var_atts rt.PhpVal) string {
	mut var_post := rt.new_null()
	mut var_args := rt.call_function('shortcode_atts', [
		rt.create_array([rt.ArrayItem{ key: 'width', val: '' },
			rt.ArrayItem{ key: 'height', val: '' }, rt.ArrayItem{ key: 'class', val: 'aligncenter' },
			rt.ArrayItem{ key: 'post_id', val: '' }]),
		var_atts.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_args.array_get(rt.new_string('post_id'))))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return ''
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_args.array_get(rt.new_string('post_id')))))) {
		var_args.array_set('post_id', rt.get_property(var_post, 'ID'))
	}
	mut var_brands := rt.call_function('wp_get_post_terms', [
		var_args.array_get(rt.new_string('post_id')),
		rt.new_string('product_brand'),
		rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' }]),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_brands.clone()])) {
		return ''
	}
	if 0 == var_brands.clone().array_count() {
		return ''
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	mut iter_2 := var_brands.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_brand := item_2.val
		mut var_thumbnail := rt.call_function('wc_get_brand_thumbnail_url', [
			var_brand.clone()])
		if !rt.is_true(var_thumbnail) {
			continue
		}
		var_args.array_set('thumbnail', var_thumbnail.clone())
		var_args.array_set('term', rt.call_function('get_term_by', [
			rt.new_string('id'), var_brand.clone(), rt.new_string('product_brand')]))
		if rt.is_true(var_args.array_get(rt.new_string('width')))
			|| rt.is_true(var_args.array_get(rt.new_string('height'))) {
			var_args.array_set('width', if !(!rt.is_true(var_args.array_get(rt.new_string('width')))) {
				var_args.array_get(rt.new_string('width'))
			} else {
				rt.new_string('auto')
			})
			var_args.array_set('height', if !(!rt.is_true(var_args.array_get(rt.new_string('height')))) {
				var_args.array_get(rt.new_string('height'))
			} else {
				rt.new_string('auto')
			})
		}
		rt.call_function('wc_get_template', [
			rt.new_string('shortcodes/single-brand.php'),
			var_args.clone(),
			rt.new_string('woocommerce'),
			rt.new_string(
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
				'/templates/brands/'),
		])
	}
	return (rt.call_function('ob_get_clean', []rt.PhpVal{})).str()
}

fn (mut this Class_WC_Brands) output_product_brand_list(var_atts rt.PhpVal) rt.PhpVal {
	mut var_args := rt.call_function('shortcode_atts', [
		rt.create_array([rt.ArrayItem{ key: 'show_top_links', val: true },
			rt.ArrayItem{ key: 'show_empty', val: true }, rt.ArrayItem{
				key: 'show_empty_brands'
				val: false
			}]),
		var_atts.clone(),
	])
	mut var_show_top_links := var_args.array_get(rt.new_string('show_top_links'))
	mut var_show_empty := var_args.array_get(rt.new_string('show_empty'))
	mut var_show_empty_brands := var_args.array_get(rt.new_string('show_empty_brands'))
	if rt.is_true(rt.identical(rt.new_string('false'), var_show_top_links)) {
		var_show_top_links = rt.new_bool(false)
	}
	if rt.is_true(rt.identical(rt.new_string('false'), var_show_empty)) {
		var_show_empty = rt.new_bool(false)
	}
	if rt.is_true(rt.identical(rt.new_string('false'), var_show_empty_brands)) {
		var_show_empty_brands = rt.new_bool(false)
	}
	mut var_product_brands := rt.new_array()
	mut var_terms := rt.call_function('get_terms', [
		rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_brand' },
			rt.ArrayItem{
				key: 'hide_empty'
				val: if rt.is_true(var_show_empty_brands) { false } else { true }
			}]),
	])
	mut var_alphabet := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_brands_list_alphabet'),
		rt.call_function('range', [rt.new_string('a'), rt.new_string('z')]),
	])
	mut var_numbers := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_brands_list_numbers'),
		rt.new_string('0-9'),
	])
	mut iter_3 := var_terms.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_term := item_3.val
		mut var_term_letter :=
			this.get_brand_name_first_character(rt.get_property(var_term, 'name'))
		if rt.is_true(rt.call_function('has_filter', [
			rt.new_string('woocommerce_brands_list_locale'),
		]))
		{
			rt.call_function('setLocale', [rt.get_constant('LC_CTYPE'),
				rt.call_function('apply_filters', [
					rt.new_string('woocommerce_brands_list_locale'),
					rt.new_string('en_US.UTF-8'),
				])])
		}
		if rt.is_true(rt.call_function('ctype_alpha', [var_term_letter.clone()])) {
			mut iter_4 := var_alphabet.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_i := item_4.val
				if rt.is_true(rt.equal(var_i, var_term_letter)) {
					var_product_brands.array_get_mut(var_i).array_push(var_term.clone())
					break
				}
			}
		} else {
			var_product_brands.array_get_mut(var_numbers).array_push(var_term.clone())
		}
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('wc_get_template', [rt.new_string('shortcodes/brands-a-z.php'),
		rt.create_array([rt.ArrayItem{ key: 'terms', val: var_terms },
			rt.ArrayItem{
				key: 'index'
				val: rt.call_function('array_merge', [var_alphabet.clone(),
					rt.create_array([
						rt.ArrayItem{ key: none, val: var_numbers },
					])])
			}, rt.ArrayItem{ key: 'product_brands', val: var_product_brands },
			rt.ArrayItem{ key: 'show_empty', val: var_show_empty },
			rt.ArrayItem{ key: 'show_top_links', val: var_show_top_links }]),
		rt.new_string('woocommerce'),
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
			'/templates/brands/')])
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_WC_Brands) get_brand_name_first_character(var_name rt.PhpVal) rt.PhpVal {
	mut var_clean_name := rt.new_string(rt.call_function('sanitize_title', [
		var_name.clone()]).to_string().to_lower())
	return rt.call_function('substr', [var_clean_name.clone(),
		rt.new_int(0), rt.new_int(1)])
}

fn (mut this Class_WC_Brands) output_product_brand_thumbnails(var_atts rt.PhpVal) rt.PhpVal {
	mut var_args := rt.call_function('shortcode_atts', [
		rt.create_array([rt.ArrayItem{ key: 'show_empty', val: true },
			rt.ArrayItem{ key: 'columns', val: 4 }, rt.ArrayItem{ key: 'hide_empty', val: 0 },
			rt.ArrayItem{ key: 'orderby', val: 'name' }, rt.ArrayItem{ key: 'exclude', val: '' },
			rt.ArrayItem{ key: 'number', val: '' }, rt.ArrayItem{ key: 'fluid_columns', val: false }]),
		var_atts.clone(),
	])
	mut var_exclude := rt.call_function('array_map', [rt.new_string('intval'),
		rt.call_function('explode',
			[rt.new_string(','), var_args.array_get(rt.new_string('exclude'))])])
	mut var_order := rt.new_string((if rt.is_true(rt.identical(rt.new_string('name'),
		var_args.array_get(rt.new_string('orderby'))))
	{
		'asc'
	} else {
		'desc'
	}).str())
	if rt.is_true(rt.identical(rt.new_string('true'),
		var_args.array_get(rt.new_string('show_empty'))))
	{
		mut var_hide_empty := rt.new_bool(false)
	} else {
		var_hide_empty = rt.new_bool(true)
	}
	mut var_brands := rt.call_function('get_terms', [rt.new_string('product_brand'),
		rt.create_array([rt.ArrayItem{ key: 'hide_empty', val: var_hide_empty },
			rt.ArrayItem{ key: 'orderby', val: var_args.array_get(rt.new_string('orderby')) },
			rt.ArrayItem{ key: 'exclude', val: var_exclude },
			rt.ArrayItem{ key: 'number', val: var_args.array_get(rt.new_string('number')) },
			rt.ArrayItem{ key: 'order', val: var_order }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_brands)))) {
		return rt.new_null()
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('wc_get_template', [rt.new_string('widgets/brand-thumbnails.php'),
		rt.create_array([rt.ArrayItem{ key: 'brands', val: var_brands },
			rt.ArrayItem{
				key: 'columns'
				val: if var_args.array_get(rt.new_string('columns')).is_long()
					|| var_args.array_get(rt.new_string('columns')).is_double() {
					var_args.array_get(rt.new_string('columns')).to_i64()
				} else {
					4
				}
			}, rt.ArrayItem{ key: 'fluid_columns', val: rt.call_function('wp_validate_boolean', [
				var_args.array_get(rt.new_string('fluid_columns')),
			]) }]),
		rt.new_string('woocommerce'),
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
			'/templates/brands/')])
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_WC_Brands) output_product_brand_thumbnails_description(var_atts rt.PhpVal) rt.PhpVal {
	mut var_args := rt.call_function('shortcode_atts', [
		rt.create_array([rt.ArrayItem{ key: 'show_empty', val: true },
			rt.ArrayItem{ key: 'columns', val: 1 }, rt.ArrayItem{ key: 'hide_empty', val: 0 },
			rt.ArrayItem{ key: 'orderby', val: 'name' }, rt.ArrayItem{ key: 'exclude', val: '' },
			rt.ArrayItem{ key: 'number', val: '' }]),
		var_atts.clone(),
	])
	mut var_exclude := rt.call_function('array_map', [rt.new_string('intval'),
		rt.call_function('explode',
			[rt.new_string(','), var_args.array_get(rt.new_string('exclude'))])])
	mut var_order := rt.new_string((if rt.is_true(rt.identical(rt.new_string('name'),
		var_args.array_get(rt.new_string('orderby'))))
	{
		'asc'
	} else {
		'desc'
	}).str())
	if rt.is_true(rt.identical(rt.new_string('true'),
		var_args.array_get(rt.new_string('show_empty'))))
	{
		mut var_hide_empty := rt.new_bool(false)
	} else {
		var_hide_empty = rt.new_bool(true)
	}
	mut var_brands := rt.call_function('get_terms', [rt.new_string('product_brand'),
		rt.create_array([rt.ArrayItem{ key: 'hide_empty', val: var_hide_empty },
			rt.ArrayItem{ key: 'orderby', val: var_args.array_get(rt.new_string('orderby')) },
			rt.ArrayItem{ key: 'exclude', val: var_exclude },
			rt.ArrayItem{ key: 'number', val: var_args.array_get(rt.new_string('number')) },
			rt.ArrayItem{ key: 'order', val: var_order }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_brands)))) {
		return rt.new_null()
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('wc_get_template', [
		rt.new_string('widgets/brand-thumbnails-description.php'),
		rt.create_array([rt.ArrayItem{ key: 'brands', val: var_brands },
			rt.ArrayItem{ key: 'columns', val: var_args.array_get(rt.new_string('columns')) }]),
		rt.new_string('woocommerce'),
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
			'/templates/brands/'),
	])
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_WC_Brands) output_brand_products(var_atts rt.PhpVal) string {
	if !rt.is_true(var_atts.array_get(rt.new_string('brand'))) {
		return ''
	}
	rt.call_function('add_filter', [rt.new_string('shortcode_atts_brand_products'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'add_brand_products_shortcode_atts' }]),
		rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_shortcode_products_query'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'get_brand_products_query_args' }]),
		rt.new_int(10),
		rt.new_int(3),
	])
	mut var_shortcode := create_wc_shortcode_products(var_atts.clone(),
		rt.new_string('brand_products'))
	rt.call_function('remove_filter', [rt.new_string('shortcode_atts_brand_products'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'add_brand_products_shortcode_atts' }]),
		rt.new_int(10)])
	rt.call_function('remove_filter', [
		rt.new_string('woocommerce_shortcode_products_query'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'get_brand_products_query_args' }]),
		rt.new_int(10),
	])
	return (var_shortcode.get_content()).str()
}

fn Class_WC_Brands.get_brand_products_query_args(var_query_args rt.PhpVal, var_attributes rt.PhpVal, var_type rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('brand_products'), var_type))))
		|| !rt.is_true(var_attributes.array_get(rt.new_string('brand'))) {
		return var_query_args.clone()
	}
	var_query_args.array_get_mut('tax_query').array_push(rt.create_array([
		rt.ArrayItem{ key: 'taxonomy', val: 'product_brand' },
		rt.ArrayItem{ key: 'terms', val: rt.call_function('array_map', [
			rt.new_string('sanitize_title'),
			rt.call_function('explode',
				[rt.new_string(','), var_attributes.array_get(rt.new_string('brand'))]),
		]) },
		rt.ArrayItem{ key: 'field', val: 'slug' },
		rt.ArrayItem{ key: 'operator', val: 'IN' },
	]))
	return var_query_args.clone()
}

fn Class_WC_Brands.add_brand_products_shortcode_atts(var_out rt.PhpVal, var_pairs rt.PhpVal, var_atts rt.PhpVal, var_shortcode rt.PhpVal) rt.PhpVal {
	mut var_out_mutated := var_out
	mut var_shortcode_mutated := var_shortcode
	var_out_mutated.array_set('brand', if rt.is_true(rt.new_bool(var_atts.clone().array_isset(rt.new_string('brand')))) {
		var_atts.array_get(rt.new_string('brand'))
	} else {
		rt.new_string('')
	})
	return var_out_mutated.clone()
}

fn (mut this Class_WC_Brands) rest_api_register_routes() {
	rt.include_file(
		(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
		'/includes/rest-api/Controllers/Version2/class-wc-rest-product-brands-v2-controller.php',
		'4')
	rt.include_file(
		(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
		'/includes/rest-api/Controllers/Version3/class-wc-rest-product-brands-controller.php', '4')
	mut var_controllers := ['WC_REST_Product_Brands_V2_Controller',
		'WC_REST_Product_Brands_Controller']
	for var_controller in var_controllers {
		rt.call_method(rt.create_object_dynamically(controller, []rt.PhpVal{}), 'register_routes',
			[]rt.PhpVal{})
	}
}

fn (mut this Class_WC_Brands) rest_api_maybe_set_brands(var_post rt.PhpVal, var_request rt.PhpVal) {
	if var_request.array_isset(rt.new_string('brands'))
		&& var_request.array_get(rt.new_string('brands')).is_array() {
		mut var_terms := rt.call_function('array_map', [rt.new_string('absint'),
			var_request.array_get(rt.new_string('brands'))])
		rt.call_function('wp_set_object_terms', [rt.get_property(var_post, 'ID'),
			var_terms.clone(), rt.new_string('product_brand')])
	}
}

fn (mut this Class_WC_Brands) rest_api_prepare_brands_to_product(var_response rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_post_id := if rt.call_function('is_callable', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_post },
			rt.ArrayItem{ key: none, val: 'get_id' }]),
	])
	{
		rt.call_method(var_post, 'get_id', []rt.PhpVal{})
	} else {
		if !(!rt.is_true(rt.get_property(var_post, 'ID'))) {
			rt.get_property(var_post, 'ID')
		} else {
			rt.new_null()
		}
	}
	if !rt.is_true(rt.get_property(var_response, 'data').array_get(rt.new_string('brands'))) {
		mut var_terms := rt.new_array()
		mut iter_5 := rt.call_function('wp_get_post_terms', [
			var_post_id.clone(), rt.new_string('product_brand')]).iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_term := item_5.val
			var_terms.array_push(rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.get_property(var_term, 'term_id') },
				rt.ArrayItem{ key: 'name', val: rt.get_property(var_term, 'name') },
				rt.ArrayItem{ key: 'slug', val: rt.get_property(var_term, 'slug') },
			]))
		}
		rt.get_property(var_response, 'data').array_set('brands', var_terms.clone())
	}
	return var_response.clone()
}

fn (mut this Class_WC_Brands) rest_api_add_brands_to_product(var_product rt.PhpVal, var_request rt.PhpVal, creating bool) {
	mut var_product_mutated := var_product
	mut var_product_id := if rt.call_function('is_callable', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_product_mutated },
			rt.ArrayItem{ key: none, val: 'get_id' }]),
	])
	{
		rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})
	} else {
		if !(!rt.is_true(rt.get_property(var_product_mutated, 'ID'))) {
			rt.get_property(var_product_mutated, 'ID')
		} else {
			rt.new_null()
		}
	}
	mut var_params := rt.call_method(var_request, 'get_params', []rt.PhpVal{})
	mut var_brands := if var_params.array_isset(rt.new_string('brands')) {
		var_params.array_get(rt.new_string('brands'))
	} else {
		rt.new_array()
	}
	if !(!rt.is_true(var_brands)) {
		if var_brands.array_get(rt.new_int(0)).is_array()
			&& rt.is_true(rt.new_bool(var_brands.array_get(rt.new_int(0)).array_isset(rt.new_string('id')))) {
			closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_brand := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return
			}
			closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_brand := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return
			}
			var_brands = rt.call_function('array_map', [rt.new_closure(closure_2_fn),
				var_brands.clone()])
		} else {
			var_brands = rt.call_function('array_map', [rt.new_string('absint'),
				var_brands.clone()])
		}
		rt.call_function('wp_set_object_terms', [var_product_id.clone(),
			var_brands.clone(), rt.new_string('product_brand')])
	}
}

fn (mut this Class_WC_Brands) rest_api_filter_products_by_brand(var_args rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if !(!rt.is_true(var_request.array_get(rt.new_string('brand')))) {
		var_args_mutated.array_get_mut('tax_query').array_push(rt.create_array([
			rt.ArrayItem{ key: 'taxonomy', val: 'product_brand' },
			rt.ArrayItem{ key: 'field', val: 'term_id' },
			rt.ArrayItem{ key: 'terms', val: var_request.array_get(rt.new_string('brand')) },
		]))
	}
	return var_args_mutated.clone()
}

fn (mut this Class_WC_Brands) rest_api_product_collection_params(var_params rt.PhpVal, var_post_type rt.PhpVal) rt.PhpVal {
	mut var_params_mutated := var_params
	var_params_mutated.array_set('brand', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to products assigned a specific brand ID.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	return var_params_mutated.clone()
}

fn (mut this Class_WC_Brands) woocommerce_brands_update_layered_nav_link(var_term_html rt.PhpVal, var_term rt.PhpVal, var_link rt.PhpVal, var_count rt.PhpVal) rt.PhpVal {
	mut var_term_html_mutated := var_term_html
	mut var_term_mutated := var_term
	mut var_link_mutated := var_link
	if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('filter_product_brand'))) {
		return var_term_html_mutated.clone()
	}
	mut var_filter_product_brand := rt.call_function('wc_clean', [
		rt.call_function('wp_unslash', [
			rt.get_superglobal('_GET').array_get(rt.new_string('filter_product_brand')),
		]),
	])
	mut var_current_attributes := rt.call_function('array_map', [
		rt.new_string('intval'),
		rt.call_function('explode', [
			rt.new_string(','), var_filter_product_brand.clone()])])
	mut var_current_values := if !(!rt.is_true(var_current_attributes)) {
		var_current_attributes
	} else {
		rt.new_array()
	}
	var_link_mutated = rt.call_function('add_query_arg', [
		rt.create_array([rt.ArrayItem{ key: 'filtering', val: '1' },
			rt.ArrayItem{ key: 'filter_product_brand', val: rt.call_function('implode', [
				rt.new_string(','),
				var_current_values.clone(),
			]) }]),
		rt.call_function('wp_specialchars_decode', [var_link_mutated.clone()]),
	])
	var_term_html_mutated = rt.new_string('<a rel="nofollow" href="' +
		(rt.call_function('esc_url', [var_link_mutated.clone()])).str() + '">' +
		(rt.call_function('esc_html', [rt.get_property(var_term_mutated, 'name')])).str() + '</a>')
	var_term_html_mutated = rt.concat(var_term_html_mutated, rt.new_string(' ' +
		(rt.call_function('apply_filters', [rt.new_string('woocommerce_layered_nav_count'), rt.new_string('<span class="count">(' + (rt.call_function('absint', [var_count.clone()])).str() +
		')</span>'), var_count.clone(), var_term_mutated.clone()])).str()))
	return var_term_html_mutated.clone()
}

fn (mut this Class_WC_Brands) duplicate_store_temporary_brands(var_duplicate rt.PhpVal, var_original rt.PhpVal) {
	mut var_terms := rt.call_function('get_the_terms', [
		rt.call_method(var_original, 'get_id', []rt.PhpVal{}),
		rt.new_string('product_brand'),
	])
	if !(var_terms.clone().is_array()) {
		return
	}
	mut var_ids := rt.new_array()
	mut iter_6 := var_terms.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_term := item_6.val
		var_ids << rt.get_property(var_term, 'term_id')
	}
	rt.call_method(var_duplicate, 'add_meta_data', [
		rt.new_string('duplicate_temp_brand_ids'),
		rt.create_array_from_list(var_ids),
	])
}

fn (mut this Class_WC_Brands) duplicate_add_product_brand_terms(var_product_id rt.PhpVal) {
	mut var_product_id_mutated := var_product_id
	mut var_product := rt.call_function('wc_get_product', [var_product_id_mutated.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product')))))) {
		return
	}
	mut var_term_ids := rt.call_method(var_product, 'get_meta', [
		rt.new_string('duplicate_temp_brand_ids'),
	])
	if !rt.is_true(var_term_ids) {
		return
	}
	mut var_term_taxonomy_ids := rt.call_function('wp_set_object_terms', [
		var_product_id_mutated.clone(), var_term_ids.clone(),
		rt.new_string('product_brand')])
	rt.call_method(var_product, 'delete_meta_data', [
		rt.new_string('duplicate_temp_brand_ids'),
	])
	rt.call_method(var_product, 'save', []rt.PhpVal{})
}

fn (mut this Class_WC_Brands) invalidate_wc_layered_nav_counts_cache() {
	mut var_taxonomy := rt.new_string('product_brand')
	rt.call_function('delete_transient', [
		rt.new_string('wc_layered_nav_counts_' +
			(rt.call_function('sanitize_title', [var_taxonomy.clone()])).str()),
	])
}

fn (mut this Class_WC_Brands) reset_layered_nav_counts_on_status_change(var_new_status rt.PhpVal, var_old_status rt.PhpVal, var_post rt.PhpVal) {
	if rt.is_true(rt.identical(rt.get_property(var_post, 'post_type'), rt.new_string('product')))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_old_status, var_new_status)))) {
		this.invalidate_wc_layered_nav_counts_cache()
	}
}

fn (mut this Class_WC_Brands) wc_brands_on_block_template_register(var_template_id rt.PhpVal, var_template_area rt.PhpVal, var_template rt.PhpVal) {
	mut var_template_mutated := var_template
	if rt.is_true(rt.identical(rt.new_string('simple-product'), rt.call_method(var_template_mutated,
		'get_id', []rt.PhpVal{})))
	{
		mut var_section := rt.call_method(var_template_mutated, 'get_section_by_id', [
			rt.new_string('product-catalog-section'),
		])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_section, rt.new_null())))) {
			rt.call_method(var_section, 'add_block', [
				rt.create_array([
					rt.ArrayItem{ key: 'id', val: 'woocommerce-brands-select' },
					rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-taxonomy-field' },
					rt.ArrayItem{ key: 'order', val: 15 },
					rt.ArrayItem{ key: 'attributes', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Brands'),
							rt.new_string('woocommerce-brands'),
						]) },
						rt.ArrayItem{ key: 'createTitle', val: rt.call_function('__', [
							rt.new_string('Create new brand'),
							rt.new_string('woocommerce-brands'),
						]) },
						rt.ArrayItem{ key: 'slug', val: 'product_brand' },
						rt.ArrayItem{ key: 'property', val: 'brands' },
					]) },
				]),
			])
		}
	}
}

fn (mut this Class_WC_Brands) hook_product_brand_block(var_hooked_block_types rt.PhpVal, var_relative_position rt.PhpVal, var_anchor_block_type rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_hooked_block_types_mutated := var_hooked_block_types
	if rt.is_true(rt.identical(rt.new_string('woocommerce/product-meta'), var_anchor_block_type))
		&& rt.is_true(rt.identical(rt.new_string('last_child'), var_relative_position))
		&& rt.is_true(rt.new_bool(rt.instance_of(var_context, 'WP_Block_Template')))
		&& rt.is_true(rt.identical(rt.new_string('single-product'), rt.get_property(var_context, 'slug'))) {
		rt.call_function('remove_action', [rt.new_string('woocommerce_product_meta_end'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'show_brand' },
			])])
		if !(this.template_already_has_brand_block(var_context.clone())) {
			var_hooked_block_types_mutated.array_push('core/post-terms')
		}
	}
	return var_hooked_block_types_mutated.clone()
}

fn (mut this Class_WC_Brands) template_already_has_brand_block(var_template rt.PhpVal) bool {
	mut var_template_mutated := var_template
	if rt.is_true(rt.new_bool(!(rt.is_true(var_template_mutated))))
		|| !rt.is_true(rt.get_property(var_template_mutated, 'content')) {
		return false
	}
	return rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
		rt.get_property(var_template_mutated, 'content'),
		rt.new_string('<!-- wp:post-terms {"term":"product_brand"'),
	]), rt.new_bool(false))))
}

fn (mut this Class_WC_Brands) configure_product_brand_block(var_parsed_hooked_block rt.PhpVal, var_hooked_block_type rt.PhpVal, var_relative_position rt.PhpVal, var_parsed_anchor_block rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_parsed_hooked_block_mutated := var_parsed_hooked_block
	if rt.is_true(rt.new_bool(var_parsed_hooked_block_mutated.clone().is_null())) {
		return var_parsed_hooked_block_mutated.clone()
	}
	if rt.is_true(rt.identical(rt.new_string('core/post-terms'), var_hooked_block_type))
		&& rt.is_true(rt.identical(rt.new_string('last_child'), var_relative_position))
		&& rt.is_true(rt.identical(rt.new_string('woocommerce/product-meta'), var_parsed_anchor_block.array_get(rt.new_string('blockName'))))
		&& !rt.is_true(var_parsed_anchor_block.array_get(rt.new_string('attrs'))) {
		var_parsed_hooked_block_mutated.array_set('attrs', rt.create_array([
			rt.ArrayItem{ key: 'term', val: 'product_brand' },
			rt.ArrayItem{ key: 'prefix', val: rt.call_function('__', [
				rt.new_string('Brands: '),
				rt.new_string('woocommerce'),
			]) },
		]))
	}
	return var_parsed_hooked_block_mutated.clone()
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_WC_Shortcode_Products {
	rt.PhpObjectBase
}

fn create_wc_brands() &Class_WC_Brands {
	mut obj := &Class_WC_Brands{
		PhpObjectBase: rt.PhpObjectBase{}
		template_url:  rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shortcode_products(_args ...rt.PhpVal) &Class_WC_Shortcode_Products {
	mut obj := &Class_WC_Shortcode_Products{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Brands) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'register_hooks' {
			this.register_hooks()
			return rt.new_null()
		}
		'recount_after_stock_change' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.recount_after_stock_change(dispatch_arg_0)
			return rt.new_null()
		}
		'recount_all_brands' {
			this.recount_all_brands()
			return rt.new_null()
		}
		'update_product_query_tax_query' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.update_product_query_tax_query(mut dispatch_arg_0)
		}
		'post_type_link' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.post_type_link(dispatch_arg_0, dispatch_arg_1)
		}
		'body_class' {
			this.body_class()
			return rt.new_null()
		}
		'add_body_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_body_class(dispatch_arg_0)
		}
		'styles' {
			this.styles()
			return rt.new_null()
		}
		'should_load_brands_styles' {
			return rt.new_bool(this.should_load_brands_styles())
		}
		'init_taxonomy' {
			Class_WC_Brands.init_taxonomy()
			return rt.new_null()
		}
		'init_widgets' {
			this.init_widgets()
			return rt.new_null()
		}
		'template_loader' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.template_loader(dispatch_arg_0)
		}
		'brand_description' {
			this.brand_description()
			return rt.new_null()
		}
		'show_brand' {
			this.show_brand()
			return rt.new_null()
		}
		'add_structured_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_structured_data(dispatch_arg_0)
		}
		'register_shortcodes' {
			this.register_shortcodes()
			return rt.new_null()
		}
		'output_product_brand' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.output_product_brand(dispatch_arg_0))
		}
		'output_product_brand_list' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.output_product_brand_list(dispatch_arg_0)
		}
		'get_brand_name_first_character' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_brand_name_first_character(dispatch_arg_0)
		}
		'output_product_brand_thumbnails' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.output_product_brand_thumbnails(dispatch_arg_0)
		}
		'output_product_brand_thumbnails_description' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.output_product_brand_thumbnails_description(dispatch_arg_0)
		}
		'output_brand_products' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.output_brand_products(dispatch_arg_0))
		}
		'get_brand_products_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WC_Brands.get_brand_products_query_args(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'add_brand_products_shortcode_atts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_WC_Brands.add_brand_products_shortcode_atts(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'rest_api_register_routes' {
			this.rest_api_register_routes()
			return rt.new_null()
		}
		'rest_api_maybe_set_brands' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.rest_api_maybe_set_brands(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'rest_api_prepare_brands_to_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.rest_api_prepare_brands_to_product(dispatch_arg_0, dispatch_arg_1)
		}
		'rest_api_add_brands_to_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.rest_api_add_brands_to_product(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'rest_api_filter_products_by_brand' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.rest_api_filter_products_by_brand(dispatch_arg_0, dispatch_arg_1)
		}
		'rest_api_product_collection_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.rest_api_product_collection_params(dispatch_arg_0, dispatch_arg_1)
		}
		'woocommerce_brands_update_layered_nav_link' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.woocommerce_brands_update_layered_nav_link(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3)
		}
		'duplicate_store_temporary_brands' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.duplicate_store_temporary_brands(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'duplicate_add_product_brand_terms' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.duplicate_add_product_brand_terms(dispatch_arg_0)
			return rt.new_null()
		}
		'invalidate_wc_layered_nav_counts_cache' {
			this.invalidate_wc_layered_nav_counts_cache()
			return rt.new_null()
		}
		'reset_layered_nav_counts_on_status_change' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.reset_layered_nav_counts_on_status_change(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
			return rt.new_null()
		}
		'wc_brands_on_block_template_register' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.wc_brands_on_block_template_register(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
			return rt.new_null()
		}
		'hook_product_brand_block' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.hook_product_brand_block(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
		}
		'template_already_has_brand_block' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.template_already_has_brand_block(dispatch_arg_0))
		}
		'configure_product_brand_block' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return this.configure_product_brand_block(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Brands) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'template_url' { return this.template_url }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Brands) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'template_url' {
			this.template_url = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Shortcode_Products) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shortcode_Products) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shortcode_Products) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('WC_Brands', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_brands()
		return rt.new_object('WC_Brands', []string{}, obj)
	})
	rt.register_class_factory('Automattic_Jetpack_Constants', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_jetpack_constants()
		return rt.new_object('Automattic_Jetpack_Constants', []string{}, obj)
	})
	rt.register_class_factory('WC_Shortcode_Products', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_shortcode_products()
		return rt.new_object('WC_Shortcode_Products', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_GLOBALS := rt.new_null()
	var_GLOBALS.array_set('WC_Brands', create_wc_brands())
}
