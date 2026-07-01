import rt

struct Class_WC_Settings_Advanced {
	rt.PhpObjectBase
pub mut:
		icon rt.PhpVal = rt.new_string('more')
}

fn (mut this Class_WC_Settings_Advanced) construct()  {
	this.dispatch_set_prop('id', rt.new_string('advanced'))
	this.dispatch_set_prop('label', rt.call_function('__', [rt.new_string('Advanced'), rt.new_string('woocommerce')]))
	this.Class_WC_Settings_Page.construct()
	this.notices()
}

fn (mut this Class_WC_Settings_Advanced) get_own_sections() rt.PhpVal {
	mut var_sections := { '': rt.call_function('__', [rt.new_string('Page setup'), rt.new_string('woocommerce')]), 'keys': rt.call_function('__', [rt.new_string('REST API keys'), rt.new_string('woocommerce')]) }
	mut var_features_controller := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class()])
	if rt.is_true(rt.call_method(var_features_controller, 'feature_is_enabled', [rt.new_string('rest_api_caching')])) {
		var_sections['rest_api_caching'] = rt.call_function('__', [rt.new_string('REST API caching'), rt.new_string('woocommerce')])
	}
	var_sections['webhooks'] = rt.call_function('__', [rt.new_string('Webhooks'), rt.new_string('woocommerce')])
	var_sections['legacy_api'] = rt.call_function('__', [rt.new_string('Legacy API'), rt.new_string('woocommerce')])
	var_sections['woocommerce_com'] = rt.call_function('__', [rt.new_string('WooCommerce.com'), rt.new_string('woocommerce')])
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('blueprint'))) {
		var_sections['blueprint'] = rt.call_function('__', [rt.new_string('Blueprint (beta)'), rt.new_string('woocommerce')])
	}
	return var_sections.dup()
}

fn (mut this Class_WC_Settings_Advanced) get_settings_for_default_section() rt.PhpVal {
	mut var_settings := rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Page setup'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('These pages need to be set so that WooCommerce knows where to send users to checkout.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'title' }, rt.ArrayItem{ key: 'id', val: 'advanced_page_options' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Cart page'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Page where shoppers review their shopping cart'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_cart_page_id' }, rt.ArrayItem{ key: 'type', val: 'single_select_page_with_search' }, rt.ArrayItem{ key: 'default', val: '' }, rt.ArrayItem{ key: 'class', val: 'wc-page-search' }, rt.ArrayItem{ key: 'css', val: 'min-width:300px;' }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'exclude', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('wc_get_page_id', [rt.new_string('checkout')]) }, rt.ArrayItem{ key: none, val: rt.call_function('wc_get_page_id', [rt.new_string('myaccount')]) }]) }]) }, rt.ArrayItem{ key: 'desc_tip', val: true }, rt.ArrayItem{ key: 'autoload', val: false }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Checkout page'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Page where shoppers go to finalize their purchase'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_checkout_page_id' }, rt.ArrayItem{ key: 'type', val: 'single_select_page_with_search' }, rt.ArrayItem{ key: 'default', val: rt.call_function('wc_get_page_id', [rt.new_string('checkout')]) }, rt.ArrayItem{ key: 'class', val: 'wc-page-search' }, rt.ArrayItem{ key: 'css', val: 'min-width:300px;' }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'exclude', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('wc_get_page_id', [rt.new_string('cart')]) }, rt.ArrayItem{ key: none, val: rt.call_function('wc_get_page_id', [rt.new_string('myaccount')]) }]) }]) }, rt.ArrayItem{ key: 'desc_tip', val: true }, rt.ArrayItem{ key: 'autoload', val: false }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('My account page'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Page contents: [%s]'), rt.new_string('woocommerce')]), rt.call_function('apply_filters', [rt.new_string('woocommerce_my_account_shortcode_tag'), rt.new_string('woocommerce_my_account')])]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_myaccount_page_id' }, rt.ArrayItem{ key: 'type', val: 'single_select_page_with_search' }, rt.ArrayItem{ key: 'default', val: '' }, rt.ArrayItem{ key: 'class', val: 'wc-page-search' }, rt.ArrayItem{ key: 'css', val: 'min-width:300px;' }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'exclude', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('wc_get_page_id', [rt.new_string('cart')]) }, rt.ArrayItem{ key: none, val: rt.call_function('wc_get_page_id', [rt.new_string('checkout')]) }]) }]) }, rt.ArrayItem{ key: 'desc_tip', val: true }, rt.ArrayItem{ key: 'autoload', val: false }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Terms and conditions'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('If you define a "Terms" page the customer will be asked if they accept them when checking out.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_terms_page_id' }, rt.ArrayItem{ key: 'default', val: '' }, rt.ArrayItem{ key: 'class', val: 'wc-page-search' }, rt.ArrayItem{ key: 'css', val: 'min-width:300px;' }, rt.ArrayItem{ key: 'type', val: 'single_select_page_with_search' }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'exclude', val: rt.call_function('wc_get_page_id', [rt.new_string('checkout')]) }]) }, rt.ArrayItem{ key: 'desc_tip', val: true }, rt.ArrayItem{ key: 'autoload', val: false }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'sectionend' }, rt.ArrayItem{ key: 'id', val: 'advanced_page_options' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: '' }, rt.ArrayItem{ key: 'type', val: 'title' }, rt.ArrayItem{ key: 'id', val: 'checkout_process_options' }]) }, rt.ArrayItem{ key: 'force_ssl_checkout', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Secure checkout'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Force secure checkout'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_force_ssl_checkout' }, rt.ArrayItem{ key: 'default', val: 'no' }, rt.ArrayItem{ key: 'type', val: 'checkbox' }, rt.ArrayItem{ key: 'checkboxgroup', val: 'start' }, rt.ArrayItem{ key: 'show_if_checked', val: 'option' }, rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Force SSL (HTTPS) on the checkout pages (<a href="%s" target="_blank">an SSL Certificate is required</a>).'), rt.new_string('woocommerce')]), rt.new_string('https://woocommerce.com/document/ssl-and-https/#section-3')]) }]) }, rt.ArrayItem{ key: 'unforce_ssl_checkout', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Force HTTP when leaving the checkout'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_unforce_ssl_checkout' }, rt.ArrayItem{ key: 'default', val: 'no' }, rt.ArrayItem{ key: 'type', val: 'checkbox' }, rt.ArrayItem{ key: 'checkboxgroup', val: 'end' }, rt.ArrayItem{ key: 'show_if_checked', val: 'yes' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'sectionend' }, rt.ArrayItem{ key: 'id', val: 'checkout_process_options' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Checkout endpoints'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'title' }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Endpoints are appended to your page URLs to handle specific actions during the checkout process. They should be unique.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'checkout_endpoint_options' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Pay'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Endpoint for the "Checkout &rarr; Pay" page.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_checkout_pay_endpoint' }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'default', val: 'order-pay' }, rt.ArrayItem{ key: 'desc_tip', val: true }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Order received'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Endpoint for the "Checkout &rarr; Order received" page.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_checkout_order_received_endpoint' }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'default', val: 'order-received' }, rt.ArrayItem{ key: 'desc_tip', val: true }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Add payment method'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Endpoint for the "Checkout &rarr; Add payment method" page.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_myaccount_add_payment_method_endpoint' }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'default', val: 'add-payment-method' }, rt.ArrayItem{ key: 'desc_tip', val: true }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Delete payment method'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Endpoint for the delete payment method page.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_myaccount_delete_payment_method_endpoint' }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'default', val: 'delete-payment-method' }, rt.ArrayItem{ key: 'desc_tip', val: true }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Set default payment method'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Endpoint for the setting a default payment method page.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_myaccount_set_default_payment_method_endpoint' }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'default', val: 'set-default-payment-method' }, rt.ArrayItem{ key: 'desc_tip', val: true }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'sectionend' }, rt.ArrayItem{ key: 'id', val: 'checkout_endpoint_options' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Account endpoints'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'title' }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Endpoints are appended to your page URLs to handle specific actions on the accounts pages. They should be unique and can be left blank to disable the endpoint.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'account_endpoint_options' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Orders'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Endpoint for the "My account &rarr; Orders" page.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_myaccount_orders_endpoint' }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'default', val: 'orders' }, rt.ArrayItem{ key: 'desc_tip', val: true }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('View order'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Endpoint for the "My account &rarr; View order" page.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_myaccount_view_order_endpoint' }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'default', val: 'view-order' }, rt.ArrayItem{ key: 'desc_tip', val: true }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Downloads'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Endpoint for the "My account &rarr; Downloads" page.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_myaccount_downloads_endpoint' }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'default', val: 'downloads' }, rt.ArrayItem{ key: 'desc_tip', val: true }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Edit account'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Endpoint for the "My account &rarr; Edit account" page.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_myaccount_edit_account_endpoint' }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'default', val: 'edit-account' }, rt.ArrayItem{ key: 'desc_tip', val: true }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Addresses'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Endpoint for the "My account &rarr; Addresses" page.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_myaccount_edit_address_endpoint' }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'default', val: 'edit-address' }, rt.ArrayItem{ key: 'desc_tip', val: true }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Payment methods'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Endpoint for the "My account &rarr; Payment methods" page.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_myaccount_payment_methods_endpoint' }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'default', val: 'payment-methods' }, rt.ArrayItem{ key: 'desc_tip', val: true }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Lost password'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Endpoint for the "My account &rarr; Lost password" page.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_myaccount_lost_password_endpoint' }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'default', val: 'lost-password' }, rt.ArrayItem{ key: 'desc_tip', val: true }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Logout'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Endpoint for the triggering logout. You can add this to your menus via a custom link: yoursite.com/?customer-logout=true'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_logout_endpoint' }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'default', val: 'customer-logout' }, rt.ArrayItem{ key: 'desc_tip', val: true }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'sectionend' }, rt.ArrayItem{ key: 'id', val: 'account_endpoint_options' }]) }])
	var_settings = rt.call_function('apply_filters', [rt.new_string('woocommerce_settings_pages'), var_settings.dup()])
	if rt.is_true(rt.call_function('wc_site_is_https', []rt.PhpVal{})) {
		var_settings.array_unset(rt.new_string('unforce_ssl_checkout'))
		var_settings.array_unset(rt.new_string('force_ssl_checkout'))
	}
	return var_settings.dup()
}

fn (mut this Class_WC_Settings_Advanced) get_settings_for_woocommerce_com_section() rt.PhpVal {
	mut var_tracking_info_text := rt.call_function('sprintf', [rt.new_string('<a href="%s" target="_blank">%s</a>'), rt.new_string('https://woocommerce.com/usage-tracking'), rt.call_function('esc_html__', [rt.new_string('WooCommerce.com Usage Tracking Documentation'), rt.new_string('woocommerce')])])
	mut var_settings := rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('esc_html__', [rt.new_string('Usage Tracking'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'title' }, rt.ArrayItem{ key: 'id', val: 'tracking_options' }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Gathering usage data allows us to tailor your store setup experience, offer more relevant content, and help make WooCommerce better for everyone.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Enable tracking'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Allow usage of WooCommerce to be tracked'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('To opt out, leave this box unticked. Your store remains untracked, and no data will be collected. Read about what usage data is tracked at: %s.'), rt.new_string('woocommerce')]), var_tracking_info_text.dup()]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_allow_tracking' }, rt.ArrayItem{ key: 'type', val: 'checkbox' }, rt.ArrayItem{ key: 'checkboxgroup', val: 'start' }, rt.ArrayItem{ key: 'default', val: 'no' }, rt.ArrayItem{ key: 'autoload', val: true }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'sectionend' }, rt.ArrayItem{ key: 'id', val: 'tracking_options' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('esc_html__', [rt.new_string('Marketplace suggestions'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'title' }, rt.ArrayItem{ key: 'id', val: 'marketplace_suggestions' }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('We show contextual suggestions for official extensions that may be helpful to your store.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Show Suggestions'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Display suggestions within WooCommerce'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('esc_html__', [rt.new_string('Leave this box unchecked if you do not want to pull suggested extensions from WooCommerce.com.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_show_marketplace_suggestions' }, rt.ArrayItem{ key: 'type', val: 'checkbox' }, rt.ArrayItem{ key: 'checkboxgroup', val: 'start' }, rt.ArrayItem{ key: 'default', val: 'yes' }, rt.ArrayItem{ key: 'autoload', val: false }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'sectionend' }, rt.ArrayItem{ key: 'id', val: 'marketplace_suggestions' }]) }])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_com_integration_settings'), var_settings.dup()])
}

fn (mut this Class_WC_Settings_Advanced) get_settings_for_legacy_api_section() rt.PhpVal {
	mut var_legacy_api_setting_desc := if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_api_enabled')]))) { rt.call_function('__', [rt.new_string('The legacy REST API is enabled'), rt.new_string('woocommerce')]) } else { rt.call_function('__', [rt.new_string('The legacy REST API is NOT enabled'), rt.new_string('woocommerce')]) }
	mut var_legacy_api_setting_tip := if rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'legacy_rest_api_is_available', []rt.PhpVal{})) { rt.call_function('__', [rt.new_string('ℹ️️ The WooCommerce Legacy REST API extension is installed and active.'), rt.new_string('woocommerce')]) } else { rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('⚠️ The WooCommerce Legacy REST API has been moved to <a target=”_blank” href="%1$s">a dedicated extension</a>. <b><a target=”_blank” href="%2$s">Learn more about this change</a></b>'), rt.new_string('woocommerce')]), rt.new_string('https://wordpress.org/plugins/woocommerce-legacy-rest-api/'), rt.new_string('https://developer.woocommerce.com/2023/10/03/the-legacy-rest-api-will-move-to-a-dedicated-extension-in-woocommerce-9-0/')]) }
	mut var_settings := rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: '' }, rt.ArrayItem{ key: 'type', val: 'title' }, rt.ArrayItem{ key: 'desc', val: '' }, rt.ArrayItem{ key: 'id', val: 'legacy_api_options' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Legacy API'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: var_legacy_api_setting_desc }, rt.ArrayItem{ key: 'id', val: 'woocommerce_api_enabled' }, rt.ArrayItem{ key: 'type', val: 'checkbox' }, rt.ArrayItem{ key: 'default', val: 'no' }, rt.ArrayItem{ key: 'disabled', val: true }, rt.ArrayItem{ key: 'desc_tip', val: var_legacy_api_setting_tip }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'sectionend' }, rt.ArrayItem{ key: 'id', val: 'legacy_api_options' }]) }])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_settings_rest_api'), var_settings.dup()])
}

fn (mut this Class_WC_Settings_Advanced) get_settings_for_rest_api_caching_section() rt.PhpVal {
	mut var_has_object_cache := rt.call_function('wp_using_ext_object_cache', []rt.PhpVal{})
	mut var_settings := rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('REST API response cache'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'title' }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('These settings control backend caching and cache control headers for REST API responses.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'rest_api_cache_options' }]) }])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_object_cache)))) {
		var_settings.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: 'notice' }, rt.ArrayItem{ key: 'id', val: 'rest_api_cache_warning' }, rt.ArrayItem{ key: 'notice_type', val: 'warning' }, rt.ArrayItem{ key: 'text', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Backend caching requires a WordPress object cache plugin (Redis, Memcached, etc.) to be installed and active. %1$sLearn more about object caching%2$s.'), rt.new_string('woocommerce')]), rt.new_string('<a href="https://developer.wordpress.org/reference/classes/wp_object_cache/" target="_blank">'), rt.new_string('</a>')]) }]))
	}
	mut var_backend_caching_setting := { 'title': rt.call_function('__', [rt.new_string('Enable backend caching'), rt.new_string('woocommerce')]), 'desc': rt.call_function('__', [rt.new_string('Cache REST API responses on the server'), rt.new_string('woocommerce')]), 'id': rt.new_string('woocommerce_rest_api_enable_backend_caching'), 'type': rt.new_string('checkbox'), 'default': rt.new_string('no'), 'disabled': rt.new_bool(!(rt.is_true(var_has_object_cache))), 'fixed_value': if rt.is_true(var_has_object_cache) { rt.new_null() } else { rt.new_string('no') }, 'desc_tip': rt.call_function('__', [rt.new_string('Enables responses for REST API endpoints configured as cacheable. Requires an external object cache.<br/>This setting should be enabled only if no other plugins that handle caching are active.'), rt.new_string('woocommerce')]) }
	var_settings.array_push(var_backend_caching_setting.dup())
	var_settings.array_push(rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Enable cache control headers'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Send cache control headers and support 304 Not Modified responses'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'id', val: 'woocommerce_rest_api_enable_cache_headers' }, rt.ArrayItem{ key: 'type', val: 'checkbox' }, rt.ArrayItem{ key: 'default', val: 'yes' }, rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [rt.new_string('Enables including ETag and Cache-Control headers, and returning 304 Not Modified responses, for REST API endpoints configured as cacheable.'), rt.new_string('woocommerce')]) }]))
	var_settings.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: 'sectionend' }, rt.ArrayItem{ key: 'id', val: 'rest_api_cache_options' }]))
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_api_cache_settings'), var_settings.dup()])
}

fn (mut this Class_WC_Settings_Advanced) get_settings_for_blueprint_section() rt.PhpVal {
	mut var_settings := rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'id', val: 'wc_settings_blueprint_slotfill' }, rt.ArrayItem{ key: 'type', val: 'slotfill_placeholder' }]) }])
	return var_settings.dup()
}

fn (mut this Class_WC_Settings_Advanced) form_method(var_method rt.PhpVal) string {
	return 'post'
}

fn (mut this Class_WC_Settings_Advanced) notices()  {
	if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('section')) && rt.is_true(rt.identical(rt.new_string('webhooks'), rt.get_superglobal('_GET').array_get('section'))))) {
		fn () rt.PhpVal { mut temp := Class_WC_Admin_Webhooks{}; return temp.notices() }()
	}
	if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('section')) && rt.is_true(rt.identical(rt.new_string('keys'), rt.get_superglobal('_GET').array_get('section'))))) {
		fn () rt.PhpVal { mut temp := Class_WC_Admin_API_Keys{}; return temp.notices() }()
	}
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_WC_Settings_Advanced) output()  {
	mut var_current_section := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.identical(rt.new_string('blueprint'), var_current_section)) {
		mut var_hide_save_button := rt.new_bool(rt.new_bool(true))
	}
	if rt.is_true(rt.identical(rt.new_string('webhooks'), var_current_section)) {
		fn () rt.PhpVal { mut temp := Class_WC_Admin_Webhooks{}; return temp.page_output() }()
	} else if rt.is_true(rt.identical(rt.new_string('keys'), var_current_section)) {
		fn () rt.PhpVal { mut temp := Class_WC_Admin_API_Keys{}; return temp.page_output() }()
	} else {
		this.Class_WC_Settings_Page.output()
	}
}

fn (mut this Class_WC_Settings_Advanced) save()  {
	mut var_current_section := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_prev_value := rt.new_string(if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_allow_tracking'), rt.new_string('no')]))) { rt.new_string('yes') } else { rt.new_string('no') })
	mut var_new_value := rt.new_string(if rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('woocommerce_allow_tracking')) && rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('yes'), rt.get_superglobal('_POST').array_get('woocommerce_allow_tracking'))) || rt.is_true(rt.identical(rt.new_string('1'), rt.get_superglobal('_POST').array_get('woocommerce_allow_tracking'))))))) { rt.new_string('yes') } else { rt.new_string('no') })
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_api_valid_to_save'), rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_current_section.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'keys' }, rt.ArrayItem{ key: none, val: 'webhooks' }]), rt.new_bool(true)]))))])) {
		if rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('woocommerce_terms_page_id')) && rt.get_superglobal('_POST').array_isset(rt.new_string('woocommerce_checkout_page_id')) && rt.is_true(rt.identical(rt.get_superglobal('_POST').array_get('woocommerce_terms_page_id'), rt.get_superglobal('_POST').array_get('woocommerce_checkout_page_id'))))) {
			rt.get_superglobal('_POST').array_set('woocommerce_terms_page_id', '')
		}
		if rt.get_superglobal('_POST').array_isset(rt.new_string('woocommerce_cart_page_id')) && rt.get_superglobal('_POST').array_isset(rt.new_string('woocommerce_checkout_page_id')) && rt.get_superglobal('_POST').array_isset(rt.new_string('woocommerce_myaccount_page_id')) {
			if rt.is_true(rt.identical(rt.get_superglobal('_POST').array_get('woocommerce_cart_page_id'), rt.get_superglobal('_POST').array_get('woocommerce_checkout_page_id'))) {
				rt.get_superglobal('_POST').array_set('woocommerce_checkout_page_id', '')
			}
			if rt.is_true(rt.identical(rt.get_superglobal('_POST').array_get('woocommerce_cart_page_id'), rt.get_superglobal('_POST').array_get('woocommerce_myaccount_page_id'))) {
				rt.get_superglobal('_POST').array_set('woocommerce_myaccount_page_id', '')
			}
			if rt.is_true(rt.identical(rt.get_superglobal('_POST').array_get('woocommerce_checkout_page_id'), rt.get_superglobal('_POST').array_get('woocommerce_myaccount_page_id'))) {
				rt.get_superglobal('_POST').array_set('woocommerce_myaccount_page_id', '')
			}
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Tracks')])) && rt.is_true(rt.identical(rt.new_string('no'), var_new_value)))) && rt.is_true(rt.identical(rt.new_string('yes'), var_prev_value)))) {
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks{}; return temp.track_woocommerce_allow_tracking_toggled(arg_0, arg_1, arg_2) }(var_prev_value.dup(), var_new_value.dup(), rt.new_string('settings'))
		}
		this.save_settings_for_current_section()
		this.do_update_options_action()
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Tracks')])) && rt.is_true(rt.identical(rt.new_string('yes'), var_new_value)))) && rt.is_true(rt.identical(rt.new_string('no'), var_prev_value)))) {
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks{}; return temp.track_woocommerce_allow_tracking_toggled(arg_0, arg_1, arg_2) }(var_prev_value.dup(), var_new_value.dup(), rt.new_string('settings'))
		}
	}
	// unsupported statement: Stmt_Nop
}

struct Class_WC_Settings_Rest_API {
	rt.PhpObjectBase
}

struct Class_WC_Settings_Page {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Webhooks {
	rt.PhpObjectBase
}

struct Class_WC_Admin_API_Keys {
	rt.PhpObjectBase
}

struct Class_WC_Tracks {
	rt.PhpObjectBase
}

fn create_wc_settings_advanced() &Class_WC_Settings_Advanced {
	mut obj := &Class_WC_Settings_Advanced{
		PhpObjectBase: rt.PhpObjectBase{}
		icon: rt.new_string('more')
	}
	obj.construct()
	return obj
}

fn create_wc_settings_rest_api() &Class_WC_Settings_Rest_API {
	mut obj := &Class_WC_Settings_Rest_API{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_settings_page() &Class_WC_Settings_Page {
	mut obj := &Class_WC_Settings_Page{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil() &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_webhooks() &Class_WC_Admin_Webhooks {
	mut obj := &Class_WC_Admin_Webhooks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_api_keys() &Class_WC_Admin_API_Keys {
	mut obj := &Class_WC_Admin_API_Keys{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracks() &Class_WC_Tracks {
	mut obj := &Class_WC_Tracks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Settings_Advanced) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_own_sections' {
			return this.get_own_sections()
		}
		'get_settings_for_default_section' {
			return this.get_settings_for_default_section()
		}
		'get_settings_for_woocommerce_com_section' {
			return this.get_settings_for_woocommerce_com_section()
		}
		'get_settings_for_legacy_api_section' {
			return this.get_settings_for_legacy_api_section()
		}
		'get_settings_for_rest_api_caching_section' {
			return this.get_settings_for_rest_api_caching_section()
		}
		'get_settings_for_blueprint_section' {
			return this.get_settings_for_blueprint_section()
		}
		'form_method' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.form_method(dispatch_arg_0))
		}
		'notices' {
			this.notices()
			return rt.new_null()
		}
		'output' {
			this.output()
			return rt.new_null()
		}
		'save' {
			this.save()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Settings_Advanced) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'icon' { return this.icon }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Settings_Advanced) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'icon' { this.icon = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Settings_Rest_API) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Settings_Rest_API) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Settings_Rest_API) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Settings_Page) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Settings_Page) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Settings_Page) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Admin_Webhooks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Webhooks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Webhooks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Admin_API_Keys) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_API_Keys) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_API_Keys) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Tracks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tracks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_settings_class_wc_settings_advanced_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Settings_Advanced'), rt.new_bool(false)])) {
		return create_wc_settings_advanced()
	}
	return create_wc_settings_advanced()
	// unsupported statement: Stmt_Nop
}
