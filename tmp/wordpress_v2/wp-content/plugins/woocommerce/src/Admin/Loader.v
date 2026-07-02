import rt

struct Class_Automattic_WooCommerce_Admin_Loader {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_loader() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Loader', 'facade_over_classname',
		rt.new_string('Automattic\\WooCommerce\\Internal\\Admin\\Loader'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_Loader', 'deprecated_in_version',
		rt.new_string('6.3.0'))
}

fn Class_Automattic_WooCommerce_Admin_Loader.is_feature_enabled(var_feature rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('is_feature_enabled'),
		rt.new_string('5.0'),
		rt.new_string('\\Automattic\\WooCommerce\\Internal\\Features\\Features::is_enabled()')])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_0 := iife_temp_0.is_enabled(var_feature.clone())
	return iife_result_0
}

fn Class_Automattic_WooCommerce_Admin_Loader.is_admin_or_embed_page() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('is_admin_or_embed_page'),
		rt.new_string('6.3'),
		rt.new_string('\\Automattic\\WooCommerce\\Admin\\PageController::is_admin_or_embed_page()')])
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_1 := iife_temp_1.is_admin_or_embed_page()
	return iife_result_1
}

fn Class_Automattic_WooCommerce_Admin_Loader.is_admin_page() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('is_admin_page'),
		rt.new_string('6.3'),
		rt.new_string('\\Automattic\\WooCommerce\\Admin\\PageController::is_admin_page()')])
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_2 := iife_temp_2.is_admin_page()
	return iife_result_2
}

fn Class_Automattic_WooCommerce_Admin_Loader.is_embed_page() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('is_embed_page'),
		rt.new_string('6.3'),
		rt.new_string('\\Automattic\\WooCommerce\\Admin\\PageController::is_embed_page()')])
	mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_3 := iife_temp_3.is_embed_page()
	return iife_result_3
}

fn Class_Automattic_WooCommerce_Admin_Loader.should_use_minified_js_file(var_script_debug rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WC_ABSPATH'),
	])))))
	{
		return rt.new_null()
	}
	mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
	mut iife_result_4 := iife_temp_4.should_use_minified_js_file(var_script_debug.clone())
	return iife_result_4
}

struct Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PageController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_loader(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Loader {
	mut obj := &Class_Automattic_WooCommerce_Admin_Loader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_deprecatedclassfacade(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade {
	mut obj := &Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
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

fn create_automattic_woocommerce_internal_admin_wcadminassets(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Loader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_feature_enabled' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Loader.is_feature_enabled(dispatch_arg_0)
		}
		'is_admin_or_embed_page' {
			return Class_Automattic_WooCommerce_Admin_Loader.is_admin_or_embed_page()
		}
		'is_admin_page' {
			return Class_Automattic_WooCommerce_Admin_Loader.is_admin_page()
		}
		'is_embed_page' {
			return Class_Automattic_WooCommerce_Admin_Loader.is_embed_page()
		}
		'should_use_minified_js_file' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Loader.should_use_minified_js_file(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Loader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Loader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PageController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
