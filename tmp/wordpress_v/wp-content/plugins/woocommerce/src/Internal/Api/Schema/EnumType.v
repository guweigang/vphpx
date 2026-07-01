import rt

struct Class_Automattic_WooCommerce_Internal_Api_Schema_EnumType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Api_Schema_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_api_schema_enumtype() &Class_Automattic_WooCommerce_Internal_Api_Schema_EnumType {
	mut obj := &Class_Automattic_WooCommerce_Internal_Api_Schema_EnumType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_api_schema_automattic_woocommerce_vendor_graphql_type_definition_enumtype() &Class_Automattic_WooCommerce_Internal_Api_Schema_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType {
	mut obj := &Class_Automattic_WooCommerce_Internal_Api_Schema_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Schema_EnumType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Api_Schema_EnumType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Schema_EnumType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Schema_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Api_Schema_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Schema_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_api_schema_enumtype_php() {
	// unsupported statement: Stmt_Declare
}
