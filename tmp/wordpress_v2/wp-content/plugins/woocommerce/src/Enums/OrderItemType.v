import rt

pub fn Class_Automattic_WooCommerce_Enums_OrderItemType.line_item() string {
	return 'line_item'
}

pub fn Class_Automattic_WooCommerce_Enums_OrderItemType.fee() string {
	return 'fee'
}

pub fn Class_Automattic_WooCommerce_Enums_OrderItemType.shipping() string {
	return 'shipping'
}

pub fn Class_Automattic_WooCommerce_Enums_OrderItemType.tax() string {
	return 'tax'
}

pub fn Class_Automattic_WooCommerce_Enums_OrderItemType.coupon() string {
	return 'coupon'
}

struct Class_Automattic_WooCommerce_Enums_OrderItemType {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_enums_orderitemtype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Enums_OrderItemType {
	mut obj := &Class_Automattic_WooCommerce_Enums_OrderItemType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Enums_OrderItemType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Enums_OrderItemType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Enums_OrderItemType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
