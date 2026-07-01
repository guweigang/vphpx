import rt

struct Class_Automattic_WooCommerce_RestApi_Server {
	rt.PhpObjectBase
pub mut:
		controllers rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_RestApi_Server) init()  {
	rt.call_function('add_action', [rt.new_string('rest_api_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_RestApi_Server', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_rest_routes' }]), rt.new_int(10)])
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_RestApi_WC_REST_System_Status_V2_Controller{}; return temp.register_cache_clean() }()
}

fn (mut this Class_Automattic_WooCommerce_RestApi_Server) register_rest_routes()  {
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	mut var_legacy_proxy := rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Proxies_LegacyProxy.class()])
	{
		mut iter_1 := this.get_rest_namespaces().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_controllers := item_1.val
			mut var_namespace := item_1.key
			{
				mut iter_2 := var_controllers.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_controller_class := item_2.val
					mut var_controller_name := item_2.key
					this.controllers.array_get_mut(var_namespace).array_set(var_controller_name, if rt.is_true(rt.call_method(var_container, 'has', [var_controller_class.dup()])) { rt.call_method(var_container, 'get', [var_controller_class.dup()]) } else { rt.call_method(var_legacy_proxy, 'get_instance_of', [var_controller_class.dup()]) })
					rt.call_method(this.controllers.array_get(var_namespace).array_get(var_controller_name), 'register_routes', []rt.PhpVal{})
				}
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_RestApi_Server) get_rest_namespaces() rt.PhpVal {
	mut var_namespaces := rt.create_array([rt.ArrayItem{ key: 'wc/v1', val: if rt.is_true(rt.call_function('wc_rest_should_load_namespace', [rt.new_string('wc/v1')])) { this.get_v1_controllers() } else { rt.new_array() } }, rt.ArrayItem{ key: 'wc/v2', val: if rt.is_true(rt.call_function('wc_rest_should_load_namespace', [rt.new_string('wc/v2')])) { this.get_v2_controllers() } else { rt.new_array() } }, rt.ArrayItem{ key: 'wc/v3', val: if rt.is_true(rt.call_function('wc_rest_should_load_namespace', [rt.new_string('wc/v3')])) { this.get_v3_controllers() } else { rt.new_array() } }, rt.ArrayItem{ key: 'wc-telemetry', val: if rt.is_true(rt.call_function('wc_rest_should_load_namespace', [rt.new_string('wc-telemetry')])) { this.get_telemetry_controllers() } else { rt.new_array() } }])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('wc_rest_should_load_namespace', [rt.new_string('wc/v4')])) && rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.is_enabled(arg_0) }(rt.new_string('rest-api-v4'))))) {
		var_namespaces.array_set('wc/v4', this.get_v4_controllers())
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_api_get_rest_namespaces'), var_namespaces.dup()])
}

fn (mut this Class_Automattic_WooCommerce_RestApi_Server) get_v1_controllers() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'coupons', val: 'WC_REST_Coupons_V1_Controller' }, rt.ArrayItem{ key: 'customer-downloads', val: 'WC_REST_Customer_Downloads_V1_Controller' }, rt.ArrayItem{ key: 'customers', val: 'WC_REST_Customers_V1_Controller' }, rt.ArrayItem{ key: 'order-notes', val: 'WC_REST_Order_Notes_V1_Controller' }, rt.ArrayItem{ key: 'order-refunds', val: 'WC_REST_Order_Refunds_V1_Controller' }, rt.ArrayItem{ key: 'orders', val: 'WC_REST_Orders_V1_Controller' }, rt.ArrayItem{ key: 'product-attribute-terms', val: 'WC_REST_Product_Attribute_Terms_V1_Controller' }, rt.ArrayItem{ key: 'product-attributes', val: 'WC_REST_Product_Attributes_V1_Controller' }, rt.ArrayItem{ key: 'product-categories', val: 'WC_REST_Product_Categories_V1_Controller' }, rt.ArrayItem{ key: 'product-reviews', val: 'WC_REST_Product_Reviews_V1_Controller' }, rt.ArrayItem{ key: 'product-shipping-classes', val: 'WC_REST_Product_Shipping_Classes_V1_Controller' }, rt.ArrayItem{ key: 'product-tags', val: 'WC_REST_Product_Tags_V1_Controller' }, rt.ArrayItem{ key: 'products', val: 'WC_REST_Products_V1_Controller' }, rt.ArrayItem{ key: 'reports-sales', val: 'WC_REST_Report_Sales_V1_Controller' }, rt.ArrayItem{ key: 'reports-top-sellers', val: 'WC_REST_Report_Top_Sellers_V1_Controller' }, rt.ArrayItem{ key: 'reports', val: 'WC_REST_Reports_V1_Controller' }, rt.ArrayItem{ key: 'tax-classes', val: 'WC_REST_Tax_Classes_V1_Controller' }, rt.ArrayItem{ key: 'taxes', val: 'WC_REST_Taxes_V1_Controller' }, rt.ArrayItem{ key: 'webhooks', val: 'WC_REST_Webhooks_V1_Controller' }, rt.ArrayItem{ key: 'webhook-deliveries', val: 'WC_REST_Webhook_Deliveries_V1_Controller' }])
}

fn (mut this Class_Automattic_WooCommerce_RestApi_Server) get_v2_controllers() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'coupons', val: 'WC_REST_Coupons_V2_Controller' }, rt.ArrayItem{ key: 'customer-downloads', val: 'WC_REST_Customer_Downloads_V2_Controller' }, rt.ArrayItem{ key: 'customers', val: 'WC_REST_Customers_V2_Controller' }, rt.ArrayItem{ key: 'network-orders', val: 'WC_REST_Network_Orders_V2_Controller' }, rt.ArrayItem{ key: 'order-notes', val: 'WC_REST_Order_Notes_V2_Controller' }, rt.ArrayItem{ key: 'order-refunds', val: 'WC_REST_Order_Refunds_V2_Controller' }, rt.ArrayItem{ key: 'orders', val: 'WC_REST_Orders_V2_Controller' }, rt.ArrayItem{ key: 'product-attribute-terms', val: 'WC_REST_Product_Attribute_Terms_V2_Controller' }, rt.ArrayItem{ key: 'product-attributes', val: 'WC_REST_Product_Attributes_V2_Controller' }, rt.ArrayItem{ key: 'product-categories', val: 'WC_REST_Product_Categories_V2_Controller' }, rt.ArrayItem{ key: 'product-reviews', val: 'WC_REST_Product_Reviews_V2_Controller' }, rt.ArrayItem{ key: 'product-shipping-classes', val: 'WC_REST_Product_Shipping_Classes_V2_Controller' }, rt.ArrayItem{ key: 'product-tags', val: 'WC_REST_Product_Tags_V2_Controller' }, rt.ArrayItem{ key: 'products', val: 'WC_REST_Products_V2_Controller' }, rt.ArrayItem{ key: 'product-variations', val: 'WC_REST_Product_Variations_V2_Controller' }, rt.ArrayItem{ key: 'reports-sales', val: 'WC_REST_Report_Sales_V2_Controller' }, rt.ArrayItem{ key: 'reports-top-sellers', val: 'WC_REST_Report_Top_Sellers_V2_Controller' }, rt.ArrayItem{ key: 'reports', val: 'WC_REST_Reports_V2_Controller' }, rt.ArrayItem{ key: 'settings', val: 'WC_REST_Settings_V2_Controller' }, rt.ArrayItem{ key: 'settings-options', val: 'WC_REST_Setting_Options_V2_Controller' }, rt.ArrayItem{ key: 'shipping-zones', val: 'WC_REST_Shipping_Zones_V2_Controller' }, rt.ArrayItem{ key: 'shipping-zone-locations', val: 'WC_REST_Shipping_Zone_Locations_V2_Controller' }, rt.ArrayItem{ key: 'shipping-zone-methods', val: 'WC_REST_Shipping_Zone_Methods_V2_Controller' }, rt.ArrayItem{ key: 'tax-classes', val: 'WC_REST_Tax_Classes_V2_Controller' }, rt.ArrayItem{ key: 'taxes', val: 'WC_REST_Taxes_V2_Controller' }, rt.ArrayItem{ key: 'webhooks', val: 'WC_REST_Webhooks_V2_Controller' }, rt.ArrayItem{ key: 'webhook-deliveries', val: 'WC_REST_Webhook_Deliveries_V2_Controller' }, rt.ArrayItem{ key: 'system-status', val: 'WC_REST_System_Status_V2_Controller' }, rt.ArrayItem{ key: 'system-status-tools', val: 'WC_REST_System_Status_Tools_V2_Controller' }, rt.ArrayItem{ key: 'shipping-methods', val: 'WC_REST_Shipping_Methods_V2_Controller' }, rt.ArrayItem{ key: 'payment-gateways', val: 'WC_REST_Payment_Gateways_V2_Controller' }])
}

fn (mut this Class_Automattic_WooCommerce_RestApi_Server) get_v3_controllers() rt.PhpVal {
	mut var_controllers := rt.create_array([rt.ArrayItem{ key: 'coupons', val: 'WC_REST_Coupons_Controller' }, rt.ArrayItem{ key: 'customer-downloads', val: 'WC_REST_Customer_Downloads_Controller' }, rt.ArrayItem{ key: 'customers', val: 'WC_REST_Customers_Controller' }, rt.ArrayItem{ key: 'layout-templates', val: 'WC_REST_Layout_Templates_Controller' }, rt.ArrayItem{ key: 'network-orders', val: 'WC_REST_Network_Orders_Controller' }, rt.ArrayItem{ key: 'order-notes', val: 'WC_REST_Order_Notes_Controller' }, rt.ArrayItem{ key: 'order-refunds', val: 'WC_REST_Order_Refunds_Controller' }, rt.ArrayItem{ key: 'orders', val: 'WC_REST_Orders_Controller' }, rt.ArrayItem{ key: 'product-attribute-terms', val: 'WC_REST_Product_Attribute_Terms_Controller' }, rt.ArrayItem{ key: 'product-attributes', val: 'WC_REST_Product_Attributes_Controller' }, rt.ArrayItem{ key: 'product-categories', val: 'WC_REST_Product_Categories_Controller' }, rt.ArrayItem{ key: 'product-custom-fields', val: 'WC_REST_Product_Custom_Fields_Controller' }, rt.ArrayItem{ key: 'product-reviews', val: 'WC_REST_Product_Reviews_Controller' }, rt.ArrayItem{ key: 'product-shipping-classes', val: 'WC_REST_Product_Shipping_Classes_Controller' }, rt.ArrayItem{ key: 'product-tags', val: 'WC_REST_Product_Tags_Controller' }, rt.ArrayItem{ key: 'products', val: 'WC_REST_Products_Controller' }, rt.ArrayItem{ key: 'product-variations', val: 'WC_REST_Product_Variations_Controller' }, rt.ArrayItem{ key: 'refunds', val: 'WC_REST_Refunds_Controller' }, rt.ArrayItem{ key: 'reports-sales', val: 'WC_REST_Report_Sales_Controller' }, rt.ArrayItem{ key: 'reports-top-sellers', val: 'WC_REST_Report_Top_Sellers_Controller' }, rt.ArrayItem{ key: 'reports-orders-totals', val: 'WC_REST_Report_Orders_Totals_Controller' }, rt.ArrayItem{ key: 'reports-products-totals', val: 'WC_REST_Report_Products_Totals_Controller' }, rt.ArrayItem{ key: 'reports-customers-totals', val: 'WC_REST_Report_Customers_Totals_Controller' }, rt.ArrayItem{ key: 'reports-coupons-totals', val: 'WC_REST_Report_Coupons_Totals_Controller' }, rt.ArrayItem{ key: 'reports-reviews-totals', val: 'WC_REST_Report_Reviews_Totals_Controller' }, rt.ArrayItem{ key: 'reports', val: 'WC_REST_Reports_Controller' }, rt.ArrayItem{ key: 'settings', val: 'WC_REST_Settings_Controller' }, rt.ArrayItem{ key: 'settings-options', val: 'WC_REST_Setting_Options_Controller' }, rt.ArrayItem{ key: 'shipping-zones', val: 'WC_REST_Shipping_Zones_Controller' }, rt.ArrayItem{ key: 'shipping-zone-locations', val: 'WC_REST_Shipping_Zone_Locations_Controller' }, rt.ArrayItem{ key: 'shipping-zone-methods', val: 'WC_REST_Shipping_Zone_Methods_Controller' }, rt.ArrayItem{ key: 'tax-classes', val: 'WC_REST_Tax_Classes_Controller' }, rt.ArrayItem{ key: 'taxes', val: 'WC_REST_Taxes_Controller' }, rt.ArrayItem{ key: 'variations', val: 'WC_REST_Variations_Controller' }, rt.ArrayItem{ key: 'webhooks', val: 'WC_REST_Webhooks_Controller' }, rt.ArrayItem{ key: 'system-status', val: 'WC_REST_System_Status_Controller' }, rt.ArrayItem{ key: 'system-status-tools', val: 'WC_REST_System_Status_Tools_Controller' }, rt.ArrayItem{ key: 'shipping-methods', val: 'WC_REST_Shipping_Methods_Controller' }, rt.ArrayItem{ key: 'payment-gateways', val: 'WC_REST_Payment_Gateways_Controller' }, rt.ArrayItem{ key: 'data', val: 'WC_REST_Data_Controller' }, rt.ArrayItem{ key: 'data-continents', val: 'WC_REST_Data_Continents_Controller' }, rt.ArrayItem{ key: 'data-countries', val: 'WC_REST_Data_Countries_Controller' }, rt.ArrayItem{ key: 'data-currencies', val: 'WC_REST_Data_Currencies_Controller' }, rt.ArrayItem{ key: 'paypal-standard', val: 'WC_REST_Paypal_Standard_Controller' }, rt.ArrayItem{ key: 'paypal-webhooks', val: 'WC_REST_Paypal_Webhooks_Controller' }, rt.ArrayItem{ key: 'paypal-buttons', val: 'WC_REST_Paypal_Buttons_Controller' }])
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.is_enabled(arg_0) }(rt.new_string('products-catalog-api'))) {
		var_controllers.array_set('products-catalog', 'WC_REST_Products_Catalog_Controller')
	}
	return var_controllers.dup()
}

fn (mut this Class_Automattic_WooCommerce_RestApi_Server) get_v4_controllers() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'fulfillments', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Fulfillments_Controller.class() }, rt.ArrayItem{ key: 'products', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller.class() }, rt.ArrayItem{ key: 'customers', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller.class() }, rt.ArrayItem{ key: 'order-notes', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller.class() }, rt.ArrayItem{ key: 'shipping-zones', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZones_Controller.class() }, rt.ArrayItem{ key: 'shipping-zone-method', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_ShippingZoneMethod_Controller.class() }, rt.ArrayItem{ key: 'orders', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Controller.class() }, rt.ArrayItem{ key: 'refunds', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Refunds_Controller.class() }, rt.ArrayItem{ key: 'offline-payment-methods', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_OfflinePaymentMethods_Controller.class() }, rt.ArrayItem{ key: 'settings-general', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_General_Controller.class() }, rt.ArrayItem{ key: 'settings-email', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Email_Controller.class() }, rt.ArrayItem{ key: 'settings-emails', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Emails_Controller.class() }, rt.ArrayItem{ key: 'settings-products', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Products_Controller.class() }, rt.ArrayItem{ key: 'settings-payment-gateways', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Controller.class() }, rt.ArrayItem{ key: 'settings-tax', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Tax_Controller.class() }, rt.ArrayItem{ key: 'settings-account', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Account_Controller.class() }, rt.ArrayItem{ key: 'settings', val: 'WC_REST_Settings_V4_Controller' }])
}

fn (mut this Class_Automattic_WooCommerce_RestApi_Server) get_v4_controller(var_identifier rt.PhpVal, var_route rt.PhpVal) rt.PhpVal {
	if this.controllers.array_get('wc/v4').array_isset(var_identifier) {
		return this.controllers.array_get('wc/v4').array_get(var_identifier)
	}
	return rt.create_object_dynamically(var_route, []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_RestApi_Server) get_telemetry_controllers() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'tracker', val: 'WC_REST_Telemetry_Controller' }])
}

fn Class_Automattic_WooCommerce_RestApi_Server.get_path() rt.PhpVal {
	return rt.call_function('dirname', [rt.new_string(@DIR)])
}

struct Class_Automattic_WooCommerce_RestApi_WC_REST_System_Status_V2_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_restapi_server() &Class_Automattic_WooCommerce_RestApi_Server {
	mut obj := &Class_Automattic_WooCommerce_RestApi_Server{
		PhpObjectBase: rt.PhpObjectBase{}
		controllers: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_restapi_wc_rest_system_status_v2_controller() &Class_Automattic_WooCommerce_RestApi_WC_REST_System_Status_V2_Controller {
	mut obj := &Class_Automattic_WooCommerce_RestApi_WC_REST_System_Status_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features() &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_RestApi_Server) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'register_rest_routes' {
			this.register_rest_routes()
			return rt.new_null()
		}
		'get_rest_namespaces' {
			return this.get_rest_namespaces()
		}
		'get_v1_controllers' {
			return this.get_v1_controllers()
		}
		'get_v2_controllers' {
			return this.get_v2_controllers()
		}
		'get_v3_controllers' {
			return this.get_v3_controllers()
		}
		'get_v4_controllers' {
			return this.get_v4_controllers()
		}
		'get_v4_controller' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_v4_controller(dispatch_arg_0, dispatch_arg_1)
		}
		'get_telemetry_controllers' {
			return this.get_telemetry_controllers()
		}
		'get_path' {
			return Class_Automattic_WooCommerce_RestApi_Server.get_path()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_RestApi_Server) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'controllers' { return this.controllers }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_RestApi_Server) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'controllers' { this.controllers = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_RestApi_WC_REST_System_Status_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_RestApi_WC_REST_System_Status_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_RestApi_WC_REST_System_Status_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_RestApi_Server', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_restapi_server()
		return rt.new_object('Automattic_WooCommerce_RestApi_Server', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_RestApi_WC_REST_System_Status_V2_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_restapi_wc_rest_system_status_v2_controller()
		return rt.new_object('Automattic_WooCommerce_RestApi_WC_REST_System_Status_V2_Controller', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Features_Features', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_features_features()
		return rt.new_object('Automattic_WooCommerce_Admin_Features_Features', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_rest_api_server_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
