import rt

struct Class_Automattic_WooCommerce_Api_InputTypes_Products_ProductFilterInput {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Api_InputTypes_Products_ProductFilterInput) construct(mut var_status Class_Automattic_WooCommerce_Api_InputTypes_Products_?ProductStatus, mut var_stock_status Class_Automattic_WooCommerce_Api_InputTypes_Products_?StockStatus, mut var_search Class_Automattic_WooCommerce_Api_InputTypes_Products_?string) {
}

fn create_automattic_woocommerce_api_inputtypes_products_productfilterinput(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_Api_InputTypes_Products_ProductFilterInput {
	mut obj := &Class_Automattic_WooCommerce_Api_InputTypes_Products_ProductFilterInput{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_InputTypes_Products_ProductFilterInput) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_InputTypes_Products_?ProductStatus](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_InputTypes_Products_?StockStatus](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_InputTypes_Products_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Api_InputTypes_Products_ProductFilterInput) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_InputTypes_Products_ProductFilterInput) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
