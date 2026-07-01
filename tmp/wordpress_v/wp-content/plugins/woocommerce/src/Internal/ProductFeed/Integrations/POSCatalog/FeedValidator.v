import rt

struct Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_FeedValidator {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_FeedValidator) validate_entry(mut var_entry Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_array, mut var_product Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_WC_Product) rt.PhpVal {
	return rt.new_array()
}

fn create_automattic_woocommerce_internal_productfeed_integrations_poscatalog_feedvalidator() &Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_FeedValidator {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_FeedValidator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_FeedValidator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'validate_entry' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_WC_Product](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.validate_entry(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_FeedValidator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_FeedValidator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_productfeed_integrations_poscatalog_feedvalidator_php() {
	// unsupported statement: Stmt_Declare
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
}
