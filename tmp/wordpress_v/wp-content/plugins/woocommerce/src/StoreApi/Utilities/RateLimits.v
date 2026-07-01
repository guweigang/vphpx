import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.cache_group() string {
	return 'store_api_rate_limit'
}
pub fn Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.enabled() bool {
	return false
}
pub fn Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.proxy_support() bool {
	return false
}
pub fn Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.limit() i64 {
	return 25
}
pub fn Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.seconds() i64 {
	return 10
}
struct Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.get_cache_key(var_action_id rt.PhpVal) string {
	return (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.get_cache_prefix(arg_0) }(rt.new_string('store_api_rate_limit' + (var_action_id).str()))).str()
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.get_rate_limit_row(action_id string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_time := rt.call_function('time', []rt.PhpVal{})
	mut var_row := rt.call_method(var_wpdb, 'get_row', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('\n\t\t\t\t\tSELECT rate_limit_expiry as reset, rate_limit_remaining as remaining\n\t\t\t\t\tFROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_rate_limits\n\t\t\t\t\tWHERE rate_limit_key = %s\n\t\t\t\t\tAND rate_limit_expiry > %s\n\t\t\t\t')), rt.new_string(action_id), var_time.dup()]), rt.new_string('OBJECT')])
	if !rt.is_true(var_row) {
		mut var_options := Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.get_options()
		return // unsupported expression: Expr_Cast_Object
	}
	return // unsupported expression: Expr_Cast_Object
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.get_rate_limit(action_id string) rt.PhpVal {
	mut var_current_limit := Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.get_cached(rt.new_string(action_id))
	if rt.is_true(rt.identical(rt.new_bool(false), var_current_limit)) {
		var_current_limit = Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.get_rate_limit_row(action_id)
		Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.set_cache(rt.new_string(action_id), var_current_limit.dup())
	}
	return var_current_limit.dup()
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.is_exceeded_retry_after(action_id string) bool {
	mut var_current_limit := Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.get_rate_limit(action_id)
	mut var_time := rt.call_function('time', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.less_equal(var_time, // unsupported expression: Expr_Cast_Int)) && rt.is_true(rt.identical(rt.new_int(0), // unsupported expression: Expr_Cast_Int)))) {
		return (rt.sub(// unsupported expression: Expr_Cast_Int, var_time)).to_bool()
	}
	return false
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.update_rate_limit(action_id string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_options := Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.get_options()
	mut var_time := rt.call_function('time', []rt.PhpVal{})
	mut var_rate_limit_expiry := rt.add(var_time, // unsupported expression: Expr_Cast_Int)
	rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('INSERT INTO '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_rate_limits\n\t\t\t\t\t(`rate_limit_key`, `rate_limit_expiry`, `rate_limit_remaining`)\n\t\t\t\tVALUES\n\t\t\t\t\t(%s, %d, %d)\n\t\t\t\tON DUPLICATE KEY UPDATE\n\t\t\t\t\t`rate_limit_remaining` = IF(`rate_limit_expiry` < %d, VALUES(`rate_limit_remaining`), GREATEST(`rate_limit_remaining` - 1, 0)),\n\t\t\t\t\t`rate_limit_expiry` = IF(`rate_limit_expiry` < %d, VALUES(`rate_limit_expiry`), `rate_limit_expiry`);\n\t\t\t\t')), rt.new_string(action_id), var_rate_limit_expiry.dup(), rt.sub(// unsupported expression: Expr_Cast_Int, rt.new_int(1)), var_time.dup(), var_time.dup()])])
	mut var_current_limit := Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.get_rate_limit_row(action_id)
	Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.set_cache(rt.new_string(action_id), var_current_limit.dup())
	return var_current_limit.dup()
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.get_cached(var_action_id rt.PhpVal) rt.PhpVal {
	return rt.call_function('wp_cache_get', [Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.get_cache_key(var_action_id.dup()), Class_Automattic_WooCommerce_StoreApi_Utilities_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.cache_group()])
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.set_cache(var_action_id rt.PhpVal, var_current_limit rt.PhpVal) bool {
	mut var_current_limit_mutated := var_current_limit
	return (rt.call_function('wp_cache_set', [Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.get_cache_key(var_action_id.dup()), var_current_limit_mutated.dup(), Class_Automattic_WooCommerce_StoreApi_Utilities_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.cache_group()])).to_bool()
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.get_options() rt.PhpVal {
	mut var_default_options := rt.create_array([rt.ArrayItem{ key: 'enabled', val: Class_Automattic_WooCommerce_StoreApi_Utilities_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.enabled() }, rt.ArrayItem{ key: 'proxy_support', val: Class_Automattic_WooCommerce_StoreApi_Utilities_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.proxy_support() }, rt.ArrayItem{ key: 'limit', val: Class_Automattic_WooCommerce_StoreApi_Utilities_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.limit() }, rt.ArrayItem{ key: 'seconds', val: Class_Automattic_WooCommerce_StoreApi_Utilities_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.seconds() }])
	return // unsupported expression: Expr_Cast_Object
}

fn Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.get_option(var_option rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_option.dup().is_string()))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', ['RateLimits::' + var_option.dup().to_string().to_upper()]))))))) {
		return rt.new_null()
	}
	return Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.get_options().array_get(var_option)
}

struct Class_WC_Rate_Limiter {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_utilities_ratelimits() &Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_rate_limiter() &Class_WC_Rate_Limiter {
	mut obj := &Class_WC_Rate_Limiter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cache_helper() &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_cache_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.get_cache_key(dispatch_arg_0))
		}
		'get_rate_limit_row' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.get_rate_limit_row(dispatch_arg_0)
		}
		'get_rate_limit' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.get_rate_limit(dispatch_arg_0)
		}
		'is_exceeded_retry_after' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.is_exceeded_retry_after(dispatch_arg_0))
		}
		'update_rate_limit' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.update_rate_limit(dispatch_arg_0)
		}
		'get_cached' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.get_cached(dispatch_arg_0)
		}
		'set_cache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.set_cache(dispatch_arg_0, dispatch_arg_1))
		}
		'get_options' {
			return Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.get_options()
		}
		'get_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits.get_option(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_RateLimits) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Rate_Limiter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Rate_Limiter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Rate_Limiter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_storeapi_utilities_ratelimits_php() {
}
