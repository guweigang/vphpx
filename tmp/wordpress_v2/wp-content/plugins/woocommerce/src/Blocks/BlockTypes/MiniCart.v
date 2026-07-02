import rt

pub fn Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart.mini_cart_template_blocks() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart-contents' },
		rt.ArrayItem{ key: none, val: 'woocommerce/filled-mini-cart-contents-block' },
		rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart-title-block' },
		rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart-title-label-block' },
		rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart-title-items-counter-block' },
		rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart-items-block' },
		rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart-products-table-block' },
		rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart-footer-block' },
		rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart-cart-button-block' },
		rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart-checkout-button-block' },
		rt.ArrayItem{ key: none, val: 'woocommerce/empty-mini-cart-contents-block' },
		rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart-shopping-button-block' },
	])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart {
	rt.PhpObjectBase
pub mut:
	block_name                        rt.PhpVal = rt.new_string('mini-cart')
	chunks_folder                     rt.PhpVal = rt.new_string('mini-cart-contents-block')
	scripts_to_lazy_load              rt.PhpVal = rt.new_array()
	tax_label                         rt.PhpVal = rt.new_string('')
	display_cart_prices_including_tax rt.PhpVal = rt.new_bool(false)
	hooked_block_placements           rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) construct(mut var_asset_api Class_Automattic_WooCommerce_Blocks_Assets_Api, mut var_asset_data_registry Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry, mut var_integration_registry Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry) {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.construct(rt.new_object('Automattic_WooCommerce_Blocks_Assets_Api',
		[]string{}, var_asset_api), rt.new_object('Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry',
		[]string{}, var_asset_data_registry), rt.new_object('Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry',
		[]string{}, var_integration_registry), this.block_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) initialize() {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.initialize()
	rt.call_function('add_action', [rt.new_string('wp_loaded'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'register_empty_cart_message_block_pattern' },
		])])
	rt.call_function('add_action', [rt.new_string('wp_print_footer_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'print_lazy_load_scripts' },
		]),
		rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('hooked_block_woocommerce/mini-cart'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'modify_hooked_block_attributes' },
		]),
		rt.new_int(10), rt.new_int(5)])
	rt.call_function('add_filter', [rt.new_string('hooked_block_types'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'register_hooked_block' },
		]),
		rt.new_int(9), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'enable_interactivity_support' },
		]),
		rt.new_int(20)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) enable_interactivity_support() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_0 := iife_temp_0.is_enabled(rt.new_string('experimental-iapi-mini-cart'))
	if rt.is_true(iife_result_0) {
		mut iife_temp_1 := Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Block_Type_Registry{}
		mut iife_result_1 := iife_temp_1.get_instance()
		mut var_block_type := rt.call_method(iife_result_1, 'get_registered', [
			rt.new_string('woocommerce/mini-cart'),
		])
		if rt.is_true(var_block_type) {
			rt.get_property(var_block_type, 'supports').array_set('interactivity', true)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) modify_hooked_block_attributes(var_parsed_hooked_block rt.PhpVal, var_hooked_block_type rt.PhpVal, var_relative_position rt.PhpVal, var_parsed_anchor_block rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_context_mutated := var_context
	mut var_mini_cart_block_font_size := rt.call_function('wp_get_global_styles', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'blocks' },
			rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart' },
			rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'fontSize' }]),
	])
	if !(var_mini_cart_block_font_size.clone().is_string()) {
		mut var_navigation_block_font_size := rt.call_function('wp_get_global_styles', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'blocks' },
				rt.ArrayItem{ key: none, val: 'core/navigation' },
				rt.ArrayItem{ key: none, val: 'typography' },
				rt.ArrayItem{ key: none, val: 'fontSize' }]),
		])
		if rt.is_true(rt.new_bool(var_navigation_block_font_size.clone().is_string())) {
			var_parsed_hooked_block.array_get_mut('attrs').array_get_mut('style').array_get_mut('typography').array_set('fontSize',
				var_navigation_block_font_size.clone())
		}
	}
	return var_parsed_hooked_block.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) get_block_type_editor_script(var_key rt.PhpVal) rt.PhpVal {
	mut var_script := rt.create_array([
		rt.ArrayItem{ key: 'handle', val: 'wc-' + (this.block_name).str() + '-block' },
		rt.ArrayItem{ key: 'path', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
		], &this), 'asset_api'), 'get_block_asset_build_path', [
			this.block_name,
		]) },
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-blocks' },
		]) },
	])
	return if rt.is_true(var_key) { var_script.array_get(var_key) } else { var_script }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_2 := iife_temp_2.is_enabled(rt.new_string('experimental-iapi-mini-cart'))
	if rt.is_true(rt.call_function('is_cart', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{})) || rt.is_true(iife_result_2) {
		return rt.new_null()
	}
	mut var_script := rt.create_array([
		rt.ArrayItem{ key: 'handle', val: 'wc-' + (this.block_name).str() + '-block-frontend' },
		rt.ArrayItem{ key: 'path', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
		], &this), 'asset_api'), 'get_block_asset_build_path', [
			rt.new_string((this.block_name).str() + '-frontend'),
		]) },
		rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
	])
	return if rt.is_true(var_key) { var_script.array_get(var_key) } else { var_script }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) get_block_type_style() rt.PhpVal {
	return rt.call_function('array_merge', [this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.get_block_type_style(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'wc-blocks-packages-style' }])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array) {
	if rt.is_true(rt.call_function('is_cart', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{})) {
		return
	}
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array',
		[]string{}, var_attributes))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_rest_api_request', []rt.PhpVal{}))))) {
		mut var_label_info := this.get_tax_label()
		this.tax_label = var_label_info.array_get(rt.new_string('tax_label'))
		this.display_cart_prices_including_tax =
			var_label_info.array_get(rt.new_string('display_cart_prices_including_tax'))
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
		], &this), 'asset_data_registry'), 'add', [rt.new_string('taxLabel'), this.tax_label])
	}
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [
		rt.new_string('displayCartPricesIncludingTax'),
		this.display_cart_prices_including_tax,
	])
	mut var_template_part_edit_uri := rt.new_string('')
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]))
		&& rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('block-template-parts')])) {
		mut iife_temp_3 := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}
		mut iife_result_3 := iife_temp_3.theme_has_template_part(rt.new_string('mini-cart'))
		mut var_theme_slug := if rt.is_true(iife_result_3) {
			rt.call_method(rt.call_function('wp_get_theme', []rt.PhpVal{}), 'get_stylesheet',
				[]rt.PhpVal{})
		} else {
			Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.plugin_slug()
		}
		if rt.is_true(rt.call_function('version_compare', [
			rt.call_function('get_bloginfo', [rt.new_string('version')]),
			rt.new_string('5.9'),
			rt.new_string('<'),
		]))
		{
			mut var_site_editor_uri := rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'page', val: 'gutenberg-edit-site' }]),
				rt.call_function('admin_url', [rt.new_string('themes.php')]),
			])
		} else {
			var_site_editor_uri = rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'canvas', val: 'edit' },
					rt.ArrayItem{ key: 'path', val: '/template-parts/single' }]),
				rt.call_function('admin_url', [rt.new_string('site-editor.php')]),
			])
		}
		var_template_part_edit_uri = rt.call_function('esc_url_raw', [
			rt.call_function('add_query_arg', [
				rt.create_array([
					rt.ArrayItem{ key: 'postId', val: rt.call_function('sprintf', [
						rt.new_string('%s//%s'),
						var_theme_slug.clone(),
						rt.new_string('mini-cart'),
					]) },
					rt.ArrayItem{ key: 'postType', val: 'wp_template_part' },
				]),
				var_site_editor_uri.clone(),
			]),
		])
	}
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('templatePartEditUri'),
		var_template_part_edit_uri.clone()])
	rt.call_function('do_action', [rt.new_string('woocommerce_blocks_cart_enqueue_data')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) print_lazy_load_scripts() {
	mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_4 := iife_temp_4.is_enabled(rt.new_string('experimental-iapi-mini-cart'))
	if rt.is_true(iife_result_4) {
		return
	}
	mut var_script_data := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_api'), 'get_script_data', [
		rt.new_string('assets/client/blocks/mini-cart-component-frontend.js'),
	])
	mut var_num_dependencies := rt.new_int(if rt.call_function('is_countable', [
		var_script_data.array_get(rt.new_string('dependencies')),
	])
	{ var_script_data.array_get(rt.new_string('dependencies')).array_count() } else { 0 })
	mut var_wp_scripts := rt.call_function('wp_scripts', []rt.PhpVal{})
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, var_num_dependencies))) { break
		 }
		mut var_dependency :=
			var_script_data.array_get(rt.new_string('dependencies')).array_get(var_i)
		mut iter_1 := rt.get_property(var_wp_scripts, 'registered').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_script := item_1.val
			if rt.is_true(rt.identical(rt.get_property(var_script, 'handle'), var_dependency)) {
				this.append_script_and_deps_src(var_script.clone())
				break
			}
		}
		rt.post_inc(var_i)
	}
	mut iife_temp_5 := Class_Automattic_WooCommerce_Blocks_Package{}
	mut iife_result_5 := iife_temp_5.container()
	mut var_payment_method_registry := rt.call_method(iife_result_5, 'get', [
		Class_Automattic_WooCommerce_Blocks_Payments_PaymentMethodRegistry.class(),
	])
	mut var_payment_methods := rt.call_method(var_payment_method_registry,
		'get_all_active_payment_method_script_dependencies', []rt.PhpVal{})
	mut iter_2 := var_payment_methods.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_payment_method := item_2.val
		mut var_payment_method_script := this.get_script_from_handle(var_payment_method.clone())
		if !(var_payment_method_script.clone().is_null()) {
			this.append_script_and_deps_src(var_payment_method_script.clone())
		}
	}
	this.scripts_to_lazy_load.array_set('wc-block-mini-cart-component-frontend', rt.create_array([
		rt.ArrayItem{ key: 'src', val: var_script_data.array_get(rt.new_string('src')) },
		rt.ArrayItem{ key: 'version', val: var_script_data.array_get(rt.new_string('version')) },
		rt.ArrayItem{ key: 'translations', val: this.get_inner_blocks_translations() },
	]))
	mut var_inner_blocks_frontend_scripts := rt.new_array()
	mut var_cart := this.get_cart_instance()
	if rt.is_true(var_cart) {
		var_inner_blocks_frontend_scripts = if rt.is_true(rt.call_method(var_cart, 'is_empty', []rt.PhpVal{})) { rt.create_array([
				rt.ArrayItem{ key: none, val: 'empty-cart-frontend' },
				rt.ArrayItem{ key: none, val: 'filled-cart-frontend' },
				rt.ArrayItem{ key: none, val: 'shopping-button-frontend' },
			]) } else { rt.create_array([
				rt.ArrayItem{ key: none, val: 'empty-cart-frontend' },
				rt.ArrayItem{ key: none, val: 'filled-cart-frontend' },
				rt.ArrayItem{ key: none, val: 'title-frontend' },
				rt.ArrayItem{ key: none, val: 'items-frontend' },
				rt.ArrayItem{ key: none, val: 'footer-frontend' },
				rt.ArrayItem{ key: none, val: 'products-table-frontend' },
				rt.ArrayItem{ key: none, val: 'cart-button-frontend' },
				rt.ArrayItem{ key: none, val: 'checkout-button-frontend' },
				rt.ArrayItem{ key: none, val: 'title-label-frontend' },
				rt.ArrayItem{ key: none, val: 'title-items-counter-frontend' },
			]) }
	}
	mut iter_3 := var_inner_blocks_frontend_scripts.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_inner_block_frontend_script := item_3.val
		var_script_data = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
		], &this), 'asset_api'), 'get_script_data', [
			rt.new_string('assets/client/blocks/mini-cart-contents-block/' +
				var_inner_block_frontend_script.str() + '.js'),
		])
		this.scripts_to_lazy_load.array_set('wc-block-' + var_inner_block_frontend_script.str(), rt.create_array([
			rt.ArrayItem{ key: 'src', val: var_script_data.array_get(rt.new_string('src')) },
			rt.ArrayItem{ key: 'version', val: var_script_data.array_get(rt.new_string('version')) },
		]))
	}
	mut var_data := rt.call_function('rawurlencode', [
		rt.call_function('wp_json_encode', [this.scripts_to_lazy_load]),
	])
	mut var_mini_cart_dependencies_script := rt.new_string(
		"var wcBlocksMiniCartFrontendDependencies = JSON.parse( decodeURIComponent( '" +
		(rt.call_function('esc_js', [var_data.clone()])).str() + "' ) );")
	rt.call_function('wp_add_inline_script', [
		rt.new_string('wc-mini-cart-block-frontend'),
		var_mini_cart_dependencies_script.clone(),
		rt.new_string('before'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) get_script_from_handle(var_handle rt.PhpVal) rt.PhpVal {
	mut var_handle_mutated := var_handle
	mut var_wp_scripts := rt.call_function('wp_scripts', []rt.PhpVal{})
	mut iter_4 := rt.get_property(var_wp_scripts, 'registered').iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_script := item_4.val
		if rt.is_true(rt.identical(rt.get_property(var_script, 'handle'), var_handle_mutated)) {
			return var_script.clone()
		}
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) append_script_and_deps_src(var_script rt.PhpVal) {
	mut var_script_mutated := var_script
	mut var_wp_scripts := rt.call_function('wp_scripts', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_script_mutated))))
		|| rt.is_true(rt.new_bool(this.scripts_to_lazy_load.array_isset(rt.get_property(var_script_mutated, 'handle'))))
		|| rt.is_true(rt.call_function('wp_script_is', [rt.get_property(var_script_mutated, 'handle'), rt.new_string('enqueued')])) {
		return
	}
	if rt.call_function('is_countable', [rt.get_property(var_script_mutated, 'deps')])
		&& rt.is_true(rt.new_int(rt.get_property(var_script_mutated, 'deps').array_count())) {
		mut iter_5 := rt.get_property(var_script_mutated, 'deps').iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_dep := item_5.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.scripts_to_lazy_load.array_isset(var_dep.clone())))))) {
				mut var_dep_script := this.get_script_from_handle(var_dep.clone())
				if !(var_dep_script.clone().is_null()) {
					this.append_script_and_deps_src(var_dep_script.clone())
				}
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_script_mutated, 'src'))))) {
		return
	}
	mut var_site_url := if !(rt.call_function('site_url', []rt.PhpVal{})).is_null() {
		rt.call_function('site_url', []rt.PhpVal{})
	} else {
		rt.call_function('wp_guess_url', []rt.PhpVal{})
	}
	mut iife_temp_6 := Class_Automattic_WooCommerce_Blocks_Utils_Utils{}
	mut iife_result_6 := iife_temp_6.wp_version_compare(rt.new_string('6.3'), rt.new_string('>='))
	if rt.is_true(iife_result_6) {
		mut var_script_before := rt.call_method(var_wp_scripts, 'get_inline_script_data', [
			rt.get_property(var_script_mutated, 'handle'),
			rt.new_string('before'),
		])
		mut var_script_after := rt.call_method(var_wp_scripts, 'get_inline_script_data', [
			rt.get_property(var_script_mutated, 'handle'),
			rt.new_string('after'),
		])
	} else {
		var_script_before = rt.call_method(var_wp_scripts, 'print_inline_script', [
			rt.get_property(var_script_mutated, 'handle'),
			rt.new_string('before'),
			rt.new_bool(false),
		])
		var_script_after = rt.call_method(var_wp_scripts, 'print_inline_script', [
			rt.get_property(var_script_mutated, 'handle'),
			rt.new_string('after'),
			rt.new_bool(false),
		])
	}
	this.scripts_to_lazy_load.array_set(rt.get_property(var_script_mutated, 'handle'), rt.create_array([
		rt.ArrayItem{
			key: 'src'
			val: if rt.is_true(rt.call_function('preg_match', [
				rt.new_string('|^(https?:)?//|'),
				rt.get_property(var_script_mutated, 'src'),
			]))
			{
				rt.get_property(var_script_mutated, 'src')
			} else {
				var_site_url.str() + (rt.get_property(var_script_mutated, 'src')).str()
			}
		},
		rt.ArrayItem{ key: 'version', val: rt.get_property(var_script_mutated, 'ver') },
		rt.ArrayItem{ key: 'before', val: var_script_before },
		rt.ArrayItem{ key: 'after', val: var_script_after },
		rt.ArrayItem{ key: 'translations', val: rt.call_method(var_wp_scripts,
			'print_translations', [
			rt.get_property(var_script_mutated, 'handle'),
			rt.new_bool(false),
		]) },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) get_cart_price_markup(var_attributes rt.PhpVal) string {
	if var_attributes.array_isset(rt.new_string('hasHiddenPrice'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_attributes.array_get(rt.new_string('hasHiddenPrice')))))) {
		return ''
	}
	mut var_price_color := if var_attributes.array_get(rt.new_string('priceColor')).array_isset(rt.new_string('color')) {
		var_attributes.array_get(rt.new_string('priceColor')).array_get(rt.new_string('color'))
	} else {
		rt.new_string('')
	}
	return '<span class="wc-block-mini-cart__amount" style="color:' +
		(rt.call_function('esc_attr', [var_price_color.clone()])).str() + '"></span>' +
		this.get_include_tax_label_markup(var_attributes.clone())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) get_include_tax_label_markup(var_attributes rt.PhpVal) string {
	if !rt.is_true(this.tax_label) {
		return ''
	}
	mut var_price_color := if var_attributes.array_get(rt.new_string('priceColor')).array_isset(rt.new_string('color')) {
		var_attributes.array_get(rt.new_string('priceColor')).array_get(rt.new_string('color'))
	} else {
		rt.new_string('')
	}
	return '<small class="wc-block-mini-cart__tax-label" style="color:' +
		(rt.call_function('esc_attr', [var_price_color.clone()])).str() + ' " hidden>' +
		(rt.call_function('esc_html', [this.tax_label])).str() + '</small>'
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_coming_soon_helper := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonHelper.class(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_rest_api_request', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_method(var_coming_soon_helper, 'is_store_coming_soon', []rt.PhpVal{})) {
		return ''
	}
	mut iife_temp_7 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_7 := iife_temp_7.is_enabled(rt.new_string('experimental-iapi-mini-cart'))
	if rt.is_true(iife_result_7)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_cart', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{}))))) {
		return this.render_experimental_iapi_mini_cart(var_attributes.clone(), var_content.clone(),
			var_block.clone())
	}
	mut iife_temp_8 := Class_Automattic_WooCommerce_Blocks_Utils_MiniCartUtils{}
	mut iife_result_8 := iife_temp_8.migrate_attributes_to_color_panel(var_attributes.clone())
	return var_content.str() + this.get_markup(iife_result_8)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) render_experimental_iapi_mini_cart(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	rt.call_function('wp_enqueue_script_module', [this.get_full_block_name()])
	mut var_integration_script_handles := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'integration_registry'), 'get_all_registered_script_handles', []rt.PhpVal{})
	mut iter_6 := var_integration_script_handles.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_handle := item_6.val
		rt.call_function('wp_enqueue_script', [var_handle.clone()])
	}
	mut var_consent :=
		rt.new_string('I acknowledge that using private APIs means my theme or plugin will inevitably break in the next version of WooCommerce')
	mut iife_temp_9 := Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState{}
	mut iife_result_9 := iife_temp_9.load_cart_state(var_consent.clone())
	mut iife_temp_10 := Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState{}
	mut iife_result_10 := iife_temp_10.load_store_config(var_consent.clone())
	mut iife_temp_11 := Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState{}
	mut iife_result_11 := iife_temp_11.load_placeholder_image(var_consent.clone())
	mut var_cart := this.get_cart_instance()
	if rt.is_true(var_cart) {
		mut iife_temp_12 := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
		mut iife_result_12 :=
			iife_temp_12.get_classes_and_styles_by_attributes(var_attributes.clone())
		mut var_classes_styles := iife_result_12
		mut var_icon_color := if var_attributes.array_get(rt.new_string('iconColor')).array_isset(rt.new_string('color')) { rt.call_function('esc_attr', [
				var_attributes.array_get(rt.new_string('iconColor')).array_get(rt.new_string('color')),
			]) } else { rt.new_string('currentColor') }
		mut var_product_count_color := if var_attributes.array_get(rt.new_string('productCountColor')).array_isset(rt.new_string('color')) { rt.call_function('esc_attr', [
				var_attributes.array_get(rt.new_string('productCountColor')).array_get(rt.new_string('color')),
			]) } else { rt.new_string('') }
		mut var_styles := rt.new_string((if rt.is_true(var_product_count_color) {
			'background:' + var_product_count_color.str()
		} else {
			''
		}).str())
		mut iife_temp_13 := Class_Automattic_WooCommerce_Blocks_Utils_MiniCartUtils{}
		mut iife_result_13 := iife_temp_13.get_svg_icon(if !(var_attributes.array_get(rt.new_string('miniCartIcon'))).is_null() {
			var_attributes.array_get(rt.new_string('miniCartIcon'))
		} else {
			rt.new_string('')
		}, var_icon_color.clone())
		mut var_icon := iife_result_13
		mut var_product_count_visibility := if var_attributes.array_isset(rt.new_string('productCountVisibility')) {
			var_attributes.array_get(rt.new_string('productCountVisibility'))
		} else {
			rt.new_string('greater_than_zero')
		}
		mut var_wrapper_classes := rt.call_function('sprintf', [
			rt.new_string('wc-block-mini-cart wp-block-woocommerce-mini-cart %s'),
			var_classes_styles.array_get(rt.new_string('classes')),
		])
		mut var_wrapper_styles := var_classes_styles.array_get(rt.new_string('styles'))
		mut var_template_part_contents := this.get_template_part_contents(false)
		var_template_part_contents = rt.call_function('do_blocks', [
			this.process_template_contents(var_template_part_contents.clone()),
		])
		mut var_cart_item_count := if rt.is_true(var_cart) {
			rt.call_method(var_cart, 'get_cart_contents_count', []rt.PhpVal{})
		} else {
			rt.new_int(0)
		}
		mut var_display_cart_price_including_tax := rt.identical(rt.call_function('get_option', [
			rt.new_string('woocommerce_tax_display_cart'),
		]), rt.new_string('incl'))
		var_cart_item_count = if rt.is_true(var_cart) {
			rt.call_method(var_cart, 'get_cart_contents_count', []rt.PhpVal{})
		} else {
			rt.new_int(0)
		}
		mut var_badge_is_visible := rt.new_bool(
			rt.is_true(rt.identical(rt.new_string('always'), var_product_count_visibility))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('never'), var_product_count_visibility))))
			&& rt.is_true(rt.greater(var_cart_item_count, rt.new_int(0))))
		mut var_formatted_subtotal := rt.new_string('')
		mut var_html := create_automattic_woocommerce_blocks_blocktypes_wp_html_tag_processor(rt.call_function('wc_price', [
			rt.call_method(var_cart, 'get_displayed_subtotal', []rt.PhpVal{}),
		]))
		mut var_on_cart_click_behaviour := if var_attributes.array_isset(rt.new_string('onCartClickBehaviour')) {
			var_attributes.array_get(rt.new_string('onCartClickBehaviour'))
		} else {
			rt.new_string('open_drawer')
		}
		if rt.is_true(var_html.next_tag(rt.new_string('bdi'))) {
			for rt.is_true(var_html.next_token()) {
				if rt.is_true(rt.identical(rt.new_string('#text'), var_html.get_token_name())) {
					var_formatted_subtotal = rt.concat(var_formatted_subtotal,
						var_html.get_modifiable_text())
				}
			}
		}
		mut var_button_aria_label_template := if var_attributes.array_isset(rt.new_string('hasHiddenPrice')) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_attributes.array_get(rt.new_string('hasHiddenPrice')))))) { rt.call_function('__', [
				rt.new_string('Number of items in the cart: %d'),
				rt.new_string('woocommerce'),
			]) } else { rt.call_function('__', [
				rt.new_string('Number of items in the cart: %1$d. Total price of %2$s'),
				rt.new_string('woocommerce'),
			]) }
		closure_15_fn := fn [var_button_aria_label_template] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_attributes := rt.new_null()
			mut var_state := rt.call_function('wp_interactivity_state', []rt.PhpVal{})
			return (if var_attributes.array_isset(rt.new_string('hasHiddenPrice'))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_attributes.array_get(rt.new_string('hasHiddenPrice')))))) {
				rt.call_function('sprintf', [var_button_aria_label_template.clone(),
					var_state.array_get(rt.new_string('totalItemsInCart'))])
			} else {
				rt.call_function('sprintf', [var_button_aria_label_template.clone(),
					var_state.array_get(rt.new_string('totalItemsInCart')),
					var_state.array_get(rt.new_string('formattedSubtotal'))])
			}).str()
		}
		rt.call_function('wp_interactivity_state', [this.get_full_block_name(),
			rt.create_array([rt.ArrayItem{ key: 'isOpen', val: false },
				rt.ArrayItem{ key: 'totalItemsInCart', val: var_cart_item_count },
				rt.ArrayItem{ key: 'shouldShowTaxLabel', val: rt.greater(rt.call_method(var_cart,
					'get_cart_contents_tax', []rt.PhpVal{}), rt.new_int(0)) },
				rt.ArrayItem{ key: 'badgeIsVisible', val: var_badge_is_visible },
				rt.ArrayItem{ key: 'formattedSubtotal', val: var_formatted_subtotal },
				rt.ArrayItem{
					key: 'drawerOverlayClass'
					val: 'wc-block-components-drawer__screen-overlay wc-block-components-drawer__screen-overlay--with-slide-out wc-block-components-drawer__screen-overlay--is-hidden'
				}, rt.ArrayItem{ key: 'buttonAriaLabel', val: rt.new_closure(closure_15_fn) }])])
		mut var_context := rt.create_array([
			rt.ArrayItem{ key: 'productCountVisibility', val: var_product_count_visibility },
		])
		rt.call_function('wp_interactivity_config', [this.get_full_block_name(),
			rt.create_array([
				rt.ArrayItem{
					key: 'displayCartPriceIncludingTax'
					val: var_display_cart_price_including_tax
				},
				rt.ArrayItem{ key: 'onCartClickBehaviour', val: var_on_cart_click_behaviour },
				rt.ArrayItem{ key: 'checkoutUrl', val: rt.call_function('wc_get_checkout_url',
					[]rt.PhpVal{}) },
				rt.ArrayItem{ key: 'buttonAriaLabelTemplate', val: var_button_aria_label_template },
			])])
		mut var_cart_always_shows_price := rt.new_bool(
			var_attributes.array_isset(rt.new_string('hasHiddenPrice'))
			&& rt.is_true(rt.identical(rt.new_bool(false), var_attributes.array_get(rt.new_string('hasHiddenPrice')))))
		mut var_price_color := if var_attributes.array_get(rt.new_string('priceColor')).array_isset(rt.new_string('color')) {
			var_attributes.array_get(rt.new_string('priceColor')).array_get(rt.new_string('color'))
		} else {
			rt.new_string('')
		}
		mut var_button_role := rt.new_string((if rt.is_true(rt.identical(rt.new_string('navigate_to_checkout'),
			var_on_cart_click_behaviour))
		{
			'role="link"'
		} else {
			''
		}).str())
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_action', [
			rt.new_string('wp_footer'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', [
					'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
				], &this) },
				rt.ArrayItem{ key: none, val: 'render_experimental_iapi_mini_cart_overlay' },
			]),
		])))))
		{
			rt.call_function('add_action', [rt.new_string('wp_footer'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', [
						'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
					], &this) },
					rt.ArrayItem{ key: none, val: 'render_experimental_iapi_mini_cart_overlay' },
				])])
		}
		rt.call_function('ob_start', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.identical(rt.new_string('open_drawer'),
			var_attributes.array_get(rt.new_string('addToCartBehaviour'))))
		{
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_interactivity_data_wp_context', [
			var_context.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_wrapper_classes.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_wrapper_styles.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_button_role)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_icon)
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('never'),
			var_product_count_visibility))))
		{
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_styles.clone()]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_cart_always_shows_price) {
			// unsupported statement: Stmt_InlineHTML
			print('color:' + (rt.call_function('esc_attr', [var_price_color.clone()])).str())
			// unsupported statement: Stmt_InlineHTML
			if !(!rt.is_true(this.tax_label)) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_price_color.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [this.tax_label]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		return (rt.call_function('ob_get_clean', []rt.PhpVal{})).str()
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) render_experimental_iapi_mini_cart_overlay() {
	mut var_template_part_contents := this.get_template_part_contents(false)
	var_template_part_contents = rt.call_function('do_blocks', [
		this.process_template_contents(var_template_part_contents.clone()),
	])
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_template_part_contents)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_interactivity_process_directives', [
		rt.call_function('ob_get_clean', []rt.PhpVal{}),
	]))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) process_template_contents(var_template_contents rt.PhpVal) rt.PhpVal {
	mut var_at := rt.new_null()
	mut var_length := rt.new_null()
	mut var_p :=
		create_automattic_woocommerce_blocks_blocktypes_wp_html_tag_processor(var_template_contents.clone())
	mut var_is_old_template := var_p.next_tag(rt.create_array([
		rt.ArrayItem{ key: 'tag_name', val: 'div' },
		rt.ArrayItem{ key: 'class_name', val: 'wp-block-woocommerce-mini-cart-contents' },
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_old_template)))) {
		return var_template_contents.clone()
	}
	mut var_output := rt.new_string('')
	mut var_was_at := rt.new_int(0)
	mut var_is_mini_cart_block_stack := rt.create_array([
		rt.ArrayItem{ key: none, val: false },
	])
	mut iife_temp_15 := Class_Automattic_Block_Delimiter{}
	mut iife_result_15 := iife_temp_15.scan_delimiters(var_template_contents.clone())
	mut iter_7 := iife_result_15.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_delimiter := item_7.val
		mut var_where := item_7.key
		mut list_tmp_1 := var_where
		var_at = list_tmp_1.array_get(0)
		var_length = list_tmp_1.array_get(1)
		mut var_block_type := rt.call_method(var_delimiter, 'allocate_and_return_block_type',
			[]rt.PhpVal{})
		mut var_delimiter_type := rt.call_method(var_delimiter, 'get_delimiter_type', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(var_is_mini_cart_block_stack.array_get(rt.call_function('array_key_last', [
			var_is_mini_cart_block_stack.clone(),
		]))))))
		{
			var_output = rt.concat(var_output, rt.call_function('substr', [
				var_template_contents.clone(), var_was_at.clone(),
				rt.sub(rt.add(var_at, var_length), var_was_at)]))
		} else {
			var_output = rt.concat(var_output, rt.call_function('substr', [
				var_template_contents.clone(), var_at.clone(),
				var_length.clone()]))
		}
		var_was_at = rt.add(var_at, var_length)
		if rt.is_true(rt.identical(Class_Automattic_Block_Delimiter.opener(), var_delimiter_type)) {
			var_is_mini_cart_block_stack.array_push(rt.call_function('in_array', [
				var_block_type.clone(),
				Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart.mini_cart_template_blocks(),
				rt.new_bool(true),
			]))
		} else if rt.is_true(rt.identical(Class_Automattic_Block_Delimiter.closer(),
			var_delimiter_type))
		{
			rt.call_function('array_pop', [var_is_mini_cart_block_stack.clone()])
		}
	}
	var_output = rt.concat(var_output, rt.call_function('substr', [
		var_template_contents.clone(), var_was_at.clone()]))
	return var_output.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) get_template_part_contents(do_blocks bool) rt.PhpVal {
	mut var_template_name := rt.new_string('mini-cart')
	mut var_template_part_contents := rt.new_string('')
	mut iife_temp_16 := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}
	mut iife_result_16 := iife_temp_16.get_block_templates_from_db(rt.create_array([
		rt.ArrayItem{ key: none, val: var_template_name },
	]), rt.new_string('wp_template_part'))
	mut var_templates_from_db := iife_result_16
	if rt.call_function('is_countable', [var_templates_from_db.clone()])
		&& var_templates_from_db.clone().array_count() > 0 {
		mut var_template_slug_to_load := rt.get_property(var_templates_from_db.array_get(rt.new_int(0)),
			'theme')
	} else {
		mut iife_temp_17 := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}
		mut iife_result_17 := iife_temp_17.theme_has_template_part(var_template_name.clone())
		mut var_theme_has_mini_cart := iife_result_17
		var_template_slug_to_load = if rt.is_true(var_theme_has_mini_cart) {
			rt.call_function('get_stylesheet', []rt.PhpVal{})
		} else {
			Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.plugin_slug()
		}
	}
	mut var_template_part := rt.call_function('get_block_template', [
		rt.new_string(var_template_slug_to_load.str() + '//' + var_template_name.str()),
		rt.new_string('wp_template_part'),
	])
	if rt.is_true(var_template_part)
		&& !(!rt.is_true(rt.get_property(var_template_part, 'content'))) {
		if var_do_blocks {
			var_template_part_contents = rt.call_function('do_blocks', [
				rt.get_property(var_template_part, 'content'),
			])
		} else {
			var_template_part_contents = rt.get_property(var_template_part, 'content')
		}
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_template_part_contents)) {
		mut iife_temp_18 := Class_Automattic_WooCommerce_Blocks_Package{}
		mut iife_result_18 := iife_temp_18.get_path()
		mut iife_temp_19 := Class_Automattic_WooCommerce_Blocks_Package{}
		mut iife_result_19 := iife_temp_19.get_path()
		mut var_file_contents := rt.call_function('file_get_contents', [
			rt.new_string(iife_result_18.str() + 'templates/' +
				(Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.directory_names().array_get(rt.new_string('TEMPLATE_PARTS'))).str() + '/' + var_template_name.str() +
				'.html'),
		])
		if var_do_blocks {
			var_template_part_contents = rt.call_function('do_blocks', [
				var_file_contents.clone()])
		} else {
			var_template_part_contents = var_file_contents.clone()
		}
	}
	return var_template_part_contents.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) get_markup(var_attributes rt.PhpVal) string {
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
		|| rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_rest_api_request', []rt.PhpVal{})) {
		return ''
	}
	mut iife_temp_20 := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
	mut iife_result_20 := iife_temp_20.get_classes_and_styles_by_attributes(var_attributes.clone())
	mut var_classes_styles := iife_result_20
	mut var_wrapper_classes := rt.call_function('sprintf', [
		rt.new_string('wc-block-mini-cart wp-block-woocommerce-mini-cart %s'),
		var_classes_styles.array_get(rt.new_string('classes')),
	])
	mut var_wrapper_styles := var_classes_styles.array_get(rt.new_string('styles'))
	mut var_icon_color := if var_attributes.array_get(rt.new_string('iconColor')).array_isset(rt.new_string('color')) { rt.call_function('esc_attr', [
			var_attributes.array_get(rt.new_string('iconColor')).array_get(rt.new_string('color')),
		]) } else { rt.new_string('currentColor') }
	mut var_product_count_color := if var_attributes.array_get(rt.new_string('productCountColor')).array_isset(rt.new_string('color')) { rt.call_function('esc_attr', [
			var_attributes.array_get(rt.new_string('productCountColor')).array_get(rt.new_string('color')),
		]) } else { rt.new_string('') }
	mut var_styles := rt.new_string((if rt.is_true(var_product_count_color) {
		'background:' + var_product_count_color.str()
	} else {
		''
	}).str())
	mut iife_temp_21 := Class_Automattic_WooCommerce_Blocks_Utils_MiniCartUtils{}
	mut iife_result_21 := iife_temp_21.get_svg_icon(if !(var_attributes.array_get(rt.new_string('miniCartIcon'))).is_null() {
		var_attributes.array_get(rt.new_string('miniCartIcon'))
	} else {
		rt.new_string('')
	}, var_icon_color.clone())
	mut var_icon := iife_result_21
	mut var_product_count_visibility := if var_attributes.array_isset(rt.new_string('productCountVisibility')) {
		var_attributes.array_get(rt.new_string('productCountVisibility'))
	} else {
		rt.new_string('greater_than_zero')
	}
	mut var_button_html := rt.new_string(
		'<span class="wc-block-mini-cart__quantity-badge">\n\t\t\t' + var_icon.str() + '\n\t\t\t' +
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('never'), var_product_count_visibility)))) { '<span class="wc-block-mini-cart__badge" style="' +
		(rt.call_function('esc_attr', [var_styles.clone()])).str() + '"></span>' } else { '' } +
		'\n\t\t</span>\n\t\t' + this.get_cart_price_markup(var_attributes.clone()))
	if rt.is_true(rt.call_function('is_cart', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{})) {
		if this.should_not_render_mini_cart(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](var_attributes)) {
			return ''
		}
		return '<div class="' +
			(rt.call_function('esc_attr', [var_wrapper_classes.clone()])).str() +
			'" style="visibility:hidden" aria-hidden="true">\n\t\t\t\t<button class="wc-block-mini-cart__button" disabled aria-label="' +
			(rt.call_function('__', [rt.new_string('Cart'), rt.new_string('woocommerce')])).str() +
			'">' + var_button_html.str() + '</button>\n\t\t\t</div>'
	}
	mut var_template_part_contents := this.get_template_part_contents(false)
	return '<div class="' + (rt.call_function('esc_attr', [var_wrapper_classes.clone()])).str() +
		'" style="' + (rt.call_function('esc_attr', [var_wrapper_styles.clone()])).str() +
		'">\n\t\t\t<button class="wc-block-mini-cart__button" aria-label="' +
		(rt.call_function('__', [rt.new_string('Cart'), rt.new_string('woocommerce')])).str() +
		'">' + var_button_html.str() +
		'</button>\n\t\t\t<div class="is-loading wc-block-components-drawer__screen-overlay wc-block-components-drawer__screen-overlay--is-hidden" aria-hidden="true">\n\t\t\t\t<div class="wc-block-mini-cart__drawer wc-block-components-drawer">\n\t\t\t\t\t<div class="wc-block-components-drawer__content">\n\t\t\t\t\t\t<div class="wc-block-mini-cart__template-part">' +
		(rt.call_function('wp_kses_post', [var_template_part_contents.clone()])).str() +
		'</div>\n\t\t\t\t\t</div>\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t</div>'
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) get_cart_instance() rt.PhpVal {
	mut var_cart := rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart')
	if rt.is_true(var_cart)
		&& rt.is_true(rt.new_bool(rt.instance_of(var_cart, 'Automattic_WooCommerce_Blocks_BlockTypes_WC_Cart'))) {
		return var_cart.clone()
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) get_tax_label() rt.PhpVal {
	mut var_cart := this.get_cart_instance()
	if rt.is_true(var_cart)
		&& rt.is_true(rt.call_method(var_cart, 'display_prices_including_tax', []rt.PhpVal{})) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_prices_include_tax',
			[]rt.PhpVal{})))))
		{
			mut var_tax_label := rt.call_method(rt.get_property(rt.call_function('WC',
				[]rt.PhpVal{}), 'countries'), 'inc_tax_or_vat', []rt.PhpVal{})
			mut var_display_cart_prices_including_tax := rt.new_bool(true)
			return rt.create_array([rt.ArrayItem{ key: 'tax_label', val: var_tax_label },
				rt.ArrayItem{
					key: 'display_cart_prices_including_tax'
					val: var_display_cart_prices_including_tax
				}])
		}
		return rt.create_array([rt.ArrayItem{ key: 'tax_label', val: '' },
			rt.ArrayItem{ key: 'display_cart_prices_including_tax', val: true }])
	}
	if rt.is_true(rt.call_function('wc_prices_include_tax', []rt.PhpVal{})) {
		var_tax_label = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
			'countries'), 'ex_tax_or_vat', []rt.PhpVal{})
		return rt.create_array([rt.ArrayItem{ key: 'tax_label', val: var_tax_label },
			rt.ArrayItem{ key: 'display_cart_prices_including_tax', val: false }])
	}
	return rt.create_array([rt.ArrayItem{ key: 'tax_label', val: '' },
		rt.ArrayItem{ key: 'display_cart_prices_including_tax', val: false }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) get_inner_blocks_translations() rt.PhpVal {
	mut var_wp_scripts := rt.call_function('wp_scripts', []rt.PhpVal{})
	mut var_translations := rt.new_array()
	mut var_chunks := this.get_chunks_paths(this.chunks_folder)
	mut var_vendor_chunks :=
		this.get_chunks_paths(rt.new_string('vendors--mini-cart-contents-block'))
	mut var_shared_chunks := rt.create_array([
		rt.ArrayItem{
			key: none
			val: 'cart-blocks/cart-line-items--mini-cart-contents-block/products-table-frontend'
		},
	])
	mut iter_8 := rt.call_function('array_merge', [var_chunks.clone(),
		var_vendor_chunks.clone(), var_shared_chunks.clone()]).iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_chunk := item_8.val
		mut var_handle := rt.new_string('wc-blocks-' + var_chunk.str() + '-chunk')
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
		], &this), 'asset_api'), 'register_script', [var_handle.clone(),
			rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this), 'asset_api'), 'get_block_asset_build_path', [
				var_chunk.clone(),
			]),
			rt.new_array(), rt.new_bool(true)])
		var_translations.array_push(rt.call_method(var_wp_scripts, 'print_translations', [
			var_handle.clone(),
			rt.new_bool(false),
		]))
		rt.call_function('wp_deregister_script', [var_handle.clone()])
	}
	var_translations = rt.call_function('array_filter', [var_translations.clone()])
	return rt.call_function('implode', [rt.new_string('\n'), var_translations.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) register_empty_cart_message_block_pattern() {
	rt.call_function('register_block_pattern', [
		rt.new_string('woocommerce/mini-cart-empty-cart-message'),
		rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Empty Mini-Cart Message'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'inserter', val: false },
			rt.ArrayItem{ key: 'content', val:
				'<!-- wp:paragraph {"align":"center"} --><p class="has-text-align-center"><strong>' +
				(rt.call_function('__', [rt.new_string('Your cart is currently empty!'), rt.new_string('woocommerce')])).str() +
				'</strong></p><!-- /wp:paragraph -->' },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) should_not_render_mini_cart(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array) bool {
	return var_attributes.array_isset(rt.new_string('cartAndCheckoutRenderStyle'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('hidden'), var_attributes.array_get(rt.new_string('cartAndCheckoutRenderStyle'))))))
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Package {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_MiniCartUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_Automattic_Block_Delimiter {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_minicart(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart{
		PhpObjectBase:                     rt.PhpObjectBase{}
		block_name:                        rt.new_string('mini-cart')
		chunks_folder:                     rt.new_string('mini-cart-contents-block')
		scripts_to_lazy_load:              rt.new_array()
		tax_label:                         rt.new_string('')
		display_cart_prices_including_tax: rt.new_bool(false)
		hooked_block_placements:           rt.new_array()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
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

fn create_automattic_woocommerce_blocks_blocktypes_wp_block_type_registry(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Block_Type_Registry {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_blocktemplateutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_package(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Package {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Package{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_Utils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_minicartutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_MiniCartUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_MiniCartUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_blockssharedstate(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_styleattributesutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_wp_html_tag_processor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_block_delimiter(_args ...rt.PhpVal) &Class_Automattic_Block_Delimiter {
	mut obj := &Class_Automattic_Block_Delimiter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Assets_Api](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'enable_interactivity_support' {
			this.enable_interactivity_support()
			return rt.new_null()
		}
		'modify_hooked_block_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return this.modify_hooked_block_attributes(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		'get_block_type_editor_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_type_editor_script(dispatch_arg_0)
		}
		'get_block_type_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_type_script(dispatch_arg_0)
		}
		'get_block_type_style' {
			return this.get_block_type_style()
		}
		'enqueue_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.enqueue_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		'print_lazy_load_scripts' {
			this.print_lazy_load_scripts()
			return rt.new_null()
		}
		'get_script_from_handle' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_script_from_handle(dispatch_arg_0)
		}
		'append_script_and_deps_src' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.append_script_and_deps_src(dispatch_arg_0)
			return rt.new_null()
		}
		'get_cart_price_markup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_cart_price_markup(dispatch_arg_0))
		}
		'get_include_tax_label_markup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_include_tax_label_markup(dispatch_arg_0))
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'render_experimental_iapi_mini_cart' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render_experimental_iapi_mini_cart(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2))
		}
		'render_experimental_iapi_mini_cart_overlay' {
			this.render_experimental_iapi_mini_cart_overlay()
			return rt.new_null()
		}
		'process_template_contents' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.process_template_contents(dispatch_arg_0)
		}
		'get_template_part_contents' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_template_part_contents(dispatch_arg_0)
		}
		'get_markup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_markup(dispatch_arg_0))
		}
		'get_cart_instance' {
			return this.get_cart_instance()
		}
		'get_tax_label' {
			return this.get_tax_label()
		}
		'get_inner_blocks_translations' {
			return this.get_inner_blocks_translations()
		}
		'register_empty_cart_message_block_pattern' {
			this.register_empty_cart_message_block_pattern()
			return rt.new_null()
		}
		'should_not_render_mini_cart' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.should_not_render_mini_cart(mut dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		'chunks_folder' { return this.chunks_folder }
		'scripts_to_lazy_load' { return this.scripts_to_lazy_load }
		'tax_label' { return this.tax_label }
		'display_cart_prices_including_tax' { return this.display_cart_prices_including_tax }
		'hooked_block_placements' { return this.hooked_block_placements }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' {
			this.block_name = val
			return true
		}
		'chunks_folder' {
			this.chunks_folder = val
			return true
		}
		'scripts_to_lazy_load' {
			this.scripts_to_lazy_load = val
			return true
		}
		'tax_label' {
			this.tax_label = val
			return true
		}
		'display_cart_prices_including_tax' {
			this.display_cart_prices_including_tax = val
			return true
		}
		'hooked_block_placements' {
			this.hooked_block_placements = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Block_Type_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Block_Type_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Block_Type_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_MiniCartUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_MiniCartUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_MiniCartUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_Block_Delimiter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Block_Delimiter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Block_Delimiter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
