import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema {
	rt.PhpObjectBase
pub mut:
		introspection rt.PhpVal = rt.new_null()
		options rt.PhpVal = rt.new_null()
		typeMap rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema) construct(mut var_introspectionQuery Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) {
	this.introspection = var_introspectionQuery
	this.options = var_options
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema.build(mut var_introspectionQuery Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	return rt.call_method(create_automattic_woocommerce_vendor_graphql_utils_self(var_introspectionQuery, var_options), 'buildSchema', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema) buildschema() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.introspection.array_isset(rt.new_string('__schema'))))))) {
		mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_0 := iife_temp_0.printsafejson(this.introspection)
		mut var_missingSchemaIntrospection := iife_result_0
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Invalid or incomplete introspection result. Ensure that you are passing \"data\" property of introspection response and no \"errors\" was returned alongside: ${var_missingSchemaIntrospection.to_string()}."))))
	}
	mut var_schemaIntrospection := this.introspection.array_get(rt.new_string('__schema'))
	mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
	mut iife_result_1 := iife_temp_1.builtinscalars()
	mut iife_temp_2 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection{}
	mut iife_result_2 := iife_temp_2.gettypes()
	mut iife_temp_3 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
	mut iife_result_3 := iife_temp_3.builtinscalars()
	mut var_builtInTypes := rt.call_function('array_merge', [iife_result_1, iife_result_2])
	mut iter_1 := var_schemaIntrospection.array_get(rt.new_string('types')).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_typeIntrospection := item_1.val
		if !(var_typeIntrospection.array_isset(rt.new_string('name'))) {
			rt.throw_exception(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema.invalidorincompleteintrospectionresult(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_typeIntrospection)))
		}
		mut var_name := var_typeIntrospection.array_get(rt.new_string('name'))
		if !(var_name.clone().is_string()) {
			rt.throw_exception(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema.invalidorincompleteintrospectionresult(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_typeIntrospection)))
		}
		this.typeMap.array_set(var_name, if !(var_builtInTypes.array_get(var_name)).is_null() { var_builtInTypes.array_get(var_name) } else { this.buildtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_typeIntrospection)) })
	}
	mut var_description := if var_schemaIntrospection.array_isset(rt.new_string('description')) { var_schemaIntrospection.array_get(rt.new_string('description')) } else { rt.new_null() }
	mut var_queryType := if var_schemaIntrospection.array_isset(rt.new_string('queryType')) { this.getobjecttype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_schemaIntrospection.array_get(rt.new_string('queryType')))) } else { rt.new_null() }
	mut var_mutationType := if var_schemaIntrospection.array_isset(rt.new_string('mutationType')) { this.getobjecttype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_schemaIntrospection.array_get(rt.new_string('mutationType')))) } else { rt.new_null() }
	mut var_subscriptionType := if var_schemaIntrospection.array_isset(rt.new_string('subscriptionType')) { this.getobjecttype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_schemaIntrospection.array_get(rt.new_string('subscriptionType')))) } else { rt.new_null() }
	mut var_directives := if var_schemaIntrospection.array_isset(rt.new_string('directives')) { rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'buildDirective' }]), var_schemaIntrospection.array_get(rt.new_string('directives'))]) } else { rt.new_array() }
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Schema', []string{}, create_automattic_woocommerce_vendor_graphql_type_schema(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(create_automattic_woocommerce_vendor_graphql_type_schemaconfig(), 'setDescription', [var_description.clone()]), 'setQuery', [var_queryType.clone()]), 'setMutation', [var_mutationType.clone()]), 'setSubscription', [var_subscriptionType.clone()]), 'setTypes', [this.typeMap]), 'setDirectives', [var_directives.clone()]), 'setAssumeValid', [if !(this.options.array_get(rt.new_string('assumeValid'))).is_null() { this.options.array_get(rt.new_string('assumeValid')) } else { rt.new_bool(false) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema) gettype(mut var_typeRef Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	if var_typeRef.array_isset(rt.new_string('kind')) {
		if rt.is_true(rt.identical(var_typeRef.array_get(rt.new_string('kind')), Class_Automattic_WooCommerce_Vendor_GraphQL_Type_TypeKind.list())) {
			if !(var_typeRef.array_isset(rt.new_string('ofType'))) {
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string('Decorated type deeper than introspection query.'))))
			}
			return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_listoftype(this.gettype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_typeRef.array_get(rt.new_string('ofType'))))))
		}
		if rt.is_true(rt.identical(var_typeRef.array_get(rt.new_string('kind')), Class_Automattic_WooCommerce_Vendor_GraphQL_Type_TypeKind.non_null())) {
			if !(var_typeRef.array_isset(rt.new_string('ofType'))) {
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string('Decorated type deeper than introspection query.'))))
			}
			return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_nonnull(this.gettype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_typeRef.array_get(rt.new_string('ofType'))))))
		}
	}
	if !(var_typeRef.array_isset(rt.new_string('name'))) {
		mut iife_temp_4 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_4 := iife_temp_4.printsafejson(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_array', []string{}, var_typeRef))
		mut var_unknownTypeRef := iife_result_4
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Unknown type reference: ${var_unknownTypeRef.to_string()}."))))
	}
	return this.getnamedtype((var_typeRef.array_get(rt.new_string('name'))).str())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema) getnamedtype(typeName string) rt.PhpVal {
	if !(this.typeMap.array_isset(rt.new_string(typeName))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Invalid or incomplete schema, unknown type: ${var_typeName}. Ensure that a full introspection query is used in order to build a client schema."))))
	}
	return this.typeMap.array_get(rt.new_string(typeName))
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema.invalidorincompleteintrospectionresult(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	mut var_type_mutated := var_type
	mut iife_temp_5 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
	mut iife_result_5 := iife_temp_5.printsafejson(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_array', []string{}, var_type_mutated))
	mut var_incompleteType := iife_result_5
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Invalid or incomplete introspection result. Ensure that a full introspection query is used in order to build a client schema: ${var_incompleteType.to_string()}.")))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema) getinputtype(mut var_typeRef Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	mut var_type := this.gettype(mut var_typeRef)
	if rt.is_true(rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType'))) {
		return var_type.clone()
	}
	mut iife_temp_6 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
	mut iife_result_6 := iife_temp_6.printsafe(var_type.clone())
	mut var_notInputType := iife_result_6
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Introspection must provide input type for arguments, but received: ${var_notInputType.to_string()}."))))
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema) getoutputtype(mut var_typeRef Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	mut var_type := this.gettype(mut var_typeRef)
	if rt.is_true(rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_OutputType'))) {
		return var_type.clone()
	}
	mut iife_temp_7 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
	mut iife_result_7 := iife_temp_7.printsafe(var_type.clone())
	mut var_notInputType := iife_result_7
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Introspection must provide output type for fields, but received: ${var_notInputType.to_string()}."))))
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema) getobjecttype(mut var_typeRef Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	mut var_type := this.gettype(mut var_typeRef)
	mut iife_temp_8 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType{}
	mut iife_result_8 := iife_temp_8.assertobjecttype(var_type.clone())
	return iife_result_8
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema) getinterfacetype(mut var_typeRef Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	mut var_type := this.gettype(mut var_typeRef)
	mut iife_temp_9 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType{}
	mut iife_result_9 := iife_temp_9.assertinterfacetype(var_type.clone())
	return iife_result_9
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema) buildtype(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	mut var_type_mutated := var_type
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_type_mutated.array_isset(rt.new_string('kind'))))))) {
		rt.throw_exception(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema.invalidorincompleteintrospectionresult(mut var_type_mutated))
	}
	mut switch_val_1 := var_type_mutated.array_get(rt.new_string('kind'))
	if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Type_TypeKind.scalar())) {
		return this.buildscalardef(mut var_type_mutated)
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Type_TypeKind.object())) {
		return this.buildobjectdef(mut var_type_mutated)
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Type_TypeKind.interface())) {
		return this.buildinterfacedef(mut var_type_mutated)
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Type_TypeKind.union())) {
		return this.builduniondef(mut var_type_mutated)
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Type_TypeKind.enum())) {
		return this.buildenumdef(mut var_type_mutated)
	} else if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Vendor_GraphQL_Type_TypeKind.input_object())) {
		return this.buildinputobjectdef(mut var_type_mutated)
	} else {
		mut iife_temp_10 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_10 := iife_temp_10.printsafejson(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_array', []string{}, var_type_mutated))
		mut var_unknownKindType := iife_result_10
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Invalid or incomplete introspection result. Received type with unknown kind: ${var_unknownKindType.to_string()}."))))
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema) buildscalardef(mut var_scalar Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	mut var_value := rt.new_null()
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_value
		}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_customscalartype(rt.create_array([rt.ArrayItem{ key: 'name', val: var_scalar.array_get(rt.new_string('name')) }, rt.ArrayItem{ key: 'description', val: var_scalar.array_get(rt.new_string('description')) }, rt.ArrayItem{ key: 'serialize', val: rt.new_closure(closure_12_fn) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema) buildimplementationslist(mut var_implementingIntrospection Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_implementingIntrospection.array_isset(rt.new_string('interfaces')))) && rt.is_true(rt.identical(var_implementingIntrospection.array_get(rt.new_string('interfaces')), rt.new_null())) && rt.is_true(rt.identical(var_implementingIntrospection.array_get(rt.new_string('kind')), Class_Automattic_WooCommerce_Vendor_GraphQL_Type_TypeKind.interface())) {
		return rt.new_array()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_implementingIntrospection.array_isset(rt.new_string('interfaces'))))))) {
		mut iife_temp_12 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_12 := iife_temp_12.printsafejson(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_array', []string{}, var_implementingIntrospection))
		mut var_safeIntrospection := iife_result_12
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Introspection result missing interfaces: ${var_safeIntrospection.to_string()}."))))
	}
	return rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'getInterfaceType' }]), var_implementingIntrospection.array_get(rt.new_string('interfaces'))])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema) buildobjectdef(mut var_object Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	closure_14_fn := fn [var_object] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.buildimplementationslist(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_array', []string{}, var_object))
		}
	closure_15_fn := fn [var_object] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.buildfielddefmap(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_array', []string{}, var_object))
		}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_objecttype(rt.create_array([rt.ArrayItem{ key: 'name', val: var_object.array_get(rt.new_string('name')) }, rt.ArrayItem{ key: 'description', val: var_object.array_get(rt.new_string('description')) }, rt.ArrayItem{ key: 'interfaces', val: rt.new_closure(closure_14_fn) }, rt.ArrayItem{ key: 'fields', val: rt.new_closure(closure_15_fn) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema) buildinterfacedef(mut var_interface Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	closure_16_fn := fn [var_interface] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.buildfielddefmap(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_array', []string{}, var_interface))
		}
	closure_17_fn := fn [var_interface] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.buildimplementationslist(mut rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_array', []string{}, var_interface))
		}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_interfacetype(rt.create_array([rt.ArrayItem{ key: 'name', val: var_interface.array_get(rt.new_string('name')) }, rt.ArrayItem{ key: 'description', val: var_interface.array_get(rt.new_string('description')) }, rt.ArrayItem{ key: 'fields', val: rt.new_closure(closure_16_fn) }, rt.ArrayItem{ key: 'interfaces', val: rt.new_closure(closure_17_fn) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema) builduniondef(mut var_union Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_union.array_isset(rt.new_string('possibleTypes'))))))) {
		mut iife_temp_17 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_17 := iife_temp_17.printsafejson(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_array', []string{}, var_union))
		mut var_safeUnion := iife_result_17
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Introspection result missing possibleTypes: ${var_safeUnion.to_string()}."))))
	}
	closure_19_fn := fn [var_union] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'getObjectType' }]), var_union.array_get(rt.new_string('possibleTypes'))])
		}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_uniontype(rt.create_array([rt.ArrayItem{ key: 'name', val: var_union.array_get(rt.new_string('name')) }, rt.ArrayItem{ key: 'description', val: var_union.array_get(rt.new_string('description')) }, rt.ArrayItem{ key: 'types', val: rt.new_closure(closure_19_fn) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema) buildenumdef(mut var_enum Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_enum.array_isset(rt.new_string('enumValues'))))))) {
		mut iife_temp_19 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_19 := iife_temp_19.printsafejson(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_array', []string{}, var_enum))
		mut var_safeEnum := iife_result_19
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Introspection result missing enumValues: ${var_safeEnum.to_string()}."))))
	}
	mut var_values := rt.new_array()
	mut iter_2 := var_enum.array_get(rt.new_string('enumValues')).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value := item_2.val
		var_values.array_set(var_value.array_get(rt.new_string('name')), rt.create_array([rt.ArrayItem{ key: 'description', val: var_value.array_get(rt.new_string('description')) }, rt.ArrayItem{ key: 'deprecationReason', val: var_value.array_get(rt.new_string('deprecationReason')) }]))
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_enumtype(rt.create_array([rt.ArrayItem{ key: 'name', val: var_enum.array_get(rt.new_string('name')) }, rt.ArrayItem{ key: 'description', val: var_enum.array_get(rt.new_string('description')) }, rt.ArrayItem{ key: 'values', val: var_values }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema) buildinputobjectdef(mut var_inputObject Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_inputObject.array_isset(rt.new_string('inputFields'))))))) {
		mut iife_temp_20 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_20 := iife_temp_20.printsafejson(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_array', []string{}, var_inputObject))
		mut var_safeInputObject := iife_result_20
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Introspection result missing inputFields: ${var_safeInputObject.to_string()}."))))
	}
	closure_22_fn := fn [var_inputObject] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.buildinputvaluedefmap(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_inputObject.array_get(rt.new_string('inputFields'))))
		}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_inputobjecttype(rt.create_array([rt.ArrayItem{ key: 'name', val: var_inputObject.array_get(rt.new_string('name')) }, rt.ArrayItem{ key: 'description', val: var_inputObject.array_get(rt.new_string('description')) }, rt.ArrayItem{ key: 'fields', val: rt.new_closure(closure_22_fn) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema) buildfielddefmap(mut var_typeIntrospection Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_typeIntrospection.array_isset(rt.new_string('fields'))))))) {
		mut iife_temp_22 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_22 := iife_temp_22.printsafejson(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_array', []string{}, var_typeIntrospection))
		mut var_safeType := iife_result_22
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Introspection result missing fields: ${var_safeType.to_string()}."))))
	}
	mut var_map := rt.new_array()
	mut iter_3 := var_typeIntrospection.array_get(rt.new_string('fields')).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_field := item_3.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_field.clone().array_isset(rt.new_string('args'))))))) {
			mut iife_temp_23 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
			mut iife_result_23 := iife_temp_23.printsafejson(var_field.clone())
			mut var_safeField := iife_result_23
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Introspection result missing field args: ${var_safeField.to_string()}."))))
		}
		var_map.array_set(var_field.array_get(rt.new_string('name')), rt.create_array([rt.ArrayItem{ key: 'description', val: var_field.array_get(rt.new_string('description')) }, rt.ArrayItem{ key: 'deprecationReason', val: var_field.array_get(rt.new_string('deprecationReason')) }, rt.ArrayItem{ key: 'type', val: this.getoutputtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_field.array_get(rt.new_string('type')))) }, rt.ArrayItem{ key: 'args', val: this.buildinputvaluedefmap(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_field.array_get(rt.new_string('args')))) }]))
	}
	return var_map.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema) buildinputvaluedefmap(mut var_inputValueIntrospections Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	mut var_map := rt.new_array()
	mut iter_4 := var_inputValueIntrospections.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_value := item_4.val
		var_map.array_set(var_value.array_get(rt.new_string('name')), this.buildinputvalue(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_value)))
	}
	return var_map.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema) buildinputvalue(mut var_inputValueIntrospection Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	mut var_type := this.getinputtype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_inputValueIntrospection.array_get(rt.new_string('type'))))
	mut var_inputValue := rt.create_array([rt.ArrayItem{ key: 'description', val: var_inputValueIntrospection.array_get(rt.new_string('description')) }, rt.ArrayItem{ key: 'type', val: var_type }])
	if var_inputValueIntrospection.array_isset(rt.new_string('defaultValue')) {
		mut iife_temp_24 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser{}
		mut iife_result_24 := iife_temp_24.parsevalue(var_inputValueIntrospection.array_get(rt.new_string('defaultValue')))
		mut iife_temp_25 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}
		mut iife_result_25 := iife_temp_25.valuefromast(iife_result_24, var_type.clone())
		var_inputValue.array_set('defaultValue', iife_result_25)
	}
	return var_inputValue.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema) builddirective(mut var_directive Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_directive.array_isset(rt.new_string('args'))))))) {
		mut iife_temp_26 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_26 := iife_temp_26.printsafejson(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_array', []string{}, var_directive))
		mut var_safeDirective := iife_result_26
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Introspection result missing directive args: ${var_safeDirective.to_string()}."))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_directive.array_isset(rt.new_string('locations'))))))) {
		mut iife_temp_27 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_27 := iife_temp_27.printsafejson(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Utils_array', []string{}, var_directive))
		var_safeDirective = iife_result_27
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string("Introspection result missing directive locations: ${var_safeDirective.to_string()}."))))
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive', []string{}, create_automattic_woocommerce_vendor_graphql_type_definition_directive(rt.create_array([rt.ArrayItem{ key: 'name', val: var_directive.array_get(rt.new_string('name')) }, rt.ArrayItem{ key: 'description', val: var_directive.array_get(rt.new_string('description')) }, rt.ArrayItem{ key: 'args', val: this.buildinputvaluedefmap(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](var_directive.array_get(rt.new_string('args')))) }, rt.ArrayItem{ key: 'isRepeatable', val: if !(var_directive.array_get(rt.new_string('isRepeatable'))).is_null() { var_directive.array_get(rt.new_string('isRepeatable')) } else { rt.new_bool(false) } }, rt.ArrayItem{ key: 'locations', val: var_directive.array_get(rt.new_string('locations')) }])))
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_self {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_utils_buildclientschema(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema{
		PhpObjectBase: rt.PhpObjectBase{}
		introspection: rt.new_null()
		options: rt.new_null()
		typeMap: rt.new_array()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_self(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_self {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_self{
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

fn create_automattic_woocommerce_vendor_graphql_error_invariantviolation(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation{
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

fn create_automattic_woocommerce_vendor_graphql_type_introspection(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_schema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_schemaconfig(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_listoftype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_nonnull(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_objecttype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_interfacetype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_customscalartype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_uniontype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_enumtype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_inputobjecttype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_ast(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_parser(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_directive(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'build' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema.build(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'buildSchema' {
			return this.buildschema()
		}
		'getType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.gettype(mut dispatch_arg_0)
		}
		'getNamedType' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.getnamedtype(dispatch_arg_0)
		}
		'invalidOrIncompleteIntrospectionResult' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema.invalidorincompleteintrospectionresult(mut dispatch_arg_0)
		}
		'getInputType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getinputtype(mut dispatch_arg_0)
		}
		'getOutputType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getoutputtype(mut dispatch_arg_0)
		}
		'getObjectType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getobjecttype(mut dispatch_arg_0)
		}
		'getInterfaceType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getinterfacetype(mut dispatch_arg_0)
		}
		'buildType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.buildtype(mut dispatch_arg_0)
		}
		'buildScalarDef' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.buildscalardef(mut dispatch_arg_0)
		}
		'buildImplementationsList' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.buildimplementationslist(mut dispatch_arg_0)
		}
		'buildObjectDef' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.buildobjectdef(mut dispatch_arg_0)
		}
		'buildInterfaceDef' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.buildinterfacedef(mut dispatch_arg_0)
		}
		'buildUnionDef' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.builduniondef(mut dispatch_arg_0)
		}
		'buildEnumDef' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.buildenumdef(mut dispatch_arg_0)
		}
		'buildInputObjectDef' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.buildinputobjectdef(mut dispatch_arg_0)
		}
		'buildFieldDefMap' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.buildfielddefmap(mut dispatch_arg_0)
		}
		'buildInputValueDefMap' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.buildinputvaluedefmap(mut dispatch_arg_0)
		}
		'buildInputValue' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.buildinputvalue(mut dispatch_arg_0)
		}
		'buildDirective' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.builddirective(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'introspection' { return this.introspection }
		'options' { return this.options }
		'typeMap' { return this.typeMap }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_BuildClientSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'introspection' { this.introspection = val; return true }
		'options' { this.options = val; return true }
		'typeMap' { this.typeMap = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_CustomScalarType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
