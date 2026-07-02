import rt

struct Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductLoader {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductLoader) get_products(mut var_args Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_array) rt.PhpVal {
	return rt.call_function('wc_get_products', [var_args])
}

fn create_automattic_woocommerce_internal_productfeed_feed_productloader(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductLoader {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductLoader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductLoader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_products' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_products(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductLoader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Feed_ProductLoader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
