import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode {
	rt.PhpObjectBase
pub mut:
	kind         rt.PhpVal = rt.new_null()
	name         rt.PhpVal = rt.new_null()
	alias        rt.PhpVal = rt.new_null()
	arguments    rt.PhpVal = rt.new_null()
	directives   rt.PhpVal = rt.new_null()
	selectionSet rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode) construct(mut var_vars Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_array) {
	this.Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node.construct(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_array',
		[]string{}, var_vars))
	rt.new_null()
	rt.new_null()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_fieldnode(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode{
		PhpObjectBase: rt.PhpObjectBase{}
		kind:          rt.new_null()
		name:          rt.new_null()
		alias:         rt.new_null()
		arguments:     rt.new_null()
		directives:    rt.new_null()
		selectionSet:  rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_node(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'kind' { return this.kind }
		'name' { return this.name }
		'alias' { return this.alias }
		'arguments' { return this.arguments }
		'directives' { return this.directives }
		'selectionSet' { return this.selectionSet }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'kind' {
			this.kind = val
			return true
		}
		'name' {
			this.name = val
			return true
		}
		'alias' {
			this.alias = val
			return true
		}
		'arguments' {
			this.arguments = val
			return true
		}
		'directives' {
			this.directives = val
			return true
		}
		'selectionSet' {
			this.selectionSet = val
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
