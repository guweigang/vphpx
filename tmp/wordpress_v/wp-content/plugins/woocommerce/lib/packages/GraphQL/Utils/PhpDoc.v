import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PhpDoc {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PhpDoc.unwrap(var_docBlock rt.PhpVal) string {
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_docBlock, rt.new_bool(false))) || rt.is_true(rt.identical(var_docBlock, rt.new_null())))) {
		return (rt.new_null()).str()
	}
	mut var_content := rt.call_function('preg_replace', [rt.new_string('~([\\r\\n]) \\* (.*)~i'), rt.new_string('$1$2'), var_docBlock.dup()])
	rt.call_function('assert', [rt.new_bool(var_content.dup().is_string()), rt.new_string('regex is statically known to be valid')])
	var_content = rt.call_function('preg_replace', [rt.new_string('~([\\r\\n])[\\* ]+([\\r\\n])~i'), rt.new_string('$1$2'), var_content.dup()])
	rt.call_function('assert', [rt.new_bool(var_content.dup().is_string()), rt.new_string('regex is statically known to be valid')])
	var_content = rt.call_function('substr', [var_content.dup(), rt.new_int(3)])
	var_content = rt.call_function('substr', [var_content.dup(), rt.new_int(0), // unsupported expression: Expr_UnaryMinus])
	return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PhpDoc.nonemptyornull((var_content).str())).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PhpDoc.unpad(var_docBlock rt.PhpVal) string {
	mut var_line := rt.new_null()
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_docBlock, rt.new_bool(false))) || rt.is_true(rt.identical(var_docBlock, rt.new_null())))) {
		return (rt.new_null()).str()
	}
	mut var_lines := rt.call_function('explode', [rt.new_string('\n'), var_docBlock.dup()])
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_line := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return ' ' + var_line.dup().to_string().trim_space()
	}
	mut var_line := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return ' ' + var_line.dup().to_string().trim_space()
	}
	var_lines = rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_lines.dup()])
	mut var_content := rt.call_function('implode', [rt.new_string('\n'), var_lines.dup()])
	return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PhpDoc.nonemptyornull((var_content).str())).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PhpDoc.nonemptyornull(maybeEmptyString string) string {
	mut var_trimmed := rt.new_string(rt.new_string(maybeEmptyString.trim_space()))
	return (if rt.is_true(rt.identical(var_trimmed, rt.new_string(''))) { rt.new_null() } else { var_trimmed }).str()
}

fn create_automattic_woocommerce_vendor_graphql_utils_phpdoc() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PhpDoc {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PhpDoc{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PhpDoc) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'unwrap' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PhpDoc.unwrap(dispatch_arg_0))
		}
		'unpad' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PhpDoc.unpad(dispatch_arg_0))
		}
		'nonEmptyOrNull' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PhpDoc.nonemptyornull(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PhpDoc) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_PhpDoc) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_utils_phpdoc_php() {
	// unsupported statement: Stmt_Declare
}
