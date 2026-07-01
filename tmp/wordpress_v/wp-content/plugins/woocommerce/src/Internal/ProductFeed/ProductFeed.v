import rt

struct Class_Automattic_WooCommerce_Internal_ProductFeed_ProductFeed {
	rt.PhpObjectBase
pub mut:
	integration_registry rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_ProductFeed) init(mut var_integration_registry Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_IntegrationRegistry, mut var_pos_integration Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSIntegration) {
	this.integration_registry = var_integration_registry.dup()
	rt.call_method(this.integration_registry, 'register_integration', [
		var_pos_integration,
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_ProductFeed) register_integration(mut var_integration Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_IntegrationInterface) {
	rt.call_method(this.integration_registry, 'register_integration', [
		var_integration,
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_ProductFeed) register() {
	{
		mut iter_1 :=
			rt.call_method(this.integration_registry, 'get_integrations', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_integration := item_1.val
			rt.call_method(var_integration, 'register_hooks', []rt.PhpVal{})
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_ProductFeed) activate() {
	{
		mut iter_1 :=
			rt.call_method(this.integration_registry, 'get_integrations', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_integration := item_1.val
			rt.call_method(var_integration, 'activate', []rt.PhpVal{})
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_ProductFeed) deactivate() {
	{
		mut iter_1 :=
			rt.call_method(this.integration_registry, 'get_integrations', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_integration := item_1.val
			rt.call_method(var_integration, 'deactivate', []rt.PhpVal{})
		}
	}
}

fn create_automattic_woocommerce_internal_productfeed_productfeed() &Class_Automattic_WooCommerce_Internal_ProductFeed_ProductFeed {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFeed_ProductFeed{
		PhpObjectBase:        rt.PhpObjectBase{}
		integration_registry: rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_ProductFeed) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_IntegrationRegistry](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSIntegration](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'register_integration' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_IntegrationInterface](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.register_integration(mut dispatch_arg_0)
			return rt.new_null()
		}
		'register' {
			this.register()
			return rt.new_null()
		}
		'activate' {
			this.activate()
			return rt.new_null()
		}
		'deactivate' {
			this.deactivate()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFeed_ProductFeed) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'integration_registry' { return this.integration_registry }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_ProductFeed) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'integration_registry' {
			this.integration_registry = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_src_internal_productfeed_productfeed_php() {
	// unsupported statement: Stmt_Declare
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
}
