import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputValueDefinitionNode {
	rt.PhpObjectBase
pub mut:
	kind         rt.PhpVal = rt.new_null()
	name         rt.PhpVal = rt.new_null()
	prop_type    rt.PhpVal = rt.new_null()
	defaultValue rt.PhpVal = rt.new_null()
	directives   rt.PhpVal = rt.new_null()
	description  rt.PhpVal = rt.new_null()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_inputvaluedefinitionnode() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputValueDefinitionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputValueDefinitionNode{
		PhpObjectBase: rt.PhpObjectBase{}
		kind:          rt.new_null()
		name:          rt.new_null()
		prop_type:     rt.new_null()
		defaultValue:  rt.new_null()
		directives:    rt.new_null()
		description:   rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_node() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputValueDefinitionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputValueDefinitionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'kind' { return this.kind }
		'name' { return this.name }
		'type' { return this.prop_type }
		'defaultValue' { return this.defaultValue }
		'directives' { return this.directives }
		'description' { return this.description }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputValueDefinitionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'kind' {
			this.kind = val
			return true
		}
		'name' {
			this.name = val
			return true
		}
		'type' {
			this.prop_type = val
			return true
		}
		'defaultValue' {
			this.defaultValue = val
			return true
		}
		'directives' {
			this.directives = val
			return true
		}
		'description' {
			this.description = val
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

pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_language_ast_inputvaluedefinitionnode_php() {
	// unsupported statement: Stmt_Declare
}
