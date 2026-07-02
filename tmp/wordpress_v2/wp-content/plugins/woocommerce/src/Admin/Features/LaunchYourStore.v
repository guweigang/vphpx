import rt

pub fn Class_Automattic_WooCommerce_Admin_Features_LaunchYourStore.banner_dismiss_user_meta_key() string {
	return 'coming_soon_banner_dismissed'
}

struct Class_Automattic_WooCommerce_Admin_Features_LaunchYourStore {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_LaunchYourStore) construct() {
	rt.call_function('add_action', [
		rt.new_string('woocommerce_update_options_site-visibility'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_LaunchYourStore',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'save_site_visibility_options' },
		]),
	])
	rt.call_function('add_filter', [rt.new_string('woocommerce_admin_shared_settings'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_LaunchYourStore',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'preload_settings' },
		])])
	rt.call_function('add_action', [rt.new_string('wp_footer'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_LaunchYourStore',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'maybe_add_coming_soon_banner_on_frontend' },
		])])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_LaunchYourStore',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_launch_your_store_user_meta_fields' },
		])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_tracks_event_properties'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_LaunchYourStore',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'append_coming_soon_global_tracks' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('wp_login'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_LaunchYourStore',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'reset_woocommerce_coming_soon_banner_dismissed' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_admin_get_user_data_fields'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_LaunchYourStore',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_user_data_fields' },
		]),
	])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_0 := iife_temp_0.is_enabled(rt.new_string('coming-soon-newsletter-template'))
	if rt.is_true(iife_result_0) {
		rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_LaunchYourStore',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'load_newsletter_scripts' },
			])])
		rt.call_function('add_action', [rt.new_string('save_post_wp_template'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_LaunchYourStore',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'maybe_track_template_change' },
			]),
			rt.new_int(10), rt.new_int(3)])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_LaunchYourStore) save_site_visibility_options() {
	mut var_nonce := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('_wpnonce')) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wpnonce'))]),
		]) } else { rt.new_string('') }
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_1 := iife_temp_1.is_enabled(rt.new_string('settings'))
	mut var_nonce_string := rt.new_string((if rt.is_true(iife_result_1) {
		'wp_rest'
	} else {
		'woocommerce-settings'
	}).str())
	if !rt.is_true(var_nonce)
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [var_nonce.clone(), var_nonce_string.clone()]))))) {
		return
	}
	mut var_options := rt.create_array([
		rt.ArrayItem{ key: 'woocommerce_coming_soon', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'yes' },
			rt.ArrayItem{ key: none, val: 'no' },
		]) },
		rt.ArrayItem{ key: 'woocommerce_store_pages_only', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'yes' },
			rt.ArrayItem{ key: none, val: 'no' },
		]) },
		rt.ArrayItem{ key: 'woocommerce_private_link', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'yes' },
			rt.ArrayItem{ key: none, val: 'no' },
		]) },
	])
	mut var_event_data := rt.new_array()
	mut iter_1 := var_options.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_allowed_values := item_1.val
		mut var_name := item_1.key
		mut var_current_value := rt.call_function('get_option', [
			var_name.clone(), rt.new_string('not set')])
		mut var_new_value := var_current_value.clone()
		if rt.get_superglobal('_POST').array_isset(var_name) {
			mut var_input_value := rt.call_function('sanitize_text_field', [
				rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(var_name)]),
			])
			if rt.is_true(rt.call_function('in_array', [var_input_value.clone(),
				var_allowed_values.clone(), rt.new_bool(true)]))
			{
				rt.call_function('update_option', [var_name.clone(),
					var_input_value.clone()])
				var_new_value = var_input_value.clone()
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_current_value, var_new_value)))) {
					mut var_enabled_or_disabled := rt.new_string((if rt.is_true(rt.identical(rt.new_string('yes'),
						var_new_value))
					{
						'enabled'
					} else {
						'disabled'
					}).str())
					var_event_data.array_set(var_name.str() + '_toggled',
						var_enabled_or_disabled.clone())
				}
			}
		}
		var_event_data.array_set(var_name, var_new_value.clone())
	}
	rt.call_function('wc_admin_record_tracks_event', [
		rt.new_string('site_visibility_saved'),
		var_event_data.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_LaunchYourStore) append_coming_soon_global_tracks(var_event_properties rt.PhpVal) rt.PhpVal {
	mut var_event_properties_mutated := var_event_properties
	if rt.is_true(rt.new_bool(var_event_properties_mutated.clone().is_array())) {
		mut var_coming_soon := rt.new_string('no')
		if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
			rt.new_string('woocommerce_coming_soon'),
			rt.new_string('no'),
		])))
		{
			if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
				rt.new_string('woocommerce_store_pages_only'),
				rt.new_string('no'),
			])))
			{
				var_coming_soon = rt.new_string('store')
			} else {
				var_coming_soon = rt.new_string('site')
			}
		}
		var_event_properties_mutated.array_set('coming_soon', var_coming_soon.clone())
	}
	return var_event_properties_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_LaunchYourStore) preload_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		return var_settings_mutated.clone()
	}
	mut var_current_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	mut var_is_setting_page := rt.new_bool(rt.is_true(var_current_screen)
		&& rt.is_true(rt.identical(rt.new_string('woocommerce_page_wc-settings'), rt.get_property(var_current_screen, 'id'))))
	mut var_is_woopayments_connect := rt.new_bool(
		rt.get_superglobal('_GET').array_isset(rt.new_string('path'))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('page'))
		&& rt.is_true(rt.identical(rt.new_string('/payments/connect'), rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('path'))])])))
		|| rt.is_true(rt.identical(rt.new_string('/payments/onboarding'), rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('path'))])])))
		&& rt.is_true(rt.identical(rt.new_string('wc-admin'), rt.get_superglobal('_GET').array_get(rt.new_string('page')))))
	if rt.is_true(var_is_setting_page) || rt.is_true(var_is_woopayments_connect) {
		rt.call_function('add_option', [rt.new_string('woocommerce_share_key'),
			rt.call_function('wp_generate_password', [rt.new_int(32),
				rt.new_bool(false)])])
		var_settings_mutated.array_set('siteVisibilitySettings', rt.create_array([
			rt.ArrayItem{ key: 'shop_permalink', val: rt.call_function('get_permalink', [
				rt.call_function('wc_get_page_id', [rt.new_string('shop')]),
			]) },
			rt.ArrayItem{ key: 'woocommerce_coming_soon', val: rt.call_function('get_option', [
				rt.new_string('woocommerce_coming_soon'),
			]) },
			rt.ArrayItem{ key: 'woocommerce_store_pages_only', val: rt.call_function('get_option', [
				rt.new_string('woocommerce_store_pages_only'),
			]) },
			rt.ArrayItem{ key: 'woocommerce_private_link', val: rt.call_function('get_option', [
				rt.new_string('woocommerce_private_link'),
			]) },
			rt.ArrayItem{ key: 'woocommerce_share_key', val: rt.call_function('get_option', [
				rt.new_string('woocommerce_share_key'),
			]) },
		]))
	}
	return var_settings_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_LaunchYourStore) is_manager_or_admin() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('shop_manager')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('administrator')]))))) {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_LaunchYourStore) maybe_add_coming_soon_banner_on_frontend() bool {
	if rt.get_superglobal('_GET').array_isset(rt.new_string('site-preview')) {
		return false
	}
	mut var_current_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_current_user_id)))) {
		return false
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser{}
	mut iife_result_2 := iife_temp_2.get_user_data_field(var_current_user_id.clone(),
		Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Admin_Features_LaunchYourStore.banner_dismiss_user_meta_key())
	mut var_has_dismissed_banner := rt.new_bool(rt.is_true(iife_result_2)
		|| rt.is_true(rt.identical(rt.call_function('get_user_meta', [var_current_user_id.clone(), rt.new_string('woocommerce_' + (Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Admin_Features_LaunchYourStore.banner_dismiss_user_meta_key()).str()), rt.new_bool(true)]), rt.new_string('yes'))))
	if rt.is_true(var_has_dismissed_banner) {
		return false
	}
	if !(this.is_manager_or_admin()) {
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_option', [
		rt.new_string('woocommerce_coming_soon'),
		rt.new_string('no'),
	]), rt.new_string('yes')))))
	{
		return false
	}
	mut var_store_pages_only := rt.identical(rt.call_function('get_option', [
		rt.new_string('woocommerce_store_pages_only'),
	]), rt.new_string('yes'))
	mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_WCAdminHelper{}
	mut iife_result_3 := iife_temp_3.is_current_page_store_page()
	if rt.is_true(var_store_pages_only) && rt.is_true(rt.new_bool(!(rt.is_true(iife_result_3)))) {
		return false
	}
	mut var_link := rt.call_function('admin_url', [
		rt.new_string('admin.php?page=wc-settings&tab=site-visibility'),
	])
	mut var_rest_url := rt.call_function('rest_url', [
		rt.new_string('wp/v2/users/' + var_current_user_id.str()),
	])
	mut var_rest_nonce := rt.call_function('wp_create_nonce', [
		rt.new_string('wp_rest')])
	mut var_text := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('\n\t\t\tThis page is in "Coming soon" mode and is only visible to you and those who have permission. To make it public to everyone,&nbsp;<a href=\'%s\'>change visibility settings</a>.\n\t\t'),
			rt.new_string('woocommerce'),
		]),
		var_link.clone(),
	])
	print("<div id='coming-soon-footer-banner'><div class='coming-soon-footer-banner__content'>${var_text.to_string()}</div><a class='coming-soon-footer-banner-dismiss' data-rest-url='${var_rest_url.to_string()}' data-rest-nonce='${var_rest_nonce.to_string()}'></a></div>")
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_LaunchYourStore) register_launch_your_store_user_meta_fields() {
	if !(this.is_manager_or_admin()) {
		return
	}
	rt.call_function('register_meta', [rt.new_string('user'),
		rt.new_string('woocommerce_launch_your_store_tour_hidden'),
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'description'
				val: 'Indicate whether the user has dismissed the site visibility tour on the home screen.'
			}, rt.ArrayItem{ key: 'single', val: true }, rt.ArrayItem{
				key: 'show_in_rest'
				val: true
			}])])
	rt.call_function('register_meta', [rt.new_string('user'),
		rt.new_string('woocommerce_coming_soon_banner_dismissed'),
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{
				key: 'description'
				val: 'Indicate whether the user has dismissed the coming soon notice or not.'
			}, rt.ArrayItem{ key: 'single', val: true }, rt.ArrayItem{
				key: 'show_in_rest'
				val: true
			}])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_LaunchYourStore) add_user_data_fields(var_user_data_fields rt.PhpVal) rt.PhpVal {
	return rt.call_function('array_merge', [var_user_data_fields.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'launch_your_store_tour_hidden' },
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Admin_Features_LaunchYourStore.banner_dismiss_user_meta_key()
			}])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_LaunchYourStore) reset_woocommerce_coming_soon_banner_dismissed(var_user_login rt.PhpVal, var_user rt.PhpVal) {
	mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser{}
	mut iife_result_4 := iife_temp_4.get_user_data_field(rt.get_property(var_user, 'ID'),
		Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Admin_Features_LaunchYourStore.banner_dismiss_user_meta_key())
	mut var_existing_meta := iife_result_4
	if rt.is_true(rt.identical(rt.new_string('yes'), var_existing_meta)) {
		mut iife_temp_5 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser{}
		mut iife_result_5 := iife_temp_5.update_user_data_field(rt.get_property(var_user, 'ID'),
			Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Admin_Features_LaunchYourStore.banner_dismiss_user_meta_key(),
			rt.new_string('no'))
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_LaunchYourStore) is_mailpoet_connected() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('\\MailPoet\\DI\\ContainerWrapper')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('\\MailPoet\\Settings\\SettingsController')]))))) {
		return false
	}
	mut iife_temp_6 := Class_Automattic_WooCommerce_Admin_Features_MailPoet_DI_ContainerWrapper{}
	mut iife_result_6 := iife_temp_6.getinstance(rt.get_constant('WP_DEBUG'))
	mut var_container := iife_result_6
	mut var_settings := rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Admin_Features_MailPoet_Settings_SettingsController.class(),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(rt.instance_of(var_settings,
		'Automattic_WooCommerce_Admin_Features_MailPoet_Settings_SettingsController'))))
	{
		return false
	}
	mut var_mta := rt.call_method(var_settings, 'get', [rt.new_string('mta')])
	mut var_api_state := if !(var_mta.array_get(rt.new_string('mailpoet_api_key_state'))).is_null() {
		var_mta.array_get(rt.new_string('mailpoet_api_key_state'))
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_api_state))))
		|| (!(var_api_state.array_isset(rt.new_string('state'))
		&& var_api_state.array_isset(rt.new_string('code')))) {
		return false
	}
	return
		rt.is_true(rt.identical(rt.new_string('valid'), var_api_state.array_get(rt.new_string('state'))))
		&& rt.is_true(rt.identical(rt.new_int(200), var_api_state.array_get(rt.new_string('code'))))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_LaunchYourStore) maybe_track_template_change(var_post_id rt.PhpVal, var_post rt.PhpVal, var_update rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post, 'Automattic_WooCommerce_Admin_Features_WP_Post'))))))
		|| (!(!(rt.get_property(var_post, 'post_name')).is_null()
		&& !(rt.get_property(var_post, 'post_title')).is_null())) {
		return
	}
	if rt.is_true(rt.identical(rt.new_string('coming-soon'), rt.get_property(var_post, 'post_name')))
		&& rt.is_true(rt.identical(rt.new_string('Page: Coming soon'), rt.get_property(var_post, 'post_title'))) {
		mut var_matches := rt.new_array()
		mut var_content := rt.get_property(var_post, 'post_content')
		rt.call_function('preg_match', [
			rt.new_string('/"comingSoonPatternId":"([^"]+)"/'),
			var_content.clone(),
			var_matches.clone(),
		])
		if var_matches.array_isset(rt.new_int(1)) {
			rt.call_function('wc_admin_record_tracks_event', [
				rt.new_string('coming_soon_template_saved'),
				rt.create_array([
					rt.ArrayItem{ key: 'pattern_id', val: var_matches.array_get(rt.new_int(1)) },
					rt.ArrayItem{ key: 'is_update', val: var_update },
				]),
			])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_LaunchYourStore) load_newsletter_scripts() {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_screen,
		'Automattic_WooCommerce_Admin_Features_WP_Screen'))))))
	{
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('site-editor'), rt.get_property(var_screen,
		'id')))))
	{
		return
	}
	mut iife_temp_7 := Class_Automattic_WooCommerce_Admin_PluginsHelper{}
	mut iife_result_7 := iife_temp_7.is_plugin_installed(rt.new_string('mailpoet'))
	mut var_mailpoet := rt.create_array([
		rt.ArrayItem{ key: 'mailpoet_installed', val: iife_result_7 },
		rt.ArrayItem{ key: 'mailpoet_connected', val: this.is_mailpoet_connected() },
	])
	rt.call_function('wp_register_script', [
		rt.new_string('coming-soon-newsletter-mailpoet'),
		rt.new_string(''),
	])
	rt.call_function('wp_enqueue_script', [
		rt.new_string('coming-soon-newsletter-mailpoet'),
	])
	rt.call_function('wp_add_inline_script', [
		rt.new_string('coming-soon-newsletter-mailpoet'),
		rt.new_string('var comingSoonNewsletter = ' +
			(rt.call_function('wp_json_encode', [var_mailpoet.clone(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])).str() +
			';'),
	])
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_WCAdminHelper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_MailPoet_DI_ContainerWrapper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PluginsHelper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_launchyourstore() &Class_Automattic_WooCommerce_Admin_Features_LaunchYourStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_LaunchYourStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcadminuser(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_wcadminhelper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_WCAdminHelper {
	mut obj := &Class_Automattic_WooCommerce_Admin_WCAdminHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_mailpoet_di_containerwrapper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_MailPoet_DI_ContainerWrapper {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_MailPoet_DI_ContainerWrapper{
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

fn (mut this Class_Automattic_WooCommerce_Admin_Features_LaunchYourStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'save_site_visibility_options' {
			this.save_site_visibility_options()
			return rt.new_null()
		}
		'append_coming_soon_global_tracks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.append_coming_soon_global_tracks(dispatch_arg_0)
		}
		'preload_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.preload_settings(dispatch_arg_0)
		}
		'is_manager_or_admin' {
			return rt.new_bool(this.is_manager_or_admin())
		}
		'maybe_add_coming_soon_banner_on_frontend' {
			return rt.new_bool(this.maybe_add_coming_soon_banner_on_frontend())
		}
		'register_launch_your_store_user_meta_fields' {
			this.register_launch_your_store_user_meta_fields()
			return rt.new_null()
		}
		'add_user_data_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_user_data_fields(dispatch_arg_0)
		}
		'reset_woocommerce_coming_soon_banner_dismissed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.reset_woocommerce_coming_soon_banner_dismissed(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'is_mailpoet_connected' {
			return rt.new_bool(this.is_mailpoet_connected())
		}
		'maybe_track_template_change' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.maybe_track_template_change(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'load_newsletter_scripts' {
			this.load_newsletter_scripts()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_LaunchYourStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_LaunchYourStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminUser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_WCAdminHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_WCAdminHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_WCAdminHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_MailPoet_DI_ContainerWrapper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_MailPoet_DI_ContainerWrapper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_MailPoet_DI_ContainerWrapper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
