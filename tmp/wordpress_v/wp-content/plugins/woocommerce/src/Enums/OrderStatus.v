import rt

pub fn Class_Automattic_WooCommerce_Enums_OrderStatus.pending() string {
	return 'pending'
}

pub fn Class_Automattic_WooCommerce_Enums_OrderStatus.failed() string {
	return 'failed'
}

pub fn Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold() string {
	return 'on-hold'
}

pub fn Class_Automattic_WooCommerce_Enums_OrderStatus.completed() string {
	return 'completed'
}

pub fn Class_Automattic_WooCommerce_Enums_OrderStatus.processing() string {
	return 'processing'
}

pub fn Class_Automattic_WooCommerce_Enums_OrderStatus.refunded() string {
	return 'refunded'
}

pub fn Class_Automattic_WooCommerce_Enums_OrderStatus.cancelled() string {
	return 'cancelled'
}

pub fn Class_Automattic_WooCommerce_Enums_OrderStatus.trash() string {
	return 'trash'
}

pub fn Class_Automattic_WooCommerce_Enums_OrderStatus.new() string {
	return 'new'
}

pub fn Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft() string {
	return 'auto-draft'
}

pub fn Class_Automattic_WooCommerce_Enums_OrderStatus.draft() string {
	return 'draft'
}

pub fn Class_Automattic_WooCommerce_Enums_OrderStatus.checkout_draft() string {
	return 'checkout-draft'
}

pub fn Class_Automattic_WooCommerce_Enums_OrderStatus.payment_complete_statuses() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Enums_Automattic_WooCommerce_Enums_OrderStatus.on_hold()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Enums_Automattic_WooCommerce_Enums_OrderStatus.pending()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Enums_Automattic_WooCommerce_Enums_OrderStatus.failed()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Enums_Automattic_WooCommerce_Enums_OrderStatus.cancelled()
		},
	])
}

struct Class_Automattic_WooCommerce_Enums_OrderStatus {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_enums_orderstatus() &Class_Automattic_WooCommerce_Enums_OrderStatus {
	mut obj := &Class_Automattic_WooCommerce_Enums_OrderStatus{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Enums_OrderStatus) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Enums_OrderStatus) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Enums_OrderStatus) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_enums_orderstatus_php() {
	// unsupported statement: Stmt_Declare
}
