import rt

struct Class_Automattic_WooCommerce_Admin_FeaturePlugin {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_featureplugin() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_FeaturePlugin', 'facade_over_classname',
		rt.new_string('Automattic\\WooCommerce\\Internal\\Admin\\FeaturePlugin'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_FeaturePlugin', 'deprecated_in_version',
		rt.new_string('6.4.0'))
}

fn (mut this Class_Automattic_WooCommerce_Admin_FeaturePlugin) construct() {
}

fn Class_Automattic_WooCommerce_Admin_FeaturePlugin.instance() rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_Admin_static', []string{},
		create_automattic_woocommerce_admin_static())
}

fn (mut this Class_Automattic_WooCommerce_Admin_FeaturePlugin) init() {
}

struct Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_static {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_featureplugin() &Class_Automattic_WooCommerce_Admin_FeaturePlugin {
	mut obj := &Class_Automattic_WooCommerce_Admin_FeaturePlugin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_deprecatedclassfacade(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade {
	mut obj := &Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_static(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_static {
	mut obj := &Class_Automattic_WooCommerce_Admin_static{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_FeaturePlugin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'instance' {
			return Class_Automattic_WooCommerce_Admin_FeaturePlugin.instance()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_FeaturePlugin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_FeaturePlugin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_static) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_static) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_static) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
