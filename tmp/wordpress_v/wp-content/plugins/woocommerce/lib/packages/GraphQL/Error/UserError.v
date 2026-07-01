import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_UserError {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_UserError) isclientsafe() bool {
	return true
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_RuntimeException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_error_usererror() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_UserError {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_UserError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_runtimeexception() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_RuntimeException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_UserError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'isClientSafe' {
			return rt.new_bool(this.isclientsafe())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_UserError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_UserError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_error_usererror_php() {
	// unsupported statement: Stmt_Declare
}
