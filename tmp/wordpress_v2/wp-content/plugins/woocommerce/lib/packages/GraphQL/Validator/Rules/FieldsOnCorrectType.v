import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_FieldsOnCorrectType {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_FieldsOnCorrectType) getvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) rt.PhpVal {
	closure_1_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_node := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_fieldDef := var_context.getfielddef()
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_fieldDef, rt.new_null()))))
			&& rt.is_true(rt.call_method(var_fieldDef, 'isVisible', []rt.PhpVal{})) {
			return rt.new_null()
		}
		mut var_type := var_context.getparenttype()
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_type,
			'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType'))))))
		{
			return rt.new_null()
		}
		mut var_schema := var_context.getschema()
		mut var_fieldName := rt.get_property(rt.get_property(var_node, 'name'), 'value')
		mut var_suggestedTypeNames := this.getsuggestedtypenames(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](var_schema), mut
			rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_type),
			var_fieldName.str())
		mut var_suggestedFieldNames := if rt.is_true(rt.identical(var_suggestedTypeNames,
			rt.new_array()))
		{
			this.getsuggestedfieldnames(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_type),
				var_fieldName.str())
		} else {
			rt.new_array()
		}
		var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_FieldsOnCorrectType.undefinedfieldmessage((rt.get_property(rt.get_property(var_node,
			'name'), 'value')).str(), (rt.get_property(var_type, 'name')).str(), mut
			rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](var_suggestedTypeNames), mut
			rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](var_suggestedFieldNames)), rt.create_array([
			rt.ArrayItem{ key: none, val: var_node },
		])))
		return rt.new_null()
	}
	return rt.create_array([
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.field()
			val: rt.new_closure(closure_1_fn)
		},
	])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_FieldsOnCorrectType) getsuggestedtypenames(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, fieldName string) rt.PhpVal {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
	mut iife_result_1 := iife_temp_1.isabstracttype(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
		[]string{}, var_type))
	if rt.is_true(iife_result_1) {
		mut var_suggestedObjectTypes := rt.new_array()
		mut var_interfaceUsageCount := rt.new_array()
		mut iter_1 := var_schema.getpossibletypes(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
			[]string{}, var_type)).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_possibleType := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_possibleType, 'hasField', [
				rt.new_string(fieldName),
			])))))
			{
				continue
			}
			var_suggestedObjectTypes.array_push(rt.get_property(var_possibleType, 'name'))
			mut iter_2 :=
				rt.call_method(var_possibleType, 'getInterfaces', []rt.PhpVal{}).iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_possibleInterface := item_2.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_possibleInterface,
					'hasField', [rt.new_string(fieldName)])))))
				{
					continue
				}
				var_interfaceUsageCount.array_set(rt.get_property(var_possibleInterface, 'name'), if var_interfaceUsageCount.array_isset(rt.get_property(var_possibleInterface,
					'name'))
				{
					rt.add(var_interfaceUsageCount.array_get(rt.get_property(var_possibleInterface,
						'name')), rt.new_int(1))
				} else {
					rt.new_int(0)
				})
			}
		}
		rt.call_function('arsort', [var_interfaceUsageCount.clone()])
		mut var_suggestedInterfaceTypes := rt.func_array_keys(var_interfaceUsageCount.clone())
		return rt.call_function('array_merge', [var_suggestedInterfaceTypes.clone(),
			var_suggestedObjectTypes.clone()])
	}
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_FieldsOnCorrectType) getsuggestedfieldnames(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, fieldName string) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
		[]string{}, var_type),
		'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_HasFieldsType')))
	{
		mut iife_temp_2 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_2 := iife_temp_2.suggestionlist(rt.new_string(fieldName),
			var_type.getfieldnames())
		return iife_result_2
	}
	return rt.new_array()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_FieldsOnCorrectType.undefinedfieldmessage(fieldName string, type string, mut var_suggestedTypeNames Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array, mut var_suggestedFieldNames Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array) string {
	mut var_message :=
		rt.new_string("Cannot query field \"${var_fieldName}\" on type \"${var_type}\".")
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_suggestedTypeNames, rt.new_array())))) {
		mut iife_temp_3 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_3 := iife_temp_3.quotedorlist(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array',
			[]string{}, var_suggestedTypeNames))
		mut var_suggestions := iife_result_3
		var_message = rt.concat(var_message,
			rt.new_string(' Did you mean to use an inline fragment on ${var_suggestions.to_string()}?'))
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_suggestedFieldNames,
		rt.new_array()))))
	{
		mut iife_temp_4 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_4 := iife_temp_4.quotedorlist(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array',
			[]string{}, var_suggestedFieldNames))
		var_suggestions = iife_result_4
		var_message = rt.concat(var_message,
			rt.new_string(' Did you mean ${var_suggestions.to_string()}?'))
	}
	return var_message.str()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_fieldsoncorrecttype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_FieldsOnCorrectType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_FieldsOnCorrectType{
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

fn create_automattic_woocommerce_vendor_graphql_utils_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_FieldsOnCorrectType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.getvisitor(mut dispatch_arg_0)
		}
		'getSuggestedTypeNames' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.getsuggestedtypenames(mut dispatch_arg_0, mut dispatch_arg_1,
				dispatch_arg_2)
		}
		'getSuggestedFieldNames' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.getsuggestedfieldnames(mut dispatch_arg_0, dispatch_arg_1)
		}
		'undefinedFieldMessage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](if args.len > 3 {
				args[3]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_FieldsOnCorrectType.undefinedfieldmessage(dispatch_arg_0,
				dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_FieldsOnCorrectType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_FieldsOnCorrectType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
