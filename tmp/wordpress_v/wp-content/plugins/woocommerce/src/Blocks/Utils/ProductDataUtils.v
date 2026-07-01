import rt

struct Class_Automattic_WooCommerce_Blocks_Utils_ProductDataUtils {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Blocks_Utils_ProductDataUtils.get_product_data(mut var_product Class_Automattic_WooCommerce_Blocks_Utils_WC_Product) rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'price_html', val: var_product.get_price_html() },
	])
}

fn create_automattic_woocommerce_blocks_utils_productdatautils() &Class_Automattic_WooCommerce_Blocks_Utils_ProductDataUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_ProductDataUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_ProductDataUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_product_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Utils_WC_Product](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_Automattic_WooCommerce_Blocks_Utils_ProductDataUtils.get_product_data(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_ProductDataUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_ProductDataUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_utils_productdatautils_php() {
	// unsupported statement: Stmt_Declare
}
