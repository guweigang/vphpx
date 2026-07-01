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
		var_data.array_push(var_automatewoo.dup())
	}
	if rt.is_true(var_aw_referral) {
		var_data.array_push(var_aw_referral.dup())
	}
	if rt.is_true(var_aw_birthdays) {
		var_data.array_push(var_aw_birthdays.dup())
	}
	if rt.is_true(var_mailchimp) {
		var_data.array_push(var_mailchimp.dup())
	}
	if rt.is_true(var_facebook) {
		var_data.array_push(var_facebook.dup())
	}
	if rt.is_true(var_pinterest) {
		var_data.array_push(var_pinterest.dup())
	}
	if rt.is_true(var_google) {
		var_data.array_push(var_google.dup())
	}
	if rt.is_true(var_amazon_ebay) {
		var_data.array_push(var_amazon_ebay.dup())
	}
	if rt.is_true(var_mailpoet) {
		var_data.array_push(var_mailpoet.dup())
	}
	if rt.is_true(var_klaviyo) {
		var_data.array_push(var_klaviyo.dup())
	}
	if rt.is_true(var_creative_mail) {
		var_data.array_push(var_creative_mail.dup())
	}
	if rt.is_true(var_tiktok) {
		var_data.array_push(var_tiktok.dup())
	}
	if rt.is_true(var_jetpack_crm) {
		var_data.array_push(var_jetpack_crm.dup())
	}
	if rt.is_true(var_zapier) {
		var_data.array_push(var_zapier.dup())
	}
	if rt.is_true(var_salesforce) {
		var_data.array_push(var_salesforce.dup())
	}
	if rt.is_true(var_vimeo) {
		var_data.array_push(var_vimeo.dup())
	}
	if rt.is_true(var_trustpilot) {
		var_data.array_push(var_trustpilot.dup())
	}
	return var_data.dup()
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_allowed_plugins() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'automatewoo' }, rt.ArrayItem{ key: none, val: 'mailchimp-for-woocommerce' }, rt.ArrayItem{ key: none, val: 'creative-mail-by-constant-contact' }, rt.ArrayItem{ key: none, val: 'facebook-for-woocommerce' }, rt.ArrayItem{ key: none, val: 'pinterest-for-woocommerce' }, rt.ArrayItem{ key: none, val: 'google-listings-and-ads' }, rt.ArrayItem{ key: none, val: 'hubspot-for-woocommerce' }, rt.ArrayItem{ key: none, val: 'woocommerce-amazon-ebay-integration' }, rt.ArrayItem{ key: none, val: 'mailpoet' }])
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_automatewoo_extension_data() bool {
	mut var_slug := rt.new_string(rt.new_string('automatewoo'))
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.is_plugin_installed(arg_0) }(var_slug.dup()))))) {
		return false
	}
	mut var_data := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_extension_base_data(var_slug.dup())
	var_data.array_set('icon', (rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/marketing/automatewoo.svg')
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('activated'), var_data.array_get('status'))) && rt.is_true(rt.call_function('function_exists', [rt.new_string('AW')])))) {
		var_data.array_set('settingsUrl', rt.call_function('admin_url', [rt.new_string('admin.php?page=automatewoo-settings')]))
		var_data.array_set('docsUrl', 'https://automatewoo.com/docs/')
		var_data.array_set('status', 'configured')
		// unsupported statement: Stmt_Nop
	}
	return (var_data).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_aw_referral_extension_data() bool {
	mut var_slug := rt.new_string(rt.new_string('automatewoo-referrals'))
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.is_plugin_installed(arg_0) }(var_slug.dup()))))) {
		return false
	}
	mut var_data := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_extension_base_data(var_slug.dup())
	var_data.array_set('icon', (rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/marketing/automatewoo.svg')
	if rt.is_true(rt.identical(rt.new_string('activated'), var_data.array_get('status'))) {
		var_data.array_set('docsUrl', 'https://automatewoo.com/docs/refer-a-friend/')
		var_data.array_set('status', 'configured')
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('AW_Referrals')])) {
			var_data.array_set('settingsUrl', rt.call_function('admin_url', [rt.new_string('admin.php?page=automatewoo-settings&tab=referrals')]))
		}
	}
	return (var_data).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_aw_birthdays_extension_data() bool {
	mut var_slug := rt.new_string(rt.new_string('automatewoo-birthdays'))
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.is_plugin_installed(arg_0) }(var_slug.dup()))))) {
		return false
	}
	mut var_data := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_extension_base_data(var_slug.dup())
	var_data.array_set('icon', (rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/marketing/automatewoo.svg')
	if rt.is_true(rt.identical(rt.new_string('activated'), var_data.array_get('status'))) {
		var_data.array_set('docsUrl', 'https://automatewoo.com/docs/getting-started-with-birthdays/')
		var_data.array_set('status', 'configured')
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('AW_Birthdays')])) {
			var_data.array_set('settingsUrl', rt.call_function('admin_url', [rt.new_string('admin.php?page=automatewoo-settings&tab=birthdays')]))
		}
	}
	return (var_data).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_mailchimp_extension_data() bool {
	mut var_slug := rt.new_string(rt.new_string('mailchimp-for-woocommerce'))
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.is_plugin_installed(arg_0) }(var_slug.dup()))))) {
		return false
	}
	mut var_data := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_extension_base_data(var_slug.dup())
	var_data.array_set('icon', (rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/marketing/mailchimp.svg')
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('activated'), var_data.array_get('status'))) && rt.is_true(rt.call_function('function_exists', [rt.new_string('mailchimp_is_configured')])))) {
		var_data.array_set('docsUrl', 'https://mailchimp.com/help/connect-or-disconnect-mailchimp-for-woocommerce/')
		var_data.array_set('settingsUrl', rt.call_function('admin_url', [rt.new_string('admin.php?page=mailchimp-woocommerce')]))
		if rt.is_true(rt.call_function('mailchimp_is_configured', []rt.PhpVal{})) {
			var_data.array_set('status', 'configured')
		}
	}
	return (var_data).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_facebook_extension_data() bool {
	mut var_slug := rt.new_string(rt.new_string('facebook-for-woocommerce'))
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.is_plugin_installed(arg_0) }(var_slug.dup()))))) {
		return false
	}
	mut var_data := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_extension_base_data(var_slug.dup())
	var_data.array_set('icon', (rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/marketing/facebook-icon.svg')
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('activated'), var_data.array_get('status'))) && rt.is_true(rt.call_function('function_exists', [rt.new_string('facebook_for_woocommerce')])))) {
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
	mut var_slug := rt.new_string(rt.new_string('pinterest-for-woocommerce'))
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.is_plugin_installed(arg_0) }(var_slug.dup()))))) {
		return false
	}
	mut var_data := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_extension_base_data(var_slug.dup())
	var_data.array_set('icon', (rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/marketing/pinterest.svg')
	var_data.array_set('docsUrl', 'https://woocommerce.com/document/pinterest-for-woocommerce/?utm_medium=product')
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('activated'), var_data.array_get('status'))) && rt.is_true(rt.call_function('class_exists', [rt.new_string('Pinterest_For_Woocommerce')])))) {
		mut var_pinterest_onboarding_completed := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Marketing_{"nodeType":"Expr_FuncCall","line":281,"name":"Pinterest_For_Woocommerce","args":[]}{}; return temp.is_setup_complete() }()
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
	mut var_slug := rt.new_string(rt.new_string('google-listings-and-ads'))
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.is_plugin_installed(arg_0) }(var_slug.dup()))))) {
		return false
	}
	mut var_data := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_extension_base_data(var_slug.dup())
	var_data.array_set('icon', (rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/marketing/google.svg')
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(, )) && rt.is_true(rt.call_function('function_exists', [])))) && rt.is_true(rt.call_function('class_exists', [rt.new_string('\\Automattic\\WooCommerce\\GoogleListingsAndAds\\MerchantCenter\\MerchantCenterService')])))) {
		mut var_merchant_center := rt.call_method(, 'get', [])
		if rt.is_true(rt.call_method(, 'is_setup_complete', []rt.PhpVal{})) {
			
		} else {
		}
		
	}
	return ().to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_amazon_ebay_extension_data() bool {
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_mailpoet_extension_data() bool {
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_klaviyo_extension_data() bool {
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_creative_mail_extension_data() bool {
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_tiktok_extension_data() bool {
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_jetpack_crm_extension_data() bool {
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_zapier_extension_data() bool {
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_salesforce_extension_data() bool {
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_vimeo_extension_data() bool {
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_trustpilot_extension_data() bool {
}

fn Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions.get_extension_base_data(var_slug rt.PhpVal) rt.PhpVal {
	mut var_slug_mutated := var_slug
}

struct Class_Automattic_WooCommerce_Admin_PluginsHelper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Marketing_{"nodeType":"Expr_FuncCall","line":281,"name":"Pinterest_For_Woocommerce","args":[]} {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_marketing_installedextensions() &Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions {
	mut obj := &Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pluginshelper() &Class_Automattic_WooCommerce_Admin_PluginsHelper {
	mut obj := &Class_Automattic_WooCommerce_Admin_PluginsHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_marketing_{"nodetype":"expr_funccall","line":281,"name":"pinterest_for_woocommerce","args":[]}() &Class_Automattic_WooCommerce_Admin_Marketing_{"nodeType":"Expr_FuncCall","line":281,"name":"Pinterest_For_Woocommerce","args":[]} {
	mut obj := &Class_Automattic_WooCommerce_Admin_Marketing_{"nodeType":"Expr_FuncCall","line":281,"name":"Pinterest_For_Woocommerce","args":[]}{
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




pub fn init_wp_content_plugins_woocommerce_src_admin_marketing_installedextensions_php() {
}
