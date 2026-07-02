import rt

struct Class_Automattic_WooCommerce_Internal_Api_GraphQLEndpointRegistrar {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_GraphQLEndpointRegistrar) construct(controller_class_name string, route_namespace string, route string, mut var_methods Class_Automattic_WooCommerce_Internal_Api_array) {
	mut var_methods_mutated := var_methods
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_GraphQLEndpointRegistrar) handle_rest_api_init() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Api_Main{}
	mut iife_result_0 := iife_temp_0.filter_methods_against_settings(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Api_GraphQLEndpointRegistrar',
		[]string{}, &this), 'methods'))
	mut var_methods := iife_result_0
	if !rt.is_true(var_methods) {
		return
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Api_Main{}
	mut iife_result_1 := iife_temp_1.instantiate_graphql_controller(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Api_GraphQLEndpointRegistrar',
		[]string{}, &this), 'controller_class_name'))
	mut var_controller := iife_result_1
	if rt.is_true(rt.identical(rt.new_null(), var_controller)) {
		return
	}
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Api_GraphQLEndpointRegistrar',
			[]string{}, &this), 'route_namespace'),
		rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Api_GraphQLEndpointRegistrar',
			[]string{}, &this), 'route'),
		rt.create_array([rt.ArrayItem{ key: 'methods', val: var_methods },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: var_controller },
				rt.ArrayItem{ key: none, val: 'handle_request' },
			]) }, rt.ArrayItem{ key: 'permission_callback', val: '__return_true' }]),
	])
}

struct Class_Automattic_WooCommerce_Internal_Api_Main {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_api_graphqlendpointregistrar(controller_class_name string, route_namespace string, route string, arg_3 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Api_GraphQLEndpointRegistrar {
	mut obj := &Class_Automattic_WooCommerce_Internal_Api_GraphQLEndpointRegistrar{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(controller_class_name, route_namespace, route, arg_3)
	return obj
}

fn create_automattic_woocommerce_internal_api_main(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Api_Main {
	mut obj := &Class_Automattic_WooCommerce_Internal_Api_Main{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_GraphQLEndpointRegistrar) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](if args.len > 3 {
				args[3]
			} else {
				rt.new_null()
			})
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3)
			return rt.new_null()
		}
		'handle_rest_api_init' {
			this.handle_rest_api_init()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Api_GraphQLEndpointRegistrar) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_GraphQLEndpointRegistrar) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Main) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Api_Main) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Main) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
