import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType {
	rt.PhpObjectBase
pub mut:
	isOneOf           rt.PhpVal = rt.new_null()
	fields            rt.PhpVal = rt.new_null()
	parseValue        rt.PhpVal = rt.new_null()
	astNode           rt.PhpVal = rt.new_null()
	extensionASTNodes rt.PhpVal = rt.new_null()
	config            rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) construct(mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array) {
	this.dispatch_set_prop('name', if !(var_config.array_get(rt.new_string('name'))).is_null() {
		var_config.array_get(rt.new_string('name'))
	} else {
		this.infername()
	})
	this.dispatch_set_prop('description', if !(var_config.array_get(rt.new_string('description'))).is_null() {
		var_config.array_get(rt.new_string('description'))
	} else {
		rt.new_null()
	})
	this.isOneOf = if !(var_config.array_get(rt.new_string('isOneOf'))).is_null() {
		var_config.array_get(rt.new_string('isOneOf'))
	} else {
		rt.new_bool(false)
	}
	this.parseValue = if !(var_config.array_get(rt.new_string('parseValue'))).is_null() {
		var_config.array_get(rt.new_string('parseValue'))
	} else {
		rt.new_null()
	}
	this.astNode = if !(var_config.array_get(rt.new_string('astNode'))).is_null() {
		var_config.array_get(rt.new_string('astNode'))
	} else {
		rt.new_null()
	}
	this.extensionASTNodes = if !(var_config.array_get(rt.new_string('extensionASTNodes'))).is_null() {
		var_config.array_get(rt.new_string('extensionASTNodes'))
	} else {
		rt.new_array()
	}
	this.config = var_config
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) getfield(name string) rt.PhpVal {
	mut var_field := this.findfield(name)
	if rt.is_true(rt.identical(var_field, rt.new_null())) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation',
			[]string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Field "'),
			rt.new_string(name)), rt.new_string('" is not defined for type "')), rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType', [
			'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
			'InputType',
			'NullableType',
			'NamedType',
		], &this), 'name')), rt.new_string('"')))))
	}
	return var_field.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) findfield(name string) rt.PhpVal {
	if !(!(this.fields).is_null()) {
		this.initializefields()
	}
	return if !(this.fields.array_get(rt.new_string(name))).is_null() {
		this.fields.array_get(rt.new_string(name))
	} else {
		rt.new_null()
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) hasfield(name string) bool {
	if !(!(this.fields).is_null()) {
		this.initializefields()
	}
	return (rt.new_bool(this.fields.array_isset(rt.new_string(name)))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) isoneof() bool {
	return (this.isOneOf).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) getfields() rt.PhpVal {
	if !(!(this.fields).is_null()) {
		this.initializefields()
	}
	return this.fields
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) initializefields() {
	mut var_fields := this.config.array_get(rt.new_string('fields'))
	if rt.is_true(rt.call_function('is_callable', [var_fields.clone()])) {
		var_fields = rt.call_callable(var_fields, []rt.PhpVal{})
	}
	this.fields = rt.new_array()
	mut iter_1 := var_fields.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_field := item_1.val
		mut var_nameOrIndex := item_1.key
		this.initializefield(var_nameOrIndex.clone(), var_field.clone())
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) initializefield(var_nameOrIndex rt.PhpVal, var_field rt.PhpVal) {
	mut var_field_mutated := var_field
	if rt.is_true(rt.call_function('is_callable', [var_field_mutated.clone()])) {
		var_field_mutated = rt.call_callable(var_field_mutated, []rt.PhpVal{})
	}
	rt.call_function('assert', [
		rt.new_bool(
			rt.is_true(rt.new_bool(rt.instance_of(var_field_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type')))
			|| var_field_mutated.clone().is_array()
			|| rt.is_true(rt.new_bool(rt.instance_of(var_field_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectField')))),
	])
	if rt.is_true(rt.new_bool(rt.instance_of(var_field_mutated,
		'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type')))
	{
		var_field_mutated = rt.create_array([
			rt.ArrayItem{ key: 'type', val: var_field_mutated },
		])
	}
	rt.call_function('assert', [
		rt.new_bool(var_field_mutated.clone().is_array()
			|| rt.is_true(rt.new_bool(rt.instance_of(var_field_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectField')))),
	])
	if rt.is_true(rt.new_bool(var_field_mutated.clone().is_array())) {
		rt.new_null()
		if !(var_field_mutated.array_get(rt.new_string('name')).is_string()) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation',
				[]string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType', [
				'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
				'InputType',
				'NullableType',
				'NamedType',
			], &this), 'name'),
				rt.new_string(' fields must be an associative array with field names as keys, an array of arrays with a name attribute, or a callable which returns one of those.')))))
		}
		var_field_mutated =
			create_automattic_woocommerce_vendor_graphql_type_definition_inputobjectfield(var_field_mutated.clone())
	}
	rt.call_function('assert', [
		rt.new_bool(rt.instance_of(var_field_mutated,
			'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectField')),
	])
	this.fields.array_set(rt.get_property(var_field_mutated, 'name'), var_field_mutated.clone())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) parsevalue(mut var_value Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array) rt.PhpVal {
	if !(this.parseValue).is_null() {
		return rt.call_callable(this.parseValue, [var_value])
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array', []string{},
		var_value)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) assertvalid() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
	mut iife_result_0 := iife_temp_0.assertvalidname(rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType', [
		'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
		'InputType',
		'NullableType',
		'NamedType',
	], &this), 'name'))
	mut var_fields := if !(this.config.array_get(rt.new_string('fields'))).is_null() {
		this.config.array_get(rt.new_string('fields'))
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.call_function('is_callable', [var_fields.clone()])) {
		var_fields = rt.call_callable(var_fields, []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_iterable', [
		var_fields.clone()])))))
	{
		mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_1 := iife_temp_1.printsafe(var_fields.clone())
		mut var_invalidFields := iife_result_1
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation',
			[]string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.concat(rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType', [
			'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
			'InputType',
			'NullableType',
			'NamedType',
		], &this), 'name'),
			rt.new_string(' fields must be an iterable or a callable which returns an iterable, got: ')),
			var_invalidFields), rt.new_string('.')))))
	}
	mut var_resolvedFields := this.getfields()
	mut iter_2 := var_resolvedFields.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_field := item_2.val
		rt.call_method(var_field, 'assertValid', [
			rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType', [
				'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
				'InputType',
				'NullableType',
				'NamedType',
			], &this),
		])
	}
	if this.isoneof() {
		this.validateoneofconstraints(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](var_resolvedFields))
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) validateoneofconstraints(mut var_fields Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array) {
	mut var_fields_mutated := var_fields
	if var_fields_mutated.array_count() == 0 {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation',
			[]string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.new_string('OneOf input object type '), rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType', [
			'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
			'InputType',
			'NullableType',
			'NamedType',
		], &this), 'name')), rt.new_string(' must define one or more fields.')))))
	}
	mut iter_3 := var_fields_mutated.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_field := item_3.val
		mut var_fieldName := item_3.key
		mut var_fieldType := rt.call_method(var_field, 'getType', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(rt.instance_of(var_fieldType,
			'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull')))
		{
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation',
				[]string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('OneOf input object type '), rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType', [
				'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
				'InputType',
				'NullableType',
				'NamedType',
			], &this), 'name')), rt.new_string(' field ')), var_fieldName),
				rt.new_string(' must be nullable.')))))
		}
		if rt.is_true(rt.call_method(var_field, 'defaultValueExists', []rt.PhpVal{})) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation',
				[]string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('OneOf input object type '), rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType', [
				'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
				'InputType',
				'NullableType',
				'NamedType',
			], &this), 'name')), rt.new_string(' field ')), var_fieldName),
				rt.new_string(' cannot have a default value.')))))
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) astnode() rt.PhpVal {
	return this.astNode
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) extensionastnodes() rt.PhpVal {
	return this.extensionASTNodes
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectField {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_inputobjecttype(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType{
		PhpObjectBase:     rt.PhpObjectBase{}
		isOneOf:           rt.new_null()
		fields:            rt.new_null()
		parseValue:        rt.new_null()
		astNode:           rt.new_null()
		extensionASTNodes: rt.new_null()
		config:            rt.new_null()
	}
	obj.construct(arg_0)
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

fn create_automattic_woocommerce_vendor_graphql_type_definition_inputobjectfield(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectField {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectField{
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getField' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.getfield(dispatch_arg_0)
		}
		'findField' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.findfield(dispatch_arg_0)
		}
		'hasField' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.hasfield(dispatch_arg_0))
		}
		'isOneOf' {
			return rt.new_bool(this.isoneof())
		}
		'getFields' {
			return this.getfields()
		}
		'initializeFields' {
			this.initializefields()
			return rt.new_null()
		}
		'initializeField' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.initializefield(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'parseValue' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.parsevalue(mut dispatch_arg_0)
		}
		'assertValid' {
			this.assertvalid()
			return rt.new_null()
		}
		'validateOneOfConstraints' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.validateoneofconstraints(mut dispatch_arg_0)
			return rt.new_null()
		}
		'astNode' {
			return this.astnode()
		}
		'extensionASTNodes' {
			return this.extensionastnodes()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'isOneOf' { return this.isOneOf }
		'fields' { return this.fields }
		'parseValue' { return this.parseValue }
		'astNode' { return this.astNode }
		'extensionASTNodes' { return this.extensionASTNodes }
		'config' { return this.config }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'isOneOf' {
			this.isOneOf = val
			return true
		}
		'fields' {
			this.fields = val
			return true
		}
		'parseValue' {
			this.parseValue = val
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
		'config' {
			this.config = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectField) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectField) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectField) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
