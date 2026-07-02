import rt

pub fn Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.marketing_extension_category_slug() string {
	return 'marketing'
}
pub fn Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.marketing_channel_subcategory_slug() string {
	return 'sales-channels'
}
struct Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init) construct() {
	rt.call_function('add_action', [rt.new_string('woocommerce_updated'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'delete_specs_transient' }])])
}

fn Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.delete_specs_transient() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MarketingRecommendationsDataSourcePoller{}
	mut iife_result_0 := iife_temp_0.get_instance()
	rt.call_method(iife_result_0, 'delete_specs_transient', []rt.PhpVal{})
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MiscRecommendationsDataSourcePoller{}
	mut iife_result_1 := iife_temp_1.get_instance()
	rt.call_method(iife_result_1, 'delete_specs_transient', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.get_specs() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [rt.new_string('woocommerce_show_marketplace_suggestions'), rt.new_string('yes')]))) {
		mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_DefaultMarketingRecommendations{}
		mut iife_result_2 := iife_temp_2.get_all()
		return iife_result_2
	}
	mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MarketingRecommendationsDataSourcePoller{}
	mut iife_result_3 := iife_temp_3.get_instance()
	mut var_specs := rt.call_method(iife_result_3, 'get_specs_from_data_sources', []rt.PhpVal{})
	if !(var_specs.clone().is_array()) || 0 == var_specs.clone().array_count() {
		mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_DefaultMarketingRecommendations{}
		mut iife_result_4 := iife_temp_4.get_all()
		return iife_result_4
	}
	return var_specs.clone()
}

fn Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.get_misc_recommendations_specs() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [rt.new_string('woocommerce_show_marketplace_suggestions'), rt.new_string('yes')]))) {
		return rt.new_array()
	}
	mut iife_temp_5 := Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MiscRecommendationsDataSourcePoller{}
	mut iife_result_5 := iife_temp_5.get_instance()
	mut var_specs := rt.call_method(iife_result_5, 'get_specs_from_data_sources', []rt.PhpVal{})
	if !(var_specs.clone().is_array()) {
		return rt.new_array()
	}
	return var_specs.clone()
}

fn Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.evaluate_specs(mut var_specs Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_?array) rt.PhpVal {
	mut var_specs_mutated := var_specs
	mut var_suggestions := rt.new_array()
	mut var_errors := rt.new_array()
	mut iter_1 := var_specs_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_spec := item_1.val
		var_suggestions.array_push(Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.object_to_array(var_spec.clone()))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Throwable') {
			mut var_e := var_e_1.clone()
			var_errors.array_push(var_e.clone())
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
	}
	return rt.create_array([rt.ArrayItem{ key: 'suggestions', val: var_suggestions }, rt.ArrayItem{ key: 'errors', val: var_errors }])
}

fn Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.get_recommended_plugins() rt.PhpVal {
	mut var_specs := Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.get_specs()
	mut var_results := Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.evaluate_specs(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_?array](var_specs))
	mut var_specs_to_return := var_results.array_get(rt.new_string('suggestions'))
	mut var_specs_to_save := rt.new_null()
	if !rt.is_true(var_specs_to_return) {
	mut iife_temp_6 := Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_DefaultMarketingRecommendations{}
	mut iife_result_6 := iife_temp_6.get_all()
	var_specs_to_save = iife_result_6
	var_specs_to_return = Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.evaluate_specs(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_?array](var_specs_to_save)).array_get(rt.new_string('suggestions'))
	} else if var_results.array_get(rt.new_string('errors')).array_count() > 0 {
	var_specs_to_save = var_specs.clone()
	}
	if rt.is_true(var_specs_to_save) {
		mut iife_temp_7 := Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MarketingRecommendationsDataSourcePoller{}
		mut iife_result_7 := iife_temp_7.get_instance()
		rt.call_method(iife_result_7, 'set_specs_transient', [var_specs_to_save.clone(), rt.mul(rt.new_int(3), rt.get_constant('HOUR_IN_SECONDS'))])
	}
	mut var_errors := var_results.array_get(rt.new_string('errors'))
	if !(!rt.is_true(var_errors)) {
	mut iife_temp_8 := Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init{}
	mut iife_result_8 := iife_temp_8.log_errors(var_errors.clone())
	}
	return var_specs_to_return.clone()
}

fn Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.get_recommended_marketing_channels() rt.PhpVal {
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_plugin_data := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.is_marketing_channel_plugin(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_array](var_plugin_data))
		}
	return rt.call_function('array_filter', [Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.get_recommended_plugins(), rt.new_closure(closure_10_fn)])
}

fn Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.get_recommended_marketing_extensions_excluding_channels() rt.PhpVal {
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_plugin_data := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(rt.is_true(Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.is_marketing_plugin(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_array](var_plugin_data))) && rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.is_marketing_channel_plugin(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_array](var_plugin_data)))))))
		}
	return rt.call_function('array_filter', [Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.get_recommended_plugins(), rt.new_closure(closure_11_fn)])
}

fn Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.get_misc_recommendations() rt.PhpVal {
	mut var_specs := Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.get_misc_recommendations_specs()
	mut var_results := Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.evaluate_specs(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_?array](var_specs))
	mut var_specs_to_return := var_results.array_get(rt.new_string('suggestions'))
	mut var_specs_to_save := rt.new_null()
	if !rt.is_true(var_specs_to_return) {
	var_specs_to_save = rt.new_array()
	} else if var_results.array_get(rt.new_string('errors')).array_count() > 0 {
	var_specs_to_save = var_specs.clone()
	}
	if rt.is_true(var_specs_to_save) {
		mut iife_temp_11 := Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MiscRecommendationsDataSourcePoller{}
		mut iife_result_11 := iife_temp_11.get_instance()
		rt.call_method(iife_result_11, 'set_specs_transient', [var_specs_to_save.clone(), rt.mul(rt.new_int(3), rt.get_constant('HOUR_IN_SECONDS'))])
	}
	mut var_errors := var_results.array_get(rt.new_string('errors'))
	if !(!rt.is_true(var_errors)) {
	mut iife_temp_12 := Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init{}
	mut iife_result_12 := iife_temp_12.log_errors(var_errors.clone())
	}
	return var_specs_to_return.clone()
}

fn Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.is_marketing_plugin(mut var_plugin_data Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_array) bool {
	mut var_categories := if !(var_plugin_data.array_get(rt.new_string('categories'))).is_null() { var_plugin_data.array_get(rt.new_string('categories')) } else { rt.new_array() }
	return (rt.call_function('in_array', [Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.marketing_extension_category_slug(), var_categories.clone(), rt.new_bool(true)])).to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.is_marketing_channel_plugin(mut var_plugin_data Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_array) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.is_marketing_plugin(mut var_plugin_data))))) {
		return false
	}
	mut var_subcategories := if !(var_plugin_data.array_get(rt.new_string('subcategories'))).is_null() { var_plugin_data.array_get(rt.new_string('subcategories')) } else { rt.new_array() }
	mut iter_2 := var_subcategories.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_subcategory := item_2.val
		if var_subcategory.array_isset(rt.new_string('slug')) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.marketing_channel_subcategory_slug(), var_subcategory.array_get(rt.new_string('slug')))) {
			return true
		}
	}
	return false
}

fn Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.object_to_array(var_obj rt.PhpVal, var_visited rt.PhpVal) rt.PhpVal {
	mut var_obj_mutated := var_obj
	mut var_visited_mutated := var_visited
	if rt.is_true(rt.new_bool(var_obj_mutated.clone().is_object())) {
		if rt.is_true(rt.call_function('in_array', [var_obj_mutated.clone(), var_visited_mutated.clone(), rt.new_bool(true)])) {
			return rt.new_null()
		}
		var_visited_mutated.array_push(var_obj_mutated.clone())
	var_obj_mutated = rt.cast_array(var_obj_mutated)
	}
	if rt.is_true(rt.new_bool(var_obj_mutated.clone().is_array())) {
		mut var_new := rt.new_array()
		mut iter_3 := var_obj_mutated.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_val := item_3.val
			mut var_key := item_3.key
			var_new.array_set(var_key, Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.object_to_array(var_val.clone(), var_visited_mutated.clone()))
		}
	} else {
	var_new = var_obj_mutated.clone()
	}
	return var_new.clone()
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MarketingRecommendationsDataSourcePoller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MiscRecommendationsDataSourcePoller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_DefaultMarketingRecommendations {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_marketingrecommendations_init() &Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_remotespecsengine(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_marketingrecommendations_marketingrecommendationsdatasourcepoller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MarketingRecommendationsDataSourcePoller {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MarketingRecommendationsDataSourcePoller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_marketingrecommendations_miscrecommendationsdatasourcepoller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MiscRecommendationsDataSourcePoller {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MiscRecommendationsDataSourcePoller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_marketingrecommendations_defaultmarketingrecommendations(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_DefaultMarketingRecommendations {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_DefaultMarketingRecommendations{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'delete_specs_transient' {
			Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.delete_specs_transient()
			return rt.new_null()
		}
		'get_specs' {
			return Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.get_specs()
		}
		'get_misc_recommendations_specs' {
			return Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.get_misc_recommendations_specs()
		}
		'evaluate_specs' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_?array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.evaluate_specs(mut dispatch_arg_0)
		}
		'get_recommended_plugins' {
			return Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.get_recommended_plugins()
		}
		'get_recommended_marketing_channels' {
			return Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.get_recommended_marketing_channels()
		}
		'get_recommended_marketing_extensions_excluding_channels' {
			return Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.get_recommended_marketing_extensions_excluding_channels()
		}
		'get_misc_recommendations' {
			return Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.get_misc_recommendations()
		}
		'is_marketing_plugin' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.is_marketing_plugin(mut dispatch_arg_0))
		}
		'is_marketing_channel_plugin' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.is_marketing_channel_plugin(mut dispatch_arg_0))
		}
		'object_to_array' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init.object_to_array(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Init) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MarketingRecommendationsDataSourcePoller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MarketingRecommendationsDataSourcePoller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MarketingRecommendationsDataSourcePoller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MiscRecommendationsDataSourcePoller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MiscRecommendationsDataSourcePoller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MiscRecommendationsDataSourcePoller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_DefaultMarketingRecommendations) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_DefaultMarketingRecommendations) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_DefaultMarketingRecommendations) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
