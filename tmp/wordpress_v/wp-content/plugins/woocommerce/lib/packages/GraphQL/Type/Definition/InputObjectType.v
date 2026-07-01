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
	this.dispatch_set_prop('name', if !(var_config.array_get('name')).is_null() {
		var_config.array_get('name')
	} else {
		this.infername()
	})
	this.dispatch_set_prop('description', if !(var_config.array_get('description')).is_null() {
		var_config.array_get('description')
	} else {
		rt.new_null()
	})
	this.isOneOf = if !(var_config.array_get('isOneOf')).is_null() {
		var_config.array_get('isOneOf')
	} else {
		rt.new_bool(false)
	}
	this.parseValue = if !(var_config.array_get('parseValue')).is_null() {
		var_config.array_get('parseValue')
	} else {
		rt.new_null()
	}
	this.astNode = if !(var_config.array_get('astNode')).is_null() {
		var_config.array_get('astNode')
	} else {
		rt.new_null()
	}
	this.extensionASTNodes = if !(var_config.array_get('extensionASTNodes')).is_null() {
		var_config.array_get('extensionASTNodes')
	} else {
		rt.new_array()
	}
	this.config = var_config.dup()
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
	return var_field.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) findfield(name string) rt.PhpVal {
	if !(!(this.fields).is_null()) {
		this.initializefields()
	}
	return if !(this.fields.array_get(name)).is_null() {
		this.fields.array_get(name)
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
	mut var_fields := this.config.array_get('fields')
	if rt.is_true(rt.call_function('is_callable', [var_fields.dup()])) {
		var_fields = rt.call_callable(var_fields, []rt.PhpVal{})
	}
	this.fields = rt.new_array()
	{
		mut iter_1 := var_fields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			mut var_nameOrIndex := item_1.key
			this.initializefield(var_nameOrIndex.dup(), var_field.dup())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) initializefield(var_nameOrIndex rt.PhpVal, var_field rt.PhpVal) {
	mut var_field_mutated := var_field
	if rt.is_true(rt.call_function('is_callable', [var_field_mutated.dup()])) {
		var_field_mutated = rt.call_callable(var_field_mutated, []rt.PhpVal{})
	}
	rt.call_function('assert', [
		rt.new_bool(
			rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_field_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type')))
			|| rt.is_true(rt.new_bool(var_field_mutated.dup().is_array()))))
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
		rt.new_bool(rt.is_true(rt.new_bool(var_field_mutated.dup().is_array()))
			|| rt.is_true(rt.new_bool(rt.instance_of(var_field_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectField')))),
	])
	if rt.is_true(rt.new_bool(var_field_mutated.dup().is_array())) {
		// unsupported expression: Expr_AssignOp_Coalesce
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_field_mutated.array_get('name').is_string()))))) {
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
			create_automattic_woocommerce_vendor_graphql_type_definition_inputobjectfield(var_field_mutated.dup())
		// unsupported statement: Stmt_Nop
	}
	rt.call_function('assert', [
		rt.new_bool(rt.instance_of(var_field_mutated,
			'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectField')),
	])
	this.fields.array_set(rt.get_property(var_field_mutated, 'name'), var_field_mutated.dup())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) parsevalue(mut var_value Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array) rt.PhpVal {
	if !(this.parseValue).is_null() {
		return rt.call_callable(this.parseValue, [var_value])
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array', []string{},
		var_value)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) assertvalid() {
	fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		return temp.assertvalidname(arg_0)
	}(rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType', [
		'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
		'InputType',
		'NullableType',
		'NamedType',
	], &this), 'name'))
	mut var_fields := if !(this.config.array_get('fields')).is_null() {
		this.config.array_get('fields')
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.call_function('is_callable', [var_fields.dup()])) {
		var_fields = rt.call_callable(var_fields, []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_iterable', [
		var_fields.dup()])))))
	{
		mut var_invalidFields := fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
			return temp.printsafe(arg_0)
		}(var_fields.dup())
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
	{
		mut iter_1 := var_resolvedFields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			rt.call_method(var_field, 'assertValid', [
				rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType', [
					'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
					'InputType',
					'NullableType',
					'NamedType',
				], &this),
			])
		}
	}
	if this.isoneof() {
		this.validateoneofconstraints(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](var_resolvedFields))
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) validateoneofconstraints(mut var_fields Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array) {
	mut var_fields_mutated := var_fields
	if var_fields_mutated.dup().array_count() == 0 {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation',
			[]string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.new_string('OneOf input object type '), rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType', [
			'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
			'InputType',
			'NullableType',
			'NamedType',
		], &this), 'name')), rt.new_string(' must define one or more fields.')))))
	}
	{
		mut iter_1 := var_fields_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			mut var_fieldName := item_1.key
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

fn create_automattic_woocommerce_vendor_graphql_type_definition_type() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_invariantviolation() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_inputobjectfield() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectField {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectField{
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

pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_type_definition_inputobjecttype_php() {
	// unsupported statement: Stmt_Declare
}
