import rt

pub fn Class_WC_SmoothGenerator_Router.generators() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'coupons', val: Class_WC_SmoothGenerator_Generator_Coupon.class() }, rt.ArrayItem{ key: 'customers', val: Class_WC_SmoothGenerator_Generator_Customer.class() }, rt.ArrayItem{ key: 'orders', val: Class_WC_SmoothGenerator_Generator_Order.class() }, rt.ArrayItem{ key: 'products', val: Class_WC_SmoothGenerator_Generator_Product.class() }, rt.ArrayItem{ key: 'terms', val: Class_WC_SmoothGenerator_Generator_Term.class() }])
}
struct Class_WC_SmoothGenerator_Router {
	rt.PhpObjectBase
}

fn Class_WC_SmoothGenerator_Router.get_generator_class(generator_slug string) rt.PhpVal {
	if !(Class_WC_SmoothGenerator_WC_SmoothGenerator_Router.generators().array_isset(rt.new_string(generator_slug))) {
		return rt.new_object('WC_SmoothGenerator_WP_Error', []string{}, create_wc_smoothgenerator_wp_error(rt.new_string('smoothgenerator_invalid_generator'), rt.call_function('sprintf', [rt.new_string('A generator class for "%s" can\'t be found.'), rt.new_string(generator_slug)])))
	}
	return Class_WC_SmoothGenerator_WC_SmoothGenerator_Router.generators().array_get(rt.new_string(generator_slug))
}

fn Class_WC_SmoothGenerator_Router.generate_batch(generator_slug string, amount i64, mut var_args Class_WC_SmoothGenerator_array) rt.PhpVal {
	mut var_generator := Class_WC_SmoothGenerator_Router.get_generator_class(generator_slug)
	if rt.is_true(rt.call_function('is_wp_error', [var_generator.clone()])) {
		return var_generator.clone()
	}
	mut iife_temp_0 := Class_WC_SmoothGenerator_{"nodeType":"Expr_Variable","line":57,"name":"generator"}{}
	mut iife_result_0 := iife_temp_0.batch(rt.new_int(amount), rt.new_object('WC_SmoothGenerator_array', []string{}, var_args))
	return iife_result_0
}

struct Class_WC_SmoothGenerator_WP_Error {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_{"nodeType":"Expr_Variable","line":57,"name":"generator"} {
	rt.PhpObjectBase
}

fn create_wc_smoothgenerator_router(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Router {
	mut obj := &Class_WC_SmoothGenerator_Router{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_wp_error(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_WP_Error {
	mut obj := &Class_WC_SmoothGenerator_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_{"nodetype":"expr_variable","line":57,"name":"generator"}(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_{"nodeType":"Expr_Variable","line":57,"name":"generator"} {
	mut obj := &Class_WC_SmoothGenerator_{"nodeType":"Expr_Variable","line":57,"name":"generator"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_SmoothGenerator_Router) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_generator_class' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WC_SmoothGenerator_Router.get_generator_class(dispatch_arg_0)
		}
		'generate_batch' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WC_SmoothGenerator_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return Class_WC_SmoothGenerator_Router.generate_batch(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_WC_SmoothGenerator_Router) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Router) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_SmoothGenerator_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_SmoothGenerator_{"nodeType":"Expr_Variable","line":57,"name":"generator"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_{"nodeType":"Expr_Variable","line":57,"name":"generator"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_{"nodeType":"Expr_Variable","line":57,"name":"generator"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
