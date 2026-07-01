import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableDefinitionNode {
	rt.PhpObjectBase
pub mut:
	kind         rt.PhpVal = rt.new_null()
	variable     rt.PhpVal = rt.new_null()
	prop_type    rt.PhpVal = rt.new_null()
	defaultValue rt.PhpVal = rt.new_null()
	directives   rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableDefinitionNode) construct(mut var_vars Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_array) {
	this.Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node.construct(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_array',
		[]string{}, var_vars))
	// unsupported expression: Expr_AssignOp_Coalesce
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_variabledefinitionnode(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableDefinitionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableDefinitionNode{
		PhpObjectBase: rt.PhpObjectBase{}
		kind:          rt.new_null()
		variable:      rt.new_null()
		prop_type:     rt.new_null()
		defaultValue:  rt.new_null()
		directives:    rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_node() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableDefinitionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableDefinitionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'kind' { return this.kind }
		'variable' { return this.variable }
		'type' { return this.prop_type }
		'defaultValue' { return this.defaultValue }
		'directives' { return this.directives }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableDefinitionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'kind' {
			this.kind = val
			return true
		}
		'variable' {
			this.variable = val
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

pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_language_ast_variabledefinitionnode_php() {
	// unsupported statement: Stmt_Declare
}
