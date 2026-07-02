import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller.id() string {
	return 'payment_method_promotion'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller.data_sources() rt.PhpVal {
	return rt.new_array()
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_internal_admin_wcpaypromotion_wcpaypromotiondatasourcepoller() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller',
		'instance', rt.new_null())
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller',
		'instance')))))
	{
		rt.set_static_prop('Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller',
			'instance', rt.new_object('Automattic_WooCommerce_Internal_Admin_WCPayPromotion_self',
			[]string{}, create_automattic_woocommerce_internal_admin_wcpaypromotion_self(Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller.id(),
			Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller.get_data_sources())))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller',
		'instance')
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller.get_data_sources() rt.PhpVal {
	mut iife_temp_0 := Class_WC_Helper{}
	mut iife_result_0 := iife_temp_0.get_woocommerce_com_base_url()
	mut var_data_sources := rt.create_array([
		rt.ArrayItem{ key: none, val: iife_result_0.str() +
			'wp-json/wccom/payment-gateway-suggestions/2.0/payment-method/promotions.json' },
	])
	mut var_base_location := rt.call_function('wc_get_base_location', []rt.PhpVal{})
	closure_2_fn := fn [var_base_location] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_url := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('add_query_arg', [rt.new_string('country'),
			var_base_location.array_get(rt.new_string('country')),
			var_url.clone()])
	}
	closure_3_fn := fn [var_base_location] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_url := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('add_query_arg', [rt.new_string('country'),
			var_base_location.array_get(rt.new_string('country')),
			var_url.clone()])
	}
	mut var_data_sources_with_country := rt.call_function('array_map', [
		rt.new_closure(closure_2_fn),
		var_data_sources.clone(),
	])
	return var_data_sources_with_country.clone()
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_self {
	rt.PhpObjectBase
}

struct Class_WC_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_wcpaypromotion_wcpaypromotiondatasourcepoller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_datasourcepoller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcpaypromotion_self(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_self {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper(_args ...rt.PhpVal) &Class_WC_Helper {
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
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPayPromotionDataSourcePoller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
