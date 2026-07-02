import rt

struct Class_Automattic_WooCommerce_Blocks_Registry_SharedType {
	rt.PhpObjectBase
pub mut:
	shared_instance rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Registry_SharedType) get(mut var_container Class_Automattic_WooCommerce_Blocks_Registry_Container) rt.PhpVal {
	if !rt.is_true(this.shared_instance) {
		this.shared_instance = this.resolve_value(rt.new_object('Automattic_WooCommerce_Blocks_Registry_Container',
			[]string{}, var_container))
	}
	return this.shared_instance
}

struct Class_Automattic_WooCommerce_Blocks_Registry_AbstractDependencyType {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_registry_sharedtype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Registry_SharedType {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Registry_SharedType{
		PhpObjectBase:   rt.PhpObjectBase{}
		shared_instance: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_blocks_registry_abstractdependencytype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Registry_AbstractDependencyType {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Registry_AbstractDependencyType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Registry_SharedType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_Automattic_WooCommerce_Blocks_Registry_SharedType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'shared_instance' { return this.shared_instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Registry_SharedType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'shared_instance' {
			this.shared_instance = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
