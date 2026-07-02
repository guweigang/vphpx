import rt

struct Class_WC_Admin_Settings {
	rt.PhpObjectBase
}

fn create_wc_admin_settings(_args ...rt.PhpVal) &Class_WC_Admin_Settings {
	mut obj := &Class_WC_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_tabs := map[string]rt.PhpVal{}
	mut var_current_tab := rt.new_null()
	mut var_current_section := rt.new_null()
	mut var_GLOBALS := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	mut var_tab_exists := var_tabs.array_isset(var_current_tab)
		|| rt.is_true(rt.call_function('has_action', [rt.new_string('woocommerce_sections_' + var_current_tab.str())]))
		|| rt.is_true(rt.call_function('has_action', [rt.new_string('woocommerce_settings_' + var_current_tab.str())]))
		|| rt.is_true(rt.call_function('has_action', [rt.new_string('woocommerce_settings_tabs_' + var_current_tab.str())]))
	mut var_current_tab_label := if var_tabs.array_isset(var_current_tab) {
		var_tabs[var_current_tab]
	} else {
		rt.new_string('')
	}
	if !var_tab_exists {
		rt.call_function('wp_safe_redirect', [
			rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings')]),
		])
		exit(0)
	}
	mut var_hide_nav := rt.is_true(rt.identical(rt.new_string('checkout'), var_current_tab))
		&& rt.is_true(rt.call_function('in_array', [var_current_section.clone(), rt.create_array([rt.ArrayItem{
		key: none
		val: 'offline'
	}, rt.ArrayItem{ key: none, val: 'bacs' }, rt.ArrayItem{ key: none, val: 'cheque' }, rt.ArrayItem{
		key: none
		val: 'cod'
	}]), rt.new_bool(true)]))
	if rt.is_true(rt.new_bool(rt.create_array_from_native_map(var_tabs).array_isset(rt.new_string('advanced')))) {
		mut var_advanced := var_tabs['advanced']
		var_tabs.delete('advanced')
		var_tabs['advanced'] = var_advanced.clone()
	}
	mut var_marketplace_base_url := rt.new_string(
		(rt.call_function('trailingslashit', [rt.call_function('esc_url_raw', [rt.call_function('apply_filters', [rt.new_string('woo_com_base_url'), rt.new_string('https://woocommerce.com/')])])])).str() +
		'product-category/woocommerce-extensions/')
	mut var_marketplace_links := rt.create_array([
		rt.ArrayItem{ key: 'products', val: rt.create_array([
			rt.ArrayItem{ key: 'url', val: var_marketplace_base_url.str() + 'merchandising/' },
			rt.ArrayItem{ key: 'is_external', val: true },
			rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
				rt.new_string('%1$sExplore solutions%2$s that help highlight products and drive more sales.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'tax', val: rt.create_array([
			rt.ArrayItem{ key: 'url', val: var_marketplace_base_url.str() +
				'operations/sales-tax-and-duties/' },
			rt.ArrayItem{ key: 'is_external', val: true },
			rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
				rt.new_string('%1$sExplore solutions%2$s that help with tax calculations, compliance, and regional requirements.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'shipping', val: rt.create_array([
			rt.ArrayItem{ key: 'url', val: var_marketplace_base_url.str() +
				'shipping-delivery-and-fulfillment/' },
			rt.ArrayItem{ key: 'is_external', val: true },
			rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
				rt.new_string('%1$sExplore solutions%2$s that enhance shipping, delivery, and fulfillment workflows.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'account', val: rt.create_array([
			rt.ArrayItem{ key: 'url', val: var_marketplace_base_url.str() +
				'store-content-and-customizations/cart-and-checkout-features/' },
			rt.ArrayItem{ key: 'is_external', val: true },
			rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
				rt.new_string('%1$sExplore solutions%2$s that help customize cart and checkout flows.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'email', val: rt.create_array([
			rt.ArrayItem{ key: 'url', val: var_marketplace_base_url.str() +
				'marketing-extensions/email-marketing-extensions/' },
			rt.ArrayItem{ key: 'is_external', val: true },
			rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
				rt.new_string('%1$sExplore solutions%2$s that help automate and improve customer email communication.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'general', val: rt.create_array([
			rt.ArrayItem{ key: 'url', val: rt.call_function('admin_url', [
				rt.new_string('admin.php?page=wc-admin&path=%2Fextensions'),
			]) },
			rt.ArrayItem{ key: 'is_external', val: false },
			rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
				rt.new_string('%1$sDiscover additional solutions%2$s to boost your business and expand what your store can do.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_before_settings_' + var_current_tab.str()),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_settings_form_method_tab_' + var_current_tab.str()),
			rt.new_string('post'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if !var_hide_nav {
		// unsupported statement: Stmt_InlineHTML
		for var_slug, var_label in var_tabs {
			print('<a href="' +
				(rt.call_function('esc_html', [rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=' + (rt.call_function('esc_attr', [rt.new_string(slug)])).str())])])).str() +
				'" class="nav-tab ' +
				if rt.is_true(rt.identical(var_current_tab, rt.new_string(slug))) { 'nav-tab-active' } else { '' } +
				'">' + (rt.call_function('esc_html', [var_label.clone()])).str() + '</a>')
		}
		rt.call_function('do_action', [rt.new_string('woocommerce_settings_tabs')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_current_tab_label.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_sections_' + var_current_tab.str()),
	])
	mut iife_temp_0 := Class_WC_Admin_Settings{}
	mut iife_result_0 := iife_temp_0.show_messages()
	rt.call_function('do_action', [
		rt.new_string('woocommerce_settings_' + var_current_tab.str()),
	])
	rt.call_function('do_action', [
		rt.new_string('woocommerce_settings_tabs_' + var_current_tab.str()),
	])
	// unsupported statement: Stmt_InlineHTML
	if !rt.is_true(var_GLOBALS.array_get(rt.new_string('hide_save_button'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Save changes'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Save changes'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('woocommerce-settings')])
	// unsupported statement: Stmt_InlineHTML
	if var_marketplace_links.array_isset(var_current_tab) {
		// unsupported statement: Stmt_InlineHTML
		mut var_link_config := var_marketplace_links.array_get(var_current_tab)
		if rt.is_true(var_link_config.array_get(rt.new_string('is_external'))) {
			mut var_utm_source := rt.new_string('settings_' + var_current_tab.str() +
				if rt.is_true(var_current_section) { '_' + var_current_section.str() } else { '' })
			mut var_link_url := rt.call_function('add_query_arg', [
				rt.new_string('utm_source'),
				var_utm_source.clone(),
				var_link_config.array_get(rt.new_string('url')),
			])
			mut var_icon_url := rt.new_string(
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
				'/assets/images/icons/external-link.svg')
			mut var_external_icon := rt.new_string('<img src="' +
				(rt.call_function('esc_url', [var_icon_url.clone()])).str() + '" alt="" />')
			mut var_screen_reader := rt.new_string('<span class="screen-reader-text">' +
				(rt.call_function('esc_html__', [rt.new_string('(opens in a new tab)'), rt.new_string('woocommerce')])).str() +
				'</span>')
			mut var_link_open := rt.new_string('<a href="' +
				(rt.call_function('esc_url', [var_link_url.clone()])).str() +
				'" target="_blank" rel="noopener noreferrer">' + var_external_icon.str())
			mut var_link_close := rt.new_string(var_screen_reader.str() + '</a>')
		} else {
			var_link_open = rt.new_string('<a href="' +
				(rt.call_function('esc_url', [var_link_config.array_get(rt.new_string('url'))])).str() +
				'">')
			var_link_close = rt.new_string('</a>')
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_current_tab.clone()]))
		// unsupported statement: Stmt_InlineHTML
		print(if rt.is_true(var_current_section) {
			' data-settings-section="' +
				(rt.call_function('esc_attr', [var_current_section.clone()])).str() + '"'
		} else {
			''
		})
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [
			rt.call_function('sprintf', [var_link_config.array_get(rt.new_string('message')),
				var_link_open.clone(), var_link_close.clone()]),
			rt.create_array([rt.ArrayItem{ key: 'a', val: rt.create_array([
				rt.ArrayItem{ key: 'href', val: rt.new_array() },
				rt.ArrayItem{ key: 'target', val: rt.new_array() },
				rt.ArrayItem{ key: 'rel', val: rt.new_array() },
			]) }, rt.ArrayItem{ key: 'img', val: rt.create_array([
				rt.ArrayItem{ key: 'src', val: rt.new_array() },
				rt.ArrayItem{ key: 'alt', val: rt.new_array() },
			]) }, rt.ArrayItem{ key: 'span', val: rt.create_array([
				rt.ArrayItem{ key: 'class', val: rt.new_array() },
			]) }]),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_after_settings_' + var_current_tab.str()),
	])
	// unsupported statement: Stmt_InlineHTML
}
