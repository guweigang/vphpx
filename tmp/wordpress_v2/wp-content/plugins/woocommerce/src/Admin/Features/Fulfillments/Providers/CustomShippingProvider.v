import rt

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_CustomShippingProvider {
	rt.PhpObjectBase
pub mut:
	key                   string
	name                  string
	icon                  string
	tracking_url_template string
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_CustomShippingProvider) construct(key string, name string, icon string, tracking_url_template string) {
	this.key = key
	this.name = name
	this.icon = icon
	this.tracking_url_template = tracking_url_template
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_CustomShippingProvider) get_key() string {
	return this.key
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_CustomShippingProvider) get_name() string {
	return this.name
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_CustomShippingProvider) get_icon() string {
	return this.icon
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_CustomShippingProvider) get_tracking_url(tracking_number string) string {
	if this.tracking_url_template == '' {
		return ''
	}
	return (rt.call_function('str_replace', [rt.new_string('__PLACEHOLDER__'),
		rt.call_function('rawurlencode', [rt.new_string(tracking_number)]),
		rt.new_string(this.tracking_url_template)])).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_CustomShippingProvider) try_parse_tracking_number(tracking_number string, shipping_from string, shipping_to string) rt.PhpVal {
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_fulfillments_providers_customshippingprovider(key string, name string, icon string, tracking_url_template string) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_CustomShippingProvider {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_CustomShippingProvider{
		PhpObjectBase:         rt.PhpObjectBase{}
		key:                   ''
		name:                  ''
		icon:                  ''
		tracking_url_template: ''
	}
	obj.construct(key, name, icon, tracking_url_template)
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_providers_abstractshippingprovider(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_AbstractShippingProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_CustomShippingProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
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
		'try_parse_tracking_number' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.try_parse_tracking_number(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_CustomShippingProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'key' { return rt.new_string(this.key) }
		'name' { return rt.new_string(this.name) }
		'icon' { return rt.new_string(this.icon) }
		'tracking_url_template' { return rt.new_string(this.tracking_url_template) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Providers_CustomShippingProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'key' {
			this.key = val.str()
			return true
		}
		'name' {
			this.name = val.str()
			return true
		}
		'icon' {
			this.icon = val.str()
			return true
		}
		'tracking_url_template' {
			this.tracking_url_template = val.str()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
