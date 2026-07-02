import rt
import crypto.md5

struct Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_WooPayments {
	rt.PhpObjectBase
pub mut:
	cache_transient_name              rt.PhpVal = rt.new_null()
	store_has_orders_transient_name   rt.PhpVal = rt.new_null()
	store_had_woopayments_option_name rt.PhpVal = rt.new_null()
	incentives_memo                   rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_WooPayments) construct(suggestion_id string) {
	this.Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive.construct(rt.new_string(suggestion_id))
	this.cache_transient_name =
		(Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_WooPayments.prefix()).str() + suggestion_id + '_cache'
	this.store_has_orders_transient_name =
		(Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_WooPayments.prefix()).str() + suggestion_id + '_store_has_orders'
	this.store_had_woopayments_option_name =
		(Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_WooPayments.prefix()).str() + suggestion_id + '_store_had_woopayments'
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_WooPayments) is_visible(id string, country_code string, skip_extension_active_check bool) bool {
	if rt.is_true(rt.identical(rt.new_bool(false), this.Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive.is_visible(rt.new_string(id),
		rt.new_string(country_code), rt.new_bool(true))))
	{
		return false
	}
	if !var_skip_extension_active_check && this.is_extension_active()
		&& this.has_wcpay_account_data() {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_WooPayments) clear_cache() {
	rt.call_function('delete_transient', [this.cache_transient_name])
	this.reset_memo()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_WooPayments) reset_memo() {
	this.incentives_memo = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_WooPayments) is_extension_active() bool {
	return (rt.call_function('class_exists', [rt.new_string('\\WC_Payments')])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_WooPayments) get_incentives(country_code string) rt.PhpVal {
	if !(this.incentives_memo).is_null() {
		return this.incentives_memo
	}
	mut var_cache := rt.call_function('get_transient', [this.cache_transient_name])
	if rt.is_true(rt.call_function('is_wp_error', [var_cache.clone()])) {
		this.incentives_memo = rt.new_array()
		return this.incentives_memo
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_WCAdminHelper{}
	mut iife_result_0 := iife_temp_0.get_wcadmin_active_for_in_seconds()
	mut var_store_context := rt.create_array([
		rt.ArrayItem{ key: 'country', val: country_code },
		rt.ArrayItem{ key: 'locale', val: rt.call_function('get_locale', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'active_for', val: iife_result_0 },
		rt.ArrayItem{ key: 'has_orders', val: this.has_orders() },
		rt.ArrayItem{ key: 'has_payments', val: this.has_enabled_payment_gateways() },
		rt.ArrayItem{ key: 'has_wcpay', val: this.has_wcpay() },
	])
	mut var_store_context_hash :=
		rt.new_string(this.generate_context_hash(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_array](var_store_context)))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_cache))))
		&& !(!rt.is_true(var_cache.array_get(rt.new_string('context_hash'))))
		&& var_cache.array_get(rt.new_string('context_hash')).is_string()
		&& rt.is_true(rt.call_function('hash_equals', [var_store_context_hash.clone(), var_cache.array_get(rt.new_string('context_hash'))])) {
		this.incentives_memo = if !(var_cache.array_get(rt.new_string('incentives'))).is_null() {
			var_cache.array_get(rt.new_string('incentives'))
		} else {
			rt.new_array()
		}
		return this.incentives_memo
	}
	mut var_url := rt.call_function('add_query_arg', [var_store_context.clone(),
		rt.new_string('https://public-api.wordpress.com/wpcom/v2/wcpay/incentives')])
	mut var_response := rt.call_function('wp_remote_get', [var_url.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'user-agent', val: 'WooCommerce/' +
				(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version')).str() + '; ' +
				(rt.call_function('get_bloginfo', [rt.new_string('url')])).str() },
		])])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		mut var_error := create_automattic_woocommerce_internal_admin_suggestions_incentives_wp_error(rt.call_method(var_response,
			'get_error_code', []rt.PhpVal{}), rt.call_method(var_response, 'get_error_message',
			[]rt.PhpVal{}), rt.call_function('wp_remote_retrieve_response_code', [
			var_response.clone(),
		]))
		rt.call_function('set_transient', [this.cache_transient_name, var_error,
			rt.mul(rt.get_constant('HOUR_IN_SECONDS'), rt.new_int(6))])
		this.incentives_memo = rt.new_array()
		return this.incentives_memo
	}
	mut var_cache_for := rt.call_function('wp_remote_retrieve_header', [
		var_response.clone(), rt.new_string('cache-for')])
	this.incentives_memo = rt.new_array()
	if rt.is_true(rt.identical(rt.new_int(200), rt.call_function('wp_remote_retrieve_response_code', [
		var_response.clone(),
	])))
	{
		mut var_results := if !(rt.call_function('json_decode', [
			rt.call_function('wp_remote_retrieve_body', [var_response.clone()]),
			rt.new_bool(true),
		])).is_null() { rt.call_function('json_decode', [
				rt.call_function('wp_remote_retrieve_body', [
					var_response.clone()]),
				rt.new_bool(true),
			]) } else { rt.new_array() }
		this.incentives_memo = var_results.clone()
	}
	if rt.is_true(rt.identical(rt.new_string('0'), var_cache_for)) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_cache)))) {
			rt.call_function('delete_transient', [this.cache_transient_name])
		}
		return this.incentives_memo
	}
	rt.call_function('set_transient', [this.cache_transient_name,
		rt.create_array([rt.ArrayItem{ key: 'incentives', val: this.incentives_memo },
			rt.ArrayItem{ key: 'context_hash', val: var_store_context_hash },
			rt.ArrayItem{ key: 'timestamp', val: rt.call_function('time', []rt.PhpVal{}) }]),
		if !(!rt.is_true(var_cache_for)) {
			rt.new_int(var_cache_for.to_i64())
		} else {
			rt.get_constant('DAY_IN_SECONDS')
		}])
	return this.incentives_memo
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_WooPayments) has_wcpay() bool {
	mut var_had_wcpay := rt.call_function('get_option', [
		this.store_had_woopayments_option_name,
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_had_wcpay)))) {
		return (rt.call_function('filter_var', [var_had_wcpay.clone(),
			rt.get_constant('FILTER_VALIDATE_BOOLEAN')])).to_bool()
	}
	var_had_wcpay = rt.new_bool(false)
	if this.has_wcpay_account_data() {
		var_had_wcpay = rt.new_bool(true)
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_had_wcpay))
		&& !(!rt.is_true(rt.call_function('wc_get_orders', [rt.create_array([rt.ArrayItem{
		key: 'payment_method'
		val: 'woocommerce_payments'
	}, rt.ArrayItem{ key: 'return', val: 'ids' }, rt.ArrayItem{ key: 'limit', val: 1 }, rt.ArrayItem{
		key: 'orderby'
		val: 'none'
	}])]))) {
		var_had_wcpay = rt.new_bool(true)
	}
	rt.call_function('update_option', [this.store_had_woopayments_option_name,
		rt.new_string((if rt.is_true(var_had_wcpay) { 'yes' } else { 'no' }).str())])
	return var_had_wcpay.to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_WooPayments) has_wcpay_account_data() bool {
	mut var_account_data := rt.call_function('get_option', [
		rt.new_string('wcpay_account_data'),
		rt.new_array(),
	])
	if !(!rt.is_true(var_account_data.array_get(rt.new_string('data')).array_get(rt.new_string('account_id')))) {
		return true
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_WooPayments) has_orders() bool {
	mut var_has_orders := rt.call_function('get_transient', [
		this.store_has_orders_transient_name,
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_has_orders)))) {
		return (rt.call_function('filter_var', [var_has_orders.clone(),
			rt.get_constant('FILTER_VALIDATE_BOOLEAN')])).to_bool()
	}
	var_has_orders = rt.new_bool(false)
	mut var_expiration := rt.mul(rt.new_int(6), rt.get_constant('HOUR_IN_SECONDS'))
	mut var_latest_order := rt.call_function('wc_get_orders', [
		rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.completed()
				},
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.processing()
				},
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.refunded()
				},
			]) },
			rt.ArrayItem{ key: 'limit', val: 1 },
			rt.ArrayItem{ key: 'orderby', val: 'date' },
			rt.ArrayItem{ key: 'order', val: 'DESC' },
		]),
	])
	if !(!rt.is_true(var_latest_order)) {
		var_latest_order = rt.call_function('reset', [var_latest_order.clone()])
		if rt.is_true(rt.new_bool(rt.instance_of(var_latest_order, 'WC_Abstract_Order')))
			&& rt.is_true(rt.greater_equal(rt.call_function('strtotime', [rt.new_string((rt.call_method(var_latest_order, 'get_date_created', []rt.PhpVal{})).str())]), rt.call_function('strtotime', [rt.new_string('-90 days')]))) {
			var_has_orders = rt.new_bool(true)
			var_expiration = rt.sub(rt.add(rt.call_function('strtotime', [
				rt.new_string((rt.call_method(var_latest_order, 'get_date_created', []rt.PhpVal{})).str()),
			]), rt.mul(rt.new_int(90), rt.get_constant('DAY_IN_SECONDS'))), rt.call_function('time',
				[]rt.PhpVal{}))
		}
	}
	rt.call_function('set_transient', [this.store_has_orders_transient_name,
		rt.new_string((if rt.is_true(var_has_orders) { 'yes' } else { 'no' }).str()),
		var_expiration.clone()])
	return var_has_orders.to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_WooPayments) has_enabled_payment_gateways() bool {
	mut var_payment_gateways := rt.get_property(rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
		'payment_gateways', []rt.PhpVal{}), 'payment_gateways')
	if !rt.is_true(var_payment_gateways) || !(var_payment_gateways.clone().is_array()) {
		return false
	}
	mut iter_1 := var_payment_gateways.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_payment_gateway := item_1.val
		if rt.is_true(rt.call_function('filter_var', [
			rt.get_property(var_payment_gateway, 'enabled'),
			rt.get_constant('FILTER_VALIDATE_BOOLEAN'),
		]))
		{
			return true
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_WooPayments) generate_context_hash(mut var_context Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_array) string {
	return md5.hexhash(rt.call_function('wp_json_encode', [
		rt.create_array([
			rt.ArrayItem{
				key: 'country'
				val: if !(var_context.array_get(rt.new_string('country'))).is_null() {
					var_context.array_get(rt.new_string('country'))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'locale'
				val: if !(var_context.array_get(rt.new_string('locale'))).is_null() {
					var_context.array_get(rt.new_string('locale'))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'has_orders'
				val: if !(var_context.array_get(rt.new_string('has_orders'))).is_null() {
					var_context.array_get(rt.new_string('has_orders'))
				} else {
					rt.new_bool(false)
				}
			},
			rt.ArrayItem{
				key: 'has_payments'
				val: if !(var_context.array_get(rt.new_string('has_payments'))).is_null() {
					var_context.array_get(rt.new_string('has_payments'))
				} else {
					rt.new_bool(false)
				}
			},
			rt.ArrayItem{
				key: 'has_wcpay'
				val: if !(var_context.array_get(rt.new_string('has_wcpay'))).is_null() {
					var_context.array_get(rt.new_string('has_wcpay'))
				} else {
					rt.new_bool(false)
				}
			},
		]),
	]).to_string())
}

struct Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_WCAdminHelper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_suggestions_incentives_woopayments(suggestion_id string) &Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_WooPayments {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_WooPayments{
		PhpObjectBase:                     rt.PhpObjectBase{}
		cache_transient_name:              rt.new_null()
		store_has_orders_transient_name:   rt.new_null()
		store_had_woopayments_option_name: rt.new_null()
		incentives_memo:                   rt.new_null()
	}
	obj.construct(suggestion_id)
	return obj
}

fn create_automattic_woocommerce_internal_admin_suggestions_incentives_incentive(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_wcadminhelper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_WCAdminHelper {
	mut obj := &Class_Automattic_WooCommerce_Admin_WCAdminHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_suggestions_incentives_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_WooPayments) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'is_visible' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.is_visible(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'clear_cache' {
			this.clear_cache()
			return rt.new_null()
		}
		'reset_memo' {
			this.reset_memo()
			return rt.new_null()
		}
		'is_extension_active' {
			return rt.new_bool(this.is_extension_active())
		}
		'get_incentives' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_incentives(dispatch_arg_0)
		}
		'has_wcpay' {
			return rt.new_bool(this.has_wcpay())
		}
		'has_wcpay_account_data' {
			return rt.new_bool(this.has_wcpay_account_data())
		}
		'has_orders' {
			return rt.new_bool(this.has_orders())
		}
		'has_enabled_payment_gateways' {
			return rt.new_bool(this.has_enabled_payment_gateways())
		}
		'generate_context_hash' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.generate_context_hash(mut dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_WooPayments) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cache_transient_name' { return this.cache_transient_name }
		'store_has_orders_transient_name' { return this.store_has_orders_transient_name }
		'store_had_woopayments_option_name' { return this.store_had_woopayments_option_name }
		'incentives_memo' { return this.incentives_memo }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_WooPayments) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cache_transient_name' {
			this.cache_transient_name = val
			return true
		}
		'store_has_orders_transient_name' {
			this.store_has_orders_transient_name = val
			return true
		}
		'store_had_woopayments_option_name' {
			this.store_had_woopayments_option_name = val
			return true
		}
		'incentives_memo' {
			this.incentives_memo = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_WCAdminHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_WCAdminHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_WCAdminHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
