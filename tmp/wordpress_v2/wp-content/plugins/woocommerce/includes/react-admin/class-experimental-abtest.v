import rt

struct Class_WooCommerce_Admin_Experimental_Abtest {
	rt.PhpObjectBase
pub mut:
	tests              rt.PhpVal = rt.new_array()
	anon_id            string
	platform           string
	consent            bool
	as_auth_wpcom_user bool
}

fn (mut this Class_WooCommerce_Admin_Experimental_Abtest) construct(anon_id string, platform string, consent bool, as_auth_wpcom_user bool) {
	mut anon_id_mutated := anon_id
	this.anon_id = (rt.new_string(anon_id_mutated)).str()
	this.platform = platform
	this.consent = consent
	this.as_auth_wpcom_user = as_auth_wpcom_user
}

fn Class_WooCommerce_Admin_Experimental_Abtest.in_treatment(experiment_name string, as_auth_wpcom_user bool) rt.PhpVal {
	mut var_anon_id := if rt.get_superglobal('_COOKIE').array_isset(rt.new_string('tk_ai')) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_COOKIE').array_get(rt.new_string('tk_ai'))]),
		]) } else { rt.new_string('') }
	mut var_allow_tracking := rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_allow_tracking'),
	]))
	mut var_abtest := create_woocommerce_admin_self(var_anon_id.clone(),
		rt.new_string('woocommerce'), var_allow_tracking.clone(), rt.new_bool(as_auth_wpcom_user))
	return rt.identical(var_abtest.get_variation(rt.new_string(experiment_name)),
		rt.new_string('treatment'))
}

fn (mut this Class_WooCommerce_Admin_Experimental_Abtest) get_variation(var_test_name rt.PhpVal) string {
	if !(this.consent) {
		return 'control'
	}
	mut var_variation := this.fetch_variation(var_test_name.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_variation.clone()])) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('production'), rt.call_function('wp_get_environment_type',
			[]rt.PhpVal{})))))
		{
			rt.throw_exception(rt.new_object('WooCommerce_Admin_Exception', []string{}, create_woocommerce_admin_exception(rt.call_method(var_variation,
				'get_error_message', []rt.PhpVal{}))))
		}
		return 'control'
	}
	return var_variation.str()
}

fn (mut this Class_WooCommerce_Admin_Experimental_Abtest) request_assignment(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if this.as_auth_wpcom_user
		&& rt.is_true(rt.call_function('class_exists', [Class_Automattic_Jetpack_Connection_Manager.class()])) {
		mut var_jetpack_connection_manager := create_automattic_jetpack_connection_manager()
		if rt.is_true(var_jetpack_connection_manager.is_user_connected()) {
			mut iife_temp_0 := Class_Automattic_Jetpack_Connection_Client{}
			mut iife_result_0 := iife_temp_0.wpcom_json_api_request_as_user(rt.new_string(
				'/experiments/0.1.0/assignments/' + this.platform), rt.new_string('2'),
				var_args_mutated.clone())
			mut var_response := iife_result_0
		}
	}
	if !(!var_response.is_null()) {
		if !(var_args_mutated.array_isset(rt.new_string('anon_id')))
			|| !rt.is_true(var_args_mutated.array_get(rt.new_string('anon_id'))) {
			return rt.new_object('WooCommerce_Admin_WP_Error', []string{}, create_woocommerce_admin_wp_error(rt.new_string('invalid_anon_id'),
				rt.new_string('anon_id must be an none empty string.')))
		}
		mut var_url := rt.call_function('add_query_arg', [var_args_mutated.clone(),
			rt.call_function('sprintf', [
				rt.new_string('https://public-api.wordpress.com/wpcom/v2/experiments/0.1.0/assignments/%s'),
				rt.new_string(this.platform),
			])])
		var_response = rt.call_function('wp_remote_get', [var_url.clone()])
	}
	return var_response.clone()
}

fn (mut this Class_WooCommerce_Admin_Experimental_Abtest) fetch_variation(var_test_name rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_test_name)))) {
		return rt.new_object('WooCommerce_Admin_WP_Error', []string{}, create_woocommerce_admin_wp_error(rt.new_string('test_name_not_provided'),
			rt.new_string('A/B test name has not been provided.')))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/^[a-z0-9_]+$/'),
		var_test_name.clone(),
	])))))
	{
		return rt.new_object('WooCommerce_Admin_WP_Error', []string{}, create_woocommerce_admin_wp_error(rt.new_string('invalid_test_name'),
			rt.new_string('Invalid A/B test name.')))
	}
	if this.tests.array_isset(var_test_name) {
		return this.tests.array_get(var_test_name)
	}
	if !(!rt.is_true(rt.call_function('get_transient', [
		rt.new_string('abtest_variation_' + var_test_name.str()),
	]))) {
		return rt.call_function('get_transient', [
			rt.new_string('abtest_variation_' + var_test_name.str()),
		])
	}
	mut var_args := rt.create_array([
		rt.ArrayItem{ key: 'experiment_name', val: var_test_name },
		rt.ArrayItem{ key: 'anon_id', val: rt.call_function('rawurlencode', [
			rt.new_string(this.anon_id),
		]) },
		rt.ArrayItem{ key: 'woo_country_code', val: rt.call_function('rawurlencode', [
			rt.call_function('get_option', [rt.new_string('woocommerce_default_country'),
				rt.new_string('US:CA')]),
		]) },
		rt.ArrayItem{ key: 'woo_wcadmin_install_timestamp', val: rt.call_function('rawurlencode', [
			rt.call_function('get_option', [
				Class_Automattic_WooCommerce_Admin_WCAdminHelper.wc_admin_timestamp_option(),
			]),
		]) },
	])
	var_args = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_explat_request_args'),
		var_args.clone(),
	])
	mut var_response := this.request_assignment(var_args.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()]))
		|| !(var_response.clone().is_array()) || !(var_response.array_isset(rt.new_string('body'))) {
		return rt.new_object('WooCommerce_Admin_WP_Error', []string{}, create_woocommerce_admin_wp_error(rt.new_string('failed_to_fetch_data'),
			rt.new_string('Unable to fetch the requested data.')))
	}
	mut var_results := rt.call_function('json_decode', [
		var_response.array_get(rt.new_string('body')),
		rt.new_bool(true),
	])
	if !(var_results.clone().is_array()) {
		return rt.new_object('WooCommerce_Admin_WP_Error', []string{}, create_woocommerce_admin_wp_error(rt.new_string('unexpected_data_format'),
			rt.new_string('Data was not returned in the expected format.')))
	}
	this.tests.array_set(var_test_name, if !(var_results.array_get(rt.new_string('variations')).array_get(var_test_name)).is_null() {
		var_results.array_get(rt.new_string('variations')).array_get(var_test_name)
	} else {
		rt.new_null()
	})
	mut var_variation := if !(var_results.array_get(rt.new_string('variations')).array_get(var_test_name)).is_null() {
		var_results.array_get(rt.new_string('variations')).array_get(var_test_name)
	} else {
		rt.new_string('control')
	}
	if !(!rt.is_true(var_results.array_get(rt.new_string('ttl')))) {
		rt.call_function('set_transient', [
			rt.new_string('abtest_variation_' + var_test_name.str()),
			var_variation.clone(),
			var_results.array_get(rt.new_string('ttl')),
		])
	}
	return var_variation.clone()
}

struct Class_WooCommerce_Admin_self {
	rt.PhpObjectBase
}

struct Class_WooCommerce_Admin_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Connection_Manager {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Connection_Client {
	rt.PhpObjectBase
}

struct Class_WooCommerce_Admin_WP_Error {
	rt.PhpObjectBase
}

fn create_woocommerce_admin_experimental_abtest(anon_id string, platform string, consent bool, as_auth_wpcom_user bool) &Class_WooCommerce_Admin_Experimental_Abtest {
	mut obj := &Class_WooCommerce_Admin_Experimental_Abtest{
		PhpObjectBase:      rt.PhpObjectBase{}
		tests:              rt.new_array()
		anon_id:            ''
		platform:           ''
		consent:            false
		as_auth_wpcom_user: false
	}
	obj.construct(anon_id, platform, consent, as_auth_wpcom_user)
	return obj
}

fn create_woocommerce_admin_self(_args ...rt.PhpVal) &Class_WooCommerce_Admin_self {
	mut obj := &Class_WooCommerce_Admin_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_woocommerce_admin_exception(_args ...rt.PhpVal) &Class_WooCommerce_Admin_Exception {
	mut obj := &Class_WooCommerce_Admin_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_connection_manager(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Connection_Manager {
	mut obj := &Class_Automattic_Jetpack_Connection_Manager{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_connection_client(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Connection_Client {
	mut obj := &Class_Automattic_Jetpack_Connection_Client{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_woocommerce_admin_wp_error(_args ...rt.PhpVal) &Class_WooCommerce_Admin_WP_Error {
	mut obj := &Class_WooCommerce_Admin_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WooCommerce_Admin_Experimental_Abtest) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'in_treatment' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_WooCommerce_Admin_Experimental_Abtest.in_treatment(dispatch_arg_0,
				dispatch_arg_1)
		}
		'get_variation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_variation(dispatch_arg_0))
		}
		'request_assignment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.request_assignment(dispatch_arg_0)
		}
		'fetch_variation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.fetch_variation(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WooCommerce_Admin_Experimental_Abtest) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'tests' { return this.tests }
		'anon_id' { return rt.new_string(this.anon_id) }
		'platform' { return rt.new_string(this.platform) }
		'consent' { return rt.new_bool(this.consent) }
		'as_auth_wpcom_user' { return rt.new_bool(this.as_auth_wpcom_user) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WooCommerce_Admin_Experimental_Abtest) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'tests' {
			this.tests = val
			return true
		}
		'anon_id' {
			this.anon_id = val.str()
			return true
		}
		'platform' {
			this.platform = val.str()
			return true
		}
		'consent' {
			this.consent = val.to_bool()
			return true
		}
		'as_auth_wpcom_user' {
			this.as_auth_wpcom_user = val.to_bool()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WooCommerce_Admin_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WooCommerce_Admin_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WooCommerce_Admin_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WooCommerce_Admin_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WooCommerce_Admin_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WooCommerce_Admin_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_Jetpack_Connection_Manager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Connection_Manager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Connection_Manager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_Jetpack_Connection_Client) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Connection_Client) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Connection_Client) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WooCommerce_Admin_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WooCommerce_Admin_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WooCommerce_Admin_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
