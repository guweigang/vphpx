import rt

pub fn Class_Automattic_WooCommerce_Internal_Caches_ProductCacheController.feature_name() string {
	return 'product_instance_caching'
}

struct Class_Automattic_WooCommerce_Internal_Caches_ProductCacheController {
	rt.PhpObjectBase
pub mut:
	product_cache rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductCacheController) init(mut var_product_cache Class_Automattic_WooCommerce_Internal_Caches_ProductCache) {
	this.product_cache = var_product_cache
	this.set_product_cache_group_as_non_persistent()
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_ProductCacheController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'on_init' },
		]),
		rt.new_int(0)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductCacheController) on_init() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_0 :=
		iife_temp_0.feature_is_enabled(Class_Automattic_WooCommerce_Internal_Caches_Automattic_WooCommerce_Internal_Caches_ProductCacheController.feature_name())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		return
	}
	this.register_hooks()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductCacheController) register_hooks() {
	rt.call_function('add_action', [rt.new_string('clean_post_cache'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_ProductCacheController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'invalidate_product_cache_on_clean' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('updated_post_meta'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_ProductCacheController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'invalidate_product_cache_by_meta' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('added_post_meta'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_ProductCacheController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'invalidate_product_cache_by_meta' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('deleted_post_meta'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_ProductCacheController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'invalidate_product_cache_by_meta' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_updated_product_stock'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_ProductCacheController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'invalidate_product_cache' },
		]),
		rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('woocommerce_updated_product_sales'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Caches_ProductCacheController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'invalidate_product_cache' },
		]),
		rt.new_int(10), rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductCacheController) set_product_cache_group_as_non_persistent() {
	rt.call_function('wp_cache_add_non_persistent_groups', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_method(this.product_cache, 'get_object_type',
				[]rt.PhpVal{}) },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductCacheController) invalidate_product_cache_on_clean(var_post_id rt.PhpVal, var_post rt.PhpVal) {
	mut var_post_id_mutated := var_post_id
	var_post_id_mutated = rt.new_int(var_post_id_mutated.to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post, 'Automattic_WooCommerce_Internal_Caches_WP_Post'))))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'post_type'), rt.create_array([rt.ArrayItem{
		key: none
		val: 'product'
	}, rt.ArrayItem{ key: none, val: 'product_variation' }]), rt.new_bool(true)]))))) {
		return
	}
	rt.call_method(this.product_cache, 'remove', [var_post_id_mutated.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductCacheController) invalidate_product_cache(var_post_id rt.PhpVal) {
	mut var_post_id_mutated := var_post_id
	var_post_id_mutated = rt.new_int(var_post_id_mutated.to_i64())
	mut var_post_type := rt.call_function('get_post_type', [var_post_id_mutated.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_post_type.clone(), rt.create_array([rt.ArrayItem{
		key: none
		val: 'product'
	}, rt.ArrayItem{ key: none, val: 'product_variation' }]), rt.new_bool(true)]))))) {
		return
	}
	rt.call_method(this.product_cache, 'remove', [var_post_id_mutated.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductCacheController) invalidate_product_cache_by_meta(var_meta_id rt.PhpVal, var_object_id rt.PhpVal) {
	mut var_object_id_mutated := var_object_id
	var_object_id_mutated = rt.new_int(var_object_id_mutated.to_i64())
	if rt.is_true(rt.call_function('in_array', [
		rt.call_function('get_post_type', [var_object_id_mutated.clone()]),
		rt.create_array([rt.ArrayItem{ key: none, val: 'product' },
			rt.ArrayItem{ key: none, val: 'product_variation' }]),
		rt.new_bool(true),
	]))
	{
		this.invalidate_product_cache(var_object_id_mutated.clone())
	}
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_caches_productcachecontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Caches_ProductCacheController {
	mut obj := &Class_Automattic_WooCommerce_Internal_Caches_ProductCacheController{
		PhpObjectBase: rt.PhpObjectBase{}
		product_cache: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductCacheController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Caches_ProductCache](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'on_init' {
			this.on_init()
			return rt.new_null()
		}
		'register_hooks' {
			this.register_hooks()
			return rt.new_null()
		}
		'set_product_cache_group_as_non_persistent' {
			this.set_product_cache_group_as_non_persistent()
			return rt.new_null()
		}
		'invalidate_product_cache_on_clean' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.invalidate_product_cache_on_clean(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'invalidate_product_cache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.invalidate_product_cache(dispatch_arg_0)
			return rt.new_null()
		}
		'invalidate_product_cache_by_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.invalidate_product_cache_by_meta(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Caches_ProductCacheController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'product_cache' { return this.product_cache }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductCacheController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'product_cache' {
			this.product_cache = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
