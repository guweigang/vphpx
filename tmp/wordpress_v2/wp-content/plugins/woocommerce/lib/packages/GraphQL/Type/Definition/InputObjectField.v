import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectField {
	rt.PhpObjectBase
pub mut:
	name              rt.PhpVal = rt.new_null()
	defaultValue      rt.PhpVal = rt.new_null()
	description       rt.PhpVal = rt.new_null()
	deprecationReason rt.PhpVal = rt.new_null()
	prop_type         rt.PhpVal = rt.new_null()
	astNode           rt.PhpVal = rt.new_null()
	config            rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectField) construct(mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array) {
	this.name = var_config.array_get(rt.new_string('name'))
	this.defaultValue = if !(var_config.array_get(rt.new_string('defaultValue'))).is_null() {
		var_config.array_get(rt.new_string('defaultValue'))
	} else {
		rt.new_null()
	}
	this.description = if !(var_config.array_get(rt.new_string('description'))).is_null() {
		var_config.array_get(rt.new_string('description'))
	} else {
		rt.new_null()
	}
	this.deprecationReason = if !(var_config.array_get(rt.new_string('deprecationReason'))).is_null() {
		var_config.array_get(rt.new_string('deprecationReason'))
	} else {
		rt.new_null()
	}
	this.astNode = if !(var_config.array_get(rt.new_string('astNode'))).is_null() {
		var_config.array_get(rt.new_string('astNode'))
	} else {
		rt.new_null()
	}
	this.config = var_config
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectField) gettype() rt.PhpVal {
	if !(!(this.prop_type).is_null()) {
		mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema{}
		mut iife_result_0 := iife_temp_0.resolvetype(this.config.array_get(rt.new_string('type')))
		this.prop_type = iife_result_0
	}
	return this.prop_type
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectField) defaultvalueexists() bool {
	return this.config.array_isset(rt.new_string('defaultValue'))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectField) isrequired() bool {
	return
		rt.is_true(rt.new_bool(rt.instance_of(this.gettype(), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull')))
		&& !(this.defaultvalueexists())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectField) isdeprecated() bool {
	return (this.deprecationReason).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectField) assertvalid(mut var_parentType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
	mut iife_result_1 := iife_temp_1.isvalidnameerror(this.name)
	mut var_error := iife_result_1
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_error, rt.new_null())))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation',
			[]string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.concat(rt.concat(rt.get_property(var_parentType,
			'name'), rt.new_string('.')), this.name), rt.new_string(': ')), rt.call_method(var_error,
			'getMessage', []rt.PhpVal{})))))
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
	mut iife_result_2 := iife_temp_2.getnamedtype(this.gettype())
	mut var_type := iife_result_2
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_type,
		'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputType'))))))
	{
		mut iife_temp_3 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_3 := iife_temp_3.printsafe(this.prop_type)
		mut var_notInputType := iife_result_3
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation',
			[]string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.concat(rt.concat(rt.get_property(var_parentType,
			'name'), rt.new_string('.')), this.name),
			rt.new_string(' field type must be Input Type but got: ')), var_notInputType))))
	}
	if rt.is_true(rt.new_bool(this.config.array_isset(rt.new_string('resolve')))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation',
			[]string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.concat(rt.get_property(var_parentType,
			'name'), rt.new_string('.')), this.name),
			rt.new_string(' field has a resolve property, but Input Types cannot define resolvers.')))))
	}
	if this.isrequired() && this.isdeprecated() {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation',
			[]string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Required input field '), rt.get_property(var_parentType,
			'name')), rt.new_string('.')), this.name), rt.new_string(' cannot be deprecated.')))))
	}
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema {
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

fn create_automattic_woocommerce_vendor_graphql_type_definition_inputobjectfield(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectField {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectField{
		PhpObjectBase:     rt.PhpObjectBase{}
		name:              rt.new_null()
		defaultValue:      rt.new_null()
		description:       rt.new_null()
		deprecationReason: rt.new_null()
		prop_type:         rt.new_null()
		astNode:           rt.new_null()
		config:            rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_schema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema{
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectField) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'getType' {
			return this.gettype()
		}
		'defaultValueExists' {
			return rt.new_bool(this.defaultvalueexists())
		}
		'isRequired' {
			return rt.new_bool(this.isrequired())
		}
		'isDeprecated' {
			return rt.new_bool(this.isdeprecated())
		}
		'assertValid' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.assertvalid(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectField) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'defaultValue' { return this.defaultValue }
		'description' { return this.description }
		'deprecationReason' { return this.deprecationReason }
		'type' { return this.prop_type }
		'astNode' { return this.astNode }
		'config' { return this.config }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectField) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' {
			this.name = val
			return true
		}
		'defaultValue' {
			this.defaultValue = val
			return true
		}
		'description' {
			this.description = val
			return true
		}
		'deprecationReason' {
			this.deprecationReason = val
			return true
		}
		'type' {
			this.prop_type = val
			return true
		}
		'astNode' {
			this.astNode = val
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
