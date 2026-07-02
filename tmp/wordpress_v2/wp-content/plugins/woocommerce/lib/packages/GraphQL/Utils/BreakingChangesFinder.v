import rt

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_field_changed_kind() string {
	return 'FIELD_CHANGED_KIND'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_field_removed() string {
	return 'FIELD_REMOVED'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_type_changed_kind() string {
	return 'TYPE_CHANGED_KIND'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_type_removed() string {
	return 'TYPE_REMOVED'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_type_removed_from_union() string {
	return 'TYPE_REMOVED_FROM_UNION'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_value_removed_from_enum() string {
	return 'VALUE_REMOVED_FROM_ENUM'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_arg_removed() string {
	return 'ARG_REMOVED'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_arg_changed_kind() string {
	return 'ARG_CHANGED_KIND'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_required_arg_added() string {
	return 'REQUIRED_ARG_ADDED'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_required_input_field_added() string {
	return 'REQUIRED_INPUT_FIELD_ADDED'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_implemented_interface_removed() string {
	return 'IMPLEMENTED_INTERFACE_REMOVED'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_directive_removed() string {
	return 'DIRECTIVE_REMOVED'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_directive_arg_removed() string {
	return 'DIRECTIVE_ARG_REMOVED'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_directive_location_removed() string {
	return 'DIRECTIVE_LOCATION_REMOVED'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_required_directive_arg_added() string {
	return 'REQUIRED_DIRECTIVE_ARG_ADDED'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.dangerous_change_arg_default_value_changed() string {
	return 'ARG_DEFAULT_VALUE_CHANGE'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.dangerous_change_value_added_to_enum() string {
	return 'VALUE_ADDED_TO_ENUM'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.dangerous_change_implemented_interface_added() string {
	return 'IMPLEMENTED_INTERFACE_ADDED'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.dangerous_change_type_added_to_union() string {
	return 'TYPE_ADDED_TO_UNION'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.dangerous_change_optional_input_field_added() string {
	return 'OPTIONAL_INPUT_FIELD_ADDED'
}
pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.dangerous_change_optional_arg_added() string {
	return 'OPTIONAL_ARG_ADDED'
}
struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findbreakingchanges(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
	return rt.call_function('array_merge', [Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremovedtypes(mut var_oldSchema, mut var_newSchema), Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findtypesthatchangedkind(mut var_oldSchema, mut var_newSchema), Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findfieldsthatchangedtypeonobjectorinterfacetypes(mut var_oldSchema, mut var_newSchema), Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findfieldsthatchangedtypeoninputobjecttypes(mut var_oldSchema, mut var_newSchema).array_get(rt.new_string('breakingChanges')), Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findtypesremovedfromunions(mut var_oldSchema, mut var_newSchema), Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findvaluesremovedfromenums(mut var_oldSchema, mut var_newSchema), Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findargchanges(mut var_oldSchema, mut var_newSchema).array_get(rt.new_string('breakingChanges')), Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findinterfacesremovedfromobjecttypes(mut var_oldSchema, mut var_newSchema), Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremoveddirectives(mut var_oldSchema, mut var_newSchema), Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremoveddirectiveargs(mut var_oldSchema, mut var_newSchema), Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findaddednonnulldirectiveargs(mut var_oldSchema, mut var_newSchema), Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremoveddirectivelocations(mut var_oldSchema, mut var_newSchema)])
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremovedtypes(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
	mut var_oldTypeMap := var_oldSchema.gettypemap()
	mut var_newTypeMap := var_newSchema.gettypemap()
	mut var_breakingChanges := rt.new_array()
	mut iter_1 := rt.func_array_keys(var_oldTypeMap.clone()).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_typeName := item_1.val
		if !(var_newTypeMap.array_isset(var_typeName)) {
			var_breakingChanges.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_type_removed() }, rt.ArrayItem{ key: 'description', val: "${var_typeName.to_string()} was removed." }]))
		}
	}
	return var_breakingChanges.clone()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findtypesthatchangedkind(mut var_schemaA Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_schemaB Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
	mut var_schemaATypeMap := var_schemaA.gettypemap()
	mut var_schemaBTypeMap := var_schemaB.gettypemap()
	mut var_breakingChanges := rt.new_array()
	mut iter_2 := var_schemaATypeMap.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_schemaAType := item_2.val
		mut var_typeName := item_2.key
		if !(var_schemaBTypeMap.array_isset(var_typeName)) {
			continue
		}
		mut var_schemaBType := var_schemaBTypeMap.array_get(var_typeName)
		if rt.is_true(rt.new_bool(rt.instance_of(var_schemaAType, 'Automattic_WooCommerce_Vendor_GraphQL_Utils_{"nodeType":"Expr_Variable","line":134,"name":"schemaBType"}'))) {
			continue
		}
		if rt.is_true(rt.new_bool(rt.instance_of(var_schemaBType, 'Automattic_WooCommerce_Vendor_GraphQL_Utils_{"nodeType":"Expr_Variable","line":138,"name":"schemaAType"}'))) {
			continue
		}
		mut var_schemaATypeKindName := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.typekindname(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType](var_schemaAType))
		mut var_schemaBTypeKindName := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.typekindname(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType](var_schemaBType))
		var_breakingChanges.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_type_changed_kind() }, rt.ArrayItem{ key: 'description', val: "${var_typeName.to_string()} changed from ${var_schemaATypeKindName.to_string()} to ${var_schemaBTypeKindName.to_string()}." }]))
	}
	return var_breakingChanges.clone()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.typekindname(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType) string {
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType', []string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType'))) {
		return 'a Scalar type'
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType', []string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType'))) {
		return 'an Object type'
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType', []string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType'))) {
		return 'an Interface type'
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType', []string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType'))) {
		return 'a Union type'
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType', []string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType'))) {
		return 'an Enum type'
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType', []string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType'))) {
		return 'an Input type'
	}
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeError', []string{}, create_automattic_woocommerce_vendor_graphql_utils_typeerror('Unknown type: ' + (rt.get_property(var_type, 'name')).str())))
	return ''
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findfieldsthatchangedtypeonobjectorinterfacetypes(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
	mut var_oldTypeMap := var_oldSchema.gettypemap()
	mut var_newTypeMap := var_newSchema.gettypemap()
	mut var_breakingChanges := rt.new_array()
	mut iter_3 := var_oldTypeMap.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_oldType := item_3.val
		mut var_typeName := item_3.key
		mut var_newType := if !(var_newTypeMap.array_get(var_typeName)).is_null() { var_newTypeMap.array_get(var_typeName) } else { rt.new_null() }
		if ((rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_oldType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType')))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_oldType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType'))))))) || (rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_newType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType')))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_newType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType')))))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_newType, 'Automattic_WooCommerce_Vendor_GraphQL_Utils_{"nodeType":"Expr_Variable","line":205,"name":"oldType"}')))))) {
			continue
		}
		mut var_oldTypeFieldsDef := rt.call_method(var_oldType, 'getFields', []rt.PhpVal{})
		mut var_newTypeFieldsDef := rt.call_method(var_newType, 'getFields', []rt.PhpVal{})
		mut iter_4 := var_oldTypeFieldsDef.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_fieldDefinition := item_4.val
			mut var_fieldName := item_4.key
			if !(var_newTypeFieldsDef.array_isset(var_fieldName)) {
				var_breakingChanges.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_field_removed() }, rt.ArrayItem{ key: 'description', val: "${var_typeName.to_string()}.${var_fieldName.to_string()} was removed." }]))
			} else {
				mut var_oldFieldType := rt.call_method(var_oldTypeFieldsDef.array_get(var_fieldName), 'getType', []rt.PhpVal{})
				mut var_newFieldType := rt.call_method(var_newTypeFieldsDef.array_get(var_fieldName), 'getType', []rt.PhpVal{})
				mut var_isSafe := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.ischangesafeforobjectorinterfacefield(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_oldFieldType), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_newFieldType))
				if rt.is_true(rt.new_bool(!(rt.is_true(var_isSafe)))) {
					var_breakingChanges.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_field_changed_kind() }, rt.ArrayItem{ key: 'description', val: "${var_typeName.to_string()}.${var_fieldName.to_string()} changed type from ${var_oldFieldType.to_string()} to ${var_newFieldType.to_string()}." }]))
				}
			}
		}
	}
	return var_breakingChanges.clone()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.ischangesafeforobjectorinterfacefield(mut var_oldType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, mut var_newType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) bool {
	mut var_oldType_mutated := var_oldType
	mut var_newType_mutated := var_newType
	if rt.is_true(rt.new_bool(rt.instance_of(var_oldType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType'))) {
		return rt.is_true(rt.new_bool(rt.instance_of(var_newType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType'))) && rt.is_true(rt.identical(rt.get_property(var_oldType_mutated, 'name'), rt.get_property(var_newType_mutated, 'name'))) || rt.is_true(rt.new_bool(rt.instance_of(var_newType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) && rt.is_true(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.ischangesafeforobjectorinterfacefield(mut var_oldType_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_newType_mutated, 'getWrappedType', []rt.PhpVal{}))))
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_oldType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType'))) {
		return rt.is_true(rt.new_bool(rt.instance_of(var_newType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType'))) && rt.is_true(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.ischangesafeforobjectorinterfacefield(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_oldType_mutated, 'getWrappedType', []rt.PhpVal{})), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_newType_mutated, 'getWrappedType', []rt.PhpVal{})))) || rt.is_true(rt.new_bool(rt.instance_of(var_newType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) && rt.is_true(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.ischangesafeforobjectorinterfacefield(mut var_oldType_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_newType_mutated, 'getWrappedType', []rt.PhpVal{}))))
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_oldType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) {
		return rt.is_true(rt.new_bool(rt.instance_of(var_newType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) && rt.is_true(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.ischangesafeforobjectorinterfacefield(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_oldType_mutated, 'getWrappedType', []rt.PhpVal{})), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_newType_mutated, 'getWrappedType', []rt.PhpVal{}))))
	}
	return false
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findfieldsthatchangedtypeoninputobjecttypes(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
	mut var_oldTypeMap := var_oldSchema.gettypemap()
	mut var_newTypeMap := var_newSchema.gettypemap()
	mut var_breakingChanges := rt.new_array()
	mut var_dangerousChanges := rt.new_array()
	mut iter_5 := var_oldTypeMap.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_oldType := item_5.val
		mut var_typeName := item_5.key
		mut var_newType := if !(var_newTypeMap.array_get(var_typeName)).is_null() { var_newTypeMap.array_get(var_typeName) } else { rt.new_null() }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_oldType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType')))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_newType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType')))))) {
			continue
		}
		mut var_oldTypeFieldsDef := rt.call_method(var_oldType, 'getFields', []rt.PhpVal{})
		mut var_newTypeFieldsDef := rt.call_method(var_newType, 'getFields', []rt.PhpVal{})
		mut iter_6 := rt.func_array_keys(var_oldTypeFieldsDef.clone()).iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_fieldName := item_6.val
			if !(var_newTypeFieldsDef.array_isset(var_fieldName)) {
				var_breakingChanges.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_field_removed() }, rt.ArrayItem{ key: 'description', val: "${var_typeName.to_string()}.${var_fieldName.to_string()} was removed." }]))
			} else {
				mut var_oldFieldType := rt.call_method(var_oldTypeFieldsDef.array_get(var_fieldName), 'getType', []rt.PhpVal{})
				mut var_newFieldType := rt.call_method(var_newTypeFieldsDef.array_get(var_fieldName), 'getType', []rt.PhpVal{})
				mut var_isSafe := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.ischangesafeforinputobjectfieldorfieldarg(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_oldFieldType), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_newFieldType))
				if rt.is_true(rt.new_bool(!(rt.is_true(var_isSafe)))) {
					mut var_oldFieldTypeString := if rt.is_true(rt.new_bool(rt.instance_of(var_oldFieldType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType'))) { rt.get_property(var_oldFieldType, 'name') } else { var_oldFieldType }
					mut var_newFieldTypeString := if rt.is_true(rt.new_bool(rt.instance_of(var_newFieldType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType'))) { rt.get_property(var_newFieldType, 'name') } else { var_newFieldType }
					var_breakingChanges.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_field_changed_kind() }, rt.ArrayItem{ key: 'description', val: "${var_typeName.to_string()}.${var_fieldName.to_string()} changed type from ${var_oldFieldTypeString.to_string()} to ${var_newFieldTypeString.to_string()}." }]))
				}
			}
		}
		mut iter_7 := var_newTypeFieldsDef.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_fieldDef := item_7.val
			mut var_fieldName := item_7.key
			if var_oldTypeFieldsDef.array_isset(var_fieldName) {
				continue
			}
			mut var_newTypeName := rt.get_property(var_newType, 'name')
			if rt.is_true(rt.call_method(var_fieldDef, 'isRequired', []rt.PhpVal{})) {
				var_breakingChanges.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_required_input_field_added() }, rt.ArrayItem{ key: 'description', val: "A required field ${var_fieldName.to_string()} on input type ${var_newTypeName.to_string()} was added." }]))
			} else {
				var_dangerousChanges.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.dangerous_change_optional_input_field_added() }, rt.ArrayItem{ key: 'description', val: "An optional field ${var_fieldName.to_string()} on input type ${var_newTypeName.to_string()} was added." }]))
			}
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'breakingChanges', val: var_breakingChanges }, rt.ArrayItem{ key: 'dangerousChanges', val: var_dangerousChanges }])
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.ischangesafeforinputobjectfieldorfieldarg(mut var_oldType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, mut var_newType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) bool {
	mut var_oldType_mutated := var_oldType
	mut var_newType_mutated := var_newType
	if rt.is_true(rt.new_bool(rt.instance_of(var_oldType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_newType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType')))))) {
			return false
		}
		return (rt.identical(rt.get_property(var_oldType_mutated, 'name'), rt.get_property(var_newType_mutated, 'name'))).to_bool()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_oldType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType'))) {
		return rt.is_true(rt.new_bool(rt.instance_of(var_newType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType'))) && rt.is_true(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.ischangesafeforinputobjectfieldorfieldarg(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_oldType_mutated, 'getWrappedType', []rt.PhpVal{})), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_newType_mutated, 'getWrappedType', []rt.PhpVal{}))))
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_oldType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) {
		return rt.is_true(rt.new_bool(rt.instance_of(var_newType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) && rt.is_true(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.ischangesafeforinputobjectfieldorfieldarg(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_oldType_mutated, 'getWrappedType', []rt.PhpVal{})), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_newType_mutated, 'getWrappedType', []rt.PhpVal{})))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_newType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull')))))) && rt.is_true(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.ischangesafeforinputobjectfieldorfieldarg(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_oldType_mutated, 'getWrappedType', []rt.PhpVal{})), mut var_newType_mutated))
	}
	return false
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findtypesremovedfromunions(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
	mut var_oldTypeMap := var_oldSchema.gettypemap()
	mut var_newTypeMap := var_newSchema.gettypemap()
	mut var_typesRemovedFromUnion := rt.new_array()
	mut iter_8 := var_oldTypeMap.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_oldType := item_8.val
		mut var_typeName := item_8.key
		mut var_newType := if !(var_newTypeMap.array_get(var_typeName)).is_null() { var_newTypeMap.array_get(var_typeName) } else { rt.new_null() }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_oldType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType')))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_newType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType')))))) {
			continue
		}
		mut var_typeNamesInNewUnion := rt.new_array()
		mut iter_9 := rt.call_method(var_newType, 'getTypes', []rt.PhpVal{}).iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_type := item_9.val
			var_typeNamesInNewUnion.array_set(rt.get_property(var_type, 'name'), true)
		}
		mut iter_10 := rt.call_method(var_oldType, 'getTypes', []rt.PhpVal{}).iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_type := item_10.val
			if !(var_typeNamesInNewUnion.array_isset(rt.get_property(var_type, 'name'))) {
				var_typesRemovedFromUnion.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_type_removed_from_union() }, rt.ArrayItem{ key: 'description', val: rt.concat(rt.concat(rt.concat(rt.get_property(var_type, 'name'), rt.new_string(' was removed from union type ')), var_typeName), rt.new_string('.')) }]))
			}
		}
	}
	return var_typesRemovedFromUnion.clone()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findvaluesremovedfromenums(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
	mut var_oldTypeMap := var_oldSchema.gettypemap()
	mut var_newTypeMap := var_newSchema.gettypemap()
	mut var_valuesRemovedFromEnums := rt.new_array()
	mut iter_11 := var_oldTypeMap.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_oldType := item_11.val
		mut var_typeName := item_11.key
		mut var_newType := if !(var_newTypeMap.array_get(var_typeName)).is_null() { var_newTypeMap.array_get(var_typeName) } else { rt.new_null() }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_oldType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType')))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_newType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType')))))) {
			continue
		}
		mut var_valuesInNewEnum := rt.new_array()
		mut iter_12 := rt.call_method(var_newType, 'getValues', []rt.PhpVal{}).iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_value := item_12.val
			var_valuesInNewEnum.array_set(rt.get_property(var_value, 'name'), true)
		}
		mut iter_13 := rt.call_method(var_oldType, 'getValues', []rt.PhpVal{}).iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_value := item_13.val
			if !(var_valuesInNewEnum.array_isset(rt.get_property(var_value, 'name'))) {
				var_valuesRemovedFromEnums.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_value_removed_from_enum() }, rt.ArrayItem{ key: 'description', val: rt.concat(rt.concat(rt.concat(rt.get_property(var_value, 'name'), rt.new_string(' was removed from enum type ')), var_typeName), rt.new_string('.')) }]))
			}
		}
	}
	return var_valuesRemovedFromEnums.clone()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findargchanges(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
	mut var_oldTypeMap := var_oldSchema.gettypemap()
	mut var_newTypeMap := var_newSchema.gettypemap()
	mut var_breakingChanges := rt.new_array()
	mut var_dangerousChanges := rt.new_array()
	mut iter_14 := var_oldTypeMap.iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_oldType := item_14.val
		mut var_typeName := item_14.key
		mut var_newType := if !(var_newTypeMap.array_get(var_typeName)).is_null() { var_newTypeMap.array_get(var_typeName) } else { rt.new_null() }
		if ((rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_oldType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType')))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_oldType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType'))))))) || (rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_newType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType')))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_newType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType')))))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_newType, 'Automattic_WooCommerce_Vendor_GraphQL_Utils_{"nodeType":"Expr_Variable","line":492,"name":"oldType"}')))))) {
			continue
		}
		mut var_oldTypeFields := rt.call_method(var_oldType, 'getFields', []rt.PhpVal{})
		mut var_newTypeFields := rt.call_method(var_newType, 'getFields', []rt.PhpVal{})
		mut iter_15 := var_oldTypeFields.iterator()
		for {
			item_15 := iter_15.next() or { break }
			mut var_oldField := item_15.val
			mut var_fieldName := item_15.key
			if !(var_newTypeFields.array_isset(var_fieldName)) {
				continue
			}
			mut iter_16 := rt.get_property(var_oldField, 'args').iterator()
			for {
				item_16 := iter_16.next() or { break }
				mut var_oldArgDef := item_16.val
				mut var_newArgDef := rt.new_null()
				mut iter_17 := rt.get_property(var_newTypeFields.array_get(var_fieldName), 'args').iterator()
				for {
					item_17 := iter_17.next() or { break }
					mut var_newArg := item_17.val
					if rt.is_true(rt.identical(rt.get_property(var_newArg, 'name'), rt.get_property(var_oldArgDef, 'name'))) {
					var_newArgDef = var_newArg
					}
				}
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_newArgDef, rt.new_null())))) {
					mut var_isSafe := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.ischangesafeforinputobjectfieldorfieldarg(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_oldArgDef, 'getType', []rt.PhpVal{})), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_newArgDef, 'getType', []rt.PhpVal{})))
					mut var_oldArgType := rt.call_method(var_oldArgDef, 'getType', []rt.PhpVal{})
					mut var_oldArgName := rt.get_property(var_oldArgDef, 'name')
					if rt.is_true(rt.new_bool(!(rt.is_true(var_isSafe)))) {
						mut var_newArgType := rt.call_method(var_newArgDef, 'getType', []rt.PhpVal{})
						var_breakingChanges.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_arg_changed_kind() }, rt.ArrayItem{ key: 'description', val: "${var_typeName.to_string()}.${var_fieldName.to_string()} arg ${var_oldArgName.to_string()} has changed type from ${var_oldArgType.to_string()} to ${var_newArgType.to_string()}" }]))
					} else if rt.is_true(rt.call_method(var_oldArgDef, 'defaultValueExists', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_oldArgDef, 'defaultValue'), rt.get_property(var_newArgDef, 'defaultValue'))))) {
						var_dangerousChanges.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.dangerous_change_arg_default_value_changed() }, rt.ArrayItem{ key: 'description', val: "${var_typeName.to_string()}.${var_fieldName.to_string()} arg ${var_oldArgName.to_string()} has changed defaultValue" }]))
					}
				} else {
					var_breakingChanges.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_arg_removed() }, rt.ArrayItem{ key: 'description', val: rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(var_typeName, rt.new_string('.')), var_fieldName), rt.new_string(' arg ')), rt.get_property(var_oldArgDef, 'name')), rt.new_string(' was removed')) }]))
				}
				mut iter_18 := rt.get_property(var_newTypeFields.array_get(var_fieldName), 'args').iterator()
				for {
					item_18 := iter_18.next() or { break }
					mut var_newTypeFieldArgDef := item_18.val
					var_oldArgDef = rt.new_null()
					mut iter_19 := rt.get_property(var_oldTypeFields.array_get(var_fieldName), 'args').iterator()
					for {
						item_19 := iter_19.next() or { break }
						mut var_oldArg := item_19.val
						if rt.is_true(rt.identical(rt.get_property(var_oldArg, 'name'), rt.get_property(var_newTypeFieldArgDef, 'name'))) {
						var_oldArgDef = var_oldArg
						}
					}
					if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_oldArgDef, rt.new_null())))) {
						continue
					}
					mut var_newTypeName := rt.get_property(var_newType, 'name')
					mut var_newArgName := rt.get_property(var_newTypeFieldArgDef, 'name')
					if rt.is_true(rt.call_method(var_newTypeFieldArgDef, 'isRequired', []rt.PhpVal{})) {
						var_breakingChanges.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_required_arg_added() }, rt.ArrayItem{ key: 'description', val: "A required arg ${var_newArgName.to_string()} on ${var_newTypeName.to_string()}.${var_fieldName.to_string()} was added" }]))
					} else {
						var_dangerousChanges.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.dangerous_change_optional_arg_added() }, rt.ArrayItem{ key: 'description', val: "An optional arg ${var_newArgName.to_string()} on ${var_newTypeName.to_string()}.${var_fieldName.to_string()} was added" }]))
					}
				}
			}
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'breakingChanges', val: var_breakingChanges }, rt.ArrayItem{ key: 'dangerousChanges', val: var_dangerousChanges }])
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findinterfacesremovedfromobjecttypes(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
	mut var_oldTypeMap := var_oldSchema.gettypemap()
	mut var_newTypeMap := var_newSchema.gettypemap()
	mut var_breakingChanges := rt.new_array()
	mut iter_20 := var_oldTypeMap.iterator()
	for {
		item_20 := iter_20.next() or { break }
		mut var_oldType := item_20.val
		mut var_typeName := item_20.key
		mut var_newType := if !(var_newTypeMap.array_get(var_typeName)).is_null() { var_newTypeMap.array_get(var_typeName) } else { rt.new_null() }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_oldType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType')))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_newType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType')))))) {
			continue
		}
		mut var_oldInterfaces := rt.call_method(var_oldType, 'getInterfaces', []rt.PhpVal{})
		mut var_newInterfaces := rt.call_method(var_newType, 'getInterfaces', []rt.PhpVal{})
		mut iter_21 := var_oldInterfaces.iterator()
		for {
			item_21 := iter_21.next() or { break }
			mut var_oldInterface := item_21.val
			mut var_interfaceWasRemoved := rt.new_bool(true)
			mut iter_22 := var_newInterfaces.iterator()
			for {
				item_22 := iter_22.next() or { break }
				mut var_newInterface := item_22.val
				if rt.is_true(rt.identical(rt.get_property(var_oldInterface, 'name'), rt.get_property(var_newInterface, 'name'))) {
				var_interfaceWasRemoved = rt.new_bool(false)
				}
			}
			if rt.is_true(var_interfaceWasRemoved) {
				var_breakingChanges.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_implemented_interface_removed() }, rt.ArrayItem{ key: 'description', val: rt.concat(rt.concat(rt.concat(var_typeName, rt.new_string(' no longer implements interface ')), rt.get_property(var_oldInterface, 'name')), rt.new_string('.')) }]))
			}
		}
	}
	return var_breakingChanges.clone()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremoveddirectives(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
	mut var_removedDirectives := rt.new_array()
	mut var_newSchemaDirectiveMap := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.getdirectivemapforschema(mut var_newSchema)
	mut iter_23 := var_oldSchema.getdirectives().iterator()
	for {
		item_23 := iter_23.next() or { break }
		mut var_directive := item_23.val
		if !(var_newSchemaDirectiveMap.array_isset(rt.get_property(var_directive, 'name'))) {
			var_removedDirectives.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_directive_removed() }, rt.ArrayItem{ key: 'description', val: rt.concat(rt.get_property(var_directive, 'name'), rt.new_string(' was removed')) }]))
		}
	}
	return var_removedDirectives.clone()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.getdirectivemapforschema(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
	mut var_directives := rt.new_array()
	mut iter_24 := var_schema.getdirectives().iterator()
	for {
		item_24 := iter_24.next() or { break }
		mut var_directive := item_24.val
		var_directives.array_set(rt.get_property(var_directive, 'name'), var_directive.clone())
	}
	return var_directives.clone()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremoveddirectiveargs(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
	mut var_removedDirectiveArgs := rt.new_array()
	mut var_oldSchemaDirectiveMap := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.getdirectivemapforschema(mut var_oldSchema)
	mut iter_25 := var_newSchema.getdirectives().iterator()
	for {
		item_25 := iter_25.next() or { break }
		mut var_newDirective := item_25.val
		if !(var_oldSchemaDirectiveMap.array_isset(rt.get_property(var_newDirective, 'name'))) {
			continue
		}
		mut iter_26 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremovedargsfordirectives(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive](var_oldSchemaDirectiveMap.array_get(rt.get_property(var_newDirective, 'name'))), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive](var_newDirective)).iterator()
		for {
			item_26 := iter_26.next() or { break }
			mut var_arg := item_26.val
			var_removedDirectiveArgs.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_directive_arg_removed() }, rt.ArrayItem{ key: 'description', val: rt.concat(rt.concat(rt.get_property(var_arg, 'name'), rt.new_string(' was removed from ')), rt.get_property(var_newDirective, 'name')) }]))
		}
	}
	return var_removedDirectiveArgs.clone()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremovedargsfordirectives(mut var_oldDirective Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive, mut var_newDirective Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) rt.PhpVal {
	mut var_removedArgs := rt.new_array()
	mut var_newArgMap := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.getargumentmapfordirective(mut var_newDirective)
	mut iter_27 := rt.get_property(var_oldDirective, 'args').iterator()
	for {
		item_27 := iter_27.next() or { break }
		mut var_arg := item_27.val
		if !(var_newArgMap.array_isset(rt.get_property(var_arg, 'name'))) {
			var_removedArgs.array_push(var_arg.clone())
		}
	}
	return var_removedArgs.clone()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.getargumentmapfordirective(mut var_directive Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) rt.PhpVal {
	mut var_args := rt.new_array()
	mut iter_28 := rt.get_property(var_directive, 'args').iterator()
	for {
		item_28 := iter_28.next() or { break }
		mut var_arg := item_28.val
		var_args.array_set(rt.get_property(var_arg, 'name'), var_arg.clone())
	}
	return var_args.clone()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findaddednonnulldirectiveargs(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
	mut var_addedNonNullableArgs := rt.new_array()
	mut var_oldSchemaDirectiveMap := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.getdirectivemapforschema(mut var_oldSchema)
	mut iter_29 := var_newSchema.getdirectives().iterator()
	for {
		item_29 := iter_29.next() or { break }
		mut var_newDirective := item_29.val
		if !(var_oldSchemaDirectiveMap.array_isset(rt.get_property(var_newDirective, 'name'))) {
			continue
		}
		mut iter_30 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findaddedargsfordirective(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive](var_oldSchemaDirectiveMap.array_get(rt.get_property(var_newDirective, 'name'))), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive](var_newDirective)).iterator()
		for {
			item_30 := iter_30.next() or { break }
			mut var_arg := item_30.val
			if rt.is_true(rt.call_method(var_arg, 'isRequired', []rt.PhpVal{})) {
				var_addedNonNullableArgs.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_required_directive_arg_added() }, rt.ArrayItem{ key: 'description', val: rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('A required arg '), rt.get_property(var_arg, 'name')), rt.new_string(' on directive ')), rt.get_property(var_newDirective, 'name')), rt.new_string(' was added')) }]))
			}
		}
	}
	return var_addedNonNullableArgs.clone()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findaddedargsfordirective(mut var_oldDirective Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive, mut var_newDirective Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) rt.PhpVal {
	mut var_addedArgs := rt.new_array()
	mut var_oldArgMap := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.getargumentmapfordirective(mut var_oldDirective)
	mut iter_31 := rt.get_property(var_newDirective, 'args').iterator()
	for {
		item_31 := iter_31.next() or { break }
		mut var_arg := item_31.val
		if !(var_oldArgMap.array_isset(rt.get_property(var_arg, 'name'))) {
			var_addedArgs.array_push(var_arg.clone())
		}
	}
	return var_addedArgs.clone()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremoveddirectivelocations(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
	mut var_removedLocations := rt.new_array()
	mut var_oldSchemaDirectiveMap := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.getdirectivemapforschema(mut var_oldSchema)
	mut iter_32 := var_newSchema.getdirectives().iterator()
	for {
		item_32 := iter_32.next() or { break }
		mut var_newDirective := item_32.val
		if !(var_oldSchemaDirectiveMap.array_isset(rt.get_property(var_newDirective, 'name'))) {
			continue
		}
		mut iter_33 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremovedlocationsfordirective(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive](var_oldSchemaDirectiveMap.array_get(rt.get_property(var_newDirective, 'name'))), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive](var_newDirective)).iterator()
		for {
			item_33 := iter_33.next() or { break }
			mut var_location := item_33.val
			var_removedLocations.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_directive_location_removed() }, rt.ArrayItem{ key: 'description', val: rt.concat(rt.concat(var_location, rt.new_string(' was removed from ')), rt.get_property(var_newDirective, 'name')) }]))
		}
	}
	return var_removedLocations.clone()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremovedlocationsfordirective(mut var_oldDirective Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive, mut var_newDirective Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) rt.PhpVal {
	mut var_removedLocations := rt.new_array()
	mut var_newLocationSet := rt.call_function('array_flip', [rt.get_property(var_newDirective, 'locations')])
	mut iter_34 := rt.get_property(var_oldDirective, 'locations').iterator()
	for {
		item_34 := iter_34.next() or { break }
		mut var_oldLocation := item_34.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_newLocationSet.clone().array_isset(var_oldLocation.clone())))))) {
			var_removedLocations.array_push(var_oldLocation.clone())
		}
	}
	return var_removedLocations.clone()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.finddangerouschanges(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
	return rt.call_function('array_merge', [Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findargchanges(mut var_oldSchema, mut var_newSchema).array_get(rt.new_string('dangerousChanges')), Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findvaluesaddedtoenums(mut var_oldSchema, mut var_newSchema), Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findinterfacesaddedtoobjecttypes(mut var_oldSchema, mut var_newSchema), Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findtypesaddedtounions(mut var_oldSchema, mut var_newSchema), Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findfieldsthatchangedtypeoninputobjecttypes(mut var_oldSchema, mut var_newSchema).array_get(rt.new_string('dangerousChanges'))])
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findvaluesaddedtoenums(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
	mut var_oldTypeMap := var_oldSchema.gettypemap()
	mut var_newTypeMap := var_newSchema.gettypemap()
	mut var_valuesAddedToEnums := rt.new_array()
	mut iter_35 := var_oldTypeMap.iterator()
	for {
		item_35 := iter_35.next() or { break }
		mut var_oldType := item_35.val
		mut var_typeName := item_35.key
		mut var_newType := if !(var_newTypeMap.array_get(var_typeName)).is_null() { var_newTypeMap.array_get(var_typeName) } else { rt.new_null() }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_oldType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType')))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_newType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType')))))) {
			continue
		}
		mut var_valuesInOldEnum := rt.new_array()
		mut iter_36 := rt.call_method(var_oldType, 'getValues', []rt.PhpVal{}).iterator()
		for {
			item_36 := iter_36.next() or { break }
			mut var_value := item_36.val
			var_valuesInOldEnum.array_set(rt.get_property(var_value, 'name'), true)
		}
		mut iter_37 := rt.call_method(var_newType, 'getValues', []rt.PhpVal{}).iterator()
		for {
			item_37 := iter_37.next() or { break }
			mut var_value := item_37.val
			if !(var_valuesInOldEnum.array_isset(rt.get_property(var_value, 'name'))) {
				var_valuesAddedToEnums.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.dangerous_change_value_added_to_enum() }, rt.ArrayItem{ key: 'description', val: rt.concat(rt.concat(rt.concat(rt.get_property(var_value, 'name'), rt.new_string(' was added to enum type ')), var_typeName), rt.new_string('.')) }]))
			}
		}
	}
	return var_valuesAddedToEnums.clone()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findinterfacesaddedtoobjecttypes(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
	mut var_oldTypeMap := var_oldSchema.gettypemap()
	mut var_newTypeMap := var_newSchema.gettypemap()
	mut var_interfacesAddedToObjectTypes := rt.new_array()
	mut iter_38 := var_newTypeMap.iterator()
	for {
		item_38 := iter_38.next() or { break }
		mut var_newType := item_38.val
		mut var_typeName := item_38.key
		mut var_oldType := if !(var_oldTypeMap.array_get(var_typeName)).is_null() { var_oldTypeMap.array_get(var_typeName) } else { rt.new_null() }
		if (rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_oldType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType')))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_oldType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType'))))))) || (rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_newType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType')))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_newType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType'))))))) {
			continue
		}
		mut var_oldInterfaces := rt.call_method(var_oldType, 'getInterfaces', []rt.PhpVal{})
		mut var_newInterfaces := rt.call_method(var_newType, 'getInterfaces', []rt.PhpVal{})
		mut iter_39 := var_newInterfaces.iterator()
		for {
			item_39 := iter_39.next() or { break }
			mut var_newInterface := item_39.val
			mut var_interfaceWasAdded := rt.new_bool(true)
			mut iter_40 := var_oldInterfaces.iterator()
			for {
				item_40 := iter_40.next() or { break }
				mut var_oldInterface := item_40.val
				if rt.is_true(rt.identical(rt.get_property(var_oldInterface, 'name'), rt.get_property(var_newInterface, 'name'))) {
				var_interfaceWasAdded = rt.new_bool(false)
				}
			}
			if rt.is_true(var_interfaceWasAdded) {
				var_interfacesAddedToObjectTypes.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.dangerous_change_implemented_interface_added() }, rt.ArrayItem{ key: 'description', val: rt.concat(rt.concat(rt.concat(rt.get_property(var_newInterface, 'name'), rt.new_string(' added to interfaces implemented by ')), var_typeName), rt.new_string('.')) }]))
			}
		}
	}
	return var_interfacesAddedToObjectTypes.clone()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findtypesaddedtounions(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
	mut var_oldTypeMap := var_oldSchema.gettypemap()
	mut var_newTypeMap := var_newSchema.gettypemap()
	mut var_typesAddedToUnion := rt.new_array()
	mut iter_41 := var_newTypeMap.iterator()
	for {
		item_41 := iter_41.next() or { break }
		mut var_newType := item_41.val
		mut var_typeName := item_41.key
		mut var_oldType := if !(var_oldTypeMap.array_get(var_typeName)).is_null() { var_oldTypeMap.array_get(var_typeName) } else { rt.new_null() }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_oldType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType')))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_newType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType')))))) {
			continue
		}
		mut var_typeNamesInOldUnion := rt.new_array()
		mut iter_42 := rt.call_method(var_oldType, 'getTypes', []rt.PhpVal{}).iterator()
		for {
			item_42 := iter_42.next() or { break }
			mut var_type := item_42.val
			var_typeNamesInOldUnion.array_set(rt.get_property(var_type, 'name'), true)
		}
		mut iter_43 := rt.call_method(var_newType, 'getTypes', []rt.PhpVal{}).iterator()
		for {
			item_43 := iter_43.next() or { break }
			mut var_type := item_43.val
			if !(var_typeNamesInOldUnion.array_isset(rt.get_property(var_type, 'name'))) {
				var_typesAddedToUnion.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.dangerous_change_type_added_to_union() }, rt.ArrayItem{ key: 'description', val: rt.concat(rt.concat(rt.concat(rt.get_property(var_type, 'name'), rt.new_string(' was added to union type ')), var_typeName), rt.new_string('.')) }]))
			}
		}
	}
	return var_typesAddedToUnion.clone()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeError {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_utils_breakingchangesfinder(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_typeerror(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeError {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'findBreakingChanges' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findbreakingchanges(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'findRemovedTypes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremovedtypes(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'findTypesThatChangedKind' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findtypesthatchangedkind(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'typeKindName' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.typekindname(mut dispatch_arg_0))
		}
		'findFieldsThatChangedTypeOnObjectOrInterfaceTypes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findfieldsthatchangedtypeonobjectorinterfacetypes(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'isChangeSafeForObjectOrInterfaceField' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.ischangesafeforobjectorinterfacefield(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'findFieldsThatChangedTypeOnInputObjectTypes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findfieldsthatchangedtypeoninputobjecttypes(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'isChangeSafeForInputObjectFieldOrFieldArg' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.ischangesafeforinputobjectfieldorfieldarg(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'findTypesRemovedFromUnions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findtypesremovedfromunions(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'findValuesRemovedFromEnums' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findvaluesremovedfromenums(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'findArgChanges' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findargchanges(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'findInterfacesRemovedFromObjectTypes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findinterfacesremovedfromobjecttypes(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'findRemovedDirectives' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremoveddirectives(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'getDirectiveMapForSchema' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.getdirectivemapforschema(mut dispatch_arg_0)
		}
		'findRemovedDirectiveArgs' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremoveddirectiveargs(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'findRemovedArgsForDirectives' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremovedargsfordirectives(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'getArgumentMapForDirective' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.getargumentmapfordirective(mut dispatch_arg_0)
		}
		'findAddedNonNullDirectiveArgs' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findaddednonnulldirectiveargs(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'findAddedArgsForDirective' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findaddedargsfordirective(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'findRemovedDirectiveLocations' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremoveddirectivelocations(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'findRemovedLocationsForDirective' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremovedlocationsfordirective(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'findDangerousChanges' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.finddangerouschanges(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'findValuesAddedToEnums' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findvaluesaddedtoenums(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'findInterfacesAddedToObjectTypes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findinterfacesaddedtoobjecttypes(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'findTypesAddedToUnions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findtypesaddedtounions(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
