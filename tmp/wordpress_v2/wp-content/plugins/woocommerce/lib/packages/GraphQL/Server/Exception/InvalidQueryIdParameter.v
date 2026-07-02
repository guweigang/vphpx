import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidQueryIdParameter {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_RequestError {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_server_exception_invalidqueryidparameter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidQueryIdParameter {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidQueryIdParameter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_requesterror(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_RequestError {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_RequestError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidQueryIdParameter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidQueryIdParameter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_InvalidQueryIdParameter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_RequestError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_RequestError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_RequestError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
