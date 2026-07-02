import rt

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Config {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_internal_stocknotifications_config() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_StockNotifications_Config',
		'supported_product_types', rt.new_null())
	rt.init_static_prop('Automattic_WooCommerce_Internal_StockNotifications_Config',
		'supported_product_statuses', rt.new_null())
	rt.init_static_prop('Automattic_WooCommerce_Internal_StockNotifications_Config',
		'eligible_stock_statuses', rt.new_null())
	rt.init_static_prop('Automattic_WooCommerce_Internal_StockNotifications_Config',
		'verification_expiration_time_threshold', rt.new_null())
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Config.get_supported_product_types() rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.get_static_prop('Automattic_WooCommerce_Internal_StockNotifications_Config',
		'supported_product_types').is_array()))
	{
		return rt.get_static_prop('Automattic_WooCommerce_Internal_StockNotifications_Config',
			'supported_product_types')
	}
	rt.set_static_prop('Automattic_WooCommerce_Internal_StockNotifications_Config',
		'supported_product_types', rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_customer_stock_notifications_supported_product_types'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductType.simple() },
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductType.variable() },
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductType.variation() },
		]),
	])))
	return rt.get_static_prop('Automattic_WooCommerce_Internal_StockNotifications_Config',
		'supported_product_types')
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Config.get_supported_product_statuses() rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.get_static_prop('Automattic_WooCommerce_Internal_StockNotifications_Config',
		'supported_product_statuses').is_array()))
	{
		return rt.get_static_prop('Automattic_WooCommerce_Internal_StockNotifications_Config',
			'supported_product_statuses')
	}
	rt.set_static_prop('Automattic_WooCommerce_Internal_StockNotifications_Config',
		'supported_product_statuses', rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_customer_stock_notifications_supported_product_stock_statuses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductStatus.publish() },
		]),
	])))
	return rt.get_static_prop('Automattic_WooCommerce_Internal_StockNotifications_Config',
		'supported_product_statuses')
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Config.get_eligible_stock_statuses() rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.get_static_prop('Automattic_WooCommerce_Internal_StockNotifications_Config',
		'eligible_stock_statuses').is_array()))
	{
		return rt.get_static_prop('Automattic_WooCommerce_Internal_StockNotifications_Config',
			'eligible_stock_statuses')
	}
	rt.set_static_prop('Automattic_WooCommerce_Internal_StockNotifications_Config',
		'eligible_stock_statuses', rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_customer_stock_notifications_supported_stock_statuses'),
		rt.create_array([
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_ProductStockStatus.in_stock()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_ProductStockStatus.on_backorder()
			},
		]),
	])))
	return rt.get_static_prop('Automattic_WooCommerce_Internal_StockNotifications_Config',
		'eligible_stock_statuses')
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Config.get_product_signups_meta_key() string {
	return 'customer_stock_notifications_enable_signups'
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Config.allows_signups() bool {
	return (rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_customer_stock_notifications_allow_signups'),
		rt.new_string('no'),
	]))).to_bool()
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Config.requires_double_opt_in() bool {
	return (rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_customer_stock_notifications_require_double_opt_in'),
		rt.new_string('no'),
	]))).to_bool()
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Config.requires_account() bool {
	return (rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_customer_stock_notifications_require_account'),
		rt.new_string('no'),
	]))).to_bool()
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Config.creates_account_on_signup() bool {
	return (rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_customer_stock_notifications_create_account_on_signup'),
		rt.new_string('no'),
	]))).to_bool()
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Config.get_unverified_deletion_days_threshold() i64 {
	return (rt.call_function('absint', [
		rt.call_function('get_option', [
			rt.new_string('woocommerce_customer_stock_notifications_unverified_deletions_days_threshold'),
			rt.new_int(0),
		]),
	])).to_i64()
}

fn Class_Automattic_WooCommerce_Internal_StockNotifications_Config.get_verification_expiration_time_threshold() i64 {
	if !(rt.get_static_prop('Automattic_WooCommerce_Internal_StockNotifications_Config',
		'verification_expiration_time_threshold').is_null()) {
		return (rt.get_static_prop('Automattic_WooCommerce_Internal_StockNotifications_Config',
			'verification_expiration_time_threshold')).to_i64()
	}
	rt.set_static_prop('Automattic_WooCommerce_Internal_StockNotifications_Config',
		'verification_expiration_time_threshold', rt.new_int((rt.call_function('apply_filters', [
		rt.new_string('woocommerce_customer_stock_notifications_verification_expiration_time_threshold'),
		rt.get_constant('HOUR_IN_SECONDS'),
	])).to_i64()))
	return (rt.get_static_prop('Automattic_WooCommerce_Internal_StockNotifications_Config',
		'verification_expiration_time_threshold')).to_i64()
}

fn create_automattic_woocommerce_internal_stocknotifications_config(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Config {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Config{
		PhpObjectBase: rt.PhpObjectBase{}
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
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Config) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Config) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
