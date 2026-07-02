import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema {
	rt.PhpObjectBase
pub mut:
	config             rt.PhpVal = rt.new_null()
	resolvedTypes      rt.PhpVal = rt.new_array()
	implementationsMap rt.PhpVal = rt.new_null()
	fullyLoaded        bool
	scalarOverrides    rt.PhpVal = rt.new_null()
	validationErrors   rt.PhpVal = rt.new_null()
	description        rt.PhpVal = rt.new_null()
	astNode            rt.PhpVal = rt.new_null()
	extensionASTNodes  rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) construct(var_config rt.PhpVal) {
	mut var_config_mutated := var_config
	if rt.is_true(rt.new_bool(var_config_mutated.clone().is_array())) {
		mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig{}
		mut iife_result_0 := iife_temp_0.create(var_config_mutated.clone())
		var_config_mutated = iife_result_0
	}
	if rt.is_true(rt.call_method(var_config_mutated, 'getAssumeValid', []rt.PhpVal{})) {
		this.validationErrors = rt.new_array()
	}
	this.description = rt.get_property(var_config_mutated, 'description')
	this.astNode = rt.get_property(var_config_mutated, 'astNode')
	this.extensionASTNodes = rt.get_property(var_config_mutated, 'extensionASTNodes')
	this.config = var_config_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) gettypemap() rt.PhpVal {
	if !(this.fullyLoaded) {
		this.resolvedTypes = rt.new_array()
		mut var_scalarOverrides := this.getscalaroverrides()
		mut iter_1 := this.materializetypes().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_typeOrLazyType := item_1.val
			mut var_type :=
				Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema.resolvetype(var_typeOrLazyType.clone())
			rt.call_function('assert', [
				rt.new_bool(rt.instance_of(var_type,
					'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType')),
			])
			mut var_typeName := rt.get_property(var_type, 'name')
			if var_scalarOverrides.array_isset(var_typeName) {
				continue
			}
			rt.call_function('assert', [
				rt.new_bool(!(this.resolvedTypes.array_isset(var_typeName))
					|| rt.is_true(rt.identical(var_type, this.resolvedTypes.array_get(var_typeName)))),
				rt.new_string("Schema must contain unique named types but contains multiple types named \"${var_type.to_string()}\" (see https://webonyx.github.io/graphql-php/type-definitions/#type-registry)."),
			])
			this.resolvedTypes.array_set(var_typeName, var_type.clone())
		}
		mut var_allReferencedTypes := rt.new_array()
		mut iter_2 := this.resolvedTypes.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_type := item_2.val
			var_allReferencedTypes.array_unset(rt.get_property(var_type, 'name'))
			mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo{}
			mut iife_result_1 := iife_temp_1.extracttypes(var_type.clone(),
				var_allReferencedTypes.clone())
		}
		mut iter_3 := rt.create_array([
			rt.ArrayItem{ key: none, val: this.getquerytype() },
			rt.ArrayItem{ key: none, val: this.getmutationtype() },
			rt.ArrayItem{ key: none, val: this.getsubscriptiontype() },
		]).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_rootType := item_3.val
			if rt.is_true(rt.new_bool(rt.instance_of(var_rootType,
				'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType')))
			{
				mut iife_temp_2 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo{}
				mut iife_result_2 := iife_temp_2.extracttypes(var_rootType.clone(),
					var_allReferencedTypes.clone())
			}
		}
		mut iter_4 := this.getdirectives().iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_directive := item_4.val
			if rt.is_true(rt.new_bool(rt.instance_of(var_directive,
				'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive')))
			{
				mut iife_temp_3 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo{}
				mut iife_result_3 := iife_temp_3.extracttypesfromdirectives(var_directive.clone(),
					var_allReferencedTypes.clone())
			}
		}
		mut iife_temp_4 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection{}
		mut iife_result_4 := iife_temp_4._schema()
		mut iife_temp_5 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo{}
		mut iife_result_5 := iife_temp_5.extracttypes(iife_result_4, var_allReferencedTypes.clone())
		mut iter_5 := var_scalarOverrides.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_override := item_5.val
			mut var_name := item_5.key
			var_allReferencedTypes.array_set(var_name, var_override.clone())
		}
		this.resolvedTypes = var_allReferencedTypes.clone()
		this.fullyLoaded = true
	}
	return this.resolvedTypes
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) getdirectives() rt.PhpVal {
	mut iife_temp_6 := Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL{}
	mut iife_result_6 := iife_temp_6.getstandarddirectives()
	return if !(rt.get_property(this.config, 'directives')).is_null() {
		rt.get_property(this.config, 'directives')
	} else {
		iife_result_6
	}
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema.typeloadernottype(var_typeLoaderReturn rt.PhpVal) string {
	mut var_typeClass := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type.class()
	mut iife_temp_7 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
	mut iife_result_7 := iife_temp_7.printsafe(var_typeLoaderReturn.clone())
	mut var_notType := iife_result_7
	return 'Type loader is expected to return an instanceof ${var_typeClass.to_string()}, but it returned ${var_notType.to_string()}'
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema.typeloaderwrongtypename(expectedTypeName string, actualTypeName string) string {
	return 'Type loader is expected to return type ${var_expectedTypeName}, but it returned type ${var_actualTypeName}.'
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) getoperationtype(operation string) rt.PhpVal {
	mut switch_val_1 := rt.new_string(operation)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('query'))) {
		return this.getquerytype()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('mutation'))) {
		return this.getmutationtype()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('subscription'))) {
		return this.getsubscriptiontype()
	} else {
		return rt.new_null()
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) getquerytype() rt.PhpVal {
	mut var_query := rt.get_property(this.config, 'query')
	if rt.is_true(rt.identical(var_query, rt.new_null())) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('is_callable', [var_query.clone()])) {
		return rt.set_property(this.config, 'query', rt.call_callable(var_query, []rt.PhpVal{}))
	}
	return var_query.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) getmutationtype() rt.PhpVal {
	mut var_mutation := rt.get_property(this.config, 'mutation')
	if rt.is_true(rt.identical(var_mutation, rt.new_null())) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('is_callable', [var_mutation.clone()])) {
		return rt.set_property(this.config, 'mutation', rt.call_callable(var_mutation,
			[]rt.PhpVal{}))
	}
	return var_mutation.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) getsubscriptiontype() rt.PhpVal {
	mut var_subscription := rt.get_property(this.config, 'subscription')
	if rt.is_true(rt.identical(var_subscription, rt.new_null())) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('is_callable', [var_subscription.clone()])) {
		return rt.set_property(this.config, 'subscription', rt.call_callable(var_subscription,
			[]rt.PhpVal{}))
	}
	return var_subscription.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) getconfig() rt.PhpVal {
	return this.config
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) gettype(name string) rt.PhpVal {
	if this.resolvedTypes.array_isset(rt.new_string(name)) {
		return this.resolvedTypes.array_get(rt.new_string(name))
	}
	mut iife_temp_8 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection{}
	mut iife_result_8 := iife_temp_8.gettypes()
	mut var_introspectionTypes := iife_result_8
	if var_introspectionTypes.array_isset(rt.new_string(name)) {
		return var_introspectionTypes.array_get(rt.new_string(name))
	}
	mut var_type := this.loadtype(name)
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_type, rt.new_null())))) {
		return this.resolvedTypes.array_set(name,
			Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema.resolvetype(var_type.clone()))
	}
	mut var_scalarOverrides := this.getscalaroverrides()
	if var_scalarOverrides.array_isset(rt.new_string(name)) {
		return this.resolvedTypes.array_set(name,
			var_scalarOverrides.array_get(rt.new_string(name)))
	}
	mut iife_temp_9 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
	mut iife_result_9 := iife_temp_9.builtinscalars()
	mut var_builtInScalars := iife_result_9
	if var_builtInScalars.array_isset(rt.new_string(name)) {
		return this.resolvedTypes.array_set(name, var_builtInScalars.array_get(rt.new_string(name)))
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) hastype(name string) bool {
	return rt.new_bool(!rt.is_true(rt.identical(this.gettype(name), rt.new_null())))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) loadtype(typeName string) rt.PhpVal {
	mut typeName_mutated := typeName
	mut var_typeLoader := rt.get_property(this.config, 'typeLoader')
	if !(!var_typeLoader.is_null()) {
		return if !(this.gettypemap().array_get(rt.new_string(typeName_mutated))).is_null() {
			this.gettypemap().array_get(rt.new_string(typeName_mutated))
		} else {
			rt.new_null()
		}
	}
	mut iife_temp_10 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
	mut iife_result_10 := iife_temp_10.isbuiltinscalarname(rt.new_string(typeName_mutated))
	if rt.is_true(iife_result_10) {
		return rt.new_null()
	}
	mut var_type := rt.call_callable(var_typeLoader, [rt.new_string(typeName_mutated).clone()])
	if rt.is_true(rt.identical(var_type, rt.new_null())) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_type,
		'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type'))))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation',
			[]string{},
			create_automattic_woocommerce_vendor_graphql_error_invariantviolation(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema.typeloadernottype(var_type.clone()))))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(typeName_mutated), rt.get_property(var_type,
		'name')))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation',
			[]string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema.typeloaderwrongtypename(typeName_mutated, (rt.get_property(var_type,
			'name')).str()))))
	}
	return var_type.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) getscalaroverrides() rt.PhpVal {
	if rt.is_true(rt.identical(this.scalarOverrides, rt.new_null())) {
		this.scalarOverrides = rt.new_array()
		mut iife_temp_11 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		mut iife_result_11 := iife_temp_11.builtinscalars()
		mut var_builtInScalars := iife_result_11
		mut iter_6 := this.materializetypes().iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_typeOrLazyType := item_6.val
			mut var_type :=
				Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema.resolvetype(var_typeOrLazyType.clone())
			if rt.is_true(rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ScalarType')))
				&& var_builtInScalars.array_isset(rt.get_property(var_type, 'name'))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_type, var_builtInScalars.array_get(rt.get_property(var_type, 'name')))))) {
				this.scalarOverrides.array_set(rt.get_property(var_type, 'name'), var_type.clone())
			}
		}
	}
	return this.scalarOverrides
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) materializetypes() rt.PhpVal {
	mut var_types := rt.get_property(this.config, 'types')
	if rt.is_true(rt.call_function('is_callable', [var_types.clone()])) {
		var_types = rt.call_callable(var_types, []rt.PhpVal{})
	}
	if !(var_types.clone().is_array()) {
		var_types = rt.call_function('iterator_to_array', [var_types.clone()])
		rt.set_property(this.config, 'types', var_types.clone())
	}
	return var_types.clone()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema.resolvetype(var_type rt.PhpVal) rt.PhpVal {
	mut var_type_mutated := var_type
	if rt.is_true(rt.new_bool(rt.instance_of(var_type_mutated,
		'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type')))
	{
		return var_type_mutated.clone()
	}
	return rt.call_callable(var_type_mutated, []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) getpossibletypes(mut var_abstractType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType',
		[]string{}, var_abstractType),
		'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType')))
	{
		return var_abstractType.gettypes()
	}
	rt.call_function('assert', [
		rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType',
			[]string{}, var_abstractType),
			'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType')),
		rt.new_string('only other option'),
	])
	return rt.call_method(this.getimplementations(mut var_abstractType), 'objects', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) getimplementations(mut var_abstractType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType) rt.PhpVal {
	return this.collectimplementations().array_get(rt.get_property(var_abstractType, 'name'))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) collectimplementations() rt.PhpVal {
	if !(!(this.implementationsMap).is_null()) {
		this.implementationsMap = rt.new_array()
		mut var_foundImplementations := rt.new_array()
		mut iter_7 := this.gettypemap().iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_type := item_7.val
			if rt.is_true(rt.new_bool(rt.instance_of(var_type,
				'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType')))
			{
				if !(var_foundImplementations.array_isset(rt.get_property(var_type, 'name'))) {
					var_foundImplementations.array_set(rt.get_property(var_type, 'name'), rt.create_array([
						rt.ArrayItem{ key: 'objects', val: rt.new_array() },
						rt.ArrayItem{ key: 'interfaces', val: rt.new_array() },
					]))
				}
				mut iter_8 := rt.call_method(var_type, 'getInterfaces', []rt.PhpVal{}).iterator()
				for {
					item_8 := iter_8.next() or { break }
					mut var_iface := item_8.val
					if !(var_foundImplementations.array_isset(rt.get_property(var_iface, 'name'))) {
						var_foundImplementations.array_set(rt.get_property(var_iface, 'name'), rt.create_array([
							rt.ArrayItem{ key: 'objects', val: rt.new_array() },
							rt.ArrayItem{ key: 'interfaces', val: rt.new_array() },
						]))
					}
					var_foundImplementations.array_get_mut(rt.get_property(var_iface, 'name')).array_get_mut('interfaces').array_push(var_type.clone())
				}
			} else if rt.is_true(rt.new_bool(rt.instance_of(var_type,
				'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType')))
			{
				mut iter_9 := rt.call_method(var_type, 'getInterfaces', []rt.PhpVal{}).iterator()
				for {
					item_9 := iter_9.next() or { break }
					mut var_iface := item_9.val
					if !(var_foundImplementations.array_isset(rt.get_property(var_iface, 'name'))) {
						var_foundImplementations.array_set(rt.get_property(var_iface, 'name'), rt.create_array([
							rt.ArrayItem{ key: 'objects', val: rt.new_array() },
							rt.ArrayItem{ key: 'interfaces', val: rt.new_array() },
						]))
					}
					var_foundImplementations.array_get_mut(rt.get_property(var_iface, 'name')).array_get_mut('objects').array_push(var_type.clone())
				}
			}
		}
		mut iter_10 := var_foundImplementations.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_implementations := item_10.val
			mut var_name := item_10.key
			this.implementationsMap.array_set(var_name, create_automattic_woocommerce_vendor_graphql_utils_interfaceimplementations(var_implementations.array_get(rt.new_string('objects')),
				var_implementations.array_get(rt.new_string('interfaces'))))
		}
	}
	return this.implementationsMap
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) issubtype(mut var_abstractType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType, mut var_maybeSubType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType) bool {
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType',
		[]string{}, var_abstractType),
		'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType')))
	{
		return (var_maybeSubType.implementsinterface(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType',
			[]string{}, var_abstractType))).to_bool()
	}
	rt.call_function('assert', [
		rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType',
			[]string{}, var_abstractType),
			'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType')),
		rt.new_string('only other option'),
	])
	return (var_abstractType.ispossibletype(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType',
		[]string{}, var_maybeSubType))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) getdirective(name string) rt.PhpVal {
	mut iter_11 := this.getdirectives().iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_directive := item_11.val
		if rt.is_true(rt.identical(rt.get_property(var_directive, 'name'), rt.new_string(name))) {
			return var_directive.clone()
		}
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) assertvalid() {
	mut var_errors := this.validate()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_errors, rt.new_array())))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation',
			[]string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.call_function('implode', [
			rt.new_string('\n\n'),
			this.validationErrors,
		]))))
	}
	mut iife_temp_12 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
	mut iife_result_12 := iife_temp_12.builtinscalars()
	mut iife_temp_13 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection{}
	mut iife_result_13 := iife_temp_13.gettypes()
	mut var_internalTypes := rt.add(iife_result_12, iife_result_13)
	mut iter_12 := this.gettypemap().iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_type := item_12.val
		mut var_name := item_12.key
		if var_internalTypes.array_isset(var_name) {
			continue
		}
		rt.call_method(var_type, 'assertValid', []rt.PhpVal{})
		if !(rt.get_property(this.config, 'typeLoader')).is_null()
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.loadtype(var_name.str()), var_type)))) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation',
				[]string{},
				create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string('Type loader returns different instance for ${var_name.to_string()} than field/argument definitions. Make sure you always return the same instance for the same type name.'))))
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) validate() rt.PhpVal {
	if !(this.validationErrors).is_null() {
		return this.validationErrors
	}
	mut var_context := create_automattic_woocommerce_vendor_graphql_type_schemavalidationcontext(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Schema',
		[]string{}, &this))
	var_context.validateroottypes()
	var_context.validatedirectives()
	var_context.validatetypes()
	this.validationErrors = var_context.geterrors()
	return this.validationErrors
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Introspection {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_GraphQL {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_InterfaceImplementations {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_type_schema(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema{
		PhpObjectBase:      rt.PhpObjectBase{}
		config:             rt.new_null()
		resolvedTypes:      rt.new_array()
		implementationsMap: rt.new_null()
		fullyLoaded:        false
		scalarOverrides:    rt.new_null()
		validationErrors:   rt.new_null()
		description:        rt.new_null()
		astNode:            rt.new_null()
		extensionASTNodes:  rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_schemaconfig(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaConfig{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_typeinfo(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo{
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

fn create_automattic_woocommerce_vendor_graphql_type_definition_type(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{
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

fn create_automattic_woocommerce_vendor_graphql_utils_interfaceimplementations(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_InterfaceImplementations {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_InterfaceImplementations{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_schemavalidationcontext(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getTypeMap' {
			return this.gettypemap()
		}
		'getDirectives' {
			return this.getdirectives()
		}
		'typeLoaderNotType' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema.typeloadernottype(dispatch_arg_0))
		}
		'typeLoaderWrongTypeName' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema.typeloaderwrongtypename(dispatch_arg_0,
				dispatch_arg_1))
		}
		'getOperationType' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.getoperationtype(dispatch_arg_0)
		}
		'getQueryType' {
			return this.getquerytype()
		}
		'getMutationType' {
			return this.getmutationtype()
		}
		'getSubscriptionType' {
			return this.getsubscriptiontype()
		}
		'getConfig' {
			return this.getconfig()
		}
		'getType' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.gettype(dispatch_arg_0)
		}
		'hasType' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.hastype(dispatch_arg_0))
		}
		'loadType' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.loadtype(dispatch_arg_0)
		}
		'getScalarOverrides' {
			return this.getscalaroverrides()
		}
		'materializeTypes' {
			return this.materializetypes()
		}
		'resolveType' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema.resolvetype(dispatch_arg_0)
		}
		'getPossibleTypes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.getpossibletypes(mut dispatch_arg_0)
		}
		'getImplementations' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InterfaceType](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.getimplementations(mut dispatch_arg_0)
		}
		'collectImplementations' {
			return this.collectimplementations()
		}
		'isSubType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_AbstractType](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.issubtype(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'getDirective' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.getdirective(dispatch_arg_0)
		}
		'assertValid' {
			this.assertvalid()
			return rt.new_null()
		}
		'validate' {
			return this.validate()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'config' { return this.config }
		'resolvedTypes' { return this.resolvedTypes }
		'implementationsMap' { return this.implementationsMap }
		'fullyLoaded' { return rt.new_bool(this.fullyLoaded) }
		'scalarOverrides' { return this.scalarOverrides }
		'validationErrors' { return this.validationErrors }
		'description' { return this.description }
		'astNode' { return this.astNode }
		'extensionASTNodes' { return this.extensionASTNodes }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'config' {
			this.config = val
			return true
		}
		'resolvedTypes' {
			this.resolvedTypes = val
			return true
		}
		'implementationsMap' {
			this.implementationsMap = val
			return true
		}
		'fullyLoaded' {
			this.fullyLoaded = val.to_bool()
			return true
		}
		'scalarOverrides' {
			this.scalarOverrides = val
			return true
		}
		'validationErrors' {
			this.validationErrors = val
			return true
		}
		'description' {
			this.description = val
			return true
		}
		'astNode' {
			this.astNode = val
			return true
		}
		'extensionASTNodes' {
			this.extensionASTNodes = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeInfo) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_InterfaceImplementations) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_InterfaceImplementations) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_InterfaceImplementations) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}
