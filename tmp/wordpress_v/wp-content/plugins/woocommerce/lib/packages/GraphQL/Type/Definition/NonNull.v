import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull {
	rt.PhpObjectBase
pub mut:
	wrappedType rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull) construct(var_type rt.PhpVal) {
	mut var_type_mutated := var_type
	this.wrappedType = var_type_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull) tostring() string {
	return (rt.call_method(this.getwrappedtype(), 'toString', []rt.PhpVal{})).str() + '!'
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull) getwrappedtype() rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema{}
		return temp.resolvetype(arg_0)
	}(this.wrappedType)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull) getinnermosttype() rt.PhpVal {
	mut var_type := this.getwrappedtype()
	for rt.is_true(rt.new_bool(rt.instance_of(var_type,
		'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_WrappingType'))) {
		var_type = rt.call_method(var_type, 'getWrappedType', []rt.PhpVal{})
	}
	rt.call_function('assert', [
		rt.new_bool(rt.instance_of(var_type,
			'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NamedType')),
		rt.new_string('known because we unwrapped all the way down'),
	])
	return var_type.dup()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_nonnull(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull{
		PhpObjectBase: rt.PhpObjectBase{}
		wrappedType:   rt.new_null()
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

fn create_automattic_woocommerce_vendor_graphql_type_schema() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'toString' {
			return rt.new_string(this.tostring())
		}
		'getWrappedType' {
			return this.getwrappedtype()
		}
		'getInnermostType' {
			return this.getinnermosttype()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'wrappedType' { return this.wrappedType }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'wrappedType' {
			this.wrappedType = val
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_type_definition_nonnull_php() {
	// unsupported statement: Stmt_Declare
}
