import rt

struct Class_WC_Marketplace_Updater {
	rt.PhpObjectBase
}

fn Class_WC_Marketplace_Updater.load() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'init' }])])
}

fn Class_WC_Marketplace_Updater.init() {
	rt.call_function('add_action', [
		rt.new_string('woocommerce_update_marketplace_suggestions'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'update_marketplace_suggestions' }]),
	])
}

fn Class_WC_Marketplace_Updater.update_marketplace_suggestions() rt.PhpVal {
	mut var_data := rt.call_function('get_option', [
		rt.new_string('woocommerce_marketplace_suggestions'),
		rt.create_array([rt.ArrayItem{ key: 'suggestions', val: rt.new_array() },
			rt.ArrayItem{ key: 'updated', val: rt.call_function('time', []rt.PhpVal{}) }]),
	])
	var_data.array_set('updated', rt.call_function('time', []rt.PhpVal{}))
	mut var_request_data := rt.new_array()
	mut var_allow_tracking := rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_allow_tracking'),
		rt.new_string('no'),
	]))
	mut iife_temp_0 := Class_WC_Marketplace_Suggestions{}
	mut iife_result_0 := iife_temp_0.allow_suggestions()
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Marketplace_Suggestions')]))
		&& rt.is_true(iife_result_0) && rt.is_true(var_allow_tracking) {
		var_request_data =
			Class_WC_Marketplace_Updater.add_personalization_data(var_request_data.clone())
	}
	mut var_url :=
		rt.new_string('https://woocommerce.com/wp-json/wccom/marketplace-suggestions/2.0/suggestions.json')
	if !(!rt.is_true(var_request_data)) {
		var_url = rt.call_function('add_query_arg', [var_request_data.clone(),
			var_url.clone()])
	}
	mut var_request := rt.call_function('wp_safe_remote_get', [
		var_url.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'user-agent', val: 'WooCommerce/' +
				(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version')).str() + '; ' +
				(rt.call_function('get_bloginfo', [rt.new_string('url')])).str() },
		])])
	if rt.is_true(rt.call_function('is_wp_error', [var_request.clone()])) {
		Class_WC_Marketplace_Updater.retry()
		return rt.call_function('update_option', [
			rt.new_string('woocommerce_marketplace_suggestions'),
			var_data.clone(),
			rt.new_bool(false),
		])
	}
	mut var_body := rt.call_function('wp_remote_retrieve_body', [
		var_request.clone()])
	if !rt.is_true(var_body) {
		Class_WC_Marketplace_Updater.retry()
		return rt.call_function('update_option', [
			rt.new_string('woocommerce_marketplace_suggestions'),
			var_data.clone(),
			rt.new_bool(false),
		])
	}
	var_body = rt.call_function('json_decode', [var_body.clone(),
		rt.new_bool(true)])
	if !rt.is_true(var_body) || !(var_body.clone().is_array()) {
		Class_WC_Marketplace_Updater.retry()
		return rt.call_function('update_option', [
			rt.new_string('woocommerce_marketplace_suggestions'),
			var_data.clone(),
			rt.new_bool(false),
		])
	}
	var_data.array_set('suggestions', var_body.clone())
	return rt.call_function('update_option', [
		rt.new_string('woocommerce_marketplace_suggestions'),
		var_data.clone(),
		rt.new_bool(false),
	])
}

fn Class_WC_Marketplace_Updater.retry() {
	rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{}),
		'cancel_all', [rt.new_string('woocommerce_update_marketplace_suggestions')])
	rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue', []rt.PhpVal{}),
		'schedule_single', [
		rt.add(rt.call_function('time', []rt.PhpVal{}), rt.get_constant('DAY_IN_SECONDS')),
		rt.new_string('woocommerce_update_marketplace_suggestions'),
	])
}

fn Class_WC_Marketplace_Updater.add_personalization_data(var_request_params rt.PhpVal) rt.PhpVal {
	mut var_request_params_mutated := var_request_params
	var_request_params_mutated.array_set('country', rt.call_function('wc_get_base_location',
		[]rt.PhpVal{}).array_get(rt.new_string('country')))
	return var_request_params_mutated.clone()
}

struct Class_WC_Marketplace_Suggestions {
	rt.PhpObjectBase
}

fn create_wc_marketplace_updater(_args ...rt.PhpVal) &Class_WC_Marketplace_Updater {
	mut obj := &Class_WC_Marketplace_Updater{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_marketplace_suggestions(_args ...rt.PhpVal) &Class_WC_Marketplace_Suggestions {
	mut obj := &Class_WC_Marketplace_Suggestions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Marketplace_Updater) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'load' {
			Class_WC_Marketplace_Updater.load()
			return rt.new_null()
		}
		'init' {
			Class_WC_Marketplace_Updater.init()
			return rt.new_null()
		}
		'update_marketplace_suggestions' {
			return Class_WC_Marketplace_Updater.update_marketplace_suggestions()
		}
		'retry' {
			Class_WC_Marketplace_Updater.retry()
			return rt.new_null()
		}
		'add_personalization_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Marketplace_Updater.add_personalization_data(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Marketplace_Updater) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Marketplace_Updater) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Marketplace_Suggestions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Marketplace_Suggestions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Marketplace_Suggestions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	Class_WC_Marketplace_Updater.load()
}
