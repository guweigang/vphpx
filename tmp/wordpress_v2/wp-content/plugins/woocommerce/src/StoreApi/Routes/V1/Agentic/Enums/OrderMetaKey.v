import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_OrderMetaKey.agentic_checkout_session_id() string {
	return '_agentic_checkout_session_id'
}

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_OrderMetaKey.agentic_checkout_canceled() string {
	return '_agentic_checkout_canceled'
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_OrderMetaKey {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_agentic_enums_ordermetakey(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_OrderMetaKey {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_OrderMetaKey{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_OrderMetaKey) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_OrderMetaKey) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Agentic_Enums_OrderMetaKey) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
