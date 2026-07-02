import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_InterfaceImplementations {
	rt.PhpObjectBase
pub mut:
	objects    rt.PhpVal = rt.new_null()
	interfaces rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_InterfaceImplementations) construct(mut var_objects Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array, mut var_interfaces Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) {
	this.objects = var_objects
	this.interfaces = var_interfaces
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_InterfaceImplementations) objects() rt.PhpVal {
	return this.objects
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_InterfaceImplementations) interfaces() rt.PhpVal {
	return this.interfaces
}

fn create_automattic_woocommerce_vendor_graphql_utils_interfaceimplementations(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_InterfaceImplementations {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_InterfaceImplementations{
		PhpObjectBase: rt.PhpObjectBase{}
		objects:       rt.new_null()
		interfaces:    rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_InterfaceImplementations) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'objects' {
			return this.objects()
		}
		'interfaces' {
			return this.interfaces()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_InterfaceImplementations) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'objects' { return this.objects }
		'interfaces' { return this.interfaces }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_InterfaceImplementations) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'objects' {
			this.objects = val
			return true
		}
		'interfaces' {
			this.interfaces = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
