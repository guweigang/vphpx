import rt

struct Class_Automattic_WooCommerce_Blocks_Registry_FactoryType {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Registry_FactoryType) get(mut var_container Class_Automattic_WooCommerce_Blocks_Registry_Container) rt.PhpVal {
	return this.resolve_value(rt.new_object('Automattic_WooCommerce_Blocks_Registry_Container',
		[]string{}, var_container))
}

struct Class_Automattic_WooCommerce_Blocks_Registry_AbstractDependencyType {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_registry_factorytype() &Class_Automattic_WooCommerce_Blocks_Registry_FactoryType {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Registry_FactoryType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_registry_abstractdependencytype() &Class_Automattic_WooCommerce_Blocks_Registry_AbstractDependencyType {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Registry_AbstractDependencyType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Registry_FactoryType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Registry_Container](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Registry_FactoryType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Registry_FactoryType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Registry_AbstractDependencyType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Registry_AbstractDependencyType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Registry_AbstractDependencyType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_registry_factorytype_php() {
}
