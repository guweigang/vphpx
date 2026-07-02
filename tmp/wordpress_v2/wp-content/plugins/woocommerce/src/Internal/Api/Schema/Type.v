import rt

struct Class_Automattic_WooCommerce_Internal_Api_Schema_Type {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Api_Schema_Type.int() rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
	mut iife_result_0 := iife_temp_0.int()
	return iife_result_0
}

fn Class_Automattic_WooCommerce_Internal_Api_Schema_Type.string() rt.PhpVal {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
	mut iife_result_1 := iife_temp_1.string()
	return iife_result_1
}

fn Class_Automattic_WooCommerce_Internal_Api_Schema_Type.boolean() rt.PhpVal {
	mut iife_temp_2 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
	mut iife_result_2 := iife_temp_2.boolean()
	return iife_result_2
}

fn Class_Automattic_WooCommerce_Internal_Api_Schema_Type.float() rt.PhpVal {
	mut iife_temp_3 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
	mut iife_result_3 := iife_temp_3.float()
	return iife_result_3
}

fn Class_Automattic_WooCommerce_Internal_Api_Schema_Type.id() rt.PhpVal {
	mut iife_temp_4 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
	mut iife_result_4 := iife_temp_4.id()
	return iife_result_4
}

fn Class_Automattic_WooCommerce_Internal_Api_Schema_Type.nonnull(var_inner rt.PhpVal) rt.PhpVal {
	mut iife_temp_5 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
	mut iife_result_5 := iife_temp_5.nonnull(var_inner.clone())
	return iife_result_5
}

fn Class_Automattic_WooCommerce_Internal_Api_Schema_Type.listof(var_inner rt.PhpVal) rt.PhpVal {
	mut iife_temp_6 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
	mut iife_result_6 := iife_temp_6.listof(var_inner.clone())
	return iife_result_6
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_api_schema_type(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Api_Schema_Type {
	mut obj := &Class_Automattic_WooCommerce_Internal_Api_Schema_Type{
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

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Schema_Type) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'int' {
			return Class_Automattic_WooCommerce_Internal_Api_Schema_Type.int()
		}
		'string' {
			return Class_Automattic_WooCommerce_Internal_Api_Schema_Type.string()
		}
		'boolean' {
			return Class_Automattic_WooCommerce_Internal_Api_Schema_Type.boolean()
		}
		'float' {
			return Class_Automattic_WooCommerce_Internal_Api_Schema_Type.float()
		}
		'id' {
			return Class_Automattic_WooCommerce_Internal_Api_Schema_Type.id()
		}
		'nonNull' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Api_Schema_Type.nonnull(dispatch_arg_0)
		}
		'listOf' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Api_Schema_Type.listof(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Api_Schema_Type) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Schema_Type) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
