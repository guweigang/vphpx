import rt

struct Class_Automattic_WooCommerce_Blocks_Package {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Blocks_Package.get_package() rt.PhpVal {
	return rt.call_method(Class_Automattic_WooCommerce_Blocks_Package.container(), 'get', [
		Class_Automattic_WooCommerce_Blocks_Domain_Package.class(),
	])
}

fn Class_Automattic_WooCommerce_Blocks_Package.init() {
	rt.call_method(Class_Automattic_WooCommerce_Blocks_Package.container(), 'get', [
		Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap.class(),
	])
}

fn Class_Automattic_WooCommerce_Blocks_Package.get_version() rt.PhpVal {
	return rt.call_method(Class_Automattic_WooCommerce_Blocks_Package.get_package(), 'get_version',
		[]rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Blocks_Package.get_path() rt.PhpVal {
	return rt.call_method(Class_Automattic_WooCommerce_Blocks_Package.get_package(), 'get_path',
		[]rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Blocks_Package.feature() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('Package::feature'),
		rt.new_string('9.6'), rt.new_string('wp_get_environment_type')])
	return rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_FeatureGating', []string{},
		create_automattic_woocommerce_blocks_domain_services_featuregating())
}

fn Class_Automattic_WooCommerce_Blocks_Package.container(reset bool) rt.PhpVal {
	mut var_container := rt.new_null()
	if !(true) || var_reset {
		var_container = create_automattic_woocommerce_blocks_registry_container()
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_version := rt.new_string('11.8.0-dev')
			return rt.new_object('Automattic_WooCommerce_Blocks_Domain_Package', []string{}, create_automattic_woocommerce_blocks_domain_package(var_version.clone(), rt.call_function('dirname', [
				rt.new_string(@DIR),
				rt.new_int(2),
			])))
		}
		var_container.register(Class_Automattic_WooCommerce_Blocks_Domain_Package.class(),
			rt.new_closure(closure_1_fn))
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_object('Automattic_WooCommerce_Blocks_Domain_Bootstrap', []string{},
				create_automattic_woocommerce_blocks_domain_bootstrap(var_container))
		}
		var_container.register(Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap.class(),
			rt.new_closure(closure_2_fn))
	}
	return mut var_container
}

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_FeatureGating {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Registry_Container {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Domain_Package {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_package(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Package {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Package{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_domain_services_featuregating(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_FeatureGating {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_FeatureGating{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_registry_container(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Registry_Container {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Registry_Container{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_domain_package(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Package {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Package{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_domain_bootstrap(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_package' {
			return Class_Automattic_WooCommerce_Blocks_Package.get_package()
		}
		'init' {
			Class_Automattic_WooCommerce_Blocks_Package.init()
			return rt.new_null()
		}
		'get_version' {
			return Class_Automattic_WooCommerce_Blocks_Package.get_version()
		}
		'get_path' {
			return Class_Automattic_WooCommerce_Blocks_Package.get_path()
		}
		'feature' {
			return Class_Automattic_WooCommerce_Blocks_Package.feature()
		}
		'container' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_Blocks_Package.container(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_FeatureGating) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_FeatureGating) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_FeatureGating) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Registry_Container) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Registry_Container) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Registry_Container) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Bootstrap) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
