import rt

struct Class_Automattic_WooCommerce_Api_Attributes_Parameter {
	rt.PhpObjectBase
pub mut:
		has_default bool
}

fn (mut this Class_Automattic_WooCommerce_Api_Attributes_Parameter) construct(name string, type string, nullable bool, array bool, mut var_default Class_Automattic_WooCommerce_Api_Attributes_mixed, description string, has_default bool, unroll bool)  {
	this.has_default = var_has_default || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)
}

fn create_automattic_woocommerce_api_attributes_parameter(name string, type string, nullable bool, array bool, arg_4 rt.PhpVal, description string, has_default bool, unroll bool) &Class_Automattic_WooCommerce_Api_Attributes_Parameter {
	mut obj := &Class_Automattic_WooCommerce_Api_Attributes_Parameter{
		PhpObjectBase: rt.PhpObjectBase{}
		has_default: false
	}
	obj.construct(name, type, nullable, array, arg_4, description, has_default, unroll)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Attributes_Parameter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Api_Attributes_mixed](if args.len > 4 { args[4] } else { rt.new_null() })
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
			dispatch_arg_6 := (if args.len > 6 { args[6] } else { rt.new_null() }).to_bool()
			dispatch_arg_7 := (if args.len > 7 { args[7] } else { rt.new_null() }).to_bool()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4, dispatch_arg_5, dispatch_arg_6, dispatch_arg_7)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Api_Attributes_Parameter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'has_default' { return rt.new_bool(this.has_default) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Api_Attributes_Parameter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'has_default' { this.has_default = (val).to_bool(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_src_api_attributes_parameter_php() {
	// unsupported statement: Stmt_Declare
}
