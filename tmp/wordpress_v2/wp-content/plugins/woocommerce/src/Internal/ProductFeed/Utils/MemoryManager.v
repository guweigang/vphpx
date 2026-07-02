import rt

struct Class_Automattic_WooCommerce_Internal_ProductFeed_Utils_MemoryManager {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Utils_MemoryManager) get_available_memory() i64 {
	mut var_memory_limit := rt.call_function('wp_convert_hr_to_bytes', [
		rt.call_function('ini_get', [rt.new_string('memory_limit')]),
	])
	if rt.is_true(rt.greater_equal(rt.new_int(0), var_memory_limit)) {
		return 0
	}
	return rt.new_int((rt.call_function('round', [
		rt.sub(rt.new_int(100), rt.mul(rt.div(rt.call_function('memory_get_usage', [
			rt.new_bool(true),
		]), var_memory_limit), rt.new_int(100))),
	])).to_i64())
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Utils_MemoryManager) flush_caches() {
	mut var_wpdb := rt.new_null()
	mut var_wp_object_cache := rt.new_null()
	rt.set_property(var_wpdb, 'queries', rt.new_array())
	rt.call_function('wp_cache_flush', []rt.PhpVal{})
	if !(var_wp_object_cache.clone().is_object()) {
		return
	}
	rt.set_property(var_wp_object_cache, 'group_ops', rt.new_array())
	rt.set_property(var_wp_object_cache, 'stats', rt.new_array())
	rt.set_property(var_wp_object_cache, 'memcache_debug', rt.new_array())
	rt.set_property(var_wp_object_cache, 'cache', rt.new_array())
	if rt.is_true(rt.call_function('method_exists', [var_wp_object_cache.clone(),
		rt.new_string('__remoteset')]))
	{
		rt.call_method(var_wp_object_cache, '__remoteset', []rt.PhpVal{})
	}
	this.collect_garbage()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Utils_MemoryManager) collect_garbage() {
	mut var_gc_threshold := 5000
	mut var_gc_too_low_in_a_row := 0
	mut var_gc_too_high_in_a_row := 0
	mut var_gc_threshold_step := rt.new_int(2500)
	mut var_gc_status := rt.call_function('gc_status', []rt.PhpVal{})
	if rt.is_true(rt.greater(var_gc_threshold, var_gc_status.array_get(rt.new_string('threshold')))) {
		var_gc_threshold = var_gc_status.array_get(rt.new_string('threshold'))
	}
	if rt.is_true(rt.greater(var_gc_status.array_get(rt.new_string('roots')), var_gc_threshold)) {
		mut var_collected := rt.call_function('gc_collect_cycles', []rt.PhpVal{})
		if rt.is_true(rt.less(var_collected, rt.new_int(100))) {
			if rt.is_true(rt.greater(var_gc_too_low_in_a_row, rt.new_int(0))) {
				var_gc_too_low_in_a_row = rt.new_int(0)
				var_gc_threshold = rt.add(var_gc_threshold, var_gc_threshold_step)
				var_gc_threshold = rt.call_function('min', [var_gc_threshold.clone(),
					rt.new_int(1000000000), var_gc_status.array_get(rt.new_string('threshold'))])
			} else {
				rt.pre_inc(var_gc_too_low_in_a_row)
			}
			var_gc_too_high_in_a_row = rt.new_int(0)
		} else {
			if rt.is_true(rt.greater(var_gc_too_high_in_a_row, rt.new_int(0))) {
				var_gc_too_high_in_a_row = rt.new_int(0)
				var_gc_threshold = rt.sub(var_gc_threshold, var_gc_threshold_step)
				var_gc_threshold = rt.call_function('max', [var_gc_threshold.clone(),
					rt.new_int(5000)])
			} else {
				rt.pre_inc(var_gc_too_high_in_a_row)
			}
			var_gc_too_low_in_a_row = rt.new_int(0)
		}
	}
}

fn create_automattic_woocommerce_internal_productfeed_utils_memorymanager(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductFeed_Utils_MemoryManager {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFeed_Utils_MemoryManager{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Utils_MemoryManager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_available_memory' {
			return rt.new_int(this.get_available_memory())
		}
		'flush_caches' {
			this.flush_caches()
			return rt.new_null()
		}
		'collect_garbage' {
			this.collect_garbage()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFeed_Utils_MemoryManager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Utils_MemoryManager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
