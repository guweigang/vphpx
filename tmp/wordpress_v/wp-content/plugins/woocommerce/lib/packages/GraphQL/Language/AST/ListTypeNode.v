import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListTypeNode {
	rt.PhpObjectBase
pub mut:
	kind      rt.PhpVal = rt.new_null()
	prop_type rt.PhpVal = rt.new_null()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_listtypenode() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListTypeNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListTypeNode{
		PhpObjectBase: rt.PhpObjectBase{}
		kind:          rt.new_null()
		prop_type:     rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_node() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListTypeNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListTypeNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'kind' { return this.kind }
		'type' { return this.prop_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListTypeNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'kind' {
			this.kind = val
			return true
		}
		'type' {
			this.prop_type = val
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

pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_language_ast_listtypenode_php() {
	// unsupported statement: Stmt_Declare
}
