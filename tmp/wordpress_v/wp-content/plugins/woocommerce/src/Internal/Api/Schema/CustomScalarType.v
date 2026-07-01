import rt

struct Class_Automattic_WooCommerce_Internal_Api_Schema_CustomScalarType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Api_Schema_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_api_schema_customscalartype() &Class_Automattic_WooCommerce_Internal_Api_Schema_CustomScalarType {
	mut obj := &Class_Automattic_WooCommerce_Internal_Api_Schema_CustomScalarType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_api_schema_automattic_woocommerce_vendor_graphql_type_definition_customscalartype() &Class_Automattic_WooCommerce_Internal_Api_Schema_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType {
	mut obj := &Class_Automattic_WooCommerce_Internal_Api_Schema_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Schema_CustomScalarType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Api_Schema_CustomScalarType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Schema_CustomScalarType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Schema_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Api_Schema_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Schema_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_api_schema_customscalartype_php() {
	// unsupported statement: Stmt_Declare
}
