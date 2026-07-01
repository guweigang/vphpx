import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString.dedentblockstringlines(rawString string) string {
	mut var_lines := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.splitlines(arg_0) }(rt.new_string(rawString))
	mut var_commonIndent := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString.getindentation(rawString)
	mut var_linesLength := rt.new_int(rt.new_int(var_lines.dup().array_count()))
	if rt.is_true(rt.greater(var_commonIndent, rt.new_int(0))) {
		{
			mut var_i := rt.new_int(rt.new_int(1))
			for {
				if !(rt.is_true(rt.less(var_i, var_linesLength))) { break }
				var_lines.array_set(var_i, rt.call_function('mb_substr', [var_lines.array_get(var_i), var_commonIndent.dup()]))
				rt.pre_inc(var_i)
			}
		}
	}
	mut var_startLine := rt.new_int(rt.new_int(0))
	for rt.is_true(rt.new_bool(rt.is_true(rt.less(var_startLine, var_linesLength)) && rt.is_true(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString.isblank((var_lines.array_get(var_startLine)).str())))) {
		rt.pre_inc(var_startLine)
	}
	mut var_endLine := var_linesLength.dup()
	for rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_endLine, var_startLine)) && rt.is_true(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString.isblank((var_lines.array_get(rt.sub(var_endLine, rt.new_int(1)))).str())))) {
		rt.pre_dec(var_endLine)
	}
	return (rt.call_function('implode', [rt.new_string('\n'), rt.call_function('array_slice', [var_lines.dup(), var_startLine.dup(), rt.sub(var_endLine, var_startLine)])])).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString.isblank(str string) bool {
	mut var_strLength := rt.call_function('mb_strlen', [rt.new_string(str)])
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, var_strLength))) { break }
			if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				return false
			}
			rt.pre_inc(var_i)
		}
	}
	return true
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString.getindentation(value string) i64 {
	mut var_isFirstLine := rt.new_bool(rt.new_bool(true))
	mut var_isEmptyLine := rt.new_bool(rt.new_bool(true))
	mut var_indent := rt.new_int(rt.new_int(0))
	mut var_commonIndent := rt.new_null()
	mut var_valueLength := rt.call_function('mb_strlen', [rt.new_string(value)])
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, var_valueLength))) { break }
			mut switch_val_1 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.charcodeat(arg_0, arg_1) }(rt.new_string(value), var_i.dup())
			if rt.is_true(rt.equal(switch_val_1, rt.new_int(13))) {
				if rt.is_true(rt.identical(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.charcodeat(arg_0, arg_1) }(rt.new_string(value), rt.add(var_i, rt.new_int(1))), rt.new_int(10))) {
					rt.pre_inc(var_i)
					// unsupported statement: Stmt_Nop
				}
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(10))) {
				var_isFirstLine = rt.new_bool(rt.new_bool(false))
				var_isEmptyLine = rt.new_bool(rt.new_bool(true))
				var_indent = rt.new_int(rt.new_int(0))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(9))) || rt.is_true(rt.equal(switch_val_1, rt.new_int(32))) {
				rt.pre_inc(var_indent)
			} else {
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_isEmptyLine) && rt.is_true(rt.new_bool(!(rt.is_true(var_isFirstLine)))))) && rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_commonIndent, rt.new_null())) || rt.is_true(rt.less(var_indent, var_commonIndent)))))) {
					var_commonIndent = var_indent.dup()
				}
				var_isEmptyLine = rt.new_bool(rt.new_bool(false))
			}
			rt.pre_inc(var_i)
		}
	}
	return (if !(var_commonIndent).is_null() { var_commonIndent } else { rt.new_int(0) }).to_i64()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString.print(value string) string {
	mut var_escapedValue := rt.call_function('str_replace', [rt.new_string('"""'), rt.new_string('\\"""'), rt.new_string(value)])
	mut var_lines := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.splitlines(arg_0) }(var_escapedValue.dup())
	mut var_isSingleLine := rt.new_bool(rt.new_bool(var_lines.dup().array_count() == 1))
	mut var_forceLeadingNewLine := rt.new_bool(rt.new_bool(var_lines.dup().array_count() > 1))
	{
		mut iter_1 := var_lines.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_line := item_1.val
			mut var_i := item_1.key
			if rt.is_true(rt.identical(var_i, rt.new_int(0))) {
				continue
			}
			if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				var_forceLeadingNewLine = rt.new_bool(rt.new_bool(false))
			}
		}
	}
	mut var_hasTrailingTripleQuotes := rt.identical(rt.call_function('preg_match', [rt.new_string('/\\\\"""$/'), var_escapedValue.dup()]), rt.new_int(1))
	mut var_hasTrailingQuote := rt.new_bool(rt.new_bool(rt.is_true(rt.identical(rt.call_function('preg_match', [rt.new_string('/"$/'), rt.new_string(value)]), rt.new_int(1))) && rt.is_true(rt.new_bool(!(rt.is_true(var_hasTrailingTripleQuotes))))))
	mut var_hasTrailingSlash := rt.identical(rt.call_function('preg_match', [rt.new_string('/\\\\$/'), rt.new_string(value)]), rt.new_int(1))
	mut var_forceTrailingNewline := rt.new_bool(rt.new_bool(rt.is_true(var_hasTrailingQuote) || rt.is_true(var_hasTrailingSlash)))
	mut var_printAsMultipleLines := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_isSingleLine)))) || rt.is_true(rt.greater(rt.call_function('mb_strlen', [rt.new_string(value)]), rt.new_int(70))))) || rt.is_true(var_forceTrailingNewline))) || rt.is_true(var_forceLeadingNewLine))) || rt.is_true(var_hasTrailingTripleQuotes)))
	mut var_result := rt.new_string(rt.new_string(''))
	mut var_skipLeadingNewLine := rt.new_bool(rt.new_bool(rt.is_true(var_isSingleLine) && rt.is_true(rt.identical(rt.call_function('preg_match', [rt.new_string('/^\\s/'), rt.new_string(value)]), rt.new_int(1)))))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_printAsMultipleLines) && rt.is_true(rt.new_bool(!(rt.is_true(var_skipLeadingNewLine)))))) || rt.is_true(var_forceLeadingNewLine))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	if rt.is_true(var_printAsMultipleLines) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return '"""' + (var_result).str() + '"""'
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_language_blockstring() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_utils() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'dedentBlockStringLines' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString.dedentblockstringlines(dispatch_arg_0))
		}
		'isBlank' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString.isblank(dispatch_arg_0))
		}
		'getIndentation' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_int(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString.getindentation(dispatch_arg_0))
		}
		'print' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString.print(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_language_blockstring_php() {
	// unsupported statement: Stmt_Declare
}
