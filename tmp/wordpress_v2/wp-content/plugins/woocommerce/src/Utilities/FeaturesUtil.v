import rt

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Utilities_FeaturesUtil.get_features(include_experimental bool, include_enabled_info bool) rt.PhpVal {
	return rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class(),
	]), 'get_features', [rt.new_bool(include_experimental), rt.new_bool(include_enabled_info)])
}

fn Class_Automattic_WooCommerce_Utilities_FeaturesUtil.feature_is_enabled(feature_id string) bool {
	mut var_features_controller := rt.call_method(rt.call_function('wc_get_container',
		[]rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class(),
	])
	mut var_feature := rt.call_method(var_features_controller, 'get_feature_definition', [
		rt.new_string(feature_id),
	])
	if !(!rt.is_true(var_feature.array_get(rt.new_string('deprecated_since')))) {
		Class_Automattic_WooCommerce_Utilities_FeaturesUtil.log_deprecated_feature_usage(feature_id,
			(var_feature.array_get(rt.new_string('deprecated_since'))).str())
	}
	return (rt.call_method(var_features_controller, 'feature_is_enabled', [
		rt.new_string(feature_id),
	])).to_bool()
}

fn Class_Automattic_WooCommerce_Utilities_FeaturesUtil.log_deprecated_feature_usage(feature_id string, deprecated_since string) {
	mut var_logged := rt.new_null()
	if var_logged.array_isset(rt.new_string(feature_id)) {
		return
	}
	var_logged.array_set(feature_id, true)
	rt.call_function('wc_deprecated_function', [
		rt.new_string("FeaturesUtil::feature_is_enabled('${var_feature_id}')"),
		rt.new_string(deprecated_since),
	])
}

fn Class_Automattic_WooCommerce_Utilities_FeaturesUtil.declare_compatibility(feature_id string, plugin_file string, positive_compatibility bool) bool {
	return (rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class(),
	]), 'declare_compatibility', [rt.new_string(feature_id), rt.new_string(plugin_file),
		rt.new_bool(positive_compatibility)])).to_bool()
}

fn Class_Automattic_WooCommerce_Utilities_FeaturesUtil.get_compatible_features_for_plugin(plugin_name string) rt.PhpVal {
	return rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class(),
	]), 'get_compatible_features_for_plugin', [rt.new_string(plugin_name)])
}

fn Class_Automattic_WooCommerce_Utilities_FeaturesUtil.get_compatible_plugins_for_feature(feature_id string) rt.PhpVal {
	return rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class(),
	]), 'get_compatible_plugins_for_feature', [rt.new_string(feature_id)])
}

fn Class_Automattic_WooCommerce_Utilities_FeaturesUtil.allow_enabling_features_with_incompatible_plugins() {
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class(),
	]), 'allow_enabling_features_with_incompatible_plugins', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Utilities_FeaturesUtil.allow_activating_plugins_with_incompatible_features() {
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class(),
	]), 'allow_activating_plugins_with_incompatible_features', []rt.PhpVal{})
}

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_features' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_Utilities_FeaturesUtil.get_features(dispatch_arg_0,
				dispatch_arg_1)
		}
		'feature_is_enabled' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Utilities_FeaturesUtil.feature_is_enabled(dispatch_arg_0))
		}
		'log_deprecated_feature_usage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			Class_Automattic_WooCommerce_Utilities_FeaturesUtil.log_deprecated_feature_usage(dispatch_arg_0,
				dispatch_arg_1)
			return rt.new_null()
		}
		'declare_compatibility' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(Class_Automattic_WooCommerce_Utilities_FeaturesUtil.declare_compatibility(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2))
		}
		'get_compatible_features_for_plugin' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Utilities_FeaturesUtil.get_compatible_features_for_plugin(dispatch_arg_0)
		}
		'get_compatible_plugins_for_feature' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Utilities_FeaturesUtil.get_compatible_plugins_for_feature(dispatch_arg_0)
		}
		'allow_enabling_features_with_incompatible_plugins' {
			Class_Automattic_WooCommerce_Utilities_FeaturesUtil.allow_enabling_features_with_incompatible_plugins()
			return rt.new_null()
		}
		'allow_activating_plugins_with_incompatible_features' {
			Class_Automattic_WooCommerce_Utilities_FeaturesUtil.allow_activating_plugins_with_incompatible_features()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
