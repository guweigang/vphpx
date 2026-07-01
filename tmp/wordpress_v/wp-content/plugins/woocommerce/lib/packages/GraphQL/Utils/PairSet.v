import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PairSet {
	rt.PhpObjectBase
pub mut:
		data rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PairSet) has(a string, b string, areMutuallyExclusive bool) bool {
	mut var_first := if !(this.data.array_get(a)).is_null() { this.data.array_get(a) } else { rt.new_null() }
	mut var_result := if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && var_first.array_isset(rt.new_string(b)))) { var_first.array_get(b) } else { rt.new_null() }
	if rt.is_true(rt.identical(var_result, rt.new_null())) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_bool(areMutuallyExclusive), rt.new_bool(false))) {
		return (rt.identical(var_result, rt.new_bool(false))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PairSet) add(a string, b string, areMutuallyExclusive bool)  {
	this.pairsetadd(a, b, areMutuallyExclusive)
	this.pairsetadd(b, a, areMutuallyExclusive)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PairSet) pairsetadd(a string, b string, areMutuallyExclusive bool)  {
	// unsupported expression: Expr_AssignOp_Coalesce
	this.data.array_get_mut(a).array_set(b, areMutuallyExclusive)
}

fn create_automattic_woocommerce_vendor_graphql_utils_pairset() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PairSet {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PairSet{
		PhpObjectBase: rt.PhpObjectBase{}
		data: rt.new_array()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PairSet) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'has' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.has(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'add' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.add(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'pairSetAdd' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.pairsetadd(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PairSet) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'data' { return this.data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PairSet) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'data' { this.data = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_utils_pairset_php() {
	// unsupported statement: Stmt_Declare
}
