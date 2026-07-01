import rt

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Config {
	rt.PhpObjectBase
pub mut:
		supported_product_types rt.PhpVal = rt.new_null()
		supported_product_statuses rt.PhpVal = rt.new_null()
		eligible_stock_statuses rt.PhpVal = rt.new_null()
		verification_expiration_time_threshold rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Config.get_supported_product_types() rt.PhpVal {
	if rt.is_true(rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.is_array())) {
		return // unsupported expression: Expr_StaticPropertyFetch
	}
	// unsupported assign target: Expr_StaticPropertyFetch
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Config.get_supported_product_statuses() rt.PhpVal {
	if rt.is_true(rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.is_array())) {
		return // unsupported expression: Expr_StaticPropertyFetch
	}
	// unsupported assign target: Expr_StaticPropertyFetch
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Config.get_eligible_stock_statuses() rt.PhpVal {
	if rt.is_true(rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.is_array())) {
		return // unsupported expression: Expr_StaticPropertyFetch
	}
	// unsupported assign target: Expr_StaticPropertyFetch
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Config.get_product_signups_meta_key() string {
	return 'customer_stock_notifications_enable_signups'
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Config.allows_signups() bool {
	return (rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_customer_stock_notifications_allow_signups'), rt.new_string('no')]))).to_bool()
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Config.requires_double_opt_in() bool {
	return (rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_customer_stock_notifications_require_double_opt_in'), rt.new_string('no')]))).to_bool()
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Config.requires_account() bool {
	return (rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_customer_stock_notifications_require_account'), rt.new_string('no')]))).to_bool()
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Config.creates_account_on_signup() bool {
	return (rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_customer_stock_notifications_create_account_on_signup'), rt.new_string('no')]))).to_bool()
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Config.get_unverified_deletion_days_threshold() i64 {
	return (rt.call_function('absint', [rt.call_function('get_option', [rt.new_string('woocommerce_customer_stock_notifications_unverified_deletions_days_threshold'), rt.new_int(0)])])).to_i64()
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Config.get_verification_expiration_time_threshold() i64 {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.is_null()))))) {
		return (// unsupported expression: Expr_StaticPropertyFetch).to_i64()
	}
	// unsupported assign target: Expr_StaticPropertyFetch
	return (// unsupported expression: Expr_StaticPropertyFetch).to_i64()
}

fn create_automattic_woocommerce_internal_stocknotifications_config() &Class_Automattic_WooCommerce_Internal_StockNotifications_Config {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Config{
		PhpObjectBase: rt.PhpObjectBase{}
		supported_product_types: rt.new_null()
		supported_product_statuses: rt.new_null()
		eligible_stock_statuses: rt.new_null()
		verification_expiration_time_threshold: rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Config) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_supported_product_types' {
			return Class_Automattic_WooCommerce_Internal_StockNotifications_Config.get_supported_product_types()
		}
		'get_supported_product_statuses' {
			return Class_Automattic_WooCommerce_Internal_StockNotifications_Config.get_supported_product_statuses()
		}
		'get_eligible_stock_statuses' {
			return Class_Automattic_WooCommerce_Internal_StockNotifications_Config.get_eligible_stock_statuses()
		}
		'get_product_signups_meta_key' {
			return rt.new_string(Class_Automattic_WooCommerce_Internal_StockNotifications_Config.get_product_signups_meta_key())
		}
		'allows_signups' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_StockNotifications_Config.allows_signups())
		}
		'requires_double_opt_in' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_StockNotifications_Config.requires_double_opt_in())
		}
		'requires_account' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_StockNotifications_Config.requires_account())
		}
		'creates_account_on_signup' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_StockNotifications_Config.creates_account_on_signup())
		}
		'get_unverified_deletion_days_threshold' {
			return rt.new_int(Class_Automattic_WooCommerce_Internal_StockNotifications_Config.get_unverified_deletion_days_threshold())
		}
		'get_verification_expiration_time_threshold' {
			return rt.new_int(Class_Automattic_WooCommerce_Internal_StockNotifications_Config.get_verification_expiration_time_threshold())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Config) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'supported_product_types' { return this.supported_product_types }
		'supported_product_statuses' { return this.supported_product_statuses }
		'eligible_stock_statuses' { return this.eligible_stock_statuses }
		'verification_expiration_time_threshold' { return this.verification_expiration_time_threshold }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Config) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'supported_product_types' { this.supported_product_types = val; return true }
		'supported_product_statuses' { this.supported_product_statuses = val; return true }
		'eligible_stock_statuses' { this.eligible_stock_statuses = val; return true }
		'verification_expiration_time_threshold' { this.verification_expiration_time_threshold = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_src_internal_stocknotifications_config_php() {
	// unsupported statement: Stmt_Declare
}
