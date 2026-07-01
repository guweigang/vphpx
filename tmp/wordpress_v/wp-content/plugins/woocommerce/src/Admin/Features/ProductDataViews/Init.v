import rt

struct Class_Automattic_WooCommerce_Admin_Features_ProductDataViews_Init {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductDataViews_Init) construct() {
	rt.call_function('add_action', [rt.new_string('admin_menu'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_ProductDataViews_Init',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'woocommerce_add_new_products_dashboard' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_ProductDataViews_Init',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'enqueue_styles' },
		]),
		rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_ProductDataViews_Init',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'enqueue_scripts' },
		]),
		rt.new_int(20)])
	if this.is_product_data_view_page() {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_classes := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			return
		}
		rt.call_function('add_filter', [rt.new_string('admin_body_class'),
			rt.new_closure(closure_1_fn)])
	}
}

fn Class_Automattic_WooCommerce_Admin_Features_ProductDataViews_Init.is_product_data_view_page() bool {
	return rt.get_superglobal('_GET').array_isset(rt.new_string('page'))
		&& rt.is_true(rt.identical(rt.new_string('woocommerce-products-dashboard'), rt.get_superglobal('_GET').array_get('page')))
	// unsupported statement: Stmt_Nop
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductDataViews_Init) enqueue_styles() {
	if !(this.is_product_data_view_page()) {
		return rt.new_null()
	}
	rt.call_function('wp_enqueue_style', [rt.new_string('wc-experimental-products-app')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductDataViews_Init) enqueue_scripts() {
	if !(this.is_product_data_view_page()) {
		return rt.new_null()
	}
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-experimental-products-app')])
	rt.call_function('wp_add_inline_script', [
		rt.new_string('wc-experimental-products-app'),
		rt.new_string('window.wc.experimentalProductsApp.initializeProductsDashboard( "woocommerce-products-dashboard" );'),
		rt.new_string('after'),
	])
	mut var_script_handle := rt.new_string(rt.new_string('wc-admin-edit-product'))
	rt.call_function('wp_register_script', [var_script_handle.dup(),
		rt.new_string(''), rt.create_array([rt.ArrayItem{ key: none, val: 'wp-blocks' }]),
		rt.new_string('0.1.0'), rt.new_bool(true)])
	rt.call_function('wp_enqueue_script', [var_script_handle.dup()])
	rt.call_function('wp_enqueue_media', []rt.PhpVal{})
	rt.call_function('wp_register_style', [rt.new_string('wc-global-presets'),
		rt.new_bool(false)])
	rt.call_function('wp_add_inline_style', [rt.new_string('wc-global-presets'),
		rt.call_function('wp_get_global_stylesheet', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'presets' }]),
		])])
	rt.call_function('wp_enqueue_style', [rt.new_string('wc-global-presets')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductDataViews_Init) woocommerce_add_new_products_dashboard() {
	mut var_gutenberg_experiments := rt.call_function('get_option', [
		rt.new_string('gutenberg-experiments'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_gutenberg_experiments)))) {
		return rt.new_null()
	}
	mut var_ptype_obj := rt.call_function('get_post_type_object', [
		rt.new_string('product'),
	])
	rt.call_function('add_submenu_page', [rt.new_string('edit.php?post_type=product'),
		rt.get_property(rt.get_property(var_ptype_obj, 'labels'), 'name'),
		rt.call_function('esc_html__', [rt.new_string('All Products ( new )'),
			rt.new_string('woocommerce')]),
		rt.new_string('manage_woocommerce'), rt.new_string('woocommerce-products-dashboard'),
		rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_ProductDataViews_Init',
			[]string{}, &this) }, rt.ArrayItem{ key: none, val: 'woocommerce_products_dashboard' }]),
		rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductDataViews_Init) woocommerce_products_dashboard() {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('gutenberg_url')])) {
		rt.call_function('wp_register_style', [
			rt.new_string('wp-gutenberg-posts-dashboard'),
			rt.call_function('gutenberg_url', [
				rt.new_string('build/edit-site/posts.css'),
				rt.new_string(@FILE),
			]),
			rt.create_array([
				rt.ArrayItem{ key: none, val: 'wp-components' },
			]),
		])
		rt.call_function('wp_enqueue_style', [
			rt.new_string('wp-gutenberg-posts-dashboard'),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_script_is', [
		rt.new_string('wc-experimental-products-app'),
		rt.new_string('enqueued'),
	])))))
	{
		rt.call_function('printf', [
			rt.new_string('<div class="notice notice-error"><p>%s</p></div>'),
			rt.call_function('esc_html__', [
				rt.new_string('The experimental products app assets are not available yet. Rebuild the admin assets and reload this page.'),
				rt.new_string('woocommerce'),
			]),
		])
	}
	print('<div id="woocommerce-products-dashboard"></div>')
}

fn create_automattic_woocommerce_admin_features_productdataviews_init() &Class_Automattic_WooCommerce_Admin_Features_ProductDataViews_Init {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_ProductDataViews_Init{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductDataViews_Init) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'is_product_data_view_page' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_ProductDataViews_Init.is_product_data_view_page())
		}
		'enqueue_styles' {
			this.enqueue_styles()
			return rt.new_null()
		}
		'enqueue_scripts' {
			this.enqueue_scripts()
			return rt.new_null()
		}
		'woocommerce_add_new_products_dashboard' {
			this.woocommerce_add_new_products_dashboard()
			return rt.new_null()
		}
		'woocommerce_products_dashboard' {
			this.woocommerce_products_dashboard()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_ProductDataViews_Init) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductDataViews_Init) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_admin_features_productdataviews_init_php() {
	// unsupported statement: Stmt_Declare
}
