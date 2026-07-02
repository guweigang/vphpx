import rt

struct Class_WC_Shop_Customizer {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Shop_Customizer) construct() {
	rt.call_function('add_action', [rt.new_string('customize_register'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Shop_Customizer', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_sections' },
		])])
	rt.call_function('add_action', [rt.new_string('customize_controls_print_styles'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Shop_Customizer', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_styles' },
		])])
	rt.call_function('add_action', [rt.new_string('customize_controls_print_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Shop_Customizer', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_scripts' },
		]),
		rt.new_int(30)])
	rt.call_function('add_action', [rt.new_string('customize_controls_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Shop_Customizer', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'enqueue_scripts' },
		])])
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Shop_Customizer', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_frontend_scripts' },
		])])
}

fn (mut this Class_WC_Shop_Customizer) add_sections(var_wp_customize rt.PhpVal) {
	rt.call_method(var_wp_customize, 'add_panel', [rt.new_string('woocommerce'),
		rt.create_array([rt.ArrayItem{ key: 'priority', val: 200 },
			rt.ArrayItem{ key: 'capability', val: 'manage_woocommerce' },
			rt.ArrayItem{ key: 'theme_supports', val: '' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('WooCommerce'),
				rt.new_string('woocommerce'),
			]) }])])
	this.add_store_notice_section(var_wp_customize.clone())
	this.add_product_catalog_section(var_wp_customize.clone())
	this.add_product_images_section(var_wp_customize.clone())
	this.add_checkout_section(var_wp_customize.clone())
}

fn (mut this Class_WC_Shop_Customizer) add_frontend_scripts() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_store_notice_showing', []rt.PhpVal{}))))) {
		return
	}
	mut var_css :=
		rt.new_string('.woocommerce-store-notice, p.demo_store { display: block !important; }')
	rt.call_function('wp_add_inline_style', [rt.new_string('customize-preview'),
		var_css.clone()])
}

fn (mut this Class_WC_Shop_Customizer) add_styles() {
	if this.has_block_checkout() {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Shop_Customizer) add_scripts() {
	mut var_min_rows := rt.call_function('wc_get_theme_support', [
		rt.new_string('product_grid::min_rows'),
		rt.new_int(1),
	])
	mut var_max_rows := rt.call_function('wc_get_theme_support', [
		rt.new_string('product_grid::max_rows'),
		rt.new_string(''),
	])
	mut var_min_columns := rt.call_function('wc_get_theme_support', [
		rt.new_string('product_grid::min_columns'),
		rt.new_int(1),
	])
	mut var_max_columns := rt.call_function('wc_get_theme_support', [
		rt.new_string('product_grid::max_columns'),
		rt.new_string(''),
	])
	mut var_min_notice := rt.call_function('__', [
		rt.new_string('The minimum allowed setting is %d'),
		rt.new_string('woocommerce'),
	])
	mut var_max_notice := rt.call_function('__', [
		rt.new_string('The maximum allowed setting is %d'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('wc_get_page_permalink', [rt.new_string('shop')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('wc_get_page_permalink', [rt.new_string('shop')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('wc_get_page_permalink', [rt.new_string('checkout')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [var_min_columns.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [var_max_columns.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('sprintf', [var_max_notice.clone(), var_max_columns.clone()]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('sprintf', [var_min_notice.clone(), var_min_columns.clone()]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [var_min_rows.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [var_max_rows.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('sprintf', [var_max_notice.clone(), var_max_rows.clone()]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('sprintf', [var_min_notice.clone(), var_min_rows.clone()]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if this.has_block_checkout() {
		mut var_message := rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Checkout can be customized <a href="%s">in the Editor</a> with your active theme.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('admin_url', [
				rt.new_string('post.php?post=' +
					(rt.call_function('get_option', [rt.new_string('woocommerce_checkout_page_id')])).str() +
					'&action=edit'),
			]),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_json_encode', [var_message.clone(),
			rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
				rt.get_constant('JSON_UNESCAPED_SLASHES'))]))
		// unsupported statement: Stmt_InlineHTML
	}
}

fn (mut this Class_WC_Shop_Customizer) enqueue_scripts() {
	mut var_handle := rt.new_string('custom-notice')
	rt.call_function('wp_register_script', [var_handle.clone(),
		rt.new_bool(false), rt.create_array([
			rt.ArrayItem{ key: none, val: 'customize-controls' },
		]),
		rt.get_constant('WC_VERSION'), rt.new_bool(false)])
	rt.call_function('wp_enqueue_script', [var_handle.clone()])
}

fn (mut this Class_WC_Shop_Customizer) sanitize_archive_display(var_value rt.PhpVal) rt.PhpVal {
	mut var_options := rt.create_array([rt.ArrayItem{ key: none, val: '' },
		rt.ArrayItem{ key: none, val: 'subcategories' }, rt.ArrayItem{ key: none, val: 'both' }])
	return if rt.is_true(rt.call_function('in_array', [var_value.clone(),
		var_options.clone(), rt.new_bool(true)]))
	{ var_value } else { rt.new_string('') }
}

fn (mut this Class_WC_Shop_Customizer) sanitize_default_catalog_orderby(var_value rt.PhpVal) rt.PhpVal {
	mut var_options := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_default_catalog_orderby_options'),
		rt.create_array([
			rt.ArrayItem{ key: 'menu_order', val: rt.call_function('__', [
				rt.new_string('Default sorting (custom ordering + name)'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'popularity', val: rt.call_function('__', [
				rt.new_string('Popularity (sales)'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'rating', val: rt.call_function('__', [
				rt.new_string('Average rating'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'date', val: rt.call_function('__', [
				rt.new_string('Sort by most recent'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'price', val: rt.call_function('__', [
				rt.new_string('Sort by price (asc)'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'price-desc', val: rt.call_function('__', [
				rt.new_string('Sort by price (desc)'),
				rt.new_string('woocommerce'),
			]) },
		]),
	])
	return if rt.is_true(rt.new_bool(var_options.clone().array_isset(var_value.clone()))) {
		var_value
	} else {
		rt.new_string('menu_order')
	}
}

fn (mut this Class_WC_Shop_Customizer) add_store_notice_section(var_wp_customize rt.PhpVal) {
	rt.call_method(var_wp_customize, 'add_section', [
		rt.new_string('woocommerce_store_notice'),
		rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Store Notice'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'priority', val: 10 },
			rt.ArrayItem{ key: 'panel', val: 'woocommerce' },
		]),
	])
	rt.call_method(var_wp_customize, 'add_setting', [
		rt.new_string('woocommerce_demo_store'),
		rt.create_array([rt.ArrayItem{ key: 'default', val: 'no' },
			rt.ArrayItem{ key: 'type', val: 'option' }, rt.ArrayItem{
				key: 'capability'
				val: 'manage_woocommerce'
			}, rt.ArrayItem{ key: 'sanitize_callback', val: 'wc_bool_to_string' },
			rt.ArrayItem{ key: 'sanitize_js_callback', val: 'wc_string_to_bool' }]),
	])
	rt.call_method(var_wp_customize, 'add_setting', [
		rt.new_string('woocommerce_demo_store_notice'),
		rt.create_array([
			rt.ArrayItem{ key: 'default', val: rt.call_function('__', [
				rt.new_string('This is a demo store for testing purposes &mdash; no orders shall be fulfilled.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'option' },
			rt.ArrayItem{ key: 'capability', val: 'manage_woocommerce' },
			rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_kses_post' },
			rt.ArrayItem{ key: 'transport', val: 'postMessage' },
		]),
	])
	rt.call_method(var_wp_customize, 'add_control', [
		rt.new_string('woocommerce_demo_store_notice'),
		rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Store notice'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('If enabled, this text will be shown site-wide. You can use it to show events or promotions to visitors!'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'section', val: 'woocommerce_store_notice' },
			rt.ArrayItem{ key: 'settings', val: 'woocommerce_demo_store_notice' },
			rt.ArrayItem{ key: 'type', val: 'textarea' },
		]),
	])
	rt.call_method(var_wp_customize, 'add_control', [
		rt.new_string('woocommerce_demo_store'),
		rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Enable store notice'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'section', val: 'woocommerce_store_notice' },
			rt.ArrayItem{ key: 'settings', val: 'woocommerce_demo_store' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
		]),
	])
	if !(rt.get_property(var_wp_customize, 'selective_refresh')).is_null() {
		rt.call_method(rt.get_property(var_wp_customize, 'selective_refresh'), 'add_partial', [
			rt.new_string('woocommerce_demo_store_notice'),
			rt.create_array([
				rt.ArrayItem{ key: 'selector', val: '.woocommerce-store-notice' },
				rt.ArrayItem{ key: 'container_inclusive', val: true },
				rt.ArrayItem{ key: 'render_callback', val: 'woocommerce_demo_store' },
			]),
		])
	}
}

fn (mut this Class_WC_Shop_Customizer) add_product_catalog_section(var_wp_customize rt.PhpVal) {
	rt.call_method(var_wp_customize, 'add_section', [
		rt.new_string('woocommerce_product_catalog'),
		rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Product Catalog'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'priority', val: 10 },
			rt.ArrayItem{ key: 'panel', val: 'woocommerce' },
		]),
	])
	rt.call_method(var_wp_customize, 'add_setting', [
		rt.new_string('woocommerce_shop_page_display'),
		rt.create_array([rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'type', val: 'option' }, rt.ArrayItem{
				key: 'capability'
				val: 'manage_woocommerce'
			}, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Shop_Customizer', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'sanitize_archive_display' },
			]) }]),
	])
	rt.call_method(var_wp_customize, 'add_control', [
		rt.new_string('woocommerce_shop_page_display'),
		rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Shop page display'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Choose what to display on the main shop page.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'section', val: 'woocommerce_product_catalog' },
			rt.ArrayItem{ key: 'settings', val: 'woocommerce_shop_page_display' },
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'choices', val: rt.create_array([
				rt.ArrayItem{ key: '', val: rt.call_function('__', [
					rt.new_string('Show products'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'subcategories', val: rt.call_function('__', [
					rt.new_string('Show categories'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'both', val: rt.call_function('__', [
					rt.new_string('Show categories &amp; products'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]),
	])
	rt.call_method(var_wp_customize, 'add_setting', [
		rt.new_string('woocommerce_category_archive_display'),
		rt.create_array([rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'type', val: 'option' }, rt.ArrayItem{
				key: 'capability'
				val: 'manage_woocommerce'
			}, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Shop_Customizer', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'sanitize_archive_display' },
			]) }]),
	])
	rt.call_method(var_wp_customize, 'add_control', [
		rt.new_string('woocommerce_category_archive_display'),
		rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Category display'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Choose what to display on product category pages.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'section', val: 'woocommerce_product_catalog' },
			rt.ArrayItem{ key: 'settings', val: 'woocommerce_category_archive_display' },
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'choices', val: rt.create_array([
				rt.ArrayItem{ key: '', val: rt.call_function('__', [
					rt.new_string('Show products'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'subcategories', val: rt.call_function('__', [
					rt.new_string('Show subcategories'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'both', val: rt.call_function('__', [
					rt.new_string('Show subcategories &amp; products'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]),
	])
	rt.call_method(var_wp_customize, 'add_setting', [
		rt.new_string('woocommerce_default_catalog_orderby'),
		rt.create_array([rt.ArrayItem{ key: 'default', val: 'menu_order' },
			rt.ArrayItem{ key: 'type', val: 'option' }, rt.ArrayItem{
				key: 'capability'
				val: 'manage_woocommerce'
			}, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Shop_Customizer', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'sanitize_default_catalog_orderby' },
			]) }]),
	])
	rt.call_method(var_wp_customize, 'add_control', [
		rt.new_string('woocommerce_default_catalog_orderby'),
		rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Default product sorting'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('How should products be sorted in the catalog by default?'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'section', val: 'woocommerce_product_catalog' },
			rt.ArrayItem{ key: 'settings', val: 'woocommerce_default_catalog_orderby' },
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'choices', val: rt.call_function('apply_filters', [
				rt.new_string('woocommerce_default_catalog_orderby_options'),
				rt.create_array([
					rt.ArrayItem{ key: 'menu_order', val: rt.call_function('__', [
						rt.new_string('Default sorting (custom ordering + name)'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'popularity', val: rt.call_function('__', [
						rt.new_string('Popularity (sales)'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'rating', val: rt.call_function('__', [
						rt.new_string('Average rating'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'date', val: rt.call_function('__', [
						rt.new_string('Sort by most recent'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'price', val: rt.call_function('__', [
						rt.new_string('Sort by price (asc)'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'price-desc', val: rt.call_function('__', [
						rt.new_string('Sort by price (desc)'),
						rt.new_string('woocommerce'),
					]) },
				]),
			]) },
		]),
	])
	if rt.is_true(rt.call_function('has_filter', [rt.new_string('loop_shop_columns')])) {
		return
	}
	rt.call_method(var_wp_customize, 'add_setting', [
		rt.new_string('woocommerce_catalog_columns'),
		rt.create_array([rt.ArrayItem{ key: 'default', val: 4 },
			rt.ArrayItem{ key: 'type', val: 'option' }, rt.ArrayItem{
				key: 'capability'
				val: 'manage_woocommerce'
			}, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
			rt.ArrayItem{ key: 'sanitize_js_callback', val: 'absint' }]),
	])
	rt.call_method(var_wp_customize, 'add_control', [
		rt.new_string('woocommerce_catalog_columns'),
		rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Products per row'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('How many products should be shown per row?'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'section', val: 'woocommerce_product_catalog' },
			rt.ArrayItem{ key: 'settings', val: 'woocommerce_catalog_columns' },
			rt.ArrayItem{ key: 'type', val: 'number' },
			rt.ArrayItem{ key: 'input_attrs', val: rt.create_array([
				rt.ArrayItem{ key: 'min', val: rt.call_function('wc_get_theme_support', [
					rt.new_string('product_grid::min_columns'),
					rt.new_int(1),
				]) },
				rt.ArrayItem{ key: 'max', val: rt.call_function('wc_get_theme_support', [
					rt.new_string('product_grid::max_columns'),
					rt.new_string(''),
				]) },
				rt.ArrayItem{ key: 'step', val: 1 },
			]) },
		]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_filter', [
		rt.new_string('loop_shop_per_page'),
	])))))
	{
		rt.call_method(var_wp_customize, 'add_setting', [
			rt.new_string('woocommerce_catalog_rows'),
			rt.create_array([rt.ArrayItem{ key: 'default', val: 4 },
				rt.ArrayItem{ key: 'type', val: 'option' }, rt.ArrayItem{
					key: 'capability'
					val: 'manage_woocommerce'
				}, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
				rt.ArrayItem{ key: 'sanitize_js_callback', val: 'absint' }]),
		])
	}
	rt.call_method(var_wp_customize, 'add_control', [
		rt.new_string('woocommerce_catalog_rows'),
		rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Rows per page'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('How many rows of products should be shown per page?'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'section', val: 'woocommerce_product_catalog' },
			rt.ArrayItem{ key: 'settings', val: 'woocommerce_catalog_rows' },
			rt.ArrayItem{ key: 'type', val: 'number' },
			rt.ArrayItem{ key: 'input_attrs', val: rt.create_array([
				rt.ArrayItem{ key: 'min', val: rt.call_function('wc_get_theme_support', [
					rt.new_string('product_grid::min_rows'),
					rt.new_int(1),
				]) },
				rt.ArrayItem{ key: 'max', val: rt.call_function('wc_get_theme_support', [
					rt.new_string('product_grid::max_rows'),
					rt.new_string(''),
				]) },
				rt.ArrayItem{ key: 'step', val: 1 },
			]) },
		]),
	])
}

fn (mut this Class_WC_Shop_Customizer) add_product_images_section(var_wp_customize rt.PhpVal) {
	mut iife_temp_0 := Class_Jetpack{}
	mut iife_result_0 := iife_temp_0.is_module_active(rt.new_string('photon'))
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('Jetpack')]))
		&& rt.is_true(iife_result_0) {
		mut var_regen_description := rt.new_string('')
	} else if
		rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_background_image_regeneration'), rt.new_bool(true)]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		var_regen_description = rt.call_function('__', [
			rt.new_string('After publishing your changes, new image sizes will be generated automatically.'),
			rt.new_string('woocommerce'),
		])
	} else if
		rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_background_image_regeneration'), rt.new_bool(true)]))
		&& rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_regen_description = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('After publishing your changes, new image sizes may not be shown until you regenerate thumbnails. You can do this from the <a href="%1$s" target="_blank">tools section in WooCommerce</a> or by using a plugin such as <a href="%2$s" target="_blank">Regenerate Thumbnails</a>.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('admin_url', [
				rt.new_string('admin.php?page=wc-status&tab=tools'),
			]),
			rt.new_string('https://en-gb.wordpress.org/plugins/regenerate-thumbnails/'),
		])
	} else {
		var_regen_description = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('After publishing your changes, new image sizes may not be shown until you <a href="%s" target="_blank">Regenerate Thumbnails</a>.'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('https://en-gb.wordpress.org/plugins/regenerate-thumbnails/'),
		])
	}
	rt.call_method(var_wp_customize, 'add_section', [
		rt.new_string('woocommerce_product_images'),
		rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Product Images'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: var_regen_description },
			rt.ArrayItem{ key: 'priority', val: 20 },
			rt.ArrayItem{ key: 'panel', val: 'woocommerce' },
		]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_get_theme_support', [
		rt.new_string('single_image_width'),
	])))))
	{
		rt.call_method(var_wp_customize, 'add_setting', [
			rt.new_string('woocommerce_single_image_width'),
			rt.create_array([rt.ArrayItem{ key: 'default', val: 600 },
				rt.ArrayItem{ key: 'type', val: 'option' }, rt.ArrayItem{
					key: 'capability'
					val: 'manage_woocommerce'
				}, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
				rt.ArrayItem{ key: 'sanitize_js_callback', val: 'absint' }]),
		])
		rt.call_method(var_wp_customize, 'add_control', [
			rt.new_string('woocommerce_single_image_width'),
			rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Main image width'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Image size used for the main image on single product pages. These images will remain uncropped.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'section', val: 'woocommerce_product_images' },
				rt.ArrayItem{ key: 'settings', val: 'woocommerce_single_image_width' },
				rt.ArrayItem{ key: 'type', val: 'number' },
				rt.ArrayItem{ key: 'input_attrs', val: rt.create_array([
					rt.ArrayItem{ key: 'min', val: 0 },
					rt.ArrayItem{ key: 'step', val: 1 },
				]) },
			]),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_get_theme_support', [
		rt.new_string('thumbnail_image_width'),
	])))))
	{
		rt.call_method(var_wp_customize, 'add_setting', [
			rt.new_string('woocommerce_thumbnail_image_width'),
			rt.create_array([rt.ArrayItem{ key: 'default', val: 300 },
				rt.ArrayItem{ key: 'type', val: 'option' }, rt.ArrayItem{
					key: 'capability'
					val: 'manage_woocommerce'
				}, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
				rt.ArrayItem{ key: 'sanitize_js_callback', val: 'absint' }]),
		])
		rt.call_method(var_wp_customize, 'add_control', [
			rt.new_string('woocommerce_thumbnail_image_width'),
			rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Thumbnail width'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Image size used for products in the catalog.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'section', val: 'woocommerce_product_images' },
				rt.ArrayItem{ key: 'settings', val: 'woocommerce_thumbnail_image_width' },
				rt.ArrayItem{ key: 'type', val: 'number' },
				rt.ArrayItem{ key: 'input_attrs', val: rt.create_array([
					rt.ArrayItem{ key: 'min', val: 0 },
					rt.ArrayItem{ key: 'step', val: 1 },
				]) },
			]),
		])
	}
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/customizer/class-wc-customizer-control-cropping.php',
		'2')
	rt.call_method(var_wp_customize, 'add_setting', [
		rt.new_string('woocommerce_thumbnail_cropping'),
		rt.create_array([rt.ArrayItem{ key: 'default', val: '1:1' },
			rt.ArrayItem{ key: 'type', val: 'option' }, rt.ArrayItem{
				key: 'capability'
				val: 'manage_woocommerce'
			}, rt.ArrayItem{ key: 'sanitize_callback', val: 'wc_clean' }]),
	])
	rt.call_method(var_wp_customize, 'add_setting', [
		rt.new_string('woocommerce_thumbnail_cropping_custom_width'),
		rt.create_array([rt.ArrayItem{ key: 'default', val: '4' },
			rt.ArrayItem{ key: 'type', val: 'option' }, rt.ArrayItem{
				key: 'capability'
				val: 'manage_woocommerce'
			}, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
			rt.ArrayItem{ key: 'sanitize_js_callback', val: 'absint' }]),
	])
	rt.call_method(var_wp_customize, 'add_setting', [
		rt.new_string('woocommerce_thumbnail_cropping_custom_height'),
		rt.create_array([rt.ArrayItem{ key: 'default', val: '3' },
			rt.ArrayItem{ key: 'type', val: 'option' }, rt.ArrayItem{
				key: 'capability'
				val: 'manage_woocommerce'
			}, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
			rt.ArrayItem{ key: 'sanitize_js_callback', val: 'absint' }]),
	])
	rt.call_method(var_wp_customize, 'add_control', [
		create_wc_customizer_control_cropping(var_wp_customize.clone(),
			rt.new_string('woocommerce_thumbnail_cropping'), rt.create_array([
			rt.ArrayItem{ key: 'section', val: 'woocommerce_product_images' },
			rt.ArrayItem{ key: 'settings', val: rt.create_array([
				rt.ArrayItem{ key: 'cropping', val: 'woocommerce_thumbnail_cropping' },
				rt.ArrayItem{
					key: 'custom_width'
					val: 'woocommerce_thumbnail_cropping_custom_width'
				},
				rt.ArrayItem{
					key: 'custom_height'
					val: 'woocommerce_thumbnail_cropping_custom_height'
				},
			]) },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Thumbnail cropping'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'choices', val: rt.create_array([
				rt.ArrayItem{ key: '1:1', val: rt.create_array([
					rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
						rt.new_string('1:1'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Images will be cropped into a square'),
						rt.new_string('woocommerce'),
					]) },
				]) },
				rt.ArrayItem{ key: 'custom', val: rt.create_array([
					rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
						rt.new_string('Custom'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Images will be cropped to a custom aspect ratio'),
						rt.new_string('woocommerce'),
					]) },
				]) },
				rt.ArrayItem{ key: 'uncropped', val: rt.create_array([
					rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
						rt.new_string('Uncropped'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Images will display using the aspect ratio in which they were uploaded'),
						rt.new_string('woocommerce'),
					]) },
				]) },
			]) },
		])),
	])
}

fn (mut this Class_WC_Shop_Customizer) add_checkout_section(var_wp_customize rt.PhpVal) {
	rt.call_method(var_wp_customize, 'add_section', [
		rt.new_string('woocommerce_checkout'),
		rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Checkout'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'priority', val: 20 },
			rt.ArrayItem{ key: 'panel', val: 'woocommerce' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('These options let you change the appearance of the WooCommerce checkout.'),
				rt.new_string('woocommerce'),
			]) },
		]),
	])
	mut var_fields := {
		'company':   rt.call_function('__', [rt.new_string('Company name'),
			rt.new_string('woocommerce')])
		'address_2': rt.call_function('__', [rt.new_string('Address line 2'),
			rt.new_string('woocommerce')])
		'phone':     rt.call_function('__', [rt.new_string('Phone'),
			rt.new_string('woocommerce')])
	}
	for var_field, var_label in var_fields {
		rt.call_method(var_wp_customize, 'add_setting', [
			rt.new_string('woocommerce_checkout_' + field + '_field'),
			rt.create_array([
				rt.ArrayItem{
					key: 'default'
					val: if rt.is_true(rt.identical(rt.new_string('phone'), rt.new_string(field))) {
						'required'
					} else {
						'optional'
					}
				},
				rt.ArrayItem{ key: 'type', val: 'option' },
				rt.ArrayItem{ key: 'capability', val: 'manage_woocommerce' },
				rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_Shop_Customizer', []string{},
						&this) },
					rt.ArrayItem{ key: none, val: 'sanitize_checkout_field_display' },
				]) },
			]),
		])
		rt.call_method(var_wp_customize, 'add_control', [
			rt.new_string('woocommerce_checkout_' + field + '_field'),
			rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('%s field'),
						rt.new_string('woocommerce')]),
					var_label.clone(),
				]) },
				rt.ArrayItem{ key: 'section', val: 'woocommerce_checkout' },
				rt.ArrayItem{ key: 'settings', val: 'woocommerce_checkout_' + field + '_field' },
				rt.ArrayItem{ key: 'type', val: 'select' },
				rt.ArrayItem{ key: 'choices', val: rt.create_array([
					rt.ArrayItem{ key: 'hidden', val: rt.call_function('__', [
						rt.new_string('Hidden'), rt.new_string('woocommerce')]) },
					rt.ArrayItem{ key: 'optional', val: rt.call_function('__', [
						rt.new_string('Optional'), rt.new_string('woocommerce')]) },
					rt.ArrayItem{ key: 'required', val: rt.call_function('__', [
						rt.new_string('Required'), rt.new_string('woocommerce')]) },
				]) },
			]),
		])
	}
	rt.call_method(var_wp_customize, 'add_setting', [
		rt.new_string('woocommerce_checkout_highlight_required_fields'),
		rt.create_array([rt.ArrayItem{ key: 'default', val: 'yes' },
			rt.ArrayItem{ key: 'type', val: 'option' }, rt.ArrayItem{
				key: 'capability'
				val: 'manage_woocommerce'
			}, rt.ArrayItem{ key: 'sanitize_callback', val: 'wc_bool_to_string' },
			rt.ArrayItem{ key: 'sanitize_js_callback', val: 'wc_string_to_bool' }]),
	])
	rt.call_method(var_wp_customize, 'add_setting', [
		rt.new_string('woocommerce_checkout_terms_and_conditions_checkbox_text'),
		rt.create_array([
			rt.ArrayItem{ key: 'default', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('I have read and agree to the website %s'),
					rt.new_string('woocommerce'),
				]),
				rt.new_string('[terms]'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'option' },
			rt.ArrayItem{ key: 'capability', val: 'manage_woocommerce' },
			rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_kses_post' },
			rt.ArrayItem{ key: 'transport', val: 'postMessage' },
		]),
	])
	rt.call_method(var_wp_customize, 'add_setting', [
		rt.new_string('woocommerce_checkout_privacy_policy_text'),
		rt.create_array([
			rt.ArrayItem{ key: 'default', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Your personal data will be used to process your order, support your experience throughout this website, and for other purposes described in our %s.'),
					rt.new_string('woocommerce'),
				]),
				rt.new_string('[privacy_policy]'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'option' },
			rt.ArrayItem{ key: 'capability', val: 'manage_woocommerce' },
			rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_kses_post' },
			rt.ArrayItem{ key: 'transport', val: 'postMessage' },
		]),
	])
	rt.call_method(var_wp_customize, 'add_control', [
		rt.new_string('woocommerce_checkout_highlight_required_fields'),
		rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Highlight required fields with an asterisk'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'section', val: 'woocommerce_checkout' },
			rt.ArrayItem{ key: 'settings', val: 'woocommerce_checkout_highlight_required_fields' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
		]),
	])
	if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_privacy_options'),
	]))
	{
		mut var_choose_pages := {
			'wp_page_for_privacy_policy': rt.call_function('__', [
				rt.new_string('Privacy policy'),
				rt.new_string('woocommerce'),
			])
			'woocommerce_terms_page_id':  rt.call_function('__', [
				rt.new_string('Terms and conditions'),
				rt.new_string('woocommerce'),
			])
		}
	} else {
		var_choose_pages = {
			'woocommerce_terms_page_id': rt.call_function('__', [
				rt.new_string('Terms and conditions'),
				rt.new_string('woocommerce'),
			])
		}
	}
	mut var_pages := rt.call_function('get_pages', [
		rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'page' },
			rt.ArrayItem{ key: 'post_status', val: 'publish,private,draft' },
			rt.ArrayItem{ key: 'child_of', val: 0 }, rt.ArrayItem{ key: 'parent', val: -1 },
			rt.ArrayItem{ key: 'exclude', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('wc_get_page_id', [
					rt.new_string('cart'),
				]) },
				rt.ArrayItem{ key: none, val: rt.call_function('wc_get_page_id', [
					rt.new_string('checkout'),
				]) },
				rt.ArrayItem{ key: none, val: rt.call_function('wc_get_page_id', [
					rt.new_string('myaccount'),
				]) },
			]) }, rt.ArrayItem{ key: 'sort_order', val: 'asc' },
			rt.ArrayItem{ key: 'sort_column', val: 'post_title' }]),
	])
	mut var_page_choices := rt.add(rt.create_array([
		rt.ArrayItem{ key: '', val: rt.call_function('__', [rt.new_string('No page set'),
			rt.new_string('woocommerce')]) },
	]), rt.call_function('array_combine', [
		rt.call_function('array_map', [rt.new_string('strval'),
			rt.call_function('wp_list_pluck', [var_pages.clone(),
				rt.new_string('ID')])]),
		rt.call_function('wp_list_pluck', [var_pages.clone(),
			rt.new_string('post_title')]),
	]))
	for var_id, var_name in var_choose_pages {
		rt.call_method(var_wp_customize, 'add_setting', [rt.new_string(id),
			rt.create_array([rt.ArrayItem{ key: 'default', val: '' },
				rt.ArrayItem{ key: 'type', val: 'option' }, rt.ArrayItem{
					key: 'capability'
					val: 'manage_woocommerce'
				}])])
		rt.call_method(var_wp_customize, 'add_control', [rt.new_string(id),
			rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('%s page'),
						rt.new_string('woocommerce')]),
					var_name.clone(),
				]) },
				rt.ArrayItem{ key: 'section', val: 'woocommerce_checkout' },
				rt.ArrayItem{ key: 'settings', val: id },
				rt.ArrayItem{ key: 'type', val: 'select' },
				rt.ArrayItem{ key: 'choices', val: var_page_choices },
			])])
	}
	rt.call_method(var_wp_customize, 'add_control', [
		rt.new_string('woocommerce_checkout_privacy_policy_text'),
		rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Privacy policy'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Optionally add some text about your store privacy policy to show during checkout.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'section', val: 'woocommerce_checkout' },
			rt.ArrayItem{ key: 'settings', val: 'woocommerce_checkout_privacy_policy_text' },
			rt.ArrayItem{ key: 'active_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Shop_Customizer', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'has_privacy_policy_page_id' },
			]) },
			rt.ArrayItem{ key: 'type', val: 'textarea' },
		]),
	])
	rt.call_method(var_wp_customize, 'add_control', [
		rt.new_string('woocommerce_checkout_terms_and_conditions_checkbox_text'),
		rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Terms and conditions'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Optionally add some text for the terms checkbox that customers must accept.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'section', val: 'woocommerce_checkout' },
			rt.ArrayItem{
				key: 'settings'
				val: 'woocommerce_checkout_terms_and_conditions_checkbox_text'
			},
			rt.ArrayItem{ key: 'active_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Shop_Customizer', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'has_terms_and_conditions_page_id' },
			]) },
			rt.ArrayItem{ key: 'type', val: 'text' },
		]),
	])
	if !(rt.get_property(var_wp_customize, 'selective_refresh')).is_null() {
		rt.call_method(rt.get_property(var_wp_customize, 'selective_refresh'), 'add_partial', [
			rt.new_string('woocommerce_checkout_privacy_policy_text'),
			rt.create_array([
				rt.ArrayItem{ key: 'selector', val: '.woocommerce-privacy-policy-text' },
				rt.ArrayItem{ key: 'container_inclusive', val: true },
				rt.ArrayItem{ key: 'render_callback', val: 'wc_checkout_privacy_policy_text' },
			]),
		])
		rt.call_method(rt.get_property(var_wp_customize, 'selective_refresh'), 'add_partial', [
			rt.new_string('woocommerce_checkout_terms_and_conditions_checkbox_text'),
			rt.create_array([
				rt.ArrayItem{
					key: 'selector'
					val: '.woocommerce-terms-and-conditions-checkbox-text'
				},
				rt.ArrayItem{ key: 'container_inclusive', val: false },
				rt.ArrayItem{ key: 'render_callback', val: 'wc_terms_and_conditions_checkbox_text' },
			]),
		])
	}
}

fn (mut this Class_WC_Shop_Customizer) sanitize_checkout_field_display(var_value rt.PhpVal) rt.PhpVal {
	mut var_options := rt.create_array([rt.ArrayItem{ key: none, val: 'hidden' },
		rt.ArrayItem{ key: none, val: 'optional' }, rt.ArrayItem{ key: none, val: 'required' }])
	return if rt.is_true(rt.call_function('in_array', [var_value.clone(),
		var_options.clone(), rt.new_bool(true)]))
	{ var_value } else { rt.new_string('') }
}

fn (mut this Class_WC_Shop_Customizer) has_privacy_policy_page_id() rt.PhpVal {
	return rt.greater(rt.call_function('wc_privacy_policy_page_id', []rt.PhpVal{}), rt.new_int(0))
}

fn (mut this Class_WC_Shop_Customizer) has_terms_and_conditions_page_id() rt.PhpVal {
	return rt.greater(rt.call_function('wc_terms_and_conditions_page_id', []rt.PhpVal{}),
		rt.new_int(0))
}

fn (mut this Class_WC_Shop_Customizer) has_block_checkout() bool {
	mut var_post := rt.call_function('get_post', [
		rt.call_function('get_option', [rt.new_string('woocommerce_checkout_page_id')]),
	])
	return rt.is_true(var_post)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [rt.get_property(var_post, 'post_content'), rt.new_string('<!-- wp:woocommerce/checkout')]), rt.new_bool(false)))))
}

struct Class_Jetpack {
	rt.PhpObjectBase
}

struct Class_WC_Customizer_Control_Cropping {
	rt.PhpObjectBase
}

fn create_wc_shop_customizer() &Class_WC_Shop_Customizer {
	mut obj := &Class_WC_Shop_Customizer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_jetpack(_args ...rt.PhpVal) &Class_Jetpack {
	mut obj := &Class_Jetpack{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_customizer_control_cropping(_args ...rt.PhpVal) &Class_WC_Customizer_Control_Cropping {
	mut obj := &Class_WC_Customizer_Control_Cropping{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Shop_Customizer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'add_sections' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_sections(dispatch_arg_0)
			return rt.new_null()
		}
		'add_frontend_scripts' {
			this.add_frontend_scripts()
			return rt.new_null()
		}
		'add_styles' {
			this.add_styles()
			return rt.new_null()
		}
		'add_scripts' {
			this.add_scripts()
			return rt.new_null()
		}
		'enqueue_scripts' {
			this.enqueue_scripts()
			return rt.new_null()
		}
		'sanitize_archive_display' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize_archive_display(dispatch_arg_0)
		}
		'sanitize_default_catalog_orderby' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize_default_catalog_orderby(dispatch_arg_0)
		}
		'add_store_notice_section' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_store_notice_section(dispatch_arg_0)
			return rt.new_null()
		}
		'add_product_catalog_section' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_product_catalog_section(dispatch_arg_0)
			return rt.new_null()
		}
		'add_product_images_section' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_product_images_section(dispatch_arg_0)
			return rt.new_null()
		}
		'add_checkout_section' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_checkout_section(dispatch_arg_0)
			return rt.new_null()
		}
		'sanitize_checkout_field_display' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize_checkout_field_display(dispatch_arg_0)
		}
		'has_privacy_policy_page_id' {
			return this.has_privacy_policy_page_id()
		}
		'has_terms_and_conditions_page_id' {
			return this.has_terms_and_conditions_page_id()
		}
		'has_block_checkout' {
			return rt.new_bool(this.has_block_checkout())
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Shop_Customizer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shop_Customizer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Jetpack) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Jetpack) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Jetpack) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Customizer_Control_Cropping) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Customizer_Control_Cropping) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Customizer_Control_Cropping) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
