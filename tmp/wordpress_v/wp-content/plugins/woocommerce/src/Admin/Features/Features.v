import rt

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
		optional_features rt.PhpVal = rt.new_array()
		beta_features rt.PhpVal = rt.new_array()
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) construct()  {
	this.register_internal_class_aliases()
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Admin_Features_Features.should_load_features())))) {
		return
	}
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'load_features' }]), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'maybe_load_beta_features_modal' }])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'load_scripts' }]), rt.new_int(15)])
	rt.call_function('add_filter', [rt.new_string('admin_body_class'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_admin_body_classes' }])])
	rt.call_function('add_filter', [rt.new_string('update_option_woocommerce_allow_tracking'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'maybe_disable_features' }]), rt.new_int(10), rt.new_int(2)])
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.get_features() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_features'), rt.new_array()])
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.get_optional_feature_options() rt.PhpVal {
	mut var_features := rt.new_array()
	{
		mut iter_1 := rt.func_array_keys(// unsupported expression: Expr_StaticPropertyFetch).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_optional_feature_key := item_1.val
			mut var_feature_class := Class_Automattic_WooCommerce_Admin_Features_Features.get_feature_class(var_optional_feature_key.dup())
			if rt.is_true(var_feature_class) {
				var_features.array_set(var_optional_feature_key, Class_Automattic_WooCommerce_Admin_Features_{"nodeType":"Expr_Variable","line":93,"name":"feature_class"}.toggle_option_name())
			}
		}
	}
	return var_features.dup()
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.exists(var_feature rt.PhpVal) rt.PhpVal {
	mut var_feature_mutated := var_feature
	mut var_features := Class_Automattic_WooCommerce_Admin_Features_Features.get_features()
	return rt.call_function('in_array', [var_feature_mutated.dup(), var_features.dup(), rt.new_bool(true)])
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.get_feature_class(var_feature rt.PhpVal) rt.PhpVal {
	mut var_feature_mutated := var_feature
	var_feature_mutated = rt.call_function('str_replace', [rt.new_string('-'), rt.new_string(''), rt.call_function('ucwords', [rt.new_string(var_feature_mutated.dup().to_string().to_lower()), rt.new_string('-')])])
	mut var_feature_class := rt.new_string('Automattic\\WooCommerce\\Admin\\Features\\' + (var_feature_mutated).str())
	mut var_should_autoload_class := Class_Automattic_WooCommerce_Admin_Features_Features.should_load_features()
	if rt.is_true(rt.call_function('class_exists', [var_feature_class.dup(), var_should_autoload_class.dup()])) {
		return var_feature_class.dup()
	}
	if rt.is_true(rt.call_function('class_exists', [(var_feature_class).str() + '\\Init', var_should_autoload_class.dup()])) {
		return rt.new_string((var_feature_class).str() + '\\Init')
	}
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.load_features()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Admin_Features_Features.should_load_features())))) {
		return rt.new_null()
	}
	mut var_features := Class_Automattic_WooCommerce_Admin_Features_Features.get_features()
	{
		mut iter_1 := var_features.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_feature := item_1.val
			mut var_feature_class := Class_Automattic_WooCommerce_Admin_Features_Features.get_feature_class(var_feature.dup())
			if rt.is_true(var_feature_class) {
				rt.create_object_dynamically(var_feature_class, []rt.PhpVal{})
			}
		}
	}
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('blueprint'))) {
		create_automattic_woocommerce_admin_features_automattic_woocommerce_admin_features_blueprint_init()
	}
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.get_available_features() rt.PhpVal {
	mut var_features := Class_Automattic_WooCommerce_Admin_Features_Features.get_features()
	mut var_optional_feature_keys := rt.func_array_keys(// unsupported expression: Expr_StaticPropertyFetch)
	mut var_optional_features_unavailable := rt.new_array()
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_disabled'), rt.new_bool(false)])) {
		return rt.call_function('array_values', [rt.call_function('array_diff', [var_features.dup(), var_optional_feature_keys.dup()])])
	}
	{
		mut iter_1 := var_optional_feature_keys.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_optional_feature_key := item_1.val
			mut var_feature_class := Class_Automattic_WooCommerce_Admin_Features_Features.get_feature_class(var_optional_feature_key.dup())
			if rt.is_true(var_feature_class) {
				mut var_default := if // unsupported expression: Expr_StaticPropertyFetch.array_get(var_optional_feature_key).array_isset(rt.new_string('default')) { // unsupported expression: Expr_StaticPropertyFetch.array_get(var_optional_feature_key).array_get('default') } else { rt.new_string('no') }
				mut var_feature_option := Class_Automattic_WooCommerce_Admin_Features_{"nodeType":"Expr_Variable","line":185,"name":"feature_class"}.toggle_option_name()
				if rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_isset(var_feature_option) && rt.is_true(rt.identical(rt.new_string('1'), rt.get_superglobal('_POST').array_get(var_feature_option))))) {
					continue
				}
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					var_optional_features_unavailable.array_push(var_optional_feature_key.dup())
				}
			}
		}
	}
	return rt.call_function('array_values', [rt.call_function('array_diff', [var_features.dup(), var_optional_features_unavailable.dup()])])
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.is_enabled(var_feature rt.PhpVal) rt.PhpVal {
	mut var_feature_mutated := var_feature
	mut var_available_features := Class_Automattic_WooCommerce_Admin_Features_Features.get_available_features()
	return rt.call_function('in_array', [var_feature_mutated.dup(), var_available_features.dup(), rt.new_bool(true)])
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.enable(var_feature rt.PhpVal) bool {
	mut var_feature_mutated := var_feature
	mut var_features := Class_Automattic_WooCommerce_Admin_Features_Features.get_optional_feature_options()
	if var_features.array_isset(var_feature_mutated) {
		rt.call_function('update_option', [var_features.array_get(var_feature_mutated), rt.new_string('yes')])
		return true
	}
	return false
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.disable(var_feature rt.PhpVal) bool {
	mut var_feature_mutated := var_feature
	mut var_features := Class_Automattic_WooCommerce_Admin_Features_Features.get_optional_feature_options()
	if var_features.array_isset(var_feature_mutated) {
		rt.call_function('update_option', [var_features.array_get(var_feature_mutated), rt.new_string('no')])
		return true
	}
	return false
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.maybe_disable_features(var_old_value rt.PhpVal, var_value rt.PhpVal)  {
	if rt.is_true(rt.identical(rt.new_string('yes'), var_value)) {
		return rt.new_null()
	}
	{
		mut iter_1 := // unsupported expression: Expr_StaticPropertyFetch.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_feature := item_1.val
			Class_Automattic_WooCommerce_Admin_Features_Features.disable(var_feature.dup())
		}
	}
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.add_features_section(var_sections rt.PhpVal) rt.PhpVal {
	return var_sections.dup()
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.add_features_settings(var_settings rt.PhpVal, var_current_section rt.PhpVal) rt.PhpVal {
	return var_settings.dup()
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.maybe_load_beta_features_modal(var_hook rt.PhpVal)  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || !(rt.get_superglobal('_GET').array_isset(rt.new_string('tab'))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) || !(rt.get_superglobal('_GET').array_isset(rt.new_string('section'))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	mut var_tracking_enabled := rt.call_function('get_option', [rt.new_string('woocommerce_allow_tracking'), rt.new_string('no')])
	if !rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_string('yes'), var_tracking_enabled)) {
		return rt.new_null()
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}; return temp.register_style(arg_0, arg_1, arg_2) }(rt.new_string('beta-features-tracking-modal'), rt.new_string('style'), rt.create_array([rt.ArrayItem{ key: none, val: 'wp-components' }]))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}; return temp.register_script(arg_0, arg_1, arg_2) }(rt.new_string('wp-admin-scripts'), rt.new_string('beta-features-tracking-modal'), rt.create_array([rt.ArrayItem{ key: none, val: 'wp-i18n' }, rt.ArrayItem{ key: none, val: 'wp-element' }, rt.ArrayItem{ key: none, val: rt.get_constant('WC_ADMIN_APP') }]))
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.load_scripts()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_admin_or_embed_page() }())))) {
		return rt.new_null()
	}
	mut var_features := Class_Automattic_WooCommerce_Admin_Features_Features.get_features()
	mut var_enabled_features := rt.new_array()
	{
		mut iter_1 := var_features.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			var_enabled_features.array_set(var_key, Class_Automattic_WooCommerce_Admin_Features_Features.is_enabled(var_key.dup()))
		}
	}
	rt.call_function('wp_add_inline_script', [rt.get_constant('WC_ADMIN_APP'), 'window.wcAdminFeatures = ' + (rt.call_function('wp_json_encode', [var_enabled_features.dup(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])).str(), rt.new_string('before')])
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.add_admin_body_classes(admin_body_class string) string {
	mut admin_body_class_mutated := admin_body_class
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_admin_or_embed_page() }())))) {
		return admin_body_class_mutated
	}
	mut var_classes := rt.call_function('explode', [rt.new_string(' '), rt.new_string(admin_body_class_mutated.trim_space())])
	mut var_features := Class_Automattic_WooCommerce_Admin_Features_Features.get_features()
	{
		mut iter_1 := var_features.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_feature_key := item_1.val
			var_classes.array_push(rt.call_function('sanitize_html_class', ['woocommerce-feature-enabled-' + (var_feature_key).str()]))
		}
	}
	admin_body_class_mutated = (rt.call_function('implode', [rt.new_string(' '), rt.call_function('array_unique', [var_classes.dup()])])).str()
	return " ${var_admin_body_class.to_string()} "
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) register_internal_class_aliases()  {
	mut var_aliases := rt.create_array([rt.ArrayItem{ key: 'Automattic\\WooCommerce\\Internal\\Admin\\WCPayPromotion\\Init', val: 'Automattic\\WooCommerce\\Admin\\Features\\WcPayPromotion\\Init' }, rt.ArrayItem{ key: 'Automattic\\WooCommerce\\Internal\\Admin\\RemoteFreeExtensions\\Init', val: 'Automattic\\WooCommerce\\Admin\\Features\\RemoteFreeExtensions\\Init' }, rt.ArrayItem{ key: 'Automattic\\WooCommerce\\Internal\\Admin\\ActivityPanels', val: 'Automattic\\WooCommerce\\Admin\\Features\\ActivityPanels' }, rt.ArrayItem{ key: 'Automattic\\WooCommerce\\Internal\\Admin\\Analytics', val: 'Automattic\\WooCommerce\\Admin\\Features\\Analytics' }, rt.ArrayItem{ key: 'Automattic\\WooCommerce\\Internal\\Admin\\Coupons', val: 'Automattic\\WooCommerce\\Admin\\Features\\Coupons' }, rt.ArrayItem{ key: 'Automattic\\WooCommerce\\Internal\\Admin\\CouponsMovedTrait', val: 'Automattic\\WooCommerce\\Admin\\Features\\CouponsMovedTrait' }, rt.ArrayItem{ key: 'Automattic\\WooCommerce\\Internal\\Admin\\CustomerEffortScoreTracks', val: 'Automattic\\WooCommerce\\Admin\\Features\\CustomerEffortScoreTracks' }, rt.ArrayItem{ key: 'Automattic\\WooCommerce\\Internal\\Admin\\Homescreen', val: 'Automattic\\WooCommerce\\Admin\\Features\\Homescreen' }, rt.ArrayItem{ key: 'Automattic\\WooCommerce\\Internal\\Admin\\Marketing', val: 'Automattic\\WooCommerce\\Admin\\Features\\Marketing' }, rt.ArrayItem{ key: 'Automattic\\WooCommerce\\Internal\\Admin\\MobileAppBanner', val: 'Automattic\\WooCommerce\\Admin\\Features\\MobileAppBanner' }, rt.ArrayItem{ key: 'Automattic\\WooCommerce\\Internal\\Admin\\RemoteInboxNotifications', val: 'Automattic\\WooCommerce\\Admin\\Features\\RemoteInboxNotifications' }, rt.ArrayItem{ key: 'Automattic\\WooCommerce\\Internal\\Admin\\ShippingLabelBanner', val: 'Automattic\\WooCommerce\\Admin\\Features\\ShippingLabelBanner' }, rt.ArrayItem{ key: 'Automattic\\WooCommerce\\Internal\\Admin\\ShippingLabelBannerDisplayRules', val: 'Automattic\\WooCommerce\\Admin\\Features\\ShippingLabelBannerDisplayRules' }, rt.ArrayItem{ key: 'Automattic\\WooCommerce\\Internal\\Admin\\WcPayWelcomePage', val: 'Automattic\\WooCommerce\\Admin\\Features\\WcPayWelcomePage' }])
	{
		mut iter_1 := var_aliases.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_orig_class := item_1.val
			mut var_new_class := item_1.key
			rt.call_function('class_alias', [var_new_class.dup(), var_orig_class.dup()])
		}
	}
}

fn Class_Automattic_WooCommerce_Admin_Features_Features.should_load_features() rt.PhpVal {
	mut var_should_load := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) || rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})))) || rt.is_true(rt.call_function('wp_doing_cron', []rt.PhpVal{})))) || rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WP_CLI')])) && rt.is_true(rt.get_constant('WP_CLI')))))) || rt.is_true(rt.new_bool(rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_rest_api_request', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_store_api_request', []rt.PhpVal{}))))))))) || rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_should_load_features'), var_should_load.dup()])
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
		instance: rt.new_null()
		optional_features: rt.new_array()
		beta_features: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil() &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_automattic_woocommerce_admin_features_blueprint_init() &Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Admin_Features_Blueprint_Init {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Admin_Features_Blueprint_Init{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcadminassets() &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pagecontroller() &Class_Automattic_WooCommerce_Admin_PageController {
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
			Class_Automattic_WooCommerce_Admin_Features_Features.maybe_disable_features(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_features_section' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_Features.add_features_section(dispatch_arg_0)
		}
		'add_features_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_Features.add_features_settings(dispatch_arg_0, dispatch_arg_1)
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
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		'optional_features' { return this.optional_features }
		'beta_features' { return this.beta_features }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		'optional_features' { this.optional_features = val; return true }
		'beta_features' { this.beta_features = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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
	rt.register_class_factory('Automattic_WooCommerce_Admin_Features_Features', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_features_features()
		return rt.new_object('Automattic_WooCommerce_Admin_Features_Features', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_FeaturesUtil', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_featuresutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_FeaturesUtil', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Admin_Features_Blueprint_Init', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_features_automattic_woocommerce_admin_features_blueprint_init()
		return rt.new_object('Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Admin_Features_Blueprint_Init', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_Admin_WCAdminAssets', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_admin_wcadminassets()
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_WCAdminAssets', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_PageController', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_pagecontroller()
		return rt.new_object('Automattic_WooCommerce_Admin_PageController', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_admin_features_features_php() {
}
