import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('class_alias', [
		Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo.class(),
		rt.new_string('Automattic\\WooCommerce\\Internal\\Api\\Schema\\ResolveInfo'),
	])
	rt.call_function('class_alias', [
		Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode.class(),
		rt.new_string('Automattic\\WooCommerce\\Internal\\Api\\Schema\\AST\\StringValueNode'),
	])
}
