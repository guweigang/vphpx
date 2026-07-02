import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_SessionKey.chosen_shipping_methods() string {
	return 'chosen_shipping_methods'
}

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_SessionKey.agentic_checkout_session_id() string {
	return 'agentic_checkout_session_id'
}

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_SessionKey.agentic_checkout_completed_order_id() string {
	return 'agentic_checkout_completed_order_id'
}

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_SessionKey.agentic_checkout_payment_in_progress() string {
	return 'agentic_checkout_payment_in_progress'
}

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_SessionKey.agentic_checkout_provider_id() string {
	return 'agentic_checkout_provider_id'
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_SessionKey {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_agentic_enums_sessionkey(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_SessionKey {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_SessionKey{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_SessionKey) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_SessionKey) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_SessionKey) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
