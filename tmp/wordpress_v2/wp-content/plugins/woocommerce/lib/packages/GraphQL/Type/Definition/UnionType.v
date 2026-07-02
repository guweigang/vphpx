import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType {
	rt.PhpObjectBase
pub mut:
	astNode           rt.PhpVal = rt.new_null()
	extensionASTNodes rt.PhpVal = rt.new_null()
	config            rt.PhpVal = rt.new_null()
	types             rt.PhpVal = rt.new_null()
	possibleTypeNames rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType) construct(mut var_config Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_array) {
	this.dispatch_set_prop('name', if !(var_config.array_get(rt.new_string('name'))).is_null() {
		var_config.array_get(rt.new_string('name'))
	} else {
		this.infername()
	})
	this.dispatch_set_prop('description', if !(var_config.array_get(rt.new_string('description'))).is_null() {
		var_config.array_get(rt.new_string('description'))
	} else {
		if !(rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType', [
			'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
			'AbstractType',
			'OutputType',
			'CompositeType',
			'NullableType',
			'NamedType',
		], &this), 'description')).is_null() { rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType', [
				'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
				'AbstractType',
				'OutputType',
				'CompositeType',
				'NullableType',
				'NamedType',
			], &this), 'description') } else { rt.new_null() }
	})
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType) ispossibletype(mut var_type Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
		[]string{}, var_type), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ObjectType'))))))
	{
		return false
	}
	if !(!(this.possibleTypeNames).is_null()) {
		this.possibleTypeNames = rt.new_array()
		mut iter_1 := this.gettypes().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_possibleType := item_1.val
			this.possibleTypeNames.array_set(rt.get_property(var_possibleType, 'name'), true)
		}
	}
	return (rt.new_bool(this.possibleTypeNames.array_isset(rt.get_property(var_type, 'name')))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType) gettypes() rt.PhpVal {
	if !(!(this.types).is_null()) {
		this.types = rt.new_array()
		mut var_types := if !(this.config.array_get(rt.new_string('types'))).is_null() {
			this.config.array_get(rt.new_string('types'))
		} else {
			rt.new_null()
		}
		if rt.is_true(rt.call_function('is_callable', [var_types.clone()])) {
			var_types = rt.call_callable(var_types, []rt.PhpVal{})
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_iterable', [
			var_types.clone(),
		])))))
		{
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation',
				[]string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.new_string('Must provide iterable of types or a callable which returns such an iterable for Union '), rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType', [
				'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
				'AbstractType',
				'OutputType',
				'CompositeType',
				'NullableType',
				'NamedType',
			], &this), 'name')), rt.new_string('.')))))
		}
		mut iter_2 := var_types.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_type := item_2.val
			mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema{}
			mut iife_result_0 := iife_temp_0.resolvetype(var_type.clone())
			this.types.array_push(iife_result_0)
		}
	}
	return this.types
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType) resolvevalue(var_objectValue rt.PhpVal, var_context rt.PhpVal, mut var_info Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo) rt.PhpVal {
	if this.config.array_isset(rt.new_string('resolveValue')) {
		return rt.call_callable(this.config.array_get(rt.new_string('resolveValue')), [
			var_objectValue.clone(),
			var_context.clone(),
			var_info,
		])
	}
	return var_objectValue.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType) resolvetype(var_objectValue rt.PhpVal, var_context rt.PhpVal, mut var_info Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo) rt.PhpVal {
	if this.config.array_isset(rt.new_string('resolveType')) {
		return rt.call_callable(this.config.array_get(rt.new_string('resolveType')), [
			var_objectValue.clone(),
			var_context.clone(),
			var_info,
		])
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType) assertvalid() {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
	mut iife_result_1 := iife_temp_1.assertvalidname(rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType', [
		'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
		'AbstractType',
		'OutputType',
		'CompositeType',
		'NullableType',
		'NamedType',
	], &this), 'name'))
	mut var_resolveType := if !(this.config.array_get(rt.new_string('resolveType'))).is_null() {
		this.config.array_get(rt.new_string('resolveType'))
	} else {
		rt.new_null()
	}
	if !var_resolveType.is_null() && !(rt.call_function('is_callable', [var_resolveType.clone()])) {
		mut iife_temp_2 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_2 := iife_temp_2.printsafe(var_resolveType.clone())
		mut var_notCallable := iife_result_2
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation',
			[]string{}, create_automattic_woocommerce_vendor_graphql_error_invariantviolation(rt.concat(rt.concat(rt.concat(rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType', [
			'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
			'AbstractType',
			'OutputType',
			'CompositeType',
			'NullableType',
			'NamedType',
		], &this), 'name'),
			rt.new_string(' must provide "resolveType" as null or a callable, but got: ')),
			var_notCallable), rt.new_string('.')))))
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType) astnode() rt.PhpVal {
	return this.astNode
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType) extensionastnodes() rt.PhpVal {
	return this.extensionASTNodes
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_InvariantViolation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_uniontype(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType{
		PhpObjectBase:     rt.PhpObjectBase{}
		astNode:           rt.new_null()
		extensionASTNodes: rt.new_null()
		config:            rt.new_null()
		types:             rt.new_null()
		possibleTypeNames: rt.new_null()
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'isPossibleType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.ispossibletype(mut dispatch_arg_0))
		}
		'getTypes' {
			return this.gettypes()
		}
		'resolveValue' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return this.resolvevalue(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'resolveType' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return this.resolvetype(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
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

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'astNode' { return this.astNode }
		'extensionASTNodes' { return this.extensionASTNodes }
		'config' { return this.config }
		'types' { return this.types }
		'possibleTypeNames' { return this.possibleTypeNames }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_UnionType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
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
		'types' {
			this.types = val
			return true
		}
		'possibleTypeNames' {
			this.possibleTypeNames = val
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
