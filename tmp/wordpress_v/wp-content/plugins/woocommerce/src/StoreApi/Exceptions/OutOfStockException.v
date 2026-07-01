import rt

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_OutOfStockException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_StockAvailabilityException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_exceptions_outofstockexception() &Class_Automattic_WooCommerce_StoreApi_Exceptions_OutOfStockException {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Exceptions_OutOfStockException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_exceptions_stockavailabilityexception() &Class_Automattic_WooCommerce_StoreApi_Exceptions_StockAvailabilityException {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Exceptions_StockAvailabilityException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_OutOfStockException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Exceptions_OutOfStockException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_OutOfStockException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_StockAvailabilityException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Exceptions_StockAvailabilityException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_StockAvailabilityException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_storeapi_exceptions_outofstockexception_php() {
}
