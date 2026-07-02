import rt

pub fn Class_Automattic_WooCommerce_Enums_ProductStockStatus.in_stock() string {
	return 'instock'
}

pub fn Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock() string {
	return 'outofstock'
}

pub fn Class_Automattic_WooCommerce_Enums_ProductStockStatus.on_backorder() string {
	return 'onbackorder'
}

pub fn Class_Automattic_WooCommerce_Enums_ProductStockStatus.low_stock() string {
	return 'lowstock'
}

struct Class_Automattic_WooCommerce_Enums_ProductStockStatus {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_enums_productstockstatus(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Enums_ProductStockStatus {
	mut obj := &Class_Automattic_WooCommerce_Enums_ProductStockStatus{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Enums_ProductStockStatus) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Enums_ProductStockStatus) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Enums_ProductStockStatus) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
