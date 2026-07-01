import rt

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Handler_CommentHandler {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Handler_CommentHandler) handle(mut var_reader Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Reader, mut var_stream Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream) bool {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	mut var_offset := var_reader.getoffset(rt.new_string('*/'))
	if rt.is_true(rt.identical(rt.new_bool(false), var_offset)) {
		var_reader.movetoend()
	} else {
		var_reader.moveforward(rt.add(var_offset, rt.new_int(2)))
	}
	return true
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_parser_handler_commenthandler() &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Handler_CommentHandler {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Handler_CommentHandler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Handler_CommentHandler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'handle' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Reader](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.handle(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Handler_CommentHandler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Handler_CommentHandler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_symfony_component_cssselector_parser_handler_commenthandler_php() {
}
