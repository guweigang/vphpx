import rt

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_TypeKind.scalar() string {
	return 'SCALAR'
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_TypeKind.object() string {
	return 'OBJECT'
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_TypeKind.interface() string {
	return 'INTERFACE'
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_TypeKind.union() string {
	return 'UNION'
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_TypeKind.enum() string {
	return 'ENUM'
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_TypeKind.input_object() string {
	return 'INPUT_OBJECT'
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_TypeKind.list() string {
	return 'LIST'
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_TypeKind.non_null() string {
	return 'NON_NULL'
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_TypeKind {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_type_typekind() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_TypeKind {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_TypeKind{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_TypeKind) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_TypeKind) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_TypeKind) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_type_typekind_php() {
	// unsupported statement: Stmt_Declare
}
