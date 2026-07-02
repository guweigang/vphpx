import rt

struct Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBannerDisplayRules {
	rt.PhpObjectBase
pub mut:
	dotcom_connected                  rt.PhpVal = rt.new_null()
	no_incompatible_plugins_installed bool
	wcs_version                       rt.PhpVal = rt.new_null()
	supported_countries               rt.PhpVal = rt.new_array()
	supported_currencies              rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBannerDisplayRules) construct(var_dotcom_connected rt.PhpVal, var_wcs_version rt.PhpVal, var_incompatible_plugins_installed rt.PhpVal) {
	this.dotcom_connected = var_dotcom_connected.clone()
	this.wcs_version = var_wcs_version.clone()
	this.no_incompatible_plugins_installed = !(rt.is_true(var_incompatible_plugins_installed))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBannerDisplayRules) should_display_banner() bool {
	return this.banner_not_dismissed() && rt.is_true(this.dotcom_connected)
		&& this.no_incompatible_plugins_installed && this.order_has_shippable_products()
		&& this.store_in_us_and_usd() && this.wcs_not_installed()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBannerDisplayRules) banner_not_dismissed() bool {
	mut var_dismissed_timestamp_ms := rt.call_function('get_option', [
		rt.new_string('woocommerce_shipping_dismissed_timestamp'),
	])
	if !(var_dismissed_timestamp_ms.clone().is_long()
		|| var_dismissed_timestamp_ms.clone().is_double()) {
		return true
	}
	var_dismissed_timestamp_ms = rt.new_int(var_dismissed_timestamp_ms.clone().to_i64())
	mut var_dismissed_timestamp := rt.new_int(rt.call_function('round', [
		rt.div(var_dismissed_timestamp_ms, rt.new_int(1000)),
	]).to_i64())
	mut var_expired_timestamp := rt.add(var_dismissed_timestamp, 24 * 60 * 60)
	mut var_dismissed_for_good := rt.identical(-1, var_dismissed_timestamp_ms)
	mut var_dismissed_24h := rt.less(rt.call_function('time', []rt.PhpVal{}), var_expired_timestamp)
	return rt.is_true(rt.new_bool(!(rt.is_true(var_dismissed_for_good))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_dismissed_24h))))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBannerDisplayRules) order_has_shippable_products() bool {
	mut var_order := rt.call_function('wc_get_order', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return false
	}
	mut iter_1 := rt.call_method(var_order, 'get_items', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_item := item_1.val
		if rt.is_true(rt.new_bool(rt.instance_of(var_item,
			'Automattic_WooCommerce_Internal_Admin_WC_Order_Item_Product')))
		{
			mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
			if rt.is_true(var_product)
				&& rt.is_true(rt.call_method(var_product, 'needs_shipping', []rt.PhpVal{})) {
				return true
			}
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBannerDisplayRules) store_in_us_and_usd() bool {
	mut var_base_currency := rt.call_function('get_woocommerce_currency', []rt.PhpVal{})
	mut var_base_location := rt.call_function('wc_get_base_location', []rt.PhpVal{})
	return
		rt.is_true(rt.call_function('in_array', [var_base_currency.clone(), this.supported_currencies, rt.new_bool(true)]))
		&& rt.is_true(rt.call_function('in_array', [var_base_location.array_get(rt.new_string('country')), this.supported_countries, rt.new_bool(true)]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBannerDisplayRules) wcs_not_installed() bool {
	return !(rt.is_true(this.wcs_version))
}

fn create_automattic_woocommerce_internal_admin_shippinglabelbannerdisplayrules(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBannerDisplayRules {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBannerDisplayRules{
		PhpObjectBase:                     rt.PhpObjectBase{}
		dotcom_connected:                  rt.new_null()
		no_incompatible_plugins_installed: false
		wcs_version:                       rt.new_null()
		supported_countries:               rt.new_array()
		supported_currencies:              rt.new_array()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBannerDisplayRules) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'should_display_banner' {
			return rt.new_bool(this.should_display_banner())
		}
		'banner_not_dismissed' {
			return rt.new_bool(this.banner_not_dismissed())
		}
		'order_has_shippable_products' {
			return rt.new_bool(this.order_has_shippable_products())
		}
		'store_in_us_and_usd' {
			return rt.new_bool(this.store_in_us_and_usd())
		}
		'wcs_not_installed' {
			return rt.new_bool(this.wcs_not_installed())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBannerDisplayRules) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'dotcom_connected' { return this.dotcom_connected }
		'no_incompatible_plugins_installed' { return rt.new_bool(this.no_incompatible_plugins_installed) }
		'wcs_version' { return this.wcs_version }
		'supported_countries' { return this.supported_countries }
		'supported_currencies' { return this.supported_currencies }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBannerDisplayRules) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'dotcom_connected' {
			this.dotcom_connected = val
			return true
		}
		'no_incompatible_plugins_installed' {
			this.no_incompatible_plugins_installed = val.to_bool()
			return true
		}
		'wcs_version' {
			this.wcs_version = val
			return true
		}
		'supported_countries' {
			this.supported_countries = val
			return true
		}
		'supported_currencies' {
			this.supported_currencies = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
