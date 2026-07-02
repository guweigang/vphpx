import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaDefinitionNode {
	rt.PhpObjectBase
pub mut:
	kind           rt.PhpVal = rt.new_null()
	directives     rt.PhpVal = rt.new_null()
	operationTypes rt.PhpVal = rt.new_null()
	description    rt.PhpVal = rt.new_null()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_schemadefinitionnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaDefinitionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaDefinitionNode{
		PhpObjectBase:  rt.PhpObjectBase{}
		kind:           rt.new_null()
		directives:     rt.new_null()
		operationTypes: rt.new_null()
		description:    rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_node(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaDefinitionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaDefinitionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'kind' { return this.kind }
		'directives' { return this.directives }
		'operationTypes' { return this.operationTypes }
		'description' { return this.description }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaDefinitionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'kind' {
			this.kind = val
			return true
		}
		'directives' {
			this.directives = val
			return true
		}
		'operationTypes' {
			this.operationTypes = val
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

fn main() {
	defer {
		rt.shutdown()
	}
}
