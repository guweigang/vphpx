import rt

struct Class_Automattic_WooCommerce_Internal_DependencyManagement_ContainerException {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_DependencyManagement_ContainerException) construct(var_message rt.PhpVal, code i64, mut var_previous Class_Automattic_WooCommerce_Internal_DependencyManagement_?Exception) {
	this.Class_Automattic_WooCommerce_Internal_DependencyManagement_Exception.construct(var_message.clone(), rt.new_int(code), rt.new_object('Automattic_WooCommerce_Internal_DependencyManagement_?Exception', []string{}, var_previous))
}

struct Class_Automattic_WooCommerce_Internal_DependencyManagement_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_dependencymanagement_containerexception(arg_0 rt.PhpVal, code i64, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DependencyManagement_ContainerException {
	mut obj := &Class_Automattic_WooCommerce_Internal_DependencyManagement_ContainerException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(arg_0, code, arg_2)
	return obj
}

fn create_automattic_woocommerce_internal_dependencymanagement_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DependencyManagement_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_DependencyManagement_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_DependencyManagement_ContainerException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_DependencyManagement_?Exception](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_DependencyManagement_ContainerException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DependencyManagement_ContainerException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_DependencyManagement_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DependencyManagement_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DependencyManagement_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
