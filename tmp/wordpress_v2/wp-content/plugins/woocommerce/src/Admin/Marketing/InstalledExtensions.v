import rt

struct Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_data() rt.PhpVal {
	mut var_data := rt.new_array()
	mut var_automatewoo := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_automatewoo_extension_data()
	mut var_aw_referral := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_aw_referral_extension_data()
	mut var_aw_birthdays := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_aw_birthdays_extension_data()
	mut var_mailchimp := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_mailchimp_extension_data()
	mut var_facebook := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_facebook_extension_data()
	mut var_pinterest := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_pinterest_extension_data()
	mut var_google := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_google_extension_data()
	mut var_amazon_ebay := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_amazon_ebay_extension_data()
	mut var_mailpoet := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_mailpoet_extension_data()
	mut var_klaviyo := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_klaviyo_extension_data()
	mut var_creative_mail := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_creative_mail_extension_data()
	mut var_tiktok := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_tiktok_extension_data()
	mut var_jetpack_crm := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_jetpack_crm_extension_data()
	mut var_zapier := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_zapier_extension_data()
	mut var_salesforce := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_salesforce_extension_data()
	mut var_vimeo := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_vimeo_extension_data()
	mut var_trustpilot := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_trustpilot_extension_data()
	if rt.is_true(var_automatewoo) {
		var_data.array_push(var_automatewoo.clone())
	}
	if rt.is_true(var_aw_referral) {
		var_data.array_push(var_aw_referral.clone())
	}
	if rt.is_true(var_aw_birthdays) {
		var_data.array_push(var_aw_birthdays.clone())
	}
	if rt.is_true(var_mailchimp) {
		var_data.array_push(var_mailchimp.clone())
	}
	if rt.is_true(var_facebook) {
		var_data.array_push(var_facebook.clone())
	}
	if rt.is_true(var_pinterest) {
		var_data.array_push(var_pinterest.clone())
	}
	if rt.is_true(var_google) {
		var_data.array_push(var_google.clone())
	}
	if rt.is_true(var_amazon_ebay) {
		var_data.array_push(var_amazon_ebay.clone())
	}
	if rt.is_true(var_mailpoet) {
		var_data.array_push(var_mailpoet.clone())
	}
	if rt.is_true(var_klaviyo) {
		var_data.array_push(var_klaviyo.clone())
	}
	if rt.is_true(var_creative_mail) {
		var_data.array_push(var_creative_mail.clone())
	}
	if rt.is_true(var_tiktok) {
		var_data.array_push(var_tiktok.clone())
	}
	if rt.is_true(var_jetpack_crm) {
		var_data.array_push(var_jetpack_crm.clone())
	}
	if rt.is_true(var_zapier) {
		var_data.array_push(var_zapier.clone())
	}
	if rt.is_true(var_salesforce) {
		var_data.array_push(var_salesforce.clone())
	}
	if rt.is_true(var_vimeo) {
		var_data.array_push(var_vimeo.clone())
	}
	if rt.is_true(var_trustpilot) {
		var_data.array_push(var_trustpilot.clone())
	}
	return var_data.clone()
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_allowed_plugins() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'automatewoo' }, rt.ArrayItem{ key: none, val: 'mailchimp-for-woocommerce' }, rt.ArrayItem{ key: none, val: 'creative-mail-by-constant-contact' }, rt.ArrayItem{ key: none, val: 'facebook-for-woocommerce' }, rt.ArrayItem{ key: none, val: 'pinterest-for-woocommerce' }, rt.ArrayItem{ key: none, val: 'google-listings-and-ads' }, rt.ArrayItem{ key: none, val: 'hubspot-for-woocommerce' }, rt.ArrayItem{ key: none, val: 'woocommerce-amazon-ebay-integration' }, rt.ArrayItem{ key: none, val: 'mailpoet' }])
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_automatewoo_extension_data() bool {
	mut var_slug := rt.new_string('automatewoo')
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_0 := iife_temp_0.is_plugin_installed(var_slug.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		return false
	}
	mut var_data := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_extension_base_data(var_slug.clone())
	var_data.array_set('icon', (rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/marketing/automatewoo.svg')
	if rt.is_true(rt.identical(rt.new_string('activated'), var_data.array_get(rt.new_string('status')))) && rt.is_true(rt.call_function('function_exists', [rt.new_string('AW')])) {
		var_data.array_set('settingsUrl', rt.call_function('admin_url', [rt.new_string('admin.php?page=automatewoo-settings')]))
		var_data.array_set('docsUrl', 'https://automatewoo.com/docs/')
		var_data.array_set('status', 'configured')
	}
	return (var_data).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_aw_referral_extension_data() bool {
	mut var_slug := rt.new_string('automatewoo-referrals')
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_1 := iife_temp_1.is_plugin_installed(var_slug.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_1)))) {
		return false
	}
	mut var_data := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_extension_base_data(var_slug.clone())
	var_data.array_set('icon', (rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/marketing/automatewoo.svg')
	if rt.is_true(rt.identical(rt.new_string('activated'), var_data.array_get(rt.new_string('status')))) {
		var_data.array_set('docsUrl', 'https://automatewoo.com/docs/refer-a-friend/')
		var_data.array_set('status', 'configured')
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('AW_Referrals')])) {
			var_data.array_set('settingsUrl', rt.call_function('admin_url', [rt.new_string('admin.php?page=automatewoo-settings&tab=referrals')]))
		}
	}
	return (var_data).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_aw_birthdays_extension_data() bool {
	mut var_slug := rt.new_string('automatewoo-birthdays')
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_2 := iife_temp_2.is_plugin_installed(var_slug.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_2)))) {
		return false
	}
	mut var_data := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_extension_base_data(var_slug.clone())
	var_data.array_set('icon', (rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/marketing/automatewoo.svg')
	if rt.is_true(rt.identical(rt.new_string('activated'), var_data.array_get(rt.new_string('status')))) {
		var_data.array_set('docsUrl', 'https://automatewoo.com/docs/getting-started-with-birthdays/')
		var_data.array_set('status', 'configured')
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('AW_Birthdays')])) {
			var_data.array_set('settingsUrl', rt.call_function('admin_url', [rt.new_string('admin.php?page=automatewoo-settings&tab=birthdays')]))
		}
	}
	return (var_data).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_mailchimp_extension_data() bool {
	mut var_slug := rt.new_string('mailchimp-for-woocommerce')
	mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_3 := iife_temp_3.is_plugin_installed(var_slug.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_3)))) {
		return false
	}
	mut var_data := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_extension_base_data(var_slug.clone())
	var_data.array_set('icon', (rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/marketing/mailchimp.svg')
	if rt.is_true(rt.identical(rt.new_string('activated'), var_data.array_get(rt.new_string('status')))) && rt.is_true(rt.call_function('function_exists', [rt.new_string('mailchimp_is_configured')])) {
		var_data.array_set('docsUrl', 'https://mailchimp.com/help/connect-or-disconnect-mailchimp-for-woocommerce/')
		var_data.array_set('settingsUrl', rt.call_function('admin_url', [rt.new_string('admin.php?page=mailchimp-woocommerce')]))
		if rt.is_true(rt.call_function('mailchimp_is_configured', []rt.PhpVal{})) {
			var_data.array_set('status', 'configured')
		}
	}
	return (var_data).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_facebook_extension_data() bool {
	mut var_slug := rt.new_string('facebook-for-woocommerce')
	mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_4 := iife_temp_4.is_plugin_installed(var_slug.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_4)))) {
		return false
	}
	mut var_data := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_extension_base_data(var_slug.clone())
	var_data.array_set('icon', (rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/marketing/facebook-icon.svg')
	if rt.is_true(rt.identical(rt.new_string('activated'), var_data.array_get(rt.new_string('status')))) && rt.is_true(rt.call_function('function_exists', [rt.new_string('facebook_for_woocommerce')])) {
		mut var_integration := rt.call_method(rt.call_function('facebook_for_woocommerce', []rt.PhpVal{}), 'get_integration', []rt.PhpVal{})
		if rt.is_true(rt.call_method(var_integration, 'is_configured', []rt.PhpVal{})) {
			var_data.array_set('status', 'configured')
		}
		var_data.array_set('settingsUrl', rt.call_method(rt.call_function('facebook_for_woocommerce', []rt.PhpVal{}), 'get_settings_url', []rt.PhpVal{}))
		var_data.array_set('docsUrl', rt.call_method(rt.call_function('facebook_for_woocommerce', []rt.PhpVal{}), 'get_documentation_url', []rt.PhpVal{}))
	}
	return (var_data).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_pinterest_extension_data() bool {
	mut var_slug := rt.new_string('pinterest-for-woocommerce')
	mut iife_temp_5 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_5 := iife_temp_5.is_plugin_installed(var_slug.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_5)))) {
		return false
	}
	mut var_data := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_extension_base_data(var_slug.clone())
	var_data.array_set('icon', (rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/marketing/pinterest.svg')
	var_data.array_set('docsUrl', 'https://woocommerce.com/document/pinterest-for-woocommerce/?utm_medium=product')
	if rt.is_true(rt.identical(rt.new_string('activated'), var_data.array_get(rt.new_string('status')))) && rt.is_true(rt.call_function('class_exists', [rt.new_string('Pinterest_For_Woocommerce')])) {
		mut iife_temp_6 := Class_Automattic_WooCommerce_Admin_Marketing_{"nodeType":"Expr_FuncCall","line":281,"name":"Pinterest_For_Woocommerce","args":[]}{}
		mut iife_result_6 := iife_temp_6.is_setup_complete()
		mut var_pinterest_onboarding_completed := iife_result_6
		if rt.is_true(var_pinterest_onboarding_completed) {
			var_data.array_set('status', 'configured')
			var_data.array_set('settingsUrl', rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-admin&path=/pinterest/settings')]))
		} else {
			var_data.array_set('settingsUrl', rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-admin&path=/pinterest/landing')]))
		}
	}
	return (var_data).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_google_extension_data() bool {
	mut var_slug := rt.new_string('google-listings-and-ads')
	mut iife_temp_7 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_7 := iife_temp_7.is_plugin_installed(var_slug.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_7)))) {
		return false
	}
	mut var_data := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_extension_base_data(var_slug.clone())
	var_data.array_set('icon', (rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/marketing/google.svg')
	if rt.is_true(rt.identical(rt.new_string('activated'), var_data.array_get(rt.new_string('status')))) && rt.is_true(rt.call_function('function_exists', [rt.new_string('woogle_get_container')])) && rt.is_true(rt.call_function('class_exists', [rt.new_string('\\Automattic\\WooCommerce\\GoogleListingsAndAds\\MerchantCenter\\MerchantCenterService')])) {
		mut var_merchant_center := rt.call_method(rt.call_function('woogle_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Admin_Marketing_Automattic_WooCommerce_GoogleListingsAndAds_MerchantCenter_MerchantCenterService.class()])
		if rt.is_true(rt.call_method(var_merchant_center, 'is_setup_complete', []rt.PhpVal{})) {
			var_data.array_set('status', 'configured')
			var_data.array_set('settingsUrl', rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-admin&path=/google/settings')]))
		} else {
			var_data.array_set('settingsUrl', rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-admin&path=/google/start')]))
		}
		var_data.array_set('docsUrl', 'https://woocommerce.com/document/google-listings-and-ads/?utm_medium=product')
	}
	return (var_data).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_amazon_ebay_extension_data() bool {
	mut var_slug := rt.new_string('woocommerce-amazon-ebay-integration')
	mut iife_temp_8 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_8 := iife_temp_8.is_plugin_installed(var_slug.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_8)))) {
		return false
	}
	mut var_data := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_extension_base_data(var_slug.clone())
	var_data.array_set('icon', (rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/marketing/amazon-ebay.svg')
	if rt.is_true(rt.identical(rt.new_string('activated'), var_data.array_get(rt.new_string('status')))) && rt.is_true(rt.call_function('class_exists', [rt.new_string('\\CodistoConnect')])) {
		mut var_codisto_merchantid := rt.call_function('get_option', [rt.new_string('codisto_merchantid')])
		if rt.is_true(rt.new_bool(var_codisto_merchantid.clone().is_long() || var_codisto_merchantid.clone().is_double())) {
			var_data.array_set('status', 'configured')
		}
		var_data.array_set('settingsUrl', rt.call_function('admin_url', [rt.new_string('admin.php?page=codisto-settings')]))
		var_data.array_set('docsUrl', 'https://woocommerce.com/document/multichannel-for-woocommerce-google-amazon-ebay-walmart-integration/?utm_medium=product')
	}
	return (var_data).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_mailpoet_extension_data() bool {
	mut var_slug := rt.new_string('mailpoet')
	mut iife_temp_9 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_9 := iife_temp_9.is_plugin_installed(var_slug.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_9)))) {
		return false
	}
	mut var_data := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_extension_base_data(var_slug.clone())
	var_data.array_set('icon', (rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/marketing/mailpoet.svg')
	if rt.is_true(rt.identical(rt.new_string('activated'), var_data.array_get(rt.new_string('status')))) && rt.is_true(rt.call_function('class_exists', [rt.new_string('\\MailPoet\\API\\API')])) {
		mut iife_temp_10 := Class_Automattic_WooCommerce_Admin_Marketing_MailPoet_API_API{}
		mut iife_result_10 := iife_temp_10.mp(rt.new_string('v1'))
		mut var_mailpoet_api := iife_result_10
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('method_exists', [var_mailpoet_api.clone(), rt.new_string('isSetupComplete')]))))) || rt.is_true(rt.call_method(var_mailpoet_api, 'isSetupComplete', []rt.PhpVal{})) {
			var_data.array_set('status', 'configured')
			var_data.array_set('settingsUrl', rt.call_function('admin_url', [rt.new_string('admin.php?page=mailpoet-settings')]))
		} else {
			var_data.array_set('settingsUrl', rt.call_function('admin_url', [rt.new_string('admin.php?page=mailpoet-newsletters')]))
		}
		var_data.array_set('docsUrl', 'https://kb.mailpoet.com/')
		var_data.array_set('supportUrl', 'https://www.mailpoet.com/support/')
	}
	return (var_data).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_klaviyo_extension_data() bool {
	mut var_slug := rt.new_string('klaviyo')
	mut iife_temp_11 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_11 := iife_temp_11.is_plugin_installed(var_slug.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_11)))) {
		return false
	}
	mut var_data := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_extension_base_data(var_slug.clone())
	var_data.array_set('icon', rt.call_function('plugins_url', [rt.new_string('assets/images/marketing/klaviyo.png'), rt.get_constant('WC_PLUGIN_FILE')]))
	if rt.is_true(rt.identical(rt.new_string('activated'), var_data.array_get(rt.new_string('status')))) {
		mut var_klaviyo_options := rt.call_function('get_option', [rt.new_string('klaviyo_settings')])
		if var_klaviyo_options.array_isset(rt.new_string('klaviyo_public_api_key')) {
			var_data.array_set('status', 'configured')
		}
		var_data.array_set('settingsUrl', rt.call_function('admin_url', [rt.new_string('admin.php?page=klaviyo_settings')]))
	}
	return (var_data).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_creative_mail_extension_data() bool {
	mut var_slug := rt.new_string('creative-mail-by-constant-contact')
	mut iife_temp_12 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_12 := iife_temp_12.is_plugin_installed(var_slug.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_12)))) {
		return false
	}
	mut var_data := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_extension_base_data(var_slug.clone())
	var_data.array_set('icon', (rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/marketing/creative-mail-by-constant-contact.png')
	if rt.is_true(rt.identical(rt.new_string('activated'), var_data.array_get(rt.new_string('status')))) && rt.is_true(rt.call_function('class_exists', [rt.new_string('\\CreativeMail\\Helpers\\OptionsHelper')])) {
		mut iife_temp_13 := Class_Automattic_WooCommerce_Admin_Marketing_CreativeMail_Helpers_OptionsHelper{}
		mut iife_result_13 := iife_temp_13.get_instance_id()
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('method_exists', [rt.new_string('\\CreativeMail\\Helpers\\OptionsHelper'), rt.new_string('get_instance_id')]))))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_13, rt.new_null())))) {
			var_data.array_set('status', 'configured')
			var_data.array_set('settingsUrl', rt.call_function('admin_url', [rt.new_string('admin.php?page=creativemail_settings')]))
		} else {
			var_data.array_set('settingsUrl', rt.call_function('admin_url', [rt.new_string('admin.php?page=creativemail')]))
		}
		var_data.array_set('docsUrl', 'https://app.creativemail.com/kb/help/WooCommerce')
		var_data.array_set('supportUrl', 'https://app.creativemail.com/kb/help/')
	}
	return (var_data).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_tiktok_extension_data() bool {
	mut var_slug := rt.new_string('tiktok-for-business')
	mut iife_temp_14 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_14 := iife_temp_14.is_plugin_installed(var_slug.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_14)))) {
		return false
	}
	mut var_data := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_extension_base_data(var_slug.clone())
	var_data.array_set('icon', (rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/marketing/tiktok.jpg')
	if rt.is_true(rt.identical(rt.new_string('activated'), var_data.array_get(rt.new_string('status')))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('get_option', [rt.new_string('tt4b_access_token')]))))) {
			var_data.array_set('status', 'configured')
		}
		var_data.array_set('settingsUrl', rt.call_function('admin_url', [rt.new_string('admin.php?page=tiktok')]))
		var_data.array_set('docsUrl', 'https://woocommerce.com/document/tiktok-for-woocommerce/')
		var_data.array_set('supportUrl', 'https://ads.tiktok.com/athena/user-feedback/?identify_key=6a1e079024806640c5e1e695d13db80949525168a052299b4970f9c99cb5ac78')
	}
	return (var_data).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_jetpack_crm_extension_data() bool {
	mut var_slug := rt.new_string('zero-bs-crm')
	mut iife_temp_15 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_15 := iife_temp_15.is_plugin_installed(var_slug.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_15)))) {
		return false
	}
	mut var_data := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_extension_base_data(var_slug.clone())
	var_data.array_set('icon', (rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/marketing/jetpack-crm.png')
	if rt.is_true(rt.identical(rt.new_string('activated'), var_data.array_get(rt.new_string('status')))) {
		var_data.array_set('status', 'configured')
		var_data.array_set('settingsUrl', rt.call_function('admin_url', [rt.new_string('admin.php?page=zerobscrm-plugin-settings')]))
		var_data.array_set('docsUrl', 'https://kb.jetpackcrm.com/')
		var_data.array_set('supportUrl', 'https://kb.jetpackcrm.com/crm-support/')
	}
	return (var_data).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_zapier_extension_data() bool {
	mut var_slug := rt.new_string('woocommerce-zapier')
	mut iife_temp_16 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_16 := iife_temp_16.is_plugin_installed(var_slug.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_16)))) {
		return false
	}
	mut var_data := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_extension_base_data(var_slug.clone())
	var_data.array_set('icon', (rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/marketing/zapier.png')
	if rt.is_true(rt.identical(rt.new_string('activated'), var_data.array_get(rt.new_string('status')))) {
		var_data.array_set('status', 'configured')
		var_data.array_set('settingsUrl', rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=wc_zapier')]))
		var_data.array_set('docsUrl', 'https://docs.om4.io/woocommerce-zapier/')
	}
	return (var_data).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_salesforce_extension_data() bool {
	mut var_slug := rt.new_string('integration-with-salesforce')
	mut iife_temp_17 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_17 := iife_temp_17.is_plugin_installed(var_slug.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_17)))) {
		return false
	}
	mut var_data := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_extension_base_data(var_slug.clone())
	var_data.array_set('icon', (rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/marketing/salesforce.jpg')
	if rt.is_true(rt.identical(rt.new_string('activated'), var_data.array_get(rt.new_string('status')))) && rt.is_true(rt.call_function('class_exists', [rt.new_string('\\Integration_With_Salesforce_Admin')])) {
		mut iife_temp_18 := Class_Automattic_WooCommerce_Admin_Marketing_Integration_With_Salesforce_Admin{}
		mut iife_result_18 := iife_temp_18.get_connection_status()
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('method_exists', [rt.new_string('\\Integration_With_Salesforce_Admin'), rt.new_string('get_connection_status')]))))) || rt.is_true(iife_result_18) {
			var_data.array_set('status', 'configured')
		}
		var_data.array_set('settingsUrl', rt.call_function('admin_url', [rt.new_string('admin.php?page=integration-with-salesforce')]))
		var_data.array_set('docsUrl', 'https://woocommerce.com/document/salesforce-integration/')
		var_data.array_set('supportUrl', 'https://wpswings.com/submit-query/')
	}
	return (var_data).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_vimeo_extension_data() bool {
	mut var_slug := rt.new_string('vimeo')
	mut iife_temp_19 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_19 := iife_temp_19.is_plugin_installed(var_slug.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_19)))) {
		return false
	}
	mut var_data := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_extension_base_data(var_slug.clone())
	var_data.array_set('icon', (rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/marketing/vimeo.png')
	if rt.is_true(rt.identical(rt.new_string('activated'), var_data.array_get(rt.new_string('status')))) && rt.is_true(rt.call_function('class_exists', [rt.new_string('\\Tribe\\Vimeo_WP\\Vimeo\\Vimeo_Auth')])) {
		if rt.is_true(rt.call_function('method_exists', [rt.new_string('\\Tribe\\Vimeo_WP\\Vimeo\\Vimeo_Auth'), rt.new_string('has_access_token')])) {
			mut var_vimeo_auth := create_automattic_woocommerce_admin_marketing_tribe_vimeo_wp_vimeo_vimeo_auth()
			if rt.is_true(var_vimeo_auth.has_access_token()) {
				var_data.array_set('status', 'configured')
			}
		} else {
			var_data.array_set('status', 'configured')
		}
		var_data.array_set('settingsUrl', rt.call_function('admin_url', [rt.new_string('options-general.php?page=vimeo_settings')]))
		var_data.array_set('docsUrl', 'https://woocommerce.com/document/vimeo/')
		var_data.array_set('supportUrl', 'https://vimeo.com/help/contact')
	}
	return (var_data).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_trustpilot_extension_data() bool {
	mut var_slug := rt.new_string('trustpilot-reviews')
	mut iife_temp_20 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_20 := iife_temp_20.is_plugin_installed(var_slug.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_20)))) {
		return false
	}
	mut var_data := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_extension_base_data(var_slug.clone())
	var_data.array_set('icon', (rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/marketing/trustpilot.png')
	if rt.is_true(rt.identical(rt.new_string('activated'), var_data.array_get(rt.new_string('status')))) {
		var_data.array_set('status', 'configured')
		var_data.array_set('settingsUrl', rt.call_function('admin_url', [rt.new_string('admin.php?page=woocommerce-trustpilot-settings-page')]))
		var_data.array_set('docsUrl', 'https://woocommerce.com/document/trustpilot-reviews/')
		var_data.array_set('supportUrl', 'https://support.trustpilot.com/hc/en-us/requests/new')
	}
	return (var_data).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_extension_base_data(var_slug rt.PhpVal) rt.PhpVal {
	mut var_slug_mutated := var_slug
	mut iife_temp_21 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_21 := iife_temp_21.is_plugin_active(var_slug_mutated.clone())
	mut var_status := rt.new_string((if rt.is_true(iife_result_21) { 'activated' } else { 'installed' }).str())
	mut iife_temp_22 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_22 := iife_temp_22.get_plugin_data(var_slug_mutated.clone())
	mut var_plugin_data := iife_result_22
	if rt.is_true(rt.new_bool(!(rt.is_true(var_plugin_data)))) {
		return rt.new_bool(false)
	}
	return rt.create_array([rt.ArrayItem{ key: 'slug', val: var_slug_mutated }, rt.ArrayItem{ key: 'status', val: var_status }, rt.ArrayItem{ key: 'name', val: var_plugin_data.array_get(rt.new_string('Name')) }, rt.ArrayItem{ key: 'description', val: rt.call_function('html_entity_decode', [rt.call_function('wp_trim_words', [var_plugin_data.array_get(rt.new_string('Description')), rt.new_int(20)])]) }, rt.ArrayItem{ key: 'supportUrl', val: 'https://woocommerce.com/my-account/create-a-ticket/?utm_medium=product' }])
}

struct Class_Automattic_WooCommerce_Admin_PluginsHelper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Marketing_{"nodeType":"Expr_FuncCall","line":281,"name":"Pinterest_For_Woocommerce","args":[]} {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Marketing_MailPoet_API_API {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Marketing_CreativeMail_Helpers_OptionsHelper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Marketing_Integration_With_Salesforce_Admin {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Marketing_Tribe_Vimeo_WP_Vimeo_Vimeo_Auth {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_marketing_installedextensions(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions {
	mut obj := &Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pluginshelper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_PluginsHelper {
	mut obj := &Class_Automattic_WooCommerce_Admin_PluginsHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_marketing_{"nodetype":"expr_funccall","line":281,"name":"pinterest_for_woocommerce","args":[]}(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Marketing_{"nodeType":"Expr_FuncCall","line":281,"name":"Pinterest_For_Woocommerce","args":[]} {
	mut obj := &Class_Automattic_WooCommerce_Admin_Marketing_{"nodeType":"Expr_FuncCall","line":281,"name":"Pinterest_For_Woocommerce","args":[]}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_marketing_mailpoet_api_api(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Marketing_MailPoet_API_API {
	mut obj := &Class_Automattic_WooCommerce_Admin_Marketing_MailPoet_API_API{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_marketing_creativemail_helpers_optionshelper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Marketing_CreativeMail_Helpers_OptionsHelper {
	mut obj := &Class_Automattic_WooCommerce_Admin_Marketing_CreativeMail_Helpers_OptionsHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_marketing_integration_with_salesforce_admin(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Marketing_Integration_With_Salesforce_Admin {
	mut obj := &Class_Automattic_WooCommerce_Admin_Marketing_Integration_With_Salesforce_Admin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_marketing_tribe_vimeo_wp_vimeo_vimeo_auth(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Marketing_Tribe_Vimeo_WP_Vimeo_Vimeo_Auth {
	mut obj := &Class_Automattic_WooCommerce_Admin_Marketing_Tribe_Vimeo_WP_Vimeo_Vimeo_Auth{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_data' {
			return Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_data()
		}
		'get_allowed_plugins' {
			return Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_allowed_plugins()
		}
		'get_automatewoo_extension_data' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_automatewoo_extension_data())
		}
		'get_aw_referral_extension_data' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_aw_referral_extension_data())
		}
		'get_aw_birthdays_extension_data' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_aw_birthdays_extension_data())
		}
		'get_mailchimp_extension_data' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_mailchimp_extension_data())
		}
		'get_facebook_extension_data' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_facebook_extension_data())
		}
		'get_pinterest_extension_data' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_pinterest_extension_data())
		}
		'get_google_extension_data' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_google_extension_data())
		}
		'get_amazon_ebay_extension_data' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_amazon_ebay_extension_data())
		}
		'get_mailpoet_extension_data' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_mailpoet_extension_data())
		}
		'get_klaviyo_extension_data' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_klaviyo_extension_data())
		}
		'get_creative_mail_extension_data' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_creative_mail_extension_data())
		}
		'get_tiktok_extension_data' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_tiktok_extension_data())
		}
		'get_jetpack_crm_extension_data' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_jetpack_crm_extension_data())
		}
		'get_zapier_extension_data' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_zapier_extension_data())
		}
		'get_salesforce_extension_data' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_salesforce_extension_data())
		}
		'get_vimeo_extension_data' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_vimeo_extension_data())
		}
		'get_trustpilot_extension_data' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_trustpilot_extension_data())
		}
		'get_extension_base_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_extension_base_data(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_{"nodeType":"Expr_FuncCall","line":281,"name":"Pinterest_For_Woocommerce","args":[]}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Marketing_{"nodeType":"Expr_FuncCall","line":281,"name":"Pinterest_For_Woocommerce","args":[]}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_{"nodeType":"Expr_FuncCall","line":281,"name":"Pinterest_For_Woocommerce","args":[]}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_MailPoet_API_API) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Marketing_MailPoet_API_API) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_MailPoet_API_API) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_CreativeMail_Helpers_OptionsHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Marketing_CreativeMail_Helpers_OptionsHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_CreativeMail_Helpers_OptionsHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_Integration_With_Salesforce_Admin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Marketing_Integration_With_Salesforce_Admin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_Integration_With_Salesforce_Admin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_Tribe_Vimeo_WP_Vimeo_Vimeo_Auth) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Marketing_Tribe_Vimeo_WP_Vimeo_Vimeo_Auth) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_Tribe_Vimeo_WP_Vimeo_Vimeo_Auth) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
