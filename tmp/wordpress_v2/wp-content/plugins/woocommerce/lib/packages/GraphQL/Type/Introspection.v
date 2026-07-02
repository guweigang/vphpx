import rt

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.schema_field_name() string {
	return '__schema'
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.type_field_name() string {
	return '__type'
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.type_name_field_name() string {
	return '__typename'
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.schema_object_name() string {
	return '__Schema'
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.type_object_name() string {
	return '__Type'
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.directive_object_name() string {
	return '__Directive'
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.field_object_name() string {
	return '__Field'
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.input_value_object_name() string {
	return '__InputValue'
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.enum_value_object_name() string {
	return '__EnumValue'
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.type_kind_enum_name() string {
	return '__TypeKind'
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.directive_location_enum_name() string {
	return '__DirectiveLocation'
}

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.type_names() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.schema_object_name()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.type_object_name()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.directive_object_name()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.field_object_name()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.input_value_object_name()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.enum_value_object_name()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.type_kind_enum_name()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.directive_location_enum_name()
		},
	])
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_vendor_graphql_type_introspection() {
	rt.init_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection',
		'cachedInstances', rt.new_null())
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.getintrospectionquery(mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Type_array) string {
	mut var_optionsWithDefaults := rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: 'descriptions', val: true },
			rt.ArrayItem{ key: 'directiveIsRepeatable', val: false },
			rt.ArrayItem{ key: 'schemaDescription', val: false },
			rt.ArrayItem{ key: 'typeIsOneOf', val: false }]),
		var_options,
	])
	mut var_descriptions := rt.new_string((if rt.is_true(var_optionsWithDefaults.array_get(rt.new_string('descriptions'))) {
		'description'
	} else {
		''
	}).str())
	mut var_directiveIsRepeatable := rt.new_string((if rt.is_true(var_optionsWithDefaults.array_get(rt.new_string('directiveIsRepeatable'))) {
		'isRepeatable'
	} else {
		''
	}).str())
	mut var_schemaDescription := if rt.is_true(var_optionsWithDefaults.array_get(rt.new_string('schemaDescription'))) {
		var_descriptions
	} else {
		rt.new_string('')
	}
	mut var_typeIsOneOf := rt.new_string((if rt.is_true(var_optionsWithDefaults.array_get(rt.new_string('typeIsOneOf'))) {
		'isOneOf'
	} else {
		''
	}).str())
	return '  query IntrospectionQuery {\n    __schema {\n      ${var_schemaDescription.to_string()}\n      queryType { name }\n      mutationType { name }\n      subscriptionType { name }\n      types {\n        ...FullType\n      }\n      directives {\n        name\n        ${var_descriptions.to_string()}\n        args(includeDeprecated: true) {\n          ...InputValue\n        }\n        ${var_directiveIsRepeatable.to_string()}\n        locations\n      }\n    }\n  }\n\n  fragment FullType on __Type {\n    kind\n    name\n    ${var_descriptions.to_string()}\n    ${var_typeIsOneOf.to_string()}\n    fields(includeDeprecated: true) {\n      name\n      ${var_descriptions.to_string()}\n      args(includeDeprecated: true) {\n        ...InputValue\n      }\n      type {\n        ...TypeRef\n      }\n      isDeprecated\n      deprecationReason\n    }\n    inputFields(includeDeprecated: true) {\n      ...InputValue\n    }\n    interfaces {\n      ...TypeRef\n    }\n    enumValues(includeDeprecated: true) {\n      name\n      ${var_descriptions.to_string()}\n      isDeprecated\n      deprecationReason\n    }\n    possibleTypes {\n      ...TypeRef\n    }\n  }\n\n  fragment InputValue on __InputValue {\n    name\n    ${var_descriptions.to_string()}\n    type { ...TypeRef }\n    defaultValue\n    isDeprecated\n    deprecationReason\n  }\n\n  fragment TypeRef on __Type {\n    kind\n    name\n    ofType {\n      kind\n      name\n      ofType {\n        kind\n        name\n        ofType {\n          kind\n          name\n          ofType {\n            kind\n            name\n            ofType {\n              kind\n              name\n              ofType {\n                kind\n                name\n                ofType {\n                  kind\n                  name\n                }\n              }\n            }\n          }\n        }\n      }\n    }\n  }'
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.fromschema(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Type_array) rt.PhpVal {
	mut var_optionsWithDefaults := rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: 'directiveIsRepeatable', val: true },
			rt.ArrayItem{ key: 'schemaDescription', val: true },
			rt.ArrayItem{ key: 'typeIsOneOf', val: true }]),
		var_options,
	])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL{}
	mut iife_result_0 := iife_temp_0.executequery(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Schema',
		[]string{}, var_schema),
		Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.getintrospectionquery(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_array](var_optionsWithDefaults)))
	mut var_result := iife_result_0
	mut var_data := rt.get_property(var_result, 'data')
	if rt.is_true(rt.identical(var_data, rt.new_null())) {
		mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_1 := iife_temp_1.printsafejson(var_result.clone())
		mut var_noDataResult := iife_result_1
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation',
			[]string{},
			create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string('Introspection query returned no data: ${var_noDataResult.to_string()}.'))))
	}
	return var_data.clone()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.isintrospectiontype(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType) bool {
	return (rt.call_function('in_array', [rt.get_property(var_type, 'name'),
		Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.type_names(),
		rt.new_bool(true)])).to_bool()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.gettypes() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.schema_object_name()
			val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection._schema()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.type_object_name()
			val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection._type()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.directive_object_name()
			val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection._directive()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.field_object_name()
			val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection._field()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.input_value_object_name()
			val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection._inputvalue()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.enum_value_object_name()
			val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection._enumvalue()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.type_kind_enum_name()
			val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection._typekind()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.directive_location_enum_name()
			val: Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection._directivelocation()
		},
	])
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection._schema() rt.PhpVal {
	mut var_schema := rt.new_null()
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection._type() rt.PhpVal {
	mut var_type := rt.new_null()
	mut var_info := rt.new_null()
	mut var_args := rt.new_null()
	mut var_context := rt.new_null()
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection._typekind() rt.PhpVal {
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection._field() rt.PhpVal {
	mut var_field := rt.new_null()
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection._inputvalue() rt.PhpVal {
	mut var_inputValue := rt.new_null()
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection._enumvalue() rt.PhpVal {
	mut var_enumValue := rt.new_null()
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection._directive() rt.PhpVal {
	mut var_directive := rt.new_null()
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection._directivelocation() rt.PhpVal {
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.schemametafielddef() rt.PhpVal {
	mut var_info := rt.new_null()
	mut var_source := rt.new_null()
	mut var_args := rt.new_null()
	mut var_context := rt.new_null()
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.typemetafielddef() rt.PhpVal {
	mut var_info := rt.new_null()
	mut var_args := rt.new_null()
	mut var_source := rt.new_null()
	mut var_context := rt.new_null()
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.typenamemetafielddef() rt.PhpVal {
	mut var_info := rt.new_null()
	mut var_source := rt.new_null()
	mut var_args := rt.new_null()
	mut var_context := rt.new_null()
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.resetcachedinstances() {
	rt.set_static_prop('Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection',
		'cachedInstances', rt.new_null())
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_type_introspection(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_graphql(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL{
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getIntrospectionQuery' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.getintrospectionquery(mut dispatch_arg_0))
		}
		'fromSchema' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.fromschema(mut dispatch_arg_0, mut
				dispatch_arg_1)
		}
		'isIntrospectionType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.isintrospectiontype(mut dispatch_arg_0))
		}
		'getTypes' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.gettypes()
		}
		'_schema' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection._schema()
		}
		'_type' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection._type()
		}
		'_typeKind' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection._typekind()
		}
		'_field' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection._field()
		}
		'_inputValue' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection._inputvalue()
		}
		'_enumValue' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection._enumvalue()
		}
		'_directive' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection._directive()
		}
		'_directiveLocation' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection._directivelocation()
		}
		'schemaMetaFieldDef' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.schemametafielddef()
		}
		'typeMetaFieldDef' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.typemetafielddef()
		}
		'typeNameMetaFieldDef' {
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.typenamemetafielddef()
		}
		'resetCachedInstances' {
			Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection.resetcachedinstances()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
