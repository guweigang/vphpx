import rt

pub fn Class_Automattic_WooCommerce_Enums_OrderInternalStatus.pending() string {
	return 'wc-pending'
}

pub fn Class_Automattic_WooCommerce_Enums_OrderInternalStatus.processing() string {
	return 'wc-processing'
}

pub fn Class_Automattic_WooCommerce_Enums_OrderInternalStatus.on_hold() string {
	return 'wc-on-hold'
}

pub fn Class_Automattic_WooCommerce_Enums_OrderInternalStatus.completed() string {
	return 'wc-completed'
}

pub fn Class_Automattic_WooCommerce_Enums_OrderInternalStatus.cancelled() string {
	return 'wc-cancelled'
}

pub fn Class_Automattic_WooCommerce_Enums_OrderInternalStatus.refunded() string {
	return 'wc-refunded'
}

pub fn Class_Automattic_WooCommerce_Enums_OrderInternalStatus.failed() string {
	return 'wc-failed'
}

struct Class_Automattic_WooCommerce_Enums_OrderInternalStatus {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_enums_orderinternalstatus() &Class_Automattic_WooCommerce_Enums_OrderInternalStatus {
	mut obj := &Class_Automattic_WooCommerce_Enums_OrderInternalStatus{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Enums_OrderInternalStatus) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Enums_OrderInternalStatus) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Enums_OrderInternalStatus) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_enums_orderinternalstatus_php() {
	// unsupported statement: Stmt_Declare
}
