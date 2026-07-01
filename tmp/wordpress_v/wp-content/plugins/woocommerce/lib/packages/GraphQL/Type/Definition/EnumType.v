import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType {
	rt.PhpObjectBase
pub mut:
		astNode rt.PhpVal = rt.new_null()
		extensionASTNodes rt.PhpVal = rt.new_null()
		config rt.PhpVal = rt.new_null()
		values rt.PhpVal = rt.new_null()
		valueLookup rt.PhpVal = rt.new_null()
		nameLookup rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) construct(mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array)  {
	this.dispatch_set_prop('name', if !(var_config.array_get('name')).is_null() { var_config.array_get('name') } else { this.infername() })
	this.dispatch_set_prop('description', if !(var_config.array_get('description')).is_null() { var_config.array_get('description') } else { rt.new_null() })
	this.astNode = if !(var_config.array_get('astNode')).is_null() { var_config.array_get('astNode') } else { rt.new_null() }
	this.extensionASTNodes = if !(var_config.array_get('extensionASTNodes')).is_null() { var_config.array_get('extensionASTNodes') } else { rt.new_array() }
	this.config = var_config.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) getvalue(name string) rt.PhpVal {
	mut name_mutated := name
	if !(!(this.nameLookup).is_null()) {
		this.initializenamelookup()
	}
	return if !(this.nameLookup.array_get(name_mutated)).is_null() { this.nameLookup.array_get(name_mutated) } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) getvalues() rt.PhpVal {
	if !(!(this.values).is_null()) {
		this.values = rt.new_array()
		mut var_values := this.config.array_get('values')
		if rt.is_true(rt.call_function('is_callable', [var_values.dup()])) {
			var_values = rt.call_callable(var_values, []rt.PhpVal{})
		}
		{
			mut iter_1 := var_values.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_name := item_1.key
				if rt.is_true(rt.new_bool(var_name.dup().is_string())) {
					if rt.is_true(rt.new_bool(var_value.dup().is_array())) {
						// unsupported expression: Expr_AssignOp_Plus
					} else {
						var_value = rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'value', val: var_value }])
					}
				} else if rt.is_true(rt.new_bool(var_value.dup().is_string())) {
					var_value = rt.create_array([rt.ArrayItem{ key: 'name', val: var_value }, rt.ArrayItem{ key: 'value', val: var_value }])
				} else {
					rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType', ['Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', 'InputType', 'OutputType', 'LeafType', 'NullableType', 'NamedType'], &this), 'name'), rt.new_string(' values must be an array with value names as keys or values.')))))
				}
				this.values.array_push(create_automattic_woocommerce_vendor_graphql_type_definition_enumvaluedefinition(var_value.dup()))
			}
		}
	}
	return this.values
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) serialize(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_lookup := this.getvaluelookup()
	if var_lookup.array_isset(var_value_mutated) {
		return rt.get_property(var_lookup.array_get(var_value_mutated), 'name')
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_value_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_BackedEnum'))) {
		return rt.get_property(var_value_mutated, 'name')
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_value_mutated, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnitEnum'))) {
		return rt.get_property(var_value_mutated, 'name')
	}
	mut var_safeValue := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(var_value_mutated.dup())
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_SerializationError', []string{}, create_automattic_woocommerce_vendor_graphql_error_serializationerror(rt.new_string("Cannot serialize value as enum: ${var_safeValue.to_string()}"))))
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) getvaluelookup() rt.PhpVal {
	if !(!(this.valueLookup).is_null()) {
		this.valueLookup = create_automattic_woocommerce_vendor_graphql_utils_mixedstore()
		{
			mut iter_1 := this.getvalues().iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				rt.call_method(this.valueLookup, 'offsetSet', [rt.get_property(var_value, 'value'), var_value.dup()])
			}
		}
	}
	return this.valueLookup
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) parsevalue(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_string()))))) {
		mut var_safeValue := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafejson(arg_0) }(var_value_mutated.dup())
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Enum "'), rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType', ['Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', 'InputType', 'OutputType', 'LeafType', 'NullableType', 'NamedType'], &this), 'name')), rt.new_string('" cannot represent non-string value: ')), var_safeValue), rt.new_string('.')), this.didyoumean((var_safeValue).str())))))
	}
	if !(!(this.nameLookup).is_null()) {
		this.initializenamelookup()
	}
	if !(this.nameLookup.array_isset(var_value_mutated)) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Value "'), var_value_mutated), rt.new_string('" does not exist in "')), rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType', ['Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', 'InputType', 'OutputType', 'LeafType', 'NullableType', 'NamedType'], &this), 'name')), rt.new_string('" enum.')), this.didyoumean((var_value_mutated).str())))))
	}
	return rt.get_property(this.nameLookup.array_get(var_value_mutated), 'value')
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) parseliteral(mut var_valueNode Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node, mut var_variables Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_?array) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_valueNode), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueNode')))))) {
		mut var_valueStr := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{}; return temp.doprint(arg_0) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_valueNode))
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Enum "'), rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType', ['Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', 'InputType', 'OutputType', 'LeafType', 'NullableType', 'NamedType'], &this), 'name')), rt.new_string('" cannot represent non-enum value: ')), var_valueStr), rt.new_string('.')), this.didyoumean((var_valueStr).str())), var_valueNode.dup())))
	}
	mut var_name := rt.get_property(var_valueNode, 'value')
	if !(!(this.nameLookup).is_null()) {
		this.initializenamelookup()
	}
	if this.nameLookup.array_isset(var_name) {
		return rt.get_property(this.nameLookup.array_get(var_name), 'value')
	}
	var_valueStr = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{}; return temp.doprint(arg_0) }(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node', []string{}, var_valueNode))
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_Error', []string{}, create_automattic_woocommerce_vendor_graphql_error_error(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Value "'), var_valueStr), rt.new_string('" does not exist in "')), rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType', ['Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', 'InputType', 'OutputType', 'LeafType', 'NullableType', 'NamedType'], &this), 'name')), rt.new_string('" enum.')), this.didyoumean((var_valueStr).str())), var_valueNode.dup())))
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) assertvalid()  {
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.assertvalidname(arg_0) }(rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType', ['Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', 'InputType', 'OutputType', 'LeafType', 'NullableType', 'NamedType'], &this), 'name'))
	mut var_values := if !(this.config.array_get('values')).is_null() { this.config.array_get('values') } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_iterable', [var_values.dup()]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [var_values.dup()]))))))) {
		mut var_notIterable := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.printsafe(arg_0) }(var_values.dup())
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType', ['Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', 'InputType', 'OutputType', 'LeafType', 'NullableType', 'NamedType'], &this), 'name'), rt.new_string(' values must be an iterable or callable, got: ')), var_notIterable))))
	}
	this.getvalues()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) initializenamelookup()  {
	this.nameLookup = rt.new_array()
	{
		mut iter_1 := this.getvalues().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			this.nameLookup.array_set(rt.get_property(var_value, 'name'), var_value.dup())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) didyoumean(unknownValue string) string {
	mut var_value := rt.new_null()
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.get_property(var_value, 'name')
	}
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.get_property(var_value, 'name')
	}
	mut var_suggestions := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.suggestionlist(arg_0, arg_1) }(rt.new_string(unknownValue), rt.call_function('array_map', [rt.new_closure(closure_1_fn), this.getvalues()]))
	return (if rt.is_true(rt.identical(var_suggestions, rt.new_array())) { rt.new_null() } else { ' Did you mean the enum value ' + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}; return temp.quotedorlist(arg_0) }(var_suggestions.dup())).str() + '?' }).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) astnode() rt.PhpVal {
	return this.astNode
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) extensionastnodes() rt.PhpVal {
	return this.extensionASTNodes
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumValueDefinition {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SerializationError {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_MixedStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_enumtype(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType{
		PhpObjectBase: rt.PhpObjectBase{}
		astNode: rt.new_null()
		extensionASTNodes: rt.new_null()
		config: rt.new_null()
		values: rt.new_null()
		valueLookup: rt.new_null()
		nameLookup: rt.new_null()
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

fn create_automattic_woocommerce_vendor_graphql_type_definition_enumvaluedefinition() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumValueDefinition {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumValueDefinition{
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

fn create_automattic_woocommerce_vendor_graphql_error_serializationerror() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SerializationError {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SerializationError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_mixedstore() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_MixedStore {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_MixedStore{
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

fn create_automattic_woocommerce_vendor_graphql_language_printer() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getValue' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.getvalue(dispatch_arg_0)
		}
		'getValues' {
			return this.getvalues()
		}
		'serialize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.serialize(dispatch_arg_0)
		}
		'getValueLookup' {
			return this.getvaluelookup()
		}
		'parseValue' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parsevalue(dispatch_arg_0)
		}
		'parseLiteral' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.parseliteral(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'assertValid' {
			this.assertvalid()
			return rt.new_null()
		}
		'initializeNameLookup' {
			this.initializenamelookup()
			return rt.new_null()
		}
		'didYouMean' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.didyoumean(dispatch_arg_0))
		}
		'astNode' {
			return this.astnode()
		}
		'extensionASTNodes' {
			return this.extensionastnodes()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'astNode' { return this.astNode }
		'extensionASTNodes' { return this.extensionASTNodes }
		'config' { return this.config }
		'values' { return this.values }
		'valueLookup' { return this.valueLookup }
		'nameLookup' { return this.nameLookup }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'astNode' { this.astNode = val; return true }
		'extensionASTNodes' { this.extensionASTNodes = val; return true }
		'config' { this.config = val; return true }
		'values' { this.values = val; return true }
		'valueLookup' { this.valueLookup = val; return true }
		'nameLookup' { this.nameLookup = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumValueDefinition) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumValueDefinition) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_EnumValueDefinition) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SerializationError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SerializationError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SerializationError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_MixedStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_MixedStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_MixedStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_type_definition_enumtype_php() {
	// unsupported statement: Stmt_Declare
}
