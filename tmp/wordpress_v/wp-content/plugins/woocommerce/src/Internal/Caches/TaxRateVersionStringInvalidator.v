import rt

struct Class_Automattic_WooCommerce_Internal_Caches_TaxRateVersionStringInvalidator {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_TaxRateVersionStringInvalidator) init()  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_rest_api_enable_backend_caching'), rt.new_string('no')]))) {
		this.register_hooks()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_TaxRateVersionStringInvalidator) register_hooks()  {
	rt.call_function('add_action', [rt.new_string('woocommerce_tax_rate_added'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_TaxRateVersionStringInvalidator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_woocommerce_tax_rate_added' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('woocommerce_tax_rate_updated'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_TaxRateVersionStringInvalidator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_woocommerce_tax_rate_updated' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('woocommerce_tax_rate_deleted'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_TaxRateVersionStringInvalidator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_woocommerce_tax_rate_deleted' }]), rt.new_int(10), rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_TaxRateVersionStringInvalidator) handle_woocommerce_tax_rate_added(var_tax_rate_id rt.PhpVal)  {
	this.invalidate((// unsupported expression: Expr_Cast_Int).to_i64())
	this.invalidate_tax_rates_list()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_TaxRateVersionStringInvalidator) handle_woocommerce_tax_rate_updated(var_tax_rate_id rt.PhpVal)  {
	this.invalidate((// unsupported expression: Expr_Cast_Int).to_i64())
	this.invalidate_tax_rates_list()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_TaxRateVersionStringInvalidator) handle_woocommerce_tax_rate_deleted(var_tax_rate_id rt.PhpVal)  {
	this.invalidate((// unsupported expression: Expr_Cast_Int).to_i64())
	this.invalidate_tax_rates_list()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_TaxRateVersionStringInvalidator) invalidate_tax_rates_list()  {
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator.class()]), 'delete_version', [rt.new_string('list_tax_rates')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_TaxRateVersionStringInvalidator) invalidate(tax_rate_id i64)  {
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator.class()]), 'delete_version', [rt.new_string("tax_rate_${var_tax_rate_id.str()}")])
}

fn create_automattic_woocommerce_internal_caches_taxrateversionstringinvalidator() &Class_Automattic_WooCommerce_Internal_Caches_TaxRateVersionStringInvalidator {
	mut obj := &Class_Automattic_WooCommerce_Internal_Caches_TaxRateVersionStringInvalidator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_TaxRateVersionStringInvalidator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'register_hooks' {
			this.register_hooks()
			return rt.new_null()
		}
		'handle_woocommerce_tax_rate_added' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_woocommerce_tax_rate_added(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_woocommerce_tax_rate_updated' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_woocommerce_tax_rate_updated(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_woocommerce_tax_rate_deleted' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_woocommerce_tax_rate_deleted(dispatch_arg_0)
			return rt.new_null()
		}
		'invalidate_tax_rates_list' {
			this.invalidate_tax_rates_list()
			return rt.new_null()
		}
		'invalidate' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.invalidate(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Caches_TaxRateVersionStringInvalidator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_TaxRateVersionStringInvalidator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_caches_taxrateversionstringinvalidator_php() {
	// unsupported statement: Stmt_Declare
}
