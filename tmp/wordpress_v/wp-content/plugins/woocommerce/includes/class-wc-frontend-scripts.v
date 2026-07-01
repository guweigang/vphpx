import rt

struct Class_WC_Frontend_Scripts {
	rt.PhpObjectBase
pub mut:
		registered_scripts rt.PhpVal = rt.new_array()
		styles rt.PhpVal = rt.new_array()
		wp_localize_scripts rt.PhpVal = rt.new_array()
}

fn Class_WC_Frontend_Scripts.init()  {
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'load_scripts' }])])
	rt.call_function('add_action', [rt.new_string('wp_print_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'localize_printed_scripts' }]), rt.new_int(5)])
	rt.call_function('add_action', [rt.new_string('wp_print_footer_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'localize_printed_scripts' }]), rt.new_int(5)])
	rt.call_function('add_action', [rt.new_string('enqueue_block_assets'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'enqueue_block_assets' }])])
}

fn Class_WC_Frontend_Scripts.get_styles() rt.PhpVal {
	mut var_version := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_VERSION'))
	mut var_styles := rt.call_function('apply_filters', [rt.new_string('woocommerce_enqueue_styles'), rt.create_array([rt.ArrayItem{ key: 'woocommerce-layout', val: rt.create_array([rt.ArrayItem{ key: 'src', val: Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/css/woocommerce-layout.css')) }, rt.ArrayItem{ key: 'deps', val: '' }, rt.ArrayItem{ key: 'version', val: var_version }, rt.ArrayItem{ key: 'media', val: 'all' }, rt.ArrayItem{ key: 'has_rtl', val: true }]) }, rt.ArrayItem{ key: 'woocommerce-smallscreen', val: rt.create_array([rt.ArrayItem{ key: 'src', val: Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/css/woocommerce-smallscreen.css')) }, rt.ArrayItem{ key: 'deps', val: 'woocommerce-layout' }, rt.ArrayItem{ key: 'version', val: var_version }, rt.ArrayItem{ key: 'media', val: 'only screen and (max-width: ' + (rt.call_function('apply_filters', [rt.new_string('woocommerce_style_smallscreen_breakpoint'), rt.new_string('768px')])).str() + ')' }, rt.ArrayItem{ key: 'has_rtl', val: true }]) }, rt.ArrayItem{ key: 'woocommerce-general', val: rt.create_array([rt.ArrayItem{ key: 'src', val: Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/css/woocommerce.css')) }, rt.ArrayItem{ key: 'deps', val: '' }, rt.ArrayItem{ key: 'version', val: var_version }, rt.ArrayItem{ key: 'media', val: 'all' }, rt.ArrayItem{ key: 'has_rtl', val: true }]) }])])
	return if rt.is_true(rt.new_bool(var_styles.dup().is_array())) { rt.call_function('array_filter', [var_styles.dup()]) } else { rt.new_array() }
}

fn Class_WC_Frontend_Scripts.enqueue_block_assets()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	mut var_version := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_VERSION'))
	rt.call_function('wp_enqueue_style', [rt.new_string('woocommerce-blocktheme'), Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/css/woocommerce-blocktheme.css')), rt.new_array(), var_version.dup(), rt.new_string('all')])
	rt.call_function('wp_style_add_data', [rt.new_string('woocommerce-blocktheme'), rt.new_string('rtl'), rt.new_string('replace')])
}

fn Class_WC_Frontend_Scripts.get_asset_url(var_path rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_asset_url'), rt.call_function('plugins_url', [var_path.dup(), rt.get_constant('WC_PLUGIN_FILE')]), var_path.dup()])
}

fn Class_WC_Frontend_Scripts.register_script(var_handle rt.PhpVal, var_path rt.PhpVal, var_deps rt.PhpVal, var_version rt.PhpVal, var_in_footer rt.PhpVal)  {
	mut var_version_mutated := var_version
	// unsupported expression: Expr_StaticPropertyFetch.array_push(var_handle.dup())
	rt.call_function('wp_register_script', [var_handle.dup(), var_path.dup(), var_deps.dup(), var_version_mutated.dup(), var_in_footer.dup()])
}

fn Class_WC_Frontend_Scripts.enqueue_script(var_handle rt.PhpVal, path string, var_deps rt.PhpVal, var_version rt.PhpVal, var_in_footer rt.PhpVal)  {
	mut var_version_mutated := var_version
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_handle.dup(), // unsupported expression: Expr_StaticPropertyFetch, rt.new_bool(true)]))))) && var_path.len > 0 && var_path != '0')) {
		Class_WC_Frontend_Scripts.register_script(var_handle.dup(), rt.new_string(path), var_deps.dup(), var_version_mutated.dup(), var_in_footer.dup())
	}
	rt.call_function('wp_enqueue_script', [var_handle.dup()])
}

fn Class_WC_Frontend_Scripts.register_style(var_handle rt.PhpVal, var_path rt.PhpVal, var_deps rt.PhpVal, var_version rt.PhpVal, media string, has_rtl bool)  {
	mut var_version_mutated := var_version
	// unsupported expression: Expr_StaticPropertyFetch.array_push(var_handle.dup())
	rt.call_function('wp_register_style', [var_handle.dup(), var_path.dup(), var_deps.dup(), var_version_mutated.dup(), rt.new_string(media)])
	if var_has_rtl {
		rt.call_function('wp_style_add_data', [var_handle.dup(), rt.new_string('rtl'), rt.new_string('replace')])
	}
}

fn Class_WC_Frontend_Scripts.enqueue_style(var_handle rt.PhpVal, path string, var_deps rt.PhpVal, var_version rt.PhpVal, media string, has_rtl bool)  {
	mut var_version_mutated := var_version
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_handle.dup(), // unsupported expression: Expr_StaticPropertyFetch, rt.new_bool(true)]))))) && var_path.len > 0 && var_path != '0')) {
		Class_WC_Frontend_Scripts.register_style(var_handle.dup(), path, (var_deps).to_bool(), var_version_mutated.dup(), rt.new_string(media), rt.new_bool(has_rtl))
	}
	rt.call_function('wp_enqueue_style', [var_handle.dup()])
}

fn Class_WC_Frontend_Scripts.get_scripts() rt.PhpVal {
	mut var_suffix := rt.new_string(if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_true(arg_0) }(rt.new_string('SCRIPT_DEBUG'))) { rt.new_string('') } else { rt.new_string('.min') })
	mut var_version := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_VERSION'))
	mut var_scripts := { 'selectWoo': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/selectWoo/selectWoo.full' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': '1.0.9-wc.' + (var_version).str() }, 'wc-account-i18n': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/frontend/account-i18n' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': var_version }, 'wc-add-payment-method': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/frontend/add-payment-method' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': var_version }, 'wc-add-to-cart': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/frontend/add-to-cart' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': var_version }, 'wc-add-to-cart-variation': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/frontend/add-to-cart-variation' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': var_version }, 'wc-address-i18n': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/frontend/address-i18n' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': var_version }, 'wc-back-in-stock-form': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/frontend/back-in-stock-form' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': var_version }, 'wc-cart': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/frontend/cart' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': var_version }, 'wc-cart-fragments': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/frontend/cart-fragments' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': var_version }, 'wc-checkout': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/frontend/checkout' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': var_version }, 'wc-country-select': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/frontend/country-select' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': var_version }, 'wc-credit-card-form': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/frontend/credit-card-form' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': var_version }, 'wc-custom-place-order-button': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/frontend/utils/custom-place-order-button' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': var_version }, 'wc-dompurify': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/dompurify/purify' + (var_suffix).str() + '.js')), 'deps': rt.new_array(), 'version': var_version }, 'wc-flexslider': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/flexslider/jquery.flexslider' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': '2.7.2-wc.' + (var_version).str(), 'legacy_handle': rt.new_string('flexslider') }, 'wc-geolocation': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/frontend/geolocation' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': var_version }, 'wc-jquery-blockui': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/jquery-blockui/jquery.blockUI' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': '2.7.0-wc.' + (var_version).str(), 'legacy_handle': rt.new_string('jquery-blockui') }, 'wc-jquery-cookie': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/jquery-cookie/jquery.cookie' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': '1.4.1-wc.' + (var_version).str(), 'legacy_handle': rt.new_string('jquery-cookie') }, 'wc-jquery-payment': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/jquery-payment/jquery.payment' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': '3.0.0-wc.' + (var_version).str(), 'legacy_handle': rt.new_string('jquery-payment') }, 'wc-jquery-tiptip': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/jquery-tiptip/jquery.tipTip' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': var_version, 'legacy_handle': rt.new_string('jquery-tiptip') }, 'wc-js-cookie': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/js-cookie/js.cookie' + (var_suffix).str() + '.js')), 'deps': rt.new_array(), 'version': '2.1.4-wc.' + (var_version).str(), 'legacy_handle': rt.new_string('js-cookie') }, 'wc-lost-password': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/frontend/lost-password' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': var_version }, 'wc-password-strength-meter': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/frontend/password-strength-meter' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': var_version }, 'wc-photoswipe': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/photoswipe/photoswipe' + (var_suffix).str() + '.js')), 'deps': rt.new_array(), 'version': '4.1.1-wc.' + (var_version).str(), 'legacy_handle': rt.new_string('photoswipe') }, 'wc-photoswipe-ui-default': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/photoswipe/photoswipe-ui-default' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': '4.1.1-wc.' + (var_version).str(), 'legacy_handle': rt.new_string('photoswipe-ui-default') }, 'wc-prettyPhoto': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/prettyPhoto/jquery.prettyPhoto' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': '3.1.6-wc.' + (var_version).str(), 'legacy_handle': rt.new_string('prettyPhoto') }, 'wc-prettyPhoto-init': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/prettyPhoto/jquery.prettyPhoto.init' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': var_version, 'legacy_handle': rt.new_string('prettyPhoto-init') }, 'wc-select2': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/select2/select2.full' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': '4.0.3-wc.' + (var_version).str(), 'legacy_handle': rt.new_string('select2') }, 'wc-single-product': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/frontend/single-product' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': var_version }, 'wc-zoom': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/zoom/jquery.zoom' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': '1.7.21-wc.' + (var_version).str(), 'legacy_handle': rt.new_string('zoom') }, 'woocommerce': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/frontend/woocommerce' + (var_suffix).str() + '.js')), 'deps': map[string]rt.PhpVal{}, 'version': var_version } }
	if rt.is_true(rt.identical(rt.call_function('wc_string_to_bool', [rt.call_function('get_option', [rt.new_string('woocommerce_address_autocomplete_enabled'), rt.new_string('no')])]), rt.new_bool(true))) {
		var_scripts['wc-address-autocomplete-common'] = rt.create_array([rt.ArrayItem{ key: 'src', val: Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/frontend/utils/address-autocomplete-common' + (var_suffix).str() + '.js')) }, rt.ArrayItem{ key: 'deps', val: rt.new_array() }, rt.ArrayItem{ key: 'version', val: var_version }])
		var_scripts['wc-address-autocomplete'] = rt.create_array([rt.ArrayItem{ key: 'src', val: Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/js/frontend/address-autocomplete' + (var_suffix).str() + '.js')) }, rt.ArrayItem{ key: 'deps', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc-address-autocomplete-common' }, rt.ArrayItem{ key: none, val: 'wc-dompurify' }]) }, rt.ArrayItem{ key: 'version', val: var_version }])
	}
	return var_scripts.dup()
}

fn Class_WC_Frontend_Scripts.register_scripts()  {
	mut var_register_scripts := Class_WC_Frontend_Scripts.get_scripts()
	{
		mut iter_1 := var_register_scripts.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_props := item_1.val
			mut var_name := item_1.key
			Class_WC_Frontend_Scripts.register_script(var_name.dup(), var_props.array_get('src'), var_props.array_get('deps'), var_props.array_get('version'))
			if var_props.array_isset(rt.new_string('legacy_handle')) {
				Class_WC_Frontend_Scripts.register_script(var_props.array_get('legacy_handle'), rt.new_bool(false), rt.create_array([rt.ArrayItem{ key: none, val: var_name }]), var_props.array_get('version'), rt.new_bool(true))
			}
		}
	}
}

fn Class_WC_Frontend_Scripts.register_styles()  {
	mut var_version := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_VERSION'))
	mut var_register_styles := { 'photoswipe': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/css/photoswipe/photoswipe.min.css')), 'deps': rt.new_array(), 'version': var_version, 'has_rtl': rt.new_bool(false) }, 'photoswipe-default-skin': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/css/photoswipe/default-skin/default-skin.min.css')), 'deps': map[string]rt.PhpVal{}, 'version': var_version, 'has_rtl': rt.new_bool(false) }, 'select2': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/css/select2.css')), 'deps': rt.new_array(), 'version': var_version, 'has_rtl': rt.new_bool(false) }, 'woocommerce_prettyPhoto_css': { 'src': Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/css/prettyPhoto.css')), 'deps': rt.new_array(), 'version': var_version, 'has_rtl': rt.new_bool(true) } }
	if rt.is_true(rt.identical(rt.call_function('wc_string_to_bool', [rt.call_function('get_option', [rt.new_string('woocommerce_address_autocomplete_enabled'), rt.new_string('no')])]), rt.new_bool(true))) {
		var_register_styles['wc-address-autocomplete'] = rt.create_array([rt.ArrayItem{ key: 'src', val: Class_WC_Frontend_Scripts.get_asset_url(rt.new_string('assets/css/address-autocomplete.css')) }, rt.ArrayItem{ key: 'deps', val: rt.new_array() }, rt.ArrayItem{ key: 'version', val: var_version }, rt.ArrayItem{ key: 'has_rtl', val: false }])
	}
	for var_name, var_props in var_register_styles {
		Class_WC_Frontend_Scripts.register_style(rt.new_string(name), (var_props.array_get('src')).str(), (var_props.array_get('deps')).to_bool(), var_props.array_get('version'), rt.new_string('all'), var_props.array_get('has_rtl'))
	}
}

fn Class_WC_Frontend_Scripts.load_scripts()  {
	mut var_post := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('before_woocommerce_init')]))))) {
		return rt.new_null()
	}
	Class_WC_Frontend_Scripts.register_scripts()
	Class_WC_Frontend_Scripts.register_styles()
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_enable_ajax_add_to_cart')]))) {
		Class_WC_Frontend_Scripts.enqueue_script('wc-add-to-cart')
	}
	if rt.is_true(rt.call_function('is_cart', []rt.PhpVal{})) {
		Class_WC_Frontend_Scripts.enqueue_script('wc-cart')
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_cart', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{})))) || rt.is_true(rt.call_function('is_account_page', []rt.PhpVal{})))) {
		Class_WC_Frontend_Scripts.enqueue_script('selectWoo')
		Class_WC_Frontend_Scripts.enqueue_style('select2')
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [rt.new_string('woocommerce_registration_generate_password')]))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))))) || rt.is_true(rt.call_function('is_edit_account_page', []rt.PhpVal{})))) || rt.is_true(rt.call_function('is_lost_password_page', []rt.PhpVal{})))) {
			Class_WC_Frontend_Scripts.enqueue_script('wc-password-strength-meter')
		}
	}
	if rt.is_true(rt.call_function('is_account_page', []rt.PhpVal{})) {
		Class_WC_Frontend_Scripts.enqueue_script('wc-account-i18n')
	}
	if rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{})) {
		Class_WC_Frontend_Scripts.enqueue_script('wc-checkout')
	}
	if rt.is_true(rt.identical(rt.call_function('wc_string_to_bool', [rt.call_function('get_option', [rt.new_string('woocommerce_address_autocomplete_enabled'), rt.new_string('no')])]), rt.new_bool(true))) {
		mut var_address_provider_service := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_AddressProvider_AddressProviderController.class()])
		if rt.is_true(rt.new_bool(rt.is_true(var_address_provider_service) && rt.is_true(rt.call_function('method_exists', [var_address_provider_service.dup(), rt.new_string('get_providers')])))) {
			mut var_registered_providers := rt.call_method(var_address_provider_service, 'get_providers', []rt.PhpVal{})
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_registered_providers.dup().is_array())) && var_registered_providers.dup().array_count() > 0)) {
				Class_WC_Frontend_Scripts.enqueue_script('wc-address-autocomplete-common')
				Class_WC_Frontend_Scripts.enqueue_script('wc-address-autocomplete')
				Class_WC_Frontend_Scripts.enqueue_style('wc-address-autocomplete')
			}
		}
	}
	if rt.is_true(rt.call_function('is_add_payment_method_page', []rt.PhpVal{})) {
		Class_WC_Frontend_Scripts.enqueue_script('wc-add-payment-method')
	}
	if rt.is_true(rt.call_function('is_lost_password_page', []rt.PhpVal{})) {
		Class_WC_Frontend_Scripts.enqueue_script('wc-lost-password')
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_product', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))))))) || rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_property(var_post, 'post_content'))) && rt.is_true(rt.call_function('strstr', [rt.get_property(var_post, 'post_content'), rt.new_string('[product_page')])))))) {
		if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('wc-product-gallery-zoom')])) {
			Class_WC_Frontend_Scripts.enqueue_script('wc-zoom')
		}
		if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('wc-product-gallery-slider')])) {
			Class_WC_Frontend_Scripts.enqueue_script('wc-flexslider')
		}
		if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('wc-product-gallery-lightbox')])) {
			Class_WC_Frontend_Scripts.enqueue_script('wc-photoswipe-ui-default')
			Class_WC_Frontend_Scripts.enqueue_style('photoswipe-default-skin')
			rt.call_function('add_action', [rt.new_string('wp_footer'), rt.new_string('woocommerce_photoswipe')])
		}
		Class_WC_Frontend_Scripts.enqueue_script('wc-single-product')
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.geolocation_ajax(), rt.call_function('get_option', [rt.new_string('woocommerce_default_customer_address')]))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_cart', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_account_page', []rt.PhpVal{})))) || rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{})))) || rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{}))))))))) {
		mut var_ua := rt.new_string(rt.new_string(rt.call_function('wc_get_user_agent', []rt.PhpVal{}).to_string().to_lower()))
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strstr', [var_ua.dup(), rt.new_string('bot')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strstr', [var_ua.dup(), rt.new_string('spider')]))))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strstr', [var_ua.dup(), rt.new_string('crawl')]))))))) {
			Class_WC_Frontend_Scripts.enqueue_script('wc-geolocation')
		}
	}
	Class_WC_Frontend_Scripts.enqueue_script('woocommerce')
	mut var_enqueue_styles := Class_WC_Frontend_Scripts.get_styles()
	if rt.is_true(var_enqueue_styles) {
		{
			mut iter_1 := var_enqueue_styles.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_args := item_1.val
				mut var_handle := item_1.key
				if !(var_args.array_isset(rt.new_string('has_rtl'))) {
					var_args.array_set('has_rtl', false)
				}
				Class_WC_Frontend_Scripts.enqueue_style((var_handle).str(), var_args.array_get('src'), (var_args.array_get('deps')).str(), (var_args.array_get('version')).to_bool(), var_args.array_get('media'), var_args.array_get('has_rtl'))
			}
		}
	}
	rt.call_function('wp_register_style', [rt.new_string('woocommerce-inline'), rt.new_bool(false)])
	rt.call_function('wp_enqueue_style', [rt.new_string('woocommerce-inline')])
	if rt.is_true(rt.identical(rt.new_bool(true), rt.call_function('wc_string_to_bool', [rt.call_function('get_option', [rt.new_string('woocommerce_checkout_highlight_required_fields'), rt.new_string('yes')])]))) {
		rt.call_function('wp_add_inline_style', [rt.new_string('woocommerce-inline'), rt.new_string('.woocommerce form .form-row .required { visibility: visible; }')])
	} else {
		rt.call_function('wp_add_inline_style', [rt.new_string('woocommerce-inline'), rt.new_string('.woocommerce form .form-row .required { visibility: hidden; }')])
	}
}

fn Class_WC_Frontend_Scripts.localize_script(var_handle rt.PhpVal)  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_handle.dup(), // unsupported expression: Expr_StaticPropertyFetch, rt.new_bool(true)]))))) && rt.is_true(rt.call_function('wp_script_is', [var_handle.dup()])))) {
		mut var_data := Class_WC_Frontend_Scripts.get_script_data(var_handle.dup())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_data)))) {
			return rt.new_null()
		}
		mut var_name := rt.new_string((rt.call_function('str_replace', [rt.new_string('-'), rt.new_string('_'), var_handle.dup()])).str() + '_params')
		// unsupported expression: Expr_StaticPropertyFetch.array_push(var_handle.dup())
		rt.call_function('wp_localize_script', [var_handle.dup(), var_name.dup(), rt.call_function('apply_filters', [var_name.dup(), var_data.dup()])])
	}
}

fn Class_WC_Frontend_Scripts.get_script_data(var_handle rt.PhpVal) rt.PhpVal {
	mut var_wp := rt.new_null()
	// unsupported statement: Stmt_Global
	mut switch_val_1 := var_handle
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce'))) {
		mut var_params := rt.create_array([rt.ArrayItem{ key: 'ajax_url', val: rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'ajax_url', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'wc_ajax_url', val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_AJAX{}; return temp.get_endpoint(arg_0) }(rt.new_string('%%endpoint%%')) }, rt.ArrayItem{ key: 'i18n_password_show', val: rt.call_function('esc_attr__', [rt.new_string('Show password'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'i18n_password_hide', val: rt.call_function('esc_attr__', [rt.new_string('Hide password'), rt.new_string('woocommerce')]) }])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wc-geolocation'))) {
		var_params = rt.create_array([rt.ArrayItem{ key: 'wc_ajax_url', val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_AJAX{}; return temp.get_endpoint(arg_0) }(rt.new_string('%%endpoint%%')) }, rt.ArrayItem{ key: 'home_url', val: rt.call_function('remove_query_arg', [rt.new_string('lang'), rt.call_function('home_url', []rt.PhpVal{})]) }])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wc-single-product'))) {
		var_params = rt.create_array([rt.ArrayItem{ key: 'i18n_required_rating_text', val: rt.call_function('esc_attr__', [rt.new_string('Please select a rating'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'i18n_rating_options', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('esc_attr__', [rt.new_string('1 of 5 stars'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: none, val: rt.call_function('esc_attr__', [rt.new_string('2 of 5 stars'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: none, val: rt.call_function('esc_attr__', [rt.new_string('3 of 5 stars'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: none, val: rt.call_function('esc_attr__', [rt.new_string('4 of 5 stars'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: none, val: rt.call_function('esc_attr__', [rt.new_string('5 of 5 stars'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'i18n_product_gallery_trigger_text', val: rt.call_function('esc_attr__', [rt.new_string('View full-screen image gallery'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'review_rating_required', val: if rt.is_true(rt.call_function('wc_review_ratings_required', []rt.PhpVal{})) { 'yes' } else { 'no' } }, rt.ArrayItem{ key: 'flexslider', val: rt.call_function('apply_filters', [rt.new_string('woocommerce_single_product_carousel_options'), rt.create_array([rt.ArrayItem{ key: 'rtl', val: rt.call_function('is_rtl', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'animation', val: 'slide' }, rt.ArrayItem{ key: 'smoothHeight', val: true }, rt.ArrayItem{ key: 'directionNav', val: false }, rt.ArrayItem{ key: 'controlNav', val: 'thumbnails' }, rt.ArrayItem{ key: 'slideshow', val: false }, rt.ArrayItem{ key: 'animationSpeed', val: 500 }, rt.ArrayItem{ key: 'animationLoop', val: false }, rt.ArrayItem{ key: 'allowOneSlide', val: false }])]) }, rt.ArrayItem{ key: 'zoom_enabled', val: rt.call_function('apply_filters', [rt.new_string('woocommerce_single_product_zoom_enabled'), rt.call_function('get_theme_support', [rt.new_string('wc-product-gallery-zoom')])]) }, rt.ArrayItem{ key: 'zoom_options', val: rt.call_function('apply_filters', [rt.new_string('woocommerce_single_product_zoom_options'), rt.new_array()]) }, rt.ArrayItem{ key: 'photoswipe_enabled', val: rt.call_function('apply_filters', [rt.new_string('woocommerce_single_product_photoswipe_enabled'), rt.call_function('get_theme_support', [rt.new_string('wc-product-gallery-lightbox')])]) }, rt.ArrayItem{ key: 'photoswipe_options', val: rt.call_function('apply_filters', [rt.new_string('woocommerce_single_product_photoswipe_options'), rt.create_array([rt.ArrayItem{ key: 'shareEl', val: false }, rt.ArrayItem{ key: 'closeOnScroll', val: false }, rt.ArrayItem{ key: 'history', val: false }, rt.ArrayItem{ key: 'hideAnimationDuration', val: 0 }, rt.ArrayItem{ key: 'showAnimationDuration', val: 0 }])]) }, rt.ArrayItem{ key: 'flexslider_enabled', val: rt.call_function('apply_filters', [rt.new_string('woocommerce_single_product_flexslider_enabled'), rt.call_function('get_theme_support', [rt.new_string('wc-product-gallery-slider')])]) }])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wc-checkout'))) {
		var_params = rt.create_array([rt.ArrayItem{ key: 'ajax_url', val: rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'ajax_url', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'wc_ajax_url', val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_AJAX{}; return temp.get_endpoint(arg_0) }(rt.new_string('%%endpoint%%')) }, rt.ArrayItem{ key: 'update_order_review_nonce', val: rt.call_function('wp_create_nonce', [rt.new_string('update-order-review')]) }, rt.ArrayItem{ key: 'apply_coupon_nonce', val: rt.call_function('wp_create_nonce', [rt.new_string('apply-coupon')]) }, rt.ArrayItem{ key: 'remove_coupon_nonce', val: rt.call_function('wp_create_nonce', [rt.new_string('remove-coupon')]) }, rt.ArrayItem{ key: 'option_guest_checkout', val: rt.call_function('get_option', [rt.new_string('woocommerce_enable_guest_checkout')]) }, rt.ArrayItem{ key: 'checkout_url', val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_AJAX{}; return temp.get_endpoint(arg_0) }(rt.new_string('checkout')) }, rt.ArrayItem{ key: 'is_checkout', val: if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{})) && !rt.is_true(rt.get_property(var_wp, 'query_vars').array_get('order-pay')))) && !(rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('order-received'))))) { 1 } else { 0 } }, rt.ArrayItem{ key: 'debug_mode', val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_true(arg_0) }(rt.new_string('WP_DEBUG')) }, rt.ArrayItem{ key: 'i18n_checkout_error', val: rt.call_function('sprintf', [rt.call_function('esc_attr__', [rt.new_string('There was an error processing your order. Please check for any charges in your payment method and review your <a href="%s">order history</a> before placing the order again.'), rt.new_string('woocommerce')]), rt.call_function('esc_url', [rt.call_function('wc_get_account_endpoint_url', [rt.new_string('orders')])])]) }, rt.ArrayItem{ key: 'gateways_with_custom_place_order_button', val: Class_WC_Frontend_Scripts.get_gateways_with_custom_place_order_button() }])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wc-address-autocomplete-common'))) {
		mut var_providers := rt.new_array()
		var_providers = rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_AddressProvider_AddressProviderController.class()]), 'get_providers', []rt.PhpVal{})
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Throwable') {
			mut var_e := var_e_1.dup()
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', ['Could not get address providers for wc-address-autocomplete script: ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'address-autocomplete' }])])
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
		closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_provider := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.create_array([rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }])
	}
	mut var_provider := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return 
	}
	mut var_provider := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	}
	mut var_provider := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	}
		var_params = rt.create_array([rt.ArrayItem{ key: 'address_providers', val: rt.call_function('wp_json_encode', [rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_providers.dup()]), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))]) }])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wc-address-i18n'))) {
		var_params = rt.create_array([rt.ArrayItem{ key: 'locale', val: rt.call_function('wp_json_encode', [rt.call_method(, 'get_country_locale', []rt.PhpVal{}), rt.bitwise_or(, )]) }, rt.ArrayItem{ key: 'locale_fields', val: rt.call_function('wp_json_encode', [rt.call_method(, 'get_country_locale_field_selectors', []rt.PhpVal{}), rt.bitwise_or(, )]) }, rt.ArrayItem{ key: 'i18n_required_text', val: rt.call_function('esc_attr__', [rt.new_string('required'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'i18n_optional_text', val: rt.call_function('esc_html__', [rt.new_string('optional'), rt.new_string('woocommerce')]) }])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wc-cart'))) {
		var_params = rt.create_array([rt.ArrayItem{ key: 'ajax_url', val: rt.call_method(, 'ajax_url', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'wc_ajax_url', val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_AJAX{}; return temp.get_endpoint(arg_0) }(rt.new_string()) }, rt.ArrayItem{ key: 'update_shipping_method_nonce', val: rt.call_function('wp_create_nonce', []) }, rt.ArrayItem{ key: 'apply_coupon_nonce', val: rt.call_function('wp_create_nonce', []) }, rt.ArrayItem{ key: 'remove_coupon_nonce', val: rt.call_function('wp_create_nonce', []) }])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wc-cart-fragments'))) {
		var_params = rt.create_array([rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wc-add-to-cart'))) {
		var_params = 
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wc-add-payment-method'))) {
		
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else {
	}
}

fn Class_WC_Frontend_Scripts.get_gateways_with_custom_place_order_button() rt.PhpVal {
}

fn Class_WC_Frontend_Scripts.localize_printed_scripts()  {
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_WC_AJAX {
	rt.PhpObjectBase
}

fn create_wc_frontend_scripts() &Class_WC_Frontend_Scripts {
	mut obj := &Class_WC_Frontend_Scripts{
		PhpObjectBase: rt.PhpObjectBase{}
		registered_scripts: rt.new_array()
		styles: rt.new_array()
		wp_localize_scripts: rt.new_array()
	}
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_ajax() &Class_WC_AJAX {
	mut obj := &Class_WC_AJAX{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Frontend_Scripts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_Frontend_Scripts.init()
			return rt.new_null()
		}
		'get_styles' {
			return Class_WC_Frontend_Scripts.get_styles()
		}
		'enqueue_block_assets' {
			Class_WC_Frontend_Scripts.enqueue_block_assets()
			return rt.new_null()
		}
		'get_asset_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Frontend_Scripts.get_asset_url(dispatch_arg_0)
		}
		'register_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			Class_WC_Frontend_Scripts.register_script(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
			return rt.new_null()
		}
		'enqueue_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			Class_WC_Frontend_Scripts.enqueue_script(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
			return rt.new_null()
		}
		'register_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).to_bool()
			Class_WC_Frontend_Scripts.register_style(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5)
			return rt.new_null()
		}
		'enqueue_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).to_bool()
			Class_WC_Frontend_Scripts.enqueue_style(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5)
			return rt.new_null()
		}
		'get_scripts' {
			return Class_WC_Frontend_Scripts.get_scripts()
		}
		'register_scripts' {
			Class_WC_Frontend_Scripts.register_scripts()
			return rt.new_null()
		}
		'register_styles' {
			Class_WC_Frontend_Scripts.register_styles()
			return rt.new_null()
		}
		'load_scripts' {
			Class_WC_Frontend_Scripts.load_scripts()
			return rt.new_null()
		}
		'localize_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Frontend_Scripts.localize_script(dispatch_arg_0)
			return rt.new_null()
		}
		'get_script_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Frontend_Scripts.get_script_data(dispatch_arg_0)
		}
		'get_gateways_with_custom_place_order_button' {
			return Class_WC_Frontend_Scripts.get_gateways_with_custom_place_order_button()
		}
		'localize_printed_scripts' {
			Class_WC_Frontend_Scripts.localize_printed_scripts()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Frontend_Scripts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'registered_scripts' { return this.registered_scripts }
		'styles' { return this.styles }
		'wp_localize_scripts' { return this.wp_localize_scripts }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Frontend_Scripts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'registered_scripts' { this.registered_scripts = val; return true }
		'styles' { this.styles = val; return true }
		'wp_localize_scripts' { this.wp_localize_scripts = val; return true }
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


fn (mut this Class_WC_AJAX) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_AJAX) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_AJAX) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_frontend_scripts_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
