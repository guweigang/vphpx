import rt

pub fn Class_Automattic_WooCommerce_Internal_ProductFilters_CacheController.cache_group() string {
	return 'filter_data'
}

pub fn Class_Automattic_WooCommerce_Internal_ProductFilters_CacheController.cache_entry_count_transient() string {
	return 'wc_filter_data_entry_count'
}

struct Class_Automattic_WooCommerce_Internal_ProductFilters_CacheController {
	rt.PhpObjectBase
pub mut:
	taxonomy_hierarchy_data rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_CacheController) init(mut var_taxonomy_hierarchy_data Class_Automattic_WooCommerce_Internal_ProductFilters_TaxonomyHierarchyData) {
	this.taxonomy_hierarchy_data = var_taxonomy_hierarchy_data
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_CacheController) register() {
	if !(this.need_cleanup()) {
		return
	}
	rt.call_function('add_action', [
		rt.new_string('woocommerce_after_product_object_save'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_CacheController', [
				'RegisterHooksInterface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'invalidate_filter_data_cache' },
		]),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_delete_product_transients'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_CacheController', [
				'RegisterHooksInterface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'invalidate_filter_data_cache' },
		]),
	])
	rt.call_function('add_action', [rt.new_string('created_term'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_CacheController', [
				'RegisterHooksInterface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'clear_taxonomy_hierarchy_cache' },
		]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('edited_term'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_CacheController', [
				'RegisterHooksInterface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'clear_taxonomy_hierarchy_cache' },
		]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('delete_term'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_CacheController', [
				'RegisterHooksInterface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'clear_taxonomy_hierarchy_cache' },
		]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('added_term_meta'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_CacheController', [
				'RegisterHooksInterface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'clear_taxonomy_hierarchy_cache_on_meta_update' },
		]),
		rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('updated_term_meta'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_CacheController', [
				'RegisterHooksInterface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'clear_taxonomy_hierarchy_cache_on_meta_update' },
		]),
		rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('deleted_term_meta'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductFilters_CacheController', [
				'RegisterHooksInterface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'clear_taxonomy_hierarchy_cache_on_meta_update' },
		]),
		rt.new_int(10), rt.new_int(4)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_CacheController) invalidate_filter_data_cache() {
	mut iife_temp_0 := Class_WC_Cache_Helper{}
	mut iife_result_0 := iife_temp_0.get_transient_version(Class_Automattic_WooCommerce_Internal_ProductFilters_Automattic_WooCommerce_Internal_ProductFilters_CacheController.cache_group(),
		rt.new_bool(true))
	mut iife_temp_1 := Class_WC_Cache_Helper{}
	mut iife_result_1 :=
		iife_temp_1.invalidate_cache_group(Class_Automattic_WooCommerce_Internal_ProductFilters_Automattic_WooCommerce_Internal_ProductFilters_CacheController.cache_group())
	rt.call_function('delete_transient', [
		Class_Automattic_WooCommerce_Internal_ProductFilters_Automattic_WooCommerce_Internal_ProductFilters_CacheController.cache_entry_count_transient(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_CacheController) clear_taxonomy_hierarchy_cache(var_term_id rt.PhpVal, var_term_taxonomy_id rt.PhpVal, var_taxonomy rt.PhpVal) {
	if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [
		var_taxonomy.clone()]))
	{
		rt.call_method(this.taxonomy_hierarchy_data, 'clear_cache', [
			var_taxonomy.clone()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_CacheController) clear_taxonomy_hierarchy_cache_on_meta_update(var_meta_id rt.PhpVal, var_term_id rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('order'), var_meta_key)))) {
		return
	}
	mut var_term := rt.call_function('get_term', [var_term_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_term,
		'Automattic_WooCommerce_Internal_ProductFilters_WP_Term'))))))
	{
		return
	}
	rt.call_method(this.taxonomy_hierarchy_data, 'clear_cache', [
		rt.get_property(var_term, 'taxonomy'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_CacheController) delete_filter_data_transients() {
	mut var_wpdb := rt.new_null()
	if !(this.need_cleanup()) {
		return
	}
	rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'options')),
				rt.new_string(' WHERE option_name LIKE %s OR option_name LIKE %s')),
			rt.new_string(
				(rt.call_method(var_wpdb, 'esc_like', [rt.new_string('_transient_wc_filter_data_')])).str() +
				'%'),
			rt.new_string(
				(rt.call_method(var_wpdb, 'esc_like', [rt.new_string('_transient_timeout_wc_filter_data_')])).str() +
				'%'),
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_CacheController) need_cleanup() bool {
	return !(!rt.is_true(rt.call_function('get_transient', [
		rt.new_string(
			(Class_Automattic_WooCommerce_Internal_ProductFilters_Automattic_WooCommerce_Internal_ProductFilters_CacheController.cache_group()).str() + '-transient-version'),
	])))
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_productfilters_cachecontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductFilters_CacheController {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFilters_CacheController{
		PhpObjectBase:           rt.PhpObjectBase{}
		taxonomy_hierarchy_data: rt.new_null()
	}
	return obj
}

fn create_wc_cache_helper(_args ...rt.PhpVal) &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_CacheController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_TaxonomyHierarchyData](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'register' {
			this.register()
			return rt.new_null()
		}
		'invalidate_filter_data_cache' {
			this.invalidate_filter_data_cache()
			return rt.new_null()
		}
		'clear_taxonomy_hierarchy_cache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.clear_taxonomy_hierarchy_cache(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'clear_taxonomy_hierarchy_cache_on_meta_update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.clear_taxonomy_hierarchy_cache_on_meta_update(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'delete_filter_data_transients' {
			this.delete_filter_data_transients()
			return rt.new_null()
		}
		'need_cleanup' {
			return rt.new_bool(this.need_cleanup())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFilters_CacheController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'taxonomy_hierarchy_data' { return this.taxonomy_hierarchy_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_CacheController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'taxonomy_hierarchy_data' {
			this.taxonomy_hierarchy_data = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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
}
