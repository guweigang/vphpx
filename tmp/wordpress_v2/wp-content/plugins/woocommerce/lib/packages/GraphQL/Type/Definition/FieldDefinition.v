import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition {
	rt.PhpObjectBase
pub mut:
		name rt.PhpVal = rt.new_null()
		args rt.PhpVal = rt.new_null()
		argsMapper rt.PhpVal = rt.new_null()
		resolveFn rt.PhpVal = rt.new_null()
		description rt.PhpVal = rt.new_null()
		visible rt.PhpVal = rt.new_null()
		deprecationReason rt.PhpVal = rt.new_null()
		astNode rt.PhpVal = rt.new_null()
		complexityFn rt.PhpVal = rt.new_null()
		config rt.PhpVal = rt.new_null()
		prop_type rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition) construct(mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array) {
	this.name = var_config.array_get(rt.new_string('name'))
	this.resolveFn = if !(var_config.array_get(rt.new_string('resolve'))).is_null() { var_config.array_get(rt.new_string('resolve')) } else { rt.new_null() }
	mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument{}
	mut iife_result_0 := iife_temp_0.listfromconfig(var_config.array_get(rt.new_string('args')))
	this.args = if var_config.array_isset(rt.new_string('args')) { iife_result_0 } else { rt.new_array() }
	this.argsMapper = if !(var_config.array_get(rt.new_string('argsMapper'))).is_null() { var_config.array_get(rt.new_string('argsMapper')) } else { rt.new_null() }
	this.description = if !(var_config.array_get(rt.new_string('description'))).is_null() { var_config.array_get(rt.new_string('description')) } else { rt.new_null() }
	this.visible = if !(var_config.array_get(rt.new_string('visible'))).is_null() { var_config.array_get(rt.new_string('visible')) } else { rt.new_bool(true) }
	this.deprecationReason = if !(var_config.array_get(rt.new_string('deprecationReason'))).is_null() { var_config.array_get(rt.new_string('deprecationReason')) } else { rt.new_null() }
	this.astNode = if !(var_config.array_get(rt.new_string('astNode'))).is_null() { var_config.array_get(rt.new_string('astNode')) } else { rt.new_null() }
	this.complexityFn = if !(var_config.array_get(rt.new_string('complexity'))).is_null() { var_config.array_get(rt.new_string('complexity')) } else { rt.new_null() }
	this.config = var_config
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition.definefieldmap(mut var_parentType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, var_fields rt.PhpVal) rt.PhpVal {
	mut var_fields_mutated := var_fields
	if rt.is_true(rt.call_function('is_callable', [var_fields_mutated.clone()])) {
	var_fields_mutated = rt.call_callable(var_fields_mutated, []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_iterable', [var_fields_mutated.clone()]))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.get_property(var_parentType, 'name'), rt.new_string(' fields must be an iterable or a callable which returns such an iterable.')))))
	}
	mut var_map := rt.new_array()
	mut iter_1 := var_fields_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_field := item_1.val
		mut var_maybeName := item_1.key
		if rt.is_true(rt.new_bool(var_field.clone().is_array())) {
			if !(var_field.array_isset(rt.new_string('name'))) {
				if !(var_maybeName.clone().is_string()) {
					rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.get_property(var_parentType, 'name'), rt.new_string(' fields must be an associative array with field names as keys or a function which returns such an array.')))))
				}
				var_field.array_set('name', var_maybeName.clone())
			}
		mut var_fieldDef := create_automattic_woocommerce_vendor_graphql_type_definition_self(var_field.clone())
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_field, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_self'))) {
		var_fieldDef = var_field.clone()
		} else if rt.is_true(rt.call_function('is_callable', [var_field.clone()])) {
			if !(var_maybeName.clone().is_string()) {
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.get_property(var_parentType, 'name'), rt.new_string(' lazy fields must be an associative array with field names as keys.')))))
			}
		var_fieldDef = create_automattic_woocommerce_vendor_graphql_type_definition_unresolvedfielddefinition(var_maybeName.clone(), var_field.clone())
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_field, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type'))) {
		var_fieldDef = create_automattic_woocommerce_vendor_graphql_type_definition_self(rt.create_array([rt.ArrayItem{ key: 'name', val: var_maybeName }, rt.ArrayItem{ key: 'type', val: var_field }]))
		} else {
			mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
			mut iife_result_1 := iife_temp_1.printsafe(var_field.clone())
			mut var_invalidFieldConfig := iife_result_1
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.concat(rt.concat(rt.get_property(var_parentType, 'name'), rt.new_string('.')), var_maybeName), rt.new_string(' field config must be an array, but got: ')), var_invalidFieldConfig))))
		}
		var_map.array_set(rt.call_method(var_fieldDef, 'getName', []rt.PhpVal{}), var_fieldDef.clone())
	}
	return var_map.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition) getarg(name string) rt.PhpVal {
	mut iter_2 := this.args.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_arg := item_2.val
		if rt.is_true(rt.identical(rt.get_property(var_arg, 'name'), rt.new_string(name))) {
			return var_arg.clone()
		}
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition) getname() string {
	return (this.name).str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition) gettype() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition) isvisible() bool {
	if rt.is_true(rt.new_bool(this.visible.is_bool())) {
		return (this.visible).to_bool()
	}
	return (this.visible = rt.call_callable(this.visible, []rt.PhpVal{})).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition) isdeprecated() bool {
	return (this.deprecationReason).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition) assertvalid(mut var_parentType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) {
	mut iife_temp_2 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
	mut iife_result_2 := iife_temp_2.isvalidnameerror(this.name)
	mut var_error := iife_result_2
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_error, rt.new_null())))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.concat(rt.concat(rt.get_property(var_parentType, 'name'), rt.new_string('.')), this.name), rt.new_string(': ')), rt.call_method(var_error, 'getMessage', []rt.PhpVal{})))))
	}
	mut iife_temp_3 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
	mut iife_result_3 := iife_temp_3.getnamedtype(this.gettype())
	mut var_type := iife_result_3
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_type, 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_OutputType')))))) {
		mut iife_temp_4 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_4 := iife_temp_4.printsafe(this.prop_type)
		mut var_safeType := iife_result_4
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.get_property(var_parentType, 'name'), rt.new_string('.')), this.name), rt.new_string(' field type must be Output Type but got: ')), var_safeType), rt.new_string('.')))))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.resolveFn, rt.new_null())))) && !(rt.call_function('is_callable', [this.resolveFn])) {
		mut iife_temp_5 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_5 := iife_temp_5.printsafe(this.resolveFn)
		mut var_safeResolveFn := iife_result_5
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation', []string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.get_property(var_parentType, 'name'), rt.new_string('.')), this.name), rt.new_string(' field resolver must be a function if provided, but got: ')), var_safeResolveFn), rt.new_string('.')))))
	}
	mut iter_3 := this.args.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_fieldArgument := item_3.val
		rt.call_method(var_fieldArgument, 'assertValid', [rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition', []string{}, &this), var_type.clone()])
	}
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_self {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnresolvedFieldDefinition {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_fielddefinition(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition{
		PhpObjectBase: rt.PhpObjectBase{}
		name: rt.new_null()
		args: rt.new_null()
		argsMapper: rt.new_null()
		resolveFn: rt.new_null()
		description: rt.new_null()
		visible: rt.new_null()
		deprecationReason: rt.new_null()
		astNode: rt.new_null()
		complexityFn: rt.new_null()
		config: rt.new_null()
		prop_type: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_argument(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument{
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

fn create_automattic_woocommerce_vendor_graphql_type_definition_self(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_self {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_unresolvedfielddefinition(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnresolvedFieldDefinition {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnresolvedFieldDefinition{
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'defineFieldMap' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition.definefieldmap(mut dispatch_arg_0, dispatch_arg_1)
		}
		'getArg' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.getarg(dispatch_arg_0)
		}
		'getName' {
			return rt.new_string(this.getname())
		}
		'getType' {
			return this.gettype()
		}
		'isVisible' {
			return rt.new_bool(this.isvisible())
		}
		'isDeprecated' {
			return rt.new_bool(this.isdeprecated())
		}
		'assertValid' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 { args[0] } else { rt.new_null() })
			this.assertvalid(mut dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'args' { return this.args }
		'argsMapper' { return this.argsMapper }
		'resolveFn' { return this.resolveFn }
		'description' { return this.description }
		'visible' { return this.visible }
		'deprecationReason' { return this.deprecationReason }
		'astNode' { return this.astNode }
		'complexityFn' { return this.complexityFn }
		'config' { return this.config }
		'type' { return this.prop_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_FieldDefinition) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' { this.name = val; return true }
		'args' { this.args = val; return true }
		'argsMapper' { this.argsMapper = val; return true }
		'resolveFn' { this.resolveFn = val; return true }
		'description' { this.description = val; return true }
		'visible' { this.visible = val; return true }
		'deprecationReason' { this.deprecationReason = val; return true }
		'astNode' { this.astNode = val; return true }
		'complexityFn' { this.complexityFn = val; return true }
		'config' { this.config = val; return true }
		'type' { this.prop_type = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnresolvedFieldDefinition) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnresolvedFieldDefinition) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnresolvedFieldDefinition) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
