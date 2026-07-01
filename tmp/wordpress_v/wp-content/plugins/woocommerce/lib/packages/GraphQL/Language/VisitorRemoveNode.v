import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_VisitorRemoveNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_VisitorOperation {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_language_visitorremovenode() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_VisitorRemoveNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_VisitorRemoveNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_visitoroperation() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_VisitorOperation {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_VisitorOperation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_VisitorRemoveNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_VisitorRemoveNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_VisitorRemoveNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_VisitorOperation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_VisitorOperation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_VisitorOperation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_language_visitorremovenode_php() {
	// unsupported statement: Stmt_Declare
}
