import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller.id() string {
	return 'payment_method_promotion'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller.data_sources() rt.PhpVal {
	return rt.new_array()
}
struct Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller.get_data_sources() rt.PhpVal {
	mut var_data_sources := rt.create_array([rt.ArrayItem{ key: none, val: (fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_woocommerce_com_base_url() }()).str() + 'wp-json/wccom/payment-gateway-suggestions/2.0/payment-method/promotions.json' }])
	mut var_base_location := rt.call_function('wc_get_base_location', []rt.PhpVal{})
	closure_2_fn := fn [var_base_location] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn [var_base_location] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_url := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_function('add_query_arg', [rt.new_string('country'), var_base_location.array_get('country'), var_url.dup()])
	}
	mut var_url := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_function('add_query_arg', [rt.new_string('country'), var_base_location.array_get('country'), var_url.dup()])
	}
	mut var_data_sources_with_country := rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_data_sources.dup()])
	return var_data_sources_with_country.dup()
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller {
	rt.PhpObjectBase
}

struct Class_WC_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_wcpaypromotion_wcpaypromotiondatasourcepoller() &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_datasourcepoller() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper() &Class_WC_Helper {
	mut obj := &Class_WC_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller.get_instance()
		}
		'get_data_sources' {
			return Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller.get_data_sources()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_wcpaypromotion_wcpaypromotiondatasourcepoller_php() {
}
