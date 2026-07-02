import rt

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_FeatureGating {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_blocks_domain_services_featuregating() {
	rt.init_static_prop('Automattic_WooCommerce_Blocks_Domain_Services_FeatureGating',
		'deprecated_in_version', rt.new_string('9.6.0'))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_FeatureGating) construct(environment string) {
}

struct Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_domain_services_featuregating(environment string) &Class_Automattic_WooCommerce_Blocks_Domain_Services_FeatureGating {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_FeatureGating{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(environment)
	return obj
}

fn create_automattic_woocommerce_admin_deprecatedclassfacade(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade {
	mut obj := &Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_FeatureGating) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_FeatureGating) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_FeatureGating) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
