import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValuesOfCorrectType {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValuesOfCorrectType) getvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) rt.PhpVal {
	closure_3_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_node := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_type := var_context.getinputtype()
		if rt.is_true(rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) {
			mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
			mut iife_result_1 := iife_temp_1.printsafe(var_type.clone())
			mut var_typeStr := iife_result_1
			mut iife_temp_2 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{}
			mut iife_result_2 := iife_temp_2.doprint(var_node.clone())
			mut var_nodeStr := iife_result_2
			var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("Expected value of type \"${var_typeStr.to_string()}\", found ${var_nodeStr.to_string()}."), var_node.clone()))
		}
		return rt.new_null()
		}
	closure_6_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_node := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_parentType := var_context.getparentinputtype()
		mut iife_temp_4 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		mut iife_result_4 := iife_temp_4.getnullabletype(var_parentType.clone())
		mut var_type := if rt.is_true(rt.identical(var_parentType, rt.new_null())) { rt.new_null() } else { iife_result_4 }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType')))))) {
			this.isvalidvaluenode(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext', []string{}, var_context), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode](var_node))
			mut iife_temp_5 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}
			mut iife_result_5 := iife_temp_5.skipnode()
			return iife_result_5
		}
		return rt.new_null()
		}
	closure_10_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_node := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_7 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		mut iife_result_7 := iife_temp_7.getnamedtype(var_context.getinputtype())
		mut var_type := iife_result_7
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType')))))) {
			this.isvalidvaluenode(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext', []string{}, var_context), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode](var_node))
			mut iife_temp_8 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}
			mut iife_result_8 := iife_temp_8.skipnode()
			return iife_result_8
		}
		mut var_inputFields := rt.call_method(var_type, 'getFields', []rt.PhpVal{})
		mut var_fieldNodeMap := rt.new_array()
		mut iter_1 := rt.get_property(var_node, 'fields').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			var_fieldNodeMap.array_set(rt.get_property(rt.get_property(var_field, 'name'), 'value'), var_field.clone())
		}
		mut iter_2 := var_inputFields.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_fieldDef := item_2.val
			mut var_inputFieldName := item_2.key
			if !(var_fieldNodeMap.array_isset(var_inputFieldName)) && rt.is_true(rt.call_method(var_fieldDef, 'isRequired', []rt.PhpVal{})) {
				mut iife_temp_9 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
				mut iife_result_9 := iife_temp_9.printsafe(rt.call_method(var_fieldDef, 'getType', []rt.PhpVal{}))
				mut var_fieldType := iife_result_9
				var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Field '), rt.get_property(var_type, 'name')), rt.new_string('.')), var_inputFieldName), rt.new_string(' of required type ')), var_fieldType), rt.new_string(' was not provided.')), var_node.clone()))
			}
		}
		return rt.new_null()
		}
	closure_14_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_node := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_11 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		mut iife_result_11 := iife_temp_11.getnamedtype(var_context.getparentinputtype())
		mut var_parentType := iife_result_11
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_parentType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType')))))) {
			return rt.new_null()
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_context.getinputtype(), rt.new_null())))) {
			return rt.new_null()
		}
		mut iife_temp_12 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_12 := iife_temp_12.suggestionlist(rt.get_property(rt.get_property(var_node, 'name'), 'value'), rt.func_array_keys(rt.call_method(var_parentType, 'getFields', []rt.PhpVal{})))
		mut var_suggestions := iife_result_12
		mut iife_temp_13 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_13 := iife_temp_13.quotedorlist(var_suggestions.clone())
		mut var_didYouMean := if rt.is_true(rt.identical(var_suggestions, rt.new_array())) { rt.new_null() } else { ' Did you mean ' + (iife_result_13).str() + '?' }
		var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Field "'), rt.get_property(rt.get_property(var_node, 'name'), 'value')), rt.new_string('" is not defined by type "')), rt.get_property(var_parentType, 'name')), rt.new_string('".')), var_didYouMean), var_node.clone()))
		return rt.new_null()
		}
	closure_15_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_node := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		this.isvalidvaluenode(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext', []string{}, var_context), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode](var_node))
		return rt.new_null()
		}
	closure_16_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_node := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		this.isvalidvaluenode(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext', []string{}, var_context), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode](var_node))
		return rt.new_null()
		}
	closure_17_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_node := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		this.isvalidvaluenode(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext', []string{}, var_context), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode](var_node))
		return rt.new_null()
		}
	closure_18_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_node := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		this.isvalidvaluenode(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext', []string{}, var_context), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode](var_node))
		return rt.new_null()
		}
	closure_19_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_node := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		this.isvalidvaluenode(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext', []string{}, var_context), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode](var_node))
		return rt.new_null()
		}
	return rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.null(), val: rt.new_closure(closure_3_fn) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.lst(), val: rt.new_closure(closure_6_fn) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.object(), val: rt.new_closure(closure_10_fn) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.object_field(), val: rt.new_closure(closure_14_fn) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.enum(), val: rt.new_closure(closure_15_fn) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.int(), val: rt.new_closure(closure_16_fn) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.float(), val: rt.new_closure(closure_17_fn) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.string(), val: rt.new_closure(closure_18_fn) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.boolean(), val: rt.new_closure(closure_19_fn) }])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValuesOfCorrectType) isvalidvaluenode(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext, mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode) {
	mut var_locationType := var_context.getinputtype()
	if rt.is_true(rt.identical(var_locationType, rt.new_null())) {
		return
	}
	mut iife_temp_19 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
	mut iife_result_19 := iife_temp_19.getnamedtype(var_locationType.clone())
	mut var_type := iife_result_19
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_LeafType')))))) {
		mut iife_temp_20 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_20 := iife_temp_20.printsafe(var_type.clone())
		mut var_typeStr := iife_result_20
		mut iife_temp_21 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{}
		mut iife_result_21 := iife_temp_21.doprint(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode', []string{}, var_node))
		mut var_nodeStr := iife_result_21
		var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(rt.new_string("Expected value of type \"${var_typeStr.to_string()}\", found ${var_nodeStr.to_string()}."), var_node))
		return
	}
	rt.call_method(var_type, 'parseLiteral', [var_node])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_Throwable') {
		mut var_error := var_e_1.clone()
		if rt.is_true(rt.new_bool(rt.instance_of(var_error, 'Automattic_WooCommerce_Vendor_GraphQL_Error_Error'))) {
			var_context.reporterror(var_error.clone())
		} else {
			mut iife_temp_22 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
			mut iife_result_22 := iife_temp_22.printsafe(var_type.clone())
			var_typeStr = iife_result_22
			mut iife_temp_23 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{}
			mut iife_result_23 := iife_temp_23.doprint(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ValueNode', []string{}, var_node))
			var_nodeStr = iife_result_23
			var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Expected value of type "'), var_typeStr), rt.new_string('", found ')), var_nodeStr), rt.new_string('; ')), rt.call_method(var_error, 'getMessage', []rt.PhpVal{})), var_node, rt.new_null(), rt.new_array(), rt.new_null(), var_error.clone()))
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

fn create_automattic_woocommerce_vendor_graphql_validator_rules_valuesofcorrecttype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValuesOfCorrectType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValuesOfCorrectType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_validationrule(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_printer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_type(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_visitor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor {
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



fn main() {
	defer {
		rt.shutdown()
	}

}
