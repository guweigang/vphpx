import rt

struct Class_Automattic_WooCommerce_Blocks_AssetsController {
	rt.PhpObjectBase
pub mut:
	api rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AssetsController) construct(mut var_asset_api Class_Automattic_WooCommerce_Blocks_Assets_Api) {
	this.api = var_asset_api
	this.init()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AssetsController) init() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_AssetsController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_assets' },
		])])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_AssetsController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_script_modules' },
		])])
	rt.call_function('add_action', [rt.new_string('enqueue_block_editor_assets'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_AssetsController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_and_enqueue_site_editor_assets' },
		])])
	rt.call_function('add_filter', [rt.new_string('wp_resource_hints'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_AssetsController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_resource_hints' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('body_class'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_AssetsController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_theme_body_class' },
		]),
		rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('admin_body_class'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_AssetsController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_theme_body_class' },
		]),
		rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_AssetsController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'update_block_style_dependencies' },
		]),
		rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_AssetsController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'update_block_settings_dependencies' },
		]),
		rt.new_int(100)])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_AssetsController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'update_block_settings_dependencies' },
		]),
		rt.new_int(100)])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_AssetsController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'enqueue_wc_entities' },
		]),
		rt.new_int(100)])
	rt.call_function('add_filter', [rt.new_string('js_do_concat'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_AssetsController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'skip_boost_minification_for_cart_checkout' },
		]),
		rt.new_int(10), rt.new_int(2)])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_0 := iife_temp_0.is_enabled(rt.new_string('experimental-iapi-runtime'))
	if rt.is_true(iife_result_0) {
		rt.call_function('add_filter', [rt.new_string('wp_default_scripts'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_AssetsController',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'reregister_core_iapi_runtime' },
			]),
			rt.new_int(20)])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AssetsController) reregister_core_iapi_runtime() {
	mut var_interactivity_api_asset_data := rt.call_method(this.api, 'get_asset_data', [
		rt.call_method(this.api, 'get_block_asset_build_path', [
			rt.new_string('interactivity-api-assets'),
			rt.new_string('php'),
		]),
	])
	mut iter_1 := var_interactivity_api_asset_data.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_data := item_1.val
		mut var_handle := item_1.key
		mut var_handle_without_js := rt.call_function('str_replace', [
			rt.new_string('.js'),
			rt.new_string(''),
			var_handle.clone(),
		])
		if rt.is_true(rt.identical(rt.new_string('@wordpress/interactivity'), var_handle_without_js))
			|| rt.is_true(rt.identical(rt.new_string('@wordpress/interactivity-router'), var_handle_without_js)) {
			rt.call_function('wp_deregister_script_module', [
				var_handle_without_js.clone()])
		}
		rt.call_function('wp_register_script_module', [var_handle_without_js.clone(),
			rt.call_function('plugins_url', [
				rt.call_method(this.api, 'get_block_asset_build_path', [
					var_handle_without_js.clone()]),
				rt.call_function('dirname', [rt.new_string(@DIR)]),
			]),
			var_data.array_get(rt.new_string('dependencies')),
			var_data.array_get(rt.new_string('version'))])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AssetsController) register_script_modules() {
	mut var_asset_data := rt.call_method(this.api, 'get_asset_data', [
		rt.call_method(this.api, 'get_block_asset_build_path', [
			rt.new_string('interactivity-blocks-frontend-assets'),
			rt.new_string('php'),
		]),
	])
	mut iter_2 := var_asset_data.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_data := item_2.val
		mut var_handle := item_2.key
		mut var_handle_without_js := rt.call_function('str_replace', [
			rt.new_string('.js'),
			rt.new_string(''),
			var_handle.clone(),
		])
		rt.call_function('wp_register_script_module', [var_handle_without_js.clone(),
			rt.call_function('plugins_url', [
				rt.call_method(this.api, 'get_block_asset_build_path', [
					var_handle_without_js.clone()]),
				rt.call_function('dirname', [rt.new_string(@DIR)]),
			]),
			var_data.array_get(rt.new_string('dependencies')),
			var_data.array_get(rt.new_string('version'))])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AssetsController) register_assets() {
	this.register_style(rt.new_string('wc-blocks-packages-style'), rt.call_function('plugins_url', [
		rt.call_method(this.api, 'get_block_asset_build_path', [
			rt.new_string('packages-style'),
			rt.new_string('css'),
		]),
		rt.call_function('dirname', [
			rt.new_string(@DIR),
		]),
	]), rt.new_array(), 'all', true)
	this.register_style(rt.new_string('wc-blocks-style'), rt.call_function('plugins_url', [
		rt.call_method(this.api, 'get_block_asset_build_path', [
			rt.new_string('wc-blocks'),
			rt.new_string('css'),
		]),
		rt.call_function('dirname', [
			rt.new_string(@DIR),
		]),
	]), rt.new_array(), 'all', true)
	this.register_style(rt.new_string('wc-blocks-editor-style'), rt.call_function('plugins_url', [
		rt.call_method(this.api, 'get_block_asset_build_path', [
			rt.new_string('wc-blocks-editor-style'),
			rt.new_string('css'),
		]),
		rt.call_function('dirname', [
			rt.new_string(@DIR),
		]),
	]), rt.create_array([rt.ArrayItem{ key: none, val: 'wp-edit-blocks' }]), 'all', true)
	rt.call_method(this.api, 'register_script', [rt.new_string('wc-types'),
		rt.call_method(this.api, 'get_block_asset_build_path', [
			rt.new_string('wc-types'),
		]),
		rt.new_array(), rt.new_bool(false)])
	rt.call_method(this.api, 'register_script', [rt.new_string('wc-entities'),
		rt.new_string('assets/client/blocks/wc-entities.js'),
		rt.new_array(), rt.new_bool(false)])
	rt.call_method(this.api, 'register_script', [rt.new_string('wc-blocks-middleware'),
		rt.new_string('assets/client/blocks/wc-blocks-middleware.js'),
		rt.new_array(), rt.new_bool(false)])
	rt.call_method(this.api, 'register_script', [rt.new_string('wc-blocks-data-store'),
		rt.new_string('assets/client/blocks/wc-blocks-data.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'wc-blocks-middleware' }])])
	rt.call_method(this.api, 'register_script', [rt.new_string('wc-blocks-vendors'),
		rt.call_method(this.api, 'get_block_asset_build_path', [
			rt.new_string('wc-blocks-vendors'),
		]),
		rt.new_array(), rt.new_bool(false)])
	rt.call_method(this.api, 'register_script', [rt.new_string('wc-blocks-registry'),
		rt.new_string('assets/client/blocks/wc-blocks-registry.js'),
		rt.new_array(), rt.new_bool(false)])
	rt.call_method(this.api, 'register_script', [rt.new_string('wc-blocks'),
		rt.call_method(this.api, 'get_block_asset_build_path', [
			rt.new_string('wc-blocks'),
		]),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-blocks-vendors' },
		]),
		rt.new_bool(false)])
	rt.call_method(this.api, 'register_script', [
		rt.new_string('wc-blocks-shared-context'),
		rt.new_string('assets/client/blocks/wc-blocks-shared-context.js'),
	])
	rt.call_method(this.api, 'register_script', [rt.new_string('wc-blocks-shared-hocs'),
		rt.new_string('assets/client/blocks/wc-blocks-shared-hocs.js'),
		rt.new_array(), rt.new_bool(false)])
	rt.call_method(this.api, 'register_script', [rt.new_string('wc-price-format'),
		rt.new_string('assets/client/blocks/price-format.js'),
		rt.new_array(), rt.new_bool(false)])
	rt.call_method(this.api, 'register_script', [
		rt.new_string('wc-blocks-frontend-vendors'),
		rt.call_method(this.api, 'get_block_asset_build_path', [
			rt.new_string('wc-blocks-frontend-vendors-frontend'),
		]),
		rt.new_array(),
		rt.new_bool(true),
	])
	rt.call_method(this.api, 'register_script', [
		rt.new_string('wc-cart-checkout-vendors'),
		rt.call_method(this.api, 'get_block_asset_build_path', [
			rt.new_string('wc-cart-checkout-vendors-frontend'),
		]),
		rt.new_array(),
		rt.new_bool(true),
	])
	rt.call_method(this.api, 'register_script', [rt.new_string('wc-cart-checkout-base'),
		rt.call_method(this.api, 'get_block_asset_build_path', [
			rt.new_string('wc-cart-checkout-base-frontend'),
		]),
		rt.new_array(), rt.new_bool(true)])
	rt.call_method(this.api, 'register_script', [rt.new_string('wc-blocks-checkout'),
		rt.new_string('assets/client/blocks/blocks-checkout.js')])
	rt.call_method(this.api, 'register_script', [
		rt.new_string('wc-blocks-checkout-events'),
		rt.new_string('assets/client/blocks/blocks-checkout-events.js'),
	])
	rt.call_method(this.api, 'register_script', [rt.new_string('wc-blocks-components'),
		rt.new_string('assets/client/blocks/blocks-components.js')])
	rt.call_method(this.api, 'register_script', [rt.new_string('wc-schema-parser'),
		rt.new_string('assets/client/blocks/wc-schema-parser.js'),
		rt.new_array(), rt.new_bool(false)])
	rt.call_method(this.api, 'register_script', [rt.new_string('wc-sanitize'),
		rt.new_string('assets/client/admin/sanitize/index.js'),
		rt.new_array()])
	rt.call_method(this.api, 'register_script', [
		rt.new_string('wc-customer-effort-score'),
		rt.new_string('assets/client/admin/customer-effort-score/index.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'wp-data' },
			rt.ArrayItem{ key: none, val: 'wp-data-controls' },
			rt.ArrayItem{ key: none, val: 'wc-store-data' }]),
	])
	rt.call_method(this.api, 'register_style', [
		rt.new_string('wc-customer-effort-score'),
		rt.new_string('assets/client/admin/customer-effort-score/style.css'),
	])
	rt.call_function('wp_add_inline_script', [rt.new_string('wc-blocks-middleware'),
		rt.new_string("\n\t\t\tvar wcBlocksMiddlewareConfig = {\n\t\t\t\tstoreApiNonce: '" +
			(rt.call_function('esc_js', [rt.call_function('wp_create_nonce', [rt.new_string('wc_store_api')])])).str() +
			"',\n\t\t\t\twcStoreApiNonceTimestamp: '" +
			(rt.call_function('esc_js', [rt.call_function('time', []rt.PhpVal{})])).str() +
			"'\n\t\t\t};\n\t\t\t"),
		rt.new_string('before')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AssetsController) register_and_enqueue_site_editor_assets() {
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-customer-effort-score')])
	rt.call_function('wp_enqueue_style', [rt.new_string('wc-customer-effort-score')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AssetsController) add_resource_hints(var_urls rt.PhpVal, var_relation_type rt.PhpVal) rt.PhpVal {
	mut var_urls_mutated := var_urls
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_relation_type.clone(), rt.create_array([rt.ArrayItem{
		key: none
		val: 'prefetch'
	}, rt.ArrayItem{ key: none, val: 'prerender' }]), rt.new_bool(true)])))))
		|| rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		return var_urls_mutated.clone()
	}
	mut var_cart := rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'cart')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_cart, 'Automattic_WooCommerce_Blocks_WC_Cart'))))))
		|| rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_cart, 'get_cart_contents_count', []rt.PhpVal{}))) {
		return var_urls_mutated.clone()
	}
	if rt.is_true(rt.identical(rt.new_string('prefetch'), var_relation_type)) {
		var_urls_mutated = rt.call_function('array_merge', [var_urls_mutated.clone(),
			this.get_prefetch_resource_hints()])
	}
	if rt.is_true(rt.identical(rt.new_string('prerender'), var_relation_type)) {
		var_urls_mutated = rt.call_function('array_merge', [var_urls_mutated.clone(),
			this.get_prerender_resource_hints()])
	}
	return var_urls_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AssetsController) get_prefetch_resource_hints() rt.PhpVal {
	mut var_urls := rt.new_array()
	mut var_cart_page_id := rt.call_function('wc_get_page_id', [
		rt.new_string('cart')])
	mut var_checkout_page_id := rt.call_function('wc_get_page_id', [
		rt.new_string('checkout'),
	])
	mut var_has_block_cart := rt.new_bool(rt.is_true(var_cart_page_id)
		&& rt.is_true(rt.call_function('has_block', [rt.new_string('woocommerce/cart'), var_cart_page_id.clone()])))
	mut var_has_block_checkout := rt.new_bool(rt.is_true(var_checkout_page_id)
		&& rt.is_true(rt.call_function('has_block', [rt.new_string('woocommerce/checkout'), var_checkout_page_id.clone()])))
	mut var_is_block_cart := rt.call_function('has_block', [
		rt.new_string('woocommerce/cart'),
	])
	mut var_is_block_checkout := rt.call_function('has_block', [
		rt.new_string('woocommerce/checkout'),
	])
	if rt.is_true(var_has_block_cart) && rt.is_true(rt.new_bool(!(rt.is_true(var_is_block_cart)))) {
		var_urls = rt.call_function('array_merge', [var_urls.clone(),
			this.get_block_asset_resource_hints('cart-frontend')])
	}
	if rt.is_true(var_has_block_checkout)
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_is_block_checkout)))) {
		var_urls = rt.call_function('array_merge', [var_urls.clone(),
			this.get_block_asset_resource_hints('checkout-frontend')])
	}
	return var_urls.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AssetsController) get_prerender_resource_hints() rt.PhpVal {
	mut var_urls := rt.new_array()
	mut var_is_block_cart := rt.call_function('has_block', [
		rt.new_string('woocommerce/cart'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_block_cart)))) {
		return var_urls.clone()
	}
	mut var_checkout_page_id := rt.call_function('wc_get_page_id', [
		rt.new_string('checkout'),
	])
	mut var_checkout_page_url := if rt.is_true(var_checkout_page_id) { rt.call_function('get_permalink', [
			var_checkout_page_id.clone(),
		]) } else { rt.new_string('') }
	if rt.is_true(var_checkout_page_url) {
		var_urls.array_push(var_checkout_page_url.clone())
	}
	return var_urls.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AssetsController) get_block_asset_resource_hints_cache() rt.PhpVal {
	if rt.is_true(rt.call_function('wp_is_development_mode', [
		rt.new_string('plugin')]))
	{
		return rt.new_null()
	}
	mut var_cache := rt.call_function('get_transient', [
		rt.new_string('woocommerce_block_asset_resource_hints'),
	])
	mut iife_temp_1 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_1 := iife_temp_1.get_constant(rt.new_string('WC_VERSION'))
	mut var_current_version := rt.create_array([
		rt.ArrayItem{ key: 'woocommerce', val: iife_result_1 },
		rt.ArrayItem{ key: 'wordpress', val: rt.call_function('get_bloginfo', [
			rt.new_string('version'),
		]) },
		rt.ArrayItem{ key: 'site_url', val: rt.call_function('site_url', []rt.PhpVal{}) },
	])
	if var_cache.array_isset(rt.new_string('version'))
		&& rt.is_true(rt.identical(var_cache.array_get(rt.new_string('version')), var_current_version)) {
		return var_cache.array_get(rt.new_string('files'))
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AssetsController) set_block_asset_resource_hints_cache(var_filename rt.PhpVal, var_data rt.PhpVal) {
	mut var_filename_mutated := var_filename
	mut var_data_mutated := var_data
	mut var_cache := this.get_block_asset_resource_hints_cache()
	mut iife_temp_2 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_2 := iife_temp_2.get_constant(rt.new_string('WC_VERSION'))
	mut var_updated := rt.create_array([
		rt.ArrayItem{
			key: 'files'
			val: if !var_cache.is_null() { var_cache } else { rt.new_array() }
		},
		rt.ArrayItem{ key: 'version', val: rt.create_array([
			rt.ArrayItem{ key: 'woocommerce', val: iife_result_2 },
			rt.ArrayItem{ key: 'wordpress', val: rt.call_function('get_bloginfo', [
				rt.new_string('version'),
			]) },
			rt.ArrayItem{ key: 'site_url', val: rt.call_function('site_url', []rt.PhpVal{}) },
		]) },
	])
	var_updated.array_get_mut('files').array_set(var_filename_mutated, var_data_mutated.clone())
	rt.call_function('set_transient', [
		rt.new_string('woocommerce_block_asset_resource_hints'),
		var_updated.clone(),
		rt.get_constant('WEEK_IN_SECONDS'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AssetsController) get_block_asset_resource_hints(filename string) rt.PhpVal {
	mut filename_mutated := filename
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(filename_mutated))))) {
		return rt.new_array()
	}
	mut var_cached := this.get_block_asset_resource_hints_cache()
	if var_cached.array_isset(rt.new_string(filename_mutated)) {
		return var_cached.array_get(rt.new_string(filename_mutated))
	}
	mut var_script_data := rt.call_method(this.api, 'get_script_data', [
		rt.call_method(this.api, 'get_block_asset_build_path', [
			rt.new_string(filename_mutated).clone()]),
	])
	mut var_resources := rt.call_function('array_merge', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('esc_url', [
				rt.call_function('add_query_arg', [rt.new_string('ver'),
					var_script_data.array_get(rt.new_string('version')),
					var_script_data.array_get(rt.new_string('src'))]),
			]) },
		]),
		this.get_script_dependency_src_array(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_array](var_script_data.array_get(rt.new_string('dependencies')))),
	])
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_src := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.create_array([rt.ArrayItem{ key: 'href', val: var_src },
			rt.ArrayItem{ key: 'as', val: 'script' }])
	}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_src := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.create_array([rt.ArrayItem{ key: 'href', val: var_src },
			rt.ArrayItem{ key: 'as', val: 'script' }])
	}
	mut var_data := rt.call_function('array_map', [rt.new_closure(closure_4_fn),
		rt.call_function('array_unique', [
			rt.call_function('array_filter', [var_resources.clone()]),
		])])
	this.set_block_asset_resource_hints_cache(rt.new_string(filename_mutated), var_data.clone())
	return var_data.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AssetsController) get_script_dependency_src_array(mut var_dependencies Class_Automattic_WooCommerce_Blocks_array) rt.PhpVal {
	mut var_wp_scripts := rt.call_function('wp_scripts', []rt.PhpVal{})
	mut var_found_dependencies := rt.new_array()
	this.gather_script_dependency_handles(mut var_dependencies, mut
		rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_WP_Scripts](var_wp_scripts),
		var_found_dependencies.clone())
	mut var_src := rt.new_array()
	mut iter_3 := var_found_dependencies.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_unused := item_3.val
		mut var_handle := item_3.key
		var_src.array_push(rt.call_function('esc_url', [
			rt.call_function('add_query_arg', [rt.new_string('ver'),
				rt.get_property(rt.get_property(var_wp_scripts, 'registered').array_get(var_handle),
					'ver'),
				this.get_absolute_url(rt.get_property(rt.get_property(var_wp_scripts, 'registered').array_get(var_handle),
					'src'))]),
		]))
	}
	return var_src.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AssetsController) gather_script_dependency_handles(mut var_dependencies Class_Automattic_WooCommerce_Blocks_array, mut var_wp_scripts Class_Automattic_WooCommerce_Blocks_WP_Scripts, var_found_dependencies rt.PhpVal) {
	mut var_wp_scripts_mutated := var_wp_scripts
	mut var_found_dependencies_mutated := var_found_dependencies
	mut iter_4 := var_dependencies.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_handle := item_4.val
		if rt.get_property(var_wp_scripts_mutated, 'registered').array_isset(var_handle)
			&& !(var_found_dependencies_mutated.array_isset(var_handle)) {
			var_found_dependencies_mutated.array_set(var_handle, true)
			if !(!rt.is_true(rt.get_property(rt.get_property(var_wp_scripts_mutated, 'registered').array_get(var_handle),
				'deps'))) {
				this.gather_script_dependency_handles(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_array](rt.get_property(rt.get_property(var_wp_scripts_mutated,
					'registered').array_get(var_handle), 'deps')), mut var_wp_scripts_mutated,
					var_found_dependencies_mutated.clone())
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AssetsController) get_absolute_url(var_src rt.PhpVal) rt.PhpVal {
	mut var_src_mutated := var_src
	mut var_wp_scripts := rt.call_function('wp_scripts', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('|^(https?:)?//|'), var_src_mutated.clone()])))))
		&& !(rt.is_true(rt.get_property(var_wp_scripts, 'content_url'))
		&& rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_src_mutated.clone(), rt.get_property(var_wp_scripts, 'content_url')])))) {
		var_src_mutated = rt.new_string((rt.get_property(var_wp_scripts, 'base_url')).str() +
			var_src_mutated.str())
	}
	return var_src_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AssetsController) skip_boost_minification_for_cart_checkout(var_do_concat rt.PhpVal, var_handle rt.PhpVal) rt.PhpVal {
	mut var_boost_is_outdated := rt.new_bool(
		rt.is_true(rt.call_function('defined', [rt.new_string('JETPACK_BOOST_VERSION')]))
		&& rt.is_true(rt.call_function('version_compare', [rt.get_constant('JETPACK_BOOST_VERSION'), rt.new_string('3.4.2'), rt.new_string('<')])))
	mut var_scripts_to_ignore := rt.create_array([
		rt.ArrayItem{ key: none, val: 'wc-cart-checkout-vendors' },
		rt.ArrayItem{ key: none, val: 'wc-cart-checkout-base' },
	])
	return if rt.is_true(var_boost_is_outdated)
		&& rt.is_true(rt.call_function('in_array', [var_handle.clone(), var_scripts_to_ignore.clone(), rt.new_bool(true)])) {
		rt.new_bool(false)
	} else {
		var_do_concat
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AssetsController) add_theme_body_class(var_classes rt.PhpVal) rt.PhpVal {
	mut var_classes_mutated := var_classes
	mut var_class := rt.new_string('theme-' +
		(rt.call_function('get_template', []rt.PhpVal{})).str())
	if rt.is_true(rt.new_bool(var_classes_mutated.clone().is_array())) {
		var_classes_mutated.array_push(var_class.clone())
	} else {
		var_classes_mutated = rt.concat(var_classes_mutated, rt.new_string(' ' + var_class.str() +
			' '))
	}
	return var_classes_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AssetsController) get_file_version(var_file rt.PhpVal) rt.PhpVal {
	mut iife_temp_5 := Class_Automattic_WooCommerce_Blocks_Automattic_WooCommerce_Blocks_Package{}
	mut iife_result_5 := iife_temp_5.get_path()
	mut iife_temp_6 := Class_Automattic_WooCommerce_Blocks_Automattic_WooCommerce_Blocks_Package{}
	mut iife_result_6 := iife_temp_6.get_path()
	if rt.is_true(rt.call_function('defined', [rt.new_string('SCRIPT_DEBUG')]))
		&& rt.is_true(rt.get_constant('SCRIPT_DEBUG'))
		&& rt.is_true(rt.call_function('file_exists', [rt.new_string(iife_result_5.str() + var_file.str())])) {
		mut iife_temp_7 :=
			Class_Automattic_WooCommerce_Blocks_Automattic_WooCommerce_Blocks_Package{}
		mut iife_result_7 := iife_temp_7.get_path()
		mut iife_temp_8 :=
			Class_Automattic_WooCommerce_Blocks_Automattic_WooCommerce_Blocks_Package{}
		mut iife_result_8 := iife_temp_8.get_path()
		return rt.call_function('filemtime', [
			rt.new_string(iife_result_7.str() + var_file.str()),
		])
	}
	return rt.get_property(this.api, 'wc_version')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AssetsController) register_style(var_handle rt.PhpVal, var_src rt.PhpVal, var_deps rt.PhpVal, media string, rtl bool) {
	mut var_src_mutated := var_src
	mut var_filename := rt.call_function('str_replace', [
		rt.call_function('plugins_url', [rt.new_string('/'),
			rt.call_function('dirname', [rt.new_string(@DIR)])]),
		rt.new_string(''),
		var_src_mutated.clone(),
	])
	mut iife_temp_9 := Class_Automattic_WooCommerce_Blocks_AssetsController{}
	mut iife_result_9 := iife_temp_9.get_file_version(var_filename.clone())
	mut var_ver := iife_result_9
	rt.call_function('wp_register_style', [var_handle.clone(),
		var_src_mutated.clone(), var_deps.clone(), var_ver.clone(),
		rt.new_string(media)])
	if var_rtl {
		rt.call_function('wp_style_add_data', [var_handle.clone(),
			rt.new_string('rtl'), rt.new_string('replace')])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AssetsController) update_block_style_dependencies() {
	mut var_wp_styles := rt.call_function('wp_styles', []rt.PhpVal{})
	mut var_style := rt.call_method(var_wp_styles, 'query', [
		rt.new_string('wc-blocks-style'),
		rt.new_string('registered'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_style)))) {
		return
	}
	if rt.is_true(rt.call_function('wp_style_is', [rt.new_string('woocommerce-general'), rt.new_string('registered')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('woocommerce-general'), rt.get_property(var_style, 'deps'), rt.new_bool(true)]))))) {
		rt.get_property(var_style, 'deps').array_push('woocommerce-general')
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AssetsController) update_block_settings_dependencies() {
	mut var_wp_scripts := rt.call_function('wp_scripts', []rt.PhpVal{})
	mut var_known_packages := rt.create_array([
		rt.ArrayItem{ key: none, val: 'wc-settings' },
		rt.ArrayItem{ key: none, val: 'wc-blocks-checkout' },
		rt.ArrayItem{ key: none, val: 'wc-price-format' },
	])
	mut iter_5 := rt.get_property(var_wp_scripts, 'registered').iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_script := item_5.val
		mut var_handle := item_5.key
		if rt.is_true(rt.call_function('array_intersect', [var_known_packages.clone(), rt.get_property(var_script, 'deps')]))
			&& !(rt.get_property(var_script, 'extra').array_isset(rt.new_string('group'))) {
			rt.call_method(var_wp_scripts, 'add_data', [var_handle.clone(),
				rt.new_string('group'), rt.new_int(1)])
			mut var_error_handle := rt.new_string('wc-settings-dep-in-header')
			mut var_used_deps := rt.call_function('implode', [
				rt.new_string(', '),
				rt.call_function('array_intersect', [
					var_known_packages.clone(), rt.get_property(var_script, 'deps')])])
			mut var_error_message :=
				rt.new_string('Scripts that have a dependency on [${var_used_deps.to_string()}] must be loaded in the footer, ${var_handle.to_string()} was registered to load in the header, but has been switched to load in the footer instead. See https://github.com/woocommerce/woocommerce-gutenberg-products-block/pull/5059')
			rt.call_function('wp_register_script', [var_error_handle.clone(),
				rt.new_string('')])
			rt.call_function('wp_enqueue_script', [var_error_handle.clone()])
			rt.call_function('wp_add_inline_script', [var_error_handle.clone(),
				rt.call_function('sprintf', [rt.new_string('console.warn( "%s" );'),
					var_error_message.clone()])])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AssetsController) enqueue_wc_entities() {
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-entities')])
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Automattic_WooCommerce_Blocks_Package {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_assetscontroller(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_AssetsController {
	mut obj := &Class_Automattic_WooCommerce_Blocks_AssetsController{
		PhpObjectBase: rt.PhpObjectBase{}
		api:           rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_automattic_woocommerce_blocks_package(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Automattic_WooCommerce_Blocks_Package {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Automattic_WooCommerce_Blocks_Package{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AssetsController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Assets_Api](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'reregister_core_iapi_runtime' {
			this.reregister_core_iapi_runtime()
			return rt.new_null()
		}
		'register_script_modules' {
			this.register_script_modules()
			return rt.new_null()
		}
		'register_assets' {
			this.register_assets()
			return rt.new_null()
		}
		'register_and_enqueue_site_editor_assets' {
			this.register_and_enqueue_site_editor_assets()
			return rt.new_null()
		}
		'add_resource_hints' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_resource_hints(dispatch_arg_0, dispatch_arg_1)
		}
		'get_prefetch_resource_hints' {
			return this.get_prefetch_resource_hints()
		}
		'get_prerender_resource_hints' {
			return this.get_prerender_resource_hints()
		}
		'get_block_asset_resource_hints_cache' {
			return this.get_block_asset_resource_hints_cache()
		}
		'set_block_asset_resource_hints_cache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_block_asset_resource_hints_cache(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_block_asset_resource_hints' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_block_asset_resource_hints(dispatch_arg_0)
		}
		'get_script_dependency_src_array' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_script_dependency_src_array(mut dispatch_arg_0)
		}
		'gather_script_dependency_handles' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_WP_Scripts](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.gather_script_dependency_handles(mut dispatch_arg_0, mut dispatch_arg_1,
				dispatch_arg_2)
			return rt.new_null()
		}
		'get_absolute_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_absolute_url(dispatch_arg_0)
		}
		'skip_boost_minification_for_cart_checkout' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.skip_boost_minification_for_cart_checkout(dispatch_arg_0, dispatch_arg_1)
		}
		'add_theme_body_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_theme_body_class(dispatch_arg_0)
		}
		'get_file_version' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_file_version(dispatch_arg_0)
		}
		'register_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
			this.register_style(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4)
			return rt.new_null()
		}
		'update_block_style_dependencies' {
			this.update_block_style_dependencies()
			return rt.new_null()
		}
		'update_block_settings_dependencies' {
			this.update_block_settings_dependencies()
			return rt.new_null()
		}
		'enqueue_wc_entities' {
			this.enqueue_wc_entities()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_AssetsController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'api' { return this.api }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AssetsController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'api' {
			this.api = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Automattic_WooCommerce_Blocks_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Automattic_WooCommerce_Blocks_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Automattic_WooCommerce_Blocks_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
