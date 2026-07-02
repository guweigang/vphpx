import rt

struct Class_Automattic_WooCommerce_Internal_Api_Schema_ObjectType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Api_Schema_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_api_schema_objecttype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Api_Schema_ObjectType {
	mut obj := &Class_Automattic_WooCommerce_Internal_Api_Schema_ObjectType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_api_schema_automattic_woocommerce_vendor_graphql_type_definition_objecttype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Api_Schema_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType {
	mut obj := &Class_Automattic_WooCommerce_Internal_Api_Schema_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Schema_ObjectType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Api_Schema_ObjectType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Schema_ObjectType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Schema_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Api_Schema_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Schema_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
