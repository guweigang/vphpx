import rt

struct Class_Automattic_WooCommerce_Admin_API_ShippingPartnerSuggestions {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc-admin')
		rest_base rt.PhpVal = rt.new_string('shipping-partner-suggestions')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ShippingPartnerSuggestions) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ShippingPartnerSuggestions', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_suggestions' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ShippingPartnerSuggestions', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_permission_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force_default_suggestions', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Return the default shipping partner suggestions when woocommerce_show_marketplace_suggestions option is set to no'), rt.new_string('woocommerce')]) }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ShippingPartnerSuggestions', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_suggestions_schema' }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ShippingPartnerSuggestions) get_permission_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_plugins')]))))) {
		return (create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_cannot_update'), rt.call_function('__', [rt.new_string('You do not have permissions to manage plugins. Please contact your site administrator.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ShippingPartnerSuggestions) should_display() bool {
	if rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [rt.new_string('woocommerce_show_marketplace_suggestions'), rt.new_string('yes')]))) {
		return false
	}
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_allow_shipping_partner_suggestions'), rt.new_bool(true)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ShippingPartnerSuggestions) get_suggestions(var_request rt.PhpVal) rt.PhpVal {
	mut var_should_display := rt.new_bool(this.should_display())
	mut var_force_default := rt.call_method(var_request, 'get_param', [rt.new_string('force_default_suggestions')])
	if rt.is_true(var_should_display) {
		return fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestions{}; return temp.get_suggestions() }()
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), var_should_display)) && rt.is_true(rt.identical(rt.new_bool(true), var_force_default)))) {
		return rt.call_function('rest_ensure_response', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestions{}; return temp.get_suggestions(arg_0) }(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners{}; return temp.get_all() }())])
	}
	return rt.call_function('rest_ensure_response', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestions{}; return temp.get_suggestions(arg_0) }(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners{}; return temp.get_all() }())])
}

fn Class_Automattic_WooCommerce_Admin_API_ShippingPartnerSuggestions.get_suggestions_schema() rt.PhpVal {
	mut var_feature_def := rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'icon', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }])
	mut var_layout_def := rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'image', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: '' }]) }, rt.ArrayItem{ key: 'image_label', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: '' }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: '' }]) }, rt.ArrayItem{ key: 'features', val: var_feature_def }]) }])
	mut var_item_schema := rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'is_visible' }, rt.ArrayItem{ key: none, val: 'available_layouts' }]) }, rt.ArrayItem{ key: 'anyOf', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'required', val: 'layout_row' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'required', val: 'layout_column' }]) }]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Plugin name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'slug', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Plugin slug used in https://wordpress.org/plugins/{slug}.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'layout_row', val: var_layout_def }, rt.ArrayItem{ key: 'layout_column', val: var_layout_def }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Description'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'learn_more_link', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Learn more link .'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'is_visible', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Suggestion visibility.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'available_layouts', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Available layouts -- single, dual, or both'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'row' }, rt.ArrayItem{ key: none, val: 'column' }]) }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'countries_where_primary', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Countries where this partner should appear first.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }])
	mut var_schema := rt.create_array([rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: 'shipping-partner-suggestions' }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: none, val: var_item_schema }]) }])
	return var_schema.dup()
}

struct Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestions {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_shippingpartnersuggestions() &Class_Automattic_WooCommerce_Admin_API_ShippingPartnerSuggestions {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_ShippingPartnerSuggestions{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc-admin')
		rest_base: rt.new_string('shipping-partner-suggestions')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_rest_data_controller() &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wp_error() &Class_Automattic_WooCommerce_Admin_API_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_shippingpartnersuggestions_shippingpartnersuggestions() &Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestions {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_shippingpartnersuggestions_defaultshippingpartners() &Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ShippingPartnerSuggestions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_permission_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_permission_check(dispatch_arg_0))
		}
		'should_display' {
			return rt.new_bool(this.should_display())
		}
		'get_suggestions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_suggestions(dispatch_arg_0)
		}
		'get_suggestions_schema' {
			return Class_Automattic_WooCommerce_Admin_API_ShippingPartnerSuggestions.get_suggestions_schema()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_ShippingPartnerSuggestions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ShippingPartnerSuggestions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_ShippingPartnerSuggestions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ShippingPartnerSuggestions_DefaultShippingPartners) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_shippingpartnersuggestions_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
