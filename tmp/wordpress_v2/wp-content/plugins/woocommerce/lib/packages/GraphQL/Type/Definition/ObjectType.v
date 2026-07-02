import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType {
	rt.PhpObjectBase
pub mut:
	astNode           rt.PhpVal = rt.new_null()
	extensionASTNodes rt.PhpVal = rt.new_null()
	resolveFieldFn    rt.PhpVal = rt.new_null()
	argsMapper        rt.PhpVal = rt.new_null()
	config            rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType) construct(mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array) {
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
	this.resolveFieldFn = if !(var_config.array_get(rt.new_string('resolveField'))).is_null() {
		var_config.array_get(rt.new_string('resolveField'))
	} else {
		rt.new_null()
	}
	this.argsMapper = if !(var_config.array_get(rt.new_string('argsMapper'))).is_null() {
		var_config.array_get(rt.new_string('argsMapper'))
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

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType.assertobjecttype(var_type rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_type,
		'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_self'))))))
	{
		mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_0 := iife_temp_0.printsafe(var_type.clone())
		mut var_notObjectType := iife_result_0
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation',
			[]string{},
			create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.new_string('Expected ${var_notObjectType.to_string()} to be a Automattic\\WooCommerce\\Vendor\\GraphQL Object type.'))))
	}
	return var_type.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType) istypeof(var_objectValue rt.PhpVal, var_context rt.PhpVal, mut var_info Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo) rt.PhpVal {
	return if this.config.array_isset(rt.new_string('isTypeOf')) { rt.call_callable(this.config.array_get(rt.new_string('isTypeOf')), [
			var_objectValue.clone(),
			var_context.clone(),
			var_info,
		]) } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType) assertvalid() {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
	mut iife_result_1 := iife_temp_1.assertvalidname(rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType', [
		'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
		'OutputType',
		'CompositeType',
		'NullableType',
		'HasFieldsType',
		'NamedType',
		'ImplementingType',
	], &this), 'name'))
	mut var_isTypeOf := if !(this.config.array_get(rt.new_string('isTypeOf'))).is_null() {
		this.config.array_get(rt.new_string('isTypeOf'))
	} else {
		rt.new_null()
	}
	if !var_isTypeOf.is_null() && !(rt.call_function('is_callable', [var_isTypeOf.clone()])) {
		mut iife_temp_2 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_2 := iife_temp_2.printsafe(var_isTypeOf.clone())
		mut var_notCallable := iife_result_2
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation',
			[]string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.concat(rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType', [
			'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
			'OutputType',
			'CompositeType',
			'NullableType',
			'HasFieldsType',
			'NamedType',
			'ImplementingType',
		], &this), 'name'),
			rt.new_string(' must provide "isTypeOf" as null or a callable, but got: ')),
			var_notCallable), rt.new_string('.')))))
	}
	mut iter_1 := this.getfields().iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_field := item_1.val
		rt.call_method(var_field, 'assertValid', [
			rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType', [
				'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
				'OutputType',
				'CompositeType',
				'NullableType',
				'HasFieldsType',
				'NamedType',
				'ImplementingType',
			], &this),
		])
	}
	this.assertvalidinterfaces()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType) astnode() rt.PhpVal {
	return this.astNode
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType) extensionastnodes() rt.PhpVal {
	return this.extensionASTNodes
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_objecttype(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType{
		PhpObjectBase:     rt.PhpObjectBase{}
		astNode:           rt.new_null()
		extensionASTNodes: rt.new_null()
		resolveFieldFn:    rt.new_null()
		argsMapper:        rt.new_null()
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'assertObjectType' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType.assertobjecttype(dispatch_arg_0)
		}
		'isTypeOf' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return this.istypeof(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'assertValid' {
			this.assertvalid()
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

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'astNode' { return this.astNode }
		'extensionASTNodes' { return this.extensionASTNodes }
		'resolveFieldFn' { return this.resolveFieldFn }
		'argsMapper' { return this.argsMapper }
		'config' { return this.config }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'astNode' {
			this.astNode = val
			return true
		}
		'extensionASTNodes' {
			this.extensionASTNodes = val
			return true
		}
		'resolveFieldFn' {
			this.resolveFieldFn = val
			return true
		}
		'argsMapper' {
			this.argsMapper = val
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
