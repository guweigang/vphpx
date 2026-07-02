import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeDefinitionNode {
	rt.PhpObjectBase
pub mut:
	kind        rt.PhpVal = rt.new_null()
	name        rt.PhpVal = rt.new_null()
	directives  rt.PhpVal = rt.new_null()
	interfaces  rt.PhpVal = rt.new_null()
	fields      rt.PhpVal = rt.new_null()
	description rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeDefinitionNode) getname() rt.PhpVal {
	return this.name
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_interfacetypedefinitionnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeDefinitionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeDefinitionNode{
		PhpObjectBase: rt.PhpObjectBase{}
		kind:          rt.new_null()
		name:          rt.new_null()
		directives:    rt.new_null()
		interfaces:    rt.new_null()
		fields:        rt.new_null()
		description:   rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_node(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeDefinitionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getName' {
			return this.getname()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeDefinitionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'kind' { return this.kind }
		'name' { return this.name }
		'directives' { return this.directives }
		'interfaces' { return this.interfaces }
		'fields' { return this.fields }
		'description' { return this.description }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeDefinitionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'kind' {
			this.kind = val
			return true
		}
		'name' {
			this.name = val
			return true
		}
		'directives' {
			this.directives = val
			return true
		}
		'interfaces' {
			this.interfaces = val
			return true
		}
		'fields' {
			this.fields = val
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
