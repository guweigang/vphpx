import rt

struct Class_Automattic_WooCommerce_Internal_Api_Schema_Type {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Api_Schema_Type.int() rt.PhpVal {
	return fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		return temp.int()
	}()
}

fn Class_Automattic_WooCommerce_Internal_Api_Schema_Type.string() rt.PhpVal {
	return fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		return temp.string()
	}()
}

fn Class_Automattic_WooCommerce_Internal_Api_Schema_Type.boolean() rt.PhpVal {
	return fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		return temp.boolean()
	}()
}

fn Class_Automattic_WooCommerce_Internal_Api_Schema_Type.float() rt.PhpVal {
	return fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		return temp.float()
	}()
}

fn Class_Automattic_WooCommerce_Internal_Api_Schema_Type.id() rt.PhpVal {
	return fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		return temp.id()
	}()
}

fn Class_Automattic_WooCommerce_Internal_Api_Schema_Type.nonnull(var_inner rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		return temp.nonnull(arg_0)
	}(var_inner.dup())
}

fn Class_Automattic_WooCommerce_Internal_Api_Schema_Type.listof(var_inner rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type{}
		return temp.listof(arg_0)
	}(var_inner.dup())
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Type {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_api_schema_type() &Class_Automattic_WooCommerce_Internal_Api_Schema_Type {
	mut obj := &Class_Automattic_WooCommerce_Internal_Api_Schema_Type{
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

pub fn init_wp_content_plugins_woocommerce_src_internal_api_schema_type_php() {
	// unsupported statement: Stmt_Declare
}
