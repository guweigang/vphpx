import rt

pub fn init_wp_content_plugins_woocommerce_src_internal_api_schema_aliases_php() {
	// unsupported statement: Stmt_Declare
	rt.call_function('class_alias', [
		Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo.class(),
		rt.new_string('Automattic\\WooCommerce\\Internal\\Api\\Schema\\ResolveInfo'),
	])
	rt.call_function('class_alias', [
		Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode.class(),
		rt.new_string('Automattic\\WooCommerce\\Internal\\Api\\Schema\\AST\\StringValueNode'),
	])
}
