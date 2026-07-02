import rt

struct Class_Automattic_WooCommerce_EmailEditor_Container {
	rt.PhpObjectBase
pub mut:
	services  rt.PhpVal = rt.new_array()
	instances rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Container) magic_unserialize(mut var_data Class_Automattic_WooCommerce_EmailEditor_array) {
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditor_Exception', []string{},
		create_automattic_woocommerce_emaileditor_exception(rt.new_string('Deserialization of Container is not allowed for security reasons.'))))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Container) set(name string, mut var_callback Class_Automattic_WooCommerce_EmailEditor_callable) {
	this.services.array_set(name, var_callback)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Container) get(name string) rt.PhpVal {
	if this.instances.array_isset(rt.new_string(name)) {
		mut var_instance := this.instances.array_get(rt.new_string(name))
		return var_instance.clone()
	}
	if !(this.services.array_isset(rt.new_string(name))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditor_Exception',
			[]string{}, create_automattic_woocommerce_emaileditor_exception(rt.call_function('esc_html', [
			rt.new_string('Service not found: ${var_name}'),
		]))))
	}
	var_instance = rt.call_callable(this.services.array_get(rt.new_string(name)), [
		rt.new_object('Automattic_WooCommerce_EmailEditor_Container', []string{}, &this),
	])
	this.instances.array_set(name, var_instance.clone())
	return var_instance.clone()
}

struct Class_Automattic_WooCommerce_EmailEditor_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_container(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Container {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Container{
		PhpObjectBase: rt.PhpObjectBase{}
		services:      rt.new_array()
		instances:     rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Exception {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Container) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__unserialize' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.magic_unserialize(mut dispatch_arg_0)
			return rt.new_null()
		}
		'set' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_callable](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.set(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Container) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'services' { return this.services }
		'instances' { return this.instances }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Container) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'services' {
			this.services = val
			return true
		}
		'instances' {
			this.instances = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}
