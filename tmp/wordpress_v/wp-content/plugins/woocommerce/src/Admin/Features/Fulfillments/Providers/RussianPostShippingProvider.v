import rt

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_RussianPostShippingProvider {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_RussianPostShippingProvider) get_key() string {
	return 'russian-post'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_RussianPostShippingProvider) get_name() string {
	return 'Russian Post'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_RussianPostShippingProvider) get_icon() string {
	return
		(rt.call_function('esc_url', [rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})])).str() +
		'/assets/images/shipping_providers/russian-post.png'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_RussianPostShippingProvider) get_tracking_url(tracking_number string) string {
	return 'https://www.pochta.ru/tracking/' + tracking_number
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_fulfillments_providers_russianpostshippingprovider() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_RussianPostShippingProvider {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_RussianPostShippingProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_providers_abstractshippingprovider() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_RussianPostShippingProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_key' {
			return rt.new_string(this.get_key())
		}
		'get_name' {
			return rt.new_string(this.get_name())
		}
		'get_icon' {
			return rt.new_string(this.get_icon())
		}
		'get_tracking_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_tracking_url(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_RussianPostShippingProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_RussianPostShippingProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_admin_features_fulfillments_providers_russianpostshippingprovider_php() {
	// unsupported statement: Stmt_Declare
}
