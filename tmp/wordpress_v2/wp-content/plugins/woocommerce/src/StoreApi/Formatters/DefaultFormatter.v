import rt

struct Class_Automattic_WooCommerce_StoreApi_Formatters_DefaultFormatter {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Formatters_DefaultFormatter) format(var_value rt.PhpVal, mut var_options Class_Automattic_WooCommerce_StoreApi_Formatters_array) rt.PhpVal {
	return var_value.clone()
}

fn create_automattic_woocommerce_storeapi_formatters_defaultformatter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Formatters_DefaultFormatter {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Formatters_DefaultFormatter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Formatters_DefaultFormatter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'format' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Formatters_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.format(dispatch_arg_0, mut dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Formatters_DefaultFormatter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Formatters_DefaultFormatter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
