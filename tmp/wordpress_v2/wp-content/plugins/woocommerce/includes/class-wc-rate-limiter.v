import rt

pub fn Class_WC_Rate_Limiter.cache_group() string {
	return 'wc_rate_limit'
}

struct Class_WC_Rate_Limiter {
	rt.PhpObjectBase
}

fn Class_WC_Rate_Limiter.init() {
	rt.call_function('add_action', [rt.new_string('woocommerce_cleanup_rate_limits'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'cleanup' }])])
}

fn Class_WC_Rate_Limiter.storage_id(var_action_id rt.PhpVal) rt.PhpVal {
	return var_action_id.clone()
}

fn Class_WC_Rate_Limiter.get_cache_key(var_action_id rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_WC_Cache_Helper{}
	mut iife_result_0 := iife_temp_0.get_cache_prefix(rt.new_string('rate_limit' +
		var_action_id.str()))
	return iife_result_0
}

fn Class_WC_Rate_Limiter.get_cached(var_action_id rt.PhpVal) rt.PhpVal {
	return rt.call_function('wp_cache_get', [
		Class_WC_Rate_Limiter.get_cache_key(var_action_id.clone()),
		rt.new_string(Class_WC_Rate_Limiter.cache_group()),
	])
}

fn Class_WC_Rate_Limiter.set_cache(var_action_id rt.PhpVal, var_expiry rt.PhpVal) rt.PhpVal {
	return rt.call_function('wp_cache_set', [
		Class_WC_Rate_Limiter.get_cache_key(var_action_id.clone()),
		var_expiry.clone(),
		rt.new_string(Class_WC_Rate_Limiter.cache_group()),
	])
}

fn Class_WC_Rate_Limiter.retried_too_soon(var_action_id rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_next_try_allowed_at := Class_WC_Rate_Limiter.get_cached(var_action_id.clone())
	if rt.is_true(rt.identical(rt.new_bool(false), var_next_try_allowed_at)) {
		var_next_try_allowed_at = rt.call_method(var_wpdb, 'get_var', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('\n\t\t\t\t\t\tSELECT rate_limit_expiry\n\t\t\t\t\t\tFROM '), rt.get_property(var_wpdb,
					'prefix')),
					rt.new_string('wc_rate_limits\n\t\t\t\t\t\tWHERE rate_limit_key = %s\n\t\t\t\t\t')),
				var_action_id.clone(),
			]),
		])
		Class_WC_Rate_Limiter.set_cache(var_action_id.clone(), var_next_try_allowed_at.clone())
	}
	if rt.is_true(rt.identical(rt.new_null(), var_next_try_allowed_at)) {
		return false
	}
	if rt.is_true(rt.less_equal(rt.call_function('time', []rt.PhpVal{}), var_next_try_allowed_at)) {
		return true
	}
	return false
}

fn Class_WC_Rate_Limiter.set_rate_limit(var_action_id rt.PhpVal, var_delay rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_next_try_allowed_at := rt.add(rt.call_function('time', []rt.PhpVal{}), var_delay)
	mut var_result := rt.call_method(var_wpdb, 'replace', [
		rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'wc_rate_limits'),
		rt.create_array([rt.ArrayItem{ key: 'rate_limit_key', val: var_action_id },
			rt.ArrayItem{ key: 'rate_limit_expiry', val: var_next_try_allowed_at }]),
		rt.create_array([rt.ArrayItem{ key: none, val: '%s' },
			rt.ArrayItem{ key: none, val: '%d' }]),
	])
	Class_WC_Rate_Limiter.set_cache(var_action_id.clone(), var_next_try_allowed_at.clone())
	return rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_result)))
}

fn Class_WC_Rate_Limiter.cleanup() {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')),
				rt.new_string('wc_rate_limits WHERE rate_limit_expiry < %d')),
			rt.call_function('time', []rt.PhpVal{}),
		]),
	])
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Cache_Helper')])) {
		mut iife_temp_1 := Class_WC_Cache_Helper{}
		mut iife_result_1 :=
			iife_temp_1.invalidate_cache_group(rt.new_string(Class_WC_Rate_Limiter.cache_group()))
	}
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

fn create_wc_rate_limiter(_args ...rt.PhpVal) &Class_WC_Rate_Limiter {
	mut obj := &Class_WC_Rate_Limiter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cache_helper(_args ...rt.PhpVal) &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Rate_Limiter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_Rate_Limiter.init()
			return rt.new_null()
		}
		'storage_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Rate_Limiter.storage_id(dispatch_arg_0)
		}
		'get_cache_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Rate_Limiter.get_cache_key(dispatch_arg_0)
		}
		'get_cached' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Rate_Limiter.get_cached(dispatch_arg_0)
		}
		'set_cache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Rate_Limiter.set_cache(dispatch_arg_0, dispatch_arg_1)
		}
		'retried_too_soon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Rate_Limiter.retried_too_soon(dispatch_arg_0))
		}
		'set_rate_limit' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Rate_Limiter.set_rate_limit(dispatch_arg_0, dispatch_arg_1))
		}
		'cleanup' {
			Class_WC_Rate_Limiter.cleanup()
			return rt.new_null()
		}
		else {
			return none
		}
	}
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	Class_WC_Rate_Limiter.init()
}
