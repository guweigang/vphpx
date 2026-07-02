import rt

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_features_features() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Features_Features', 'instance', rt.new_null())
	rt.init_static_prop('Automattic_WooCommerce_Admin_Features_Features', 'optional_features', rt.create_array([
		rt.ArrayItem{ key: 'analytics', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: 'yes' },
		]) },
		rt.ArrayItem{ key: 'remote-inbox-notifications', val: rt.create_array([
			rt.ArrayItem{ key: 'default', val: 'yes' },
		]) },
	]))
	rt.init_static_prop('Automattic_WooCommerce_Admin_Features_Features', 'beta_features', rt.create_array([
		rt.ArrayItem{ key: none, val: 'settings' },
	]))
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Admin_Features_Features',
		'instance')))))
	{
		rt.set_static_prop('Automattic_WooCommerce_Admin_Features_Features', 'instance', rt.new_object('Automattic_WooCommerce_Admin_Features_self',
			[]string{}, create_automattic_woocommerce_admin_features_self()))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Admin_Features_Features', 'instance')
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) construct() {
	this.register_internal_class_aliases()
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Admin_Features_Features.should_load_features())))) {
		return
	}
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'load_features' }]),
		rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'maybe_load_beta_features_modal' }])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'load_scripts' }]),
		rt.new_int(15)])
	rt.call_function('add_filter', [rt.new_string('admin_body_class'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'add_admin_body_classes' }])])
	rt.call_function('add_filter', [
		rt.new_string('update_option_woocommerce_allow_tracking'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'maybe_disable_features' }]),
		rt.new_int(10),
		rt.new_int(2),
	])
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.get_features() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_features'),
		rt.new_array(),
	])
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.get_optional_feature_options() rt.PhpVal {
	mut var_features := rt.new_array()
	mut iter_1 := rt.func_array_keys(rt.get_static_prop('Automattic_WooCommerce_Admin_Features_Features',
		'optional_features')).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_optional_feature_key := item_1.val
		mut var_feature_class :=
			Class_Automattic_WooCommerce_Admin_Features_Features.get_feature_class(var_optional_feature_key.clone())
		if rt.is_true(var_feature_class) {
			var_features.array_set(var_optional_feature_key, Class_Automattic_WooCommerce_Admin_Features_{
				nodeType: 'Expr_Variable'
				line:     93
				name:     'feature_class'
			}.toggle_option_name())
		}
	}
	return var_features.clone()
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.exists(var_feature rt.PhpVal) rt.PhpVal {
	mut var_feature_mutated := var_feature
	mut var_features := Class_Automattic_WooCommerce_Admin_Features_Features.get_features()
	return rt.call_function('in_array', [var_feature_mutated.clone(),
		var_features.clone(), rt.new_bool(true)])
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.get_feature_class(var_feature rt.PhpVal) rt.PhpVal {
	mut var_feature_mutated := var_feature
	var_feature_mutated = rt.call_function('str_replace', [rt.new_string('-'),
		rt.new_string(''),
		rt.call_function('ucwords', [
			rt.new_string(var_feature_mutated.clone().to_string().to_lower()),
			rt.new_string('-'),
		])])
	mut var_feature_class := rt.new_string('Automattic\\WooCommerce\\Admin\\Features\\' +
		var_feature_mutated.str())
	mut var_should_autoload_class :=
		Class_Automattic_WooCommerce_Admin_Features_Features.should_load_features()
	if rt.is_true(rt.call_function('class_exists', [var_feature_class.clone(),
		var_should_autoload_class.clone()]))
	{
		return var_feature_class.clone()
	}
	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string(var_feature_class.str() + '\\Init'),
		var_should_autoload_class.clone(),
	]))
	{
		return rt.new_string(var_feature_class.str() + '\\Init')
	}
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.load_features() {
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Admin_Features_Features.should_load_features())))) {
		return
	}
	mut var_features := Class_Automattic_WooCommerce_Admin_Features_Features.get_features()
	mut iter_2 := var_features.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_feature := item_2.val
		mut var_feature_class :=
			Class_Automattic_WooCommerce_Admin_Features_Features.get_feature_class(var_feature.clone())
		if rt.is_true(var_feature_class) {
			rt.create_object_dynamically(var_feature_class, []rt.PhpVal{})
		}
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_0 := iife_temp_0.feature_is_enabled(rt.new_string('blueprint'))
	if rt.is_true(iife_result_0) {
		create_automattic_woocommerce_admin_features_automattic_woocommerce_admin_features_blueprint_init()
	}
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.get_available_features() rt.PhpVal {
	mut var_features := Class_Automattic_WooCommerce_Admin_Features_Features.get_features()
	mut var_optional_feature_keys := rt.func_array_keys(rt.get_static_prop('Automattic_WooCommerce_Admin_Features_Features',
		'optional_features'))
	mut var_optional_features_unavailable := rt.new_array()
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_disabled'),
		rt.new_bool(false),
	]))
	{
		return rt.call_function('array_values', [
			rt.call_function('array_diff', [var_features.clone(),
				var_optional_feature_keys.clone()]),
		])
	}
	mut iter_3 := var_optional_feature_keys.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_optional_feature_key := item_3.val
		mut var_feature_class :=
			Class_Automattic_WooCommerce_Admin_Features_Features.get_feature_class(var_optional_feature_key.clone())
		if rt.is_true(var_feature_class) {
			mut var_default := if rt.get_static_prop('Automattic_WooCommerce_Admin_Features_Features',
				'optional_features').array_get(var_optional_feature_key).array_isset(rt.new_string('default'))
			{
				rt.get_static_prop('Automattic_WooCommerce_Admin_Features_Features',
					'optional_features').array_get(var_optional_feature_key).array_get(rt.new_string('default'))
			} else {
				rt.new_string('no')
			}
			mut var_feature_option := Class_Automattic_WooCommerce_Admin_Features_{
				nodeType: 'Expr_Variable'
				line:     185
				name:     'feature_class'
			}.toggle_option_name()
			if rt.get_superglobal('_POST').array_isset(var_feature_option)
				&& rt.is_true(rt.identical(rt.new_string('1'), rt.get_superglobal('_POST').array_get(var_feature_option))) {
				continue
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
				Class_Automattic_WooCommerce_Admin_Features_{
					nodeType: 'Expr_Variable'
					line:     190
					name:     'feature_class'
				}.toggle_option_name(),
				var_default.clone(),
			])))))
			{
				var_optional_features_unavailable.array_push(var_optional_feature_key.clone())
			}
		}
	}
	return rt.call_function('array_values', [
		rt.call_function('array_diff', [var_features.clone(),
			var_optional_features_unavailable.clone()]),
	])
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.is_enabled(var_feature rt.PhpVal) rt.PhpVal {
	mut var_feature_mutated := var_feature
	mut var_available_features :=
		Class_Automattic_WooCommerce_Admin_Features_Features.get_available_features()
	return rt.call_function('in_array', [var_feature_mutated.clone(),
		var_available_features.clone(), rt.new_bool(true)])
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.enable(var_feature rt.PhpVal) bool {
	mut var_feature_mutated := var_feature
	mut var_features :=
		Class_Automattic_WooCommerce_Admin_Features_Features.get_optional_feature_options()
	if var_features.array_isset(var_feature_mutated) {
		rt.call_function('update_option', [var_features.array_get(var_feature_mutated),
			rt.new_string('yes')])
		return true
	}
	return false
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.disable(var_feature rt.PhpVal) bool {
	mut var_feature_mutated := var_feature
	mut var_features :=
		Class_Automattic_WooCommerce_Admin_Features_Features.get_optional_feature_options()
	if var_features.array_isset(var_feature_mutated) {
		rt.call_function('update_option', [var_features.array_get(var_feature_mutated),
			rt.new_string('no')])
		return true
	}
	return false
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.maybe_disable_features(var_old_value rt.PhpVal, var_value rt.PhpVal) {
	if rt.is_true(rt.identical(rt.new_string('yes'), var_value)) {
		return
	}
	mut iter_4 := rt.get_static_prop('Automattic_WooCommerce_Admin_Features_Features',
		'beta_features').iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_feature := item_4.val
		Class_Automattic_WooCommerce_Admin_Features_Features.disable(var_feature.clone())
	}
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.add_features_section(var_sections rt.PhpVal) rt.PhpVal {
	return var_sections.clone()
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.add_features_settings(var_settings rt.PhpVal, var_current_section rt.PhpVal) rt.PhpVal {
	return var_settings.clone()
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.maybe_load_beta_features_modal(var_hook rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('woocommerce_page_wc-settings'), var_hook))))
		|| !(rt.get_superglobal('_GET').array_isset(rt.new_string('tab')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('advanced'), rt.get_superglobal('_GET').array_get(rt.new_string('tab'))))))
		|| !(rt.get_superglobal('_GET').array_isset(rt.new_string('section')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('features'), rt.get_superglobal('_GET').array_get(rt.new_string('section')))))) {
		return
	}
	mut var_tracking_enabled := rt.call_function('get_option', [
		rt.new_string('woocommerce_allow_tracking'),
		rt.new_string('no'),
	])
	if !rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Admin_Features_Features',
		'beta_features')) {
		return
	}
	if rt.is_true(rt.identical(rt.new_string('yes'), var_tracking_enabled)) {
		return
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
	mut iife_result_1 := iife_temp_1.register_style(rt.new_string('beta-features-tracking-modal'),
		rt.new_string('style'), rt.create_array([
		rt.ArrayItem{ key: none, val: 'wp-components' },
	]))
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
	mut iife_result_2 := iife_temp_2.register_script(rt.new_string('wp-admin-scripts'),
		rt.new_string('beta-features-tracking-modal'), rt.create_array([
		rt.ArrayItem{ key: none, val: 'wp-i18n' },
		rt.ArrayItem{ key: none, val: 'wp-element' },
		rt.ArrayItem{ key: none, val: rt.get_constant('WC_ADMIN_APP') },
	]))
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.load_scripts() {
	mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_3 := iife_temp_3.is_admin_or_embed_page()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_3)))) {
		return
	}
	mut var_features := Class_Automattic_WooCommerce_Admin_Features_Features.get_features()
	mut var_enabled_features := rt.new_array()
	mut iter_5 := var_features.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_key := item_5.val
		var_enabled_features.array_set(var_key,
			Class_Automattic_WooCommerce_Admin_Features_Features.is_enabled(var_key.clone()))
	}
	rt.call_function('wp_add_inline_script', [rt.get_constant('WC_ADMIN_APP'),
		rt.new_string('window.wcAdminFeatures = ' +(rt.call_function('wp_json_encode', [var_enabled_features.clone(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])).str()),
		rt.new_string('before')])
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.add_admin_body_classes(admin_body_class string) string {
	mut admin_body_class_mutated := admin_body_class
	mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_4 := iife_temp_4.is_admin_or_embed_page()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_4)))) {
		return admin_body_class_mutated
	}
	mut var_classes := rt.call_function('explode', [rt.new_string(' '),
		rt.new_string(admin_body_class_mutated.trim_space())])
	mut var_features := Class_Automattic_WooCommerce_Admin_Features_Features.get_features()
	mut iter_6 := var_features.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_feature_key := item_6.val
		var_classes.array_push(rt.call_function('sanitize_html_class', [
			rt.new_string('woocommerce-feature-enabled-' + var_feature_key.str()),
		]))
	}
	admin_body_class_mutated = (rt.call_function('implode', [
		rt.new_string(' '), rt.call_function('array_unique', [
			var_classes.clone()])])).str()
	return ' ${var_admin_body_class.to_string()} '
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) register_internal_class_aliases() {
	mut var_aliases := rt.create_array([
		rt.ArrayItem{
			key: 'Automattic\\WooCommerce\\Internal\\Admin\\WCPayPromotion\\Init'
			val: 'Automattic\\WooCommerce\\Admin\\Features\\WcPayPromotion\\Init'
		},
		rt.ArrayItem{
			key: 'Automattic\\WooCommerce\\Internal\\Admin\\RemoteFreeExtensions\\Init'
			val: 'Automattic\\WooCommerce\\Admin\\Features\\RemoteFreeExtensions\\Init'
		},
		rt.ArrayItem{
			key: 'Automattic\\WooCommerce\\Internal\\Admin\\ActivityPanels'
			val: 'Automattic\\WooCommerce\\Admin\\Features\\ActivityPanels'
		},
		rt.ArrayItem{
			key: 'Automattic\\WooCommerce\\Internal\\Admin\\Analytics'
			val: 'Automattic\\WooCommerce\\Admin\\Features\\Analytics'
		},
		rt.ArrayItem{
			key: 'Automattic\\WooCommerce\\Internal\\Admin\\Coupons'
			val: 'Automattic\\WooCommerce\\Admin\\Features\\Coupons'
		},
		rt.ArrayItem{
			key: 'Automattic\\WooCommerce\\Internal\\Admin\\CouponsMovedTrait'
			val: 'Automattic\\WooCommerce\\Admin\\Features\\CouponsMovedTrait'
		},
		rt.ArrayItem{
			key: 'Automattic\\WooCommerce\\Internal\\Admin\\CustomerEffortScoreTracks'
			val: 'Automattic\\WooCommerce\\Admin\\Features\\CustomerEffortScoreTracks'
		},
		rt.ArrayItem{
			key: 'Automattic\\WooCommerce\\Internal\\Admin\\Homescreen'
			val: 'Automattic\\WooCommerce\\Admin\\Features\\Homescreen'
		},
		rt.ArrayItem{
			key: 'Automattic\\WooCommerce\\Internal\\Admin\\Marketing'
			val: 'Automattic\\WooCommerce\\Admin\\Features\\Marketing'
		},
		rt.ArrayItem{
			key: 'Automattic\\WooCommerce\\Internal\\Admin\\MobileAppBanner'
			val: 'Automattic\\WooCommerce\\Admin\\Features\\MobileAppBanner'
		},
		rt.ArrayItem{
			key: 'Automattic\\WooCommerce\\Internal\\Admin\\RemoteInboxNotifications'
			val: 'Automattic\\WooCommerce\\Admin\\Features\\RemoteInboxNotifications'
		},
		rt.ArrayItem{
			key: 'Automattic\\WooCommerce\\Internal\\Admin\\ShippingLabelBanner'
			val: 'Automattic\\WooCommerce\\Admin\\Features\\ShippingLabelBanner'
		},
		rt.ArrayItem{
			key: 'Automattic\\WooCommerce\\Internal\\Admin\\ShippingLabelBannerDisplayRules'
			val: 'Automattic\\WooCommerce\\Admin\\Features\\ShippingLabelBannerDisplayRules'
		},
		rt.ArrayItem{
			key: 'Automattic\\WooCommerce\\Internal\\Admin\\WcPayWelcomePage'
			val: 'Automattic\\WooCommerce\\Admin\\Features\\WcPayWelcomePage'
		},
	])
	mut iter_7 := var_aliases.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_orig_class := item_7.val
		mut var_new_class := item_7.key
		rt.call_function('class_alias', [var_new_class.clone(),
			var_orig_class.clone()])
	}
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.should_load_features() rt.PhpVal {
	mut var_should_load := rt.new_bool((rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('wp_doing_cron', []rt.PhpVal{}))
		|| (rt.is_true(rt.call_function('defined', [rt.new_string('WP_CLI')]))
		&& rt.is_true(rt.get_constant('WP_CLI'))))|| (rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_rest_api_request', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_store_api_request', []rt.PhpVal{}))))))
		|| rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])))
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_should_load_features'),
		var_should_load.clone(),
	])
}

struct Class_Automattic_WooCommerce_Admin_Features_self {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Admin_Features_Blueprint_Init {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PageController {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_features() &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_features_self(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_self {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_automattic_woocommerce_admin_features_blueprint_init(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Admin_Features_Blueprint_Init {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Admin_Features_Blueprint_Init{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcadminassets(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pagecontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_PageController {
	mut obj := &Class_Automattic_WooCommerce_Admin_PageController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_Automattic_WooCommerce_Admin_Features_Features.get_instance()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_features' {
			return Class_Automattic_WooCommerce_Admin_Features_Features.get_features()
		}
		'get_optional_feature_options' {
			return Class_Automattic_WooCommerce_Admin_Features_Features.get_optional_feature_options()
		}
		'exists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_Features.exists(dispatch_arg_0)
		}
		'get_feature_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_Features.get_feature_class(dispatch_arg_0)
		}
		'load_features' {
			Class_Automattic_WooCommerce_Admin_Features_Features.load_features()
			return rt.new_null()
		}
		'get_available_features' {
			return Class_Automattic_WooCommerce_Admin_Features_Features.get_available_features()
		}
		'is_enabled' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_Features.is_enabled(dispatch_arg_0)
		}
		'enable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_Features.enable(dispatch_arg_0))
		}
		'disable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_Features.disable(dispatch_arg_0))
		}
		'maybe_disable_features' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_Features_Features.maybe_disable_features(dispatch_arg_0,
				dispatch_arg_1)
			return rt.new_null()
		}
		'add_features_section' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_Features.add_features_section(dispatch_arg_0)
		}
		'add_features_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_Features.add_features_settings(dispatch_arg_0,
				dispatch_arg_1)
		}
		'maybe_load_beta_features_modal' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_Features_Features.maybe_load_beta_features_modal(dispatch_arg_0)
			return rt.new_null()
		}
		'load_scripts' {
			Class_Automattic_WooCommerce_Admin_Features_Features.load_scripts()
			return rt.new_null()
		}
		'add_admin_body_classes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Admin_Features_Features.add_admin_body_classes(dispatch_arg_0))
		}
		'register_internal_class_aliases' {
			this.register_internal_class_aliases()
			return rt.new_null()
		}
		'should_load_features' {
			return Class_Automattic_WooCommerce_Admin_Features_Features.should_load_features()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Admin_Features_Blueprint_Init) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Admin_Features_Blueprint_Init) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Admin_Features_Blueprint_Init) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PageController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Admin_Features_Features', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_features_features()
		return rt.new_object('Automattic_WooCommerce_Admin_Features_Features', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Features_self', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_features_self()
		return rt.new_object('Automattic_WooCommerce_Admin_Features_self', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_FeaturesUtil', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_featuresutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_FeaturesUtil', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Admin_Features_Blueprint_Init', fn (args []rt.PhpVal) rt.PhpVal {
		obj :=
			create_automattic_woocommerce_admin_features_automattic_woocommerce_admin_features_blueprint_init()
		return rt.new_object('Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Admin_Features_Blueprint_Init',
			[]string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_Admin_WCAdminAssets', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_admin_wcadminassets()
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_WCAdminAssets', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_PageController', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_pagecontroller()
		return rt.new_object('Automattic_WooCommerce_Admin_PageController', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}
