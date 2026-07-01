import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValuesOfCorrectType {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValuesOfCorrectType) getvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) rt.PhpVal {
	closure_9_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_8_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_7_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_6_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_5_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_4_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_node := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_type := var_context.getinputtype()
	if rt.is_true(rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) {
		mut var_typeStr := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(var_type.dup())
		mut var_nodeStr := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{}; return temp.doprint(arg_0) }(var_node.dup())
		var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("Expected value of type \"${var_typeStr.to_string()}\", found ${var_nodeStr.to_string()}."), var_node.dup()))
	}
	return rt.new_null()
	}
	mut var_node := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_parentType := var_context.getparentinputtype()
	mut var_type := if rt.is_true(rt.identical(var_parentType, rt.new_null())) { rt.new_null() } else { fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}; return temp.getnullabletype(arg_0) }(var_parentType.dup()) }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType')))))) {
		this.isvalidvaluenode(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext', []string{}, var_context), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode](var_node))
		return fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}; return temp.skipnode() }()
	}
	return rt.new_null()
	}
	mut var_node := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_type := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}; return temp.getnamedtype(arg_0) }(var_context.getinputtype())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType')))))) {
		this.isvalidvaluenode(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext', []string{}, var_context), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode](var_node))
		return fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}; return temp.skipnode() }()
	}
	mut var_inputFields := rt.call_method(var_type, 'getFields', []rt.PhpVal{})
	mut var_fieldNodeMap := rt.new_array()
	{
		mut iter_1 := rt.get_property(var_node, 'fields').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			var_fieldNodeMap.array_set(rt.get_property(rt.get_property(var_field, 'name'), 'value'), var_field.dup())
		}
	}
	{
		mut iter_1 := var_inputFields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_fieldDef := item_1.val
			mut var_inputFieldName := item_1.key
			if rt.is_true(rt.new_bool(!(var_fieldNodeMap.array_isset(var_inputFieldName)) && rt.is_true(rt.call_method(var_fieldDef, 'isRequired', []rt.PhpVal{})))) {
				mut var_fieldType := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(rt.call_method(var_fieldDef, 'getType', []rt.PhpVal{}))
				var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Field '), rt.get_property(var_type, 'name')), rt.new_string('.')), var_inputFieldName), rt.new_string(' of required type ')), var_fieldType), rt.new_string(' was not provided.')), var_node.dup()))
			}
		}
	}
	return rt.new_null()
	}
	mut var_node := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_parentType := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}; return temp.getnamedtype(arg_0) }(var_context.getparentinputtype())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_parentType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType')))))) {
		return rt.new_null()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	mut var_suggestions := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.suggestionlist(arg_0, arg_1) }(rt.get_property(rt.get_property(var_node, 'name'), 'value'), rt.func_array_keys(rt.call_method(var_parentType, 'getFields', []rt.PhpVal{})))
	mut var_didYouMean := if rt.is_true(rt.identical(var_suggestions, rt.new_array())) { rt.new_null() } else { ' Did you mean ' + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.quotedorlist(arg_0) }(var_suggestions.dup())).str() + '?' }
	var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Field "'), rt.get_property(rt.get_property(var_node, 'name'), 'value')), rt.new_string('" is not defined by type "')), rt.get_property(var_parentType, 'name')), rt.new_string('".')), var_didYouMean), var_node.dup()))
	return rt.new_null()
	}
	mut var_node := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	this.isvalidvaluenode(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext', []string{}, var_context), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode](var_node))
	return rt.new_null()
	}
	mut var_node := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	this.isvalidvaluenode(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext', []string{}, var_context), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode](var_node))
	return rt.new_null()
	}
	mut var_node := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	this.isvalidvaluenode(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext', []string{}, var_context), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode](var_node))
	return rt.new_null()
	}
	mut var_node := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	this.isvalidvaluenode(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext', []string{}, var_context), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode](var_node))
	return rt.new_null()
	}
	mut var_node := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	this.isvalidvaluenode(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext', []string{}, var_context), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode](var_node))
	return rt.new_null()
	}
	return rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.null(), val: rt.new_closure(closure_1_fn) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.lst(), val: rt.new_closure(closure_2_fn) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.object(), val: rt.new_closure(closure_3_fn) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.object_field(), val: rt.new_closure(closure_4_fn) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.enum(), val: rt.new_closure(closure_5_fn) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.int(), val: rt.new_closure(closure_6_fn) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.float(), val: rt.new_closure(closure_7_fn) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.string(), val: rt.new_closure(closure_8_fn) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.boolean(), val: rt.new_closure(closure_9_fn) }])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValuesOfCorrectType) isvalidvaluenode(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext, mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode)  {
	mut var_locationType := var_context.getinputtype()
	if rt.is_true(rt.identical(var_locationType, rt.new_null())) {
		return rt.new_null()
	}
	mut var_type := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}; return temp.getnamedtype(arg_0) }(var_locationType.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_LeafType')))))) {
		mut var_typeStr := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(var_type.dup())
		mut var_nodeStr := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{}; return temp.doprint(arg_0) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode', []string{}, var_node))
		var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("Expected value of type \"${var_typeStr.to_string()}\", found ${var_nodeStr.to_string()}."), var_node.dup()))
		return rt.new_null()
	}
	rt.call_method(var_type, 'parseLiteral', [var_node])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_Throwable') {
		mut var_error := var_e_1.dup()
		if rt.is_true(rt.new_bool(rt.instance_of(var_error, 'Automattic_WooCommerce_Vendor_GraphQL_Error_Error'))) {
			var_context.reporterror(var_error.dup())
		} else {
			var_typeStr = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(var_type.dup())
			var_nodeStr = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{}; return temp.doprint(arg_0) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode', []string{}, var_node))
			var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Expected value of type "'), var_typeStr), rt.new_string('", found ')), var_nodeStr), rt.new_string('; ')), rt.call_method(var_error, 'getMessage', []rt.PhpVal{})), var_node.dup(), rt.new_null(), rt.new_array(), rt.new_null(), var_error.dup()))
		}
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_valuesofcorrecttype() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValuesOfCorrectType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValuesOfCorrectType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_validationrule() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule{
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

fn create_automattic_woocommerce_vendor_graphql_language_printer() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{
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

fn create_automattic_woocommerce_vendor_graphql_type_definition_type() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_visitor() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValuesOfCorrectType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getvisitor(mut dispatch_arg_0)
		}
		'isValidValueNode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode](if args.len > 1 { args[1] } else { rt.new_null() })
			this.isvalidvaluenode(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValuesOfCorrectType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValuesOfCorrectType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_validator_rules_valuesofcorrecttype_php() {
	// unsupported statement: Stmt_Declare
}
