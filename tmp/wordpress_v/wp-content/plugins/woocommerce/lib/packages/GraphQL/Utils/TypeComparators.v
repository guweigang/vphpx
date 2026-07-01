import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators.isequaltype(mut var_typeA Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, mut var_typeB Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) bool {
	if rt.is_true(rt.identical(var_typeA, var_typeB)) {
		return true
	}
	if rt.is_true(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators.aresamebuiltinscalar(mut var_typeA, mut
		var_typeB))
	{
		return true
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_typeA), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull')))
		&& rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_typeB), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull')))))
	{
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators.isequaltype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_typeA.getwrappedtype()), mut
			rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_typeB.getwrappedtype()))).to_bool()
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_typeA), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType')))
		&& rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_typeB), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType')))))
	{
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators.isequaltype(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_typeA.getwrappedtype()), mut
			rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_typeB.getwrappedtype()))).to_bool()
	}
	return false
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators.istypesubtypeof(mut var_schema Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema, mut var_maybeSubType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, mut var_superType Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) bool {
	if rt.is_true(rt.identical(var_maybeSubType, var_superType)) {
		return true
	}
	if rt.is_true(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators.aresamebuiltinscalar(mut var_maybeSubType, mut
		var_superType))
	{
		return true
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
		[]string{}, var_superType), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull')))
	{
		if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
			[]string{}, var_maybeSubType),
			'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull')))
		{
			return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators.istypesubtypeof(mut var_schema, mut
				rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_maybeSubType.getwrappedtype()), mut
				rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_superType.getwrappedtype()))).to_bool()
		}
		return false
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
		[]string{}, var_maybeSubType),
		'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull')))
	{
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators.istypesubtypeof(mut var_schema, mut
			rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_maybeSubType.getwrappedtype()), mut
			var_superType)).to_bool()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
		[]string{}, var_superType),
		'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType')))
	{
		if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
			[]string{}, var_maybeSubType),
			'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType')))
		{
			return (Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators.istypesubtypeof(mut var_schema, mut
				rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_maybeSubType.getwrappedtype()), mut
				rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](var_superType.getwrappedtype()))).to_bool()
		}
		return false
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type',
		[]string{}, var_maybeSubType),
		'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ListOfType')))
	{
		return false
	}
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		return temp.isabstracttype(arg_0)
	}(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{},
		var_superType)))
	{
		return
			rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_maybeSubType), 'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ImplementingType')))
			&& rt.is_true(var_schema.issubtype(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_superType), rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_maybeSubType)))
	}
	return false
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators.aresamebuiltinscalar(mut var_typeA Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type, mut var_typeB Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type) bool {
	return
		rt.is_true(rt.new_bool(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		return temp.isbuiltinscalar(arg_0)
	}(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_typeA)))
		&& rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		return temp.isbuiltinscalar(arg_0)
	}(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type', []string{}, var_typeB)))))
		&& rt.is_true(rt.identical(var_typeA.name(), var_typeB.name()))
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_utils_typecomparators() &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_type() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'isEqualType' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_bool(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators.isequaltype(mut dispatch_arg_0, mut
				dispatch_arg_1))
		}
		'isTypeSubTypeOf' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return rt.new_bool(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators.istypesubtypeof(mut dispatch_arg_0, mut
				dispatch_arg_1, mut dispatch_arg_2))
		}
		'areSameBuiltInScalar' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_bool(Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators.aresamebuiltinscalar(mut dispatch_arg_0, mut
				dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_TypeComparators) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_utils_typecomparators_php() {
	// unsupported statement: Stmt_Declare
}
