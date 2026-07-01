import rt

struct Class_Automattic_WooCommerce_Blocks_Registry_AbstractDependencyType {
	rt.PhpObjectBase
pub mut:
	callable_or_value rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Registry_AbstractDependencyType) construct(var_callable_or_value rt.PhpVal) {
	this.callable_or_value = var_callable_or_value.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Registry_AbstractDependencyType) resolve_value(mut var_container Class_Automattic_WooCommerce_Blocks_Registry_Container) rt.PhpVal {
	mut var_callback := this.callable_or_value
	return if rt.is_true(rt.call_function('is_callable', [var_callback.dup()])) { rt.call_callable(var_callback, [
			var_container,
		]) } else { var_callback }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Registry_AbstractDependencyType) get(mut var_container Class_Automattic_WooCommerce_Blocks_Registry_Container) {
}

fn create_automattic_woocommerce_blocks_registry_abstractdependencytype(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Registry_AbstractDependencyType {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Registry_AbstractDependencyType{
		PhpObjectBase:     rt.PhpObjectBase{}
		callable_or_value: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Registry_AbstractDependencyType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'resolve_value' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Registry_Container](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.resolve_value(mut dispatch_arg_0)
		}
		'get' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Registry_Container](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.get(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Registry_AbstractDependencyType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'callable_or_value' { return this.callable_or_value }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Registry_AbstractDependencyType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'callable_or_value' {
			this.callable_or_value = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn init_registry() {
}

fn init() {
	init_registry()
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_registry_abstractdependencytype_php() {
}
