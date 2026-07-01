import rt

struct Class_WC_Brands {
	rt.PhpObjectBase
pub mut:
		template_url rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Brands) construct()  {
	this.template_url = rt.call_function('apply_filters', [rt.new_string('woocommerce_template_url'), rt.new_string('woocommerce/')])
	rt.call_function('add_action', [rt.new_string('plugins_loaded'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_hooks' }]), rt.new_int(11)])
	this.register_shortcodes()
}

fn (mut this Class_WC_Brands) register_hooks()  {
	rt.call_function('add_action', [rt.new_string('woocommerce_register_taxonomy'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'init_taxonomy' }])])
	rt.call_function('add_action', [rt.new_string('widgets_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'init_widgets' }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))))) {
		rt.call_function('add_filter', [rt.new_string('template_include'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'template_loader' }])])
	}
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'styles' }])])
	rt.call_function('add_action', [rt.new_string('wp'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'body_class' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_product_meta_end'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'show_brand' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_structured_data_product'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_structured_data' }]), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('woocommerce_product_duplicate_before_save'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'duplicate_store_temporary_brands' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_new_product'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'duplicate_add_product_brand_terms' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_new_product'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'invalidate_wc_layered_nav_counts_cache' }]), rt.new_int(10), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('woocommerce_update_product'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'invalidate_wc_layered_nav_counts_cache' }]), rt.new_int(10), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('transition_post_status'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'reset_layered_nav_counts_on_status_change' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('post_type_link'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'post_type_link' }]), rt.new_int(11), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_archive_description'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'brand_description' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_product_query_tax_query'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'update_product_query_tax_query' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('rest_api_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'rest_api_register_routes' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_rest_insert_product'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'rest_api_maybe_set_brands' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_rest_prepare_product'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'rest_api_prepare_brands_to_product' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_rest_prepare_product_object'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'rest_api_prepare_brands_to_product' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_rest_insert_product'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'rest_api_add_brands_to_product' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('woocommerce_rest_insert_product_object'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'rest_api_add_brands_to_product' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_rest_product_object_query'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'rest_api_filter_products_by_brand' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('rest_product_collection_params'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'rest_api_product_collection_params' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_layered_nav_term_html'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'woocommerce_brands_update_layered_nav_link' }]), rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('woocommerce_product_set_stock_status'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'recount_after_stock_change' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_update_options_products_inventory'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'recount_all_brands' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_layout_template_after_instantiation'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'wc_brands_on_block_template_register' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('hooked_block_types'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'hook_product_brand_block' }]), rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_filter', [rt.new_string('hooked_block_core/post-terms'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'configure_product_brand_block' }]), rt.new_int(10), rt.new_int(5)])
}

fn (mut this Class_WC_Brands) recount_after_stock_change(var_product_id rt.PhpVal)  {
	mut var_product_id_mutated := var_product_id
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || !rt.is_true(var_product_id_mutated))) {
		return rt.new_null()
	}
	mut var_product_terms := rt.call_function('get_the_terms', [var_product_id_mutated.dup(), rt.new_string('product_brand')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product_terms)))) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('wp_defer_term_counting', []rt.PhpVal{})) {
		var_product_terms = rt.call_function('get_the_terms', [var_product_id_mutated.dup(), rt.new_string('product_brand')])
		if rt.is_true(rt.new_bool(var_product_terms.dup().is_array())) {
			rt.call_function('wp_update_term_count', [rt.call_function('array_column', [var_product_terms.dup(), rt.new_string('term_taxonomy_id')]), rt.new_string('product_brand')])
		}
		return rt.new_null()
	}
	mut var_product_brands := rt.new_array()
	{
		mut iter_1 := var_product_terms.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_term := item_1.val
			var_product_brands.array_set(rt.get_property(var_term, 'term_id'), rt.get_property(var_term, 'parent'))
		}
	}
	rt.call_function('_wc_term_recount', [var_product_brands.dup(), rt.call_function('get_taxonomy', [rt.new_string('product_brand')]), rt.new_bool(false), rt.new_bool(false)])
}

fn (mut this Class_WC_Brands) recount_all_brands()  {
	mut var_product_brands := rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_brand' }, rt.ArrayItem{ key: 'hide_empty', val: false }, rt.ArrayItem{ key: 'fields', val: 'id=>parent' }])])
	rt.call_function('_wc_term_recount', [var_product_brands.dup(), rt.call_function('get_taxonomy', [rt.new_string('product_brand')]), rt.new_bool(true), rt.new_bool(false)])
}

fn (mut this Class_WC_Brands) update_product_query_tax_query(mut var_tax_query Class_array) rt.PhpVal {
	mut var_tax_query_mutated := var_tax_query
	if rt.get_superglobal('_GET').array_isset(rt.new_string('filter_product_brand')) {
		mut var_filter_product_brand := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('filter_product_brand')])])
		mut var_brands_filter := rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('absint'), rt.call_function('explode', [rt.new_string(','), var_filter_product_brand.dup()])])])
		if rt.is_true(var_brands_filter) {
			var_tax_query_mutated.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_brand' }, rt.ArrayItem{ key: 'terms', val: var_brands_filter }, rt.ArrayItem{ key: 'operator', val: 'IN' }]))
		}
	}
	return rt.new_object('array', []string{}, var_tax_query_mutated)
}

fn (mut this Class_WC_Brands) post_type_link(var_permalink rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_permalink_mutated := var_permalink
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_permalink_mutated.dup()
	}
	if !rt.is_true(var_permalink_mutated) {
		return var_permalink_mutated.dup()
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_permalink_mutated.dup(), rt.new_string('%')]))) {
		return var_permalink_mutated.dup()
	}
	mut var_terms := rt.call_function('get_the_terms', [rt.get_property(var_post, 'ID'), rt.new_string('product_brand')])
	mut var_product_brand := rt.call_function('_x', [rt.new_string('uncategorized'), rt.new_string('slug'), rt.new_string('woocommerce')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_terms.dup().is_array())) && !(!rt.is_true(var_terms)))) {
		mut var_first_term := rt.call_function('array_shift', [var_terms.dup()])
		if rt.is_true(rt.new_bool(rt.instance_of(var_first_term, 'WP_Term'))) {
			var_product_brand = rt.get_property(var_first_term, 'slug')
		}
	}
	mut var_find := [rt.new_string('%product_brand%')]
	mut var_replace := rt.create_array([rt.ArrayItem{ key: none, val: var_product_brand }])
	var_replace = rt.call_function('array_map', [rt.new_string('sanitize_title'), var_replace.dup()])
	var_permalink_mutated = rt.call_function('str_replace', [var_find.dup(), var_replace.dup(), var_permalink_mutated.dup()])
	return var_permalink_mutated.dup()
}

fn (mut this Class_WC_Brands) body_class()  {
	if rt.is_true(rt.call_function('is_tax', [rt.new_string('product_brand')])) {
		rt.call_function('add_filter', [rt.new_string('body_class'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_body_class' }])])
	}
}

fn (mut this Class_WC_Brands) add_body_class(var_classes rt.PhpVal) rt.PhpVal {
	mut var_classes_mutated := var_classes
	var_classes_mutated.array_push('woocommerce')
	var_classes_mutated.array_push('woocommerce-page')
	return var_classes_mutated.dup()
}

fn (mut this Class_WC_Brands) styles()  {
	if !(this.should_load_brands_styles()) {
		return rt.new_null()
	}
	mut var_version := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_VERSION'))
	rt.call_function('wp_enqueue_style', [rt.new_string('brands-styles'), (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/assets/css/brands.css', rt.new_array(), var_version.dup()])
}

fn (mut this Class_WC_Brands) should_load_brands_styles() bool {
	mut var_post := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.call_function('is_tax', [rt.new_string('product_brand')])) {
		return true
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_singular', [rt.new_string('product')])) && rt.is_true(rt.call_function('has_term', [rt.new_string(''), rt.new_string('product_brand')])))) {
		return true
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_post) && !(!rt.is_true(rt.get_property(var_post, 'post_content'))))) {
		mut var_brand_shortcodes := ['brand_products', 'product_brand', 'product_brand_list', 'product_brand_thumbnails', 'product_brand_thumbnails_description']
		for var_shortcode in var_brand_shortcodes {
			if rt.is_true(rt.call_function('has_shortcode', [rt.get_property(var_post, 'post_content'), rt.new_string(shortcode)])) {
				return true
			}
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_active_widget', [rt.new_bool(false), rt.new_bool(false), rt.new_string('wc_brands_brand_description')])) || rt.is_true(rt.call_function('is_active_widget', [rt.new_bool(false), rt.new_bool(false), rt.new_string('woocommerce_brand_nav')])))) || rt.is_true(rt.call_function('is_active_widget', [rt.new_bool(false), rt.new_bool(false), rt.new_string('wc_brands_brand_thumbnails')])))) {
		return true
	}
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_should_load_brands_styles'), rt.new_bool(false)])).to_bool()
}

fn Class_WC_Brands.init_taxonomy()  {
	mut var_slug := rt.call_function('get_option', [rt.new_string('woocommerce_brand_permalink'), rt.new_string('')])
	if rt.is_true(rt.identical(rt.new_string(''), var_slug)) {
		var_slug = rt.call_function('__', [rt.new_string('brand'), rt.new_string('woocommerce')])
	}
	rt.call_function('register_taxonomy', [rt.new_string('product_brand'), rt.create_array([rt.ArrayItem{ key: none, val: 'product' }]), rt.call_function('apply_filters', [rt.new_string('register_taxonomy_product_brand'), rt.create_array([rt.ArrayItem{ key: 'hierarchical', val: true }, rt.ArrayItem{ key: 'update_count_callback', val: '_wc_term_recount' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Brands'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'labels', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Brands'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'singular_name', val: rt.call_function('__', [rt.new_string('Brand'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'template_name', val: rt.call_function('_x', [rt.new_string('Products by Brand'), rt.new_string('Template name'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'search_items', val: rt.call_function('__', [rt.new_string('Search Brands'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'all_items', val: rt.call_function('__', [rt.new_string('All Brands'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'parent_item', val: rt.call_function('__', [rt.new_string('Parent Brand'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'parent_item_colon', val: rt.call_function('__', [rt.new_string('Parent Brand:'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'edit_item', val: rt.call_function('__', [rt.new_string('Edit Brand'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'update_item', val: rt.call_function('__', [rt.new_string('Update Brand'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'add_new_item', val: rt.call_function('__', [rt.new_string('Add New Brand'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'new_item_name', val: rt.call_function('__', [rt.new_string('New Brand Name'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'not_found', val: rt.call_function('__', [rt.new_string('No Brands Found'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'no_terms', val: rt.call_function('__', [rt.new_string('No brands'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'back_to_items', val: rt.call_function('__', [rt.new_string('&larr; Go to Brands'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'show_ui', val: true }, rt.ArrayItem{ key: 'show_admin_column', val: true }, rt.ArrayItem{ key: 'show_in_nav_menus', val: true }, rt.ArrayItem{ key: 'show_in_rest', val: true }, rt.ArrayItem{ key: 'capabilities', val: rt.create_array([rt.ArrayItem{ key: 'manage_terms', val: 'manage_product_terms' }, rt.ArrayItem{ key: 'edit_terms', val: 'edit_product_terms' }, rt.ArrayItem{ key: 'delete_terms', val: 'delete_product_terms' }, rt.ArrayItem{ key: 'assign_terms', val: 'assign_product_terms' }]) }, rt.ArrayItem{ key: 'rewrite', val: rt.create_array([rt.ArrayItem{ key: 'slug', val: var_slug }, rt.ArrayItem{ key: 'with_front', val: false }, rt.ArrayItem{ key: 'hierarchical', val: true }]) }])])])
}

fn (mut this Class_WC_Brands) init_widgets()  {
	rt.include_file((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + '/includes/widgets/class-wc-widget-brand-description.php', '4')
	rt.include_file((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + '/includes/widgets/class-wc-widget-brand-nav.php', '4')
	rt.include_file((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + '/includes/widgets/class-wc-widget-brand-thumbnails.php', '4')
	rt.call_function('register_widget', [rt.new_string('WC_Widget_Brand_Description')])
	rt.call_function('register_widget', [rt.new_string('WC_Widget_Brand_Nav')])
	rt.call_function('register_widget', [rt.new_string('WC_Widget_Brand_Thumbnails')])
}

fn (mut this Class_WC_Brands) template_loader(var_template rt.PhpVal) rt.PhpVal {
	mut var_template_mutated := var_template
	mut var_find := [rt.new_string('woocommerce.php')]
	mut var_file := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.call_function('is_tax', [rt.new_string('product_brand')])) {
		mut var_term := rt.call_function('get_queried_object', []rt.PhpVal{})
		var_file = rt.new_string('taxonomy-' + (rt.get_property(var_term, 'taxonomy')).str() + '.php')
		var_find << 'taxonomy-' + (rt.get_property(var_term, 'taxonomy')).str() + '-' + (rt.get_property(var_term, 'slug')).str() + '.php'
		var_find << ().str() +  + (rt.get_property(, 'taxonomy')).str() + '-' + (rt.get_property(var_term, 'slug')).str() + '.php'
		var_find << var_file.dup()
		var_find << rt.concat(this.template_url, var_file)
	}
	if rt.is_true(var_file) {
		var_template_mutated = rt.call_function('locate_template', [var_find.dup()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_template_mutated)))) {
			var_template_mutated = rt.new_string()
		}
	}
	return var_template_mutated.dup()
}

fn (mut this Class_WC_Brands) brand_description()  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	
}

fn (mut this Class_WC_Brands) show_brand()  {
	mut var_post := rt.new_null()
}

fn (mut this Class_WC_Brands) add_structured_data(var_markup rt.PhpVal) rt.PhpVal {
	mut var_post := rt.new_null()
	mut var_markup_mutated := var_markup
}

fn (mut this Class_WC_Brands) register_shortcodes()  {
}

fn (mut this Class_WC_Brands) output_product_brand(var_atts rt.PhpVal) string {
	mut var_post := rt.new_null()
}

fn (mut this Class_WC_Brands) output_product_brand_list(var_atts rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Brands) get_brand_name_first_character(var_name rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Brands) output_product_brand_thumbnails(var_atts rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Brands) output_product_brand_thumbnails_description(var_atts rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Brands) output_brand_products(var_atts rt.PhpVal) string {
}

fn Class_WC_Brands.get_brand_products_query_args(var_query_args rt.PhpVal, var_attributes rt.PhpVal, var_type rt.PhpVal) rt.PhpVal {
}

fn Class_WC_Brands.add_brand_products_shortcode_atts(var_out rt.PhpVal, var_pairs rt.PhpVal, var_atts rt.PhpVal, var_shortcode rt.PhpVal) rt.PhpVal {
	mut var_out_mutated := var_out
	mut var_shortcode_mutated := var_shortcode
}

fn (mut this Class_WC_Brands) rest_api_register_routes()  {
}

fn (mut this Class_WC_Brands) rest_api_maybe_set_brands(var_post rt.PhpVal, var_request rt.PhpVal)  {
}

fn (mut this Class_WC_Brands) rest_api_prepare_brands_to_product(var_response rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Brands) rest_api_add_brands_to_product(var_product rt.PhpVal, var_request rt.PhpVal, creating bool)  {
	mut var_product_mutated := var_product
}

fn (mut this Class_WC_Brands) rest_api_filter_products_by_brand(var_args rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_WC_Brands) rest_api_product_collection_params(var_params rt.PhpVal, var_post_type rt.PhpVal) rt.PhpVal {
	mut var_params_mutated := var_params
}

fn (mut this Class_WC_Brands) woocommerce_brands_update_layered_nav_link(var_term_html rt.PhpVal, var_term rt.PhpVal, var_link rt.PhpVal, var_count rt.PhpVal) rt.PhpVal {
	mut var_term_html_mutated := var_term_html
	mut var_term_mutated := var_term
	mut var_link_mutated := var_link
}

fn (mut this Class_WC_Brands) duplicate_store_temporary_brands(var_duplicate rt.PhpVal, var_original rt.PhpVal)  {
}

fn (mut this Class_WC_Brands) duplicate_add_product_brand_terms(var_product_id rt.PhpVal)  {
	mut var_product_id_mutated := var_product_id
}

fn (mut this Class_WC_Brands) invalidate_wc_layered_nav_counts_cache()  {
}

fn (mut this Class_WC_Brands) reset_layered_nav_counts_on_status_change(var_new_status rt.PhpVal, var_old_status rt.PhpVal, var_post rt.PhpVal)  {
}

fn (mut this Class_WC_Brands) wc_brands_on_block_template_register(var_template_id rt.PhpVal, var_template_area rt.PhpVal, var_template rt.PhpVal)  {
	mut var_template_mutated := var_template
}

fn (mut this Class_WC_Brands) hook_product_brand_block(var_hooked_block_types rt.PhpVal, var_relative_position rt.PhpVal, var_anchor_block_type rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_hooked_block_types_mutated := var_hooked_block_types
}

fn (mut this Class_WC_Brands) template_already_has_brand_block(var_template rt.PhpVal) bool {
	mut var_template_mutated := var_template
}

fn (mut this Class_WC_Brands) configure_product_brand_block(var_parsed_hooked_block rt.PhpVal, var_hooked_block_type rt.PhpVal, var_relative_position rt.PhpVal, var_parsed_anchor_block rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_parsed_hooked_block_mutated := var_parsed_hooked_block
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_wc_brands() &Class_WC_Brands {
	mut obj := &Class_WC_Brands{
		PhpObjectBase: rt.PhpObjectBase{}
		template_url: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
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
			return Class_WC_Brands.get_brand_products_query_args(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'add_brand_products_shortcode_atts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_WC_Brands.add_brand_products_shortcode_atts(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
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
			return this.woocommerce_brands_update_layered_nav_link(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
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
			this.reset_layered_nav_counts_on_status_change(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'wc_brands_on_block_template_register' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.wc_brands_on_block_template_register(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'hook_product_brand_block' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.hook_product_brand_block(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
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
			return this.configure_product_brand_block(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		else { return none }
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
		'template_url' { this.template_url = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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


fn init_registry() {
	rt.register_class_factory('WC_Brands', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_brands()
		return rt.new_object('WC_Brands', []string{}, obj)
	})
	rt.register_class_factory('Automattic_Jetpack_Constants', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_jetpack_constants()
		return rt.new_object('Automattic_Jetpack_Constants', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_class_wc_brands_php() {
	mut var_GLOBALS := rt.new_null()
	// unsupported statement: Stmt_Declare
}
