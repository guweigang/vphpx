import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_UnexpectedContentType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Server_RequestError {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_server_exception_unexpectedcontenttype() &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_UnexpectedContentType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_UnexpectedContentType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_server_requesterror() &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_RequestError {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_RequestError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_UnexpectedContentType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_UnexpectedContentType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Server_Exception_UnexpectedContentType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_server_exception_unexpectedcontenttype_php() {
	// unsupported statement: Stmt_Declare
}
