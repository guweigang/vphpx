import rt

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_DebugFlag.none() i64 {
	return 0
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_DebugFlag.include_debug_message() i64 {
	return 1
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_DebugFlag.include_trace() i64 {
	return 2
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_DebugFlag.rethrow_internal_exceptions() i64 {
	return 4
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Error_DebugFlag.rethrow_unsafe_exceptions() i64 {
	return 8
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_DebugFlag {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_error_debugflag(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_DebugFlag {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_DebugFlag{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_DebugFlag) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_DebugFlag) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_DebugFlag) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
