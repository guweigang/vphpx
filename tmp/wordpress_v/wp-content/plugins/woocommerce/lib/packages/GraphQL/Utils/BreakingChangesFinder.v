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
	return rt.call_function('array_merge', [Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremovedtypes(mut var_oldSchema, mut var_newSchema), Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findtypesthatchangedkind(mut var_oldSchema, mut var_newSchema), Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findfieldsthatchangedtypeonobjectorinterfacetypes(mut var_oldSchema, mut var_newSchema), Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findfieldsthatchangedtypeoninputobjecttypes(mut var_oldSchema, mut var_newSchema).array_get('breakingChanges'), Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findtypesremovedfromunions(mut var_oldSchema, mut var_newSchema), Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findvaluesremovedfromenums(mut var_oldSchema, mut var_newSchema), Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findargchanges(mut var_oldSchema, mut var_newSchema).array_get('breakingChanges'), Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findinterfacesremovedfromobjecttypes(mut var_oldSchema, mut var_newSchema), Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremoveddirectives(mut var_oldSchema, mut var_newSchema), Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremoveddirectiveargs(mut var_oldSchema, mut var_newSchema), Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findaddednonnulldirectiveargs(mut var_oldSchema, mut var_newSchema), Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremoveddirectivelocations(mut var_oldSchema, mut var_newSchema)])
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremovedtypes(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
	mut var_oldTypeMap := var_oldSchema.gettypemap()
	mut var_newTypeMap := var_newSchema.gettypemap()
	mut var_breakingChanges := rt.new_array()
	{
		mut iter_1 := rt.func_array_keys(var_oldTypeMap.dup()).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_typeName := item_1.val
			if !(var_newTypeMap.array_isset(var_typeName)) {
				var_breakingChanges.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.breaking_change_type_removed() }, rt.ArrayItem{ key: 'description', val: "${var_typeName.to_string()} was removed." }]))
			}
		}
	}
	return var_breakingChanges.dup()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findtypesthatchangedkind(mut var_schemaA Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_schemaB Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
	mut var_schemaATypeMap := var_schemaA.gettypemap()
	mut var_schemaBTypeMap := var_schemaB.gettypemap()
	mut var_breakingChanges := rt.new_array()
	{
		mut iter_1 := var_schemaATypeMap.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_schemaAType := item_1.val
			mut var_typeName := item_1.key
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
	}
	return var_breakingChanges.dup()
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
	{
		mut iter_1 := var_oldTypeMap.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_oldType := item_1.val
			mut var_typeName := item_1.key
			mut var_newType := if !(var_newTypeMap.array_get(var_typeName)).is_null() { var_newTypeMap.array_get(var_typeName) } else { rt.new_null() }
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_oldType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType')))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_oldType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType')))))))) || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_newType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType')))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_newType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType')))))))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_newType, 'Automattic_WooCommerce_Vendor_GraphQL_Utils_{"nodeType":"Expr_Variable","line":205,"name":"oldType"}')))))))) {
				continue
			}
			mut var_oldTypeFieldsDef := rt.call_method(var_oldType, 'getFields', []rt.PhpVal{})
			mut var_newTypeFieldsDef := rt.call_method(var_newType, 'getFields', []rt.PhpVal{})
			{
				mut iter_2 := var_oldTypeFieldsDef.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_fieldDefinition := item_2.val
					mut var_fieldName := item_2.key
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
		}
	}
	return var_breakingChanges.dup()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.ischangesafeforobjectorinterfacefield(mut var_oldType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, mut var_newType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) bool {
	mut var_oldType_mutated := var_oldType
	mut var_newType_mutated := var_newType
	if rt.is_true(rt.new_bool(rt.instance_of(var_oldType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType'))) {
		return rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_newType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType'))) && rt.is_true(rt.identical(rt.get_property(var_oldType_mutated, 'name'), rt.get_property(var_newType_mutated, 'name'))))) || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_newType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) && rt.is_true(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.ischangesafeforobjectorinterfacefield(mut var_oldType_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_newType_mutated, 'getWrappedType', []rt.PhpVal{}))))))
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_oldType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType'))) {
		return rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_newType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType'))) && rt.is_true(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.ischangesafeforobjectorinterfacefield(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_oldType_mutated, 'getWrappedType', []rt.PhpVal{})), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_newType_mutated, 'getWrappedType', []rt.PhpVal{})))))) || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_newType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) && rt.is_true(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.ischangesafeforobjectorinterfacefield(mut var_oldType_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_newType_mutated, 'getWrappedType', []rt.PhpVal{}))))))
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
	{
		mut iter_1 := var_oldTypeMap.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_oldType := item_1.val
			mut var_typeName := item_1.key
			mut var_newType := if !(var_newTypeMap.array_get(var_typeName)).is_null() { var_newTypeMap.array_get(var_typeName) } else { rt.new_null() }
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_oldType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType')))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_newType, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType')))))))) {
				continue
			}
			mut var_oldTypeFieldsDef := rt.call_method(var_oldType, 'getFields', []rt.PhpVal{})
			mut var_newTypeFieldsDef := rt.call_method(var_newType, 'getFields', []rt.PhpVal{})
			{
				mut iter_2 := rt.func_array_keys(var_oldTypeFieldsDef.dup()).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_fieldName := item_2.val
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
			}
			{
				mut iter_2 := var_newTypeFieldsDef.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_fieldDef := item_2.val
					mut var_fieldName := item_2.key
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
		return rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_newType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull'))) && rt.is_true(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.ischangesafeforinputobjectfieldorfieldarg(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_oldType_mutated, 'getWrappedType', []rt.PhpVal{})), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_newType_mutated, 'getWrappedType', []rt.PhpVal{})))))) || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_newType_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull')))))) && rt.is_true(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.ischangesafeforinputobjectfieldorfieldarg(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](rt.call_method(var_oldType_mutated, 'getWrappedType', []rt.PhpVal{})), mut var_newType_mutated))))
	}
	return false
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findtypesremovedfromunions(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
	mut var_oldTypeMap := var_oldSchema.gettypemap()
	mut var_newTypeMap := var_newSchema.gettypemap()
	mut var_typesRemovedFromUnion := rt.new_array()
	{
		mut iter_1 := var_oldTypeMap.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_oldType := item_1.val
			mut var_typeName := item_1.key
			mut var_newType := if !(var_newTypeMap.array_get(var_typeName)).is_null() { var_newTypeMap.array_get(var_typeName) } else { rt.new_null() }
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType')))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType')))))))) {
				continue
			}
			mut var_typeNamesInNewUnion := rt.new_array()
			{
				mut iter_2 := rt.call_method(, 'getTypes', []rt.PhpVal{}).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_type := item_2.val
					
				}
			}
		}
	}
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findvaluesremovedfromenums(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findargchanges(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findinterfacesremovedfromobjecttypes(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremoveddirectives(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.getdirectivemapforschema(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremoveddirectiveargs(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremovedargsfordirectives(mut var_oldDirective Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive, mut var_newDirective Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.getargumentmapfordirective(mut var_directive Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findaddednonnulldirectiveargs(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findaddedargsfordirective(mut var_oldDirective Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive, mut var_newDirective Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremoveddirectivelocations(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findremovedlocationsfordirective(mut var_oldDirective Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive, mut var_newDirective Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.finddangerouschanges(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findvaluesaddedtoenums(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findinterfacesaddedtoobjecttypes(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder.findtypesaddedtounions(mut var_oldSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_newSchema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) rt.PhpVal {
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeError {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_utils_breakingchangesfinder() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BreakingChangesFinder{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_typeerror() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeError {
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




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_utils_breakingchangesfinder_php() {
	// unsupported statement: Stmt_Declare
}
