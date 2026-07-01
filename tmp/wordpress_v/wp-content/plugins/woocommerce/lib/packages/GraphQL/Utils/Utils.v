import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.undefined() rt.PhpVal {
	mut var_undefined := rt.new_null()
	// unsupported statement: Stmt_Static
	return // unsupported expression: Expr_AssignOp_Coalesce
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.assign(mut var_obj Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_object, mut var_vars Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	mut var_obj_mutated := var_obj
	{
		mut iter_1 := var_vars.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('property_exists', [var_obj_mutated.dup(), var_key.dup()]))))) {
				mut var_cls := rt.call_function('get_class', [var_obj_mutated.dup()])
				fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning{}; return temp.warn(arg_0, arg_1) }(rt.new_string("Trying to set non-existing property '${var_key.to_string()}' on class '${var_cls.to_string()}'"), Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning.warning_assign())
			}
			rt.set_property(var_obj_mutated, '{"nodeType":"Expr_Variable","line":30,"name":"key"}', var_value.dup())
		}
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_object', []string{}, var_obj_mutated)
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.printsafejson(var_value rt.PhpVal) string {
	if rt.is_true(rt.new_bool(rt.instance_of(var_value, 'Automattic_WooCommerce_Vendor_GraphQL_Utils_stdClass'))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.jsonencodeorserialize(var_value.dup())).str()
	}
	return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.printsafeinternal(var_value.dup())).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.printsafe(var_value rt.PhpVal) string {
	if rt.is_true(rt.new_bool(var_value.dup().is_object())) {
		if rt.is_true(rt.call_function('method_exists', [var_value.dup(), rt.new_string('__toString')])) {
			return (rt.call_method(var_value, '__toString', []rt.PhpVal{})).str()
		}
		return 'instance of ' + (rt.call_function('get_class', [var_value.dup()])).str()
	}
	return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.printsafeinternal(var_value.dup())).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.jsonencodeorserialize(var_value rt.PhpVal) string {
	return rt.json_encode(var_value.dup())
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Vendor_GraphQL_Utils_JsonException') {
		mut var_jsonException := var_e_1.dup()
		return (rt.call_function('serialize', [var_value.dup()])).str()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return ''
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.printsafeinternal(var_value rt.PhpVal) string {
	if rt.is_true(rt.new_bool(var_value.dup().is_array())) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.jsonencodeorserialize(var_value.dup())).str()
	}
	if rt.is_true(rt.identical(var_value, rt.new_string(''))) {
		return '(empty string)'
	}
	if rt.is_true(rt.identical(var_value, rt.new_null())) {
		return 'null'
	}
	if rt.is_true(rt.identical(var_value, rt.new_bool(false))) {
		return 'false'
	}
	if rt.is_true(rt.identical(var_value, rt.new_bool(true))) {
		return 'true'
	}
	if rt.is_true(rt.new_bool(var_value.dup().is_string())) {
		return "\"${var_value.to_string()}\""
	}
	if rt.is_true(rt.call_function('is_scalar', [var_value.dup()])) {
		return (// unsupported expression: Expr_Cast_String).str()
	}
	return (rt.call_function('gettype', [var_value.dup()])).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.chr(ord i64, encoding string) string {
	if rt.is_true(rt.identical(rt.new_string(encoding), rt.new_string('UCS-4BE'))) {
		return (rt.call_function('pack', [rt.new_string('N'), rt.new_int(ord)])).str()
	}
	return (rt.call_function('mb_convert_encoding', [Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.chr(ord, 'UCS-4BE'), rt.new_string(encoding), rt.new_string('UCS-4BE')])).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.ord(char string, encoding string) i64 {
	mut char_mutated := char
	if !(rt.new_string(char_mutated).array_isset(rt.new_int(1))) {
		return (rt.call_function('ord', [rt.new_string(char_mutated).dup()])).to_i64()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		char_mutated = (rt.call_function('mb_convert_encoding', [rt.new_string(char_mutated).dup(), rt.new_string('UCS-4BE'), rt.new_string(encoding)])).str()
		rt.call_function('assert', [rt.new_bool(rt.new_string(char_mutated).dup().is_string()), rt.new_string('format string is statically known to be correct')])
	}
	mut var_unpacked := rt.call_function('unpack', [rt.new_string('N'), rt.new_string(char_mutated).dup()])
	rt.call_function('assert', [rt.new_bool(var_unpacked.dup().is_array()), rt.new_string('format string is statically known to be correct')])
	return (var_unpacked.array_get(1)).to_i64()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.charcodeat(string string, position i64) i64 {
	mut var_char := rt.call_function('mb_substr', [rt.new_string(string), rt.new_int(position), rt.new_int(1), rt.new_string('UTF-8')])
	return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.ord((var_char).str())).to_i64()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.printcharcode(mut var_code Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?int) string {
	if rt.is_true(rt.identical(var_code, rt.new_null())) {
		return '<EOF>'
	}
	return if rt.is_true(rt.less(var_code, rt.new_int(127))) { rt.json_encode(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.chr(var_code)) } else { '"\\u' + (rt.call_function('dechex', [var_code])).str() + '"' }
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.assertvalidname(name string)  {
	mut var_error := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.isvalidnameerror(name)
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(var_error)
	}
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.isvalidnameerror(name string, mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Node) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.new_string(name).array_isset(rt.new_int(1)) && rt.is_true(rt.identical(rt.new_string(name).array_get(0), rt.new_string('_'))))) && rt.is_true(rt.identical(rt.new_string(name).array_get(1), rt.new_string('_'))))) {
		return create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("Name \"${var_name}\" must not begin with \"__\", which is reserved by Automattic\\WooCommerce\\Vendor\\GraphQL introspection."), var_node.dup())
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return create_automattic_woocommerce_vendor_graphql_error_error(rt.concat(rt.concat(rt.new_string('Names must match /^[_a-zA-Z][_a-zA-Z0-9]*$/ but "'), rt.new_string(name)), rt.new_string('" does not.')), var_node.dup())
	}
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.quotedorlist(mut var_items Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) string {
	mut var_item := rt.new_null()
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_string("\"${var_item.to_string()}\"")
	}
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_string("\"${var_item.to_string()}\"")
	}
	mut var_quoted := rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_items])
	return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.orlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_quoted))).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.orlist(mut var_items Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) string {
	mut var_list := rt.new_null()
	mut var_index := rt.new_null()
	if rt.is_true(rt.identical(var_items, rt.new_array())) {
		return ''
	}
	mut var_selected := rt.call_function('array_slice', [var_items, rt.new_int(0), rt.new_int(5)])
	mut var_selectedLength := rt.new_int(rt.new_int(var_selected.dup().array_count()))
	mut var_firstSelected := var_selected.array_get(0)
	if rt.is_true(rt.identical(var_selectedLength, rt.new_int(1))) {
		return (var_firstSelected).str()
	}
	closure_3_fn := fn [var_selected] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_list := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_index := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return (var_list).str() + if rt.is_true(rt.greater(var_selectedLength, rt.new_int(2))) { ', ' } else { ' ' } + if rt.is_true(rt.identical(var_index, rt.sub(var_selectedLength, rt.new_int(1)))) { 'or ' } else { '' } + (var_selected.array_get(var_index)).str()
	}
	return (rt.call_function('array_reduce', [rt.call_function('range', [rt.new_int(1), rt.sub(var_selectedLength, rt.new_int(1))]), rt.new_closure(closure_3_fn), var_firstSelected.dup()])).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.suggestionlist(input string, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	mut var_optionsByDistance := rt.new_array()
	mut var_lexicalDistance := create_automattic_woocommerce_vendor_graphql_utils_lexicaldistance(rt.new_string(input).dup())
	mut var_threshold := rt.new_float(rt.call_function('mb_strlen', [rt.new_string(input)]) * 0.4 + 1)
	{
		mut iter_1 := var_options.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_option := item_1.val
			mut var_distance := var_lexicalDistance.measure(var_option.dup(), var_threshold.dup())
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				var_optionsByDistance.array_set(var_option, var_distance.dup())
			}
		}
	}
	closure_4_fn := fn [var_optionsByDistance] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_a := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_b := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	mut var_distanceDiff := rt.sub(var_optionsByDistance.array_get(var_a), var_optionsByDistance.array_get(var_b))
	return if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_distanceDiff } else { rt.call_function('strnatcmp', [var_a.dup(), var_b.dup()]) }
	}
	rt.call_function('uksort', [var_optionsByDistance.dup(), rt.new_closure(closure_4_fn)])
	return rt.call_function('array_map', [rt.new_string('strval'), rt.func_array_keys(var_optionsByDistance.dup())])
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.extractkey(var_objectLikeValue rt.PhpVal, key string) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_objectLikeValue.dup().is_array())) || rt.is_true(rt.new_bool(rt.instance_of(var_objectLikeValue, 'Automattic_WooCommerce_Vendor_GraphQL_Utils_ArrayAccess'))))) {
		return if !(var_objectLikeValue.array_get(key)).is_null() { var_objectLikeValue.array_get(key) } else { rt.new_null() }
	}
	if rt.is_true(rt.new_bool(var_objectLikeValue.dup().is_object())) {
		return if !(rt.get_property(var_objectLikeValue, '{"nodeType":"Expr_Variable","line":276,"name":"key"}')).is_null() { rt.get_property(var_objectLikeValue, '{"nodeType":"Expr_Variable","line":276,"name":"key"}') } else { rt.new_null() }
	}
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.splitlines(value string) rt.PhpVal {
	mut var_lines := rt.call_function('preg_split', [rt.new_string('/\r\n|\r|\n/'), rt.new_string(value)])
	rt.call_function('assert', [rt.new_bool(var_lines.dup().is_array()), rt.new_string('given the regex is valid')])
	return var_lines.dup()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_LexicalDistance {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_utils_utils() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_warning() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_error() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_lexicaldistance() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_LexicalDistance {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_LexicalDistance{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'undefined' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.undefined()
		}
		'assign' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_object](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.assign(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'printSafeJson' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.printsafejson(dispatch_arg_0))
		}
		'printSafe' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.printsafe(dispatch_arg_0))
		}
		'jsonEncodeOrSerialize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.jsonencodeorserialize(dispatch_arg_0))
		}
		'printSafeInternal' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.printsafeinternal(dispatch_arg_0))
		}
		'chr' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.chr(dispatch_arg_0, dispatch_arg_1))
		}
		'ord' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_int(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.ord(dispatch_arg_0, dispatch_arg_1))
		}
		'charCodeAt' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_int(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.charcodeat(dispatch_arg_0, dispatch_arg_1))
		}
		'printCharCode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?int](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.printcharcode(mut dispatch_arg_0))
		}
		'assertValidName' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.assertvalidname(dispatch_arg_0)
			return rt.new_null()
		}
		'isValidNameError' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_?Node](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.isvalidnameerror(dispatch_arg_0, mut dispatch_arg_1)
		}
		'quotedOrList' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.quotedorlist(mut dispatch_arg_0))
		}
		'orList' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.orlist(mut dispatch_arg_0))
		}
		'suggestionList' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.suggestionlist(dispatch_arg_0, mut dispatch_arg_1)
		}
		'extractKey' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.extractkey(dispatch_arg_0, dispatch_arg_1)
		}
		'splitLines' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils.splitlines(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Warning) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_LexicalDistance) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_LexicalDistance) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_LexicalDistance) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_utils_utils_php() {
	// unsupported statement: Stmt_Declare
}
