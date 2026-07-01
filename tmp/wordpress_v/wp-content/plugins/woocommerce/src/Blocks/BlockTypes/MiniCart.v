import rt

pub fn Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart.mini_cart_template_blocks() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart-contents' }, rt.ArrayItem{ key: none, val: 'woocommerce/filled-mini-cart-contents-block' }, rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart-title-block' }, rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart-title-label-block' }, rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart-title-items-counter-block' }, rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart-items-block' }, rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart-products-table-block' }, rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart-footer-block' }, rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart-cart-button-block' }, rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart-checkout-button-block' }, rt.ArrayItem{ key: none, val: 'woocommerce/empty-mini-cart-contents-block' }, rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart-shopping-button-block' }])
}
struct Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart {
	rt.PhpObjectBase
pub mut:
		block_name rt.PhpVal = rt.new_string('mini-cart')
		chunks_folder rt.PhpVal = rt.new_string('mini-cart-contents-block')
		scripts_to_lazy_load rt.PhpVal = rt.new_array()
		tax_label rt.PhpVal = rt.new_string('')
		display_cart_prices_including_tax rt.PhpVal = rt.new_bool(false)
		hooked_block_placements rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) construct(mut var_asset_api Class_Automattic_WooCommerce_Blocks_Assets_Api, mut var_asset_data_registry Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry, mut var_integration_registry Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry)  {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.construct(rt.new_object('Automattic_WooCommerce_Blocks_Assets_Api', []string{}, var_asset_api), rt.new_object('Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry', []string{}, var_asset_data_registry), rt.new_object('Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry', []string{}, var_integration_registry), this.block_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) initialize()  {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.initialize()
	rt.call_function('add_action', [rt.new_string('wp_loaded'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'register_empty_cart_message_block_pattern' }])])
	rt.call_function('add_action', [rt.new_string('wp_print_footer_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'print_lazy_load_scripts' }]), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('hooked_block_woocommerce/mini-cart'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'modify_hooked_block_attributes' }]), rt.new_int(10), rt.new_int(5)])
	rt.call_function('add_filter', [rt.new_string('hooked_block_types'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'register_hooked_block' }]), rt.new_int(9), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'enable_interactivity_support' }]), rt.new_int(20)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) enable_interactivity_support()  {
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.is_enabled(arg_0) }(rt.new_string('experimental-iapi-mini-cart'))) {
		mut var_block_type := rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Block_Type_Registry{}; return temp.get_instance() }(), 'get_registered', [rt.new_string('woocommerce/mini-cart')])
		if rt.is_true(var_block_type) {
			rt.get_property(var_block_type, 'supports').array_set('interactivity', true)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) modify_hooked_block_attributes(var_parsed_hooked_block rt.PhpVal, var_hooked_block_type rt.PhpVal, var_relative_position rt.PhpVal, var_parsed_anchor_block rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_context_mutated := var_context
	mut var_mini_cart_block_font_size := rt.call_function('wp_get_global_styles', [rt.create_array([rt.ArrayItem{ key: none, val: 'blocks' }, rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart' }, rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'fontSize' }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_mini_cart_block_font_size.dup().is_string()))))) {
		mut var_navigation_block_font_size := rt.call_function('wp_get_global_styles', [rt.create_array([rt.ArrayItem{ key: none, val: 'blocks' }, rt.ArrayItem{ key: none, val: 'core/navigation' }, rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'fontSize' }])])
		if rt.is_true(rt.new_bool(var_navigation_block_font_size.dup().is_string())) {
			var_parsed_hooked_block.array_get_mut('attrs').array_get_mut('style').array_get_mut('typography').array_set('fontSize', var_navigation_block_font_size.dup())
		}
	}
	return var_parsed_hooked_block.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) get_block_type_editor_script(var_key rt.PhpVal) rt.PhpVal {
	mut var_script := rt.create_array([rt.ArrayItem{ key: 'handle', val: 'wc-' + (this.block_name).str() + '-block' }, rt.ArrayItem{ key: 'path', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_api'), 'get_block_asset_build_path', [this.block_name]) }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc-blocks' }]) }])
	return if rt.is_true(var_key) { var_script.array_get(var_key) } else { var_script }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_cart', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{})))) || rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.is_enabled(arg_0) }(rt.new_string('experimental-iapi-mini-cart'))))) {
		return rt.new_null()
	}
	mut var_script := rt.create_array([rt.ArrayItem{ key: 'handle', val: 'wc-' + (this.block_name).str() + '-block-frontend' }, rt.ArrayItem{ key: 'path', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_api'), 'get_block_asset_build_path', [(this.block_name).str() + '-frontend']) }, rt.ArrayItem{ key: 'dependencies', val: rt.new_array() }])
	return if rt.is_true(var_key) { var_script.array_get(var_key) } else { var_script }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) get_block_type_style() rt.PhpVal {
	return rt.call_function('array_merge', [this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.get_block_type_style(), rt.create_array([rt.ArrayItem{ key: none, val: 'wc-blocks-packages-style' }])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array)  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_cart', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{})))) {
		return rt.new_null()
	}
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array', []string{}, var_attributes))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_rest_api_request', []rt.PhpVal{}))))))) {
		mut var_label_info := this.get_tax_label()
		this.tax_label = var_label_info.array_get('tax_label')
		this.display_cart_prices_including_tax = var_label_info.array_get('display_cart_prices_including_tax')
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('taxLabel'), this.tax_label])
	}
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('displayCartPricesIncludingTax'), this.display_cart_prices_including_tax])
	mut var_template_part_edit_uri := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')])) && rt.is_true(rt.new_bool(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) || rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('block-template-parts')])))))) {
		mut var_theme_slug := if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}; return temp.theme_has_template_part(arg_0) }(rt.new_string('mini-cart'))) { rt.call_method(rt.call_function('wp_get_theme', []rt.PhpVal{}), 'get_stylesheet', []rt.PhpVal{}) } else { Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.plugin_slug() }
		if rt.is_true(rt.call_function('version_compare', [rt.call_function('get_bloginfo', [rt.new_string('version')]), rt.new_string('5.9'), rt.new_string('<')])) {
			mut var_site_editor_uri := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'page', val: 'gutenberg-edit-site' }]), rt.call_function('admin_url', [rt.new_string('themes.php')])])
		} else {
			var_site_editor_uri = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'canvas', val: 'edit' }, rt.ArrayItem{ key: 'path', val: '/template-parts/single' }]), rt.call_function('admin_url', [rt.new_string('site-editor.php')])])
		}
		var_template_part_edit_uri = rt.call_function('esc_url_raw', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'postId', val: rt.call_function('sprintf', [rt.new_string('%s//%s'), var_theme_slug.dup(), rt.new_string('mini-cart')]) }, rt.ArrayItem{ key: 'postType', val: 'wp_template_part' }]), var_site_editor_uri.dup()])])
	}
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('templatePartEditUri'), var_template_part_edit_uri.dup()])
	rt.call_function('do_action', [rt.new_string('woocommerce_blocks_cart_enqueue_data')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) print_lazy_load_scripts()  {
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.is_enabled(arg_0) }(rt.new_string('experimental-iapi-mini-cart'))) {
		return rt.new_null()
	}
	mut var_script_data := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_api'), 'get_script_data', [rt.new_string('assets/client/blocks/mini-cart-component-frontend.js')])
	mut var_num_dependencies := rt.new_int(if rt.is_true(rt.call_function('is_countable', [var_script_data.array_get('dependencies')])) { rt.new_int(var_script_data.array_get('dependencies').array_count()) } else { rt.new_int(0) })
	mut var_wp_scripts := rt.call_function('wp_scripts', []rt.PhpVal{})
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, var_num_dependencies))) { break }
			mut var_dependency := var_script_data.array_get('dependencies').array_get(var_i)
			{
				mut iter_1 := rt.get_property(var_wp_scripts, 'registered').iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_script := item_1.val
					if rt.is_true(rt.identical(rt.get_property(var_script, 'handle'), var_dependency)) {
						this.append_script_and_deps_src(var_script.dup())
						break
					}
				}
			}
			rt.post_inc(var_i)
		}
	}
	mut var_payment_method_registry := rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Package{}; return temp.container() }(), 'get', [Class_Automattic_WooCommerce_Blocks_Payments_PaymentMethodRegistry.class()])
	mut var_payment_methods := rt.call_method(var_payment_method_registry, 'get_all_active_payment_method_script_dependencies', []rt.PhpVal{})
	{
		mut iter_1 := var_payment_methods.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_payment_method := item_1.val
			mut var_payment_method_script := this.get_script_from_handle(var_payment_method.dup())
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_payment_method_script.dup().is_null()))))) {
				this.append_script_and_deps_src(var_payment_method_script.dup())
			}
		}
	}
	this.scripts_to_lazy_load.array_set('wc-block-mini-cart-component-frontend', rt.create_array([rt.ArrayItem{ key: 'src', val: var_script_data.array_get('src') }, rt.ArrayItem{ key: 'version', val: var_script_data.array_get('version') }, rt.ArrayItem{ key: 'translations', val: this.get_inner_blocks_translations() }]))
	mut var_inner_blocks_frontend_scripts := rt.new_array()
	mut var_cart := this.get_cart_instance()
	if rt.is_true(var_cart) {
		var_inner_blocks_frontend_scripts = if rt.is_true(rt.call_method(var_cart, 'is_empty', []rt.PhpVal{})) { rt.create_array([rt.ArrayItem{ key: none, val: 'empty-cart-frontend' }, rt.ArrayItem{ key: none, val: 'filled-cart-frontend' }, rt.ArrayItem{ key: none, val: 'shopping-button-frontend' }]) } else { rt.create_array([rt.ArrayItem{ key: none, val: 'empty-cart-frontend' }, rt.ArrayItem{ key: none, val: 'filled-cart-frontend' }, rt.ArrayItem{ key: none, val: 'title-frontend' }, rt.ArrayItem{ key: none, val: 'items-frontend' }, rt.ArrayItem{ key: none, val: 'footer-frontend' }, rt.ArrayItem{ key: none, val: 'products-table-frontend' }, rt.ArrayItem{ key: none, val: 'cart-button-frontend' }, rt.ArrayItem{ key: none, val: 'checkout-button-frontend' }, rt.ArrayItem{ key: none, val: 'title-label-frontend' }, rt.ArrayItem{ key: none, val: 'title-items-counter-frontend' }]) }
	}
	{
		mut iter_1 := var_inner_blocks_frontend_scripts.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_inner_block_frontend_script := item_1.val
			var_script_data = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCart', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_api'), 'get_script_data', ['assets/client/blocks/mini-cart-contents-block/' + (var_inner_block_frontend_script).str() + '.js'])
			this.scripts_to_lazy_load.array_set('wc-block-' + (var_inner_block_frontend_script).str(), rt.create_array([rt.ArrayItem{ key: 'src', val: var_script_data.array_get('src') }, rt.ArrayItem{ key: 'version', val: var_script_data.array_get('version') }]))
		}
	}
	mut var_data := rt.call_function('rawurlencode', [rt.call_function('wp_json_encode', [this.scripts_to_lazy_load])])
	mut var_mini_cart_dependencies_script := rt.new_string('var wcBlocksMiniCartFrontendDependencies = JSON.parse( decodeURIComponent( \'' + (rt.call_function('esc_js', [var_data.dup()])).str() + '\' ) );')
	rt.call_function('wp_add_inline_script', [rt.new_string('wc-mini-cart-block-frontend'), var_mini_cart_dependencies_script.dup(), rt.new_string('before')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) get_script_from_handle(var_handle rt.PhpVal) rt.PhpVal {
	mut var_handle_mutated := var_handle
	mut var_wp_scripts := rt.call_function('wp_scripts', []rt.PhpVal{})
	{
		mut iter_1 := rt.get_property(var_wp_scripts, 'registered').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_script := item_1.val
			if rt.is_true(rt.identical(rt.get_property(var_script, 'handle'), var_handle_mutated)) {
				return var_script.dup()
			}
		}
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) append_script_and_deps_src(var_script rt.PhpVal)  {
	mut var_script_mutated := var_script
	mut var_wp_scripts := rt.call_function('wp_scripts', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_script_mutated)))) || rt.is_true(rt.new_bool(this.scripts_to_lazy_load.array_isset(rt.get_property(var_script_mutated, 'handle')))))) || rt.is_true(rt.call_function('wp_script_is', [rt.get_property(var_script_mutated, 'handle'), rt.new_string('enqueued')])))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_countable', [rt.get_property(var_script_mutated, 'deps')])) && rt.is_true(rt.new_int(rt.get_property(var_script_mutated, 'deps').array_count())))) {
		{
			mut iter_1 := rt.get_property(var_script_mutated, 'deps').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_dep := item_1.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.scripts_to_lazy_load.array_isset(var_dep.dup())))))) {
					mut var_dep_script := this.get_script_from_handle(var_dep.dup())
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_dep_script.dup().is_null()))))) {
						this.append_script_and_deps_src(var_dep_script.dup())
					}
				}
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_script_mutated, 'src'))))) {
		return rt.new_null()
	}
	mut var_site_url := if !(rt.call_function('site_url', []rt.PhpVal{})).is_null() { rt.call_function('site_url', []rt.PhpVal{}) } else { rt.call_function('wp_guess_url', []rt.PhpVal{}) }
	if rt.is_true(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_Utils{}; return temp.wp_version_compare(arg_0, arg_1) }(rt.new_string('6.3'), rt.new_string('>='))) {
		mut var_script_before := rt.call_method(var_wp_scripts, 'get_inline_script_data', [rt.get_property(var_script_mutated, 'handle'), rt.new_string('before')])
		mut var_script_after := rt.call_method(var_wp_scripts, 'get_inline_script_data', [rt.get_property(var_script_mutated, 'handle'), rt.new_string('after')])
	} else {
		var_script_before = rt.call_method(var_wp_scripts, 'print_inline_script', [rt.get_property(var_script_mutated, 'handle'), rt.new_string('before'), rt.new_bool(false)])
		var_script_after = rt.call_method(var_wp_scripts, 'print_inline_script', [rt.get_property(var_script_mutated, 'handle'), rt.new_string('after'), rt.new_bool(false)])
	}
	this.scripts_to_lazy_load.array_set(rt.get_property(var_script_mutated, 'handle'), rt.create_array([rt.ArrayItem{ key: 'src', val: if rt.is_true(rt.call_function('preg_match', [rt.new_string('|^(https?:)?//|'), rt.get_property(var_script_mutated, 'src')])) { rt.get_property(var_script_mutated, 'src') } else { rt.concat(var_site_url, rt.get_property(var_script_mutated, 'src')) } }, rt.ArrayItem{ key: 'version', val: rt.get_property(var_script_mutated, 'ver') }, rt.ArrayItem{ key: 'before', val: var_script_before }, rt.ArrayItem{ key: 'after', val: var_script_after }, rt.ArrayItem{ key: 'translations', val: rt.call_method(var_wp_scripts, 'print_translations', [rt.get_property(var_script_mutated, 'handle'), rt.new_bool(false)]) }]))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) get_cart_price_markup(var_attributes rt.PhpVal) string {
	if rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('hasHiddenPrice')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return ''
	}
	mut var_price_color := if var_attributes.array_get('priceColor').array_isset(rt.new_string('color')) { var_attributes.array_get('priceColor').array_get('color') } else { rt.new_string('') }
	return '<span class="wc-block-mini-cart__amount" style="color:' + (rt.call_function('esc_attr', [var_price_color.dup()])).str() + '"></span>' + this.get_include_tax_label_markup(var_attributes.dup())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) get_include_tax_label_markup(var_attributes rt.PhpVal) string {
	if !rt.is_true(this.tax_label) {
		return ''
	}
	mut var_price_color := if var_attributes.array_get('priceColor').array_isset(rt.new_string('color')) { var_attributes.array_get('priceColor').array_get('color') } else { rt.new_string('') }
	return  + ().str() + ' " hidden>' + (rt.call_function('esc_html', [this.tax_label])).str() + '</small>'
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_coming_soon_helper := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonHelper.class()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true() && rt.is_true())) && rt.is_true(rt.call_method(, 'is_store_coming_soon', []rt.PhpVal{})))) {
		return ''
	}
	if rt.is_true(rt.new_bool(rt.is_true() && rt.is_true())) {
		return 
	}
	return 
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) render_experimental_iapi_mini_cart(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) render_experimental_iapi_mini_cart_overlay()  {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) process_template_contents(var_template_contents rt.PhpVal) rt.PhpVal {
	mut var_at := rt.new_null()
	mut var_length := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) get_template_part_contents(do_blocks bool) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) get_markup(var_attributes rt.PhpVal) string {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) get_cart_instance() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) get_tax_label() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) get_inner_blocks_translations() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) register_empty_cart_message_block_pattern()  {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) should_not_render_mini_cart(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array) bool {
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

fn create_automattic_woocommerce_blocks_blocktypes_minicart(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name: rt.new_string('mini-cart')
		chunks_folder: rt.new_string('mini-cart-contents-block')
		scripts_to_lazy_load: rt.new_array()
		tax_label: rt.new_string('')
		display_cart_prices_including_tax: rt.new_bool(false)
		hooked_block_placements: rt.new_array()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features() &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_wp_block_type_registry() &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Block_Type_Registry {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_blocktemplateutils() &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_package() &Class_Automattic_WooCommerce_Blocks_Package {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Package{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_utils() &Class_Automattic_WooCommerce_Blocks_Utils_Utils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCart) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Assets_Api](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry](if args.len > 2 { args[2] } else { rt.new_null() })
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
			return this.modify_hooked_block_attributes(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 { args[0] } else { rt.new_null() })
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
			return rt.new_string(this.render_experimental_iapi_mini_cart(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.should_not_render_mini_cart(mut dispatch_arg_0))
		}
		else { return none }
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
		'block_name' { this.block_name = val; return true }
		'chunks_folder' { this.chunks_folder = val; return true }
		'scripts_to_lazy_load' { this.scripts_to_lazy_load = val; return true }
		'tax_label' { this.tax_label = val; return true }
		'display_cart_prices_including_tax' { this.display_cart_prices_including_tax = val; return true }
		'hooked_block_placements' { this.hooked_block_placements = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_minicart_php() {
	// unsupported statement: Stmt_Declare
}
