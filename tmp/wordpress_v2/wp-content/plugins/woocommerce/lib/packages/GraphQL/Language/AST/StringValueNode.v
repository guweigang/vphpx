import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode {
	rt.PhpObjectBase
pub mut:
	kind  rt.PhpVal = rt.new_null()
	value rt.PhpVal = rt.new_null()
	block rt.PhpVal = rt.new_bool(false)
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_stringvaluenode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode{
		PhpObjectBase: rt.PhpObjectBase{}
		kind:          rt.new_null()
		value:         rt.new_null()
		block:         rt.new_bool(false)
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_node(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'kind' { return this.kind }
		'value' { return this.value }
		'block' { return this.block }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'kind' {
			this.kind = val
			return true
		}
		'value' {
			this.value = val
			return true
		}
		'block' {
			this.block = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
